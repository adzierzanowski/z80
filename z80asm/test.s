org 0x100

start:
  ld sp, 0x1000
  jp start

str: db 'Hello', 10, 0

