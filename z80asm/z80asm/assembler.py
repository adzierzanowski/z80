from re import match
from .interface import error
from .symbols import MNEMONICS
from . import tokenizer
from math import log2, floor
import sys
from . import ansi as a

import logging

logger = logging.getLogger()

def first_pass(tokens):
  for tok in tokens:
    print(tok)

  print('FIRST PASS')

  labels = {}

  mtoken = None # first token of the current mnemonic
  mfound = False
  mnems = None # current matching mnemonics
  mnem = None
  mpos = 0
  cpos = 0

  for i, token in enumerate(tokens):
    if mtoken and mfound:
      if len(mnem.mnemonic) <= mpos:
        mtoken = None
        mpos = 0

    print(i, token, f'{a.GREEN if mfound else a.RED}mfound{a.E}'
    f' {a.GREEN if mtoken else a.RED}mtoken{a.E}')

    if token.type == 'label':
      token.position = cpos
      labels[token.value] = cpos
    elif token.type == 'mnemonic':
      mnems = [m for m in MNEMONICS if m.mnemonic[0] == token.value]
      mtoken = token
      if len(mnems) == 1:
        mnem = mnems[0]
        mtoken.position = cpos
        mtoken.mnemonic = mnem
        mtoken.signed = mnem.signed
        cpos += mnem.size
        mfound = True
        mpos += 1
      elif len(mnems) == 0:
        error(f'Expected different token for {mtoken}')
      else:
        mfound = False
        mpos = 1
    elif token.type == 'register':
      if not mfound:
        mnems = [m for m in mnems if m.mnemonic[mpos] == token.value]
        if len(mnems) == 1:
          mnem = mnems[0]
          mtoken.position = cpos
          mtoken.mnemonic = mnem
          mtoken.signed = mnem.signed
          cpos += mnem.size
          mfound = True
          mpos += 1
        elif len(mnems) == 0:
          error(f'Unexpected token after {token}: `{token}`')
        else:
          mpos += 1
      elif mtoken:
        if mnem.mnemonic[mpos] == token.value:
          mpos += 1
        else:
          error(f'Unexpected register for {mtoken}: {token}')
      else:
        error(f'Unexpected register without an instruction: {token}')

    elif token.type == 'number':
      if not mfound:
        mnems = [m for m in mnems if m.mnemonic[mpos] in ('imm8', 'imm16')]
        if len(mnems) == 1:
          mnem = mnems[0]
          mtoken.position = cpos
          mtoken.mnemonic = mnem
          mtoken.signed = mnem.signed
          cpos += mnem.size
          mfound = True
          mpos += 1
        elif len(mnems) == 0:
          error(f'Unexpected token after {token}: `{token}`')
        else:
          mpos += 1
      elif mtoken:
        if mnem.mnemonic[mpos] == 'imm8':
          if token.value < 0x100:
            if mtoken.signed:
              if token.value not in range(-128, 128):
                error(f'Expected a signed value in range [-128, 127] for {mtoken}')
              token.signed = True

            token.position = cpos
            token.size = 1
            mpos += 1
            cpos += 1
          else:
            error(f'Expected an 8-bit value for {mtoken}')
        elif mnem.mnemonic[mpos] == 'imm16':
          if token.value < 0x10000:
            token.position = cpos
            token.size = 2
            mpos += 1
            cpos += 2
          else:
            error(f'Expected a 16-byte value for {mtoken}')

      else:
        pass
        #cpos += floor(floor(log2(token.value)+1)/8+1) # number of bytes needed

    elif token.type == 'label_ref':
      if not mfound:
        mnems = [m for m in mnems if m.mnemonic[mpos] == 'imm16']
        if len(mnems) == 1:
          mnem = mnems[0]
          mtoken.position = cpos
          mtoken.mnemonic = mnem
          mtoken.signed = mnem.signed
          cpos += mnem.size
          mfound = True
          mpos += 1
        elif len(mnems) == 0:
          error(f'Unexpected token after {token}: `{token}`')
        else:
          mpos += 1
      elif mtoken:
        if mnem.mnemonic[mpos] == 'imm16':
          mpos += 1
      else:
        error(f'Label reference without an instruction: {token.value}')
    elif token.type == 'opening_paren':
      if not mfound:
        mnems = [m for m in mnems if m.mnemonic[mpos] in '([']
        if len(mnems) == 1:
          mnem = mnems[0]
          mtoken.position = cpos
          mtoken.mnemonic = mnem
          mtoken.signed = mnem.signed
          cpos += mnem.size
          mfound = True
          mpos += 1
        elif len(mnems) == 0:
          error(f'Unexpected token after {token}: `{token}`')
        else:
          mpos += 1
    elif token.type == 'closing_paren':
      if not mfound:
        mnems = [m for m in mnems if m.mnemonic[mpos] in ')]']
        if len(mnems) == 1:
          mnem = mnems[0]
          mtoken.position = cpos
          mtoken.mnemonic = mnem
          mtoken.signed = mnem.signed
          cpos += mnem.size
          mfound = True
          mpos += 1
        elif len(mnems) == 0:
          error(f'Unexpected token after {token}: `{token}`')
        else:
          mpos += 1
      elif mtoken:
        if mnem.mnemonic[mpos] in ')]':
          mpos += 1
        else:
          error(f'Unexpected closing parenthesis for {mtoken}')
    elif token.type == 'operator':
      pass

  return labels

def assemble(source_code):
  print('ASSEMBLE')
  tokens = tokenizer.tokenize(source_code)
  labels = first_pass(tokens)

  tokens = [t for t in tokens if t.type != 'label']

  print('BYTECODE EMIT')

  bytecode = []
  for tok in tokens:
    print(tok)
    if tok.position is not None:
      if tok.type == 'number' and tok.size is not None:
        val = tok.value
        if tok.signed:
          if val < 0:
            val = ~((-val) - 1)

        for _ in range(tok.size):
          bytecode.append(val & 0xff)
          val >>= 8
      else:
        bytecode += tok.mnemonic.opcode
    elif tok.type == 'label_ref':
      pos = labels[tok.value]
      bytecode.append(pos & 0xff)
      bytecode.append((pos >> 8) & 0xff)
  return bytecode
