; test.s adjusted to GNU z80asm syntax
jp start
ds 0x66 - $, 0
nmi:
  retn
ds 0x100 - $, 0


start:
  nop
  ld bc, start
  ld (bc), a
  call func

func:
  ld a, 0x0f
  add a, 40
  ld (0xbeef), hl
  ret
  ret pe
  add a, (hl)
  ld a, 300-200
  ld a, (4+$)*(8 - 1 + func)
  jp 2+2*2
  jp 2+(2*2)
  jp (2+2)*2
  jp 3*0xffff

hello:
  db 0, 1, 2, 3

world:
  dw 0xdead, 0xbeef

jp $

str1: db 'Hello world', 0
