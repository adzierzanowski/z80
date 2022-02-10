from select import kevent
import serial
import sys
import time



with open(sys.argv[2], 'rb') as f:
  data = f.read()

s = serial.Serial(sys.argv[1], 115200)

def upload():
  s.write(b'p')
  s.read_all()

  global data
  data = data

  c = s.read()
  while not c == b'r':
    c = s.read()

  print('ready')

  total = len(data)
  for i, c in enumerate(data):
    b = bytes([c])
    s.write(b)
    q = b'\x100'
    while not int(c^0xff) == int.from_bytes(q, byteorder='little'):
      #print(c, c^0xff,'==?', int.from_bytes(q, byteorder='little'))
      q = s.read()
    #print('ok',c, c^0xff, '==', int.from_bytes(q, byteorder='little'))
    print(f'\r{i}/{total} {i/total*100:0.2f}%', end='')
  print('done')

  s.write(b'\xdd\x64')

  time.sleep(1)


upload()
