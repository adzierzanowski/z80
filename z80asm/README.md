# Zilog Z80 assembler


This is a python implementation of Z80 Assembler. It is not efficient in order
to make code readable and more fixable (yeah, nice try).

It is now largely usable (with some really minor issues). Real programs has been
assembled and run successfully on a real Z80 CPU.

## Installation and usage

Requirements:
* I don't remember if there are any, I will put requirements.txt here later if so

```bash
$ python3 -m pip install .
$ python3 -m z80asm input.s -o output.bin # see --help for more
```

## Syntax

#### Basiscs

Unlike other Z80 assemblers, to use memory pointers you need to use square
brackets instead of parentheses (parentheses are reserved for expressions).
Commas are largely optional.

```asm
start:
  ld a, [0xbeef] ; ld a, (0xbeef) in GNU z80asm
```

If you wish to use Intel 8080 syntax, you can do so using `-i` flag (this will
limit you to 1-byte opcodes only):

```asm
; input.s
start:
  lxi sp, 0x1000
  mvi a, 0b0011_1100

; python3 -m z80asm input.s -io output
```

#### Directives and special labels

```
ds 0x66 - $, 0                  ; define space of size 0x66 filled with zeroes
nmi_handler:
  retn

start:
  jp $                          ; $ = here (before the current instruction, i.e. at start label posiition in this example)

str: db 'Hello, world!', 0      ; define byte(s)
sixteen_bits: dw 0xdead, 0xbeef ; define word(s)

include 'io.s'                  ; include another file
```

#### Expressions

```asm
  ; This will be evaluated properly (better to use more parentheses than less because
  ; the RPN evaluator is not perfect yet) and shows all operators
  ; and all numeric literals available (dec, hex, oct, bin)
  ; The / operator is floor division (just as // in Python)
  ld sp, ((((+start & 0b1111_1111 + -$) | 1 << (1 % 2) * 0o10) ^ ~0x10) >> 4) - (30/2)

ld a, 0xff + 1 ; This will be truncated to 8-bit value because ld a, imm8 expects one byte
```

## Caveats

### Expression evaluation

In some cases you might think that using expressions is not allowed in some
cases, e.g.:

```asm
set 7, [ix + 2*8]
```

But if you add some parentheses, it works.

```asm
set 7, [ix + (~(2*8))]
```

## Inner structure

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
* No `org` directive
* No `def` directive (known as `equ` in other assemblers)
* No `times` directive (well, there's a similar `ds` so not so much of a problem)
* No higher-level abstractions like macros, conditional assembling, etc.

But in turn it has a colorful verbose output (if you use `-v` flag)

# Roadmap

* Add `org` directive
* Consider treating all numbers as expressions, this would probably make code prettier
* Maybe add original parentheses mode (**in progress**)
* Handle escape codes in string literals
