from setuptools import setup


with open('README.md', 'r') as f:
  long_description = f.read()

setup(
  name='z80asm',
  version='0.1.0',
  description='Zilog Z80 assembler and disassembler',
  long_description=long_description,
  long_description_content_type='text/markdown',
  url='https://github.com/adzierzanowski/z80',
  author='Aleksander Dzierżanowski',
  author_email='a.dzierzanowski1@gmail.com',
  license='MIT',
  packages=['z80asm'],
  include_package_data=True,
  install_requires=['pyyaml'],
  entry_points={
  },
  classifiers=[
  ],
  zip_safe=False
)
