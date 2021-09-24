#include "dtm.h"
#include "memif.h"
#include "debug_defines.h"
#include "encoding.h"
#include "es1y.h"
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <pthread.h>
#include <sys/socket.h>
#ifndef SNAP_PERIOD
#  define SNAP_PERIOD 40000000
#endif

#ifndef PLIC_PERIOD
#  define PLIC_PERIOD 100
#endif


void es1y::bg() {
  enum bg_target_e {
    SLOW_IO,
    DDR,
    USB,
    SDIO,
    ORV32,
    VP,
    FLUSH,
    FLASH,
    IDLE
  };

  std::map<int, int> bg_target_weight_map = {
    {SLOW_IO, 40},
    {DDR,     20 * this->ht->argmap["reset_ddr"].length() > 0},
    {USB,     20},
    {SDIO,    20},
    {ORV32,   20 * (this->ht->argmap["release_orv32_reset"].length() > 0)},
    {VP,      20 * (this->ht->argmap["release_vp0_reset"].length() > 0)},
    {FLUSH,   20},
    {FLASH,   20 * (this->ht->argmap["enable_flash_fsm"].length() > 0)},
    {IDLE,    10},
  };

  enum bg_target_slow_io_e {
    QSPIM,
    SSPIM0,
    SSPIM1,
    SSPIM2,
    SPIS,
    UART0,
    UART1,
    UART2,
    UART3,
    I2SM,
    I2SS0,
    I2SS1,
    I2SS2,
    I2SS3,
    I2SS4,
    I2SS5,
    I2C0,
    I2C1,
    I2C2,
    GPIO,
    RTC,
    TIMERS,
    WDT
  };

  std::map<int, int> bg_target_slow_io_weight_map = {
    {QSPIM,   10},
    {SSPIM0,  10},
    {SSPIM1,  10},
    {SSPIM2,  10},
    {SPIS,    10},
    {UART0,   10},
    {UART1,   10},
    {UART2,   10},
    {UART3,   10},
    {I2SM,    10},
    {I2SS0,   10},
    {I2SS1,   10},
    {I2SS2,   10},
    {I2SS3,   10},
    {I2SS4,   10},
    {I2SS5,   10},
    {I2C0,    10},
    {I2C1,    10},
    {I2C2,    10},
    {GPIO,    10},
    {RTC,     10},
    {TIMERS,  10},
    {WDT,     10}
  };
  enum bg_target_ddr_e {
    CTRL,
    PHY,
    SRAM,
    MR
  };

  std::map<int, int> bg_target_ddr_weight_map = {
    {CTRL,  10},
    {PHY,   10},
    {SRAM,  10},
    {MR,    10 * (this->ht->argmap["reset_ddr"].length() > 0)}
  };

  enum bg_target_orv32_e {
    ORV32_ITB,
    ORV32_PC,
    ORV32_MISC,
    ORV32_HPM,
    ORV32_PIPE
  };

  std::map<int, int> bg_target_orv32_weight_map = {
    {ORV32_ITB,  10},
    {ORV32_PC,   10},
    {ORV32_MISC, 10},
    {ORV32_HPM,  10},
    {ORV32_PIPE, 10}
  };

  enum bg_target_orv64_e {
    VP_ITB,
    VP_IC,
    VP_IBUF,
    VP_ITLB,
    VP_DTLB,
    VP_VTLB,
    VP_PC,
    VP_PIPE,
    VP_MISC,
    VP_HPM,
    VP_PMU
  };

  std::map<int, int> bg_target_orv64_weight_map = {
    {VP_ITB,  10},
    {VP_IC,   10 * (this->ht->argmap["ic_bypass"].length() > 0)},
    {VP_PC,   10},
    {VP_IBUF, 10},
    {VP_ITLB, 10},
    {VP_DTLB, 10},
    {VP_VTLB, 10},
    {VP_PIPE, 10},
    {VP_MISC, 10},
    {VP_HPM,  10},
    {VP_PMU,  10}
  };

  enum bg_target_flush_e {
    FLUSH_ADDR,
    FLUSH_IDX,
    FLUSH_ALL
  };

  std::map<int, int> bg_target_flush_weight_map = {
    {FLUSH_ADDR,  20},
    {FLUSH_IDX,   20},
    {FLUSH_ALL,  1}
  };

  uint64_t wdata;
  uint64_t rdata = 0;
  uint64_t addr;
  uint64_t orig_data = 0;
  int todo = weighted_random(bg_target_weight_map);
  //fprintf (stderr, "BG: todo = %0d\n", todo);
  int target;
  if (this->ht->argmap["snapshot"].length() > 0) {
    //this->ht->OURSBUS_READ_4B(STATION_VP_MINSTRET_ADDR_0, rdata);
    this->ht->OURSBUS_READ(STATION_VP_MINSTRET_ADDR_0, rdata);
    if ((this->ht->debug_interrupt) && (rdata == (SNAP_PERIOD * this->ht->count))) {
      this->ht->debug_interrupt = false;
      fprintf(stderr, "Sending debug interrupt %d\n", this->ht->count);
      // Issue dbg interrupt
      //this->ht->OURSBUS_WRITE(0x02002000, 1);
      this->ht->OURSBUS_WRITE(0x00802000, 1);
      this->ht->count++;
      this->ht->idle();
    } else {
      this->ht->idle();
    }
  } else if (this->ht->argmap["plic_interrupt"].length() > 0) {
    this->ht->OURSBUS_READ(STATION_VP_MINSTRET_ADDR_0, rdata);
    if ((this->ht->debug_interrupt) && (rdata == (PLIC_PERIOD * this->ht->count))) {
      fprintf(stderr, "plic interrupt\n");
      this->ht->debug_interrupt = false;
      this->ht->OURSBUS_WRITE(STATION_DMA_S2B_PLIC_INTR_EN_ADDR__DEPTH_0, 0x1); // Enable intr src 0
      this->ht->OURSBUS_WRITE(STATION_DMA_S2B_PLIC_INTR_CORE_ID_ADDR__DEPTH_0, 0x0); // CORE 0 handle the interrupt
      this->ht->OURSBUS_WRITE(STATION_DMA_S2B_PLIC_DBG_EN_ADDR__DEPTH_0, 0x1); // Trigger dbg intr src 0
      this->ht->count++;
      this->ht->idle();
    } else {
      this->ht->idle();
    }
  } else if (this->ht->argmap["test_scan_f"].length() > 0) {
    fprintf(stderr, "Start Testing Scan Function Mode\n");
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_DEBUG_STALL_ADDR_0, 1);
    this->ht->OURSBUS_WRITE(0xfffffff000, rdata);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_DEBUG_STALL_ADDR_0, 0);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_DEBUG_RESUME_ADDR_0, 1);
    fprintf(stderr, "Done Testing Scan Function Mode\n");
  } else if (this->ht->argmap["test_scu"].length() > 0) {
    fprintf(stderr, "Start Stopping PLL CLK\n");
    if (random() % 100 < 50)
      this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_LP_MODE_ADDR, 0x1);
    else
      this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_LP_MODE_ADDR, 0x2);
    fprintf(stderr, "Done PLL CLK BG\n");
  } else {
    switch (static_cast<bg_target_e>(todo)) {
      case SLOW_IO:
        target = weighted_random(bg_target_slow_io_weight_map);
        switch (static_cast<bg_target_slow_io_e>(target)) {
          case QSPIM:
            // QSPIM
            fprintf(stderr, "BG: SLOW IO QSPIM\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_QSPIM_BLOCK_REG_ADDR + 0x5c, rdata);
            if (rdata != 0x3430322a) {
              fprintf(stderr, "Error: qspim version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_QSPIM_BLOCK_REG_ADDR + 0x4, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_QSPIM_BLOCK_REG_ADDR + 0x4, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_QSPIM_BLOCK_REG_ADDR + 0x4, rdata);
            if (rdata != (wdata & 0xffff)) {
              fprintf(stderr, "Error: qspim write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_QSPIM_BLOCK_REG_ADDR + 0x4, orig_data);
            break;
          case SSPIM0:
            // SSPIM0
            fprintf(stderr, "BG: SLOW IO SSPIM0\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 0x5c, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: sspim0 version id wrong, rdata = 0x%x\n", rdata);
            }
            if (this->ht->argmap["enable_flash_fsm"].length() > 0) {
              // Do not write
            } else {
              wdata = random();
              this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 0x4, orig_data);
              this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 0x4, wdata);
              this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 0x4, rdata);
              if (rdata != (wdata & 0xffff)) {
                fprintf(stderr, "Error: sspim0 write access wrong, rdata = 0x%x\n", rdata);
              }
              this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 0x4, orig_data);
            }
            break;
          case SSPIM1:
            // SSPIM1
            fprintf(stderr, "BG: SLOW IO SSPIM1\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM1_BLOCK_REG_ADDR + 0x5c, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: sspim1 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM1_BLOCK_REG_ADDR + 0x4, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SSPIM1_BLOCK_REG_ADDR + 0x4, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM1_BLOCK_REG_ADDR + 0x4, rdata);
            if (rdata != (wdata & 0xffff)) {
              fprintf(stderr, "Error: sspim1 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SSPIM1_BLOCK_REG_ADDR + 0x4, orig_data);
            break;
          case SSPIM2:
            // SSPIM2
            fprintf(stderr, "BG: SLOW IO SSPIM2\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM2_BLOCK_REG_ADDR + 0x5c, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: sspim2 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM2_BLOCK_REG_ADDR + 0x4, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SSPIM2_BLOCK_REG_ADDR + 0x4, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM2_BLOCK_REG_ADDR + 0x4, rdata);
            if (rdata != (wdata & 0xffff)) {
              fprintf(stderr, "Error: sspim2 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SSPIM2_BLOCK_REG_ADDR + 0x4, orig_data);
            break;
          case SPIS:
            // SPIS
            fprintf(stderr, "BG: SLOW IO SPIS\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x5c, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: spis version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x2c, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x2c, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x2c, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: spis write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x2c, orig_data);
            break;
          case UART0:
            // UART0
            fprintf(stderr, "BG: SLOW IO UART0\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART0_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: uart lsr reg reset value wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART0_BLOCK_REG_ADDR + 0x4, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART0_BLOCK_REG_ADDR + 0x4, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART0_BLOCK_REG_ADDR + 0x4, rdata);
            if (rdata != (wdata & 0xf)) {
              fprintf(stderr, "Error: spis write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART0_BLOCK_REG_ADDR + 0x4, orig_data);
            break;
          case UART1:
            // UART1
            fprintf(stderr, "BG: SLOW IO UART1\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART1_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: uart lsr reg reset value wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART1_BLOCK_REG_ADDR + 0x4, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART1_BLOCK_REG_ADDR + 0x4, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART1_BLOCK_REG_ADDR + 0x4, rdata);
            if (rdata != (wdata & 0xf)) {
              fprintf(stderr, "Error: spis write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART1_BLOCK_REG_ADDR + 0x4, orig_data);
            break;
          case UART2:
            // UART2
            fprintf(stderr, "BG: SLOW IO UART2\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART2_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: uart lsr reg reset value wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART2_BLOCK_REG_ADDR + 0x4, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART2_BLOCK_REG_ADDR + 0x4, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART2_BLOCK_REG_ADDR + 0x4, rdata);
            if (rdata != (wdata & 0xf)) {
              fprintf(stderr, "Error: spis write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART2_BLOCK_REG_ADDR + 0x4, orig_data);
            break;
          case UART3:
            // UART3
            fprintf(stderr, "BG: SLOW IO UART3\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART3_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3430312a) {
              fprintf(stderr, "Error: uart lsr reg reset value wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART3_BLOCK_REG_ADDR + 0x4, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART3_BLOCK_REG_ADDR + 0x4, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART3_BLOCK_REG_ADDR + 0x4, rdata);
            if (rdata != (wdata & 0xf)) {
              fprintf(stderr, "Error: spis write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_UART3_BLOCK_REG_ADDR + 0x4, orig_data);
            break;
          case I2SM:
            // I2SM
            fprintf(stderr, "BG: SLOW IO I2SM\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x1f8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: i2sm version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x10, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x10, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x10, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: i2sm write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x10, orig_data);
            break;
          case I2SS0:
            // I2SS0
            fprintf(stderr, "BG: SLOW IO I2SS0\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x1f8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: i2ss0 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x10, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x10, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x10, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: i2ss0 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x10, orig_data);
            break;
          case I2SS1:
            // I2SS1
            fprintf(stderr, "BG: SLOW IO I2SS1\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x1f8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: i2ss1 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x10, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x10, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x10, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: i2ss1 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x10, orig_data);
            break;
          case I2SS2:
            // I2SS2
            fprintf(stderr, "BG: SLOW IO I2SS2\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x1f8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: i2ss2 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x10, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x10, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x10, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: i2ss2 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x10, orig_data);
            break;
          case I2SS3:
            // I2SS3
            fprintf(stderr, "BG: SLOW IO I2SS3\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x1f8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: i2ss3 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x10, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x10, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x10, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: i2ss3 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x10, orig_data);
            break;
          case I2SS4:
            // I2SS4
            fprintf(stderr, "BG: SLOW IO I2SS4\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS4_BLOCK_REG_ADDR + 0x1f8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: i2ss4 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS4_BLOCK_REG_ADDR + 0x10, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS4_BLOCK_REG_ADDR + 0x10, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS4_BLOCK_REG_ADDR + 0x10, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: i2ss4 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS4_BLOCK_REG_ADDR + 0x10, orig_data);
            break;
          case I2SS5:
            // I2SS5
            fprintf(stderr, "BG: SLOW IO I2SS5\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS5_BLOCK_REG_ADDR + 0x1f8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: i2ss5 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS5_BLOCK_REG_ADDR + 0x10, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS5_BLOCK_REG_ADDR + 0x10, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS5_BLOCK_REG_ADDR + 0x10, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: i2ss5 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2SS5_BLOCK_REG_ADDR + 0x10, orig_data);
            break;
          case I2C0:
            // I2C0
            fprintf(stderr, "BG: SLOW IO I2C0\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C0_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3230312a) {
              fprintf(stderr, "Error: i2c0 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C0_BLOCK_REG_ADDR + 0x8, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2C0_BLOCK_REG_ADDR + 0x8, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C0_BLOCK_REG_ADDR + 0x8, rdata);
            if (rdata != (wdata & 0x3ff)) {
              fprintf(stderr, "Error: i2c0 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2C0_BLOCK_REG_ADDR + 0x8, orig_data);
            break;
          case I2C1:
            // I2C1
            fprintf(stderr, "BG: SLOW IO I2C1\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C1_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3230312a) {
              fprintf(stderr, "Error: i2c1 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C1_BLOCK_REG_ADDR + 0x8, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2C1_BLOCK_REG_ADDR + 0x8, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C1_BLOCK_REG_ADDR + 0x8, rdata);
            if (rdata != (wdata & 0x3ff)) {
              fprintf(stderr, "Error: i2c1 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2C1_BLOCK_REG_ADDR + 0x8, orig_data);
            break;
          case I2C2:
            // I2C2
            fprintf(stderr, "BG: SLOW IO I2C2\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C2_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3230312a) {
              fprintf(stderr, "Error: i2c2 version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C2_BLOCK_REG_ADDR + 0x8, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2C2_BLOCK_REG_ADDR + 0x8, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C2_BLOCK_REG_ADDR + 0x8, rdata);
            if (rdata != (wdata & 0x3ff)) {
              fprintf(stderr, "Error: i2c2 write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_I2C2_BLOCK_REG_ADDR + 0x8, orig_data);
            break;
          case GPIO:
            // GPIO
            fprintf(stderr, "BG: SLOW IO GPIO\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x6c, rdata);
            if (rdata != 0x3231322a) {
              fprintf(stderr, "Error: gpio version id wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, orig_data);
            wdata = random();
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, rdata);
            if (rdata != wdata) {
              fprintf(stderr, "Error: gpio write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, orig_data);
            break;
          case RTC:
            // RTC
            fprintf(stderr, "BG: SLOW IO RTC\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_RTC_BLOCK_REG_ADDR + 0x1c, rdata);
            if (rdata != 0x3230362a) {
              fprintf(stderr, "Error: rtc version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_RTC_BLOCK_REG_ADDR + 0xc, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_RTC_BLOCK_REG_ADDR + 0xc, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_RTC_BLOCK_REG_ADDR + 0xc, rdata);
            if (rdata != (wdata & 0x1f)) {
              fprintf(stderr, "Error: rtc write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_RTC_BLOCK_REG_ADDR + 0xc, orig_data);
            break;
          case TIMERS:
            // TIMERS
            fprintf(stderr, "BG: SLOW IO TIMERS\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_TIMERS_BLOCK_REG_ADDR + 0xac, rdata);
            if (rdata != 0x3231312a) {
              fprintf(stderr, "Error: timers version id wrong, rdata = 0x%x\n", rdata);
            }
            wdata = random();
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_TIMERS_BLOCK_REG_ADDR + 0x0, orig_data);
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_TIMERS_BLOCK_REG_ADDR + 0x0, wdata);
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_TIMERS_BLOCK_REG_ADDR + 0x0, rdata);
            if (rdata != wdata) {
              fprintf(stderr, "Error: timers write access wrong, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_WRITE(STATION_SLOW_IO_TIMERS_BLOCK_REG_ADDR + 0x0, orig_data);
            break;
          case WDT:
            // WDT
            fprintf(stderr, "BG: SLOW IO WDT\n");
            this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_WDT_BLOCK_REG_ADDR + 0xf8, rdata);
            if (rdata != 0x3131302a) {
              fprintf(stderr, "Error: wdt version id wrong, rdata = 0x%x\n", rdata);
            }
            //wdata = random();
            //this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_WDT_BLOCK_REG_ADDR + 0x0, orig_data);
            //this->ht->OURSBUS_WRITE(STATION_SLOW_IO_WDT_BLOCK_REG_ADDR + 0x0, wdata);
            //this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_WDT_BLOCK_REG_ADDR + 0x0, rdata);
            //if ((rdata != (wdata & 0x3f)) && (rdata != ((wdata & 0x3f) | 0x1))) { // bit 0 once set can only be cleared by sys rst
            //  fprintf(stderr, "Error: wdt write access wrong, wdata = 0x%x, rdata = 0x%x\n", wdata, rdata);
            //}
            //this->ht->OURSBUS_WRITE(STATION_SLOW_IO_WDT_BLOCK_REG_ADDR + 0x0, orig_data);
            break;
        }
        break;
      case DDR:
        fprintf(stderr, "BG: DDR\n");
        this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0000 << 2), 0x0); // Enable access to PHY registers
        this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_PHY_ADDR + (0xc0080 << 2), 0x7); // DWC_DDRPHYA_DRTUB0_UcclkHclkEnables
        this->ht->OURSBUS_READ_4B(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), orig_data); //Enable access to SRAM by stall ARCv2
        fprintf(stderr, "BG: DDR Stall ARCv2 ICCMs, original MicroReset value = 0x%x\n", orig_data);
        wdata = orig_data | 0x1;
        this->ht->OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), wdata);
        target = weighted_random(bg_target_ddr_weight_map);
        int index;
        switch (static_cast<bg_target_ddr_e>(target)) {
          case CTRL:
            index = random() % 3;
            wdata = random();
            if (index == 0) {
              fprintf(stderr, "BG: DDR UMCTL2_REGS\n");
              addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x30 << 2);
              this->ht->OURSBUS_READ_4B(addr, orig_data); // PWRCTL
              this->ht->OURSBUS_WRITE(addr, wdata);
              this->ht->OURSBUS_READ_4B(addr, rdata);
              if ((rdata & 0x1ef) != (wdata & 0x1ef)) {
                fprintf(stderr, "Error: Reading UMCTL2_REGS with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0x1ef), (rdata & 0x1ef));
              }
              this->ht->OURSBUS_WRITE(addr, orig_data); //restore the original data
            } else if (index == 1) {
              fprintf(stderr, "BG: DDR UMCTL2_MP\n");
              addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x490 << 2);
              this->ht->OURSBUS_READ_4B(addr, orig_data); // PCTRL_1
              this->ht->OURSBUS_WRITE(addr, wdata);
              this->ht->OURSBUS_READ_4B(addr, rdata);
              if ((rdata & 0x1) != (wdata & 0x1)) {
                fprintf(stderr, "Error: Reading UMCTL2_MP with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0x1), (rdata & 0x1));
              }
              this->ht->OURSBUS_WRITE(addr, orig_data); //restore the original data
            } else if (index == 2) {
              fprintf(stderr, "BG: DDR UMCTL2_REGS_FREQ1\n");
              addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x2050 << 2);
              this->ht->OURSBUS_READ_4B(addr, orig_data); // RFSHCT0
              this->ht->OURSBUS_WRITE(addr, wdata);
              this->ht->OURSBUS_READ_4B(addr, rdata);
              if ((rdata & 0xf1f3f0) != (wdata & 0xf1f3f0)) {
                fprintf(stderr, "Error: Reading UMCTL2_REGS_FREQ1 with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0xf1f3f0), (rdata & 0xf1f3f0));
              }
              this->ht->OURSBUS_WRITE(addr, orig_data); //restore the original data
            }
            break;
          case PHY:
            index = random() % 2; // if index is 1 then access dbyte1 registers. otherwise access dbyte0 registers
            fprintf(stderr, "BG: DDR PHY REGs, index= 0x%x\n", index);

            wdata = random();
            addr = (STATION_DDR_TOP_DDR_PHY_ADDR + (0x100d0 << 2) + ((index * 0x1000) << 2)); //TxDqsDlyTg0_u0_p0, related to write leveling
            this->ht->OURSBUS_READ_4B(addr, orig_data);
            this->ht->OURSBUS_WRITE(addr, wdata);
            this->ht->OURSBUS_READ_4B(addr, rdata);
            if ((rdata & 0xf) != (wdata & 0xf)) {
              fprintf(stderr, "Error: Reading TxDqsDlyTg0_u0_p0 with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
            }
            this->ht->OURSBUS_WRITE(addr, orig_data);
            break;
          case SRAM:
            //SRAM, each address contains 16-bit word
            //ICCM
            fprintf(stderr, "BG: DDR ICCMs\n");
            wdata = random();
            addr = STATION_DDR_TOP_DDR_PHY_ADDR + (0x50000 << 2) + ((random() % 0x3ff8) << 2);
            this->ht->OURSBUS_WRITE(addr, wdata);
            this->ht->OURSBUS_READ_4B(addr, rdata);
            if (rdata != (wdata & 0xffff)) {
              fprintf(stderr, "Error: Reading ICCM with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
            }
            //DCCM
            fprintf(stderr, "BG: DDR DCCMs\n");
            wdata = random();
            addr = STATION_DDR_TOP_DDR_PHY_ADDR + (0x54000 << 2) + ((random() % 0x400) << 2);
            this->ht->OURSBUS_WRITE(addr, wdata);
            this->ht->OURSBUS_READ_4B(addr, rdata);
            if (rdata != (wdata & 0xffff)) {
              fprintf(stderr, "Error: Reading DCCM with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
            }
            break;
          case MR:
            if (this->ht->argmap["reset_ddr"].length() > 0) {
              fprintf(stderr, "BG: DDR MRs\n");
              //Read MR5
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x14 << 2), 0x00000500);
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x00000011);
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x80000011);

              rdata = 0x1;
              while ((rdata & 0x1) != 0) {
                this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x18 << 2), rdata);
              }

              rdata = 0x0;
              while (rdata != 1) {
                this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, rdata); 
              }
              this->ht->OURSBUS_READ (STATION_DDR_TOP_B2S_RD_MRR_DATA_ADDR, orig_data);
              if((orig_data & 0xff) != 0xff) {
                fprintf(stderr, "Error: MR5 value is 0x%x\n", orig_data);
              }
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, 0x0); 

              //Read MR6
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x14 << 2), 0x00000600);
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x00000011);
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x80000011);

              rdata = 0x1;
              while ((rdata & 0x1) != 0) {
                this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x18 << 2), rdata);
              }

              rdata = 0x0;
              while (rdata != 1) {
                this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, rdata); 
              }
              this->ht->OURSBUS_READ (STATION_DDR_TOP_B2S_RD_MRR_DATA_ADDR, orig_data); //DDR2RB
              if((orig_data & 0xff) != 0) {
                fprintf(stderr, "Error: MR6 value is 0x%x\n", orig_data);
              }
              this->ht->OURSBUS_WRITE (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, 0x0); 
            }
            break;
        }
        // Disable access to PHY registers
        this->ht->OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), 0x1);
        this->ht->OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0000 << 2), 0x1);
        break;
      case USB:
        // USB
        fprintf(stderr, "BG: USB\n");
        this->ht->OURSBUS_WRITE(STATION_USB_TOP_S2B_VCC_RESET_N_ADDR, 0x1);
        wdata = random();
        this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc128, wdata);
        this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc128, rdata);
        if (rdata != wdata) {
          fprintf(stderr, "Error: USB GUID access wrong, wdata = 0x%x, rdata = 0x%x\n", wdata, rdata);
        }
        break;
      case SDIO:
        fprintf(stderr, "BG: SDIO\n");
        wdata = random();
        this->ht->OURSBUS_WRITE(STATION_SDIO_MSHC_CTRL_ADDR + 0x34, wdata);
        this->ht->OURSBUS_READ_4B(STATION_SDIO_MSHC_CTRL_ADDR + 0x34, rdata);
        if ((rdata & 0xff) != (wdata & 0xff)) {
          fprintf(stderr, "Error: SDIO Reg access data mismatch, wdata = 0x%x, rdata = 0x%x\n", wdata, rdata);
        }
        break;
      case ORV32:
        fprintf(stderr, "BG: ORV32\n");
        target = weighted_random(bg_target_orv32_weight_map);
        switch (static_cast<bg_target_orv32_e>(target)) {
          case ORV32_ITB:
            this->ht->OURSBUS_WRITE(STATION_ORV32_S2B_CFG_ITB_EN_ADDR, 1); // Enalbe ITB
            addr = ((random() % 0x80)  + STATION_ORV32_ITB_ADDR) & 0xffffffc;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            if (rdata < 0x80000000) {
              fprintf(stderr, "Warning: ORV32 ITB data wrong, addr = 0x%x rdata = 0x%x\n", addr, rdata);
            }
            this->ht->OURSBUS_READ_4B(STATION_ORV32_B2S_ITB_LAST_PTR_ADDR, rdata);
            if ((rdata < STATION_ORV32_ITB_ADDR) || (rdata >= STATION_ORV32_S2B_CFG_RST_PC_ADDR)) {
              fprintf(stderr, "Warning: ORV32 ITB last ptr wrong, rdata = 0x%x\n", rdata);
            }
            break;
          case ORV32_PC:
            this->ht->OURSBUS_READ_4B(STATION_ORV32_IF_PC_ADDR, rdata);
            if (rdata < 0x80000000) {
              fprintf(stderr, "Error: Unrecognized ORV32 IF PC, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_READ_4B(STATION_ORV32_WB_PC_ADDR, rdata);
            if (rdata < 0x80000000) {
              fprintf(stderr, "Error: Unrecognized ORV32 WB PC, rdata = 0x%x\n", rdata);
            }
            break;
          case ORV32_MISC:
            addr = (random() % (STATION_ORV32_HPMCOUNTER_3_OFFSET - STATION_ORV32_CS2MA_EXCP_ADDR)) + STATION_ORV32_CS2MA_EXCP_OFFSET;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            break;
          case ORV32_HPM:
            this->ht->OURSBUS_WRITE(STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_ADDR, 1);
            addr = ((random() % 8) << 3) + STATION_ORV32_HPMCOUNTER_3_ADDR;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            // TODO: how to check
            break;
          case ORV32_PIPE:
            addr = ((random() % (STATION_ORV32_MA2CS_EXCP_VALID_ADDR + 1 - STATION_ORV32_IF_STALL_ADDR)) + STATION_ORV32_IF_STALL_ADDR) & 0xffffff8;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            // TODO: how to check
            break;
        }
        break;
      case VP:
        target = weighted_random(bg_target_orv64_weight_map);
        switch (static_cast<bg_target_orv64_e>(target)) {
          case VP_IC:
            fprintf(stderr, "BG: VP_IC\n");
            wdata = random();
            addr = ((random() % STATION_VP_ITB_DATA_OFFSET) + STATION_VP_IC_DATA_WAY_0_ADDR_0) & 0xfffffff8;
            this->ht->OURSBUS_WRITE(addr, wdata);
            this->ht->OURSBUS_READ_4B(addr, rdata);
            if (rdata != wdata) {
              fprintf(stderr, "Error: ORV64 IC access wrong, addr = 0x%x, wdata = 0x%x, rdata = 0x%x\n", addr, wdata, rdata);
            }
            break;
          case VP_ITB:
            fprintf(stderr, "BG: VP_ITB\n");
            this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_ITB_EN_ADDR_0, 1); // Enalbe ITB
            addr = ((random() % 0x80)  + STATION_VP_ITB_DATA_ADDR_0) & 0xffffff8;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            if (this->ht->argmap["disable_pc_chk"].length() > 0) {
              fprintf(stderr, "ORV64 ITB access get virtual pc, rdata = 0x%x\n", rdata);
            } else {
              fprintf(stderr, "Warning: ORV64 ITB access get wrong pc, rdata = 0x%x\n", rdata);
            }
            this->ht->OURSBUS_READ_4B(STATION_VP_B2S_ITB_LAST_PTR_ADDR_0, rdata);
            if ((rdata < STATION_VP_ITB_DATA_ADDR_0) || (rdata >= STATION_VP_IBUF_LINE_DATA_ADDR_0__DEPTH_0)) {
              fprintf(stderr, "Warning: ORV64 ITB last ptr wrong, rdata = 0x%x\n", rdata);
            }
            break;
          case VP_IBUF:
            fprintf(stderr, "BG: VP_IBUF\n");
            this->ht->OURSBUS_READ_4B(STATION_VP_IBUF_LINE_PADDR_ADDR_0__DEPTH_0, rdata);
            this->ht->OURSBUS_READ_4B(STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_0__DEPTH_1, rdata);
            break;
          case VP_ITLB:
            fprintf(stderr, "BG: VP_ITLB\n");
            addr = ((random() % 8) << 3) + STATION_VP_ITLB_ASID_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            addr = ((random() % 8) << 3) + STATION_VP_ITLB_VPN_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            addr = ((random() % 8) << 3) + STATION_VP_ITLB_PTE_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            break;
          case VP_DTLB:
            fprintf(stderr, "BG: VP_DTLB\n");
            addr = ((random() % 8) << 3) + STATION_VP_DTLB_ASID_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            addr = ((random() % 8) << 3) + STATION_VP_DTLB_VPN_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            addr = ((random() % 8) << 3) + STATION_VP_DTLB_PTE_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            break;
          case VP_VTLB:
            fprintf(stderr, "BG: VP_VTLB\n");
            addr = ((random() % 8) << 3) + STATION_VP_VTLB_ASID_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            addr = ((random() % 8) << 3) + STATION_VP_VTLB_VPN_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            addr = ((random() % 8) << 3) + STATION_VP_VTLB_PTE_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            break;
          case VP_PC:
            fprintf(stderr, "BG: VP_PC\n");
            this->ht->OURSBUS_READ_4B(STATION_VP_IF_PC_ADDR_0, rdata);
            if (rdata < 0x80000000) {
              if (this->ht->argmap["disable_pc_chk"].length() > 0) {
                fprintf(stderr, "Virtual ORV64 IF PC, rdata = 0x%x\n", rdata);
              } else {
                fprintf(stderr, "Error: Unrecognized ORV64 IF PC, rdata = 0x%x\n", rdata);
              }
            }
            this->ht->OURSBUS_READ_4B(STATION_VP_WB_PC_ADDR_0, rdata);
            if (rdata < 0x80000000) {
              if (this->ht->argmap["disable_pc_chk"].length() > 0) {
                fprintf(stderr, "Virtual ORV64 WB PC, rdata = 0x%x\n", rdata);
              } else {
                fprintf(stderr, "Error: Unrecognized ORV64 WB PC, rdata = 0x%x\n", rdata);
              }
            }
            break;
          case VP_PIPE:
            break;
          case VP_MISC:
            break;
          case VP_HPM:
            fprintf(stderr, "BG: VP_HPM\n");
            this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_EN_HPMCOUNTER_ADDR_0, 1);
            addr = ((random() % 14) << 3) + STATION_VP_HPMCOUNTER_3_OFFSET + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            // TODO: how to check
            break;
          case VP_PMU:
            fprintf(stderr, "BG: VP_PMU\n");
            this->ht->OURSBUS_WRITE(STATION_VP_S2B_VCORE_PMU_EN_ADDR_0, 1);
            addr = ((random() % 17) << 3) + STATION_VP_VCORE_PMU_OFFSET + STATION_VP_BASE_ADDR_0;
            this->ht->OURSBUS_READ_4B(addr, rdata);
            // TODO: how to check
            break;
        }
        break;
      case FLUSH:
        uint64_t cmd_vld;
        fprintf(stderr, "BG: DMA FLUSH\n");
        // Check cmd vld, if it's 1 then skip
        this->ht->OURSBUS_READ_4B(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, cmd_vld);
        if (!cmd_vld) {
          uint64_t flush_addr = (random() % 0x80000000) + 0x80000000;
          target = weighted_random(bg_target_flush_weight_map);
          switch (static_cast<bg_target_flush_e>(target)) {
            case FLUSH_ADDR:
              this->ht->OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_REQ_TYPE_ADDR, 0);
              this->ht->OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_ADDR_ADDR, flush_addr);
              this->ht->OURSBUS_WRITE(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, 1);
              break;
            case FLUSH_IDX:
              this->ht->OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_REQ_TYPE_ADDR, 1);
              this->ht->OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_ADDR_ADDR, flush_addr);
              this->ht->OURSBUS_WRITE(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, 1);
              break;
            case FLUSH_ALL:
              this->ht->OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_REQ_TYPE_ADDR, 2);
              this->ht->OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_ADDR_ADDR, flush_addr);
              this->ht->OURSBUS_WRITE(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, 1);
              break;
          }
        }
        break;
      case FLASH:
        fprintf(stderr, "BG: FLASH\n");
        this->ht->OURSBUS_READ(STATION_SLOW_IO_FLASH_ADDR, rdata);
        if (rdata != 0x8967452301efcdab) {
          fprintf(stderr, "Error: Flash content at addr 0x0 wrong, rdata = 0x%x\n", rdata);
        }
        break;
      case IDLE:
        //fprintf(stderr, "IDLING\n");
        this->ht->idle();
        break;
      default:
        fprintf(stderr, "UNKNOW Background Traffic\n");
        break;
      }
  }
}
