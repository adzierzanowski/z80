#include "ioctl.h"

static struct ioctl_options options = {
  .untilHalt = false,
  .tickMode = true,
  .tickReset = false,
  .maxTicks = 4
};
static struct ioctl_options *opts = &options;
static char cmd0[IOCTL_CMD_TOKLEN] = {0};
static char cmd1[IOCTL_CMD_TOKLEN] = {0};
static char cmd2[IOCTL_CMD_TOKLEN] = {0};
static char cmd3[IOCTL_CMD_TOKLEN] = {0};
static bool cmd_available = false;

bool ioctl_cmd_available() {
  return cmd_available;
}

void ioctl_init(void) {
  HAL_GPIO_WritePin(RST_GPIO_Port, RST_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(NMI_GPIO_Port, NMI_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(INT_GPIO_Port, INT_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(WAIT_GPIO_Port, WAIT_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(BUSRQ_GPIO_Port, BUSRQ_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(BUS_PL_GPIO_Port, BUS_PL_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(BUS_CP_GPIO_Port, BUS_CP_Pin, GPIO_PIN_RESET);
  HAL_GPIO_WritePin(SEGDISP_CS_GPIO_Port, SEGDISP_CS_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(TFT_CS_GPIO_Port, TFT_CS_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(BUS_CS_GPIO_Port, BUS_CS_Pin, GPIO_PIN_SET);
}

void ioctl_cdc_rx_callback(char *buf, size_t bufsz) {
  const char *sep = " \n";
  cmd_available = true;
  memset(cmd0, 0, IOCTL_CMD_TOKLEN);
  memset(cmd1, 0, IOCTL_CMD_TOKLEN);
  memset(cmd2, 0, IOCTL_CMD_TOKLEN);
  memset(cmd3, 0, IOCTL_CMD_TOKLEN);

  char *tok = strtok(buf, sep);
  if (!tok) return;
  strcpy(cmd0, tok);

  tok = strtok(NULL, sep);
  if (!tok) return;
  strcpy(cmd1, tok);

  tok = strtok(NULL, sep);
  if (!tok) return;
  strcpy(cmd2, tok);

  tok = strtok(NULL, sep);
  if (!tok) return;
  strcpy(cmd3, tok);
}

void ioctl_cmd_handle() {
  cmd_available = false;
  const char *ack_str = "ack \n";
  const char *nack_str = "nack\n";
  bool ack = false;

  if (!strcmp(cmd0, "clk")) {
    if (!strcmp(cmd1, "start")) {
      ioctl_clk_start();
      ack = true;
    } else if (!strcmp(cmd1, "stop")) {
      ioctl_clk_stop();
      ack = true;
    } else if (cmd1[0] != 0) {
      uint32_t freq = strtoll(cmd1, NULL, 10);
      ioctl_clk_set_freq(freq);
      ack = true;
    }

  } else if (!strcmp(cmd0, "tick") || !strcmp(cmd0, "t")) {
    uint32_t tickCount = 1;
    if (cmd1[0] != 0) {
      tickCount = strtoll(cmd1, NULL, 10);
    }

    options.tickMode = true;
    options.maxTicks = tickCount;
    options.tickReset = false;
    ioctl_clk_start();
    ack = true;

  } else if (!strcmp(cmd0, "rst")) {
    ioctl_reset_cpu();
    ack = true;

  } else if (!strcmp(cmd0, "bus")) {
    if (!strcmp(cmd1, "acq")) {
      ioctl_bus_acquire();
      ack = true;
    } else if (!strcmp(cmd1, "rel")) {
      ioctl_max7219_shutdown();
      ioctl_bus_release();
      ack = true;
    }

  } else if (!strcmp(cmd0, "max")) {
    if (!strcmp(cmd1, "on")) {
      ack = ioctl_bus_acquired();
      if (ack) {
        ioctl_max7219_init();
      }
    } else if (!strcmp(cmd1, "off")) {
      ioctl_max7219_shutdown();
      ack = true;
    }

  } else if (!strcmp(cmd0, "wa")) {
    if (cmd1[0] != 0 && ioctl_bus_acquired()) {
      uint16_t val = strtol(cmd1, NULL, 16);
      ioctl_write_addr(val);
      ack = true;
    }

  } else if (!strcmp(cmd0, "wd") && ioctl_bus_acquired()) {
    if (cmd1[0] != 0) {
      uint8_t val = strtol(cmd1, NULL, 16);
      ioctl_write_data(val);
      ack = true;
    }

  } else if (!strcmp(cmd0, "ram")) {
    if (!strcmp(cmd1, "wr")) {
      HAL_GPIO_WritePin(MEMRQ_GPIO_Port, MEMRQ_Pin, GPIO_PIN_RESET);
      HAL_Delay(10);
      HAL_GPIO_WritePin(WR_GPIO_Port, WR_Pin, GPIO_PIN_RESET);
      HAL_Delay(10);
      HAL_GPIO_WritePin(WR_GPIO_Port, WR_Pin, GPIO_PIN_SET);
      HAL_Delay(10);
      HAL_GPIO_WritePin(MEMRQ_GPIO_Port, MEMRQ_Pin, GPIO_PIN_SET);
      ack = true;
    }

  } else if (!strcmp(cmd0, "ra")) {
    char buf[IOCTL_CMD_TOKLEN] = {0};
    uint16_t addr = ioctl_read_addr();
    sprintf(buf, "0x%4x\n", addr);
    CDC_Transmit_FS((uint8_t *) buf, strlen(buf));
    ack = true;

  } else if (!strcmp(cmd0, "rd")) {
    char buf[IOCTL_CMD_TOKLEN] = {0};
    uint8_t data = ioctl_read_data();
    sprintf(buf, "0x%2x\n", data);
    CDC_Transmit_FS((uint8_t *) buf, strlen(buf));
    ack = true;
  }

  CDC_Transmit_FS((uint8_t *) (ack ? ack_str : nack_str), 5);
}

void ioctl_clk_set_freq(uint32_t freq) {
  if (freq == 0) {
    ioctl_clk_stop();
    return;
  }

  const uint32_t cpuf = HAL_RCC_GetSysClockFreq();
  const uint32_t fratio = cpuf / freq;
  const uint32_t limit = fmin(sqrt(fratio), 0xffff);

  uint32_t largestFactor = 1;
  for (uint32_t i = 2; i < limit; i++) {
    if (fratio % i == 0) {
      largestFactor = i;
    }
  }

  const uint16_t arr = fratio / largestFactor - 1;
  const uint16_t psc = largestFactor - 1;

  TIM16->ARR = arr;
  TIM16->PSC = psc;
  TIM16->CCR1 = arr / 2;
}

void ioctl_clk_pulse_callback() {
  static uint32_t ticks = 0;
  ticks++;

  if (options.tickMode && (ticks >= options.maxTicks)) {
    ioctl_clk_stop();
    ticks = 0;
    opts->tickMode = false;
    if (options.tickReset) {
      HAL_GPIO_WritePin(RST_GPIO_Port, RST_Pin, GPIO_PIN_SET);
      opts->tickReset = false;
    }
  }
}

void ioctl_clk_start() {
  HAL_TIM_PWM_Start_IT(&htim16, TIM_CHANNEL_1);
}

void ioctl_clk_stop() {
  HAL_TIM_PWM_Stop_IT(&htim16, TIM_CHANNEL_1);
}

void ioctl_reset_cpu() {
  HAL_GPIO_WritePin(RST_GPIO_Port, RST_Pin, GPIO_PIN_RESET);
  opts->tickMode = true;
  opts->tickReset = true;
  opts->maxTicks = 4;
  ioctl_clk_set_freq(4);
  ioctl_clk_start();
}

static uint8_t _gpio_mask_pos(uint16_t pin) {
  for (int i = 0; i < 16; i++) {
    if (pin & (1 << i)) {
      return i;
    }
  }
  return 0xff;
}

// Set input mode for MRQ, IRQ, RD, WR pins
void ioctl_bus_ctl_input() {
  MEMRQ_GPIO_Port->MODER &= ~(0b11 << (_gpio_mask_pos(MEMRQ_Pin) * 2));
  IORQ_GPIO_Port->MODER &= ~(0b11 << (_gpio_mask_pos(IORQ_Pin) * 2));
  RD_GPIO_Port->MODER &= ~(0b11 << (_gpio_mask_pos(RD_Pin) * 2));
  WR_GPIO_Port->MODER &= ~(0b11 << (_gpio_mask_pos(WR_Pin) * 2));
}

// Set output mode for MRQ, IRQ, RD, WR pins
void ioctl_bus_ctl_output() {
  MEMRQ_GPIO_Port->MODER |= (0b01 << (_gpio_mask_pos(MEMRQ_Pin) * 2));
  IORQ_GPIO_Port->MODER |= (0b01 << (_gpio_mask_pos(IORQ_Pin) * 2));
  RD_GPIO_Port->MODER |= (0b01 << (_gpio_mask_pos(RD_Pin) * 2));
  WR_GPIO_Port->MODER |= (0b01 << (_gpio_mask_pos(WR_Pin) * 2));

  HAL_GPIO_WritePin(MEMRQ_GPIO_Port, MEMRQ_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(IORQ_GPIO_Port, IORQ_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(RD_GPIO_Port, RD_Pin, GPIO_PIN_SET);
  HAL_GPIO_WritePin(WR_GPIO_Port, WR_Pin, GPIO_PIN_SET);
}

void ioctl_bus_acquire() {
  HAL_GPIO_WritePin(BUSRQ_GPIO_Port, BUSRQ_Pin, GPIO_PIN_RESET);
  ioctl_clk_start();
  while (HAL_GPIO_ReadPin(BUSACK_GPIO_Port, BUSACK_Pin));
  ioctl_clk_stop();
  ioctl_bus_ctl_output();
  CDC_Transmit_FS((uint8_t *) "Bus acquired\n", 13);
}

bool ioctl_bus_acquired() {
  return !HAL_GPIO_ReadPin(BUSACK_GPIO_Port, BUSACK_Pin);
}

void ioctl_bus_release() {
  ioctl_bus_ctl_input();
  HAL_GPIO_WritePin(BUSRQ_GPIO_Port, BUSRQ_Pin, GPIO_PIN_SET);
}

uint16_t ioctl_read_addr() {
  HAL_GPIO_WritePin(BUS_PL_GPIO_Port, BUS_PL_Pin, GPIO_PIN_RESET);
  HAL_GPIO_WritePin(BUS_PL_GPIO_Port, BUS_PL_Pin, GPIO_PIN_SET);

  uint8_t ah = 0;
  uint8_t al = 0;

  for (int i = 0; i < 8; i++) {
    ah |= HAL_GPIO_ReadPin(BUS_AH_GPIO_Port, BUS_AH_Pin) << i;
    al |= HAL_GPIO_ReadPin(BUS_AL_GPIO_Port, BUS_AL_Pin) << i;

    HAL_GPIO_WritePin(BUS_CP_GPIO_Port, BUS_CP_Pin, GPIO_PIN_RESET);
    HAL_Delay(1);
    HAL_GPIO_WritePin(BUS_CP_GPIO_Port, BUS_CP_Pin, GPIO_PIN_SET);
  }

  return (ah << 8) | al;
}

uint8_t ioctl_read_data() {
  HAL_GPIO_WritePin(BUS_PL_GPIO_Port, BUS_PL_Pin, GPIO_PIN_RESET);
  asm volatile ("nop");
  HAL_GPIO_WritePin(BUS_PL_GPIO_Port, BUS_PL_Pin, GPIO_PIN_SET);

  uint8_t data = 0;

  for (int i = 0; i < 8; i++) {
    data |= HAL_GPIO_ReadPin(BUS_D_GPIO_Port, BUS_D_Pin) << i;
    HAL_GPIO_WritePin(BUS_CP_GPIO_Port, BUS_CP_Pin, GPIO_PIN_RESET);
    asm volatile ("nop");
    HAL_GPIO_WritePin(BUS_CP_GPIO_Port, BUS_CP_Pin, GPIO_PIN_SET);
  }

  return data;
}

void ioctl_write_addr(uint16_t addr) {
  ioctl_max7219_write(1, 0x01, (addr >> 8) & 0xff);
  ioctl_max7219_write(2, 0x01, addr & 0xff);
}

void ioctl_write_data(uint8_t data) {
  ioctl_max7219_write(0, 0x01, data);
}

void ioctl_max7219_init() {
  for (int i = 0; i < 3; i++) {
    ioctl_max7219_write(i, 0x0c, 0x01); // shutdown off
    ioctl_max7219_write(i, 0x0a, 0x0f); // intensity
    ioctl_max7219_write(i, 0x0b, 0x00); // scan limit
    ioctl_max7219_write(i, 0x01, 0xaa); // scan limit
  }
}

void ioctl_max7219_write(uint8_t disp, uint8_t addr, uint8_t data) {
  uint8_t out[6] = {0};
  int offset = 6 - disp * 2 - 2;
  out[offset] = addr;
  out[offset+1] = data;

  HAL_GPIO_WritePin(BUS_CS_GPIO_Port, BUS_CS_Pin, GPIO_PIN_RESET);
  __NOP();
  __NOP();
  __NOP();
  __NOP();
  HAL_SPI_Transmit(&hspi1, out, 6, 100);
  __NOP();
  __NOP();
  __NOP();
  __NOP();
  HAL_GPIO_WritePin(BUS_CS_GPIO_Port, BUS_CS_Pin, GPIO_PIN_SET);
}

void ioctl_write_addr_data(uint8_t addr_h, uint8_t addr_l, uint8_t data) {
  ioctl_max7219_write(0, 0x01, data);
  ioctl_max7219_write(1, 0x01, data);
  ioctl_max7219_write(2, 0x01, data);
}

void ioctl_max7219_shutdown() {
  ioctl_max7219_write(0, 0x0c, 0x00);
  ioctl_max7219_write(1, 0x0c, 0x00);
  ioctl_max7219_write(2, 0x0c, 0x00);
}

void ioctl_segdisp_write(uint8_t addr, uint8_t data) {
  uint8_t out[2] = {addr, data};
  HAL_GPIO_WritePin(SEGDISP_CS_GPIO_Port, SEGDISP_CS_Pin, GPIO_PIN_RESET);
  HAL_SPI_Transmit(&hspi1, out, 2, 100);
  HAL_GPIO_WritePin(SEGDISP_CS_GPIO_Port, SEGDISP_CS_Pin, GPIO_PIN_SET);
}

static const uint8_t _segdisp_mapping[] = {
  0b01111110, 0b00110000, 0b01101101, 0b01111001,
  0b00110011, 0b01011011, 0b01011111, 0b01110000,
  0b01111111, 0b01111011, 0b01110111, 0b00011111,
  0b01001110, 0b00111101, 0b01001111, 0b01000111
};

void ioctl_segdisp_init() {
  ioctl_segdisp_write(0x0a, 0x0f); // intensity
  ioctl_segdisp_write(0x0b, 0x05); // scan limit
  ioctl_segdisp_write(0x0c, 0b01); // shutdown off
}

void ioctl_segdisp_set_addr(uint16_t addr) {
  uint8_t a0 = addr & 0xff;
  uint8_t a1 = addr >> 8;

  uint8_t a0h = a0 >> 4;
  uint8_t a0l = a0 & 0xf;
  uint8_t a1h = a1 >> 4;
  uint8_t a1l = a1 & 0xf;

  ioctl_segdisp_write(0x05, _segdisp_mapping[a1h]);
  ioctl_segdisp_write(0x06, _segdisp_mapping[a1l]);
  ioctl_segdisp_write(0x03, _segdisp_mapping[a0h]);
  ioctl_segdisp_write(0x04, _segdisp_mapping[a0l]);
}

void ioctl_segdisp_set_data(uint8_t data) {
  uint8_t dh = (data >> 4) & 0xf;
  uint8_t dl = data & 0xf;
  ioctl_segdisp_write(0x01, _segdisp_mapping[dh]);
  ioctl_segdisp_write(0x02, _segdisp_mapping[dl]);
}
