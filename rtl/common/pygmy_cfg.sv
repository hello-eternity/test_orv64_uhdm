// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.



//==========================================================
// for L2 Cache {{{


















// }}}








package pygmy_cfg;
  // backedn domain
  parameter int TOP_PD   = 0;
  parameter int ORV32_PD = 1;
  parameter int ORV64_PD = 2;
  parameter int USB_PD   = 3;
  parameter int SDIO_PD  = 4;
  parameter int VCORE_PD = 5;
  //parameter int PHY_ADDR_WIDTH = 40;
  //parameter int VIR_ADDR_WIDTH = 40;
  parameter int DRAM_ADDR_WIDTH = 32;
  parameter int CACHE_LINE_BYTE = 32; // 256-bit
  parameter int CACHE_OFFSET_WIDTH = 5;

  // timer
  parameter int TIMER_WIDTH = 64;

  // virtual memory
  parameter int PAGE_SIZE_BYTE = 4096;
  parameter int PHY_ADDR_WIDTH = 40;
  parameter int VIR_ADDR_WIDTH = 32;

  parameter int PAGE_OFFSET_WIDTH = 12; // 4KiB page
  parameter int PTE_WIDTH = 64;
  parameter int PTE_OFFSET_WIDTH = 3;

  parameter int VIR_PAGE_NUM_WIDTH = 27;
  parameter int VIR_PAGE_NUM_PART_WIDTH = 9;

  parameter int PHY_PAGE_NUM_WIDTH = 44;
  parameter int PHY_PAGE_PART_WIDTH = 9;
  parameter int ADDR_SPACE_ID_WIDTH = 16;
  parameter int NUM_PAGE_LEVELS = 3;

  // oursring
  parameter int RING_ADDR_WIDTH = 40;
  parameter int RING_DATA_WIDTH = 64;
  parameter int RING_MAX_ID_WIDTH = 8;
  parameter int RING_STRB_WIDTH = 8;
  parameter int STATION_ID_WIDTH = 8;
  parameter int JUNCTION_ID_WIDTH = 4;

  // ahb
  parameter int AHB_ADDR_WIDTH = 32;
  parameter int AHB_DATA_WIDTH = 32;

  // vcore
  parameter N_VCORE_INT = 2;
  parameter N_VCORE_FP = 0;
  parameter N_VCORE = N_VCORE_INT + N_VCORE_FP;


  // soc top
  parameter N_DDR = 1;

  parameter int N_DRAM_TESTER = 1;
  //==========================================================
  // for Cache {{{

  parameter int NUM_ORV64_PORT  = 4;
  parameter int SIZE_KBYTE = 512;
  parameter int N_WAY = 8;   // num of ways
  `ifdef PYGMY_E
    parameter int N_BANK = 2;
  `else
    parameter int N_BANK = 4; // num of banks
  `endif
  parameter int N_MSHR = 4; // num of MSHR

  parameter int LRU_WIDTH = 7;

  //parameter int TID_WIDTH = 12; // size of transaction ID
  parameter int CPU_DATA_WIDTH = 256; // CPU NoC data width in bits
  parameter int MEM_DATA_WIDTH = 64; // Mem NoC data width in bits
  parameter int BRESP_STATUS_WIDTH = 2; // B-Response status from mem controller

  //==========================================================
  // calculated parameters
  parameter int OFFSET_WIDTH = 5;
  parameter int BANK_ID_WIDTH = $clog2(N_BANK);
  parameter int WAY_ID_WIDTH = 3;
  parameter int BANK_INDEX_WIDTH = 9; // index used in each bank to address the SRAM's
  parameter int DRAM_TAG_WIDTH = DRAM_ADDR_WIDTH - BANK_INDEX_WIDTH - BANK_ID_WIDTH - OFFSET_WIDTH; // the real TAG we stored in tag ram
  parameter int TAG_WIDTH = PHY_ADDR_WIDTH - BANK_INDEX_WIDTH - BANK_ID_WIDTH - OFFSET_WIDTH;
  //parameter int DRAM_TAG_WIDTH = TAG_WIDTH; // the real TAG we stored in tag ram
  //parameter int MEM_ADDR_WIDTH = DRAM_TAG_WIDTH + BANK_INDEX_WIDTH; 
  parameter int MEM_ADDR_WIDTH = PHY_ADDR_WIDTH; 

  parameter int DRAM_ADDR_MSB = DRAM_ADDR_WIDTH - 1;
  parameter int OFFSET_MSB = OFFSET_WIDTH - 1;

  parameter int BANK_ID_LSB = OFFSET_WIDTH;
  parameter int BANK_ID_MSB = BANK_ID_WIDTH + OFFSET_WIDTH - 1;

  parameter int WAY_ID_LSB = BANK_INDEX_WIDTH + BANK_ID_WIDTH + OFFSET_WIDTH;
  parameter int WAY_ID_MSB = WAY_ID_WIDTH + BANK_INDEX_WIDTH + BANK_ID_WIDTH + OFFSET_WIDTH - 1;

  parameter int BANK_INDEX_LSB = BANK_ID_WIDTH + OFFSET_WIDTH;
  parameter int BANK_INDEX_MSB = BANK_INDEX_WIDTH + BANK_ID_WIDTH + OFFSET_WIDTH - 1;

  parameter int TAG_LSB = BANK_INDEX_WIDTH + BANK_ID_WIDTH + OFFSET_WIDTH;
  parameter int TAG_MSB = PHY_ADDR_WIDTH - 1;

  parameter int DRAM_TAG_LSB = BANK_INDEX_WIDTH + BANK_ID_WIDTH + OFFSET_WIDTH;
  parameter int DRAM_TAG_MSB = DRAM_ADDR_WIDTH - 1;

  //parameter int CPU_OFFSET_LSB = `CPU_OFFSET_LSB;
  //parameter int CPU_OFFSET_MSB = `CPU_OFFSET_MSB;
  //parameter int CPU_OFFSET_WIDTH = `CPU_OFFSET_WIDTH;

  //parameter int CPU_ADDR_WIDTH = `CPU_ADDR_WIDTH;
  parameter int CPU_ADDR_WIDTH = 9;

  parameter int MEM_OFFSET_LSB = 3;
  parameter int MEM_OFFSET_MSB = 4;
  parameter int MEM_OFFSET_WIDTH = 2;

  parameter int MEM_BURST_LEN = 4;
  parameter int MEM_BURST_WIDTH = 2;
  parameter int MEM_BURST_MSB = 1;

  //parameter int TID_MSB = 11;

  parameter int N_DATA_RAM_SPLIT = 4;
  parameter int N_DATA_RAM_BANK = 1;
  parameter int DATA_RAM_BANK_ID_WIDTH = 0;
  parameter int DATA_CHUNK_ID_WIDTH = 2;

  parameter int MSHR_ID_WIDTH = 2;

  // OURS BUS <-> L2 Debug Access
  parameter int OB_ID_WIDTH = 6;
  parameter int OB_RAM_ID_WIDTH = 3;
  parameter int OB_ADDR_WIDTH = 40;
//   parameter int OB_RSVD_WIDTH = `OB_RSVD_WIDTH;
  parameter int OB_RSVD_WIDTH = 19;

  // for future use
  // parameter int MEM_ADDR_TID_MSB = `MEM_ADDR_TID_MSB;
  // parameter int VLS_SIZE_KBYTE = `VLS_SIZE_KBYTE;

  //}}}


  //==========================================================
  // for CPU-NOC {{{
  parameter int NUM_CPU_PORT  = 8;
  parameter int CPU_PORT_ID_WIDTH = 3;
  parameter int NUM_L2_PORT   = 4;
  parameter int L2_PORT_ID_WIDTH  = 2;

  parameter int CPUNOC_TID_MASTERID_SIZE = CPU_PORT_ID_WIDTH;
  parameter int CPUNOC_TID_SRCID_SIZE    = 4;
  parameter int CPUNOC_TID_TID_SIZE      = 4;
  // }}}

  //==========================================================
  // for MEM-NOC {{{
  parameter int MEMNOC_TID_MASTERID_SIZE  = 4;
  parameter int MEMNOC_TID_TID_SIZE       = 4;

  //parameter int MEM_NOC_ID_WIDTH   = 8;
  //parameter int MEM_NOC_ADDR_WIDTH = 32;
  //parameter int MEM_NOC_DATA_WIDTH = 64;
  //parameter int MEM_NOC_DATA_MASK_WIDTH = 8;
  //parameter int MEM_NOC_RESP_STATUS_WIDTH = 8;
  //parameter int MEM_NOC_AXLEN_WIDTH       = 4;
  // }}}

  //==========================================================
  // for VCORE {{{
  parameter VLEN                        = 16;
  parameter MEM_SPACE_BYTE_IDX_SZ       = 40;
  parameter VCORE_MAX_VLEN_8B           = 128; // the maximum vector length in term of 8-bit elements
  parameter VCORE_DNN_MAX_LAYER_DEPTH   = 16384;    // maximum depth of a layer
  parameter VCORE_DNN_MAX_KERNEL_DEPTH  = 16384; // kernel depth is always = layer depth
  parameter VCORE_VRF_VECTOR_CNT        = 32; // 32 for 1 thread; 16/thread for 2 threads; 8/thread for 4 threads.
  parameter VCORE_PMU_ADDR_W            = 16;
  parameter VCORE_PMU_DATA_W            = 64;
  // }}}
  //==========================================================
  // for MEM BARRIER {{{
  parameter int MEM_BARRIER_STATUS_WIDTH = NUM_ORV64_PORT;
 endpackage

