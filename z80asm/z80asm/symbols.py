import os
from pathlib import Path
import yaml


class Mnemonic:
  def __init__(self, schema, opcode, signed=False):
    self.schema = schema.split(' ')
    if type(opcode) == int:
      self.opcode = (opcode,)
    else:
      self.opcode = opcode
    self.signed = signed

    self.size = len(self.opcode)
    if 'imm8' in self.schema:
      self.size += 1
    elif 'imm16' in self.schema:
      self.size += 2

  @staticmethod
  def from_yaml(data):
    return Mnemonic(data['schema'], data['opcode'], data.get('signed', False))

  @property
  def pretty_schema(self):
    out = ' '.join(self.schema)
    out = out.replace(' ]', ']')
    out = out.replace('[ ', '[')
    return out

  def __str__(self):
    return f'M[{" ".join(self.schema)}]'

  def __repr__(self):
    return str(self)

  @property
  def argsize(self):
    return self.size - self.opsize

class Opcode:
  def __init__(self, numbers):
    self.numbers = numbers

PARENTHESES = '([)]'

DIRECTIVES = (
  '.org',
  '.include',
  '.db',
  '.dw',
  '.ds',
  '.times',
  '.def'
)

with open(Path(__file__).parent/'mnemonics.yml', 'r') as f:
  data = yaml.full_load(f)

MNEMONICS = [Mnemonic.from_yaml(m) for m in data['z80']]

Z80_MNEMONIC_NAMES = [m.schema[0] for m in MNEMONICS]

Z80_REGISTER_NAMES = (
  'a', 'b', 'c', 'd', 'e', 'h', 'l', 'af', 'bc', 'de', 'hl', 'af\'', 'sp'
)

Z80_FLAG_NAMES = (
  'z', 'nz', 'pe', 'po', 'm', 'c', 'nc'
)

I8080_REGISTER_NAMES = (
  'a',
)

REGISTER_NAMES = Z80_REGISTER_NAMES + I8080_REGISTER_NAMES
