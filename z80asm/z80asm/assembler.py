from math import floor, log2

from . import ansi as a
from .interface import bytearr_fmt, printv, warning
from .token import *


def bytesize(value):
  if value == 0:
    return 1
  bindigits = floor(log2(value)+1)
  return bindigits // 8 + 1 if bindigits % 8 else 0

def emitval(val, size):
  assert val is not None, 'val is none'
  assert size is not None, 'size is none'
  return [(val >> (8 * i)) & 0xff for i in range(size)]

def evaluate_size(tokens):
  printv(f'{a.GREEN}Evaluate size and positions{a.E}')
  printv(f'{a.CYAN}{"#":>4} Line {"Pos":5} Token{a.E}')

  ptokens = []

  lblpos = {}
  lastsize = 0
  nextsize = 0
  nextnextsize = 0
  directive = None
  pos = 0
  noemit = False
  for i, token in enumerate(tokens):
    size = 0
    printv(f'{i+1:4} {token.line+1:4}', f'@{pos:04x}', token, end=' ')

    if isinstance(token, TOpcode):
      size = len(token.mnemonic.opcode)

      if imm8cnt := token.mnemonic.schema.count('imm8'):
        nextsize = 1
        nextnextsize = imm8cnt - 1
      elif 'imm16' in token.mnemonic.schema:
        nextsize = 2
      else:
        nextsize = 0


    elif isinstance(token, TLabelRef):
      if nextsize:
        size = nextsize
      else:
        size = 2
      nextsize = 0

    elif isinstance(token, TDirective):
      directive = token
      if token.value == 'include':
        token.chfile()

    elif isinstance(token, TNumber):
      if directive:
        if directive.value == 'ds':
          noemit = True
          if not directive.args.get('size'):
            directive.args['size'] = token.value
            size = token.value
          elif not directive.args.get('fill'):
            directive.args['fill'] = token.value
            directive = None
        elif directive.value == 'db':
          size = 1
        elif directive.value == 'dw':
          size = 2
      elif nextsize:
        size = nextsize
        nextsize = nextnextsize
        nextnextsize = 0
      else:
        warning(token.line, 'assembler::evaluate_size', 'Unexpected number (ignored):', token)

    elif isinstance(token, TExpression):
      if directive:
        if directive.value == 'ds':
          noemit = True
          val = token.evaluate(here=pos, lblpos=lblpos)
          if not directive.args.get('size'):
            directive.args['size'] = val
            size = val
          elif not directive.args.get('fill'):
            directive.args['fill'] = val
            directive = None
      elif nextsize:
        val = token.evaluate(here=(pos-lastsize), lblpos=lblpos)
        token.size = nextsize
        size = nextsize
      else:
        warning(token.line, 'assembler::evaluate_size', 'Unexpected expression (ignored):', token)

    elif isinstance(token, THere):
      if nextsize:
        token.size = nextsize
        size = nextsize
      nextsize = 0

    elif isinstance(token, TLabel):
      lblpos[token.value] = pos
      printv(f'{a.CYAN}@{a.E}x{pos:x}', end=' ')

    elif isinstance(token, TSeparator):
      noemit = True
      if token.value == '\n':
        directive = None
        nextsize = 0

    elif isinstance(token, TString):
      tokval = token.value[1:-1]
      if directive:
        if directive.value == 'db':
          size = len(tokval)
        elif directive.value == 'dw':
          size = len(tokval) * 2
      elif nextsize:
        val = ord(tokval[0])

        if nextsize == 1:
          if len(tokval) > 1:
            warning(token.line, 'assembler::evaluate_size', 'String value has been truncated to a single character:', token.value, '->', val)
        elif nextsize == 2:
          if len(tokval) > 2:
            warning(token.line, 'assembler::evaluate_size', 'String value has been truncated to first two characters:', token.value, '->', val)
        size = nextsize

    lastsize = size
    token.size = size
    pos += size
    printv(token.size if token.size else '')

    if not noemit:
      ptokens.append(token)
    noemit = False

  return ptokens, lblpos

def assemble(tokens, lblpos):
  printv(f'{a.GREEN}Assemble{a.E}')
  printv(f'{a.CYAN}{"#":>4} Line {"Pos":5} Token{a.E}')

  bytecode = []
  defer = []

  for i, token in enumerate(tokens):
    printv(f'{i+1:4} {token.line+1:4} @{len(bytecode):04x}', token, end=' ')

    emit = defer
    defer = []

    if isinstance(token, TDirective):
      if token.value == 'ds':
        size = token.args['size']
        try:
          fill = token.args['fill']
        except KeyError:
          fill = 0
        emit += [fill] * size
      elif token.value == 'include':
        token.chfile()

    elif isinstance(token, TExpression):
      posoffset = len(otoken.mnemonic.opcode) if otoken else 0
      here = len(bytecode) - posoffset
      val = token.evaluate(here=len(bytecode)-posoffset, lblpos=lblpos)
      if otoken and otoken.mnemonic.relative:
        dest = val
        reljmp = dest - (here + 2)
        print('RELJMP',reljmp)

        if reljmp in range(-128, 128):
          val_ = reljmp & 0xff
        else:
          error(token.line, 'assembler::assemble', 'Relative jump not in range[-128,127]:', token, f'reljmp={val}')
      else:
        if token.size == 1:
          val_ = val & 0xff
        elif token.size == 2:
          val_ = val & 0xffff

        if val_ != val:
          warning(token.line, 'assembler::assemble', 'Expression value has been truncated:', val, '->', val_, token.rpnfmt)

      emit = emitval(val_, token.size) + emit
      otoken = None

    elif isinstance(token, THere):
      val = len(bytecode)
      if otoken:
        val -= len(otoken.mnemonic.opcode)
        if otoken.mnemonic.relative:
          val = -2
          val_ = val
        else:
          if token.size == 1:
            val_ = val & 0xff
          elif token.size == 2:
            val_ = val & 0xffff

        if val_ != val:
          warning(token.line, 'assembler::assemble', 'Current position value has been truncated:', val, '->', val_)

      emit = emitval(val_, token.size) + emit
      otoken = None

    elif isinstance(token, TLabelRef):
      if otoken and otoken.mnemonic.relative:
        after = len(bytecode) + 1
        reljmp = lblpos.get(token.value) - after
        if reljmp in range(-128, 128):
          emit = [reljmp & 0xff]
        else:
          error(token.line, 'assembler::assemble', 'relative jump out of range[-128,127]:', token, f'reljmp={reljmp}')
      else:
        emit = emitval(lblpos[token.value], token.size) + emit

    elif isinstance(token, TNumber):
      if otoken and otoken.mnemonic.relative:
        after = len(bytecode) + 1
        reljmp = token.value - after
        if reljmp in range(-128, 128):
          emit = [reljmp & 0xff]
        else:
          error(token.line, 'assembler::assemble', 'relative jump out of range[-128,127]:', token, f'reljmp={reljmp}')
      else:
        emit = emitval(token.value, token.size) + emit

    elif isinstance(token, TOpcode):
      otoken = token
      if token.reverse_operand:
        emit = token.mnemonic.opcode[:2] + emit
        defer = token.mnemonic.opcode[2:]
      else:
        emit = list(token.mnemonic.opcode) + emit

    elif isinstance(token, TString):
      strbytes = [ord(c) for c in token.value[1:-1].replace('\\n', '\n')]
      emit = sum([emitval(b, 1) for b in strbytes], []) + emit

    bytecode += emit
    printv(bytearr_fmt(emit, rle=True))

  return bytecode
