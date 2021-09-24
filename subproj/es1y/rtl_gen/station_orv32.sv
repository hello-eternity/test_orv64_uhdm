
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_ORV32_PKG__SV
`define STATION_ORV32_PKG__SV
package station_orv32_pkg;
  localparam int STATION_ORV32_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_ORV32_DATA_WIDTH = 'h40;
  localparam [STATION_ORV32_RING_ADDR_WIDTH-1:0] STATION_ORV32_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_ORV32_BLKID = 'h0;
  localparam int STATION_ORV32_BLKID_WIDTH = 'h5;
  localparam bit [25 - 1:0] STATION_ORV32_IC_DATA_WAY_0_OFFSET = 64'h1000;
  localparam int STATION_ORV32_IC_DATA_WAY_0_WIDTH  = 32768;
  localparam bit [64 - 1:0] STATION_ORV32_IC_DATA_WAY_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IC_DATA_WAY_0_ADDR = 64'h1000;
  localparam bit [25 - 1:0] STATION_ORV32_IC_DATA_WAY_1_OFFSET = 64'h2000;
  localparam int STATION_ORV32_IC_DATA_WAY_1_WIDTH  = 32768;
  localparam bit [64 - 1:0] STATION_ORV32_IC_DATA_WAY_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IC_DATA_WAY_1_ADDR = 64'h2000;
  localparam bit [25 - 1:0] STATION_ORV32_IC_TAG_WAY_0_OFFSET = 64'h3000;
  localparam int STATION_ORV32_IC_TAG_WAY_0_WIDTH  = 8192;
  localparam bit [64 - 1:0] STATION_ORV32_IC_TAG_WAY_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IC_TAG_WAY_0_ADDR = 64'h3000;
  localparam bit [25 - 1:0] STATION_ORV32_IC_TAG_WAY_1_OFFSET = 64'h3400;
  localparam int STATION_ORV32_IC_TAG_WAY_1_WIDTH  = 8192;
  localparam bit [64 - 1:0] STATION_ORV32_IC_TAG_WAY_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IC_TAG_WAY_1_ADDR = 64'h3400;
  localparam bit [25 - 1:0] STATION_ORV32_ITB_OFFSET = 64'h80;
  localparam int STATION_ORV32_ITB_WIDTH  = 1024;
  localparam bit [64 - 1:0] STATION_ORV32_ITB_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ITB_ADDR = 64'h80;
  localparam bit [25 - 1:0] STATION_ORV32_ORV32_TOHOST_OFFSET = 64'h0;
  localparam int STATION_ORV32_ORV32_TOHOST_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_ORV32_TOHOST_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ORV32_TOHOST_ADDR = 64'h0;
  localparam bit [25 - 1:0] STATION_ORV32_ORV32_FROMHOST_OFFSET = 64'h8;
  localparam int STATION_ORV32_ORV32_FROMHOST_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_ORV32_FROMHOST_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ORV32_FROMHOST_ADDR = 64'h8;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_RST_PC_OFFSET = 64'h10;
  localparam int STATION_ORV32_S2B_CFG_RST_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_RST_PC_RSTVAL = 32'h1600000;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_RST_PC_ADDR = 64'h10;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_ITB_SEL_OFFSET = 64'h100;
  localparam int STATION_ORV32_S2B_CFG_ITB_SEL_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_ITB_SEL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_ITB_SEL_ADDR = 64'h100;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_ITB_LAST_PTR_OFFSET = 64'h18;
  localparam int STATION_ORV32_B2S_ITB_LAST_PTR_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_B2S_ITB_LAST_PTR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_ITB_LAST_PTR_ADDR = 64'h18;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_0_OFFSET = 64'h3800;
  localparam int STATION_ORV32_S2B_BP_IF_PC_0_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_IF_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_0_ADDR = 64'h3800;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_1_OFFSET = 64'h20;
  localparam int STATION_ORV32_S2B_BP_IF_PC_1_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_IF_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_1_ADDR = 64'h20;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_2_OFFSET = 64'h108;
  localparam int STATION_ORV32_S2B_BP_IF_PC_2_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_IF_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_2_ADDR = 64'h108;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_3_OFFSET = 64'h28;
  localparam int STATION_ORV32_S2B_BP_IF_PC_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_IF_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_IF_PC_3_ADDR = 64'h28;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_0_OFFSET = 64'h3808;
  localparam int STATION_ORV32_S2B_BP_WB_PC_0_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_WB_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_0_ADDR = 64'h3808;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_1_OFFSET = 64'h30;
  localparam int STATION_ORV32_S2B_BP_WB_PC_1_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_WB_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_1_ADDR = 64'h30;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_2_OFFSET = 64'h110;
  localparam int STATION_ORV32_S2B_BP_WB_PC_2_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_WB_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_2_ADDR = 64'h110;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_3_OFFSET = 64'h38;
  localparam int STATION_ORV32_S2B_BP_WB_PC_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_BP_WB_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_BP_WB_PC_3_ADDR = 64'h38;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_IF_PC_OFFSET = 64'h3810;
  localparam int STATION_ORV32_B2S_IF_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_B2S_IF_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_IF_PC_ADDR = 64'h3810;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_WB_PC_OFFSET = 64'h40;
  localparam int STATION_ORV32_B2S_WB_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_B2S_WB_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_WB_PC_ADDR = 64'h40;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_ICACHE_BASE_OFFSET = 64'h118;
  localparam int STATION_ORV32_S2B_ICACHE_BASE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_ICACHE_BASE_RSTVAL = 64'h80000000;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_ICACHE_BASE_ADDR = 64'h118;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_ICACHE_BOUNDS_OFFSET = 64'h48;
  localparam int STATION_ORV32_S2B_ICACHE_BOUNDS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_ICACHE_BOUNDS_RSTVAL = 64'hffffffff;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_ICACHE_BOUNDS_ADDR = 64'h48;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DCACHE_BASE_OFFSET = 64'h3818;
  localparam int STATION_ORV32_S2B_DCACHE_BASE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_DCACHE_BASE_RSTVAL = 64'h80000000;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DCACHE_BASE_ADDR = 64'h3818;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DCACHE_BOUNDS_OFFSET = 64'h50;
  localparam int STATION_ORV32_S2B_DCACHE_BOUNDS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_DCACHE_BOUNDS_RSTVAL = 64'hffffffff;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DCACHE_BOUNDS_ADDR = 64'h50;
  localparam bit [25 - 1:0] STATION_ORV32_CS2MA_EXCP_OFFSET = 64'h120;
  localparam int STATION_ORV32_CS2MA_EXCP_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_CS2MA_EXCP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_CS2MA_EXCP_ADDR = 64'h120;
  localparam bit [25 - 1:0] STATION_ORV32_IF_PC_OFFSET = 64'h58;
  localparam int STATION_ORV32_IF_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_IF_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF_PC_ADDR = 64'h58;
  localparam bit [25 - 1:0] STATION_ORV32_WB_PC_OFFSET = 64'h3820;
  localparam int STATION_ORV32_WB_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_WB_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_WB_PC_ADDR = 64'h3820;
  localparam bit [25 - 1:0] STATION_ORV32_IF2ID_EXCP_PC_OFFSET = 64'h60;
  localparam int STATION_ORV32_IF2ID_EXCP_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_IF2ID_EXCP_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF2ID_EXCP_PC_ADDR = 64'h60;
  localparam bit [25 - 1:0] STATION_ORV32_ID2EX_EXCP_PC_OFFSET = 64'h128;
  localparam int STATION_ORV32_ID2EX_EXCP_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_ID2EX_EXCP_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ID2EX_EXCP_PC_ADDR = 64'h128;
  localparam bit [25 - 1:0] STATION_ORV32_EX2MA_EXCP_PC_OFFSET = 64'h68;
  localparam int STATION_ORV32_EX2MA_EXCP_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_EX2MA_EXCP_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX2MA_EXCP_PC_ADDR = 64'h68;
  localparam bit [25 - 1:0] STATION_ORV32_MA2CS_EXCP_PC_OFFSET = 64'h3828;
  localparam int STATION_ORV32_MA2CS_EXCP_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_MA2CS_EXCP_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA2CS_EXCP_PC_ADDR = 64'h3828;
  localparam bit [25 - 1:0] STATION_ORV32_IF2ID_EXCP_CAUSE_OFFSET = 64'h70;
  localparam int STATION_ORV32_IF2ID_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_IF2ID_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF2ID_EXCP_CAUSE_ADDR = 64'h70;
  localparam bit [25 - 1:0] STATION_ORV32_ID2EX_EXCP_CAUSE_OFFSET = 64'h130;
  localparam int STATION_ORV32_ID2EX_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_ID2EX_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ID2EX_EXCP_CAUSE_ADDR = 64'h130;
  localparam bit [25 - 1:0] STATION_ORV32_EX2MA_EXCP_CAUSE_OFFSET = 64'h78;
  localparam int STATION_ORV32_EX2MA_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_EX2MA_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX2MA_EXCP_CAUSE_ADDR = 64'h78;
  localparam bit [25 - 1:0] STATION_ORV32_MA2CS_EXCP_CAUSE_OFFSET = 64'h3830;
  localparam int STATION_ORV32_MA2CS_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_MA2CS_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA2CS_EXCP_CAUSE_ADDR = 64'h3830;
  localparam bit [25 - 1:0] STATION_ORV32_IF2IC_PC_OFFSET = 64'h138;
  localparam int STATION_ORV32_IF2IC_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_IF2IC_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF2IC_PC_ADDR = 64'h138;
  localparam bit [25 - 1:0] STATION_ORV32_MCYCLE_OFFSET = 64'h3838;
  localparam int STATION_ORV32_MCYCLE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_MCYCLE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MCYCLE_ADDR = 64'h3838;
  localparam bit [25 - 1:0] STATION_ORV32_MINSTRET_OFFSET = 64'h140;
  localparam int STATION_ORV32_MINSTRET_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_MINSTRET_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MINSTRET_ADDR = 64'h140;
  localparam bit [25 - 1:0] STATION_ORV32_MSTATUS_OFFSET = 64'h3840;
  localparam int STATION_ORV32_MSTATUS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_MSTATUS_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MSTATUS_ADDR = 64'h3840;
  localparam bit [25 - 1:0] STATION_ORV32_MCAUSE_OFFSET = 64'h148;
  localparam int STATION_ORV32_MCAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_MCAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MCAUSE_ADDR = 64'h148;
  localparam bit [25 - 1:0] STATION_ORV32_MEPC_OFFSET = 64'h3848;
  localparam int STATION_ORV32_MEPC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_MEPC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MEPC_ADDR = 64'h3848;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_3_OFFSET = 64'h150;
  localparam int STATION_ORV32_HPMCOUNTER_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_3_ADDR = 64'h150;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_4_OFFSET = 64'h3850;
  localparam int STATION_ORV32_HPMCOUNTER_4_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_4_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_4_ADDR = 64'h3850;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_5_OFFSET = 64'h158;
  localparam int STATION_ORV32_HPMCOUNTER_5_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_5_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_5_ADDR = 64'h158;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_6_OFFSET = 64'h3858;
  localparam int STATION_ORV32_HPMCOUNTER_6_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_6_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_6_ADDR = 64'h3858;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_7_OFFSET = 64'h160;
  localparam int STATION_ORV32_HPMCOUNTER_7_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_7_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_7_ADDR = 64'h160;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_8_OFFSET = 64'h3860;
  localparam int STATION_ORV32_HPMCOUNTER_8_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_8_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_8_ADDR = 64'h3860;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_9_OFFSET = 64'h168;
  localparam int STATION_ORV32_HPMCOUNTER_9_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_9_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_9_ADDR = 64'h168;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_10_OFFSET = 64'h3868;
  localparam int STATION_ORV32_HPMCOUNTER_10_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_ORV32_HPMCOUNTER_10_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_HPMCOUNTER_10_ADDR = 64'h3868;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_LFSR_SEED_OFFSET = 64'h170;
  localparam int STATION_ORV32_S2B_CFG_LFSR_SEED_WIDTH  = 6;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_LFSR_SEED_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_LFSR_SEED_ADDR = 64'h170;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EARLY_RSTN_OFFSET = 64'h3870;
  localparam int STATION_ORV32_S2B_EARLY_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EARLY_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EARLY_RSTN_ADDR = 64'h3870;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_RSTN_OFFSET = 64'h178;
  localparam int STATION_ORV32_S2B_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_RSTN_ADDR = 64'h178;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_SOFTWARE_INT_OFFSET = 64'h3878;
  localparam int STATION_ORV32_S2B_SOFTWARE_INT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_SOFTWARE_INT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_SOFTWARE_INT_ADDR = 64'h3878;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_TIMER_INT_OFFSET = 64'h180;
  localparam int STATION_ORV32_S2B_TIMER_INT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_TIMER_INT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_TIMER_INT_ADDR = 64'h180;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EXT_EVENT_OFFSET = 64'h3880;
  localparam int STATION_ORV32_S2B_EXT_EVENT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EXT_EVENT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EXT_EVENT_ADDR = 64'h3880;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DEBUG_STALL_OFFSET = 64'h188;
  localparam int STATION_ORV32_S2B_DEBUG_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_DEBUG_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DEBUG_STALL_ADDR = 64'h188;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_DEBUG_STALL_OUT_OFFSET = 64'h3888;
  localparam int STATION_ORV32_B2S_DEBUG_STALL_OUT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_B2S_DEBUG_STALL_OUT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_DEBUG_STALL_OUT_ADDR = 64'h3888;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DEBUG_RESUME_OFFSET = 64'h190;
  localparam int STATION_ORV32_S2B_DEBUG_RESUME_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_DEBUG_RESUME_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_DEBUG_RESUME_ADDR = 64'h190;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_ITB_EN_OFFSET = 64'h3890;
  localparam int STATION_ORV32_S2B_CFG_ITB_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_ITB_EN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_ITB_EN_ADDR = 64'h3890;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_OFFSET = 64'h198;
  localparam int STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_ADDR = 64'h198;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_OFFSET = 64'h3898;
  localparam int STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_ADDR = 64'h3898;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_BYPASS_IC_OFFSET = 64'h1a0;
  localparam int STATION_ORV32_S2B_CFG_BYPASS_IC_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_BYPASS_IC_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_BYPASS_IC_ADDR = 64'h1a0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_PWR_ON_OFFSET = 64'h38a0;
  localparam int STATION_ORV32_S2B_CFG_PWR_ON_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_PWR_ON_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_PWR_ON_ADDR = 64'h38a0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_SLEEP_OFFSET = 64'h1a8;
  localparam int STATION_ORV32_S2B_CFG_SLEEP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_CFG_SLEEP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_CFG_SLEEP_ADDR = 64'h1a8;
  localparam bit [25 - 1:0] STATION_ORV32_S2ICG_CLK_EN_OFFSET = 64'h38a8;
  localparam int STATION_ORV32_S2ICG_CLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2ICG_CLK_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_ORV32_S2ICG_CLK_EN_ADDR = 64'h38a8;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_0_OFFSET = 64'h1b0;
  localparam int STATION_ORV32_S2B_EN_BP_IF_PC_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_0_ADDR = 64'h1b0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_1_OFFSET = 64'h38b0;
  localparam int STATION_ORV32_S2B_EN_BP_IF_PC_1_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_1_ADDR = 64'h38b0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_2_OFFSET = 64'h1b8;
  localparam int STATION_ORV32_S2B_EN_BP_IF_PC_2_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_2_ADDR = 64'h1b8;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_3_OFFSET = 64'h38b8;
  localparam int STATION_ORV32_S2B_EN_BP_IF_PC_3_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_IF_PC_3_ADDR = 64'h38b8;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_0_OFFSET = 64'h1c0;
  localparam int STATION_ORV32_S2B_EN_BP_WB_PC_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_0_ADDR = 64'h1c0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_1_OFFSET = 64'h38c0;
  localparam int STATION_ORV32_S2B_EN_BP_WB_PC_1_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_1_ADDR = 64'h38c0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_2_OFFSET = 64'h1c8;
  localparam int STATION_ORV32_S2B_EN_BP_WB_PC_2_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_2_ADDR = 64'h1c8;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_3_OFFSET = 64'h38c8;
  localparam int STATION_ORV32_S2B_EN_BP_WB_PC_3_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_S2B_EN_BP_WB_PC_3_ADDR = 64'h38c8;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_IF_VALID_OFFSET = 64'h1d0;
  localparam int STATION_ORV32_B2S_IF_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_B2S_IF_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_IF_VALID_ADDR = 64'h1d0;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_WB_VALID_OFFSET = 64'h38d0;
  localparam int STATION_ORV32_B2S_WB_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_B2S_WB_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_B2S_WB_VALID_ADDR = 64'h38d0;
  localparam bit [25 - 1:0] STATION_ORV32_DEBUG_INFO_ENABLE_OFFSET = 64'h1d8;
  localparam int STATION_ORV32_DEBUG_INFO_ENABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_DEBUG_INFO_ENABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_ORV32_DEBUG_INFO_ENABLE_ADDR = 64'h1d8;
  localparam bit [25 - 1:0] STATION_ORV32_IF_STALL_OFFSET = 64'h38d8;
  localparam int STATION_ORV32_IF_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_IF_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF_STALL_ADDR = 64'h38d8;
  localparam bit [25 - 1:0] STATION_ORV32_IF_KILL_OFFSET = 64'h1e0;
  localparam int STATION_ORV32_IF_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_IF_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF_KILL_ADDR = 64'h1e0;
  localparam bit [25 - 1:0] STATION_ORV32_IF_VALID_OFFSET = 64'h38e0;
  localparam int STATION_ORV32_IF_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_IF_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF_VALID_ADDR = 64'h38e0;
  localparam bit [25 - 1:0] STATION_ORV32_IF_READY_OFFSET = 64'h1e8;
  localparam int STATION_ORV32_IF_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_IF_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF_READY_ADDR = 64'h1e8;
  localparam bit [25 - 1:0] STATION_ORV32_ID_STALL_OFFSET = 64'h38e8;
  localparam int STATION_ORV32_ID_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_ID_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ID_STALL_ADDR = 64'h38e8;
  localparam bit [25 - 1:0] STATION_ORV32_ID_KILL_OFFSET = 64'h1f0;
  localparam int STATION_ORV32_ID_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_ID_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ID_KILL_ADDR = 64'h1f0;
  localparam bit [25 - 1:0] STATION_ORV32_ID_VALID_OFFSET = 64'h38f0;
  localparam int STATION_ORV32_ID_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_ID_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ID_VALID_ADDR = 64'h38f0;
  localparam bit [25 - 1:0] STATION_ORV32_ID_READY_OFFSET = 64'h1f8;
  localparam int STATION_ORV32_ID_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_ID_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ID_READY_ADDR = 64'h1f8;
  localparam bit [25 - 1:0] STATION_ORV32_EX_STALL_OFFSET = 64'h38f8;
  localparam int STATION_ORV32_EX_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_EX_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX_STALL_ADDR = 64'h38f8;
  localparam bit [25 - 1:0] STATION_ORV32_EX_KILL_OFFSET = 64'h200;
  localparam int STATION_ORV32_EX_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_EX_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX_KILL_ADDR = 64'h200;
  localparam bit [25 - 1:0] STATION_ORV32_EX_VALID_OFFSET = 64'h3900;
  localparam int STATION_ORV32_EX_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_EX_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX_VALID_ADDR = 64'h3900;
  localparam bit [25 - 1:0] STATION_ORV32_EX_READY_OFFSET = 64'h208;
  localparam int STATION_ORV32_EX_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_EX_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX_READY_ADDR = 64'h208;
  localparam bit [25 - 1:0] STATION_ORV32_MA_STALL_OFFSET = 64'h3908;
  localparam int STATION_ORV32_MA_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_MA_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA_STALL_ADDR = 64'h3908;
  localparam bit [25 - 1:0] STATION_ORV32_MA_KILL_OFFSET = 64'h210;
  localparam int STATION_ORV32_MA_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_MA_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA_KILL_ADDR = 64'h210;
  localparam bit [25 - 1:0] STATION_ORV32_MA_VALID_OFFSET = 64'h3910;
  localparam int STATION_ORV32_MA_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_MA_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA_VALID_ADDR = 64'h3910;
  localparam bit [25 - 1:0] STATION_ORV32_MA_READY_OFFSET = 64'h218;
  localparam int STATION_ORV32_MA_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_MA_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA_READY_ADDR = 64'h218;
  localparam bit [25 - 1:0] STATION_ORV32_WB_VALID_OFFSET = 64'h3918;
  localparam int STATION_ORV32_WB_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_WB_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_WB_VALID_ADDR = 64'h3918;
  localparam bit [25 - 1:0] STATION_ORV32_WB_READY_OFFSET = 64'h220;
  localparam int STATION_ORV32_WB_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_WB_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_WB_READY_ADDR = 64'h220;
  localparam bit [25 - 1:0] STATION_ORV32_CS2IF_KILL_OFFSET = 64'h3920;
  localparam int STATION_ORV32_CS2IF_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_CS2IF_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_CS2IF_KILL_ADDR = 64'h3920;
  localparam bit [25 - 1:0] STATION_ORV32_CS2ID_KILL_OFFSET = 64'h228;
  localparam int STATION_ORV32_CS2ID_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_CS2ID_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_CS2ID_KILL_ADDR = 64'h228;
  localparam bit [25 - 1:0] STATION_ORV32_CS2EX_KILL_OFFSET = 64'h3928;
  localparam int STATION_ORV32_CS2EX_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_CS2EX_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_CS2EX_KILL_ADDR = 64'h3928;
  localparam bit [25 - 1:0] STATION_ORV32_CS2MA_KILL_OFFSET = 64'h230;
  localparam int STATION_ORV32_CS2MA_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_CS2MA_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_CS2MA_KILL_ADDR = 64'h230;
  localparam bit [25 - 1:0] STATION_ORV32_MA2IF_NPC_VALID_OFFSET = 64'h3930;
  localparam int STATION_ORV32_MA2IF_NPC_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_MA2IF_NPC_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA2IF_NPC_VALID_ADDR = 64'h3930;
  localparam bit [25 - 1:0] STATION_ORV32_EX2IF_KILL_OFFSET = 64'h238;
  localparam int STATION_ORV32_EX2IF_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_EX2IF_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX2IF_KILL_ADDR = 64'h238;
  localparam bit [25 - 1:0] STATION_ORV32_EX2ID_KILL_OFFSET = 64'h3938;
  localparam int STATION_ORV32_EX2ID_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_EX2ID_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX2ID_KILL_ADDR = 64'h3938;
  localparam bit [25 - 1:0] STATION_ORV32_BRANCH_SOLVED_OFFSET = 64'h240;
  localparam int STATION_ORV32_BRANCH_SOLVED_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_BRANCH_SOLVED_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_BRANCH_SOLVED_ADDR = 64'h240;
  localparam bit [25 - 1:0] STATION_ORV32_IS_WFE_OFFSET = 64'h3940;
  localparam int STATION_ORV32_IS_WFE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_IS_WFE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IS_WFE_ADDR = 64'h3940;
  localparam bit [25 - 1:0] STATION_ORV32_IF2ID_EXCP_VALID_OFFSET = 64'h248;
  localparam int STATION_ORV32_IF2ID_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_IF2ID_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_IF2ID_EXCP_VALID_ADDR = 64'h248;
  localparam bit [25 - 1:0] STATION_ORV32_ID2EX_EXCP_VALID_OFFSET = 64'h3948;
  localparam int STATION_ORV32_ID2EX_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_ID2EX_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_ID2EX_EXCP_VALID_ADDR = 64'h3948;
  localparam bit [25 - 1:0] STATION_ORV32_EX2MA_EXCP_VALID_OFFSET = 64'h250;
  localparam int STATION_ORV32_EX2MA_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_EX2MA_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_EX2MA_EXCP_VALID_ADDR = 64'h250;
  localparam bit [25 - 1:0] STATION_ORV32_MA2CS_EXCP_VALID_OFFSET = 64'h3950;
  localparam int STATION_ORV32_MA2CS_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_ORV32_MA2CS_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_ORV32_MA2CS_EXCP_VALID_ADDR = 64'h3950;
endpackage
`endif
`ifndef STATION_ORV32__SV
`define STATION_ORV32__SV
module station_orv32
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_orv32_pkg::*;
  import orv_typedef::*;
  (
  output [STATION_ORV32_ORV32_TOHOST_WIDTH - 1 : 0] out_orv32_tohost,
  output [STATION_ORV32_ORV32_FROMHOST_WIDTH - 1 : 0] out_orv32_fromhost,
  output vaddr_t out_s2b_cfg_rst_pc,
  output itb_sel_t out_s2b_cfg_itb_sel,
  output itb_addr_t out_b2s_itb_last_ptr,
  output vaddr_t out_s2b_bp_if_pc_0,
  output vaddr_t out_s2b_bp_if_pc_1,
  output vaddr_t out_s2b_bp_if_pc_2,
  output vaddr_t out_s2b_bp_if_pc_3,
  output vaddr_t out_s2b_bp_wb_pc_0,
  output vaddr_t out_s2b_bp_wb_pc_1,
  output vaddr_t out_s2b_bp_wb_pc_2,
  output vaddr_t out_s2b_bp_wb_pc_3,
  output vaddr_t out_b2s_if_pc,
  output vaddr_t out_b2s_wb_pc,
  output vaddr_t out_s2b_icache_base,
  output vaddr_t out_s2b_icache_bounds,
  output vaddr_t out_s2b_dcache_base,
  output vaddr_t out_s2b_dcache_bounds,
  output [STATION_ORV32_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0] out_s2b_cfg_lfsr_seed,
  output out_s2b_early_rstn,
  output out_s2b_rstn,
  output out_s2b_software_int,
  output out_s2b_timer_int,
  output out_s2b_ext_event,
  output out_s2b_debug_stall,
  output out_b2s_debug_stall_out,
  output out_s2b_debug_resume,
  output out_s2b_cfg_itb_en,
  output out_s2b_cfg_itb_wrap_around,
  output out_s2b_cfg_en_hpmcounter,
  output out_s2b_cfg_bypass_ic,
  output out_s2b_cfg_pwr_on,
  output out_s2b_cfg_sleep,
  output out_s2icg_clk_en,
  output out_s2b_en_bp_if_pc_0,
  output out_s2b_en_bp_if_pc_1,
  output out_s2b_en_bp_if_pc_2,
  output out_s2b_en_bp_if_pc_3,
  output out_s2b_en_bp_wb_pc_0,
  output out_s2b_en_bp_wb_pc_1,
  output out_s2b_en_bp_wb_pc_2,
  output out_s2b_en_bp_wb_pc_3,
  output out_b2s_if_valid,
  output out_b2s_wb_valid,
  output out_debug_info_enable,
  input logic vld_in_b2s_itb_last_ptr,
  input itb_addr_t in_b2s_itb_last_ptr,
  input logic vld_in_b2s_if_pc,
  input vaddr_t in_b2s_if_pc,
  input logic vld_in_b2s_wb_pc,
  input vaddr_t in_b2s_wb_pc,
  input logic vld_in_b2s_debug_stall_out,
  input in_b2s_debug_stall_out,
  input logic vld_in_b2s_if_valid,
  input in_b2s_if_valid,
  input logic vld_in_b2s_wb_valid,
  input in_b2s_wb_valid,
  input  logic                clk,
  input  logic                rstn,
  // i_req_ring_if & o_resp_ring_if
  output oursring_resp_if_b_t o_resp_ring_if_b,
  output oursring_resp_if_r_t o_resp_ring_if_r,
  output                      o_resp_ring_if_rvalid,
  input                       o_resp_ring_if_rready,
  output                      o_resp_ring_if_bvalid,
  input                       o_resp_ring_if_bready,
  input                       i_req_ring_if_awvalid,
  input                       i_req_ring_if_wvalid,
  input                       i_req_ring_if_arvalid,
  input  oursring_req_if_ar_t i_req_ring_if_ar,
  input  oursring_req_if_aw_t i_req_ring_if_aw,
  input  oursring_req_if_w_t  i_req_ring_if_w,
  output                      i_req_ring_if_arready,
  output                      i_req_ring_if_wready,
  output                      i_req_ring_if_awready,
  // o_req_ring_if & i_resp_ring_if
  input  oursring_resp_if_b_t i_resp_ring_if_b,
  input  oursring_resp_if_r_t i_resp_ring_if_r,
  input                       i_resp_ring_if_rvalid,
  output                      i_resp_ring_if_rready,
  input                       i_resp_ring_if_bvalid,
  output                      i_resp_ring_if_bready,
  output                      o_req_ring_if_awvalid,
  output                      o_req_ring_if_wvalid,
  output                      o_req_ring_if_arvalid,
  output oursring_req_if_ar_t o_req_ring_if_ar,
  output oursring_req_if_aw_t o_req_ring_if_aw,
  output oursring_req_if_w_t  o_req_ring_if_w,
  input                       o_req_ring_if_arready,
  input                       o_req_ring_if_wready,
  input                       o_req_ring_if_awready,
  // i_req_local_if & o_resp_local_if
  output oursring_resp_if_b_t o_resp_local_if_b,
  output oursring_resp_if_r_t o_resp_local_if_r,
  output                      o_resp_local_if_rvalid,
  input                       o_resp_local_if_rready,
  output                      o_resp_local_if_bvalid,
  input                       o_resp_local_if_bready,
  input                       i_req_local_if_awvalid,
  input                       i_req_local_if_wvalid,
  input                       i_req_local_if_arvalid,
  input  oursring_req_if_ar_t i_req_local_if_ar,
  input  oursring_req_if_aw_t i_req_local_if_aw,
  input  oursring_req_if_w_t  i_req_local_if_w,
  output                      i_req_local_if_arready,
  output                      i_req_local_if_wready,
  output                      i_req_local_if_awready,
  // o_req_local_if & i_resp_local_if
  input  oursring_resp_if_b_t i_resp_local_if_b,
  input  oursring_resp_if_r_t i_resp_local_if_r,
  input                       i_resp_local_if_rvalid,
  output                      i_resp_local_if_rready,
  input                       i_resp_local_if_bvalid,
  output                      i_resp_local_if_bready,
  output                      o_req_local_if_awvalid,
  output                      o_req_local_if_wvalid,
  output                      o_req_local_if_arvalid,
  output oursring_req_if_ar_t o_req_local_if_ar,
  output oursring_req_if_aw_t o_req_local_if_aw,
  output oursring_req_if_w_t  o_req_local_if_w,
  input                       o_req_local_if_arready,
  input                       o_req_local_if_wready,
  input                       o_req_local_if_awready
);
  localparam int                                STATION_ID_WIDTH_0 = STATION_ORV32_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_ORV32_BLKID;

  oursring_resp_if_b_t      station2brb_rsp_b;
  oursring_resp_if_r_t      station2brb_rsp_r;
  logic                     station2brb_rsp_rvalid;
  logic                     station2brb_rsp_rready;
  logic                     station2brb_rsp_bvalid;
  logic                     station2brb_rsp_bready;
  logic                     station2brb_req_awvalid;
  logic                     station2brb_req_wvalid;
  logic                     station2brb_req_arvalid;
  oursring_req_if_ar_t      station2brb_req_ar;
  oursring_req_if_aw_t      station2brb_req_aw;
  oursring_req_if_w_t       station2brb_req_w;
  logic                     station2brb_req_arready;
  logic                     station2brb_req_wready;
  logic                     station2brb_req_awready;

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_ORV32_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_ORV32_MAX_RING_ADDR)) station_u (

    .i_req_local_if_ar      (i_req_local_if_ar), 
    .i_req_local_if_awvalid (i_req_local_if_awvalid), 
    .i_req_local_if_awready (i_req_local_if_awready), 
    .i_req_local_if_wvalid  (i_req_local_if_wvalid), 
    .i_req_local_if_wready  (i_req_local_if_wready), 
    .i_req_local_if_arvalid (i_req_local_if_arvalid), 
    .i_req_local_if_arready (i_req_local_if_arready), 
    .i_req_local_if_w       (i_req_local_if_w), 
    .i_req_local_if_aw      (i_req_local_if_aw),
    .i_req_ring_if_ar       (i_req_ring_if_ar), 
    .i_req_ring_if_awvalid  (i_req_ring_if_awvalid), 
    .i_req_ring_if_awready  (i_req_ring_if_awready), 
    .i_req_ring_if_wvalid   (i_req_ring_if_wvalid), 
    .i_req_ring_if_wready   (i_req_ring_if_wready), 
    .i_req_ring_if_arvalid  (i_req_ring_if_arvalid), 
    .i_req_ring_if_arready  (i_req_ring_if_arready), 
    .i_req_ring_if_w        (i_req_ring_if_w), 
    .i_req_ring_if_aw       (i_req_ring_if_aw),
    .o_req_local_if_ar      (station2brb_req_ar), 
    .o_req_local_if_awvalid (station2brb_req_awvalid), 
    .o_req_local_if_awready (station2brb_req_awready), 
    .o_req_local_if_wvalid  (station2brb_req_wvalid), 
    .o_req_local_if_wready  (station2brb_req_wready), 
    .o_req_local_if_arvalid (station2brb_req_arvalid), 
    .o_req_local_if_arready (station2brb_req_arready), 
    .o_req_local_if_w       (station2brb_req_w), 
    .o_req_local_if_aw      (station2brb_req_aw),
    .o_req_ring_if_ar       (o_req_ring_if_ar), 
    .o_req_ring_if_awvalid  (o_req_ring_if_awvalid), 
    .o_req_ring_if_awready  (o_req_ring_if_awready), 
    .o_req_ring_if_wvalid   (o_req_ring_if_wvalid), 
    .o_req_ring_if_wready   (o_req_ring_if_wready), 
    .o_req_ring_if_arvalid  (o_req_ring_if_arvalid), 
    .o_req_ring_if_arready  (o_req_ring_if_arready), 
    .o_req_ring_if_w        (o_req_ring_if_w), 
    .o_req_ring_if_aw       (o_req_ring_if_aw),
    .i_resp_local_if_b      (station2brb_rsp_b), 
    .i_resp_local_if_r      (station2brb_rsp_r), 
    .i_resp_local_if_rvalid (station2brb_rsp_rvalid), 
    .i_resp_local_if_rready (station2brb_rsp_rready), 
    .i_resp_local_if_bvalid (station2brb_rsp_bvalid), 
    .i_resp_local_if_bready (station2brb_rsp_bready),
    .i_resp_ring_if_b       (i_resp_ring_if_b), 
    .i_resp_ring_if_r       (i_resp_ring_if_r), 
    .i_resp_ring_if_rvalid  (i_resp_ring_if_rvalid), 
    .i_resp_ring_if_rready  (i_resp_ring_if_rready), 
    .i_resp_ring_if_bvalid  (i_resp_ring_if_bvalid), 
    .i_resp_ring_if_bready  (i_resp_ring_if_bready),
    .o_resp_local_if_b      (o_resp_local_if_b), 
    .o_resp_local_if_r      (o_resp_local_if_r), 
    .o_resp_local_if_rvalid (o_resp_local_if_rvalid), 
    .o_resp_local_if_rready (o_resp_local_if_rready), 
    .o_resp_local_if_bvalid (o_resp_local_if_bvalid), 
    .o_resp_local_if_bready (o_resp_local_if_bready),
    .o_resp_ring_if_b       (o_resp_ring_if_b), 
    .o_resp_ring_if_r       (o_resp_ring_if_r), 
    .o_resp_ring_if_rvalid  (o_resp_ring_if_rvalid), 
    .o_resp_ring_if_rready  (o_resp_ring_if_rready), 
    .o_resp_ring_if_bvalid  (o_resp_ring_if_bvalid), 
    .o_resp_ring_if_bready  (o_resp_ring_if_bready),
    .clk                    (clk),
    .rstn                   (rstn)
    );

  ring_data_t wmask, wmask_inv;
  generate
    for (genvar i = 0; i < $bits(ring_strb_t); i++) begin : WMASK_GEN
      assign wmask[i * 8 +: 8]      = (station2brb_req_w.wstrb[i]) ? 8'hff : 8'h00;
      assign wmask_inv[i * 8 +: 8]  = (station2brb_req_w.wstrb[i]) ? 8'h00 : 8'hff;
    end
  endgenerate

  logic [STATION_ORV32_ORV32_TOHOST_WIDTH - 1 : 0] rff_orv32_tohost;
  logic [STATION_ORV32_ORV32_TOHOST_WIDTH - 1 : 0] orv32_tohost;
  logic load_orv32_tohost;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_orv32_tohost <= STATION_ORV32_ORV32_TOHOST_RSTVAL;
    end else if (load_orv32_tohost == 1'b1) begin
      rff_orv32_tohost <= (wmask & orv32_tohost) | (wmask_inv & rff_orv32_tohost);
    end
  end
  assign out_orv32_tohost = rff_orv32_tohost;
  logic [STATION_ORV32_ORV32_FROMHOST_WIDTH - 1 : 0] rff_orv32_fromhost;
  logic [STATION_ORV32_ORV32_FROMHOST_WIDTH - 1 : 0] orv32_fromhost;
  logic load_orv32_fromhost;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_orv32_fromhost <= STATION_ORV32_ORV32_FROMHOST_RSTVAL;
    end else if (load_orv32_fromhost == 1'b1) begin
      rff_orv32_fromhost <= (wmask & orv32_fromhost) | (wmask_inv & rff_orv32_fromhost);
    end
  end
  assign out_orv32_fromhost = rff_orv32_fromhost;
  vaddr_t rff_s2b_cfg_rst_pc;
  vaddr_t s2b_cfg_rst_pc;
  logic load_s2b_cfg_rst_pc;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_rst_pc <= vaddr_t'(STATION_ORV32_S2B_CFG_RST_PC_RSTVAL);
    end else if (load_s2b_cfg_rst_pc == 1'b1) begin
      rff_s2b_cfg_rst_pc <= vaddr_t'((wmask & s2b_cfg_rst_pc) | (wmask_inv & rff_s2b_cfg_rst_pc));
    end
  end
  assign out_s2b_cfg_rst_pc = rff_s2b_cfg_rst_pc;
  itb_sel_t rff_s2b_cfg_itb_sel;
  itb_sel_t s2b_cfg_itb_sel;
  logic load_s2b_cfg_itb_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_itb_sel <= itb_sel_t'(STATION_ORV32_S2B_CFG_ITB_SEL_RSTVAL);
    end else if (load_s2b_cfg_itb_sel == 1'b1) begin
      rff_s2b_cfg_itb_sel <= itb_sel_t'((wmask & s2b_cfg_itb_sel) | (wmask_inv & rff_s2b_cfg_itb_sel));
    end
  end
  assign out_s2b_cfg_itb_sel = rff_s2b_cfg_itb_sel;
  itb_addr_t rff_b2s_itb_last_ptr;
  itb_addr_t b2s_itb_last_ptr;
  logic load_b2s_itb_last_ptr;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_itb_last_ptr <= itb_addr_t'(STATION_ORV32_B2S_ITB_LAST_PTR_RSTVAL);
    end else if (load_b2s_itb_last_ptr == 1'b1) begin
      rff_b2s_itb_last_ptr <= itb_addr_t'((wmask & b2s_itb_last_ptr) | (wmask_inv & rff_b2s_itb_last_ptr));

    end else if (vld_in_b2s_itb_last_ptr == 1'b1) begin
      rff_b2s_itb_last_ptr <= in_b2s_itb_last_ptr;
    end
  end
  assign out_b2s_itb_last_ptr = rff_b2s_itb_last_ptr;
  vaddr_t rff_s2b_bp_if_pc_0;
  vaddr_t s2b_bp_if_pc_0;
  logic load_s2b_bp_if_pc_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_0 <= vaddr_t'(STATION_ORV32_S2B_BP_IF_PC_0_RSTVAL);
    end else if (load_s2b_bp_if_pc_0 == 1'b1) begin
      rff_s2b_bp_if_pc_0 <= vaddr_t'((wmask & s2b_bp_if_pc_0) | (wmask_inv & rff_s2b_bp_if_pc_0));
    end
  end
  assign out_s2b_bp_if_pc_0 = rff_s2b_bp_if_pc_0;
  vaddr_t rff_s2b_bp_if_pc_1;
  vaddr_t s2b_bp_if_pc_1;
  logic load_s2b_bp_if_pc_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_1 <= vaddr_t'(STATION_ORV32_S2B_BP_IF_PC_1_RSTVAL);
    end else if (load_s2b_bp_if_pc_1 == 1'b1) begin
      rff_s2b_bp_if_pc_1 <= vaddr_t'((wmask & s2b_bp_if_pc_1) | (wmask_inv & rff_s2b_bp_if_pc_1));
    end
  end
  assign out_s2b_bp_if_pc_1 = rff_s2b_bp_if_pc_1;
  vaddr_t rff_s2b_bp_if_pc_2;
  vaddr_t s2b_bp_if_pc_2;
  logic load_s2b_bp_if_pc_2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_2 <= vaddr_t'(STATION_ORV32_S2B_BP_IF_PC_2_RSTVAL);
    end else if (load_s2b_bp_if_pc_2 == 1'b1) begin
      rff_s2b_bp_if_pc_2 <= vaddr_t'((wmask & s2b_bp_if_pc_2) | (wmask_inv & rff_s2b_bp_if_pc_2));
    end
  end
  assign out_s2b_bp_if_pc_2 = rff_s2b_bp_if_pc_2;
  vaddr_t rff_s2b_bp_if_pc_3;
  vaddr_t s2b_bp_if_pc_3;
  logic load_s2b_bp_if_pc_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_3 <= vaddr_t'(STATION_ORV32_S2B_BP_IF_PC_3_RSTVAL);
    end else if (load_s2b_bp_if_pc_3 == 1'b1) begin
      rff_s2b_bp_if_pc_3 <= vaddr_t'((wmask & s2b_bp_if_pc_3) | (wmask_inv & rff_s2b_bp_if_pc_3));
    end
  end
  assign out_s2b_bp_if_pc_3 = rff_s2b_bp_if_pc_3;
  vaddr_t rff_s2b_bp_wb_pc_0;
  vaddr_t s2b_bp_wb_pc_0;
  logic load_s2b_bp_wb_pc_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_0 <= vaddr_t'(STATION_ORV32_S2B_BP_WB_PC_0_RSTVAL);
    end else if (load_s2b_bp_wb_pc_0 == 1'b1) begin
      rff_s2b_bp_wb_pc_0 <= vaddr_t'((wmask & s2b_bp_wb_pc_0) | (wmask_inv & rff_s2b_bp_wb_pc_0));
    end
  end
  assign out_s2b_bp_wb_pc_0 = rff_s2b_bp_wb_pc_0;
  vaddr_t rff_s2b_bp_wb_pc_1;
  vaddr_t s2b_bp_wb_pc_1;
  logic load_s2b_bp_wb_pc_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_1 <= vaddr_t'(STATION_ORV32_S2B_BP_WB_PC_1_RSTVAL);
    end else if (load_s2b_bp_wb_pc_1 == 1'b1) begin
      rff_s2b_bp_wb_pc_1 <= vaddr_t'((wmask & s2b_bp_wb_pc_1) | (wmask_inv & rff_s2b_bp_wb_pc_1));
    end
  end
  assign out_s2b_bp_wb_pc_1 = rff_s2b_bp_wb_pc_1;
  vaddr_t rff_s2b_bp_wb_pc_2;
  vaddr_t s2b_bp_wb_pc_2;
  logic load_s2b_bp_wb_pc_2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_2 <= vaddr_t'(STATION_ORV32_S2B_BP_WB_PC_2_RSTVAL);
    end else if (load_s2b_bp_wb_pc_2 == 1'b1) begin
      rff_s2b_bp_wb_pc_2 <= vaddr_t'((wmask & s2b_bp_wb_pc_2) | (wmask_inv & rff_s2b_bp_wb_pc_2));
    end
  end
  assign out_s2b_bp_wb_pc_2 = rff_s2b_bp_wb_pc_2;
  vaddr_t rff_s2b_bp_wb_pc_3;
  vaddr_t s2b_bp_wb_pc_3;
  logic load_s2b_bp_wb_pc_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_3 <= vaddr_t'(STATION_ORV32_S2B_BP_WB_PC_3_RSTVAL);
    end else if (load_s2b_bp_wb_pc_3 == 1'b1) begin
      rff_s2b_bp_wb_pc_3 <= vaddr_t'((wmask & s2b_bp_wb_pc_3) | (wmask_inv & rff_s2b_bp_wb_pc_3));
    end
  end
  assign out_s2b_bp_wb_pc_3 = rff_s2b_bp_wb_pc_3;
  vaddr_t rff_b2s_if_pc;
  vaddr_t b2s_if_pc;
  logic load_b2s_if_pc;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_if_pc <= vaddr_t'(STATION_ORV32_B2S_IF_PC_RSTVAL);
    end else if (load_b2s_if_pc == 1'b1) begin
      rff_b2s_if_pc <= vaddr_t'((wmask & b2s_if_pc) | (wmask_inv & rff_b2s_if_pc));

    end else if (vld_in_b2s_if_pc == 1'b1) begin
      rff_b2s_if_pc <= in_b2s_if_pc;
    end
  end
  assign out_b2s_if_pc = rff_b2s_if_pc;
  vaddr_t rff_b2s_wb_pc;
  vaddr_t b2s_wb_pc;
  logic load_b2s_wb_pc;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_wb_pc <= vaddr_t'(STATION_ORV32_B2S_WB_PC_RSTVAL);
    end else if (load_b2s_wb_pc == 1'b1) begin
      rff_b2s_wb_pc <= vaddr_t'((wmask & b2s_wb_pc) | (wmask_inv & rff_b2s_wb_pc));

    end else if (vld_in_b2s_wb_pc == 1'b1) begin
      rff_b2s_wb_pc <= in_b2s_wb_pc;
    end
  end
  assign out_b2s_wb_pc = rff_b2s_wb_pc;
  vaddr_t rff_s2b_icache_base;
  vaddr_t s2b_icache_base;
  logic load_s2b_icache_base;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_icache_base <= vaddr_t'(STATION_ORV32_S2B_ICACHE_BASE_RSTVAL);
    end else if (load_s2b_icache_base == 1'b1) begin
      rff_s2b_icache_base <= vaddr_t'((wmask & s2b_icache_base) | (wmask_inv & rff_s2b_icache_base));
    end
  end
  assign out_s2b_icache_base = rff_s2b_icache_base;
  vaddr_t rff_s2b_icache_bounds;
  vaddr_t s2b_icache_bounds;
  logic load_s2b_icache_bounds;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_icache_bounds <= vaddr_t'(STATION_ORV32_S2B_ICACHE_BOUNDS_RSTVAL);
    end else if (load_s2b_icache_bounds == 1'b1) begin
      rff_s2b_icache_bounds <= vaddr_t'((wmask & s2b_icache_bounds) | (wmask_inv & rff_s2b_icache_bounds));
    end
  end
  assign out_s2b_icache_bounds = rff_s2b_icache_bounds;
  vaddr_t rff_s2b_dcache_base;
  vaddr_t s2b_dcache_base;
  logic load_s2b_dcache_base;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_dcache_base <= vaddr_t'(STATION_ORV32_S2B_DCACHE_BASE_RSTVAL);
    end else if (load_s2b_dcache_base == 1'b1) begin
      rff_s2b_dcache_base <= vaddr_t'((wmask & s2b_dcache_base) | (wmask_inv & rff_s2b_dcache_base));
    end
  end
  assign out_s2b_dcache_base = rff_s2b_dcache_base;
  vaddr_t rff_s2b_dcache_bounds;
  vaddr_t s2b_dcache_bounds;
  logic load_s2b_dcache_bounds;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_dcache_bounds <= vaddr_t'(STATION_ORV32_S2B_DCACHE_BOUNDS_RSTVAL);
    end else if (load_s2b_dcache_bounds == 1'b1) begin
      rff_s2b_dcache_bounds <= vaddr_t'((wmask & s2b_dcache_bounds) | (wmask_inv & rff_s2b_dcache_bounds));
    end
  end
  assign out_s2b_dcache_bounds = rff_s2b_dcache_bounds;
  logic [STATION_ORV32_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0] rff_s2b_cfg_lfsr_seed;
  logic [STATION_ORV32_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0] s2b_cfg_lfsr_seed;
  logic load_s2b_cfg_lfsr_seed;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_lfsr_seed <= STATION_ORV32_S2B_CFG_LFSR_SEED_RSTVAL;
    end else if (load_s2b_cfg_lfsr_seed == 1'b1) begin
      rff_s2b_cfg_lfsr_seed <= (wmask & s2b_cfg_lfsr_seed) | (wmask_inv & rff_s2b_cfg_lfsr_seed);
    end
  end
  assign out_s2b_cfg_lfsr_seed = rff_s2b_cfg_lfsr_seed;
  logic [STATION_ORV32_S2B_EARLY_RSTN_WIDTH - 1 : 0] rff_s2b_early_rstn;
  logic [STATION_ORV32_S2B_EARLY_RSTN_WIDTH - 1 : 0] s2b_early_rstn;
  logic load_s2b_early_rstn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_early_rstn <= STATION_ORV32_S2B_EARLY_RSTN_RSTVAL;
    end else if (load_s2b_early_rstn == 1'b1) begin
      rff_s2b_early_rstn <= (wmask & s2b_early_rstn) | (wmask_inv & rff_s2b_early_rstn);
    end
  end
  assign out_s2b_early_rstn = rff_s2b_early_rstn;
  logic [STATION_ORV32_S2B_RSTN_WIDTH - 1 : 0] rff_s2b_rstn;
  logic [STATION_ORV32_S2B_RSTN_WIDTH - 1 : 0] s2b_rstn;
  logic load_s2b_rstn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_rstn <= STATION_ORV32_S2B_RSTN_RSTVAL;
    end else if (load_s2b_rstn == 1'b1) begin
      rff_s2b_rstn <= (wmask & s2b_rstn) | (wmask_inv & rff_s2b_rstn);
    end
  end
  assign out_s2b_rstn = rff_s2b_rstn;
  logic [STATION_ORV32_S2B_SOFTWARE_INT_WIDTH - 1 : 0] rff_s2b_software_int;
  logic [STATION_ORV32_S2B_SOFTWARE_INT_WIDTH - 1 : 0] s2b_software_int;
  logic load_s2b_software_int;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_software_int <= STATION_ORV32_S2B_SOFTWARE_INT_RSTVAL;
    end else if (load_s2b_software_int == 1'b1) begin
      rff_s2b_software_int <= (wmask & s2b_software_int) | (wmask_inv & rff_s2b_software_int);
    end
  end
  assign out_s2b_software_int = rff_s2b_software_int;
  logic [STATION_ORV32_S2B_TIMER_INT_WIDTH - 1 : 0] rff_s2b_timer_int;
  logic [STATION_ORV32_S2B_TIMER_INT_WIDTH - 1 : 0] s2b_timer_int;
  logic load_s2b_timer_int;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_timer_int <= STATION_ORV32_S2B_TIMER_INT_RSTVAL;
    end else if (load_s2b_timer_int == 1'b1) begin
      rff_s2b_timer_int <= (wmask & s2b_timer_int) | (wmask_inv & rff_s2b_timer_int);
    end
  end
  assign out_s2b_timer_int = rff_s2b_timer_int;
  logic [STATION_ORV32_S2B_EXT_EVENT_WIDTH - 1 : 0] rff_s2b_ext_event;
  logic [STATION_ORV32_S2B_EXT_EVENT_WIDTH - 1 : 0] s2b_ext_event;
  logic load_s2b_ext_event;

  logic dff_load_s2b_ext_event_d;
  always_ff @(posedge clk) begin
    dff_load_s2b_ext_event_d <= load_s2b_ext_event;
  end

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ext_event <= STATION_ORV32_S2B_EXT_EVENT_RSTVAL;
    end else if (load_s2b_ext_event == 1'b1) begin
      rff_s2b_ext_event <= (wmask & s2b_ext_event) | (wmask_inv & rff_s2b_ext_event);

    end else if (dff_load_s2b_ext_event_d == 1'b1) begin
      rff_s2b_ext_event <= STATION_ORV32_S2B_EXT_EVENT_RSTVAL;
    end
  end
  assign out_s2b_ext_event = rff_s2b_ext_event;
  logic [STATION_ORV32_S2B_DEBUG_STALL_WIDTH - 1 : 0] rff_s2b_debug_stall;
  logic [STATION_ORV32_S2B_DEBUG_STALL_WIDTH - 1 : 0] s2b_debug_stall;
  logic load_s2b_debug_stall;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_debug_stall <= STATION_ORV32_S2B_DEBUG_STALL_RSTVAL;
    end else if (load_s2b_debug_stall == 1'b1) begin
      rff_s2b_debug_stall <= (wmask & s2b_debug_stall) | (wmask_inv & rff_s2b_debug_stall);
    end
  end
  assign out_s2b_debug_stall = rff_s2b_debug_stall;
  logic [STATION_ORV32_B2S_DEBUG_STALL_OUT_WIDTH - 1 : 0] rff_b2s_debug_stall_out;
  logic [STATION_ORV32_B2S_DEBUG_STALL_OUT_WIDTH - 1 : 0] b2s_debug_stall_out;
  logic load_b2s_debug_stall_out;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_debug_stall_out <= STATION_ORV32_B2S_DEBUG_STALL_OUT_RSTVAL;
    end else if (load_b2s_debug_stall_out == 1'b1) begin
      rff_b2s_debug_stall_out <= (wmask & b2s_debug_stall_out) | (wmask_inv & rff_b2s_debug_stall_out);

    end else if (vld_in_b2s_debug_stall_out == 1'b1) begin
      rff_b2s_debug_stall_out <= in_b2s_debug_stall_out;
    end
  end
  assign out_b2s_debug_stall_out = rff_b2s_debug_stall_out;
  logic [STATION_ORV32_S2B_DEBUG_RESUME_WIDTH - 1 : 0] rff_s2b_debug_resume;
  logic [STATION_ORV32_S2B_DEBUG_RESUME_WIDTH - 1 : 0] s2b_debug_resume;
  logic load_s2b_debug_resume;

  logic dff_load_s2b_debug_resume_d;
  always_ff @(posedge clk) begin
    dff_load_s2b_debug_resume_d <= load_s2b_debug_resume;
  end

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_debug_resume <= STATION_ORV32_S2B_DEBUG_RESUME_RSTVAL;
    end else if (load_s2b_debug_resume == 1'b1) begin
      rff_s2b_debug_resume <= (wmask & s2b_debug_resume) | (wmask_inv & rff_s2b_debug_resume);

    end else if (dff_load_s2b_debug_resume_d == 1'b1) begin
      rff_s2b_debug_resume <= STATION_ORV32_S2B_DEBUG_RESUME_RSTVAL;
    end
  end
  assign out_s2b_debug_resume = rff_s2b_debug_resume;
  logic [STATION_ORV32_S2B_CFG_ITB_EN_WIDTH - 1 : 0] rff_s2b_cfg_itb_en;
  logic [STATION_ORV32_S2B_CFG_ITB_EN_WIDTH - 1 : 0] s2b_cfg_itb_en;
  logic load_s2b_cfg_itb_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_itb_en <= STATION_ORV32_S2B_CFG_ITB_EN_RSTVAL;
    end else if (load_s2b_cfg_itb_en == 1'b1) begin
      rff_s2b_cfg_itb_en <= (wmask & s2b_cfg_itb_en) | (wmask_inv & rff_s2b_cfg_itb_en);
    end
  end
  assign out_s2b_cfg_itb_en = rff_s2b_cfg_itb_en;
  logic [STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_WIDTH - 1 : 0] rff_s2b_cfg_itb_wrap_around;
  logic [STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_WIDTH - 1 : 0] s2b_cfg_itb_wrap_around;
  logic load_s2b_cfg_itb_wrap_around;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_itb_wrap_around <= STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_RSTVAL;
    end else if (load_s2b_cfg_itb_wrap_around == 1'b1) begin
      rff_s2b_cfg_itb_wrap_around <= (wmask & s2b_cfg_itb_wrap_around) | (wmask_inv & rff_s2b_cfg_itb_wrap_around);
    end
  end
  assign out_s2b_cfg_itb_wrap_around = rff_s2b_cfg_itb_wrap_around;
  logic [STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_WIDTH - 1 : 0] rff_s2b_cfg_en_hpmcounter;
  logic [STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_WIDTH - 1 : 0] s2b_cfg_en_hpmcounter;
  logic load_s2b_cfg_en_hpmcounter;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_en_hpmcounter <= STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_RSTVAL;
    end else if (load_s2b_cfg_en_hpmcounter == 1'b1) begin
      rff_s2b_cfg_en_hpmcounter <= (wmask & s2b_cfg_en_hpmcounter) | (wmask_inv & rff_s2b_cfg_en_hpmcounter);
    end
  end
  assign out_s2b_cfg_en_hpmcounter = rff_s2b_cfg_en_hpmcounter;
  logic [STATION_ORV32_S2B_CFG_BYPASS_IC_WIDTH - 1 : 0] rff_s2b_cfg_bypass_ic;
  logic [STATION_ORV32_S2B_CFG_BYPASS_IC_WIDTH - 1 : 0] s2b_cfg_bypass_ic;
  logic load_s2b_cfg_bypass_ic;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_bypass_ic <= STATION_ORV32_S2B_CFG_BYPASS_IC_RSTVAL;
    end else if (load_s2b_cfg_bypass_ic == 1'b1) begin
      rff_s2b_cfg_bypass_ic <= (wmask & s2b_cfg_bypass_ic) | (wmask_inv & rff_s2b_cfg_bypass_ic);
    end
  end
  assign out_s2b_cfg_bypass_ic = rff_s2b_cfg_bypass_ic;
  logic [STATION_ORV32_S2B_CFG_PWR_ON_WIDTH - 1 : 0] rff_s2b_cfg_pwr_on;
  logic [STATION_ORV32_S2B_CFG_PWR_ON_WIDTH - 1 : 0] s2b_cfg_pwr_on;
  logic load_s2b_cfg_pwr_on;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_pwr_on <= STATION_ORV32_S2B_CFG_PWR_ON_RSTVAL;
    end else if (load_s2b_cfg_pwr_on == 1'b1) begin
      rff_s2b_cfg_pwr_on <= (wmask & s2b_cfg_pwr_on) | (wmask_inv & rff_s2b_cfg_pwr_on);
    end
  end
  assign out_s2b_cfg_pwr_on = rff_s2b_cfg_pwr_on;
  logic [STATION_ORV32_S2B_CFG_SLEEP_WIDTH - 1 : 0] rff_s2b_cfg_sleep;
  logic [STATION_ORV32_S2B_CFG_SLEEP_WIDTH - 1 : 0] s2b_cfg_sleep;
  logic load_s2b_cfg_sleep;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_sleep <= STATION_ORV32_S2B_CFG_SLEEP_RSTVAL;
    end else if (load_s2b_cfg_sleep == 1'b1) begin
      rff_s2b_cfg_sleep <= (wmask & s2b_cfg_sleep) | (wmask_inv & rff_s2b_cfg_sleep);
    end
  end
  assign out_s2b_cfg_sleep = rff_s2b_cfg_sleep;
  logic [STATION_ORV32_S2ICG_CLK_EN_WIDTH - 1 : 0] rff_s2icg_clk_en;
  logic [STATION_ORV32_S2ICG_CLK_EN_WIDTH - 1 : 0] s2icg_clk_en;
  logic load_s2icg_clk_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2icg_clk_en <= STATION_ORV32_S2ICG_CLK_EN_RSTVAL;
    end else if (load_s2icg_clk_en == 1'b1) begin
      rff_s2icg_clk_en <= (wmask & s2icg_clk_en) | (wmask_inv & rff_s2icg_clk_en);
    end
  end
  assign out_s2icg_clk_en = rff_s2icg_clk_en;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_0_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_0;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_0_WIDTH - 1 : 0] s2b_en_bp_if_pc_0;
  logic load_s2b_en_bp_if_pc_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_0 <= STATION_ORV32_S2B_EN_BP_IF_PC_0_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_0 == 1'b1) begin
      rff_s2b_en_bp_if_pc_0 <= (wmask & s2b_en_bp_if_pc_0) | (wmask_inv & rff_s2b_en_bp_if_pc_0);
    end
  end
  assign out_s2b_en_bp_if_pc_0 = rff_s2b_en_bp_if_pc_0;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_1_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_1;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_1_WIDTH - 1 : 0] s2b_en_bp_if_pc_1;
  logic load_s2b_en_bp_if_pc_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_1 <= STATION_ORV32_S2B_EN_BP_IF_PC_1_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_1 == 1'b1) begin
      rff_s2b_en_bp_if_pc_1 <= (wmask & s2b_en_bp_if_pc_1) | (wmask_inv & rff_s2b_en_bp_if_pc_1);
    end
  end
  assign out_s2b_en_bp_if_pc_1 = rff_s2b_en_bp_if_pc_1;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_2_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_2;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_2_WIDTH - 1 : 0] s2b_en_bp_if_pc_2;
  logic load_s2b_en_bp_if_pc_2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_2 <= STATION_ORV32_S2B_EN_BP_IF_PC_2_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_2 == 1'b1) begin
      rff_s2b_en_bp_if_pc_2 <= (wmask & s2b_en_bp_if_pc_2) | (wmask_inv & rff_s2b_en_bp_if_pc_2);
    end
  end
  assign out_s2b_en_bp_if_pc_2 = rff_s2b_en_bp_if_pc_2;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_3_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_3;
  logic [STATION_ORV32_S2B_EN_BP_IF_PC_3_WIDTH - 1 : 0] s2b_en_bp_if_pc_3;
  logic load_s2b_en_bp_if_pc_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_3 <= STATION_ORV32_S2B_EN_BP_IF_PC_3_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_3 == 1'b1) begin
      rff_s2b_en_bp_if_pc_3 <= (wmask & s2b_en_bp_if_pc_3) | (wmask_inv & rff_s2b_en_bp_if_pc_3);
    end
  end
  assign out_s2b_en_bp_if_pc_3 = rff_s2b_en_bp_if_pc_3;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_0_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_0;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_0_WIDTH - 1 : 0] s2b_en_bp_wb_pc_0;
  logic load_s2b_en_bp_wb_pc_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_0 <= STATION_ORV32_S2B_EN_BP_WB_PC_0_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_0 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_0 <= (wmask & s2b_en_bp_wb_pc_0) | (wmask_inv & rff_s2b_en_bp_wb_pc_0);
    end
  end
  assign out_s2b_en_bp_wb_pc_0 = rff_s2b_en_bp_wb_pc_0;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_1_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_1;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_1_WIDTH - 1 : 0] s2b_en_bp_wb_pc_1;
  logic load_s2b_en_bp_wb_pc_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_1 <= STATION_ORV32_S2B_EN_BP_WB_PC_1_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_1 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_1 <= (wmask & s2b_en_bp_wb_pc_1) | (wmask_inv & rff_s2b_en_bp_wb_pc_1);
    end
  end
  assign out_s2b_en_bp_wb_pc_1 = rff_s2b_en_bp_wb_pc_1;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_2_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_2;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_2_WIDTH - 1 : 0] s2b_en_bp_wb_pc_2;
  logic load_s2b_en_bp_wb_pc_2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_2 <= STATION_ORV32_S2B_EN_BP_WB_PC_2_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_2 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_2 <= (wmask & s2b_en_bp_wb_pc_2) | (wmask_inv & rff_s2b_en_bp_wb_pc_2);
    end
  end
  assign out_s2b_en_bp_wb_pc_2 = rff_s2b_en_bp_wb_pc_2;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_3_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_3;
  logic [STATION_ORV32_S2B_EN_BP_WB_PC_3_WIDTH - 1 : 0] s2b_en_bp_wb_pc_3;
  logic load_s2b_en_bp_wb_pc_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_3 <= STATION_ORV32_S2B_EN_BP_WB_PC_3_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_3 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_3 <= (wmask & s2b_en_bp_wb_pc_3) | (wmask_inv & rff_s2b_en_bp_wb_pc_3);
    end
  end
  assign out_s2b_en_bp_wb_pc_3 = rff_s2b_en_bp_wb_pc_3;
  logic [STATION_ORV32_B2S_IF_VALID_WIDTH - 1 : 0] rff_b2s_if_valid;
  logic [STATION_ORV32_B2S_IF_VALID_WIDTH - 1 : 0] b2s_if_valid;
  logic load_b2s_if_valid;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_if_valid <= STATION_ORV32_B2S_IF_VALID_RSTVAL;
    end else if (load_b2s_if_valid == 1'b1) begin
      rff_b2s_if_valid <= (wmask & b2s_if_valid) | (wmask_inv & rff_b2s_if_valid);

    end else if (vld_in_b2s_if_valid == 1'b1) begin
      rff_b2s_if_valid <= in_b2s_if_valid;
    end
  end
  assign out_b2s_if_valid = rff_b2s_if_valid;
  logic [STATION_ORV32_B2S_WB_VALID_WIDTH - 1 : 0] rff_b2s_wb_valid;
  logic [STATION_ORV32_B2S_WB_VALID_WIDTH - 1 : 0] b2s_wb_valid;
  logic load_b2s_wb_valid;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_wb_valid <= STATION_ORV32_B2S_WB_VALID_RSTVAL;
    end else if (load_b2s_wb_valid == 1'b1) begin
      rff_b2s_wb_valid <= (wmask & b2s_wb_valid) | (wmask_inv & rff_b2s_wb_valid);

    end else if (vld_in_b2s_wb_valid == 1'b1) begin
      rff_b2s_wb_valid <= in_b2s_wb_valid;
    end
  end
  assign out_b2s_wb_valid = rff_b2s_wb_valid;
  logic [STATION_ORV32_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] rff_debug_info_enable;
  logic [STATION_ORV32_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] debug_info_enable;
  logic load_debug_info_enable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_debug_info_enable <= STATION_ORV32_DEBUG_INFO_ENABLE_RSTVAL;
    end else if (load_debug_info_enable == 1'b1) begin
      rff_debug_info_enable <= (wmask & debug_info_enable) | (wmask_inv & rff_debug_info_enable);
    end
  end
  assign out_debug_info_enable = rff_debug_info_enable;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_ORV32_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_ORV32_DATA_WIDTH{1'b0}};
    orv32_tohost = rff_orv32_tohost;
    load_orv32_tohost = 1'b0;
    orv32_fromhost = rff_orv32_fromhost;
    load_orv32_fromhost = 1'b0;
    s2b_cfg_rst_pc = rff_s2b_cfg_rst_pc;
    load_s2b_cfg_rst_pc = 1'b0;
    s2b_cfg_itb_sel = rff_s2b_cfg_itb_sel;
    load_s2b_cfg_itb_sel = 1'b0;
    b2s_itb_last_ptr = rff_b2s_itb_last_ptr;
    load_b2s_itb_last_ptr = 1'b0;
    s2b_bp_if_pc_0 = rff_s2b_bp_if_pc_0;
    load_s2b_bp_if_pc_0 = 1'b0;
    s2b_bp_if_pc_1 = rff_s2b_bp_if_pc_1;
    load_s2b_bp_if_pc_1 = 1'b0;
    s2b_bp_if_pc_2 = rff_s2b_bp_if_pc_2;
    load_s2b_bp_if_pc_2 = 1'b0;
    s2b_bp_if_pc_3 = rff_s2b_bp_if_pc_3;
    load_s2b_bp_if_pc_3 = 1'b0;
    s2b_bp_wb_pc_0 = rff_s2b_bp_wb_pc_0;
    load_s2b_bp_wb_pc_0 = 1'b0;
    s2b_bp_wb_pc_1 = rff_s2b_bp_wb_pc_1;
    load_s2b_bp_wb_pc_1 = 1'b0;
    s2b_bp_wb_pc_2 = rff_s2b_bp_wb_pc_2;
    load_s2b_bp_wb_pc_2 = 1'b0;
    s2b_bp_wb_pc_3 = rff_s2b_bp_wb_pc_3;
    load_s2b_bp_wb_pc_3 = 1'b0;
    b2s_if_pc = rff_b2s_if_pc;
    load_b2s_if_pc = 1'b0;
    b2s_wb_pc = rff_b2s_wb_pc;
    load_b2s_wb_pc = 1'b0;
    s2b_icache_base = rff_s2b_icache_base;
    load_s2b_icache_base = 1'b0;
    s2b_icache_bounds = rff_s2b_icache_bounds;
    load_s2b_icache_bounds = 1'b0;
    s2b_dcache_base = rff_s2b_dcache_base;
    load_s2b_dcache_base = 1'b0;
    s2b_dcache_bounds = rff_s2b_dcache_bounds;
    load_s2b_dcache_bounds = 1'b0;
    s2b_cfg_lfsr_seed = rff_s2b_cfg_lfsr_seed;
    load_s2b_cfg_lfsr_seed = 1'b0;
    s2b_early_rstn = rff_s2b_early_rstn;
    load_s2b_early_rstn = 1'b0;
    s2b_rstn = rff_s2b_rstn;
    load_s2b_rstn = 1'b0;
    s2b_software_int = rff_s2b_software_int;
    load_s2b_software_int = 1'b0;
    s2b_timer_int = rff_s2b_timer_int;
    load_s2b_timer_int = 1'b0;
    s2b_ext_event = rff_s2b_ext_event;
    load_s2b_ext_event = 1'b0;
    s2b_debug_stall = rff_s2b_debug_stall;
    load_s2b_debug_stall = 1'b0;
    b2s_debug_stall_out = rff_b2s_debug_stall_out;
    load_b2s_debug_stall_out = 1'b0;
    s2b_debug_resume = rff_s2b_debug_resume;
    load_s2b_debug_resume = 1'b0;
    s2b_cfg_itb_en = rff_s2b_cfg_itb_en;
    load_s2b_cfg_itb_en = 1'b0;
    s2b_cfg_itb_wrap_around = rff_s2b_cfg_itb_wrap_around;
    load_s2b_cfg_itb_wrap_around = 1'b0;
    s2b_cfg_en_hpmcounter = rff_s2b_cfg_en_hpmcounter;
    load_s2b_cfg_en_hpmcounter = 1'b0;
    s2b_cfg_bypass_ic = rff_s2b_cfg_bypass_ic;
    load_s2b_cfg_bypass_ic = 1'b0;
    s2b_cfg_pwr_on = rff_s2b_cfg_pwr_on;
    load_s2b_cfg_pwr_on = 1'b0;
    s2b_cfg_sleep = rff_s2b_cfg_sleep;
    load_s2b_cfg_sleep = 1'b0;
    s2icg_clk_en = rff_s2icg_clk_en;
    load_s2icg_clk_en = 1'b0;
    s2b_en_bp_if_pc_0 = rff_s2b_en_bp_if_pc_0;
    load_s2b_en_bp_if_pc_0 = 1'b0;
    s2b_en_bp_if_pc_1 = rff_s2b_en_bp_if_pc_1;
    load_s2b_en_bp_if_pc_1 = 1'b0;
    s2b_en_bp_if_pc_2 = rff_s2b_en_bp_if_pc_2;
    load_s2b_en_bp_if_pc_2 = 1'b0;
    s2b_en_bp_if_pc_3 = rff_s2b_en_bp_if_pc_3;
    load_s2b_en_bp_if_pc_3 = 1'b0;
    s2b_en_bp_wb_pc_0 = rff_s2b_en_bp_wb_pc_0;
    load_s2b_en_bp_wb_pc_0 = 1'b0;
    s2b_en_bp_wb_pc_1 = rff_s2b_en_bp_wb_pc_1;
    load_s2b_en_bp_wb_pc_1 = 1'b0;
    s2b_en_bp_wb_pc_2 = rff_s2b_en_bp_wb_pc_2;
    load_s2b_en_bp_wb_pc_2 = 1'b0;
    s2b_en_bp_wb_pc_3 = rff_s2b_en_bp_wb_pc_3;
    load_s2b_en_bp_wb_pc_3 = 1'b0;
    b2s_if_valid = rff_b2s_if_valid;
    load_b2s_if_valid = 1'b0;
    b2s_wb_valid = rff_b2s_wb_valid;
    load_b2s_wb_valid = 1'b0;
    debug_info_enable = rff_debug_info_enable;
    load_debug_info_enable = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_ORV32_TOHOST_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_orv32_tohost;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_ORV32_FROMHOST_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_orv32_fromhost;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_RST_PC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_rst_pc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_ITB_SEL_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_itb_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_ITB_LAST_PTR_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_b2s_itb_last_ptr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_IF_PC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_b2s_if_pc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_WB_PC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_b2s_wb_pc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_ICACHE_BASE_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_icache_base;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_ICACHE_BOUNDS_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_icache_bounds;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DCACHE_BASE_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_dcache_base;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DCACHE_BOUNDS_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_dcache_bounds;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_LFSR_SEED_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_lfsr_seed;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EARLY_RSTN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_early_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_RSTN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_SOFTWARE_INT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_software_int;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_TIMER_INT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_timer_int;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EXT_EVENT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_ext_event;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DEBUG_STALL_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_debug_stall;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_DEBUG_STALL_OUT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_b2s_debug_stall_out;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DEBUG_RESUME_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_debug_resume;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_ITB_EN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_itb_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_itb_wrap_around;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_en_hpmcounter;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_BYPASS_IC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_bypass_ic;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_PWR_ON_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_pwr_on;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_SLEEP_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_sleep;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2icg_clk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_IF_VALID_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_b2s_if_valid;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_WB_VALID_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_b2s_wb_valid;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          data = rff_debug_info_enable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_ORV32_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_ORV32_TOHOST_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          orv32_tohost = station2brb_req_w.wdata[STATION_ORV32_ORV32_TOHOST_WIDTH - 1 : 0];
          load_orv32_tohost = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_ORV32_FROMHOST_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          orv32_fromhost = station2brb_req_w.wdata[STATION_ORV32_ORV32_FROMHOST_WIDTH - 1 : 0];
          load_orv32_fromhost = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_RST_PC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_rst_pc = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_RST_PC_WIDTH - 1 : 0]);
          load_s2b_cfg_rst_pc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_ITB_SEL_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_itb_sel = itb_sel_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_ITB_SEL_WIDTH - 1 : 0]);
          load_s2b_cfg_itb_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_ITB_LAST_PTR_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          b2s_itb_last_ptr = itb_addr_t'(station2brb_req_w.wdata[STATION_ORV32_B2S_ITB_LAST_PTR_WIDTH - 1 : 0]);
          load_b2s_itb_last_ptr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_0 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_IF_PC_0_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_1 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_IF_PC_1_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_2 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_IF_PC_2_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_IF_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_3 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_IF_PC_3_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_0 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_WB_PC_0_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_1 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_WB_PC_1_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_2 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_WB_PC_2_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_BP_WB_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_3 = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_BP_WB_PC_3_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_IF_PC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          b2s_if_pc = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_B2S_IF_PC_WIDTH - 1 : 0]);
          load_b2s_if_pc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_WB_PC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          b2s_wb_pc = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_B2S_WB_PC_WIDTH - 1 : 0]);
          load_b2s_wb_pc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_ICACHE_BASE_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_icache_base = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_ICACHE_BASE_WIDTH - 1 : 0]);
          load_s2b_icache_base = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_ICACHE_BOUNDS_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_icache_bounds = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_ICACHE_BOUNDS_WIDTH - 1 : 0]);
          load_s2b_icache_bounds = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DCACHE_BASE_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_dcache_base = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_DCACHE_BASE_WIDTH - 1 : 0]);
          load_s2b_dcache_base = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DCACHE_BOUNDS_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_dcache_bounds = vaddr_t'(station2brb_req_w.wdata[STATION_ORV32_S2B_DCACHE_BOUNDS_WIDTH - 1 : 0]);
          load_s2b_dcache_bounds = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_LFSR_SEED_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_lfsr_seed = station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0];
          load_s2b_cfg_lfsr_seed = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EARLY_RSTN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_early_rstn = station2brb_req_w.wdata[STATION_ORV32_S2B_EARLY_RSTN_WIDTH - 1 : 0];
          load_s2b_early_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_RSTN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_rstn = station2brb_req_w.wdata[STATION_ORV32_S2B_RSTN_WIDTH - 1 : 0];
          load_s2b_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_SOFTWARE_INT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_software_int = station2brb_req_w.wdata[STATION_ORV32_S2B_SOFTWARE_INT_WIDTH - 1 : 0];
          load_s2b_software_int = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_TIMER_INT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_timer_int = station2brb_req_w.wdata[STATION_ORV32_S2B_TIMER_INT_WIDTH - 1 : 0];
          load_s2b_timer_int = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EXT_EVENT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_ext_event = station2brb_req_w.wdata[STATION_ORV32_S2B_EXT_EVENT_WIDTH - 1 : 0];
          load_s2b_ext_event = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DEBUG_STALL_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_debug_stall = station2brb_req_w.wdata[STATION_ORV32_S2B_DEBUG_STALL_WIDTH - 1 : 0];
          load_s2b_debug_stall = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_DEBUG_STALL_OUT_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          b2s_debug_stall_out = station2brb_req_w.wdata[STATION_ORV32_B2S_DEBUG_STALL_OUT_WIDTH - 1 : 0];
          load_b2s_debug_stall_out = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_DEBUG_RESUME_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_debug_resume = station2brb_req_w.wdata[STATION_ORV32_S2B_DEBUG_RESUME_WIDTH - 1 : 0];
          load_s2b_debug_resume = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_ITB_EN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_itb_en = station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_ITB_EN_WIDTH - 1 : 0];
          load_s2b_cfg_itb_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_itb_wrap_around = station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_ITB_WRAP_AROUND_WIDTH - 1 : 0];
          load_s2b_cfg_itb_wrap_around = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_en_hpmcounter = station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_WIDTH - 1 : 0];
          load_s2b_cfg_en_hpmcounter = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_BYPASS_IC_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_bypass_ic = station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_BYPASS_IC_WIDTH - 1 : 0];
          load_s2b_cfg_bypass_ic = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_PWR_ON_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_pwr_on = station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_PWR_ON_WIDTH - 1 : 0];
          load_s2b_cfg_pwr_on = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_CFG_SLEEP_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_cfg_sleep = station2brb_req_w.wdata[STATION_ORV32_S2B_CFG_SLEEP_WIDTH - 1 : 0];
          load_s2b_cfg_sleep = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2icg_clk_en = station2brb_req_w.wdata[STATION_ORV32_S2ICG_CLK_EN_WIDTH - 1 : 0];
          load_s2icg_clk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_0 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_IF_PC_0_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_1 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_IF_PC_1_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_2 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_IF_PC_2_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_IF_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_3 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_IF_PC_3_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_0_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_0 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_WB_PC_0_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_1_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_1 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_WB_PC_1_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_2_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_2 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_WB_PC_2_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_S2B_EN_BP_WB_PC_3_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_3 = station2brb_req_w.wdata[STATION_ORV32_S2B_EN_BP_WB_PC_3_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_IF_VALID_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          b2s_if_valid = station2brb_req_w.wdata[STATION_ORV32_B2S_IF_VALID_WIDTH - 1 : 0];
          load_b2s_if_valid = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_B2S_WB_VALID_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          b2s_wb_valid = station2brb_req_w.wdata[STATION_ORV32_B2S_WB_VALID_WIDTH - 1 : 0];
          load_b2s_wb_valid = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_ORV32_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_ORV32_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_ORV32_DATA_WIDTH/8)]} == (STATION_ORV32_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_ORV32_DATA_WIDTH/8)))): begin
          debug_info_enable = station2brb_req_w.wdata[STATION_ORV32_DEBUG_INFO_ENABLE_WIDTH - 1 : 0];
          load_debug_info_enable = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        default: begin
          bdec  = 1'b0;
          bresp = AXI_RESP_DECERR;
        end
      endcase
    end
  end

  // Response Muxing
  oursring_resp_if_b_t  i_resp_if_b[2];
  oursring_resp_if_r_t  i_resp_if_r[2];
  logic                 i_resp_if_rvalid[2];
  logic                 i_resp_if_rready[2];
  logic                 i_resp_if_bvalid[2];
  logic                 i_resp_if_bready[2];
  oursring_resp_if_b_t  o_resp_ppln_if_b[1];
  oursring_resp_if_r_t  o_resp_ppln_if_r[1];
  logic                 o_resp_ppln_if_rvalid[1];
  logic                 o_resp_ppln_if_rready[1];
  logic                 o_resp_ppln_if_bvalid[1];
  logic                 o_resp_ppln_if_bready[1];

  logic                 rff_awrdy, rff_wrdy, next_awrdy, next_wrdy;
  // Request Bypassing
  assign o_req_local_if_awvalid  = (station2brb_req_awvalid & ~bdec) & ~rff_awrdy;
  assign o_req_local_if_wvalid   = (station2brb_req_wvalid & ~bdec) & ~rff_wrdy;
  assign o_req_local_if_arvalid  = (station2brb_req_arvalid & ~rdec);
  assign o_req_local_if_ar       = station2brb_req_ar;
  assign o_req_local_if_aw       = station2brb_req_aw;
  assign o_req_local_if_w        = station2brb_req_w;

  // Request Readys
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_awrdy <= 1'b0;
      rff_wrdy  <= 1'b0;
    end else begin
      rff_awrdy <= next_awrdy;
      rff_wrdy  <= next_wrdy;
    end
  end
  always_comb begin
    next_awrdy = rff_awrdy;
    next_wrdy  = rff_wrdy;
    if ((~bdec & o_req_local_if_awready & o_req_local_if_awvalid) | (bdec & i_resp_if_bready[0])) begin
      next_awrdy = 1'b1;
    end else if (rff_awrdy & rff_wrdy) begin
      next_awrdy = 1'b0;
    end
    if ((~bdec & o_req_local_if_wready & o_req_local_if_wvalid)  | (bdec & i_resp_if_bready[0])) begin
      next_wrdy = 1'b1;
    end else if (rff_awrdy & rff_wrdy) begin
      next_wrdy = 1'b0;
    end
  end
  assign station2brb_req_awready  = rff_awrdy & rff_wrdy;
  assign station2brb_req_wready   = rff_awrdy & rff_wrdy;

  assign station2brb_req_arready  = (~rdec & o_req_local_if_arready) | (rdec & i_resp_if_rready[0]);

  // if 1, means input port i's destination station id matches output j's station id
  logic [1:0][0:0]      is_r_dst_match;
  logic [1:0][0:0]      is_b_dst_match;

  oursring_resp_if_b_t  brb_b;
  oursring_resp_if_r_t  brb_r;

  assign brb_b.bid   = station2brb_req_aw.awid;
  assign brb_b.bresp = bresp;

  assign brb_r.rid   = station2brb_req_ar.arid;
  assign brb_r.rresp = rresp;
  assign brb_r.rdata = data;
  assign brb_r.rlast = 1'b1;

  assign i_resp_if_b[0] = brb_b;
  assign i_resp_if_b[1] = i_resp_local_if_b;

  assign i_resp_if_r[0] = brb_r;
  assign i_resp_if_r[1] = i_resp_local_if_r;

  assign i_resp_if_rvalid[0] = station2brb_req_arvalid & rdec;
  assign i_resp_if_rvalid[1] = i_resp_local_if_rvalid;

  assign i_resp_local_if_rready = i_resp_if_rready[1];

  assign i_resp_if_bvalid[0] = station2brb_req_awvalid & station2brb_req_wvalid & bdec & ~rff_awrdy & ~rff_wrdy;
  assign i_resp_if_bvalid[1] = i_resp_local_if_bvalid;

  assign i_resp_local_if_bready = i_resp_if_bready[1];

  assign station2brb_rsp_b        = o_resp_ppln_if_b[0];
  assign station2brb_rsp_r        = o_resp_ppln_if_r[0];
  assign station2brb_rsp_rvalid   = o_resp_ppln_if_rvalid[0];
  assign o_resp_ppln_if_rready[0] = station2brb_rsp_rready;
  assign station2brb_rsp_bvalid   = o_resp_ppln_if_bvalid[0];
  assign o_resp_ppln_if_bready[0] = station2brb_rsp_bready;
  
  assign is_r_dst_match = 2'b11;
  assign is_b_dst_match = 2'b11;

  oursring_resp #(.N_IN_PORT(2), .N_OUT_PORT(1)) resp_u (
    .i_resp_if_b            (i_resp_if_b),
    .i_resp_if_r            (i_resp_if_r),
    .i_resp_if_rvalid       (i_resp_if_rvalid),
    .i_resp_if_rready       (i_resp_if_rready),
    .i_resp_if_bvalid       (i_resp_if_bvalid),
    .i_resp_if_bready       (i_resp_if_bready),
    .o_resp_ppln_if_b       (o_resp_ppln_if_b),
    .o_resp_ppln_if_r       (o_resp_ppln_if_r),
    .o_resp_ppln_if_rvalid  (o_resp_ppln_if_rvalid),
    .o_resp_ppln_if_rready  (o_resp_ppln_if_rready),
    .o_resp_ppln_if_bvalid  (o_resp_ppln_if_bvalid),
    .o_resp_ppln_if_bready  (o_resp_ppln_if_bready),
    .is_r_dst_match         (is_r_dst_match),
    .is_b_dst_match         (is_b_dst_match),
    .rstn                   (rstn),
    .clk                    (clk)
    );
  
endmodule
`endif
`endif
