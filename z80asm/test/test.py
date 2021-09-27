import os
from unittest import TestCase
from z80asm.token import *
import subprocess


def rm(fname):
  if os.path.exists(fname):
    os.remove(fname)

def rmtmp():
  rm('tmp_py')
  rm('tmp_z')
  rm('tmp_py.ds')
  rm('tmp_z.ds')

def mktmp(fname, samefile=False):
  f2 = os.path.join('test', 'test_files', 'gnu', fname)
  if samefile:
    f1 = f2
  else:
    f1 = os.path.join('test', 'test_files', 'py', fname)

  if samefile:
    subprocess.call(('python3', '-m', 'z80asm', '--addr-deref-parentheses', f1, '-o', 'tmp_py'))
  else:
    subprocess.call(('python3', '-m', 'z80asm', f1, '-o', 'tmp_py'))
  subprocess.call(('z80asm', '-I', 'test/test_files/gnu', f2, '-o', 'tmp_z'))
  subprocess.call(('z80dasm', 'tmp_z', '-o', 'tmp_z.ds'))
  subprocess.call(('z80dasm', 'tmp_py', '-o', 'tmp_py.ds'))

class TestOpcodes(TestCase):
  def setUp(self):
    return super().setUp()

  def tearDown(self):
    return super().tearDown()

class TestAgainstGNU(TestCase):
  def tearDown(self):
    rmtmp()

  def _test_file(self, fname):
    mktmp(fname)
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
