flush:
  push af           ; 1 1
  ld a, 0           ; 2 3
  out [0xaa], a     ; 2 5
  pop af            ; 1 6
  ret               ; 1 7

newline:
  push af           ; 1 8
  ld a, 10          ; 2 10
  out [0xaa], a     ; 2 12
  pop af            ; 1 13
  ret               ; 1 14

print_bin:          ; 000e
  ld b, a           ; 1 15
  ld c, 1 << 7      ; 2 17
print_bin_next:     ; 0011
  and c             ; 1 18
  jp NZ, print_bin_1; 3 21
print_bin_0:        ; 0015
  ld a, '0'         ; 2 23
  jp print_bin_check; 3 25
print_bin_1:        ; 0019
  ld a, '1'
print_bin_check:
  out [0xaa], a
  srl c
  jp Z, print_bin_end
  ld a, b
  jp print_bin_next
print_bin_end:
  ret

; ix = src
print_str:
  ld b, [ix+0]
  ld a, b
  sub 0
  jp Z, print_str_done

  ld a, b
  out [0xaa], a
  inc ix
  jp print_str
print_str_done:
  ret

; ix = dst
; return: c = number of characters read
read_str:
  ld c, 0
read_str_loop:
  in a, [0xaa]
  cp 0
  jp z, read_str_end
  ld [ix + 0], a
  inc ix
  inc c
  jp read_str_loop
read_str_end:
  ld [ix + 0], 0
  ret
