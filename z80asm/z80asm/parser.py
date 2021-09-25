from re import match
from sys import is_finalizing
from .symbols import MNEMONICS
from .interface import error, printv
from .token import *


def parse_expressions(tokens):
  printv(f'{a.GREEN}Parse expressions{a.E}')
  ptokens = []

  etoken = None
  omitted = []

  for i, token in enumerate(tokens):
    if any([isinstance(token, T) for T in (TNumber, TLabelRef, THere)]):
      if etoken is None:
        etoken = TExpression('expr', rpn=[token], line=token.line)
      else:
        etoken.rpn.append(token)
      omitted.append(token)

    elif isinstance(token, TOperator):
      if etoken is None:
        error('test.s', token.line, 'Unexpected operator:', token)
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
        error('test.s', token.line, 'Unexpected closing parenthesis:', token)

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
          error('test.s', token.line, 'WTF', etoken)
        else:
          ptokens += omitted
          etoken = None
          omitted = []

      ptokens.append(token)

  for i, pt in enumerate(ptokens):
    printv(f'{i:4}', f'{pt.line:4}', pt, pt.rpnfmt if isinstance(pt, TExpression) else '')

  return ptokens

def parse_opcodes(tokens):
  def match(matches, spos, predicate):
    return [
      m for m in matches
      if (len(m.schema) > spos) and predicate(m.schema[spos])
    ]

  printv(f'{a.GREEN}Parse opcodes{a.E}')

  ptokens = []

  mtoken = None
  matches = []
  spos = 0 # schema index

  for i, token in enumerate(tokens):
    printv(f'{i:4}', token)

    if isinstance(token, TMnemonic):
      if mtoken:
        error('test.s', token.line, 'Expected a new line:', token)
      else:
        mtoken = token
        matches = match(MNEMONICS, spos, lambda s: s == token.value)

    if any([isinstance(token, T)
            for T in (TNumber, TLabelRef, THere, TExpression)]):
      if mtoken:
        matches = match(matches, spos, lambda s: s in ('imm8', 'imm16'))
        if matches:
          mtoken.operand = token

    elif any([isinstance(token, T)
              for T in (TMemOpen, TMemClose, TRegister, TFlag)]):
      if mtoken:
        matches = match(matches, spos, lambda s: s == token.value)

    if isinstance(token, TSeparator):
      if token.value == '\n':
        if mtoken:
          if matches:
            if len(matches) == 1:
              otoken = TOpcode(matches[0], line=mtoken.line)
              ptokens.append(otoken)
              if mtoken.operand:
                ptokens.append(mtoken.operand)
              mtoken = None
              spos = 0
            else:
              exact = [m for m in matches if len(m.schema) == spos]
              if len(exact) == 1:
                otoken = TOpcode(exact[0], line=mtoken.line)
                ptokens.append(otoken)
                if mtoken.operand:
                  ptokens.append(mtoken.operand)
                mtoken = None
                spos = 0
              else:
                error('test.s', mtoken.line, 'Ambiguous mnemonic:', mtoken)
          else:
            error('test.s', mtoken.line, 'No matches for mnemonic:', mtoken)
      elif token.value == ',':
        pass

    if mtoken:
      if matches and not isinstance(token, TSeparator):
        spos += 1
    else:
      ptokens.append(token)

  return ptokens
