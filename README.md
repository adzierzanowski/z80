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
* `clkmod` – Clock emulator
* `mememu` – RAM emulator
* `ctl.py` – little GUI for controlling the emulators (ports used are in `.env`)
* `ctl2.py` – as above but as a Flask app
* `prog.py` – binary uploader for the RAM emulator
* `io.s` – an IO library with a fixed address of IO port (`0xaa`) used in emulators

# Resources

* https://maker.pro/pic/projects/z80-computer-project-part-1-the-cpu
* https://istvannovak.net/2018/01/25/zx-spectrum-ide-part-3-a-brief-overview-of-the-z80a-cpu/
