module pygmy_es1y_fpga_vcu118
import pygmy_cfg::*;
import pygmy_typedef::*;
import orv_cfg::*;
import orv_typedef::*;
import orv64_typedef_pkg::*;
import pygmy_intf_typedef::*;
import vcore_pkg::*;
import station_dma_pkg::*;
import plic_typedef::*;
(
  output  c0_ddr4_act_n,
  output [16:0] c0_ddr4_adr,
  output [1:0] c0_ddr4_ba,
  output  c0_ddr4_bg,
  output  c0_ddr4_ck_c,
  output  c0_ddr4_ck_t,
  output  c0_ddr4_cke,
  output  c0_ddr4_cs_n,
  inout [7:0] c0_ddr4_dm_dbi_n,
  inout [63:0] c0_ddr4_dq,
  inout [7:0] c0_ddr4_dqs_c,
  inout [7:0] c0_ddr4_dqs_t,
  output  c0_ddr4_odt,
  output  c0_ddr4_reset_n,
  output  c0_init_calib_complete,
  input  c0_sys_clk_n,
  input  c0_sys_clk_p,
  inout  p2t_SSP_SHARED_1,
  inout  p2t_SSP_SHARED_12,
  inout  p2t_SSP_SHARED_2,
  inout  p2t_SSP_SHARED_6,
  inout  p2t_qspim_sclk_out,
  inout  p2t_qspim_ss,
  inout  p2t_sspim0_sclk_out,
  inout  p2t_sspim0_ss,
  inout  p2t_sspim0_txd,
  inout  p2t_uart1_sout,
  inout  p2t_uart2_sout,
  input  sys_rst_ddr,
  inout  t2p_SSP_SHARED_10,
  inout  t2p_SSP_SHARED_11,
  inout  t2p_SSP_SHARED_14,
  inout  t2p_sd_card_detect_n,
  inout  t2p_sd_card_write_prot,
  inout  t2p_sspim0_rxd,
  inout  t2p_uart1_sin,
  inout  t2p_uart2_sin,
  inout  tbp_SSP_SHARED_0,
  inout  tbp_SSP_SHARED_13,
  inout  tbp_SSP_SHARED_15,
  inout  tbp_SSP_SHARED_16,
  inout  tbp_SSP_SHARED_17,
  inout  tbp_SSP_SHARED_18,
  inout  tbp_SSP_SHARED_19,
  inout  tbp_SSP_SHARED_20,
  inout  tbp_SSP_SHARED_21,
  inout  tbp_SSP_SHARED_22,
  inout  tbp_SSP_SHARED_23,
  inout  tbp_SSP_SHARED_24,
  inout  tbp_SSP_SHARED_25,
  inout  tbp_SSP_SHARED_26,
  inout  tbp_SSP_SHARED_27,
  inout  tbp_SSP_SHARED_28,
  inout  tbp_SSP_SHARED_29,
  inout  tbp_SSP_SHARED_3,
  inout  tbp_SSP_SHARED_30,
  inout  tbp_SSP_SHARED_31,
  inout  tbp_SSP_SHARED_32,
  inout  tbp_SSP_SHARED_33,
  inout  tbp_SSP_SHARED_34,
  inout  tbp_SSP_SHARED_35,
  inout  tbp_SSP_SHARED_36,
  inout  tbp_SSP_SHARED_37,
  inout  tbp_SSP_SHARED_38,
  inout  tbp_SSP_SHARED_39,
  inout  tbp_SSP_SHARED_4,
  inout  tbp_SSP_SHARED_40,
  inout  tbp_SSP_SHARED_41,
  inout  tbp_SSP_SHARED_42,
  inout  tbp_SSP_SHARED_43,
  inout  tbp_SSP_SHARED_44,
  inout  tbp_SSP_SHARED_45,
  inout  tbp_SSP_SHARED_46,
  inout  tbp_SSP_SHARED_47,
  inout  tbp_SSP_SHARED_5,
  inout  tbp_SSP_SHARED_7,
  inout  tbp_SSP_SHARED_8,
  inout  tbp_SSP_SHARED_9,
  inout  tbp_i2c0_ic_clk,
  inout  tbp_i2c0_ic_data,
  inout  tbp_qspim_trxd_0,
  inout  tbp_qspim_trxd_1,
  inout  tbp_qspim_trxd_2,
  inout  tbp_qspim_trxd_3,
  inout  tbp_sd_clk,
  inout  tbp_sd_cmd_in_out,
  inout  tbp_sd_dat_in_out_0,
  inout  tbp_sd_dat_in_out_1,
  inout  tbp_sd_dat_in_out_2,
  inout  tbp_sd_dat_in_out_3
);

  wire                 SSP_SHARED_0_pad_0__I;
  wire                 SSP_SHARED_0_pad_0__O;
  wire                 SSP_SHARED_0_pad_0__T;
  wire                 SSP_SHARED_10_pad_0__I;
  wire                 SSP_SHARED_10_pad_0__O;
  wire                 SSP_SHARED_10_pad_0__T;
  wire                 SSP_SHARED_11_pad_0__I;
  wire                 SSP_SHARED_11_pad_0__O;
  wire                 SSP_SHARED_11_pad_0__T;
  wire                 SSP_SHARED_12_pad_0__I;
  wire                 SSP_SHARED_12_pad_0__O;
  wire                 SSP_SHARED_12_pad_0__T;
  wire                 SSP_SHARED_13_pad_0__I;
  wire                 SSP_SHARED_13_pad_0__O;
  wire                 SSP_SHARED_13_pad_0__T;
  wire                 SSP_SHARED_14_pad_0__I;
  wire                 SSP_SHARED_14_pad_0__O;
  wire                 SSP_SHARED_14_pad_0__T;
  wire                 SSP_SHARED_15_pad_0__I;
  wire                 SSP_SHARED_15_pad_0__O;
  wire                 SSP_SHARED_15_pad_0__T;
  wire                 SSP_SHARED_16_pad_0__I;
  wire                 SSP_SHARED_16_pad_0__O;
  wire                 SSP_SHARED_16_pad_0__T;
  wire                 SSP_SHARED_17_pad_0__I;
  wire                 SSP_SHARED_17_pad_0__O;
  wire                 SSP_SHARED_17_pad_0__T;
  wire                 SSP_SHARED_18_pad_0__I;
  wire                 SSP_SHARED_18_pad_0__O;
  wire                 SSP_SHARED_18_pad_0__T;
  wire                 SSP_SHARED_19_pad_0__I;
  wire                 SSP_SHARED_19_pad_0__O;
  wire                 SSP_SHARED_19_pad_0__T;
  wire                 SSP_SHARED_1_pad_0__I;
  wire                 SSP_SHARED_1_pad_0__O;
  wire                 SSP_SHARED_1_pad_0__T;
  wire                 SSP_SHARED_20_pad_0__I;
  wire                 SSP_SHARED_20_pad_0__O;
  wire                 SSP_SHARED_20_pad_0__T;
  wire                 SSP_SHARED_21_pad_0__I;
  wire                 SSP_SHARED_21_pad_0__O;
  wire                 SSP_SHARED_21_pad_0__T;
  wire                 SSP_SHARED_22_pad_0__I;
  wire                 SSP_SHARED_22_pad_0__O;
  wire                 SSP_SHARED_22_pad_0__T;
  wire                 SSP_SHARED_23_pad_0__I;
  wire                 SSP_SHARED_23_pad_0__O;
  wire                 SSP_SHARED_23_pad_0__T;
  wire                 SSP_SHARED_24_pad_0__I;
  wire                 SSP_SHARED_24_pad_0__O;
  wire                 SSP_SHARED_24_pad_0__T;
  wire                 SSP_SHARED_25_pad_0__I;
  wire                 SSP_SHARED_25_pad_0__O;
  wire                 SSP_SHARED_25_pad_0__T;
  wire                 SSP_SHARED_26_pad_0__I;
  wire                 SSP_SHARED_26_pad_0__O;
  wire                 SSP_SHARED_26_pad_0__T;
  wire                 SSP_SHARED_27_pad_0__I;
  wire                 SSP_SHARED_27_pad_0__O;
  wire                 SSP_SHARED_27_pad_0__T;
  wire                 SSP_SHARED_28_pad_0__I;
  wire                 SSP_SHARED_28_pad_0__O;
  wire                 SSP_SHARED_28_pad_0__T;
  wire                 SSP_SHARED_29_pad_0__I;
  wire                 SSP_SHARED_29_pad_0__O;
  wire                 SSP_SHARED_29_pad_0__T;
  wire                 SSP_SHARED_2_pad_0__I;
  wire                 SSP_SHARED_2_pad_0__O;
  wire                 SSP_SHARED_2_pad_0__T;
  wire                 SSP_SHARED_30_pad_0__I;
  wire                 SSP_SHARED_30_pad_0__O;
  wire                 SSP_SHARED_30_pad_0__T;
  wire                 SSP_SHARED_31_pad_0__I;
  wire                 SSP_SHARED_31_pad_0__O;
  wire                 SSP_SHARED_31_pad_0__T;
  wire                 SSP_SHARED_32_pad_0__I;
  wire                 SSP_SHARED_32_pad_0__O;
  wire                 SSP_SHARED_32_pad_0__T;
  wire                 SSP_SHARED_33_pad_0__I;
  wire                 SSP_SHARED_33_pad_0__O;
  wire                 SSP_SHARED_33_pad_0__T;
  wire                 SSP_SHARED_34_pad_0__I;
  wire                 SSP_SHARED_34_pad_0__O;
  wire                 SSP_SHARED_34_pad_0__T;
  wire                 SSP_SHARED_35_pad_0__I;
  wire                 SSP_SHARED_35_pad_0__O;
  wire                 SSP_SHARED_35_pad_0__T;
  wire                 SSP_SHARED_36_pad_0__I;
  wire                 SSP_SHARED_36_pad_0__O;
  wire                 SSP_SHARED_36_pad_0__T;
  wire                 SSP_SHARED_37_pad_0__I;
  wire                 SSP_SHARED_37_pad_0__O;
  wire                 SSP_SHARED_37_pad_0__T;
  wire                 SSP_SHARED_38_pad_0__I;
  wire                 SSP_SHARED_38_pad_0__O;
  wire                 SSP_SHARED_38_pad_0__T;
  wire                 SSP_SHARED_39_pad_0__I;
  wire                 SSP_SHARED_39_pad_0__O;
  wire                 SSP_SHARED_39_pad_0__T;
  wire                 SSP_SHARED_3_pad_0__I;
  wire                 SSP_SHARED_3_pad_0__O;
  wire                 SSP_SHARED_3_pad_0__T;
  wire                 SSP_SHARED_40_pad_0__I;
  wire                 SSP_SHARED_40_pad_0__O;
  wire                 SSP_SHARED_40_pad_0__T;
  wire                 SSP_SHARED_41_pad_0__I;
  wire                 SSP_SHARED_41_pad_0__O;
  wire                 SSP_SHARED_41_pad_0__T;
  wire                 SSP_SHARED_42_pad_0__I;
  wire                 SSP_SHARED_42_pad_0__O;
  wire                 SSP_SHARED_42_pad_0__T;
  wire                 SSP_SHARED_43_pad_0__I;
  wire                 SSP_SHARED_43_pad_0__O;
  wire                 SSP_SHARED_43_pad_0__T;
  wire                 SSP_SHARED_44_pad_0__I;
  wire                 SSP_SHARED_44_pad_0__O;
  wire                 SSP_SHARED_44_pad_0__T;
  wire                 SSP_SHARED_45_pad_0__I;
  wire                 SSP_SHARED_45_pad_0__O;
  wire                 SSP_SHARED_45_pad_0__T;
  wire                 SSP_SHARED_46_pad_0__I;
  wire                 SSP_SHARED_46_pad_0__O;
  wire                 SSP_SHARED_46_pad_0__T;
  wire                 SSP_SHARED_47_pad_0__I;
  wire                 SSP_SHARED_47_pad_0__O;
  wire                 SSP_SHARED_47_pad_0__T;
  wire                 SSP_SHARED_4_pad_0__I;
  wire                 SSP_SHARED_4_pad_0__O;
  wire                 SSP_SHARED_4_pad_0__T;
  wire                 SSP_SHARED_5_pad_0__I;
  wire                 SSP_SHARED_5_pad_0__O;
  wire                 SSP_SHARED_5_pad_0__T;
  wire                 SSP_SHARED_6_pad_0__I;
  wire                 SSP_SHARED_6_pad_0__O;
  wire                 SSP_SHARED_6_pad_0__T;
  wire                 SSP_SHARED_7_pad_0__I;
  wire                 SSP_SHARED_7_pad_0__O;
  wire                 SSP_SHARED_7_pad_0__T;
  wire                 SSP_SHARED_8_pad_0__I;
  wire                 SSP_SHARED_8_pad_0__O;
  wire                 SSP_SHARED_8_pad_0__T;
  wire                 SSP_SHARED_9_pad_0__I;
  wire                 SSP_SHARED_9_pad_0__O;
  wire                 SSP_SHARED_9_pad_0__T;
  wire                 i2c0_ic_clk_pad_0__I;
  wire                 i2c0_ic_clk_pad_0__O;
  wire                 i2c0_ic_clk_pad_0__T;
  wire                 i2c0_ic_data_pad_0__I;
  wire                 i2c0_ic_data_pad_0__O;
  wire                 i2c0_ic_data_pad_0__T;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_0;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_1;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_10;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_11;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_12;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_13;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_14;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_15;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_16;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_17;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_18;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_19;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_2;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_20;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_21;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_22;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_23;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_24;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_25;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_26;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_27;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_28;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_29;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_3;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_30;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_31;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_32;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_33;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_34;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_35;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_36;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_37;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_38;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_39;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_4;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_40;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_41;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_42;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_43;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_44;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_45;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_46;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_47;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_5;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_6;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_7;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_8;
  wire[1:0]            io_muxes_u__SSP_SHARED_sel_9;
  wire                 io_muxes_u__c2p_SSP_SHARED_0;
  wire                 io_muxes_u__c2p_SSP_SHARED_0_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_1;
  wire                 io_muxes_u__c2p_SSP_SHARED_12;
  wire                 io_muxes_u__c2p_SSP_SHARED_13;
  wire                 io_muxes_u__c2p_SSP_SHARED_13_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_15;
  wire                 io_muxes_u__c2p_SSP_SHARED_15_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_16;
  wire                 io_muxes_u__c2p_SSP_SHARED_16_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_17;
  wire                 io_muxes_u__c2p_SSP_SHARED_17_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_18;
  wire                 io_muxes_u__c2p_SSP_SHARED_18_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_19;
  wire                 io_muxes_u__c2p_SSP_SHARED_19_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_2;
  wire                 io_muxes_u__c2p_SSP_SHARED_20;
  wire                 io_muxes_u__c2p_SSP_SHARED_20_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_21;
  wire                 io_muxes_u__c2p_SSP_SHARED_21_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_22;
  wire                 io_muxes_u__c2p_SSP_SHARED_22_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_23;
  wire                 io_muxes_u__c2p_SSP_SHARED_23_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_24;
  wire                 io_muxes_u__c2p_SSP_SHARED_24_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_25;
  wire                 io_muxes_u__c2p_SSP_SHARED_25_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_26;
  wire                 io_muxes_u__c2p_SSP_SHARED_26_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_27;
  wire                 io_muxes_u__c2p_SSP_SHARED_27_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_28;
  wire                 io_muxes_u__c2p_SSP_SHARED_28_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_29;
  wire                 io_muxes_u__c2p_SSP_SHARED_29_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_3;
  wire                 io_muxes_u__c2p_SSP_SHARED_30;
  wire                 io_muxes_u__c2p_SSP_SHARED_30_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_31;
  wire                 io_muxes_u__c2p_SSP_SHARED_31_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_32;
  wire                 io_muxes_u__c2p_SSP_SHARED_32_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_33;
  wire                 io_muxes_u__c2p_SSP_SHARED_33_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_34;
  wire                 io_muxes_u__c2p_SSP_SHARED_34_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_35;
  wire                 io_muxes_u__c2p_SSP_SHARED_35_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_36;
  wire                 io_muxes_u__c2p_SSP_SHARED_36_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_37;
  wire                 io_muxes_u__c2p_SSP_SHARED_37_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_38;
  wire                 io_muxes_u__c2p_SSP_SHARED_38_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_39;
  wire                 io_muxes_u__c2p_SSP_SHARED_39_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_3_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_4;
  wire                 io_muxes_u__c2p_SSP_SHARED_40;
  wire                 io_muxes_u__c2p_SSP_SHARED_40_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_41;
  wire                 io_muxes_u__c2p_SSP_SHARED_41_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_42;
  wire                 io_muxes_u__c2p_SSP_SHARED_42_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_43;
  wire                 io_muxes_u__c2p_SSP_SHARED_43_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_44;
  wire                 io_muxes_u__c2p_SSP_SHARED_44_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_45;
  wire                 io_muxes_u__c2p_SSP_SHARED_45_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_46;
  wire                 io_muxes_u__c2p_SSP_SHARED_46_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_47;
  wire                 io_muxes_u__c2p_SSP_SHARED_47_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_4_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_5;
  wire                 io_muxes_u__c2p_SSP_SHARED_5_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_6;
  wire                 io_muxes_u__c2p_SSP_SHARED_7;
  wire                 io_muxes_u__c2p_SSP_SHARED_7_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_8;
  wire                 io_muxes_u__c2p_SSP_SHARED_8_oen;
  wire                 io_muxes_u__c2p_SSP_SHARED_9;
  wire                 io_muxes_u__c2p_SSP_SHARED_9_oen;
  wire[31:0]           io_muxes_u__c2p_gpio_porta;
  wire[31:0]           io_muxes_u__c2p_gpio_porta_oen;
  wire                 io_muxes_u__c2p_i2c1_ic_clk;
  wire                 io_muxes_u__c2p_i2c1_ic_clk_oen;
  wire                 io_muxes_u__c2p_i2c1_ic_data;
  wire                 io_muxes_u__c2p_i2c1_ic_data_oen;
  wire                 io_muxes_u__c2p_i2c2_ic_clk;
  wire                 io_muxes_u__c2p_i2c2_ic_clk_oen;
  wire                 io_muxes_u__c2p_i2c2_ic_data;
  wire                 io_muxes_u__c2p_i2c2_ic_data_oen;
  wire                 io_muxes_u__c2p_i2srxm0_sclk;
  wire                 io_muxes_u__c2p_i2srxm0_ws;
  wire                 io_muxes_u__c2p_i2srxm1_sclk;
  wire                 io_muxes_u__c2p_i2srxm1_ws;
  wire                 io_muxes_u__c2p_i2srxm2_sclk;
  wire                 io_muxes_u__c2p_i2srxm2_ws;
  wire                 io_muxes_u__c2p_i2srxm3_sclk;
  wire                 io_muxes_u__c2p_i2srxm3_ws;
  wire                 io_muxes_u__c2p_i2srxm4_sclk;
  wire                 io_muxes_u__c2p_i2srxm4_ws;
  wire                 io_muxes_u__c2p_i2srxm5_sclk;
  wire                 io_muxes_u__c2p_i2srxm5_ws;
  wire[3:0]            io_muxes_u__c2p_i2stxm_data;
  wire                 io_muxes_u__c2p_i2stxm_sclk;
  wire                 io_muxes_u__c2p_i2stxm_ws;
  wire[9:0]            io_muxes_u__c2p_scan_out;
  wire                 io_muxes_u__c2p_spis_txd;
  wire                 io_muxes_u__c2p_sspim1_sclk_out;
  wire                 io_muxes_u__c2p_sspim1_ss;
  wire                 io_muxes_u__c2p_sspim1_txd;
  wire                 io_muxes_u__c2p_sspim2_sclk_out;
  wire                 io_muxes_u__c2p_sspim2_ss;
  wire                 io_muxes_u__c2p_sspim2_txd;
  wire[7:0]            io_muxes_u__c2p_tim_pwn;
  wire                 io_muxes_u__c2p_uart0_rts_n;
  wire                 io_muxes_u__c2p_uart0_sout;
  wire                 io_muxes_u__c2p_uart3_sout;
  wire                 io_muxes_u__p2c_SSP_SHARED_0;
  wire                 io_muxes_u__p2c_SSP_SHARED_10;
  wire                 io_muxes_u__p2c_SSP_SHARED_11;
  wire                 io_muxes_u__p2c_SSP_SHARED_13;
  wire                 io_muxes_u__p2c_SSP_SHARED_14;
  wire                 io_muxes_u__p2c_SSP_SHARED_15;
  wire                 io_muxes_u__p2c_SSP_SHARED_16;
  wire                 io_muxes_u__p2c_SSP_SHARED_17;
  wire                 io_muxes_u__p2c_SSP_SHARED_18;
  wire                 io_muxes_u__p2c_SSP_SHARED_19;
  wire                 io_muxes_u__p2c_SSP_SHARED_20;
  wire                 io_muxes_u__p2c_SSP_SHARED_21;
  wire                 io_muxes_u__p2c_SSP_SHARED_22;
  wire                 io_muxes_u__p2c_SSP_SHARED_23;
  wire                 io_muxes_u__p2c_SSP_SHARED_24;
  wire                 io_muxes_u__p2c_SSP_SHARED_25;
  wire                 io_muxes_u__p2c_SSP_SHARED_26;
  wire                 io_muxes_u__p2c_SSP_SHARED_27;
  wire                 io_muxes_u__p2c_SSP_SHARED_28;
  wire                 io_muxes_u__p2c_SSP_SHARED_29;
  wire                 io_muxes_u__p2c_SSP_SHARED_3;
  wire                 io_muxes_u__p2c_SSP_SHARED_30;
  wire                 io_muxes_u__p2c_SSP_SHARED_31;
  wire                 io_muxes_u__p2c_SSP_SHARED_32;
  wire                 io_muxes_u__p2c_SSP_SHARED_33;
  wire                 io_muxes_u__p2c_SSP_SHARED_34;
  wire                 io_muxes_u__p2c_SSP_SHARED_35;
  wire                 io_muxes_u__p2c_SSP_SHARED_36;
  wire                 io_muxes_u__p2c_SSP_SHARED_37;
  wire                 io_muxes_u__p2c_SSP_SHARED_38;
  wire                 io_muxes_u__p2c_SSP_SHARED_39;
  wire                 io_muxes_u__p2c_SSP_SHARED_4;
  wire                 io_muxes_u__p2c_SSP_SHARED_40;
  wire                 io_muxes_u__p2c_SSP_SHARED_41;
  wire                 io_muxes_u__p2c_SSP_SHARED_42;
  wire                 io_muxes_u__p2c_SSP_SHARED_43;
  wire                 io_muxes_u__p2c_SSP_SHARED_44;
  wire                 io_muxes_u__p2c_SSP_SHARED_45;
  wire                 io_muxes_u__p2c_SSP_SHARED_46;
  wire                 io_muxes_u__p2c_SSP_SHARED_47;
  wire                 io_muxes_u__p2c_SSP_SHARED_5;
  wire                 io_muxes_u__p2c_SSP_SHARED_7;
  wire                 io_muxes_u__p2c_SSP_SHARED_8;
  wire                 io_muxes_u__p2c_SSP_SHARED_9;
  wire[1:0]            io_muxes_u__p2c_boot_mode;
  wire[31:0]           io_muxes_u__p2c_gpio_porta;
  wire                 io_muxes_u__p2c_i2c1_ic_clk;
  wire                 io_muxes_u__p2c_i2c1_ic_data;
  wire                 io_muxes_u__p2c_i2c2_ic_clk;
  wire                 io_muxes_u__p2c_i2c2_ic_data;
  wire[3:0]            io_muxes_u__p2c_i2srxm0_data;
  wire[3:0]            io_muxes_u__p2c_i2srxm1_data;
  wire[3:0]            io_muxes_u__p2c_i2srxm2_data;
  wire[3:0]            io_muxes_u__p2c_i2srxm3_data;
  wire[3:0]            io_muxes_u__p2c_i2srxm4_data;
  wire[3:0]            io_muxes_u__p2c_i2srxm5_data;
  wire                 io_muxes_u__p2c_scan_enable;
  wire[9:0]            io_muxes_u__p2c_scan_in;
  wire                 io_muxes_u__p2c_scan_reset;
  wire                 io_muxes_u__p2c_scan_test_modes;
  wire                 io_muxes_u__p2c_spis_rxd;
  wire                 io_muxes_u__p2c_spis_sclk_in;
  wire                 io_muxes_u__p2c_spis_ss;
  wire                 io_muxes_u__p2c_sspim1_rxd;
  wire                 io_muxes_u__p2c_sspim2_rxd;
  wire                 io_muxes_u__p2c_uart0_cts_n;
  wire                 io_muxes_u__p2c_uart0_sin;
  wire                 io_muxes_u__p2c_uart3_sin;
  wire                 io_muxes_u__test_mode;
  wire                 jtag_wrapper_u__aclk;
  oursring_req_if_ar_t jtag_wrapper_u__or_req_ar;
  wire                 jtag_wrapper_u__or_req_arready;
  wire                 jtag_wrapper_u__or_req_arvalid;
  oursring_req_if_aw_t jtag_wrapper_u__or_req_aw;
  wire                 jtag_wrapper_u__or_req_awready;
  wire                 jtag_wrapper_u__or_req_awvalid;
  oursring_req_if_w_t  jtag_wrapper_u__or_req_w;
  wire                 jtag_wrapper_u__or_req_wready;
  wire                 jtag_wrapper_u__or_req_wvalid;
  oursring_resp_if_b_t jtag_wrapper_u__or_rsp_b;
  wire                 jtag_wrapper_u__or_rsp_bready;
  wire                 jtag_wrapper_u__or_rsp_bvalid;
  oursring_resp_if_r_t jtag_wrapper_u__or_rsp_r;
  wire                 jtag_wrapper_u__or_rsp_rready;
  wire                 jtag_wrapper_u__or_rsp_rvalid;
  wire                 jtag_wrapper_u__reset;
  wire                 jtag_wrapper_u__rstblk_out;
  wire                 qspim_sclk_out_pad_0__I;
  wire                 qspim_sclk_out_pad_0__O;
  wire                 qspim_sclk_out_pad_0__T;
  wire                 qspim_ss_pad_0__I;
  wire                 qspim_ss_pad_0__O;
  wire                 qspim_ss_pad_0__T;
  wire                 qspim_trxd_pad_0__I;
  wire                 qspim_trxd_pad_0__O;
  wire                 qspim_trxd_pad_0__T;
  wire                 qspim_trxd_pad_1__I;
  wire                 qspim_trxd_pad_1__O;
  wire                 qspim_trxd_pad_1__T;
  wire                 qspim_trxd_pad_2__I;
  wire                 qspim_trxd_pad_2__O;
  wire                 qspim_trxd_pad_2__T;
  wire                 qspim_trxd_pad_3__I;
  wire                 qspim_trxd_pad_3__O;
  wire                 qspim_trxd_pad_3__T;
  wire                 sd_card_detect_n_pad_0__I;
  wire                 sd_card_detect_n_pad_0__O;
  wire                 sd_card_detect_n_pad_0__T;
  wire                 sd_card_write_prot_pad_0__I;
  wire                 sd_card_write_prot_pad_0__O;
  wire                 sd_card_write_prot_pad_0__T;
  wire                 sd_clk_pad_0__I;
  wire                 sd_clk_pad_0__O;
  wire                 sd_clk_pad_0__T;
  wire                 sd_cmd_in_out_pad_0__I;
  wire                 sd_cmd_in_out_pad_0__O;
  wire                 sd_cmd_in_out_pad_0__T;
  wire[0:0]            sd_cmd_oen_inv_u__in;
  wire[0:0]            sd_cmd_oen_inv_u__out;
  wire                 sd_dat_in_out_pad_0__I;
  wire                 sd_dat_in_out_pad_0__O;
  wire                 sd_dat_in_out_pad_0__T;
  wire                 sd_dat_in_out_pad_1__I;
  wire                 sd_dat_in_out_pad_1__O;
  wire                 sd_dat_in_out_pad_1__T;
  wire                 sd_dat_in_out_pad_2__I;
  wire                 sd_dat_in_out_pad_2__O;
  wire                 sd_dat_in_out_pad_2__T;
  wire                 sd_dat_in_out_pad_3__I;
  wire                 sd_dat_in_out_pad_3__O;
  wire                 sd_dat_in_out_pad_3__T;
  wire[3:0]            sd_dat_oen_inv_u__in;
  wire[3:0]            sd_dat_oen_inv_u__out;
  wire                 soc_top_u__B0_pll_out;
  wire                 soc_top_u__B10_pll_out;
  wire                 soc_top_u__B11_pll_out;
  wire                 soc_top_u__B12_pll_out;
  wire                 soc_top_u__B13_pll_out;
  wire                 soc_top_u__B14_pll_out;
  wire                 soc_top_u__B15_pll_out;
  wire                 soc_top_u__B16_pll_out;
  wire                 soc_top_u__B17_pll_out;
  wire                 soc_top_u__B18_pll_out;
  wire                 soc_top_u__B19_pll_out;
  wire                 soc_top_u__B1_ddr_pwr_ok_in;
  wire                 soc_top_u__B1_pll_out;
  wire                 soc_top_u__B20_pll_out;
  wire                 soc_top_u__B21_pll_out;
  wire                 soc_top_u__B22_pll_out;
  wire                 soc_top_u__B23_pll_out;
  wire                 soc_top_u__B24_pll_out;
  wire                 soc_top_u__B2_pll_out;
  wire                 soc_top_u__B3_dft_mbist_mode;
  wire                 soc_top_u__B3_pll_out;
  wire                 soc_top_u__B4_pll_out;
  wire                 soc_top_u__B5_pll_out;
  wire                 soc_top_u__B6_pll_out;
  wire                 soc_top_u__B7_pll_out;
  wire                 soc_top_u__B8_pll_out;
  wire                 soc_top_u__B9_pll_out;
  wire[11:0]           soc_top_u__BP_A;
  wire                 soc_top_u__BP_ALERT_N;
  wire[23:0]           soc_top_u__BP_D;
  wire                 soc_top_u__BP_DM0;
  wire                 soc_top_u__BP_DP0;
  wire                 soc_top_u__BP_ID0;
  wire                 soc_top_u__BP_MEMRESET_L;
  wire                 soc_top_u__BP_VBUS0;
  wire                 soc_top_u__BP_VREF;
  wire                 soc_top_u__BP_ZN;
  wire                 soc_top_u__BP_ZN_SENSE;
  wire                 soc_top_u__BP_resref;
  wire[11:0]           soc_top_u__BypassInDataAC;
  wire[23:0]           soc_top_u__BypassInDataDAT;
  wire[1:0]            soc_top_u__BypassInDataMASTER;
  wire                 soc_top_u__BypassModeEnAC;
  wire                 soc_top_u__BypassModeEnDAT;
  wire                 soc_top_u__BypassModeEnMASTER;
  wire[11:0]           soc_top_u__BypassOutDataAC;
  wire[23:0]           soc_top_u__BypassOutDataDAT;
  wire[1:0]            soc_top_u__BypassOutDataMASTER;
  wire[11:0]           soc_top_u__BypassOutEnAC;
  wire[23:0]           soc_top_u__BypassOutEnDAT;
  wire[1:0]            soc_top_u__BypassOutEnMASTER;
  wire                 soc_top_u__C25_usb_pwrdown_ssp;
  wire                 soc_top_u__C26_usb_pwrdown_hsp;
  wire                 soc_top_u__C27_usb_ref_ssp_en;
  wire                 soc_top_u__C28_usb_ref_use_pad;
  wire                 soc_top_u__DIN_DONE;
  wire[63:0]           soc_top_u__DIN_ERROR_LOG_HI;
  wire[63:0]           soc_top_u__DIN_ERROR_LOG_LO;
  wire                 soc_top_u__FUNC_CLK;
  wire                 soc_top_u__FUNC_EN_CUS_MBIST;
  wire                 soc_top_u__ana_bscan_sel;
  wire                 soc_top_u__boot_from_flash_mode;
  wire                 soc_top_u__boot_fsm_mode;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_0;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_1;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_10;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_11;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_12;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_13;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_14;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_15;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_16;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_17;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_18;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_19;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_2;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_20;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_21;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_22;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_23;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_24;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_25;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_26;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_27;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_28;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_29;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_3;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_30;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_31;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_32;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_33;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_34;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_35;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_36;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_37;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_38;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_39;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_4;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_40;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_41;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_42;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_43;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_44;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_45;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_46;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_47;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_5;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_6;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_7;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_8;
  wire[1:0]            soc_top_u__c2p_SSP_SHARED_sel_9;
  wire[31:0]           soc_top_u__c2p_gpio_porta_ddr;
  wire[31:0]           soc_top_u__c2p_gpio_porta_dr;
  wire                 soc_top_u__c2p_i2c0_ic_clk_oen;
  wire                 soc_top_u__c2p_i2c0_ic_data_oen;
  wire                 soc_top_u__c2p_i2c1_ic_clk_oen;
  wire                 soc_top_u__c2p_i2c1_ic_data_oen;
  wire                 soc_top_u__c2p_i2c2_ic_clk_oen;
  wire                 soc_top_u__c2p_i2c2_ic_data_oen;
  wire                 soc_top_u__c2p_i2sm_sclk;
  wire                 soc_top_u__c2p_i2sm_sdo0;
  wire                 soc_top_u__c2p_i2sm_sdo1;
  wire                 soc_top_u__c2p_i2sm_sdo2;
  wire                 soc_top_u__c2p_i2sm_sdo3;
  wire                 soc_top_u__c2p_i2sm_ws_out;
  wire                 soc_top_u__c2p_i2ss0_sclk;
  wire                 soc_top_u__c2p_i2ss0_ws_out;
  wire                 soc_top_u__c2p_i2ss1_sclk;
  wire                 soc_top_u__c2p_i2ss1_ws_out;
  wire                 soc_top_u__c2p_i2ss2_sclk;
  wire                 soc_top_u__c2p_i2ss2_ws_out;
  wire                 soc_top_u__c2p_i2ss3_sclk;
  wire                 soc_top_u__c2p_i2ss3_ws_out;
  wire                 soc_top_u__c2p_i2ss4_sclk;
  wire                 soc_top_u__c2p_i2ss4_ws_out;
  wire                 soc_top_u__c2p_i2ss5_sclk;
  wire                 soc_top_u__c2p_i2ss5_ws_out;
  wire                 soc_top_u__c2p_jtag_tdo;
  wire                 soc_top_u__c2p_jtag_tdo_oen;
  wire                 soc_top_u__c2p_qspim_clk;
  wire                 soc_top_u__c2p_qspim_cs_n;
  wire[3:0]            soc_top_u__c2p_qspim_io_oen;
  wire[3:0]            soc_top_u__c2p_qspim_o;
  wire                 soc_top_u__c2p_scan_f_out;
  wire[9:0]            soc_top_u__c2p_scan_out;
  wire                 soc_top_u__c2p_spis_o;
  wire                 soc_top_u__c2p_sspim0_clk;
  wire                 soc_top_u__c2p_sspim0_cs_n;
  wire                 soc_top_u__c2p_sspim0_o;
  wire                 soc_top_u__c2p_sspim1_clk;
  wire                 soc_top_u__c2p_sspim1_cs_n;
  wire                 soc_top_u__c2p_sspim1_o;
  wire                 soc_top_u__c2p_sspim2_clk;
  wire                 soc_top_u__c2p_sspim2_cs_n;
  wire                 soc_top_u__c2p_sspim2_o;
  wire                 soc_top_u__c2p_test_io_clk;
  wire                 soc_top_u__c2p_test_io_clk_oen;
  wire                 soc_top_u__c2p_test_io_data;
  wire                 soc_top_u__c2p_test_io_data_oen;
  wire                 soc_top_u__c2p_test_io_en;
  wire                 soc_top_u__c2p_test_io_en_oen;
  wire                 soc_top_u__c2p_timer_1_toggle;
  wire                 soc_top_u__c2p_timer_2_toggle;
  wire                 soc_top_u__c2p_timer_3_toggle;
  wire                 soc_top_u__c2p_timer_4_toggle;
  wire                 soc_top_u__c2p_timer_5_toggle;
  wire                 soc_top_u__c2p_timer_6_toggle;
  wire                 soc_top_u__c2p_timer_7_toggle;
  wire                 soc_top_u__c2p_timer_8_toggle;
  wire                 soc_top_u__c2p_uart0_rts_n;
  wire                 soc_top_u__c2p_uart0_sout;
  wire                 soc_top_u__c2p_uart1_sout;
  wire                 soc_top_u__c2p_uart2_sout;
  wire                 soc_top_u__c2p_uart3_sout;
  wire                 soc_top_u__card_detect_n;
  wire                 soc_top_u__card_write_prot;
  wire                 soc_top_u__cclk_rx;
  wire                 soc_top_u__cmd_vld_in;
  wire[127:0]          soc_top_u__cmdbuf_in;
  wire                 soc_top_u__dft_glue_u_tck_invert_in;
  wire                 soc_top_u__gated_tx_clk_out;
  wire                 soc_top_u__global_scan_enable;
  wire                 soc_top_u__io_test_mode;
  wire                 soc_top_u__jtag_tdi_to_usb;
  wire                 soc_top_u__jtag_tdo_en_from_usb;
  wire                 soc_top_u__jtag_tdo_from_usb;
  wire                 soc_top_u__jtag_tms_to_usb;
  wire                 soc_top_u__jtag_trst_n_to_usb;
  cache_mem_if_ar_t    soc_top_u__mem_noc_req_if_ar;
  wire                 soc_top_u__mem_noc_req_if_arready;
  wire                 soc_top_u__mem_noc_req_if_arvalid;
  cache_mem_if_aw_t    soc_top_u__mem_noc_req_if_aw;
  wire                 soc_top_u__mem_noc_req_if_awready;
  wire                 soc_top_u__mem_noc_req_if_awvalid;
  cache_mem_if_w_t     soc_top_u__mem_noc_req_if_w;
  wire                 soc_top_u__mem_noc_req_if_wready;
  wire                 soc_top_u__mem_noc_req_if_wvalid;
  cache_mem_if_b_t     soc_top_u__mem_noc_resp_if_b;
  wire                 soc_top_u__mem_noc_resp_if_bready;
  wire                 soc_top_u__mem_noc_resp_if_bvalid;
  cache_mem_if_r_t     soc_top_u__mem_noc_resp_if_r;
  wire                 soc_top_u__mem_noc_resp_if_rready;
  wire                 soc_top_u__mem_noc_resp_if_rvalid;
  oursring_req_if_ar_t soc_top_u__or_req_if_ar;
  wire                 soc_top_u__or_req_if_arready;
  wire                 soc_top_u__or_req_if_arvalid;
  oursring_req_if_aw_t soc_top_u__or_req_if_aw;
  wire                 soc_top_u__or_req_if_awready;
  wire                 soc_top_u__or_req_if_awvalid;
  oursring_req_if_w_t  soc_top_u__or_req_if_w;
  wire                 soc_top_u__or_req_if_wready;
  wire                 soc_top_u__or_req_if_wvalid;
  oursring_resp_if_b_t soc_top_u__or_resp_if_b;
  wire                 soc_top_u__or_resp_if_bready;
  wire                 soc_top_u__or_resp_if_bvalid;
  oursring_resp_if_r_t soc_top_u__or_resp_if_r;
  wire                 soc_top_u__or_resp_if_rready;
  wire                 soc_top_u__or_resp_if_rvalid;
  wire                 soc_top_u__p2c_chip_wake_up;
  wire[31:0]           soc_top_u__p2c_gpio_ext_porta;
  wire                 soc_top_u__p2c_i2c0_ic_clk_in_a;
  wire                 soc_top_u__p2c_i2c0_ic_data_in_a;
  wire                 soc_top_u__p2c_i2c1_ic_clk_in_a;
  wire                 soc_top_u__p2c_i2c1_ic_data_in_a;
  wire                 soc_top_u__p2c_i2c2_ic_clk_in_a;
  wire                 soc_top_u__p2c_i2c2_ic_data_in_a;
  wire                 soc_top_u__p2c_i2ss0_sdi0;
  wire                 soc_top_u__p2c_i2ss0_sdi1;
  wire                 soc_top_u__p2c_i2ss0_sdi2;
  wire                 soc_top_u__p2c_i2ss0_sdi3;
  wire                 soc_top_u__p2c_i2ss1_sdi0;
  wire                 soc_top_u__p2c_i2ss1_sdi1;
  wire                 soc_top_u__p2c_i2ss1_sdi2;
  wire                 soc_top_u__p2c_i2ss1_sdi3;
  wire                 soc_top_u__p2c_i2ss2_sdi0;
  wire                 soc_top_u__p2c_i2ss2_sdi1;
  wire                 soc_top_u__p2c_i2ss2_sdi2;
  wire                 soc_top_u__p2c_i2ss2_sdi3;
  wire                 soc_top_u__p2c_i2ss3_sdi0;
  wire                 soc_top_u__p2c_i2ss3_sdi1;
  wire                 soc_top_u__p2c_i2ss3_sdi2;
  wire                 soc_top_u__p2c_i2ss3_sdi3;
  wire                 soc_top_u__p2c_i2ss4_sdi0;
  wire                 soc_top_u__p2c_i2ss4_sdi1;
  wire                 soc_top_u__p2c_i2ss4_sdi2;
  wire                 soc_top_u__p2c_i2ss4_sdi3;
  wire                 soc_top_u__p2c_i2ss5_sdi0;
  wire                 soc_top_u__p2c_i2ss5_sdi1;
  wire                 soc_top_u__p2c_i2ss5_sdi2;
  wire                 soc_top_u__p2c_i2ss5_sdi3;
  wire                 soc_top_u__p2c_jtag_tck;
  wire                 soc_top_u__p2c_jtag_tdi;
  wire                 soc_top_u__p2c_jtag_tms;
  wire                 soc_top_u__p2c_jtag_trst_n;
  wire[3:0]            soc_top_u__p2c_qspim_i;
  wire                 soc_top_u__p2c_refclk;
  wire                 soc_top_u__p2c_resetn;
  wire                 soc_top_u__p2c_rtcclk;
  wire                 soc_top_u__p2c_scan_ate_clk;
  wire                 soc_top_u__p2c_scan_enable;
  wire                 soc_top_u__p2c_scan_f_clk;
  wire                 soc_top_u__p2c_scan_f_in;
  wire                 soc_top_u__p2c_scan_f_mode;
  wire                 soc_top_u__p2c_scan_f_reset;
  wire[9:0]            soc_top_u__p2c_scan_in;
  wire                 soc_top_u__p2c_scan_mode;
  wire                 soc_top_u__p2c_scan_reset;
  wire                 soc_top_u__p2c_scan_tap_compliance;
  wire                 soc_top_u__p2c_scan_test_modes;
  wire                 soc_top_u__p2c_spis_clk;
  wire                 soc_top_u__p2c_spis_cs_n;
  wire                 soc_top_u__p2c_spis_i;
  wire                 soc_top_u__p2c_sspim0_i;
  wire                 soc_top_u__p2c_sspim1_i;
  wire                 soc_top_u__p2c_sspim2_i;
  wire                 soc_top_u__p2c_test_io_clk;
  wire                 soc_top_u__p2c_test_io_data;
  wire                 soc_top_u__p2c_test_io_en;
  wire                 soc_top_u__p2c_uart0_cts_n;
  wire                 soc_top_u__p2c_uart0_sin;
  wire                 soc_top_u__p2c_uart1_sin;
  wire                 soc_top_u__p2c_uart2_sin;
  wire                 soc_top_u__p2c_uart3_sin;
  wire                 soc_top_u__pygmy_es1y_ac_init_clk_in;
  wire                 soc_top_u__pygmy_es1y_ac_mode_in;
  wire                 soc_top_u__pygmy_es1y_ac_test_in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_CLAMP___in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_EXTEST_PULSE__EXTEST_TRAIN___in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_EXTEST__INTEST___in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_HIGHZ__RUNBIST___in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_PRELOAD__SAMPLE___in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_capture_dr_1_in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_one_in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_shift_dr_13_in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_update_dr_1_in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_zero_in;
  wire                 soc_top_u__pygmy_es1y_pygmy_es1y_zero_ina;
  wire                 soc_top_u__pygmy_es1y_shift_dr_in;
  wire                 soc_top_u__pygmy_es1y_soc_top_u_si_in;
  wire[63:0]           soc_top_u__rdata_out;
  wire                 soc_top_u__rdata_vld_out;
  wire                 soc_top_u__ref_pad_clk_m;
  wire                 soc_top_u__ref_pad_clk_p;
  wire                 soc_top_u__rx0_m;
  wire                 soc_top_u__rx0_p;
  wire                 soc_top_u__sd_cmd_in;
  wire                 soc_top_u__sd_cmd_out;
  wire                 soc_top_u__sd_cmd_out_en;
  wire[3:0]            soc_top_u__sd_dat_in;
  wire[3:0]            soc_top_u__sd_dat_out;
  wire[3:0]            soc_top_u__sd_dat_out_en;
  wire                 soc_top_u__soc_top_u_out;
  wire                 soc_top_u__tx0_m;
  wire                 soc_top_u__tx0_p;
  wire                 soc_top_u__usb_icg_ten;
  wire                 soc_top_u__usb_jtag_tck_gated;
  wire                 soc_top_u__vcore_icg_ten;
  wire                 sspim0_rxd_pad_0__I;
  wire                 sspim0_rxd_pad_0__O;
  wire                 sspim0_rxd_pad_0__T;
  wire                 sspim0_sclk_out_pad_0__I;
  wire                 sspim0_sclk_out_pad_0__O;
  wire                 sspim0_sclk_out_pad_0__T;
  wire                 sspim0_ss_pad_0__I;
  wire                 sspim0_ss_pad_0__O;
  wire                 sspim0_ss_pad_0__T;
  wire                 sspim0_txd_pad_0__I;
  wire                 sspim0_txd_pad_0__O;
  wire                 sspim0_txd_pad_0__T;
  wire                 uart1_sin_pad_0__I;
  wire                 uart1_sin_pad_0__O;
  wire                 uart1_sin_pad_0__T;
  wire                 uart1_sout_pad_0__I;
  wire                 uart1_sout_pad_0__O;
  wire                 uart1_sout_pad_0__T;
  wire                 uart2_sin_pad_0__I;
  wire                 uart2_sin_pad_0__O;
  wire                 uart2_sin_pad_0__T;
  wire                 uart2_sout_pad_0__I;
  wire                 uart2_sout_pad_0__O;
  wire                 uart2_sout_pad_0__T;
  wire                 xilinx_ddr_u__addn_ui_clkout1;
  wire                 xilinx_ddr_u__c0_ddr4_act_n;
  wire[16:0]           xilinx_ddr_u__c0_ddr4_adr;
  wire[1:0]            xilinx_ddr_u__c0_ddr4_ba;
  wire[0:0]            xilinx_ddr_u__c0_ddr4_bg;
  wire[0:0]            xilinx_ddr_u__c0_ddr4_ck_c;
  wire[0:0]            xilinx_ddr_u__c0_ddr4_ck_t;
  wire[0:0]            xilinx_ddr_u__c0_ddr4_cke;
  wire[0:0]            xilinx_ddr_u__c0_ddr4_cs_n;
  wire[0:0]            xilinx_ddr_u__c0_ddr4_odt;
  wire                 xilinx_ddr_u__c0_ddr4_reset_n;
  wire                 xilinx_ddr_u__c0_init_calib_complete;
  wire                 xilinx_ddr_u__c0_sys_clk_n;
  wire                 xilinx_ddr_u__c0_sys_clk_p;
  cache_mem_if_ar_t    xilinx_ddr_u__req_if_ar;
  wire                 xilinx_ddr_u__req_if_arready;
  wire                 xilinx_ddr_u__req_if_arvalid;
  cache_mem_if_aw_t    xilinx_ddr_u__req_if_aw;
  wire                 xilinx_ddr_u__req_if_awready;
  wire                 xilinx_ddr_u__req_if_awvalid;
  cache_mem_if_w_t     xilinx_ddr_u__req_if_w;
  wire                 xilinx_ddr_u__req_if_wready;
  wire                 xilinx_ddr_u__req_if_wvalid;
  cache_mem_if_b_t     xilinx_ddr_u__rsp_if_b;
  wire                 xilinx_ddr_u__rsp_if_bready;
  wire                 xilinx_ddr_u__rsp_if_bvalid;
  cache_mem_if_r_t     xilinx_ddr_u__rsp_if_r;
  wire                 xilinx_ddr_u__rsp_if_rready;
  wire                 xilinx_ddr_u__rsp_if_rvalid;
  wire                 xilinx_ddr_u__sys_rst;

  // SSP_SHARED_0_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_0
  assign SSP_SHARED_0_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_0;

  // SSP_SHARED_0_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_0
  assign io_muxes_u__p2c_SSP_SHARED_0        = SSP_SHARED_0_pad_0__O;

  // SSP_SHARED_0_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_0_oen
  assign SSP_SHARED_0_pad_0__T               = io_muxes_u__c2p_SSP_SHARED_0_oen;

  // SSP_SHARED_10_pad_0/I <-> 'b0
  assign SSP_SHARED_10_pad_0__I              = {{($bits(SSP_SHARED_10_pad_0__I)-1){1'b0}}, 1'b0};

  // SSP_SHARED_10_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_10
  assign io_muxes_u__p2c_SSP_SHARED_10       = SSP_SHARED_10_pad_0__O;

  // SSP_SHARED_10_pad_0/T <-> 'b1
  assign SSP_SHARED_10_pad_0__T              = {{($bits(SSP_SHARED_10_pad_0__T)-1){1'b0}}, 1'b1};

  // SSP_SHARED_11_pad_0/I <-> 'b0
  assign SSP_SHARED_11_pad_0__I              = {{($bits(SSP_SHARED_11_pad_0__I)-1){1'b0}}, 1'b0};

  // SSP_SHARED_11_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_11
  assign io_muxes_u__p2c_SSP_SHARED_11       = SSP_SHARED_11_pad_0__O;

  // SSP_SHARED_11_pad_0/T <-> 'b1
  assign SSP_SHARED_11_pad_0__T              = {{($bits(SSP_SHARED_11_pad_0__T)-1){1'b0}}, 1'b1};

  // SSP_SHARED_12_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_12
  assign SSP_SHARED_12_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_12;

  // SSP_SHARED_12_pad_0/T <-> 'b0
  assign SSP_SHARED_12_pad_0__T              = {{($bits(SSP_SHARED_12_pad_0__T)-1){1'b0}}, 1'b0};

  // SSP_SHARED_13_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_13
  assign SSP_SHARED_13_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_13;

  // SSP_SHARED_13_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_13
  assign io_muxes_u__p2c_SSP_SHARED_13       = SSP_SHARED_13_pad_0__O;

  // SSP_SHARED_13_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_13_oen
  assign SSP_SHARED_13_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_13_oen;

  // SSP_SHARED_14_pad_0/I <-> 'b0
  assign SSP_SHARED_14_pad_0__I              = {{($bits(SSP_SHARED_14_pad_0__I)-1){1'b0}}, 1'b0};

  // SSP_SHARED_14_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_14
  assign io_muxes_u__p2c_SSP_SHARED_14       = SSP_SHARED_14_pad_0__O;

  // SSP_SHARED_14_pad_0/T <-> 'b1
  assign SSP_SHARED_14_pad_0__T              = {{($bits(SSP_SHARED_14_pad_0__T)-1){1'b0}}, 1'b1};

  // SSP_SHARED_15_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_15
  assign SSP_SHARED_15_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_15;

  // SSP_SHARED_15_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_15
  assign io_muxes_u__p2c_SSP_SHARED_15       = SSP_SHARED_15_pad_0__O;

  // SSP_SHARED_15_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_15_oen
  assign SSP_SHARED_15_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_15_oen;

  // SSP_SHARED_16_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_16
  assign SSP_SHARED_16_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_16;

  // SSP_SHARED_16_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_16
  assign io_muxes_u__p2c_SSP_SHARED_16       = SSP_SHARED_16_pad_0__O;

  // SSP_SHARED_16_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_16_oen
  assign SSP_SHARED_16_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_16_oen;

  // SSP_SHARED_17_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_17
  assign SSP_SHARED_17_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_17;

  // SSP_SHARED_17_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_17
  assign io_muxes_u__p2c_SSP_SHARED_17       = SSP_SHARED_17_pad_0__O;

  // SSP_SHARED_17_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_17_oen
  assign SSP_SHARED_17_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_17_oen;

  // SSP_SHARED_18_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_18
  assign SSP_SHARED_18_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_18;

  // SSP_SHARED_18_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_18
  assign io_muxes_u__p2c_SSP_SHARED_18       = SSP_SHARED_18_pad_0__O;

  // SSP_SHARED_18_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_18_oen
  assign SSP_SHARED_18_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_18_oen;

  // SSP_SHARED_19_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_19
  assign SSP_SHARED_19_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_19;

  // SSP_SHARED_19_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_19
  assign io_muxes_u__p2c_SSP_SHARED_19       = SSP_SHARED_19_pad_0__O;

  // SSP_SHARED_19_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_19_oen
  assign SSP_SHARED_19_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_19_oen;

  // SSP_SHARED_1_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_1
  assign SSP_SHARED_1_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_1;

  // SSP_SHARED_1_pad_0/T <-> 'b0
  assign SSP_SHARED_1_pad_0__T               = {{($bits(SSP_SHARED_1_pad_0__T)-1){1'b0}}, 1'b0};

  // SSP_SHARED_20_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_20
  assign SSP_SHARED_20_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_20;

  // SSP_SHARED_20_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_20
  assign io_muxes_u__p2c_SSP_SHARED_20       = SSP_SHARED_20_pad_0__O;

  // SSP_SHARED_20_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_20_oen
  assign SSP_SHARED_20_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_20_oen;

  // SSP_SHARED_21_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_21
  assign SSP_SHARED_21_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_21;

  // SSP_SHARED_21_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_21
  assign io_muxes_u__p2c_SSP_SHARED_21       = SSP_SHARED_21_pad_0__O;

  // SSP_SHARED_21_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_21_oen
  assign SSP_SHARED_21_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_21_oen;

  // SSP_SHARED_22_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_22
  assign SSP_SHARED_22_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_22;

  // SSP_SHARED_22_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_22
  assign io_muxes_u__p2c_SSP_SHARED_22       = SSP_SHARED_22_pad_0__O;

  // SSP_SHARED_22_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_22_oen
  assign SSP_SHARED_22_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_22_oen;

  // SSP_SHARED_23_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_23
  assign SSP_SHARED_23_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_23;

  // SSP_SHARED_23_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_23
  assign io_muxes_u__p2c_SSP_SHARED_23       = SSP_SHARED_23_pad_0__O;

  // SSP_SHARED_23_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_23_oen
  assign SSP_SHARED_23_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_23_oen;

  // SSP_SHARED_24_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_24
  assign SSP_SHARED_24_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_24;

  // SSP_SHARED_24_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_24
  assign io_muxes_u__p2c_SSP_SHARED_24       = SSP_SHARED_24_pad_0__O;

  // SSP_SHARED_24_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_24_oen
  assign SSP_SHARED_24_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_24_oen;

  // SSP_SHARED_25_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_25
  assign SSP_SHARED_25_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_25;

  // SSP_SHARED_25_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_25
  assign io_muxes_u__p2c_SSP_SHARED_25       = SSP_SHARED_25_pad_0__O;

  // SSP_SHARED_25_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_25_oen
  assign SSP_SHARED_25_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_25_oen;

  // SSP_SHARED_26_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_26
  assign SSP_SHARED_26_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_26;

  // SSP_SHARED_26_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_26
  assign io_muxes_u__p2c_SSP_SHARED_26       = SSP_SHARED_26_pad_0__O;

  // SSP_SHARED_26_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_26_oen
  assign SSP_SHARED_26_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_26_oen;

  // SSP_SHARED_27_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_27
  assign SSP_SHARED_27_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_27;

  // SSP_SHARED_27_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_27
  assign io_muxes_u__p2c_SSP_SHARED_27       = SSP_SHARED_27_pad_0__O;

  // SSP_SHARED_27_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_27_oen
  assign SSP_SHARED_27_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_27_oen;

  // SSP_SHARED_28_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_28
  assign SSP_SHARED_28_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_28;

  // SSP_SHARED_28_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_28
  assign io_muxes_u__p2c_SSP_SHARED_28       = SSP_SHARED_28_pad_0__O;

  // SSP_SHARED_28_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_28_oen
  assign SSP_SHARED_28_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_28_oen;

  // SSP_SHARED_29_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_29
  assign SSP_SHARED_29_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_29;

  // SSP_SHARED_29_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_29
  assign io_muxes_u__p2c_SSP_SHARED_29       = SSP_SHARED_29_pad_0__O;

  // SSP_SHARED_29_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_29_oen
  assign SSP_SHARED_29_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_29_oen;

  // SSP_SHARED_2_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_2
  assign SSP_SHARED_2_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_2;

  // SSP_SHARED_2_pad_0/T <-> 'b0
  assign SSP_SHARED_2_pad_0__T               = {{($bits(SSP_SHARED_2_pad_0__T)-1){1'b0}}, 1'b0};

  // SSP_SHARED_30_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_30
  assign SSP_SHARED_30_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_30;

  // SSP_SHARED_30_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_30
  assign io_muxes_u__p2c_SSP_SHARED_30       = SSP_SHARED_30_pad_0__O;

  // SSP_SHARED_30_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_30_oen
  assign SSP_SHARED_30_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_30_oen;

  // SSP_SHARED_31_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_31
  assign SSP_SHARED_31_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_31;

  // SSP_SHARED_31_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_31
  assign io_muxes_u__p2c_SSP_SHARED_31       = SSP_SHARED_31_pad_0__O;

  // SSP_SHARED_31_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_31_oen
  assign SSP_SHARED_31_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_31_oen;

  // SSP_SHARED_32_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_32
  assign SSP_SHARED_32_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_32;

  // SSP_SHARED_32_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_32
  assign io_muxes_u__p2c_SSP_SHARED_32       = SSP_SHARED_32_pad_0__O;

  // SSP_SHARED_32_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_32_oen
  assign SSP_SHARED_32_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_32_oen;

  // SSP_SHARED_33_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_33
  assign SSP_SHARED_33_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_33;

  // SSP_SHARED_33_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_33
  assign io_muxes_u__p2c_SSP_SHARED_33       = SSP_SHARED_33_pad_0__O;

  // SSP_SHARED_33_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_33_oen
  assign SSP_SHARED_33_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_33_oen;

  // SSP_SHARED_34_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_34
  assign SSP_SHARED_34_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_34;

  // SSP_SHARED_34_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_34
  assign io_muxes_u__p2c_SSP_SHARED_34       = SSP_SHARED_34_pad_0__O;

  // SSP_SHARED_34_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_34_oen
  assign SSP_SHARED_34_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_34_oen;

  // SSP_SHARED_35_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_35
  assign SSP_SHARED_35_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_35;

  // SSP_SHARED_35_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_35
  assign io_muxes_u__p2c_SSP_SHARED_35       = SSP_SHARED_35_pad_0__O;

  // SSP_SHARED_35_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_35_oen
  assign SSP_SHARED_35_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_35_oen;

  // SSP_SHARED_36_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_36
  assign SSP_SHARED_36_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_36;

  // SSP_SHARED_36_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_36
  assign io_muxes_u__p2c_SSP_SHARED_36       = SSP_SHARED_36_pad_0__O;

  // SSP_SHARED_36_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_36_oen
  assign SSP_SHARED_36_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_36_oen;

  // SSP_SHARED_37_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_37
  assign SSP_SHARED_37_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_37;

  // SSP_SHARED_37_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_37
  assign io_muxes_u__p2c_SSP_SHARED_37       = SSP_SHARED_37_pad_0__O;

  // SSP_SHARED_37_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_37_oen
  assign SSP_SHARED_37_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_37_oen;

  // SSP_SHARED_38_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_38
  assign SSP_SHARED_38_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_38;

  // SSP_SHARED_38_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_38
  assign io_muxes_u__p2c_SSP_SHARED_38       = SSP_SHARED_38_pad_0__O;

  // SSP_SHARED_38_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_38_oen
  assign SSP_SHARED_38_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_38_oen;

  // SSP_SHARED_39_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_39
  assign SSP_SHARED_39_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_39;

  // SSP_SHARED_39_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_39
  assign io_muxes_u__p2c_SSP_SHARED_39       = SSP_SHARED_39_pad_0__O;

  // SSP_SHARED_39_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_39_oen
  assign SSP_SHARED_39_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_39_oen;

  // SSP_SHARED_3_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_3
  assign SSP_SHARED_3_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_3;

  // SSP_SHARED_3_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_3
  assign io_muxes_u__p2c_SSP_SHARED_3        = SSP_SHARED_3_pad_0__O;

  // SSP_SHARED_3_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_3_oen
  assign SSP_SHARED_3_pad_0__T               = io_muxes_u__c2p_SSP_SHARED_3_oen;

  // SSP_SHARED_40_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_40
  assign SSP_SHARED_40_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_40;

  // SSP_SHARED_40_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_40
  assign io_muxes_u__p2c_SSP_SHARED_40       = SSP_SHARED_40_pad_0__O;

  // SSP_SHARED_40_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_40_oen
  assign SSP_SHARED_40_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_40_oen;

  // SSP_SHARED_41_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_41
  assign SSP_SHARED_41_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_41;

  // SSP_SHARED_41_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_41
  assign io_muxes_u__p2c_SSP_SHARED_41       = SSP_SHARED_41_pad_0__O;

  // SSP_SHARED_41_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_41_oen
  assign SSP_SHARED_41_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_41_oen;

  // SSP_SHARED_42_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_42
  assign SSP_SHARED_42_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_42;

  // SSP_SHARED_42_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_42
  assign io_muxes_u__p2c_SSP_SHARED_42       = SSP_SHARED_42_pad_0__O;

  // SSP_SHARED_42_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_42_oen
  assign SSP_SHARED_42_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_42_oen;

  // SSP_SHARED_43_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_43
  assign SSP_SHARED_43_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_43;

  // SSP_SHARED_43_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_43
  assign io_muxes_u__p2c_SSP_SHARED_43       = SSP_SHARED_43_pad_0__O;

  // SSP_SHARED_43_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_43_oen
  assign SSP_SHARED_43_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_43_oen;

  // SSP_SHARED_44_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_44
  assign SSP_SHARED_44_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_44;

  // SSP_SHARED_44_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_44
  assign io_muxes_u__p2c_SSP_SHARED_44       = SSP_SHARED_44_pad_0__O;

  // SSP_SHARED_44_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_44_oen
  assign SSP_SHARED_44_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_44_oen;

  // SSP_SHARED_45_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_45
  assign SSP_SHARED_45_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_45;

  // SSP_SHARED_45_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_45
  assign io_muxes_u__p2c_SSP_SHARED_45       = SSP_SHARED_45_pad_0__O;

  // SSP_SHARED_45_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_45_oen
  assign SSP_SHARED_45_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_45_oen;

  // SSP_SHARED_46_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_46
  assign SSP_SHARED_46_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_46;

  // SSP_SHARED_46_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_46
  assign io_muxes_u__p2c_SSP_SHARED_46       = SSP_SHARED_46_pad_0__O;

  // SSP_SHARED_46_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_46_oen
  assign SSP_SHARED_46_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_46_oen;

  // SSP_SHARED_47_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_47
  assign SSP_SHARED_47_pad_0__I              = io_muxes_u__c2p_SSP_SHARED_47;

  // SSP_SHARED_47_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_47
  assign io_muxes_u__p2c_SSP_SHARED_47       = SSP_SHARED_47_pad_0__O;

  // SSP_SHARED_47_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_47_oen
  assign SSP_SHARED_47_pad_0__T              = io_muxes_u__c2p_SSP_SHARED_47_oen;

  // SSP_SHARED_4_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_4
  assign SSP_SHARED_4_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_4;

  // SSP_SHARED_4_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_4
  assign io_muxes_u__p2c_SSP_SHARED_4        = SSP_SHARED_4_pad_0__O;

  // SSP_SHARED_4_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_4_oen
  assign SSP_SHARED_4_pad_0__T               = io_muxes_u__c2p_SSP_SHARED_4_oen;

  // SSP_SHARED_5_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_5
  assign SSP_SHARED_5_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_5;

  // SSP_SHARED_5_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_5
  assign io_muxes_u__p2c_SSP_SHARED_5        = SSP_SHARED_5_pad_0__O;

  // SSP_SHARED_5_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_5_oen
  assign SSP_SHARED_5_pad_0__T               = io_muxes_u__c2p_SSP_SHARED_5_oen;

  // SSP_SHARED_6_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_6
  assign SSP_SHARED_6_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_6;

  // SSP_SHARED_6_pad_0/T <-> 'b0
  assign SSP_SHARED_6_pad_0__T               = {{($bits(SSP_SHARED_6_pad_0__T)-1){1'b0}}, 1'b0};

  // SSP_SHARED_7_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_7
  assign SSP_SHARED_7_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_7;

  // SSP_SHARED_7_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_7
  assign io_muxes_u__p2c_SSP_SHARED_7        = SSP_SHARED_7_pad_0__O;

  // SSP_SHARED_7_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_7_oen
  assign SSP_SHARED_7_pad_0__T               = io_muxes_u__c2p_SSP_SHARED_7_oen;

  // SSP_SHARED_8_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_8
  assign SSP_SHARED_8_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_8;

  // SSP_SHARED_8_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_8
  assign io_muxes_u__p2c_SSP_SHARED_8        = SSP_SHARED_8_pad_0__O;

  // SSP_SHARED_8_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_8_oen
  assign SSP_SHARED_8_pad_0__T               = io_muxes_u__c2p_SSP_SHARED_8_oen;

  // SSP_SHARED_9_pad_0/I <-> io_muxes_u/c2p_SSP_SHARED_9
  assign SSP_SHARED_9_pad_0__I               = io_muxes_u__c2p_SSP_SHARED_9;

  // SSP_SHARED_9_pad_0/O <-> io_muxes_u/p2c_SSP_SHARED_9
  assign io_muxes_u__p2c_SSP_SHARED_9        = SSP_SHARED_9_pad_0__O;

  // SSP_SHARED_9_pad_0/T <-> io_muxes_u/c2p_SSP_SHARED_9_oen
  assign SSP_SHARED_9_pad_0__T               = io_muxes_u__c2p_SSP_SHARED_9_oen;

  // i2c0_ic_clk_pad_0/I <-> 'b0
  assign i2c0_ic_clk_pad_0__I                = {{($bits(i2c0_ic_clk_pad_0__I)-1){1'b0}}, 1'b0};

  // i2c0_ic_clk_pad_0/O <-> soc_top_u/p2c_i2c0_ic_clk_in_a
  assign soc_top_u__p2c_i2c0_ic_clk_in_a     = i2c0_ic_clk_pad_0__O;

  // i2c0_ic_clk_pad_0/T <-> soc_top_u/c2p_i2c0_ic_clk_oen
  assign i2c0_ic_clk_pad_0__T                = soc_top_u__c2p_i2c0_ic_clk_oen;

  // i2c0_ic_data_pad_0/I <-> 'b0
  assign i2c0_ic_data_pad_0__I               = {{($bits(i2c0_ic_data_pad_0__I)-1){1'b0}}, 1'b0};

  // i2c0_ic_data_pad_0/O <-> soc_top_u/p2c_i2c0_ic_data_in_a
  assign soc_top_u__p2c_i2c0_ic_data_in_a    = i2c0_ic_data_pad_0__O;

  // i2c0_ic_data_pad_0/T <-> soc_top_u/c2p_i2c0_ic_data_oen
  assign i2c0_ic_data_pad_0__T               = soc_top_u__c2p_i2c0_ic_data_oen;

  // io_muxes_u/c2p_gpio_porta <-> soc_top_u/c2p_gpio_porta_dr
  assign io_muxes_u__c2p_gpio_porta          = soc_top_u__c2p_gpio_porta_dr;

  // io_muxes_u/c2p_gpio_porta_oen <-> soc_top_u/c2p_gpio_porta_ddr
  assign io_muxes_u__c2p_gpio_porta_oen      = soc_top_u__c2p_gpio_porta_ddr;

  // io_muxes_u/c2p_i2c1_ic_clk <-> 'b0
  assign io_muxes_u__c2p_i2c1_ic_clk         = {{($bits(io_muxes_u__c2p_i2c1_ic_clk)-1){1'b0}}, 1'b0};

  // io_muxes_u/c2p_i2c1_ic_clk_oen <-> soc_top_u/c2p_i2c1_ic_clk_oen
  assign io_muxes_u__c2p_i2c1_ic_clk_oen     = soc_top_u__c2p_i2c1_ic_clk_oen;

  // io_muxes_u/c2p_i2c1_ic_data <-> 'b0
  assign io_muxes_u__c2p_i2c1_ic_data        = {{($bits(io_muxes_u__c2p_i2c1_ic_data)-1){1'b0}}, 1'b0};

  // io_muxes_u/c2p_i2c1_ic_data_oen <-> soc_top_u/c2p_i2c1_ic_data_oen
  assign io_muxes_u__c2p_i2c1_ic_data_oen    = soc_top_u__c2p_i2c1_ic_data_oen;

  // io_muxes_u/c2p_i2c2_ic_clk <-> 'b0
  assign io_muxes_u__c2p_i2c2_ic_clk         = {{($bits(io_muxes_u__c2p_i2c2_ic_clk)-1){1'b0}}, 1'b0};

  // io_muxes_u/c2p_i2c2_ic_clk_oen <-> soc_top_u/c2p_i2c2_ic_clk_oen
  assign io_muxes_u__c2p_i2c2_ic_clk_oen     = soc_top_u__c2p_i2c2_ic_clk_oen;

  // io_muxes_u/c2p_i2c2_ic_data <-> 'b0
  assign io_muxes_u__c2p_i2c2_ic_data        = {{($bits(io_muxes_u__c2p_i2c2_ic_data)-1){1'b0}}, 1'b0};

  // io_muxes_u/c2p_i2c2_ic_data_oen <-> soc_top_u/c2p_i2c2_ic_data_oen
  assign io_muxes_u__c2p_i2c2_ic_data_oen    = soc_top_u__c2p_i2c2_ic_data_oen;

  // io_muxes_u/c2p_i2srxm0_sclk <-> soc_top_u/c2p_i2ss0_sclk
  assign io_muxes_u__c2p_i2srxm0_sclk        = soc_top_u__c2p_i2ss0_sclk;

  // io_muxes_u/c2p_i2srxm0_ws <-> soc_top_u/c2p_i2ss0_ws_out
  assign io_muxes_u__c2p_i2srxm0_ws          = soc_top_u__c2p_i2ss0_ws_out;

  // io_muxes_u/c2p_i2srxm1_sclk <-> soc_top_u/c2p_i2ss1_sclk
  assign io_muxes_u__c2p_i2srxm1_sclk        = soc_top_u__c2p_i2ss1_sclk;

  // io_muxes_u/c2p_i2srxm1_ws <-> soc_top_u/c2p_i2ss1_ws_out
  assign io_muxes_u__c2p_i2srxm1_ws          = soc_top_u__c2p_i2ss1_ws_out;

  // io_muxes_u/c2p_i2srxm2_sclk <-> soc_top_u/c2p_i2ss2_sclk
  assign io_muxes_u__c2p_i2srxm2_sclk        = soc_top_u__c2p_i2ss2_sclk;

  // io_muxes_u/c2p_i2srxm2_ws <-> soc_top_u/c2p_i2ss2_ws_out
  assign io_muxes_u__c2p_i2srxm2_ws          = soc_top_u__c2p_i2ss2_ws_out;

  // io_muxes_u/c2p_i2srxm3_sclk <-> soc_top_u/c2p_i2ss3_sclk
  assign io_muxes_u__c2p_i2srxm3_sclk        = soc_top_u__c2p_i2ss3_sclk;

  // io_muxes_u/c2p_i2srxm3_ws <-> soc_top_u/c2p_i2ss3_ws_out
  assign io_muxes_u__c2p_i2srxm3_ws          = soc_top_u__c2p_i2ss3_ws_out;

  // io_muxes_u/c2p_i2srxm4_sclk <-> soc_top_u/c2p_i2ss4_sclk
  assign io_muxes_u__c2p_i2srxm4_sclk        = soc_top_u__c2p_i2ss4_sclk;

  // io_muxes_u/c2p_i2srxm4_ws <-> soc_top_u/c2p_i2ss4_ws_out
  assign io_muxes_u__c2p_i2srxm4_ws          = soc_top_u__c2p_i2ss4_ws_out;

  // io_muxes_u/c2p_i2srxm5_sclk <-> soc_top_u/c2p_i2ss5_sclk
  assign io_muxes_u__c2p_i2srxm5_sclk        = soc_top_u__c2p_i2ss5_sclk;

  // io_muxes_u/c2p_i2srxm5_ws <-> soc_top_u/c2p_i2ss5_ws_out
  assign io_muxes_u__c2p_i2srxm5_ws          = soc_top_u__c2p_i2ss5_ws_out;

  // io_muxes_u/c2p_i2stxm_data[0] <-> soc_top_u/c2p_i2sm_sdo0
  assign io_muxes_u__c2p_i2stxm_data[0]      = soc_top_u__c2p_i2sm_sdo0;

  // io_muxes_u/c2p_i2stxm_data[1] <-> soc_top_u/c2p_i2sm_sdo1
  assign io_muxes_u__c2p_i2stxm_data[1]      = soc_top_u__c2p_i2sm_sdo1;

  // io_muxes_u/c2p_i2stxm_data[2] <-> soc_top_u/c2p_i2sm_sdo2
  assign io_muxes_u__c2p_i2stxm_data[2]      = soc_top_u__c2p_i2sm_sdo2;

  // io_muxes_u/c2p_i2stxm_data[3] <-> soc_top_u/c2p_i2sm_sdo3
  assign io_muxes_u__c2p_i2stxm_data[3]      = soc_top_u__c2p_i2sm_sdo3;

  // io_muxes_u/c2p_i2stxm_sclk <-> soc_top_u/c2p_i2sm_sclk
  assign io_muxes_u__c2p_i2stxm_sclk         = soc_top_u__c2p_i2sm_sclk;

  // io_muxes_u/c2p_i2stxm_ws <-> soc_top_u/c2p_i2sm_ws_out
  assign io_muxes_u__c2p_i2stxm_ws           = soc_top_u__c2p_i2sm_ws_out;

  // io_muxes_u/c2p_scan_out <-> 'b0
  assign io_muxes_u__c2p_scan_out            = {{($bits(io_muxes_u__c2p_scan_out)-1){1'b0}}, 1'b0};

  // io_muxes_u/c2p_spis_txd <-> soc_top_u/c2p_spis_o
  assign io_muxes_u__c2p_spis_txd            = soc_top_u__c2p_spis_o;

  // io_muxes_u/c2p_sspim1_sclk_out <-> soc_top_u/c2p_sspim1_clk
  assign io_muxes_u__c2p_sspim1_sclk_out     = soc_top_u__c2p_sspim1_clk;

  // io_muxes_u/c2p_sspim1_ss <-> soc_top_u/c2p_sspim1_cs_n
  assign io_muxes_u__c2p_sspim1_ss           = soc_top_u__c2p_sspim1_cs_n;

  // io_muxes_u/c2p_sspim1_txd <-> soc_top_u/c2p_sspim1_o
  assign io_muxes_u__c2p_sspim1_txd          = soc_top_u__c2p_sspim1_o;

  // io_muxes_u/c2p_sspim2_sclk_out <-> soc_top_u/c2p_sspim2_clk
  assign io_muxes_u__c2p_sspim2_sclk_out     = soc_top_u__c2p_sspim2_clk;

  // io_muxes_u/c2p_sspim2_ss <-> soc_top_u/c2p_sspim2_cs_n
  assign io_muxes_u__c2p_sspim2_ss           = soc_top_u__c2p_sspim2_cs_n;

  // io_muxes_u/c2p_sspim2_txd <-> soc_top_u/c2p_sspim2_o
  assign io_muxes_u__c2p_sspim2_txd          = soc_top_u__c2p_sspim2_o;

  // io_muxes_u/c2p_tim_pwn[0] <-> soc_top_u/c2p_timer_1_toggle
  assign io_muxes_u__c2p_tim_pwn[0]          = soc_top_u__c2p_timer_1_toggle;

  // io_muxes_u/c2p_tim_pwn[1] <-> soc_top_u/c2p_timer_2_toggle
  assign io_muxes_u__c2p_tim_pwn[1]          = soc_top_u__c2p_timer_2_toggle;

  // io_muxes_u/c2p_tim_pwn[2] <-> soc_top_u/c2p_timer_3_toggle
  assign io_muxes_u__c2p_tim_pwn[2]          = soc_top_u__c2p_timer_3_toggle;

  // io_muxes_u/c2p_tim_pwn[3] <-> soc_top_u/c2p_timer_4_toggle
  assign io_muxes_u__c2p_tim_pwn[3]          = soc_top_u__c2p_timer_4_toggle;

  // io_muxes_u/c2p_tim_pwn[4] <-> soc_top_u/c2p_timer_5_toggle
  assign io_muxes_u__c2p_tim_pwn[4]          = soc_top_u__c2p_timer_5_toggle;

  // io_muxes_u/c2p_tim_pwn[5] <-> soc_top_u/c2p_timer_6_toggle
  assign io_muxes_u__c2p_tim_pwn[5]          = soc_top_u__c2p_timer_6_toggle;

  // io_muxes_u/c2p_tim_pwn[6] <-> soc_top_u/c2p_timer_7_toggle
  assign io_muxes_u__c2p_tim_pwn[6]          = soc_top_u__c2p_timer_7_toggle;

  // io_muxes_u/c2p_tim_pwn[7] <-> soc_top_u/c2p_timer_8_toggle
  assign io_muxes_u__c2p_tim_pwn[7]          = soc_top_u__c2p_timer_8_toggle;

  // io_muxes_u/c2p_uart0_rts_n <-> soc_top_u/c2p_uart0_rts_n
  assign io_muxes_u__c2p_uart0_rts_n         = soc_top_u__c2p_uart0_rts_n;

  // io_muxes_u/c2p_uart0_sout <-> soc_top_u/c2p_uart0_sout
  assign io_muxes_u__c2p_uart0_sout          = soc_top_u__c2p_uart0_sout;

  // io_muxes_u/c2p_uart3_sout <-> soc_top_u/c2p_uart3_sout
  assign io_muxes_u__c2p_uart3_sout          = soc_top_u__c2p_uart3_sout;

  // io_muxes_u/p2c_gpio_porta <-> soc_top_u/p2c_gpio_ext_porta
  assign soc_top_u__p2c_gpio_ext_porta       = io_muxes_u__p2c_gpio_porta;

  // io_muxes_u/p2c_i2c1_ic_clk <-> soc_top_u/p2c_i2c1_ic_clk_in_a
  assign soc_top_u__p2c_i2c1_ic_clk_in_a     = io_muxes_u__p2c_i2c1_ic_clk;

  // io_muxes_u/p2c_i2c1_ic_data <-> soc_top_u/p2c_i2c1_ic_data_in_a
  assign soc_top_u__p2c_i2c1_ic_data_in_a    = io_muxes_u__p2c_i2c1_ic_data;

  // io_muxes_u/p2c_i2c2_ic_clk <-> soc_top_u/p2c_i2c2_ic_clk_in_a
  assign soc_top_u__p2c_i2c2_ic_clk_in_a     = io_muxes_u__p2c_i2c2_ic_clk;

  // io_muxes_u/p2c_i2c2_ic_data <-> soc_top_u/p2c_i2c2_ic_data_in_a
  assign soc_top_u__p2c_i2c2_ic_data_in_a    = io_muxes_u__p2c_i2c2_ic_data;

  // io_muxes_u/p2c_i2srxm0_data[0] <-> soc_top_u/p2c_i2ss0_sdi0
  assign soc_top_u__p2c_i2ss0_sdi0           = io_muxes_u__p2c_i2srxm0_data[0];

  // io_muxes_u/p2c_i2srxm0_data[1] <-> soc_top_u/p2c_i2ss0_sdi1
  assign soc_top_u__p2c_i2ss0_sdi1           = io_muxes_u__p2c_i2srxm0_data[1];

  // io_muxes_u/p2c_i2srxm0_data[2] <-> soc_top_u/p2c_i2ss0_sdi2
  assign soc_top_u__p2c_i2ss0_sdi2           = io_muxes_u__p2c_i2srxm0_data[2];

  // io_muxes_u/p2c_i2srxm0_data[3] <-> soc_top_u/p2c_i2ss0_sdi3
  assign soc_top_u__p2c_i2ss0_sdi3           = io_muxes_u__p2c_i2srxm0_data[3];

  // io_muxes_u/p2c_i2srxm1_data[0] <-> soc_top_u/p2c_i2ss1_sdi0
  assign soc_top_u__p2c_i2ss1_sdi0           = io_muxes_u__p2c_i2srxm1_data[0];

  // io_muxes_u/p2c_i2srxm1_data[1] <-> soc_top_u/p2c_i2ss1_sdi1
  assign soc_top_u__p2c_i2ss1_sdi1           = io_muxes_u__p2c_i2srxm1_data[1];

  // io_muxes_u/p2c_i2srxm1_data[2] <-> soc_top_u/p2c_i2ss1_sdi2
  assign soc_top_u__p2c_i2ss1_sdi2           = io_muxes_u__p2c_i2srxm1_data[2];

  // io_muxes_u/p2c_i2srxm1_data[3] <-> soc_top_u/p2c_i2ss1_sdi3
  assign soc_top_u__p2c_i2ss1_sdi3           = io_muxes_u__p2c_i2srxm1_data[3];

  // io_muxes_u/p2c_i2srxm2_data[0] <-> soc_top_u/p2c_i2ss2_sdi0
  assign soc_top_u__p2c_i2ss2_sdi0           = io_muxes_u__p2c_i2srxm2_data[0];

  // io_muxes_u/p2c_i2srxm2_data[1] <-> soc_top_u/p2c_i2ss2_sdi1
  assign soc_top_u__p2c_i2ss2_sdi1           = io_muxes_u__p2c_i2srxm2_data[1];

  // io_muxes_u/p2c_i2srxm2_data[2] <-> soc_top_u/p2c_i2ss2_sdi2
  assign soc_top_u__p2c_i2ss2_sdi2           = io_muxes_u__p2c_i2srxm2_data[2];

  // io_muxes_u/p2c_i2srxm2_data[3] <-> soc_top_u/p2c_i2ss2_sdi3
  assign soc_top_u__p2c_i2ss2_sdi3           = io_muxes_u__p2c_i2srxm2_data[3];

  // io_muxes_u/p2c_i2srxm3_data[0] <-> soc_top_u/p2c_i2ss3_sdi0
  assign soc_top_u__p2c_i2ss3_sdi0           = io_muxes_u__p2c_i2srxm3_data[0];

  // io_muxes_u/p2c_i2srxm3_data[1] <-> soc_top_u/p2c_i2ss3_sdi1
  assign soc_top_u__p2c_i2ss3_sdi1           = io_muxes_u__p2c_i2srxm3_data[1];

  // io_muxes_u/p2c_i2srxm3_data[2] <-> soc_top_u/p2c_i2ss3_sdi2
  assign soc_top_u__p2c_i2ss3_sdi2           = io_muxes_u__p2c_i2srxm3_data[2];

  // io_muxes_u/p2c_i2srxm3_data[3] <-> soc_top_u/p2c_i2ss3_sdi3
  assign soc_top_u__p2c_i2ss3_sdi3           = io_muxes_u__p2c_i2srxm3_data[3];

  // io_muxes_u/p2c_i2srxm4_data[0] <-> soc_top_u/p2c_i2ss4_sdi0
  assign soc_top_u__p2c_i2ss4_sdi0           = io_muxes_u__p2c_i2srxm4_data[0];

  // io_muxes_u/p2c_i2srxm4_data[1] <-> soc_top_u/p2c_i2ss4_sdi1
  assign soc_top_u__p2c_i2ss4_sdi1           = io_muxes_u__p2c_i2srxm4_data[1];

  // io_muxes_u/p2c_i2srxm4_data[2] <-> soc_top_u/p2c_i2ss4_sdi2
  assign soc_top_u__p2c_i2ss4_sdi2           = io_muxes_u__p2c_i2srxm4_data[2];

  // io_muxes_u/p2c_i2srxm4_data[3] <-> soc_top_u/p2c_i2ss4_sdi3
  assign soc_top_u__p2c_i2ss4_sdi3           = io_muxes_u__p2c_i2srxm4_data[3];

  // io_muxes_u/p2c_i2srxm5_data[0] <-> soc_top_u/p2c_i2ss5_sdi0
  assign soc_top_u__p2c_i2ss5_sdi0           = io_muxes_u__p2c_i2srxm5_data[0];

  // io_muxes_u/p2c_i2srxm5_data[1] <-> soc_top_u/p2c_i2ss5_sdi1
  assign soc_top_u__p2c_i2ss5_sdi1           = io_muxes_u__p2c_i2srxm5_data[1];

  // io_muxes_u/p2c_i2srxm5_data[2] <-> soc_top_u/p2c_i2ss5_sdi2
  assign soc_top_u__p2c_i2ss5_sdi2           = io_muxes_u__p2c_i2srxm5_data[2];

  // io_muxes_u/p2c_i2srxm5_data[3] <-> soc_top_u/p2c_i2ss5_sdi3
  assign soc_top_u__p2c_i2ss5_sdi3           = io_muxes_u__p2c_i2srxm5_data[3];

  // io_muxes_u/p2c_spis_rxd <-> soc_top_u/p2c_spis_i
  assign soc_top_u__p2c_spis_i               = io_muxes_u__p2c_spis_rxd;

  // io_muxes_u/p2c_spis_sclk_in <-> soc_top_u/p2c_spis_clk
  assign soc_top_u__p2c_spis_clk             = io_muxes_u__p2c_spis_sclk_in;

  // io_muxes_u/p2c_spis_ss <-> soc_top_u/p2c_spis_cs_n
  assign soc_top_u__p2c_spis_cs_n            = io_muxes_u__p2c_spis_ss;

  // io_muxes_u/p2c_sspim1_rxd <-> soc_top_u/p2c_sspim1_i
  assign soc_top_u__p2c_sspim1_i             = io_muxes_u__p2c_sspim1_rxd;

  // io_muxes_u/p2c_sspim2_rxd <-> soc_top_u/p2c_sspim2_i
  assign soc_top_u__p2c_sspim2_i             = io_muxes_u__p2c_sspim2_rxd;

  // io_muxes_u/p2c_uart0_cts_n <-> soc_top_u/p2c_uart0_cts_n
  assign soc_top_u__p2c_uart0_cts_n          = io_muxes_u__p2c_uart0_cts_n;

  // io_muxes_u/p2c_uart0_sin <-> soc_top_u/p2c_uart0_sin
  assign soc_top_u__p2c_uart0_sin            = io_muxes_u__p2c_uart0_sin;

  // io_muxes_u/p2c_uart3_sin <-> soc_top_u/p2c_uart3_sin
  assign soc_top_u__p2c_uart3_sin            = io_muxes_u__p2c_uart3_sin;

  // io_muxes_u/test_mode <-> 'b0
  assign io_muxes_u__test_mode               = {{($bits(io_muxes_u__test_mode)-1){1'b0}}, 1'b0};

  // jtag_wrapper_u.or_req <-> soc_top_u.or_req_if
  assign jtag_wrapper_u__or_req_arready      = soc_top_u__or_req_if_arready;
  assign jtag_wrapper_u__or_req_awready      = soc_top_u__or_req_if_awready;
  assign jtag_wrapper_u__or_req_wready       = soc_top_u__or_req_if_wready;
  assign soc_top_u__or_req_if_ar             = jtag_wrapper_u__or_req_ar;
  assign soc_top_u__or_req_if_arvalid        = jtag_wrapper_u__or_req_arvalid;
  assign soc_top_u__or_req_if_aw             = jtag_wrapper_u__or_req_aw;
  assign soc_top_u__or_req_if_awvalid        = jtag_wrapper_u__or_req_awvalid;
  assign soc_top_u__or_req_if_w              = jtag_wrapper_u__or_req_w;
  assign soc_top_u__or_req_if_wvalid         = jtag_wrapper_u__or_req_wvalid;

  // jtag_wrapper_u.or_rsp <-> soc_top_u.or_resp_if
  assign jtag_wrapper_u__or_rsp_b            = soc_top_u__or_resp_if_b;
  assign jtag_wrapper_u__or_rsp_bvalid       = soc_top_u__or_resp_if_bvalid;
  assign jtag_wrapper_u__or_rsp_r            = soc_top_u__or_resp_if_r;
  assign jtag_wrapper_u__or_rsp_rvalid       = soc_top_u__or_resp_if_rvalid;
  assign soc_top_u__or_resp_if_bready        = jtag_wrapper_u__or_rsp_bready;
  assign soc_top_u__or_resp_if_rready        = jtag_wrapper_u__or_rsp_rready;

  // jtag_wrapper_u/rstblk_out <-> soc_top_u/p2c_resetn
  assign soc_top_u__p2c_resetn               = jtag_wrapper_u__rstblk_out;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_act_n <-> xilinx_ddr_u/c0_ddr4_act_n
  assign c0_ddr4_act_n                       = xilinx_ddr_u__c0_ddr4_act_n;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_adr <-> xilinx_ddr_u/c0_ddr4_adr
  assign c0_ddr4_adr                         = xilinx_ddr_u__c0_ddr4_adr;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_ba <-> xilinx_ddr_u/c0_ddr4_ba
  assign c0_ddr4_ba                          = xilinx_ddr_u__c0_ddr4_ba;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_bg <-> xilinx_ddr_u/c0_ddr4_bg
  assign c0_ddr4_bg                          = xilinx_ddr_u__c0_ddr4_bg;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_ck_c <-> xilinx_ddr_u/c0_ddr4_ck_c
  assign c0_ddr4_ck_c                        = xilinx_ddr_u__c0_ddr4_ck_c;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_ck_t <-> xilinx_ddr_u/c0_ddr4_ck_t
  assign c0_ddr4_ck_t                        = xilinx_ddr_u__c0_ddr4_ck_t;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_cke <-> xilinx_ddr_u/c0_ddr4_cke
  assign c0_ddr4_cke                         = xilinx_ddr_u__c0_ddr4_cke;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_cs_n <-> xilinx_ddr_u/c0_ddr4_cs_n
  assign c0_ddr4_cs_n                        = xilinx_ddr_u__c0_ddr4_cs_n;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_odt <-> xilinx_ddr_u/c0_ddr4_odt
  assign c0_ddr4_odt                         = xilinx_ddr_u__c0_ddr4_odt;

  // pygmy_es1y_fpga_vcu118/c0_ddr4_reset_n <-> xilinx_ddr_u/c0_ddr4_reset_n
  assign c0_ddr4_reset_n                     = xilinx_ddr_u__c0_ddr4_reset_n;

  // pygmy_es1y_fpga_vcu118/c0_init_calib_complete <-> xilinx_ddr_u/c0_init_calib_complete
  assign c0_init_calib_complete              = xilinx_ddr_u__c0_init_calib_complete;

  // pygmy_es1y_fpga_vcu118/c0_sys_clk_n <-> xilinx_ddr_u/c0_sys_clk_n
  assign xilinx_ddr_u__c0_sys_clk_n          = c0_sys_clk_n;

  // pygmy_es1y_fpga_vcu118/c0_sys_clk_p <-> xilinx_ddr_u/c0_sys_clk_p
  assign xilinx_ddr_u__c0_sys_clk_p          = c0_sys_clk_p;

  // pygmy_es1y_fpga_vcu118/sys_rst_ddr <-> xilinx_ddr_u/sys_rst
  assign xilinx_ddr_u__sys_rst               = sys_rst_ddr;

  // qspim_sclk_out_pad_0/I <-> soc_top_u/c2p_qspim_clk
  assign qspim_sclk_out_pad_0__I             = soc_top_u__c2p_qspim_clk;

  // qspim_sclk_out_pad_0/T <-> 'b0
  assign qspim_sclk_out_pad_0__T             = {{($bits(qspim_sclk_out_pad_0__T)-1){1'b0}}, 1'b0};

  // qspim_ss_pad_0/I <-> soc_top_u/c2p_qspim_cs_n
  assign qspim_ss_pad_0__I                   = soc_top_u__c2p_qspim_cs_n;

  // qspim_ss_pad_0/T <-> 'b0
  assign qspim_ss_pad_0__T                   = {{($bits(qspim_ss_pad_0__T)-1){1'b0}}, 1'b0};

  // qspim_trxd_pad_0/I <-> soc_top_u/c2p_qspim_o[0]
  assign qspim_trxd_pad_0__I                 = soc_top_u__c2p_qspim_o[0];

  // qspim_trxd_pad_0/O <-> soc_top_u/p2c_qspim_i[0]
  assign soc_top_u__p2c_qspim_i[0]           = qspim_trxd_pad_0__O;

  // qspim_trxd_pad_0/T <-> soc_top_u/c2p_qspim_io_oen[0]
  assign qspim_trxd_pad_0__T                 = soc_top_u__c2p_qspim_io_oen[0];

  // qspim_trxd_pad_1/I <-> soc_top_u/c2p_qspim_o[1]
  assign qspim_trxd_pad_1__I                 = soc_top_u__c2p_qspim_o[1];

  // qspim_trxd_pad_1/O <-> soc_top_u/p2c_qspim_i[1]
  assign soc_top_u__p2c_qspim_i[1]           = qspim_trxd_pad_1__O;

  // qspim_trxd_pad_1/T <-> soc_top_u/c2p_qspim_io_oen[1]
  assign qspim_trxd_pad_1__T                 = soc_top_u__c2p_qspim_io_oen[1];

  // qspim_trxd_pad_2/I <-> soc_top_u/c2p_qspim_o[2]
  assign qspim_trxd_pad_2__I                 = soc_top_u__c2p_qspim_o[2];

  // qspim_trxd_pad_2/O <-> soc_top_u/p2c_qspim_i[2]
  assign soc_top_u__p2c_qspim_i[2]           = qspim_trxd_pad_2__O;

  // qspim_trxd_pad_2/T <-> soc_top_u/c2p_qspim_io_oen[2]
  assign qspim_trxd_pad_2__T                 = soc_top_u__c2p_qspim_io_oen[2];

  // qspim_trxd_pad_3/I <-> soc_top_u/c2p_qspim_o[3]
  assign qspim_trxd_pad_3__I                 = soc_top_u__c2p_qspim_o[3];

  // qspim_trxd_pad_3/O <-> soc_top_u/p2c_qspim_i[3]
  assign soc_top_u__p2c_qspim_i[3]           = qspim_trxd_pad_3__O;

  // qspim_trxd_pad_3/T <-> soc_top_u/c2p_qspim_io_oen[3]
  assign qspim_trxd_pad_3__T                 = soc_top_u__c2p_qspim_io_oen[3];

  // sd_card_detect_n_pad_0/I <-> 'b0
  assign sd_card_detect_n_pad_0__I           = {{($bits(sd_card_detect_n_pad_0__I)-1){1'b0}}, 1'b0};

  // sd_card_detect_n_pad_0/O <-> soc_top_u/card_detect_n
  assign soc_top_u__card_detect_n            = sd_card_detect_n_pad_0__O;

  // sd_card_detect_n_pad_0/T <-> 'b1
  assign sd_card_detect_n_pad_0__T           = {{($bits(sd_card_detect_n_pad_0__T)-1){1'b0}}, 1'b1};

  // sd_card_write_prot_pad_0/I <-> 'b0
  assign sd_card_write_prot_pad_0__I         = {{($bits(sd_card_write_prot_pad_0__I)-1){1'b0}}, 1'b0};

  // sd_card_write_prot_pad_0/O <-> soc_top_u/card_write_prot
  assign soc_top_u__card_write_prot          = sd_card_write_prot_pad_0__O;

  // sd_card_write_prot_pad_0/T <-> 'b1
  assign sd_card_write_prot_pad_0__T         = {{($bits(sd_card_write_prot_pad_0__T)-1){1'b0}}, 1'b1};

  // sd_clk_pad_0/I <-> soc_top_u/gated_tx_clk_out
  assign sd_clk_pad_0__I                     = soc_top_u__gated_tx_clk_out;

  // sd_clk_pad_0/O <-> soc_top_u/cclk_rx
  assign soc_top_u__cclk_rx                  = sd_clk_pad_0__O;

  // sd_clk_pad_0/T <-> 'b0
  assign sd_clk_pad_0__T                     = {{($bits(sd_clk_pad_0__T)-1){1'b0}}, 1'b0};

  // sd_cmd_in_out_pad_0/I <-> soc_top_u/sd_cmd_out
  assign sd_cmd_in_out_pad_0__I              = soc_top_u__sd_cmd_out;

  // sd_cmd_in_out_pad_0/O <-> soc_top_u/sd_cmd_in
  assign soc_top_u__sd_cmd_in                = sd_cmd_in_out_pad_0__O;

  // sd_cmd_in_out_pad_0/T <-> sd_cmd_oen_inv_u/out
  assign sd_cmd_in_out_pad_0__T              = sd_cmd_oen_inv_u__out;

  // sd_dat_in_out_pad_0/I <-> soc_top_u/sd_dat_out[0]
  assign sd_dat_in_out_pad_0__I              = soc_top_u__sd_dat_out[0];

  // sd_dat_in_out_pad_0/O <-> soc_top_u/sd_dat_in[0]
  assign soc_top_u__sd_dat_in[0]             = sd_dat_in_out_pad_0__O;

  // sd_dat_in_out_pad_0/T <-> sd_dat_oen_inv_u/out[0]
  assign sd_dat_in_out_pad_0__T              = sd_dat_oen_inv_u__out[0];

  // sd_dat_in_out_pad_1/I <-> soc_top_u/sd_dat_out[1]
  assign sd_dat_in_out_pad_1__I              = soc_top_u__sd_dat_out[1];

  // sd_dat_in_out_pad_1/O <-> soc_top_u/sd_dat_in[1]
  assign soc_top_u__sd_dat_in[1]             = sd_dat_in_out_pad_1__O;

  // sd_dat_in_out_pad_1/T <-> sd_dat_oen_inv_u/out[1]
  assign sd_dat_in_out_pad_1__T              = sd_dat_oen_inv_u__out[1];

  // sd_dat_in_out_pad_2/I <-> soc_top_u/sd_dat_out[2]
  assign sd_dat_in_out_pad_2__I              = soc_top_u__sd_dat_out[2];

  // sd_dat_in_out_pad_2/O <-> soc_top_u/sd_dat_in[2]
  assign soc_top_u__sd_dat_in[2]             = sd_dat_in_out_pad_2__O;

  // sd_dat_in_out_pad_2/T <-> sd_dat_oen_inv_u/out[2]
  assign sd_dat_in_out_pad_2__T              = sd_dat_oen_inv_u__out[2];

  // sd_dat_in_out_pad_3/I <-> soc_top_u/sd_dat_out[3]
  assign sd_dat_in_out_pad_3__I              = soc_top_u__sd_dat_out[3];

  // sd_dat_in_out_pad_3/O <-> soc_top_u/sd_dat_in[3]
  assign soc_top_u__sd_dat_in[3]             = sd_dat_in_out_pad_3__O;

  // sd_dat_in_out_pad_3/T <-> sd_dat_oen_inv_u/out[3]
  assign sd_dat_in_out_pad_3__T              = sd_dat_oen_inv_u__out[3];

  // soc_top_u.c2p_SSP_SHARED_sel <-> io_muxes_u.SSP_SHARED_sel
  assign io_muxes_u__SSP_SHARED_sel_0        = soc_top_u__c2p_SSP_SHARED_sel_0;
  assign io_muxes_u__SSP_SHARED_sel_1        = soc_top_u__c2p_SSP_SHARED_sel_1;
  assign io_muxes_u__SSP_SHARED_sel_10       = soc_top_u__c2p_SSP_SHARED_sel_10;
  assign io_muxes_u__SSP_SHARED_sel_11       = soc_top_u__c2p_SSP_SHARED_sel_11;
  assign io_muxes_u__SSP_SHARED_sel_12       = soc_top_u__c2p_SSP_SHARED_sel_12;
  assign io_muxes_u__SSP_SHARED_sel_13       = soc_top_u__c2p_SSP_SHARED_sel_13;
  assign io_muxes_u__SSP_SHARED_sel_14       = soc_top_u__c2p_SSP_SHARED_sel_14;
  assign io_muxes_u__SSP_SHARED_sel_15       = soc_top_u__c2p_SSP_SHARED_sel_15;
  assign io_muxes_u__SSP_SHARED_sel_16       = soc_top_u__c2p_SSP_SHARED_sel_16;
  assign io_muxes_u__SSP_SHARED_sel_17       = soc_top_u__c2p_SSP_SHARED_sel_17;
  assign io_muxes_u__SSP_SHARED_sel_18       = soc_top_u__c2p_SSP_SHARED_sel_18;
  assign io_muxes_u__SSP_SHARED_sel_19       = soc_top_u__c2p_SSP_SHARED_sel_19;
  assign io_muxes_u__SSP_SHARED_sel_2        = soc_top_u__c2p_SSP_SHARED_sel_2;
  assign io_muxes_u__SSP_SHARED_sel_20       = soc_top_u__c2p_SSP_SHARED_sel_20;
  assign io_muxes_u__SSP_SHARED_sel_21       = soc_top_u__c2p_SSP_SHARED_sel_21;
  assign io_muxes_u__SSP_SHARED_sel_22       = soc_top_u__c2p_SSP_SHARED_sel_22;
  assign io_muxes_u__SSP_SHARED_sel_23       = soc_top_u__c2p_SSP_SHARED_sel_23;
  assign io_muxes_u__SSP_SHARED_sel_24       = soc_top_u__c2p_SSP_SHARED_sel_24;
  assign io_muxes_u__SSP_SHARED_sel_25       = soc_top_u__c2p_SSP_SHARED_sel_25;
  assign io_muxes_u__SSP_SHARED_sel_26       = soc_top_u__c2p_SSP_SHARED_sel_26;
  assign io_muxes_u__SSP_SHARED_sel_27       = soc_top_u__c2p_SSP_SHARED_sel_27;
  assign io_muxes_u__SSP_SHARED_sel_28       = soc_top_u__c2p_SSP_SHARED_sel_28;
  assign io_muxes_u__SSP_SHARED_sel_29       = soc_top_u__c2p_SSP_SHARED_sel_29;
  assign io_muxes_u__SSP_SHARED_sel_3        = soc_top_u__c2p_SSP_SHARED_sel_3;
  assign io_muxes_u__SSP_SHARED_sel_30       = soc_top_u__c2p_SSP_SHARED_sel_30;
  assign io_muxes_u__SSP_SHARED_sel_31       = soc_top_u__c2p_SSP_SHARED_sel_31;
  assign io_muxes_u__SSP_SHARED_sel_32       = soc_top_u__c2p_SSP_SHARED_sel_32;
  assign io_muxes_u__SSP_SHARED_sel_33       = soc_top_u__c2p_SSP_SHARED_sel_33;
  assign io_muxes_u__SSP_SHARED_sel_34       = soc_top_u__c2p_SSP_SHARED_sel_34;
  assign io_muxes_u__SSP_SHARED_sel_35       = soc_top_u__c2p_SSP_SHARED_sel_35;
  assign io_muxes_u__SSP_SHARED_sel_36       = soc_top_u__c2p_SSP_SHARED_sel_36;
  assign io_muxes_u__SSP_SHARED_sel_37       = soc_top_u__c2p_SSP_SHARED_sel_37;
  assign io_muxes_u__SSP_SHARED_sel_38       = soc_top_u__c2p_SSP_SHARED_sel_38;
  assign io_muxes_u__SSP_SHARED_sel_39       = soc_top_u__c2p_SSP_SHARED_sel_39;
  assign io_muxes_u__SSP_SHARED_sel_4        = soc_top_u__c2p_SSP_SHARED_sel_4;
  assign io_muxes_u__SSP_SHARED_sel_40       = soc_top_u__c2p_SSP_SHARED_sel_40;
  assign io_muxes_u__SSP_SHARED_sel_41       = soc_top_u__c2p_SSP_SHARED_sel_41;
  assign io_muxes_u__SSP_SHARED_sel_42       = soc_top_u__c2p_SSP_SHARED_sel_42;
  assign io_muxes_u__SSP_SHARED_sel_43       = soc_top_u__c2p_SSP_SHARED_sel_43;
  assign io_muxes_u__SSP_SHARED_sel_44       = soc_top_u__c2p_SSP_SHARED_sel_44;
  assign io_muxes_u__SSP_SHARED_sel_45       = soc_top_u__c2p_SSP_SHARED_sel_45;
  assign io_muxes_u__SSP_SHARED_sel_46       = soc_top_u__c2p_SSP_SHARED_sel_46;
  assign io_muxes_u__SSP_SHARED_sel_47       = soc_top_u__c2p_SSP_SHARED_sel_47;
  assign io_muxes_u__SSP_SHARED_sel_5        = soc_top_u__c2p_SSP_SHARED_sel_5;
  assign io_muxes_u__SSP_SHARED_sel_6        = soc_top_u__c2p_SSP_SHARED_sel_6;
  assign io_muxes_u__SSP_SHARED_sel_7        = soc_top_u__c2p_SSP_SHARED_sel_7;
  assign io_muxes_u__SSP_SHARED_sel_8        = soc_top_u__c2p_SSP_SHARED_sel_8;
  assign io_muxes_u__SSP_SHARED_sel_9        = soc_top_u__c2p_SSP_SHARED_sel_9;

  // soc_top_u.mem_noc_req_if <-> xilinx_ddr_u.req_if
  assign soc_top_u__mem_noc_req_if_arready   = xilinx_ddr_u__req_if_arready;
  assign soc_top_u__mem_noc_req_if_awready   = xilinx_ddr_u__req_if_awready;
  assign soc_top_u__mem_noc_req_if_wready    = xilinx_ddr_u__req_if_wready;
  assign xilinx_ddr_u__req_if_ar             = soc_top_u__mem_noc_req_if_ar;
  assign xilinx_ddr_u__req_if_arvalid        = soc_top_u__mem_noc_req_if_arvalid;
  assign xilinx_ddr_u__req_if_aw             = soc_top_u__mem_noc_req_if_aw;
  assign xilinx_ddr_u__req_if_awvalid        = soc_top_u__mem_noc_req_if_awvalid;
  assign xilinx_ddr_u__req_if_w              = soc_top_u__mem_noc_req_if_w;
  assign xilinx_ddr_u__req_if_wvalid         = soc_top_u__mem_noc_req_if_wvalid;

  // soc_top_u.mem_noc_resp_if <-> xilinx_ddr_u.rsp_if
  assign soc_top_u__mem_noc_resp_if_b        = xilinx_ddr_u__rsp_if_b;
  assign soc_top_u__mem_noc_resp_if_bvalid   = xilinx_ddr_u__rsp_if_bvalid;
  assign soc_top_u__mem_noc_resp_if_r        = xilinx_ddr_u__rsp_if_r;
  assign soc_top_u__mem_noc_resp_if_rvalid   = xilinx_ddr_u__rsp_if_rvalid;
  assign xilinx_ddr_u__rsp_if_bready         = soc_top_u__mem_noc_resp_if_bready;
  assign xilinx_ddr_u__rsp_if_rready         = soc_top_u__mem_noc_resp_if_rready;

  // soc_top_u/B0_pll_out <-> 'b0
  assign soc_top_u__B0_pll_out               = {{($bits(soc_top_u__B0_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B10_pll_out <-> 'b0
  assign soc_top_u__B10_pll_out              = {{($bits(soc_top_u__B10_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B11_pll_out <-> 'b0
  assign soc_top_u__B11_pll_out              = {{($bits(soc_top_u__B11_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B12_pll_out <-> 'b0
  assign soc_top_u__B12_pll_out              = {{($bits(soc_top_u__B12_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B13_pll_out <-> 'b0
  assign soc_top_u__B13_pll_out              = {{($bits(soc_top_u__B13_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B14_pll_out <-> 'b0
  assign soc_top_u__B14_pll_out              = {{($bits(soc_top_u__B14_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B15_pll_out <-> 'b0
  assign soc_top_u__B15_pll_out              = {{($bits(soc_top_u__B15_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B16_pll_out <-> 'b0
  assign soc_top_u__B16_pll_out              = {{($bits(soc_top_u__B16_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B17_pll_out <-> 'b0
  assign soc_top_u__B17_pll_out              = {{($bits(soc_top_u__B17_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B18_pll_out <-> 'b0
  assign soc_top_u__B18_pll_out              = {{($bits(soc_top_u__B18_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B19_pll_out <-> 'b0
  assign soc_top_u__B19_pll_out              = {{($bits(soc_top_u__B19_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B1_ddr_pwr_ok_in <-> 'b0
  assign soc_top_u__B1_ddr_pwr_ok_in         = {{($bits(soc_top_u__B1_ddr_pwr_ok_in)-1){1'b0}}, 1'b0};

  // soc_top_u/B1_pll_out <-> 'b0
  assign soc_top_u__B1_pll_out               = {{($bits(soc_top_u__B1_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B20_pll_out <-> 'b0
  assign soc_top_u__B20_pll_out              = {{($bits(soc_top_u__B20_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B21_pll_out <-> 'b0
  assign soc_top_u__B21_pll_out              = {{($bits(soc_top_u__B21_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B22_pll_out <-> 'b0
  assign soc_top_u__B22_pll_out              = {{($bits(soc_top_u__B22_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B23_pll_out <-> 'b0
  assign soc_top_u__B23_pll_out              = {{($bits(soc_top_u__B23_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B24_pll_out <-> 'b0
  assign soc_top_u__B24_pll_out              = {{($bits(soc_top_u__B24_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B2_pll_out <-> 'b0
  assign soc_top_u__B2_pll_out               = {{($bits(soc_top_u__B2_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B3_dft_mbist_mode <-> 'b0
  assign soc_top_u__B3_dft_mbist_mode        = {{($bits(soc_top_u__B3_dft_mbist_mode)-1){1'b0}}, 1'b0};

  // soc_top_u/B3_pll_out <-> 'b0
  assign soc_top_u__B3_pll_out               = {{($bits(soc_top_u__B3_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B4_pll_out <-> 'b0
  assign soc_top_u__B4_pll_out               = {{($bits(soc_top_u__B4_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B5_pll_out <-> 'b0
  assign soc_top_u__B5_pll_out               = {{($bits(soc_top_u__B5_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B6_pll_out <-> 'b0
  assign soc_top_u__B6_pll_out               = {{($bits(soc_top_u__B6_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B7_pll_out <-> 'b0
  assign soc_top_u__B7_pll_out               = {{($bits(soc_top_u__B7_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B8_pll_out <-> 'b0
  assign soc_top_u__B8_pll_out               = {{($bits(soc_top_u__B8_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/B9_pll_out <-> 'b0
  assign soc_top_u__B9_pll_out               = {{($bits(soc_top_u__B9_pll_out)-1){1'b0}}, 1'b0};

  // soc_top_u/C25_usb_pwrdown_ssp <-> 'b0
  assign soc_top_u__C25_usb_pwrdown_ssp      = {{($bits(soc_top_u__C25_usb_pwrdown_ssp)-1){1'b0}}, 1'b0};

  // soc_top_u/C26_usb_pwrdown_hsp <-> 'b0
  assign soc_top_u__C26_usb_pwrdown_hsp      = {{($bits(soc_top_u__C26_usb_pwrdown_hsp)-1){1'b0}}, 1'b0};

  // soc_top_u/C27_usb_ref_ssp_en <-> 'b0
  assign soc_top_u__C27_usb_ref_ssp_en       = {{($bits(soc_top_u__C27_usb_ref_ssp_en)-1){1'b0}}, 1'b0};

  // soc_top_u/C28_usb_ref_use_pad <-> 'b0
  assign soc_top_u__C28_usb_ref_use_pad      = {{($bits(soc_top_u__C28_usb_ref_use_pad)-1){1'b0}}, 1'b0};

  // soc_top_u/ana_bscan_sel <-> 'b0
  assign soc_top_u__ana_bscan_sel            = {{($bits(soc_top_u__ana_bscan_sel)-1){1'b0}}, 1'b0};

  // soc_top_u/boot_from_flash_mode <-> 'b0
  assign soc_top_u__boot_from_flash_mode     = {{($bits(soc_top_u__boot_from_flash_mode)-1){1'b0}}, 1'b0};

  // soc_top_u/boot_fsm_mode <-> 'b0
  assign soc_top_u__boot_fsm_mode            = {{($bits(soc_top_u__boot_fsm_mode)-1){1'b0}}, 1'b0};

  // soc_top_u/cmd_vld_in <-> 'b0
  assign soc_top_u__cmd_vld_in               = {{($bits(soc_top_u__cmd_vld_in)-1){1'b0}}, 1'b0};

  // soc_top_u/cmdbuf_in <-> 'b0
  assign soc_top_u__cmdbuf_in                = {{($bits(soc_top_u__cmdbuf_in)-1){1'b0}}, 1'b0};

  // soc_top_u/dft_glue_u_tck_invert_in <-> 'b0
  assign soc_top_u__dft_glue_u_tck_invert_in = {{($bits(soc_top_u__dft_glue_u_tck_invert_in)-1){1'b0}}, 1'b0};

  // soc_top_u/global_scan_enable <-> 'b0
  assign soc_top_u__global_scan_enable       = {{($bits(soc_top_u__global_scan_enable)-1){1'b0}}, 1'b0};

  // soc_top_u/jtag_tdi_to_usb <-> 'b0
  assign soc_top_u__jtag_tdi_to_usb          = {{($bits(soc_top_u__jtag_tdi_to_usb)-1){1'b0}}, 1'b0};

  // soc_top_u/jtag_tms_to_usb <-> 'b0
  assign soc_top_u__jtag_tms_to_usb          = {{($bits(soc_top_u__jtag_tms_to_usb)-1){1'b0}}, 1'b0};

  // soc_top_u/jtag_trst_n_to_usb <-> 'b0
  assign soc_top_u__jtag_trst_n_to_usb       = {{($bits(soc_top_u__jtag_trst_n_to_usb)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_chip_wake_up <-> 'b0
  assign soc_top_u__p2c_chip_wake_up         = {{($bits(soc_top_u__p2c_chip_wake_up)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_jtag_tck <-> 'b0
  assign soc_top_u__p2c_jtag_tck             = {{($bits(soc_top_u__p2c_jtag_tck)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_jtag_tdi <-> 'b0
  assign soc_top_u__p2c_jtag_tdi             = {{($bits(soc_top_u__p2c_jtag_tdi)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_jtag_tms <-> 'b0
  assign soc_top_u__p2c_jtag_tms             = {{($bits(soc_top_u__p2c_jtag_tms)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_jtag_trst_n <-> 'b0
  assign soc_top_u__p2c_jtag_trst_n          = {{($bits(soc_top_u__p2c_jtag_trst_n)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_ate_clk <-> 'b0
  assign soc_top_u__p2c_scan_ate_clk         = {{($bits(soc_top_u__p2c_scan_ate_clk)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_enable <-> 'b0
  assign soc_top_u__p2c_scan_enable          = {{($bits(soc_top_u__p2c_scan_enable)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_f_clk <-> 'b0
  assign soc_top_u__p2c_scan_f_clk           = {{($bits(soc_top_u__p2c_scan_f_clk)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_f_in <-> 'b0
  assign soc_top_u__p2c_scan_f_in            = {{($bits(soc_top_u__p2c_scan_f_in)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_f_mode <-> 'b0
  assign soc_top_u__p2c_scan_f_mode          = {{($bits(soc_top_u__p2c_scan_f_mode)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_f_reset <-> 'b0
  assign soc_top_u__p2c_scan_f_reset         = {{($bits(soc_top_u__p2c_scan_f_reset)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_in <-> 'b0
  assign soc_top_u__p2c_scan_in              = {{($bits(soc_top_u__p2c_scan_in)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_mode <-> 'b0
  assign soc_top_u__p2c_scan_mode            = {{($bits(soc_top_u__p2c_scan_mode)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_reset <-> 'b0
  assign soc_top_u__p2c_scan_reset           = {{($bits(soc_top_u__p2c_scan_reset)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_tap_compliance <-> 'b0
  assign soc_top_u__p2c_scan_tap_compliance  = {{($bits(soc_top_u__p2c_scan_tap_compliance)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_scan_test_modes <-> 'b0
  assign soc_top_u__p2c_scan_test_modes      = {{($bits(soc_top_u__p2c_scan_test_modes)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_test_io_clk <-> 'b0
  assign soc_top_u__p2c_test_io_clk          = {{($bits(soc_top_u__p2c_test_io_clk)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_test_io_data <-> 'b0
  assign soc_top_u__p2c_test_io_data         = {{($bits(soc_top_u__p2c_test_io_data)-1){1'b0}}, 1'b0};

  // soc_top_u/p2c_test_io_en <-> 'b0
  assign soc_top_u__p2c_test_io_en           = {{($bits(soc_top_u__p2c_test_io_en)-1){1'b0}}, 1'b0};

  // soc_top_u/ref_pad_clk_m <-> 'b0
  assign soc_top_u__ref_pad_clk_m            = {{($bits(soc_top_u__ref_pad_clk_m)-1){1'b0}}, 1'b0};

  // soc_top_u/ref_pad_clk_p <-> 'b0
  assign soc_top_u__ref_pad_clk_p            = {{($bits(soc_top_u__ref_pad_clk_p)-1){1'b0}}, 1'b0};

  // soc_top_u/rx0_m <-> 'b0
  assign soc_top_u__rx0_m                    = {{($bits(soc_top_u__rx0_m)-1){1'b0}}, 1'b0};

  // soc_top_u/rx0_p <-> 'b0
  assign soc_top_u__rx0_p                    = {{($bits(soc_top_u__rx0_p)-1){1'b0}}, 1'b0};

  // soc_top_u/sd_cmd_out_en <-> sd_cmd_oen_inv_u/in
  assign sd_cmd_oen_inv_u__in                = soc_top_u__sd_cmd_out_en;

  // soc_top_u/sd_dat_out_en[0] <-> sd_dat_oen_inv_u/in[0]
  assign sd_dat_oen_inv_u__in[0]             = soc_top_u__sd_dat_out_en[0];

  // soc_top_u/sd_dat_out_en[1] <-> sd_dat_oen_inv_u/in[1]
  assign sd_dat_oen_inv_u__in[1]             = soc_top_u__sd_dat_out_en[1];

  // soc_top_u/sd_dat_out_en[2] <-> sd_dat_oen_inv_u/in[2]
  assign sd_dat_oen_inv_u__in[2]             = soc_top_u__sd_dat_out_en[2];

  // soc_top_u/sd_dat_out_en[3] <-> sd_dat_oen_inv_u/in[3]
  assign sd_dat_oen_inv_u__in[3]             = soc_top_u__sd_dat_out_en[3];

  // soc_top_u/usb_icg_ten <-> 'b0
  assign soc_top_u__usb_icg_ten              = {{($bits(soc_top_u__usb_icg_ten)-1){1'b0}}, 1'b0};

  // soc_top_u/usb_jtag_tck_gated <-> 'b0
  assign soc_top_u__usb_jtag_tck_gated       = {{($bits(soc_top_u__usb_jtag_tck_gated)-1){1'b0}}, 1'b0};

  // soc_top_u/vcore_icg_ten <-> 'b0
  assign soc_top_u__vcore_icg_ten            = {{($bits(soc_top_u__vcore_icg_ten)-1){1'b0}}, 1'b0};

  // sspim0_rxd_pad_0/I <-> 'b0
  assign sspim0_rxd_pad_0__I                 = {{($bits(sspim0_rxd_pad_0__I)-1){1'b0}}, 1'b0};

  // sspim0_rxd_pad_0/O <-> soc_top_u/p2c_sspim0_i
  assign soc_top_u__p2c_sspim0_i             = sspim0_rxd_pad_0__O;

  // sspim0_rxd_pad_0/T <-> 'b1
  assign sspim0_rxd_pad_0__T                 = {{($bits(sspim0_rxd_pad_0__T)-1){1'b0}}, 1'b1};

  // sspim0_sclk_out_pad_0/I <-> soc_top_u/c2p_sspim0_clk
  assign sspim0_sclk_out_pad_0__I            = soc_top_u__c2p_sspim0_clk;

  // sspim0_sclk_out_pad_0/T <-> 'b0
  assign sspim0_sclk_out_pad_0__T            = {{($bits(sspim0_sclk_out_pad_0__T)-1){1'b0}}, 1'b0};

  // sspim0_ss_pad_0/I <-> soc_top_u/c2p_sspim0_cs_n
  assign sspim0_ss_pad_0__I                  = soc_top_u__c2p_sspim0_cs_n;

  // sspim0_ss_pad_0/T <-> 'b0
  assign sspim0_ss_pad_0__T                  = {{($bits(sspim0_ss_pad_0__T)-1){1'b0}}, 1'b0};

  // sspim0_txd_pad_0/I <-> soc_top_u/c2p_sspim0_o
  assign sspim0_txd_pad_0__I                 = soc_top_u__c2p_sspim0_o;

  // sspim0_txd_pad_0/T <-> 'b0
  assign sspim0_txd_pad_0__T                 = {{($bits(sspim0_txd_pad_0__T)-1){1'b0}}, 1'b0};

  // uart1_sin_pad_0/I <-> 'b0
  assign uart1_sin_pad_0__I                  = {{($bits(uart1_sin_pad_0__I)-1){1'b0}}, 1'b0};

  // uart1_sin_pad_0/O <-> soc_top_u/p2c_uart1_sin
  assign soc_top_u__p2c_uart1_sin            = uart1_sin_pad_0__O;

  // uart1_sin_pad_0/T <-> 'b1
  assign uart1_sin_pad_0__T                  = {{($bits(uart1_sin_pad_0__T)-1){1'b0}}, 1'b1};

  // uart1_sout_pad_0/I <-> soc_top_u/c2p_uart1_sout
  assign uart1_sout_pad_0__I                 = soc_top_u__c2p_uart1_sout;

  // uart1_sout_pad_0/T <-> 'b0
  assign uart1_sout_pad_0__T                 = {{($bits(uart1_sout_pad_0__T)-1){1'b0}}, 1'b0};

  // uart2_sin_pad_0/I <-> 'b0
  assign uart2_sin_pad_0__I                  = {{($bits(uart2_sin_pad_0__I)-1){1'b0}}, 1'b0};

  // uart2_sin_pad_0/O <-> soc_top_u/p2c_uart2_sin
  assign soc_top_u__p2c_uart2_sin            = uart2_sin_pad_0__O;

  // uart2_sin_pad_0/T <-> 'b1
  assign uart2_sin_pad_0__T                  = {{($bits(uart2_sin_pad_0__T)-1){1'b0}}, 1'b1};

  // uart2_sout_pad_0/I <-> soc_top_u/c2p_uart2_sout
  assign uart2_sout_pad_0__I                 = soc_top_u__c2p_uart2_sout;

  // uart2_sout_pad_0/T <-> 'b0
  assign uart2_sout_pad_0__T                 = {{($bits(uart2_sout_pad_0__T)-1){1'b0}}, 1'b0};

  // xilinx_ddr_u/addn_ui_clkout1 <-> jtag_wrapper_u/aclk
  assign jtag_wrapper_u__aclk                = xilinx_ddr_u__addn_ui_clkout1;

  // xilinx_ddr_u/addn_ui_clkout1 <-> soc_top_u/p2c_refclk
  assign soc_top_u__p2c_refclk               = xilinx_ddr_u__addn_ui_clkout1;

  // xilinx_ddr_u/addn_ui_clkout1 <-> soc_top_u/p2c_rtcclk
  assign soc_top_u__p2c_rtcclk               = xilinx_ddr_u__addn_ui_clkout1;

  // xilinx_ddr_u/c0_init_calib_complete <-> jtag_wrapper_u/reset
  assign jtag_wrapper_u__reset               = xilinx_ddr_u__c0_init_calib_complete;


IOBUF SSP_SHARED_0_pad_0(
  .I(SSP_SHARED_0_pad_0__I),
  .IO(tbp_SSP_SHARED_0),
  .O(SSP_SHARED_0_pad_0__O),
  .T(SSP_SHARED_0_pad_0__T)
);

IOBUF SSP_SHARED_10_pad_0(
  .I(SSP_SHARED_10_pad_0__I),
  .IO(t2p_SSP_SHARED_10),
  .O(SSP_SHARED_10_pad_0__O),
  .T(SSP_SHARED_10_pad_0__T)
);

IOBUF SSP_SHARED_11_pad_0(
  .I(SSP_SHARED_11_pad_0__I),
  .IO(t2p_SSP_SHARED_11),
  .O(SSP_SHARED_11_pad_0__O),
  .T(SSP_SHARED_11_pad_0__T)
);

IOBUF SSP_SHARED_12_pad_0(
  .I(SSP_SHARED_12_pad_0__I),
  .IO(p2t_SSP_SHARED_12),
  .O(SSP_SHARED_12_pad_0__O),
  .T(SSP_SHARED_12_pad_0__T)
);

IOBUF SSP_SHARED_13_pad_0(
  .I(SSP_SHARED_13_pad_0__I),
  .IO(tbp_SSP_SHARED_13),
  .O(SSP_SHARED_13_pad_0__O),
  .T(SSP_SHARED_13_pad_0__T)
);

IOBUF SSP_SHARED_14_pad_0(
  .I(SSP_SHARED_14_pad_0__I),
  .IO(t2p_SSP_SHARED_14),
  .O(SSP_SHARED_14_pad_0__O),
  .T(SSP_SHARED_14_pad_0__T)
);

IOBUF SSP_SHARED_15_pad_0(
  .I(SSP_SHARED_15_pad_0__I),
  .IO(tbp_SSP_SHARED_15),
  .O(SSP_SHARED_15_pad_0__O),
  .T(SSP_SHARED_15_pad_0__T)
);

IOBUF SSP_SHARED_16_pad_0(
  .I(SSP_SHARED_16_pad_0__I),
  .IO(tbp_SSP_SHARED_16),
  .O(SSP_SHARED_16_pad_0__O),
  .T(SSP_SHARED_16_pad_0__T)
);

IOBUF SSP_SHARED_17_pad_0(
  .I(SSP_SHARED_17_pad_0__I),
  .IO(tbp_SSP_SHARED_17),
  .O(SSP_SHARED_17_pad_0__O),
  .T(SSP_SHARED_17_pad_0__T)
);

IOBUF SSP_SHARED_18_pad_0(
  .I(SSP_SHARED_18_pad_0__I),
  .IO(tbp_SSP_SHARED_18),
  .O(SSP_SHARED_18_pad_0__O),
  .T(SSP_SHARED_18_pad_0__T)
);

IOBUF SSP_SHARED_19_pad_0(
  .I(SSP_SHARED_19_pad_0__I),
  .IO(tbp_SSP_SHARED_19),
  .O(SSP_SHARED_19_pad_0__O),
  .T(SSP_SHARED_19_pad_0__T)
);

IOBUF SSP_SHARED_1_pad_0(
  .I(SSP_SHARED_1_pad_0__I),
  .IO(p2t_SSP_SHARED_1),
  .O(SSP_SHARED_1_pad_0__O),
  .T(SSP_SHARED_1_pad_0__T)
);

IOBUF SSP_SHARED_20_pad_0(
  .I(SSP_SHARED_20_pad_0__I),
  .IO(tbp_SSP_SHARED_20),
  .O(SSP_SHARED_20_pad_0__O),
  .T(SSP_SHARED_20_pad_0__T)
);

IOBUF SSP_SHARED_21_pad_0(
  .I(SSP_SHARED_21_pad_0__I),
  .IO(tbp_SSP_SHARED_21),
  .O(SSP_SHARED_21_pad_0__O),
  .T(SSP_SHARED_21_pad_0__T)
);

IOBUF SSP_SHARED_22_pad_0(
  .I(SSP_SHARED_22_pad_0__I),
  .IO(tbp_SSP_SHARED_22),
  .O(SSP_SHARED_22_pad_0__O),
  .T(SSP_SHARED_22_pad_0__T)
);

IOBUF SSP_SHARED_23_pad_0(
  .I(SSP_SHARED_23_pad_0__I),
  .IO(tbp_SSP_SHARED_23),
  .O(SSP_SHARED_23_pad_0__O),
  .T(SSP_SHARED_23_pad_0__T)
);

IOBUF SSP_SHARED_24_pad_0(
  .I(SSP_SHARED_24_pad_0__I),
  .IO(tbp_SSP_SHARED_24),
  .O(SSP_SHARED_24_pad_0__O),
  .T(SSP_SHARED_24_pad_0__T)
);

IOBUF SSP_SHARED_25_pad_0(
  .I(SSP_SHARED_25_pad_0__I),
  .IO(tbp_SSP_SHARED_25),
  .O(SSP_SHARED_25_pad_0__O),
  .T(SSP_SHARED_25_pad_0__T)
);

IOBUF SSP_SHARED_26_pad_0(
  .I(SSP_SHARED_26_pad_0__I),
  .IO(tbp_SSP_SHARED_26),
  .O(SSP_SHARED_26_pad_0__O),
  .T(SSP_SHARED_26_pad_0__T)
);

IOBUF SSP_SHARED_27_pad_0(
  .I(SSP_SHARED_27_pad_0__I),
  .IO(tbp_SSP_SHARED_27),
  .O(SSP_SHARED_27_pad_0__O),
  .T(SSP_SHARED_27_pad_0__T)
);

IOBUF SSP_SHARED_28_pad_0(
  .I(SSP_SHARED_28_pad_0__I),
  .IO(tbp_SSP_SHARED_28),
  .O(SSP_SHARED_28_pad_0__O),
  .T(SSP_SHARED_28_pad_0__T)
);

IOBUF SSP_SHARED_29_pad_0(
  .I(SSP_SHARED_29_pad_0__I),
  .IO(tbp_SSP_SHARED_29),
  .O(SSP_SHARED_29_pad_0__O),
  .T(SSP_SHARED_29_pad_0__T)
);

IOBUF SSP_SHARED_2_pad_0(
  .I(SSP_SHARED_2_pad_0__I),
  .IO(p2t_SSP_SHARED_2),
  .O(SSP_SHARED_2_pad_0__O),
  .T(SSP_SHARED_2_pad_0__T)
);

IOBUF SSP_SHARED_30_pad_0(
  .I(SSP_SHARED_30_pad_0__I),
  .IO(tbp_SSP_SHARED_30),
  .O(SSP_SHARED_30_pad_0__O),
  .T(SSP_SHARED_30_pad_0__T)
);

IOBUF SSP_SHARED_31_pad_0(
  .I(SSP_SHARED_31_pad_0__I),
  .IO(tbp_SSP_SHARED_31),
  .O(SSP_SHARED_31_pad_0__O),
  .T(SSP_SHARED_31_pad_0__T)
);

IOBUF SSP_SHARED_32_pad_0(
  .I(SSP_SHARED_32_pad_0__I),
  .IO(tbp_SSP_SHARED_32),
  .O(SSP_SHARED_32_pad_0__O),
  .T(SSP_SHARED_32_pad_0__T)
);

IOBUF SSP_SHARED_33_pad_0(
  .I(SSP_SHARED_33_pad_0__I),
  .IO(tbp_SSP_SHARED_33),
  .O(SSP_SHARED_33_pad_0__O),
  .T(SSP_SHARED_33_pad_0__T)
);

IOBUF SSP_SHARED_34_pad_0(
  .I(SSP_SHARED_34_pad_0__I),
  .IO(tbp_SSP_SHARED_34),
  .O(SSP_SHARED_34_pad_0__O),
  .T(SSP_SHARED_34_pad_0__T)
);

IOBUF SSP_SHARED_35_pad_0(
  .I(SSP_SHARED_35_pad_0__I),
  .IO(tbp_SSP_SHARED_35),
  .O(SSP_SHARED_35_pad_0__O),
  .T(SSP_SHARED_35_pad_0__T)
);

IOBUF SSP_SHARED_36_pad_0(
  .I(SSP_SHARED_36_pad_0__I),
  .IO(tbp_SSP_SHARED_36),
  .O(SSP_SHARED_36_pad_0__O),
  .T(SSP_SHARED_36_pad_0__T)
);

IOBUF SSP_SHARED_37_pad_0(
  .I(SSP_SHARED_37_pad_0__I),
  .IO(tbp_SSP_SHARED_37),
  .O(SSP_SHARED_37_pad_0__O),
  .T(SSP_SHARED_37_pad_0__T)
);

IOBUF SSP_SHARED_38_pad_0(
  .I(SSP_SHARED_38_pad_0__I),
  .IO(tbp_SSP_SHARED_38),
  .O(SSP_SHARED_38_pad_0__O),
  .T(SSP_SHARED_38_pad_0__T)
);

IOBUF SSP_SHARED_39_pad_0(
  .I(SSP_SHARED_39_pad_0__I),
  .IO(tbp_SSP_SHARED_39),
  .O(SSP_SHARED_39_pad_0__O),
  .T(SSP_SHARED_39_pad_0__T)
);

IOBUF SSP_SHARED_3_pad_0(
  .I(SSP_SHARED_3_pad_0__I),
  .IO(tbp_SSP_SHARED_3),
  .O(SSP_SHARED_3_pad_0__O),
  .T(SSP_SHARED_3_pad_0__T)
);

IOBUF SSP_SHARED_40_pad_0(
  .I(SSP_SHARED_40_pad_0__I),
  .IO(tbp_SSP_SHARED_40),
  .O(SSP_SHARED_40_pad_0__O),
  .T(SSP_SHARED_40_pad_0__T)
);

IOBUF SSP_SHARED_41_pad_0(
  .I(SSP_SHARED_41_pad_0__I),
  .IO(tbp_SSP_SHARED_41),
  .O(SSP_SHARED_41_pad_0__O),
  .T(SSP_SHARED_41_pad_0__T)
);

IOBUF SSP_SHARED_42_pad_0(
  .I(SSP_SHARED_42_pad_0__I),
  .IO(tbp_SSP_SHARED_42),
  .O(SSP_SHARED_42_pad_0__O),
  .T(SSP_SHARED_42_pad_0__T)
);

IOBUF SSP_SHARED_43_pad_0(
  .I(SSP_SHARED_43_pad_0__I),
  .IO(tbp_SSP_SHARED_43),
  .O(SSP_SHARED_43_pad_0__O),
  .T(SSP_SHARED_43_pad_0__T)
);

IOBUF SSP_SHARED_44_pad_0(
  .I(SSP_SHARED_44_pad_0__I),
  .IO(tbp_SSP_SHARED_44),
  .O(SSP_SHARED_44_pad_0__O),
  .T(SSP_SHARED_44_pad_0__T)
);

IOBUF SSP_SHARED_45_pad_0(
  .I(SSP_SHARED_45_pad_0__I),
  .IO(tbp_SSP_SHARED_45),
  .O(SSP_SHARED_45_pad_0__O),
  .T(SSP_SHARED_45_pad_0__T)
);

IOBUF SSP_SHARED_46_pad_0(
  .I(SSP_SHARED_46_pad_0__I),
  .IO(tbp_SSP_SHARED_46),
  .O(SSP_SHARED_46_pad_0__O),
  .T(SSP_SHARED_46_pad_0__T)
);

IOBUF SSP_SHARED_47_pad_0(
  .I(SSP_SHARED_47_pad_0__I),
  .IO(tbp_SSP_SHARED_47),
  .O(SSP_SHARED_47_pad_0__O),
  .T(SSP_SHARED_47_pad_0__T)
);

IOBUF SSP_SHARED_4_pad_0(
  .I(SSP_SHARED_4_pad_0__I),
  .IO(tbp_SSP_SHARED_4),
  .O(SSP_SHARED_4_pad_0__O),
  .T(SSP_SHARED_4_pad_0__T)
);

IOBUF SSP_SHARED_5_pad_0(
  .I(SSP_SHARED_5_pad_0__I),
  .IO(tbp_SSP_SHARED_5),
  .O(SSP_SHARED_5_pad_0__O),
  .T(SSP_SHARED_5_pad_0__T)
);

IOBUF SSP_SHARED_6_pad_0(
  .I(SSP_SHARED_6_pad_0__I),
  .IO(p2t_SSP_SHARED_6),
  .O(SSP_SHARED_6_pad_0__O),
  .T(SSP_SHARED_6_pad_0__T)
);

IOBUF SSP_SHARED_7_pad_0(
  .I(SSP_SHARED_7_pad_0__I),
  .IO(tbp_SSP_SHARED_7),
  .O(SSP_SHARED_7_pad_0__O),
  .T(SSP_SHARED_7_pad_0__T)
);

IOBUF SSP_SHARED_8_pad_0(
  .I(SSP_SHARED_8_pad_0__I),
  .IO(tbp_SSP_SHARED_8),
  .O(SSP_SHARED_8_pad_0__O),
  .T(SSP_SHARED_8_pad_0__T)
);

IOBUF SSP_SHARED_9_pad_0(
  .I(SSP_SHARED_9_pad_0__I),
  .IO(tbp_SSP_SHARED_9),
  .O(SSP_SHARED_9_pad_0__O),
  .T(SSP_SHARED_9_pad_0__T)
);

IOBUF i2c0_ic_clk_pad_0(
  .I(i2c0_ic_clk_pad_0__I),
  .IO(tbp_i2c0_ic_clk),
  .O(i2c0_ic_clk_pad_0__O),
  .T(i2c0_ic_clk_pad_0__T)
);

IOBUF i2c0_ic_data_pad_0(
  .I(i2c0_ic_data_pad_0__I),
  .IO(tbp_i2c0_ic_data),
  .O(i2c0_ic_data_pad_0__O),
  .T(i2c0_ic_data_pad_0__T)
);

io_muxes io_muxes_u(
  .SSP_SHARED_sel_0(io_muxes_u__SSP_SHARED_sel_0),
  .SSP_SHARED_sel_1(io_muxes_u__SSP_SHARED_sel_1),
  .SSP_SHARED_sel_10(io_muxes_u__SSP_SHARED_sel_10),
  .SSP_SHARED_sel_11(io_muxes_u__SSP_SHARED_sel_11),
  .SSP_SHARED_sel_12(io_muxes_u__SSP_SHARED_sel_12),
  .SSP_SHARED_sel_13(io_muxes_u__SSP_SHARED_sel_13),
  .SSP_SHARED_sel_14(io_muxes_u__SSP_SHARED_sel_14),
  .SSP_SHARED_sel_15(io_muxes_u__SSP_SHARED_sel_15),
  .SSP_SHARED_sel_16(io_muxes_u__SSP_SHARED_sel_16),
  .SSP_SHARED_sel_17(io_muxes_u__SSP_SHARED_sel_17),
  .SSP_SHARED_sel_18(io_muxes_u__SSP_SHARED_sel_18),
  .SSP_SHARED_sel_19(io_muxes_u__SSP_SHARED_sel_19),
  .SSP_SHARED_sel_2(io_muxes_u__SSP_SHARED_sel_2),
  .SSP_SHARED_sel_20(io_muxes_u__SSP_SHARED_sel_20),
  .SSP_SHARED_sel_21(io_muxes_u__SSP_SHARED_sel_21),
  .SSP_SHARED_sel_22(io_muxes_u__SSP_SHARED_sel_22),
  .SSP_SHARED_sel_23(io_muxes_u__SSP_SHARED_sel_23),
  .SSP_SHARED_sel_24(io_muxes_u__SSP_SHARED_sel_24),
  .SSP_SHARED_sel_25(io_muxes_u__SSP_SHARED_sel_25),
  .SSP_SHARED_sel_26(io_muxes_u__SSP_SHARED_sel_26),
  .SSP_SHARED_sel_27(io_muxes_u__SSP_SHARED_sel_27),
  .SSP_SHARED_sel_28(io_muxes_u__SSP_SHARED_sel_28),
  .SSP_SHARED_sel_29(io_muxes_u__SSP_SHARED_sel_29),
  .SSP_SHARED_sel_3(io_muxes_u__SSP_SHARED_sel_3),
  .SSP_SHARED_sel_30(io_muxes_u__SSP_SHARED_sel_30),
  .SSP_SHARED_sel_31(io_muxes_u__SSP_SHARED_sel_31),
  .SSP_SHARED_sel_32(io_muxes_u__SSP_SHARED_sel_32),
  .SSP_SHARED_sel_33(io_muxes_u__SSP_SHARED_sel_33),
  .SSP_SHARED_sel_34(io_muxes_u__SSP_SHARED_sel_34),
  .SSP_SHARED_sel_35(io_muxes_u__SSP_SHARED_sel_35),
  .SSP_SHARED_sel_36(io_muxes_u__SSP_SHARED_sel_36),
  .SSP_SHARED_sel_37(io_muxes_u__SSP_SHARED_sel_37),
  .SSP_SHARED_sel_38(io_muxes_u__SSP_SHARED_sel_38),
  .SSP_SHARED_sel_39(io_muxes_u__SSP_SHARED_sel_39),
  .SSP_SHARED_sel_4(io_muxes_u__SSP_SHARED_sel_4),
  .SSP_SHARED_sel_40(io_muxes_u__SSP_SHARED_sel_40),
  .SSP_SHARED_sel_41(io_muxes_u__SSP_SHARED_sel_41),
  .SSP_SHARED_sel_42(io_muxes_u__SSP_SHARED_sel_42),
  .SSP_SHARED_sel_43(io_muxes_u__SSP_SHARED_sel_43),
  .SSP_SHARED_sel_44(io_muxes_u__SSP_SHARED_sel_44),
  .SSP_SHARED_sel_45(io_muxes_u__SSP_SHARED_sel_45),
  .SSP_SHARED_sel_46(io_muxes_u__SSP_SHARED_sel_46),
  .SSP_SHARED_sel_47(io_muxes_u__SSP_SHARED_sel_47),
  .SSP_SHARED_sel_5(io_muxes_u__SSP_SHARED_sel_5),
  .SSP_SHARED_sel_6(io_muxes_u__SSP_SHARED_sel_6),
  .SSP_SHARED_sel_7(io_muxes_u__SSP_SHARED_sel_7),
  .SSP_SHARED_sel_8(io_muxes_u__SSP_SHARED_sel_8),
  .SSP_SHARED_sel_9(io_muxes_u__SSP_SHARED_sel_9),
  .c2p_SSP_SHARED_0(io_muxes_u__c2p_SSP_SHARED_0),
  .c2p_SSP_SHARED_0_oen(io_muxes_u__c2p_SSP_SHARED_0_oen),
  .c2p_SSP_SHARED_1(io_muxes_u__c2p_SSP_SHARED_1),
  .c2p_SSP_SHARED_12(io_muxes_u__c2p_SSP_SHARED_12),
  .c2p_SSP_SHARED_13(io_muxes_u__c2p_SSP_SHARED_13),
  .c2p_SSP_SHARED_13_oen(io_muxes_u__c2p_SSP_SHARED_13_oen),
  .c2p_SSP_SHARED_15(io_muxes_u__c2p_SSP_SHARED_15),
  .c2p_SSP_SHARED_15_oen(io_muxes_u__c2p_SSP_SHARED_15_oen),
  .c2p_SSP_SHARED_16(io_muxes_u__c2p_SSP_SHARED_16),
  .c2p_SSP_SHARED_16_oen(io_muxes_u__c2p_SSP_SHARED_16_oen),
  .c2p_SSP_SHARED_17(io_muxes_u__c2p_SSP_SHARED_17),
  .c2p_SSP_SHARED_17_oen(io_muxes_u__c2p_SSP_SHARED_17_oen),
  .c2p_SSP_SHARED_18(io_muxes_u__c2p_SSP_SHARED_18),
  .c2p_SSP_SHARED_18_oen(io_muxes_u__c2p_SSP_SHARED_18_oen),
  .c2p_SSP_SHARED_19(io_muxes_u__c2p_SSP_SHARED_19),
  .c2p_SSP_SHARED_19_oen(io_muxes_u__c2p_SSP_SHARED_19_oen),
  .c2p_SSP_SHARED_2(io_muxes_u__c2p_SSP_SHARED_2),
  .c2p_SSP_SHARED_20(io_muxes_u__c2p_SSP_SHARED_20),
  .c2p_SSP_SHARED_20_oen(io_muxes_u__c2p_SSP_SHARED_20_oen),
  .c2p_SSP_SHARED_21(io_muxes_u__c2p_SSP_SHARED_21),
  .c2p_SSP_SHARED_21_oen(io_muxes_u__c2p_SSP_SHARED_21_oen),
  .c2p_SSP_SHARED_22(io_muxes_u__c2p_SSP_SHARED_22),
  .c2p_SSP_SHARED_22_oen(io_muxes_u__c2p_SSP_SHARED_22_oen),
  .c2p_SSP_SHARED_23(io_muxes_u__c2p_SSP_SHARED_23),
  .c2p_SSP_SHARED_23_oen(io_muxes_u__c2p_SSP_SHARED_23_oen),
  .c2p_SSP_SHARED_24(io_muxes_u__c2p_SSP_SHARED_24),
  .c2p_SSP_SHARED_24_oen(io_muxes_u__c2p_SSP_SHARED_24_oen),
  .c2p_SSP_SHARED_25(io_muxes_u__c2p_SSP_SHARED_25),
  .c2p_SSP_SHARED_25_oen(io_muxes_u__c2p_SSP_SHARED_25_oen),
  .c2p_SSP_SHARED_26(io_muxes_u__c2p_SSP_SHARED_26),
  .c2p_SSP_SHARED_26_oen(io_muxes_u__c2p_SSP_SHARED_26_oen),
  .c2p_SSP_SHARED_27(io_muxes_u__c2p_SSP_SHARED_27),
  .c2p_SSP_SHARED_27_oen(io_muxes_u__c2p_SSP_SHARED_27_oen),
  .c2p_SSP_SHARED_28(io_muxes_u__c2p_SSP_SHARED_28),
  .c2p_SSP_SHARED_28_oen(io_muxes_u__c2p_SSP_SHARED_28_oen),
  .c2p_SSP_SHARED_29(io_muxes_u__c2p_SSP_SHARED_29),
  .c2p_SSP_SHARED_29_oen(io_muxes_u__c2p_SSP_SHARED_29_oen),
  .c2p_SSP_SHARED_3(io_muxes_u__c2p_SSP_SHARED_3),
  .c2p_SSP_SHARED_30(io_muxes_u__c2p_SSP_SHARED_30),
  .c2p_SSP_SHARED_30_oen(io_muxes_u__c2p_SSP_SHARED_30_oen),
  .c2p_SSP_SHARED_31(io_muxes_u__c2p_SSP_SHARED_31),
  .c2p_SSP_SHARED_31_oen(io_muxes_u__c2p_SSP_SHARED_31_oen),
  .c2p_SSP_SHARED_32(io_muxes_u__c2p_SSP_SHARED_32),
  .c2p_SSP_SHARED_32_oen(io_muxes_u__c2p_SSP_SHARED_32_oen),
  .c2p_SSP_SHARED_33(io_muxes_u__c2p_SSP_SHARED_33),
  .c2p_SSP_SHARED_33_oen(io_muxes_u__c2p_SSP_SHARED_33_oen),
  .c2p_SSP_SHARED_34(io_muxes_u__c2p_SSP_SHARED_34),
  .c2p_SSP_SHARED_34_oen(io_muxes_u__c2p_SSP_SHARED_34_oen),
  .c2p_SSP_SHARED_35(io_muxes_u__c2p_SSP_SHARED_35),
  .c2p_SSP_SHARED_35_oen(io_muxes_u__c2p_SSP_SHARED_35_oen),
  .c2p_SSP_SHARED_36(io_muxes_u__c2p_SSP_SHARED_36),
  .c2p_SSP_SHARED_36_oen(io_muxes_u__c2p_SSP_SHARED_36_oen),
  .c2p_SSP_SHARED_37(io_muxes_u__c2p_SSP_SHARED_37),
  .c2p_SSP_SHARED_37_oen(io_muxes_u__c2p_SSP_SHARED_37_oen),
  .c2p_SSP_SHARED_38(io_muxes_u__c2p_SSP_SHARED_38),
  .c2p_SSP_SHARED_38_oen(io_muxes_u__c2p_SSP_SHARED_38_oen),
  .c2p_SSP_SHARED_39(io_muxes_u__c2p_SSP_SHARED_39),
  .c2p_SSP_SHARED_39_oen(io_muxes_u__c2p_SSP_SHARED_39_oen),
  .c2p_SSP_SHARED_3_oen(io_muxes_u__c2p_SSP_SHARED_3_oen),
  .c2p_SSP_SHARED_4(io_muxes_u__c2p_SSP_SHARED_4),
  .c2p_SSP_SHARED_40(io_muxes_u__c2p_SSP_SHARED_40),
  .c2p_SSP_SHARED_40_oen(io_muxes_u__c2p_SSP_SHARED_40_oen),
  .c2p_SSP_SHARED_41(io_muxes_u__c2p_SSP_SHARED_41),
  .c2p_SSP_SHARED_41_oen(io_muxes_u__c2p_SSP_SHARED_41_oen),
  .c2p_SSP_SHARED_42(io_muxes_u__c2p_SSP_SHARED_42),
  .c2p_SSP_SHARED_42_oen(io_muxes_u__c2p_SSP_SHARED_42_oen),
  .c2p_SSP_SHARED_43(io_muxes_u__c2p_SSP_SHARED_43),
  .c2p_SSP_SHARED_43_oen(io_muxes_u__c2p_SSP_SHARED_43_oen),
  .c2p_SSP_SHARED_44(io_muxes_u__c2p_SSP_SHARED_44),
  .c2p_SSP_SHARED_44_oen(io_muxes_u__c2p_SSP_SHARED_44_oen),
  .c2p_SSP_SHARED_45(io_muxes_u__c2p_SSP_SHARED_45),
  .c2p_SSP_SHARED_45_oen(io_muxes_u__c2p_SSP_SHARED_45_oen),
  .c2p_SSP_SHARED_46(io_muxes_u__c2p_SSP_SHARED_46),
  .c2p_SSP_SHARED_46_oen(io_muxes_u__c2p_SSP_SHARED_46_oen),
  .c2p_SSP_SHARED_47(io_muxes_u__c2p_SSP_SHARED_47),
  .c2p_SSP_SHARED_47_oen(io_muxes_u__c2p_SSP_SHARED_47_oen),
  .c2p_SSP_SHARED_4_oen(io_muxes_u__c2p_SSP_SHARED_4_oen),
  .c2p_SSP_SHARED_5(io_muxes_u__c2p_SSP_SHARED_5),
  .c2p_SSP_SHARED_5_oen(io_muxes_u__c2p_SSP_SHARED_5_oen),
  .c2p_SSP_SHARED_6(io_muxes_u__c2p_SSP_SHARED_6),
  .c2p_SSP_SHARED_7(io_muxes_u__c2p_SSP_SHARED_7),
  .c2p_SSP_SHARED_7_oen(io_muxes_u__c2p_SSP_SHARED_7_oen),
  .c2p_SSP_SHARED_8(io_muxes_u__c2p_SSP_SHARED_8),
  .c2p_SSP_SHARED_8_oen(io_muxes_u__c2p_SSP_SHARED_8_oen),
  .c2p_SSP_SHARED_9(io_muxes_u__c2p_SSP_SHARED_9),
  .c2p_SSP_SHARED_9_oen(io_muxes_u__c2p_SSP_SHARED_9_oen),
  .c2p_gpio_porta(io_muxes_u__c2p_gpio_porta),
  .c2p_gpio_porta_oen(io_muxes_u__c2p_gpio_porta_oen),
  .c2p_i2c1_ic_clk(io_muxes_u__c2p_i2c1_ic_clk),
  .c2p_i2c1_ic_clk_oen(io_muxes_u__c2p_i2c1_ic_clk_oen),
  .c2p_i2c1_ic_data(io_muxes_u__c2p_i2c1_ic_data),
  .c2p_i2c1_ic_data_oen(io_muxes_u__c2p_i2c1_ic_data_oen),
  .c2p_i2c2_ic_clk(io_muxes_u__c2p_i2c2_ic_clk),
  .c2p_i2c2_ic_clk_oen(io_muxes_u__c2p_i2c2_ic_clk_oen),
  .c2p_i2c2_ic_data(io_muxes_u__c2p_i2c2_ic_data),
  .c2p_i2c2_ic_data_oen(io_muxes_u__c2p_i2c2_ic_data_oen),
  .c2p_i2srxm0_sclk(io_muxes_u__c2p_i2srxm0_sclk),
  .c2p_i2srxm0_ws(io_muxes_u__c2p_i2srxm0_ws),
  .c2p_i2srxm1_sclk(io_muxes_u__c2p_i2srxm1_sclk),
  .c2p_i2srxm1_ws(io_muxes_u__c2p_i2srxm1_ws),
  .c2p_i2srxm2_sclk(io_muxes_u__c2p_i2srxm2_sclk),
  .c2p_i2srxm2_ws(io_muxes_u__c2p_i2srxm2_ws),
  .c2p_i2srxm3_sclk(io_muxes_u__c2p_i2srxm3_sclk),
  .c2p_i2srxm3_ws(io_muxes_u__c2p_i2srxm3_ws),
  .c2p_i2srxm4_sclk(io_muxes_u__c2p_i2srxm4_sclk),
  .c2p_i2srxm4_ws(io_muxes_u__c2p_i2srxm4_ws),
  .c2p_i2srxm5_sclk(io_muxes_u__c2p_i2srxm5_sclk),
  .c2p_i2srxm5_ws(io_muxes_u__c2p_i2srxm5_ws),
  .c2p_i2stxm_data(io_muxes_u__c2p_i2stxm_data),
  .c2p_i2stxm_sclk(io_muxes_u__c2p_i2stxm_sclk),
  .c2p_i2stxm_ws(io_muxes_u__c2p_i2stxm_ws),
  .c2p_scan_out(io_muxes_u__c2p_scan_out),
  .c2p_spis_txd(io_muxes_u__c2p_spis_txd),
  .c2p_sspim1_sclk_out(io_muxes_u__c2p_sspim1_sclk_out),
  .c2p_sspim1_ss(io_muxes_u__c2p_sspim1_ss),
  .c2p_sspim1_txd(io_muxes_u__c2p_sspim1_txd),
  .c2p_sspim2_sclk_out(io_muxes_u__c2p_sspim2_sclk_out),
  .c2p_sspim2_ss(io_muxes_u__c2p_sspim2_ss),
  .c2p_sspim2_txd(io_muxes_u__c2p_sspim2_txd),
  .c2p_tim_pwn(io_muxes_u__c2p_tim_pwn),
  .c2p_uart0_rts_n(io_muxes_u__c2p_uart0_rts_n),
  .c2p_uart0_sout(io_muxes_u__c2p_uart0_sout),
  .c2p_uart3_sout(io_muxes_u__c2p_uart3_sout),
  .p2c_SSP_SHARED_0(io_muxes_u__p2c_SSP_SHARED_0),
  .p2c_SSP_SHARED_10(io_muxes_u__p2c_SSP_SHARED_10),
  .p2c_SSP_SHARED_11(io_muxes_u__p2c_SSP_SHARED_11),
  .p2c_SSP_SHARED_13(io_muxes_u__p2c_SSP_SHARED_13),
  .p2c_SSP_SHARED_14(io_muxes_u__p2c_SSP_SHARED_14),
  .p2c_SSP_SHARED_15(io_muxes_u__p2c_SSP_SHARED_15),
  .p2c_SSP_SHARED_16(io_muxes_u__p2c_SSP_SHARED_16),
  .p2c_SSP_SHARED_17(io_muxes_u__p2c_SSP_SHARED_17),
  .p2c_SSP_SHARED_18(io_muxes_u__p2c_SSP_SHARED_18),
  .p2c_SSP_SHARED_19(io_muxes_u__p2c_SSP_SHARED_19),
  .p2c_SSP_SHARED_20(io_muxes_u__p2c_SSP_SHARED_20),
  .p2c_SSP_SHARED_21(io_muxes_u__p2c_SSP_SHARED_21),
  .p2c_SSP_SHARED_22(io_muxes_u__p2c_SSP_SHARED_22),
  .p2c_SSP_SHARED_23(io_muxes_u__p2c_SSP_SHARED_23),
  .p2c_SSP_SHARED_24(io_muxes_u__p2c_SSP_SHARED_24),
  .p2c_SSP_SHARED_25(io_muxes_u__p2c_SSP_SHARED_25),
  .p2c_SSP_SHARED_26(io_muxes_u__p2c_SSP_SHARED_26),
  .p2c_SSP_SHARED_27(io_muxes_u__p2c_SSP_SHARED_27),
  .p2c_SSP_SHARED_28(io_muxes_u__p2c_SSP_SHARED_28),
  .p2c_SSP_SHARED_29(io_muxes_u__p2c_SSP_SHARED_29),
  .p2c_SSP_SHARED_3(io_muxes_u__p2c_SSP_SHARED_3),
  .p2c_SSP_SHARED_30(io_muxes_u__p2c_SSP_SHARED_30),
  .p2c_SSP_SHARED_31(io_muxes_u__p2c_SSP_SHARED_31),
  .p2c_SSP_SHARED_32(io_muxes_u__p2c_SSP_SHARED_32),
  .p2c_SSP_SHARED_33(io_muxes_u__p2c_SSP_SHARED_33),
  .p2c_SSP_SHARED_34(io_muxes_u__p2c_SSP_SHARED_34),
  .p2c_SSP_SHARED_35(io_muxes_u__p2c_SSP_SHARED_35),
  .p2c_SSP_SHARED_36(io_muxes_u__p2c_SSP_SHARED_36),
  .p2c_SSP_SHARED_37(io_muxes_u__p2c_SSP_SHARED_37),
  .p2c_SSP_SHARED_38(io_muxes_u__p2c_SSP_SHARED_38),
  .p2c_SSP_SHARED_39(io_muxes_u__p2c_SSP_SHARED_39),
  .p2c_SSP_SHARED_4(io_muxes_u__p2c_SSP_SHARED_4),
  .p2c_SSP_SHARED_40(io_muxes_u__p2c_SSP_SHARED_40),
  .p2c_SSP_SHARED_41(io_muxes_u__p2c_SSP_SHARED_41),
  .p2c_SSP_SHARED_42(io_muxes_u__p2c_SSP_SHARED_42),
  .p2c_SSP_SHARED_43(io_muxes_u__p2c_SSP_SHARED_43),
  .p2c_SSP_SHARED_44(io_muxes_u__p2c_SSP_SHARED_44),
  .p2c_SSP_SHARED_45(io_muxes_u__p2c_SSP_SHARED_45),
  .p2c_SSP_SHARED_46(io_muxes_u__p2c_SSP_SHARED_46),
  .p2c_SSP_SHARED_47(io_muxes_u__p2c_SSP_SHARED_47),
  .p2c_SSP_SHARED_5(io_muxes_u__p2c_SSP_SHARED_5),
  .p2c_SSP_SHARED_7(io_muxes_u__p2c_SSP_SHARED_7),
  .p2c_SSP_SHARED_8(io_muxes_u__p2c_SSP_SHARED_8),
  .p2c_SSP_SHARED_9(io_muxes_u__p2c_SSP_SHARED_9),
  .p2c_boot_mode(io_muxes_u__p2c_boot_mode),
  .p2c_gpio_porta(io_muxes_u__p2c_gpio_porta),
  .p2c_i2c1_ic_clk(io_muxes_u__p2c_i2c1_ic_clk),
  .p2c_i2c1_ic_data(io_muxes_u__p2c_i2c1_ic_data),
  .p2c_i2c2_ic_clk(io_muxes_u__p2c_i2c2_ic_clk),
  .p2c_i2c2_ic_data(io_muxes_u__p2c_i2c2_ic_data),
  .p2c_i2srxm0_data(io_muxes_u__p2c_i2srxm0_data),
  .p2c_i2srxm1_data(io_muxes_u__p2c_i2srxm1_data),
  .p2c_i2srxm2_data(io_muxes_u__p2c_i2srxm2_data),
  .p2c_i2srxm3_data(io_muxes_u__p2c_i2srxm3_data),
  .p2c_i2srxm4_data(io_muxes_u__p2c_i2srxm4_data),
  .p2c_i2srxm5_data(io_muxes_u__p2c_i2srxm5_data),
  .p2c_scan_enable(io_muxes_u__p2c_scan_enable),
  .p2c_scan_in(io_muxes_u__p2c_scan_in),
  .p2c_scan_reset(io_muxes_u__p2c_scan_reset),
  .p2c_scan_test_modes(io_muxes_u__p2c_scan_test_modes),
  .p2c_spis_rxd(io_muxes_u__p2c_spis_rxd),
  .p2c_spis_sclk_in(io_muxes_u__p2c_spis_sclk_in),
  .p2c_spis_ss(io_muxes_u__p2c_spis_ss),
  .p2c_sspim1_rxd(io_muxes_u__p2c_sspim1_rxd),
  .p2c_sspim2_rxd(io_muxes_u__p2c_sspim2_rxd),
  .p2c_uart0_cts_n(io_muxes_u__p2c_uart0_cts_n),
  .p2c_uart0_sin(io_muxes_u__p2c_uart0_sin),
  .p2c_uart3_sin(io_muxes_u__p2c_uart3_sin),
  .test_mode(io_muxes_u__test_mode)
);

jtag_wrapper jtag_wrapper_u(
  .aclk(jtag_wrapper_u__aclk),
  .or_req_ar(jtag_wrapper_u__or_req_ar),
  .or_req_arready(jtag_wrapper_u__or_req_arready),
  .or_req_arvalid(jtag_wrapper_u__or_req_arvalid),
  .or_req_aw(jtag_wrapper_u__or_req_aw),
  .or_req_awready(jtag_wrapper_u__or_req_awready),
  .or_req_awvalid(jtag_wrapper_u__or_req_awvalid),
  .or_req_w(jtag_wrapper_u__or_req_w),
  .or_req_wready(jtag_wrapper_u__or_req_wready),
  .or_req_wvalid(jtag_wrapper_u__or_req_wvalid),
  .or_rsp_b(jtag_wrapper_u__or_rsp_b),
  .or_rsp_bready(jtag_wrapper_u__or_rsp_bready),
  .or_rsp_bvalid(jtag_wrapper_u__or_rsp_bvalid),
  .or_rsp_r(jtag_wrapper_u__or_rsp_r),
  .or_rsp_rready(jtag_wrapper_u__or_rsp_rready),
  .or_rsp_rvalid(jtag_wrapper_u__or_rsp_rvalid),
  .reset(jtag_wrapper_u__reset),
  .rstblk_out(jtag_wrapper_u__rstblk_out)
);

IOBUF qspim_sclk_out_pad_0(
  .I(qspim_sclk_out_pad_0__I),
  .IO(p2t_qspim_sclk_out),
  .O(qspim_sclk_out_pad_0__O),
  .T(qspim_sclk_out_pad_0__T)
);

IOBUF qspim_ss_pad_0(
  .I(qspim_ss_pad_0__I),
  .IO(p2t_qspim_ss),
  .O(qspim_ss_pad_0__O),
  .T(qspim_ss_pad_0__T)
);

IOBUF qspim_trxd_pad_0(
  .I(qspim_trxd_pad_0__I),
  .IO(tbp_qspim_trxd_0),
  .O(qspim_trxd_pad_0__O),
  .T(qspim_trxd_pad_0__T)
);

IOBUF qspim_trxd_pad_1(
  .I(qspim_trxd_pad_1__I),
  .IO(tbp_qspim_trxd_1),
  .O(qspim_trxd_pad_1__O),
  .T(qspim_trxd_pad_1__T)
);

IOBUF qspim_trxd_pad_2(
  .I(qspim_trxd_pad_2__I),
  .IO(tbp_qspim_trxd_2),
  .O(qspim_trxd_pad_2__O),
  .T(qspim_trxd_pad_2__T)
);

IOBUF qspim_trxd_pad_3(
  .I(qspim_trxd_pad_3__I),
  .IO(tbp_qspim_trxd_3),
  .O(qspim_trxd_pad_3__O),
  .T(qspim_trxd_pad_3__T)
);

IOBUF sd_card_detect_n_pad_0(
  .I(sd_card_detect_n_pad_0__I),
  .IO(t2p_sd_card_detect_n),
  .O(sd_card_detect_n_pad_0__O),
  .T(sd_card_detect_n_pad_0__T)
);

IOBUF sd_card_write_prot_pad_0(
  .I(sd_card_write_prot_pad_0__I),
  .IO(t2p_sd_card_write_prot),
  .O(sd_card_write_prot_pad_0__O),
  .T(sd_card_write_prot_pad_0__T)
);

IOBUF sd_clk_pad_0(
  .I(sd_clk_pad_0__I),
  .IO(tbp_sd_clk),
  .O(sd_clk_pad_0__O),
  .T(sd_clk_pad_0__T)
);

IOBUF sd_cmd_in_out_pad_0(
  .I(sd_cmd_in_out_pad_0__I),
  .IO(tbp_sd_cmd_in_out),
  .O(sd_cmd_in_out_pad_0__O),
  .T(sd_cmd_in_out_pad_0__T)
);

inv sd_cmd_oen_inv_u(
  .in(sd_cmd_oen_inv_u__in),
  .out(sd_cmd_oen_inv_u__out)
);

IOBUF sd_dat_in_out_pad_0(
  .I(sd_dat_in_out_pad_0__I),
  .IO(tbp_sd_dat_in_out_0),
  .O(sd_dat_in_out_pad_0__O),
  .T(sd_dat_in_out_pad_0__T)
);

IOBUF sd_dat_in_out_pad_1(
  .I(sd_dat_in_out_pad_1__I),
  .IO(tbp_sd_dat_in_out_1),
  .O(sd_dat_in_out_pad_1__O),
  .T(sd_dat_in_out_pad_1__T)
);

IOBUF sd_dat_in_out_pad_2(
  .I(sd_dat_in_out_pad_2__I),
  .IO(tbp_sd_dat_in_out_2),
  .O(sd_dat_in_out_pad_2__O),
  .T(sd_dat_in_out_pad_2__T)
);

IOBUF sd_dat_in_out_pad_3(
  .I(sd_dat_in_out_pad_3__I),
  .IO(tbp_sd_dat_in_out_3),
  .O(sd_dat_in_out_pad_3__O),
  .T(sd_dat_in_out_pad_3__T)
);

inv #(.WIDTH(4)) sd_dat_oen_inv_u(
  .in(sd_dat_oen_inv_u__in),
  .out(sd_dat_oen_inv_u__out)
);

soc_top soc_top_u(
  .B0_pll_out(soc_top_u__B0_pll_out),
  .B10_pll_out(soc_top_u__B10_pll_out),
  .B11_pll_out(soc_top_u__B11_pll_out),
  .B12_pll_out(soc_top_u__B12_pll_out),
  .B13_pll_out(soc_top_u__B13_pll_out),
  .B14_pll_out(soc_top_u__B14_pll_out),
  .B15_pll_out(soc_top_u__B15_pll_out),
  .B16_pll_out(soc_top_u__B16_pll_out),
  .B17_pll_out(soc_top_u__B17_pll_out),
  .B18_pll_out(soc_top_u__B18_pll_out),
  .B19_pll_out(soc_top_u__B19_pll_out),
  .B1_ddr_pwr_ok_in(soc_top_u__B1_ddr_pwr_ok_in),
  .B1_pll_out(soc_top_u__B1_pll_out),
  .B20_pll_out(soc_top_u__B20_pll_out),
  .B21_pll_out(soc_top_u__B21_pll_out),
  .B22_pll_out(soc_top_u__B22_pll_out),
  .B23_pll_out(soc_top_u__B23_pll_out),
  .B24_pll_out(soc_top_u__B24_pll_out),
  .B2_pll_out(soc_top_u__B2_pll_out),
  .B3_dft_mbist_mode(soc_top_u__B3_dft_mbist_mode),
  .B3_pll_out(soc_top_u__B3_pll_out),
  .B4_pll_out(soc_top_u__B4_pll_out),
  .B5_pll_out(soc_top_u__B5_pll_out),
  .B6_pll_out(soc_top_u__B6_pll_out),
  .B7_pll_out(soc_top_u__B7_pll_out),
  .B8_pll_out(soc_top_u__B8_pll_out),
  .B9_pll_out(soc_top_u__B9_pll_out),
  .BP_A(soc_top_u__BP_A),
  .BP_ALERT_N(soc_top_u__BP_ALERT_N),
  .BP_D(soc_top_u__BP_D),
  .BP_DM0(soc_top_u__BP_DM0),
  .BP_DP0(soc_top_u__BP_DP0),
  .BP_ID0(soc_top_u__BP_ID0),
  .BP_MEMRESET_L(soc_top_u__BP_MEMRESET_L),
  .BP_VBUS0(soc_top_u__BP_VBUS0),
  .BP_VREF(soc_top_u__BP_VREF),
  .BP_ZN(soc_top_u__BP_ZN),
  .BP_ZN_SENSE(soc_top_u__BP_ZN_SENSE),
  .BP_resref(soc_top_u__BP_resref),
  .BypassInDataAC(soc_top_u__BypassInDataAC),
  .BypassInDataDAT(soc_top_u__BypassInDataDAT),
  .BypassInDataMASTER(soc_top_u__BypassInDataMASTER),
  .BypassModeEnAC(soc_top_u__BypassModeEnAC),
  .BypassModeEnDAT(soc_top_u__BypassModeEnDAT),
  .BypassModeEnMASTER(soc_top_u__BypassModeEnMASTER),
  .BypassOutDataAC(soc_top_u__BypassOutDataAC),
  .BypassOutDataDAT(soc_top_u__BypassOutDataDAT),
  .BypassOutDataMASTER(soc_top_u__BypassOutDataMASTER),
  .BypassOutEnAC(soc_top_u__BypassOutEnAC),
  .BypassOutEnDAT(soc_top_u__BypassOutEnDAT),
  .BypassOutEnMASTER(soc_top_u__BypassOutEnMASTER),
  .C25_usb_pwrdown_ssp(soc_top_u__C25_usb_pwrdown_ssp),
  .C26_usb_pwrdown_hsp(soc_top_u__C26_usb_pwrdown_hsp),
  .C27_usb_ref_ssp_en(soc_top_u__C27_usb_ref_ssp_en),
  .C28_usb_ref_use_pad(soc_top_u__C28_usb_ref_use_pad),
  .DIN_DONE(soc_top_u__DIN_DONE),
  .DIN_ERROR_LOG_HI(soc_top_u__DIN_ERROR_LOG_HI),
  .DIN_ERROR_LOG_LO(soc_top_u__DIN_ERROR_LOG_LO),
  .FUNC_CLK(soc_top_u__FUNC_CLK),
  .FUNC_EN_CUS_MBIST(soc_top_u__FUNC_EN_CUS_MBIST),
  .ana_bscan_sel(soc_top_u__ana_bscan_sel),
  .boot_from_flash_mode(soc_top_u__boot_from_flash_mode),
  .boot_fsm_mode(soc_top_u__boot_fsm_mode),
  .c2p_SSP_SHARED_sel_0(soc_top_u__c2p_SSP_SHARED_sel_0),
  .c2p_SSP_SHARED_sel_1(soc_top_u__c2p_SSP_SHARED_sel_1),
  .c2p_SSP_SHARED_sel_10(soc_top_u__c2p_SSP_SHARED_sel_10),
  .c2p_SSP_SHARED_sel_11(soc_top_u__c2p_SSP_SHARED_sel_11),
  .c2p_SSP_SHARED_sel_12(soc_top_u__c2p_SSP_SHARED_sel_12),
  .c2p_SSP_SHARED_sel_13(soc_top_u__c2p_SSP_SHARED_sel_13),
  .c2p_SSP_SHARED_sel_14(soc_top_u__c2p_SSP_SHARED_sel_14),
  .c2p_SSP_SHARED_sel_15(soc_top_u__c2p_SSP_SHARED_sel_15),
  .c2p_SSP_SHARED_sel_16(soc_top_u__c2p_SSP_SHARED_sel_16),
  .c2p_SSP_SHARED_sel_17(soc_top_u__c2p_SSP_SHARED_sel_17),
  .c2p_SSP_SHARED_sel_18(soc_top_u__c2p_SSP_SHARED_sel_18),
  .c2p_SSP_SHARED_sel_19(soc_top_u__c2p_SSP_SHARED_sel_19),
  .c2p_SSP_SHARED_sel_2(soc_top_u__c2p_SSP_SHARED_sel_2),
  .c2p_SSP_SHARED_sel_20(soc_top_u__c2p_SSP_SHARED_sel_20),
  .c2p_SSP_SHARED_sel_21(soc_top_u__c2p_SSP_SHARED_sel_21),
  .c2p_SSP_SHARED_sel_22(soc_top_u__c2p_SSP_SHARED_sel_22),
  .c2p_SSP_SHARED_sel_23(soc_top_u__c2p_SSP_SHARED_sel_23),
  .c2p_SSP_SHARED_sel_24(soc_top_u__c2p_SSP_SHARED_sel_24),
  .c2p_SSP_SHARED_sel_25(soc_top_u__c2p_SSP_SHARED_sel_25),
  .c2p_SSP_SHARED_sel_26(soc_top_u__c2p_SSP_SHARED_sel_26),
  .c2p_SSP_SHARED_sel_27(soc_top_u__c2p_SSP_SHARED_sel_27),
  .c2p_SSP_SHARED_sel_28(soc_top_u__c2p_SSP_SHARED_sel_28),
  .c2p_SSP_SHARED_sel_29(soc_top_u__c2p_SSP_SHARED_sel_29),
  .c2p_SSP_SHARED_sel_3(soc_top_u__c2p_SSP_SHARED_sel_3),
  .c2p_SSP_SHARED_sel_30(soc_top_u__c2p_SSP_SHARED_sel_30),
  .c2p_SSP_SHARED_sel_31(soc_top_u__c2p_SSP_SHARED_sel_31),
  .c2p_SSP_SHARED_sel_32(soc_top_u__c2p_SSP_SHARED_sel_32),
  .c2p_SSP_SHARED_sel_33(soc_top_u__c2p_SSP_SHARED_sel_33),
  .c2p_SSP_SHARED_sel_34(soc_top_u__c2p_SSP_SHARED_sel_34),
  .c2p_SSP_SHARED_sel_35(soc_top_u__c2p_SSP_SHARED_sel_35),
  .c2p_SSP_SHARED_sel_36(soc_top_u__c2p_SSP_SHARED_sel_36),
  .c2p_SSP_SHARED_sel_37(soc_top_u__c2p_SSP_SHARED_sel_37),
  .c2p_SSP_SHARED_sel_38(soc_top_u__c2p_SSP_SHARED_sel_38),
  .c2p_SSP_SHARED_sel_39(soc_top_u__c2p_SSP_SHARED_sel_39),
  .c2p_SSP_SHARED_sel_4(soc_top_u__c2p_SSP_SHARED_sel_4),
  .c2p_SSP_SHARED_sel_40(soc_top_u__c2p_SSP_SHARED_sel_40),
  .c2p_SSP_SHARED_sel_41(soc_top_u__c2p_SSP_SHARED_sel_41),
  .c2p_SSP_SHARED_sel_42(soc_top_u__c2p_SSP_SHARED_sel_42),
  .c2p_SSP_SHARED_sel_43(soc_top_u__c2p_SSP_SHARED_sel_43),
  .c2p_SSP_SHARED_sel_44(soc_top_u__c2p_SSP_SHARED_sel_44),
  .c2p_SSP_SHARED_sel_45(soc_top_u__c2p_SSP_SHARED_sel_45),
  .c2p_SSP_SHARED_sel_46(soc_top_u__c2p_SSP_SHARED_sel_46),
  .c2p_SSP_SHARED_sel_47(soc_top_u__c2p_SSP_SHARED_sel_47),
  .c2p_SSP_SHARED_sel_5(soc_top_u__c2p_SSP_SHARED_sel_5),
  .c2p_SSP_SHARED_sel_6(soc_top_u__c2p_SSP_SHARED_sel_6),
  .c2p_SSP_SHARED_sel_7(soc_top_u__c2p_SSP_SHARED_sel_7),
  .c2p_SSP_SHARED_sel_8(soc_top_u__c2p_SSP_SHARED_sel_8),
  .c2p_SSP_SHARED_sel_9(soc_top_u__c2p_SSP_SHARED_sel_9),
  .c2p_gpio_porta_ddr(soc_top_u__c2p_gpio_porta_ddr),
  .c2p_gpio_porta_dr(soc_top_u__c2p_gpio_porta_dr),
  .c2p_i2c0_ic_clk_oen(soc_top_u__c2p_i2c0_ic_clk_oen),
  .c2p_i2c0_ic_data_oen(soc_top_u__c2p_i2c0_ic_data_oen),
  .c2p_i2c1_ic_clk_oen(soc_top_u__c2p_i2c1_ic_clk_oen),
  .c2p_i2c1_ic_data_oen(soc_top_u__c2p_i2c1_ic_data_oen),
  .c2p_i2c2_ic_clk_oen(soc_top_u__c2p_i2c2_ic_clk_oen),
  .c2p_i2c2_ic_data_oen(soc_top_u__c2p_i2c2_ic_data_oen),
  .c2p_i2sm_sclk(soc_top_u__c2p_i2sm_sclk),
  .c2p_i2sm_sdo0(soc_top_u__c2p_i2sm_sdo0),
  .c2p_i2sm_sdo1(soc_top_u__c2p_i2sm_sdo1),
  .c2p_i2sm_sdo2(soc_top_u__c2p_i2sm_sdo2),
  .c2p_i2sm_sdo3(soc_top_u__c2p_i2sm_sdo3),
  .c2p_i2sm_ws_out(soc_top_u__c2p_i2sm_ws_out),
  .c2p_i2ss0_sclk(soc_top_u__c2p_i2ss0_sclk),
  .c2p_i2ss0_ws_out(soc_top_u__c2p_i2ss0_ws_out),
  .c2p_i2ss1_sclk(soc_top_u__c2p_i2ss1_sclk),
  .c2p_i2ss1_ws_out(soc_top_u__c2p_i2ss1_ws_out),
  .c2p_i2ss2_sclk(soc_top_u__c2p_i2ss2_sclk),
  .c2p_i2ss2_ws_out(soc_top_u__c2p_i2ss2_ws_out),
  .c2p_i2ss3_sclk(soc_top_u__c2p_i2ss3_sclk),
  .c2p_i2ss3_ws_out(soc_top_u__c2p_i2ss3_ws_out),
  .c2p_i2ss4_sclk(soc_top_u__c2p_i2ss4_sclk),
  .c2p_i2ss4_ws_out(soc_top_u__c2p_i2ss4_ws_out),
  .c2p_i2ss5_sclk(soc_top_u__c2p_i2ss5_sclk),
  .c2p_i2ss5_ws_out(soc_top_u__c2p_i2ss5_ws_out),
  .c2p_jtag_tdo(soc_top_u__c2p_jtag_tdo),
  .c2p_jtag_tdo_oen(soc_top_u__c2p_jtag_tdo_oen),
  .c2p_qspim_clk(soc_top_u__c2p_qspim_clk),
  .c2p_qspim_cs_n(soc_top_u__c2p_qspim_cs_n),
  .c2p_qspim_io_oen(soc_top_u__c2p_qspim_io_oen),
  .c2p_qspim_o(soc_top_u__c2p_qspim_o),
  .c2p_scan_f_out(soc_top_u__c2p_scan_f_out),
  .c2p_scan_out(soc_top_u__c2p_scan_out),
  .c2p_spis_o(soc_top_u__c2p_spis_o),
  .c2p_sspim0_clk(soc_top_u__c2p_sspim0_clk),
  .c2p_sspim0_cs_n(soc_top_u__c2p_sspim0_cs_n),
  .c2p_sspim0_o(soc_top_u__c2p_sspim0_o),
  .c2p_sspim1_clk(soc_top_u__c2p_sspim1_clk),
  .c2p_sspim1_cs_n(soc_top_u__c2p_sspim1_cs_n),
  .c2p_sspim1_o(soc_top_u__c2p_sspim1_o),
  .c2p_sspim2_clk(soc_top_u__c2p_sspim2_clk),
  .c2p_sspim2_cs_n(soc_top_u__c2p_sspim2_cs_n),
  .c2p_sspim2_o(soc_top_u__c2p_sspim2_o),
  .c2p_test_io_clk(soc_top_u__c2p_test_io_clk),
  .c2p_test_io_clk_oen(soc_top_u__c2p_test_io_clk_oen),
  .c2p_test_io_data(soc_top_u__c2p_test_io_data),
  .c2p_test_io_data_oen(soc_top_u__c2p_test_io_data_oen),
  .c2p_test_io_en(soc_top_u__c2p_test_io_en),
  .c2p_test_io_en_oen(soc_top_u__c2p_test_io_en_oen),
  .c2p_timer_1_toggle(soc_top_u__c2p_timer_1_toggle),
  .c2p_timer_2_toggle(soc_top_u__c2p_timer_2_toggle),
  .c2p_timer_3_toggle(soc_top_u__c2p_timer_3_toggle),
  .c2p_timer_4_toggle(soc_top_u__c2p_timer_4_toggle),
  .c2p_timer_5_toggle(soc_top_u__c2p_timer_5_toggle),
  .c2p_timer_6_toggle(soc_top_u__c2p_timer_6_toggle),
  .c2p_timer_7_toggle(soc_top_u__c2p_timer_7_toggle),
  .c2p_timer_8_toggle(soc_top_u__c2p_timer_8_toggle),
  .c2p_uart0_rts_n(soc_top_u__c2p_uart0_rts_n),
  .c2p_uart0_sout(soc_top_u__c2p_uart0_sout),
  .c2p_uart1_sout(soc_top_u__c2p_uart1_sout),
  .c2p_uart2_sout(soc_top_u__c2p_uart2_sout),
  .c2p_uart3_sout(soc_top_u__c2p_uart3_sout),
  .card_detect_n(soc_top_u__card_detect_n),
  .card_write_prot(soc_top_u__card_write_prot),
  .cclk_rx(soc_top_u__cclk_rx),
  .cmd_vld_in(soc_top_u__cmd_vld_in),
  .cmdbuf_in(soc_top_u__cmdbuf_in),
  .dft_glue_u_tck_invert_in(soc_top_u__dft_glue_u_tck_invert_in),
  .gated_tx_clk_out(soc_top_u__gated_tx_clk_out),
  .global_scan_enable(soc_top_u__global_scan_enable),
  .io_test_mode(soc_top_u__io_test_mode),
  .jtag_tdi_to_usb(soc_top_u__jtag_tdi_to_usb),
  .jtag_tdo_en_from_usb(soc_top_u__jtag_tdo_en_from_usb),
  .jtag_tdo_from_usb(soc_top_u__jtag_tdo_from_usb),
  .jtag_tms_to_usb(soc_top_u__jtag_tms_to_usb),
  .jtag_trst_n_to_usb(soc_top_u__jtag_trst_n_to_usb),
  .mem_noc_req_if_ar(soc_top_u__mem_noc_req_if_ar),
  .mem_noc_req_if_arready(soc_top_u__mem_noc_req_if_arready),
  .mem_noc_req_if_arvalid(soc_top_u__mem_noc_req_if_arvalid),
  .mem_noc_req_if_aw(soc_top_u__mem_noc_req_if_aw),
  .mem_noc_req_if_awready(soc_top_u__mem_noc_req_if_awready),
  .mem_noc_req_if_awvalid(soc_top_u__mem_noc_req_if_awvalid),
  .mem_noc_req_if_w(soc_top_u__mem_noc_req_if_w),
  .mem_noc_req_if_wready(soc_top_u__mem_noc_req_if_wready),
  .mem_noc_req_if_wvalid(soc_top_u__mem_noc_req_if_wvalid),
  .mem_noc_resp_if_b(soc_top_u__mem_noc_resp_if_b),
  .mem_noc_resp_if_bready(soc_top_u__mem_noc_resp_if_bready),
  .mem_noc_resp_if_bvalid(soc_top_u__mem_noc_resp_if_bvalid),
  .mem_noc_resp_if_r(soc_top_u__mem_noc_resp_if_r),
  .mem_noc_resp_if_rready(soc_top_u__mem_noc_resp_if_rready),
  .mem_noc_resp_if_rvalid(soc_top_u__mem_noc_resp_if_rvalid),
  .or_req_if_ar(soc_top_u__or_req_if_ar),
  .or_req_if_arready(soc_top_u__or_req_if_arready),
  .or_req_if_arvalid(soc_top_u__or_req_if_arvalid),
  .or_req_if_aw(soc_top_u__or_req_if_aw),
  .or_req_if_awready(soc_top_u__or_req_if_awready),
  .or_req_if_awvalid(soc_top_u__or_req_if_awvalid),
  .or_req_if_w(soc_top_u__or_req_if_w),
  .or_req_if_wready(soc_top_u__or_req_if_wready),
  .or_req_if_wvalid(soc_top_u__or_req_if_wvalid),
  .or_resp_if_b(soc_top_u__or_resp_if_b),
  .or_resp_if_bready(soc_top_u__or_resp_if_bready),
  .or_resp_if_bvalid(soc_top_u__or_resp_if_bvalid),
  .or_resp_if_r(soc_top_u__or_resp_if_r),
  .or_resp_if_rready(soc_top_u__or_resp_if_rready),
  .or_resp_if_rvalid(soc_top_u__or_resp_if_rvalid),
  .p2c_chip_wake_up(soc_top_u__p2c_chip_wake_up),
  .p2c_gpio_ext_porta(soc_top_u__p2c_gpio_ext_porta),
  .p2c_i2c0_ic_clk_in_a(soc_top_u__p2c_i2c0_ic_clk_in_a),
  .p2c_i2c0_ic_data_in_a(soc_top_u__p2c_i2c0_ic_data_in_a),
  .p2c_i2c1_ic_clk_in_a(soc_top_u__p2c_i2c1_ic_clk_in_a),
  .p2c_i2c1_ic_data_in_a(soc_top_u__p2c_i2c1_ic_data_in_a),
  .p2c_i2c2_ic_clk_in_a(soc_top_u__p2c_i2c2_ic_clk_in_a),
  .p2c_i2c2_ic_data_in_a(soc_top_u__p2c_i2c2_ic_data_in_a),
  .p2c_i2ss0_sdi0(soc_top_u__p2c_i2ss0_sdi0),
  .p2c_i2ss0_sdi1(soc_top_u__p2c_i2ss0_sdi1),
  .p2c_i2ss0_sdi2(soc_top_u__p2c_i2ss0_sdi2),
  .p2c_i2ss0_sdi3(soc_top_u__p2c_i2ss0_sdi3),
  .p2c_i2ss1_sdi0(soc_top_u__p2c_i2ss1_sdi0),
  .p2c_i2ss1_sdi1(soc_top_u__p2c_i2ss1_sdi1),
  .p2c_i2ss1_sdi2(soc_top_u__p2c_i2ss1_sdi2),
  .p2c_i2ss1_sdi3(soc_top_u__p2c_i2ss1_sdi3),
  .p2c_i2ss2_sdi0(soc_top_u__p2c_i2ss2_sdi0),
  .p2c_i2ss2_sdi1(soc_top_u__p2c_i2ss2_sdi1),
  .p2c_i2ss2_sdi2(soc_top_u__p2c_i2ss2_sdi2),
  .p2c_i2ss2_sdi3(soc_top_u__p2c_i2ss2_sdi3),
  .p2c_i2ss3_sdi0(soc_top_u__p2c_i2ss3_sdi0),
  .p2c_i2ss3_sdi1(soc_top_u__p2c_i2ss3_sdi1),
  .p2c_i2ss3_sdi2(soc_top_u__p2c_i2ss3_sdi2),
  .p2c_i2ss3_sdi3(soc_top_u__p2c_i2ss3_sdi3),
  .p2c_i2ss4_sdi0(soc_top_u__p2c_i2ss4_sdi0),
  .p2c_i2ss4_sdi1(soc_top_u__p2c_i2ss4_sdi1),
  .p2c_i2ss4_sdi2(soc_top_u__p2c_i2ss4_sdi2),
  .p2c_i2ss4_sdi3(soc_top_u__p2c_i2ss4_sdi3),
  .p2c_i2ss5_sdi0(soc_top_u__p2c_i2ss5_sdi0),
  .p2c_i2ss5_sdi1(soc_top_u__p2c_i2ss5_sdi1),
  .p2c_i2ss5_sdi2(soc_top_u__p2c_i2ss5_sdi2),
  .p2c_i2ss5_sdi3(soc_top_u__p2c_i2ss5_sdi3),
  .p2c_jtag_tck(soc_top_u__p2c_jtag_tck),
  .p2c_jtag_tdi(soc_top_u__p2c_jtag_tdi),
  .p2c_jtag_tms(soc_top_u__p2c_jtag_tms),
  .p2c_jtag_trst_n(soc_top_u__p2c_jtag_trst_n),
  .p2c_qspim_i(soc_top_u__p2c_qspim_i),
  .p2c_refclk(soc_top_u__p2c_refclk),
  .p2c_resetn(soc_top_u__p2c_resetn),
  .p2c_rtcclk(soc_top_u__p2c_rtcclk),
  .p2c_scan_ate_clk(soc_top_u__p2c_scan_ate_clk),
  .p2c_scan_enable(soc_top_u__p2c_scan_enable),
  .p2c_scan_f_clk(soc_top_u__p2c_scan_f_clk),
  .p2c_scan_f_in(soc_top_u__p2c_scan_f_in),
  .p2c_scan_f_mode(soc_top_u__p2c_scan_f_mode),
  .p2c_scan_f_reset(soc_top_u__p2c_scan_f_reset),
  .p2c_scan_in(soc_top_u__p2c_scan_in),
  .p2c_scan_mode(soc_top_u__p2c_scan_mode),
  .p2c_scan_reset(soc_top_u__p2c_scan_reset),
  .p2c_scan_tap_compliance(soc_top_u__p2c_scan_tap_compliance),
  .p2c_scan_test_modes(soc_top_u__p2c_scan_test_modes),
  .p2c_spis_clk(soc_top_u__p2c_spis_clk),
  .p2c_spis_cs_n(soc_top_u__p2c_spis_cs_n),
  .p2c_spis_i(soc_top_u__p2c_spis_i),
  .p2c_sspim0_i(soc_top_u__p2c_sspim0_i),
  .p2c_sspim1_i(soc_top_u__p2c_sspim1_i),
  .p2c_sspim2_i(soc_top_u__p2c_sspim2_i),
  .p2c_test_io_clk(soc_top_u__p2c_test_io_clk),
  .p2c_test_io_data(soc_top_u__p2c_test_io_data),
  .p2c_test_io_en(soc_top_u__p2c_test_io_en),
  .p2c_uart0_cts_n(soc_top_u__p2c_uart0_cts_n),
  .p2c_uart0_sin(soc_top_u__p2c_uart0_sin),
  .p2c_uart1_sin(soc_top_u__p2c_uart1_sin),
  .p2c_uart2_sin(soc_top_u__p2c_uart2_sin),
  .p2c_uart3_sin(soc_top_u__p2c_uart3_sin),
  .pygmy_es1y_ac_init_clk_in(soc_top_u__pygmy_es1y_ac_init_clk_in),
  .pygmy_es1y_ac_mode_in(soc_top_u__pygmy_es1y_ac_mode_in),
  .pygmy_es1y_ac_test_in(soc_top_u__pygmy_es1y_ac_test_in),
  .pygmy_es1y_pygmy_es1y_CLAMP___in(soc_top_u__pygmy_es1y_pygmy_es1y_CLAMP___in),
  .pygmy_es1y_pygmy_es1y_EXTEST_PULSE__EXTEST_TRAIN___in(soc_top_u__pygmy_es1y_pygmy_es1y_EXTEST_PULSE__EXTEST_TRAIN___in),
  .pygmy_es1y_pygmy_es1y_EXTEST__INTEST___in(soc_top_u__pygmy_es1y_pygmy_es1y_EXTEST__INTEST___in),
  .pygmy_es1y_pygmy_es1y_HIGHZ__RUNBIST___in(soc_top_u__pygmy_es1y_pygmy_es1y_HIGHZ__RUNBIST___in),
  .pygmy_es1y_pygmy_es1y_PRELOAD__SAMPLE___in(soc_top_u__pygmy_es1y_pygmy_es1y_PRELOAD__SAMPLE___in),
  .pygmy_es1y_pygmy_es1y_capture_dr_1_in(soc_top_u__pygmy_es1y_pygmy_es1y_capture_dr_1_in),
  .pygmy_es1y_pygmy_es1y_one_in(soc_top_u__pygmy_es1y_pygmy_es1y_one_in),
  .pygmy_es1y_pygmy_es1y_shift_dr_13_in(soc_top_u__pygmy_es1y_pygmy_es1y_shift_dr_13_in),
  .pygmy_es1y_pygmy_es1y_update_dr_1_in(soc_top_u__pygmy_es1y_pygmy_es1y_update_dr_1_in),
  .pygmy_es1y_pygmy_es1y_zero_in(soc_top_u__pygmy_es1y_pygmy_es1y_zero_in),
  .pygmy_es1y_pygmy_es1y_zero_ina(soc_top_u__pygmy_es1y_pygmy_es1y_zero_ina),
  .pygmy_es1y_shift_dr_in(soc_top_u__pygmy_es1y_shift_dr_in),
  .pygmy_es1y_soc_top_u_si_in(soc_top_u__pygmy_es1y_soc_top_u_si_in),
  .rdata_out(soc_top_u__rdata_out),
  .rdata_vld_out(soc_top_u__rdata_vld_out),
  .ref_pad_clk_m(soc_top_u__ref_pad_clk_m),
  .ref_pad_clk_p(soc_top_u__ref_pad_clk_p),
  .rx0_m(soc_top_u__rx0_m),
  .rx0_p(soc_top_u__rx0_p),
  .sd_cmd_in(soc_top_u__sd_cmd_in),
  .sd_cmd_out(soc_top_u__sd_cmd_out),
  .sd_cmd_out_en(soc_top_u__sd_cmd_out_en),
  .sd_dat_in(soc_top_u__sd_dat_in),
  .sd_dat_out(soc_top_u__sd_dat_out),
  .sd_dat_out_en(soc_top_u__sd_dat_out_en),
  .soc_top_u_out(soc_top_u__soc_top_u_out),
  .tx0_m(soc_top_u__tx0_m),
  .tx0_p(soc_top_u__tx0_p),
  .usb_icg_ten(soc_top_u__usb_icg_ten),
  .usb_jtag_tck_gated(soc_top_u__usb_jtag_tck_gated),
  .vcore_icg_ten(soc_top_u__vcore_icg_ten)
);

IOBUF sspim0_rxd_pad_0(
  .I(sspim0_rxd_pad_0__I),
  .IO(t2p_sspim0_rxd),
  .O(sspim0_rxd_pad_0__O),
  .T(sspim0_rxd_pad_0__T)
);

IOBUF sspim0_sclk_out_pad_0(
  .I(sspim0_sclk_out_pad_0__I),
  .IO(p2t_sspim0_sclk_out),
  .O(sspim0_sclk_out_pad_0__O),
  .T(sspim0_sclk_out_pad_0__T)
);

IOBUF sspim0_ss_pad_0(
  .I(sspim0_ss_pad_0__I),
  .IO(p2t_sspim0_ss),
  .O(sspim0_ss_pad_0__O),
  .T(sspim0_ss_pad_0__T)
);

IOBUF sspim0_txd_pad_0(
  .I(sspim0_txd_pad_0__I),
  .IO(p2t_sspim0_txd),
  .O(sspim0_txd_pad_0__O),
  .T(sspim0_txd_pad_0__T)
);

IOBUF uart1_sin_pad_0(
  .I(uart1_sin_pad_0__I),
  .IO(t2p_uart1_sin),
  .O(uart1_sin_pad_0__O),
  .T(uart1_sin_pad_0__T)
);

IOBUF uart1_sout_pad_0(
  .I(uart1_sout_pad_0__I),
  .IO(p2t_uart1_sout),
  .O(uart1_sout_pad_0__O),
  .T(uart1_sout_pad_0__T)
);

IOBUF uart2_sin_pad_0(
  .I(uart2_sin_pad_0__I),
  .IO(t2p_uart2_sin),
  .O(uart2_sin_pad_0__O),
  .T(uart2_sin_pad_0__T)
);

IOBUF uart2_sout_pad_0(
  .I(uart2_sout_pad_0__I),
  .IO(p2t_uart2_sout),
  .O(uart2_sout_pad_0__O),
  .T(uart2_sout_pad_0__T)
);

ddr_vcu118 xilinx_ddr_u(
  .addn_ui_clkout1(xilinx_ddr_u__addn_ui_clkout1),
  .c0_ddr4_act_n(xilinx_ddr_u__c0_ddr4_act_n),
  .c0_ddr4_adr(xilinx_ddr_u__c0_ddr4_adr),
  .c0_ddr4_ba(xilinx_ddr_u__c0_ddr4_ba),
  .c0_ddr4_bg(xilinx_ddr_u__c0_ddr4_bg),
  .c0_ddr4_ck_c(xilinx_ddr_u__c0_ddr4_ck_c),
  .c0_ddr4_ck_t(xilinx_ddr_u__c0_ddr4_ck_t),
  .c0_ddr4_cke(xilinx_ddr_u__c0_ddr4_cke),
  .c0_ddr4_cs_n(xilinx_ddr_u__c0_ddr4_cs_n),
  .c0_ddr4_dm_dbi_n(c0_ddr4_dm_dbi_n),
  .c0_ddr4_dq(c0_ddr4_dq),
  .c0_ddr4_dqs_c(c0_ddr4_dqs_c),
  .c0_ddr4_dqs_t(c0_ddr4_dqs_t),
  .c0_ddr4_odt(xilinx_ddr_u__c0_ddr4_odt),
  .c0_ddr4_reset_n(xilinx_ddr_u__c0_ddr4_reset_n),
  .c0_init_calib_complete(xilinx_ddr_u__c0_init_calib_complete),
  .c0_sys_clk_n(xilinx_ddr_u__c0_sys_clk_n),
  .c0_sys_clk_p(xilinx_ddr_u__c0_sys_clk_p),
  .req_if_ar(xilinx_ddr_u__req_if_ar),
  .req_if_arready(xilinx_ddr_u__req_if_arready),
  .req_if_arvalid(xilinx_ddr_u__req_if_arvalid),
  .req_if_aw(xilinx_ddr_u__req_if_aw),
  .req_if_awready(xilinx_ddr_u__req_if_awready),
  .req_if_awvalid(xilinx_ddr_u__req_if_awvalid),
  .req_if_w(xilinx_ddr_u__req_if_w),
  .req_if_wready(xilinx_ddr_u__req_if_wready),
  .req_if_wvalid(xilinx_ddr_u__req_if_wvalid),
  .rsp_if_b(xilinx_ddr_u__rsp_if_b),
  .rsp_if_bready(xilinx_ddr_u__rsp_if_bready),
  .rsp_if_bvalid(xilinx_ddr_u__rsp_if_bvalid),
  .rsp_if_r(xilinx_ddr_u__rsp_if_r),
  .rsp_if_rready(xilinx_ddr_u__rsp_if_rready),
  .rsp_if_rvalid(xilinx_ddr_u__rsp_if_rvalid),
  .sys_rst(xilinx_ddr_u__sys_rst)
);

endmodule
