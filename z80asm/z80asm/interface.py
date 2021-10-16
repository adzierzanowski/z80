import sys

from . import ansi as a
from . import config


def error(line, func, fname, *msg, quit=True):
  if config.current_include:
    line -= config.current_include.line
  print(
    f'{a.RED}{fname}:{line+1}: error:{a.E} {a.YELLOW}{func}{a.E} {" ".join([str(m) for m in msg])}',
    file=sys.stderr)
  if quit:
    sys.exit(1)

def warning(line, func, fname, *msg):
  print(
    f'{a.YELLOW}{fname}:{line+1} warning:{a.E} {a.ORANGE}{func}{a.E} {" ".join([str(m) for m in msg])}',
    file=sys.stderr)

def printv(*args, section=None, **kwargs):
  if config.silly or any([s in config.verbose for s in section.split(' ')]):
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
