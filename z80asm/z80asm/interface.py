import sys
from . import ansi as a
from . import config


def error(fname, line, *msg, quit=True):
  print(f'{a.RED}{fname}:{line}: error:{a.E} {" ".join([str(m) for m in msg])}', file=sys.stderr)
  if quit:
    sys.exit(1)

def warning(fname, line, *msg):
  print(f'{a.YELLOW}{fname}:{line} warning:{a.E} {" ".join([str(m) for m in msg])}', file=sys.stderr)

def printv(*args, **kwargs):
  if config.verbose:
    print(*args, **kwargs)

def bytearr_fmt(ls, rle=False):
  if rle:
    last = None
    rlels = []
    for b in ls:
      if b == last:
        rlels[-1][1] += 1
      else:
        rlels.append([b, 1])
        last = b

    out = ''
    for b, cnt in rlels:
      if cnt > 4:
        out += f'{b:02x}[...{cnt}]'
      else:
        out += f'{b:02x} ' * cnt

    return out.rstrip()

  return ' '.join([f'{b:02x}' for b in ls])
