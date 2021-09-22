jp start
ds 0x66 - $
nmi:
  retn
ds 0x100 - $

start:
  ld ix, name
  call print_str
  call flush
  halt

  ld ix, 0x400
  call read_str

  ld a, c
  call print_bin
  call flush

  ld ix, 0x400
  call print_str
  call flush

  halt
  jp start


name: db 'Say your name:', 0

include 'io.s'
