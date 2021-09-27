; hl / a
; ret a = result, d = remainder
divide:
  ; mov bc, a
  push af
  pop bc
  ld c, b
  ld b, 0
  ld d, 0
  ccf
divide_sub:
  sbc hl, bc
  inc d
  jp nc, divide_sub

  dec d
  adc hl, bc

divide_ret:
  ld a, d
  ld d, l
  ret

; 0/56   = 0%0
; 1/56   = 0%1
; 56/56  = 0%56
; 57/56  = 1%0
; 112/56 = 1%56
; 199/56 = 3%31

; 00000000 00111000 HL
; 00000000 00111000 BC
;                 0 CF

; 00000000 00000000 HL
; 00000000 00111000 BC
;                 0 CF
