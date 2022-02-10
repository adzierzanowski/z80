; hl = delay cycles
delay:
  dec hl
  ld a, l
  cp 0

  jp z, delay_l0

delay_l0:
  ld a, h
  cp 0
  jp nz, delay

delay_ret:
  ret
  
