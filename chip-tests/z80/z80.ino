#define ADDR0 22
#define ADDRLEN 4
#define DATA0 26
#define CLK 34
#define INT 35
#define NMI 36
#define HALT 37
#define MREQ 38
#define IORQ 39
#define RD 40
#define WR 41
#define BUSAK 42
#define WAIT 43
#define BUSRQ 44
#define RESET 45
#define M1 46
#define REFSH 47


uint8_t ram[0x100] = {0x76, 0};

void setDataMode(int mode) {
  for (int i = 0; i < 8; i++) {
    pinMode(DATA0+i, mode);
  }
}

void writeData(uint8_t val) {
  for (int i = 0; i < 8; i++) {
    digitalWrite(DATA0, (int) !!(val & (1 << i)));
  }
}

uint16_t readAddr() {
  uint16_t addr = 0;

  for (int i = 0; i < ADDRLEN; i++) {
    addr |= digitalRead(ADDR0+i) << i;
  }

  return addr;
}

void printState() {
  char buf[0x100] = {0};

  sprintf(buf, "A:%04x D:%02x %c %c %c %c %c %s %s %s %s %c %s %c %s %s",
    readAddr(),
    ram[readAddr()],
    digitalRead(CLK) ? 'C' : 'c',
    digitalRead(INT) ? 'I' : 'i',
    digitalRead(NMI) ? 'N' : 'n',
    digitalRead(HALT) ? 'H' : 'h',
    digitalRead(MREQ) ? 'M' : 'm',
    digitalRead(IORQ) ? "IO" : "io",
    digitalRead(RD) ? "RD" : "rd",
    digitalRead(WR) ? "WR" : "wr",
    digitalRead(BUSAK) ? "BA" : "ba",
    digitalRead(WAIT) ? 'W' : 'w',
    digitalRead(BUSRQ) ? "BR" : "br",
    digitalRead(RESET) ? 'R' : 'r',
    digitalRead(M1) ? "M1" : "m1",
    digitalRead(REFSH) ? "RF" : "rf"
  );

  Serial.println(buf);
}

void setup()
{
  Serial.begin(115200);

  setDataMode(INPUT);

  for (int i = 0; i < ADDRLEN; i++) {
    pinMode(ADDR0+i, INPUT);
  }

  pinMode(CLK, OUTPUT);
  pinMode(INT, OUTPUT);
  pinMode(NMI, OUTPUT);
  pinMode(WAIT, OUTPUT);
  pinMode(BUSRQ, OUTPUT);
  pinMode(RESET, OUTPUT);

  digitalWrite(CLK, HIGH);
  digitalWrite(INT, HIGH);
  digitalWrite(NMI, HIGH);
  digitalWrite(WAIT, HIGH);
  digitalWrite(BUSRQ, HIGH);
  digitalWrite(RESET, HIGH);

  reset();
}

void reset() {
  digitalWrite(RESET, LOW);
  printState();
  for (int i = 0; i < 4; i++) {
    digitalWrite(CLK, LOW);
    delay(1);
    printState();
    digitalWrite(CLK, HIGH);
    delay(1);
    printState();
  }
  digitalWrite(RESET, HIGH);
  printState();
}

void loop()
{
  digitalWrite(CLK, !digitalRead(CLK));

  if (digitalRead(RD)) {
    setDataMode(INPUT);
  }

  else if (!digitalRead(MREQ) && !digitalRead(RD)) {
    setDataMode(OUTPUT);
    writeData(ram[readAddr()]);
  }

  printState();
  while (!Serial.available());
  Serial.read();
}
