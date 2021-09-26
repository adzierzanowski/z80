from argparse import ArgumentParser

from . import config
from .assembler import assemble, evaluate_size
from .disassembler import disassemble


def main():
  argparser = ArgumentParser('z80asm')
  argparser.add_argument('file', type=str)
  argparser.add_argument('-d', '--disassemble', action='store_true')
  argparser.add_argument('-o', '--output', type=str)
  argparser.add_argument('--documented', action='store_true', help='use only documented opcodes')
  argparser.add_argument('-v', '--verbose', action='store_true')
  args = argparser.parse_args()

  config.filename = args.file
  if args.verbose:
    config.verbose = True
  if args.documented:
    config.undocumented = False

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
