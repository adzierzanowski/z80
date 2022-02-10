#define ADDR0 22
#define DATA0 46
#define CE 2
#define OE 3
#define WE 4




void setAddr(uint16_t addr) {
  for (int i = 0; i < 15; i++) {
    digitalWrite(ADDR0+i, (int) !!(addr & (1 << i)));
  }
}

uint16_t readAddr() {
  uint16_t addr = 0;

  for (int i = 0; i < 15; i++) {
    addr |= (digitalRead(ADDR0+i) << i);
  }

  return addr;
}

void setDataMode(int mode) {
  for (int i = 0; i < 8; i++) {
    pinMode(DATA0+i, mode);
  }
}

void writeData(uint8_t data) {
  setDataMode(OUTPUT);

  digitalWrite(CE, LOW);

  for (int i = 0; i < 8; i++) {
    digitalWrite(DATA0+i, (int) !!(data & (1 << i)));
  }

  digitalWrite(WE, LOW);
  digitalWrite(WE, HIGH);
  digitalWrite(CE, HIGH);
}

uint8_t readData() {
  setDataMode(INPUT);

  digitalWrite(CE, LOW);
  digitalWrite(OE, LOW);

  uint8_t data = 0;
  for (int i = 0; i < 8; i++) {
    data |= (digitalRead(DATA0+i) << i);
  }

  digitalWrite(OE, HIGH);
  digitalWrite(CE, HIGH);

  return data;
}


void setup() {
  Serial.begin(115200);
  randomSeed(analogRead(A0));

  for (int i = 0; i < 15; i++) {
    pinMode(ADDR0+i, OUTPUT);
  }

  pinMode(CE, OUTPUT);
  pinMode(WE, OUTPUT);
  pinMode(OE, OUTPUT);

  digitalWrite(CE, OUTPUT);
  digitalWrite(OE, OUTPUT);
  digitalWrite(WE, OUTPUT);


}

void binbuf(char *buf, uint8_t data) {
  int bufpos = 0;
  for (int i = 7; i >= 0; i--) {
    buf[bufpos++] = data & (1<<i) ? '1' : '0';
  }
  buf[bufpos] = 0;
}

uint8_t performTest(uint8_t bitmask) {
  Serial.print("RAM check initialized with bitmask: ");
  Serial.println(bitmask, BIN);

  int failcount = 0;
  uint8_t failbits = 0;

  char buf[0x100] = {0};
  

  for (uint16_t i = 0; i < 0x8000; i++) {
    setAddr(i);
    uint8_t wData = random(1, 0x100) & bitmask;
    writeData(wData);
    uint8_t rData = readData() & bitmask;

    if (rData != wData) {
      failcount++;
      failbits |= (rData ^ wData);
    }

    if (i % 0x1000 == 0) {
      Serial.println(i);
    }
  }
  
  sprintf(buf, "RAM check done. Failure count = %d.", failcount);
  Serial.println(buf);

  binbuf(buf, failbits);
  Serial.print("Failed bits: ");
  Serial.println(buf);
  return failbits;
}

void loop() {
  while (!Serial.available());
  Serial.read();

  uint8_t failedBits = performTest(0xff);
  if (failedBits) {
    performTest(~failedBits);
  }
}

