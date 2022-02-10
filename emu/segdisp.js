import Display from "./disp.js";


class SegmentDisplay extends Display {
  static DIGITS = [
    0b01111110,
    0b00110000,
    0b01101101,
    0b01111001,
    0b00110011,
    0b01011011,
    0b01011111,
    0b01110000,
    0b01111111,
    0b01111011,
    0b01110111,
    0b00011111,
    0b01001110,
    0b00111101,
    0b01001111,
    0b01000111
  ];

  constructor(count) {
    super();

    this.count = count;
    this.mounted = false;
    this.displays = [];
  };

  generateDOM() {
    const wrapper = document.createElement('div');
    wrapper.classList.add('segdisp-wrapper');

    for (let i = 0; i < this.count; i++) {
      const disp = document.createElement('div');
      disp.classList.add('segdisp');

      for (let j = 0; j < 8; j++) {
        const segment = document.createElement('div');
        segment.classList.add('segdisp__segment');
        segment.classList.add(`segdisp__segment--${j}`);
        disp.appendChild(segment);
      }
      this.displays.push(disp);
      wrapper.appendChild(disp);
    }

    return wrapper;
  }

  setSegments(disp, val) {
    if (!this.mounted) return;
    if (disp >= this.count) return;

    for (let i = 0; i < 8; i++) {
      const seg = this.displays[disp].querySelector(`.segdisp__segment--${i}`);
      if (val & (1<<i)) {
        seg.classList.add('on');
      } else {
        seg.classList.remove('on');
      }
    }
  }

  setDigit(disp, n) {
    this.setSegments(disp, SegmentDisplay.DIGITS[n]);
  }

  setDigits() {
    for (let i = 0; i < arguments.length; i++) {
      if (i >= this.count) return;

      this.setDigit(i, arguments[i]);
    }
  }

  setValue(x) {
    let i = 0;
    while (i < this.count) {
      this.setDigit(this.count - i - 1, (x >> 4*i) & 0xf);
      i++;
    }
  }
}

export default SegmentDisplay;
