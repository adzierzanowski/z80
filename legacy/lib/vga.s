vcls:
  ld a, 13
  out [0x76], a
  ret

vnewline:
  push af           ; 1 8
  ld a, ' '
  out [0x76], a
  ld a, 10          ; 2 10
  out [0x76], a     ; 2 12
  pop af            ; 1 13
  ret               ; 1 14

vprint_bin:          ; 000e
  ld b, a           ; 1 15
  ld c, 1 << 7      ; 2 17
vprint_bin_next:     ; 0011
  and c             ; 1 18
  jp NZ, vprint_bin_1; 3 21
vprint_bin_0:        ; 0015
  ld a, '0'         ; 2 23
  jp vprint_bin_check; 3 25
vprint_bin_1:        ; 0019
  ld a, '1'
vprint_bin_check:
  out [0x76], a
  srl c
  jp Z, vprint_bin_end
  ld a, b
  jp vprint_bin_next
vprint_bin_end:
  ret

; ix = src
vprint_str:
  ld b, [ix+0]
  ld a, b
  sub 0
  jp Z, vprint_str_done

  ld a, b
  out [0x76], a
  inc ix
  jp vprint_str
vprint_str_done:
  ret
