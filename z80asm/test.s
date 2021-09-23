start:
  nop
  ld bc, start
  ld (bc), a
  call func

func:
  ld a, 0x0f
  add a, 40
  ld (0xbeef), hl
  ret pe
  add a, (hl)
.ds 0x10, 0xaa

hello:
  .db 0 1 2 3

world:
  .dw 0xdead 0xbeef

jp $
