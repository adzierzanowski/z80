import sys

from . import config
from .interface import error, parsenum, printv
from .symbols import Z80_DOCUMENTED_MNEMONICS, Z80_UNIQUE_MNEMONICS
from .token import *

MNEMONICS = Z80_UNIQUE_MNEMONICS if config.undocumented else Z80_DOCUMENTED_MNEMONICS


def parse_expressions(tokens):
  printv(f'{a.GREEN}Parse expressions{a.E}')
  printv(f'{a.CYAN}{"#":>4} Line Token{a.E}')
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
        etoken = TExpression('expr', rpn=[token], line=token.line)
      else:
        etoken.rpn.append(token)
      omitted.append(token)

    elif isinstance(token, TRegister):
      if token.value in ('ix', 'iy'):
        ixiy = True
      ptokens.append(token)

    elif isinstance(token, TOperator):
      if etoken is None:
        if not ixiy:
          error('test.s', token.line+1, 'Unexpected operator:', token)
        ptokens.append(token)
      else:
        omitted.append(token)
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
        error('test.s', token.line+1, 'Unexpected closing parenthesis:', token)

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

    else:
      if etoken:
        if etoken.valid():
          error('test.s', token.line+1, 'WTF', etoken)
        else:
          ptokens += omitted
          etoken = None
          omitted = []

      ptokens.append(token)

  for i, pt in enumerate(ptokens):
    try:
      printv(f'{i+1:4}', f'{pt.line:4}', pt, pt.rpnfmt if isinstance(pt, TExpression) else '')
    except TypeError:
      printv(pt)

  return ptokens

def parse_opcodes(tokens):
  def match(matches, spos, predicate):
    return [
      m for m in matches
      if (len(m.schema) > spos) and predicate(m.schema[spos])
    ]

  printv(f'{a.GREEN}Parse opcodes{a.E}')
  printv(f'{a.CYAN}{"#":>4} Line Token{a.E}')

  ptokens = []

  mtoken = None
  matches = []
  spos = 0 # schema index

  for i, token in enumerate(tokens):
    printv(f'{i+1:4} {token.line+1:4}', token)

    if isinstance(token, TMnemonic):
      if mtoken:
        error('test.s', token.line+1, 'Expected a new line:', token)
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
              for T in (TMemOpen, TMemClose, TRegister, TFlag)]):
      if mtoken:
        matches = match(matches, spos, lambda s: s == token.value)

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
              otoken = TOpcode(matches[0], line=mtoken.line)
              ptokens.append(otoken)
              if mtoken.operands:
                ptokens += mtoken.operands
              mtoken = None
              spos = 0
            else:
              exact = [m for m in matches if len(m.schema) == spos]
              if len(exact) == 1:
                otoken = TOpcode(exact[0], line=mtoken.line)
                ptokens.append(otoken)
                if mtoken.operands:
                  ptokens += mtoken.operands
                mtoken = None
                spos = 0
              else:
                error('test.s', mtoken.line+1, 'Ambiguous mnemonic:', mtoken, quit=False)
                print('Did you mean one of the following?')
                for match in matches:
                  print('   ', match, file=sys.stderr)
                sys.exit(1)
          else:
            error('test.s', mtoken.line+1, 'No matches for mnemonic:', mtoken)
      elif token.value == ',':
        pass

    if mtoken:
      if matches and not isinstance(token, TSeparator):
        spos += 1
    else:
      ptokens.append(token)

  return ptokens
