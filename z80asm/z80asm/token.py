from .symbols import OPERATORS
from . import config
from .interface import error
from . import ansi as a


class Token:
  DIRECTIVE = 'DIR'
  EXPRESSION = 'EXPR'
  EXPR_OPEN = 'EOPN'
  EXPR_CLOSE = 'ECLS'
  FLAG = 'FLAG'
  HERE = 'HERE'
  LABEL = 'LBL'
  LABEL_REF = 'REF'
  MEM_CLOSE = 'MCLS'
  MEM_OPEN = 'MOPN'
  MNEMONIC = 'MNEM'
  NUMBER = 'NUM'
  OPCODE = 'OPCD'
  OPERATOR = 'OPTR'
  REGISTER = 'REG'
  SEPARATOR = 'SEP'
  STRING = 'STR'

  def __init__(self, type, value, line=0):
    self.type = type
    self.value = value
    self.line = line
    self.size = None

  def __str__(self):
    val = self.value
    if type(val) == int:
      val = f'x{self.value:x}'
    else:
      val = str(val)
      val = val.replace('\n', '\\n')
      if len(val) > 24:
        val = val[:21] + '...'
    out = f'{a.BLUE}{self.type:>4}{a.E}[{a.YELLOW}{val:^24}{a.E}]'
    out = out.replace('imm8', f'{a.ORANGE}imm8{a.YELLOW}')
    out = out.replace('imm16', f'{a.ORANGE}imm16{a.YELLOW}')
    return out

  def __repr__(self):
    return str(self)

class TDirective(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.DIRECTIVE, value, line=line)
    self.args = {}

  def chfile(self):
    fname = self.args.get('filename')
    if self.value == 'include' and fname:
      config.filename = fname

class TExpression(Token):
  def __init__(self, value, rpn=None, opstack=None, line=None):
    super().__init__(Token.EXPRESSION, value, line=line)
    self.rpn = rpn if rpn else []
    self.opstack = opstack if opstack else []
    self._value = None

  @property
  def exprvalue(self):
    if self._value:
      return self._value
    return self.evaluate()

  @exprvalue.setter
  def exprvalue(self, val):
    self._value = val

  def valid(self):
    return self.rpn and not self.opstack and any((isinstance(t, TOperator) for t in self.rpn))

  def evaluate(self, here=None, lblpos=None):
    lblpos = lblpos if lblpos else {}
    rpn = self.rpn[::-1]
    val = []
    while rpn:
      tok = rpn.pop()
      if isinstance(tok, TNumber):
        val.append(tok.value)
      elif isinstance(tok, THere):
        if here:
          val.append(here)
        else:
          error('test.s', self.line, 'Can\'t evaluate current position:', self)
      elif isinstance(tok, TLabelRef):
        if lpos := lblpos.get(tok.value):
          val.append(lpos)
        else:
          error('test.s', self.line, 'Can\'t evaluate label position:', tok)
      elif isinstance(tok, TOperator):
        b = val.pop()
        a = val.pop()

        if tok.value == '|':
          val.append(a | b)
        elif tok.value == '^':
          val.append(a ^ b)
        elif tok.value == '&':
          val.append(a & b)
        elif tok.value == '<<':
          val.append(a << b)
        elif tok.value == '>>':
          val.append(a >> b)
        elif tok.value == '+':
          val.append(a + b)
        elif tok.value == '-':
          val.append(a - b)
        elif tok.value == '*':
          val.append(a * b)
        elif tok.value == '/':
          val.append(a // b)
        elif tok.value == '%':
          val.append(a % b)

    self._value = val[0]
    return val[0]

  @property
  def rpnfmt(self):
    return '[' + ' '.join([str(t.value) for t in self.rpn]) + ']'

class TExprClose(Token):
  def __init__(self, line=None):
    super().__init__(Token.EXPR_CLOSE, ')', line=line)

class TExprOpen(Token):
  def __init__(self, line=None):
    super().__init__(Token.EXPR_OPEN, '(', line=line)

class TFlag(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.FLAG, value, line=line)

class THere(Token):
  def __init__(self, line=None):
    super().__init__(Token.HERE, '$', line=line)
    self.position = None

class TLabel(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.LABEL, value, line=line)

class TLabelRef(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.LABEL_REF, value, line=line)

class TMemClose(Token):
  def __init__(self, line=None):
    super().__init__(Token.MEM_CLOSE, ']', line=line)

class TMemOpen(Token):
  def __init__(self, line=None):
    super().__init__(Token.MEM_OPEN, '[', line=line)

class TMnemonic(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.MNEMONIC, value, line=line)
    self.operands = []

class TNumber(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.NUMBER, value, line=line)

class TOpcode(Token):
  def __init__(self, mnemonic, line=None):
    super().__init__(Token.OPCODE, str(mnemonic), line=line)
    self.mnemonic = mnemonic

  @property
  def opsize(self):
    s = len(self.mnemonic.opcode)
    s += self.mnemonic.schema.count('imm8')
    s += self.mnemonic.schema.count('imm16')

    '''
    if 'imm8' in self.mnemonic.schema:
      s += 1
    elif 'imm16' in self.mnemonic.schema:
      s += 2
    '''

    return s

class TOperator(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.OPERATOR, value, line=line)
    self.precedence = {
      '|': 1,
      '^': 2,
      '&': 3,
      '<<': 4,
      '>>': 4,
      '+': 5,
      '-': 5,
      '*': 6,
      '/': 6,
      '%': 6
    }[value]
    self.associativity = 'left' if value in '|^&<<>>*/%-+' else 'right'

  def __lt__(self, other):
    smaller_precedence = self.precedence < other.precedence
    same_precedence = self.precedence == other.precedence
    left_assoc = self.associativity == 'left'
    return smaller_precedence or (same_precedence and left_assoc)

class TRegister(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.REGISTER, value, line=line)

class TSeparator(Token):
  def __init__(self, value=',', line=None):
    super().__init__(Token.SEPARATOR, value, line=line)

class TString(Token):
  def __init__(self, value, line=None):
    super().__init__(Token.STRING, value, line=line)

    for symbol in tuple('[](),') + tuple(OPERATORS):
      self.value = self.value.replace(f' {symbol} ', f'{symbol}')
