include 'start.s'


start:
  call flush
  halt
  ld a, 0
stlp:
  inc a
  push af
  call print_bin
  call flush
  pop af
  jp stlp

include 'io.s'
