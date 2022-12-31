# Zilog Z80 playground

This is a scratchpad repository containing my Z80 sandbox.

## Assembler
The most interesting for other people is most probably **[an assembler](z80asm)**
written in Python.

The assembler is more-than-two-pass assembler to make code more readable than
optimized.

I've also written a 2-pass Z80 assember in C which is much faster.
[Check it out here](https://github.com/adzierzanowski/zasm).

## Z80 Minicomputer

For now the other part of the project consists of:

* a main board with 10 MHz Zilog Z80 CPU and some LEDs,
* a RAM board with two 62256 SRAM chips, 32 kiB of memory each
  and 7-segment displays showing data and address bus state,
* a CLKMOD board acting as a clock and interrupt controller.

Implying the following specs:

```
- Up to 1 MHZ Z80 CPU (because of bottleneck that is CLKMOD which will
                       be replaced with a crystal oscillator)
- 64 kiB SRAM
- No external non-volatile memory
- No IO at the moment
```

At the moment I'm developing the new IO Controller and IO device modules:
* 128x160 TFT display module,
* PS/2 keyboard input module.

In the `legacy/` directory there are some IO controller files which I used
for communicating with the CPU via serial port and low-resolution VGA output.

# Files

* `z80asm` – Python dual-syntax (i8080, Z80) assembler/disassembler module

* `busctl/` – Bus controller (and RAM Uploader)
* `clkmod/` – Clock emulator
* `fontmaker/` – Little HTML/JS utility for creating fonts
* `legacy/` – Old unused controllers
* `lib/` – ASM libraries
* `schematics/` – KiCAD schematics
* `static/` and `templates/` – Flask assets
* `tft` – TFT Display Controller

* `ctl.py` – Flask GUI for the clock emulator
* `prog.py` – Bus controller RAM programming interface
* `serialprompt.py` – Utility for fast testing of serial communication


# Resources

* https://maker.pro/pic/projects/z80-computer-project-part-1-the-cpu
* https://istvannovak.net/2018/01/25/zx-spectrum-ide-part-3-a-brief-overview-of-the-z80a-cpu/
