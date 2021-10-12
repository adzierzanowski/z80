org 0x100

start:
  ds 12

func:
  ds 7, 10
  jp orgchange
  ret

end:
  ld sp, [func]

org 0x200

orgchange:
  jp start
