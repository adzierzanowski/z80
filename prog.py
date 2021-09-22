from select import kevent
import serial
import sys
import time



with open(sys.argv[2], 'rb') as f:
  data = f.read()

s = serial.Serial(sys.argv[1], 115200)

def upload():
  buf = b''
  while not b'READY' in buf:
    buf += s.read_all()

  s.write(b'prog\n')
  print(s.read_all())

  while True:
    buf += s.read_all()
    if b'Ready' in buf:
      break

  print('Writing binary')
  s.write(data)
  print(s.read_all())

  s.write(b'\xed\x7f')

  print('Waiting for Done')
  while True:

    buf += s.read_all()
    if b'Done' in buf:
      break


upload()
