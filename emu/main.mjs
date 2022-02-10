import LEDDisplay from './leddisp.js';
import SegmentDisplay from './segdisp.js';
import Z80Disp from './z80disp.js';
import Z80 from './cpu.js';



const addrDisp = new SegmentDisplay(4);
const dataDisp = new SegmentDisplay(2);
const addrLEDs = new LEDDisplay(16);
const dataLEDs = new LEDDisplay(8);
const cpuDisp = new Z80Disp();

addrDisp.mount(document.getElementById('address-segdisp-wrapper'));
dataDisp.mount(document.getElementById('data-segdisp-wrapper'));
addrLEDs.mount(document.getElementById('address-leddisp-wrapper'));
dataLEDs.mount(document.getElementById('data-leddisp-wrapper'));
cpuDisp.mount(document.getElementById('cpu-wrapper'));

const cpu = new Z80({disp: cpuDisp, addrLEDs: addrLEDs, addrSegments: addrDisp, dataLEDs: dataLEDs, dataSegments: dataDisp});
cpu.attachDisplayEvents();
cpu.connectPower();
window.cpu = cpu;

/*
const nextVal = (x) => {
  addrDisp.setValue(x);
  addrLEDs.setValue(x);
  dataDisp.setValue(x+1);
  dataLEDs.setValue(x+1);
  cpu.setAddr(x);
  cpu.setData(x+1);
  cpu.setPin('CLK', x % 2);
  cpu.setPin('REFSH', x % 2);
  setTimeout(() => nextVal(x+1), 100);
};

nextVal(0);
cpu.setPin(0, true);

cpu.setPin('VCC', true);
cpu.setPin('NMI', true);
cpu.setPin('INT', true);
cpu.setPin('RESET', true);
cpu.setPin('HALT', true);
cpu.setPin('WAIT', true);
cpu.setPin('IORQ', true);
cpu.setPin('MREQ', true);
cpu.setPin('WR', true);
cpu.setPin('RD', true);
cpu.setPin('BUSACK', true);
cpu.setPin('BUSRQ', true);
cpu.setPin('M1', true);
*/
