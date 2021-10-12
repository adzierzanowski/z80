ld sp, 0x1400
jp start

ds 0x66 - $
nmi:
  retn
ds 0x100 - $


start:
  call vcls
  ld ix, msg
  call vprint_str

cmdloop:
  call getcmd

  ld de, 0x400
  ld hl, cmd_print
  call strcmp
  cp 7
  call z, cmd_print_handler

  ld de, 0x400
  ld hl, cmd_clear
  call strcmp
  cp 0
  call z, vcls

  ld de, 0x400
  ld hl, cmd_regs
  call strcmp
  cp 0
  call z, cmd_regs_handler

  ld de, 0x400
  ld hl, cmd_reset
  call strcmp
  cp 0
  jp z, start

  ld de, 0x400
  ld hl, cmd_stack
  call strcmp
  cp 0
  call z, cmd_stack_handler

  jp cmdloop

cmd_stack_handler:
  call vnewline
  ld [0x400], sp
  ld a, [0x401]
  call vprint_bin
  ld a, ':'
  out [0x76], a
  ld a, [0x400]
  call vprint_bin
  ret

cmd_regs_handler:
  call vnewline
  ex af, af'
  exx
  ld a, 'A'
  out [0x76], a
  ex af, af'
  call vprint_bin
  call vnewline

  ld a, 'B'
  out [0x76], a
  exx
  ld a, b
  exx
  call vprint_bin
  call vnewline

  ld a, 'C'
  out [0x76], a
  exx
  ld a, c
  exx
  call vprint_bin
  call vnewline

  ld a, 'D'
  out [0x76], a
  exx
  ld a, d
  exx
  call vprint_bin
  call vnewline

  ld a, 'E'
  out [0x76], a
  exx
  ld a, e
  exx
  call vprint_bin
  call vnewline


  ld a, 'H'
  out [0x76], a
  exx
  ld a, h
  exx
  call vprint_bin
  call vnewline
  ret

cmd_print_handler:
  call vnewline
  ld ix, 0x406
  call vprint_str
  ret

getcmd:
  ld ix, prompt
  call vprint_str
  halt

  ld ix, 0x400
  call read_str

  ld ix, 0x400
  call vprint_str
  call newline
  ret

include 'io.s'
include 'vga.s'
include 'string.s'

msg: db 'sensik corp. sz80 (c) 2021', 10, 0
prompt: db 10, '$ ', 0

cmd_print: db 'print ', 0
cmd_clear: db 'clear', 0
cmd_regs: db 'regs', 0
cmd_reset: db 'reset', 0
cmd_stack: db 'stack', 0
