import serial
import argparse

from serial.tools.list_ports import comports


def parsenum(word):
  try:
    if word.startswith('0b'):
      return int(word[2:], 2)
    elif word.startswith('0o'):
      return int(word[2:], 8)
    elif word.startswith('0x'):
      return int(word[2:], 16)
    else:
      return int(word)
  except ValueError:
    return ord(word[0])


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('-b', '--baudrate', type=int, default=115200)
  parser.add_argument('-p', '--port', type=str)
  args = parser.parse_args()

  port = args.port
  if not port:
    port = comports()[-1].device

  s = serial.Serial(port, args.baudrate)

  print(f'Connected to {port} @ {args.baudrate}')
  try:
    while True:
      try:
        send = input('$ ')
        s.write(bytes([parsenum(send)]))
        print('response:', s.read_all())
      except ValueError:
        print('response:', s.read_all())
      except IndexError:
        print('response:', s.read_all())
  finally:
    s.close()
