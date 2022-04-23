
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.





`define STATION_VP_PKG__SV
package station_vp_pkg;
  localparam int STATION_VP_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_VP_DATA_WIDTH = 'h40;
  localparam [STATION_VP_RING_ADDR_WIDTH-1:0] STATION_VP_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_VP_BLKID_0 = 'h1;
  localparam bit [25 - 1:0] STATION_VP_BASE_ADDR_0 = 'h100000;
  localparam int STATION_VP_BLKID_1 = 'h2;
  localparam bit [25 - 1:0] STATION_VP_BASE_ADDR_1 = 'h200000;
  localparam int STATION_VP_BLKID_2 = 'h3;
  localparam bit [25 - 1:0] STATION_VP_BASE_ADDR_2 = 'h300000;
  localparam int STATION_VP_BLKID_3 = 'h4;
  localparam bit [25 - 1:0] STATION_VP_BASE_ADDR_3 = 'h400000;
  localparam int STATION_VP_BLKID_WIDTH = 'h5;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_0_OFFSET = 64'h1000;
  localparam int STATION_VP_IC_DATA_WAY_0_WIDTH  = 32768;
  localparam bit [64 - 1:0] STATION_VP_IC_DATA_WAY_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_0_ADDR_0 = 64'h101000;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_0_ADDR_1 = 64'h201000;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_0_ADDR_2 = 64'h301000;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_0_ADDR_3 = 64'h401000;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_1_OFFSET = 64'h2000;
  localparam int STATION_VP_IC_DATA_WAY_1_WIDTH  = 32768;
  localparam bit [64 - 1:0] STATION_VP_IC_DATA_WAY_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_1_ADDR_0 = 64'h102000;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_1_ADDR_1 = 64'h202000;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_1_ADDR_2 = 64'h302000;
  localparam bit [25 - 1:0] STATION_VP_IC_DATA_WAY_1_ADDR_3 = 64'h402000;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_0_OFFSET = 64'h3000;
  localparam int STATION_VP_IC_TAG_WAY_0_WIDTH  = 8192;
  localparam bit [64 - 1:0] STATION_VP_IC_TAG_WAY_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_0_ADDR_0 = 64'h103000;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_0_ADDR_1 = 64'h203000;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_0_ADDR_2 = 64'h303000;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_0_ADDR_3 = 64'h403000;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_1_OFFSET = 64'h3400;
  localparam int STATION_VP_IC_TAG_WAY_1_WIDTH  = 8192;
  localparam bit [64 - 1:0] STATION_VP_IC_TAG_WAY_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_1_ADDR_0 = 64'h103400;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_1_ADDR_1 = 64'h203400;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_1_ADDR_2 = 64'h303400;
  localparam bit [25 - 1:0] STATION_VP_IC_TAG_WAY_1_ADDR_3 = 64'h403400;
  localparam bit [25 - 1:0] STATION_VP_VCORE_PMU_OFFSET = 64'h10000;
  localparam int STATION_VP_VCORE_PMU_WIDTH  = 4096;
  localparam bit [64 - 1:0] STATION_VP_VCORE_PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VCORE_PMU_ADDR_0 = 64'h110000;
  localparam bit [25 - 1:0] STATION_VP_VCORE_PMU_ADDR_1 = 64'h210000;
  localparam bit [25 - 1:0] STATION_VP_VCORE_PMU_ADDR_2 = 64'h310000;
  localparam bit [25 - 1:0] STATION_VP_VCORE_PMU_ADDR_3 = 64'h410000;
  localparam bit [25 - 1:0] STATION_VP_ITB_DATA_OFFSET = 64'h5000;
  localparam int STATION_VP_ITB_DATA_WIDTH  = 1024;
  localparam bit [64 - 1:0] STATION_VP_ITB_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ITB_DATA_ADDR_0 = 64'h105000;
  localparam bit [25 - 1:0] STATION_VP_ITB_DATA_ADDR_1 = 64'h205000;
  localparam bit [25 - 1:0] STATION_VP_ITB_DATA_ADDR_2 = 64'h305000;
  localparam bit [25 - 1:0] STATION_VP_ITB_DATA_ADDR_3 = 64'h405000;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_OFFSET__DEPTH_0 = 64'h6000;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_OFFSET__DEPTH_1 = 64'h6020;
  localparam int STATION_VP_IBUF_LINE_DATA_WIDTH  = 256;
  localparam bit [64 - 1:0] STATION_VP_IBUF_LINE_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_0__DEPTH_0 = 64'h106000;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_0__DEPTH_1 = 64'h106020;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_1__DEPTH_0 = 64'h206000;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_1__DEPTH_1 = 64'h206020;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_2__DEPTH_0 = 64'h306000;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_2__DEPTH_1 = 64'h306020;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_3__DEPTH_0 = 64'h406000;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_DATA_ADDR_3__DEPTH_1 = 64'h406020;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_RST_PC_OFFSET = 64'h0;
  localparam int STATION_VP_S2B_CFG_RST_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_RST_PC_RSTVAL = 32'h80000000;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_RST_PC_ADDR_0 = 64'h100000;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_RST_PC_ADDR_1 = 64'h200000;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_RST_PC_ADDR_2 = 64'h300000;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_RST_PC_ADDR_3 = 64'h400000;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_SEL_OFFSET = 64'h8;
  localparam int STATION_VP_S2B_CFG_ITB_SEL_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_ITB_SEL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_SEL_ADDR_0 = 64'h100008;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_SEL_ADDR_1 = 64'h200008;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_SEL_ADDR_2 = 64'h300008;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_SEL_ADDR_3 = 64'h400008;
  localparam bit [25 - 1:0] STATION_VP_B2S_ITB_LAST_PTR_OFFSET = 64'h10;
  localparam int STATION_VP_B2S_ITB_LAST_PTR_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_B2S_ITB_LAST_PTR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_B2S_ITB_LAST_PTR_ADDR_0 = 64'h100010;
  localparam bit [25 - 1:0] STATION_VP_B2S_ITB_LAST_PTR_ADDR_1 = 64'h200010;
  localparam bit [25 - 1:0] STATION_VP_B2S_ITB_LAST_PTR_ADDR_2 = 64'h300010;
  localparam bit [25 - 1:0] STATION_VP_B2S_ITB_LAST_PTR_ADDR_3 = 64'h400010;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_0_OFFSET = 64'h18;
  localparam int STATION_VP_S2B_BP_IF_PC_0_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_IF_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_0_ADDR_0 = 64'h100018;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_0_ADDR_1 = 64'h200018;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_0_ADDR_2 = 64'h300018;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_0_ADDR_3 = 64'h400018;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_1_OFFSET = 64'h20;
  localparam int STATION_VP_S2B_BP_IF_PC_1_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_IF_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_1_ADDR_0 = 64'h100020;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_1_ADDR_1 = 64'h200020;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_1_ADDR_2 = 64'h300020;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_1_ADDR_3 = 64'h400020;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_2_OFFSET = 64'h28;
  localparam int STATION_VP_S2B_BP_IF_PC_2_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_IF_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_2_ADDR_0 = 64'h100028;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_2_ADDR_1 = 64'h200028;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_2_ADDR_2 = 64'h300028;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_2_ADDR_3 = 64'h400028;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_3_OFFSET = 64'h30;
  localparam int STATION_VP_S2B_BP_IF_PC_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_IF_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_3_ADDR_0 = 64'h100030;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_3_ADDR_1 = 64'h200030;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_3_ADDR_2 = 64'h300030;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_IF_PC_3_ADDR_3 = 64'h400030;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_0_OFFSET = 64'h38;
  localparam int STATION_VP_S2B_BP_WB_PC_0_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_WB_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_0_ADDR_0 = 64'h100038;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_0_ADDR_1 = 64'h200038;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_0_ADDR_2 = 64'h300038;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_0_ADDR_3 = 64'h400038;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_1_OFFSET = 64'h40;
  localparam int STATION_VP_S2B_BP_WB_PC_1_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_WB_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_1_ADDR_0 = 64'h100040;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_1_ADDR_1 = 64'h200040;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_1_ADDR_2 = 64'h300040;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_1_ADDR_3 = 64'h400040;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_2_OFFSET = 64'h48;
  localparam int STATION_VP_S2B_BP_WB_PC_2_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_WB_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_2_ADDR_0 = 64'h100048;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_2_ADDR_1 = 64'h200048;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_2_ADDR_2 = 64'h300048;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_2_ADDR_3 = 64'h400048;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_3_OFFSET = 64'h50;
  localparam int STATION_VP_S2B_BP_WB_PC_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_WB_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_3_ADDR_0 = 64'h100050;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_3_ADDR_1 = 64'h200050;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_3_ADDR_2 = 64'h300050;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_WB_PC_3_ADDR_3 = 64'h400050;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_INSTRET_OFFSET = 64'h58;
  localparam int STATION_VP_S2B_BP_INSTRET_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_BP_INSTRET_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_INSTRET_ADDR_0 = 64'h100058;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_INSTRET_ADDR_1 = 64'h200058;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_INSTRET_ADDR_2 = 64'h300058;
  localparam bit [25 - 1:0] STATION_VP_S2B_BP_INSTRET_ADDR_3 = 64'h400058;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_OFFSET__DEPTH_0 = 64'h60;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_OFFSET__DEPTH_1 = 64'h68;
  localparam int STATION_VP_IBUF_LINE_PADDR_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IBUF_LINE_PADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_0__DEPTH_0 = 64'h100060;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_0__DEPTH_1 = 64'h100068;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_1__DEPTH_0 = 64'h200060;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_1__DEPTH_1 = 64'h200068;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_2__DEPTH_0 = 64'h300060;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_2__DEPTH_1 = 64'h300068;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_3__DEPTH_0 = 64'h400060;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_PADDR_ADDR_3__DEPTH_1 = 64'h400068;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_OFFSET__DEPTH_0 = 64'h70;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_OFFSET__DEPTH_1 = 64'h78;
  localparam int STATION_VP_IBUF_LINE_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_0__DEPTH_0 = 64'h100070;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_0__DEPTH_1 = 64'h100078;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_1__DEPTH_0 = 64'h200070;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_1__DEPTH_1 = 64'h200078;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_2__DEPTH_0 = 64'h300070;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_2__DEPTH_1 = 64'h300078;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_3__DEPTH_0 = 64'h400070;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_3__DEPTH_1 = 64'h400078;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_0 = 64'h80;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_1 = 64'h88;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_2 = 64'h90;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_3 = 64'h98;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_4 = 64'ha0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_5 = 64'ha8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_6 = 64'hb0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_OFFSET__DEPTH_7 = 64'hb8;
  localparam int STATION_VP_ITLB_ASID_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_ITLB_ASID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_0 = 64'h100080;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_1 = 64'h100088;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_2 = 64'h100090;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_3 = 64'h100098;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_4 = 64'h1000a0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_5 = 64'h1000a8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_6 = 64'h1000b0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_0__DEPTH_7 = 64'h1000b8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_0 = 64'h200080;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_1 = 64'h200088;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_2 = 64'h200090;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_3 = 64'h200098;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_4 = 64'h2000a0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_5 = 64'h2000a8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_6 = 64'h2000b0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_1__DEPTH_7 = 64'h2000b8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_0 = 64'h300080;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_1 = 64'h300088;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_2 = 64'h300090;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_3 = 64'h300098;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_4 = 64'h3000a0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_5 = 64'h3000a8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_6 = 64'h3000b0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_2__DEPTH_7 = 64'h3000b8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_0 = 64'h400080;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_1 = 64'h400088;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_2 = 64'h400090;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_3 = 64'h400098;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_4 = 64'h4000a0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_5 = 64'h4000a8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_6 = 64'h4000b0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_ASID_ADDR_3__DEPTH_7 = 64'h4000b8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_0 = 64'hc0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_1 = 64'hc8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_2 = 64'hd0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_3 = 64'hd8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_4 = 64'he0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_5 = 64'he8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_6 = 64'hf0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_OFFSET__DEPTH_7 = 64'hf8;
  localparam int STATION_VP_ITLB_VPN_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_ITLB_VPN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_0 = 64'h1000c0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_1 = 64'h1000c8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_2 = 64'h1000d0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_3 = 64'h1000d8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_4 = 64'h1000e0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_5 = 64'h1000e8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_6 = 64'h1000f0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_0__DEPTH_7 = 64'h1000f8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_0 = 64'h2000c0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_1 = 64'h2000c8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_2 = 64'h2000d0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_3 = 64'h2000d8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_4 = 64'h2000e0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_5 = 64'h2000e8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_6 = 64'h2000f0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_1__DEPTH_7 = 64'h2000f8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_0 = 64'h3000c0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_1 = 64'h3000c8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_2 = 64'h3000d0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_3 = 64'h3000d8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_4 = 64'h3000e0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_5 = 64'h3000e8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_6 = 64'h3000f0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_2__DEPTH_7 = 64'h3000f8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_0 = 64'h4000c0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_1 = 64'h4000c8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_2 = 64'h4000d0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_3 = 64'h4000d8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_4 = 64'h4000e0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_5 = 64'h4000e8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_6 = 64'h4000f0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VPN_ADDR_3__DEPTH_7 = 64'h4000f8;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_0 = 64'h100;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_1 = 64'h108;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_2 = 64'h110;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_3 = 64'h118;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_4 = 64'h120;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_5 = 64'h128;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_6 = 64'h130;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_OFFSET__DEPTH_7 = 64'h138;
  localparam int STATION_VP_ITLB_PTE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_ITLB_PTE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_0 = 64'h100100;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_1 = 64'h100108;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_2 = 64'h100110;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_3 = 64'h100118;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_4 = 64'h100120;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_5 = 64'h100128;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_6 = 64'h100130;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_0__DEPTH_7 = 64'h100138;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_0 = 64'h200100;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_1 = 64'h200108;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_2 = 64'h200110;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_3 = 64'h200118;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_4 = 64'h200120;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_5 = 64'h200128;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_6 = 64'h200130;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_1__DEPTH_7 = 64'h200138;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_0 = 64'h300100;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_1 = 64'h300108;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_2 = 64'h300110;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_3 = 64'h300118;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_4 = 64'h300120;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_5 = 64'h300128;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_6 = 64'h300130;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_2__DEPTH_7 = 64'h300138;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_0 = 64'h400100;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_1 = 64'h400108;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_2 = 64'h400110;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_3 = 64'h400118;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_4 = 64'h400120;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_5 = 64'h400128;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_6 = 64'h400130;
  localparam bit [25 - 1:0] STATION_VP_ITLB_PTE_ADDR_3__DEPTH_7 = 64'h400138;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_0 = 64'h140;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_1 = 64'h148;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_2 = 64'h150;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_3 = 64'h158;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_4 = 64'h160;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_5 = 64'h168;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_6 = 64'h170;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_OFFSET__DEPTH_7 = 64'h178;
  localparam int STATION_VP_DTLB_ASID_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_DTLB_ASID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_0 = 64'h100140;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_1 = 64'h100148;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_2 = 64'h100150;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_3 = 64'h100158;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_4 = 64'h100160;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_5 = 64'h100168;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_6 = 64'h100170;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_0__DEPTH_7 = 64'h100178;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_0 = 64'h200140;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_1 = 64'h200148;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_2 = 64'h200150;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_3 = 64'h200158;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_4 = 64'h200160;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_5 = 64'h200168;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_6 = 64'h200170;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_1__DEPTH_7 = 64'h200178;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_0 = 64'h300140;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_1 = 64'h300148;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_2 = 64'h300150;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_3 = 64'h300158;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_4 = 64'h300160;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_5 = 64'h300168;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_6 = 64'h300170;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_2__DEPTH_7 = 64'h300178;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_0 = 64'h400140;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_1 = 64'h400148;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_2 = 64'h400150;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_3 = 64'h400158;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_4 = 64'h400160;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_5 = 64'h400168;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_6 = 64'h400170;
  localparam bit [25 - 1:0] STATION_VP_DTLB_ASID_ADDR_3__DEPTH_7 = 64'h400178;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_0 = 64'h180;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_1 = 64'h188;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_2 = 64'h190;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_3 = 64'h198;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_4 = 64'h1a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_5 = 64'h1a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_6 = 64'h1b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_OFFSET__DEPTH_7 = 64'h1b8;
  localparam int STATION_VP_DTLB_VPN_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_DTLB_VPN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_0 = 64'h100180;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_1 = 64'h100188;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_2 = 64'h100190;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_3 = 64'h100198;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_4 = 64'h1001a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_5 = 64'h1001a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_6 = 64'h1001b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_0__DEPTH_7 = 64'h1001b8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_0 = 64'h200180;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_1 = 64'h200188;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_2 = 64'h200190;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_3 = 64'h200198;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_4 = 64'h2001a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_5 = 64'h2001a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_6 = 64'h2001b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_1__DEPTH_7 = 64'h2001b8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_0 = 64'h300180;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_1 = 64'h300188;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_2 = 64'h300190;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_3 = 64'h300198;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_4 = 64'h3001a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_5 = 64'h3001a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_6 = 64'h3001b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_2__DEPTH_7 = 64'h3001b8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_0 = 64'h400180;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_1 = 64'h400188;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_2 = 64'h400190;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_3 = 64'h400198;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_4 = 64'h4001a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_5 = 64'h4001a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_6 = 64'h4001b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VPN_ADDR_3__DEPTH_7 = 64'h4001b8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_0 = 64'h1c0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_1 = 64'h1c8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_2 = 64'h1d0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_3 = 64'h1d8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_4 = 64'h1e0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_5 = 64'h1e8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_6 = 64'h1f0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_OFFSET__DEPTH_7 = 64'h1f8;
  localparam int STATION_VP_DTLB_PTE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_DTLB_PTE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_0 = 64'h1001c0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_1 = 64'h1001c8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_2 = 64'h1001d0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_3 = 64'h1001d8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_4 = 64'h1001e0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_5 = 64'h1001e8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_6 = 64'h1001f0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_0__DEPTH_7 = 64'h1001f8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_0 = 64'h2001c0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_1 = 64'h2001c8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_2 = 64'h2001d0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_3 = 64'h2001d8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_4 = 64'h2001e0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_5 = 64'h2001e8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_6 = 64'h2001f0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_1__DEPTH_7 = 64'h2001f8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_0 = 64'h3001c0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_1 = 64'h3001c8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_2 = 64'h3001d0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_3 = 64'h3001d8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_4 = 64'h3001e0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_5 = 64'h3001e8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_6 = 64'h3001f0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_2__DEPTH_7 = 64'h3001f8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_0 = 64'h4001c0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_1 = 64'h4001c8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_2 = 64'h4001d0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_3 = 64'h4001d8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_4 = 64'h4001e0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_5 = 64'h4001e8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_6 = 64'h4001f0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_PTE_ADDR_3__DEPTH_7 = 64'h4001f8;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_OFFSET__DEPTH_0 = 64'h200;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_OFFSET__DEPTH_1 = 64'h208;
  localparam int STATION_VP_VTLB_ASID_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VTLB_ASID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_0__DEPTH_0 = 64'h100200;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_0__DEPTH_1 = 64'h100208;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_1__DEPTH_0 = 64'h200200;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_1__DEPTH_1 = 64'h200208;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_2__DEPTH_0 = 64'h300200;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_2__DEPTH_1 = 64'h300208;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_3__DEPTH_0 = 64'h400200;
  localparam bit [25 - 1:0] STATION_VP_VTLB_ASID_ADDR_3__DEPTH_1 = 64'h400208;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_OFFSET__DEPTH_0 = 64'h210;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_OFFSET__DEPTH_1 = 64'h218;
  localparam int STATION_VP_VTLB_VPN_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VTLB_VPN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_0__DEPTH_0 = 64'h100210;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_0__DEPTH_1 = 64'h100218;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_1__DEPTH_0 = 64'h200210;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_1__DEPTH_1 = 64'h200218;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_2__DEPTH_0 = 64'h300210;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_2__DEPTH_1 = 64'h300218;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_3__DEPTH_0 = 64'h400210;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VPN_ADDR_3__DEPTH_1 = 64'h400218;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_OFFSET__DEPTH_0 = 64'h220;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_OFFSET__DEPTH_1 = 64'h228;
  localparam int STATION_VP_VTLB_PTE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VTLB_PTE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_0__DEPTH_0 = 64'h100220;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_0__DEPTH_1 = 64'h100228;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_1__DEPTH_0 = 64'h200220;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_1__DEPTH_1 = 64'h200228;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_2__DEPTH_0 = 64'h300220;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_2__DEPTH_1 = 64'h300228;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_3__DEPTH_0 = 64'h400220;
  localparam bit [25 - 1:0] STATION_VP_VTLB_PTE_ADDR_3__DEPTH_1 = 64'h400228;
  localparam bit [25 - 1:0] STATION_VP_VCORE_MEM_EXCEPTION_OFFSET = 64'h230;
  localparam int STATION_VP_VCORE_MEM_EXCEPTION_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VCORE_MEM_EXCEPTION_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VCORE_MEM_EXCEPTION_ADDR_0 = 64'h100230;
  localparam bit [25 - 1:0] STATION_VP_VCORE_MEM_EXCEPTION_ADDR_1 = 64'h200230;
  localparam bit [25 - 1:0] STATION_VP_VCORE_MEM_EXCEPTION_ADDR_2 = 64'h300230;
  localparam bit [25 - 1:0] STATION_VP_VCORE_MEM_EXCEPTION_ADDR_3 = 64'h400230;
  localparam bit [25 - 1:0] STATION_VP_IF_PC_OFFSET = 64'h238;
  localparam int STATION_VP_IF_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IF_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_PC_ADDR_0 = 64'h100238;
  localparam bit [25 - 1:0] STATION_VP_IF_PC_ADDR_1 = 64'h200238;
  localparam bit [25 - 1:0] STATION_VP_IF_PC_ADDR_2 = 64'h300238;
  localparam bit [25 - 1:0] STATION_VP_IF_PC_ADDR_3 = 64'h400238;
  localparam bit [25 - 1:0] STATION_VP_IF_INST_OFFSET = 64'h240;
  localparam int STATION_VP_IF_INST_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IF_INST_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_INST_ADDR_0 = 64'h100240;
  localparam bit [25 - 1:0] STATION_VP_IF_INST_ADDR_1 = 64'h200240;
  localparam bit [25 - 1:0] STATION_VP_IF_INST_ADDR_2 = 64'h300240;
  localparam bit [25 - 1:0] STATION_VP_IF_INST_ADDR_3 = 64'h400240;
  localparam bit [25 - 1:0] STATION_VP_ID_PC_OFFSET = 64'h248;
  localparam int STATION_VP_ID_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_ID_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID_PC_ADDR_0 = 64'h100248;
  localparam bit [25 - 1:0] STATION_VP_ID_PC_ADDR_1 = 64'h200248;
  localparam bit [25 - 1:0] STATION_VP_ID_PC_ADDR_2 = 64'h300248;
  localparam bit [25 - 1:0] STATION_VP_ID_PC_ADDR_3 = 64'h400248;
  localparam bit [25 - 1:0] STATION_VP_ID_INST_OFFSET = 64'h250;
  localparam int STATION_VP_ID_INST_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_ID_INST_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID_INST_ADDR_0 = 64'h100250;
  localparam bit [25 - 1:0] STATION_VP_ID_INST_ADDR_1 = 64'h200250;
  localparam bit [25 - 1:0] STATION_VP_ID_INST_ADDR_2 = 64'h300250;
  localparam bit [25 - 1:0] STATION_VP_ID_INST_ADDR_3 = 64'h400250;
  localparam bit [25 - 1:0] STATION_VP_WB_PC_OFFSET = 64'h258;
  localparam int STATION_VP_WB_PC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_WB_PC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_WB_PC_ADDR_0 = 64'h100258;
  localparam bit [25 - 1:0] STATION_VP_WB_PC_ADDR_1 = 64'h200258;
  localparam bit [25 - 1:0] STATION_VP_WB_PC_ADDR_2 = 64'h300258;
  localparam bit [25 - 1:0] STATION_VP_WB_PC_ADDR_3 = 64'h400258;
  localparam bit [25 - 1:0] STATION_VP_PRV_OFFSET = 64'h260;
  localparam int STATION_VP_PRV_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_PRV_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_PRV_ADDR_0 = 64'h100260;
  localparam bit [25 - 1:0] STATION_VP_PRV_ADDR_1 = 64'h200260;
  localparam bit [25 - 1:0] STATION_VP_PRV_ADDR_2 = 64'h300260;
  localparam bit [25 - 1:0] STATION_VP_PRV_ADDR_3 = 64'h400260;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_VPC_OFFSET = 64'h268;
  localparam int STATION_VP_IF2IC_VPC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IF2IC_VPC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_VPC_ADDR_0 = 64'h100268;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_VPC_ADDR_1 = 64'h200268;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_VPC_ADDR_2 = 64'h300268;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_VPC_ADDR_3 = 64'h400268;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_INST_OFFSET = 64'h270;
  localparam int STATION_VP_IC2IF_INST_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IC2IF_INST_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_INST_ADDR_0 = 64'h100270;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_INST_ADDR_1 = 64'h200270;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_INST_ADDR_2 = 64'h300270;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_INST_ADDR_3 = 64'h400270;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_CAUSE_OFFSET = 64'h278;
  localparam int STATION_VP_IC2IF_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IC2IF_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_CAUSE_ADDR_0 = 64'h100278;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_CAUSE_ADDR_1 = 64'h200278;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_CAUSE_ADDR_2 = 64'h300278;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_CAUSE_ADDR_3 = 64'h400278;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_CAUSE_OFFSET = 64'h280;
  localparam int STATION_VP_IF2ID_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IF2ID_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_CAUSE_ADDR_0 = 64'h100280;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_CAUSE_ADDR_1 = 64'h200280;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_CAUSE_ADDR_2 = 64'h300280;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_CAUSE_ADDR_3 = 64'h400280;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_CAUSE_OFFSET = 64'h288;
  localparam int STATION_VP_ID2EX_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_ID2EX_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_CAUSE_ADDR_0 = 64'h100288;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_CAUSE_ADDR_1 = 64'h200288;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_CAUSE_ADDR_2 = 64'h300288;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_CAUSE_ADDR_3 = 64'h400288;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_CAUSE_OFFSET = 64'h290;
  localparam int STATION_VP_EX2MA_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_EX2MA_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_CAUSE_ADDR_0 = 64'h100290;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_CAUSE_ADDR_1 = 64'h200290;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_CAUSE_ADDR_2 = 64'h300290;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_CAUSE_ADDR_3 = 64'h400290;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_CAUSE_OFFSET = 64'h298;
  localparam int STATION_VP_MA2CS_EXCP_CAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MA2CS_EXCP_CAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_CAUSE_ADDR_0 = 64'h100298;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_CAUSE_ADDR_1 = 64'h200298;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_CAUSE_ADDR_2 = 64'h300298;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_CAUSE_ADDR_3 = 64'h400298;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_EXCP_OFFSET = 64'h2a0;
  localparam int STATION_VP_CS2MA_EXCP_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_CS2MA_EXCP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_EXCP_ADDR_0 = 64'h1002a0;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_EXCP_ADDR_1 = 64'h2002a0;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_EXCP_ADDR_2 = 64'h3002a0;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_EXCP_ADDR_3 = 64'h4002a0;
  localparam bit [25 - 1:0] STATION_VP_MCYCLE_OFFSET = 64'h2a8;
  localparam int STATION_VP_MCYCLE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MCYCLE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MCYCLE_ADDR_0 = 64'h1002a8;
  localparam bit [25 - 1:0] STATION_VP_MCYCLE_ADDR_1 = 64'h2002a8;
  localparam bit [25 - 1:0] STATION_VP_MCYCLE_ADDR_2 = 64'h3002a8;
  localparam bit [25 - 1:0] STATION_VP_MCYCLE_ADDR_3 = 64'h4002a8;
  localparam bit [25 - 1:0] STATION_VP_MINSTRET_OFFSET = 64'h2b0;
  localparam int STATION_VP_MINSTRET_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MINSTRET_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MINSTRET_ADDR_0 = 64'h1002b0;
  localparam bit [25 - 1:0] STATION_VP_MINSTRET_ADDR_1 = 64'h2002b0;
  localparam bit [25 - 1:0] STATION_VP_MINSTRET_ADDR_2 = 64'h3002b0;
  localparam bit [25 - 1:0] STATION_VP_MINSTRET_ADDR_3 = 64'h4002b0;
  localparam bit [25 - 1:0] STATION_VP_MSTATUS_OFFSET = 64'h2b8;
  localparam int STATION_VP_MSTATUS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MSTATUS_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MSTATUS_ADDR_0 = 64'h1002b8;
  localparam bit [25 - 1:0] STATION_VP_MSTATUS_ADDR_1 = 64'h2002b8;
  localparam bit [25 - 1:0] STATION_VP_MSTATUS_ADDR_2 = 64'h3002b8;
  localparam bit [25 - 1:0] STATION_VP_MSTATUS_ADDR_3 = 64'h4002b8;
  localparam bit [25 - 1:0] STATION_VP_MCAUSE_OFFSET = 64'h2c0;
  localparam int STATION_VP_MCAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MCAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MCAUSE_ADDR_0 = 64'h1002c0;
  localparam bit [25 - 1:0] STATION_VP_MCAUSE_ADDR_1 = 64'h2002c0;
  localparam bit [25 - 1:0] STATION_VP_MCAUSE_ADDR_2 = 64'h3002c0;
  localparam bit [25 - 1:0] STATION_VP_MCAUSE_ADDR_3 = 64'h4002c0;
  localparam bit [25 - 1:0] STATION_VP_MEPC_OFFSET = 64'h2c8;
  localparam int STATION_VP_MEPC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MEPC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MEPC_ADDR_0 = 64'h1002c8;
  localparam bit [25 - 1:0] STATION_VP_MEPC_ADDR_1 = 64'h2002c8;
  localparam bit [25 - 1:0] STATION_VP_MEPC_ADDR_2 = 64'h3002c8;
  localparam bit [25 - 1:0] STATION_VP_MEPC_ADDR_3 = 64'h4002c8;
  localparam bit [25 - 1:0] STATION_VP_MISA_OFFSET = 64'h2d0;
  localparam int STATION_VP_MISA_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MISA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MISA_ADDR_0 = 64'h1002d0;
  localparam bit [25 - 1:0] STATION_VP_MISA_ADDR_1 = 64'h2002d0;
  localparam bit [25 - 1:0] STATION_VP_MISA_ADDR_2 = 64'h3002d0;
  localparam bit [25 - 1:0] STATION_VP_MISA_ADDR_3 = 64'h4002d0;
  localparam bit [25 - 1:0] STATION_VP_MIP_OFFSET = 64'h2d8;
  localparam int STATION_VP_MIP_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MIP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MIP_ADDR_0 = 64'h1002d8;
  localparam bit [25 - 1:0] STATION_VP_MIP_ADDR_1 = 64'h2002d8;
  localparam bit [25 - 1:0] STATION_VP_MIP_ADDR_2 = 64'h3002d8;
  localparam bit [25 - 1:0] STATION_VP_MIP_ADDR_3 = 64'h4002d8;
  localparam bit [25 - 1:0] STATION_VP_MIE_OFFSET = 64'h2e0;
  localparam int STATION_VP_MIE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MIE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MIE_ADDR_0 = 64'h1002e0;
  localparam bit [25 - 1:0] STATION_VP_MIE_ADDR_1 = 64'h2002e0;
  localparam bit [25 - 1:0] STATION_VP_MIE_ADDR_2 = 64'h3002e0;
  localparam bit [25 - 1:0] STATION_VP_MIE_ADDR_3 = 64'h4002e0;
  localparam bit [25 - 1:0] STATION_VP_MEDELEG_OFFSET = 64'h2e8;
  localparam int STATION_VP_MEDELEG_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MEDELEG_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MEDELEG_ADDR_0 = 64'h1002e8;
  localparam bit [25 - 1:0] STATION_VP_MEDELEG_ADDR_1 = 64'h2002e8;
  localparam bit [25 - 1:0] STATION_VP_MEDELEG_ADDR_2 = 64'h3002e8;
  localparam bit [25 - 1:0] STATION_VP_MEDELEG_ADDR_3 = 64'h4002e8;
  localparam bit [25 - 1:0] STATION_VP_MIDELEG_OFFSET = 64'h2f0;
  localparam int STATION_VP_MIDELEG_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MIDELEG_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MIDELEG_ADDR_0 = 64'h1002f0;
  localparam bit [25 - 1:0] STATION_VP_MIDELEG_ADDR_1 = 64'h2002f0;
  localparam bit [25 - 1:0] STATION_VP_MIDELEG_ADDR_2 = 64'h3002f0;
  localparam bit [25 - 1:0] STATION_VP_MIDELEG_ADDR_3 = 64'h4002f0;
  localparam bit [25 - 1:0] STATION_VP_MTVEC_OFFSET = 64'h2f8;
  localparam int STATION_VP_MTVEC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MTVEC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MTVEC_ADDR_0 = 64'h1002f8;
  localparam bit [25 - 1:0] STATION_VP_MTVEC_ADDR_1 = 64'h2002f8;
  localparam bit [25 - 1:0] STATION_VP_MTVEC_ADDR_2 = 64'h3002f8;
  localparam bit [25 - 1:0] STATION_VP_MTVEC_ADDR_3 = 64'h4002f8;
  localparam bit [25 - 1:0] STATION_VP_MTVAL_OFFSET = 64'h300;
  localparam int STATION_VP_MTVAL_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MTVAL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MTVAL_ADDR_0 = 64'h100300;
  localparam bit [25 - 1:0] STATION_VP_MTVAL_ADDR_1 = 64'h200300;
  localparam bit [25 - 1:0] STATION_VP_MTVAL_ADDR_2 = 64'h300300;
  localparam bit [25 - 1:0] STATION_VP_MTVAL_ADDR_3 = 64'h400300;
  localparam bit [25 - 1:0] STATION_VP_SATP_OFFSET = 64'h308;
  localparam int STATION_VP_SATP_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_SATP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_SATP_ADDR_0 = 64'h100308;
  localparam bit [25 - 1:0] STATION_VP_SATP_ADDR_1 = 64'h200308;
  localparam bit [25 - 1:0] STATION_VP_SATP_ADDR_2 = 64'h300308;
  localparam bit [25 - 1:0] STATION_VP_SATP_ADDR_3 = 64'h400308;
  localparam bit [25 - 1:0] STATION_VP_SEPC_OFFSET = 64'h310;
  localparam int STATION_VP_SEPC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_SEPC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_SEPC_ADDR_0 = 64'h100310;
  localparam bit [25 - 1:0] STATION_VP_SEPC_ADDR_1 = 64'h200310;
  localparam bit [25 - 1:0] STATION_VP_SEPC_ADDR_2 = 64'h300310;
  localparam bit [25 - 1:0] STATION_VP_SEPC_ADDR_3 = 64'h400310;
  localparam bit [25 - 1:0] STATION_VP_SCAUSE_OFFSET = 64'h318;
  localparam int STATION_VP_SCAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_SCAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_SCAUSE_ADDR_0 = 64'h100318;
  localparam bit [25 - 1:0] STATION_VP_SCAUSE_ADDR_1 = 64'h200318;
  localparam bit [25 - 1:0] STATION_VP_SCAUSE_ADDR_2 = 64'h300318;
  localparam bit [25 - 1:0] STATION_VP_SCAUSE_ADDR_3 = 64'h400318;
  localparam bit [25 - 1:0] STATION_VP_SEDELEG_OFFSET = 64'h320;
  localparam int STATION_VP_SEDELEG_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_SEDELEG_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_SEDELEG_ADDR_0 = 64'h100320;
  localparam bit [25 - 1:0] STATION_VP_SEDELEG_ADDR_1 = 64'h200320;
  localparam bit [25 - 1:0] STATION_VP_SEDELEG_ADDR_2 = 64'h300320;
  localparam bit [25 - 1:0] STATION_VP_SEDELEG_ADDR_3 = 64'h400320;
  localparam bit [25 - 1:0] STATION_VP_SIDELEG_OFFSET = 64'h328;
  localparam int STATION_VP_SIDELEG_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_SIDELEG_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_SIDELEG_ADDR_0 = 64'h100328;
  localparam bit [25 - 1:0] STATION_VP_SIDELEG_ADDR_1 = 64'h200328;
  localparam bit [25 - 1:0] STATION_VP_SIDELEG_ADDR_2 = 64'h300328;
  localparam bit [25 - 1:0] STATION_VP_SIDELEG_ADDR_3 = 64'h400328;
  localparam bit [25 - 1:0] STATION_VP_STVEC_OFFSET = 64'h330;
  localparam int STATION_VP_STVEC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_STVEC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_STVEC_ADDR_0 = 64'h100330;
  localparam bit [25 - 1:0] STATION_VP_STVEC_ADDR_1 = 64'h200330;
  localparam bit [25 - 1:0] STATION_VP_STVEC_ADDR_2 = 64'h300330;
  localparam bit [25 - 1:0] STATION_VP_STVEC_ADDR_3 = 64'h400330;
  localparam bit [25 - 1:0] STATION_VP_STVAL_OFFSET = 64'h338;
  localparam int STATION_VP_STVAL_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_STVAL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_STVAL_ADDR_0 = 64'h100338;
  localparam bit [25 - 1:0] STATION_VP_STVAL_ADDR_1 = 64'h200338;
  localparam bit [25 - 1:0] STATION_VP_STVAL_ADDR_2 = 64'h300338;
  localparam bit [25 - 1:0] STATION_VP_STVAL_ADDR_3 = 64'h400338;
  localparam bit [25 - 1:0] STATION_VP_UEPC_OFFSET = 64'h340;
  localparam int STATION_VP_UEPC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_UEPC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_UEPC_ADDR_0 = 64'h100340;
  localparam bit [25 - 1:0] STATION_VP_UEPC_ADDR_1 = 64'h200340;
  localparam bit [25 - 1:0] STATION_VP_UEPC_ADDR_2 = 64'h300340;
  localparam bit [25 - 1:0] STATION_VP_UEPC_ADDR_3 = 64'h400340;
  localparam bit [25 - 1:0] STATION_VP_UCAUSE_OFFSET = 64'h348;
  localparam int STATION_VP_UCAUSE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_UCAUSE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_UCAUSE_ADDR_0 = 64'h100348;
  localparam bit [25 - 1:0] STATION_VP_UCAUSE_ADDR_1 = 64'h200348;
  localparam bit [25 - 1:0] STATION_VP_UCAUSE_ADDR_2 = 64'h300348;
  localparam bit [25 - 1:0] STATION_VP_UCAUSE_ADDR_3 = 64'h400348;
  localparam bit [25 - 1:0] STATION_VP_UTVEC_OFFSET = 64'h350;
  localparam int STATION_VP_UTVEC_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_UTVEC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_UTVEC_ADDR_0 = 64'h100350;
  localparam bit [25 - 1:0] STATION_VP_UTVEC_ADDR_1 = 64'h200350;
  localparam bit [25 - 1:0] STATION_VP_UTVEC_ADDR_2 = 64'h300350;
  localparam bit [25 - 1:0] STATION_VP_UTVEC_ADDR_3 = 64'h400350;
  localparam bit [25 - 1:0] STATION_VP_UTVAL_OFFSET = 64'h358;
  localparam int STATION_VP_UTVAL_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_UTVAL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_UTVAL_ADDR_0 = 64'h100358;
  localparam bit [25 - 1:0] STATION_VP_UTVAL_ADDR_1 = 64'h200358;
  localparam bit [25 - 1:0] STATION_VP_UTVAL_ADDR_2 = 64'h300358;
  localparam bit [25 - 1:0] STATION_VP_UTVAL_ADDR_3 = 64'h400358;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_3_OFFSET = 64'h360;
  localparam int STATION_VP_HPMCOUNTER_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_3_ADDR_0 = 64'h100360;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_3_ADDR_1 = 64'h200360;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_3_ADDR_2 = 64'h300360;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_3_ADDR_3 = 64'h400360;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_4_OFFSET = 64'h368;
  localparam int STATION_VP_HPMCOUNTER_4_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_4_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_4_ADDR_0 = 64'h100368;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_4_ADDR_1 = 64'h200368;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_4_ADDR_2 = 64'h300368;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_4_ADDR_3 = 64'h400368;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_5_OFFSET = 64'h370;
  localparam int STATION_VP_HPMCOUNTER_5_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_5_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_5_ADDR_0 = 64'h100370;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_5_ADDR_1 = 64'h200370;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_5_ADDR_2 = 64'h300370;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_5_ADDR_3 = 64'h400370;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_6_OFFSET = 64'h378;
  localparam int STATION_VP_HPMCOUNTER_6_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_6_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_6_ADDR_0 = 64'h100378;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_6_ADDR_1 = 64'h200378;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_6_ADDR_2 = 64'h300378;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_6_ADDR_3 = 64'h400378;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_7_OFFSET = 64'h380;
  localparam int STATION_VP_HPMCOUNTER_7_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_7_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_7_ADDR_0 = 64'h100380;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_7_ADDR_1 = 64'h200380;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_7_ADDR_2 = 64'h300380;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_7_ADDR_3 = 64'h400380;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_8_OFFSET = 64'h388;
  localparam int STATION_VP_HPMCOUNTER_8_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_8_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_8_ADDR_0 = 64'h100388;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_8_ADDR_1 = 64'h200388;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_8_ADDR_2 = 64'h300388;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_8_ADDR_3 = 64'h400388;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_9_OFFSET = 64'h390;
  localparam int STATION_VP_HPMCOUNTER_9_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_9_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_9_ADDR_0 = 64'h100390;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_9_ADDR_1 = 64'h200390;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_9_ADDR_2 = 64'h300390;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_9_ADDR_3 = 64'h400390;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_10_OFFSET = 64'h398;
  localparam int STATION_VP_HPMCOUNTER_10_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_10_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_10_ADDR_0 = 64'h100398;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_10_ADDR_1 = 64'h200398;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_10_ADDR_2 = 64'h300398;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_10_ADDR_3 = 64'h400398;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_11_OFFSET = 64'h3a0;
  localparam int STATION_VP_HPMCOUNTER_11_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_11_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_11_ADDR_0 = 64'h1003a0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_11_ADDR_1 = 64'h2003a0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_11_ADDR_2 = 64'h3003a0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_11_ADDR_3 = 64'h4003a0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_12_OFFSET = 64'h3a8;
  localparam int STATION_VP_HPMCOUNTER_12_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_12_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_12_ADDR_0 = 64'h1003a8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_12_ADDR_1 = 64'h2003a8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_12_ADDR_2 = 64'h3003a8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_12_ADDR_3 = 64'h4003a8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_13_OFFSET = 64'h3b0;
  localparam int STATION_VP_HPMCOUNTER_13_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_13_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_13_ADDR_0 = 64'h1003b0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_13_ADDR_1 = 64'h2003b0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_13_ADDR_2 = 64'h3003b0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_13_ADDR_3 = 64'h4003b0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_14_OFFSET = 64'h3b8;
  localparam int STATION_VP_HPMCOUNTER_14_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_14_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_14_ADDR_0 = 64'h1003b8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_14_ADDR_1 = 64'h2003b8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_14_ADDR_2 = 64'h3003b8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_14_ADDR_3 = 64'h4003b8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_15_OFFSET = 64'h3c0;
  localparam int STATION_VP_HPMCOUNTER_15_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_15_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_15_ADDR_0 = 64'h1003c0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_15_ADDR_1 = 64'h2003c0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_15_ADDR_2 = 64'h3003c0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_15_ADDR_3 = 64'h4003c0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_16_OFFSET = 64'h3c8;
  localparam int STATION_VP_HPMCOUNTER_16_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_HPMCOUNTER_16_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_16_ADDR_0 = 64'h1003c8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_16_ADDR_1 = 64'h2003c8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_16_ADDR_2 = 64'h3003c8;
  localparam bit [25 - 1:0] STATION_VP_HPMCOUNTER_16_ADDR_3 = 64'h4003c8;
  localparam bit [25 - 1:0] STATION_VP_WB_HASH_OFFSET = 64'h3d0;
  localparam int STATION_VP_WB_HASH_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_WB_HASH_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_WB_HASH_ADDR_0 = 64'h1003d0;
  localparam bit [25 - 1:0] STATION_VP_WB_HASH_ADDR_1 = 64'h2003d0;
  localparam bit [25 - 1:0] STATION_VP_WB_HASH_ADDR_2 = 64'h3003d0;
  localparam bit [25 - 1:0] STATION_VP_WB_HASH_ADDR_3 = 64'h4003d0;
  localparam bit [25 - 1:0] STATION_VP_IF_AMO_ST_OFFSET = 64'h3d8;
  localparam int STATION_VP_IF_AMO_ST_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IF_AMO_ST_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_AMO_ST_ADDR_0 = 64'h1003d8;
  localparam bit [25 - 1:0] STATION_VP_IF_AMO_ST_ADDR_1 = 64'h2003d8;
  localparam bit [25 - 1:0] STATION_VP_IF_AMO_ST_ADDR_2 = 64'h3003d8;
  localparam bit [25 - 1:0] STATION_VP_IF_AMO_ST_ADDR_3 = 64'h4003d8;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_CONDITIONS_OFFSET = 64'h3e0;
  localparam int STATION_VP_IF_STALL_CONDITIONS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_IF_STALL_CONDITIONS_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_CONDITIONS_ADDR_0 = 64'h1003e0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_CONDITIONS_ADDR_1 = 64'h2003e0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_CONDITIONS_ADDR_2 = 64'h3003e0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_CONDITIONS_ADDR_3 = 64'h4003e0;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_CONDITIONS_OFFSET = 64'h3e8;
  localparam int STATION_VP_ID_STALL_CONDITIONS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_ID_STALL_CONDITIONS_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_CONDITIONS_ADDR_0 = 64'h1003e8;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_CONDITIONS_ADDR_1 = 64'h2003e8;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_CONDITIONS_ADDR_2 = 64'h3003e8;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_CONDITIONS_ADDR_3 = 64'h4003e8;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_CONDITIONS_OFFSET = 64'h3f0;
  localparam int STATION_VP_EX_STALL_CONDITIONS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_EX_STALL_CONDITIONS_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_CONDITIONS_ADDR_0 = 64'h1003f0;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_CONDITIONS_ADDR_1 = 64'h2003f0;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_CONDITIONS_ADDR_2 = 64'h3003f0;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_CONDITIONS_ADDR_3 = 64'h4003f0;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_CONDITIONS_OFFSET = 64'h3f8;
  localparam int STATION_VP_MA_STALL_CONDITIONS_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_MA_STALL_CONDITIONS_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_CONDITIONS_ADDR_0 = 64'h1003f8;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_CONDITIONS_ADDR_1 = 64'h2003f8;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_CONDITIONS_ADDR_2 = 64'h3003f8;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_CONDITIONS_ADDR_3 = 64'h4003f8;
  localparam bit [25 - 1:0] STATION_VP_VCORE_IDLE_OFFSET = 64'h400;
  localparam int STATION_VP_VCORE_IDLE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VCORE_IDLE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VCORE_IDLE_ADDR_0 = 64'h100400;
  localparam bit [25 - 1:0] STATION_VP_VCORE_IDLE_ADDR_1 = 64'h200400;
  localparam bit [25 - 1:0] STATION_VP_VCORE_IDLE_ADDR_2 = 64'h300400;
  localparam bit [25 - 1:0] STATION_VP_VCORE_IDLE_ADDR_3 = 64'h400400;
  localparam bit [25 - 1:0] STATION_VP_VLEN_OFFSET = 64'h408;
  localparam int STATION_VP_VLEN_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VLEN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VLEN_ADDR_0 = 64'h100408;
  localparam bit [25 - 1:0] STATION_VP_VLEN_ADDR_1 = 64'h200408;
  localparam bit [25 - 1:0] STATION_VP_VLEN_ADDR_2 = 64'h300408;
  localparam bit [25 - 1:0] STATION_VP_VLEN_ADDR_3 = 64'h400408;
  localparam bit [25 - 1:0] STATION_VP_VLS_VLEN_GRPDEPTH_RATIO_OFFSET = 64'h410;
  localparam int STATION_VP_VLS_VLEN_GRPDEPTH_RATIO_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VLS_VLEN_GRPDEPTH_RATIO_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VLS_VLEN_GRPDEPTH_RATIO_ADDR_0 = 64'h100410;
  localparam bit [25 - 1:0] STATION_VP_VLS_VLEN_GRPDEPTH_RATIO_ADDR_1 = 64'h200410;
  localparam bit [25 - 1:0] STATION_VP_VLS_VLEN_GRPDEPTH_RATIO_ADDR_2 = 64'h300410;
  localparam bit [25 - 1:0] STATION_VP_VLS_VLEN_GRPDEPTH_RATIO_ADDR_3 = 64'h400410;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPDEPTH_OFFSET = 64'h418;
  localparam int STATION_VP_VLS_GRPDEPTH_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VLS_GRPDEPTH_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPDEPTH_ADDR_0 = 64'h100418;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPDEPTH_ADDR_1 = 64'h200418;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPDEPTH_ADDR_2 = 64'h300418;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPDEPTH_ADDR_3 = 64'h400418;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPSTRIDE_OFFSET = 64'h420;
  localparam int STATION_VP_VLS_GRPSTRIDE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_VLS_GRPSTRIDE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPSTRIDE_ADDR_0 = 64'h100420;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPSTRIDE_ADDR_1 = 64'h200420;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPSTRIDE_ADDR_2 = 64'h300420;
  localparam bit [25 - 1:0] STATION_VP_VLS_GRPSTRIDE_ADDR_3 = 64'h400420;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_ICG_DISABLE_OFFSET = 64'h428;
  localparam int STATION_VP_S2B_VCORE_ICG_DISABLE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_VCORE_ICG_DISABLE_RSTVAL = 14'h3fff;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_ICG_DISABLE_ADDR_0 = 64'h100428;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_ICG_DISABLE_ADDR_1 = 64'h200428;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_ICG_DISABLE_ADDR_2 = 64'h300428;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_ICG_DISABLE_ADDR_3 = 64'h400428;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EVT_MASK_OFFSET = 64'h430;
  localparam int STATION_VP_S2B_VCORE_PMU_EVT_MASK_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_VP_S2B_VCORE_PMU_EVT_MASK_RSTVAL = 64'hffffffff;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EVT_MASK_ADDR_0 = 64'h100430;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EVT_MASK_ADDR_1 = 64'h200430;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EVT_MASK_ADDR_2 = 64'h300430;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EVT_MASK_ADDR_3 = 64'h400430;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERLINE_CTRL_OFFSET = 64'h438;
  localparam int STATION_VP_S2B_POWERLINE_CTRL_WIDTH  = 7;
  localparam bit [64 - 1:0] STATION_VP_S2B_POWERLINE_CTRL_RSTVAL = 7'b1111111;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERLINE_CTRL_ADDR_0 = 64'h100438;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERLINE_CTRL_ADDR_1 = 64'h200438;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERLINE_CTRL_ADDR_2 = 64'h300438;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERLINE_CTRL_ADDR_3 = 64'h400438;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_LFSR_SEED_OFFSET = 64'h440;
  localparam int STATION_VP_S2B_CFG_LFSR_SEED_WIDTH  = 6;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_LFSR_SEED_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_LFSR_SEED_ADDR_0 = 64'h100440;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_LFSR_SEED_ADDR_1 = 64'h200440;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_LFSR_SEED_ADDR_2 = 64'h300440;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_LFSR_SEED_ADDR_3 = 64'h400440;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERVBANK_CTRL_OFFSET = 64'h448;
  localparam int STATION_VP_S2B_POWERVBANK_CTRL_WIDTH  = 5;
  localparam bit [64 - 1:0] STATION_VP_S2B_POWERVBANK_CTRL_RSTVAL = 5'b11111;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERVBANK_CTRL_ADDR_0 = 64'h100448;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERVBANK_CTRL_ADDR_1 = 64'h200448;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERVBANK_CTRL_ADDR_2 = 64'h300448;
  localparam bit [25 - 1:0] STATION_VP_S2B_POWERVBANK_CTRL_ADDR_3 = 64'h400448;
  localparam bit [25 - 1:0] STATION_VP_IBUF_CNT_OFFSET = 64'h450;
  localparam int STATION_VP_IBUF_CNT_WIDTH  = 5;
  localparam bit [64 - 1:0] STATION_VP_IBUF_CNT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IBUF_CNT_ADDR_0 = 64'h100450;
  localparam bit [25 - 1:0] STATION_VP_IBUF_CNT_ADDR_1 = 64'h200450;
  localparam bit [25 - 1:0] STATION_VP_IBUF_CNT_ADDR_2 = 64'h300450;
  localparam bit [25 - 1:0] STATION_VP_IBUF_CNT_ADDR_3 = 64'h400450;
  localparam bit [25 - 1:0] STATION_VP_IBUF_RPTR_OFFSET = 64'h458;
  localparam int STATION_VP_IBUF_RPTR_WIDTH  = 5;
  localparam bit [64 - 1:0] STATION_VP_IBUF_RPTR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IBUF_RPTR_ADDR_0 = 64'h100458;
  localparam bit [25 - 1:0] STATION_VP_IBUF_RPTR_ADDR_1 = 64'h200458;
  localparam bit [25 - 1:0] STATION_VP_IBUF_RPTR_ADDR_2 = 64'h300458;
  localparam bit [25 - 1:0] STATION_VP_IBUF_RPTR_ADDR_3 = 64'h400458;
  localparam bit [25 - 1:0] STATION_VP_S2B_EARLY_RSTN_OFFSET = 64'h460;
  localparam int STATION_VP_S2B_EARLY_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EARLY_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EARLY_RSTN_ADDR_0 = 64'h100460;
  localparam bit [25 - 1:0] STATION_VP_S2B_EARLY_RSTN_ADDR_1 = 64'h200460;
  localparam bit [25 - 1:0] STATION_VP_S2B_EARLY_RSTN_ADDR_2 = 64'h300460;
  localparam bit [25 - 1:0] STATION_VP_S2B_EARLY_RSTN_ADDR_3 = 64'h400460;
  localparam bit [25 - 1:0] STATION_VP_S2B_RSTN_OFFSET = 64'h468;
  localparam int STATION_VP_S2B_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_RSTN_ADDR_0 = 64'h100468;
  localparam bit [25 - 1:0] STATION_VP_S2B_RSTN_ADDR_1 = 64'h200468;
  localparam bit [25 - 1:0] STATION_VP_S2B_RSTN_ADDR_2 = 64'h300468;
  localparam bit [25 - 1:0] STATION_VP_S2B_RSTN_ADDR_3 = 64'h400468;
  localparam bit [25 - 1:0] STATION_VP_S2B_EXT_EVENT_OFFSET = 64'h470;
  localparam int STATION_VP_S2B_EXT_EVENT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EXT_EVENT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EXT_EVENT_ADDR_0 = 64'h100470;
  localparam bit [25 - 1:0] STATION_VP_S2B_EXT_EVENT_ADDR_1 = 64'h200470;
  localparam bit [25 - 1:0] STATION_VP_S2B_EXT_EVENT_ADDR_2 = 64'h300470;
  localparam bit [25 - 1:0] STATION_VP_S2B_EXT_EVENT_ADDR_3 = 64'h400470;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_STALL_OFFSET = 64'h478;
  localparam int STATION_VP_S2B_DEBUG_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_DEBUG_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_STALL_ADDR_0 = 64'h100478;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_STALL_ADDR_1 = 64'h200478;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_STALL_ADDR_2 = 64'h300478;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_STALL_ADDR_3 = 64'h400478;
  localparam bit [25 - 1:0] STATION_VP_B2S_DEBUG_STALL_OUT_OFFSET = 64'h480;
  localparam int STATION_VP_B2S_DEBUG_STALL_OUT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_B2S_DEBUG_STALL_OUT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_0 = 64'h100480;
  localparam bit [25 - 1:0] STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_1 = 64'h200480;
  localparam bit [25 - 1:0] STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_2 = 64'h300480;
  localparam bit [25 - 1:0] STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_3 = 64'h400480;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_RESUME_OFFSET = 64'h488;
  localparam int STATION_VP_S2B_DEBUG_RESUME_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_DEBUG_RESUME_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_RESUME_ADDR_0 = 64'h100488;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_RESUME_ADDR_1 = 64'h200488;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_RESUME_ADDR_2 = 64'h300488;
  localparam bit [25 - 1:0] STATION_VP_S2B_DEBUG_RESUME_ADDR_3 = 64'h400488;
  localparam bit [25 - 1:0] STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_OFFSET = 64'h490;
  localparam int STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_ADDR_0 = 64'h100490;
  localparam bit [25 - 1:0] STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_ADDR_1 = 64'h200490;
  localparam bit [25 - 1:0] STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_ADDR_2 = 64'h300490;
  localparam bit [25 - 1:0] STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_ADDR_3 = 64'h400490;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_EN_HPMCOUNTER_OFFSET = 64'h498;
  localparam int STATION_VP_S2B_CFG_EN_HPMCOUNTER_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_EN_HPMCOUNTER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_EN_HPMCOUNTER_ADDR_0 = 64'h100498;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_EN_HPMCOUNTER_ADDR_1 = 64'h200498;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_EN_HPMCOUNTER_ADDR_2 = 64'h300498;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_EN_HPMCOUNTER_ADDR_3 = 64'h400498;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_PWR_ON_OFFSET = 64'h4a0;
  localparam int STATION_VP_S2B_CFG_PWR_ON_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_PWR_ON_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_PWR_ON_ADDR_0 = 64'h1004a0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_PWR_ON_ADDR_1 = 64'h2004a0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_PWR_ON_ADDR_2 = 64'h3004a0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_PWR_ON_ADDR_3 = 64'h4004a0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_SLEEP_OFFSET = 64'h4a8;
  localparam int STATION_VP_S2B_CFG_SLEEP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_SLEEP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_SLEEP_ADDR_0 = 64'h1004a8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_SLEEP_ADDR_1 = 64'h2004a8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_SLEEP_ADDR_2 = 64'h3004a8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_SLEEP_ADDR_3 = 64'h4004a8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_IC_OFFSET = 64'h4b0;
  localparam int STATION_VP_S2B_CFG_BYPASS_IC_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_BYPASS_IC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_IC_ADDR_0 = 64'h1004b0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_IC_ADDR_1 = 64'h2004b0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_IC_ADDR_2 = 64'h3004b0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_IC_ADDR_3 = 64'h4004b0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_TLB_OFFSET = 64'h4b8;
  localparam int STATION_VP_S2B_CFG_BYPASS_TLB_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_BYPASS_TLB_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_0 = 64'h1004b8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_1 = 64'h2004b8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_2 = 64'h3004b8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_3 = 64'h4004b8;
  localparam bit [25 - 1:0] STATION_VP_S2ICG_CLK_EN_OFFSET = 64'h4c0;
  localparam int STATION_VP_S2ICG_CLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2ICG_CLK_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_VP_S2ICG_CLK_EN_ADDR_0 = 64'h1004c0;
  localparam bit [25 - 1:0] STATION_VP_S2ICG_CLK_EN_ADDR_1 = 64'h2004c0;
  localparam bit [25 - 1:0] STATION_VP_S2ICG_CLK_EN_ADDR_2 = 64'h3004c0;
  localparam bit [25 - 1:0] STATION_VP_S2ICG_CLK_EN_ADDR_3 = 64'h4004c0;
  localparam bit [25 - 1:0] STATION_VP_B2S_IS_VTLB_EXCP_OFFSET = 64'h4c8;
  localparam int STATION_VP_B2S_IS_VTLB_EXCP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_B2S_IS_VTLB_EXCP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_B2S_IS_VTLB_EXCP_ADDR_0 = 64'h1004c8;
  localparam bit [25 - 1:0] STATION_VP_B2S_IS_VTLB_EXCP_ADDR_1 = 64'h2004c8;
  localparam bit [25 - 1:0] STATION_VP_B2S_IS_VTLB_EXCP_ADDR_2 = 64'h3004c8;
  localparam bit [25 - 1:0] STATION_VP_B2S_IS_VTLB_EXCP_ADDR_3 = 64'h4004c8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_EN_OFFSET = 64'h4d0;
  localparam int STATION_VP_S2B_CFG_ITB_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_ITB_EN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_EN_ADDR_0 = 64'h1004d0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_EN_ADDR_1 = 64'h2004d0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_EN_ADDR_2 = 64'h3004d0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_EN_ADDR_3 = 64'h4004d0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_WRAP_AROUND_OFFSET = 64'h4d8;
  localparam int STATION_VP_S2B_CFG_ITB_WRAP_AROUND_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_CFG_ITB_WRAP_AROUND_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_WRAP_AROUND_ADDR_0 = 64'h1004d8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_WRAP_AROUND_ADDR_1 = 64'h2004d8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_WRAP_AROUND_ADDR_2 = 64'h3004d8;
  localparam bit [25 - 1:0] STATION_VP_S2B_CFG_ITB_WRAP_AROUND_ADDR_3 = 64'h4004d8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_0_OFFSET = 64'h4e0;
  localparam int STATION_VP_S2B_EN_BP_IF_PC_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_0_ADDR_0 = 64'h1004e0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_0_ADDR_1 = 64'h2004e0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_0_ADDR_2 = 64'h3004e0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_0_ADDR_3 = 64'h4004e0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_1_OFFSET = 64'h4e8;
  localparam int STATION_VP_S2B_EN_BP_IF_PC_1_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_1_ADDR_0 = 64'h1004e8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_1_ADDR_1 = 64'h2004e8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_1_ADDR_2 = 64'h3004e8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_1_ADDR_3 = 64'h4004e8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_2_OFFSET = 64'h4f0;
  localparam int STATION_VP_S2B_EN_BP_IF_PC_2_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_2_ADDR_0 = 64'h1004f0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_2_ADDR_1 = 64'h2004f0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_2_ADDR_2 = 64'h3004f0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_2_ADDR_3 = 64'h4004f0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_3_OFFSET = 64'h4f8;
  localparam int STATION_VP_S2B_EN_BP_IF_PC_3_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_3_ADDR_0 = 64'h1004f8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_3_ADDR_1 = 64'h2004f8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_3_ADDR_2 = 64'h3004f8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_IF_PC_3_ADDR_3 = 64'h4004f8;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_0_OFFSET = 64'h500;
  localparam int STATION_VP_S2B_EN_BP_WB_PC_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_0_ADDR_0 = 64'h100500;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_0_ADDR_1 = 64'h200500;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_0_ADDR_2 = 64'h300500;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_0_ADDR_3 = 64'h400500;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_1_OFFSET = 64'h508;
  localparam int STATION_VP_S2B_EN_BP_WB_PC_1_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_1_ADDR_0 = 64'h100508;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_1_ADDR_1 = 64'h200508;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_1_ADDR_2 = 64'h300508;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_1_ADDR_3 = 64'h400508;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_2_OFFSET = 64'h510;
  localparam int STATION_VP_S2B_EN_BP_WB_PC_2_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_2_ADDR_0 = 64'h100510;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_2_ADDR_1 = 64'h200510;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_2_ADDR_2 = 64'h300510;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_2_ADDR_3 = 64'h400510;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_3_OFFSET = 64'h518;
  localparam int STATION_VP_S2B_EN_BP_WB_PC_3_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_3_ADDR_0 = 64'h100518;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_3_ADDR_1 = 64'h200518;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_3_ADDR_2 = 64'h300518;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_WB_PC_3_ADDR_3 = 64'h400518;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_INSTRET_OFFSET = 64'h520;
  localparam int STATION_VP_S2B_EN_BP_INSTRET_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_EN_BP_INSTRET_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_INSTRET_ADDR_0 = 64'h100520;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_INSTRET_ADDR_1 = 64'h200520;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_INSTRET_ADDR_2 = 64'h300520;
  localparam bit [25 - 1:0] STATION_VP_S2B_EN_BP_INSTRET_ADDR_3 = 64'h400520;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_EN_OFFSET = 64'h528;
  localparam int STATION_VP_S2B_VCORE_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_VCORE_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_EN_ADDR_0 = 64'h100528;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_EN_ADDR_1 = 64'h200528;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_EN_ADDR_2 = 64'h300528;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_EN_ADDR_3 = 64'h400528;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_OFFSET__DEPTH_0 = 64'h530;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_OFFSET__DEPTH_1 = 64'h538;
  localparam int STATION_VP_IBUF_LINE_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_0__DEPTH_0 = 64'h100530;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_0__DEPTH_1 = 64'h100538;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_1__DEPTH_0 = 64'h200530;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_1__DEPTH_1 = 64'h200538;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_2__DEPTH_0 = 64'h300530;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_2__DEPTH_1 = 64'h300538;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_3__DEPTH_0 = 64'h400530;
  localparam bit [25 - 1:0] STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_3__DEPTH_1 = 64'h400538;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_0 = 64'h540;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_1 = 64'h548;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_2 = 64'h550;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_3 = 64'h558;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_4 = 64'h560;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_5 = 64'h568;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_6 = 64'h570;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_OFFSET__DEPTH_7 = 64'h578;
  localparam int STATION_VP_ITLB_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_ITLB_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_0 = 64'h100540;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_1 = 64'h100548;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_2 = 64'h100550;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_3 = 64'h100558;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_4 = 64'h100560;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_5 = 64'h100568;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_6 = 64'h100570;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_0__DEPTH_7 = 64'h100578;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_0 = 64'h200540;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_1 = 64'h200548;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_2 = 64'h200550;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_3 = 64'h200558;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_4 = 64'h200560;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_5 = 64'h200568;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_6 = 64'h200570;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_1__DEPTH_7 = 64'h200578;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_0 = 64'h300540;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_1 = 64'h300548;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_2 = 64'h300550;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_3 = 64'h300558;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_4 = 64'h300560;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_5 = 64'h300568;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_6 = 64'h300570;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_2__DEPTH_7 = 64'h300578;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_0 = 64'h400540;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_1 = 64'h400548;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_2 = 64'h400550;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_3 = 64'h400558;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_4 = 64'h400560;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_5 = 64'h400568;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_6 = 64'h400570;
  localparam bit [25 - 1:0] STATION_VP_ITLB_VALID_ADDR_3__DEPTH_7 = 64'h400578;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_0 = 64'h580;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_1 = 64'h588;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_2 = 64'h590;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_3 = 64'h598;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_4 = 64'h5a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_5 = 64'h5a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_6 = 64'h5b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_OFFSET__DEPTH_7 = 64'h5b8;
  localparam int STATION_VP_DTLB_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_DTLB_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_0 = 64'h100580;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_1 = 64'h100588;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_2 = 64'h100590;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_3 = 64'h100598;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_4 = 64'h1005a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_5 = 64'h1005a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_6 = 64'h1005b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_0__DEPTH_7 = 64'h1005b8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_0 = 64'h200580;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_1 = 64'h200588;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_2 = 64'h200590;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_3 = 64'h200598;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_4 = 64'h2005a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_5 = 64'h2005a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_6 = 64'h2005b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_1__DEPTH_7 = 64'h2005b8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_0 = 64'h300580;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_1 = 64'h300588;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_2 = 64'h300590;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_3 = 64'h300598;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_4 = 64'h3005a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_5 = 64'h3005a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_6 = 64'h3005b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_2__DEPTH_7 = 64'h3005b8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_0 = 64'h400580;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_1 = 64'h400588;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_2 = 64'h400590;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_3 = 64'h400598;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_4 = 64'h4005a0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_5 = 64'h4005a8;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_6 = 64'h4005b0;
  localparam bit [25 - 1:0] STATION_VP_DTLB_VALID_ADDR_3__DEPTH_7 = 64'h4005b8;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_OFFSET__DEPTH_0 = 64'h5c0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_OFFSET__DEPTH_1 = 64'h5c8;
  localparam int STATION_VP_VTLB_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_VTLB_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_0__DEPTH_0 = 64'h1005c0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_0__DEPTH_1 = 64'h1005c8;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_1__DEPTH_0 = 64'h2005c0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_1__DEPTH_1 = 64'h2005c8;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_2__DEPTH_0 = 64'h3005c0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_2__DEPTH_1 = 64'h3005c8;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_3__DEPTH_0 = 64'h4005c0;
  localparam bit [25 - 1:0] STATION_VP_VTLB_VALID_ADDR_3__DEPTH_1 = 64'h4005c8;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_OFFSET = 64'h5d0;
  localparam int STATION_VP_IF_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IF_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_ADDR_0 = 64'h1005d0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_ADDR_1 = 64'h2005d0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_ADDR_2 = 64'h3005d0;
  localparam bit [25 - 1:0] STATION_VP_IF_STALL_ADDR_3 = 64'h4005d0;
  localparam bit [25 - 1:0] STATION_VP_IF_KILL_OFFSET = 64'h5d8;
  localparam int STATION_VP_IF_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IF_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_KILL_ADDR_0 = 64'h1005d8;
  localparam bit [25 - 1:0] STATION_VP_IF_KILL_ADDR_1 = 64'h2005d8;
  localparam bit [25 - 1:0] STATION_VP_IF_KILL_ADDR_2 = 64'h3005d8;
  localparam bit [25 - 1:0] STATION_VP_IF_KILL_ADDR_3 = 64'h4005d8;
  localparam bit [25 - 1:0] STATION_VP_IF_VALID_OFFSET = 64'h5e0;
  localparam int STATION_VP_IF_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IF_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_VALID_ADDR_0 = 64'h1005e0;
  localparam bit [25 - 1:0] STATION_VP_IF_VALID_ADDR_1 = 64'h2005e0;
  localparam bit [25 - 1:0] STATION_VP_IF_VALID_ADDR_2 = 64'h3005e0;
  localparam bit [25 - 1:0] STATION_VP_IF_VALID_ADDR_3 = 64'h4005e0;
  localparam bit [25 - 1:0] STATION_VP_IF_READY_OFFSET = 64'h5e8;
  localparam int STATION_VP_IF_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IF_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF_READY_ADDR_0 = 64'h1005e8;
  localparam bit [25 - 1:0] STATION_VP_IF_READY_ADDR_1 = 64'h2005e8;
  localparam bit [25 - 1:0] STATION_VP_IF_READY_ADDR_2 = 64'h3005e8;
  localparam bit [25 - 1:0] STATION_VP_IF_READY_ADDR_3 = 64'h4005e8;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_OFFSET = 64'h5f0;
  localparam int STATION_VP_ID_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_ID_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_ADDR_0 = 64'h1005f0;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_ADDR_1 = 64'h2005f0;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_ADDR_2 = 64'h3005f0;
  localparam bit [25 - 1:0] STATION_VP_ID_STALL_ADDR_3 = 64'h4005f0;
  localparam bit [25 - 1:0] STATION_VP_ID_KILL_OFFSET = 64'h5f8;
  localparam int STATION_VP_ID_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_ID_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID_KILL_ADDR_0 = 64'h1005f8;
  localparam bit [25 - 1:0] STATION_VP_ID_KILL_ADDR_1 = 64'h2005f8;
  localparam bit [25 - 1:0] STATION_VP_ID_KILL_ADDR_2 = 64'h3005f8;
  localparam bit [25 - 1:0] STATION_VP_ID_KILL_ADDR_3 = 64'h4005f8;
  localparam bit [25 - 1:0] STATION_VP_ID_VALID_OFFSET = 64'h600;
  localparam int STATION_VP_ID_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_ID_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID_VALID_ADDR_0 = 64'h100600;
  localparam bit [25 - 1:0] STATION_VP_ID_VALID_ADDR_1 = 64'h200600;
  localparam bit [25 - 1:0] STATION_VP_ID_VALID_ADDR_2 = 64'h300600;
  localparam bit [25 - 1:0] STATION_VP_ID_VALID_ADDR_3 = 64'h400600;
  localparam bit [25 - 1:0] STATION_VP_ID_READY_OFFSET = 64'h608;
  localparam int STATION_VP_ID_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_ID_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID_READY_ADDR_0 = 64'h100608;
  localparam bit [25 - 1:0] STATION_VP_ID_READY_ADDR_1 = 64'h200608;
  localparam bit [25 - 1:0] STATION_VP_ID_READY_ADDR_2 = 64'h300608;
  localparam bit [25 - 1:0] STATION_VP_ID_READY_ADDR_3 = 64'h400608;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_OFFSET = 64'h610;
  localparam int STATION_VP_EX_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_EX_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_ADDR_0 = 64'h100610;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_ADDR_1 = 64'h200610;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_ADDR_2 = 64'h300610;
  localparam bit [25 - 1:0] STATION_VP_EX_STALL_ADDR_3 = 64'h400610;
  localparam bit [25 - 1:0] STATION_VP_EX_KILL_OFFSET = 64'h618;
  localparam int STATION_VP_EX_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_EX_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX_KILL_ADDR_0 = 64'h100618;
  localparam bit [25 - 1:0] STATION_VP_EX_KILL_ADDR_1 = 64'h200618;
  localparam bit [25 - 1:0] STATION_VP_EX_KILL_ADDR_2 = 64'h300618;
  localparam bit [25 - 1:0] STATION_VP_EX_KILL_ADDR_3 = 64'h400618;
  localparam bit [25 - 1:0] STATION_VP_EX_VALID_OFFSET = 64'h620;
  localparam int STATION_VP_EX_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_EX_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX_VALID_ADDR_0 = 64'h100620;
  localparam bit [25 - 1:0] STATION_VP_EX_VALID_ADDR_1 = 64'h200620;
  localparam bit [25 - 1:0] STATION_VP_EX_VALID_ADDR_2 = 64'h300620;
  localparam bit [25 - 1:0] STATION_VP_EX_VALID_ADDR_3 = 64'h400620;
  localparam bit [25 - 1:0] STATION_VP_EX_READY_OFFSET = 64'h628;
  localparam int STATION_VP_EX_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_EX_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX_READY_ADDR_0 = 64'h100628;
  localparam bit [25 - 1:0] STATION_VP_EX_READY_ADDR_1 = 64'h200628;
  localparam bit [25 - 1:0] STATION_VP_EX_READY_ADDR_2 = 64'h300628;
  localparam bit [25 - 1:0] STATION_VP_EX_READY_ADDR_3 = 64'h400628;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_OFFSET = 64'h630;
  localparam int STATION_VP_MA_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_MA_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_ADDR_0 = 64'h100630;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_ADDR_1 = 64'h200630;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_ADDR_2 = 64'h300630;
  localparam bit [25 - 1:0] STATION_VP_MA_STALL_ADDR_3 = 64'h400630;
  localparam bit [25 - 1:0] STATION_VP_MA_KILL_OFFSET = 64'h638;
  localparam int STATION_VP_MA_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_MA_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA_KILL_ADDR_0 = 64'h100638;
  localparam bit [25 - 1:0] STATION_VP_MA_KILL_ADDR_1 = 64'h200638;
  localparam bit [25 - 1:0] STATION_VP_MA_KILL_ADDR_2 = 64'h300638;
  localparam bit [25 - 1:0] STATION_VP_MA_KILL_ADDR_3 = 64'h400638;
  localparam bit [25 - 1:0] STATION_VP_MA_VALID_OFFSET = 64'h640;
  localparam int STATION_VP_MA_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_MA_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA_VALID_ADDR_0 = 64'h100640;
  localparam bit [25 - 1:0] STATION_VP_MA_VALID_ADDR_1 = 64'h200640;
  localparam bit [25 - 1:0] STATION_VP_MA_VALID_ADDR_2 = 64'h300640;
  localparam bit [25 - 1:0] STATION_VP_MA_VALID_ADDR_3 = 64'h400640;
  localparam bit [25 - 1:0] STATION_VP_MA_READY_OFFSET = 64'h648;
  localparam int STATION_VP_MA_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_MA_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA_READY_ADDR_0 = 64'h100648;
  localparam bit [25 - 1:0] STATION_VP_MA_READY_ADDR_1 = 64'h200648;
  localparam bit [25 - 1:0] STATION_VP_MA_READY_ADDR_2 = 64'h300648;
  localparam bit [25 - 1:0] STATION_VP_MA_READY_ADDR_3 = 64'h400648;
  localparam bit [25 - 1:0] STATION_VP_WB_VALID_OFFSET = 64'h650;
  localparam int STATION_VP_WB_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_WB_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_WB_VALID_ADDR_0 = 64'h100650;
  localparam bit [25 - 1:0] STATION_VP_WB_VALID_ADDR_1 = 64'h200650;
  localparam bit [25 - 1:0] STATION_VP_WB_VALID_ADDR_2 = 64'h300650;
  localparam bit [25 - 1:0] STATION_VP_WB_VALID_ADDR_3 = 64'h400650;
  localparam bit [25 - 1:0] STATION_VP_WB_READY_OFFSET = 64'h658;
  localparam int STATION_VP_WB_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_WB_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_WB_READY_ADDR_0 = 64'h100658;
  localparam bit [25 - 1:0] STATION_VP_WB_READY_ADDR_1 = 64'h200658;
  localparam bit [25 - 1:0] STATION_VP_WB_READY_ADDR_2 = 64'h300658;
  localparam bit [25 - 1:0] STATION_VP_WB_READY_ADDR_3 = 64'h400658;
  localparam bit [25 - 1:0] STATION_VP_CS2IF_KILL_OFFSET = 64'h660;
  localparam int STATION_VP_CS2IF_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_CS2IF_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_CS2IF_KILL_ADDR_0 = 64'h100660;
  localparam bit [25 - 1:0] STATION_VP_CS2IF_KILL_ADDR_1 = 64'h200660;
  localparam bit [25 - 1:0] STATION_VP_CS2IF_KILL_ADDR_2 = 64'h300660;
  localparam bit [25 - 1:0] STATION_VP_CS2IF_KILL_ADDR_3 = 64'h400660;
  localparam bit [25 - 1:0] STATION_VP_CS2ID_KILL_OFFSET = 64'h668;
  localparam int STATION_VP_CS2ID_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_CS2ID_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_CS2ID_KILL_ADDR_0 = 64'h100668;
  localparam bit [25 - 1:0] STATION_VP_CS2ID_KILL_ADDR_1 = 64'h200668;
  localparam bit [25 - 1:0] STATION_VP_CS2ID_KILL_ADDR_2 = 64'h300668;
  localparam bit [25 - 1:0] STATION_VP_CS2ID_KILL_ADDR_3 = 64'h400668;
  localparam bit [25 - 1:0] STATION_VP_CS2EX_KILL_OFFSET = 64'h670;
  localparam int STATION_VP_CS2EX_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_CS2EX_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_CS2EX_KILL_ADDR_0 = 64'h100670;
  localparam bit [25 - 1:0] STATION_VP_CS2EX_KILL_ADDR_1 = 64'h200670;
  localparam bit [25 - 1:0] STATION_VP_CS2EX_KILL_ADDR_2 = 64'h300670;
  localparam bit [25 - 1:0] STATION_VP_CS2EX_KILL_ADDR_3 = 64'h400670;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_KILL_OFFSET = 64'h678;
  localparam int STATION_VP_CS2MA_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_CS2MA_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_KILL_ADDR_0 = 64'h100678;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_KILL_ADDR_1 = 64'h200678;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_KILL_ADDR_2 = 64'h300678;
  localparam bit [25 - 1:0] STATION_VP_CS2MA_KILL_ADDR_3 = 64'h400678;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_VALID_OFFSET = 64'h680;
  localparam int STATION_VP_L2_REQ_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_L2_REQ_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_VALID_ADDR_0 = 64'h100680;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_VALID_ADDR_1 = 64'h200680;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_VALID_ADDR_2 = 64'h300680;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_VALID_ADDR_3 = 64'h400680;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_READY_OFFSET = 64'h688;
  localparam int STATION_VP_L2_REQ_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_L2_REQ_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_READY_ADDR_0 = 64'h100688;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_READY_ADDR_1 = 64'h200688;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_READY_ADDR_2 = 64'h300688;
  localparam bit [25 - 1:0] STATION_VP_L2_REQ_READY_ADDR_3 = 64'h400688;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_VALID_OFFSET = 64'h690;
  localparam int STATION_VP_L2_RESP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_L2_RESP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_VALID_ADDR_0 = 64'h100690;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_VALID_ADDR_1 = 64'h200690;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_VALID_ADDR_2 = 64'h300690;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_VALID_ADDR_3 = 64'h400690;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_READY_OFFSET = 64'h698;
  localparam int STATION_VP_L2_RESP_READY_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_L2_RESP_READY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_READY_ADDR_0 = 64'h100698;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_READY_ADDR_1 = 64'h200698;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_READY_ADDR_2 = 64'h300698;
  localparam bit [25 - 1:0] STATION_VP_L2_RESP_READY_ADDR_3 = 64'h400698;
  localparam bit [25 - 1:0] STATION_VP_WFI_STALL_OFFSET = 64'h6a0;
  localparam int STATION_VP_WFI_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_WFI_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_WFI_STALL_ADDR_0 = 64'h1006a0;
  localparam bit [25 - 1:0] STATION_VP_WFI_STALL_ADDR_1 = 64'h2006a0;
  localparam bit [25 - 1:0] STATION_VP_WFI_STALL_ADDR_2 = 64'h3006a0;
  localparam bit [25 - 1:0] STATION_VP_WFI_STALL_ADDR_3 = 64'h4006a0;
  localparam bit [25 - 1:0] STATION_VP_WFE_STALL_OFFSET = 64'h6a8;
  localparam int STATION_VP_WFE_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_WFE_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_WFE_STALL_ADDR_0 = 64'h1006a8;
  localparam bit [25 - 1:0] STATION_VP_WFE_STALL_ADDR_1 = 64'h2006a8;
  localparam bit [25 - 1:0] STATION_VP_WFE_STALL_ADDR_2 = 64'h3006a8;
  localparam bit [25 - 1:0] STATION_VP_WFE_STALL_ADDR_3 = 64'h4006a8;
  localparam bit [25 - 1:0] STATION_VP_MA2IF_NPC_VALID_OFFSET = 64'h6b0;
  localparam int STATION_VP_MA2IF_NPC_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_MA2IF_NPC_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA2IF_NPC_VALID_ADDR_0 = 64'h1006b0;
  localparam bit [25 - 1:0] STATION_VP_MA2IF_NPC_VALID_ADDR_1 = 64'h2006b0;
  localparam bit [25 - 1:0] STATION_VP_MA2IF_NPC_VALID_ADDR_2 = 64'h3006b0;
  localparam bit [25 - 1:0] STATION_VP_MA2IF_NPC_VALID_ADDR_3 = 64'h4006b0;
  localparam bit [25 - 1:0] STATION_VP_EX2IF_KILL_OFFSET = 64'h6b8;
  localparam int STATION_VP_EX2IF_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_EX2IF_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX2IF_KILL_ADDR_0 = 64'h1006b8;
  localparam bit [25 - 1:0] STATION_VP_EX2IF_KILL_ADDR_1 = 64'h2006b8;
  localparam bit [25 - 1:0] STATION_VP_EX2IF_KILL_ADDR_2 = 64'h3006b8;
  localparam bit [25 - 1:0] STATION_VP_EX2IF_KILL_ADDR_3 = 64'h4006b8;
  localparam bit [25 - 1:0] STATION_VP_EX2ID_KILL_OFFSET = 64'h6c0;
  localparam int STATION_VP_EX2ID_KILL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_EX2ID_KILL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX2ID_KILL_ADDR_0 = 64'h1006c0;
  localparam bit [25 - 1:0] STATION_VP_EX2ID_KILL_ADDR_1 = 64'h2006c0;
  localparam bit [25 - 1:0] STATION_VP_EX2ID_KILL_ADDR_2 = 64'h3006c0;
  localparam bit [25 - 1:0] STATION_VP_EX2ID_KILL_ADDR_3 = 64'h4006c0;
  localparam bit [25 - 1:0] STATION_VP_BRANCH_SOLVED_OFFSET = 64'h6c8;
  localparam int STATION_VP_BRANCH_SOLVED_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_BRANCH_SOLVED_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_BRANCH_SOLVED_ADDR_0 = 64'h1006c8;
  localparam bit [25 - 1:0] STATION_VP_BRANCH_SOLVED_ADDR_1 = 64'h2006c8;
  localparam bit [25 - 1:0] STATION_VP_BRANCH_SOLVED_ADDR_2 = 64'h3006c8;
  localparam bit [25 - 1:0] STATION_VP_BRANCH_SOLVED_ADDR_3 = 64'h4006c8;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_EN_OFFSET = 64'h6d0;
  localparam int STATION_VP_IF2IC_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IF2IC_EN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_EN_ADDR_0 = 64'h1006d0;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_EN_ADDR_1 = 64'h2006d0;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_EN_ADDR_2 = 64'h3006d0;
  localparam bit [25 - 1:0] STATION_VP_IF2IC_EN_ADDR_3 = 64'h4006d0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_VALID_OFFSET = 64'h6d8;
  localparam int STATION_VP_IC2IF_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IC2IF_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_VALID_ADDR_0 = 64'h1006d8;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_VALID_ADDR_1 = 64'h2006d8;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_VALID_ADDR_2 = 64'h3006d8;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_EXCP_VALID_ADDR_3 = 64'h4006d8;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_IS_RVC_OFFSET = 64'h6e0;
  localparam int STATION_VP_IC2IF_IS_RVC_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IC2IF_IS_RVC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_IS_RVC_ADDR_0 = 64'h1006e0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_IS_RVC_ADDR_1 = 64'h2006e0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_IS_RVC_ADDR_2 = 64'h3006e0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_IS_RVC_ADDR_3 = 64'h4006e0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_VALID_OFFSET = 64'h6e8;
  localparam int STATION_VP_IC2IF_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IC2IF_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_VALID_ADDR_0 = 64'h1006e8;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_VALID_ADDR_1 = 64'h2006e8;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_VALID_ADDR_2 = 64'h3006e8;
  localparam bit [25 - 1:0] STATION_VP_IC2IF_VALID_ADDR_3 = 64'h4006e8;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_VALID_OFFSET = 64'h6f0;
  localparam int STATION_VP_IF2ID_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_IF2ID_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_VALID_ADDR_0 = 64'h1006f0;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_VALID_ADDR_1 = 64'h2006f0;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_VALID_ADDR_2 = 64'h3006f0;
  localparam bit [25 - 1:0] STATION_VP_IF2ID_EXCP_VALID_ADDR_3 = 64'h4006f0;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_VALID_OFFSET = 64'h6f8;
  localparam int STATION_VP_ID2EX_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_ID2EX_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_VALID_ADDR_0 = 64'h1006f8;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_VALID_ADDR_1 = 64'h2006f8;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_VALID_ADDR_2 = 64'h3006f8;
  localparam bit [25 - 1:0] STATION_VP_ID2EX_EXCP_VALID_ADDR_3 = 64'h4006f8;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_VALID_OFFSET = 64'h700;
  localparam int STATION_VP_EX2MA_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_EX2MA_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_VALID_ADDR_0 = 64'h100700;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_VALID_ADDR_1 = 64'h200700;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_VALID_ADDR_2 = 64'h300700;
  localparam bit [25 - 1:0] STATION_VP_EX2MA_EXCP_VALID_ADDR_3 = 64'h400700;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_VALID_OFFSET = 64'h708;
  localparam int STATION_VP_MA2CS_EXCP_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_MA2CS_EXCP_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_VALID_ADDR_0 = 64'h100708;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_VALID_ADDR_1 = 64'h200708;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_VALID_ADDR_2 = 64'h300708;
  localparam bit [25 - 1:0] STATION_VP_MA2CS_EXCP_VALID_ADDR_3 = 64'h400708;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EN_OFFSET = 64'h710;
  localparam int STATION_VP_S2B_VCORE_PMU_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_VP_S2B_VCORE_PMU_EN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EN_ADDR_0 = 64'h100710;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EN_ADDR_1 = 64'h200710;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EN_ADDR_2 = 64'h300710;
  localparam bit [25 - 1:0] STATION_VP_S2B_VCORE_PMU_EN_ADDR_3 = 64'h400710;
endpackage


`define STATION_VP__SV
module station_vp
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_vp_pkg::*;
  import vcore_pkg::*;
  import orv64_typedef_pkg::*;
  # ( parameter int BLOCK_INST_ID = 0 ) (
  output orv64_vaddr_t out_s2b_cfg_rst_pc,
  output orv64_itb_sel_t out_s2b_cfg_itb_sel,
  output orv64_itb_addr_t out_b2s_itb_last_ptr,
  output orv64_vaddr_t out_s2b_bp_if_pc_0,
  output orv64_vaddr_t out_s2b_bp_if_pc_1,
  output orv64_vaddr_t out_s2b_bp_if_pc_2,
  output orv64_vaddr_t out_s2b_bp_if_pc_3,
  output orv64_vaddr_t out_s2b_bp_wb_pc_0,
  output orv64_vaddr_t out_s2b_bp_wb_pc_1,
  output orv64_vaddr_t out_s2b_bp_wb_pc_2,
  output orv64_vaddr_t out_s2b_bp_wb_pc_3,
  output orv64_data_t out_s2b_bp_instret,
  output orv_vcore_icg_disable_t out_s2b_vcore_icg_disable,
  output vcore_pmu_evt_mask_t out_s2b_vcore_pmu_evt_mask,
  output powerline_ctrl_t out_s2b_powerline_ctrl,
  output [STATION_VP_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0] out_s2b_cfg_lfsr_seed,
  output powervbank_ctrl_t out_s2b_powervbank_ctrl,
  output out_s2b_early_rstn,
  output out_s2b_rstn,
  output out_s2b_ext_event,
  output out_s2b_debug_stall,
  output out_b2s_debug_stall_out,
  output out_s2b_debug_resume,
  output out_b2s_vload_drt_req_vlen_illegal,
  output out_s2b_cfg_en_hpmcounter,
  output out_s2b_cfg_pwr_on,
  output out_s2b_cfg_sleep,
  output out_s2b_cfg_bypass_ic,
  output out_s2b_cfg_bypass_tlb,
  output out_s2icg_clk_en,
  output out_b2s_is_vtlb_excp,
  output out_s2b_cfg_itb_en,
  output out_s2b_cfg_itb_wrap_around,
  output out_s2b_en_bp_if_pc_0,
  output out_s2b_en_bp_if_pc_1,
  output out_s2b_en_bp_if_pc_2,
  output out_s2b_en_bp_if_pc_3,
  output out_s2b_en_bp_wb_pc_0,
  output out_s2b_en_bp_wb_pc_1,
  output out_s2b_en_bp_wb_pc_2,
  output out_s2b_en_bp_wb_pc_3,
  output out_s2b_en_bp_instret,
  output out_s2b_vcore_en,
  output out_s2b_vcore_pmu_en,
  input logic vld_in_b2s_itb_last_ptr,
  input orv64_itb_addr_t in_b2s_itb_last_ptr,
  input logic vld_in_b2s_debug_stall_out,
  input in_b2s_debug_stall_out,
  input logic vld_in_b2s_vload_drt_req_vlen_illegal,
  input in_b2s_vload_drt_req_vlen_illegal,
  input logic vld_in_b2s_is_vtlb_excp,
  input in_b2s_is_vtlb_excp,
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
  localparam int                                STATION_ID_WIDTH_0 = STATION_VP_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 =
    (BLOCK_INST_ID == 0) ? STATION_VP_BLKID_0 :
    (BLOCK_INST_ID == 1) ? STATION_VP_BLKID_1 :
    (BLOCK_INST_ID == 2) ? STATION_VP_BLKID_2 :
    (BLOCK_INST_ID == 3) ? STATION_VP_BLKID_3 :
    0;

  `ifndef SYNTHESIS
  initial begin
    assert (BLOCK_INST_ID < 4) else $fatal("%m: BLOCK_INST_ID = %d >= 4", BLOCK_INST_ID);
  end
  `endif
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
  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_VP_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_VP_MAX_RING_ADDR)) station_u (
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
  orv64_vaddr_t rff_s2b_cfg_rst_pc;
  orv64_vaddr_t s2b_cfg_rst_pc;
  logic load_s2b_cfg_rst_pc;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_rst_pc <= orv64_vaddr_t'(STATION_VP_S2B_CFG_RST_PC_RSTVAL);
    end else if (load_s2b_cfg_rst_pc == 1'b1) begin
      rff_s2b_cfg_rst_pc <= orv64_vaddr_t'((wmask & s2b_cfg_rst_pc) | (wmask_inv & rff_s2b_cfg_rst_pc));
    end
  end
  assign out_s2b_cfg_rst_pc = rff_s2b_cfg_rst_pc;
  orv64_itb_sel_t rff_s2b_cfg_itb_sel;
  orv64_itb_sel_t s2b_cfg_itb_sel;
  logic load_s2b_cfg_itb_sel;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_itb_sel <= orv64_itb_sel_t'(STATION_VP_S2B_CFG_ITB_SEL_RSTVAL);
    end else if (load_s2b_cfg_itb_sel == 1'b1) begin
      rff_s2b_cfg_itb_sel <= orv64_itb_sel_t'((wmask & s2b_cfg_itb_sel) | (wmask_inv & rff_s2b_cfg_itb_sel));
    end
  end
  assign out_s2b_cfg_itb_sel = rff_s2b_cfg_itb_sel;
  orv64_itb_addr_t rff_b2s_itb_last_ptr;
  orv64_itb_addr_t b2s_itb_last_ptr;
  logic load_b2s_itb_last_ptr;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_itb_last_ptr <= orv64_itb_addr_t'(STATION_VP_B2S_ITB_LAST_PTR_RSTVAL);
    end else if (load_b2s_itb_last_ptr == 1'b1) begin
      rff_b2s_itb_last_ptr <= orv64_itb_addr_t'((wmask & b2s_itb_last_ptr) | (wmask_inv & rff_b2s_itb_last_ptr));
    end else if (vld_in_b2s_itb_last_ptr == 1'b1) begin
      rff_b2s_itb_last_ptr <= in_b2s_itb_last_ptr;
    end
  end
  assign out_b2s_itb_last_ptr = rff_b2s_itb_last_ptr;
  orv64_vaddr_t rff_s2b_bp_if_pc_0;
  orv64_vaddr_t s2b_bp_if_pc_0;
  logic load_s2b_bp_if_pc_0;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_0 <= orv64_vaddr_t'(STATION_VP_S2B_BP_IF_PC_0_RSTVAL);
    end else if (load_s2b_bp_if_pc_0 == 1'b1) begin
      rff_s2b_bp_if_pc_0 <= orv64_vaddr_t'((wmask & s2b_bp_if_pc_0) | (wmask_inv & rff_s2b_bp_if_pc_0));
    end
  end
  assign out_s2b_bp_if_pc_0 = rff_s2b_bp_if_pc_0;
  orv64_vaddr_t rff_s2b_bp_if_pc_1;
  orv64_vaddr_t s2b_bp_if_pc_1;
  logic load_s2b_bp_if_pc_1;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_1 <= orv64_vaddr_t'(STATION_VP_S2B_BP_IF_PC_1_RSTVAL);
    end else if (load_s2b_bp_if_pc_1 == 1'b1) begin
      rff_s2b_bp_if_pc_1 <= orv64_vaddr_t'((wmask & s2b_bp_if_pc_1) | (wmask_inv & rff_s2b_bp_if_pc_1));
    end
  end
  assign out_s2b_bp_if_pc_1 = rff_s2b_bp_if_pc_1;
  orv64_vaddr_t rff_s2b_bp_if_pc_2;
  orv64_vaddr_t s2b_bp_if_pc_2;
  logic load_s2b_bp_if_pc_2;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_2 <= orv64_vaddr_t'(STATION_VP_S2B_BP_IF_PC_2_RSTVAL);
    end else if (load_s2b_bp_if_pc_2 == 1'b1) begin
      rff_s2b_bp_if_pc_2 <= orv64_vaddr_t'((wmask & s2b_bp_if_pc_2) | (wmask_inv & rff_s2b_bp_if_pc_2));
    end
  end
  assign out_s2b_bp_if_pc_2 = rff_s2b_bp_if_pc_2;
  orv64_vaddr_t rff_s2b_bp_if_pc_3;
  orv64_vaddr_t s2b_bp_if_pc_3;
  logic load_s2b_bp_if_pc_3;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_if_pc_3 <= orv64_vaddr_t'(STATION_VP_S2B_BP_IF_PC_3_RSTVAL);
    end else if (load_s2b_bp_if_pc_3 == 1'b1) begin
      rff_s2b_bp_if_pc_3 <= orv64_vaddr_t'((wmask & s2b_bp_if_pc_3) | (wmask_inv & rff_s2b_bp_if_pc_3));
    end
  end
  assign out_s2b_bp_if_pc_3 = rff_s2b_bp_if_pc_3;
  orv64_vaddr_t rff_s2b_bp_wb_pc_0;
  orv64_vaddr_t s2b_bp_wb_pc_0;
  logic load_s2b_bp_wb_pc_0;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_0 <= orv64_vaddr_t'(STATION_VP_S2B_BP_WB_PC_0_RSTVAL);
    end else if (load_s2b_bp_wb_pc_0 == 1'b1) begin
      rff_s2b_bp_wb_pc_0 <= orv64_vaddr_t'((wmask & s2b_bp_wb_pc_0) | (wmask_inv & rff_s2b_bp_wb_pc_0));
    end
  end
  assign out_s2b_bp_wb_pc_0 = rff_s2b_bp_wb_pc_0;
  orv64_vaddr_t rff_s2b_bp_wb_pc_1;
  orv64_vaddr_t s2b_bp_wb_pc_1;
  logic load_s2b_bp_wb_pc_1;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_1 <= orv64_vaddr_t'(STATION_VP_S2B_BP_WB_PC_1_RSTVAL);
    end else if (load_s2b_bp_wb_pc_1 == 1'b1) begin
      rff_s2b_bp_wb_pc_1 <= orv64_vaddr_t'((wmask & s2b_bp_wb_pc_1) | (wmask_inv & rff_s2b_bp_wb_pc_1));
    end
  end
  assign out_s2b_bp_wb_pc_1 = rff_s2b_bp_wb_pc_1;
  orv64_vaddr_t rff_s2b_bp_wb_pc_2;
  orv64_vaddr_t s2b_bp_wb_pc_2;
  logic load_s2b_bp_wb_pc_2;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_2 <= orv64_vaddr_t'(STATION_VP_S2B_BP_WB_PC_2_RSTVAL);
    end else if (load_s2b_bp_wb_pc_2 == 1'b1) begin
      rff_s2b_bp_wb_pc_2 <= orv64_vaddr_t'((wmask & s2b_bp_wb_pc_2) | (wmask_inv & rff_s2b_bp_wb_pc_2));
    end
  end
  assign out_s2b_bp_wb_pc_2 = rff_s2b_bp_wb_pc_2;
  orv64_vaddr_t rff_s2b_bp_wb_pc_3;
  orv64_vaddr_t s2b_bp_wb_pc_3;
  logic load_s2b_bp_wb_pc_3;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_wb_pc_3 <= orv64_vaddr_t'(STATION_VP_S2B_BP_WB_PC_3_RSTVAL);
    end else if (load_s2b_bp_wb_pc_3 == 1'b1) begin
      rff_s2b_bp_wb_pc_3 <= orv64_vaddr_t'((wmask & s2b_bp_wb_pc_3) | (wmask_inv & rff_s2b_bp_wb_pc_3));
    end
  end
  assign out_s2b_bp_wb_pc_3 = rff_s2b_bp_wb_pc_3;
  orv64_data_t rff_s2b_bp_instret;
  orv64_data_t s2b_bp_instret;
  logic load_s2b_bp_instret;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_bp_instret <= orv64_data_t'(STATION_VP_S2B_BP_INSTRET_RSTVAL);
    end else if (load_s2b_bp_instret == 1'b1) begin
      rff_s2b_bp_instret <= orv64_data_t'((wmask & s2b_bp_instret) | (wmask_inv & rff_s2b_bp_instret));
    end
  end
  assign out_s2b_bp_instret = rff_s2b_bp_instret;
  orv_vcore_icg_disable_t rff_s2b_vcore_icg_disable;
  orv_vcore_icg_disable_t s2b_vcore_icg_disable;
  logic load_s2b_vcore_icg_disable;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_vcore_icg_disable <= orv_vcore_icg_disable_t'(STATION_VP_S2B_VCORE_ICG_DISABLE_RSTVAL);
    end else if (load_s2b_vcore_icg_disable == 1'b1) begin
      rff_s2b_vcore_icg_disable <= orv_vcore_icg_disable_t'((wmask & s2b_vcore_icg_disable) | (wmask_inv & rff_s2b_vcore_icg_disable));
    end
  end
  assign out_s2b_vcore_icg_disable = rff_s2b_vcore_icg_disable;
  vcore_pmu_evt_mask_t rff_s2b_vcore_pmu_evt_mask;
  vcore_pmu_evt_mask_t s2b_vcore_pmu_evt_mask;
  logic load_s2b_vcore_pmu_evt_mask;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_vcore_pmu_evt_mask <= vcore_pmu_evt_mask_t'(STATION_VP_S2B_VCORE_PMU_EVT_MASK_RSTVAL);
    end else if (load_s2b_vcore_pmu_evt_mask == 1'b1) begin
      rff_s2b_vcore_pmu_evt_mask <= vcore_pmu_evt_mask_t'((wmask & s2b_vcore_pmu_evt_mask) | (wmask_inv & rff_s2b_vcore_pmu_evt_mask));
    end
  end
  assign out_s2b_vcore_pmu_evt_mask = rff_s2b_vcore_pmu_evt_mask;
  powerline_ctrl_t rff_s2b_powerline_ctrl;
  powerline_ctrl_t s2b_powerline_ctrl;
  logic load_s2b_powerline_ctrl;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_powerline_ctrl <= powerline_ctrl_t'(STATION_VP_S2B_POWERLINE_CTRL_RSTVAL);
    end else if (load_s2b_powerline_ctrl == 1'b1) begin
      rff_s2b_powerline_ctrl <= powerline_ctrl_t'((wmask & s2b_powerline_ctrl) | (wmask_inv & rff_s2b_powerline_ctrl));
    end
  end
  assign out_s2b_powerline_ctrl = rff_s2b_powerline_ctrl;
  logic [STATION_VP_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0] rff_s2b_cfg_lfsr_seed;
  logic [STATION_VP_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0] s2b_cfg_lfsr_seed;
  logic load_s2b_cfg_lfsr_seed;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_lfsr_seed <= STATION_VP_S2B_CFG_LFSR_SEED_RSTVAL;
    end else if (load_s2b_cfg_lfsr_seed == 1'b1) begin
      rff_s2b_cfg_lfsr_seed <= (wmask & s2b_cfg_lfsr_seed) | (wmask_inv & rff_s2b_cfg_lfsr_seed);
    end
  end
  assign out_s2b_cfg_lfsr_seed = rff_s2b_cfg_lfsr_seed;
  powervbank_ctrl_t rff_s2b_powervbank_ctrl;
  powervbank_ctrl_t s2b_powervbank_ctrl;
  logic load_s2b_powervbank_ctrl;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_powervbank_ctrl <= powervbank_ctrl_t'(STATION_VP_S2B_POWERVBANK_CTRL_RSTVAL);
    end else if (load_s2b_powervbank_ctrl == 1'b1) begin
      rff_s2b_powervbank_ctrl <= powervbank_ctrl_t'((wmask & s2b_powervbank_ctrl) | (wmask_inv & rff_s2b_powervbank_ctrl));
    end
  end
  assign out_s2b_powervbank_ctrl = rff_s2b_powervbank_ctrl;
  logic [STATION_VP_S2B_EARLY_RSTN_WIDTH - 1 : 0] rff_s2b_early_rstn;
  logic [STATION_VP_S2B_EARLY_RSTN_WIDTH - 1 : 0] s2b_early_rstn;
  logic load_s2b_early_rstn;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_early_rstn <= STATION_VP_S2B_EARLY_RSTN_RSTVAL;
    end else if (load_s2b_early_rstn == 1'b1) begin
      rff_s2b_early_rstn <= (wmask & s2b_early_rstn) | (wmask_inv & rff_s2b_early_rstn);
    end
  end
  assign out_s2b_early_rstn = rff_s2b_early_rstn;
  logic [STATION_VP_S2B_RSTN_WIDTH - 1 : 0] rff_s2b_rstn;
  logic [STATION_VP_S2B_RSTN_WIDTH - 1 : 0] s2b_rstn;
  logic load_s2b_rstn;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_rstn <= STATION_VP_S2B_RSTN_RSTVAL;
    end else if (load_s2b_rstn == 1'b1) begin
      rff_s2b_rstn <= (wmask & s2b_rstn) | (wmask_inv & rff_s2b_rstn);
    end
  end
  assign out_s2b_rstn = rff_s2b_rstn;
  logic [STATION_VP_S2B_EXT_EVENT_WIDTH - 1 : 0] rff_s2b_ext_event;
  logic [STATION_VP_S2B_EXT_EVENT_WIDTH - 1 : 0] s2b_ext_event;
  logic load_s2b_ext_event;
  logic dff_load_s2b_ext_event_d;
  always_ff @(posedge clk) begin
    dff_load_s2b_ext_event_d <= load_s2b_ext_event;
  end
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ext_event <= STATION_VP_S2B_EXT_EVENT_RSTVAL;
    end else if (load_s2b_ext_event == 1'b1) begin
      rff_s2b_ext_event <= (wmask & s2b_ext_event) | (wmask_inv & rff_s2b_ext_event);
    end else if (dff_load_s2b_ext_event_d == 1'b1) begin
      rff_s2b_ext_event <= STATION_VP_S2B_EXT_EVENT_RSTVAL;
    end
  end
  assign out_s2b_ext_event = rff_s2b_ext_event;
  logic [STATION_VP_S2B_DEBUG_STALL_WIDTH - 1 : 0] rff_s2b_debug_stall;
  logic [STATION_VP_S2B_DEBUG_STALL_WIDTH - 1 : 0] s2b_debug_stall;
  logic load_s2b_debug_stall;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_debug_stall <= STATION_VP_S2B_DEBUG_STALL_RSTVAL;
    end else if (load_s2b_debug_stall == 1'b1) begin
      rff_s2b_debug_stall <= (wmask & s2b_debug_stall) | (wmask_inv & rff_s2b_debug_stall);
    end
  end
  assign out_s2b_debug_stall = rff_s2b_debug_stall;
  logic [STATION_VP_B2S_DEBUG_STALL_OUT_WIDTH - 1 : 0] rff_b2s_debug_stall_out;
  logic [STATION_VP_B2S_DEBUG_STALL_OUT_WIDTH - 1 : 0] b2s_debug_stall_out;
  logic load_b2s_debug_stall_out;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_debug_stall_out <= STATION_VP_B2S_DEBUG_STALL_OUT_RSTVAL;
    end else if (load_b2s_debug_stall_out == 1'b1) begin
      rff_b2s_debug_stall_out <= (wmask & b2s_debug_stall_out) | (wmask_inv & rff_b2s_debug_stall_out);
    end else if (vld_in_b2s_debug_stall_out == 1'b1) begin
      rff_b2s_debug_stall_out <= in_b2s_debug_stall_out;
    end
  end
  assign out_b2s_debug_stall_out = rff_b2s_debug_stall_out;
  logic [STATION_VP_S2B_DEBUG_RESUME_WIDTH - 1 : 0] rff_s2b_debug_resume;
  logic [STATION_VP_S2B_DEBUG_RESUME_WIDTH - 1 : 0] s2b_debug_resume;
  logic load_s2b_debug_resume;
  logic dff_load_s2b_debug_resume_d;
  always_ff @(posedge clk) begin
    dff_load_s2b_debug_resume_d <= load_s2b_debug_resume;
  end
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_debug_resume <= STATION_VP_S2B_DEBUG_RESUME_RSTVAL;
    end else if (load_s2b_debug_resume == 1'b1) begin
      rff_s2b_debug_resume <= (wmask & s2b_debug_resume) | (wmask_inv & rff_s2b_debug_resume);
    end else if (dff_load_s2b_debug_resume_d == 1'b1) begin
      rff_s2b_debug_resume <= STATION_VP_S2B_DEBUG_RESUME_RSTVAL;
    end
  end
  assign out_s2b_debug_resume = rff_s2b_debug_resume;
  logic [STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_WIDTH - 1 : 0] rff_b2s_vload_drt_req_vlen_illegal;
  logic [STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_WIDTH - 1 : 0] b2s_vload_drt_req_vlen_illegal;
  logic load_b2s_vload_drt_req_vlen_illegal;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_vload_drt_req_vlen_illegal <= STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_RSTVAL;
    end else if (load_b2s_vload_drt_req_vlen_illegal == 1'b1) begin
      rff_b2s_vload_drt_req_vlen_illegal <= (wmask & b2s_vload_drt_req_vlen_illegal) | (wmask_inv & rff_b2s_vload_drt_req_vlen_illegal);
    end else if (vld_in_b2s_vload_drt_req_vlen_illegal == 1'b1) begin
      rff_b2s_vload_drt_req_vlen_illegal <= in_b2s_vload_drt_req_vlen_illegal;
    end
  end
  assign out_b2s_vload_drt_req_vlen_illegal = rff_b2s_vload_drt_req_vlen_illegal;
  logic [STATION_VP_S2B_CFG_EN_HPMCOUNTER_WIDTH - 1 : 0] rff_s2b_cfg_en_hpmcounter;
  logic [STATION_VP_S2B_CFG_EN_HPMCOUNTER_WIDTH - 1 : 0] s2b_cfg_en_hpmcounter;
  logic load_s2b_cfg_en_hpmcounter;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_en_hpmcounter <= STATION_VP_S2B_CFG_EN_HPMCOUNTER_RSTVAL;
    end else if (load_s2b_cfg_en_hpmcounter == 1'b1) begin
      rff_s2b_cfg_en_hpmcounter <= (wmask & s2b_cfg_en_hpmcounter) | (wmask_inv & rff_s2b_cfg_en_hpmcounter);
    end
  end
  assign out_s2b_cfg_en_hpmcounter = rff_s2b_cfg_en_hpmcounter;
  logic [STATION_VP_S2B_CFG_PWR_ON_WIDTH - 1 : 0] rff_s2b_cfg_pwr_on;
  logic [STATION_VP_S2B_CFG_PWR_ON_WIDTH - 1 : 0] s2b_cfg_pwr_on;
  logic load_s2b_cfg_pwr_on;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_pwr_on <= STATION_VP_S2B_CFG_PWR_ON_RSTVAL;
    end else if (load_s2b_cfg_pwr_on == 1'b1) begin
      rff_s2b_cfg_pwr_on <= (wmask & s2b_cfg_pwr_on) | (wmask_inv & rff_s2b_cfg_pwr_on);
    end
  end
  assign out_s2b_cfg_pwr_on = rff_s2b_cfg_pwr_on;
  logic [STATION_VP_S2B_CFG_SLEEP_WIDTH - 1 : 0] rff_s2b_cfg_sleep;
  logic [STATION_VP_S2B_CFG_SLEEP_WIDTH - 1 : 0] s2b_cfg_sleep;
  logic load_s2b_cfg_sleep;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_sleep <= STATION_VP_S2B_CFG_SLEEP_RSTVAL;
    end else if (load_s2b_cfg_sleep == 1'b1) begin
      rff_s2b_cfg_sleep <= (wmask & s2b_cfg_sleep) | (wmask_inv & rff_s2b_cfg_sleep);
    end
  end
  assign out_s2b_cfg_sleep = rff_s2b_cfg_sleep;
  logic [STATION_VP_S2B_CFG_BYPASS_IC_WIDTH - 1 : 0] rff_s2b_cfg_bypass_ic;
  logic [STATION_VP_S2B_CFG_BYPASS_IC_WIDTH - 1 : 0] s2b_cfg_bypass_ic;
  logic load_s2b_cfg_bypass_ic;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_bypass_ic <= STATION_VP_S2B_CFG_BYPASS_IC_RSTVAL;
    end else if (load_s2b_cfg_bypass_ic == 1'b1) begin
      rff_s2b_cfg_bypass_ic <= (wmask & s2b_cfg_bypass_ic) | (wmask_inv & rff_s2b_cfg_bypass_ic);
    end
  end
  assign out_s2b_cfg_bypass_ic = rff_s2b_cfg_bypass_ic;
  logic [STATION_VP_S2B_CFG_BYPASS_TLB_WIDTH - 1 : 0] rff_s2b_cfg_bypass_tlb;
  logic [STATION_VP_S2B_CFG_BYPASS_TLB_WIDTH - 1 : 0] s2b_cfg_bypass_tlb;
  logic load_s2b_cfg_bypass_tlb;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_bypass_tlb <= STATION_VP_S2B_CFG_BYPASS_TLB_RSTVAL;
    end else if (load_s2b_cfg_bypass_tlb == 1'b1) begin
      rff_s2b_cfg_bypass_tlb <= (wmask & s2b_cfg_bypass_tlb) | (wmask_inv & rff_s2b_cfg_bypass_tlb);
    end
  end
  assign out_s2b_cfg_bypass_tlb = rff_s2b_cfg_bypass_tlb;
  logic [STATION_VP_S2ICG_CLK_EN_WIDTH - 1 : 0] rff_s2icg_clk_en;
  logic [STATION_VP_S2ICG_CLK_EN_WIDTH - 1 : 0] s2icg_clk_en;
  logic load_s2icg_clk_en;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2icg_clk_en <= STATION_VP_S2ICG_CLK_EN_RSTVAL;
    end else if (load_s2icg_clk_en == 1'b1) begin
      rff_s2icg_clk_en <= (wmask & s2icg_clk_en) | (wmask_inv & rff_s2icg_clk_en);
    end
  end
  assign out_s2icg_clk_en = rff_s2icg_clk_en;
  logic [STATION_VP_B2S_IS_VTLB_EXCP_WIDTH - 1 : 0] rff_b2s_is_vtlb_excp;
  logic [STATION_VP_B2S_IS_VTLB_EXCP_WIDTH - 1 : 0] b2s_is_vtlb_excp;
  logic load_b2s_is_vtlb_excp;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_is_vtlb_excp <= STATION_VP_B2S_IS_VTLB_EXCP_RSTVAL;
    end else if (load_b2s_is_vtlb_excp == 1'b1) begin
      rff_b2s_is_vtlb_excp <= (wmask & b2s_is_vtlb_excp) | (wmask_inv & rff_b2s_is_vtlb_excp);
    end else if (vld_in_b2s_is_vtlb_excp == 1'b1) begin
      rff_b2s_is_vtlb_excp <= in_b2s_is_vtlb_excp;
    end
  end
  assign out_b2s_is_vtlb_excp = rff_b2s_is_vtlb_excp;
  logic [STATION_VP_S2B_CFG_ITB_EN_WIDTH - 1 : 0] rff_s2b_cfg_itb_en;
  logic [STATION_VP_S2B_CFG_ITB_EN_WIDTH - 1 : 0] s2b_cfg_itb_en;
  logic load_s2b_cfg_itb_en;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_itb_en <= STATION_VP_S2B_CFG_ITB_EN_RSTVAL;
    end else if (load_s2b_cfg_itb_en == 1'b1) begin
      rff_s2b_cfg_itb_en <= (wmask & s2b_cfg_itb_en) | (wmask_inv & rff_s2b_cfg_itb_en);
    end
  end
  assign out_s2b_cfg_itb_en = rff_s2b_cfg_itb_en;
  logic [STATION_VP_S2B_CFG_ITB_WRAP_AROUND_WIDTH - 1 : 0] rff_s2b_cfg_itb_wrap_around;
  logic [STATION_VP_S2B_CFG_ITB_WRAP_AROUND_WIDTH - 1 : 0] s2b_cfg_itb_wrap_around;
  logic load_s2b_cfg_itb_wrap_around;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cfg_itb_wrap_around <= STATION_VP_S2B_CFG_ITB_WRAP_AROUND_RSTVAL;
    end else if (load_s2b_cfg_itb_wrap_around == 1'b1) begin
      rff_s2b_cfg_itb_wrap_around <= (wmask & s2b_cfg_itb_wrap_around) | (wmask_inv & rff_s2b_cfg_itb_wrap_around);
    end
  end
  assign out_s2b_cfg_itb_wrap_around = rff_s2b_cfg_itb_wrap_around;
  logic [STATION_VP_S2B_EN_BP_IF_PC_0_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_0;
  logic [STATION_VP_S2B_EN_BP_IF_PC_0_WIDTH - 1 : 0] s2b_en_bp_if_pc_0;
  logic load_s2b_en_bp_if_pc_0;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_0 <= STATION_VP_S2B_EN_BP_IF_PC_0_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_0 == 1'b1) begin
      rff_s2b_en_bp_if_pc_0 <= (wmask & s2b_en_bp_if_pc_0) | (wmask_inv & rff_s2b_en_bp_if_pc_0);
    end
  end
  assign out_s2b_en_bp_if_pc_0 = rff_s2b_en_bp_if_pc_0;
  logic [STATION_VP_S2B_EN_BP_IF_PC_1_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_1;
  logic [STATION_VP_S2B_EN_BP_IF_PC_1_WIDTH - 1 : 0] s2b_en_bp_if_pc_1;
  logic load_s2b_en_bp_if_pc_1;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_1 <= STATION_VP_S2B_EN_BP_IF_PC_1_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_1 == 1'b1) begin
      rff_s2b_en_bp_if_pc_1 <= (wmask & s2b_en_bp_if_pc_1) | (wmask_inv & rff_s2b_en_bp_if_pc_1);
    end
  end
  assign out_s2b_en_bp_if_pc_1 = rff_s2b_en_bp_if_pc_1;
  logic [STATION_VP_S2B_EN_BP_IF_PC_2_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_2;
  logic [STATION_VP_S2B_EN_BP_IF_PC_2_WIDTH - 1 : 0] s2b_en_bp_if_pc_2;
  logic load_s2b_en_bp_if_pc_2;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_2 <= STATION_VP_S2B_EN_BP_IF_PC_2_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_2 == 1'b1) begin
      rff_s2b_en_bp_if_pc_2 <= (wmask & s2b_en_bp_if_pc_2) | (wmask_inv & rff_s2b_en_bp_if_pc_2);
    end
  end
  assign out_s2b_en_bp_if_pc_2 = rff_s2b_en_bp_if_pc_2;
  logic [STATION_VP_S2B_EN_BP_IF_PC_3_WIDTH - 1 : 0] rff_s2b_en_bp_if_pc_3;
  logic [STATION_VP_S2B_EN_BP_IF_PC_3_WIDTH - 1 : 0] s2b_en_bp_if_pc_3;
  logic load_s2b_en_bp_if_pc_3;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_if_pc_3 <= STATION_VP_S2B_EN_BP_IF_PC_3_RSTVAL;
    end else if (load_s2b_en_bp_if_pc_3 == 1'b1) begin
      rff_s2b_en_bp_if_pc_3 <= (wmask & s2b_en_bp_if_pc_3) | (wmask_inv & rff_s2b_en_bp_if_pc_3);
    end
  end
  assign out_s2b_en_bp_if_pc_3 = rff_s2b_en_bp_if_pc_3;
  logic [STATION_VP_S2B_EN_BP_WB_PC_0_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_0;
  logic [STATION_VP_S2B_EN_BP_WB_PC_0_WIDTH - 1 : 0] s2b_en_bp_wb_pc_0;
  logic load_s2b_en_bp_wb_pc_0;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_0 <= STATION_VP_S2B_EN_BP_WB_PC_0_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_0 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_0 <= (wmask & s2b_en_bp_wb_pc_0) | (wmask_inv & rff_s2b_en_bp_wb_pc_0);
    end
  end
  assign out_s2b_en_bp_wb_pc_0 = rff_s2b_en_bp_wb_pc_0;
  logic [STATION_VP_S2B_EN_BP_WB_PC_1_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_1;
  logic [STATION_VP_S2B_EN_BP_WB_PC_1_WIDTH - 1 : 0] s2b_en_bp_wb_pc_1;
  logic load_s2b_en_bp_wb_pc_1;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_1 <= STATION_VP_S2B_EN_BP_WB_PC_1_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_1 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_1 <= (wmask & s2b_en_bp_wb_pc_1) | (wmask_inv & rff_s2b_en_bp_wb_pc_1);
    end
  end
  assign out_s2b_en_bp_wb_pc_1 = rff_s2b_en_bp_wb_pc_1;
  logic [STATION_VP_S2B_EN_BP_WB_PC_2_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_2;
  logic [STATION_VP_S2B_EN_BP_WB_PC_2_WIDTH - 1 : 0] s2b_en_bp_wb_pc_2;
  logic load_s2b_en_bp_wb_pc_2;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_2 <= STATION_VP_S2B_EN_BP_WB_PC_2_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_2 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_2 <= (wmask & s2b_en_bp_wb_pc_2) | (wmask_inv & rff_s2b_en_bp_wb_pc_2);
    end
  end
  assign out_s2b_en_bp_wb_pc_2 = rff_s2b_en_bp_wb_pc_2;
  logic [STATION_VP_S2B_EN_BP_WB_PC_3_WIDTH - 1 : 0] rff_s2b_en_bp_wb_pc_3;
  logic [STATION_VP_S2B_EN_BP_WB_PC_3_WIDTH - 1 : 0] s2b_en_bp_wb_pc_3;
  logic load_s2b_en_bp_wb_pc_3;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_wb_pc_3 <= STATION_VP_S2B_EN_BP_WB_PC_3_RSTVAL;
    end else if (load_s2b_en_bp_wb_pc_3 == 1'b1) begin
      rff_s2b_en_bp_wb_pc_3 <= (wmask & s2b_en_bp_wb_pc_3) | (wmask_inv & rff_s2b_en_bp_wb_pc_3);
    end
  end
  assign out_s2b_en_bp_wb_pc_3 = rff_s2b_en_bp_wb_pc_3;
  logic [STATION_VP_S2B_EN_BP_INSTRET_WIDTH - 1 : 0] rff_s2b_en_bp_instret;
  logic [STATION_VP_S2B_EN_BP_INSTRET_WIDTH - 1 : 0] s2b_en_bp_instret;
  logic load_s2b_en_bp_instret;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_en_bp_instret <= STATION_VP_S2B_EN_BP_INSTRET_RSTVAL;
    end else if (load_s2b_en_bp_instret == 1'b1) begin
      rff_s2b_en_bp_instret <= (wmask & s2b_en_bp_instret) | (wmask_inv & rff_s2b_en_bp_instret);
    end
  end
  assign out_s2b_en_bp_instret = rff_s2b_en_bp_instret;
  logic [STATION_VP_S2B_VCORE_EN_WIDTH - 1 : 0] rff_s2b_vcore_en;
  logic [STATION_VP_S2B_VCORE_EN_WIDTH - 1 : 0] s2b_vcore_en;
  logic load_s2b_vcore_en;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_vcore_en <= STATION_VP_S2B_VCORE_EN_RSTVAL;
    end else if (load_s2b_vcore_en == 1'b1) begin
      rff_s2b_vcore_en <= (wmask & s2b_vcore_en) | (wmask_inv & rff_s2b_vcore_en);
    end
  end
  assign out_s2b_vcore_en = rff_s2b_vcore_en;
  logic [STATION_VP_S2B_VCORE_PMU_EN_WIDTH - 1 : 0] rff_s2b_vcore_pmu_en;
  logic [STATION_VP_S2B_VCORE_PMU_EN_WIDTH - 1 : 0] s2b_vcore_pmu_en;
  logic load_s2b_vcore_pmu_en;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_vcore_pmu_en <= STATION_VP_S2B_VCORE_PMU_EN_RSTVAL;
    end else if (load_s2b_vcore_pmu_en == 1'b1) begin
      rff_s2b_vcore_pmu_en <= (wmask & s2b_vcore_pmu_en) | (wmask_inv & rff_s2b_vcore_pmu_en);
    end
  end
  assign out_s2b_vcore_pmu_en = rff_s2b_vcore_pmu_en;
  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_VP_DATA_WIDTH - 1 : 0] data;
  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_VP_DATA_WIDTH{1'b0}};
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
    s2b_bp_instret = rff_s2b_bp_instret;
    load_s2b_bp_instret = 1'b0;
    s2b_vcore_icg_disable = rff_s2b_vcore_icg_disable;
    load_s2b_vcore_icg_disable = 1'b0;
    s2b_vcore_pmu_evt_mask = rff_s2b_vcore_pmu_evt_mask;
    load_s2b_vcore_pmu_evt_mask = 1'b0;
    s2b_powerline_ctrl = rff_s2b_powerline_ctrl;
    load_s2b_powerline_ctrl = 1'b0;
    s2b_cfg_lfsr_seed = rff_s2b_cfg_lfsr_seed;
    load_s2b_cfg_lfsr_seed = 1'b0;
    s2b_powervbank_ctrl = rff_s2b_powervbank_ctrl;
    load_s2b_powervbank_ctrl = 1'b0;
    s2b_early_rstn = rff_s2b_early_rstn;
    load_s2b_early_rstn = 1'b0;
    s2b_rstn = rff_s2b_rstn;
    load_s2b_rstn = 1'b0;
    s2b_ext_event = rff_s2b_ext_event;
    load_s2b_ext_event = 1'b0;
    s2b_debug_stall = rff_s2b_debug_stall;
    load_s2b_debug_stall = 1'b0;
    b2s_debug_stall_out = rff_b2s_debug_stall_out;
    load_b2s_debug_stall_out = 1'b0;
    s2b_debug_resume = rff_s2b_debug_resume;
    load_s2b_debug_resume = 1'b0;
    b2s_vload_drt_req_vlen_illegal = rff_b2s_vload_drt_req_vlen_illegal;
    load_b2s_vload_drt_req_vlen_illegal = 1'b0;
    s2b_cfg_en_hpmcounter = rff_s2b_cfg_en_hpmcounter;
    load_s2b_cfg_en_hpmcounter = 1'b0;
    s2b_cfg_pwr_on = rff_s2b_cfg_pwr_on;
    load_s2b_cfg_pwr_on = 1'b0;
    s2b_cfg_sleep = rff_s2b_cfg_sleep;
    load_s2b_cfg_sleep = 1'b0;
    s2b_cfg_bypass_ic = rff_s2b_cfg_bypass_ic;
    load_s2b_cfg_bypass_ic = 1'b0;
    s2b_cfg_bypass_tlb = rff_s2b_cfg_bypass_tlb;
    load_s2b_cfg_bypass_tlb = 1'b0;
    s2icg_clk_en = rff_s2icg_clk_en;
    load_s2icg_clk_en = 1'b0;
    b2s_is_vtlb_excp = rff_b2s_is_vtlb_excp;
    load_b2s_is_vtlb_excp = 1'b0;
    s2b_cfg_itb_en = rff_s2b_cfg_itb_en;
    load_s2b_cfg_itb_en = 1'b0;
    s2b_cfg_itb_wrap_around = rff_s2b_cfg_itb_wrap_around;
    load_s2b_cfg_itb_wrap_around = 1'b0;
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
    s2b_en_bp_instret = rff_s2b_en_bp_instret;
    load_s2b_en_bp_instret = 1'b0;
    s2b_vcore_en = rff_s2b_vcore_en;
    load_s2b_vcore_en = 1'b0;
    s2b_vcore_pmu_en = rff_s2b_vcore_pmu_en;
    load_s2b_vcore_pmu_en = 1'b0;
    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_RST_PC_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_rst_pc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_ITB_SEL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_itb_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_ITB_LAST_PTR_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_b2s_itb_last_ptr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_if_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_wb_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_INSTRET_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_bp_instret;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_ICG_DISABLE_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_vcore_icg_disable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_PMU_EVT_MASK_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_vcore_pmu_evt_mask;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_POWERLINE_CTRL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_powerline_ctrl;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_LFSR_SEED_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_lfsr_seed;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_POWERVBANK_CTRL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_powervbank_ctrl;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EARLY_RSTN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_early_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_RSTN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EXT_EVENT_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ext_event;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_DEBUG_STALL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_debug_stall;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_DEBUG_STALL_OUT_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_b2s_debug_stall_out;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_DEBUG_RESUME_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_debug_resume;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_b2s_vload_drt_req_vlen_illegal;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_EN_HPMCOUNTER_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_en_hpmcounter;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_PWR_ON_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_pwr_on;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_SLEEP_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_sleep;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_BYPASS_IC_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_bypass_ic;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_BYPASS_TLB_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_bypass_tlb;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2icg_clk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_IS_VTLB_EXCP_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_b2s_is_vtlb_excp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_ITB_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_itb_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_ITB_WRAP_AROUND_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cfg_itb_wrap_around;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_if_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_wb_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_INSTRET_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_en_bp_instret;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_vcore_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_PMU_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          data = rff_s2b_vcore_pmu_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_VP_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_RST_PC_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_rst_pc = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_CFG_RST_PC_WIDTH - 1 : 0]);
          load_s2b_cfg_rst_pc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_ITB_SEL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_itb_sel = orv64_itb_sel_t'(station2brb_req_w.wdata[STATION_VP_S2B_CFG_ITB_SEL_WIDTH - 1 : 0]);
          load_s2b_cfg_itb_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_ITB_LAST_PTR_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          b2s_itb_last_ptr = orv64_itb_addr_t'(station2brb_req_w.wdata[STATION_VP_B2S_ITB_LAST_PTR_WIDTH - 1 : 0]);
          load_b2s_itb_last_ptr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_0 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_IF_PC_0_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_1 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_IF_PC_1_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_2 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_IF_PC_2_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_IF_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_if_pc_3 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_IF_PC_3_WIDTH - 1 : 0]);
          load_s2b_bp_if_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_0 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_WB_PC_0_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_1 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_WB_PC_1_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_2 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_WB_PC_2_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_WB_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_wb_pc_3 = orv64_vaddr_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_WB_PC_3_WIDTH - 1 : 0]);
          load_s2b_bp_wb_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_BP_INSTRET_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_bp_instret = orv64_data_t'(station2brb_req_w.wdata[STATION_VP_S2B_BP_INSTRET_WIDTH - 1 : 0]);
          load_s2b_bp_instret = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_ICG_DISABLE_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_vcore_icg_disable = orv_vcore_icg_disable_t'(station2brb_req_w.wdata[STATION_VP_S2B_VCORE_ICG_DISABLE_WIDTH - 1 : 0]);
          load_s2b_vcore_icg_disable = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_PMU_EVT_MASK_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_vcore_pmu_evt_mask = vcore_pmu_evt_mask_t'(station2brb_req_w.wdata[STATION_VP_S2B_VCORE_PMU_EVT_MASK_WIDTH - 1 : 0]);
          load_s2b_vcore_pmu_evt_mask = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_POWERLINE_CTRL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_powerline_ctrl = powerline_ctrl_t'(station2brb_req_w.wdata[STATION_VP_S2B_POWERLINE_CTRL_WIDTH - 1 : 0]);
          load_s2b_powerline_ctrl = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_LFSR_SEED_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_lfsr_seed = station2brb_req_w.wdata[STATION_VP_S2B_CFG_LFSR_SEED_WIDTH - 1 : 0];
          load_s2b_cfg_lfsr_seed = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_POWERVBANK_CTRL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_powervbank_ctrl = powervbank_ctrl_t'(station2brb_req_w.wdata[STATION_VP_S2B_POWERVBANK_CTRL_WIDTH - 1 : 0]);
          load_s2b_powervbank_ctrl = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EARLY_RSTN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_early_rstn = station2brb_req_w.wdata[STATION_VP_S2B_EARLY_RSTN_WIDTH - 1 : 0];
          load_s2b_early_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_RSTN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_rstn = station2brb_req_w.wdata[STATION_VP_S2B_RSTN_WIDTH - 1 : 0];
          load_s2b_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EXT_EVENT_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_ext_event = station2brb_req_w.wdata[STATION_VP_S2B_EXT_EVENT_WIDTH - 1 : 0];
          load_s2b_ext_event = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_DEBUG_STALL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_debug_stall = station2brb_req_w.wdata[STATION_VP_S2B_DEBUG_STALL_WIDTH - 1 : 0];
          load_s2b_debug_stall = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_DEBUG_STALL_OUT_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          b2s_debug_stall_out = station2brb_req_w.wdata[STATION_VP_B2S_DEBUG_STALL_OUT_WIDTH - 1 : 0];
          load_b2s_debug_stall_out = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_DEBUG_RESUME_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_debug_resume = station2brb_req_w.wdata[STATION_VP_S2B_DEBUG_RESUME_WIDTH - 1 : 0];
          load_s2b_debug_resume = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          b2s_vload_drt_req_vlen_illegal = station2brb_req_w.wdata[STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_WIDTH - 1 : 0];
          load_b2s_vload_drt_req_vlen_illegal = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_EN_HPMCOUNTER_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_en_hpmcounter = station2brb_req_w.wdata[STATION_VP_S2B_CFG_EN_HPMCOUNTER_WIDTH - 1 : 0];
          load_s2b_cfg_en_hpmcounter = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_PWR_ON_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_pwr_on = station2brb_req_w.wdata[STATION_VP_S2B_CFG_PWR_ON_WIDTH - 1 : 0];
          load_s2b_cfg_pwr_on = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_SLEEP_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_sleep = station2brb_req_w.wdata[STATION_VP_S2B_CFG_SLEEP_WIDTH - 1 : 0];
          load_s2b_cfg_sleep = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_BYPASS_IC_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_bypass_ic = station2brb_req_w.wdata[STATION_VP_S2B_CFG_BYPASS_IC_WIDTH - 1 : 0];
          load_s2b_cfg_bypass_ic = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_BYPASS_TLB_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_bypass_tlb = station2brb_req_w.wdata[STATION_VP_S2B_CFG_BYPASS_TLB_WIDTH - 1 : 0];
          load_s2b_cfg_bypass_tlb = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2icg_clk_en = station2brb_req_w.wdata[STATION_VP_S2ICG_CLK_EN_WIDTH - 1 : 0];
          load_s2icg_clk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_B2S_IS_VTLB_EXCP_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          b2s_is_vtlb_excp = station2brb_req_w.wdata[STATION_VP_B2S_IS_VTLB_EXCP_WIDTH - 1 : 0];
          load_b2s_is_vtlb_excp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_ITB_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_itb_en = station2brb_req_w.wdata[STATION_VP_S2B_CFG_ITB_EN_WIDTH - 1 : 0];
          load_s2b_cfg_itb_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_CFG_ITB_WRAP_AROUND_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_cfg_itb_wrap_around = station2brb_req_w.wdata[STATION_VP_S2B_CFG_ITB_WRAP_AROUND_WIDTH - 1 : 0];
          load_s2b_cfg_itb_wrap_around = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_0 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_IF_PC_0_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_1 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_IF_PC_1_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_2 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_IF_PC_2_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_IF_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_if_pc_3 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_IF_PC_3_WIDTH - 1 : 0];
          load_s2b_en_bp_if_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_0_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_0 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_WB_PC_0_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_1_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_1 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_WB_PC_1_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_2_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_2 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_WB_PC_2_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_WB_PC_3_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_wb_pc_3 = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_WB_PC_3_WIDTH - 1 : 0];
          load_s2b_en_bp_wb_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_EN_BP_INSTRET_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_en_bp_instret = station2brb_req_w.wdata[STATION_VP_S2B_EN_BP_INSTRET_WIDTH - 1 : 0];
          load_s2b_en_bp_instret = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_vcore_en = station2brb_req_w.wdata[STATION_VP_S2B_VCORE_EN_WIDTH - 1 : 0];
          load_s2b_vcore_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_VP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_VP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_VP_DATA_WIDTH/8)]} == (STATION_VP_S2B_VCORE_PMU_EN_OFFSET >> $clog2(STATION_VP_DATA_WIDTH/8)))): begin
          s2b_vcore_pmu_en = station2brb_req_w.wdata[STATION_VP_S2B_VCORE_PMU_EN_WIDTH - 1 : 0];
          load_s2b_vcore_pmu_en = station2brb_req_awready & station2brb_req_wready;
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
