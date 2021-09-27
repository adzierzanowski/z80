from unittest import TestCase
from z80asm.token import *


class TestExpressionEvaluation(TestCase):
  def test_simple_expressions(self):
    expr = TExpression('expr', rpn=[
      TNumber(2),
      TNumber(2),
      TOperator('+'),
      TNumber(2),
      TOperator('*')
    ])

    expr2 = TExpression('expr2', rpn=[
      TNumber(2),
      TNumber(2),
      TNumber(2),
      TOperator('*'),
      TOperator('+')
    ])

    self.assertEqual(expr.evaluate(), 8)
    self.assertEqual(expr2.evaluate(), 6)

  def test_unary_operators(self):
    expr = TExpression('expr', rpn=[
      TNumber(2),
      TOperator('-', unary=True),
      TNumber(8),
      TOperator('+', unary=True),
      TOperator('+'),
      TOperator('~', unary=True)
    ])

    self.assertEqual(expr.evaluate(), 0b11111001)
