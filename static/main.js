const cmd = (c, a) => {
  fetch(`/ctl?cmd=${c}&arg=${a}`).then(res => {
    res.text().then(text => console.log(text));
  });
};

const assemble = () => {
  document.getElementById('disassembled').innerHTML = 'assembling...';
  fetch(`/assemble`, {method: 'POST', body: document.getElementById('source').value}).then(res => {
    res.text().then(text => {
      document.getElementById('disassembled').innerHTML = text
        .replace(/^([0-9a-f]{4})/gm, '<span id="dasm-$1">$1</span>')
        .replace(/\x1b\[38;5;4m/g, '<span style="color: #51a1f0;">')
        .replace(/\x1b\[38;5;6m/g, '<span style="color: #a0c7ee;">')
        .replace(/\x1b\[38;5;3m/g, '<span style="color: orange;">')
        .replace(/\x1b\[38;5;1m/g, '<span style="color: red;">')
        .replace(/\x1b\[0m/g, '</span>');
    });
  });
};

const upload = () => {
  fetch('/upload').then(res => {
    console.log(res)
  })
};

setInterval(() => {
  fetch('/inbuf').then(res => {res.text().then(text => {
    const output = document.getElementById('output');
    output.value = text;
    output.scroll(0, output.scrollHeight);
  })});
}, 1000);

document.getElementById('instant-write').addEventListener('keyup', e => {
  e.preventDefault();
  console.log(e);
  if (e.key === 'Enter') {
    fetch('/ctl?cmd=write&arg=11');
  } else if (e.key === 'Home') {
    fetch('/ctl?cmd=write&arg=13');
  } else if (e.key === 'PageUp') {
    fetch('/ctl?cmd=write&arg=132');
  } else if ([37, 38, 39, 40].includes(e.keyCode)) {
    fetch(`/ctl?cmd=write&arg=${e.keyCode+91}`);
  } else if ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -_=+~`!@#$%^&*()[]{};:\'"/?.,<>'.includes(e.key)) {
    e.target.value = e.key;
    fetch(`/ctl?cmd=write&arg=${e.key === ' ' ? '%20' : e.key}`);
  } else if (['Control', 'Shift', 'Meta', 'Alt'].includes(e.key)) {

  } else {
    fetch(`/ctl?cmd=write&arg=${e.keyCode}`);
  }
});
