from .interface import bytearr_fmt, error, printv, warning
from .symbols import MNEMONICS
from .tokenizer import Token, tokenize
from math import log2, floor
import sys
from . import ansi as a


class FirstPassState:
  def __init__(self):
    self.mtoken = None # first token of the current mnemonic
    self.mfound = False
    self.mnems = None # current matching mnemonics
    self.mnem = None
    self.mpos = 0
    self.cpos = 0
    self.last_line = 0
    self.dtoken = None # directive token

  def get_predicate(self, tok):
    if tok.type == Token.NUMBER:
      predicate = lambda m: m.schema[self.mpos] in ('imm8', 'imm16')
    elif tok.type in (Token.LABEL_REF, Token.HERE):
      predicate = lambda m: m.schema[self.mpos] == 'imm16'
    elif tok.type == Token.OPENING_PAREN:
      predicate = lambda m: m.schema[self.mpos] in '(['
    elif tok.type == Token.CLOSING_PAREN:
      predicate = lambda m: m.schema[self.mpos] in ')]'
    else:
      predicate = lambda m: len(m.schema) > self.mpos and m.schema[self.mpos] == tok.value
    return predicate, ('Generic error',)

  def find_mnemonic(self, tok):
    if tok.type == Token.MNEMONIC:
      self.mtoken = tok
    haystack = self.mnems
    if self.mpos == 0:
      haystack = MNEMONICS
      predicate = lambda m: m.schema[0] == tok.value
    else:
      predicate, _ = self.get_predicate(tok)

    self.mnems = [m for m in haystack if predicate(m)]

    if len(self.mnems) == 1:
      self.mnem = self.mnems[0]
      self.mtoken.position = self.cpos
      self.mtoken.mnemonic = self.mnem
      self.cpos += self.mnem.size
      self.mfound = True
      self.mpos += 1
    elif len(self.mnems) == 0:
      error(f'Unexpected token for {self.mtoken}: {tok}')
    else:
      self.mfound = False
      self.mpos += 1

  def match_mnemonic(self, tok):
    if not self.mfound:
      self.find_mnemonic(tok)
      return True
    elif self.mtoken:
      predicate, err = self.get_predicate(tok)
      if predicate(self.mnem):
        self.mpos += 1
      else:
        error(*err)
      return True
    return False

def first_pass(tokens, verbose=False):
  printv(verbose, 'FIRST PASS')

  labels = {}
  fps = FirstPassState()

  for token in tokens:
    if fps.last_line != token.src_line:
      fps.dtoken = None
      if fps.mtoken and not fps.mfound:
        fps.mnems_ = [m for m in fps.mnems if len(m.schema) == fps.mpos]
        if len(fps.mnems_) == 1:
          fps.mtoken.mnemonic = fps.mnems_[0]
        elif len(fps.mnems) == 0:
          error('Mnemonic not found for token:', fps.mtoken)
        else:
          error('Mnemonic is ambiguous:', fps.mtoken, quit=False)
          for fps.mnem in fps.mnems:
            print(fps.mnem.pretty_schema, file=sys.stderr)
          sys.exit(1)
    fps.last_line = token.src_line

    if fps.mtoken and fps.mfound:
      if len(fps.mnem.schema) <= fps.mpos:
        fps.mtoken = None
        fps.mpos = 0

    printv(verbose, token)

    if token.type == Token.LABEL:
      token.position = fps.cpos
      labels[token.value] = fps.cpos

    elif token.type == Token.DIRECTIVE:
      fps.dtoken = token

    elif token.type == Token.MNEMONIC:
      fps.find_mnemonic(token)

    elif token.type == Token.REGISTER:
      if not fps.match_mnemonic(token):
        error('Unexpected register without an instruction:', token)

    elif token.type == Token.FLAG:
      if not fps.match_mnemonic(token):
        error('Unexpected flag without an instruction:', token)

    elif token.type == Token.NUMBER:
      if not fps.mfound:
        fps.find_mnemonic(token)
      elif fps.mtoken:
        if fps.mnem.mnemonic[fps.mpos] == 'imm8':
          if token.value < 0x100:
            if fps.mtoken.signed:
              if token.value not in range(-128, 128):
                error(f'Expected a signed value in range [-128, 127] for {fps.mtoken}')
              token.signed = True

            token.position = fps.cpos
            token.size = 1
            fps.mpos += 1
            fps.cpos += 1
          else:
            error(f'Expected an 8-bit value for {fps.mtoken}')
        elif fps.mnem.mnemonic[fps.mpos] == 'imm16':
          if token.value < 0x10000:
            token.position = fps.cpos
            token.size = 2
            fps.mpos += 1
            fps.cpos += 2
          else:
            error(f'Expected a 16-byte value for {fps.mtoken}')

      elif fps.dtoken:
        if fps.dtoken.value == '.db':
          token.position = fps.cpos
          token.size = 1
          fps.cpos += 1
        elif fps.dtoken.value == '.dw':
          token.position = fps.cpos
          token.size = 2
          fps.cpos += 2
        elif fps.dtoken.value == '.ds':
          if fps.dtoken.argc == 0:
            fps.dtoken.argc = 1
            fps.dtoken.size = token.value
            fps.dtoken.fill = 0
            fps.cpos += token.value
          elif fps.dtoken.argc == 1:
            fps.dtoken.argc = 2
            fps.dtoken.fill = token.value

    elif token.type == Token.HERE:
      if not fps.match_mnemonic(token):
        error(f'Unexpected current position reference:', token)
      else:
        token.position = fps.cpos
        token.value = fps.cpos - 3 # TODO: think if it makes sense
        token.size = 2

    elif token.type == Token.LABEL_REF:
      if not fps.match_mnemonic(token):
        error(f'Label reference without an instruction: {token.value}')

    elif token.type == Token.OPENING_PAREN:
      if not fps.match_mnemonic(token):
        error(f'Unexpected opening parenthesis', token)

    elif token.type == Token.CLOSING_PAREN:
      if not fps.match_mnemonic(token):
        error(f'Unexpected closing parenthesis', token)

    elif token.type == Token.OPERATOR:
      pass

  printv(verbose)
  return labels

def assemble(source_code, verbose=False):
  tokens = tokenize(source_code, verbose=verbose)
  labels = first_pass(tokens, verbose=verbose)

  tokens = [t for t in tokens if t.type != Token.LABEL]

  printv(verbose, 'BYTECODE EMIT')

  bytecode = []
  mtok = None
  for tok in tokens:
    emit = []
    if tok.type == Token.MNEMONIC and not tok.mnemonic:
      error('Token type is mnemonic but no mnemonic found:', tok)

    if tok.mnemonic:
      mtok = tok
      emit = tok.mnemonic.opcode
    elif tok.type == Token.DIRECTIVE:
      if tok.value == '.ds':
        emit = [tok.fill for _ in range(tok.size)]
    elif tok.type == Token.LABEL_REF:
      pos = labels[tok.value]
      emit = [pos & 0xff, (pos >> 8) & 0xff]
    elif tok.type == Token.NUMBER or tok.type == Token.HERE:
      if tok.size is not None:
        # number of bytes needed to cover the whole number
        real_size = 1
        if tok.value > 0:
          bindigits = floor(log2(tok.value)+1)
          real_size = bindigits // 8 + 1 if bindigits % 8 else 0
        emit = [tok.value >> (i * 8) & 0xff for i in range(tok.size)]
        if real_size > tok.size:
          warning('Number has been truncated:', tok, '->', bytearr_fmt(emit))

      elif mtok:
        if 'imm8' in mtok.mnemonic.schema:
          emit = [tok.value]
        elif 'imm16' in mtok.mnemonic.schema:
          emit = [tok.value & 0xff, (tok.value >> 8) & 0xff]

    bytecode += emit
    printv(verbose, tok, bytearr_fmt(emit, rle=True))
  printv(verbose)
  return bytecode
