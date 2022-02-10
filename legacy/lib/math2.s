; hl / a = a_ret * a + d
divide_upper: dw 0
divide:
  push af
  ld a, l
  cp 0
  jp z, divide_check_zero
divide_not_zero:
  pop af
  ccf
  ld [divide_upper], a
  ld a, 0
  ld [(divide_upper + 1)], a
  ld bc, [divide_upper]
  ld d, 0
divide_sub:
  inc d
  sbc hl, bc
  jp c, divide_ret_overflow
  jp z, divide_ret
  jp divide_sub
divide_ret_overflow:
  dec d
  ld bc, [divide_upper]
  adc hl, bc

divide_check_zero:
  ld a, h
  cp 0
  jp z, divide_zero
  jp divide_not_zero

divide_zero:
  pop af
  ld a, 0
  ld d, 0
  ret

divide_ret:
  ld [divide_upper], hl
  ld a, [divide_upper]
  ld e, a
  ld a, d
  ld d, e
  ret

; input: hl
print_dec:
  ld a, 100
  call divide
  add a, '0'
  out [0xaa], a

  push de
  pop hl
  ld a, h
  cp 0
  jp z, print_dec_zero

  ld l, h
  ld h, 0
  ld a, 10

  call divide
  add a, '0'
  out [0xaa], a
  ld a, d
  add a, '0'
  out [0xaa], a
  jp print_dec_ret

print_dec_zero:
  ld a, '0'
  out [0xaa], a
  out [0xaa], a

print_dec_ret:
  ret
