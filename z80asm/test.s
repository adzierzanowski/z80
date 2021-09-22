start:
  jp (dupa + 1) / 2
  jp dupa
  ld a, (7*4/2) & 0xf
  nop
  nop
  nop
dupa:
