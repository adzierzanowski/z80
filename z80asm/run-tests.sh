#!/usr/bin/env bash

python3 -m unittest test/parser.py
python3 -m unittest test/expr.py
python3 -m unittest test/test.py
#python3 -m unittest test/gnusyntax.py
