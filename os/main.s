include 'definitions.s'


ld sp, STACKEND
jp _os_main

ds IRQ_OFFSET - $
sys:
  ret

ds NMI_OFFSET - $
_os_nmi:
  retn

ds START_OFFSET - $

_os_main:
  ld hl, msg
  call prints

_os_prompt:
  ld hl, prompt
  call prints

_os_prompt_input:
  ld hl, KBDBUF
_os_read_until_return:
  call getch
  cp 11
  jp z, _os_read_until_return_done
  cp 0
  jp nz, _os_read_until_return_store_char
  jp _os_read_until_return
_os_read_until_return_store_char:
  cp KBDPORT
  jp z, _os_read_until_return
  ld [hl], a
  inc hl
  call putch
  jp _os_read_until_return
_os_read_until_return_done:
  ld [hl], 0
  ld a, 10
  out [0xaa], a
  ld hl, KBDBUF

  ld bc, _os_uname_str
  call strcmp
  cp 0
  call z, _os_uname_cmd

  ld bc, _os_clear_str
  call strcmp
  cp 0
  call z, _os_clear_cmd

  ld bc, _os_stack_str
  call strcmp
  cp 0
  call z, _os_stack_cmd

  ld bc, _os_test_str
  call strcmp
  cp 0
  call z, _os_test_cmd

  ld bc, _os_help_str
  call strcmp
  cp 0
  call z, _os_help_cmd

  ld bc, _os_vi_str
  call strcmp
  cp 0
  call z, vi_main

  jp _os_prompt
  SYSCALL

  halt


_os_uname_cmd:
  ld hl, _os_uname_out
  call prints
  call _os_stack_cmd
  ret

_os_clear_cmd:
  ld a, 13
  call putch
  ret

_os_stack_cmd:
  ld hl, 0
  add hl, sp
  ld a, h
  call printx
  ld a, l
  call printx
  call printnl
  ret

_os_test_cmd:
  ld a, 0
_os_test_cmd_loop:
  push af
  call printx
  ld a, ' '
  call putch
  pop af
  inc a
  cp 20
  jp nz, _os_test_cmd_loop
  call printnl


  ld hl, 0x1004
  ld a, 0xaa
  call eeprom_write
  ld a, 10
  call putch


  ld hl, 0x100
  call delay


  ld hl, 0x1004
  call eeprom_read
  call printb
  ret

_os_help_cmd:
  ld hl, _os_clear_str
  call prints
  call printnl

  inc hl
  call prints
  call printnl

  inc hl
  call prints
  call printnl

  inc hl
  call prints
  call printnl

  inc hl
  call prints
  call printnl

  ret

include 'io.s'
include 'vi.s'

msg: db 13, 'uZ8021 microcomputer', 10, 0
prompt: db '$ ', 0
_os_clear_str: db 'clear', 0
_os_help_str: db 'help', 0
_os_stack_str: db 'stack', 0
_os_test_str: db 'test', 0
_os_uname_str: db 'uname', 0
_os_vi_str: db 'vi', 0
_os_uname_out: db 'uZ80 OS', 10, 'v.0.0.1 (C) 2021', 10, 0
