import sys
import serial

with open(sys.argv[2], 'rb') as f:
  data = f.read()

s = serial.Serial(sys.argv[1], 921600)

def wait_for(str):
  buf = b''
  str = str.encode('ascii')
  while True:
    buf += s.read()
    if str in buf:
      return

s.write(b'bus acq ')
buf = b''
wait_for('acquired')

s.write(b'max init ')

with open(sys.argv[2], 'rb') as f:
  data = f.read()

for i, byte in enumerate(data):
  s.write(b'write addr ' + (hex(i)[2:]).encode('ascii') + b' ')
  wait_for('ok')
  s.write(b'write data ' + (hex(byte)[2:]).encode('ascii') + b' ')
  wait_for('ok')
  s.write(b'mq ')
  wait_for('ok')
  s.write(b'wr ')
  wait_for('ok')
  s.write(b'wr ')
  wait_for('ok')
  s.write(b'mq ')
  wait_for('ok')

s.write(b'max off ')
wait_for('ok')
s.write(b'bus rel ')
wait_for('ok')
s.write(b'reset ')
wait_for('ok')
