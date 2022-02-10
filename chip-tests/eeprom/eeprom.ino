#include <Wire.h>
#include "eeprom.h"

void setup()
{
  Serial.begin(115200);
  Wire.begin();

  eeprom_write(0x1004, 0xaa);

  delay(100);
  Serial.println(eeprom_read(0x1004));
}

void loop()
{

}
