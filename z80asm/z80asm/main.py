from argparse import ArgumentParser
from .assembler import assemble, evaluate_size
from . import config

def main():
  argparser = ArgumentParser('z80asmx')
  argparser.add_argument('file', type=str)
  argparser.add_argument('-o', '--output', type=str)
  argparser.add_argument('-v', '--verbose', action='store_true')
  args = argparser.parse_args()

  config.filename = args.file
  if args.verbose:
    config.verbose = True

  from .tokenizer import tokenize
  from .parser import parse_expressions, parse_opcodes
  with open(args.file, 'r') as f:
    tokens = tokenize(f.read())
  tokens = parse_expressions(tokens)
  tokens = parse_opcodes(tokens)
  tokens, lblpos = evaluate_size(tokens)
  bytecode = assemble(tokens, lblpos)

  if args.output:
    with open(args.output, 'wb') as f:
      f.write(bytes(bytecode))

    # parse expressions
    # find opcodes
    # parse directives *
    # emit bytecode
    #   evaluate expressions
    #   fill address
