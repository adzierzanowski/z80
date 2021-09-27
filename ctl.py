import os
import tkinter as tk
import time
from tkinter import ttk
import dotenv
import serial
import threading
import subprocess
from tkinter.scrolledtext import ScrolledText


dotenv.load_dotenv()
clkport = os.environ.get('CLKPORT')
memport = os.environ.get('MEMPORT')


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

        self.inbuf.insert(tk.END, f'{text}')
        self.inbuf.see('end')
      time.sleep(0.5)

class GUI:
  def __init__(self, root):
    self.root = root
    self.clks = serial.Serial(clkport, 115200)
    self.inbuf = tk.StringVar()

    self.create_clock_panel()
    self.create_control_panel()
    self.create_program_panel()
    #self.create_bindings()
    self.clock_panel.grid(row=0, column=0, sticky='we')
    ttk.Label().grid(row=1, column=0)
    self.control_panel.grid(row=2, column=0, sticky='we')
    ttk.Label().grid(row=3, column=0)
    self.program_panel.grid(row=4, column=0, sticky='we')

    self.outbuf_entry = ttk.Entry()
    self.outbuf_entry.grid(row=5,column=0, sticky='we')
    self.outbuf_btn = ttk.Button(text='Send', command=self.send)
    self.outbuf_btn.grid(row=5, column=1, sticky='we')


    self.inbuf_label = ScrolledText(font=('Courier', ))
    self.inbuf_label.grid(row=6, column=0, sticky='we')

    self.inbuf_clr_btn = ttk.Button(text='Clear', command=self.clear_inbuf)
    self.inbuf_clr_btn.grid(row=5, column=2, sticky='we')
    self.inbuf_thread = InbufThread(self.clks, self.inbuf_label)
    self.root.protocol('WM_DELETE_WINDOW', self.on_close)
    self.inbuf_thread.start()


  def create_bindings(self):
    self.root.bind('t', self.tick)
    self.root.bind('u', self.upload)
    self.root.bind('r', self.reset)
    self.root.bind('n', self.nmi)
    self.root.bind('h', self.until_halt)
    self.root.bind('s', self.stop)
    self.root.bind('c', self.clear_inbuf)

  def clear_inbuf(self, *a):
    self.inbuf_label.delete('1.0', tk.END)

  def send(self, *a):
    self.clks.write(b'w' + self.outbuf_entry.get().encode('ascii') + b'\n')

  def read_inbuf(self):
    while True:
      if self.clks.in_waiting:
        try:
          text = self.clks.read_all().decode('utf-8').replace('\r', '')
        except UnicodeDecodeError:
          text = str(text)[2:-1]

        self.inbuf_label.insert(tk.END, f'{text}')

  def create_clock_panel(self):
    self.clock_panel = ttk.Frame()
    self.clock_label = ttk.Label(self.clock_panel, text='Clock')

    self.tick_btn = ttk.Button(self.clock_panel, text='Tick', command=self.tick)
    self.tickcnt_entry = ttk.Entry(self.clock_panel)
    self.speed_entry = ttk.Entry(self.clock_panel)
    self.speed_btn = ttk.Button(self.clock_panel, text='Set Speed', command=self.set_speed)
    self.use_ms_btn = ttk.Button(self.clock_panel, text='ms', command=self.use_ms)
    self.use_us_btn = ttk.Button(self.clock_panel, text='μs', command=self.use_us)

    self.clock_panel.grid(row=0, column=0)
    self.clock_label.grid(row=0, column=0, sticky='we', columnspan=2)
    self.use_ms_btn.grid(row=0, column=1, sticky='we')
    self.use_us_btn.grid(row=0, column=2, sticky='we')
    self.speed_entry.grid(row=1, column=0, sticky='we')
    self.speed_btn.grid(row=1, column=1, sticky='we')
    self.tickcnt_entry.grid(row=1, column=2, sticky='we')
    self.tick_btn.grid(row=1, column=3, sticky='we')

    self.tickcnt_entry.insert(0, '1')
    self.speed_entry.insert(0, '100')

  def create_control_panel(self):
    self.control_panel = ttk.Frame()
    self.control_label = ttk.Label(self.control_panel, text='Control', justify='center')

    self.reset_btn = ttk.Button(self.control_panel, text='Reset', command=self.reset)
    self.until_halt_btn = ttk.Button(self.control_panel, text='Run until HALT', command=self.until_halt)
    self.stop_btn = ttk.Button(self.control_panel, text='Stop', command=self.stop)
    self.nmi_continue_btn = ttk.Button(self.control_panel, text='Continue', command=self.continue_)
    self.nmi_btn = ttk.Button(self.control_panel, text='NMI', command=self.nmi)
    self.nmi_skip_btn = ttk.Button(self.control_panel, text='NMI + 3 ticks', command=self.nmi_skip)
    self.int_label = ttk.Label(self.control_panel, text='Interrupts')
    self.int_btn = ttk.Button(self.control_panel, text='INT', command=self.int)

    self.control_label.grid(row=0, column=0, sticky='we')
    self.reset_btn.grid(row=1, column=0, sticky='we')
    self.until_halt_btn.grid(row=1, column=1, sticky='we')
    self.stop_btn.grid(row=1, column=2, sticky='we')
    self.nmi_continue_btn.grid(row=1, column=3, sticky='we')
    self.int_label.grid(row=2, column=0, sticky='we')
    self.nmi_btn.grid(row=2, column=1, sticky='we')
    self.nmi_skip_btn.grid(row=2, column=2, sticky='we')
    self.int_btn.grid(row=3, column=1, sticky='we')

  def create_program_panel(self):
    self.program_panel = ttk.Frame()
    self.program_label = ttk.Label(self.program_panel, text='Program')

    self.program_entry = ttk.Entry(self.program_panel)
    self.upload_btn = ttk.Button(self.program_panel, text='Upload', command=self.upload)

    self.program_label.grid(row=0, column=0, sticky='we')
    self.program_entry.grid(row=1, column=0, sticky='we')
    self.upload_btn.grid(row=1, column=1, sticky='we')

    self.program_entry.insert(0, 'test.s')

  def on_close(self, *a):
    print('Waiting for InbufThread')
    self.inbuf_thread.stop = True
    self.inbuf_thread.join()
    print('Closing serial connection')
    self.clks.close()
    print('Destroying window')
    self.root.destroy()

  def tick(self, *a):
    n = self.tickcnt_entry.get().encode('ascii')
    self.clks.write(b't' + n + b'\n')

  def nmi(self, *a):
    self.clks.write(b'n\n')

  def continue_(self, *a):
    self.clks.write(b'n\n')
    time.sleep(0.2)
    self.clks.write(b't4\n')
    time.sleep(0.2)
    self.clks.write(b'h\n')

  def int(self, *a):
    self.clks.write(b'i\n')

  def nmi_skip(self, *a):
    self.clks.write(b'n\n')
    self.clks.write(b't3\n')

  def until_halt(self, *a):
    self.clks.write(b'h\n')

  def stop(self, *a):
    self.clks.write(b's\n')

  def reset(self, *a):
    self.clks.write(b'r\n')

  def use_ms(self, *a):
    self.clks.write(b'm\n')

  def use_us(self, *a):
    self.clks.write(b'u\n')

  def set_speed(self, *a):
    n = self.speed_entry.get()
    self.clks.write(b'c' + n.encode('ascii') + b'\n')

  def upload(self, *a):
    th = threading.Thread(target=self._up)
    th.start()

  def _up(self):
    progname = self.program_entry.get()
    #subprocess.call(('z80asm', progname, '-o', 'test'))
    subprocess.call(('python3', '-m', 'z80asm', progname, '-vo', 'test'))

    subprocess.call(('python3', 'prog.py', memport, 'test'))

root = tk.Tk()
gui = GUI(root)
root.mainloop()
