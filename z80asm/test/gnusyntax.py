from unittest import TestCase
from .test import mktmp, rm, rmtmp

class TestGNUSyntaxMode(TestCase):
  def tearDown(self) -> None:
    rmtmp()

  def _test_file(self, fname):
    mktmp(fname, samefile=True)
    with open('tmp_z.ds', 'r') as z:
      z_lines = z.read().splitlines()
      with open('tmp_py.ds', 'r') as py:
        py_lines = py.read().splitlines()

        for i, line in enumerate(py_lines):
          if line.startswith(';'):
            continue
          print(f'{line:40} {z_lines[i]:40}')
          self.assertEqual(line, z_lines[i])

  def test_io(self):
    self._test_file('io.s')

  def test_math(self):
    self._test_file('math.s')

  def test_include(self):
    self._test_file('incl.s')

  def test_expr(self):
    self._test_file('expr.s')

  def test_multi_include(self):
    self._test_file('test4.s')

  def test_relative_jumps(self):
    self._test_file('reljmp.s')
