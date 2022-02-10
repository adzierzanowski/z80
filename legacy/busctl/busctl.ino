#define LC_DIN 2
#define LC_LOAD 3
#define LC_CLK 4

#define BUSRQ 22
#define BUSACK 24
#define DBUS0 38

#define ABUS0 23

#define MEMRQ 26
#define IORQ 28
#define WAIT 30
#define RD 32
#define WR 34

#define BTN 7


#include "LedControl.h"

bool progMode = false;
bool readMode = false;

LedControl lc(LC_DIN, LC_CLK, LC_LOAD, 1);

const uint8_t program[] = {
  0b00110001, 0, 0b00010000,
  0b00111110, 0b10101010,
  0b1110110,
  0b11000011, 0b11, 0
};

const size_t program_sz = sizeof program / sizeof program[0];

void showBus(uint16_t addr, uint8_t data) {
  lc.setDigit(0, 0, data >> 4, false);
  lc.setDigit(0, 1, data & 0xf, false);

  lc.setDigit(0, 2, (addr >> 4) & 0xf, false);
  lc.setDigit(0, 3, (addr >> 0) & 0xf, false);
  lc.setDigit(0, 4, (addr >> 12) & 0xf, false);
  lc.setDigit(0, 5, (addr >> 8) & 0xf, false);

}

void waitForButton() {
  static uint32_t debounce = 0;
  while (true) {
    if (millis() - debounce > 200 && !digitalRead(BTN)) {
      break;
    }
  }
  debounce = millis();
}

uint16_t readAddr() {
  uint16_t val = 0;
  for (int i = 0; i < 16; i++) {
    val |= digitalRead(ABUS0 + i*2) << i;
  }
  return val;
}

uint8_t readData() {
  uint8_t val = 0;
  for (int i = 0; i < 8; i++) {
    val |= digitalRead(DBUS0 + i*2) << i;
  }
  return val;
}

void setData(uint8_t val) {
  for (int i = 0; i < 8; i++) {
    digitalWrite(DBUS0 + i*2, !!(val & (1 << i)));
  }
}

void setDataIn() {
  for (int i = DBUS0; i < DBUS0 + 8*2; i+=2) {
    pinMode(i, INPUT);
  }
}

void setDataOut() {
  for (int i = DBUS0; i < DBUS0 + 8*2; i+=2) {
    pinMode(i, OUTPUT);
  }
}

void setAddr(uint16_t val) {
  for (int i = 0; i < 16; i++) {
    digitalWrite(ABUS0 + i*2, !!(val & (1 << i)));
  }
}

void ramWrite(uint16_t addr, uint8_t val) {
  setAddr(addr);
  delay(1);
  setData(val);
  delay(1);
  digitalWrite(MEMRQ, LOW);
  delay(1);
  digitalWrite(WR, LOW);
  delay(5);
  digitalWrite(WR, HIGH);
  delay(1);
  digitalWrite(MEMRQ, HIGH);
  delay(1);
}

bool acquireBus() {
  digitalWrite(BUSRQ, LOW);
  while (digitalRead(BUSACK)) {}
  delay(100);

  for (int i = ABUS0; i < ABUS0 + 16*2; i+=2) {
    pinMode(i, OUTPUT);
  }

  for (int i = DBUS0; i < DBUS0 + 8*2; i+=2) {
    pinMode(i, OUTPUT);
  }

  pinMode(MEMRQ, OUTPUT);
  pinMode(RD, OUTPUT);
  pinMode(WR, OUTPUT);

  digitalWrite(MEMRQ, HIGH);
  digitalWrite(RD, HIGH);
  digitalWrite(WR, HIGH);
}

void releaseBus() {
  for (int i = ABUS0; i < ABUS0 + 16*2; i+=2) {
    pinMode(i, INPUT);
  }
  for (int i = DBUS0; i < DBUS0 + 8*2; i+=2) {
    pinMode(i, INPUT);
  }
  pinMode(MEMRQ, INPUT);
  pinMode(RD, INPUT);
  pinMode(WR, INPUT);

  delay(100);

  digitalWrite(BUSRQ, HIGH);
}

void setup() {
  Serial.begin(115200); // Programming
  Serial1.begin(115200); // TFT
  Serial2.begin(9600); // Keyboard

  pinMode(BUSACK, INPUT);
  pinMode(BUSRQ, OUTPUT);
  pinMode(MEMRQ, INPUT);
  pinMode(RD, INPUT);
  pinMode(WR, INPUT);
  pinMode(WAIT, OUTPUT);
  pinMode(BTN, INPUT_PULLUP);

  digitalWrite(WAIT, HIGH);
  digitalWrite(BUSRQ, HIGH);

  for (int i = ABUS0; i < ABUS0 + 16*2; i+=2) {
    pinMode(i, INPUT);
  }

  for (int i = DBUS0; i < DBUS0 + 8*2; i+=2) {
    pinMode(i, INPUT);
  }

  lc.shutdown(0,false);
  lc.setIntensity(0,0xf);
  lc.clearDisplay(0);
  Serial.flush();
}

char kbdbuf[25*16] = {0};
int kbdbufWRPos = 0;
int kbdbufRDPos = 0;

void loop() {
  static uint32_t lcDebounce = 0;

  if (progMode) {
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

  } else if (readMode) {
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
  } else {
    if (!digitalRead(IORQ)) {
      uint8_t data = readData();
      uint16_t addr = readAddr();

      if (((uint8_t) (addr & 0xff)) == 0xaa) {
        if (!digitalRead(WR)) {
          Serial1.write(data);
          while (!digitalRead(WR));
        }
      }

      else if (((uint8_t) (addr & 0xff)) == 0xab) {
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

      if (millis() - lcDebounce > 50) {
        uint8_t data = readData();
        uint16_t addr = readAddr();

        showBus(addr, data);
        lcDebounce = millis();
      }
    }
  }
}
