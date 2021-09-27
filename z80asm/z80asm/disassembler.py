from . import config
from . import ansi as a
from .symbols import I8080_MNEMONICS, Z80_MNEMONICS

import re

print('CONFIG.CPU', config.cpu)
MNEMONICS = Z80_MNEMONICS if config.cpu == 'z80' else I8080_MNEMONICS

ANSIRX = re.compile(r'(\[\d*?;\d*?;\d*?m)')

def ansipad(ansistr, pad):
  s = ansistr.replace('\x1b', '')
  s = re.sub(ANSIRX, '', s)
  s = s.replace('[0m', '').strip()
  s = ansistr + (pad - len(s)) * ' '
  return s

def operandval(operands):
  val = 0
  for i, op in enumerate(operands):
    val |= op << (8 * i)
  return val

def disassemble(bytecode):
  matches = MNEMONICS
  match = None
  opos = 0
  operands = []
  imm = 0
  out = ''
  i = 0
  skip = False
  skipped_byte = None
  defer_opcode = False

  while True:
    nomore = False
    try:
      b = bytecode[i]
    except IndexError:
      nomore = True


    if skip and not nomore:
      skip = False
      skipped_byte = b
      i += 1
      continue
    elif imm and not nomore:
      operands.append(b)
      imm -= 1
    else:
      if match:
        val = operandval(operands)
        out += match.pretty_schema.replace('imm8', f'0x{val:02x}').replace('imm16', f'0x{val:04x}') + '\n'

        schema = match.pretty_schema
        schema = schema.replace('[', f'{a.YELLOW}[{a.E}{a.BLUE}')
        schema = schema.replace(']', f'{a.YELLOW}]{a.E}{a.BLUE}')
        schema = schema.replace('imm8', f'{a.CYAN}{val:02x}{a.E}{a.BLUE}')
        schema = schema.replace('imm16', f'{a.CYAN}{val:04x}{a.E}{a.BLUE}')
        schema = a.BLUE + schema
        schema = ansipad(schema, 30)

        opcode_bytes = match.opcode
        deferred = None
        if defer_opcode:
          opcode_bytes, deferred = opcode_bytes[:2], opcode_bytes[-1]
          defer_opcode = False

        opcodefmt = a.BLUE + ' '.join([f'{byte:08b}' for byte in opcode_bytes]) + a.E
        deferredfmt = (a.BLUE + f'{deferred:08b}' + a.E) if deferred is not None else ''
        operandfmt = a.CYAN + ' '.join([f'{byte:08b}' for byte in operands]) + a.E + ' ' + deferredfmt
        opcodechars = a.BLUE + ' '.join([chr(byte) if chr(byte).isprintable() else '.' for byte in opcode_bytes]) + a.E
        operandchars = a.BLUE + ' '.join([chr(byte) if chr(byte).isprintable() else '.' for byte in operands]) + a.E

        opcodefmt = ansipad(opcodefmt, 8)
        operandfmt = ansipad(operandfmt, 30)

        pos = i - len(operands) - len(match.opcode) + (1 if deferred else 0)
        undoc = f'{a.RED}undocumented{a.E}' if match.undocumented else ''
        dup = f'{a.RED}duplicate{a.E}' if match.duplicate else ''

        print(f'{pos:04x}    {schema} {opcodefmt} {operandfmt} {opcodechars} {operandchars} {undoc} {dup}')
        operands = []
        match = None
        matches = MNEMONICS
        if deferred:
          deferred = None
          i += 1
          continue

      matches = [m for m in matches if m.opcode[opos] == b]

      if len(matches) == 1:
        match = matches[0]
        if skipped_byte is not None:
          imm = 0
          operands = [skipped_byte]
          opos = 0
          skipped_byte = None
          defer_opcode = True
          continue

        imm = match.schema.count('imm8')
        imm += match.schema.count('imm16') * 2

        if len(match.opcode) == opos + 1:
          opos = 0
          matches = MNEMONICS
        else:
          opos += 1
      elif len(matches) > 1:
        if opos == 1 and matches[0].opcode[1] == 0xcb:
          skip = True
        opos += 1

    i += 1
    if nomore:
      break
  return out
