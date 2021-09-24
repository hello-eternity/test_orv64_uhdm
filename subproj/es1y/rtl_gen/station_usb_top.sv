
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_USB_TOP_PKG__SV
`define STATION_USB_TOP_PKG__SV
package station_usb_top_pkg;
  localparam int STATION_USB_TOP_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_USB_TOP_DATA_WIDTH = 'h40;
  localparam [STATION_USB_TOP_RING_ADDR_WIDTH-1:0] STATION_USB_TOP_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_USB_TOP_BLKID = 'h7;
  localparam int STATION_USB_TOP_BLKID_WIDTH = 'h5;
  localparam bit [25 - 1:0] STATION_USB_TOP_USB3_CFG_OFFSET = 64'h0;
  localparam int STATION_USB_TOP_USB3_CFG_WIDTH  = 524288;
  localparam bit [64 - 1:0] STATION_USB_TOP_USB3_CFG_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_USB3_CFG_ADDR = 64'h700000;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_OFFSET = 64'h10000;
  localparam int STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_ADDR = 64'h710000;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_OFFSET = 64'h10008;
  localparam int STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_ADDR = 64'h710008;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_OFFSET = 64'h10010;
  localparam int STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_ADDR = 64'h710010;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_OFFSET = 64'h10018;
  localparam int STATION_USB_TOP_B2S_DEBUG_WIDTH  = 62;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_DEBUG_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_ADDR = 64'h710018;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_U3PMU_OFFSET = 64'h10020;
  localparam int STATION_USB_TOP_B2S_DEBUG_U3PMU_WIDTH  = 39;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_DEBUG_U3PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_U3PMU_ADDR = 64'h710020;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_OFFSET = 64'h10028;
  localparam int STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_WIDTH  = 30;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_ADDR = 64'h710028;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_GP_IN_OFFSET = 64'h10030;
  localparam int STATION_USB_TOP_S2B_GP_IN_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_GP_IN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_GP_IN_ADDR = 64'h710030;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_GP_OUT_OFFSET = 64'h10038;
  localparam int STATION_USB_TOP_B2S_GP_OUT_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_GP_OUT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_GP_OUT_ADDR = 64'h710038;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_DATA_IN_OFFSET = 64'h10040;
  localparam int STATION_USB_TOP_S2B_CR_DATA_IN_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_CR_DATA_IN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_DATA_IN_ADDR = 64'h710040;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CR_DATA_OUT_OFFSET = 64'h10048;
  localparam int STATION_USB_TOP_B2S_CR_DATA_OUT_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_CR_DATA_OUT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CR_DATA_OUT_ADDR = 64'h710048;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_OFFSET = 64'h10050;
  localparam int STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_WIDTH  = 10;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_RSTVAL = 'h3ff;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_ADDR = 64'h710050;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_OFFSET = 64'h10058;
  localparam int STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_WIDTH  = 9;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_ADDR = 64'h710058;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_OFFSET = 64'h10060;
  localparam int STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_WIDTH  = 7;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_RSTVAL = 'h7f;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_ADDR = 64'h710060;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_MPLL_MULTIPLIER_OFFSET = 64'h10068;
  localparam int STATION_USB_TOP_S2B_MPLL_MULTIPLIER_WIDTH  = 7;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_MPLL_MULTIPLIER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_MPLL_MULTIPLIER_ADDR = 64'h710068;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_OFFSET = 64'h10070;
  localparam int STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_WIDTH  = 6;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_RSTVAL = 'h1c;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_ADDR = 64'h710070;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_OFFSET = 64'h10078;
  localparam int STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_WIDTH  = 6;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_RSTVAL = 'h1c;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_ADDR = 64'h710078;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_FSEL_OFFSET = 64'h10080;
  localparam int STATION_USB_TOP_S2B_FSEL_WIDTH  = 6;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_FSEL_RSTVAL = 'b100111;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_FSEL_ADDR = 64'h710080;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LOS_LEVEL_OFFSET = 64'h10088;
  localparam int STATION_USB_TOP_S2B_LOS_LEVEL_WIDTH  = 5;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_LOS_LEVEL_RSTVAL = 'h9;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LOS_LEVEL_ADDR = 64'h710088;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_OFFSET = 64'h10090;
  localparam int STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_WIDTH  = 5;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_ADDR = 64'h710090;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXFSLSTUNE0_OFFSET = 64'h10098;
  localparam int STATION_USB_TOP_S2B_TXFSLSTUNE0_WIDTH  = 4;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TXFSLSTUNE0_RSTVAL = 'h3;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXFSLSTUNE0_ADDR = 64'h710098;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXVREFTUNE0_OFFSET = 64'h100a0;
  localparam int STATION_USB_TOP_S2B_TXVREFTUNE0_WIDTH  = 4;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TXVREFTUNE0_RSTVAL = 'h8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXVREFTUNE0_ADDR = 64'h7100a0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_OFFSET = 64'h100a8;
  localparam int STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_WIDTH  = 4;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_ADDR = 64'h7100a8;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CLK_GATE_CTRL_OFFSET = 64'h100b0;
  localparam int STATION_USB_TOP_B2S_CLK_GATE_CTRL_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_CLK_GATE_CTRL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CLK_GATE_CTRL_ADDR = 64'h7100b0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_COMPDISTUNE0_OFFSET = 64'h100b8;
  localparam int STATION_USB_TOP_S2B_COMPDISTUNE0_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_COMPDISTUNE0_RSTVAL = 'h4;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_COMPDISTUNE0_ADDR = 64'h7100b8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_OTGTUNE0_OFFSET = 64'h100c0;
  localparam int STATION_USB_TOP_S2B_OTGTUNE0_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_OTGTUNE0_RSTVAL = 'h4;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_OTGTUNE0_ADDR = 64'h7100c0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_SQRXTUNE0_OFFSET = 64'h100c8;
  localparam int STATION_USB_TOP_S2B_SQRXTUNE0_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_SQRXTUNE0_RSTVAL = 'h3;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_SQRXTUNE0_ADDR = 64'h7100c8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LOS_BIAS_OFFSET = 64'h100d0;
  localparam int STATION_USB_TOP_S2B_LOS_BIAS_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_LOS_BIAS_RSTVAL = 'h4;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LOS_BIAS_ADDR = 64'h7100d0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TX_VBOOST_LVL_OFFSET = 64'h100d8;
  localparam int STATION_USB_TOP_S2B_TX_VBOOST_LVL_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TX_VBOOST_LVL_RSTVAL = 'h4;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TX_VBOOST_LVL_ADDR = 64'h7100d8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_SSC_RANGE_OFFSET = 64'h100e0;
  localparam int STATION_USB_TOP_S2B_SSC_RANGE_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_SSC_RANGE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_SSC_RANGE_ADDR = 64'h7100e0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXHSXVTUNE0_OFFSET = 64'h100e8;
  localparam int STATION_USB_TOP_S2B_TXHSXVTUNE0_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TXHSXVTUNE0_RSTVAL = 'h3;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXHSXVTUNE0_ADDR = 64'h7100e8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_OFFSET = 64'h100f0;
  localparam int STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_ADDR = 64'h7100f0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXRESTUNE0_OFFSET = 64'h100f8;
  localparam int STATION_USB_TOP_S2B_TXRESTUNE0_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TXRESTUNE0_RSTVAL = 'h1;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXRESTUNE0_ADDR = 64'h7100f8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXRISETUNE0_OFFSET = 64'h10100;
  localparam int STATION_USB_TOP_S2B_TXRISETUNE0_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TXRISETUNE0_RSTVAL = 'h2;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXRISETUNE0_ADDR = 64'h710100;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VDATREFTUNE0_OFFSET = 64'h10108;
  localparam int STATION_USB_TOP_S2B_VDATREFTUNE0_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_VDATREFTUNE0_RSTVAL = 'h1;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VDATREFTUNE0_ADDR = 64'h710108;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_OFFSET = 64'h10110;
  localparam int STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_ADDR = 64'h710110;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_OFFSET = 64'h10118;
  localparam int STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_ADDR = 64'h710118;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_OFFSET = 64'h10120;
  localparam int STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_ADDR = 64'h710120;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VCC_RESET_N_OFFSET = 64'h10128;
  localparam int STATION_USB_TOP_S2B_VCC_RESET_N_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_VCC_RESET_N_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VCC_RESET_N_ADDR = 64'h710128;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VAUX_RESET_N_OFFSET = 64'h10130;
  localparam int STATION_USB_TOP_S2B_VAUX_RESET_N_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_VAUX_RESET_N_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VAUX_RESET_N_ADDR = 64'h710130;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM0_SLP_OFFSET = 64'h10138;
  localparam int STATION_USB_TOP_S2B_RAM0_SLP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_RAM0_SLP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM0_SLP_ADDR = 64'h710138;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM0_SD_OFFSET = 64'h10140;
  localparam int STATION_USB_TOP_S2B_RAM0_SD_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_RAM0_SD_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM0_SD_ADDR = 64'h710140;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM1_SLP_OFFSET = 64'h10148;
  localparam int STATION_USB_TOP_S2B_RAM1_SLP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_RAM1_SLP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM1_SLP_ADDR = 64'h710148;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM1_SD_OFFSET = 64'h10150;
  localparam int STATION_USB_TOP_S2B_RAM1_SD_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_RAM1_SD_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM1_SD_ADDR = 64'h710150;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM2_SLP_OFFSET = 64'h10158;
  localparam int STATION_USB_TOP_S2B_RAM2_SLP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_RAM2_SLP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM2_SLP_ADDR = 64'h710158;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM2_SD_OFFSET = 64'h10160;
  localparam int STATION_USB_TOP_S2B_RAM2_SD_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_RAM2_SD_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RAM2_SD_ADDR = 64'h710160;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_OFFSET = 64'h10168;
  localparam int STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_ADDR = 64'h710168;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RTUNE_REQ_OFFSET = 64'h10170;
  localparam int STATION_USB_TOP_S2B_RTUNE_REQ_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_RTUNE_REQ_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_RTUNE_REQ_ADDR = 64'h710170;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_RTUNE_ACK_OFFSET = 64'h10178;
  localparam int STATION_USB_TOP_B2S_RTUNE_ACK_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_RTUNE_ACK_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_RTUNE_ACK_ADDR = 64'h710178;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_ATERESET_OFFSET = 64'h10180;
  localparam int STATION_USB_TOP_S2B_ATERESET_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_ATERESET_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_ATERESET_ADDR = 64'h710180;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LOOPBACKENB0_OFFSET = 64'h10188;
  localparam int STATION_USB_TOP_S2B_LOOPBACKENB0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_LOOPBACKENB0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LOOPBACKENB0_ADDR = 64'h710188;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_OFFSET = 64'h10190;
  localparam int STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_ADDR = 64'h710190;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_OFFSET = 64'h10198;
  localparam int STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_ADDR = 64'h710198;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VATESTENB_OFFSET = 64'h101a0;
  localparam int STATION_USB_TOP_S2B_VATESTENB_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_VATESTENB_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_VATESTENB_ADDR = 64'h7101a0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_CAP_ADDR_OFFSET = 64'h101a8;
  localparam int STATION_USB_TOP_S2B_CR_CAP_ADDR_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_CR_CAP_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_CAP_ADDR_ADDR = 64'h7101a8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_CAP_DATA_OFFSET = 64'h101b0;
  localparam int STATION_USB_TOP_S2B_CR_CAP_DATA_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_CR_CAP_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_CAP_DATA_ADDR = 64'h7101b0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_READ_OFFSET = 64'h101b8;
  localparam int STATION_USB_TOP_S2B_CR_READ_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_CR_READ_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_READ_ADDR = 64'h7101b8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_WRITE_OFFSET = 64'h101c0;
  localparam int STATION_USB_TOP_S2B_CR_WRITE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_CR_WRITE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_CR_WRITE_ADDR = 64'h7101c0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CR_ACK_OFFSET = 64'h101c8;
  localparam int STATION_USB_TOP_B2S_CR_ACK_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_CR_ACK_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CR_ACK_ADDR = 64'h7101c8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_REF_SSP_EN_OFFSET = 64'h101d0;
  localparam int STATION_USB_TOP_S2B_REF_SSP_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_REF_SSP_EN_RSTVAL = 'h1;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_REF_SSP_EN_ADDR = 64'h7101d0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_REF_USE_PAD_OFFSET = 64'h101d8;
  localparam int STATION_USB_TOP_S2B_REF_USE_PAD_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_REF_USE_PAD_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_REF_USE_PAD_ADDR = 64'h7101d8;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2ICG_PLLCLK_EN_OFFSET = 64'h101e0;
  localparam int STATION_USB_TOP_S2ICG_PLLCLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2ICG_PLLCLK_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2ICG_PLLCLK_EN_ADDR = 64'h7101e0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2ICG_REFCLK_EN_OFFSET = 64'h101e8;
  localparam int STATION_USB_TOP_S2ICG_REFCLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2ICG_REFCLK_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2ICG_REFCLK_EN_ADDR = 64'h7101e8;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_OFFSET = 64'h101f0;
  localparam int STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_ADDR = 64'h7101f0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_REF_CLKDIV2_OFFSET = 64'h101f8;
  localparam int STATION_USB_TOP_S2B_REF_CLKDIV2_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_REF_CLKDIV2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_REF_CLKDIV2_ADDR = 64'h7101f8;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_OFFSET = 64'h10200;
  localparam int STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_ADDR = 64'h710200;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_OFFSET = 64'h10208;
  localparam int STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_ADDR = 64'h710208;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_OFFSET = 64'h10210;
  localparam int STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_ADDR = 64'h710210;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_OFFSET = 64'h10218;
  localparam int STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_ADDR = 64'h710218;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_OFFSET = 64'h10220;
  localparam int STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_ADDR = 64'h710220;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_OFFSET = 64'h10228;
  localparam int STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_ADDR = 64'h710228;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_OFFSET = 64'h10230;
  localparam int STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_ADDR = 64'h710230;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_DONE_OFFSET = 64'h10238;
  localparam int STATION_USB_TOP_S2DFT_MBIST_DONE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2DFT_MBIST_DONE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_DONE_ADDR = 64'h710238;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_OFFSET = 64'h10240;
  localparam int STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_ADDR = 64'h710240;
  localparam bit [25 - 1:0] STATION_USB_TOP_DEBUG_INFO_ENABLE_OFFSET = 64'h10248;
  localparam int STATION_USB_TOP_DEBUG_INFO_ENABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_USB_TOP_DEBUG_INFO_ENABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_USB_TOP_DEBUG_INFO_ENABLE_ADDR = 64'h710248;
endpackage
`endif
`ifndef STATION_USB_TOP__SV
`define STATION_USB_TOP__SV
module station_usb_top
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_usb_top_pkg::*;
  (
  output [STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_WIDTH - 1 : 0] out_b2s_debug_u2pmu_lo,
  output [STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_WIDTH - 1 : 0] out_s2dft_mbist_error_log_hi,
  output [STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_WIDTH - 1 : 0] out_s2dft_mbist_error_log_lo,
  output [STATION_USB_TOP_B2S_DEBUG_WIDTH - 1 : 0] out_b2s_debug,
  output [STATION_USB_TOP_B2S_DEBUG_U3PMU_WIDTH - 1 : 0] out_b2s_debug_u3pmu,
  output [STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_WIDTH - 1 : 0] out_s2b_pm_pmu_config_strap,
  output [STATION_USB_TOP_S2B_GP_IN_WIDTH - 1 : 0] out_s2b_gp_in,
  output [STATION_USB_TOP_B2S_GP_OUT_WIDTH - 1 : 0] out_b2s_gp_out,
  output [STATION_USB_TOP_S2B_CR_DATA_IN_WIDTH - 1 : 0] out_s2b_cr_data_in,
  output [STATION_USB_TOP_B2S_CR_DATA_OUT_WIDTH - 1 : 0] out_b2s_cr_data_out,
  output [STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_WIDTH - 1 : 0] out_s2b_pcs_rx_los_mask_val,
  output [STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_WIDTH - 1 : 0] out_s2b_ssc_ref_clk_sel,
  output [STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_WIDTH - 1 : 0] out_s2b_pcs_tx_swing_full,
  output [STATION_USB_TOP_S2B_MPLL_MULTIPLIER_WIDTH - 1 : 0] out_s2b_mpll_multiplier,
  output [STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_WIDTH - 1 : 0] out_s2b_pcs_tx_deemph_3p5db,
  output [STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_WIDTH - 1 : 0] out_s2b_pcs_tx_deemph_6db,
  output [STATION_USB_TOP_S2B_FSEL_WIDTH - 1 : 0] out_s2b_fsel,
  output [STATION_USB_TOP_S2B_LOS_LEVEL_WIDTH - 1 : 0] out_s2b_los_level,
  output [STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_WIDTH - 1 : 0] out_s2b_lane0_tx_term_offset,
  output [STATION_USB_TOP_S2B_TXFSLSTUNE0_WIDTH - 1 : 0] out_s2b_TXFSLSTUNE0,
  output [STATION_USB_TOP_S2B_TXVREFTUNE0_WIDTH - 1 : 0] out_s2b_TXVREFTUNE0,
  output [STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_WIDTH - 1 : 0] out_b2s_debug_u2pmu_hi,
  output [STATION_USB_TOP_B2S_CLK_GATE_CTRL_WIDTH - 1 : 0] out_b2s_clk_gate_ctrl,
  output [STATION_USB_TOP_S2B_COMPDISTUNE0_WIDTH - 1 : 0] out_s2b_COMPDISTUNE0,
  output [STATION_USB_TOP_S2B_OTGTUNE0_WIDTH - 1 : 0] out_s2b_OTGTUNE0,
  output [STATION_USB_TOP_S2B_SQRXTUNE0_WIDTH - 1 : 0] out_s2b_SQRXTUNE0,
  output [STATION_USB_TOP_S2B_LOS_BIAS_WIDTH - 1 : 0] out_s2b_los_bias,
  output [STATION_USB_TOP_S2B_TX_VBOOST_LVL_WIDTH - 1 : 0] out_s2b_tx_vboost_lvl,
  output [STATION_USB_TOP_S2B_SSC_RANGE_WIDTH - 1 : 0] out_s2b_ssc_range,
  output [STATION_USB_TOP_S2B_TXHSXVTUNE0_WIDTH - 1 : 0] out_s2b_TXHSXVTUNE0,
  output [STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_WIDTH - 1 : 0] out_s2b_TXPREEMPAMPTUNE0,
  output [STATION_USB_TOP_S2B_TXRESTUNE0_WIDTH - 1 : 0] out_s2b_TXRESTUNE0,
  output [STATION_USB_TOP_S2B_TXRISETUNE0_WIDTH - 1 : 0] out_s2b_TXRISETUNE0,
  output [STATION_USB_TOP_S2B_VDATREFTUNE0_WIDTH - 1 : 0] out_s2b_VDATREFTUNE0,
  output [STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_WIDTH - 1 : 0] out_s2b_pm_power_state_request,
  output [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_WIDTH - 1 : 0] out_b2s_current_power_state_u2pmu,
  output [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_WIDTH - 1 : 0] out_b2s_current_power_state_u3pmu,
  output out_s2b_vcc_reset_n,
  output out_s2b_vaux_reset_n,
  output out_s2b_ram0_slp,
  output out_s2b_ram0_sd,
  output out_s2b_ram1_slp,
  output out_s2b_ram1_sd,
  output out_s2b_ram2_slp,
  output out_s2b_ram2_sd,
  output out_s2b_TXPREEMPPULSETUNE0,
  output out_s2b_rtune_req,
  output out_b2s_rtune_ack,
  output out_s2b_ATERESET,
  output out_s2b_LOOPBACKENB0,
  output out_s2b_test_powerdown_hsp,
  output out_s2b_test_powerdown_ssp,
  output out_s2b_VATESTENB,
  output out_s2b_cr_cap_addr,
  output out_s2b_cr_cap_data,
  output out_s2b_cr_read,
  output out_s2b_cr_write,
  output out_b2s_cr_ack,
  output out_s2b_ref_ssp_en,
  output out_s2b_ref_use_pad,
  output out_s2icg_pllclk_en,
  output out_s2icg_refclk_en,
  output out_b2s_mpll_refssc_clk,
  output out_s2b_ref_clkdiv2,
  output out_b2s_pme_generation_u2pmu,
  output out_b2s_connect_state_u2pmu,
  output out_b2s_pme_generation_u3pmu,
  output out_b2s_connect_state_u3pmu,
  output out_s2b_power_switch_control,
  output out_s2b_lane0_ext_pclk_req,
  output out_s2b_lane0_tx2rx_loopbk,
  output out_s2dft_mbist_done,
  output out_s2dft_mbist_func_en,
  output out_debug_info_enable,
  input logic vld_in_b2s_debug_u2pmu_lo,
  input [STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_WIDTH - 1 : 0] in_b2s_debug_u2pmu_lo,
  input logic vld_in_b2s_debug,
  input [STATION_USB_TOP_B2S_DEBUG_WIDTH - 1 : 0] in_b2s_debug,
  input logic vld_in_b2s_debug_u3pmu,
  input [STATION_USB_TOP_B2S_DEBUG_U3PMU_WIDTH - 1 : 0] in_b2s_debug_u3pmu,
  input logic vld_in_b2s_gp_out,
  input [STATION_USB_TOP_B2S_GP_OUT_WIDTH - 1 : 0] in_b2s_gp_out,
  input logic vld_in_b2s_cr_data_out,
  input [STATION_USB_TOP_B2S_CR_DATA_OUT_WIDTH - 1 : 0] in_b2s_cr_data_out,
  input logic vld_in_b2s_debug_u2pmu_hi,
  input [STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_WIDTH - 1 : 0] in_b2s_debug_u2pmu_hi,
  input logic vld_in_b2s_clk_gate_ctrl,
  input [STATION_USB_TOP_B2S_CLK_GATE_CTRL_WIDTH - 1 : 0] in_b2s_clk_gate_ctrl,
  input logic vld_in_b2s_current_power_state_u2pmu,
  input [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_WIDTH - 1 : 0] in_b2s_current_power_state_u2pmu,
  input logic vld_in_b2s_current_power_state_u3pmu,
  input [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_WIDTH - 1 : 0] in_b2s_current_power_state_u3pmu,
  input logic vld_in_b2s_rtune_ack,
  input in_b2s_rtune_ack,
  input logic vld_in_b2s_cr_ack,
  input in_b2s_cr_ack,
  input logic vld_in_b2s_mpll_refssc_clk,
  input in_b2s_mpll_refssc_clk,
  input logic vld_in_b2s_pme_generation_u2pmu,
  input in_b2s_pme_generation_u2pmu,
  input logic vld_in_b2s_connect_state_u2pmu,
  input in_b2s_connect_state_u2pmu,
  input logic vld_in_b2s_pme_generation_u3pmu,
  input in_b2s_pme_generation_u3pmu,
  input logic vld_in_b2s_connect_state_u3pmu,
  input in_b2s_connect_state_u3pmu,
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
  localparam int                                STATION_ID_WIDTH_0 = STATION_USB_TOP_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_USB_TOP_BLKID;

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

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_USB_TOP_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_USB_TOP_MAX_RING_ADDR)) station_u (

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

  logic [STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_WIDTH - 1 : 0] rff_b2s_debug_u2pmu_lo;
  logic [STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_WIDTH - 1 : 0] b2s_debug_u2pmu_lo;
  logic load_b2s_debug_u2pmu_lo;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_debug_u2pmu_lo <= STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_RSTVAL;
    end else if (load_b2s_debug_u2pmu_lo == 1'b1) begin
      rff_b2s_debug_u2pmu_lo <= (wmask & b2s_debug_u2pmu_lo) | (wmask_inv & rff_b2s_debug_u2pmu_lo);

    end else if (vld_in_b2s_debug_u2pmu_lo == 1'b1) begin
      rff_b2s_debug_u2pmu_lo <= in_b2s_debug_u2pmu_lo;
    end
  end
  assign out_b2s_debug_u2pmu_lo = rff_b2s_debug_u2pmu_lo;
  logic [STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_WIDTH - 1 : 0] rff_s2dft_mbist_error_log_hi;
  logic [STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_WIDTH - 1 : 0] s2dft_mbist_error_log_hi;
  logic load_s2dft_mbist_error_log_hi;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2dft_mbist_error_log_hi <= STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_RSTVAL;
    end else if (load_s2dft_mbist_error_log_hi == 1'b1) begin
      rff_s2dft_mbist_error_log_hi <= (wmask & s2dft_mbist_error_log_hi) | (wmask_inv & rff_s2dft_mbist_error_log_hi);
    end
  end
  assign out_s2dft_mbist_error_log_hi = rff_s2dft_mbist_error_log_hi;
  logic [STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_WIDTH - 1 : 0] rff_s2dft_mbist_error_log_lo;
  logic [STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_WIDTH - 1 : 0] s2dft_mbist_error_log_lo;
  logic load_s2dft_mbist_error_log_lo;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2dft_mbist_error_log_lo <= STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_RSTVAL;
    end else if (load_s2dft_mbist_error_log_lo == 1'b1) begin
      rff_s2dft_mbist_error_log_lo <= (wmask & s2dft_mbist_error_log_lo) | (wmask_inv & rff_s2dft_mbist_error_log_lo);
    end
  end
  assign out_s2dft_mbist_error_log_lo = rff_s2dft_mbist_error_log_lo;
  logic [STATION_USB_TOP_B2S_DEBUG_WIDTH - 1 : 0] rff_b2s_debug;
  logic [STATION_USB_TOP_B2S_DEBUG_WIDTH - 1 : 0] b2s_debug;
  logic load_b2s_debug;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_debug <= STATION_USB_TOP_B2S_DEBUG_RSTVAL;
    end else if (load_b2s_debug == 1'b1) begin
      rff_b2s_debug <= (wmask & b2s_debug) | (wmask_inv & rff_b2s_debug);

    end else if (vld_in_b2s_debug == 1'b1) begin
      rff_b2s_debug <= in_b2s_debug;
    end
  end
  assign out_b2s_debug = rff_b2s_debug;
  logic [STATION_USB_TOP_B2S_DEBUG_U3PMU_WIDTH - 1 : 0] rff_b2s_debug_u3pmu;
  logic [STATION_USB_TOP_B2S_DEBUG_U3PMU_WIDTH - 1 : 0] b2s_debug_u3pmu;
  logic load_b2s_debug_u3pmu;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_debug_u3pmu <= STATION_USB_TOP_B2S_DEBUG_U3PMU_RSTVAL;
    end else if (load_b2s_debug_u3pmu == 1'b1) begin
      rff_b2s_debug_u3pmu <= (wmask & b2s_debug_u3pmu) | (wmask_inv & rff_b2s_debug_u3pmu);

    end else if (vld_in_b2s_debug_u3pmu == 1'b1) begin
      rff_b2s_debug_u3pmu <= in_b2s_debug_u3pmu;
    end
  end
  assign out_b2s_debug_u3pmu = rff_b2s_debug_u3pmu;
  logic [STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_WIDTH - 1 : 0] rff_s2b_pm_pmu_config_strap;
  logic [STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_WIDTH - 1 : 0] s2b_pm_pmu_config_strap;
  logic load_s2b_pm_pmu_config_strap;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pm_pmu_config_strap <= STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_RSTVAL;
    end else if (load_s2b_pm_pmu_config_strap == 1'b1) begin
      rff_s2b_pm_pmu_config_strap <= (wmask & s2b_pm_pmu_config_strap) | (wmask_inv & rff_s2b_pm_pmu_config_strap);
    end
  end
  assign out_s2b_pm_pmu_config_strap = rff_s2b_pm_pmu_config_strap;
  logic [STATION_USB_TOP_S2B_GP_IN_WIDTH - 1 : 0] rff_s2b_gp_in;
  logic [STATION_USB_TOP_S2B_GP_IN_WIDTH - 1 : 0] s2b_gp_in;
  logic load_s2b_gp_in;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_gp_in <= STATION_USB_TOP_S2B_GP_IN_RSTVAL;
    end else if (load_s2b_gp_in == 1'b1) begin
      rff_s2b_gp_in <= (wmask & s2b_gp_in) | (wmask_inv & rff_s2b_gp_in);
    end
  end
  assign out_s2b_gp_in = rff_s2b_gp_in;
  logic [STATION_USB_TOP_B2S_GP_OUT_WIDTH - 1 : 0] rff_b2s_gp_out;
  logic [STATION_USB_TOP_B2S_GP_OUT_WIDTH - 1 : 0] b2s_gp_out;
  logic load_b2s_gp_out;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_gp_out <= STATION_USB_TOP_B2S_GP_OUT_RSTVAL;
    end else if (load_b2s_gp_out == 1'b1) begin
      rff_b2s_gp_out <= (wmask & b2s_gp_out) | (wmask_inv & rff_b2s_gp_out);

    end else if (vld_in_b2s_gp_out == 1'b1) begin
      rff_b2s_gp_out <= in_b2s_gp_out;
    end
  end
  assign out_b2s_gp_out = rff_b2s_gp_out;
  logic [STATION_USB_TOP_S2B_CR_DATA_IN_WIDTH - 1 : 0] rff_s2b_cr_data_in;
  logic [STATION_USB_TOP_S2B_CR_DATA_IN_WIDTH - 1 : 0] s2b_cr_data_in;
  logic load_s2b_cr_data_in;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cr_data_in <= STATION_USB_TOP_S2B_CR_DATA_IN_RSTVAL;
    end else if (load_s2b_cr_data_in == 1'b1) begin
      rff_s2b_cr_data_in <= (wmask & s2b_cr_data_in) | (wmask_inv & rff_s2b_cr_data_in);
    end
  end
  assign out_s2b_cr_data_in = rff_s2b_cr_data_in;
  logic [STATION_USB_TOP_B2S_CR_DATA_OUT_WIDTH - 1 : 0] rff_b2s_cr_data_out;
  logic [STATION_USB_TOP_B2S_CR_DATA_OUT_WIDTH - 1 : 0] b2s_cr_data_out;
  logic load_b2s_cr_data_out;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_cr_data_out <= STATION_USB_TOP_B2S_CR_DATA_OUT_RSTVAL;
    end else if (load_b2s_cr_data_out == 1'b1) begin
      rff_b2s_cr_data_out <= (wmask & b2s_cr_data_out) | (wmask_inv & rff_b2s_cr_data_out);

    end else if (vld_in_b2s_cr_data_out == 1'b1) begin
      rff_b2s_cr_data_out <= in_b2s_cr_data_out;
    end
  end
  assign out_b2s_cr_data_out = rff_b2s_cr_data_out;
  logic [STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_WIDTH - 1 : 0] rff_s2b_pcs_rx_los_mask_val;
  logic [STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_WIDTH - 1 : 0] s2b_pcs_rx_los_mask_val;
  logic load_s2b_pcs_rx_los_mask_val;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pcs_rx_los_mask_val <= STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_RSTVAL;
    end else if (load_s2b_pcs_rx_los_mask_val == 1'b1) begin
      rff_s2b_pcs_rx_los_mask_val <= (wmask & s2b_pcs_rx_los_mask_val) | (wmask_inv & rff_s2b_pcs_rx_los_mask_val);
    end
  end
  assign out_s2b_pcs_rx_los_mask_val = rff_s2b_pcs_rx_los_mask_val;
  logic [STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_WIDTH - 1 : 0] rff_s2b_ssc_ref_clk_sel;
  logic [STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_WIDTH - 1 : 0] s2b_ssc_ref_clk_sel;
  logic load_s2b_ssc_ref_clk_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ssc_ref_clk_sel <= STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_RSTVAL;
    end else if (load_s2b_ssc_ref_clk_sel == 1'b1) begin
      rff_s2b_ssc_ref_clk_sel <= (wmask & s2b_ssc_ref_clk_sel) | (wmask_inv & rff_s2b_ssc_ref_clk_sel);
    end
  end
  assign out_s2b_ssc_ref_clk_sel = rff_s2b_ssc_ref_clk_sel;
  logic [STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_WIDTH - 1 : 0] rff_s2b_pcs_tx_swing_full;
  logic [STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_WIDTH - 1 : 0] s2b_pcs_tx_swing_full;
  logic load_s2b_pcs_tx_swing_full;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pcs_tx_swing_full <= STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_RSTVAL;
    end else if (load_s2b_pcs_tx_swing_full == 1'b1) begin
      rff_s2b_pcs_tx_swing_full <= (wmask & s2b_pcs_tx_swing_full) | (wmask_inv & rff_s2b_pcs_tx_swing_full);
    end
  end
  assign out_s2b_pcs_tx_swing_full = rff_s2b_pcs_tx_swing_full;
  logic [STATION_USB_TOP_S2B_MPLL_MULTIPLIER_WIDTH - 1 : 0] rff_s2b_mpll_multiplier;
  logic [STATION_USB_TOP_S2B_MPLL_MULTIPLIER_WIDTH - 1 : 0] s2b_mpll_multiplier;
  logic load_s2b_mpll_multiplier;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_mpll_multiplier <= STATION_USB_TOP_S2B_MPLL_MULTIPLIER_RSTVAL;
    end else if (load_s2b_mpll_multiplier == 1'b1) begin
      rff_s2b_mpll_multiplier <= (wmask & s2b_mpll_multiplier) | (wmask_inv & rff_s2b_mpll_multiplier);
    end
  end
  assign out_s2b_mpll_multiplier = rff_s2b_mpll_multiplier;
  logic [STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_WIDTH - 1 : 0] rff_s2b_pcs_tx_deemph_3p5db;
  logic [STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_WIDTH - 1 : 0] s2b_pcs_tx_deemph_3p5db;
  logic load_s2b_pcs_tx_deemph_3p5db;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pcs_tx_deemph_3p5db <= STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_RSTVAL;
    end else if (load_s2b_pcs_tx_deemph_3p5db == 1'b1) begin
      rff_s2b_pcs_tx_deemph_3p5db <= (wmask & s2b_pcs_tx_deemph_3p5db) | (wmask_inv & rff_s2b_pcs_tx_deemph_3p5db);
    end
  end
  assign out_s2b_pcs_tx_deemph_3p5db = rff_s2b_pcs_tx_deemph_3p5db;
  logic [STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_WIDTH - 1 : 0] rff_s2b_pcs_tx_deemph_6db;
  logic [STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_WIDTH - 1 : 0] s2b_pcs_tx_deemph_6db;
  logic load_s2b_pcs_tx_deemph_6db;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pcs_tx_deemph_6db <= STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_RSTVAL;
    end else if (load_s2b_pcs_tx_deemph_6db == 1'b1) begin
      rff_s2b_pcs_tx_deemph_6db <= (wmask & s2b_pcs_tx_deemph_6db) | (wmask_inv & rff_s2b_pcs_tx_deemph_6db);
    end
  end
  assign out_s2b_pcs_tx_deemph_6db = rff_s2b_pcs_tx_deemph_6db;
  logic [STATION_USB_TOP_S2B_FSEL_WIDTH - 1 : 0] rff_s2b_fsel;
  logic [STATION_USB_TOP_S2B_FSEL_WIDTH - 1 : 0] s2b_fsel;
  logic load_s2b_fsel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_fsel <= STATION_USB_TOP_S2B_FSEL_RSTVAL;
    end else if (load_s2b_fsel == 1'b1) begin
      rff_s2b_fsel <= (wmask & s2b_fsel) | (wmask_inv & rff_s2b_fsel);
    end
  end
  assign out_s2b_fsel = rff_s2b_fsel;
  logic [STATION_USB_TOP_S2B_LOS_LEVEL_WIDTH - 1 : 0] rff_s2b_los_level;
  logic [STATION_USB_TOP_S2B_LOS_LEVEL_WIDTH - 1 : 0] s2b_los_level;
  logic load_s2b_los_level;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_los_level <= STATION_USB_TOP_S2B_LOS_LEVEL_RSTVAL;
    end else if (load_s2b_los_level == 1'b1) begin
      rff_s2b_los_level <= (wmask & s2b_los_level) | (wmask_inv & rff_s2b_los_level);
    end
  end
  assign out_s2b_los_level = rff_s2b_los_level;
  logic [STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_WIDTH - 1 : 0] rff_s2b_lane0_tx_term_offset;
  logic [STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_WIDTH - 1 : 0] s2b_lane0_tx_term_offset;
  logic load_s2b_lane0_tx_term_offset;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_lane0_tx_term_offset <= STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_RSTVAL;
    end else if (load_s2b_lane0_tx_term_offset == 1'b1) begin
      rff_s2b_lane0_tx_term_offset <= (wmask & s2b_lane0_tx_term_offset) | (wmask_inv & rff_s2b_lane0_tx_term_offset);
    end
  end
  assign out_s2b_lane0_tx_term_offset = rff_s2b_lane0_tx_term_offset;
  logic [STATION_USB_TOP_S2B_TXFSLSTUNE0_WIDTH - 1 : 0] rff_s2b_TXFSLSTUNE0;
  logic [STATION_USB_TOP_S2B_TXFSLSTUNE0_WIDTH - 1 : 0] s2b_TXFSLSTUNE0;
  logic load_s2b_TXFSLSTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_TXFSLSTUNE0 <= STATION_USB_TOP_S2B_TXFSLSTUNE0_RSTVAL;
    end else if (load_s2b_TXFSLSTUNE0 == 1'b1) begin
      rff_s2b_TXFSLSTUNE0 <= (wmask & s2b_TXFSLSTUNE0) | (wmask_inv & rff_s2b_TXFSLSTUNE0);
    end
  end
  assign out_s2b_TXFSLSTUNE0 = rff_s2b_TXFSLSTUNE0;
  logic [STATION_USB_TOP_S2B_TXVREFTUNE0_WIDTH - 1 : 0] rff_s2b_TXVREFTUNE0;
  logic [STATION_USB_TOP_S2B_TXVREFTUNE0_WIDTH - 1 : 0] s2b_TXVREFTUNE0;
  logic load_s2b_TXVREFTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_TXVREFTUNE0 <= STATION_USB_TOP_S2B_TXVREFTUNE0_RSTVAL;
    end else if (load_s2b_TXVREFTUNE0 == 1'b1) begin
      rff_s2b_TXVREFTUNE0 <= (wmask & s2b_TXVREFTUNE0) | (wmask_inv & rff_s2b_TXVREFTUNE0);
    end
  end
  assign out_s2b_TXVREFTUNE0 = rff_s2b_TXVREFTUNE0;
  logic [STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_WIDTH - 1 : 0] rff_b2s_debug_u2pmu_hi;
  logic [STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_WIDTH - 1 : 0] b2s_debug_u2pmu_hi;
  logic load_b2s_debug_u2pmu_hi;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_debug_u2pmu_hi <= STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_RSTVAL;
    end else if (load_b2s_debug_u2pmu_hi == 1'b1) begin
      rff_b2s_debug_u2pmu_hi <= (wmask & b2s_debug_u2pmu_hi) | (wmask_inv & rff_b2s_debug_u2pmu_hi);

    end else if (vld_in_b2s_debug_u2pmu_hi == 1'b1) begin
      rff_b2s_debug_u2pmu_hi <= in_b2s_debug_u2pmu_hi;
    end
  end
  assign out_b2s_debug_u2pmu_hi = rff_b2s_debug_u2pmu_hi;
  logic [STATION_USB_TOP_B2S_CLK_GATE_CTRL_WIDTH - 1 : 0] rff_b2s_clk_gate_ctrl;
  logic [STATION_USB_TOP_B2S_CLK_GATE_CTRL_WIDTH - 1 : 0] b2s_clk_gate_ctrl;
  logic load_b2s_clk_gate_ctrl;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_clk_gate_ctrl <= STATION_USB_TOP_B2S_CLK_GATE_CTRL_RSTVAL;
    end else if (load_b2s_clk_gate_ctrl == 1'b1) begin
      rff_b2s_clk_gate_ctrl <= (wmask & b2s_clk_gate_ctrl) | (wmask_inv & rff_b2s_clk_gate_ctrl);

    end else if (vld_in_b2s_clk_gate_ctrl == 1'b1) begin
      rff_b2s_clk_gate_ctrl <= in_b2s_clk_gate_ctrl;
    end
  end
  assign out_b2s_clk_gate_ctrl = rff_b2s_clk_gate_ctrl;
  logic [STATION_USB_TOP_S2B_COMPDISTUNE0_WIDTH - 1 : 0] rff_s2b_COMPDISTUNE0;
  logic [STATION_USB_TOP_S2B_COMPDISTUNE0_WIDTH - 1 : 0] s2b_COMPDISTUNE0;
  logic load_s2b_COMPDISTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_COMPDISTUNE0 <= STATION_USB_TOP_S2B_COMPDISTUNE0_RSTVAL;
    end else if (load_s2b_COMPDISTUNE0 == 1'b1) begin
      rff_s2b_COMPDISTUNE0 <= (wmask & s2b_COMPDISTUNE0) | (wmask_inv & rff_s2b_COMPDISTUNE0);
    end
  end
  assign out_s2b_COMPDISTUNE0 = rff_s2b_COMPDISTUNE0;
  logic [STATION_USB_TOP_S2B_OTGTUNE0_WIDTH - 1 : 0] rff_s2b_OTGTUNE0;
  logic [STATION_USB_TOP_S2B_OTGTUNE0_WIDTH - 1 : 0] s2b_OTGTUNE0;
  logic load_s2b_OTGTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_OTGTUNE0 <= STATION_USB_TOP_S2B_OTGTUNE0_RSTVAL;
    end else if (load_s2b_OTGTUNE0 == 1'b1) begin
      rff_s2b_OTGTUNE0 <= (wmask & s2b_OTGTUNE0) | (wmask_inv & rff_s2b_OTGTUNE0);
    end
  end
  assign out_s2b_OTGTUNE0 = rff_s2b_OTGTUNE0;
  logic [STATION_USB_TOP_S2B_SQRXTUNE0_WIDTH - 1 : 0] rff_s2b_SQRXTUNE0;
  logic [STATION_USB_TOP_S2B_SQRXTUNE0_WIDTH - 1 : 0] s2b_SQRXTUNE0;
  logic load_s2b_SQRXTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_SQRXTUNE0 <= STATION_USB_TOP_S2B_SQRXTUNE0_RSTVAL;
    end else if (load_s2b_SQRXTUNE0 == 1'b1) begin
      rff_s2b_SQRXTUNE0 <= (wmask & s2b_SQRXTUNE0) | (wmask_inv & rff_s2b_SQRXTUNE0);
    end
  end
  assign out_s2b_SQRXTUNE0 = rff_s2b_SQRXTUNE0;
  logic [STATION_USB_TOP_S2B_LOS_BIAS_WIDTH - 1 : 0] rff_s2b_los_bias;
  logic [STATION_USB_TOP_S2B_LOS_BIAS_WIDTH - 1 : 0] s2b_los_bias;
  logic load_s2b_los_bias;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_los_bias <= STATION_USB_TOP_S2B_LOS_BIAS_RSTVAL;
    end else if (load_s2b_los_bias == 1'b1) begin
      rff_s2b_los_bias <= (wmask & s2b_los_bias) | (wmask_inv & rff_s2b_los_bias);
    end
  end
  assign out_s2b_los_bias = rff_s2b_los_bias;
  logic [STATION_USB_TOP_S2B_TX_VBOOST_LVL_WIDTH - 1 : 0] rff_s2b_tx_vboost_lvl;
  logic [STATION_USB_TOP_S2B_TX_VBOOST_LVL_WIDTH - 1 : 0] s2b_tx_vboost_lvl;
  logic load_s2b_tx_vboost_lvl;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_tx_vboost_lvl <= STATION_USB_TOP_S2B_TX_VBOOST_LVL_RSTVAL;
    end else if (load_s2b_tx_vboost_lvl == 1'b1) begin
      rff_s2b_tx_vboost_lvl <= (wmask & s2b_tx_vboost_lvl) | (wmask_inv & rff_s2b_tx_vboost_lvl);
    end
  end
  assign out_s2b_tx_vboost_lvl = rff_s2b_tx_vboost_lvl;
  logic [STATION_USB_TOP_S2B_SSC_RANGE_WIDTH - 1 : 0] rff_s2b_ssc_range;
  logic [STATION_USB_TOP_S2B_SSC_RANGE_WIDTH - 1 : 0] s2b_ssc_range;
  logic load_s2b_ssc_range;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ssc_range <= STATION_USB_TOP_S2B_SSC_RANGE_RSTVAL;
    end else if (load_s2b_ssc_range == 1'b1) begin
      rff_s2b_ssc_range <= (wmask & s2b_ssc_range) | (wmask_inv & rff_s2b_ssc_range);
    end
  end
  assign out_s2b_ssc_range = rff_s2b_ssc_range;
  logic [STATION_USB_TOP_S2B_TXHSXVTUNE0_WIDTH - 1 : 0] rff_s2b_TXHSXVTUNE0;
  logic [STATION_USB_TOP_S2B_TXHSXVTUNE0_WIDTH - 1 : 0] s2b_TXHSXVTUNE0;
  logic load_s2b_TXHSXVTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_TXHSXVTUNE0 <= STATION_USB_TOP_S2B_TXHSXVTUNE0_RSTVAL;
    end else if (load_s2b_TXHSXVTUNE0 == 1'b1) begin
      rff_s2b_TXHSXVTUNE0 <= (wmask & s2b_TXHSXVTUNE0) | (wmask_inv & rff_s2b_TXHSXVTUNE0);
    end
  end
  assign out_s2b_TXHSXVTUNE0 = rff_s2b_TXHSXVTUNE0;
  logic [STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_WIDTH - 1 : 0] rff_s2b_TXPREEMPAMPTUNE0;
  logic [STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_WIDTH - 1 : 0] s2b_TXPREEMPAMPTUNE0;
  logic load_s2b_TXPREEMPAMPTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_TXPREEMPAMPTUNE0 <= STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_RSTVAL;
    end else if (load_s2b_TXPREEMPAMPTUNE0 == 1'b1) begin
      rff_s2b_TXPREEMPAMPTUNE0 <= (wmask & s2b_TXPREEMPAMPTUNE0) | (wmask_inv & rff_s2b_TXPREEMPAMPTUNE0);
    end
  end
  assign out_s2b_TXPREEMPAMPTUNE0 = rff_s2b_TXPREEMPAMPTUNE0;
  logic [STATION_USB_TOP_S2B_TXRESTUNE0_WIDTH - 1 : 0] rff_s2b_TXRESTUNE0;
  logic [STATION_USB_TOP_S2B_TXRESTUNE0_WIDTH - 1 : 0] s2b_TXRESTUNE0;
  logic load_s2b_TXRESTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_TXRESTUNE0 <= STATION_USB_TOP_S2B_TXRESTUNE0_RSTVAL;
    end else if (load_s2b_TXRESTUNE0 == 1'b1) begin
      rff_s2b_TXRESTUNE0 <= (wmask & s2b_TXRESTUNE0) | (wmask_inv & rff_s2b_TXRESTUNE0);
    end
  end
  assign out_s2b_TXRESTUNE0 = rff_s2b_TXRESTUNE0;
  logic [STATION_USB_TOP_S2B_TXRISETUNE0_WIDTH - 1 : 0] rff_s2b_TXRISETUNE0;
  logic [STATION_USB_TOP_S2B_TXRISETUNE0_WIDTH - 1 : 0] s2b_TXRISETUNE0;
  logic load_s2b_TXRISETUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_TXRISETUNE0 <= STATION_USB_TOP_S2B_TXRISETUNE0_RSTVAL;
    end else if (load_s2b_TXRISETUNE0 == 1'b1) begin
      rff_s2b_TXRISETUNE0 <= (wmask & s2b_TXRISETUNE0) | (wmask_inv & rff_s2b_TXRISETUNE0);
    end
  end
  assign out_s2b_TXRISETUNE0 = rff_s2b_TXRISETUNE0;
  logic [STATION_USB_TOP_S2B_VDATREFTUNE0_WIDTH - 1 : 0] rff_s2b_VDATREFTUNE0;
  logic [STATION_USB_TOP_S2B_VDATREFTUNE0_WIDTH - 1 : 0] s2b_VDATREFTUNE0;
  logic load_s2b_VDATREFTUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_VDATREFTUNE0 <= STATION_USB_TOP_S2B_VDATREFTUNE0_RSTVAL;
    end else if (load_s2b_VDATREFTUNE0 == 1'b1) begin
      rff_s2b_VDATREFTUNE0 <= (wmask & s2b_VDATREFTUNE0) | (wmask_inv & rff_s2b_VDATREFTUNE0);
    end
  end
  assign out_s2b_VDATREFTUNE0 = rff_s2b_VDATREFTUNE0;
  logic [STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_WIDTH - 1 : 0] rff_s2b_pm_power_state_request;
  logic [STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_WIDTH - 1 : 0] s2b_pm_power_state_request;
  logic load_s2b_pm_power_state_request;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_pm_power_state_request <= STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_RSTVAL;
    end else if (load_s2b_pm_power_state_request == 1'b1) begin
      rff_s2b_pm_power_state_request <= (wmask & s2b_pm_power_state_request) | (wmask_inv & rff_s2b_pm_power_state_request);
    end
  end
  assign out_s2b_pm_power_state_request = rff_s2b_pm_power_state_request;
  logic [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_WIDTH - 1 : 0] rff_b2s_current_power_state_u2pmu;
  logic [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_WIDTH - 1 : 0] b2s_current_power_state_u2pmu;
  logic load_b2s_current_power_state_u2pmu;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_current_power_state_u2pmu <= STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_RSTVAL;
    end else if (load_b2s_current_power_state_u2pmu == 1'b1) begin
      rff_b2s_current_power_state_u2pmu <= (wmask & b2s_current_power_state_u2pmu) | (wmask_inv & rff_b2s_current_power_state_u2pmu);

    end else if (vld_in_b2s_current_power_state_u2pmu == 1'b1) begin
      rff_b2s_current_power_state_u2pmu <= in_b2s_current_power_state_u2pmu;
    end
  end
  assign out_b2s_current_power_state_u2pmu = rff_b2s_current_power_state_u2pmu;
  logic [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_WIDTH - 1 : 0] rff_b2s_current_power_state_u3pmu;
  logic [STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_WIDTH - 1 : 0] b2s_current_power_state_u3pmu;
  logic load_b2s_current_power_state_u3pmu;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_current_power_state_u3pmu <= STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_RSTVAL;
    end else if (load_b2s_current_power_state_u3pmu == 1'b1) begin
      rff_b2s_current_power_state_u3pmu <= (wmask & b2s_current_power_state_u3pmu) | (wmask_inv & rff_b2s_current_power_state_u3pmu);

    end else if (vld_in_b2s_current_power_state_u3pmu == 1'b1) begin
      rff_b2s_current_power_state_u3pmu <= in_b2s_current_power_state_u3pmu;
    end
  end
  assign out_b2s_current_power_state_u3pmu = rff_b2s_current_power_state_u3pmu;
  logic [STATION_USB_TOP_S2B_VCC_RESET_N_WIDTH - 1 : 0] rff_s2b_vcc_reset_n;
  logic [STATION_USB_TOP_S2B_VCC_RESET_N_WIDTH - 1 : 0] s2b_vcc_reset_n;
  logic load_s2b_vcc_reset_n;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_vcc_reset_n <= STATION_USB_TOP_S2B_VCC_RESET_N_RSTVAL;
    end else if (load_s2b_vcc_reset_n == 1'b1) begin
      rff_s2b_vcc_reset_n <= (wmask & s2b_vcc_reset_n) | (wmask_inv & rff_s2b_vcc_reset_n);
    end
  end
  assign out_s2b_vcc_reset_n = rff_s2b_vcc_reset_n;
  logic [STATION_USB_TOP_S2B_VAUX_RESET_N_WIDTH - 1 : 0] rff_s2b_vaux_reset_n;
  logic [STATION_USB_TOP_S2B_VAUX_RESET_N_WIDTH - 1 : 0] s2b_vaux_reset_n;
  logic load_s2b_vaux_reset_n;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_vaux_reset_n <= STATION_USB_TOP_S2B_VAUX_RESET_N_RSTVAL;
    end else if (load_s2b_vaux_reset_n == 1'b1) begin
      rff_s2b_vaux_reset_n <= (wmask & s2b_vaux_reset_n) | (wmask_inv & rff_s2b_vaux_reset_n);
    end
  end
  assign out_s2b_vaux_reset_n = rff_s2b_vaux_reset_n;
  logic [STATION_USB_TOP_S2B_RAM0_SLP_WIDTH - 1 : 0] rff_s2b_ram0_slp;
  logic [STATION_USB_TOP_S2B_RAM0_SLP_WIDTH - 1 : 0] s2b_ram0_slp;
  logic load_s2b_ram0_slp;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ram0_slp <= STATION_USB_TOP_S2B_RAM0_SLP_RSTVAL;
    end else if (load_s2b_ram0_slp == 1'b1) begin
      rff_s2b_ram0_slp <= (wmask & s2b_ram0_slp) | (wmask_inv & rff_s2b_ram0_slp);
    end
  end
  assign out_s2b_ram0_slp = rff_s2b_ram0_slp;
  logic [STATION_USB_TOP_S2B_RAM0_SD_WIDTH - 1 : 0] rff_s2b_ram0_sd;
  logic [STATION_USB_TOP_S2B_RAM0_SD_WIDTH - 1 : 0] s2b_ram0_sd;
  logic load_s2b_ram0_sd;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ram0_sd <= STATION_USB_TOP_S2B_RAM0_SD_RSTVAL;
    end else if (load_s2b_ram0_sd == 1'b1) begin
      rff_s2b_ram0_sd <= (wmask & s2b_ram0_sd) | (wmask_inv & rff_s2b_ram0_sd);
    end
  end
  assign out_s2b_ram0_sd = rff_s2b_ram0_sd;
  logic [STATION_USB_TOP_S2B_RAM1_SLP_WIDTH - 1 : 0] rff_s2b_ram1_slp;
  logic [STATION_USB_TOP_S2B_RAM1_SLP_WIDTH - 1 : 0] s2b_ram1_slp;
  logic load_s2b_ram1_slp;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ram1_slp <= STATION_USB_TOP_S2B_RAM1_SLP_RSTVAL;
    end else if (load_s2b_ram1_slp == 1'b1) begin
      rff_s2b_ram1_slp <= (wmask & s2b_ram1_slp) | (wmask_inv & rff_s2b_ram1_slp);
    end
  end
  assign out_s2b_ram1_slp = rff_s2b_ram1_slp;
  logic [STATION_USB_TOP_S2B_RAM1_SD_WIDTH - 1 : 0] rff_s2b_ram1_sd;
  logic [STATION_USB_TOP_S2B_RAM1_SD_WIDTH - 1 : 0] s2b_ram1_sd;
  logic load_s2b_ram1_sd;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ram1_sd <= STATION_USB_TOP_S2B_RAM1_SD_RSTVAL;
    end else if (load_s2b_ram1_sd == 1'b1) begin
      rff_s2b_ram1_sd <= (wmask & s2b_ram1_sd) | (wmask_inv & rff_s2b_ram1_sd);
    end
  end
  assign out_s2b_ram1_sd = rff_s2b_ram1_sd;
  logic [STATION_USB_TOP_S2B_RAM2_SLP_WIDTH - 1 : 0] rff_s2b_ram2_slp;
  logic [STATION_USB_TOP_S2B_RAM2_SLP_WIDTH - 1 : 0] s2b_ram2_slp;
  logic load_s2b_ram2_slp;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ram2_slp <= STATION_USB_TOP_S2B_RAM2_SLP_RSTVAL;
    end else if (load_s2b_ram2_slp == 1'b1) begin
      rff_s2b_ram2_slp <= (wmask & s2b_ram2_slp) | (wmask_inv & rff_s2b_ram2_slp);
    end
  end
  assign out_s2b_ram2_slp = rff_s2b_ram2_slp;
  logic [STATION_USB_TOP_S2B_RAM2_SD_WIDTH - 1 : 0] rff_s2b_ram2_sd;
  logic [STATION_USB_TOP_S2B_RAM2_SD_WIDTH - 1 : 0] s2b_ram2_sd;
  logic load_s2b_ram2_sd;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ram2_sd <= STATION_USB_TOP_S2B_RAM2_SD_RSTVAL;
    end else if (load_s2b_ram2_sd == 1'b1) begin
      rff_s2b_ram2_sd <= (wmask & s2b_ram2_sd) | (wmask_inv & rff_s2b_ram2_sd);
    end
  end
  assign out_s2b_ram2_sd = rff_s2b_ram2_sd;
  logic [STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_WIDTH - 1 : 0] rff_s2b_TXPREEMPPULSETUNE0;
  logic [STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_WIDTH - 1 : 0] s2b_TXPREEMPPULSETUNE0;
  logic load_s2b_TXPREEMPPULSETUNE0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_TXPREEMPPULSETUNE0 <= STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_RSTVAL;
    end else if (load_s2b_TXPREEMPPULSETUNE0 == 1'b1) begin
      rff_s2b_TXPREEMPPULSETUNE0 <= (wmask & s2b_TXPREEMPPULSETUNE0) | (wmask_inv & rff_s2b_TXPREEMPPULSETUNE0);
    end
  end
  assign out_s2b_TXPREEMPPULSETUNE0 = rff_s2b_TXPREEMPPULSETUNE0;
  logic [STATION_USB_TOP_S2B_RTUNE_REQ_WIDTH - 1 : 0] rff_s2b_rtune_req;
  logic [STATION_USB_TOP_S2B_RTUNE_REQ_WIDTH - 1 : 0] s2b_rtune_req;
  logic load_s2b_rtune_req;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_rtune_req <= STATION_USB_TOP_S2B_RTUNE_REQ_RSTVAL;
    end else if (load_s2b_rtune_req == 1'b1) begin
      rff_s2b_rtune_req <= (wmask & s2b_rtune_req) | (wmask_inv & rff_s2b_rtune_req);
    end
  end
  assign out_s2b_rtune_req = rff_s2b_rtune_req;
  logic [STATION_USB_TOP_B2S_RTUNE_ACK_WIDTH - 1 : 0] rff_b2s_rtune_ack;
  logic [STATION_USB_TOP_B2S_RTUNE_ACK_WIDTH - 1 : 0] b2s_rtune_ack;
  logic load_b2s_rtune_ack;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_rtune_ack <= STATION_USB_TOP_B2S_RTUNE_ACK_RSTVAL;
    end else if (load_b2s_rtune_ack == 1'b1) begin
      rff_b2s_rtune_ack <= (wmask & b2s_rtune_ack) | (wmask_inv & rff_b2s_rtune_ack);

    end else if (vld_in_b2s_rtune_ack == 1'b1) begin
      rff_b2s_rtune_ack <= in_b2s_rtune_ack;
    end
  end
  assign out_b2s_rtune_ack = rff_b2s_rtune_ack;
  logic [STATION_USB_TOP_S2B_ATERESET_WIDTH - 1 : 0] rff_s2b_ATERESET;
  logic [STATION_USB_TOP_S2B_ATERESET_WIDTH - 1 : 0] s2b_ATERESET;
  logic load_s2b_ATERESET;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ATERESET <= STATION_USB_TOP_S2B_ATERESET_RSTVAL;
    end else if (load_s2b_ATERESET == 1'b1) begin
      rff_s2b_ATERESET <= (wmask & s2b_ATERESET) | (wmask_inv & rff_s2b_ATERESET);
    end
  end
  assign out_s2b_ATERESET = rff_s2b_ATERESET;
  logic [STATION_USB_TOP_S2B_LOOPBACKENB0_WIDTH - 1 : 0] rff_s2b_LOOPBACKENB0;
  logic [STATION_USB_TOP_S2B_LOOPBACKENB0_WIDTH - 1 : 0] s2b_LOOPBACKENB0;
  logic load_s2b_LOOPBACKENB0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_LOOPBACKENB0 <= STATION_USB_TOP_S2B_LOOPBACKENB0_RSTVAL;
    end else if (load_s2b_LOOPBACKENB0 == 1'b1) begin
      rff_s2b_LOOPBACKENB0 <= (wmask & s2b_LOOPBACKENB0) | (wmask_inv & rff_s2b_LOOPBACKENB0);
    end
  end
  assign out_s2b_LOOPBACKENB0 = rff_s2b_LOOPBACKENB0;
  logic [STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_WIDTH - 1 : 0] rff_s2b_test_powerdown_hsp;
  logic [STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_WIDTH - 1 : 0] s2b_test_powerdown_hsp;
  logic load_s2b_test_powerdown_hsp;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_test_powerdown_hsp <= STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_RSTVAL;
    end else if (load_s2b_test_powerdown_hsp == 1'b1) begin
      rff_s2b_test_powerdown_hsp <= (wmask & s2b_test_powerdown_hsp) | (wmask_inv & rff_s2b_test_powerdown_hsp);
    end
  end
  assign out_s2b_test_powerdown_hsp = rff_s2b_test_powerdown_hsp;
  logic [STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_WIDTH - 1 : 0] rff_s2b_test_powerdown_ssp;
  logic [STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_WIDTH - 1 : 0] s2b_test_powerdown_ssp;
  logic load_s2b_test_powerdown_ssp;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_test_powerdown_ssp <= STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_RSTVAL;
    end else if (load_s2b_test_powerdown_ssp == 1'b1) begin
      rff_s2b_test_powerdown_ssp <= (wmask & s2b_test_powerdown_ssp) | (wmask_inv & rff_s2b_test_powerdown_ssp);
    end
  end
  assign out_s2b_test_powerdown_ssp = rff_s2b_test_powerdown_ssp;
  logic [STATION_USB_TOP_S2B_VATESTENB_WIDTH - 1 : 0] rff_s2b_VATESTENB;
  logic [STATION_USB_TOP_S2B_VATESTENB_WIDTH - 1 : 0] s2b_VATESTENB;
  logic load_s2b_VATESTENB;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_VATESTENB <= STATION_USB_TOP_S2B_VATESTENB_RSTVAL;
    end else if (load_s2b_VATESTENB == 1'b1) begin
      rff_s2b_VATESTENB <= (wmask & s2b_VATESTENB) | (wmask_inv & rff_s2b_VATESTENB);
    end
  end
  assign out_s2b_VATESTENB = rff_s2b_VATESTENB;
  logic [STATION_USB_TOP_S2B_CR_CAP_ADDR_WIDTH - 1 : 0] rff_s2b_cr_cap_addr;
  logic [STATION_USB_TOP_S2B_CR_CAP_ADDR_WIDTH - 1 : 0] s2b_cr_cap_addr;
  logic load_s2b_cr_cap_addr;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cr_cap_addr <= STATION_USB_TOP_S2B_CR_CAP_ADDR_RSTVAL;
    end else if (load_s2b_cr_cap_addr == 1'b1) begin
      rff_s2b_cr_cap_addr <= (wmask & s2b_cr_cap_addr) | (wmask_inv & rff_s2b_cr_cap_addr);
    end
  end
  assign out_s2b_cr_cap_addr = rff_s2b_cr_cap_addr;
  logic [STATION_USB_TOP_S2B_CR_CAP_DATA_WIDTH - 1 : 0] rff_s2b_cr_cap_data;
  logic [STATION_USB_TOP_S2B_CR_CAP_DATA_WIDTH - 1 : 0] s2b_cr_cap_data;
  logic load_s2b_cr_cap_data;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cr_cap_data <= STATION_USB_TOP_S2B_CR_CAP_DATA_RSTVAL;
    end else if (load_s2b_cr_cap_data == 1'b1) begin
      rff_s2b_cr_cap_data <= (wmask & s2b_cr_cap_data) | (wmask_inv & rff_s2b_cr_cap_data);
    end
  end
  assign out_s2b_cr_cap_data = rff_s2b_cr_cap_data;
  logic [STATION_USB_TOP_S2B_CR_READ_WIDTH - 1 : 0] rff_s2b_cr_read;
  logic [STATION_USB_TOP_S2B_CR_READ_WIDTH - 1 : 0] s2b_cr_read;
  logic load_s2b_cr_read;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cr_read <= STATION_USB_TOP_S2B_CR_READ_RSTVAL;
    end else if (load_s2b_cr_read == 1'b1) begin
      rff_s2b_cr_read <= (wmask & s2b_cr_read) | (wmask_inv & rff_s2b_cr_read);
    end
  end
  assign out_s2b_cr_read = rff_s2b_cr_read;
  logic [STATION_USB_TOP_S2B_CR_WRITE_WIDTH - 1 : 0] rff_s2b_cr_write;
  logic [STATION_USB_TOP_S2B_CR_WRITE_WIDTH - 1 : 0] s2b_cr_write;
  logic load_s2b_cr_write;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_cr_write <= STATION_USB_TOP_S2B_CR_WRITE_RSTVAL;
    end else if (load_s2b_cr_write == 1'b1) begin
      rff_s2b_cr_write <= (wmask & s2b_cr_write) | (wmask_inv & rff_s2b_cr_write);
    end
  end
  assign out_s2b_cr_write = rff_s2b_cr_write;
  logic [STATION_USB_TOP_B2S_CR_ACK_WIDTH - 1 : 0] rff_b2s_cr_ack;
  logic [STATION_USB_TOP_B2S_CR_ACK_WIDTH - 1 : 0] b2s_cr_ack;
  logic load_b2s_cr_ack;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_cr_ack <= STATION_USB_TOP_B2S_CR_ACK_RSTVAL;
    end else if (load_b2s_cr_ack == 1'b1) begin
      rff_b2s_cr_ack <= (wmask & b2s_cr_ack) | (wmask_inv & rff_b2s_cr_ack);

    end else if (vld_in_b2s_cr_ack == 1'b1) begin
      rff_b2s_cr_ack <= in_b2s_cr_ack;
    end
  end
  assign out_b2s_cr_ack = rff_b2s_cr_ack;
  logic [STATION_USB_TOP_S2B_REF_SSP_EN_WIDTH - 1 : 0] rff_s2b_ref_ssp_en;
  logic [STATION_USB_TOP_S2B_REF_SSP_EN_WIDTH - 1 : 0] s2b_ref_ssp_en;
  logic load_s2b_ref_ssp_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ref_ssp_en <= STATION_USB_TOP_S2B_REF_SSP_EN_RSTVAL;
    end else if (load_s2b_ref_ssp_en == 1'b1) begin
      rff_s2b_ref_ssp_en <= (wmask & s2b_ref_ssp_en) | (wmask_inv & rff_s2b_ref_ssp_en);
    end
  end
  assign out_s2b_ref_ssp_en = rff_s2b_ref_ssp_en;
  logic [STATION_USB_TOP_S2B_REF_USE_PAD_WIDTH - 1 : 0] rff_s2b_ref_use_pad;
  logic [STATION_USB_TOP_S2B_REF_USE_PAD_WIDTH - 1 : 0] s2b_ref_use_pad;
  logic load_s2b_ref_use_pad;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ref_use_pad <= STATION_USB_TOP_S2B_REF_USE_PAD_RSTVAL;
    end else if (load_s2b_ref_use_pad == 1'b1) begin
      rff_s2b_ref_use_pad <= (wmask & s2b_ref_use_pad) | (wmask_inv & rff_s2b_ref_use_pad);
    end
  end
  assign out_s2b_ref_use_pad = rff_s2b_ref_use_pad;
  logic [STATION_USB_TOP_S2ICG_PLLCLK_EN_WIDTH - 1 : 0] rff_s2icg_pllclk_en;
  logic [STATION_USB_TOP_S2ICG_PLLCLK_EN_WIDTH - 1 : 0] s2icg_pllclk_en;
  logic load_s2icg_pllclk_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2icg_pllclk_en <= STATION_USB_TOP_S2ICG_PLLCLK_EN_RSTVAL;
    end else if (load_s2icg_pllclk_en == 1'b1) begin
      rff_s2icg_pllclk_en <= (wmask & s2icg_pllclk_en) | (wmask_inv & rff_s2icg_pllclk_en);
    end
  end
  assign out_s2icg_pllclk_en = rff_s2icg_pllclk_en;
  logic [STATION_USB_TOP_S2ICG_REFCLK_EN_WIDTH - 1 : 0] rff_s2icg_refclk_en;
  logic [STATION_USB_TOP_S2ICG_REFCLK_EN_WIDTH - 1 : 0] s2icg_refclk_en;
  logic load_s2icg_refclk_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2icg_refclk_en <= STATION_USB_TOP_S2ICG_REFCLK_EN_RSTVAL;
    end else if (load_s2icg_refclk_en == 1'b1) begin
      rff_s2icg_refclk_en <= (wmask & s2icg_refclk_en) | (wmask_inv & rff_s2icg_refclk_en);
    end
  end
  assign out_s2icg_refclk_en = rff_s2icg_refclk_en;
  logic [STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_WIDTH - 1 : 0] rff_b2s_mpll_refssc_clk;
  logic [STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_WIDTH - 1 : 0] b2s_mpll_refssc_clk;
  logic load_b2s_mpll_refssc_clk;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_mpll_refssc_clk <= STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_RSTVAL;
    end else if (load_b2s_mpll_refssc_clk == 1'b1) begin
      rff_b2s_mpll_refssc_clk <= (wmask & b2s_mpll_refssc_clk) | (wmask_inv & rff_b2s_mpll_refssc_clk);

    end else if (vld_in_b2s_mpll_refssc_clk == 1'b1) begin
      rff_b2s_mpll_refssc_clk <= in_b2s_mpll_refssc_clk;
    end
  end
  assign out_b2s_mpll_refssc_clk = rff_b2s_mpll_refssc_clk;
  logic [STATION_USB_TOP_S2B_REF_CLKDIV2_WIDTH - 1 : 0] rff_s2b_ref_clkdiv2;
  logic [STATION_USB_TOP_S2B_REF_CLKDIV2_WIDTH - 1 : 0] s2b_ref_clkdiv2;
  logic load_s2b_ref_clkdiv2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ref_clkdiv2 <= STATION_USB_TOP_S2B_REF_CLKDIV2_RSTVAL;
    end else if (load_s2b_ref_clkdiv2 == 1'b1) begin
      rff_s2b_ref_clkdiv2 <= (wmask & s2b_ref_clkdiv2) | (wmask_inv & rff_s2b_ref_clkdiv2);
    end
  end
  assign out_s2b_ref_clkdiv2 = rff_s2b_ref_clkdiv2;
  logic [STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_WIDTH - 1 : 0] rff_b2s_pme_generation_u2pmu;
  logic [STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_WIDTH - 1 : 0] b2s_pme_generation_u2pmu;
  logic load_b2s_pme_generation_u2pmu;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_pme_generation_u2pmu <= STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_RSTVAL;
    end else if (load_b2s_pme_generation_u2pmu == 1'b1) begin
      rff_b2s_pme_generation_u2pmu <= (wmask & b2s_pme_generation_u2pmu) | (wmask_inv & rff_b2s_pme_generation_u2pmu);

    end else if (vld_in_b2s_pme_generation_u2pmu == 1'b1) begin
      rff_b2s_pme_generation_u2pmu <= in_b2s_pme_generation_u2pmu;
    end
  end
  assign out_b2s_pme_generation_u2pmu = rff_b2s_pme_generation_u2pmu;
  logic [STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_WIDTH - 1 : 0] rff_b2s_connect_state_u2pmu;
  logic [STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_WIDTH - 1 : 0] b2s_connect_state_u2pmu;
  logic load_b2s_connect_state_u2pmu;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_connect_state_u2pmu <= STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_RSTVAL;
    end else if (load_b2s_connect_state_u2pmu == 1'b1) begin
      rff_b2s_connect_state_u2pmu <= (wmask & b2s_connect_state_u2pmu) | (wmask_inv & rff_b2s_connect_state_u2pmu);

    end else if (vld_in_b2s_connect_state_u2pmu == 1'b1) begin
      rff_b2s_connect_state_u2pmu <= in_b2s_connect_state_u2pmu;
    end
  end
  assign out_b2s_connect_state_u2pmu = rff_b2s_connect_state_u2pmu;
  logic [STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_WIDTH - 1 : 0] rff_b2s_pme_generation_u3pmu;
  logic [STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_WIDTH - 1 : 0] b2s_pme_generation_u3pmu;
  logic load_b2s_pme_generation_u3pmu;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_pme_generation_u3pmu <= STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_RSTVAL;
    end else if (load_b2s_pme_generation_u3pmu == 1'b1) begin
      rff_b2s_pme_generation_u3pmu <= (wmask & b2s_pme_generation_u3pmu) | (wmask_inv & rff_b2s_pme_generation_u3pmu);

    end else if (vld_in_b2s_pme_generation_u3pmu == 1'b1) begin
      rff_b2s_pme_generation_u3pmu <= in_b2s_pme_generation_u3pmu;
    end
  end
  assign out_b2s_pme_generation_u3pmu = rff_b2s_pme_generation_u3pmu;
  logic [STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_WIDTH - 1 : 0] rff_b2s_connect_state_u3pmu;
  logic [STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_WIDTH - 1 : 0] b2s_connect_state_u3pmu;
  logic load_b2s_connect_state_u3pmu;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_connect_state_u3pmu <= STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_RSTVAL;
    end else if (load_b2s_connect_state_u3pmu == 1'b1) begin
      rff_b2s_connect_state_u3pmu <= (wmask & b2s_connect_state_u3pmu) | (wmask_inv & rff_b2s_connect_state_u3pmu);

    end else if (vld_in_b2s_connect_state_u3pmu == 1'b1) begin
      rff_b2s_connect_state_u3pmu <= in_b2s_connect_state_u3pmu;
    end
  end
  assign out_b2s_connect_state_u3pmu = rff_b2s_connect_state_u3pmu;
  logic [STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_WIDTH - 1 : 0] rff_s2b_power_switch_control;
  logic [STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_WIDTH - 1 : 0] s2b_power_switch_control;
  logic load_s2b_power_switch_control;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_power_switch_control <= STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_RSTVAL;
    end else if (load_s2b_power_switch_control == 1'b1) begin
      rff_s2b_power_switch_control <= (wmask & s2b_power_switch_control) | (wmask_inv & rff_s2b_power_switch_control);
    end
  end
  assign out_s2b_power_switch_control = rff_s2b_power_switch_control;
  logic [STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_WIDTH - 1 : 0] rff_s2b_lane0_ext_pclk_req;
  logic [STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_WIDTH - 1 : 0] s2b_lane0_ext_pclk_req;
  logic load_s2b_lane0_ext_pclk_req;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_lane0_ext_pclk_req <= STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_RSTVAL;
    end else if (load_s2b_lane0_ext_pclk_req == 1'b1) begin
      rff_s2b_lane0_ext_pclk_req <= (wmask & s2b_lane0_ext_pclk_req) | (wmask_inv & rff_s2b_lane0_ext_pclk_req);
    end
  end
  assign out_s2b_lane0_ext_pclk_req = rff_s2b_lane0_ext_pclk_req;
  logic [STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_WIDTH - 1 : 0] rff_s2b_lane0_tx2rx_loopbk;
  logic [STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_WIDTH - 1 : 0] s2b_lane0_tx2rx_loopbk;
  logic load_s2b_lane0_tx2rx_loopbk;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_lane0_tx2rx_loopbk <= STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_RSTVAL;
    end else if (load_s2b_lane0_tx2rx_loopbk == 1'b1) begin
      rff_s2b_lane0_tx2rx_loopbk <= (wmask & s2b_lane0_tx2rx_loopbk) | (wmask_inv & rff_s2b_lane0_tx2rx_loopbk);
    end
  end
  assign out_s2b_lane0_tx2rx_loopbk = rff_s2b_lane0_tx2rx_loopbk;
  logic [STATION_USB_TOP_S2DFT_MBIST_DONE_WIDTH - 1 : 0] rff_s2dft_mbist_done;
  logic [STATION_USB_TOP_S2DFT_MBIST_DONE_WIDTH - 1 : 0] s2dft_mbist_done;
  logic load_s2dft_mbist_done;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2dft_mbist_done <= STATION_USB_TOP_S2DFT_MBIST_DONE_RSTVAL;
    end else if (load_s2dft_mbist_done == 1'b1) begin
      rff_s2dft_mbist_done <= (wmask & s2dft_mbist_done) | (wmask_inv & rff_s2dft_mbist_done);
    end
  end
  assign out_s2dft_mbist_done = rff_s2dft_mbist_done;
  logic [STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_WIDTH - 1 : 0] rff_s2dft_mbist_func_en;
  logic [STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_WIDTH - 1 : 0] s2dft_mbist_func_en;
  logic load_s2dft_mbist_func_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2dft_mbist_func_en <= STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_RSTVAL;
    end else if (load_s2dft_mbist_func_en == 1'b1) begin
      rff_s2dft_mbist_func_en <= (wmask & s2dft_mbist_func_en) | (wmask_inv & rff_s2dft_mbist_func_en);
    end
  end
  assign out_s2dft_mbist_func_en = rff_s2dft_mbist_func_en;
  logic [STATION_USB_TOP_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] rff_debug_info_enable;
  logic [STATION_USB_TOP_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] debug_info_enable;
  logic load_debug_info_enable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_debug_info_enable <= STATION_USB_TOP_DEBUG_INFO_ENABLE_RSTVAL;
    end else if (load_debug_info_enable == 1'b1) begin
      rff_debug_info_enable <= (wmask & debug_info_enable) | (wmask_inv & rff_debug_info_enable);
    end
  end
  assign out_debug_info_enable = rff_debug_info_enable;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_USB_TOP_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_USB_TOP_DATA_WIDTH{1'b0}};
    b2s_debug_u2pmu_lo = rff_b2s_debug_u2pmu_lo;
    load_b2s_debug_u2pmu_lo = 1'b0;
    s2dft_mbist_error_log_hi = rff_s2dft_mbist_error_log_hi;
    load_s2dft_mbist_error_log_hi = 1'b0;
    s2dft_mbist_error_log_lo = rff_s2dft_mbist_error_log_lo;
    load_s2dft_mbist_error_log_lo = 1'b0;
    b2s_debug = rff_b2s_debug;
    load_b2s_debug = 1'b0;
    b2s_debug_u3pmu = rff_b2s_debug_u3pmu;
    load_b2s_debug_u3pmu = 1'b0;
    s2b_pm_pmu_config_strap = rff_s2b_pm_pmu_config_strap;
    load_s2b_pm_pmu_config_strap = 1'b0;
    s2b_gp_in = rff_s2b_gp_in;
    load_s2b_gp_in = 1'b0;
    b2s_gp_out = rff_b2s_gp_out;
    load_b2s_gp_out = 1'b0;
    s2b_cr_data_in = rff_s2b_cr_data_in;
    load_s2b_cr_data_in = 1'b0;
    b2s_cr_data_out = rff_b2s_cr_data_out;
    load_b2s_cr_data_out = 1'b0;
    s2b_pcs_rx_los_mask_val = rff_s2b_pcs_rx_los_mask_val;
    load_s2b_pcs_rx_los_mask_val = 1'b0;
    s2b_ssc_ref_clk_sel = rff_s2b_ssc_ref_clk_sel;
    load_s2b_ssc_ref_clk_sel = 1'b0;
    s2b_pcs_tx_swing_full = rff_s2b_pcs_tx_swing_full;
    load_s2b_pcs_tx_swing_full = 1'b0;
    s2b_mpll_multiplier = rff_s2b_mpll_multiplier;
    load_s2b_mpll_multiplier = 1'b0;
    s2b_pcs_tx_deemph_3p5db = rff_s2b_pcs_tx_deemph_3p5db;
    load_s2b_pcs_tx_deemph_3p5db = 1'b0;
    s2b_pcs_tx_deemph_6db = rff_s2b_pcs_tx_deemph_6db;
    load_s2b_pcs_tx_deemph_6db = 1'b0;
    s2b_fsel = rff_s2b_fsel;
    load_s2b_fsel = 1'b0;
    s2b_los_level = rff_s2b_los_level;
    load_s2b_los_level = 1'b0;
    s2b_lane0_tx_term_offset = rff_s2b_lane0_tx_term_offset;
    load_s2b_lane0_tx_term_offset = 1'b0;
    s2b_TXFSLSTUNE0 = rff_s2b_TXFSLSTUNE0;
    load_s2b_TXFSLSTUNE0 = 1'b0;
    s2b_TXVREFTUNE0 = rff_s2b_TXVREFTUNE0;
    load_s2b_TXVREFTUNE0 = 1'b0;
    b2s_debug_u2pmu_hi = rff_b2s_debug_u2pmu_hi;
    load_b2s_debug_u2pmu_hi = 1'b0;
    b2s_clk_gate_ctrl = rff_b2s_clk_gate_ctrl;
    load_b2s_clk_gate_ctrl = 1'b0;
    s2b_COMPDISTUNE0 = rff_s2b_COMPDISTUNE0;
    load_s2b_COMPDISTUNE0 = 1'b0;
    s2b_OTGTUNE0 = rff_s2b_OTGTUNE0;
    load_s2b_OTGTUNE0 = 1'b0;
    s2b_SQRXTUNE0 = rff_s2b_SQRXTUNE0;
    load_s2b_SQRXTUNE0 = 1'b0;
    s2b_los_bias = rff_s2b_los_bias;
    load_s2b_los_bias = 1'b0;
    s2b_tx_vboost_lvl = rff_s2b_tx_vboost_lvl;
    load_s2b_tx_vboost_lvl = 1'b0;
    s2b_ssc_range = rff_s2b_ssc_range;
    load_s2b_ssc_range = 1'b0;
    s2b_TXHSXVTUNE0 = rff_s2b_TXHSXVTUNE0;
    load_s2b_TXHSXVTUNE0 = 1'b0;
    s2b_TXPREEMPAMPTUNE0 = rff_s2b_TXPREEMPAMPTUNE0;
    load_s2b_TXPREEMPAMPTUNE0 = 1'b0;
    s2b_TXRESTUNE0 = rff_s2b_TXRESTUNE0;
    load_s2b_TXRESTUNE0 = 1'b0;
    s2b_TXRISETUNE0 = rff_s2b_TXRISETUNE0;
    load_s2b_TXRISETUNE0 = 1'b0;
    s2b_VDATREFTUNE0 = rff_s2b_VDATREFTUNE0;
    load_s2b_VDATREFTUNE0 = 1'b0;
    s2b_pm_power_state_request = rff_s2b_pm_power_state_request;
    load_s2b_pm_power_state_request = 1'b0;
    b2s_current_power_state_u2pmu = rff_b2s_current_power_state_u2pmu;
    load_b2s_current_power_state_u2pmu = 1'b0;
    b2s_current_power_state_u3pmu = rff_b2s_current_power_state_u3pmu;
    load_b2s_current_power_state_u3pmu = 1'b0;
    s2b_vcc_reset_n = rff_s2b_vcc_reset_n;
    load_s2b_vcc_reset_n = 1'b0;
    s2b_vaux_reset_n = rff_s2b_vaux_reset_n;
    load_s2b_vaux_reset_n = 1'b0;
    s2b_ram0_slp = rff_s2b_ram0_slp;
    load_s2b_ram0_slp = 1'b0;
    s2b_ram0_sd = rff_s2b_ram0_sd;
    load_s2b_ram0_sd = 1'b0;
    s2b_ram1_slp = rff_s2b_ram1_slp;
    load_s2b_ram1_slp = 1'b0;
    s2b_ram1_sd = rff_s2b_ram1_sd;
    load_s2b_ram1_sd = 1'b0;
    s2b_ram2_slp = rff_s2b_ram2_slp;
    load_s2b_ram2_slp = 1'b0;
    s2b_ram2_sd = rff_s2b_ram2_sd;
    load_s2b_ram2_sd = 1'b0;
    s2b_TXPREEMPPULSETUNE0 = rff_s2b_TXPREEMPPULSETUNE0;
    load_s2b_TXPREEMPPULSETUNE0 = 1'b0;
    s2b_rtune_req = rff_s2b_rtune_req;
    load_s2b_rtune_req = 1'b0;
    b2s_rtune_ack = rff_b2s_rtune_ack;
    load_b2s_rtune_ack = 1'b0;
    s2b_ATERESET = rff_s2b_ATERESET;
    load_s2b_ATERESET = 1'b0;
    s2b_LOOPBACKENB0 = rff_s2b_LOOPBACKENB0;
    load_s2b_LOOPBACKENB0 = 1'b0;
    s2b_test_powerdown_hsp = rff_s2b_test_powerdown_hsp;
    load_s2b_test_powerdown_hsp = 1'b0;
    s2b_test_powerdown_ssp = rff_s2b_test_powerdown_ssp;
    load_s2b_test_powerdown_ssp = 1'b0;
    s2b_VATESTENB = rff_s2b_VATESTENB;
    load_s2b_VATESTENB = 1'b0;
    s2b_cr_cap_addr = rff_s2b_cr_cap_addr;
    load_s2b_cr_cap_addr = 1'b0;
    s2b_cr_cap_data = rff_s2b_cr_cap_data;
    load_s2b_cr_cap_data = 1'b0;
    s2b_cr_read = rff_s2b_cr_read;
    load_s2b_cr_read = 1'b0;
    s2b_cr_write = rff_s2b_cr_write;
    load_s2b_cr_write = 1'b0;
    b2s_cr_ack = rff_b2s_cr_ack;
    load_b2s_cr_ack = 1'b0;
    s2b_ref_ssp_en = rff_s2b_ref_ssp_en;
    load_s2b_ref_ssp_en = 1'b0;
    s2b_ref_use_pad = rff_s2b_ref_use_pad;
    load_s2b_ref_use_pad = 1'b0;
    s2icg_pllclk_en = rff_s2icg_pllclk_en;
    load_s2icg_pllclk_en = 1'b0;
    s2icg_refclk_en = rff_s2icg_refclk_en;
    load_s2icg_refclk_en = 1'b0;
    b2s_mpll_refssc_clk = rff_b2s_mpll_refssc_clk;
    load_b2s_mpll_refssc_clk = 1'b0;
    s2b_ref_clkdiv2 = rff_s2b_ref_clkdiv2;
    load_s2b_ref_clkdiv2 = 1'b0;
    b2s_pme_generation_u2pmu = rff_b2s_pme_generation_u2pmu;
    load_b2s_pme_generation_u2pmu = 1'b0;
    b2s_connect_state_u2pmu = rff_b2s_connect_state_u2pmu;
    load_b2s_connect_state_u2pmu = 1'b0;
    b2s_pme_generation_u3pmu = rff_b2s_pme_generation_u3pmu;
    load_b2s_pme_generation_u3pmu = 1'b0;
    b2s_connect_state_u3pmu = rff_b2s_connect_state_u3pmu;
    load_b2s_connect_state_u3pmu = 1'b0;
    s2b_power_switch_control = rff_s2b_power_switch_control;
    load_s2b_power_switch_control = 1'b0;
    s2b_lane0_ext_pclk_req = rff_s2b_lane0_ext_pclk_req;
    load_s2b_lane0_ext_pclk_req = 1'b0;
    s2b_lane0_tx2rx_loopbk = rff_s2b_lane0_tx2rx_loopbk;
    load_s2b_lane0_tx2rx_loopbk = 1'b0;
    s2dft_mbist_done = rff_s2dft_mbist_done;
    load_s2dft_mbist_done = 1'b0;
    s2dft_mbist_func_en = rff_s2dft_mbist_func_en;
    load_s2dft_mbist_func_en = 1'b0;
    debug_info_enable = rff_debug_info_enable;
    load_debug_info_enable = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_debug_u2pmu_lo;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2dft_mbist_error_log_hi;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2dft_mbist_error_log_lo;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_debug;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_debug_u3pmu;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pm_pmu_config_strap;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_GP_IN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_gp_in;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_GP_OUT_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_gp_out;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_DATA_IN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cr_data_in;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CR_DATA_OUT_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_cr_data_out;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pcs_rx_los_mask_val;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ssc_ref_clk_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pcs_tx_swing_full;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_MPLL_MULTIPLIER_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_mpll_multiplier;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pcs_tx_deemph_3p5db;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pcs_tx_deemph_6db;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_FSEL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_fsel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LOS_LEVEL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_los_level;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_lane0_tx_term_offset;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXFSLSTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_TXFSLSTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXVREFTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_TXVREFTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_debug_u2pmu_hi;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CLK_GATE_CTRL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_clk_gate_ctrl;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_COMPDISTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_COMPDISTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_OTGTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_OTGTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_SQRXTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_SQRXTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LOS_BIAS_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_los_bias;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TX_VBOOST_LVL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_tx_vboost_lvl;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_SSC_RANGE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ssc_range;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXHSXVTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_TXHSXVTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_TXPREEMPAMPTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXRESTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_TXRESTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXRISETUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_TXRISETUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VDATREFTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_VDATREFTUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_pm_power_state_request;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_current_power_state_u2pmu;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_current_power_state_u3pmu;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VCC_RESET_N_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_vcc_reset_n;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VAUX_RESET_N_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_vaux_reset_n;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM0_SLP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ram0_slp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM0_SD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ram0_sd;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM1_SLP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ram1_slp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM1_SD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ram1_sd;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM2_SLP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ram2_slp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM2_SD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ram2_sd;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_TXPREEMPPULSETUNE0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RTUNE_REQ_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_rtune_req;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_RTUNE_ACK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_rtune_ack;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_ATERESET_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ATERESET;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LOOPBACKENB0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_LOOPBACKENB0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_test_powerdown_hsp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_test_powerdown_ssp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VATESTENB_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_VATESTENB;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_CAP_ADDR_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cr_cap_addr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_CAP_DATA_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cr_cap_data;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_READ_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cr_read;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_WRITE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_cr_write;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CR_ACK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_cr_ack;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_REF_SSP_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ref_ssp_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_REF_USE_PAD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ref_use_pad;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2ICG_PLLCLK_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2icg_pllclk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2ICG_REFCLK_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2icg_refclk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_mpll_refssc_clk;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_REF_CLKDIV2_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ref_clkdiv2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_pme_generation_u2pmu;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_connect_state_u2pmu;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_pme_generation_u3pmu;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_b2s_connect_state_u3pmu;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_power_switch_control;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_lane0_ext_pclk_req;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2b_lane0_tx2rx_loopbk;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_DONE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2dft_mbist_done;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_s2dft_mbist_func_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          data = rff_debug_info_enable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_USB_TOP_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_debug_u2pmu_lo = station2brb_req_w.wdata[STATION_USB_TOP_B2S_DEBUG_U2PMU_LO_WIDTH - 1 : 0];
          load_b2s_debug_u2pmu_lo = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2dft_mbist_error_log_hi = station2brb_req_w.wdata[STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_HI_WIDTH - 1 : 0];
          load_s2dft_mbist_error_log_hi = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2dft_mbist_error_log_lo = station2brb_req_w.wdata[STATION_USB_TOP_S2DFT_MBIST_ERROR_LOG_LO_WIDTH - 1 : 0];
          load_s2dft_mbist_error_log_lo = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_debug = station2brb_req_w.wdata[STATION_USB_TOP_B2S_DEBUG_WIDTH - 1 : 0];
          load_b2s_debug = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_debug_u3pmu = station2brb_req_w.wdata[STATION_USB_TOP_B2S_DEBUG_U3PMU_WIDTH - 1 : 0];
          load_b2s_debug_u3pmu = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_pm_pmu_config_strap = station2brb_req_w.wdata[STATION_USB_TOP_S2B_PM_PMU_CONFIG_STRAP_WIDTH - 1 : 0];
          load_s2b_pm_pmu_config_strap = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_GP_IN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_gp_in = station2brb_req_w.wdata[STATION_USB_TOP_S2B_GP_IN_WIDTH - 1 : 0];
          load_s2b_gp_in = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_GP_OUT_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_gp_out = station2brb_req_w.wdata[STATION_USB_TOP_B2S_GP_OUT_WIDTH - 1 : 0];
          load_b2s_gp_out = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_DATA_IN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_cr_data_in = station2brb_req_w.wdata[STATION_USB_TOP_S2B_CR_DATA_IN_WIDTH - 1 : 0];
          load_s2b_cr_data_in = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CR_DATA_OUT_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_cr_data_out = station2brb_req_w.wdata[STATION_USB_TOP_B2S_CR_DATA_OUT_WIDTH - 1 : 0];
          load_b2s_cr_data_out = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_pcs_rx_los_mask_val = station2brb_req_w.wdata[STATION_USB_TOP_S2B_PCS_RX_LOS_MASK_VAL_WIDTH - 1 : 0];
          load_s2b_pcs_rx_los_mask_val = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ssc_ref_clk_sel = station2brb_req_w.wdata[STATION_USB_TOP_S2B_SSC_REF_CLK_SEL_WIDTH - 1 : 0];
          load_s2b_ssc_ref_clk_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_pcs_tx_swing_full = station2brb_req_w.wdata[STATION_USB_TOP_S2B_PCS_TX_SWING_FULL_WIDTH - 1 : 0];
          load_s2b_pcs_tx_swing_full = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_MPLL_MULTIPLIER_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_mpll_multiplier = station2brb_req_w.wdata[STATION_USB_TOP_S2B_MPLL_MULTIPLIER_WIDTH - 1 : 0];
          load_s2b_mpll_multiplier = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_pcs_tx_deemph_3p5db = station2brb_req_w.wdata[STATION_USB_TOP_S2B_PCS_TX_DEEMPH_3P5DB_WIDTH - 1 : 0];
          load_s2b_pcs_tx_deemph_3p5db = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_pcs_tx_deemph_6db = station2brb_req_w.wdata[STATION_USB_TOP_S2B_PCS_TX_DEEMPH_6DB_WIDTH - 1 : 0];
          load_s2b_pcs_tx_deemph_6db = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_FSEL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_fsel = station2brb_req_w.wdata[STATION_USB_TOP_S2B_FSEL_WIDTH - 1 : 0];
          load_s2b_fsel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LOS_LEVEL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_los_level = station2brb_req_w.wdata[STATION_USB_TOP_S2B_LOS_LEVEL_WIDTH - 1 : 0];
          load_s2b_los_level = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_lane0_tx_term_offset = station2brb_req_w.wdata[STATION_USB_TOP_S2B_LANE0_TX_TERM_OFFSET_WIDTH - 1 : 0];
          load_s2b_lane0_tx_term_offset = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXFSLSTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_TXFSLSTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TXFSLSTUNE0_WIDTH - 1 : 0];
          load_s2b_TXFSLSTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXVREFTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_TXVREFTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TXVREFTUNE0_WIDTH - 1 : 0];
          load_s2b_TXVREFTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_debug_u2pmu_hi = station2brb_req_w.wdata[STATION_USB_TOP_B2S_DEBUG_U2PMU_HI_WIDTH - 1 : 0];
          load_b2s_debug_u2pmu_hi = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CLK_GATE_CTRL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_clk_gate_ctrl = station2brb_req_w.wdata[STATION_USB_TOP_B2S_CLK_GATE_CTRL_WIDTH - 1 : 0];
          load_b2s_clk_gate_ctrl = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_COMPDISTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_COMPDISTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_COMPDISTUNE0_WIDTH - 1 : 0];
          load_s2b_COMPDISTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_OTGTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_OTGTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_OTGTUNE0_WIDTH - 1 : 0];
          load_s2b_OTGTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_SQRXTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_SQRXTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_SQRXTUNE0_WIDTH - 1 : 0];
          load_s2b_SQRXTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LOS_BIAS_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_los_bias = station2brb_req_w.wdata[STATION_USB_TOP_S2B_LOS_BIAS_WIDTH - 1 : 0];
          load_s2b_los_bias = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TX_VBOOST_LVL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_tx_vboost_lvl = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TX_VBOOST_LVL_WIDTH - 1 : 0];
          load_s2b_tx_vboost_lvl = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_SSC_RANGE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ssc_range = station2brb_req_w.wdata[STATION_USB_TOP_S2B_SSC_RANGE_WIDTH - 1 : 0];
          load_s2b_ssc_range = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXHSXVTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_TXHSXVTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TXHSXVTUNE0_WIDTH - 1 : 0];
          load_s2b_TXHSXVTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_TXPREEMPAMPTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TXPREEMPAMPTUNE0_WIDTH - 1 : 0];
          load_s2b_TXPREEMPAMPTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXRESTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_TXRESTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TXRESTUNE0_WIDTH - 1 : 0];
          load_s2b_TXRESTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXRISETUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_TXRISETUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TXRISETUNE0_WIDTH - 1 : 0];
          load_s2b_TXRISETUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VDATREFTUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_VDATREFTUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_VDATREFTUNE0_WIDTH - 1 : 0];
          load_s2b_VDATREFTUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_pm_power_state_request = station2brb_req_w.wdata[STATION_USB_TOP_S2B_PM_POWER_STATE_REQUEST_WIDTH - 1 : 0];
          load_s2b_pm_power_state_request = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_current_power_state_u2pmu = station2brb_req_w.wdata[STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U2PMU_WIDTH - 1 : 0];
          load_b2s_current_power_state_u2pmu = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_current_power_state_u3pmu = station2brb_req_w.wdata[STATION_USB_TOP_B2S_CURRENT_POWER_STATE_U3PMU_WIDTH - 1 : 0];
          load_b2s_current_power_state_u3pmu = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VCC_RESET_N_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_vcc_reset_n = station2brb_req_w.wdata[STATION_USB_TOP_S2B_VCC_RESET_N_WIDTH - 1 : 0];
          load_s2b_vcc_reset_n = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VAUX_RESET_N_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_vaux_reset_n = station2brb_req_w.wdata[STATION_USB_TOP_S2B_VAUX_RESET_N_WIDTH - 1 : 0];
          load_s2b_vaux_reset_n = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM0_SLP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ram0_slp = station2brb_req_w.wdata[STATION_USB_TOP_S2B_RAM0_SLP_WIDTH - 1 : 0];
          load_s2b_ram0_slp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM0_SD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ram0_sd = station2brb_req_w.wdata[STATION_USB_TOP_S2B_RAM0_SD_WIDTH - 1 : 0];
          load_s2b_ram0_sd = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM1_SLP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ram1_slp = station2brb_req_w.wdata[STATION_USB_TOP_S2B_RAM1_SLP_WIDTH - 1 : 0];
          load_s2b_ram1_slp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM1_SD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ram1_sd = station2brb_req_w.wdata[STATION_USB_TOP_S2B_RAM1_SD_WIDTH - 1 : 0];
          load_s2b_ram1_sd = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM2_SLP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ram2_slp = station2brb_req_w.wdata[STATION_USB_TOP_S2B_RAM2_SLP_WIDTH - 1 : 0];
          load_s2b_ram2_slp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RAM2_SD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ram2_sd = station2brb_req_w.wdata[STATION_USB_TOP_S2B_RAM2_SD_WIDTH - 1 : 0];
          load_s2b_ram2_sd = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_TXPREEMPPULSETUNE0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TXPREEMPPULSETUNE0_WIDTH - 1 : 0];
          load_s2b_TXPREEMPPULSETUNE0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_RTUNE_REQ_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_rtune_req = station2brb_req_w.wdata[STATION_USB_TOP_S2B_RTUNE_REQ_WIDTH - 1 : 0];
          load_s2b_rtune_req = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_RTUNE_ACK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_rtune_ack = station2brb_req_w.wdata[STATION_USB_TOP_B2S_RTUNE_ACK_WIDTH - 1 : 0];
          load_b2s_rtune_ack = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_ATERESET_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ATERESET = station2brb_req_w.wdata[STATION_USB_TOP_S2B_ATERESET_WIDTH - 1 : 0];
          load_s2b_ATERESET = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LOOPBACKENB0_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_LOOPBACKENB0 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_LOOPBACKENB0_WIDTH - 1 : 0];
          load_s2b_LOOPBACKENB0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_test_powerdown_hsp = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TEST_POWERDOWN_HSP_WIDTH - 1 : 0];
          load_s2b_test_powerdown_hsp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_test_powerdown_ssp = station2brb_req_w.wdata[STATION_USB_TOP_S2B_TEST_POWERDOWN_SSP_WIDTH - 1 : 0];
          load_s2b_test_powerdown_ssp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_VATESTENB_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_VATESTENB = station2brb_req_w.wdata[STATION_USB_TOP_S2B_VATESTENB_WIDTH - 1 : 0];
          load_s2b_VATESTENB = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_CAP_ADDR_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_cr_cap_addr = station2brb_req_w.wdata[STATION_USB_TOP_S2B_CR_CAP_ADDR_WIDTH - 1 : 0];
          load_s2b_cr_cap_addr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_CAP_DATA_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_cr_cap_data = station2brb_req_w.wdata[STATION_USB_TOP_S2B_CR_CAP_DATA_WIDTH - 1 : 0];
          load_s2b_cr_cap_data = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_READ_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_cr_read = station2brb_req_w.wdata[STATION_USB_TOP_S2B_CR_READ_WIDTH - 1 : 0];
          load_s2b_cr_read = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_CR_WRITE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_cr_write = station2brb_req_w.wdata[STATION_USB_TOP_S2B_CR_WRITE_WIDTH - 1 : 0];
          load_s2b_cr_write = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CR_ACK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_cr_ack = station2brb_req_w.wdata[STATION_USB_TOP_B2S_CR_ACK_WIDTH - 1 : 0];
          load_b2s_cr_ack = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_REF_SSP_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ref_ssp_en = station2brb_req_w.wdata[STATION_USB_TOP_S2B_REF_SSP_EN_WIDTH - 1 : 0];
          load_s2b_ref_ssp_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_REF_USE_PAD_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ref_use_pad = station2brb_req_w.wdata[STATION_USB_TOP_S2B_REF_USE_PAD_WIDTH - 1 : 0];
          load_s2b_ref_use_pad = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2ICG_PLLCLK_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2icg_pllclk_en = station2brb_req_w.wdata[STATION_USB_TOP_S2ICG_PLLCLK_EN_WIDTH - 1 : 0];
          load_s2icg_pllclk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2ICG_REFCLK_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2icg_refclk_en = station2brb_req_w.wdata[STATION_USB_TOP_S2ICG_REFCLK_EN_WIDTH - 1 : 0];
          load_s2icg_refclk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_mpll_refssc_clk = station2brb_req_w.wdata[STATION_USB_TOP_B2S_MPLL_REFSSC_CLK_WIDTH - 1 : 0];
          load_b2s_mpll_refssc_clk = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_REF_CLKDIV2_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_ref_clkdiv2 = station2brb_req_w.wdata[STATION_USB_TOP_S2B_REF_CLKDIV2_WIDTH - 1 : 0];
          load_s2b_ref_clkdiv2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_pme_generation_u2pmu = station2brb_req_w.wdata[STATION_USB_TOP_B2S_PME_GENERATION_U2PMU_WIDTH - 1 : 0];
          load_b2s_pme_generation_u2pmu = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_connect_state_u2pmu = station2brb_req_w.wdata[STATION_USB_TOP_B2S_CONNECT_STATE_U2PMU_WIDTH - 1 : 0];
          load_b2s_connect_state_u2pmu = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_pme_generation_u3pmu = station2brb_req_w.wdata[STATION_USB_TOP_B2S_PME_GENERATION_U3PMU_WIDTH - 1 : 0];
          load_b2s_pme_generation_u3pmu = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          b2s_connect_state_u3pmu = station2brb_req_w.wdata[STATION_USB_TOP_B2S_CONNECT_STATE_U3PMU_WIDTH - 1 : 0];
          load_b2s_connect_state_u3pmu = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_power_switch_control = station2brb_req_w.wdata[STATION_USB_TOP_S2B_POWER_SWITCH_CONTROL_WIDTH - 1 : 0];
          load_s2b_power_switch_control = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_lane0_ext_pclk_req = station2brb_req_w.wdata[STATION_USB_TOP_S2B_LANE0_EXT_PCLK_REQ_WIDTH - 1 : 0];
          load_s2b_lane0_ext_pclk_req = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2b_lane0_tx2rx_loopbk = station2brb_req_w.wdata[STATION_USB_TOP_S2B_LANE0_TX2RX_LOOPBK_WIDTH - 1 : 0];
          load_s2b_lane0_tx2rx_loopbk = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_DONE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2dft_mbist_done = station2brb_req_w.wdata[STATION_USB_TOP_S2DFT_MBIST_DONE_WIDTH - 1 : 0];
          load_s2dft_mbist_done = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          s2dft_mbist_func_en = station2brb_req_w.wdata[STATION_USB_TOP_S2DFT_MBIST_FUNC_EN_WIDTH - 1 : 0];
          load_s2dft_mbist_func_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_USB_TOP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_USB_TOP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_USB_TOP_DATA_WIDTH/8)]} == (STATION_USB_TOP_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_USB_TOP_DATA_WIDTH/8)))): begin
          debug_info_enable = station2brb_req_w.wdata[STATION_USB_TOP_DEBUG_INFO_ENABLE_WIDTH - 1 : 0];
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
