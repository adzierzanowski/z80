#define CS 22
#define A0 23
#define RST 24

#include <SPI.h>
#include <stdarg.h>
#include <stdlib.h>

SPISettings spi_settings(2000000, MSBFIRST, SPI_MODE0);

void tft_reset() {
  digitalWrite(RST, LOW);
  delay(100);
  digitalWrite(RST, HIGH);
}

void tft_send_cmd(uint8_t cmd, int argc, ...) {
  uint8_t *buf = malloc((argc+1) * sizeof (uint8_t));
  buf[0] = cmd;

  va_list args;
  va_start(args, argc);

  for (int i = 0; i < argc; i++) {
    buf[i+1] = (uint8_t) va_arg(args, int);
  }

  va_end(args);

  digitalWrite(A0, LOW);
  digitalWrite(CS, LOW);
  SPI.beginTransaction(spi_settings);
  SPI.transfer(buf, argc+1);
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
  tft_send_cmd(0x36, 1, 0xc8);                   // set address mode
  tft_send_cmd(0x29, 0);                         // set display on
}

void tft_send_data(uint8_t data) {
  digitalWrite(CS, LOW);

  SPI.beginTransaction(spi_settings);
  digitalWrite(A0, LOW);
  SPI.transfer(0x2c);
  digitalWrite(A0, HIGH);
  SPI.transfer(data);
  SPI.endTransaction();
  digitalWrite(CS, HIGH);
}

void tft_caset() {
  digitalWrite(CS, LOW);

  SPI.beginTransaction(spi_settings);
  digitalWrite(A0, LOW);
  SPI.transfer(0x2a);
  digitalWrite(A0, HIGH);
  SPI.transfer16(0);
  SPI.transfer16(10);
  SPI.endTransaction();
  digitalWrite(CS, HIGH);
}

void tft_raset() {
  digitalWrite(CS, LOW);

  SPI.beginTransaction(spi_settings);
  digitalWrite(A0, LOW);
  SPI.transfer(0x2b);
  digitalWrite(A0, HIGH);
  SPI.transfer16(0);
  SPI.transfer16(10);
  SPI.endTransaction();
  digitalWrite(CS, HIGH);
}

void setup()
{
  SPI.begin();

  pinMode(CS, OUTPUT);
  pinMode(RST, OUTPUT);
  pinMode(A0, OUTPUT);
  digitalWrite(CS, HIGH);
  digitalWrite(A0, HIGH);
  digitalWrite(RST, HIGH);

  tft_init();

  tft_caset();
  tft_raset();

  for (int i = 0; i < 100; i++) {
    tft_send_data(0xff);
    tft_send_data(0xff);
  }
}


void loop()
{


}
