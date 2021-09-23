import re
import sys
from .interface import error, printv
from .symbols import DIRECTIVES, MNEMONICS, REGISTER_NAMES, Z80_FLAG_NAMES, Z80_MNEMONIC_NAMES, Z80_REGISTER_NAMES, Mnemonic

from . import ansi as a

import logging

logger = logging.getLogger(__name__)

LABEL_RX = re.compile(r'([a-z_][a-z_\d]*):')

def try_parsenum(str):
  val = None
  try:
    if str.startswith('0b'):
      val = int(str[2:], 2)
    elif str.startswith('0x'):
      val = int(str[2:], 16)
    else:
      val = int(str)
  except ValueError:
    pass
  return val

class Token:
  DIRECTIVE = 'DIR'
  NUMBER = 'NUM'
  OPENING_PAREN = 'OPAR'
  CLOSING_PAREN = 'CPAR'
  MNEMONIC = 'MNEM'
  REGISTER = 'REG'
  FLAG = 'FLAG'
  HERE = 'HERE'
  LABEL = 'LBL'
  OPERATOR = 'OPER'
  LABEL_REF = 'REF'

  def __init__(self, type, value, src_line):
    self.type = type
    self.value = value
    self.src_line = src_line
    self.signed = False
    self.position = None
    self.mnemonic = None
    self.size = None
    self.argc = 0

  def __repr__(self):
    return str(self)

  def __str__(self):
    pos = f' #{self.position:04x}' if self.position is not None else '      '
    val = f'0x{self.value:<8x}' if type(self.value) == int else f'{self.value:<10}'
    return (
      f'{a.YELLOW}<'
      f'{a.BLUE}{self.type:5s}{a.E} '
      f'{val} L{self.src_line+1:<4d}{pos}'
      f'{a.YELLOW}>{a.E}'
    )

def find_labels(source_code):
  return re.findall(LABEL_RX, source_code)

def tokenize(source_code, verbose=False):
  printv(verbose, 'TOKENIZE')
  def unexpected_token(word, line_number):
    error(f'Unexpected token at line {line_number}:', word)

  src = source_code
  for symbol in '()[]+-*/&|':
    src = src.replace(symbol, f' {symbol} ')
  src = src.replace(',', '')
  labels = find_labels(src)

  tokens = []
  data = src.splitlines()
  for line_number, line in enumerate(data):
    # Strip comments
    try:
      line = line[:line.index(';')]
    except ValueError:
      pass

    spline = [word.strip() for word in line.split(' ') if word != '']
    for word in spline:
      word = word.lower()
      if word in DIRECTIVES:
        token = Token(Token.DIRECTIVE, word, line_number)
      elif word == '$':
        token = Token(Token.HERE, '$', line_number)
      elif word in ('-', '+', '*', '/', '&', '|'):
        token = Token(Token.OPERATOR, word, line_number)
      elif word in ('(', '['):
        token = Token(Token.OPENING_PAREN, word, line_number)
      elif word in (')', ']'):
        token = Token(Token.CLOSING_PAREN, word, line_number)
      elif word.endswith(':'):
        if re.match(LABEL_RX, word):
          token = Token(Token.LABEL, word[:-1], line_number)
        else:
          unexpected_token(word, line_number)
      elif word in Z80_MNEMONIC_NAMES:
        token = Token(Token.MNEMONIC, word, line_number)
      elif word in Z80_REGISTER_NAMES:
        token = Token(Token.REGISTER, word, line_number)
      elif word in Z80_FLAG_NAMES:
        token = Token(Token.FLAG, word, line_number)
      elif word in labels:
        token = Token(Token.LABEL_REF, word, line_number)
      else:
        if (val := try_parsenum(word)) is not None:
          token = Token(Token.NUMBER, val, line_number)
        else:
          unexpected_token(word, line_number)

      tokens.append(token)
      printv(verbose, token)

  printv(verbose)
  return tokens
