
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "socket_server.h"
#include "station_dma.h"
#include "station_cache.h"

void do_arm2or_write(uint64_t addr, uint64_t data) {
  uint64_t busy = 1;
  uint32_t gpio_addr[5] = {0xa0040000, 0xa0040008, 0xa0040010, 0xa0040018, 0xa0040020};
  write_gpio(gpio_addr[1], 1); // WR CMD
  write_gpio(gpio_addr[2], addr); // REQ ADDR
  write_gpio(gpio_addr[3], data); // WDATA
  write_gpio(gpio_addr[0], 1); // EXE
  while (busy == 1) {
    busy = read_gpio(gpio_addr[0]);
  }
}

uint64_t do_arm2or_read(uint64_t addr) {
  uint64_t busy = 1;
  uint32_t gpio_addr[5] = {0xa0040000, 0xa0040008, 0xa0040010, 0xa0040018, 0xa0040020};
  write_gpio(gpio_addr[1], 0); // WR CMD
  write_gpio(gpio_addr[2], addr); // REQ ADDR
  write_gpio(gpio_addr[0], 1); // EXE
  while (busy == 1) {
    busy = read_gpio(gpio_addr[0]);
  }
  return (read_gpio(gpio_addr[4]));
}

void do_dma_write(uint64_t addr, uint64_t data) {
  uint64_t dma_cmd_vld = 1;
  do_arm2or_write(STATION_DMA_S2B_DMA_DEBUG_ADDR_ADDR, addr);
  do_arm2or_write(STATION_DMA_S2B_DMA_DEBUG_REQ_TYPE_ADDR, 2);
  do_arm2or_write(STATION_DMA_S2B_DMA_DEBUG_WR_DATA_ADDR, data);
  do_arm2or_write(STATION_DMA_DMA_DEBUG_CMD_VLD_ADDR, dma_cmd_vld);
  while (dma_cmd_vld == 1) {
    dma_cmd_vld = do_arm2or_read(STATION_DMA_DMA_DEBUG_CMD_VLD_ADDR);
  }
}

uint64_t do_dma_read(uint64_t addr) {
  uint64_t dma_cmd_vld = 1;
  do_arm2or_write(STATION_DMA_S2B_DMA_DEBUG_ADDR_ADDR, addr);
  do_arm2or_write(STATION_DMA_S2B_DMA_DEBUG_REQ_TYPE_ADDR, 0);
  do_arm2or_write(STATION_DMA_DMA_DEBUG_CMD_VLD_ADDR, dma_cmd_vld);
  while (dma_cmd_vld == 1) {
    dma_cmd_vld = do_arm2or_read(STATION_DMA_DMA_DEBUG_CMD_VLD_ADDR);
  }
  return (do_arm2or_read(STATION_DMA_B2S_DMA_DEBUG_RDATA_ADDR));
}

int main() {
  char line[1024];
  FILE * f = fopen("./test_bbl.hex", "r");
  char * p;
  uint32_t ret[2];
  uint64_t val;
  uint64_t addr = 0x80000000;

  if (f == NULL)
    exit(EXIT_FAILURE);

  open_fd();

  system("date");

  do_arm2or_write(STATION_CACHE_S2B_RSTN_ADDR_0, 1);
  do_arm2or_write(STATION_CACHE_S2B_RSTN_ADDR_1, 1);
  do_arm2or_write(STATION_CACHE_S2B_RSTN_ADDR_2, 1);
  do_arm2or_write(STATION_CACHE_S2B_RSTN_ADDR_3, 1);

  while (1) {
    fgets(line, 1024, f);
    ret[0] = strtoul(line, &p, 16);
    fgets(line, 1024, f);
    ret[1] = strtoul(line, &p, 16);
    val = ret[1];
    val = (val << 32) + ret[0];
    printf("addr = %llx, val = %llx\n", addr, val);
    do_dma_write(addr, val);
    addr = addr + 8;
    if (feof(f))
      break;
  }

  system("date");

  fclose(f);

  exit(EXIT_SUCCESS);
}


