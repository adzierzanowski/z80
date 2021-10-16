import os
import re

from . import config
from .interface import error, parsenum, printv
from .symbols import (DIRECTIVES, I8080_MNEMONIC_NAMES, I8080_REGISTER_NAMES, OPERATORS, Z80_DOCUMENTED_MNEMONIC_NAMES, Z80_FLAG_NAMES,
                      Z80_MNEMONIC_NAMES, Z80_REGISTER_NAMES)
from .token import *

if config.cpu == 'z80':
  MNEMONIC_NAMES = Z80_MNEMONIC_NAMES if config.undocumented else Z80_DOCUMENTED_MNEMONIC_NAMES
  FLAGS = Z80_FLAG_NAMES
  REGISTER_NAMES = Z80_REGISTER_NAMES
elif config.cpu == 'i8080':
  MNEMONIC_NAMES = I8080_MNEMONIC_NAMES
  REGISTER_NAMES = I8080_REGISTER_NAMES
  FLAGS = []

LABEL_RX = re.compile(r'([a-zA-Z_][a-zA-Z0-9_]+):')
STRING_RX = re.compile(r'[\'\"].*?[\'\"]')
INCLUDE_RX = re.compile(r'^include [\'\"](?P<fname>.*?)[\'\"]$', re.M)
DEFINE_RX = re.compile(r'^def (?P<key>[a-zA-Z_0-9]+) (?P<val>.*?)(;|$)', re.M)


def strip_comments(line):
  try:
    line = line[:line.index(';')]
  except ValueError:
    pass
  return line

def find_file(fname, paths):
  for path in paths:
    if fname in os.listdir(path):
      return os.path.join(path, fname)
  return None

def resolve_includes(source, include_paths=None, origin=None, included=None):
  if included is None:
    included = {}

  if origin is None:
    origin = config.filename

  includes = re.finditer(INCLUDE_RX, source)
  src = source
  for inc in includes:
    directive = inc.group(0)
    fname = inc.group(1)
    back_to_origin = f'include "{origin}"'

    fpath = find_file(fname, include_paths)

    with open(fpath, 'r') as f:
      if fname in included and not config.once:
        warning(
          0, 'tokenizer::resolve_includes', fname,
          'multiple includes of a source:', f'"{fname}"')

      if fname in included and config.once:
        continue

      data = f.read()
      incsrc = resolve_includes(
        data, include_paths=include_paths, origin=fname, included=included)

      if fname in included:
        included[fname] += 1
      else:
        included[fname] = 1
      src = src.replace(
        directive, '\n'.join([directive, incsrc, back_to_origin]))

  return src

def resolve_defines(src):
  defines = {}

  for match in re.finditer(DEFINE_RX, src):
    k, v = match.group('key'), match.group('val')
    if k in defines:
      warning(0, 'tokenizer::resolve_defines', '<FNAME>',
        'multiple definitions for',
        f'{a.BLUE}{k}{a.E}',
        'the first one will be used:',
        f'{a.GREEN}"{defines[k]}"{a.E}')
    else:
      val = v
      for kk, vv in defines.items():
        if kk in v:
          val = v.replace(kk, vv)

      defines[k] = val

  src = src.split('\n')
  printv('Resolved definitions:', section='tok def')
  for k, v in defines.items():
    printv(
      f'  {a.BLUE}{k}{a.E} is defined as {a.YELLOW}{v}{a.E}',
      section='tok def')
    src = [line.replace(k, v) for line in src if not line.startswith('def')]
  printv(section='tok def')

  return defines

def tokenize(source, fname=config.filename, defines=None, lblnames=None, included=None):
  printv(section='tok token')
  printv(f'{a.GREEN}Tokenize{a.E} {fname}', section='tok token')

  if included is None:
    included = []
  merged_sources = resolve_includes(source, include_paths=config.include_paths)
  if defines is None:
    defines = resolve_defines(merged_sources)
  if lblnames is None:
    lblnames = re.findall(LABEL_RX, merged_sources)

  src = source
  for k, v in defines.items():
    src = src.replace(k, v)
  src = re.sub(DEFINE_RX, '', src)

  for symbol in tuple('[](),') + tuple(OPERATORS):
    src = src.replace(symbol, f' {symbol} ')
  src = src.splitlines()

  tokens = []
  newline = True

  for n, line in enumerate(src):
    strings = re.findall(STRING_RX, line)

    line = strip_comments(line)
    for i, s in enumerate(strings):
      line = line.replace(s, f'@{i}')

    line = [w for w in line.split(' ') if w != '']

    newline = True
    include = None

    printv(f'{n+1:4} ', end=' ', section='tok token')
    for word in line:

      token = None
      if word in DIRECTIVES:
        token = TDirective(word, fname, line=n)
        if token.value == 'include':
          include = token
        elif token.value == 'once':
          # TODO:
          pass
      elif word == '(':
        token = TExprOpen(fname, line=n)
      elif word == ')':
        token = TExprClose(fname, line=n)
      elif word.lower() in FLAGS:
        token = TFlag(word.lower(), fname, line=n)
      elif word == '$':
        token = THere(fname, line=n)
      elif word.endswith(':') and word[:-1] in lblnames:
        token = TLabel(word[:-1], fname, line=n)
      elif word in lblnames:
        token = TLabelRef(word, fname, line=n)
      elif word == '[':
        token = TMemOpen(fname, line=n)
      elif word == ']':
        token = TMemClose(fname, line=n)
      elif word in MNEMONIC_NAMES:
        token = TMnemonic(word, fname, line=n)
      elif (val := parsenum(word)) is not None:
        token = TNumber(val, fname, line=n)
      elif word in OPERATORS:
        unary = any([
          isinstance(tokens[-1], T)
          for T in (TExprOpen, TMnemonic, TSeparator, TDirective, TOperator)
        ]) and word in '+-'

        token = TOperator(word, fname, unary=unary, line=n)
      elif word in REGISTER_NAMES:
        token = TRegister(word, fname, line=n)
      elif word == ',':
        token = TSeparator(fname, line=n)
      elif word.startswith('@'):
        token = TString(strings[int(word[1:])], fname, line=n)
        if include:
          inc_fname = token.value[1:-1]
          include.args['filename'] = inc_fname
          fpath = find_file(inc_fname, config.include_paths)
          with open(fpath, 'r') as f:
            inctokens, nestedincs = tokenize(
              f.read(),
              fname=inc_fname,
              defines=defines,
              lblnames=lblnames,
              included=included)

            if inc_fname not in included or len([
              t for t in inctokens
              if isinstance(t, TDirective) and t.value == 'once'
            ]) == 0:
              tokens += inctokens
              included.append(inc_fname)
            else:
              printv(
                f'Skipping inclusion of "{inc_fname}" because of `once` directive.', section='tok token')

          include = None
          token = None

      else:
        error(n, 'tokenizer::tokenize', 'Unexpected token:', word)

      if token:
        printv(
          ('      ' if not newline else '') + f'{token}',
          section='tok token')
        tokens.append(token)

      newline = False

    linesep = TSeparator(fname, value='\n', line=n)
    printv(
      ('      ' if not newline else '') + str(linesep),
      section='tok token')
    tokens.append(linesep)

  return tokens, included
