import os
import re

from . import config
from .interface import error, parsenum, printv
from .symbols import (DIRECTIVES, I8080_MNEMONIC_NAMES, I8080_REGISTER_NAMES, OPERATORS, Z80_DOCUMENTED_MNEMONIC_NAMES, Z80_FLAG_NAMES,
                      Z80_MNEMONIC_NAMES, Z80_REGISTER_NAMES)
from .token import *

if config.cpu == 'z80':
  MNEMONIC_NAMES = Z80_MNEMONIC_NAMES if config.undocumented else Z80_DOCUMENTED_MNEMONIC_NAMES
  FLAGS = Z80_FLAG_NAMES
  REGISTER_NAMES = Z80_REGISTER_NAMES
elif config.cpu == 'i8080':
  MNEMONIC_NAMES = I8080_MNEMONIC_NAMES
  REGISTER_NAMES = I8080_REGISTER_NAMES
  FLAGS = []

LABEL_RX = re.compile(r'([a-zA-Z_][a-zA-Z0-9_]+):')
STRING_RX = re.compile(r'[\'\"].*?[\'\"]')
INCLUDE_RX = re.compile(r'include [\'\"](.*?)[\'\"]')


def strip_comments(line):
  try:
    line = line[:line.index(';')]
  except ValueError:
    pass
  return line


def resolve_includes(source):
  includes = re.finditer(INCLUDE_RX, source)
  src = source
  for inc in includes:
    directive = inc.group(0)
    fname = inc.group(1)
    back_to_origin = f'include "{config.filename}"'

    with open(os.path.join(os.path.dirname(config.filename), fname)) as f:
      data = f.read()
      src = src.replace(directive, '\n'.join([directive, data, back_to_origin]))

  return src

def tokenize(source):
  printv(f'{a.GREEN}Tokenize{a.E}')

  src = resolve_includes(source)
  lblnames = re.findall(LABEL_RX, src)

  for symbol in tuple('[](),') + tuple(OPERATORS):
    src = src.replace(symbol, f' {symbol} ')
  src = src.splitlines()

  tokens = []
  newline = True

  for n, line in enumerate(src):
    strings = re.findall(STRING_RX, line)

    line = strip_comments(line)
    for i, s in enumerate(strings):
      line = line.replace(s, f'@{i}')

    line = [w for w in line.split(' ') if w != '']

    newline = True
    include = None

    printv(f'{n+1:4}', end=' ')
    for word in line:

      token = None
      if word in DIRECTIVES:
        token = TDirective(word, line=n)
        if token.value == 'include':
          include = token
          include.chfile()
      elif word == '(':
        token = TExprOpen(line=n)
      elif word == ')':
        token = TExprClose(line=n)
      elif word.lower() in FLAGS:
        token = TFlag(word.lower(), line=n)
      elif word == '$':
        token = THere(line=n)
      elif word.endswith(':') and word[:-1] in lblnames:
        token = TLabel(word[:-1], line=n)
      elif word in lblnames:
        token = TLabelRef(word, line=n)
      elif word == '[':
        token = TMemOpen(line=n)
      elif word == ']':
        token = TMemClose(line=n)
      elif word in MNEMONIC_NAMES:
        token = TMnemonic(word, line=n)
      elif (val := parsenum(word)) is not None:
        token = TNumber(val, line=n)
      elif word in OPERATORS:
        unary = any([
          isinstance(tokens[-1], T)
          for T in (TExprOpen, TMnemonic, TSeparator, TDirective, TOperator)
        ]) and word in '+-'

        token = TOperator(word, unary=unary, line=n)
      elif word in REGISTER_NAMES:
        token = TRegister(word, line=n)
      elif word == ',':
        token = TSeparator(line=n)
      elif word.startswith('@'):
        token = TString(strings[int(word[1:])], line=n)
        if include:
          include.args['filename'] = token.value[1:-1]
          include.chfile()
          include = None
          token = None

      else:
        error('test.s', n+1, 'Unexpected token:', word)

      if token:
        printv(('     ' if not newline else '') + str(token))
        tokens.append(token)

      newline = False

    linesep = TSeparator(value='\n', line=n)
    printv(('     ' if not newline else '') + str(linesep))
    tokens.append(linesep)
  return tokens
