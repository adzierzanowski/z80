from re import T


class Mnemonic:
  def __init__(self, mnemonic, opcode, opsize, size, cpu='z80', signed=False):
    self.mnemonic = mnemonic
    self.size = size
    self.opsize = opsize
    self.cpu = cpu
    self.opcode = opcode
    self.signed = signed

  def __str__(self):
    return f'M[{" ".join(self.mnemonic)}]'

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
  '.ds'
)

MNEMONICS = (
  Mnemonic(('nop',), [0x00], 1, 1),
  Mnemonic(('ld', 'bc', 'imm16'), [0x01], 1, 3),
  Mnemonic(('ld', '[', 'bc', ']', 'a'), [0x02], 1, 1),
  Mnemonic(('inc', 'bc'), [0x03], 1, 1),
  Mnemonic(('inc', 'b'), [0x04], 1, 1),
  Mnemonic(('dec', 'b'), [0x05], 1, 1),
  Mnemonic(('ld', 'b', 'imm8'), [0x06], 1, 2),
  Mnemonic(('rlca',), [0x07], 1, 1),
  Mnemonic(('ex', 'af', 'af\''), [0x08], 1, 1),
  Mnemonic(('add', 'hl', 'bc'), [0x09], 1, 1),
  Mnemonic(('ld', 'a', '[', 'bc', ']'), [0x0a], 1, 1),
  Mnemonic(('dec', 'bc'), [0x0b], 1, 1),
  Mnemonic(('inc', 'c'), [0x0c], 1, 1),
  Mnemonic(('dec', 'c'), [0x0d], 1, 1),
  Mnemonic(('ld', 'c', 'imm8'), [0x0e], 1, 2),
  Mnemonic(('rrca',), [0x0f], 1, 1),

  Mnemonic(('djnz', 'imm8'), [0x10], 1, 2, signed=True),
  Mnemonic(('ld', 'de', 'imm16'), [0x11], 1, 3),
  Mnemonic(('ld', '[', 'de', ']', 'a'), [0x12], 1, 1),
  Mnemonic(('inc', 'de'), [0x13], 1, 1),
  Mnemonic(('inc', 'd'), [0x14], 1, 1),
  Mnemonic(('dec', 'd'), [0x15], 1, 1),
  Mnemonic(('ld', 'd', 'imm8'), [0x16], 1, 2),
  Mnemonic(('rla',), [0x17], 1, 1),
  Mnemonic(('jr', 'imm8'), [0x18], 1, 2),
  Mnemonic(('add', 'hl', 'de'), [0x19], 1, 1),
  Mnemonic(('ld', 'a', '[', 'de', ']'), [0x1a], 1, 1),
  Mnemonic(('dec', 'de'), [0x1b], 1, 1),
  Mnemonic(('inc', 'e'), [0x1c], 1, 1),
  Mnemonic(('dec', 'e'), [0x1d], 1, 1),
  Mnemonic(('ld', 'e', 'imm8'), [0x1e], 1, 2),
  Mnemonic(('rra',), [0x1f], 1, 1),

  Mnemonic(('jr', 'nz', 'imm8'), [0x20], 1, 2, signed=True),
  Mnemonic(('ld', 'hl', 'imm16'), [0x21], 1, 3),
  Mnemonic(('ld', '[', 'imm16', ']', 'hl'), [0x22], 1, 3),
  Mnemonic(('inc', 'hl'), [0x23], 1, 1),
  Mnemonic(('inc', 'h'), [0x24], 1, 1),
  Mnemonic(('dec', 'h'), [0x25], 1, 1),
  Mnemonic(('ld', 'h', 'imm8'), [0x26], 1, 2),
  Mnemonic(('daa',), [0x27], 1, 1),
  Mnemonic(('jr', 'z', 'imm8'), [0x28], 1, 2),
  Mnemonic(('add', 'hl', 'hl'), [0x29], 1, 1),
  Mnemonic(('ld', 'hl', '[', 'imm16', ']'), [0x2a], 1, 3),
  Mnemonic(('dec', 'hl'), [0x2b], 1, 1),
  Mnemonic(('inc', 'l'), [0x2c], 1, 1),
  Mnemonic(('dec', 'l'), [0x2d], 1, 1),
  Mnemonic(('ld', 'l', 'imm8'), [0x2e], 1, 1),
  Mnemonic(('cpl',), [0x2f], 1, 1),

  Mnemonic(('jr', 'nc', 'imm8'), [0x30], 1, 2, signed=True),
  Mnemonic(('ld', 'sp', 'imm16'), [0x31], 1, 3),
  Mnemonic(('ld', '[', 'imm16', ']', 'a'), [0x32], 1, 3),
  Mnemonic(('inc', 'sp'), [0x33], 1, 1),
  Mnemonic(('inc', '[', 'hl', ']'), [0x34], 1, 1),
  Mnemonic(('dec', '[', 'hl', ']'), [0x35], 1, 1),
  #Mnemonic((), [0x36], 1, 1),
  #Mnemonic((), [0x37], 1, 1),
  #Mnemonic((), [0x38], 1, 1),
  #Mnemonic((), [0x39], 1, 1),
  #Mnemonic((), [0x3a], 1, 1),
  #Mnemonic((), [0x3b], 1, 1),
  #Mnemonic((), [0x3c], 1, 1),
  #Mnemonic((), [0x3d], 1, 1),
  #Mnemonic((), [0x3e], 1, 1),
  #Mnemonic((), [0x3f], 1, 1),

  #Mnemonic((), [0x40], 1, 1),
  #Mnemonic((), [0x41], 1, 1),
  #Mnemonic((), [0x42], 1, 1),
  #Mnemonic((), [0x43], 1, 1),
  #Mnemonic((), [0x44], 1, 1),
  #Mnemonic((), [0x45], 1, 1),
  #Mnemonic((), [0x46], 1, 1),
  #Mnemonic((), [0x47], 1, 1),
  #Mnemonic((), [0x48], 1, 1),
  #Mnemonic((), [0x49], 1, 1),
  #Mnemonic((), [0x4a], 1, 1),
  #Mnemonic((), [0x4b], 1, 1),
  #Mnemonic((), [0x4c], 1, 1),
  #Mnemonic((), [0x4d], 1, 1),
  #Mnemonic((), [0x4e], 1, 1),
  #Mnemonic((), [0x4f], 1, 1),

  Mnemonic(('ld', 'de', 'imm16'), [0x11], 1, 3),
  Mnemonic(('jp', 'imm16'), [0xc3], 1, 3),
  Mnemonic(('add', 'a', 'imm8'), [0xc6], 1, 2),
  Mnemonic(('ld', 'a', 'imm8'), [0x3c], 1, 2),
)

Z80_MNEMONIC_NAMES = [m.mnemonic[0] for m in MNEMONICS if m.cpu == 'z80']

Z80_REGISTER_NAMES = (
  'a', 'b', 'c', 'd', 'e', 'h', 'l', 'af', 'bc', 'de', 'hl', 'af\'', 'sp'
)

Z80_FLAG_NAMES = (
  'z', 'nz', 'p', 'm', 'c', 'nc'
)

I8080_REGISTER_NAMES = (
  'a',
)

REGISTER_NAMES = Z80_REGISTER_NAMES + I8080_REGISTER_NAMES
