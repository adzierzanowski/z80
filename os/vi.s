include 'io.s'

def XPOS 0x8000
def YPOS 0x8001
def MODE 0x8002
def MODE_NORMAL 0
def MODE_INSERT 1
def BUF 0x8010

vi_main:
  ld hl, XPOS
  ld [hl], 0
  ld hl, YPOS
  ld [hl], 0
  ld hl, YPOS
  ld [hl], 0

  call vi_init_scr
  call vi_show_cursor
  call vi_show_mode

vi_mainloop:
  call vi_getkey
  jp vi_mainloop
  ret

vi_init_scr:
  ld a, 13
  call putch
  ld c, 10
vi_init_scr_loop:
  ld a, '~'
  call putch
  call printnl

  dec c
  ld a, c
  jp nz, vi_init_scr_loop
  ret


vi_show_cursor:
  ld hl, XPOS
  ld a, [hl]
  push af
  ld hl, YPOS
  ld a, [hl]
  ld l, a
  pop af
  ld h, a
  call gotoxy

  ld a, '_'
  call putch
  ret

vi_show_mode:
  ld hl, 0x000f
  call gotoxy

  ld hl, vi_normal_str
  call prints
  ret

vi_getkey:
  call getch
  cp 'j'
  jp z, vi_move_down
  ret

vi_move_down:
  ld hl, YPOS
  ld a, [hl]
  inc a
  ld [hl], a
  call vi_init_scr
  call vi_show_cursor
  call vi_show_mode
  ret

vi_hello: db 'VI, uZ8021 VERSION', 0
vi_normal_str: db '-- NORMAL --', 0
