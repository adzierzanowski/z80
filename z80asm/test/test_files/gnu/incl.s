ld sp, 0x1000
ei
im 1
jp start

ds 0x38 - $
mint:
  ld ix, int38
  call print_str
  call flush
  ei
  reti

ds 0x66 - $
nmi:
  ld ix, int66
  call print_str
  call flush
  retn

ds 0x100 - $

start:
  ld ix, hello
  call print_str
  call flush
  jp $


hello: db 'Hello', 0
int38: db 'I see you interrupted using INT', 0
int66: db 'Non maskable interrupt', 0


include 'test/test_files/io.s'
