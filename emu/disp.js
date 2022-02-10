class Display {
  mount(target) {
    target.appendChild(this.generateDOM());
    this.mounted = true;
  }
}

export default Display;
