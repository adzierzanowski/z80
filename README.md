# Zilog Z80 playground

This is a scratchpad repository containing a [an assembler](z80asm) written in
Python, some utilities to control my Z80 CPU and RAM and clock emulation
for Arduino Mega. This is until I get a real SRAM chip.

For now the project consists of a main board with Z80 CPU and some LEDs,
a 5kiB Arduino Mega RAM emulator which can load programs dynamically and
contains some IO buffers to communicate with the CPU. There's also another
Arduino Mega which controls the CPU (clock, interrupts, some little parts of IO
handling).

The assembler is more-than-two-pass assembler to make code more readable than
optimized.

I hope that in the future this will get more professional.

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
* `serialprompt.py` – Bus controller RAM programming interface


# Resources

* https://maker.pro/pic/projects/z80-computer-project-part-1-the-cpu
* https://istvannovak.net/2018/01/25/zx-spectrum-ide-part-3-a-brief-overview-of-the-z80a-cpu/
