#ifndef EEPROM_H
#define EEPROM_H

static const uint8_t addr0 = 0b1010000 | 0b000;
static const uint8_t addr1 = 0b1010000 | 0b100;
static const uint8_t addr2 = 0b1010000 | 0b010;
static const uint8_t addr3 = 0b1010000 | 0b110;


uint8_t eeprom_devaddr(uint16_t vAddr) {
  /// yyyyyeeeah, I've connected address pins the other way around
  return 0b01010000 | ((vAddr / 0x1000) * 2);
}

uint16_t eeprom_memaddr(uint16_t vAddr) {
  return vAddr % 0x1000;
}

void eeprom_write(uint16_t vAddr, uint8_t data) {
  uint8_t i2cAddr = eeprom_devaddr(vAddr);
  uint16_t memAddr = eeprom_memaddr(vAddr);
  uint8_t memAddrH = memAddr >> 8;
  uint8_t memAddrL = memAddr;

  Wire.beginTransmission(i2cAddr);
  Wire.write(memAddrH);
  Wire.write(memAddrL);
  Wire.write(data);
  Wire.endTransmission();
}

uint8_t eeprom_read(uint16_t vAddr) {
  uint8_t i2cAddr = eeprom_devaddr(vAddr);
  uint16_t memAddr = eeprom_memaddr(vAddr);
  uint8_t memAddrH = memAddr >> 8;
  uint8_t memAddrL = memAddr;

  Wire.beginTransmission(i2cAddr);
  Wire.write(memAddrH);
  Wire.write(memAddrL);
  Wire.endTransmission();
  Wire.requestFrom(i2cAddr, 1);

  return Wire.read();
}

#endif
