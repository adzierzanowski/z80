ld sp, 0x1400
jp start_

ds 0x66 - $
nmi:
  retn
ds 0x100 - $

start_:
  call cls
start:
  in a, [0xaa]
  cp 0
  ;call nz, pchar
  jp z, start
  call nz, wch
  cp 10
  call z, cls
  cp 11
  call z, enter
  cp 0x84
  call z, goto205
  jp start

goto205:
  ld bc, 0x1405
  call gotoxy
  ret

pchar:
  push af
  call print_bin
  call newline
  call flush
  pop af
  ret 

enter:
  ld a, 10
  out [0x76], a
  ret

cls:
  ld a, 13
  out [0x76], a
  ret

wch:
  out [0x76], a
  ret

; b = x, c = y
gotoxy:
  ld a, 27
  out [0x76], a
  ld a, b
  out [0x76], a
  ld a, c
  out [0x76], a
  ret

include 'lib/io.s'
  