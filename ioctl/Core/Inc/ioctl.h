#ifndef IOCTL_H
#define IOCTL_H

#define IOCTL_CMD_TOKLEN 10

#include <math.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include "main.h"
#include "tim.h"
#include "spi.h"
#include "usbd_cdc_if.h"

struct ioctl_options {
  bool untilHalt;
  bool tickMode;
  bool tickReset;
  uint32_t maxTicks;
};

void ioctl_init(void);

void ioctl_cdc_rx_callback(char *buf, size_t bufsz);
bool ioctl_cmd_available();
void ioctl_cmd_handle();

void ioctl_clk_set_freq(uint32_t freq);
void ioctl_clk_pulse_callback();
void ioctl_clk_start();
void ioctl_clk_stop();
void ioctl_reset_cpu();

void ioctl_bus_ctl_input();
void ioctl_bus_ctl_output();
void ioctl_bus_acquire();
void ioctl_bus_release();
bool ioctl_bus_acquired();

uint16_t ioctl_read_addr();
uint8_t ioctl_read_data();
void ioctl_write_addr(uint16_t addr);
void ioctl_write_data(uint8_t data);
void ioctl_write_addr_data(uint8_t addr_h, uint8_t addr_l, uint8_t data);

void ioctl_max7219_init();
void ioctl_max7219_shutdown();
void ioctl_max7219_write(uint8_t disp, uint8_t addr, uint8_t data);

void ioctl_segdisp_write(uint8_t addr, uint8_t data);
void ioctl_segdisp_init();
void ioctl_segdisp_set_addr(uint16_t addr);
void ioctl_segdisp_set_data(uint8_t data);

#endif
