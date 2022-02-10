#define RST A1
#define CS A2
#define TFTA0 A3
#define A0PORT PORTC
#define A0PIN 0b100
#define TFT_MOSI 7

#define TFT_MISO 6
#define TFT_SCK 5
#define IRQLED 0
#define SPIMODELED 1

#define A0H digitalWrite(TFTA0, HIGH)
#define A0L digitalWrite(TFTA0, LOW)
//#define A0H (A0PORT |= A0PIN)
//#define A0L (A0PORT &= A0PIN)

#include <SPI.h>
#include <Wire.h>
#include <stdarg.h>
#include <stdlib.h>
#include "font.h"

SPISettings spi_settings(800000, MSBFIRST, SPI_MODE0);
uint8_t tft_spcr = 0;
//SoftSPI SPI(TFT_MOSI, TFT_MISO, TFT_SCK);

bool cls = false;
bool flip = false;
uint16_t data = 0;
int chbufpos = 0;
uint32_t tft_flip_debounce = 0;
char chbuf[20*16] = {0};

void tft_reset() {
  digitalWrite(RST, LOW);
  delay(100);
  digitalWrite(RST, HIGH);
}

void tft_send_cmd(uint8_t cmd, int argc, ...) {
  uint8_t *buf = (uint8_t *) malloc((argc) * sizeof (uint8_t));

  va_list args;
  va_start(args, argc);

  for (int i = 0; i < argc; i++) {
    buf[i] = (uint8_t) va_arg(args, int);
  }

  va_end(args);

  digitalWrite(CS, LOW);
  A0L;
  SPI.beginTransaction(spi_settings);
  SPI.transfer(cmd);
  A0H;
  SPI.transfer(buf, argc);
  SPI.endTransaction();
  digitalWrite(CS, HIGH);

  free(buf);
}

void tft_init() {
  tft_reset();
  tft_send_cmd(0x01, 0);                         // reset
  tft_send_cmd(0x11, 0);                         // exit sleep mode
  tft_send_cmd(0x3a, 1, 0x05);                   // set pixel mode
  tft_send_cmd(0x26, 1, 0x04);                   // set gamma curve
  tft_send_cmd(0xf2, 1, 0x01);                   // set gamma adjustment enabled
  tft_send_cmd(0xe0, 15,                         // positive gamma
    0x3f, 0x25, 0x1c, 0x1e, 0x20,
    0x12, 0x2a, 0x90, 0x24, 0x11,
    0x00, 0x00, 0x00, 0x00, 0x00
  );
  tft_send_cmd(0xe1, 15,                         // negative gamma
    0x20, 0x20, 0x20, 0x20, 0x05,
    0x00, 0x15, 0xa7, 0x3d, 0x18,
    0x25, 0x2a, 0x2b, 0x2b, 0x3a
  );
  tft_send_cmd(0xb1, 2, 0x08, 0x08);             // framerate control 1
  tft_send_cmd(0xb4, 1, 0x07);                   // display inversion
  tft_send_cmd(0xc0, 2, 0x0a, 0x02);             // power control 1
  tft_send_cmd(0xc1, 1, 0x02);                   // power control 2
  tft_send_cmd(0xc5, 2, 0x50, 0x5b);             // vcom control 1
  tft_send_cmd(0xc7, 1, 0x40);                   // vcom offset
  tft_send_cmd(0x2a, 4, 0x00, 0x00, 0x00, 0x7f); // set column address
  delay(250);
  tft_send_cmd(0x2b, 4, 0x00, 0x00, 0x00, 0x9f); // set page address
  tft_send_cmd(0x36, 1, 0b10100000);
  tft_send_cmd(0x29, 0);                         // set display on
}

void tft_send_data(uint16_t data) {
  digitalWrite(CS, LOW);
  A0L;
  SPI.beginTransaction(spi_settings);
  SPI.transfer(0x2c);
  A0H;
  SPI.transfer16(data);
  SPI.endTransaction();
  digitalWrite(CS, HIGH);
}

void tft_pix(uint16_t x, uint16_t y, uint16_t c) {
  digitalWrite(CS, LOW);

  A0L;
  SPI.beginTransaction(spi_settings);
  SPI.transfer(0x2a);
  A0H;
  SPI.transfer16(x);
  SPI.transfer16(x);

  A0L;
  SPI.transfer(0x2b);
  A0H;
  SPI.transfer16(y);
  SPI.transfer16(y);

  A0L;
  SPI.transfer(0x2c);
  A0H;
  SPI.transfer16(c);
  SPI.endTransaction();

  digitalWrite(CS, HIGH);
}

void tft_rect(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t c) {
  digitalWrite(CS, LOW);

  A0L;
  SPI.beginTransaction(spi_settings);
  SPI.transfer(0x2a);
  A0H;
  SPI.transfer16(y);
  SPI.transfer16(y+h);

  A0L;
  SPI.transfer(0x2b);
  A0H;
  SPI.transfer16(x);
  SPI.transfer16(x+w);

  A0L;
  SPI.transfer(0x2c);
  A0H;
  for (int i = 0; i < w*(h+1); i++) {
    SPI.transfer16(c);
  }
  SPI.endTransaction();

  digitalWrite(CS, HIGH);
}

void tft_fill(uint16_t c) {
  tft_rect(0, 0, 128, 160, c);
}

void tft_putch(uint8_t line, uint8_t col, char c, uint16_t color) {
  const uint8_t *fch;
  if (isprint(c)) {
    fch = font[c - ' '];
  } else {
    fch = font[0];
  }

  for (int y = 0; y < 8; y++) {
    for (int i = 0; i < 8; i++) {
      if (fch[y] & (1 << i)) {
        tft_pix(col*8+i, y+line*8, color);
      }
    }
  }
}

void tft_flip_chbuf(uint16_t color) {
  for (int i = 0; i < 20*16; i++) {
    tft_putch(i/20, i%20, chbuf[i], color);
  }
}

void setup()
{
  //Serial.begin(115200);
  Wire.begin(0x0a);
  Wire.onReceive(onReceive);

  pinMode(CS, OUTPUT);
  pinMode(RST, OUTPUT);
  pinMode(TFTA0, OUTPUT);
  pinMode(IRQLED, OUTPUT);
  pinMode(SPIMODELED, OUTPUT);
  digitalWrite(IRQLED, LOW);
  digitalWrite(CS, HIGH);
  digitalWrite(TFTA0, HIGH);
  digitalWrite(RST, HIGH);

  SPI.begin();

  tft_init();
  tft_fill(0x000a);

  strcpy(chbuf, "TFT READY");
  flip = true;
}

void loop()
{
  if (flip && millis() - tft_flip_debounce > 50) {
    if (cls) {
      tft_fill(0x0004);
      cls = false;
    }
    tft_flip_chbuf(0xffff);
    tft_flip_debounce = millis();
    flip = false;
  }
}

void onReceive(int count) {
  static bool escape = false;
  static int x = -1;

  digitalWrite(IRQLED, !digitalRead(IRQLED));
  char c = (char) Wire.read();

  if (escape) {
    if (x < 0) {
      x = (uint8_t) c;
    } else {
      chbufpos = 20 * ((uint8_t) c) + x;
      x = -1;
      escape = false;
    }
  }

  if (c == '\n') {
    chbufpos += 20 - (chbufpos%20);
    cls = true;
  } else if (c == '\r') {
    memset(chbuf, 0, 20*16);
    cls = true;
    chbufpos = 0;
  } else if (c == 27) {
    escape = true;
  } else if (isprint(c)) {
    chbuf[chbufpos++] = c;
  }

  if (chbufpos >= 20*16) {
    memmove(chbuf, chbuf+20, 20*15);
    memset(chbuf+20*15, 0, 20);
    chbufpos = 20*15;
    cls = true;
  }

  flip = true;
}
