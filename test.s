ld sp, 0xffff
nop
jp start

ds 0x66 - $
nmi:
  retn
ds 0x100 - $

start:
  db 0xff
  jp start

