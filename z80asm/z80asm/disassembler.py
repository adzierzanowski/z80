from . import ansi as a
from .symbols import Z80_MNEMONICS


def operandval(operands):
  val = 0
  for i, op in enumerate(operands):
    val |= op << (8 * i)
  return val

def disassemble(bytecode):
  matches = Z80_MNEMONICS
  match = None
  opos = 0
  operands = []
  imm = 0
  out = ''
  i = 0

  while True:
    nomore = False
    try:
      b = bytecode[i]
    except IndexError:
      nomore = True

    if imm and not nomore:
      operands.append(b)
      imm -= 1
    else:
      if match:
        val = operandval(operands)
        out += match.pretty_schema.replace('imm8', f'0x{val:02x}').replace('imm16', f'0x{val:04x}') + '\n'
        schema = f'{match.pretty_schema:30}'
        schema = schema.split(' ')
        opcode, schema = schema[0], ' '.join(schema[1:])
        schema = schema + ('  ' * schema.count('imm8'))
        schema = schema + (' ' * schema.count('imm16'))
        schema = schema.replace('[', f'{a.YELLOW}[{a.BLUE}')
        schema = schema.replace(']', f'{a.YELLOW}]{a.BLUE}')
        schema = schema.replace('imm8', f'{a.CYAN}{val:02x}{a.BLUE}')
        schema = schema.replace('imm16', f'{a.CYAN}{val:04x}{a.BLUE}')
        schema = a.BLUE + opcode + ' ' + schema


        opcode_bytes = match.opcode
        opcodefmt = a.BLUE + ' '.join([f'{byte:02x}' for byte in opcode_bytes]) + a.E
        operandfmt = a.CYAN + ' '.join([f'{byte:02x}' for byte in operands]) + a.E
        opcodechars = a.BLUE + ' '.join([chr(byte) if chr(byte).isprintable() else '.' for byte in opcode_bytes]) + a.E
        operandchars = a.BLUE + ' '.join([chr(byte) if chr(byte).isprintable() else '.' for byte in operands]) + a.E

        pos = i - len(operands) - len(match.opcode)
        undoc = f'{a.RED}undocumented{a.E}' if match.undocumented else ''
        dup = f'{a.RED}duplicate{a.E}' if match.duplicate else ''

        print(f'{pos:04x}    {schema} {opcodefmt} {operandfmt:30} {opcodechars} {operandchars} {undoc} {dup}')
        operands = []
        match = None
        matches = Z80_MNEMONICS

      matches = [m for m in matches if m.opcode[opos] == b]

      if len(matches) == 1:
        match = matches[0]
        imm = match.schema.count('imm8')
        imm += match.schema.count('imm16') * 2

        if len(match.opcode) == opos + 1:
          opos = 0
          matches = Z80_MNEMONICS
        else:
          opos += 1
      elif len(matches) > 1:
        opos += 1
    i += 1
    if nomore:
      break
  return out
