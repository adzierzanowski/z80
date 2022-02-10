import Display from './disp.js';


class LEDDisplay extends Display {
  constructor(count) {
    super();

    this.mounted = false;
    this.count = count;
    this.leds = [];
  }

  generateDOM() {
    const wrapper = document.createElement('div');
    wrapper.classList.add('led-display__wrapper');

    for (let i = 0; i < this.count; i++) {
      const led = document.createElement('div');
      led.classList.add('led-display__led');
      this.leds.push(led);
      wrapper.appendChild(led);
    }

    return wrapper;
  }

  setValue(val) {
    for (let i = 0; i < this.leds.length; i++) {
      const led = this.leds[this.leds.length - i - 1];

      if (val & (1 << i)) {
        led.classList.add('on');
      } else {
        led.classList.remove('on');
      }
    }
  }
}

export default LEDDisplay;
