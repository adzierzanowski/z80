import Display from "./disp.js";

class Z80Disp extends Display {
  static PINOUT = [
    'A11', 'A12', 'A13', 'A14', 'A15',
    'CLK',
    'D4', 'D3', 'D5', 'D6',
    'VCC',
    'D2', 'D7', 'D0', 'D1',
    'INT', 'NMI', 'HALT', 'MREQ', 'IORQ',
    'RD', 'WR', 'BUSACK', 'WAIT', 'BUSRQ', 'RESET', 'M1', 'REFSH', 'GND',
    'A0', 'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'A10'
  ];

  constructor() {
    super();
    this.pins = [];
  }

  generateDOM() {
    const wrapper = document.createElement('div');
    wrapper.classList.add('z80-display__wrapper');

    const pkg = document.createElement('div');
    pkg.classList.add('z80-display__package');
    const pkgName = document.createTextNode('Zilog Z80');
    pkg.appendChild(pkgName);


    const bottomPins = document.createElement('div');
    bottomPins.classList.add('z80-display__bottom-pins');
    pkg.appendChild(bottomPins);

    const topPins = document.createElement('div');
    topPins.classList.add('z80-display__top-pins');
    pkg.appendChild(topPins);

    for (let i = 0; i < 40; i++) {
      const pin = document.createElement('div');
      pin.classList.add('z80-display__pin');
      pin.classList.add(`z80-display__pin--${i}`);
      const pinNameWrapper = document.createElement('div');
      pinNameWrapper.classList.add('z80-display__pin--name-wrapper');

      const pinName = document.createTextNode(Z80Disp.PINOUT[i]);
      pinNameWrapper.appendChild(pinName);
      pin.appendChild(pinNameWrapper);

      if (i < 20) {
        bottomPins.appendChild(pin);
      } else {
        topPins.prepend(pin);
      }
      this.pins.push(pin);
    }

    wrapper.appendChild(pkg);

    return wrapper;
  }

  setPin(n, val) {
    const i = Number.isInteger(n) ? n : Z80Disp.PINOUT.indexOf(n);

    if (val) {
      this.pins[i].classList.add('on');
    } else {
      this.pins[i].classList.remove('on');
    }
  }

  setAddress(n) {
    for (let i = 0; i < 16; i++) {
      this.setPin(`A${i}`, n & (1 << i));
    }
  }

  setData(n) {
    for (let i = 0; i < 8; i++) {
      this.setPin(`D${i}`, n & (1 << i));
    }
  }
}

export default Z80Disp;
