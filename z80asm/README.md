# Zilog Z80 assembler


This is a python implementation of Z80 Assembler. It is not efficient in order
to make code readable and more fixable. There are following steps:

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
* No relative jump sigend operands support
* No `org` directive
* No `def` directive (known as `equ` in other assemblers)
* No unary operators in expressions
* No higher-level abstractions like macros, conditional assembling, etc.
* No `times` directive (well, there's a similar `ds` so not so much of a problem)
* `ds` directive has two mandatory arguments (unlike z80asm in which the second one can be omitted)

But in turn it has a colorful verbose output (if you use `-v` flag)

# Roadmap

* Add relative jump support
* Add `org` directive
* Add unary operators
* Add i8080 mode, mixed mode, strict mode
