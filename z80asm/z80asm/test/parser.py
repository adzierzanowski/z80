
from unittest.case import TestCase
from z80asm.token import *
from z80asm.parser import parse_expressions


class TestExpressionParser(TestCase):
  def test_bit_shift(self):
    tokens = [
      TMnemonic('ld'), TRegister('c'), TSeparator(','),
      TNumber(1), TOperator('<<'), TNumber(7)]
    tokens = parse_expressions(tokens)
    print(tokens)
