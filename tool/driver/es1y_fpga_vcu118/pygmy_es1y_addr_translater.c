#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <vector>
#include <string>
#include <string.h>
#include <map>

#include "common.h"

std::map<std::string, uint8_t> orid_map = {
  {"rb",      0b100000},
  {"mmem",    0b100001},
  {"mp",      0b100010},
  {"ddr",     0b100011},
  {"dt",      0b100101},
  {"dma",     0b100111},
  {"l2_vld",  0b101000},
  {"l2_dirty",0b101001},
  {"l2_tag",  0b101010},
  {"l2_data", 0b101011},
  {"l2_lru",  0b101100},
  {"l2_hpm",  0b101101}
};


uint64_t addr2oraddr (std::string target, uint64_t addr) {
  uint64_t oraddr = 0;
  uint64_t base_addr = 0;
  uint64_t sram_offset = 0;

  if (target.substr(0, 2) == "l2") {
    int dch = (addr >> 3) & 0x3; // 2 bits
    if ((target.substr(3, 3) == "vld") || (target.substr(3, 3) == "tag")) {
      dch = 0;
    }
    int bid = (addr >> 5) & 0x3; // 2 bits
    int bix = (addr >> 7) & 0x1ff; // 9 bits
    int wid = (addr >> 16) & 0x7; // 3 bits

    // Identify base addr
    switch (bid) {
      case 0:
        base_addr = STATION_CACHE_BASE_ADDR_0;
        break;
      case 1:
        base_addr = STATION_CACHE_BASE_ADDR_1;
        break;
      case 2:
        base_addr = STATION_CACHE_BASE_ADDR_2;
        break;
      case 3:
        base_addr = STATION_CACHE_BASE_ADDR_3;
        break;
    }


    // Translate sram offset
    if (target.substr(3,3) == "vld") {
      sram_offset = STATION_CACHE_DBG_VLDRAM_OFFSET;
    } else if (target.substr(3,5) == "dirty") {
      sram_offset = STATION_CACHE_DBG_DIRTYRAM_OFFSET;
    } else if (target.substr(3,3) == "tag") {
      sram_offset = STATION_CACHE_DBG_TAGRAM_OFFSET;
    } else if (target.substr(3,4) == "data") {
      sram_offset = STATION_CACHE_DBG_DATARAM_OFFSET;
    } else if (target.substr(3,3) == "lru") {
      sram_offset = STATION_CACHE_DBG_LRURAM_OFFSET;
    } else if (target.substr(3,3) == "hpm") {
      sram_offset = STATION_CACHE_DBG_HPM_OFFSET;
    }

    // Form new addr
    oraddr = base_addr + sram_offset + (((((wid <<  2) + dch) << 9) + bix) << 3);
  } else if (target.substr(0, 2) == "dt") {
    int orid = orid_map[target];
    oraddr += orid;
    oraddr = (oraddr << 31) + (addr >> 3);
    oraddr = (oraddr << 3) + 0x5;
  } else if (target == "mmem") {
    int orid = orid_map[target];
    oraddr += orid;
    oraddr = (oraddr << 34) + ((addr >> 3) << 3);
  } else if (target == "dma") {
    int orid = orid_map[target];
    oraddr += orid;
    oraddr = (oraddr << 31) + (addr >> 3);
    oraddr = (oraddr << 3) + 0x3;
  }
  return oraddr;
}

