ld sp, 0x1400
jp start
ds 0x66 - $, 0
nmi_isr:
  retn
ds 0x100 - $, 0
