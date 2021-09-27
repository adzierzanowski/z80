#include <stdint.h>
#include <stdlib.h>
#include <string.h>


#define ADDR_BASE 22
#define ADDR_END(pincnt) (ADDR_BASE+pincnt*2)
#define DATA_BASE 39
#define DATA_END(pincnt) (DATA_BASE+pincnt*2)

#define CS 23
#define IOQ 25
#define WAIT 27
#define OE 29
#define WE 31

#define READY_LED 13

#define RAM_SIZE 0x1400
#define OUTBUF_SIZE 0x400

#ifdef DEBUG
  #define DBGPRINT(msg) Serial.print(msg)
  #define DBGPRINTLN(msg) Serial.println(msg)
#else
  #define DBGPRINT(msg)
  #define DBGPRINTLN(msg)
#endif


uint8_t ram[RAM_SIZE] = {0};
uint32_t cs_debounce = 0;
bool programmingMode = false;
bool probableStop = false;

char outbuf[OUTBUF_SIZE] = {0};
int outpos = 0;
char inbuf[OUTBUF_SIZE] = {0};
int inpos = 0;
int inposw = 0;

constexpr uint8_t program[] = {
  0x7f & ~1
};

constexpr size_t program_sz = sizeof program / sizeof program[0];

uint8_t readData() {
  uint8_t data = 0;
  int pos = 0;
  for (int i = DATA_BASE; i < DATA_END(8); i+=2, pos++) {
    data |= (digitalRead(i) << pos);
  }
  return data;
}

void writeData(uint8_t val) {
  for (int i = DATA_BASE; i < DATA_END(8); i+=2) {
    digitalWrite(i, val & 1);
    val >>= 1;
  }
}

uint16_t readAddr() {
  uint16_t addr = 0;
  int pos = 0;
  for (int i = ADDR_BASE; i < ADDR_END(16); i+=2, pos++) {
    addr |= ((uint16_t) digitalRead(i)) << pos;
  }
  return addr;
}

void setDataMode(int mode) {
  for (int i = DATA_BASE; i < DATA_END(8); i+=2) {
    pinMode(i, mode);
  }
}

void setup()
{
  pinMode(READY_LED, OUTPUT);
  pinMode(WAIT, OUTPUT);

  digitalWrite(WAIT, LOW);
  digitalWrite(READY_LED, LOW);
  Serial.begin(115200);
  Serial1.begin(115200);

  Serial.println(F("memset"));
  memset(ram, 0, RAM_SIZE);
  Serial.println(F("copying program"));
  memcpy(ram, program, program_sz);

  for (int i = ADDR_BASE; i < ADDR_END(16); i+=2) {
    pinMode(i, INPUT);
  }

  setDataMode(INPUT);

  pinMode(CS, INPUT_PULLUP);
  pinMode(OE, INPUT_PULLUP);
  pinMode(WE, INPUT_PULLUP);

  Serial.print(F("RAM: "));
  Serial.print(RAM_SIZE);
  Serial.println(F(" B"));
  Serial.println(F("READY"));
  digitalWrite(READY_LED, HIGH);

  digitalWrite(WAIT, HIGH);
}


void loop()
{
  static char buf[0x100] = {0};
  static int bufpos = 0;

  if (Serial.available()) {
    unsigned char c = Serial.read();

    if (programmingMode) {
      if (c == 0xed) {
        probableStop = true;
        ram[bufpos++] = c;
        Serial.write('K');
      } else if (probableStop && c == 0x7f) {
        for (int i = 0; i < bufpos; i++) {
          Serial.write(ram[i]);
        }
        programmingMode = false;
        bufpos = 0;
        probableStop = false;
        Serial.write("Done");
        digitalWrite(WAIT, HIGH);
      } else if (probableStop) {
        probableStop = false;
        ram[bufpos++] = c;
        Serial.write('K');
      } else {
        ram[bufpos++] = c;
        Serial.write('K');
      }
    } else {
      if (c == '\n') {
        buf[bufpos] = 0;
        bufpos = 0;

        Serial.print(F("buf: "));
        Serial.println(buf);

        if (strcmp(buf, "prog") == 0) {
          programmingMode = true;
          bufpos = 0;
          digitalWrite(WAIT, LOW);
          delay(100);
          Serial.println(F("Ready"));
        }
      } else {
        buf[bufpos++] = c;
      }
    }
  }

  if (Serial1.available()) {
    char c = Serial1.read();

    if (c) {
      inbuf[inpos++] = c;
    } else {
      inbuf[inpos] = 0;
      inpos = 0;
      inposw = 0;
    }
  }


  if (!programmingMode) {
    if (!digitalRead(CS)) {
      uint16_t addr = readAddr();
      uint8_t value = ram[addr];

      if (digitalRead(OE) == 0)  {
        setDataMode(OUTPUT);
        writeData(value);
        while (!digitalRead(OE));
        setDataMode(INPUT);
      }

      if (digitalRead(WE) == 0) {
        uint8_t data = readData();
        while (!digitalRead(OE));
        ram[addr] = data;
      }
    } else if (!digitalRead(IOQ)) {
      uint16_t addr = readAddr() & 0xff;

      if (!digitalRead(WE))  {
        uint8_t data = readData();

        if (addr == 0xaa) {
          if (data) {
            outbuf[outpos++] = (char) data;
          } else {
            outbuf[outpos] = 0;
            outpos = 0;
          }
        }

        while (!digitalRead(WE));
        if (!outpos && (addr == 0xaa)) {
          Serial1.println(outbuf);
        }
      } else if (!digitalRead(OE)) {
        setDataMode(OUTPUT);
        if (inposw < inpos) {
          writeData(inbuf[inposw++]);
        } else {
          inpos = 0;
          inposw = 0;
          writeData(0);
        }
        while (!digitalRead(OE));
        setDataMode(INPUT);
      }
    }
  }
}
