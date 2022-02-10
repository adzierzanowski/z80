const fontTable = document.getElementById('font-table');
const state = {
  erase: false
};

function pad(str, char, len) {
  let zero = false;

  if (Number(str) === 0) {
    zero = true;
  }

  while (str.length < len) {
    str = char + str;
  }

  if (zero) {
    str = '<span class="zero">0x' + str + '</span>';
  } else {
    str = '<span class="not-zero">0x' + str + '</span>';
  }

  return str;
}

function recalculate() {
  const charWidth = Number(document.getElementById('width').value);
  const reverseBits = document.getElementById('reverse-bits').checked;

  let output = '<span class="keyword">const</span> ';
  output += '<span class="type">uint8_t</span> font';
  output += '<span class="brackets">[]</span> = <span class="brackets">{</span>\n';

  fontTable.querySelectorAll('.char').forEach(char => {
    const ord = char.getAttribute('data-ord');
    const chr = char.getAttribute('data-char');

    const data = [];

    char.querySelectorAll('.row').forEach(row => {
      let val = 0;

      row.querySelectorAll('.pix').forEach((pix, i) => {
        if (pix.classList.contains('on')) {
          if (reverseBits) {
            val |= (1 << (charWidth - i - 1))
          } else {
            val |= (1 << (i))
          }
        }
      });

      data.push(val);
    });

    let cchar = chr;
    if (cchar === '\\') {
      cchar = 'backslash';
    } else if (cchar === ' ') {
      cchar = 'space';
    }

    output += '  <span class="brackets">{</span> ';
    output += data.map(x => pad(x.toString(16), '0', 2)).join(', ');
    output += ` <span class="brackets">}</span>, <span class="comment">// ${ord} ${cchar}</span>\n`;
  });

  output += '<span class="brackets">}</span>;';
  const out = document.getElementById('output');
  out.innerHTML = output;
}

function createFontTable() {
  const charWidth = Number(document.getElementById('width').value);
  const charHeight = Number(document.getElementById('height').value);

  const fontTable = document.getElementById('font-table');
  fontTable.innerHTML = '';

  for (let i = ' '.charCodeAt(0); i < 127; i++) {
    const charDiv = document.createElement('div');
    charDiv.setAttribute('class', 'char');
    charDiv.setAttribute('id', `char${i}`);
    charDiv.setAttribute('data-char', String.fromCharCode(i));
    charDiv.setAttribute('data-ord', `${i}`);

    const charDivTitle = document.createElement('h4');
    charDivTitle.innerText = `'${String.fromCharCode(i)}'`;
    charDiv.appendChild(charDivTitle);

    const charDivNav = document.createElement('div');
    charDivNav.setAttribute('class', 'char-nav');
    charDiv.appendChild(charDivNav);

    const clearButton = document.createElement('button');
    clearButton.innerText = 'Clear';
    clearButton.addEventListener('click', () => {
      charDiv.querySelectorAll('.pix').forEach(pix => {
        pix.classList.remove('on');
      });
    });
    charDivNav.appendChild(clearButton);

    const charDivBitmap = document.createElement('div');
    charDivBitmap.setAttribute('class', 'bitmap');
    charDiv.appendChild(charDivBitmap);

    for (let y = 0; y < charHeight; y++) {
      const rowDiv = document.createElement('div');
      rowDiv.setAttribute('class', 'row');

      for (let x = 0; x < charWidth; x++) {
        const pixDiv = document.createElement('pix');
        pixDiv.setAttribute('class', 'pix');
        pixDiv.setAttribute('data-char', String.fromCharCode(i));
        pixDiv.setAttribute('data-ord', i);
        pixDiv.setAttribute('data-x', x);
        pixDiv.setAttribute('data-y', y);

        rowDiv.appendChild(pixDiv);
      }
      charDivBitmap.appendChild(rowDiv);
    }

    fontTable.appendChild(charDiv);

  }
}

function putPix(target, buttons) {
  if (buttons === 1) {
    if (state.erase) {
      target.classList.remove('on');
    } else {
      target.classList.add('on');
    }
  }
}

fontTable.addEventListener('mousemove', e => {
  window.getSelection().empty();
  putPix(e.target, e.buttons);
});

fontTable.addEventListener('mouseup', e => {
  recalculate();
});


document.getElementById('font-table').addEventListener('click', e => {
  if (e.target.classList.contains('pix')) {
    putPix(e.target, 1);
    recalculate();
  }
});

createFontTable();
recalculate();

document.getElementById('reload').addEventListener('click', () => {
  createFontTable();
  recalculate();
});

document.addEventListener('keyup', e => {
  if (e.key == 'e') {
    state.erase = !state.erase;
  }
});
