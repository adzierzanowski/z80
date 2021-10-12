from flask import Flask, render_template, request
import time
from dotenv import dotenv_values
from serial import Serial
import threading
from io import StringIO
import subprocess

class InbufThread(threading.Thread):
  def __init__(self, clks, inbuf):
      super().__init__()
      self.clks = clks
      self.inbuf = inbuf
      self.stop = False

  def run(self):
    while not self.stop:
      if self.clks.in_waiting:
        try:
          text = self.clks.read_all().decode('utf-8').replace('\r', '')
        except UnicodeDecodeError:
          text = str(text)[2:-1]

        self.inbuf.write(text)

      time.sleep(0.5)

env = dotenv_values()
clkport = env.get('CLKPORT')
memport = env.get('MEMPORT')
clks = Serial(clkport, 115200)
inbuffer = StringIO('')
inbuf_th = InbufThread(clks, inbuffer)
inbuf_th.start()

app = Flask(__name__)

@app.route('/')
def home():
  return render_template('home.html')

@app.route('/ctl')
def ctl():
  global inbuffer
  cmd = request.args['cmd']
  arg = request.args.get('arg', '')

  if arg == 'undefined':
    arg = ''

  if cmd == 'tick':
    clks.write(b't\n')
  elif cmd == 'reset':
    clks.write(b'r\n')
  elif cmd == 'run':
    clks.write(b'h\n')
  elif cmd == 'ms':
    clks.write(b'm\n')
  elif cmd == 'us':
    clks.write(b'u\n')
  elif cmd == 'nmi':
    clks.write(b'n\n')
    if arg:
      clks.write(b't' + arg.encode('ascii') + b'\n')
  elif cmd == 'irq':
    clks.write(b'i\n')
  elif cmd == 'stop':
    clks.write(b's\n')
  elif cmd == 'speed':
    clks.write(b'c' + arg.encode('ascii') + b'\n')
  elif cmd == 'write':
    try:
      c = bytes([int(arg)])
    except:
      c = arg.encode('ascii')
    clks.write(b'w' + c + b'\n')
  elif cmd == 'continue':
    clks.write(b'n\n')
    time.sleep(0.1)
    clks.write(b't3\n')
    time.sleep(0.1)
    clks.write(b'h\n')
  elif cmd == 'clear':
    inbuffer = StringIO('')
    inbuf_th.inbuf = inbuffer

  return request.path

@app.route('/inbuf')
def inbuf():
  val = inbuffer.getvalue()
  return val

@app.route('/assemble', methods=['POST'])
def assemble():
  if request.method == 'POST':
    src = request.data

    with open('test.s', 'w') as f:
      f.write(src.decode('utf-8'))

    retcode = subprocess.call(('python3', '-m', 'z80asm', 'test.s', '-o', 'test'))
    if retcode:
      return 'assembly failed'
    out = subprocess.check_output(('python3', '-m', 'z80asm', '-d', 'test'))
    return out

@app.route('/upload')
def upload():
  subprocess.call(('python3', 'prog.py', memport, 'test'))
  return 'ok'

if __name__ == '__main__':
  app.run()
