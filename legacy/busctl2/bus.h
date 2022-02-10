#ifndef BUS_H
#define BUS_H

uint16_t readAddr() {
  uint16_t val = 0;
  for (int i = 0; i < 16; i++) {
    val |= digitalRead(ABUS0 + i*ABUSGAP) << i;
  }
  return val;
}

void setAddr(uint16_t val) {
  for (int i = 0; i < 16; i++) {
    digitalWrite(ABUS0 + i*ABUSGAP, !!(val & (1 << i)));
  }
}

uint8_t readData() {
  uint8_t val = 0;
  for (int i = 0; i < 8; i++) {
    val |= digitalRead(DBUS0 + i*DBUSGAP) << i;
  }
  return val;
}

void setData(uint8_t val) {
  for (int i = 0; i < 8; i++) {
    digitalWrite(DBUS0 + i*DBUSGAP, !!(val & (1 << i)));
  }
}

void setDataIn() {
  for (int i = DBUS0; i < DBUS0 + 8*DBUSGAP; i+=DBUSGAP) {
    pinMode(i, INPUT);
  }
}

void setDataOut() {
  for (int i = DBUS0; i < DBUS0 + 8*DBUSGAP; i+=DBUSGAP) {
    pinMode(i, OUTPUT);
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

  for (int i = ABUS0; i < ABUS0 + 16*ABUSGAP; i+=ABUSGAP) {
    pinMode(i, OUTPUT);
  }

  for (int i = DBUS0; i < DBUS0 + 8*DBUSGAP; i+=DBUSGAP) {
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
  for (int i = ABUS0; i < ABUS0 + 16*ABUSGAP; i+=ABUSGAP) {
    pinMode(i, INPUT);
  }
  for (int i = DBUS0; i < DBUS0 + 8*DBUSGAP; i+=DBUSGAP) {
    pinMode(i, INPUT);
  }
  pinMode(MEMRQ, INPUT);
  pinMode(RD, INPUT);
  pinMode(WR, INPUT);

  delay(100);

  digitalWrite(BUSRQ, HIGH);
}

#endif
