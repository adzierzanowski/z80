import sys
from . import ansi as a


def error(*msg, quit=True):
  print(f'{a.RED}error:{a.E} {" ".join([str(m) for m in msg])}', file=sys.stderr)
  if quit:
    sys.exit(1)
