import RAM from './ram.js';

class Z80 {
  constructor({disp, addrLEDs, addrSegments, dataLEDs, dataSegments}) {
    this.disp = disp;
    this.addrLEDs = addrLEDs;
    this.addrSegments = addrSegments;
    this.dataLEDs = dataLEDs;
    this.dataSegments = dataSegments;

    this.ram = new RAM();

    this.control = {
      CLK: false,
      INT: false,
      NMI: false,
      HALT: false,
      MREQ: false,
      IORQ: false,
      RD: false,
      WR: false,
      BUSACK: false,
      WAIT: false,
      BUSRQ: false,
      RESET: false,
      M1: false,
      REFSH: false,
      VCC: false
    };

    this.pc = 0;
  }

  setControl(which, value) {
    // Power on
    if (which === 'VCC' && !this.control.VCC && value === true) {
      this.setAddress(0);
      this.setData();
    } else if (which === 'CLK' && this.control.CLK && !value) {
      this.onTick();
    }

    this.control[which] = value;

    const ev = new CustomEvent('ctlChanged', {detail: {pin: which, value: value}});
    document.dispatchEvent(ev);
  }

  setControls(whichDict) {
    for (let key in whichDict) {
      this.setControl(key, whichDict[key]);
    }
  }

  attachDisplayEvents() {
    document.addEventListener('addressChanged', e => {
      this.addrSegments.setValue(e.detail.address);
      this.addrLEDs.setValue(e.detail.address);
      this.disp.setAddress(e.detail.address);
    });

    document.addEventListener('dataChanged', e => {
      this.dataSegments.setValue(e.detail.data);
      this.dataLEDs.setValue(e.detail.data);
      this.disp.setData(e.detail.data);
    });

    document.addEventListener('ctlChanged', e => {
      this.disp.setPin(e.detail.pin, e.detail.value);
    });
  }

  setAddress(value) {
    this.pc = value;
    const ev = new CustomEvent('addressChanged', {detail: {address: value}});
    document.dispatchEvent(ev);
  }

  setData() {
    const value = this.ram.memory[this.pc];

    const ev = new CustomEvent('dataChanged', {detail: {data: value}});
    document.dispatchEvent(ev);
  }

  connectPower() {
    this.setControls({
      VCC: true,
      INT: true,
      NMI: true,
      HALT: true,
      MREQ: true,
      IORQ: true,
      RD: true,
      WR: true,
      BUSACK: true,
      WAIT: true,
      BUSRQ: true,
      RESET: true,
      M1: true,
      REFSH: true
    })
  }

  clockPulse(delay=250) {
    this.setControl('CLK', true);
    setTimeout(() => this.setControl('CLK', false), delay);
  }

  onTick() {
    this.setAddress(this.pc + 1);

  }
}

export default Z80;
