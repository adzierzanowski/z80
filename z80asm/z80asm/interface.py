import sys

from . import ansi as a
from . import config


def error(fname, line, *msg, quit=True):
  print(f'{a.RED}{config.filename}:{line}: error:{a.E} {" ".join([str(m) for m in msg])}', file=sys.stderr)
  if quit:
    sys.exit(1)

def warning(fname, line, *msg):
  print(f'{a.YELLOW}{config.filename}:{line} warning:{a.E} {" ".join([str(m) for m in msg])}', file=sys.stderr)

def printv(*args, **kwargs):
  if config.verbose:
    print(*args, **kwargs)

def parsenum(word):
  try:
    if word.startswith('0b'):
      return int(word[2:], 2)
    elif word.startswith('0o'):
      return int(word[2:], 8)
    elif word.startswith('0x'):
      return int(word[2:], 16)
    else:
      return int(word)
  except ValueError:
    return None

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
