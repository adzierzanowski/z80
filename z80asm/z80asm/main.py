import sys

from argparse import ArgumentParser

from . import config


def main():
  argparser = ArgumentParser('z80asm')
  argparser.add_argument('file', type=str, help='input filename')
  argparser.add_argument('-d', '--disassemble', action='store_true', help='disassemble a binary file')
  argparser.add_argument('-i', '--i8080', action='store_true', help='Intel 8080 mode')
  argparser.add_argument('-o', '--output', type=str, help='output filename')
  argparser.add_argument('-p', '--parentheses', action='store_true', help='dereference addresses with (parentheses) instead of [brackets]')
  argparser.add_argument('-v', '--verbose', action='append', help='be verbose about a section (`-v list` for available sections)', metavar='SECTION')
  argparser.add_argument('-D', '--documented', action='store_true', help='use only documented opcodes')
  argparser.add_argument('-I', '--include', type=str, help='include path', action='append')
  argparser.add_argument('-O', '--once', action='store_true', help='include files at most one time')
  argparser.add_argument('-V', '--silly', action='store_true', help='be VERY verbose')
  args = argparser.parse_args()

  config.verbose = args.verbose if args.verbose else []
  if 'list' in config.verbose:
    print(f'{"tok":10} tokenizer module')
    print(f'{"  def":10} define resolution step')
    print(f'{"  token":10} tokenization step')
    print(f'{"parser":10} parser module')
    print(f'{"  expr":10} expression parsing step')
    print(f'{"  opcode":10} opcode parsing step')
    print(f'{"asm":10} assembler module')
    print(f'{"  szeval":10} size evaluation step')
    print(f'{"  emit":10} bytecode emission step')
    sys.exit(0)

  config.cpu = 'i8080' if args.i8080 else 'z80'
  config.filename = args.file
  config.include_paths = ['.'] + (args.include if args.include else [])
  config.once = args.once
  config.original_parentheses = args.parentheses
  config.silly = args.silly
  config.undocumented = not args.documented

  from .assembler import assemble, evaluate_size
  from .disassembler import disassemble
  from .parser import parse_expressions, parse_opcodes
  from .tokenizer import tokenize

  if args.disassemble:
    with open(args.file, 'rb') as f:
      data = tuple(f.read())
    out = disassemble(data)
    if args.output:
      with open(args.output, 'w') as f:
        f.write(out)
  else:
    with open(args.file, 'r') as f:
      tokens, _ = tokenize(f.read())
    tokens = parse_expressions(tokens)
    tokens = parse_opcodes(tokens)
    tokens, lblpos = evaluate_size(tokens)
    bytecode = assemble(tokens, lblpos)

    if args.output:
      with open(args.output, 'wb') as f:
        f.write(bytes(bytecode))
