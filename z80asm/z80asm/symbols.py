from collections import namedtuple
from pathlib import Path

import yaml

Operator = namedtuple('Operator', ('precedence', 'associativity'))

class Mnemonic:
  def __init__(self, schema, opcode, undocumented=False, duplicate=False, signed=False, relative=False):
    self.original_schema = schema
    self.schema = schema.replace(',', '').split(' ')
    self.duplicate = duplicate
    self.undocumented = undocumented
    self.relative = relative

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
    return Mnemonic(
      data['schema'],
      data['opcode'],
      duplicate=data.get('duplicate', False),
      undocumented=data.get('undocumented', False),
      signed=data.get('signed', False),
      relative=data.get('relative', False)
    )

  @property
  def pretty_schema(self):
    out = self.original_schema
    out = out.replace(' ]', ']')
    out = out.replace('[ ', '[')
    return out

  def __str__(self):
    return f'{" ".join(self.schema)}'

  def __repr__(self):
    return str(self)

DIRECTIVES = (
  'org',
  'include',
  'db',
  'dw',
  'ds',
  'times',
  'def',
  'once'
)

OPERATORS = ('~', '|', '^', '&', '<<', '>>', '+', '-', '*', '/', '%')

with open(Path(__file__).parent/'mnemonics.yml', 'r') as f:
  data = yaml.full_load(f)

Z80_MNEMONICS = [Mnemonic.from_yaml(m) for m in data['z80']]
Z80_MNEMONIC_NAMES = [m.schema[0] for m in Z80_MNEMONICS]
Z80_UNIQUE_MNEMONICS = [m for m in Z80_MNEMONICS if not m.duplicate]
Z80_DOCUMENTED_MNEMONICS = [m for m in Z80_UNIQUE_MNEMONICS if not m.undocumented]
Z80_DOCUMENTED_MNEMONIC_NAMES = [m.schema[0] for m in Z80_DOCUMENTED_MNEMONICS]

Z80_REGISTER_NAMES = (
  'ixh', 'ixl', 'iyh', 'iyl',
  'af', 'bc', 'de', 'hl',
  'af\'', 'sp', 'ix', 'iy',
  'a', 'b', 'c', 'd', 'e', 'h', 'l', 'i', 'r'
)

Z80_FLAG_NAMES = (
  'z', 'nz', 'pe', 'po', 'm', 'c', 'nc', 'p'
)

I8080_MNEMONICS = [Mnemonic.from_yaml(m) for m in data['i8080']]
I8080_MNEMONIC_NAMES = [m.schema[0] for m in I8080_MNEMONICS]
I8080_UNIQUE_MNEMONICS = [m for m in I8080_MNEMONICS if not m.duplicate]

I8080_REGISTER_NAMES = (
  'psw',
  'sp',
  'a', 'b', 'c', 'd', 'e', 'h', 'l',
)
