
module io
  import pygmy_cfg::*;
(
// Reference Clock
output wire  p2c_refclk,
// Reference Clock
inout wire  t2p_refclk,
// RTC Clock
output wire  p2c_rtcclk,
// RTC Clock
inout wire  t2p_rtcclk,
// Chip Reset, Low Active
output wire  p2c_reset_n,
// Chip Reset, Low Active
inout wire  t2p_reset_n,
// Scan ATE Clock
output wire  p2c_scan_ate_clk,
// Scan ATE Clock
inout wire  t2p_scan_ate_clk,
// Scan Mode
output wire  p2c_scan_mode,
// Scan Mode
inout wire  t2p_scan_mode,
// Scan TAP compliance bit
output wire  p2c_scan_tap_compliance,
// Scan TAP compliance bit
inout wire  t2p_scan_tap_compliance,
// Functional Scan Clock
output wire  p2c_scan_f_clk,
// Functional Scan Clock
inout wire  t2p_scan_f_clk,
// Sampled by cclk_rx
input  wire  c2p_sd_cmd_in_out,
output wire  p2c_sd_cmd_in_out,
input  wire  c2p_sd_cmd_in_out_oen,
// Sampled by cclk_rx
inout wire  tbp_sd_cmd_in_out,
// Sampled by cclk_rx. All data line must be pulled high, even if they are not used.
input  wire [4 - 1 : 0] c2p_sd_dat_in_out,
output wire [4 - 1 : 0] p2c_sd_dat_in_out,
input  wire [4 - 1 : 0] c2p_sd_dat_in_out_oen,
// Sampled by cclk_rx. All data line must be pulled high, even if they are not used.
inout wire [4 - 1 : 0] tbp_sd_dat_in_out,
// Sampled by cclk_rx. All data line must be pulled high, even if they are not used.
input  wire  c2p_sd_clk,
output wire  p2c_sd_clk,
input  wire  c2p_sd_clk_oen,
// Sampled by cclk_rx. All data line must be pulled high, even if they are not used.
inout wire  tbp_sd_clk,
// When this is 0, it represents card is connected.
output wire  p2c_sd_card_detect_n,
// When this is 0, it represents card is connected.
inout wire  t2p_sd_card_detect_n,
// When this is 1, it represents card is write protected.
output wire  p2c_sd_card_write_prot,
// When this is 1, it represents card is write protected.
inout wire  t2p_sd_card_write_prot,
// Test IO Clock
input  wire  c2p_test_io_clk,
output wire  p2c_test_io_clk,
input  wire  c2p_test_io_clk_oen,
// Test IO Clock
inout wire  tbp_test_io_clk,
// Test IO Enable
input  wire  c2p_test_io_en,
output wire  p2c_test_io_en,
input  wire  c2p_test_io_en_oen,
// Test IO Enable
inout wire  tbp_test_io_en,
// Test IO Data
input  wire  c2p_test_io_data,
output wire  p2c_test_io_data,
input  wire  c2p_test_io_data_oen,
// Test IO Data
inout wire  tbp_test_io_data,
// JTAG Clock
output wire  p2c_jtag_tck,
// JTAG Clock
inout wire  t2p_jtag_tck,
// JTAG Input Port
output wire  p2c_jtag_tdi,
// JTAG Input Port
inout wire  t2p_jtag_tdi,
// JTAG Output Port
input  wire  c2p_jtag_tdo,
output wire  p2c_jtag_tdo,
input  wire  c2p_jtag_tdo_oen,
// JTAG Output Port
inout wire  tbp_jtag_tdo,
// JTAG State Machine Control
output wire  p2c_jtag_tms,
// JTAG State Machine Control
inout wire  t2p_jtag_tms,
// PHY JTAG Reset
output wire  p2c_jtag_trst_n,
// PHY JTAG Reset
inout wire  t2p_jtag_trst_n,
// Output clk from spi master
input  wire  c2p_qspim_sclk_out,
// Output clk from spi master
inout wire  p2t_qspim_sclk_out,
// 
input  wire [4 - 1 : 0] c2p_qspim_trxd,
output wire [4 - 1 : 0] p2c_qspim_trxd,
input  wire [4 - 1 : 0] c2p_qspim_trxd_oen,
// 
inout wire [4 - 1 : 0] tbp_qspim_trxd,
// 
input  wire  c2p_qspim_ss,
// 
inout wire  p2t_qspim_ss,
// 
input  wire  c2p_sspim0_sclk_out,
// 
inout wire  p2t_sspim0_sclk_out,
// 
output wire  p2c_sspim0_rxd,
// 
inout wire  t2p_sspim0_rxd,
// 
input  wire  c2p_sspim0_txd,
// 
inout wire  p2t_sspim0_txd,
// 
input  wire  c2p_sspim0_ss,
// 
inout wire  p2t_sspim0_ss,
// Serial Input
output wire  p2c_uart1_sin,
// Serial Input
inout wire  t2p_uart1_sin,
// Serial Output.
input  wire  c2p_uart1_sout,
// Serial Output.
inout wire  p2t_uart1_sout,
// Serial Input
output wire  p2c_uart2_sin,
// Serial Input
inout wire  t2p_uart2_sin,
// Serial Output.
input  wire  c2p_uart2_sout,
// Serial Output.
inout wire  p2t_uart2_sout,
// I2C0 clk pin
input  wire  c2p_i2c0_ic_clk,
output wire  p2c_i2c0_ic_clk,
input  wire  c2p_i2c0_ic_clk_oen,
// I2C0 clk pin
inout wire  tbp_i2c0_ic_clk,
// 
input  wire  c2p_i2c0_ic_data,
output wire  p2c_i2c0_ic_data,
input  wire  c2p_i2c0_ic_data_oen,
// 
inout wire  tbp_i2c0_ic_data,
// REFCLK ENABLE
input  wire  c2p_refclk_en,
// REFCLK ENABLE
inout wire  p2t_refclk_en,
input wire [2 - 1 : 0] SSP_SHARED_sel_0,
input wire [2 - 1 : 0] SSP_SHARED_sel_1,
input wire [2 - 1 : 0] SSP_SHARED_sel_2,
input wire [2 - 1 : 0] SSP_SHARED_sel_3,
input wire [2 - 1 : 0] SSP_SHARED_sel_4,
input wire [2 - 1 : 0] SSP_SHARED_sel_5,
input wire [2 - 1 : 0] SSP_SHARED_sel_6,
input wire [2 - 1 : 0] SSP_SHARED_sel_7,
input wire [2 - 1 : 0] SSP_SHARED_sel_8,
input wire [2 - 1 : 0] SSP_SHARED_sel_9,
input wire [2 - 1 : 0] SSP_SHARED_sel_10,
input wire [2 - 1 : 0] SSP_SHARED_sel_11,
input wire [2 - 1 : 0] SSP_SHARED_sel_12,
input wire [2 - 1 : 0] SSP_SHARED_sel_13,
input wire [2 - 1 : 0] SSP_SHARED_sel_14,
input wire [2 - 1 : 0] SSP_SHARED_sel_15,
input wire [2 - 1 : 0] SSP_SHARED_sel_16,
input wire [2 - 1 : 0] SSP_SHARED_sel_17,
input wire [2 - 1 : 0] SSP_SHARED_sel_18,
input wire [2 - 1 : 0] SSP_SHARED_sel_19,
input wire [2 - 1 : 0] SSP_SHARED_sel_20,
input wire [2 - 1 : 0] SSP_SHARED_sel_21,
input wire [2 - 1 : 0] SSP_SHARED_sel_22,
input wire [2 - 1 : 0] SSP_SHARED_sel_23,
input wire [2 - 1 : 0] SSP_SHARED_sel_24,
input wire [2 - 1 : 0] SSP_SHARED_sel_25,
input wire [2 - 1 : 0] SSP_SHARED_sel_26,
input wire [2 - 1 : 0] SSP_SHARED_sel_27,
input wire [2 - 1 : 0] SSP_SHARED_sel_28,
input wire [2 - 1 : 0] SSP_SHARED_sel_29,
input wire [2 - 1 : 0] SSP_SHARED_sel_30,
input wire [2 - 1 : 0] SSP_SHARED_sel_31,
input wire [2 - 1 : 0] SSP_SHARED_sel_32,
input wire [2 - 1 : 0] SSP_SHARED_sel_33,
input wire [2 - 1 : 0] SSP_SHARED_sel_34,
input wire [2 - 1 : 0] SSP_SHARED_sel_35,
input wire [2 - 1 : 0] SSP_SHARED_sel_36,
input wire [2 - 1 : 0] SSP_SHARED_sel_37,
input wire [2 - 1 : 0] SSP_SHARED_sel_38,
input wire [2 - 1 : 0] SSP_SHARED_sel_39,
input wire [2 - 1 : 0] SSP_SHARED_sel_40,
input wire [2 - 1 : 0] SSP_SHARED_sel_41,
input wire [2 - 1 : 0] SSP_SHARED_sel_42,
input wire [2 - 1 : 0] SSP_SHARED_sel_43,
input wire [2 - 1 : 0] SSP_SHARED_sel_44,
input wire [2 - 1 : 0] SSP_SHARED_sel_45,
input wire [2 - 1 : 0] SSP_SHARED_sel_46,
input wire [2 - 1 : 0] SSP_SHARED_sel_47,
input wire test_mode,
// 
output wire  p2c_uart0_cts_n,
// 
input  wire  c2p_uart0_rts_n,
// uart0 sout
input  wire  c2p_uart0_sout,
// uart0 sin
output wire  p2c_uart0_sin,
// BOOTMODE
output wire [2 - 1 : 0] p2c_boot_mode,
// 
input  wire  c2p_sspim1_sclk_out,
// 
output wire  p2c_sspim1_rxd,
// 
input  wire  c2p_sspim1_txd,
// 
input  wire  c2p_sspim1_ss,
// 
output wire  p2c_spis_sclk_in,
// 
output wire  p2c_spis_rxd,
// 
input  wire  c2p_spis_txd,
// 
output wire  p2c_spis_ss,
// Serial Input
output wire  p2c_uart3_sin,
// Serial Output.
input  wire  c2p_uart3_sout,
// 
input  wire [32 - 1 : 0] c2p_gpio_porta,
output wire [32 - 1 : 0] p2c_gpio_porta,
input  wire [32 - 1 : 0] c2p_gpio_porta_oen,
// 
input  wire  c2p_i2stxm_sclk,
// 
input  wire  c2p_i2stxm_ws,
// 
input  wire [4 - 1 : 0] c2p_i2stxm_data,
// 
input  wire  c2p_i2srxm0_sclk,
// 
input  wire  c2p_i2srxm0_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm0_data,
// 
input  wire  c2p_i2srxm1_sclk,
// 
input  wire  c2p_i2srxm1_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm1_data,
// 
input  wire  c2p_i2srxm2_sclk,
// 
input  wire  c2p_i2srxm2_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm2_data,
// 
input  wire  c2p_i2srxm3_sclk,
// 
input  wire  c2p_i2srxm3_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm3_data,
// 
input  wire  c2p_i2srxm4_sclk,
// 
input  wire  c2p_i2srxm4_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm4_data,
// 
input  wire  c2p_i2srxm5_sclk,
// 
input  wire  c2p_i2srxm5_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm5_data,
// 
output wire  p2c_chip_wake_up,
// 
output wire  p2c_scan_test_modes,
// 
output wire  p2c_scan_reset,
// 
output wire  p2c_scan_enable,
// 
output wire [10 - 1 : 0] p2c_scan_in,
// 
input  wire [10 - 1 : 0] c2p_scan_out,
// I2C1 clk pin
input  wire  c2p_i2c1_ic_clk,
output wire  p2c_i2c1_ic_clk,
input  wire  c2p_i2c1_ic_clk_oen,
// 
input  wire  c2p_i2c1_ic_data,
output wire  p2c_i2c1_ic_data,
input  wire  c2p_i2c1_ic_data_oen,
// I2C2 clk pin
input  wire  c2p_i2c2_ic_clk,
output wire  p2c_i2c2_ic_clk,
input  wire  c2p_i2c2_ic_clk_oen,
// 
input  wire  c2p_i2c2_ic_data,
output wire  p2c_i2c2_ic_data,
input  wire  c2p_i2c2_ic_data_oen,
// 
input  wire  c2p_sspim2_sclk_out,
// 
output wire  p2c_sspim2_rxd,
// 
input  wire  c2p_sspim2_txd,
// 
input  wire  c2p_sspim2_ss,
// 
input  wire [8 - 1 : 0] c2p_tim_pwn,
// 
inout wire  tbp_SSP_SHARED_0,
// 
inout wire  p2t_SSP_SHARED_1,
// 
inout wire  p2t_SSP_SHARED_2,
// 
inout wire  tbp_SSP_SHARED_3,
// 
inout wire  tbp_SSP_SHARED_4,
// 
inout wire  tbp_SSP_SHARED_5,
// 
inout wire  p2t_SSP_SHARED_6,
// 
inout wire  tbp_SSP_SHARED_7,
// 
inout wire  tbp_SSP_SHARED_8,
// 
inout wire  tbp_SSP_SHARED_9,
// 
inout wire  t2p_SSP_SHARED_10,
// 
inout wire  t2p_SSP_SHARED_11,
// 
inout wire  p2t_SSP_SHARED_12,
// 
inout wire  tbp_SSP_SHARED_13,
// 
inout wire  t2p_SSP_SHARED_14,
// 
inout wire  tbp_SSP_SHARED_15,
// 
inout wire  tbp_SSP_SHARED_16,
// 
inout wire  tbp_SSP_SHARED_17,
// 
inout wire  tbp_SSP_SHARED_18,
// 
inout wire  tbp_SSP_SHARED_19,
// 
inout wire  tbp_SSP_SHARED_20,
// 
inout wire  tbp_SSP_SHARED_21,
// 
inout wire  tbp_SSP_SHARED_22,
// 
inout wire  tbp_SSP_SHARED_23,
// 
inout wire  tbp_SSP_SHARED_24,
// 
inout wire  tbp_SSP_SHARED_25,
// 
inout wire  tbp_SSP_SHARED_26,
// 
inout wire  tbp_SSP_SHARED_27,
// 
inout wire  tbp_SSP_SHARED_28,
// 
inout wire  tbp_SSP_SHARED_29,
// 
inout wire  tbp_SSP_SHARED_30,
// 
inout wire  tbp_SSP_SHARED_31,
// 
inout wire  tbp_SSP_SHARED_32,
// 
inout wire  tbp_SSP_SHARED_33,
// 
inout wire  tbp_SSP_SHARED_34,
// 
inout wire  tbp_SSP_SHARED_35,
// 
inout wire  tbp_SSP_SHARED_36,
// 
inout wire  tbp_SSP_SHARED_37,
// 
inout wire  tbp_SSP_SHARED_38,
// 
inout wire  tbp_SSP_SHARED_39,
// 
inout wire  tbp_SSP_SHARED_40,
// 
inout wire  tbp_SSP_SHARED_41,
// 
inout wire  tbp_SSP_SHARED_42,
// 
inout wire  tbp_SSP_SHARED_43,
// 
inout wire  tbp_SSP_SHARED_44,
// 
inout wire  tbp_SSP_SHARED_45,
// 
inout wire  tbp_SSP_SHARED_46,
// 
inout wire  tbp_SSP_SHARED_47
);
logic c2p_SSP_SHARED_0;
logic p2c_SSP_SHARED_0;
logic c2p_SSP_SHARED_0_oen;

logic c2p_SSP_SHARED_1;

logic c2p_SSP_SHARED_2;

logic c2p_SSP_SHARED_3;
logic p2c_SSP_SHARED_3;
logic c2p_SSP_SHARED_3_oen;

logic c2p_SSP_SHARED_4;
logic p2c_SSP_SHARED_4;
logic c2p_SSP_SHARED_4_oen;

logic c2p_SSP_SHARED_5;
logic p2c_SSP_SHARED_5;
logic c2p_SSP_SHARED_5_oen;

logic c2p_SSP_SHARED_6;

logic c2p_SSP_SHARED_7;
logic p2c_SSP_SHARED_7;
logic c2p_SSP_SHARED_7_oen;

logic c2p_SSP_SHARED_8;
logic p2c_SSP_SHARED_8;
logic c2p_SSP_SHARED_8_oen;

logic c2p_SSP_SHARED_9;
logic p2c_SSP_SHARED_9;
logic c2p_SSP_SHARED_9_oen;

logic p2c_SSP_SHARED_10;

logic p2c_SSP_SHARED_11;

logic c2p_SSP_SHARED_12;

logic c2p_SSP_SHARED_13;
logic p2c_SSP_SHARED_13;
logic c2p_SSP_SHARED_13_oen;

logic p2c_SSP_SHARED_14;

logic c2p_SSP_SHARED_15;
logic p2c_SSP_SHARED_15;
logic c2p_SSP_SHARED_15_oen;

logic c2p_SSP_SHARED_16;
logic p2c_SSP_SHARED_16;
logic c2p_SSP_SHARED_16_oen;

logic c2p_SSP_SHARED_17;
logic p2c_SSP_SHARED_17;
logic c2p_SSP_SHARED_17_oen;

logic c2p_SSP_SHARED_18;
logic p2c_SSP_SHARED_18;
logic c2p_SSP_SHARED_18_oen;

logic c2p_SSP_SHARED_19;
logic p2c_SSP_SHARED_19;
logic c2p_SSP_SHARED_19_oen;

logic c2p_SSP_SHARED_20;
logic p2c_SSP_SHARED_20;
logic c2p_SSP_SHARED_20_oen;

logic c2p_SSP_SHARED_21;
logic p2c_SSP_SHARED_21;
logic c2p_SSP_SHARED_21_oen;

logic c2p_SSP_SHARED_22;
logic p2c_SSP_SHARED_22;
logic c2p_SSP_SHARED_22_oen;

logic c2p_SSP_SHARED_23;
logic p2c_SSP_SHARED_23;
logic c2p_SSP_SHARED_23_oen;

logic c2p_SSP_SHARED_24;
logic p2c_SSP_SHARED_24;
logic c2p_SSP_SHARED_24_oen;

logic c2p_SSP_SHARED_25;
logic p2c_SSP_SHARED_25;
logic c2p_SSP_SHARED_25_oen;

logic c2p_SSP_SHARED_26;
logic p2c_SSP_SHARED_26;
logic c2p_SSP_SHARED_26_oen;

logic c2p_SSP_SHARED_27;
logic p2c_SSP_SHARED_27;
logic c2p_SSP_SHARED_27_oen;

logic c2p_SSP_SHARED_28;
logic p2c_SSP_SHARED_28;
logic c2p_SSP_SHARED_28_oen;

logic c2p_SSP_SHARED_29;
logic p2c_SSP_SHARED_29;
logic c2p_SSP_SHARED_29_oen;

logic c2p_SSP_SHARED_30;
logic p2c_SSP_SHARED_30;
logic c2p_SSP_SHARED_30_oen;

logic c2p_SSP_SHARED_31;
logic p2c_SSP_SHARED_31;
logic c2p_SSP_SHARED_31_oen;

logic c2p_SSP_SHARED_32;
logic p2c_SSP_SHARED_32;
logic c2p_SSP_SHARED_32_oen;

logic c2p_SSP_SHARED_33;
logic p2c_SSP_SHARED_33;
logic c2p_SSP_SHARED_33_oen;

logic c2p_SSP_SHARED_34;
logic p2c_SSP_SHARED_34;
logic c2p_SSP_SHARED_34_oen;

logic c2p_SSP_SHARED_35;
logic p2c_SSP_SHARED_35;
logic c2p_SSP_SHARED_35_oen;

logic c2p_SSP_SHARED_36;
logic p2c_SSP_SHARED_36;
logic c2p_SSP_SHARED_36_oen;

logic c2p_SSP_SHARED_37;
logic p2c_SSP_SHARED_37;
logic c2p_SSP_SHARED_37_oen;

logic c2p_SSP_SHARED_38;
logic p2c_SSP_SHARED_38;
logic c2p_SSP_SHARED_38_oen;

logic c2p_SSP_SHARED_39;
logic p2c_SSP_SHARED_39;
logic c2p_SSP_SHARED_39_oen;

logic c2p_SSP_SHARED_40;
logic p2c_SSP_SHARED_40;
logic c2p_SSP_SHARED_40_oen;

logic c2p_SSP_SHARED_41;
logic p2c_SSP_SHARED_41;
logic c2p_SSP_SHARED_41_oen;

logic c2p_SSP_SHARED_42;
logic p2c_SSP_SHARED_42;
logic c2p_SSP_SHARED_42_oen;

logic c2p_SSP_SHARED_43;
logic p2c_SSP_SHARED_43;
logic c2p_SSP_SHARED_43_oen;

logic c2p_SSP_SHARED_44;
logic p2c_SSP_SHARED_44;
logic c2p_SSP_SHARED_44_oen;

logic c2p_SSP_SHARED_45;
logic p2c_SSP_SHARED_45;
logic c2p_SSP_SHARED_45_oen;

logic c2p_SSP_SHARED_46;
logic p2c_SSP_SHARED_46;
logic c2p_SSP_SHARED_46_oen;

logic c2p_SSP_SHARED_47;
logic p2c_SSP_SHARED_47;
logic c2p_SSP_SHARED_47_oen;

io_pads io_pads_u (

// Reference Clock
.refclk_pad_0_pad(t2p_refclk),
.refclk_pad_0_c(p2c_refclk),

// RTC Clock
.rtcclk_pad_0_pad(t2p_rtcclk),
.rtcclk_pad_0_c(p2c_rtcclk),

// Chip Reset, Low Active
.reset_n_pad_0_pad(t2p_reset_n),
.reset_n_pad_0_c(p2c_reset_n),

// Scan ATE Clock
.scan_ate_clk_pad_0_pad(t2p_scan_ate_clk),
.scan_ate_clk_pad_0_c(p2c_scan_ate_clk),

// Scan Mode
.scan_mode_pad_0_pad(t2p_scan_mode),
.scan_mode_pad_0_c(p2c_scan_mode),

// Scan TAP compliance bit
.scan_tap_compliance_pad_0_pad(t2p_scan_tap_compliance),
.scan_tap_compliance_pad_0_c(p2c_scan_tap_compliance),

// Functional Scan Clock
.scan_f_clk_pad_0_pad(t2p_scan_f_clk),
.scan_f_clk_pad_0_c(p2c_scan_f_clk),

// Sampled by cclk_rx
.sd_cmd_in_out_pad_0_pad(tbp_sd_cmd_in_out),
.sd_cmd_in_out_pad_0_c(p2c_sd_cmd_in_out),
.sd_cmd_in_out_pad_0_i(c2p_sd_cmd_in_out),
.sd_cmd_in_out_pad_0_oen(c2p_sd_cmd_in_out_oen),

// Sampled by cclk_rx. All data line must be pulled high, even if they are not used.
.sd_dat_in_out_pad_0_pad(tbp_sd_dat_in_out[0]),
.sd_dat_in_out_pad_0_c(p2c_sd_dat_in_out[0]),
.sd_dat_in_out_pad_0_i(c2p_sd_dat_in_out[0]),
.sd_dat_in_out_pad_0_oen(c2p_sd_dat_in_out_oen[0]),
.sd_dat_in_out_pad_1_pad(tbp_sd_dat_in_out[1]),
.sd_dat_in_out_pad_1_c(p2c_sd_dat_in_out[1]),
.sd_dat_in_out_pad_1_i(c2p_sd_dat_in_out[1]),
.sd_dat_in_out_pad_1_oen(c2p_sd_dat_in_out_oen[1]),
.sd_dat_in_out_pad_2_pad(tbp_sd_dat_in_out[2]),
.sd_dat_in_out_pad_2_c(p2c_sd_dat_in_out[2]),
.sd_dat_in_out_pad_2_i(c2p_sd_dat_in_out[2]),
.sd_dat_in_out_pad_2_oen(c2p_sd_dat_in_out_oen[2]),
.sd_dat_in_out_pad_3_pad(tbp_sd_dat_in_out[3]),
.sd_dat_in_out_pad_3_c(p2c_sd_dat_in_out[3]),
.sd_dat_in_out_pad_3_i(c2p_sd_dat_in_out[3]),
.sd_dat_in_out_pad_3_oen(c2p_sd_dat_in_out_oen[3]),

// Sampled by cclk_rx. All data line must be pulled high, even if they are not used.
.sd_clk_pad_0_pad(tbp_sd_clk),
.sd_clk_pad_0_c(p2c_sd_clk),
.sd_clk_pad_0_i(c2p_sd_clk),
.sd_clk_pad_0_oen(c2p_sd_clk_oen),

// When this is 0, it represents card is connected.
.sd_card_detect_n_pad_0_pad(t2p_sd_card_detect_n),
.sd_card_detect_n_pad_0_c(p2c_sd_card_detect_n),

// When this is 1, it represents card is write protected.
.sd_card_write_prot_pad_0_pad(t2p_sd_card_write_prot),
.sd_card_write_prot_pad_0_c(p2c_sd_card_write_prot),

// Test IO Clock
.test_io_clk_pad_0_pad(tbp_test_io_clk),
.test_io_clk_pad_0_c(p2c_test_io_clk),
.test_io_clk_pad_0_i(c2p_test_io_clk),
.test_io_clk_pad_0_oen(c2p_test_io_clk_oen),

// Test IO Enable
.test_io_en_pad_0_pad(tbp_test_io_en),
.test_io_en_pad_0_c(p2c_test_io_en),
.test_io_en_pad_0_i(c2p_test_io_en),
.test_io_en_pad_0_oen(c2p_test_io_en_oen),

// Test IO Data
.test_io_data_pad_0_pad(tbp_test_io_data),
.test_io_data_pad_0_c(p2c_test_io_data),
.test_io_data_pad_0_i(c2p_test_io_data),
.test_io_data_pad_0_oen(c2p_test_io_data_oen),

// JTAG Clock
.jtag_tck_pad_0_pad(t2p_jtag_tck),
.jtag_tck_pad_0_c(p2c_jtag_tck),

// JTAG Input Port
.jtag_tdi_pad_0_pad(t2p_jtag_tdi),
.jtag_tdi_pad_0_c(p2c_jtag_tdi),

// JTAG Output Port
.jtag_tdo_pad_0_pad(tbp_jtag_tdo),
.jtag_tdo_pad_0_c(p2c_jtag_tdo),
.jtag_tdo_pad_0_i(c2p_jtag_tdo),
.jtag_tdo_pad_0_oen(c2p_jtag_tdo_oen),

// JTAG State Machine Control
.jtag_tms_pad_0_pad(t2p_jtag_tms),
.jtag_tms_pad_0_c(p2c_jtag_tms),

// PHY JTAG Reset
.jtag_trst_n_pad_0_pad(t2p_jtag_trst_n),
.jtag_trst_n_pad_0_c(p2c_jtag_trst_n),

// Output clk from spi master
.qspim_sclk_out_pad_0_pad(p2t_qspim_sclk_out),
.qspim_sclk_out_pad_0_i(c2p_qspim_sclk_out),

// 
.qspim_trxd_pad_0_pad(tbp_qspim_trxd[0]),
.qspim_trxd_pad_0_c(p2c_qspim_trxd[0]),
.qspim_trxd_pad_0_i(c2p_qspim_trxd[0]),
.qspim_trxd_pad_0_oen(c2p_qspim_trxd_oen[0]),
.qspim_trxd_pad_1_pad(tbp_qspim_trxd[1]),
.qspim_trxd_pad_1_c(p2c_qspim_trxd[1]),
.qspim_trxd_pad_1_i(c2p_qspim_trxd[1]),
.qspim_trxd_pad_1_oen(c2p_qspim_trxd_oen[1]),
.qspim_trxd_pad_2_pad(tbp_qspim_trxd[2]),
.qspim_trxd_pad_2_c(p2c_qspim_trxd[2]),
.qspim_trxd_pad_2_i(c2p_qspim_trxd[2]),
.qspim_trxd_pad_2_oen(c2p_qspim_trxd_oen[2]),
.qspim_trxd_pad_3_pad(tbp_qspim_trxd[3]),
.qspim_trxd_pad_3_c(p2c_qspim_trxd[3]),
.qspim_trxd_pad_3_i(c2p_qspim_trxd[3]),
.qspim_trxd_pad_3_oen(c2p_qspim_trxd_oen[3]),

// 
.qspim_ss_pad_0_pad(p2t_qspim_ss),
.qspim_ss_pad_0_i(c2p_qspim_ss),

// 
.sspim0_sclk_out_pad_0_pad(p2t_sspim0_sclk_out),
.sspim0_sclk_out_pad_0_i(c2p_sspim0_sclk_out),

// 
.sspim0_rxd_pad_0_pad(t2p_sspim0_rxd),
.sspim0_rxd_pad_0_c(p2c_sspim0_rxd),

// 
.sspim0_txd_pad_0_pad(p2t_sspim0_txd),
.sspim0_txd_pad_0_i(c2p_sspim0_txd),

// 
.sspim0_ss_pad_0_pad(p2t_sspim0_ss),
.sspim0_ss_pad_0_i(c2p_sspim0_ss),

// Serial Input
.uart1_sin_pad_0_pad(t2p_uart1_sin),
.uart1_sin_pad_0_c(p2c_uart1_sin),

// Serial Output.
.uart1_sout_pad_0_pad(p2t_uart1_sout),
.uart1_sout_pad_0_i(c2p_uart1_sout),

// Serial Input
.uart2_sin_pad_0_pad(t2p_uart2_sin),
.uart2_sin_pad_0_c(p2c_uart2_sin),

// Serial Output.
.uart2_sout_pad_0_pad(p2t_uart2_sout),
.uart2_sout_pad_0_i(c2p_uart2_sout),

// I2C0 clk pin
.i2c0_ic_clk_pad_0_pad(tbp_i2c0_ic_clk),
.i2c0_ic_clk_pad_0_c(p2c_i2c0_ic_clk),
.i2c0_ic_clk_pad_0_i(c2p_i2c0_ic_clk),
.i2c0_ic_clk_pad_0_oen(c2p_i2c0_ic_clk_oen),

// 
.i2c0_ic_data_pad_0_pad(tbp_i2c0_ic_data),
.i2c0_ic_data_pad_0_c(p2c_i2c0_ic_data),
.i2c0_ic_data_pad_0_i(c2p_i2c0_ic_data),
.i2c0_ic_data_pad_0_oen(c2p_i2c0_ic_data_oen),

// REFCLK ENABLE
.refclk_en_pad_0_pad(p2t_refclk_en),
.refclk_en_pad_0_i(c2p_refclk_en),

// 
.SSP_SHARED_0_pad_0_pad(tbp_SSP_SHARED_0),
.SSP_SHARED_0_pad_0_c(p2c_SSP_SHARED_0),
.SSP_SHARED_0_pad_0_i(c2p_SSP_SHARED_0),
.SSP_SHARED_0_pad_0_oen(c2p_SSP_SHARED_0_oen),

// 
.SSP_SHARED_1_pad_0_pad(p2t_SSP_SHARED_1),
.SSP_SHARED_1_pad_0_i(c2p_SSP_SHARED_1),

// 
.SSP_SHARED_2_pad_0_pad(p2t_SSP_SHARED_2),
.SSP_SHARED_2_pad_0_i(c2p_SSP_SHARED_2),

// 
.SSP_SHARED_3_pad_0_pad(tbp_SSP_SHARED_3),
.SSP_SHARED_3_pad_0_c(p2c_SSP_SHARED_3),
.SSP_SHARED_3_pad_0_i(c2p_SSP_SHARED_3),
.SSP_SHARED_3_pad_0_oen(c2p_SSP_SHARED_3_oen),

// 
.SSP_SHARED_4_pad_0_pad(tbp_SSP_SHARED_4),
.SSP_SHARED_4_pad_0_c(p2c_SSP_SHARED_4),
.SSP_SHARED_4_pad_0_i(c2p_SSP_SHARED_4),
.SSP_SHARED_4_pad_0_oen(c2p_SSP_SHARED_4_oen),

// 
.SSP_SHARED_5_pad_0_pad(tbp_SSP_SHARED_5),
.SSP_SHARED_5_pad_0_c(p2c_SSP_SHARED_5),
.SSP_SHARED_5_pad_0_i(c2p_SSP_SHARED_5),
.SSP_SHARED_5_pad_0_oen(c2p_SSP_SHARED_5_oen),

// 
.SSP_SHARED_6_pad_0_pad(p2t_SSP_SHARED_6),
.SSP_SHARED_6_pad_0_i(c2p_SSP_SHARED_6),

// 
.SSP_SHARED_7_pad_0_pad(tbp_SSP_SHARED_7),
.SSP_SHARED_7_pad_0_c(p2c_SSP_SHARED_7),
.SSP_SHARED_7_pad_0_i(c2p_SSP_SHARED_7),
.SSP_SHARED_7_pad_0_oen(c2p_SSP_SHARED_7_oen),

// 
.SSP_SHARED_8_pad_0_pad(tbp_SSP_SHARED_8),
.SSP_SHARED_8_pad_0_c(p2c_SSP_SHARED_8),
.SSP_SHARED_8_pad_0_i(c2p_SSP_SHARED_8),
.SSP_SHARED_8_pad_0_oen(c2p_SSP_SHARED_8_oen),

// 
.SSP_SHARED_9_pad_0_pad(tbp_SSP_SHARED_9),
.SSP_SHARED_9_pad_0_c(p2c_SSP_SHARED_9),
.SSP_SHARED_9_pad_0_i(c2p_SSP_SHARED_9),
.SSP_SHARED_9_pad_0_oen(c2p_SSP_SHARED_9_oen),

// 
.SSP_SHARED_10_pad_0_pad(t2p_SSP_SHARED_10),
.SSP_SHARED_10_pad_0_c(p2c_SSP_SHARED_10),

// 
.SSP_SHARED_11_pad_0_pad(t2p_SSP_SHARED_11),
.SSP_SHARED_11_pad_0_c(p2c_SSP_SHARED_11),

// 
.SSP_SHARED_12_pad_0_pad(p2t_SSP_SHARED_12),
.SSP_SHARED_12_pad_0_i(c2p_SSP_SHARED_12),

// 
.SSP_SHARED_13_pad_0_pad(tbp_SSP_SHARED_13),
.SSP_SHARED_13_pad_0_c(p2c_SSP_SHARED_13),
.SSP_SHARED_13_pad_0_i(c2p_SSP_SHARED_13),
.SSP_SHARED_13_pad_0_oen(c2p_SSP_SHARED_13_oen),

// 
.SSP_SHARED_14_pad_0_pad(t2p_SSP_SHARED_14),
.SSP_SHARED_14_pad_0_c(p2c_SSP_SHARED_14),

// 
.SSP_SHARED_15_pad_0_pad(tbp_SSP_SHARED_15),
.SSP_SHARED_15_pad_0_c(p2c_SSP_SHARED_15),
.SSP_SHARED_15_pad_0_i(c2p_SSP_SHARED_15),
.SSP_SHARED_15_pad_0_oen(c2p_SSP_SHARED_15_oen),

// 
.SSP_SHARED_16_pad_0_pad(tbp_SSP_SHARED_16),
.SSP_SHARED_16_pad_0_c(p2c_SSP_SHARED_16),
.SSP_SHARED_16_pad_0_i(c2p_SSP_SHARED_16),
.SSP_SHARED_16_pad_0_oen(c2p_SSP_SHARED_16_oen),

// 
.SSP_SHARED_17_pad_0_pad(tbp_SSP_SHARED_17),
.SSP_SHARED_17_pad_0_c(p2c_SSP_SHARED_17),
.SSP_SHARED_17_pad_0_i(c2p_SSP_SHARED_17),
.SSP_SHARED_17_pad_0_oen(c2p_SSP_SHARED_17_oen),

// 
.SSP_SHARED_18_pad_0_pad(tbp_SSP_SHARED_18),
.SSP_SHARED_18_pad_0_c(p2c_SSP_SHARED_18),
.SSP_SHARED_18_pad_0_i(c2p_SSP_SHARED_18),
.SSP_SHARED_18_pad_0_oen(c2p_SSP_SHARED_18_oen),

// 
.SSP_SHARED_19_pad_0_pad(tbp_SSP_SHARED_19),
.SSP_SHARED_19_pad_0_c(p2c_SSP_SHARED_19),
.SSP_SHARED_19_pad_0_i(c2p_SSP_SHARED_19),
.SSP_SHARED_19_pad_0_oen(c2p_SSP_SHARED_19_oen),

// 
.SSP_SHARED_20_pad_0_pad(tbp_SSP_SHARED_20),
.SSP_SHARED_20_pad_0_c(p2c_SSP_SHARED_20),
.SSP_SHARED_20_pad_0_i(c2p_SSP_SHARED_20),
.SSP_SHARED_20_pad_0_oen(c2p_SSP_SHARED_20_oen),

// 
.SSP_SHARED_21_pad_0_pad(tbp_SSP_SHARED_21),
.SSP_SHARED_21_pad_0_c(p2c_SSP_SHARED_21),
.SSP_SHARED_21_pad_0_i(c2p_SSP_SHARED_21),
.SSP_SHARED_21_pad_0_oen(c2p_SSP_SHARED_21_oen),

// 
.SSP_SHARED_22_pad_0_pad(tbp_SSP_SHARED_22),
.SSP_SHARED_22_pad_0_c(p2c_SSP_SHARED_22),
.SSP_SHARED_22_pad_0_i(c2p_SSP_SHARED_22),
.SSP_SHARED_22_pad_0_oen(c2p_SSP_SHARED_22_oen),

// 
.SSP_SHARED_23_pad_0_pad(tbp_SSP_SHARED_23),
.SSP_SHARED_23_pad_0_c(p2c_SSP_SHARED_23),
.SSP_SHARED_23_pad_0_i(c2p_SSP_SHARED_23),
.SSP_SHARED_23_pad_0_oen(c2p_SSP_SHARED_23_oen),

// 
.SSP_SHARED_24_pad_0_pad(tbp_SSP_SHARED_24),
.SSP_SHARED_24_pad_0_c(p2c_SSP_SHARED_24),
.SSP_SHARED_24_pad_0_i(c2p_SSP_SHARED_24),
.SSP_SHARED_24_pad_0_oen(c2p_SSP_SHARED_24_oen),

// 
.SSP_SHARED_25_pad_0_pad(tbp_SSP_SHARED_25),
.SSP_SHARED_25_pad_0_c(p2c_SSP_SHARED_25),
.SSP_SHARED_25_pad_0_i(c2p_SSP_SHARED_25),
.SSP_SHARED_25_pad_0_oen(c2p_SSP_SHARED_25_oen),

// 
.SSP_SHARED_26_pad_0_pad(tbp_SSP_SHARED_26),
.SSP_SHARED_26_pad_0_c(p2c_SSP_SHARED_26),
.SSP_SHARED_26_pad_0_i(c2p_SSP_SHARED_26),
.SSP_SHARED_26_pad_0_oen(c2p_SSP_SHARED_26_oen),

// 
.SSP_SHARED_27_pad_0_pad(tbp_SSP_SHARED_27),
.SSP_SHARED_27_pad_0_c(p2c_SSP_SHARED_27),
.SSP_SHARED_27_pad_0_i(c2p_SSP_SHARED_27),
.SSP_SHARED_27_pad_0_oen(c2p_SSP_SHARED_27_oen),

// 
.SSP_SHARED_28_pad_0_pad(tbp_SSP_SHARED_28),
.SSP_SHARED_28_pad_0_c(p2c_SSP_SHARED_28),
.SSP_SHARED_28_pad_0_i(c2p_SSP_SHARED_28),
.SSP_SHARED_28_pad_0_oen(c2p_SSP_SHARED_28_oen),

// 
.SSP_SHARED_29_pad_0_pad(tbp_SSP_SHARED_29),
.SSP_SHARED_29_pad_0_c(p2c_SSP_SHARED_29),
.SSP_SHARED_29_pad_0_i(c2p_SSP_SHARED_29),
.SSP_SHARED_29_pad_0_oen(c2p_SSP_SHARED_29_oen),

// 
.SSP_SHARED_30_pad_0_pad(tbp_SSP_SHARED_30),
.SSP_SHARED_30_pad_0_c(p2c_SSP_SHARED_30),
.SSP_SHARED_30_pad_0_i(c2p_SSP_SHARED_30),
.SSP_SHARED_30_pad_0_oen(c2p_SSP_SHARED_30_oen),

// 
.SSP_SHARED_31_pad_0_pad(tbp_SSP_SHARED_31),
.SSP_SHARED_31_pad_0_c(p2c_SSP_SHARED_31),
.SSP_SHARED_31_pad_0_i(c2p_SSP_SHARED_31),
.SSP_SHARED_31_pad_0_oen(c2p_SSP_SHARED_31_oen),

// 
.SSP_SHARED_32_pad_0_pad(tbp_SSP_SHARED_32),
.SSP_SHARED_32_pad_0_c(p2c_SSP_SHARED_32),
.SSP_SHARED_32_pad_0_i(c2p_SSP_SHARED_32),
.SSP_SHARED_32_pad_0_oen(c2p_SSP_SHARED_32_oen),

// 
.SSP_SHARED_33_pad_0_pad(tbp_SSP_SHARED_33),
.SSP_SHARED_33_pad_0_c(p2c_SSP_SHARED_33),
.SSP_SHARED_33_pad_0_i(c2p_SSP_SHARED_33),
.SSP_SHARED_33_pad_0_oen(c2p_SSP_SHARED_33_oen),

// 
.SSP_SHARED_34_pad_0_pad(tbp_SSP_SHARED_34),
.SSP_SHARED_34_pad_0_c(p2c_SSP_SHARED_34),
.SSP_SHARED_34_pad_0_i(c2p_SSP_SHARED_34),
.SSP_SHARED_34_pad_0_oen(c2p_SSP_SHARED_34_oen),

// 
.SSP_SHARED_35_pad_0_pad(tbp_SSP_SHARED_35),
.SSP_SHARED_35_pad_0_c(p2c_SSP_SHARED_35),
.SSP_SHARED_35_pad_0_i(c2p_SSP_SHARED_35),
.SSP_SHARED_35_pad_0_oen(c2p_SSP_SHARED_35_oen),

// 
.SSP_SHARED_36_pad_0_pad(tbp_SSP_SHARED_36),
.SSP_SHARED_36_pad_0_c(p2c_SSP_SHARED_36),
.SSP_SHARED_36_pad_0_i(c2p_SSP_SHARED_36),
.SSP_SHARED_36_pad_0_oen(c2p_SSP_SHARED_36_oen),

// 
.SSP_SHARED_37_pad_0_pad(tbp_SSP_SHARED_37),
.SSP_SHARED_37_pad_0_c(p2c_SSP_SHARED_37),
.SSP_SHARED_37_pad_0_i(c2p_SSP_SHARED_37),
.SSP_SHARED_37_pad_0_oen(c2p_SSP_SHARED_37_oen),

// 
.SSP_SHARED_38_pad_0_pad(tbp_SSP_SHARED_38),
.SSP_SHARED_38_pad_0_c(p2c_SSP_SHARED_38),
.SSP_SHARED_38_pad_0_i(c2p_SSP_SHARED_38),
.SSP_SHARED_38_pad_0_oen(c2p_SSP_SHARED_38_oen),

// 
.SSP_SHARED_39_pad_0_pad(tbp_SSP_SHARED_39),
.SSP_SHARED_39_pad_0_c(p2c_SSP_SHARED_39),
.SSP_SHARED_39_pad_0_i(c2p_SSP_SHARED_39),
.SSP_SHARED_39_pad_0_oen(c2p_SSP_SHARED_39_oen),

// 
.SSP_SHARED_40_pad_0_pad(tbp_SSP_SHARED_40),
.SSP_SHARED_40_pad_0_c(p2c_SSP_SHARED_40),
.SSP_SHARED_40_pad_0_i(c2p_SSP_SHARED_40),
.SSP_SHARED_40_pad_0_oen(c2p_SSP_SHARED_40_oen),

// 
.SSP_SHARED_41_pad_0_pad(tbp_SSP_SHARED_41),
.SSP_SHARED_41_pad_0_c(p2c_SSP_SHARED_41),
.SSP_SHARED_41_pad_0_i(c2p_SSP_SHARED_41),
.SSP_SHARED_41_pad_0_oen(c2p_SSP_SHARED_41_oen),

// 
.SSP_SHARED_42_pad_0_pad(tbp_SSP_SHARED_42),
.SSP_SHARED_42_pad_0_c(p2c_SSP_SHARED_42),
.SSP_SHARED_42_pad_0_i(c2p_SSP_SHARED_42),
.SSP_SHARED_42_pad_0_oen(c2p_SSP_SHARED_42_oen),

// 
.SSP_SHARED_43_pad_0_pad(tbp_SSP_SHARED_43),
.SSP_SHARED_43_pad_0_c(p2c_SSP_SHARED_43),
.SSP_SHARED_43_pad_0_i(c2p_SSP_SHARED_43),
.SSP_SHARED_43_pad_0_oen(c2p_SSP_SHARED_43_oen),

// 
.SSP_SHARED_44_pad_0_pad(tbp_SSP_SHARED_44),
.SSP_SHARED_44_pad_0_c(p2c_SSP_SHARED_44),
.SSP_SHARED_44_pad_0_i(c2p_SSP_SHARED_44),
.SSP_SHARED_44_pad_0_oen(c2p_SSP_SHARED_44_oen),

// 
.SSP_SHARED_45_pad_0_pad(tbp_SSP_SHARED_45),
.SSP_SHARED_45_pad_0_c(p2c_SSP_SHARED_45),
.SSP_SHARED_45_pad_0_i(c2p_SSP_SHARED_45),
.SSP_SHARED_45_pad_0_oen(c2p_SSP_SHARED_45_oen),

// 
.SSP_SHARED_46_pad_0_pad(tbp_SSP_SHARED_46),
.SSP_SHARED_46_pad_0_c(p2c_SSP_SHARED_46),
.SSP_SHARED_46_pad_0_i(c2p_SSP_SHARED_46),
.SSP_SHARED_46_pad_0_oen(c2p_SSP_SHARED_46_oen),

// 
.SSP_SHARED_47_pad_0_pad(tbp_SSP_SHARED_47),
.SSP_SHARED_47_pad_0_c(p2c_SSP_SHARED_47),
.SSP_SHARED_47_pad_0_i(c2p_SSP_SHARED_47),
.SSP_SHARED_47_pad_0_oen(c2p_SSP_SHARED_47_oen));

io_muxes io_muxes_u (.*);
endmodule

module io_pads (
inout refclk_pad_0_pad,
output refclk_pad_0_c,
inout rtcclk_pad_0_pad,
output rtcclk_pad_0_c,
inout reset_n_pad_0_pad,
output reset_n_pad_0_c,
inout scan_ate_clk_pad_0_pad,
output scan_ate_clk_pad_0_c,
inout scan_mode_pad_0_pad,
output scan_mode_pad_0_c,
inout scan_tap_compliance_pad_0_pad,
output scan_tap_compliance_pad_0_c,
inout scan_f_clk_pad_0_pad,
output scan_f_clk_pad_0_c,
inout sd_cmd_in_out_pad_0_pad,
input sd_cmd_in_out_pad_0_i,
input sd_cmd_in_out_pad_0_oen,
output sd_cmd_in_out_pad_0_c,
inout sd_dat_in_out_pad_0_pad,
input sd_dat_in_out_pad_0_i,
input sd_dat_in_out_pad_0_oen,
output sd_dat_in_out_pad_0_c,
inout sd_dat_in_out_pad_1_pad,
input sd_dat_in_out_pad_1_i,
input sd_dat_in_out_pad_1_oen,
output sd_dat_in_out_pad_1_c,
inout sd_dat_in_out_pad_2_pad,
input sd_dat_in_out_pad_2_i,
input sd_dat_in_out_pad_2_oen,
output sd_dat_in_out_pad_2_c,
inout sd_dat_in_out_pad_3_pad,
input sd_dat_in_out_pad_3_i,
input sd_dat_in_out_pad_3_oen,
output sd_dat_in_out_pad_3_c,
inout sd_clk_pad_0_pad,
input sd_clk_pad_0_i,
input sd_clk_pad_0_oen,
output sd_clk_pad_0_c,
inout sd_card_detect_n_pad_0_pad,
output sd_card_detect_n_pad_0_c,
inout sd_card_write_prot_pad_0_pad,
output sd_card_write_prot_pad_0_c,
inout test_io_clk_pad_0_pad,
input test_io_clk_pad_0_i,
input test_io_clk_pad_0_oen,
output test_io_clk_pad_0_c,
inout test_io_en_pad_0_pad,
input test_io_en_pad_0_i,
input test_io_en_pad_0_oen,
output test_io_en_pad_0_c,
inout test_io_data_pad_0_pad,
input test_io_data_pad_0_i,
input test_io_data_pad_0_oen,
output test_io_data_pad_0_c,
inout jtag_tck_pad_0_pad,
output jtag_tck_pad_0_c,
inout jtag_tdi_pad_0_pad,
output jtag_tdi_pad_0_c,
inout jtag_tdo_pad_0_pad,
input jtag_tdo_pad_0_i,
input jtag_tdo_pad_0_oen,
output jtag_tdo_pad_0_c,
inout jtag_tms_pad_0_pad,
output jtag_tms_pad_0_c,
inout jtag_trst_n_pad_0_pad,
output jtag_trst_n_pad_0_c,
inout qspim_sclk_out_pad_0_pad,
input qspim_sclk_out_pad_0_i,
inout qspim_trxd_pad_0_pad,
input qspim_trxd_pad_0_i,
input qspim_trxd_pad_0_oen,
output qspim_trxd_pad_0_c,
inout qspim_trxd_pad_1_pad,
input qspim_trxd_pad_1_i,
input qspim_trxd_pad_1_oen,
output qspim_trxd_pad_1_c,
inout qspim_trxd_pad_2_pad,
input qspim_trxd_pad_2_i,
input qspim_trxd_pad_2_oen,
output qspim_trxd_pad_2_c,
inout qspim_trxd_pad_3_pad,
input qspim_trxd_pad_3_i,
input qspim_trxd_pad_3_oen,
output qspim_trxd_pad_3_c,
inout qspim_ss_pad_0_pad,
input qspim_ss_pad_0_i,
inout sspim0_sclk_out_pad_0_pad,
input sspim0_sclk_out_pad_0_i,
inout sspim0_rxd_pad_0_pad,
output sspim0_rxd_pad_0_c,
inout sspim0_txd_pad_0_pad,
input sspim0_txd_pad_0_i,
inout sspim0_ss_pad_0_pad,
input sspim0_ss_pad_0_i,
inout uart1_sin_pad_0_pad,
output uart1_sin_pad_0_c,
inout uart1_sout_pad_0_pad,
input uart1_sout_pad_0_i,
inout uart2_sin_pad_0_pad,
output uart2_sin_pad_0_c,
inout uart2_sout_pad_0_pad,
input uart2_sout_pad_0_i,
inout i2c0_ic_clk_pad_0_pad,
input i2c0_ic_clk_pad_0_i,
input i2c0_ic_clk_pad_0_oen,
output i2c0_ic_clk_pad_0_c,
inout i2c0_ic_data_pad_0_pad,
input i2c0_ic_data_pad_0_i,
input i2c0_ic_data_pad_0_oen,
output i2c0_ic_data_pad_0_c,
inout refclk_en_pad_0_pad,
input refclk_en_pad_0_i,
inout SSP_SHARED_0_pad_0_pad,
input SSP_SHARED_0_pad_0_i,
input SSP_SHARED_0_pad_0_oen,
output SSP_SHARED_0_pad_0_c,
inout SSP_SHARED_1_pad_0_pad,
input SSP_SHARED_1_pad_0_i,
inout SSP_SHARED_2_pad_0_pad,
input SSP_SHARED_2_pad_0_i,
inout SSP_SHARED_3_pad_0_pad,
input SSP_SHARED_3_pad_0_i,
input SSP_SHARED_3_pad_0_oen,
output SSP_SHARED_3_pad_0_c,
inout SSP_SHARED_4_pad_0_pad,
input SSP_SHARED_4_pad_0_i,
input SSP_SHARED_4_pad_0_oen,
output SSP_SHARED_4_pad_0_c,
inout SSP_SHARED_5_pad_0_pad,
input SSP_SHARED_5_pad_0_i,
input SSP_SHARED_5_pad_0_oen,
output SSP_SHARED_5_pad_0_c,
inout SSP_SHARED_6_pad_0_pad,
input SSP_SHARED_6_pad_0_i,
inout SSP_SHARED_7_pad_0_pad,
input SSP_SHARED_7_pad_0_i,
input SSP_SHARED_7_pad_0_oen,
output SSP_SHARED_7_pad_0_c,
inout SSP_SHARED_8_pad_0_pad,
input SSP_SHARED_8_pad_0_i,
input SSP_SHARED_8_pad_0_oen,
output SSP_SHARED_8_pad_0_c,
inout SSP_SHARED_9_pad_0_pad,
input SSP_SHARED_9_pad_0_i,
input SSP_SHARED_9_pad_0_oen,
output SSP_SHARED_9_pad_0_c,
inout SSP_SHARED_10_pad_0_pad,
output SSP_SHARED_10_pad_0_c,
inout SSP_SHARED_11_pad_0_pad,
output SSP_SHARED_11_pad_0_c,
inout SSP_SHARED_12_pad_0_pad,
input SSP_SHARED_12_pad_0_i,
inout SSP_SHARED_13_pad_0_pad,
input SSP_SHARED_13_pad_0_i,
input SSP_SHARED_13_pad_0_oen,
output SSP_SHARED_13_pad_0_c,
inout SSP_SHARED_14_pad_0_pad,
output SSP_SHARED_14_pad_0_c,
inout SSP_SHARED_15_pad_0_pad,
input SSP_SHARED_15_pad_0_i,
input SSP_SHARED_15_pad_0_oen,
output SSP_SHARED_15_pad_0_c,
inout SSP_SHARED_16_pad_0_pad,
input SSP_SHARED_16_pad_0_i,
input SSP_SHARED_16_pad_0_oen,
output SSP_SHARED_16_pad_0_c,
inout SSP_SHARED_17_pad_0_pad,
input SSP_SHARED_17_pad_0_i,
input SSP_SHARED_17_pad_0_oen,
output SSP_SHARED_17_pad_0_c,
inout SSP_SHARED_18_pad_0_pad,
input SSP_SHARED_18_pad_0_i,
input SSP_SHARED_18_pad_0_oen,
output SSP_SHARED_18_pad_0_c,
inout SSP_SHARED_19_pad_0_pad,
input SSP_SHARED_19_pad_0_i,
input SSP_SHARED_19_pad_0_oen,
output SSP_SHARED_19_pad_0_c,
inout SSP_SHARED_20_pad_0_pad,
input SSP_SHARED_20_pad_0_i,
input SSP_SHARED_20_pad_0_oen,
output SSP_SHARED_20_pad_0_c,
inout SSP_SHARED_21_pad_0_pad,
input SSP_SHARED_21_pad_0_i,
input SSP_SHARED_21_pad_0_oen,
output SSP_SHARED_21_pad_0_c,
inout SSP_SHARED_22_pad_0_pad,
input SSP_SHARED_22_pad_0_i,
input SSP_SHARED_22_pad_0_oen,
output SSP_SHARED_22_pad_0_c,
inout SSP_SHARED_23_pad_0_pad,
input SSP_SHARED_23_pad_0_i,
input SSP_SHARED_23_pad_0_oen,
output SSP_SHARED_23_pad_0_c,
inout SSP_SHARED_24_pad_0_pad,
input SSP_SHARED_24_pad_0_i,
input SSP_SHARED_24_pad_0_oen,
output SSP_SHARED_24_pad_0_c,
inout SSP_SHARED_25_pad_0_pad,
input SSP_SHARED_25_pad_0_i,
input SSP_SHARED_25_pad_0_oen,
output SSP_SHARED_25_pad_0_c,
inout SSP_SHARED_26_pad_0_pad,
input SSP_SHARED_26_pad_0_i,
input SSP_SHARED_26_pad_0_oen,
output SSP_SHARED_26_pad_0_c,
inout SSP_SHARED_27_pad_0_pad,
input SSP_SHARED_27_pad_0_i,
input SSP_SHARED_27_pad_0_oen,
output SSP_SHARED_27_pad_0_c,
inout SSP_SHARED_28_pad_0_pad,
input SSP_SHARED_28_pad_0_i,
input SSP_SHARED_28_pad_0_oen,
output SSP_SHARED_28_pad_0_c,
inout SSP_SHARED_29_pad_0_pad,
input SSP_SHARED_29_pad_0_i,
input SSP_SHARED_29_pad_0_oen,
output SSP_SHARED_29_pad_0_c,
inout SSP_SHARED_30_pad_0_pad,
input SSP_SHARED_30_pad_0_i,
input SSP_SHARED_30_pad_0_oen,
output SSP_SHARED_30_pad_0_c,
inout SSP_SHARED_31_pad_0_pad,
input SSP_SHARED_31_pad_0_i,
input SSP_SHARED_31_pad_0_oen,
output SSP_SHARED_31_pad_0_c,
inout SSP_SHARED_32_pad_0_pad,
input SSP_SHARED_32_pad_0_i,
input SSP_SHARED_32_pad_0_oen,
output SSP_SHARED_32_pad_0_c,
inout SSP_SHARED_33_pad_0_pad,
input SSP_SHARED_33_pad_0_i,
input SSP_SHARED_33_pad_0_oen,
output SSP_SHARED_33_pad_0_c,
inout SSP_SHARED_34_pad_0_pad,
input SSP_SHARED_34_pad_0_i,
input SSP_SHARED_34_pad_0_oen,
output SSP_SHARED_34_pad_0_c,
inout SSP_SHARED_35_pad_0_pad,
input SSP_SHARED_35_pad_0_i,
input SSP_SHARED_35_pad_0_oen,
output SSP_SHARED_35_pad_0_c,
inout SSP_SHARED_36_pad_0_pad,
input SSP_SHARED_36_pad_0_i,
input SSP_SHARED_36_pad_0_oen,
output SSP_SHARED_36_pad_0_c,
inout SSP_SHARED_37_pad_0_pad,
input SSP_SHARED_37_pad_0_i,
input SSP_SHARED_37_pad_0_oen,
output SSP_SHARED_37_pad_0_c,
inout SSP_SHARED_38_pad_0_pad,
input SSP_SHARED_38_pad_0_i,
input SSP_SHARED_38_pad_0_oen,
output SSP_SHARED_38_pad_0_c,
inout SSP_SHARED_39_pad_0_pad,
input SSP_SHARED_39_pad_0_i,
input SSP_SHARED_39_pad_0_oen,
output SSP_SHARED_39_pad_0_c,
inout SSP_SHARED_40_pad_0_pad,
input SSP_SHARED_40_pad_0_i,
input SSP_SHARED_40_pad_0_oen,
output SSP_SHARED_40_pad_0_c,
inout SSP_SHARED_41_pad_0_pad,
input SSP_SHARED_41_pad_0_i,
input SSP_SHARED_41_pad_0_oen,
output SSP_SHARED_41_pad_0_c,
inout SSP_SHARED_42_pad_0_pad,
input SSP_SHARED_42_pad_0_i,
input SSP_SHARED_42_pad_0_oen,
output SSP_SHARED_42_pad_0_c,
inout SSP_SHARED_43_pad_0_pad,
input SSP_SHARED_43_pad_0_i,
input SSP_SHARED_43_pad_0_oen,
output SSP_SHARED_43_pad_0_c,
inout SSP_SHARED_44_pad_0_pad,
input SSP_SHARED_44_pad_0_i,
input SSP_SHARED_44_pad_0_oen,
output SSP_SHARED_44_pad_0_c,
inout SSP_SHARED_45_pad_0_pad,
input SSP_SHARED_45_pad_0_i,
input SSP_SHARED_45_pad_0_oen,
output SSP_SHARED_45_pad_0_c,
inout SSP_SHARED_46_pad_0_pad,
input SSP_SHARED_46_pad_0_i,
input SSP_SHARED_46_pad_0_oen,
output SSP_SHARED_46_pad_0_c,
inout SSP_SHARED_47_pad_0_pad,
input SSP_SHARED_47_pad_0_i,
input SSP_SHARED_47_pad_0_oen,
output SSP_SHARED_47_pad_0_c
);

PDDW12SDGZ_V_G refclk_pad_0 (.PAD(refclk_pad_0_pad), .C(refclk_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G rtcclk_pad_0 (.PAD(rtcclk_pad_0_pad), .C(rtcclk_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G reset_n_pad_0 (.PAD(reset_n_pad_0_pad), .C(reset_n_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G scan_ate_clk_pad_0 (.PAD(scan_ate_clk_pad_0_pad), .C(scan_ate_clk_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G scan_mode_pad_0 (.PAD(scan_mode_pad_0_pad), .C(scan_mode_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G scan_tap_compliance_pad_0 (.PAD(scan_tap_compliance_pad_0_pad), .C(scan_tap_compliance_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G scan_f_clk_pad_0 (.PAD(scan_f_clk_pad_0_pad), .C(scan_f_clk_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G sd_cmd_in_out_pad_0 (.PAD(sd_cmd_in_out_pad_0_pad), .C(sd_cmd_in_out_pad_0_c), .REN(1'b1), .I(sd_cmd_in_out_pad_0_i), .OEN(sd_cmd_in_out_pad_0_oen));

PDDW12SDGZ_V_G sd_dat_in_out_pad_0 (.PAD(sd_dat_in_out_pad_0_pad), .C(sd_dat_in_out_pad_0_c), .REN(1'b1), .I(sd_dat_in_out_pad_0_i), .OEN(sd_dat_in_out_pad_0_oen));
PDDW12SDGZ_V_G sd_dat_in_out_pad_1 (.PAD(sd_dat_in_out_pad_1_pad), .C(sd_dat_in_out_pad_1_c), .REN(1'b1), .I(sd_dat_in_out_pad_1_i), .OEN(sd_dat_in_out_pad_1_oen));
PDDW12SDGZ_V_G sd_dat_in_out_pad_2 (.PAD(sd_dat_in_out_pad_2_pad), .C(sd_dat_in_out_pad_2_c), .REN(1'b1), .I(sd_dat_in_out_pad_2_i), .OEN(sd_dat_in_out_pad_2_oen));
PDDW12SDGZ_V_G sd_dat_in_out_pad_3 (.PAD(sd_dat_in_out_pad_3_pad), .C(sd_dat_in_out_pad_3_c), .REN(1'b1), .I(sd_dat_in_out_pad_3_i), .OEN(sd_dat_in_out_pad_3_oen));

PDDW12SDGZ_V_G sd_clk_pad_0 (.PAD(sd_clk_pad_0_pad), .C(sd_clk_pad_0_c), .REN(1'b1), .I(sd_clk_pad_0_i), .OEN(sd_clk_pad_0_oen));

PDDW12SDGZ_V_G sd_card_detect_n_pad_0 (.PAD(sd_card_detect_n_pad_0_pad), .C(sd_card_detect_n_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G sd_card_write_prot_pad_0 (.PAD(sd_card_write_prot_pad_0_pad), .C(sd_card_write_prot_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G test_io_clk_pad_0 (.PAD(test_io_clk_pad_0_pad), .C(test_io_clk_pad_0_c), .REN(1'b1), .I(test_io_clk_pad_0_i), .OEN(test_io_clk_pad_0_oen));

PDDW12SDGZ_V_G test_io_en_pad_0 (.PAD(test_io_en_pad_0_pad), .C(test_io_en_pad_0_c), .REN(1'b1), .I(test_io_en_pad_0_i), .OEN(test_io_en_pad_0_oen));

PDDW12SDGZ_V_G test_io_data_pad_0 (.PAD(test_io_data_pad_0_pad), .C(test_io_data_pad_0_c), .REN(1'b1), .I(test_io_data_pad_0_i), .OEN(test_io_data_pad_0_oen));

PDDW12SDGZ_V_G jtag_tck_pad_0 (.PAD(jtag_tck_pad_0_pad), .C(jtag_tck_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G jtag_tdi_pad_0 (.PAD(jtag_tdi_pad_0_pad), .C(jtag_tdi_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G jtag_tdo_pad_0 (.PAD(jtag_tdo_pad_0_pad), .C(jtag_tdo_pad_0_c), .REN(1'b1), .I(jtag_tdo_pad_0_i), .OEN(jtag_tdo_pad_0_oen));

PDDW12SDGZ_V_G jtag_tms_pad_0 (.PAD(jtag_tms_pad_0_pad), .C(jtag_tms_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G jtag_trst_n_pad_0 (.PAD(jtag_trst_n_pad_0_pad), .C(jtag_trst_n_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G qspim_sclk_out_pad_0 (.PAD(qspim_sclk_out_pad_0_pad), .C(), .REN(1'b1), .I(qspim_sclk_out_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G qspim_trxd_pad_0 (.PAD(qspim_trxd_pad_0_pad), .C(qspim_trxd_pad_0_c), .REN(1'b1), .I(qspim_trxd_pad_0_i), .OEN(qspim_trxd_pad_0_oen));
PDDW12SDGZ_V_G qspim_trxd_pad_1 (.PAD(qspim_trxd_pad_1_pad), .C(qspim_trxd_pad_1_c), .REN(1'b1), .I(qspim_trxd_pad_1_i), .OEN(qspim_trxd_pad_1_oen));
PDDW12SDGZ_V_G qspim_trxd_pad_2 (.PAD(qspim_trxd_pad_2_pad), .C(qspim_trxd_pad_2_c), .REN(1'b1), .I(qspim_trxd_pad_2_i), .OEN(qspim_trxd_pad_2_oen));
PDDW12SDGZ_V_G qspim_trxd_pad_3 (.PAD(qspim_trxd_pad_3_pad), .C(qspim_trxd_pad_3_c), .REN(1'b1), .I(qspim_trxd_pad_3_i), .OEN(qspim_trxd_pad_3_oen));

PDDW12SDGZ_V_G qspim_ss_pad_0 (.PAD(qspim_ss_pad_0_pad), .C(), .REN(1'b1), .I(qspim_ss_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G sspim0_sclk_out_pad_0 (.PAD(sspim0_sclk_out_pad_0_pad), .C(), .REN(1'b1), .I(sspim0_sclk_out_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G sspim0_rxd_pad_0 (.PAD(sspim0_rxd_pad_0_pad), .C(sspim0_rxd_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G sspim0_txd_pad_0 (.PAD(sspim0_txd_pad_0_pad), .C(), .REN(1'b1), .I(sspim0_txd_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G sspim0_ss_pad_0 (.PAD(sspim0_ss_pad_0_pad), .C(), .REN(1'b1), .I(sspim0_ss_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G uart1_sin_pad_0 (.PAD(uart1_sin_pad_0_pad), .C(uart1_sin_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G uart1_sout_pad_0 (.PAD(uart1_sout_pad_0_pad), .C(), .REN(1'b1), .I(uart1_sout_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G uart2_sin_pad_0 (.PAD(uart2_sin_pad_0_pad), .C(uart2_sin_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G uart2_sout_pad_0 (.PAD(uart2_sout_pad_0_pad), .C(), .REN(1'b1), .I(uart2_sout_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G i2c0_ic_clk_pad_0 (.PAD(i2c0_ic_clk_pad_0_pad), .C(i2c0_ic_clk_pad_0_c), .REN(1'b1), .I(i2c0_ic_clk_pad_0_i), .OEN(i2c0_ic_clk_pad_0_oen));

PDDW12SDGZ_V_G i2c0_ic_data_pad_0 (.PAD(i2c0_ic_data_pad_0_pad), .C(i2c0_ic_data_pad_0_c), .REN(1'b1), .I(i2c0_ic_data_pad_0_i), .OEN(i2c0_ic_data_pad_0_oen));

PDDW12SDGZ_V_G refclk_en_pad_0 (.PAD(refclk_en_pad_0_pad), .C(), .REN(1'b1), .I(refclk_en_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G SSP_SHARED_0_pad_0 (.PAD(SSP_SHARED_0_pad_0_pad), .C(SSP_SHARED_0_pad_0_c), .REN(1'b1), .I(SSP_SHARED_0_pad_0_i), .OEN(SSP_SHARED_0_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_1_pad_0 (.PAD(SSP_SHARED_1_pad_0_pad), .C(), .REN(1'b1), .I(SSP_SHARED_1_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G SSP_SHARED_2_pad_0 (.PAD(SSP_SHARED_2_pad_0_pad), .C(), .REN(1'b1), .I(SSP_SHARED_2_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G SSP_SHARED_3_pad_0 (.PAD(SSP_SHARED_3_pad_0_pad), .C(SSP_SHARED_3_pad_0_c), .REN(1'b1), .I(SSP_SHARED_3_pad_0_i), .OEN(SSP_SHARED_3_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_4_pad_0 (.PAD(SSP_SHARED_4_pad_0_pad), .C(SSP_SHARED_4_pad_0_c), .REN(1'b1), .I(SSP_SHARED_4_pad_0_i), .OEN(SSP_SHARED_4_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_5_pad_0 (.PAD(SSP_SHARED_5_pad_0_pad), .C(SSP_SHARED_5_pad_0_c), .REN(1'b1), .I(SSP_SHARED_5_pad_0_i), .OEN(SSP_SHARED_5_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_6_pad_0 (.PAD(SSP_SHARED_6_pad_0_pad), .C(), .REN(1'b1), .I(SSP_SHARED_6_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G SSP_SHARED_7_pad_0 (.PAD(SSP_SHARED_7_pad_0_pad), .C(SSP_SHARED_7_pad_0_c), .REN(1'b1), .I(SSP_SHARED_7_pad_0_i), .OEN(SSP_SHARED_7_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_8_pad_0 (.PAD(SSP_SHARED_8_pad_0_pad), .C(SSP_SHARED_8_pad_0_c), .REN(1'b1), .I(SSP_SHARED_8_pad_0_i), .OEN(SSP_SHARED_8_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_9_pad_0 (.PAD(SSP_SHARED_9_pad_0_pad), .C(SSP_SHARED_9_pad_0_c), .REN(1'b1), .I(SSP_SHARED_9_pad_0_i), .OEN(SSP_SHARED_9_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_10_pad_0 (.PAD(SSP_SHARED_10_pad_0_pad), .C(SSP_SHARED_10_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G SSP_SHARED_11_pad_0 (.PAD(SSP_SHARED_11_pad_0_pad), .C(SSP_SHARED_11_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G SSP_SHARED_12_pad_0 (.PAD(SSP_SHARED_12_pad_0_pad), .C(), .REN(1'b1), .I(SSP_SHARED_12_pad_0_i), .OEN(1'b0));

PDDW12SDGZ_V_G SSP_SHARED_13_pad_0 (.PAD(SSP_SHARED_13_pad_0_pad), .C(SSP_SHARED_13_pad_0_c), .REN(1'b1), .I(SSP_SHARED_13_pad_0_i), .OEN(SSP_SHARED_13_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_14_pad_0 (.PAD(SSP_SHARED_14_pad_0_pad), .C(SSP_SHARED_14_pad_0_c), .REN(1'b1), .I(1'b0), .OEN(1'b1));

PDDW12SDGZ_V_G SSP_SHARED_15_pad_0 (.PAD(SSP_SHARED_15_pad_0_pad), .C(SSP_SHARED_15_pad_0_c), .REN(1'b1), .I(SSP_SHARED_15_pad_0_i), .OEN(SSP_SHARED_15_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_16_pad_0 (.PAD(SSP_SHARED_16_pad_0_pad), .C(SSP_SHARED_16_pad_0_c), .REN(1'b1), .I(SSP_SHARED_16_pad_0_i), .OEN(SSP_SHARED_16_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_17_pad_0 (.PAD(SSP_SHARED_17_pad_0_pad), .C(SSP_SHARED_17_pad_0_c), .REN(1'b1), .I(SSP_SHARED_17_pad_0_i), .OEN(SSP_SHARED_17_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_18_pad_0 (.PAD(SSP_SHARED_18_pad_0_pad), .C(SSP_SHARED_18_pad_0_c), .REN(1'b1), .I(SSP_SHARED_18_pad_0_i), .OEN(SSP_SHARED_18_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_19_pad_0 (.PAD(SSP_SHARED_19_pad_0_pad), .C(SSP_SHARED_19_pad_0_c), .REN(1'b1), .I(SSP_SHARED_19_pad_0_i), .OEN(SSP_SHARED_19_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_20_pad_0 (.PAD(SSP_SHARED_20_pad_0_pad), .C(SSP_SHARED_20_pad_0_c), .REN(1'b1), .I(SSP_SHARED_20_pad_0_i), .OEN(SSP_SHARED_20_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_21_pad_0 (.PAD(SSP_SHARED_21_pad_0_pad), .C(SSP_SHARED_21_pad_0_c), .REN(1'b1), .I(SSP_SHARED_21_pad_0_i), .OEN(SSP_SHARED_21_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_22_pad_0 (.PAD(SSP_SHARED_22_pad_0_pad), .C(SSP_SHARED_22_pad_0_c), .REN(1'b1), .I(SSP_SHARED_22_pad_0_i), .OEN(SSP_SHARED_22_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_23_pad_0 (.PAD(SSP_SHARED_23_pad_0_pad), .C(SSP_SHARED_23_pad_0_c), .REN(1'b1), .I(SSP_SHARED_23_pad_0_i), .OEN(SSP_SHARED_23_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_24_pad_0 (.PAD(SSP_SHARED_24_pad_0_pad), .C(SSP_SHARED_24_pad_0_c), .REN(1'b1), .I(SSP_SHARED_24_pad_0_i), .OEN(SSP_SHARED_24_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_25_pad_0 (.PAD(SSP_SHARED_25_pad_0_pad), .C(SSP_SHARED_25_pad_0_c), .REN(1'b1), .I(SSP_SHARED_25_pad_0_i), .OEN(SSP_SHARED_25_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_26_pad_0 (.PAD(SSP_SHARED_26_pad_0_pad), .C(SSP_SHARED_26_pad_0_c), .REN(1'b1), .I(SSP_SHARED_26_pad_0_i), .OEN(SSP_SHARED_26_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_27_pad_0 (.PAD(SSP_SHARED_27_pad_0_pad), .C(SSP_SHARED_27_pad_0_c), .REN(1'b1), .I(SSP_SHARED_27_pad_0_i), .OEN(SSP_SHARED_27_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_28_pad_0 (.PAD(SSP_SHARED_28_pad_0_pad), .C(SSP_SHARED_28_pad_0_c), .REN(1'b1), .I(SSP_SHARED_28_pad_0_i), .OEN(SSP_SHARED_28_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_29_pad_0 (.PAD(SSP_SHARED_29_pad_0_pad), .C(SSP_SHARED_29_pad_0_c), .REN(1'b1), .I(SSP_SHARED_29_pad_0_i), .OEN(SSP_SHARED_29_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_30_pad_0 (.PAD(SSP_SHARED_30_pad_0_pad), .C(SSP_SHARED_30_pad_0_c), .REN(1'b1), .I(SSP_SHARED_30_pad_0_i), .OEN(SSP_SHARED_30_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_31_pad_0 (.PAD(SSP_SHARED_31_pad_0_pad), .C(SSP_SHARED_31_pad_0_c), .REN(1'b1), .I(SSP_SHARED_31_pad_0_i), .OEN(SSP_SHARED_31_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_32_pad_0 (.PAD(SSP_SHARED_32_pad_0_pad), .C(SSP_SHARED_32_pad_0_c), .REN(1'b1), .I(SSP_SHARED_32_pad_0_i), .OEN(SSP_SHARED_32_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_33_pad_0 (.PAD(SSP_SHARED_33_pad_0_pad), .C(SSP_SHARED_33_pad_0_c), .REN(1'b1), .I(SSP_SHARED_33_pad_0_i), .OEN(SSP_SHARED_33_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_34_pad_0 (.PAD(SSP_SHARED_34_pad_0_pad), .C(SSP_SHARED_34_pad_0_c), .REN(1'b1), .I(SSP_SHARED_34_pad_0_i), .OEN(SSP_SHARED_34_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_35_pad_0 (.PAD(SSP_SHARED_35_pad_0_pad), .C(SSP_SHARED_35_pad_0_c), .REN(1'b1), .I(SSP_SHARED_35_pad_0_i), .OEN(SSP_SHARED_35_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_36_pad_0 (.PAD(SSP_SHARED_36_pad_0_pad), .C(SSP_SHARED_36_pad_0_c), .REN(1'b1), .I(SSP_SHARED_36_pad_0_i), .OEN(SSP_SHARED_36_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_37_pad_0 (.PAD(SSP_SHARED_37_pad_0_pad), .C(SSP_SHARED_37_pad_0_c), .REN(1'b1), .I(SSP_SHARED_37_pad_0_i), .OEN(SSP_SHARED_37_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_38_pad_0 (.PAD(SSP_SHARED_38_pad_0_pad), .C(SSP_SHARED_38_pad_0_c), .REN(1'b1), .I(SSP_SHARED_38_pad_0_i), .OEN(SSP_SHARED_38_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_39_pad_0 (.PAD(SSP_SHARED_39_pad_0_pad), .C(SSP_SHARED_39_pad_0_c), .REN(1'b1), .I(SSP_SHARED_39_pad_0_i), .OEN(SSP_SHARED_39_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_40_pad_0 (.PAD(SSP_SHARED_40_pad_0_pad), .C(SSP_SHARED_40_pad_0_c), .REN(1'b1), .I(SSP_SHARED_40_pad_0_i), .OEN(SSP_SHARED_40_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_41_pad_0 (.PAD(SSP_SHARED_41_pad_0_pad), .C(SSP_SHARED_41_pad_0_c), .REN(1'b1), .I(SSP_SHARED_41_pad_0_i), .OEN(SSP_SHARED_41_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_42_pad_0 (.PAD(SSP_SHARED_42_pad_0_pad), .C(SSP_SHARED_42_pad_0_c), .REN(1'b1), .I(SSP_SHARED_42_pad_0_i), .OEN(SSP_SHARED_42_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_43_pad_0 (.PAD(SSP_SHARED_43_pad_0_pad), .C(SSP_SHARED_43_pad_0_c), .REN(1'b1), .I(SSP_SHARED_43_pad_0_i), .OEN(SSP_SHARED_43_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_44_pad_0 (.PAD(SSP_SHARED_44_pad_0_pad), .C(SSP_SHARED_44_pad_0_c), .REN(1'b1), .I(SSP_SHARED_44_pad_0_i), .OEN(SSP_SHARED_44_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_45_pad_0 (.PAD(SSP_SHARED_45_pad_0_pad), .C(SSP_SHARED_45_pad_0_c), .REN(1'b1), .I(SSP_SHARED_45_pad_0_i), .OEN(SSP_SHARED_45_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_46_pad_0 (.PAD(SSP_SHARED_46_pad_0_pad), .C(SSP_SHARED_46_pad_0_c), .REN(1'b1), .I(SSP_SHARED_46_pad_0_i), .OEN(SSP_SHARED_46_pad_0_oen));

PDDW12SDGZ_V_G SSP_SHARED_47_pad_0 (.PAD(SSP_SHARED_47_pad_0_pad), .C(SSP_SHARED_47_pad_0_c), .REN(1'b1), .I(SSP_SHARED_47_pad_0_i), .OEN(SSP_SHARED_47_pad_0_oen));
endmodule
module io_muxes (

input wire [2 - 1 : 0] SSP_SHARED_sel_0,
input wire [2 - 1 : 0] SSP_SHARED_sel_1,
input wire [2 - 1 : 0] SSP_SHARED_sel_2,
input wire [2 - 1 : 0] SSP_SHARED_sel_3,
input wire [2 - 1 : 0] SSP_SHARED_sel_4,
input wire [2 - 1 : 0] SSP_SHARED_sel_5,
input wire [2 - 1 : 0] SSP_SHARED_sel_6,
input wire [2 - 1 : 0] SSP_SHARED_sel_7,
input wire [2 - 1 : 0] SSP_SHARED_sel_8,
input wire [2 - 1 : 0] SSP_SHARED_sel_9,
input wire [2 - 1 : 0] SSP_SHARED_sel_10,
input wire [2 - 1 : 0] SSP_SHARED_sel_11,
input wire [2 - 1 : 0] SSP_SHARED_sel_12,
input wire [2 - 1 : 0] SSP_SHARED_sel_13,
input wire [2 - 1 : 0] SSP_SHARED_sel_14,
input wire [2 - 1 : 0] SSP_SHARED_sel_15,
input wire [2 - 1 : 0] SSP_SHARED_sel_16,
input wire [2 - 1 : 0] SSP_SHARED_sel_17,
input wire [2 - 1 : 0] SSP_SHARED_sel_18,
input wire [2 - 1 : 0] SSP_SHARED_sel_19,
input wire [2 - 1 : 0] SSP_SHARED_sel_20,
input wire [2 - 1 : 0] SSP_SHARED_sel_21,
input wire [2 - 1 : 0] SSP_SHARED_sel_22,
input wire [2 - 1 : 0] SSP_SHARED_sel_23,
input wire [2 - 1 : 0] SSP_SHARED_sel_24,
input wire [2 - 1 : 0] SSP_SHARED_sel_25,
input wire [2 - 1 : 0] SSP_SHARED_sel_26,
input wire [2 - 1 : 0] SSP_SHARED_sel_27,
input wire [2 - 1 : 0] SSP_SHARED_sel_28,
input wire [2 - 1 : 0] SSP_SHARED_sel_29,
input wire [2 - 1 : 0] SSP_SHARED_sel_30,
input wire [2 - 1 : 0] SSP_SHARED_sel_31,
input wire [2 - 1 : 0] SSP_SHARED_sel_32,
input wire [2 - 1 : 0] SSP_SHARED_sel_33,
input wire [2 - 1 : 0] SSP_SHARED_sel_34,
input wire [2 - 1 : 0] SSP_SHARED_sel_35,
input wire [2 - 1 : 0] SSP_SHARED_sel_36,
input wire [2 - 1 : 0] SSP_SHARED_sel_37,
input wire [2 - 1 : 0] SSP_SHARED_sel_38,
input wire [2 - 1 : 0] SSP_SHARED_sel_39,
input wire [2 - 1 : 0] SSP_SHARED_sel_40,
input wire [2 - 1 : 0] SSP_SHARED_sel_41,
input wire [2 - 1 : 0] SSP_SHARED_sel_42,
input wire [2 - 1 : 0] SSP_SHARED_sel_43,
input wire [2 - 1 : 0] SSP_SHARED_sel_44,
input wire [2 - 1 : 0] SSP_SHARED_sel_45,
input wire [2 - 1 : 0] SSP_SHARED_sel_46,
input wire [2 - 1 : 0] SSP_SHARED_sel_47,
// 
output wire  p2c_uart0_cts_n,
// 
input  wire  c2p_uart0_rts_n,
// uart0 sout
input  wire  c2p_uart0_sout,
// uart0 sin
output wire  p2c_uart0_sin,
// BOOTMODE
output wire [2 - 1 : 0] p2c_boot_mode,
// 
input  wire  c2p_sspim1_sclk_out,
// 
output wire  p2c_sspim1_rxd,
// 
input  wire  c2p_sspim1_txd,
// 
input  wire  c2p_sspim1_ss,
// 
output wire  p2c_spis_sclk_in,
// 
output wire  p2c_spis_rxd,
// 
input  wire  c2p_spis_txd,
// 
output wire  p2c_spis_ss,
// Serial Input
output wire  p2c_uart3_sin,
// Serial Output.
input  wire  c2p_uart3_sout,
// 
input  wire [32 - 1 : 0] c2p_gpio_porta,
output wire [32 - 1 : 0] p2c_gpio_porta,
input  wire [32 - 1 : 0] c2p_gpio_porta_oen,
// 
input  wire  c2p_i2stxm_sclk,
// 
input  wire  c2p_i2stxm_ws,
// 
input  wire [4 - 1 : 0] c2p_i2stxm_data,
// 
input  wire  c2p_i2srxm0_sclk,
// 
input  wire  c2p_i2srxm0_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm0_data,
// 
input  wire  c2p_i2srxm1_sclk,
// 
input  wire  c2p_i2srxm1_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm1_data,
// 
input  wire  c2p_i2srxm2_sclk,
// 
input  wire  c2p_i2srxm2_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm2_data,
// 
input  wire  c2p_i2srxm3_sclk,
// 
input  wire  c2p_i2srxm3_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm3_data,
// 
input  wire  c2p_i2srxm4_sclk,
// 
input  wire  c2p_i2srxm4_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm4_data,
// 
input  wire  c2p_i2srxm5_sclk,
// 
input  wire  c2p_i2srxm5_ws,
// 
output wire [4 - 1 : 0] p2c_i2srxm5_data,
// 
output wire  p2c_chip_wake_up,
// 
output wire  p2c_scan_test_modes,
// 
output wire  p2c_scan_reset,
// 
output wire  p2c_scan_enable,
// 
output wire [10 - 1 : 0] p2c_scan_in,
// 
input  wire [10 - 1 : 0] c2p_scan_out,
// I2C1 clk pin
input  wire  c2p_i2c1_ic_clk,
output wire  p2c_i2c1_ic_clk,
input  wire  c2p_i2c1_ic_clk_oen,
// 
input  wire  c2p_i2c1_ic_data,
output wire  p2c_i2c1_ic_data,
input  wire  c2p_i2c1_ic_data_oen,
// I2C2 clk pin
input  wire  c2p_i2c2_ic_clk,
output wire  p2c_i2c2_ic_clk,
input  wire  c2p_i2c2_ic_clk_oen,
// 
input  wire  c2p_i2c2_ic_data,
output wire  p2c_i2c2_ic_data,
input  wire  c2p_i2c2_ic_data_oen,
// 
input  wire  c2p_sspim2_sclk_out,
// 
output wire  p2c_sspim2_rxd,
// 
input  wire  c2p_sspim2_txd,
// 
input  wire  c2p_sspim2_ss,
// 
input  wire [8 - 1 : 0] c2p_tim_pwn,
output  logic c2p_SSP_SHARED_0,
input   logic p2c_SSP_SHARED_0,
output  logic c2p_SSP_SHARED_0_oen,
output  logic c2p_SSP_SHARED_1,
output  logic c2p_SSP_SHARED_2,
output  logic c2p_SSP_SHARED_3,
input   logic p2c_SSP_SHARED_3,
output  logic c2p_SSP_SHARED_3_oen,
output  logic c2p_SSP_SHARED_4,
input   logic p2c_SSP_SHARED_4,
output  logic c2p_SSP_SHARED_4_oen,
output  logic c2p_SSP_SHARED_5,
input   logic p2c_SSP_SHARED_5,
output  logic c2p_SSP_SHARED_5_oen,
output  logic c2p_SSP_SHARED_6,
output  logic c2p_SSP_SHARED_7,
input   logic p2c_SSP_SHARED_7,
output  logic c2p_SSP_SHARED_7_oen,
output  logic c2p_SSP_SHARED_8,
input   logic p2c_SSP_SHARED_8,
output  logic c2p_SSP_SHARED_8_oen,
output  logic c2p_SSP_SHARED_9,
input   logic p2c_SSP_SHARED_9,
output  logic c2p_SSP_SHARED_9_oen,
input   logic p2c_SSP_SHARED_10,
input   logic p2c_SSP_SHARED_11,
output  logic c2p_SSP_SHARED_12,
output  logic c2p_SSP_SHARED_13,
input   logic p2c_SSP_SHARED_13,
output  logic c2p_SSP_SHARED_13_oen,
input   logic p2c_SSP_SHARED_14,
output  logic c2p_SSP_SHARED_15,
input   logic p2c_SSP_SHARED_15,
output  logic c2p_SSP_SHARED_15_oen,
output  logic c2p_SSP_SHARED_16,
input   logic p2c_SSP_SHARED_16,
output  logic c2p_SSP_SHARED_16_oen,
output  logic c2p_SSP_SHARED_17,
input   logic p2c_SSP_SHARED_17,
output  logic c2p_SSP_SHARED_17_oen,
output  logic c2p_SSP_SHARED_18,
input   logic p2c_SSP_SHARED_18,
output  logic c2p_SSP_SHARED_18_oen,
output  logic c2p_SSP_SHARED_19,
input   logic p2c_SSP_SHARED_19,
output  logic c2p_SSP_SHARED_19_oen,
output  logic c2p_SSP_SHARED_20,
input   logic p2c_SSP_SHARED_20,
output  logic c2p_SSP_SHARED_20_oen,
output  logic c2p_SSP_SHARED_21,
input   logic p2c_SSP_SHARED_21,
output  logic c2p_SSP_SHARED_21_oen,
output  logic c2p_SSP_SHARED_22,
input   logic p2c_SSP_SHARED_22,
output  logic c2p_SSP_SHARED_22_oen,
output  logic c2p_SSP_SHARED_23,
input   logic p2c_SSP_SHARED_23,
output  logic c2p_SSP_SHARED_23_oen,
output  logic c2p_SSP_SHARED_24,
input   logic p2c_SSP_SHARED_24,
output  logic c2p_SSP_SHARED_24_oen,
output  logic c2p_SSP_SHARED_25,
input   logic p2c_SSP_SHARED_25,
output  logic c2p_SSP_SHARED_25_oen,
output  logic c2p_SSP_SHARED_26,
input   logic p2c_SSP_SHARED_26,
output  logic c2p_SSP_SHARED_26_oen,
output  logic c2p_SSP_SHARED_27,
input   logic p2c_SSP_SHARED_27,
output  logic c2p_SSP_SHARED_27_oen,
output  logic c2p_SSP_SHARED_28,
input   logic p2c_SSP_SHARED_28,
output  logic c2p_SSP_SHARED_28_oen,
output  logic c2p_SSP_SHARED_29,
input   logic p2c_SSP_SHARED_29,
output  logic c2p_SSP_SHARED_29_oen,
output  logic c2p_SSP_SHARED_30,
input   logic p2c_SSP_SHARED_30,
output  logic c2p_SSP_SHARED_30_oen,
output  logic c2p_SSP_SHARED_31,
input   logic p2c_SSP_SHARED_31,
output  logic c2p_SSP_SHARED_31_oen,
output  logic c2p_SSP_SHARED_32,
input   logic p2c_SSP_SHARED_32,
output  logic c2p_SSP_SHARED_32_oen,
output  logic c2p_SSP_SHARED_33,
input   logic p2c_SSP_SHARED_33,
output  logic c2p_SSP_SHARED_33_oen,
output  logic c2p_SSP_SHARED_34,
input   logic p2c_SSP_SHARED_34,
output  logic c2p_SSP_SHARED_34_oen,
output  logic c2p_SSP_SHARED_35,
input   logic p2c_SSP_SHARED_35,
output  logic c2p_SSP_SHARED_35_oen,
output  logic c2p_SSP_SHARED_36,
input   logic p2c_SSP_SHARED_36,
output  logic c2p_SSP_SHARED_36_oen,
output  logic c2p_SSP_SHARED_37,
input   logic p2c_SSP_SHARED_37,
output  logic c2p_SSP_SHARED_37_oen,
output  logic c2p_SSP_SHARED_38,
input   logic p2c_SSP_SHARED_38,
output  logic c2p_SSP_SHARED_38_oen,
output  logic c2p_SSP_SHARED_39,
input   logic p2c_SSP_SHARED_39,
output  logic c2p_SSP_SHARED_39_oen,
output  logic c2p_SSP_SHARED_40,
input   logic p2c_SSP_SHARED_40,
output  logic c2p_SSP_SHARED_40_oen,
output  logic c2p_SSP_SHARED_41,
input   logic p2c_SSP_SHARED_41,
output  logic c2p_SSP_SHARED_41_oen,
output  logic c2p_SSP_SHARED_42,
input   logic p2c_SSP_SHARED_42,
output  logic c2p_SSP_SHARED_42_oen,
output  logic c2p_SSP_SHARED_43,
input   logic p2c_SSP_SHARED_43,
output  logic c2p_SSP_SHARED_43_oen,
output  logic c2p_SSP_SHARED_44,
input   logic p2c_SSP_SHARED_44,
output  logic c2p_SSP_SHARED_44_oen,
output  logic c2p_SSP_SHARED_45,
input   logic p2c_SSP_SHARED_45,
output  logic c2p_SSP_SHARED_45_oen,
output  logic c2p_SSP_SHARED_46,
input   logic p2c_SSP_SHARED_46,
output  logic c2p_SSP_SHARED_46_oen,
output  logic c2p_SSP_SHARED_47,
input   logic p2c_SSP_SHARED_47,
output  logic c2p_SSP_SHARED_47_oen,
input   logic test_mode);
always_comb begin
  case (SSP_SHARED_sel_0)
    0: c2p_SSP_SHARED_0 = 1'b0;
    1: c2p_SSP_SHARED_0 = c2p_i2stxm_sclk;
    default: c2p_SSP_SHARED_0 = 1'b0;
  endcase
end
assign p2c_uart0_cts_n = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_0 == 0) ? p2c_SSP_SHARED_0 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_0)
    0: c2p_SSP_SHARED_0_oen = 1'b1;
    1: c2p_SSP_SHARED_0_oen = 1'b0;
    default: c2p_SSP_SHARED_0_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_1)
    0: c2p_SSP_SHARED_1 = c2p_uart0_rts_n;
    1: c2p_SSP_SHARED_1 = c2p_i2stxm_ws;
    default: c2p_SSP_SHARED_1 = 1'b0;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_2)
    0: c2p_SSP_SHARED_2 = c2p_uart0_sout;
    1: c2p_SSP_SHARED_2 = c2p_i2stxm_data[0];
    default: c2p_SSP_SHARED_2 = 1'b0;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_3)
    0: c2p_SSP_SHARED_3 = 1'b0;
    1: c2p_SSP_SHARED_3 = c2p_i2stxm_data[1];
    default: c2p_SSP_SHARED_3 = 1'b0;
  endcase
end
assign p2c_uart0_sin = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_3 == 0) ? p2c_SSP_SHARED_3 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_3)
    0: c2p_SSP_SHARED_3_oen = 1'b1;
    1: c2p_SSP_SHARED_3_oen = 1'b0;
    default: c2p_SSP_SHARED_3_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_4)
    0: c2p_SSP_SHARED_4 = 1'b0;
    1: c2p_SSP_SHARED_4 = c2p_i2stxm_data[2];
    default: c2p_SSP_SHARED_4 = 1'b0;
  endcase
end
assign p2c_boot_mode[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_4 == 0) ? p2c_SSP_SHARED_4 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_4)
    0: c2p_SSP_SHARED_4_oen = 1'b1;
    1: c2p_SSP_SHARED_4_oen = 1'b0;
    default: c2p_SSP_SHARED_4_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_5)
    0: c2p_SSP_SHARED_5 = 1'b0;
    1: c2p_SSP_SHARED_5 = c2p_i2stxm_data[3];
    default: c2p_SSP_SHARED_5 = 1'b0;
  endcase
end
assign p2c_boot_mode[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_5 == 0) ? p2c_SSP_SHARED_5 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_5)
    0: c2p_SSP_SHARED_5_oen = 1'b1;
    1: c2p_SSP_SHARED_5_oen = 1'b0;
    default: c2p_SSP_SHARED_5_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_6)
    0: c2p_SSP_SHARED_6 = c2p_sspim1_sclk_out;
    1: c2p_SSP_SHARED_6 = c2p_i2srxm0_sclk;
    default: c2p_SSP_SHARED_6 = 1'b0;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_7)
    0: c2p_SSP_SHARED_7 = 1'b0;
    1: c2p_SSP_SHARED_7 = c2p_i2srxm0_ws;
    default: c2p_SSP_SHARED_7 = 1'b0;
  endcase
end
assign p2c_sspim1_rxd = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_7 == 0) ? p2c_SSP_SHARED_7 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_7)
    0: c2p_SSP_SHARED_7_oen = 1'b1;
    1: c2p_SSP_SHARED_7_oen = 1'b0;
    default: c2p_SSP_SHARED_7_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_8)
    0: c2p_SSP_SHARED_8 = c2p_sspim1_txd;
    1: c2p_SSP_SHARED_8 = 1'b0;
    default: c2p_SSP_SHARED_8 = 1'b0;
  endcase
end
assign p2c_i2srxm0_data[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_8 == 1) ? p2c_SSP_SHARED_8 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_8)
    0: c2p_SSP_SHARED_8_oen = 1'b0;
    1: c2p_SSP_SHARED_8_oen = 1'b1;
    default: c2p_SSP_SHARED_8_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_9)
    0: c2p_SSP_SHARED_9 = c2p_sspim1_ss;
    1: c2p_SSP_SHARED_9 = 1'b0;
    default: c2p_SSP_SHARED_9 = 1'b0;
  endcase
end
assign p2c_i2srxm0_data[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_9 == 1) ? p2c_SSP_SHARED_9 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_9)
    0: c2p_SSP_SHARED_9_oen = 1'b0;
    1: c2p_SSP_SHARED_9_oen = 1'b1;
    default: c2p_SSP_SHARED_9_oen = 1'b1;
  endcase
end

assign p2c_spis_sclk_in = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_10 == 0) ? p2c_SSP_SHARED_10 : 1'b0;
assign p2c_i2srxm0_data[2] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_10 == 1) ? p2c_SSP_SHARED_10 : 1'b0;

assign p2c_spis_rxd = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_11 == 0) ? p2c_SSP_SHARED_11 : 1'b0;
assign p2c_i2srxm0_data[3] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_11 == 1) ? p2c_SSP_SHARED_11 : 1'b0;

always_comb begin
  case (SSP_SHARED_sel_12)
    0: c2p_SSP_SHARED_12 = c2p_spis_txd;
    1: c2p_SSP_SHARED_12 = c2p_i2srxm1_sclk;
    default: c2p_SSP_SHARED_12 = 1'b0;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_13)
    0: c2p_SSP_SHARED_13 = 1'b0;
    1: c2p_SSP_SHARED_13 = c2p_i2srxm1_ws;
    default: c2p_SSP_SHARED_13 = 1'b0;
  endcase
end
assign p2c_spis_ss = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_13 == 0) ? p2c_SSP_SHARED_13 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_13)
    0: c2p_SSP_SHARED_13_oen = 1'b1;
    1: c2p_SSP_SHARED_13_oen = 1'b0;
    default: c2p_SSP_SHARED_13_oen = 1'b1;
  endcase
end

assign p2c_uart3_sin = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_14 == 0) ? p2c_SSP_SHARED_14 : 1'b0;
assign p2c_i2srxm1_data[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_14 == 1) ? p2c_SSP_SHARED_14 : 1'b0;

always_comb begin
  case (SSP_SHARED_sel_15)
    0: c2p_SSP_SHARED_15 = c2p_uart3_sout;
    1: c2p_SSP_SHARED_15 = 1'b0;
    default: c2p_SSP_SHARED_15 = 1'b0;
  endcase
end
assign p2c_i2srxm1_data[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_15 == 1) ? p2c_SSP_SHARED_15 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_15)
    0: c2p_SSP_SHARED_15_oen = 1'b0;
    1: c2p_SSP_SHARED_15_oen = 1'b1;
    default: c2p_SSP_SHARED_15_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_16)
    0: c2p_SSP_SHARED_16 = c2p_gpio_porta[0];
    1: c2p_SSP_SHARED_16 = 1'b0;
    2: c2p_SSP_SHARED_16 = 1'b0;
    3: c2p_SSP_SHARED_16 = c2p_i2c1_ic_clk;
    default: c2p_SSP_SHARED_16 = 1'b0;
  endcase
end
assign p2c_gpio_porta[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_16 == 0) ? p2c_SSP_SHARED_16 : 1'b0;
assign p2c_i2srxm1_data[2] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_16 == 1) ? p2c_SSP_SHARED_16 : 1'b0;
assign p2c_scan_test_modes = (test_mode == 1'b1) ? p2c_SSP_SHARED_16 : (SSP_SHARED_sel_16 == 2) ? p2c_SSP_SHARED_16 : 1'b0;
assign p2c_i2c1_ic_clk = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_16 == 3) ? p2c_SSP_SHARED_16 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_16_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_16)
    0: c2p_SSP_SHARED_16_oen = c2p_gpio_porta_oen[0];
    1: c2p_SSP_SHARED_16_oen = 1'b1;
    2: c2p_SSP_SHARED_16_oen = 1'b1;
    3: c2p_SSP_SHARED_16_oen = c2p_i2c1_ic_clk_oen;
    default: c2p_SSP_SHARED_16_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_17)
    0: c2p_SSP_SHARED_17 = c2p_gpio_porta[1];
    1: c2p_SSP_SHARED_17 = 1'b0;
    2: c2p_SSP_SHARED_17 = 1'b0;
    3: c2p_SSP_SHARED_17 = c2p_i2c1_ic_data;
    default: c2p_SSP_SHARED_17 = 1'b0;
  endcase
end
assign p2c_gpio_porta[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_17 == 0) ? p2c_SSP_SHARED_17 : 1'b0;
assign p2c_i2srxm1_data[3] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_17 == 1) ? p2c_SSP_SHARED_17 : 1'b0;
assign p2c_scan_reset = (test_mode == 1'b1) ? p2c_SSP_SHARED_17 : (SSP_SHARED_sel_17 == 2) ? p2c_SSP_SHARED_17 : 1'b0;
assign p2c_i2c1_ic_data = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_17 == 3) ? p2c_SSP_SHARED_17 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_17_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_17)
    0: c2p_SSP_SHARED_17_oen = c2p_gpio_porta_oen[1];
    1: c2p_SSP_SHARED_17_oen = 1'b1;
    2: c2p_SSP_SHARED_17_oen = 1'b1;
    3: c2p_SSP_SHARED_17_oen = c2p_i2c1_ic_data_oen;
    default: c2p_SSP_SHARED_17_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_18)
    0: c2p_SSP_SHARED_18 = c2p_gpio_porta[2];
    1: c2p_SSP_SHARED_18 = c2p_i2srxm2_sclk;
    2: c2p_SSP_SHARED_18 = 1'b0;
    3: c2p_SSP_SHARED_18 = c2p_i2c2_ic_clk;
    default: c2p_SSP_SHARED_18 = 1'b0;
  endcase
end
assign p2c_gpio_porta[2] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_18 == 0) ? p2c_SSP_SHARED_18 : 1'b0;
assign p2c_scan_enable = (test_mode == 1'b1) ? p2c_SSP_SHARED_18 : (SSP_SHARED_sel_18 == 2) ? p2c_SSP_SHARED_18 : 1'b0;
assign p2c_i2c2_ic_clk = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_18 == 3) ? p2c_SSP_SHARED_18 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_18_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_18)
    0: c2p_SSP_SHARED_18_oen = c2p_gpio_porta_oen[2];
    1: c2p_SSP_SHARED_18_oen = 1'b0;
    2: c2p_SSP_SHARED_18_oen = 1'b1;
    3: c2p_SSP_SHARED_18_oen = c2p_i2c2_ic_clk_oen;
    default: c2p_SSP_SHARED_18_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_19)
    0: c2p_SSP_SHARED_19 = c2p_gpio_porta[3];
    1: c2p_SSP_SHARED_19 = c2p_i2srxm2_ws;
    2: c2p_SSP_SHARED_19 = 1'b0;
    3: c2p_SSP_SHARED_19 = c2p_i2c2_ic_data;
    default: c2p_SSP_SHARED_19 = 1'b0;
  endcase
end
assign p2c_gpio_porta[3] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_19 == 0) ? p2c_SSP_SHARED_19 : 1'b0;
assign p2c_scan_in[0] = (test_mode == 1'b1) ? p2c_SSP_SHARED_19 : (SSP_SHARED_sel_19 == 2) ? p2c_SSP_SHARED_19 : 1'b0;
assign p2c_i2c2_ic_data = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_19 == 3) ? p2c_SSP_SHARED_19 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_19_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_19)
    0: c2p_SSP_SHARED_19_oen = c2p_gpio_porta_oen[3];
    1: c2p_SSP_SHARED_19_oen = 1'b0;
    2: c2p_SSP_SHARED_19_oen = 1'b1;
    3: c2p_SSP_SHARED_19_oen = c2p_i2c2_ic_data_oen;
    default: c2p_SSP_SHARED_19_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_20)
    0: c2p_SSP_SHARED_20 = c2p_gpio_porta[4];
    1: c2p_SSP_SHARED_20 = 1'b0;
    2: c2p_SSP_SHARED_20 = 1'b0;
    3: c2p_SSP_SHARED_20 = c2p_sspim2_sclk_out;
    default: c2p_SSP_SHARED_20 = 1'b0;
  endcase
end
assign p2c_gpio_porta[4] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_20 == 0) ? p2c_SSP_SHARED_20 : 1'b0;
assign p2c_i2srxm2_data[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_20 == 1) ? p2c_SSP_SHARED_20 : 1'b0;
assign p2c_scan_in[1] = (test_mode == 1'b1) ? p2c_SSP_SHARED_20 : (SSP_SHARED_sel_20 == 2) ? p2c_SSP_SHARED_20 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_20_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_20)
    0: c2p_SSP_SHARED_20_oen = c2p_gpio_porta_oen[4];
    1: c2p_SSP_SHARED_20_oen = 1'b1;
    2: c2p_SSP_SHARED_20_oen = 1'b1;
    3: c2p_SSP_SHARED_20_oen = 1'b0;
    default: c2p_SSP_SHARED_20_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_21)
    0: c2p_SSP_SHARED_21 = c2p_gpio_porta[5];
    1: c2p_SSP_SHARED_21 = 1'b0;
    2: c2p_SSP_SHARED_21 = 1'b0;
    3: c2p_SSP_SHARED_21 = 1'b0;
    default: c2p_SSP_SHARED_21 = 1'b0;
  endcase
end
assign p2c_gpio_porta[5] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_21 == 0) ? p2c_SSP_SHARED_21 : 1'b0;
assign p2c_i2srxm2_data[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_21 == 1) ? p2c_SSP_SHARED_21 : 1'b0;
assign p2c_scan_in[2] = (test_mode == 1'b1) ? p2c_SSP_SHARED_21 : (SSP_SHARED_sel_21 == 2) ? p2c_SSP_SHARED_21 : 1'b0;
assign p2c_sspim2_rxd = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_21 == 3) ? p2c_SSP_SHARED_21 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_21_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_21)
    0: c2p_SSP_SHARED_21_oen = c2p_gpio_porta_oen[5];
    1: c2p_SSP_SHARED_21_oen = 1'b1;
    2: c2p_SSP_SHARED_21_oen = 1'b1;
    3: c2p_SSP_SHARED_21_oen = 1'b1;
    default: c2p_SSP_SHARED_21_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_22)
    0: c2p_SSP_SHARED_22 = c2p_gpio_porta[6];
    1: c2p_SSP_SHARED_22 = 1'b0;
    2: c2p_SSP_SHARED_22 = 1'b0;
    3: c2p_SSP_SHARED_22 = c2p_sspim2_txd;
    default: c2p_SSP_SHARED_22 = 1'b0;
  endcase
end
assign p2c_gpio_porta[6] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_22 == 0) ? p2c_SSP_SHARED_22 : 1'b0;
assign p2c_i2srxm2_data[2] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_22 == 1) ? p2c_SSP_SHARED_22 : 1'b0;
assign p2c_scan_in[3] = (test_mode == 1'b1) ? p2c_SSP_SHARED_22 : (SSP_SHARED_sel_22 == 2) ? p2c_SSP_SHARED_22 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_22_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_22)
    0: c2p_SSP_SHARED_22_oen = c2p_gpio_porta_oen[6];
    1: c2p_SSP_SHARED_22_oen = 1'b1;
    2: c2p_SSP_SHARED_22_oen = 1'b1;
    3: c2p_SSP_SHARED_22_oen = 1'b0;
    default: c2p_SSP_SHARED_22_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_23)
    0: c2p_SSP_SHARED_23 = c2p_gpio_porta[7];
    1: c2p_SSP_SHARED_23 = 1'b0;
    2: c2p_SSP_SHARED_23 = 1'b0;
    3: c2p_SSP_SHARED_23 = c2p_sspim2_ss;
    default: c2p_SSP_SHARED_23 = 1'b0;
  endcase
end
assign p2c_gpio_porta[7] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_23 == 0) ? p2c_SSP_SHARED_23 : 1'b0;
assign p2c_i2srxm2_data[3] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_23 == 1) ? p2c_SSP_SHARED_23 : 1'b0;
assign p2c_scan_in[4] = (test_mode == 1'b1) ? p2c_SSP_SHARED_23 : (SSP_SHARED_sel_23 == 2) ? p2c_SSP_SHARED_23 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_23_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_23)
    0: c2p_SSP_SHARED_23_oen = c2p_gpio_porta_oen[7];
    1: c2p_SSP_SHARED_23_oen = 1'b1;
    2: c2p_SSP_SHARED_23_oen = 1'b1;
    3: c2p_SSP_SHARED_23_oen = 1'b0;
    default: c2p_SSP_SHARED_23_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_24)
    0: c2p_SSP_SHARED_24 = c2p_gpio_porta[8];
    1: c2p_SSP_SHARED_24 = c2p_i2srxm3_sclk;
    2: c2p_SSP_SHARED_24 = 1'b0;
    3: c2p_SSP_SHARED_24 = c2p_tim_pwn[0];
    default: c2p_SSP_SHARED_24 = 1'b0;
  endcase
end
assign p2c_gpio_porta[8] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_24 == 0) ? p2c_SSP_SHARED_24 : 1'b0;
assign p2c_scan_in[5] = (test_mode == 1'b1) ? p2c_SSP_SHARED_24 : (SSP_SHARED_sel_24 == 2) ? p2c_SSP_SHARED_24 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_24_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_24)
    0: c2p_SSP_SHARED_24_oen = c2p_gpio_porta_oen[8];
    1: c2p_SSP_SHARED_24_oen = 1'b0;
    2: c2p_SSP_SHARED_24_oen = 1'b1;
    3: c2p_SSP_SHARED_24_oen = 1'b0;
    default: c2p_SSP_SHARED_24_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_25)
    0: c2p_SSP_SHARED_25 = c2p_gpio_porta[9];
    1: c2p_SSP_SHARED_25 = c2p_i2srxm3_ws;
    2: c2p_SSP_SHARED_25 = 1'b0;
    3: c2p_SSP_SHARED_25 = c2p_tim_pwn[1];
    default: c2p_SSP_SHARED_25 = 1'b0;
  endcase
end
assign p2c_gpio_porta[9] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_25 == 0) ? p2c_SSP_SHARED_25 : 1'b0;
assign p2c_scan_in[6] = (test_mode == 1'b1) ? p2c_SSP_SHARED_25 : (SSP_SHARED_sel_25 == 2) ? p2c_SSP_SHARED_25 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_25_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_25)
    0: c2p_SSP_SHARED_25_oen = c2p_gpio_porta_oen[9];
    1: c2p_SSP_SHARED_25_oen = 1'b0;
    2: c2p_SSP_SHARED_25_oen = 1'b1;
    3: c2p_SSP_SHARED_25_oen = 1'b0;
    default: c2p_SSP_SHARED_25_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_26)
    0: c2p_SSP_SHARED_26 = c2p_gpio_porta[10];
    1: c2p_SSP_SHARED_26 = 1'b0;
    2: c2p_SSP_SHARED_26 = 1'b0;
    3: c2p_SSP_SHARED_26 = c2p_tim_pwn[2];
    default: c2p_SSP_SHARED_26 = 1'b0;
  endcase
end
assign p2c_gpio_porta[10] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_26 == 0) ? p2c_SSP_SHARED_26 : 1'b0;
assign p2c_i2srxm3_data[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_26 == 1) ? p2c_SSP_SHARED_26 : 1'b0;
assign p2c_scan_in[7] = (test_mode == 1'b1) ? p2c_SSP_SHARED_26 : (SSP_SHARED_sel_26 == 2) ? p2c_SSP_SHARED_26 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_26_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_26)
    0: c2p_SSP_SHARED_26_oen = c2p_gpio_porta_oen[10];
    1: c2p_SSP_SHARED_26_oen = 1'b1;
    2: c2p_SSP_SHARED_26_oen = 1'b1;
    3: c2p_SSP_SHARED_26_oen = 1'b0;
    default: c2p_SSP_SHARED_26_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_27)
    0: c2p_SSP_SHARED_27 = c2p_gpio_porta[11];
    1: c2p_SSP_SHARED_27 = 1'b0;
    2: c2p_SSP_SHARED_27 = 1'b0;
    3: c2p_SSP_SHARED_27 = c2p_tim_pwn[3];
    default: c2p_SSP_SHARED_27 = 1'b0;
  endcase
end
assign p2c_gpio_porta[11] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_27 == 0) ? p2c_SSP_SHARED_27 : 1'b0;
assign p2c_i2srxm3_data[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_27 == 1) ? p2c_SSP_SHARED_27 : 1'b0;
assign p2c_scan_in[8] = (test_mode == 1'b1) ? p2c_SSP_SHARED_27 : (SSP_SHARED_sel_27 == 2) ? p2c_SSP_SHARED_27 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_27_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_27)
    0: c2p_SSP_SHARED_27_oen = c2p_gpio_porta_oen[11];
    1: c2p_SSP_SHARED_27_oen = 1'b1;
    2: c2p_SSP_SHARED_27_oen = 1'b1;
    3: c2p_SSP_SHARED_27_oen = 1'b0;
    default: c2p_SSP_SHARED_27_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_28)
    0: c2p_SSP_SHARED_28 = c2p_gpio_porta[12];
    1: c2p_SSP_SHARED_28 = 1'b0;
    2: c2p_SSP_SHARED_28 = 1'b0;
    3: c2p_SSP_SHARED_28 = c2p_tim_pwn[4];
    default: c2p_SSP_SHARED_28 = 1'b0;
  endcase
end
assign p2c_gpio_porta[12] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_28 == 0) ? p2c_SSP_SHARED_28 : 1'b0;
assign p2c_i2srxm3_data[2] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_28 == 1) ? p2c_SSP_SHARED_28 : 1'b0;
assign p2c_scan_in[9] = (test_mode == 1'b1) ? p2c_SSP_SHARED_28 : (SSP_SHARED_sel_28 == 2) ? p2c_SSP_SHARED_28 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_28_oen = 1'b1;
  end else
  case (SSP_SHARED_sel_28)
    0: c2p_SSP_SHARED_28_oen = c2p_gpio_porta_oen[12];
    1: c2p_SSP_SHARED_28_oen = 1'b1;
    2: c2p_SSP_SHARED_28_oen = 1'b1;
    3: c2p_SSP_SHARED_28_oen = 1'b0;
    default: c2p_SSP_SHARED_28_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_29 = c2p_scan_out[0];
  end else
  case (SSP_SHARED_sel_29)
    0: c2p_SSP_SHARED_29 = c2p_gpio_porta[13];
    1: c2p_SSP_SHARED_29 = 1'b0;
    2: c2p_SSP_SHARED_29 = c2p_scan_out[0];
    3: c2p_SSP_SHARED_29 = c2p_tim_pwn[5];
    default: c2p_SSP_SHARED_29 = 1'b0;
  endcase
end
assign p2c_gpio_porta[13] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_29 == 0) ? p2c_SSP_SHARED_29 : 1'b0;
assign p2c_i2srxm3_data[3] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_29 == 1) ? p2c_SSP_SHARED_29 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_29_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_29)
    0: c2p_SSP_SHARED_29_oen = c2p_gpio_porta_oen[13];
    1: c2p_SSP_SHARED_29_oen = 1'b1;
    2: c2p_SSP_SHARED_29_oen = 1'b0;
    3: c2p_SSP_SHARED_29_oen = 1'b0;
    default: c2p_SSP_SHARED_29_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_30 = c2p_scan_out[1];
  end else
  case (SSP_SHARED_sel_30)
    0: c2p_SSP_SHARED_30 = c2p_gpio_porta[14];
    1: c2p_SSP_SHARED_30 = c2p_i2srxm4_sclk;
    2: c2p_SSP_SHARED_30 = c2p_scan_out[1];
    3: c2p_SSP_SHARED_30 = c2p_tim_pwn[6];
    default: c2p_SSP_SHARED_30 = 1'b0;
  endcase
end
assign p2c_gpio_porta[14] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_30 == 0) ? p2c_SSP_SHARED_30 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_30_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_30)
    0: c2p_SSP_SHARED_30_oen = c2p_gpio_porta_oen[14];
    1: c2p_SSP_SHARED_30_oen = 1'b0;
    2: c2p_SSP_SHARED_30_oen = 1'b0;
    3: c2p_SSP_SHARED_30_oen = 1'b0;
    default: c2p_SSP_SHARED_30_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_31 = c2p_scan_out[2];
  end else
  case (SSP_SHARED_sel_31)
    0: c2p_SSP_SHARED_31 = c2p_gpio_porta[15];
    1: c2p_SSP_SHARED_31 = c2p_i2srxm4_ws;
    2: c2p_SSP_SHARED_31 = c2p_scan_out[2];
    3: c2p_SSP_SHARED_31 = c2p_tim_pwn[7];
    default: c2p_SSP_SHARED_31 = 1'b0;
  endcase
end
assign p2c_gpio_porta[15] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_31 == 0) ? p2c_SSP_SHARED_31 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_31_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_31)
    0: c2p_SSP_SHARED_31_oen = c2p_gpio_porta_oen[15];
    1: c2p_SSP_SHARED_31_oen = 1'b0;
    2: c2p_SSP_SHARED_31_oen = 1'b0;
    3: c2p_SSP_SHARED_31_oen = 1'b0;
    default: c2p_SSP_SHARED_31_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_32 = c2p_scan_out[3];
  end else
  case (SSP_SHARED_sel_32)
    0: c2p_SSP_SHARED_32 = c2p_gpio_porta[16];
    1: c2p_SSP_SHARED_32 = 1'b0;
    2: c2p_SSP_SHARED_32 = c2p_scan_out[3];
    default: c2p_SSP_SHARED_32 = 1'b0;
  endcase
end
assign p2c_gpio_porta[16] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_32 == 0) ? p2c_SSP_SHARED_32 : 1'b0;
assign p2c_i2srxm4_data[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_32 == 1) ? p2c_SSP_SHARED_32 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_32_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_32)
    0: c2p_SSP_SHARED_32_oen = c2p_gpio_porta_oen[16];
    1: c2p_SSP_SHARED_32_oen = 1'b1;
    2: c2p_SSP_SHARED_32_oen = 1'b0;
    default: c2p_SSP_SHARED_32_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_33 = c2p_scan_out[4];
  end else
  case (SSP_SHARED_sel_33)
    0: c2p_SSP_SHARED_33 = c2p_gpio_porta[17];
    1: c2p_SSP_SHARED_33 = 1'b0;
    2: c2p_SSP_SHARED_33 = c2p_scan_out[4];
    default: c2p_SSP_SHARED_33 = 1'b0;
  endcase
end
assign p2c_gpio_porta[17] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_33 == 0) ? p2c_SSP_SHARED_33 : 1'b0;
assign p2c_i2srxm4_data[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_33 == 1) ? p2c_SSP_SHARED_33 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_33_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_33)
    0: c2p_SSP_SHARED_33_oen = c2p_gpio_porta_oen[17];
    1: c2p_SSP_SHARED_33_oen = 1'b1;
    2: c2p_SSP_SHARED_33_oen = 1'b0;
    default: c2p_SSP_SHARED_33_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_34 = c2p_scan_out[5];
  end else
  case (SSP_SHARED_sel_34)
    0: c2p_SSP_SHARED_34 = c2p_gpio_porta[18];
    1: c2p_SSP_SHARED_34 = 1'b0;
    2: c2p_SSP_SHARED_34 = c2p_scan_out[5];
    default: c2p_SSP_SHARED_34 = 1'b0;
  endcase
end
assign p2c_gpio_porta[18] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_34 == 0) ? p2c_SSP_SHARED_34 : 1'b0;
assign p2c_i2srxm4_data[2] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_34 == 1) ? p2c_SSP_SHARED_34 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_34_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_34)
    0: c2p_SSP_SHARED_34_oen = c2p_gpio_porta_oen[18];
    1: c2p_SSP_SHARED_34_oen = 1'b1;
    2: c2p_SSP_SHARED_34_oen = 1'b0;
    default: c2p_SSP_SHARED_34_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_35 = c2p_scan_out[6];
  end else
  case (SSP_SHARED_sel_35)
    0: c2p_SSP_SHARED_35 = c2p_gpio_porta[19];
    1: c2p_SSP_SHARED_35 = 1'b0;
    2: c2p_SSP_SHARED_35 = c2p_scan_out[6];
    default: c2p_SSP_SHARED_35 = 1'b0;
  endcase
end
assign p2c_gpio_porta[19] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_35 == 0) ? p2c_SSP_SHARED_35 : 1'b0;
assign p2c_i2srxm4_data[3] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_35 == 1) ? p2c_SSP_SHARED_35 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_35_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_35)
    0: c2p_SSP_SHARED_35_oen = c2p_gpio_porta_oen[19];
    1: c2p_SSP_SHARED_35_oen = 1'b1;
    2: c2p_SSP_SHARED_35_oen = 1'b0;
    default: c2p_SSP_SHARED_35_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_36 = c2p_scan_out[7];
  end else
  case (SSP_SHARED_sel_36)
    0: c2p_SSP_SHARED_36 = c2p_gpio_porta[20];
    1: c2p_SSP_SHARED_36 = c2p_i2srxm5_sclk;
    2: c2p_SSP_SHARED_36 = c2p_scan_out[7];
    default: c2p_SSP_SHARED_36 = 1'b0;
  endcase
end
assign p2c_gpio_porta[20] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_36 == 0) ? p2c_SSP_SHARED_36 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_36_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_36)
    0: c2p_SSP_SHARED_36_oen = c2p_gpio_porta_oen[20];
    1: c2p_SSP_SHARED_36_oen = 1'b0;
    2: c2p_SSP_SHARED_36_oen = 1'b0;
    default: c2p_SSP_SHARED_36_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_37 = c2p_scan_out[8];
  end else
  case (SSP_SHARED_sel_37)
    0: c2p_SSP_SHARED_37 = c2p_gpio_porta[21];
    1: c2p_SSP_SHARED_37 = c2p_i2srxm5_ws;
    2: c2p_SSP_SHARED_37 = c2p_scan_out[8];
    default: c2p_SSP_SHARED_37 = 1'b0;
  endcase
end
assign p2c_gpio_porta[21] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_37 == 0) ? p2c_SSP_SHARED_37 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_37_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_37)
    0: c2p_SSP_SHARED_37_oen = c2p_gpio_porta_oen[21];
    1: c2p_SSP_SHARED_37_oen = 1'b0;
    2: c2p_SSP_SHARED_37_oen = 1'b0;
    default: c2p_SSP_SHARED_37_oen = 1'b1;
  endcase
end

always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_38 = c2p_scan_out[9];
  end else
  case (SSP_SHARED_sel_38)
    0: c2p_SSP_SHARED_38 = c2p_gpio_porta[22];
    1: c2p_SSP_SHARED_38 = 1'b0;
    2: c2p_SSP_SHARED_38 = c2p_scan_out[9];
    default: c2p_SSP_SHARED_38 = 1'b0;
  endcase
end
assign p2c_gpio_porta[22] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_38 == 0) ? p2c_SSP_SHARED_38 : 1'b0;
assign p2c_i2srxm5_data[0] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_38 == 1) ? p2c_SSP_SHARED_38 : 1'b0;
always_comb begin
  if (test_mode == 1'b1) begin
    c2p_SSP_SHARED_38_oen = 1'b0;
  end else
  case (SSP_SHARED_sel_38)
    0: c2p_SSP_SHARED_38_oen = c2p_gpio_porta_oen[22];
    1: c2p_SSP_SHARED_38_oen = 1'b1;
    2: c2p_SSP_SHARED_38_oen = 1'b0;
    default: c2p_SSP_SHARED_38_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_39)
    0: c2p_SSP_SHARED_39 = c2p_gpio_porta[23];
    1: c2p_SSP_SHARED_39 = 1'b0;
    default: c2p_SSP_SHARED_39 = 1'b0;
  endcase
end
assign p2c_gpio_porta[23] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_39 == 0) ? p2c_SSP_SHARED_39 : 1'b0;
assign p2c_i2srxm5_data[1] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_39 == 1) ? p2c_SSP_SHARED_39 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_39)
    0: c2p_SSP_SHARED_39_oen = c2p_gpio_porta_oen[23];
    1: c2p_SSP_SHARED_39_oen = 1'b1;
    default: c2p_SSP_SHARED_39_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_40)
    0: c2p_SSP_SHARED_40 = c2p_gpio_porta[24];
    1: c2p_SSP_SHARED_40 = 1'b0;
    default: c2p_SSP_SHARED_40 = 1'b0;
  endcase
end
assign p2c_gpio_porta[24] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_40 == 0) ? p2c_SSP_SHARED_40 : 1'b0;
assign p2c_i2srxm5_data[2] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_40 == 1) ? p2c_SSP_SHARED_40 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_40)
    0: c2p_SSP_SHARED_40_oen = c2p_gpio_porta_oen[24];
    1: c2p_SSP_SHARED_40_oen = 1'b1;
    default: c2p_SSP_SHARED_40_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_41)
    0: c2p_SSP_SHARED_41 = c2p_gpio_porta[25];
    1: c2p_SSP_SHARED_41 = 1'b0;
    default: c2p_SSP_SHARED_41 = 1'b0;
  endcase
end
assign p2c_gpio_porta[25] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_41 == 0) ? p2c_SSP_SHARED_41 : 1'b0;
assign p2c_i2srxm5_data[3] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_41 == 1) ? p2c_SSP_SHARED_41 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_41)
    0: c2p_SSP_SHARED_41_oen = c2p_gpio_porta_oen[25];
    1: c2p_SSP_SHARED_41_oen = 1'b1;
    default: c2p_SSP_SHARED_41_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_42)
    0: c2p_SSP_SHARED_42 = c2p_gpio_porta[26];
    1: c2p_SSP_SHARED_42 = 1'b0;
    default: c2p_SSP_SHARED_42 = 1'b0;
  endcase
end
assign p2c_gpio_porta[26] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_42 == 0) ? p2c_SSP_SHARED_42 : 1'b0;
assign p2c_chip_wake_up = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_42 == 1) ? p2c_SSP_SHARED_42 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_42)
    0: c2p_SSP_SHARED_42_oen = c2p_gpio_porta_oen[26];
    1: c2p_SSP_SHARED_42_oen = 1'b1;
    default: c2p_SSP_SHARED_42_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_43)
    0: c2p_SSP_SHARED_43 = c2p_gpio_porta[27];
    default: c2p_SSP_SHARED_43 = 1'b0;
  endcase
end
assign p2c_gpio_porta[27] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_43 == 0) ? p2c_SSP_SHARED_43 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_43)
    0: c2p_SSP_SHARED_43_oen = c2p_gpio_porta_oen[27];
    default: c2p_SSP_SHARED_43_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_44)
    0: c2p_SSP_SHARED_44 = c2p_gpio_porta[28];
    default: c2p_SSP_SHARED_44 = 1'b0;
  endcase
end
assign p2c_gpio_porta[28] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_44 == 0) ? p2c_SSP_SHARED_44 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_44)
    0: c2p_SSP_SHARED_44_oen = c2p_gpio_porta_oen[28];
    default: c2p_SSP_SHARED_44_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_45)
    0: c2p_SSP_SHARED_45 = c2p_gpio_porta[29];
    default: c2p_SSP_SHARED_45 = 1'b0;
  endcase
end
assign p2c_gpio_porta[29] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_45 == 0) ? p2c_SSP_SHARED_45 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_45)
    0: c2p_SSP_SHARED_45_oen = c2p_gpio_porta_oen[29];
    default: c2p_SSP_SHARED_45_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_46)
    0: c2p_SSP_SHARED_46 = c2p_gpio_porta[30];
    default: c2p_SSP_SHARED_46 = 1'b0;
  endcase
end
assign p2c_gpio_porta[30] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_46 == 0) ? p2c_SSP_SHARED_46 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_46)
    0: c2p_SSP_SHARED_46_oen = c2p_gpio_porta_oen[30];
    default: c2p_SSP_SHARED_46_oen = 1'b1;
  endcase
end

always_comb begin
  case (SSP_SHARED_sel_47)
    0: c2p_SSP_SHARED_47 = c2p_gpio_porta[31];
    default: c2p_SSP_SHARED_47 = 1'b0;
  endcase
end
assign p2c_gpio_porta[31] = (test_mode == 1'b1) ? 1'b0 : (SSP_SHARED_sel_47 == 0) ? p2c_SSP_SHARED_47 : 1'b0;
always_comb begin
  case (SSP_SHARED_sel_47)
    0: c2p_SSP_SHARED_47_oen = c2p_gpio_porta_oen[31];
    default: c2p_SSP_SHARED_47_oen = 1'b1;
  endcase
end

endmodule
