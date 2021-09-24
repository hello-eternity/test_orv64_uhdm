// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


package orv64_param_pkg;

  parameter int ORV64_XLEN = 64;

  parameter int ORV64_PHY_ADDR_WIDTH = 56;
  parameter int ORV64_VIR_ADDR_WIDTH = 39;

  parameter ORV64_ICACHE_SIZE_KBYTE = 8;

  parameter ORV64_N_ICACHE_WAY = 2;

  parameter ORV64_N_ICACHE_PREFETCH = 4;

  // calculated parameters
  parameter ORV64_N_ICACHE_LINE_SET = 128;
  parameter ORV64_N_ICACHE_DATA_BANK = 8; // 32 is instruction width

  parameter ORV64_ICACHE_LINE_WIDTH = 256;
  parameter ORV64_ICACHE_OFFSET_WIDTH = 5;
  parameter ORV64_ICACHE_INDEX_WIDTH = 7;
  parameter ORV64_ICACHE_WYID_WIDTH = 1;
  parameter ORV64_ICACHE_TAG_WIDTH = 43;
  parameter ORV64_ICACHE_RAM_TAG_WIDTH = 23;

  parameter ORV64_ICACHE_TAG_MSB = 38;
  parameter ORV64_ICACHE_TAG_LSB = 12;

  parameter ORV64_ICACHE_INDEX_MSB = 11;
  parameter ORV64_ICACHE_INDEX_LSB = 5;

  parameter ORV64_ICACHE_DATA_BANK_ID_WIDTH = 3;

  parameter ORV64_ICACHE_DATA_BANK_ID_MSB = 4;
  parameter ORV64_ICACHE_DATA_BANK_ID_LSB = 2;

  // there is no DCACHE for now, just use the ICACHE number blow
  parameter ORV64_DCACHE_TAG_MSB = 39;
  parameter ORV64_DCACHE_TAG_LSB = 12;
  parameter ORV64_DCACHE_TAG_WIDTH = 28;

  parameter ORV64_DCACHE_INDEX_MSB = 11;
  parameter ORV64_DCACHE_INDEX_LSB = 5;
  parameter ORV64_DCACHE_INDEX_WIDTH = 7;

  parameter ORV64_DCACHE_DATA_OFFSET_WIDTH = 2; // 64 is data width
  parameter ORV64_DCACHE_DATA_OFFSET_MSB = 4;
  parameter ORV64_DCACHE_DATA_OFFSET_LSB = 10;

//   parameter N_DCACHE_SET = `N_DCACHE_SET;
//   parameter DCACHE_OFFSET_WIDTH = `DCACHE_OFFSET_WIDTH;
//   parameter ORV64_DCACHE_INDEX_WIDTH = `DCACHE_INDEX_WIDTH;
//   parameter ORV64_DCACHE_TAG_WIDTH = `DCACHE_TAG_WIDTH;

  parameter ORV64_N_DMA_CHNL = 4;
  parameter ORV64_N_DMA_SIZE_BIT = 21;

  // Multicycle arithmetic unit completion cycles
  parameter ORV64_N_CYCLE_INT_MUL = 5;
  parameter ORV64_N_CYCLE_INT_DIV = 8;

  parameter ORV64_N_CYCLE_INT_MUL_FPGA = 33;
  parameter ORV64_N_CYCLE_INT_DIV_FPGA = 70;

  `ifndef FPGA
  parameter ORV64_N_CYCLE_FP_ADD_S = 33;
  parameter ORV64_N_CYCLE_FP_ADD_D = 33;

  parameter ORV64_N_CYCLE_FP_MAC_S = 33;
  parameter ORV64_N_CYCLE_FP_MAC_D = 33;

  parameter ORV64_N_CYCLE_FP_DIV_S = 33;
  parameter ORV64_N_CYCLE_FP_DIV_D = 33;

  parameter ORV64_N_CYCLE_FP_SQRT_S = 33;
  parameter ORV64_N_CYCLE_FP_SQRT_D = 33;

  parameter ORV64_N_CYCLE_FP_MISC = 16;
  `else
  parameter ORV64_N_CYCLE_FP_ADD_S = 32;
  parameter ORV64_N_CYCLE_FP_ADD_D = 32;

  parameter ORV64_N_CYCLE_FP_MAC_S = 32;
  parameter ORV64_N_CYCLE_FP_MAC_D = 32;

  parameter ORV64_N_CYCLE_FP_DIV_S = 32;
  parameter ORV64_N_CYCLE_FP_DIV_D = 64;

  parameter ORV64_N_CYCLE_FP_SQRT_S = 64;
  parameter ORV64_N_CYCLE_FP_SQRT_D = 64;

  parameter ORV64_N_CYCLE_FP_MISC = 32;
  `endif
  // constant
  parameter ORV64_CONST_INST_NOP = 64'h00000013;
  parameter ORV64_CONST_INST_WFE = 32'h10600073;

  // constant for integer
  parameter ORV64_CONST_INT32_MIN = 32'h80000000;
  parameter ORV64_CONST_INT32_MAX = 32'h7fffffff;
  parameter ORV64_CONST_INT32U_MAX = 32'hffffffff;

  // constant for floating-points
  parameter ORV64_CONST_FP_D_CANON_NAN  = {1'b0, {11{1'b1}}, 1'b1, 51'b0};
  parameter ORV64_CONST_FP_D_ZERO       = 63'b0;
  parameter ORV64_CONST_FP_D_POS_ZERO   = 64'b0;
  parameter ORV64_CONST_FP_D_NEG_ZERO   = {1'b1, 63'b0};
  parameter ORV64_CONST_FP_D_POS_INF    = {1'b0, {11{1'b1}}, 52'b0};
  parameter ORV64_CONST_FP_D_NEG_INF    = {1'b1, {11{1'b1}}, 52'b0};

  parameter ORV64_CONST_FP_S_CANON_NAN  = {1'b0, {8{1'b1}}, 1'b1, 22'b0};
  parameter ORV64_CONST_FP_S_ZERO       = 31'b0;
  parameter ORV64_CONST_FP_S_POS_ZERO   = 32'b0;
  parameter ORV64_CONST_FP_S_NEG_ZERO   = {1'b1, 31'b0};
  parameter ORV64_CONST_FP_S_POS_INF    = {1'b0, {8{1'b1}}, 23'b0};
  parameter ORV64_CONST_FP_S_NEG_INF    = {1'b1, {8{1'b1}}, 23'b0};

  parameter ORV64_CONST_FP16_S_CANON_NAN  = {1'b0, {5{1'b1}}, 1'b1, 9'b0};
  parameter ORV64_CONST_FP16_S_ZERO       = 15'b0;
  parameter ORV64_CONST_FP16_S_POS_ZERO   = 16'b0;
  parameter ORV64_CONST_FP16_S_NEG_ZERO   = {1'b1, 15'b0};
  parameter ORV64_CONST_FP16_S_POS_INF    = {1'b0, {5{1'b1}}, 10'b0};
  parameter ORV64_CONST_FP16_S_NEG_INF    = {1'b1, {5{1'b1}}, 10'b0};

  parameter ORV64_MAGICMEM_OURSBUS_ID   = 6'b10_0001;

  // constants for MMU
  parameter ORV64_N_FIELDS_PMPCFG = 8;
  parameter ORV64_N_PMP_CSR = 16;
  parameter ORV64_NUM_PAGE_LEVELS = 3;
  parameter ORV64_PTW_LVL_CNT_WIDTH = $clog2(ORV64_NUM_PAGE_LEVELS);
  parameter ORV64_PAGE_SIZE_BYTE = 4096;
  parameter ORV64_PAGE_OFFSET_WIDTH = 12;
  parameter ORV64_PTE_WIDTH = 64;
  parameter ORV64_NUM_PTE_PAGE = (ORV64_PAGE_SIZE_BYTE*8)/ORV64_PTE_WIDTH;
  parameter ORV64_PTE_IDX_WIDTH = $clog2(ORV64_NUM_PTE_PAGE);
  parameter ORV64_PTE_OFFSET_WIDTH = 3;
  parameter ORV64_ASID_WIDTH = 16;
  parameter ORV64_PPN_WIDTH = 44;
  parameter ORV64_VPN_WIDTH = 27;
  parameter ORV64_PPN_PART_WIDTH = 9;
  parameter ORV64_VPN_PART_WIDTH = 9;
  parameter ORV64_NUM_ITLB_ENTRIES = 8;
  parameter ORV64_NUM_DTLB_ENTRIES = 8;

  // ITB
  parameter ORV64_ITB_ADDR_WIDTH = 5;

  // CSR
  parameter ORV64_CSR_ADDR_RW_PRV_WIDTH = 4;
  parameter ORV64_CSR_ADDR_RW_PRV_MSB = 11;
  parameter ORV64_CSR_ADDR_RW_PRV_LSB = 8;
  parameter ORV64_CSR_ADDR_CUT_WIDTH = 8;
  parameter ORV64_CSR_ADDR_CUT_MSB = 7;
  parameter ORV64_CSR_ADDR_CUT_LSB = 0;

  // Counters
  parameter ORV64_CNTR_WIDTH = 48;

endpackage
