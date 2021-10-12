#include <VGAX.h>
#include <string.h>

#define FNT_NANOFONT_HEIGHT 6
#define FNT_NANOFONT_SYMBOLS_COUNT 95
#define LINEWIDTH 30
#define CHBUF_SZ (LINEWIDTH * 10)

VGAX vga;

const uint8_t font[][4] {
  { 0x00, 0x00, 0x00, 0x00 },
  { 0x10, 0x10, 0x00, 0x10 },
  { 0x44, 0x44, 0x00, 0x00 },
  { 0x55, 0x44, 0x55, 0x44 },
  { 0x14, 0x50, 0x14, 0x50 },
  { 0x44, 0x04, 0x40, 0x44 },
  { 0x50, 0x50, 0x54, 0x10 },
  { 0x10, 0x10, 0x00, 0x00 },
  { 0x10, 0x40, 0x40, 0x10 },
  { 0x10, 0x04, 0x04, 0x10 },
  { 0x44, 0x10, 0x44, 0x00 },
  { 0x00, 0x10, 0x54, 0x10 },
  { 0x00, 0x00, 0x04, 0x10 },
  { 0x00, 0x00, 0x54, 0x00 },
  { 0x00, 0x00, 0x00, 0x10 },
  { 0x04, 0x04, 0x10, 0x10 },

  { 0x50, 0x44, 0x44, 0x14 },
  { 0x50, 0x10, 0x10, 0x54 },
  { 0x50, 0x04, 0x10, 0x54 },
  { 0x54, 0x14, 0x04, 0x54 },
  { 0x44, 0x44, 0x54, 0x04 },
  { 0x54, 0x40, 0x14, 0x50 },
  { 0x14, 0x40, 0x54, 0x10 },
  { 0x54, 0x04, 0x10, 0x10 },
  { 0x10, 0x44, 0x10, 0x54 },
  { 0x10, 0x54, 0x04, 0x50 },

  { 0x00, 0x10, 0x00, 0x10 },
  { 0x04, 0x00, 0x04, 0x10 },
  { 0x04, 0x10, 0x40, 0x14 },
  { 0x00, 0x54, 0x00, 0x54 },
  { 0x40, 0x10, 0x04, 0x50 },
  { 0x14, 0x44, 0x00, 0x04 },
  { 0x14, 0x41, 0x11, 0x04 },

  { 0x10, 0x44, 0x54, 0x44 },
  { 0x50, 0x50, 0x44, 0x54 },
  { 0x14, 0x40, 0x40, 0x14 },
  { 0x50, 0x44, 0x44, 0x50 },
  { 0x54, 0x50, 0x40, 0x54 },
  { 0x54, 0x40, 0x50, 0x40 },
  { 0x14, 0x40, 0x44, 0x14 },
  { 0x44, 0x44, 0x54, 0x44 },
  { 0x54, 0x10, 0x10, 0x54 },
  { 0x54, 0x04, 0x04, 0x50 },
  { 0x44, 0x44, 0x50, 0x44 },
  { 0x40, 0x40, 0x40, 0x54 },
  { 0x54, 0x54, 0x44, 0x44 },
  { 0x50, 0x44, 0x44, 0x44 },
  { 0x10, 0x44, 0x44, 0x10 },
  { 0x50, 0x44, 0x50, 0x40 },
  { 0x10, 0x44, 0x44, 0x14 },
  { 0x50, 0x44, 0x50, 0x44 },
  { 0x14, 0x40, 0x04, 0x50 },
  { 0x54, 0x10, 0x10, 0x10 },
  { 0x44, 0x44, 0x44, 0x54 },
  { 0x44, 0x44, 0x44, 0x10 },
  { 0x44, 0x44, 0x54, 0x10 },
  { 0x44, 0x10, 0x44, 0x44 },
  { 0x44, 0x54, 0x10, 0x10 },
  { 0x54, 0x04, 0x10, 0x54 },

  { 0x50, 0x40, 0x40, 0x50 },
  { 0x10, 0x10, 0x04, 0x04 },
  { 0x14, 0x04, 0x04, 0x14 },
  { 0x10, 0x44, 0x00, 0x00 },
  { 0x00, 0x00, 0x00, 0x54 },
  { 0x40, 0x10, 0x00, 0x00 },

  { 0x10, 0x44, 0x54, 0x44 },
  { 0x50, 0x50, 0x44, 0x54 },
  { 0x14, 0x40, 0x40, 0x14 },
  { 0x50, 0x44, 0x44, 0x50 },
  { 0x54, 0x50, 0x40, 0x54 },
  { 0x54, 0x40, 0x50, 0x40 },
  { 0x14, 0x40, 0x44, 0x14 },
  { 0x44, 0x44, 0x54, 0x44 },
  { 0x54, 0x10, 0x10, 0x54 },
  { 0x54, 0x04, 0x04, 0x50 },
  { 0x44, 0x44, 0x50, 0x44 },
  { 0x40, 0x40, 0x40, 0x54 },
  { 0x54, 0x54, 0x44, 0x44 },
  { 0x50, 0x44, 0x44, 0x44 },
  { 0x10, 0x44, 0x44, 0x10 },
  { 0x50, 0x44, 0x50, 0x40 },
  { 0x10, 0x44, 0x44, 0x14 },
  { 0x50, 0x44, 0x50, 0x44 },
  { 0x14, 0x40, 0x04, 0x50 },
  { 0x54, 0x10, 0x10, 0x10 },
  { 0x44, 0x44, 0x44, 0x54 },
  { 0x44, 0x44, 0x44, 0x10 },
  { 0x44, 0x44, 0x54, 0x10 },
  { 0x44, 0x10, 0x44, 0x44 },
  { 0x44, 0x54, 0x10, 0x10 },
  { 0x54, 0x04, 0x10, 0x54 },

  { 0x04, 0x50, 0x10, 0x04 },
  { 0x10, 0x10, 0x10, 0x10 },
  { 0x40, 0x14, 0x10, 0x40 },
  { 0x00, 0x11, 0x44, 0x00 },
  { 0x54, 0x54, 0x54, 0x54 }
};

unsigned char chbuf[CHBUF_SZ] = {0};
int chbufpos = 0;
bool escape = false;
uint8_t x = 0xff;
uint8_t y = 0xff;


void setup() {
  Serial1.begin(9600);
  vga.begin();
  vga.clear(11);
  sprintf(chbuf, "buffer test");
}

void putchar_(uint8_t x, uint8_t y, char c) {
  if (c < ' ' || c > '~') {
    return;
  }

  for (int i = 0; i < 4; i++) {
    vgaxfb[x + VGAX_BWIDTH * (y*5+i)] = font[c - ' '][i];
  }
}

void loop() {
  static uint8_t x = 0;

  if (Serial1.available()) {
    unsigned char c = (unsigned char) Serial1.read();

    if (escape) {
      if (x == 0xff) {
        x = (uint8_t) c;
      } else if (y == 0xff) {
        y = (uint8_t) c;
        chbufpos = x + y * 30;
        x = 0xff;
        y = 0xff;
        escape = false;
      }
    } else {
      if (c == '\n') {
        while (chbufpos % 30) {
          chbuf[chbufpos++] = ' ';
        }
      } else if (c == 8) {
        chbuf[--chbufpos] = ' ';
      } else if (c == '\r') {
        memset(chbuf, 0, CHBUF_SZ);
        chbufpos = 0;
      } else if (c == 0x80) {
        chbufpos--;
      } else if (c == 0x81) {
        chbufpos -= 30;
      } else if (c == 0x82) {
        chbufpos++;
      } else if (c == 0x83) {
        chbufpos += 30;
      } else if (c == 27) {
        escape = true;
      } else {
        chbuf[chbufpos++] = c;
      }
    }

    if (chbufpos >= CHBUF_SZ)  {
      memmove(chbuf, chbuf + 30, CHBUF_SZ - 30);
      chbufpos = CHBUF_SZ - 30;
      memset(chbuf+CHBUF_SZ-30, 0, 30);
    } else if (chbufpos < 0) {
      chbufpos = 0;
    }
  }

  vga.clear(0);

  for (int i = 0; i < CHBUF_SZ; i++) {
    putchar_(i % 30, i / 30, chbuf[i]);
  }

  // cursor
  putchar_(chbufpos%30, chbufpos / 30, '_');
//  vgaxfb[VGAX_BWIDTH * chbufpos/30 + chbufpos % 30] = 0b01010101;
//  vgaxfb[VGAX_BWIDTH * (chbufpos/30+1) + chbufpos % 30] = 0b01010101;
//  vgaxfb[VGAX_BWIDTH * (chbufpos/30+2) + chbufpos % 30] = 0b01010101;
//  vgaxfb[VGAX_BWIDTH * (chbufpos/30+3) + chbufpos % 30] = 0b01010101;
//
  vga.delay(100);
}