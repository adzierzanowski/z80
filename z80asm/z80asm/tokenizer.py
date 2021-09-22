import re
import sys
from .interface import error
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
  def __init__(self, type, value, src_line):
    self.type = type
    self.value = value
    self.src_line = src_line
    self.signed = False
    self.position = None
    self.mnemonic = None
    self.size = None

  def __repr__(self):
    return str(self)

  def __str__(self):
    pos = f' #{self.position:04x}' if self.position is not None else ''
    return f'{a.YELLOW}<{a.BLUE}{self.type:15s}{a.E}{self.value:<8}@L{self.src_line+1:<4d}{pos}{a.YELLOW}>{a.E}'

def find_labels(source_code):
  return re.findall(LABEL_RX, source_code)

def tokenize(source_code):
  def unexpected_token(word):
    error('Unexpected token:', word)

  src = source_code.lower()
  for symbol in '()[]+-*/&|':
    src = src.replace(symbol, f' {symbol} ')
  src = src.replace(',', '')
  labels = find_labels(src)

  tokens = []
  data = src.split('\n')
  for line_number, line in enumerate(data):
    # Strip comments
    try:
      line = line[:line.index(';')]
    except ValueError:
      pass

    spline = [word.strip() for word in line.split(' ') if word != '']
    for word in spline:
      if word in DIRECTIVES:
        tokens.append(Token('directive', word, line_number))
      elif word == '$':
        tokens.append(Token('here', '$', line_number))
      elif word in ('-', '+', '*', '/', '&', '|'):
        tokens.append(Token('operator', word, line_number))
      elif word in ('(', '['):
        tokens.append(Token('opening_paren', word, line_number))
      elif word in (')', ']'):
        tokens.append(Token('closing_paren', word, line_number))
      elif word.endswith(':'):
        if re.match(LABEL_RX, word):
          tokens.append(Token('label', word[:-1], line_number))
        else:
          unexpected_token(word)
      elif word in Z80_MNEMONIC_NAMES:
        tokens.append(Token('mnemonic', word, line_number))
      elif word in Z80_REGISTER_NAMES:
        tokens.append(Token('register', word, line_number))
      elif word in Z80_FLAG_NAMES:
        tokens.append(Token('flag', word, line_number))
      elif word in labels:
        tokens.append(Token('label_ref', word, line_number))
      else:
        if val := try_parsenum(word):
          tokens.append(Token('number', val, line_number))
        else:
          unexpected_token(word)

  return tokens
