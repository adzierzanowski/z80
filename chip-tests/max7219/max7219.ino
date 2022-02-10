#include <LedControl.h>

#define LC_DIN 2
#define LC_CLK 3
#define LC_LOAD 4

#define CP 53
#define PL 51
#define DS 49

LedControl lc(LC_DIN, LC_CLK, LC_LOAD, 3);

void initLC(int disp) {
  lc.shutdown(disp, false);
  lc.setIntensity(disp, 0xf);
  lc.setScanLimit(disp, 0);
  lc.clearDisplay(disp);
}

void setup()
{
}

void loop()
{
  initLC(0);
  initLC(1);
  initLC(2);
  lc.setRow(0, 0, 0xaa);
  lc.setRow(1, 0, 0xbb);
  lc.setRow(2, 0, 0xcc);
  delay(100);
}

