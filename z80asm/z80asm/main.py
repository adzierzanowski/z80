from argparse import ArgumentParser

from . import config


def main():
  argparser = ArgumentParser('z80asm')
  argparser.add_argument('file', type=str, help='input filename')
  argparser.add_argument('-d', '--disassemble', action='store_true', help='disassemble a binary file')
  argparser.add_argument('-i', '--i8080', action='store_true', help='Intel 8080 mode')
  argparser.add_argument('-o', '--output', type=str, help='output filename')
  argparser.add_argument('-p', '--parentheses', action='store_true', help='dereference addresses with (parentheses) instead of [brackets]')
  argparser.add_argument('-v', '--verbose', action='store_true', help='be verbose (VERY verbose)')
  argparser.add_argument('-D', '--documented', action='store_true', help='use only documented opcodes')
  argparser.add_argument('-I', '--include', type=str, help='include path', action='append')
  args = argparser.parse_args()

  print(args.include)

  config.filename = args.file
  config.verbose = args.verbose
  config.undocumented = not args.documented
  config.cpu = 'i8080' if args.i8080 else 'z80'
  config.original_parentheses = args.parentheses

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
      tokens = tokenize(f.read())
    tokens = parse_expressions(tokens)
    tokens = parse_opcodes(tokens)
    tokens, lblpos = evaluate_size(tokens)
    bytecode = assemble(tokens, lblpos)

    if args.output:
      with open(args.output, 'wb') as f:
        f.write(bytes(bytecode))
