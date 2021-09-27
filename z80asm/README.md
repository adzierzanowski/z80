# Zilog Z80 assembler


This is a python implementation of Z80 Assembler. It is not efficient in order
to make code readable and more fixable (yeah, nice try).
There are following steps:

1. Source preparation (finding labels and includes using regexes, replacing strings with anchors, etc.)
2. Tokenization
3. Parsing numerical expressions
4. Parsing opcodes
5. Evaluating size and positions
6. Assembling the whole thing and emitting bytecode

So it's ca. 6-pass assembler. Not very impressive.

The syntax is pretty similar to GNU z80asm but the memory-access parentheses
are replaced with square brackets as in NASM. The expressions like `0x100 - $`
can use `()`.

It has the following shortcomings (which I wish to improve):
* `jr` behaves differently from other assemblers (it directly outputs the argument as operand instead of operand = argument - 2)
* No `org` directive
* No `def` directive (known as `equ` in other assemblers)
* No higher-level abstractions like macros, conditional assembling, etc.
* No `times` directive (well, there's a similar `ds` so not so much of a problem)
* `ds` directive has two mandatory arguments (unlike z80asm in which the second one can be omitted)

But in turn it has a colorful verbose output (if you use `-v` flag)

# Roadmap

* Add `org` directive
* Consider moving treating all numbers as expressions, this would probably make code prettier
* Maybe add original parentheses mode

# Caveats

In some cases you might think that using expressions is not allowed in some
cases, e.g.:

```asm
set 7, [ix + 2*8]
```

But if you add some parentheses, it works.

```asm
set 7, [ix + (~(2*8))]
```
