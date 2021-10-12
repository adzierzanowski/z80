ld sp, 0x1400
jp start
ds 0x66 - $, 0
nmi:
  retn
ds 0x100 - $, 0

start:
  ld hl, 56
  ld bc, 56
  ld d, 0
  ccf
  sbc hl, bc
  inc d
  sbc hl, bc
  inc d
  adc hl, bc
  ld a, h
  call print_bin
  ld a, ' '
  out [0xaa], a
  ld a, l
  call print_bin
  ld a, ' '
  out [0xaa], a
  ld a, d
  call print_bin
  call flush
  halt






  ld ix, msg0
  call print_str
  ld hl, 0
  ld a, 56
  call divandprint

  ld ix, msg1
  call print_str
  ld hl, 1
  ld a, 56
  call divandprint

  ld ix, msg56
  call print_str
  ld hl, 56
  ld a, 56
  call divandprint

  ld ix, msg57
  call print_str
  ld hl, 57
  ld a, 56
  call divandprint

  ld ix, msg112
  call print_str
  ld hl, 112
  ld a, 56
  call divandprint

  ld ix, msg199
  call print_str
  ld hl, 199
  ld a, 56
  call divandprint

  halt
  jp start

divandprint:
  call divide
  push de
  call print_bin
  ld a, '%'
  out [0xaa], a
  pop de
  ld a, d
  call print_bin
  call flush
  ret

include 'math.s'
include 'io.s'

msg0:   db '0/56   = ', 0
msg1:   db '1/56   = ', 0
msg56:  db '56/56  = ', 0
msg57:  db '57/56  = ', 0
msg112: db '112/56 = ', 0
msg199: db '199/56 = ', 0
