from pathlib import Path
import yaml
from collections import namedtuple

Operator = namedtuple('Operator', ('precedence', 'associativity'))

class Mnemonic:
  def __init__(self, schema, opcode, undocumented=False, duplicate=False, signed=False):
    self.schema = schema.split(' ')
    self.duplicate = duplicate
    self.undocumented = undocumented

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
      signed=data.get('signed', False)
    )

  @property
  def pretty_schema(self):
    out = ' '.join(self.schema)
    out = out.replace(' ]', ']')
    out = out.replace('[ ', '[')
    return out

  def __str__(self):
    return f'{" ".join(self.schema)}'

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
  'org',
  'include',
  'db',
  'dw',
  'ds',
  'times',
  'def'
)

OPERATORS = {
  '|': Operator(1, 'ltr'),
  '^': Operator(2, 'ltr'),
  '&': Operator(3, 'ltr'),
  '<<': Operator(4, 'ltr'),
  '>>': Operator(4, 'ltr'),
  '+': Operator(5, 'rtl'),
  '-': Operator(6, 'rtl'),
  '*': Operator(7, 'ltr'),
  '/': Operator(7, 'ltr'),
  '%': Operator(7, 'ltr'),
}

with open(Path(__file__).parent/'mnemonics.yml', 'r') as f:
  data = yaml.full_load(f)

MNEMONICS = [Mnemonic.from_yaml(m) for m in data['z80']]
Z80_MNEMONICS = [m for m in MNEMONICS if ((not m.duplicate) and (not m.undocumented))]
Z80_MNEMONIC_NAMES = [m.schema[0] for m in Z80_MNEMONICS]
MNEMONIC_NAMES = Z80_MNEMONIC_NAMES

Z80_REGISTER_NAMES = (
  'a', 'b', 'c', 'd', 'e', 'h', 'l',
  'af', 'bc', 'de', 'hl',
  'af\'', 'sp', 'ix', 'iy'
)

Z80_FLAG_NAMES = (
  'z', 'nz', 'pe', 'po', 'm', 'c', 'nc'
)

FLAGS = Z80_FLAG_NAMES

I8080_REGISTER_NAMES = (
  'a',
)

REGISTER_NAMES = Z80_REGISTER_NAMES + I8080_REGISTER_NAMES
