#define CLK 52
#define RST 50
#define HLT 48
#define NMI 46
#define INT 44

#define DEL 100

int del = DEL;
int ticks = 0;
bool untilHalt = false;
bool interrupt = false;
int interrupt_type = NMI;


void delayMilliseconds(int ms) {
  delay(ms);
}

void (*delfunc)(int) = delayMicroseconds;

void setup()
{
  Serial.begin(115200);
  Serial1.begin(115200);
  pinMode(CLK, OUTPUT);
  pinMode(RST, OUTPUT);
  pinMode(HLT, INPUT);
  pinMode(NMI, OUTPUT);
  pinMode(INT, OUTPUT);
  digitalWrite(RST, HIGH);
  digitalWrite(NMI, HIGH);
  digitalWrite(INT, HIGH);
}

void check_interrupt() {
  if (interrupt) {
    int cycles = interrupt_type == NMI ? 1 : 30;
    digitalWrite(interrupt_type, LOW);
    for (int i = 0; i < cycles; i++) {
      digitalWrite(CLK, HIGH);
      delfunc(del);
      digitalWrite(CLK, LOW);
      delfunc(del);
      digitalWrite(interrupt_type, HIGH);
    }
    interrupt = false;
  }
}

void loop()
{
  static char buf[0x100] = {0};
  static int bufpos = 0;
  //static char inbuf[0x400] = {0};
  //static int inbufpos = 0;

  if (Serial1.available()) {
    char c = Serial1.read();
    Serial.write(c);
  }

  if (Serial.available()) {
    char c = Serial.read();

    if (c == '\n') {
      buf[bufpos] = 0;
      bufpos = 0;

      if (strcmp(buf, "t") == 0) {
        ticks = 1;
      } else if (buf[0] == 't') {
        ticks = atoi(buf+1);
      } else if (buf[0] == 'c') {
        del = atoi(buf+1);
      } else if (buf[0] == 'r') {
        ticks = 4;
        digitalWrite(RST, LOW);
      } else if (buf[0] == 'h') {
        untilHalt = true;
      } else if (buf[0] == 'u') {
        delfunc = delayMicroseconds;
      } else if (buf[0] == 'm') {
        delfunc = delayMilliseconds;
      } else if (buf[0] == 'n') {
        interrupt = true;
        interrupt_type = NMI;
      } else if (buf[0] == 'i') {
        interrupt = true;
        interrupt_type = INT;
      } else if (buf[0] == 's') {
        untilHalt = false;
      } else if (buf[0] == 'w') {
        Serial1.print(buf+1);
      }
    } else {
      buf[bufpos++] = c;
    }
  }

  if (untilHalt && digitalRead(HLT)) {
    digitalWrite(CLK, HIGH);
    delfunc(del);
    digitalWrite(CLK, LOW);
    delfunc(del);
    check_interrupt();
  } else if (untilHalt) {
    untilHalt = false;
  } else if (ticks > 0) {
    digitalWrite(CLK, HIGH);
    delfunc(del);
    digitalWrite(CLK, LOW);
    delfunc(del);
    check_interrupt();
    ticks--;
  }

  if (!ticks) {
    digitalWrite(RST, HIGH);
  }
}
