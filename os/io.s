once

include 'definitions.s'

; a <- key
getch:
  in a, [KBDPORT]
  ret

; a -> screen
putch:
  out [SCREENPORT], a
  ret

; [hl] -> screen until 0
prints:
  ld a, [hl]
  cp 0
  jp z prints_ret
  out [SCREENPORT], a
  inc hl
  jp prints
prints_ret:
  ret

; bin(a) -> screen
printb:
  ld b, a
  ld c, 1 << 7
printb_next:
  and c
  jp NZ, printb_1
printb_0:
  ld a, '0'
  jp printb_check
printb_1:
  ld a, '1'
printb_check:
  out [SCREENPORT], a
  srl c
  jp Z, printb_end
  ld a, b
  jp printb_next
printb_end:
  ret

; hl -> screen
printb16:
  ld a, h
  call printb
  ld a, ':'
  out [SCREENPORT], a
  ld a, l
  call printb
  ret

; hex(a) -> screen
printx:
  ld b, a
  ld c, 0
  srl a
  srl a
  srl a
  srl a
  and 0xf
  cp 0xa
  jp m, printx_digit
  jp p, printx_letter
printx_next:
  ld a, b
  and 0xf
  cp 0xa
  jp m, printx_digit
  jp p, printx_letter
printx_digit:
  inc c
  add a, '0'
  out [SCREENPORT], a
  ld a, c
  cp 1
  jp z, printx_next
  jp nz, printx_ret
printx_letter:
  inc c
  sub 0xa
  add a, 'A'
  out [SCREENPORT], a
  ld a, c
  cp 1
  jp z, printx_next
printx_ret:
  ret

; \n -> screen
printnl:
  ld a, 10
  out [0xaa], a
  ret

; [hl] <- string until 0
reads:
  in a, [KBDPORT]
  cp 0
  jp z, reads_ret
  ld [hl], a
  inc hl
  jp reads
reads_ret:
  ld [hl], a
  ret

; a <- 0 if [hl] == [bc]
; a <- index+1 of the first differing char otherwise
strcmp:
  ld d, 0
strcmp_loop:
  inc d
  ld a, [bc]
  cp 0
  jp z, strcmp_bc_end
  cp [hl]
  jp nz, strcmp_different
  inc hl
  inc bc
  jp strcmp_loop
strcmp_bc_end:
  cp [hl]
  jp nz, strcmp_different
strcmp_same:
  ld a, 0
  ret
strcmp_different:
  ld a, d
  ret

; go to (h, l) position on the screen
gotoxy:
  ld a, 27
  call putch
  ld a, h
  call putch
  ld a, l
  call putch
  ret

; eeprom[hl] -> a
eeprom_read:
  ld a, h
  out [EEPROMPORT], a
  ld a, l
  out [EEPROMPORT], a
  in a, [EEPROMPORT]
  ret

; eeprom[hl] <- a
eeprom_write:
  push af
  ld a, h
  out [EEPROMPORT], a
  ld a, l
  out [EEPROMPORT], a
  pop af
  out [EEPROMPORT], a
  ret


; wait for hl cycles
delay:
  ld bc, 0
delay_loop:
  dec hl
  sbc hl, bc
  jp nz, delay_loop
  ret
