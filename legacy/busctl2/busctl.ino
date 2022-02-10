#define LC_DIN 2
#define LC_LOAD 3
#define LC_CLK 4

#define BUSRQ 22
#define BUSACK 24
#define DBUS0 23
#define DBUSGAP 2

#define ABUS0 54
#define ABUSGAP 1

#define MEMRQ 26
#define IORQ 28
#define WAIT 30
#define RD 32
#define WR 34

#define BTN 7

#define TFT_CS 8

#define TFT_PORT 0xaa
#define KBD_PORT 0xab
#define EEPROM_PORT 0xee

#include <SPI.h>
#include <Wire.h>
#include "LedControl.h"

#include "bus.h"
#include "eeprom.h"

bool progMode = false;
bool readMode = false;

LedControl lc(LC_DIN, LC_CLK, LC_LOAD, 1);
SPISettings spi_settings(1000000, MSBFIRST, SPI_MODE0);

uint8_t eeprom_stage = 0;
uint16_t eeprom_addr = 0xffff;

char kbdbuf[25*16] = {0};
int kbdbufWRPos = 0;
int kbdbufRDPos = 0;

void showBus(uint16_t addr, uint8_t data) {
  lc.setDigit(0, 0, data >> 4, false);
  lc.setDigit(0, 1, data & 0xf, false);

  lc.setDigit(0, 2, (addr >> 4) & 0xf, false);
  lc.setDigit(0, 3, (addr >> 0) & 0xf, false);
  lc.setDigit(0, 4, (addr >> 12) & 0xf, false);
  lc.setDigit(0, 5, (addr >> 8) & 0xf, false);
}

void setup() {
  Serial.begin(115200); // Programming
  Serial1.begin(115200); // TFT
  Serial2.begin(9600); // Keyboard
  SPI.begin();
  Wire.begin();

  pinMode(BUSACK, INPUT);
  pinMode(BUSRQ, OUTPUT);
  pinMode(MEMRQ, INPUT);
  pinMode(RD, INPUT);
  pinMode(WR, INPUT);
  pinMode(WAIT, OUTPUT);
  pinMode(BTN, INPUT_PULLUP);
  pinMode(TFT_CS, OUTPUT);

  digitalWrite(TFT_CS, HIGH);

  digitalWrite(WAIT, HIGH);
  digitalWrite(BUSRQ, HIGH);

  for (int i = ABUS0; i < ABUS0 + 16*ABUSGAP; i+=ABUSGAP) {
    pinMode(i, INPUT);
  }

  for (int i = DBUS0; i < DBUS0 + 8*DBUSGAP; i+=DBUSGAP) {
    pinMode(i, INPUT);
  }

  lc.shutdown(0,false);
  lc.setIntensity(0,0xf);
  lc.clearDisplay(0);
  Serial.flush();

  // EEPROM TEST
  randomSeed(analogRead(0));
  uint16_t randomAddr = random(0x4000);
  uint8_t randomData = random(0x100);
  showBus(randomAddr, randomData);
  delay(1000);
  showBus(0, 0);
  eeprom_write(randomAddr, randomData);
  delay(1000);
  uint8_t eereadout = eeprom_read(randomAddr);
  showBus(randomAddr, eereadout);
  delay(1000);
  if (eereadout == randomData) {
    lc.setChar(0, 4, 'G', false);
    lc.setChar(0, 5, '0', false);
    lc.setChar(0, 2, '0', false);
    lc.setChar(0, 3, 'd', false);
  } else {
    lc.setChar(0, 4, 'b', false);
    lc.setChar(0, 5, 'A', false);
    lc.setChar(0, 2, 'd', false);
    lc.setChar(0, 3, ' ', false);
  }
  delay(2000);
}

// Upload program received from PC UART to the RAM
void uploaderLoop() {
  acquireBus();

  bool probableStop = false;
  uint16_t addr = 0;

  Serial.write('r');

  while (true) {
    if (Serial.available()) {
      uint8_t c = (uint8_t) Serial.read();
      if (c == 0xff && addr == 0) {
        continue;
      }

      if (c == 0xdd) {
        probableStop = true;
      } else if (probableStop) {
        if (c == 0x64) { // ld ixh, ixh (basically nop)
          progMode = false;
        } else {
          probableStop = false;
        }
      }

      ramWrite(addr++, c);
      Serial.write(~c);

      if (!progMode) {
        Serial.println('done');
        break;
      }
    }
  }

  releaseBus();
  progMode = false;
}

// Read RAM at address received from PC UART
void readerLoop() {
  acquireBus();
  setDataIn();
  digitalWrite(RD, LOW);
  digitalWrite(MEMRQ, LOW);

  long addr = 0;
  while (true) {
    if (Serial.available()) {
      long newAddr = Serial.parseInt();
      if (newAddr < -1 || newAddr > 0xffff) {
        readMode = false;
      } else if (newAddr == -1) {
        setAddr(++addr);
        uint8_t data = readData();
        showBus(addr, data);
      } else if (newAddr != 0) {
        addr = newAddr;
        setAddr(addr);
        uint8_t data = readData();
        showBus(addr, data);
      }
    }

    if (!readMode) {
      releaseBus();
      break;
    }
  }
}

void loop() {
  static uint32_t lcDebounce = 0;

  if (progMode) {
    uploaderLoop();
  } else if (readMode) {
    readerLoop();
  } else {
    if (!digitalRead(IORQ)) {
      uint8_t data = readData();
      uint16_t addr = readAddr();
      uint8_t rq_port = addr;

      if (rq_port == TFT_PORT) {
        // Send char to TFT Controller
        if (!digitalRead(WR)) {
          Wire.beginTransmission(0x0a);
          Wire.write(data);
          Wire.endTransmission();
          while (!digitalRead(WR));
        }

      } else if (rq_port == EEPROM_PORT) {
        if (!digitalRead(WR)) {
          if (eeprom_stage == 0) {
            eeprom_addr = data;
            eeprom_stage++;
          } else if (eeprom_stage == 1) {
            eeprom_addr |= (data << 8);
            eeprom_stage++;
          } else if (eeprom_stage == 2) {
            eeprom_write(eeprom_addr, data);
            eeprom_stage = 0;
          }
          while (!digitalRead(WR));
        } else if (!digitalRead(RD)) {
          if (eeprom_stage == 2) {
            setDataOut();
            setData(eeprom_read(eeprom_addr));
          }
          while (!digitalRead(RD));
          eeprom_stage = 0;
          setDataIn();
        }

      } else if (rq_port == KBD_PORT) {
        if (!digitalRead(RD)) {
          setDataOut();

          if (kbdbufRDPos == kbdbufWRPos) {
            setData(0);
          } else {
            setData(kbdbuf[kbdbufRDPos++]);
          }

          if (kbdbufRDPos >= 10*26) {
            kbdbufRDPos = 0;
          }

          while (!digitalRead(RD));
          setDataIn();
        }
      }

    } else {
      if (Serial.available()) {
        char c = Serial.read();
        if (c == 'p') {
          progMode = true;
          Serial.flush();
        } else if (c == 'r') {
          readMode = true;
        }
      }

      if (Serial2.available()) {
        char c = Serial2.read();
        kbdbuf[kbdbufWRPos++] = c;
        if (kbdbufWRPos >= 16*20) {
          kbdbufWRPos = 0;
        }
      }

      if (millis() - lcDebounce > 250) {
        uint8_t data = readData();
        uint16_t addr = readAddr();


        showBus(addr, data);
        lcDebounce = millis();
      }
    }
  }
}
