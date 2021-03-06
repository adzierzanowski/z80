from math import isfinite
import sys

from . import config
from .interface import error, parsenum, printv
from .symbols import I8080_UNIQUE_MNEMONICS, Z80_DOCUMENTED_MNEMONICS, Z80_UNIQUE_MNEMONICS
from .token import *

if config.cpu == 'z80':
  MNEMONICS = Z80_UNIQUE_MNEMONICS if config.undocumented else Z80_DOCUMENTED_MNEMONICS
elif config.cpu == 'i8080':
  MNEMONICS = I8080_UNIQUE_MNEMONICS

if config.original_parentheses:
  EXACT_OPMATCH_TOKEN_TYPES = (TMemOpen, TMemClose, TRegister, TFlag, TExprOpen, TExprClose)
else:
  EXACT_OPMATCH_TOKEN_TYPES = (TMemOpen, TMemClose, TRegister, TFlag)


def parse_expressions(tokens):
  printv(f'{a.GREEN}Parse expressions{a.E}', section='parser expr')
  printv(f'{a.CYAN}{"#":>4} {"File":>20} Line Token{a.E}', section='parser expr')
  ptokens = []

  etoken = None
  omitted = []
  ixiy = False

  for i, token in enumerate(tokens):
    if isinstance(token, TDirective):
      if token.value == 'include':
        token.chfile()
      ptokens.append(token)

    elif any([isinstance(token, T) for T in (TNumber, TLabelRef, THere)]):
      if etoken is None:
        etoken = TExpression('expr', token.fname, rpn=[token], line=token.line)
      else:
        etoken.rpn.append(token)
      omitted.append(token)

    elif isinstance(token, TRegister):
      if token.value in ('ix', 'iy'):
        ixiy = True

      if etoken:
        omitted.append(token)
      else:
        ptokens.append(token)

    elif isinstance(token, TOperator):
      if etoken is None:
        if token.unary:
          etoken = TExpression(
            'expr', token.fname, opstack=[token], line=token.line)
          omitted.append(token)
        elif not ixiy:
          error(
            token.line, 'parser::parse_expressions', token.fname,
            'Unexpected operator:', token)
        else:
          ptokens.append(token)
      else:
        omitted.append(token)
        if not (ixiy and config.original_parentheses):
          while etoken.opstack:
            nextop = etoken.opstack[-1]
            if isinstance(nextop, TOperator) and token < nextop:
              etoken.rpn.append(etoken.opstack.pop())
            else:
              break

          etoken.opstack.append(token)

    elif isinstance(token, TExprOpen):
      if etoken is None:
        etoken = TExpression('expr', opstack=[token], line=token.line)
      else:
        etoken.opstack.append(token)

      omitted.append(token)

    elif isinstance(token, TExprClose):
      if etoken:
        while etoken.opstack:
          op = etoken.opstack.pop()
          if isinstance(op, TExprOpen):
            break
          etoken.rpn.append(op)

        omitted.append(token)
      else:
        error(
          token.line, 'parser::parse_expressions', token.fname,
          'Unexpected closing parenthesis:', token)

    elif isinstance(token, TSeparator):
      if etoken is None:
        ptokens.append(token)
      else:
        while etoken.opstack:
          etoken.rpn.append(etoken.opstack.pop())
        if etoken.valid():
          ptokens.append(etoken)
          if token.value == '\n':
            ptokens.append(token)
        else:
          omitted.append(token)
          ptokens += omitted
        etoken = None
        omitted = []
      ixiy = False

    elif isinstance(token, TMemClose):
      if etoken is None:
        ptokens.append(token)
      else:
        if etoken.valid():
          ptokens.append(etoken)
          ptokens.append(token)
        else:
          omitted.append(token)
          ptokens += omitted
        etoken = None
        omitted = []

    else:
      if etoken:
        if etoken.valid():
          error(
            token.line, 'parser::parse_expressions', token.fname,
            'WTF', etoken)
        else:
          ptokens += omitted
          etoken = None
          omitted = []

      ptokens.append(token)

  for i, pt in enumerate(ptokens):
    try:
      printv(
        f'{i+1:4}',
        f'{a.GREEN}{pt.fname:>20}{a.E}:{a.CYAN}{pt.line+1:<4}{a.E}',
        pt,
        pt.rpnfmt if isinstance(pt, TExpression) else '',
        section='parser expr')
    except TypeError:
      printv(pt, section='parser expr')
  printv(section='parser expr')

  return ptokens

def parse_opcodes(tokens):
  def match(matches, spos, predicate):
    return [
      m for m in matches
      if (len(m.schema) > spos) and predicate(m.schema[spos])
    ]

  printv(f'{a.GREEN}Parse opcodes{a.E}', section='parser opcode')
  printv(
    f'{a.CYAN}{"#":>4} {"File":>20} Line Token{a.E}', section='parser opcode')

  ptokens = []

  mtoken = None
  matches = []
  spos = 0 # schema index

  for i, token in enumerate(tokens):
    printv(
      f'{i+1:4} {a.GREEN}{token.fname:>20}{a.E}:{a.CYAN}{token.line+1:<4}{a.E}',
      token,
      section='parser opcode')

    if isinstance(token, TDirective):
      if token.value == 'include':
        token.chfile()
    elif isinstance(token, TMnemonic):
      if mtoken:
        error(
          token.line, 'parser::parse_opcodes', token.fname,
          'Expected a new line:', token)
      else:
        mtoken = token
        matches = match(MNEMONICS, spos, lambda s: s == token.value)

    elif any([isinstance(token, T)
            for T in (TNumber, TLabelRef, THere, TExpression)]):
      if mtoken:
        matches = match(matches, spos, lambda s: (s in ('imm8', 'imm16')) or (parsenum(s) == token.value))
        if matches:
          mtoken.operands.append(token)

    elif any([isinstance(token, T)
              for T in EXACT_OPMATCH_TOKEN_TYPES]):
      if mtoken:
        predicate = lambda s: s == token.value
        if config.original_parentheses:
          predicate = lambda s: s == token.value.replace('(', '[').replace(')', ']')

        matches = match(matches, spos, predicate)

    elif isinstance(token, TString):
      if mtoken:
        matches = match(matches, spos, lambda s: s in ('imm8', 'imm16'))
        if matches:
          mtoken.operands.append(token)

    elif isinstance(token, TSeparator):
      ixiy = False

      if token.value == '\n':
        if mtoken:
          if matches:
            if len(matches) == 1:
              otoken = TOpcode(matches[0], token.fname, line=mtoken.line)
              ptokens.append(otoken)
              if mtoken.operands:
                ptokens += mtoken.operands
              mtoken = None
              spos = 0
            else:
              exact = [m for m in matches if len(m.schema) == spos]
              if len(exact) == 1:
                emnem = exact[0]
                otoken = TOpcode(emnem, token.fname, line=mtoken.line)
                ptokens.append(otoken)
                if mtoken.operands:
                  operands_count = emnem.schema.count('imm8') + emnem.schema.count('imm16') * 2
                  ptokens += mtoken.operands[-operands_count:]
                mtoken = None
                spos = 0
              else:
                error(
                  mtoken.line, 'parser::parse_opcodes', mtoken.fname,
                  'Ambiguous mnemonic:', mtoken, quit=False)
                print('Did you mean one of the following?', file=sys.stderr)
                for match in matches:
                  print('   ', match, file=sys.stderr)
                sys.exit(1)
          else:
            error(
              mtoken.line, 'parser::parse_opcodes', mtoken.fname,
              'No matches for mnemonic:', mtoken)
      elif token.value == ',':
        pass

    if mtoken:
      if matches and not isinstance(token, TSeparator):
        spos += 1
    else:
      ptokens.append(token)

  printv(section='parser opcode')

  return ptokens
