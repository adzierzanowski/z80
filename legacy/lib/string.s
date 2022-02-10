
; de = str1
; hl = str2
; return a = 0 if eq
strcmp:
  ld c, 0
strcmp_loop:
  inc c
  ld a, [de]
  cp [hl]
  jp nz, strcmp_unequal
  cp 0
  jp z, strcmp_de_end
  inc de
  inc hl
  jp strcmp_loop

strcmp_de_end:
  ld a, [hl]
  cp 0
  jp z, strcmp_equal

strcmp_unequal:
  ld a, c
  jp strcmp_ret

strcmp_equal:
  ld a, 0

strcmp_ret:
  ret
