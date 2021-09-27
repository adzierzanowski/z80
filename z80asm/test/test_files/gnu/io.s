flush:
  push af
  ld a, 0
  out (0xaa), a
  pop af
  ret

newline:
  push af
  ld a, '\n'
  out (0xaa), a
  pop af
  ret

print_bin:
  ld b, a
  ld c, 1 << 7
print_bin_next:
  and c
  jp NZ, print_bin_1
print_bin_0:
  ld a, '0'
  jp print_bin_check
print_bin_1:
  ld a, '1'
print_bin_check:
  out (0xaa), a
  srl c
  jp Z, print_bin_end
  ld a, b
  jp print_bin_next
print_bin_end:
  ret

; ix = src
print_str:
  ld b, (ix+0)
  ld a, b
  sub 0
  jp Z, print_str_done

  ld a, b
  out (0xaa), a
  inc ix
  jp print_str
print_str_done:
  ret

; ix = dst
; return: c = number of characters read
read_str:
  ld c, 0
read_str_loop:
  in a, (0xaa)
  cp 0
  jp z, read_str_end
  ld (ix + 0), a
  inc ix
  inc c
  jp read_str_loop
read_str_end:
  ld (ix + 0), 0
  ret
