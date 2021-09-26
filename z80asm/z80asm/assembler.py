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

      if 'imm8' in token.mnemonic.schema:
        nextsize = 1
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
        warning('test.s', token.line+1, 'Unexpected number (ignored):', token)

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
        if nextsize == 1:
          val_ = val & 0xff
          if val != val_:
            warning('test.s', token.line+1, 'Expression value has been trucated:', val, '->', val_)
            token.exprvalue = val_
        elif nextsize == 2:
          val_ = val & 0xffff
          if val != val_:
            warning('test.s', token.line+1, 'Expression value has been trucated:', val, '->', val_)
            token.exprvalue = val_
        size = nextsize
      else:
        warning('test.s', token.line+1, 'Unexpected expression (ignored):', token)

      if token._value is not None:
        printv(f'{a.CYAN}={a.E}{token.exprvalue}', end=' ')

    elif isinstance(token, THere):
      if nextsize:
        if nextsize == 1:
          val = (pos - lastsize) & 0xff
          if (pos-lastsize) != val:
            warning('test.s', token.line+1, 'Curent position value has been trucated:', pos-lastsize, '->', val_)
          token.position = pos - lastsize
        elif nextsize == 2:
          val = (pos - lastsize) & 0xffff
          if (pos - lastsize) != val:
            error('test.s', token.line+1, 'Curent position value is greater than 0xffff:', token)
          token.position = pos - lastsize
        size = nextsize

      if token.position is not None:
        printv(f'{a.CYAN}@{a.E}{token.position}', end=' ')

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
            warning('test.s', token.line+1, 'String value has been trucated to a single character:', token.value, '->', val)
        elif nextsize == 2:
          if len(tokval) > 2:
            warning('test.s', token.line+1, 'String value has been trucated to first two characters:', token.value, '->', val)
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
  printv(f'{a.CYAN}{"#":>4} Line Token{a.E}')

  bytecode = []

  for i, token in enumerate(tokens):
    printv(f'{i+1:4} {token.line+1:4}', token, end=' ')


    emit = []


    if isinstance(token, TDirective):
      if token.value == 'ds':
        size = token.args['size']
        fill = token.args['fill']
        emit = [fill] * size
      elif token.value == 'include':
        token.chfile()

    elif isinstance(token, TExpression):
      emit = emitval(token.exprvalue, token.size)

    elif isinstance(token, THere):
      emit = emitval(token.position, token.size)

    elif isinstance(token, TLabelRef):
      emit = emitval(lblpos[token.value], token.size)

    elif isinstance(token, TNumber):
      emit = emitval(token.value, token.size)

    elif isinstance(token, TOpcode):
      emit = token.mnemonic.opcode

    elif isinstance(token, TString):
      strbytes = [ord(c) for c in token.value[1:-1]]
      emit = sum([emitval(b, 1) for b in strbytes], [])


    bytecode += emit
    printv(bytearr_fmt(emit, rle=True))

  return bytecode
