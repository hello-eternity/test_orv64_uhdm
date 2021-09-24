
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_DDR_TOP_PKG__SV
`define STATION_DDR_TOP_PKG__SV
package station_ddr_top_pkg;
  localparam int STATION_DDR_TOP_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_DDR_TOP_DATA_WIDTH = 'h40;
  localparam [STATION_DDR_TOP_RING_ADDR_WIDTH-1:0] STATION_DDR_TOP_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_DDR_TOP_BLKID = 'h3;
  localparam int STATION_DDR_TOP_BLKID_WIDTH = 'h2;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DDR_PHY_OFFSET = 64'h0;
  localparam int STATION_DDR_TOP_DDR_PHY_WIDTH  = 33554432;
  localparam bit [64 - 1:0] STATION_DDR_TOP_DDR_PHY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DDR_PHY_ADDR = 64'h1800000;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DDR_UCTRL_OFFSET = 64'h400000;
  localparam int STATION_DDR_TOP_DDR_UCTRL_WIDTH  = 1048576;
  localparam bit [64 - 1:0] STATION_DDR_TOP_DDR_UCTRL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DDR_UCTRL_ADDR = 64'h1c00000;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENDAT_OFFSET = 64'h420000;
  localparam int STATION_DDR_TOP_S2B_BYPASSOUTENDAT_WIDTH  = 24;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENDAT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENDAT_ADDR = 64'h1c20000;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_OFFSET = 64'h420008;
  localparam int STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_WIDTH  = 24;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_ADDR = 64'h1c20008;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATADAT_OFFSET = 64'h420010;
  localparam int STATION_DDR_TOP_B2S_BYPASSINDATADAT_WIDTH  = 24;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATADAT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATADAT_ADDR = 64'h1c20010;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_RD_MRR_DATA_OFFSET = 64'h420018;
  localparam int STATION_DDR_TOP_B2S_RD_MRR_DATA_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_RD_MRR_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_RD_MRR_DATA_ADDR = 64'h1c20018;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENAC_OFFSET = 64'h420020;
  localparam int STATION_DDR_TOP_S2B_BYPASSOUTENAC_WIDTH  = 12;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENAC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENAC_ADDR = 64'h1c20020;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_OFFSET = 64'h420028;
  localparam int STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_WIDTH  = 12;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_ADDR = 64'h1c20028;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATAAC_OFFSET = 64'h420030;
  localparam int STATION_DDR_TOP_B2S_BYPASSINDATAAC_WIDTH  = 12;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATAAC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATAAC_ADDR = 64'h1c20030;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_OFFSET = 64'h420038;
  localparam int STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_WIDTH  = 6;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_ADDR = 64'h1c20038;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PA_RMASK_OFFSET = 64'h420040;
  localparam int STATION_DDR_TOP_S2B_PA_RMASK_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_PA_RMASK_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PA_RMASK_ADDR = 64'h1c20040;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_OFFSET = 64'h420048;
  localparam int STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_ADDR = 64'h1c20048;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_OFFSET = 64'h420050;
  localparam int STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_ADDR = 64'h1c20050;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_OFFSET = 64'h420058;
  localparam int STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_ADDR = 64'h1c20058;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_OFFSET = 64'h420060;
  localparam int STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_ADDR = 64'h1c20060;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_OFFSET = 64'h420068;
  localparam int STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_ADDR = 64'h1c20068;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PWR_OK_IN_OFFSET = 64'h420070;
  localparam int STATION_DDR_TOP_S2B_PWR_OK_IN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_PWR_OK_IN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PWR_OK_IN_ADDR = 64'h1c20070;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_ARESETN_0_OFFSET = 64'h420078;
  localparam int STATION_DDR_TOP_S2B_ARESETN_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_ARESETN_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_ARESETN_0_ADDR = 64'h1c20078;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PRESETN_OFFSET = 64'h420080;
  localparam int STATION_DDR_TOP_S2B_PRESETN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_PRESETN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PRESETN_ADDR = 64'h1c20080;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_CSYSREQ_0_OFFSET = 64'h420088;
  localparam int STATION_DDR_TOP_S2B_CSYSREQ_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_CSYSREQ_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_CSYSREQ_0_ADDR = 64'h1c20088;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_CSYSREQ_DDRC_OFFSET = 64'h420090;
  localparam int STATION_DDR_TOP_S2B_CSYSREQ_DDRC_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_CSYSREQ_DDRC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_CSYSREQ_DDRC_ADDR = 64'h1c20090;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PA_WMASK_OFFSET = 64'h420098;
  localparam int STATION_DDR_TOP_S2B_PA_WMASK_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_PA_WMASK_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_PA_WMASK_ADDR = 64'h1c20098;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_OFFSET = 64'h4200a0;
  localparam int STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_ADDR = 64'h1c200a0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_DFI_RESET_N_IN_OFFSET = 64'h4200a8;
  localparam int STATION_DDR_TOP_S2B_DFI_RESET_N_IN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_DFI_RESET_N_IN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_DFI_RESET_N_IN_ADDR = 64'h1c200a8;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_OFFSET = 64'h4200b0;
  localparam int STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_ADDR = 64'h1c200b0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CSYSACK_0_OFFSET = 64'h4200b8;
  localparam int STATION_DDR_TOP_B2S_CSYSACK_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_CSYSACK_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CSYSACK_0_ADDR = 64'h1c200b8;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CACTIVE_0_OFFSET = 64'h4200c0;
  localparam int STATION_DDR_TOP_B2S_CACTIVE_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_CACTIVE_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CACTIVE_0_ADDR = 64'h1c200c0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CSYSACK_DDRC_OFFSET = 64'h4200c8;
  localparam int STATION_DDR_TOP_B2S_CSYSACK_DDRC_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_CSYSACK_DDRC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CSYSACK_DDRC_ADDR = 64'h1c200c8;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CACTIVE_DDRC_OFFSET = 64'h4200d0;
  localparam int STATION_DDR_TOP_B2S_CACTIVE_DDRC_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_CACTIVE_DDRC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_CACTIVE_DDRC_ADDR = 64'h1c200d0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_OFFSET = 64'h4200d8;
  localparam int STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR = 64'h1c200d8;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_DFI_RESET_N_REF_OFFSET = 64'h4200e0;
  localparam int STATION_DDR_TOP_B2S_DFI_RESET_N_REF_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_DFI_RESET_N_REF_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_DFI_RESET_N_REF_ADDR = 64'h1c200e0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_OFFSET = 64'h4200e8;
  localparam int STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_ADDR = 64'h1c200e8;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_OFFSET = 64'h4200f0;
  localparam int STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_ADDR = 64'h1c200f0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENAC_OFFSET = 64'h4200f8;
  localparam int STATION_DDR_TOP_S2B_BYPASSMODEENAC_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENAC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENAC_ADDR = 64'h1c200f8;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENDAT_OFFSET = 64'h420100;
  localparam int STATION_DDR_TOP_S2B_BYPASSMODEENDAT_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENDAT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENDAT_ADDR = 64'h1c20100;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_OFFSET = 64'h420108;
  localparam int STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_ADDR = 64'h1c20108;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DDR_PWR_ON_OFFSET = 64'h420110;
  localparam int STATION_DDR_TOP_DDR_PWR_ON_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_DDR_PWR_ON_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DDR_PWR_ON_ADDR = 64'h1c20110;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DEBUG_INFO_ENABLE_OFFSET = 64'h420118;
  localparam int STATION_DDR_TOP_DEBUG_INFO_ENABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DDR_TOP_DEBUG_INFO_ENABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_DDR_TOP_DEBUG_INFO_ENABLE_ADDR = 64'h1c20118;
endpackage
`endif
`ifndef STATION_DDR_TOP__SV
`define STATION_DDR_TOP__SV
module station_ddr_top
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_ddr_top_pkg::*;
  (
  output [STATION_DDR_TOP_S2B_BYPASSOUTENDAT_WIDTH - 1 : 0] out_s2b_BypassOutEnDAT,
  output [STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_WIDTH - 1 : 0] out_s2b_BypassOutDataDAT,
  output [STATION_DDR_TOP_B2S_BYPASSINDATADAT_WIDTH - 1 : 0] out_b2s_BypassInDataDAT,
  output [STATION_DDR_TOP_B2S_RD_MRR_DATA_WIDTH - 1 : 0] out_b2s_rd_mrr_data,
  output [STATION_DDR_TOP_S2B_BYPASSOUTENAC_WIDTH - 1 : 0] out_s2b_BypassOutEnAC,
  output [STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_WIDTH - 1 : 0] out_s2b_BypassOutDataAC,
  output [STATION_DDR_TOP_B2S_BYPASSINDATAAC_WIDTH - 1 : 0] out_b2s_BypassInDataAC,
  output [STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_WIDTH - 1 : 0] out_b2s_hif_refresh_req_bank,
  output [STATION_DDR_TOP_S2B_PA_RMASK_WIDTH - 1 : 0] out_s2b_pa_rmask,
  output [STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_WIDTH - 1 : 0] out_b2s_stat_ddrc_reg_selfref_type,
  output [STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_WIDTH - 1 : 0] out_s2b_BypassOutEnMASTER,
  output [STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_WIDTH - 1 : 0] out_s2b_BypassOutDataMASTER,
  output [STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_WIDTH - 1 : 0] out_b2s_BypassInDataMASTER,
  output out_s2b_core_ddrc_rstn,
  output out_s2b_pwr_ok_in,
  output out_s2b_aresetn_0,
  output out_s2b_presetn,
  output out_s2b_csysreq_0,
  output out_s2b_csysreq_ddrc,
  output out_s2b_pa_wmask,
  output out_s2b_dfi_ctrlupd_ack2_ch0,
  output out_s2b_dfi_reset_n_in,
  output out_s2b_init_mr_done_in,
  output out_b2s_csysack_0,
  output out_b2s_cactive_0,
  output out_b2s_csysack_ddrc,
  output out_b2s_cactive_ddrc,
  output out_b2s_rd_mrr_data_valid,
  output out_b2s_dfi_reset_n_ref,
  output out_b2s_init_mr_done_out,
  output out_b2s_dfi_alert_err_intr,
  output out_s2b_BypassModeEnAC,
  output out_s2b_BypassModeEnDAT,
  output out_s2b_BypassModeEnMASTER,
  output out_ddr_pwr_on,
  output out_debug_info_enable,
  input logic vld_in_b2s_BypassInDataDAT,
  input [STATION_DDR_TOP_B2S_BYPASSINDATADAT_WIDTH - 1 : 0] in_b2s_BypassInDataDAT,
  input logic vld_in_b2s_rd_mrr_data,
  input [STATION_DDR_TOP_B2S_RD_MRR_DATA_WIDTH - 1 : 0] in_b2s_rd_mrr_data,
  input logic vld_in_b2s_BypassInDataAC,
  input [STATION_DDR_TOP_B2S_BYPASSINDATAAC_WIDTH - 1 : 0] in_b2s_BypassInDataAC,
  input logic vld_in_b2s_hif_refresh_req_bank,
  input [STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_WIDTH - 1 : 0] in_b2s_hif_refresh_req_bank,
  input logic vld_in_b2s_stat_ddrc_reg_selfref_type,
  input [STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_WIDTH - 1 : 0] in_b2s_stat_ddrc_reg_selfref_type,
  input logic vld_in_b2s_BypassInDataMASTER,
  input [STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_WIDTH - 1 : 0] in_b2s_BypassInDataMASTER,
  input logic vld_in_b2s_csysack_0,
  input in_b2s_csysack_0,
  input logic vld_in_b2s_cactive_0,
  input in_b2s_cactive_0,
  input logic vld_in_b2s_csysack_ddrc,
  input in_b2s_csysack_ddrc,
  input logic vld_in_b2s_cactive_ddrc,
  input in_b2s_cactive_ddrc,
  input logic vld_in_b2s_rd_mrr_data_valid,
  input in_b2s_rd_mrr_data_valid,
  input logic vld_in_b2s_dfi_reset_n_ref,
  input in_b2s_dfi_reset_n_ref,
  input logic vld_in_b2s_init_mr_done_out,
  input in_b2s_init_mr_done_out,
  input logic vld_in_b2s_dfi_alert_err_intr,
  input in_b2s_dfi_alert_err_intr,
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
  localparam int                                STATION_ID_WIDTH_0 = STATION_DDR_TOP_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_DDR_TOP_BLKID;

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

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_DDR_TOP_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_DDR_TOP_MAX_RING_ADDR)) station_u (

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

  logic [STATION_DDR_TOP_S2B_BYPASSOUTENDAT_WIDTH - 1 : 0] rff_s2b_BypassOutEnDAT;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTENDAT_WIDTH - 1 : 0] s2b_BypassOutEnDAT;
  logic load_s2b_BypassOutEnDAT;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassOutEnDAT <= STATION_DDR_TOP_S2B_BYPASSOUTENDAT_RSTVAL;
    end else if (load_s2b_BypassOutEnDAT == 1'b1) begin
      rff_s2b_BypassOutEnDAT <= (wmask & s2b_BypassOutEnDAT) | (wmask_inv & rff_s2b_BypassOutEnDAT);
    end
  end
  assign out_s2b_BypassOutEnDAT = rff_s2b_BypassOutEnDAT;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_WIDTH - 1 : 0] rff_s2b_BypassOutDataDAT;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_WIDTH - 1 : 0] s2b_BypassOutDataDAT;
  logic load_s2b_BypassOutDataDAT;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassOutDataDAT <= STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_RSTVAL;
    end else if (load_s2b_BypassOutDataDAT == 1'b1) begin
      rff_s2b_BypassOutDataDAT <= (wmask & s2b_BypassOutDataDAT) | (wmask_inv & rff_s2b_BypassOutDataDAT);
    end
  end
  assign out_s2b_BypassOutDataDAT = rff_s2b_BypassOutDataDAT;
  logic [STATION_DDR_TOP_B2S_BYPASSINDATADAT_WIDTH - 1 : 0] rff_b2s_BypassInDataDAT;
  logic [STATION_DDR_TOP_B2S_BYPASSINDATADAT_WIDTH - 1 : 0] b2s_BypassInDataDAT;
  logic load_b2s_BypassInDataDAT;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_BypassInDataDAT <= STATION_DDR_TOP_B2S_BYPASSINDATADAT_RSTVAL;
    end else if (load_b2s_BypassInDataDAT == 1'b1) begin
      rff_b2s_BypassInDataDAT <= (wmask & b2s_BypassInDataDAT) | (wmask_inv & rff_b2s_BypassInDataDAT);

    end else if (vld_in_b2s_BypassInDataDAT == 1'b1) begin
      rff_b2s_BypassInDataDAT <= in_b2s_BypassInDataDAT;
    end
  end
  assign out_b2s_BypassInDataDAT = rff_b2s_BypassInDataDAT;
  logic [STATION_DDR_TOP_B2S_RD_MRR_DATA_WIDTH - 1 : 0] rff_b2s_rd_mrr_data;
  logic [STATION_DDR_TOP_B2S_RD_MRR_DATA_WIDTH - 1 : 0] b2s_rd_mrr_data;
  logic load_b2s_rd_mrr_data;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_rd_mrr_data <= STATION_DDR_TOP_B2S_RD_MRR_DATA_RSTVAL;
    end else if (load_b2s_rd_mrr_data == 1'b1) begin
      rff_b2s_rd_mrr_data <= (wmask & b2s_rd_mrr_data) | (wmask_inv & rff_b2s_rd_mrr_data);

    end else if (vld_in_b2s_rd_mrr_data == 1'b1) begin
      rff_b2s_rd_mrr_data <= in_b2s_rd_mrr_data;
    end
  end
  assign out_b2s_rd_mrr_data = rff_b2s_rd_mrr_data;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTENAC_WIDTH - 1 : 0] rff_s2b_BypassOutEnAC;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTENAC_WIDTH - 1 : 0] s2b_BypassOutEnAC;
  logic load_s2b_BypassOutEnAC;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassOutEnAC <= STATION_DDR_TOP_S2B_BYPASSOUTENAC_RSTVAL;
    end else if (load_s2b_BypassOutEnAC == 1'b1) begin
      rff_s2b_BypassOutEnAC <= (wmask & s2b_BypassOutEnAC) | (wmask_inv & rff_s2b_BypassOutEnAC);
    end
  end
  assign out_s2b_BypassOutEnAC = rff_s2b_BypassOutEnAC;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_WIDTH - 1 : 0] rff_s2b_BypassOutDataAC;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_WIDTH - 1 : 0] s2b_BypassOutDataAC;
  logic load_s2b_BypassOutDataAC;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassOutDataAC <= STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_RSTVAL;
    end else if (load_s2b_BypassOutDataAC == 1'b1) begin
      rff_s2b_BypassOutDataAC <= (wmask & s2b_BypassOutDataAC) | (wmask_inv & rff_s2b_BypassOutDataAC);
    end
  end
  assign out_s2b_BypassOutDataAC = rff_s2b_BypassOutDataAC;
  logic [STATION_DDR_TOP_B2S_BYPASSINDATAAC_WIDTH - 1 : 0] rff_b2s_BypassInDataAC;
  logic [STATION_DDR_TOP_B2S_BYPASSINDATAAC_WIDTH - 1 : 0] b2s_BypassInDataAC;
  logic load_b2s_BypassInDataAC;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_BypassInDataAC <= STATION_DDR_TOP_B2S_BYPASSINDATAAC_RSTVAL;
    end else if (load_b2s_BypassInDataAC == 1'b1) begin
      rff_b2s_BypassInDataAC <= (wmask & b2s_BypassInDataAC) | (wmask_inv & rff_b2s_BypassInDataAC);

    end else if (vld_in_b2s_BypassInDataAC == 1'b1) begin
      rff_b2s_BypassInDataAC <= in_b2s_BypassInDataAC;
    end
  end
  assign out_b2s_BypassInDataAC = rff_b2s_BypassInDataAC;
  logic [STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_WIDTH - 1 : 0] rff_b2s_hif_refresh_req_bank;
  logic [STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_WIDTH - 1 : 0] b2s_hif_refresh_req_bank;
  logic load_b2s_hif_refresh_req_bank;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_hif_refresh_req_bank <= STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_RSTVAL;
    end else if (load_b2s_hif_refresh_req_bank == 1'b1) begin
      rff_b2s_hif_refresh_req_bank <= (wmask & b2s_hif_refresh_req_bank) | (wmask_inv & rff_b2s_hif_refresh_req_bank);

    end else if (vld_in_b2s_hif_refresh_req_bank == 1'b1) begin
      rff_b2s_hif_refresh_req_bank <= in_b2s_hif_refresh_req_bank;
    end
  end
  assign out_b2s_hif_refresh_req_bank = rff_b2s_hif_refresh_req_bank;
  logic [STATION_DDR_TOP_S2B_PA_RMASK_WIDTH - 1 : 0] rff_s2b_pa_rmask;
  logic [STATION_DDR_TOP_S2B_PA_RMASK_WIDTH - 1 : 0] s2b_pa_rmask;
  logic load_s2b_pa_rmask;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pa_rmask <= STATION_DDR_TOP_S2B_PA_RMASK_RSTVAL;
    end else if (load_s2b_pa_rmask == 1'b1) begin
      rff_s2b_pa_rmask <= (wmask & s2b_pa_rmask) | (wmask_inv & rff_s2b_pa_rmask);
    end
  end
  assign out_s2b_pa_rmask = rff_s2b_pa_rmask;
  logic [STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_WIDTH - 1 : 0] rff_b2s_stat_ddrc_reg_selfref_type;
  logic [STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_WIDTH - 1 : 0] b2s_stat_ddrc_reg_selfref_type;
  logic load_b2s_stat_ddrc_reg_selfref_type;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_stat_ddrc_reg_selfref_type <= STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_RSTVAL;
    end else if (load_b2s_stat_ddrc_reg_selfref_type == 1'b1) begin
      rff_b2s_stat_ddrc_reg_selfref_type <= (wmask & b2s_stat_ddrc_reg_selfref_type) | (wmask_inv & rff_b2s_stat_ddrc_reg_selfref_type);

    end else if (vld_in_b2s_stat_ddrc_reg_selfref_type == 1'b1) begin
      rff_b2s_stat_ddrc_reg_selfref_type <= in_b2s_stat_ddrc_reg_selfref_type;
    end
  end
  assign out_b2s_stat_ddrc_reg_selfref_type = rff_b2s_stat_ddrc_reg_selfref_type;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_WIDTH - 1 : 0] rff_s2b_BypassOutEnMASTER;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_WIDTH - 1 : 0] s2b_BypassOutEnMASTER;
  logic load_s2b_BypassOutEnMASTER;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassOutEnMASTER <= STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_RSTVAL;
    end else if (load_s2b_BypassOutEnMASTER == 1'b1) begin
      rff_s2b_BypassOutEnMASTER <= (wmask & s2b_BypassOutEnMASTER) | (wmask_inv & rff_s2b_BypassOutEnMASTER);
    end
  end
  assign out_s2b_BypassOutEnMASTER = rff_s2b_BypassOutEnMASTER;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_WIDTH - 1 : 0] rff_s2b_BypassOutDataMASTER;
  logic [STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_WIDTH - 1 : 0] s2b_BypassOutDataMASTER;
  logic load_s2b_BypassOutDataMASTER;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassOutDataMASTER <= STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_RSTVAL;
    end else if (load_s2b_BypassOutDataMASTER == 1'b1) begin
      rff_s2b_BypassOutDataMASTER <= (wmask & s2b_BypassOutDataMASTER) | (wmask_inv & rff_s2b_BypassOutDataMASTER);
    end
  end
  assign out_s2b_BypassOutDataMASTER = rff_s2b_BypassOutDataMASTER;
  logic [STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_WIDTH - 1 : 0] rff_b2s_BypassInDataMASTER;
  logic [STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_WIDTH - 1 : 0] b2s_BypassInDataMASTER;
  logic load_b2s_BypassInDataMASTER;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_BypassInDataMASTER <= STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_RSTVAL;
    end else if (load_b2s_BypassInDataMASTER == 1'b1) begin
      rff_b2s_BypassInDataMASTER <= (wmask & b2s_BypassInDataMASTER) | (wmask_inv & rff_b2s_BypassInDataMASTER);

    end else if (vld_in_b2s_BypassInDataMASTER == 1'b1) begin
      rff_b2s_BypassInDataMASTER <= in_b2s_BypassInDataMASTER;
    end
  end
  assign out_b2s_BypassInDataMASTER = rff_b2s_BypassInDataMASTER;
  logic [STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_WIDTH - 1 : 0] rff_s2b_core_ddrc_rstn;
  logic [STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_WIDTH - 1 : 0] s2b_core_ddrc_rstn;
  logic load_s2b_core_ddrc_rstn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_core_ddrc_rstn <= STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_RSTVAL;
    end else if (load_s2b_core_ddrc_rstn == 1'b1) begin
      rff_s2b_core_ddrc_rstn <= (wmask & s2b_core_ddrc_rstn) | (wmask_inv & rff_s2b_core_ddrc_rstn);
    end
  end
  assign out_s2b_core_ddrc_rstn = rff_s2b_core_ddrc_rstn;
  logic [STATION_DDR_TOP_S2B_PWR_OK_IN_WIDTH - 1 : 0] rff_s2b_pwr_ok_in;
  logic [STATION_DDR_TOP_S2B_PWR_OK_IN_WIDTH - 1 : 0] s2b_pwr_ok_in;
  logic load_s2b_pwr_ok_in;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pwr_ok_in <= STATION_DDR_TOP_S2B_PWR_OK_IN_RSTVAL;
    end else if (load_s2b_pwr_ok_in == 1'b1) begin
      rff_s2b_pwr_ok_in <= (wmask & s2b_pwr_ok_in) | (wmask_inv & rff_s2b_pwr_ok_in);
    end
  end
  assign out_s2b_pwr_ok_in = rff_s2b_pwr_ok_in;
  logic [STATION_DDR_TOP_S2B_ARESETN_0_WIDTH - 1 : 0] rff_s2b_aresetn_0;
  logic [STATION_DDR_TOP_S2B_ARESETN_0_WIDTH - 1 : 0] s2b_aresetn_0;
  logic load_s2b_aresetn_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_aresetn_0 <= STATION_DDR_TOP_S2B_ARESETN_0_RSTVAL;
    end else if (load_s2b_aresetn_0 == 1'b1) begin
      rff_s2b_aresetn_0 <= (wmask & s2b_aresetn_0) | (wmask_inv & rff_s2b_aresetn_0);
    end
  end
  assign out_s2b_aresetn_0 = rff_s2b_aresetn_0;
  logic [STATION_DDR_TOP_S2B_PRESETN_WIDTH - 1 : 0] rff_s2b_presetn;
  logic [STATION_DDR_TOP_S2B_PRESETN_WIDTH - 1 : 0] s2b_presetn;
  logic load_s2b_presetn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_presetn <= STATION_DDR_TOP_S2B_PRESETN_RSTVAL;
    end else if (load_s2b_presetn == 1'b1) begin
      rff_s2b_presetn <= (wmask & s2b_presetn) | (wmask_inv & rff_s2b_presetn);
    end
  end
  assign out_s2b_presetn = rff_s2b_presetn;
  logic [STATION_DDR_TOP_S2B_CSYSREQ_0_WIDTH - 1 : 0] rff_s2b_csysreq_0;
  logic [STATION_DDR_TOP_S2B_CSYSREQ_0_WIDTH - 1 : 0] s2b_csysreq_0;
  logic load_s2b_csysreq_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_csysreq_0 <= STATION_DDR_TOP_S2B_CSYSREQ_0_RSTVAL;
    end else if (load_s2b_csysreq_0 == 1'b1) begin
      rff_s2b_csysreq_0 <= (wmask & s2b_csysreq_0) | (wmask_inv & rff_s2b_csysreq_0);
    end
  end
  assign out_s2b_csysreq_0 = rff_s2b_csysreq_0;
  logic [STATION_DDR_TOP_S2B_CSYSREQ_DDRC_WIDTH - 1 : 0] rff_s2b_csysreq_ddrc;
  logic [STATION_DDR_TOP_S2B_CSYSREQ_DDRC_WIDTH - 1 : 0] s2b_csysreq_ddrc;
  logic load_s2b_csysreq_ddrc;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_csysreq_ddrc <= STATION_DDR_TOP_S2B_CSYSREQ_DDRC_RSTVAL;
    end else if (load_s2b_csysreq_ddrc == 1'b1) begin
      rff_s2b_csysreq_ddrc <= (wmask & s2b_csysreq_ddrc) | (wmask_inv & rff_s2b_csysreq_ddrc);
    end
  end
  assign out_s2b_csysreq_ddrc = rff_s2b_csysreq_ddrc;
  logic [STATION_DDR_TOP_S2B_PA_WMASK_WIDTH - 1 : 0] rff_s2b_pa_wmask;
  logic [STATION_DDR_TOP_S2B_PA_WMASK_WIDTH - 1 : 0] s2b_pa_wmask;
  logic load_s2b_pa_wmask;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pa_wmask <= STATION_DDR_TOP_S2B_PA_WMASK_RSTVAL;
    end else if (load_s2b_pa_wmask == 1'b1) begin
      rff_s2b_pa_wmask <= (wmask & s2b_pa_wmask) | (wmask_inv & rff_s2b_pa_wmask);
    end
  end
  assign out_s2b_pa_wmask = rff_s2b_pa_wmask;
  logic [STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_WIDTH - 1 : 0] rff_s2b_dfi_ctrlupd_ack2_ch0;
  logic [STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_WIDTH - 1 : 0] s2b_dfi_ctrlupd_ack2_ch0;
  logic load_s2b_dfi_ctrlupd_ack2_ch0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_dfi_ctrlupd_ack2_ch0 <= STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_RSTVAL;
    end else if (load_s2b_dfi_ctrlupd_ack2_ch0 == 1'b1) begin
      rff_s2b_dfi_ctrlupd_ack2_ch0 <= (wmask & s2b_dfi_ctrlupd_ack2_ch0) | (wmask_inv & rff_s2b_dfi_ctrlupd_ack2_ch0);
    end
  end
  assign out_s2b_dfi_ctrlupd_ack2_ch0 = rff_s2b_dfi_ctrlupd_ack2_ch0;
  logic [STATION_DDR_TOP_S2B_DFI_RESET_N_IN_WIDTH - 1 : 0] rff_s2b_dfi_reset_n_in;
  logic [STATION_DDR_TOP_S2B_DFI_RESET_N_IN_WIDTH - 1 : 0] s2b_dfi_reset_n_in;
  logic load_s2b_dfi_reset_n_in;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_dfi_reset_n_in <= STATION_DDR_TOP_S2B_DFI_RESET_N_IN_RSTVAL;
    end else if (load_s2b_dfi_reset_n_in == 1'b1) begin
      rff_s2b_dfi_reset_n_in <= (wmask & s2b_dfi_reset_n_in) | (wmask_inv & rff_s2b_dfi_reset_n_in);
    end
  end
  assign out_s2b_dfi_reset_n_in = rff_s2b_dfi_reset_n_in;
  logic [STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_WIDTH - 1 : 0] rff_s2b_init_mr_done_in;
  logic [STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_WIDTH - 1 : 0] s2b_init_mr_done_in;
  logic load_s2b_init_mr_done_in;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_init_mr_done_in <= STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_RSTVAL;
    end else if (load_s2b_init_mr_done_in == 1'b1) begin
      rff_s2b_init_mr_done_in <= (wmask & s2b_init_mr_done_in) | (wmask_inv & rff_s2b_init_mr_done_in);
    end
  end
  assign out_s2b_init_mr_done_in = rff_s2b_init_mr_done_in;
  logic [STATION_DDR_TOP_B2S_CSYSACK_0_WIDTH - 1 : 0] rff_b2s_csysack_0;
  logic [STATION_DDR_TOP_B2S_CSYSACK_0_WIDTH - 1 : 0] b2s_csysack_0;
  logic load_b2s_csysack_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_csysack_0 <= STATION_DDR_TOP_B2S_CSYSACK_0_RSTVAL;
    end else if (load_b2s_csysack_0 == 1'b1) begin
      rff_b2s_csysack_0 <= (wmask & b2s_csysack_0) | (wmask_inv & rff_b2s_csysack_0);

    end else if (vld_in_b2s_csysack_0 == 1'b1) begin
      rff_b2s_csysack_0 <= in_b2s_csysack_0;
    end
  end
  assign out_b2s_csysack_0 = rff_b2s_csysack_0;
  logic [STATION_DDR_TOP_B2S_CACTIVE_0_WIDTH - 1 : 0] rff_b2s_cactive_0;
  logic [STATION_DDR_TOP_B2S_CACTIVE_0_WIDTH - 1 : 0] b2s_cactive_0;
  logic load_b2s_cactive_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_cactive_0 <= STATION_DDR_TOP_B2S_CACTIVE_0_RSTVAL;
    end else if (load_b2s_cactive_0 == 1'b1) begin
      rff_b2s_cactive_0 <= (wmask & b2s_cactive_0) | (wmask_inv & rff_b2s_cactive_0);

    end else if (vld_in_b2s_cactive_0 == 1'b1) begin
      rff_b2s_cactive_0 <= in_b2s_cactive_0;
    end
  end
  assign out_b2s_cactive_0 = rff_b2s_cactive_0;
  logic [STATION_DDR_TOP_B2S_CSYSACK_DDRC_WIDTH - 1 : 0] rff_b2s_csysack_ddrc;
  logic [STATION_DDR_TOP_B2S_CSYSACK_DDRC_WIDTH - 1 : 0] b2s_csysack_ddrc;
  logic load_b2s_csysack_ddrc;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_csysack_ddrc <= STATION_DDR_TOP_B2S_CSYSACK_DDRC_RSTVAL;
    end else if (load_b2s_csysack_ddrc == 1'b1) begin
      rff_b2s_csysack_ddrc <= (wmask & b2s_csysack_ddrc) | (wmask_inv & rff_b2s_csysack_ddrc);

    end else if (vld_in_b2s_csysack_ddrc == 1'b1) begin
      rff_b2s_csysack_ddrc <= in_b2s_csysack_ddrc;
    end
  end
  assign out_b2s_csysack_ddrc = rff_b2s_csysack_ddrc;
  logic [STATION_DDR_TOP_B2S_CACTIVE_DDRC_WIDTH - 1 : 0] rff_b2s_cactive_ddrc;
  logic [STATION_DDR_TOP_B2S_CACTIVE_DDRC_WIDTH - 1 : 0] b2s_cactive_ddrc;
  logic load_b2s_cactive_ddrc;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_cactive_ddrc <= STATION_DDR_TOP_B2S_CACTIVE_DDRC_RSTVAL;
    end else if (load_b2s_cactive_ddrc == 1'b1) begin
      rff_b2s_cactive_ddrc <= (wmask & b2s_cactive_ddrc) | (wmask_inv & rff_b2s_cactive_ddrc);

    end else if (vld_in_b2s_cactive_ddrc == 1'b1) begin
      rff_b2s_cactive_ddrc <= in_b2s_cactive_ddrc;
    end
  end
  assign out_b2s_cactive_ddrc = rff_b2s_cactive_ddrc;
  logic [STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_WIDTH - 1 : 0] rff_b2s_rd_mrr_data_valid;
  logic [STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_WIDTH - 1 : 0] b2s_rd_mrr_data_valid;
  logic load_b2s_rd_mrr_data_valid;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_rd_mrr_data_valid <= STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_RSTVAL;
    end else if (load_b2s_rd_mrr_data_valid == 1'b1) begin
      rff_b2s_rd_mrr_data_valid <= (wmask & b2s_rd_mrr_data_valid) | (wmask_inv & rff_b2s_rd_mrr_data_valid);

    end else if (vld_in_b2s_rd_mrr_data_valid == 1'b1) begin
      rff_b2s_rd_mrr_data_valid <= in_b2s_rd_mrr_data_valid;
    end
  end
  assign out_b2s_rd_mrr_data_valid = rff_b2s_rd_mrr_data_valid;
  logic [STATION_DDR_TOP_B2S_DFI_RESET_N_REF_WIDTH - 1 : 0] rff_b2s_dfi_reset_n_ref;
  logic [STATION_DDR_TOP_B2S_DFI_RESET_N_REF_WIDTH - 1 : 0] b2s_dfi_reset_n_ref;
  logic load_b2s_dfi_reset_n_ref;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_dfi_reset_n_ref <= STATION_DDR_TOP_B2S_DFI_RESET_N_REF_RSTVAL;
    end else if (load_b2s_dfi_reset_n_ref == 1'b1) begin
      rff_b2s_dfi_reset_n_ref <= (wmask & b2s_dfi_reset_n_ref) | (wmask_inv & rff_b2s_dfi_reset_n_ref);

    end else if (vld_in_b2s_dfi_reset_n_ref == 1'b1) begin
      rff_b2s_dfi_reset_n_ref <= in_b2s_dfi_reset_n_ref;
    end
  end
  assign out_b2s_dfi_reset_n_ref = rff_b2s_dfi_reset_n_ref;
  logic [STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_WIDTH - 1 : 0] rff_b2s_init_mr_done_out;
  logic [STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_WIDTH - 1 : 0] b2s_init_mr_done_out;
  logic load_b2s_init_mr_done_out;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_init_mr_done_out <= STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_RSTVAL;
    end else if (load_b2s_init_mr_done_out == 1'b1) begin
      rff_b2s_init_mr_done_out <= (wmask & b2s_init_mr_done_out) | (wmask_inv & rff_b2s_init_mr_done_out);

    end else if (vld_in_b2s_init_mr_done_out == 1'b1) begin
      rff_b2s_init_mr_done_out <= in_b2s_init_mr_done_out;
    end
  end
  assign out_b2s_init_mr_done_out = rff_b2s_init_mr_done_out;
  logic [STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_WIDTH - 1 : 0] rff_b2s_dfi_alert_err_intr;
  logic [STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_WIDTH - 1 : 0] b2s_dfi_alert_err_intr;
  logic load_b2s_dfi_alert_err_intr;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_dfi_alert_err_intr <= STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_RSTVAL;
    end else if (load_b2s_dfi_alert_err_intr == 1'b1) begin
      rff_b2s_dfi_alert_err_intr <= (wmask & b2s_dfi_alert_err_intr) | (wmask_inv & rff_b2s_dfi_alert_err_intr);

    end else if (vld_in_b2s_dfi_alert_err_intr == 1'b1) begin
      rff_b2s_dfi_alert_err_intr <= in_b2s_dfi_alert_err_intr;
    end
  end
  assign out_b2s_dfi_alert_err_intr = rff_b2s_dfi_alert_err_intr;
  logic [STATION_DDR_TOP_S2B_BYPASSMODEENAC_WIDTH - 1 : 0] rff_s2b_BypassModeEnAC;
  logic [STATION_DDR_TOP_S2B_BYPASSMODEENAC_WIDTH - 1 : 0] s2b_BypassModeEnAC;
  logic load_s2b_BypassModeEnAC;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassModeEnAC <= STATION_DDR_TOP_S2B_BYPASSMODEENAC_RSTVAL;
    end else if (load_s2b_BypassModeEnAC == 1'b1) begin
      rff_s2b_BypassModeEnAC <= (wmask & s2b_BypassModeEnAC) | (wmask_inv & rff_s2b_BypassModeEnAC);
    end
  end
  assign out_s2b_BypassModeEnAC = rff_s2b_BypassModeEnAC;
  logic [STATION_DDR_TOP_S2B_BYPASSMODEENDAT_WIDTH - 1 : 0] rff_s2b_BypassModeEnDAT;
  logic [STATION_DDR_TOP_S2B_BYPASSMODEENDAT_WIDTH - 1 : 0] s2b_BypassModeEnDAT;
  logic load_s2b_BypassModeEnDAT;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassModeEnDAT <= STATION_DDR_TOP_S2B_BYPASSMODEENDAT_RSTVAL;
    end else if (load_s2b_BypassModeEnDAT == 1'b1) begin
      rff_s2b_BypassModeEnDAT <= (wmask & s2b_BypassModeEnDAT) | (wmask_inv & rff_s2b_BypassModeEnDAT);
    end
  end
  assign out_s2b_BypassModeEnDAT = rff_s2b_BypassModeEnDAT;
  logic [STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_WIDTH - 1 : 0] rff_s2b_BypassModeEnMASTER;
  logic [STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_WIDTH - 1 : 0] s2b_BypassModeEnMASTER;
  logic load_s2b_BypassModeEnMASTER;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_BypassModeEnMASTER <= STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_RSTVAL;
    end else if (load_s2b_BypassModeEnMASTER == 1'b1) begin
      rff_s2b_BypassModeEnMASTER <= (wmask & s2b_BypassModeEnMASTER) | (wmask_inv & rff_s2b_BypassModeEnMASTER);
    end
  end
  assign out_s2b_BypassModeEnMASTER = rff_s2b_BypassModeEnMASTER;
  logic [STATION_DDR_TOP_DDR_PWR_ON_WIDTH - 1 : 0] rff_ddr_pwr_on;
  logic [STATION_DDR_TOP_DDR_PWR_ON_WIDTH - 1 : 0] ddr_pwr_on;
  logic load_ddr_pwr_on;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_ddr_pwr_on <= STATION_DDR_TOP_DDR_PWR_ON_RSTVAL;
    end else if (load_ddr_pwr_on == 1'b1) begin
      rff_ddr_pwr_on <= (wmask & ddr_pwr_on) | (wmask_inv & rff_ddr_pwr_on);
    end
  end
  assign out_ddr_pwr_on = rff_ddr_pwr_on;
  logic [STATION_DDR_TOP_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] rff_debug_info_enable;
  logic [STATION_DDR_TOP_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] debug_info_enable;
  logic load_debug_info_enable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_debug_info_enable <= STATION_DDR_TOP_DEBUG_INFO_ENABLE_RSTVAL;
    end else if (load_debug_info_enable == 1'b1) begin
      rff_debug_info_enable <= (wmask & debug_info_enable) | (wmask_inv & rff_debug_info_enable);
    end
  end
  assign out_debug_info_enable = rff_debug_info_enable;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_DDR_TOP_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_DDR_TOP_DATA_WIDTH{1'b0}};
    s2b_BypassOutEnDAT = rff_s2b_BypassOutEnDAT;
    load_s2b_BypassOutEnDAT = 1'b0;
    s2b_BypassOutDataDAT = rff_s2b_BypassOutDataDAT;
    load_s2b_BypassOutDataDAT = 1'b0;
    b2s_BypassInDataDAT = rff_b2s_BypassInDataDAT;
    load_b2s_BypassInDataDAT = 1'b0;
    b2s_rd_mrr_data = rff_b2s_rd_mrr_data;
    load_b2s_rd_mrr_data = 1'b0;
    s2b_BypassOutEnAC = rff_s2b_BypassOutEnAC;
    load_s2b_BypassOutEnAC = 1'b0;
    s2b_BypassOutDataAC = rff_s2b_BypassOutDataAC;
    load_s2b_BypassOutDataAC = 1'b0;
    b2s_BypassInDataAC = rff_b2s_BypassInDataAC;
    load_b2s_BypassInDataAC = 1'b0;
    b2s_hif_refresh_req_bank = rff_b2s_hif_refresh_req_bank;
    load_b2s_hif_refresh_req_bank = 1'b0;
    s2b_pa_rmask = rff_s2b_pa_rmask;
    load_s2b_pa_rmask = 1'b0;
    b2s_stat_ddrc_reg_selfref_type = rff_b2s_stat_ddrc_reg_selfref_type;
    load_b2s_stat_ddrc_reg_selfref_type = 1'b0;
    s2b_BypassOutEnMASTER = rff_s2b_BypassOutEnMASTER;
    load_s2b_BypassOutEnMASTER = 1'b0;
    s2b_BypassOutDataMASTER = rff_s2b_BypassOutDataMASTER;
    load_s2b_BypassOutDataMASTER = 1'b0;
    b2s_BypassInDataMASTER = rff_b2s_BypassInDataMASTER;
    load_b2s_BypassInDataMASTER = 1'b0;
    s2b_core_ddrc_rstn = rff_s2b_core_ddrc_rstn;
    load_s2b_core_ddrc_rstn = 1'b0;
    s2b_pwr_ok_in = rff_s2b_pwr_ok_in;
    load_s2b_pwr_ok_in = 1'b0;
    s2b_aresetn_0 = rff_s2b_aresetn_0;
    load_s2b_aresetn_0 = 1'b0;
    s2b_presetn = rff_s2b_presetn;
    load_s2b_presetn = 1'b0;
    s2b_csysreq_0 = rff_s2b_csysreq_0;
    load_s2b_csysreq_0 = 1'b0;
    s2b_csysreq_ddrc = rff_s2b_csysreq_ddrc;
    load_s2b_csysreq_ddrc = 1'b0;
    s2b_pa_wmask = rff_s2b_pa_wmask;
    load_s2b_pa_wmask = 1'b0;
    s2b_dfi_ctrlupd_ack2_ch0 = rff_s2b_dfi_ctrlupd_ack2_ch0;
    load_s2b_dfi_ctrlupd_ack2_ch0 = 1'b0;
    s2b_dfi_reset_n_in = rff_s2b_dfi_reset_n_in;
    load_s2b_dfi_reset_n_in = 1'b0;
    s2b_init_mr_done_in = rff_s2b_init_mr_done_in;
    load_s2b_init_mr_done_in = 1'b0;
    b2s_csysack_0 = rff_b2s_csysack_0;
    load_b2s_csysack_0 = 1'b0;
    b2s_cactive_0 = rff_b2s_cactive_0;
    load_b2s_cactive_0 = 1'b0;
    b2s_csysack_ddrc = rff_b2s_csysack_ddrc;
    load_b2s_csysack_ddrc = 1'b0;
    b2s_cactive_ddrc = rff_b2s_cactive_ddrc;
    load_b2s_cactive_ddrc = 1'b0;
    b2s_rd_mrr_data_valid = rff_b2s_rd_mrr_data_valid;
    load_b2s_rd_mrr_data_valid = 1'b0;
    b2s_dfi_reset_n_ref = rff_b2s_dfi_reset_n_ref;
    load_b2s_dfi_reset_n_ref = 1'b0;
    b2s_init_mr_done_out = rff_b2s_init_mr_done_out;
    load_b2s_init_mr_done_out = 1'b0;
    b2s_dfi_alert_err_intr = rff_b2s_dfi_alert_err_intr;
    load_b2s_dfi_alert_err_intr = 1'b0;
    s2b_BypassModeEnAC = rff_s2b_BypassModeEnAC;
    load_s2b_BypassModeEnAC = 1'b0;
    s2b_BypassModeEnDAT = rff_s2b_BypassModeEnDAT;
    load_s2b_BypassModeEnDAT = 1'b0;
    s2b_BypassModeEnMASTER = rff_s2b_BypassModeEnMASTER;
    load_s2b_BypassModeEnMASTER = 1'b0;
    ddr_pwr_on = rff_ddr_pwr_on;
    load_ddr_pwr_on = 1'b0;
    debug_info_enable = rff_debug_info_enable;
    load_debug_info_enable = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTENDAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassOutEnDAT;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassOutDataDAT;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_BYPASSINDATADAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_BypassInDataDAT;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_RD_MRR_DATA_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_rd_mrr_data;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTENAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassOutEnAC;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassOutDataAC;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_BYPASSINDATAAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_BypassInDataAC;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_hif_refresh_req_bank;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PA_RMASK_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pa_rmask;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_stat_ddrc_reg_selfref_type;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassOutEnMASTER;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassOutDataMASTER;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_BypassInDataMASTER;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_core_ddrc_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PWR_OK_IN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pwr_ok_in;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_ARESETN_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_aresetn_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PRESETN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_presetn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_CSYSREQ_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_csysreq_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_CSYSREQ_DDRC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_csysreq_ddrc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PA_WMASK_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pa_wmask;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_dfi_ctrlupd_ack2_ch0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_DFI_RESET_N_IN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_dfi_reset_n_in;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_init_mr_done_in;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CSYSACK_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_csysack_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CACTIVE_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_cactive_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CSYSACK_DDRC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_csysack_ddrc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CACTIVE_DDRC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_cactive_ddrc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_rd_mrr_data_valid;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_DFI_RESET_N_REF_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_dfi_reset_n_ref;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_init_mr_done_out;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_dfi_alert_err_intr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSMODEENAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassModeEnAC;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSMODEENDAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassModeEnDAT;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_BypassModeEnMASTER;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_DDR_PWR_ON_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_ddr_pwr_on;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          data = rff_debug_info_enable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_DDR_TOP_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTENDAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassOutEnDAT = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSOUTENDAT_WIDTH - 1 : 0];
          load_s2b_BypassOutEnDAT = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassOutDataDAT = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSOUTDATADAT_WIDTH - 1 : 0];
          load_s2b_BypassOutDataDAT = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_BYPASSINDATADAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_BypassInDataDAT = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_BYPASSINDATADAT_WIDTH - 1 : 0];
          load_b2s_BypassInDataDAT = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_RD_MRR_DATA_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_rd_mrr_data = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_RD_MRR_DATA_WIDTH - 1 : 0];
          load_b2s_rd_mrr_data = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTENAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassOutEnAC = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSOUTENAC_WIDTH - 1 : 0];
          load_s2b_BypassOutEnAC = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassOutDataAC = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSOUTDATAAC_WIDTH - 1 : 0];
          load_s2b_BypassOutDataAC = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_BYPASSINDATAAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_BypassInDataAC = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_BYPASSINDATAAC_WIDTH - 1 : 0];
          load_b2s_BypassInDataAC = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_hif_refresh_req_bank = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_HIF_REFRESH_REQ_BANK_WIDTH - 1 : 0];
          load_b2s_hif_refresh_req_bank = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PA_RMASK_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_pa_rmask = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_PA_RMASK_WIDTH - 1 : 0];
          load_s2b_pa_rmask = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_stat_ddrc_reg_selfref_type = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_STAT_DDRC_REG_SELFREF_TYPE_WIDTH - 1 : 0];
          load_b2s_stat_ddrc_reg_selfref_type = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassOutEnMASTER = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSOUTENMASTER_WIDTH - 1 : 0];
          load_s2b_BypassOutEnMASTER = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassOutDataMASTER = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSOUTDATAMASTER_WIDTH - 1 : 0];
          load_s2b_BypassOutDataMASTER = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_BypassInDataMASTER = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_BYPASSINDATAMASTER_WIDTH - 1 : 0];
          load_b2s_BypassInDataMASTER = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_core_ddrc_rstn = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_WIDTH - 1 : 0];
          load_s2b_core_ddrc_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PWR_OK_IN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_pwr_ok_in = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_PWR_OK_IN_WIDTH - 1 : 0];
          load_s2b_pwr_ok_in = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_ARESETN_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_aresetn_0 = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_ARESETN_0_WIDTH - 1 : 0];
          load_s2b_aresetn_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PRESETN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_presetn = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_PRESETN_WIDTH - 1 : 0];
          load_s2b_presetn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_CSYSREQ_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_csysreq_0 = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_CSYSREQ_0_WIDTH - 1 : 0];
          load_s2b_csysreq_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_CSYSREQ_DDRC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_csysreq_ddrc = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_CSYSREQ_DDRC_WIDTH - 1 : 0];
          load_s2b_csysreq_ddrc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_PA_WMASK_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_pa_wmask = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_PA_WMASK_WIDTH - 1 : 0];
          load_s2b_pa_wmask = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_dfi_ctrlupd_ack2_ch0 = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_WIDTH - 1 : 0];
          load_s2b_dfi_ctrlupd_ack2_ch0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_DFI_RESET_N_IN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_dfi_reset_n_in = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_DFI_RESET_N_IN_WIDTH - 1 : 0];
          load_s2b_dfi_reset_n_in = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_init_mr_done_in = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_WIDTH - 1 : 0];
          load_s2b_init_mr_done_in = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CSYSACK_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_csysack_0 = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_CSYSACK_0_WIDTH - 1 : 0];
          load_b2s_csysack_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CACTIVE_0_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_cactive_0 = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_CACTIVE_0_WIDTH - 1 : 0];
          load_b2s_cactive_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CSYSACK_DDRC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_csysack_ddrc = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_CSYSACK_DDRC_WIDTH - 1 : 0];
          load_b2s_csysack_ddrc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_CACTIVE_DDRC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_cactive_ddrc = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_CACTIVE_DDRC_WIDTH - 1 : 0];
          load_b2s_cactive_ddrc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_rd_mrr_data_valid = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_WIDTH - 1 : 0];
          load_b2s_rd_mrr_data_valid = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_DFI_RESET_N_REF_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_dfi_reset_n_ref = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_DFI_RESET_N_REF_WIDTH - 1 : 0];
          load_b2s_dfi_reset_n_ref = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_init_mr_done_out = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_INIT_MR_DONE_OUT_WIDTH - 1 : 0];
          load_b2s_init_mr_done_out = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          b2s_dfi_alert_err_intr = station2brb_req_w.wdata[STATION_DDR_TOP_B2S_DFI_ALERT_ERR_INTR_WIDTH - 1 : 0];
          load_b2s_dfi_alert_err_intr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSMODEENAC_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassModeEnAC = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSMODEENAC_WIDTH - 1 : 0];
          load_s2b_BypassModeEnAC = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSMODEENDAT_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassModeEnDAT = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSMODEENDAT_WIDTH - 1 : 0];
          load_s2b_BypassModeEnDAT = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          s2b_BypassModeEnMASTER = station2brb_req_w.wdata[STATION_DDR_TOP_S2B_BYPASSMODEENMASTER_WIDTH - 1 : 0];
          load_s2b_BypassModeEnMASTER = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_DDR_PWR_ON_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          ddr_pwr_on = station2brb_req_w.wdata[STATION_DDR_TOP_DDR_PWR_ON_WIDTH - 1 : 0];
          load_ddr_pwr_on = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DDR_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DDR_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DDR_TOP_DATA_WIDTH/8)]} == (STATION_DDR_TOP_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_DDR_TOP_DATA_WIDTH/8)))): begin
          debug_info_enable = station2brb_req_w.wdata[STATION_DDR_TOP_DEBUG_INFO_ENABLE_WIDTH - 1 : 0];
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
