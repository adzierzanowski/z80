import re

from .symbols import DIRECTIVES, MNEMONIC_NAMES, OPERATORS, FLAGS, REGISTER_NAMES
from .token import *
from .interface import error, printv


LABEL_RX = re.compile(r'([a-zA-Z_][a-zA-Z0-9_]+):')
STRING_RX = re.compile(r'[\'\"].*?[\'\"]')
INCLUDE_RX = re.compile(r'')

def parsenum(word):
  try:
    if word.startswith('0b'):
      return int(word[2:], 2)
    elif word.startswith('0o'):
      return int(word[2:], 8)
    elif word.startswith('0x'):
      return int(word[2:], 16)
    else:
      return int(word)
  except ValueError:
    return None

def strip_comments(line):
  try:
    line = line[:line.index(';')]
  except ValueError:
    pass
  return line


def resolve_includes(source):


  return source

def tokenize(source):
  printv(f'{a.GREEN}Tokenize{a.E}')
  lblnames = re.findall(LABEL_RX, source)

  src = source
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

    printv(f'{n+1:4}', end=' ')
    for word in line:

      token = None
      if word in DIRECTIVES:
        token = TDirective(word, line=n)
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
        token = TOperator(word, line=n)
      elif word in REGISTER_NAMES:
        token = TRegister(word, line=n)
      elif word == ',':
        token = TSeparator(line=n)
      elif word.startswith('@'):
        token = TString(strings[int(word[1:])], line=n)
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
