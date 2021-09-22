from re import DEBUG
import sys

from argparse import ArgumentParser
from .interface import error
from .assembler import assemble

import logging



def main():
  parser = ArgumentParser()
  parser.add_argument('FILE', type=str, help='input file')
  parser.add_argument('-d', '--disassemble', action='store_true', help='disassemble binary')
  parser.add_argument('-i', '--intel8080', action='store_true', help='intel8080 mode')
  parser.add_argument('-o', '--output', type=str, help='output file')
  parser.add_argument('-s', '--strict', action='store_true', help='use mnemonics strictly of cpu type')
  args = parser.parse_args()

  logging.basicConfig(format='%(levelname)-10s L%(lineno)-6d %(message)s', level=DEBUG, stream=sys.stdout)
  logging.root.setLevel(logging.NOTSET)


  try:
    with open(args.FILE, 'r') as f:
      data = f.read()
  except FileNotFoundError:
    error('Input file not found.', file=sys.stderr)
    sys.exit(1)


  if args.disassemble:
    print('Disassembler not implemented yet.', file=sys.stderr)
    sys.exit(1)
  else:
    bytecode = assemble(data)
    if args.output:
      print('writing to', args.output)
      with open(args.output, 'wb') as f:
        n = f.write(bytes(bytecode))
        print('written', n, 'bytes')


if __name__ == '__main__':
  main()
