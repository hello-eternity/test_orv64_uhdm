module soc_top
import pygmy_cfg::*;
import pygmy_typedef::*;
import orv_cfg::*;
import orv_typedef::*;
import orv64_typedef_pkg::*;
import pygmy_intf_typedef::*;
import vcore_pkg::*;
import station_dma_pkg::*;
import plic_typedef::*;
import station_slow_io_pkg::*;
(
  input  B0_pll_out,
  input  B10_pll_out,
  input  B11_pll_out,
  input  B12_pll_out,
  input  B13_pll_out,
  input  B14_pll_out,
  input  B15_pll_out,
  input  B16_pll_out,
  input  B17_pll_out,
  input  B18_pll_out,
  input  B19_pll_out,
  input  B1_ddr_pwr_ok_in,
  input  B1_pll_out,
  input  B20_pll_out,
  input  B21_pll_out,
  input  B22_pll_out,
  input  B23_pll_out,
  input  B24_pll_out,
  input  B2_pll_out,
  input  B3_dft_mbist_mode,
  input  B3_pll_out,
  input  B4_pll_out,
  input  B5_pll_out,
  input  B6_pll_out,
  input  B7_pll_out,
  input  B8_pll_out,
  input  B9_pll_out,
  inout [11:0] BP_A,
  inout  BP_ALERT_N,
  inout [23:0] BP_D,
  inout  BP_DM0,
  inout  BP_DP0,
  inout  BP_ID0,
  output  BP_MEMRESET_L,
  inout  BP_VBUS0,
  inout  BP_VREF,
  output  BP_ZN,
  input  BP_ZN_SENSE,
  inout  BP_resref,
  output [11:0] BypassInDataAC,
  output [23:0] BypassInDataDAT,
  output [1:0] BypassInDataMASTER,
  input  BypassModeEnAC,
  input  BypassModeEnDAT,
  input  BypassModeEnMASTER,
  input [11:0] BypassOutDataAC,
  input [23:0] BypassOutDataDAT,
  input [1:0] BypassOutDataMASTER,
  input [11:0] BypassOutEnAC,
  input [23:0] BypassOutEnDAT,
  input [1:0] BypassOutEnMASTER,
  input  C25_usb_pwrdown_ssp,
  input  C26_usb_pwrdown_hsp,
  input  C27_usb_ref_ssp_en,
  input  C28_usb_ref_use_pad,
  output  DIN_DONE,
  output [63:0] DIN_ERROR_LOG_HI,
  output [63:0] DIN_ERROR_LOG_LO,
  output  FUNC_CLK,
  output  FUNC_EN_CUS_MBIST,
  output [9:0] c2p_scan_out,
  input [9:0] p2c_scan_in,
  input  ana_bscan_sel,
  input  boot_from_flash_mode,
  input  boot_fsm_mode,
  output [1:0] c2p_SSP_SHARED_sel_0,
  output [1:0] c2p_SSP_SHARED_sel_1,
  output [1:0] c2p_SSP_SHARED_sel_10,
  output [1:0] c2p_SSP_SHARED_sel_11,
  output [1:0] c2p_SSP_SHARED_sel_12,
  output [1:0] c2p_SSP_SHARED_sel_13,
  output [1:0] c2p_SSP_SHARED_sel_14,
  output [1:0] c2p_SSP_SHARED_sel_15,
  output [1:0] c2p_SSP_SHARED_sel_16,
  output [1:0] c2p_SSP_SHARED_sel_17,
  output [1:0] c2p_SSP_SHARED_sel_18,
  output [1:0] c2p_SSP_SHARED_sel_19,
  output [1:0] c2p_SSP_SHARED_sel_2,
  output [1:0] c2p_SSP_SHARED_sel_20,
  output [1:0] c2p_SSP_SHARED_sel_21,
  output [1:0] c2p_SSP_SHARED_sel_22,
  output [1:0] c2p_SSP_SHARED_sel_23,
  output [1:0] c2p_SSP_SHARED_sel_24,
  output [1:0] c2p_SSP_SHARED_sel_25,
  output [1:0] c2p_SSP_SHARED_sel_26,
  output [1:0] c2p_SSP_SHARED_sel_27,
  output [1:0] c2p_SSP_SHARED_sel_28,
  output [1:0] c2p_SSP_SHARED_sel_29,
  output [1:0] c2p_SSP_SHARED_sel_3,
  output [1:0] c2p_SSP_SHARED_sel_30,
  output [1:0] c2p_SSP_SHARED_sel_31,
  output [1:0] c2p_SSP_SHARED_sel_32,
  output [1:0] c2p_SSP_SHARED_sel_33,
  output [1:0] c2p_SSP_SHARED_sel_34,
  output [1:0] c2p_SSP_SHARED_sel_35,
  output [1:0] c2p_SSP_SHARED_sel_36,
  output [1:0] c2p_SSP_SHARED_sel_37,
  output [1:0] c2p_SSP_SHARED_sel_38,
  output [1:0] c2p_SSP_SHARED_sel_39,
  output [1:0] c2p_SSP_SHARED_sel_4,
  output [1:0] c2p_SSP_SHARED_sel_40,
  output [1:0] c2p_SSP_SHARED_sel_41,
  output [1:0] c2p_SSP_SHARED_sel_42,
  output [1:0] c2p_SSP_SHARED_sel_43,
  output [1:0] c2p_SSP_SHARED_sel_44,
  output [1:0] c2p_SSP_SHARED_sel_45,
  output [1:0] c2p_SSP_SHARED_sel_46,
  output [1:0] c2p_SSP_SHARED_sel_47,
  output [1:0] c2p_SSP_SHARED_sel_5,
  output [1:0] c2p_SSP_SHARED_sel_6,
  output [1:0] c2p_SSP_SHARED_sel_7,
  output [1:0] c2p_SSP_SHARED_sel_8,
  output [1:0] c2p_SSP_SHARED_sel_9,
  output [31:0] c2p_gpio_porta_ddr,
  output [31:0] c2p_gpio_porta_dr,
  output  c2p_i2c0_ic_clk_oen,
  output  c2p_i2c0_ic_data_oen,
  output  c2p_i2c1_ic_clk_oen,
  output  c2p_i2c1_ic_data_oen,
  output  c2p_i2c2_ic_clk_oen,
  output  c2p_i2c2_ic_data_oen,
  output  c2p_i2sm_sclk,
  output  c2p_i2sm_sdo0,
  output  c2p_i2sm_sdo1,
  output  c2p_i2sm_sdo2,
  output  c2p_i2sm_sdo3,
  output  c2p_i2sm_ws_out,
  output  c2p_i2ss0_sclk,
  output  c2p_i2ss0_ws_out,
  output  c2p_i2ss1_sclk,
  output  c2p_i2ss1_ws_out,
  output  c2p_i2ss2_sclk,
  output  c2p_i2ss2_ws_out,
  output  c2p_i2ss3_sclk,
  output  c2p_i2ss3_ws_out,
  output  c2p_i2ss4_sclk,
  output  c2p_i2ss4_ws_out,
  output  c2p_i2ss5_sclk,
  output  c2p_i2ss5_ws_out,
  output c2p_jtag_tdo,
  output c2p_jtag_tdo_oen,
  output  c2p_qspim_clk,
  output  c2p_qspim_cs_n,
  output [3:0] c2p_qspim_io_oen,
  output [3:0] c2p_qspim_o,
  output  c2p_refclk_en,
  output c2p_scan_f_out,
  output  c2p_spis_o,
  output  c2p_sspim0_clk,
  output  c2p_sspim0_cs_n,
  output  c2p_sspim0_o,
  output  c2p_sspim1_clk,
  output  c2p_sspim1_cs_n,
  output  c2p_sspim1_o,
  output  c2p_sspim2_clk,
  output  c2p_sspim2_cs_n,
  output  c2p_sspim2_o,
  output  c2p_test_io_clk,
  output  c2p_test_io_clk_oen,
  output  c2p_test_io_data,
  output  c2p_test_io_data_oen,
  output  c2p_test_io_en,
  output  c2p_test_io_en_oen,
  output  c2p_timer_1_toggle,
  output  c2p_timer_2_toggle,
  output  c2p_timer_3_toggle,
  output  c2p_timer_4_toggle,
  output  c2p_timer_5_toggle,
  output  c2p_timer_6_toggle,
  output  c2p_timer_7_toggle,
  output  c2p_timer_8_toggle,
  output  c2p_uart0_rts_n,
  output  c2p_uart0_sout,
  output  c2p_uart1_sout,
  output  c2p_uart2_sout,
  output  c2p_uart3_sout,
  input  card_detect_n,
  input  card_write_prot,
  input  cclk_rx,
  input  cmd_vld_in,
  input [127:0] cmdbuf_in,
  input  dft_glue_u_tck_invert_in,
  output  gated_tx_clk_out,
  input  global_scan_enable,
  output  io_test_mode,
  input  jtag_tdi_to_usb,
  output  jtag_tdo_en_from_usb,
  output  jtag_tdo_from_usb,
  input  jtag_tms_to_usb,
  input  jtag_trst_n_to_usb,
  `ifdef EXT_MEM_NOC_BRIDGE
  output cache_mem_if_ar_t mem_noc_req_if_ar,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  input  mem_noc_req_if_arready,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  output  mem_noc_req_if_arvalid,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  output cache_mem_if_aw_t mem_noc_req_if_aw,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  input  mem_noc_req_if_awready,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  output  mem_noc_req_if_awvalid,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  output cache_mem_if_w_t mem_noc_req_if_w,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  input  mem_noc_req_if_wready,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  output  mem_noc_req_if_wvalid,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  input cache_mem_if_b_t mem_noc_resp_if_b,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  output  mem_noc_resp_if_bready,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  input  mem_noc_resp_if_bvalid,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  input cache_mem_if_r_t mem_noc_resp_if_r,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  output  mem_noc_resp_if_rready,
  `endif
  `ifdef EXT_MEM_NOC_BRIDGE
  input  mem_noc_resp_if_rvalid,
  `endif
  `ifdef EXT_OR_BRIDGE
  input oursring_req_if_ar_t or_req_if_ar,
  `endif
  `ifdef EXT_OR_BRIDGE
  output  or_req_if_arready,
  `endif
  `ifdef EXT_OR_BRIDGE
  input  or_req_if_arvalid,
  `endif
  `ifdef EXT_OR_BRIDGE
  input oursring_req_if_aw_t or_req_if_aw,
  `endif
  `ifdef EXT_OR_BRIDGE
  output  or_req_if_awready,
  `endif
  `ifdef EXT_OR_BRIDGE
  input  or_req_if_awvalid,
  `endif
  `ifdef EXT_OR_BRIDGE
  input oursring_req_if_w_t or_req_if_w,
  `endif
  `ifdef EXT_OR_BRIDGE
  output  or_req_if_wready,
  `endif
  `ifdef EXT_OR_BRIDGE
  input  or_req_if_wvalid,
  `endif
  `ifdef EXT_OR_BRIDGE
  output oursring_resp_if_b_t or_resp_if_b,
  `endif
  `ifdef EXT_OR_BRIDGE
  input  or_resp_if_bready,
  `endif
  `ifdef EXT_OR_BRIDGE
  output  or_resp_if_bvalid,
  `endif
  `ifdef EXT_OR_BRIDGE
  output oursring_resp_if_r_t or_resp_if_r,
  `endif
  `ifdef EXT_OR_BRIDGE
  input  or_resp_if_rready,
  `endif
  `ifdef EXT_OR_BRIDGE
  output  or_resp_if_rvalid,
  `endif
  input  p2c_chip_wake_up,
  input [31:0] p2c_gpio_ext_porta,
  input  p2c_i2c0_ic_clk_in_a,
  input  p2c_i2c0_ic_data_in_a,
  input  p2c_i2c1_ic_clk_in_a,
  input  p2c_i2c1_ic_data_in_a,
  input  p2c_i2c2_ic_clk_in_a,
  input  p2c_i2c2_ic_data_in_a,
  input  p2c_i2ss0_sdi0,
  input  p2c_i2ss0_sdi1,
  input  p2c_i2ss0_sdi2,
  input  p2c_i2ss0_sdi3,
  input  p2c_i2ss1_sdi0,
  input  p2c_i2ss1_sdi1,
  input  p2c_i2ss1_sdi2,
  input  p2c_i2ss1_sdi3,
  input  p2c_i2ss2_sdi0,
  input  p2c_i2ss2_sdi1,
  input  p2c_i2ss2_sdi2,
  input  p2c_i2ss2_sdi3,
  input  p2c_i2ss3_sdi0,
  input  p2c_i2ss3_sdi1,
  input  p2c_i2ss3_sdi2,
  input  p2c_i2ss3_sdi3,
  input  p2c_i2ss4_sdi0,
  input  p2c_i2ss4_sdi1,
  input  p2c_i2ss4_sdi2,
  input  p2c_i2ss4_sdi3,
  input  p2c_i2ss5_sdi0,
  input  p2c_i2ss5_sdi1,
  input  p2c_i2ss5_sdi2,
  input  p2c_i2ss5_sdi3,
  input p2c_jtag_tck,
  input p2c_jtag_tdi,
  input p2c_jtag_tms,
  input p2c_jtag_trst_n,
  input [3:0] p2c_qspim_i,
  input  p2c_refclk,
  input  p2c_resetn,
  input  p2c_rtcclk,
  input p2c_scan_ate_clk,
  input p2c_scan_enable,
  input  p2c_scan_f_clk,
  input p2c_scan_f_in,
  input  p2c_scan_f_mode,
  input  p2c_scan_f_reset,
  input  p2c_scan_mode,
  input  p2c_scan_reset,
  input  p2c_scan_tap_compliance,
  input p2c_scan_test_modes,
  input  p2c_spis_clk,
  input  p2c_spis_cs_n,
  input  p2c_spis_i,
  input  p2c_sspim0_i,
  input  p2c_sspim1_i,
  input  p2c_sspim2_i,
  input  p2c_test_io_clk,
  input  p2c_test_io_data,
  input  p2c_test_io_en,
  input  p2c_uart0_cts_n,
  input  p2c_uart0_sin,
  input  p2c_uart1_sin,
  input  p2c_uart2_sin,
  input  p2c_uart3_sin,
  input  pygmy_es1y_ac_init_clk_in,
  input  pygmy_es1y_ac_mode_in,
  input  pygmy_es1y_ac_test_in,
  input  pygmy_es1y_pygmy_es1y_CLAMP___in,
  input pygmy_es1y_pygmy_es1y_EXTEST_PULSE__EXTEST_TRAIN___in,
  input  pygmy_es1y_pygmy_es1y_EXTEST__INTEST___in,
  input  pygmy_es1y_pygmy_es1y_HIGHZ__RUNBIST___in,
  input  pygmy_es1y_pygmy_es1y_PRELOAD__SAMPLE___in,
  input  pygmy_es1y_pygmy_es1y_capture_dr_1_in,
  input pygmy_es1y_pygmy_es1y_one_in,
  input pygmy_es1y_pygmy_es1y_shift_dr_13_in,
  input  pygmy_es1y_pygmy_es1y_update_dr_1_in,
  input pygmy_es1y_pygmy_es1y_zero_in,
  input pygmy_es1y_pygmy_es1y_zero_ina,
  input  pygmy_es1y_shift_dr_in,
  input  pygmy_es1y_soc_top_u_si_in,
  output [63:0] rdata_out,
  output  rdata_vld_out,
  input  ref_pad_clk_m,
  input  ref_pad_clk_p,
  input  rx0_m,
  input  rx0_p,
  input  sd_cmd_in,
  output  sd_cmd_out,
  output  sd_cmd_out_en,
  input [3:0] sd_dat_in,
  output [3:0] sd_dat_out,
  output [3:0] sd_dat_out_en,
  output  soc_top_u_out,
  output  tx0_m,
  output  tx0_p,
  input  usb_icg_ten,
  input  usb_jtag_tck_gated,
  input  vcore_icg_ten
);

  `ifdef EXT_MEM_NOC_BRIDGE
    `define IFDEF_EXT_MEM_NOC_BRIDGE
  `endif

  `ifdef EXT_OR_BRIDGE
    `define IFDEF_EXT_OR_BRIDGE
  `endif

  `ifdef FPGA
    `ifdef SINGLE_VP
      `define IFDEF_FPGA__IFDEF_SINGLE_VP
    `endif
  `endif

  `ifdef FPGA
    `ifndef SINGLE_VP
      `define IFDEF_FPGA__IFNDEF_SINGLE_VP
    `endif
  `endif

  `ifdef NO_DDR
    `define IFDEF_NO_DDR
  `endif

  `ifdef NO_DT
    `define IFDEF_NO_DT
  `endif

  `ifdef NO_ORV32
    `define IFDEF_NO_ORV32
  `endif

  `ifdef NO_SDIO
    `ifndef TB_USE_ROB
      `define IFDEF_NO_SDIO__IFNDEF_TB_USE_ROB
    `endif
  `endif

  `ifdef NO_SSP_TOP
    `define IFDEF_NO_SSP_TOP
  `endif

  `ifdef NO_USB
    `ifndef NO_SSP_TOP
      `define IFDEF_NO_USB__IFNDEF_NO_SSP_TOP
    `endif
  `endif

  `ifdef NO_USB
    `ifndef TB_USE_ROB
      `define IFDEF_NO_USB__IFNDEF_TB_USE_ROB
    `endif
  `endif

  `ifdef SINGLE_VP
    `define IFDEF_SINGLE_VP
  `endif

  `ifdef SOC_NO_BANK2
    `define IFDEF_SOC_NO_BANK2
  `endif

  `ifdef SOC_NO_BANK3
    `define IFDEF_SOC_NO_BANK3
  `endif

  `ifdef TB_USE_CPU_NOC
    `define IFDEF_TB_USE_CPU_NOC
  `endif

  `ifdef TB_USE_DDR
    `define IFDEF_TB_USE_DDR
  `endif

  `ifdef ZEBU_SRAM_DDR
    `define IFDEF_ZEBU_SRAM_DDR
  `endif

  `ifndef EXT_OR_BRIDGE
    `ifndef TB_USE_USB_STATION_LOCAL_IF
      `define IFNDEF_EXT_OR_BRIDGE__IFNDEF_TB_USE_USB_STATION_LOCAL_IF
    `endif
  `endif

  `ifndef FPGA
    `define IFNDEF_FPGA
  `endif

  `ifndef NO_DDR
    `define IFNDEF_NO_DDR
  `endif

  `ifndef NO_DT
    `define IFNDEF_NO_DT
  `endif

  `ifndef NO_DT
    `ifdef TB_USE_MEM_NOC
      `define IFNDEF_NO_DT__IFDEF_TB_USE_MEM_NOC
    `endif
  `endif

  `ifndef NO_DT
    `ifndef TB_USE_MEM_NOC
      `define IFNDEF_NO_DT__IFNDEF_TB_USE_MEM_NOC
    `endif
  `endif

  `ifndef NO_ORV32
    `define IFNDEF_NO_ORV32
  `endif

  `ifndef NO_ORV32
    `ifdef TB_USE_CPU_NOC
      `define IFNDEF_NO_ORV32__IFDEF_TB_USE_CPU_NOC
    `endif
  `endif

  `ifndef NO_ORV32
    `ifndef TB_USE_CPU_NOC
      `define IFNDEF_NO_ORV32__IFNDEF_TB_USE_CPU_NOC
    `endif
  `endif

  `ifndef NO_SDIO
    `define IFNDEF_NO_SDIO
  `endif

  `ifndef NO_SSP_TOP
    `define IFNDEF_NO_SSP_TOP
  `endif

  `ifndef NO_USB
    `define IFNDEF_NO_USB
  `endif

  `ifndef NO_USB
    `ifndef NO_SSP_TOP
      `define IFNDEF_NO_USB__IFNDEF_NO_SSP_TOP
    `endif
  `endif

  `ifndef SINGLE_VP
    `define IFNDEF_SINGLE_VP
  `endif

  `ifndef SINGLE_VP
    `ifdef TB_USE_CPU_NOC
      `define IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
    `endif
  `endif

  `ifndef SINGLE_VP
    `ifndef NO_ORV32
      `define IFNDEF_SINGLE_VP__IFNDEF_NO_ORV32
    `endif
  `endif

  `ifndef SINGLE_VP
    `ifndef TB_USE_CPU_NOC
      `define IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
    `endif
  `endif

  `ifndef SOC_NO_BANK2
    `define IFNDEF_SOC_NO_BANK2
  `endif

  `ifndef SOC_NO_BANK2
    `ifndef TB_TORTURE_OURSRING
      `define IFNDEF_SOC_NO_BANK2__IFNDEF_TB_TORTURE_OURSRING
    `endif
  `endif

  `ifndef SOC_NO_BANK2
    `ifndef TB_USE_MEM_NOC
      `define IFNDEF_SOC_NO_BANK2__IFNDEF_TB_USE_MEM_NOC
    `endif
  `endif

  `ifndef SOC_NO_BANK3
    `define IFNDEF_SOC_NO_BANK3
  `endif

  `ifndef SOC_NO_BANK3
    `ifdef TB_USE_MEM_NOC
      `define IFNDEF_SOC_NO_BANK3__IFDEF_TB_USE_MEM_NOC
    `endif
  `endif

  `ifndef SOC_NO_BANK3
    `ifndef TB_TORTURE_OURSRING
      `define IFNDEF_SOC_NO_BANK3__IFNDEF_TB_TORTURE_OURSRING
    `endif
  `endif

  `ifndef SOC_NO_BANK3
    `ifndef TB_USE_MEM_NOC
      `define IFNDEF_SOC_NO_BANK3__IFNDEF_TB_USE_MEM_NOC
    `endif
  `endif

  `ifndef SOC_NO_BANK
    `ifdef TB_USE_MEM_NOC
      `define IFNDEF_SOC_NO_BANK__IFDEF_TB_USE_MEM_NOC
    `endif
  `endif

  `ifndef TB_TORTURE_OURSRING
    `define IFNDEF_TB_TORTURE_OURSRING
  `endif

  `ifndef TB_USE_CPU_NOC
    `define IFNDEF_TB_USE_CPU_NOC
  `endif

  `ifndef TB_USE_DDR
    `ifndef EXT_MEM_NOC_BRIDGE
      `define IFNDEF_TB_USE_DDR__IFNDEF_EXT_MEM_NOC_BRIDGE
    `endif
  `endif

  `ifndef TB_USE_MEM_NOC
    `define IFNDEF_TB_USE_MEM_NOC
  `endif

  wire                      bank0_da_u__clk;
  bank_index_t              bank0_da_u__debug_addr;
  wire[7:0]                 bank0_da_u__debug_data_ram_en_pway;
  wire                      bank0_da_u__debug_dirty_ram_en;
  wire                      bank0_da_u__debug_en;
  wire                      bank0_da_u__debug_hpmcounter_en;
  wire                      bank0_da_u__debug_lru_ram_en;
  cpu_data_t                bank0_da_u__debug_rdata;
  wire                      bank0_da_u__debug_ready;
  wire                      bank0_da_u__debug_rw;
  wire[7:0]                 bank0_da_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank0_da_u__debug_valid_dirty_bit_mask;
  wire                      bank0_da_u__debug_valid_ram_en;
  mem_data_t                bank0_da_u__debug_wdata;
  cpu_byte_mask_t           bank0_da_u__debug_wdata_byte_mask;
  oursring_req_if_ar_t      bank0_da_u__ring_req_if_ar;
  wire                      bank0_da_u__ring_req_if_arready;
  wire                      bank0_da_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      bank0_da_u__ring_req_if_aw;
  wire                      bank0_da_u__ring_req_if_awready;
  wire                      bank0_da_u__ring_req_if_awvalid;
  oursring_req_if_w_t       bank0_da_u__ring_req_if_w;
  wire                      bank0_da_u__ring_req_if_wready;
  wire                      bank0_da_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      bank0_da_u__ring_resp_if_b;
  wire                      bank0_da_u__ring_resp_if_bready;
  wire                      bank0_da_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      bank0_da_u__ring_resp_if_r;
  wire                      bank0_da_u__ring_resp_if_rready;
  wire                      bank0_da_u__ring_resp_if_rvalid;
  wire                      bank0_da_u__rstn;
  wire                      bank0_icg_u__clk;
  wire                      bank0_icg_u__clkg;
  wire                      bank0_icg_u__en;
  wire                      bank0_icg_u__rstn;
  wire                      bank0_icg_u__tst_en;
  wire                      bank0_rstn_sync_u__clk;
  wire                      bank0_rstn_sync_u__rstn_in;
  wire                      bank0_rstn_sync_u__rstn_out;
  wire                      bank0_rstn_sync_u__scan_en;
  wire                      bank0_rstn_sync_u__scan_rstn;
  wire                      bank0_station_u__clk;
  oursring_req_if_ar_t      bank0_station_u__i_req_local_if_ar;
  wire                      bank0_station_u__i_req_local_if_arready;
  wire                      bank0_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      bank0_station_u__i_req_local_if_aw;
  wire                      bank0_station_u__i_req_local_if_awready;
  wire                      bank0_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       bank0_station_u__i_req_local_if_w;
  wire                      bank0_station_u__i_req_local_if_wready;
  wire                      bank0_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      bank0_station_u__i_req_ring_if_ar;
  wire                      bank0_station_u__i_req_ring_if_arready;
  wire                      bank0_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank0_station_u__i_req_ring_if_aw;
  wire                      bank0_station_u__i_req_ring_if_awready;
  wire                      bank0_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       bank0_station_u__i_req_ring_if_w;
  wire                      bank0_station_u__i_req_ring_if_wready;
  wire                      bank0_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank0_station_u__i_resp_local_if_b;
  wire                      bank0_station_u__i_resp_local_if_bready;
  wire                      bank0_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank0_station_u__i_resp_local_if_r;
  wire                      bank0_station_u__i_resp_local_if_rready;
  wire                      bank0_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank0_station_u__i_resp_ring_if_b;
  wire                      bank0_station_u__i_resp_ring_if_bready;
  wire                      bank0_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank0_station_u__i_resp_ring_if_r;
  wire                      bank0_station_u__i_resp_ring_if_rready;
  wire                      bank0_station_u__i_resp_ring_if_rvalid;
  oursring_req_if_ar_t      bank0_station_u__o_req_local_if_ar;
  wire                      bank0_station_u__o_req_local_if_arready;
  wire                      bank0_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      bank0_station_u__o_req_local_if_aw;
  wire                      bank0_station_u__o_req_local_if_awready;
  wire                      bank0_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       bank0_station_u__o_req_local_if_w;
  wire                      bank0_station_u__o_req_local_if_wready;
  wire                      bank0_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      bank0_station_u__o_req_ring_if_ar;
  wire                      bank0_station_u__o_req_ring_if_arready;
  wire                      bank0_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank0_station_u__o_req_ring_if_aw;
  wire                      bank0_station_u__o_req_ring_if_awready;
  wire                      bank0_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       bank0_station_u__o_req_ring_if_w;
  wire                      bank0_station_u__o_req_ring_if_wready;
  wire                      bank0_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank0_station_u__o_resp_local_if_b;
  wire                      bank0_station_u__o_resp_local_if_bready;
  wire                      bank0_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank0_station_u__o_resp_local_if_r;
  wire                      bank0_station_u__o_resp_local_if_rready;
  wire                      bank0_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank0_station_u__o_resp_ring_if_b;
  wire                      bank0_station_u__o_resp_ring_if_bready;
  wire                      bank0_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank0_station_u__o_resp_ring_if_r;
  wire                      bank0_station_u__o_resp_ring_if_rready;
  wire                      bank0_station_u__o_resp_ring_if_rvalid;
  ctrl_reg_t                bank0_station_u__out_s2b_ctrl_reg;
  wire                      bank0_station_u__out_s2b_icg_disable;
  wire                      bank0_station_u__out_s2b_rstn;
  wire                      bank0_station_u__out_s2icg_clk_en;
  wire                      bank0_station_u__rstn;
  wire                      bank0_u__cache_is_idle;
  wire                      bank0_u__clk;
  cpu_cache_if_req_t        bank0_u__cpu_l2_req_if_req;
  wire                      bank0_u__cpu_l2_req_if_req_ready;
  wire                      bank0_u__cpu_l2_req_if_req_valid;
  cpu_cache_if_resp_t       bank0_u__cpu_l2_resp_if_resp;
  wire                      bank0_u__cpu_l2_resp_if_resp_ready;
  wire                      bank0_u__cpu_l2_resp_if_resp_valid;
  bank_index_t              bank0_u__debug_addr;
  wire[7:0]                 bank0_u__debug_data_ram_en_pway;
  wire                      bank0_u__debug_dirty_ram_en;
  wire                      bank0_u__debug_en;
  wire                      bank0_u__debug_hpmcounter_en;
  wire                      bank0_u__debug_lru_ram_en;
  cpu_data_t                bank0_u__debug_rdata;
  wire                      bank0_u__debug_ready;
  wire                      bank0_u__debug_rw;
  wire[7:0]                 bank0_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank0_u__debug_valid_dirty_bit_mask;
  wire                      bank0_u__debug_valid_ram_en;
  mem_data_t                bank0_u__debug_wdata;
  cpu_byte_mask_t           bank0_u__debug_wdata_byte_mask;
  cpu_cache_if_req_t        bank0_u__l2_amo_store_req;
  wire                      bank0_u__l2_amo_store_req_ready;
  wire                      bank0_u__l2_amo_store_req_valid;
  cache_mem_if_ar_t         bank0_u__l2_req_if_ar;
  wire                      bank0_u__l2_req_if_arready;
  wire                      bank0_u__l2_req_if_arvalid;
  cache_mem_if_aw_t         bank0_u__l2_req_if_aw;
  wire                      bank0_u__l2_req_if_awready;
  wire                      bank0_u__l2_req_if_awvalid;
  cache_mem_if_w_t          bank0_u__l2_req_if_w;
  wire                      bank0_u__l2_req_if_wready;
  wire                      bank0_u__l2_req_if_wvalid;
  cache_mem_if_b_t          bank0_u__l2_resp_if_b;
  wire                      bank0_u__l2_resp_if_bready;
  wire                      bank0_u__l2_resp_if_bvalid;
  cache_mem_if_r_t          bank0_u__l2_resp_if_r;
  wire                      bank0_u__l2_resp_if_rready;
  wire                      bank0_u__l2_resp_if_rvalid;
  mem_barrier_sts_t[2:0]    bank0_u__mem_barrier_clr_pbank_in;
  mem_barrier_sts_t[2:0]    bank0_u__mem_barrier_clr_pbank_out;
  mem_barrier_sts_t[2:0]    bank0_u__mem_barrier_status_in;
  mem_barrier_sts_t         bank0_u__mem_barrier_status_out;
  ctrl_reg_t                bank0_u__s2b_ctrl_reg;
  wire                      bank0_u__s2b_icg_disable;
  wire                      bank0_u__s2b_rstn;
  wire                      bank0_u__scan_mode;
  wire                      bank0_u__tst_en;
  wire                      bank1_da_u__clk;
  bank_index_t              bank1_da_u__debug_addr;
  wire[7:0]                 bank1_da_u__debug_data_ram_en_pway;
  wire                      bank1_da_u__debug_dirty_ram_en;
  wire                      bank1_da_u__debug_en;
  wire                      bank1_da_u__debug_hpmcounter_en;
  wire                      bank1_da_u__debug_lru_ram_en;
  cpu_data_t                bank1_da_u__debug_rdata;
  wire                      bank1_da_u__debug_ready;
  wire                      bank1_da_u__debug_rw;
  wire[7:0]                 bank1_da_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank1_da_u__debug_valid_dirty_bit_mask;
  wire                      bank1_da_u__debug_valid_ram_en;
  mem_data_t                bank1_da_u__debug_wdata;
  cpu_byte_mask_t           bank1_da_u__debug_wdata_byte_mask;
  oursring_req_if_ar_t      bank1_da_u__ring_req_if_ar;
  wire                      bank1_da_u__ring_req_if_arready;
  wire                      bank1_da_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      bank1_da_u__ring_req_if_aw;
  wire                      bank1_da_u__ring_req_if_awready;
  wire                      bank1_da_u__ring_req_if_awvalid;
  oursring_req_if_w_t       bank1_da_u__ring_req_if_w;
  wire                      bank1_da_u__ring_req_if_wready;
  wire                      bank1_da_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      bank1_da_u__ring_resp_if_b;
  wire                      bank1_da_u__ring_resp_if_bready;
  wire                      bank1_da_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      bank1_da_u__ring_resp_if_r;
  wire                      bank1_da_u__ring_resp_if_rready;
  wire                      bank1_da_u__ring_resp_if_rvalid;
  wire                      bank1_da_u__rstn;
  wire                      bank1_icg_u__clk;
  wire                      bank1_icg_u__clkg;
  wire                      bank1_icg_u__en;
  wire                      bank1_icg_u__rstn;
  wire                      bank1_icg_u__tst_en;
  wire                      bank1_rstn_sync_u__clk;
  wire                      bank1_rstn_sync_u__rstn_in;
  wire                      bank1_rstn_sync_u__rstn_out;
  wire                      bank1_rstn_sync_u__scan_en;
  wire                      bank1_rstn_sync_u__scan_rstn;
  wire                      bank1_station_u__clk;
  oursring_req_if_ar_t      bank1_station_u__i_req_local_if_ar;
  wire                      bank1_station_u__i_req_local_if_arready;
  wire                      bank1_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      bank1_station_u__i_req_local_if_aw;
  wire                      bank1_station_u__i_req_local_if_awready;
  wire                      bank1_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       bank1_station_u__i_req_local_if_w;
  wire                      bank1_station_u__i_req_local_if_wready;
  wire                      bank1_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      bank1_station_u__i_req_ring_if_ar;
  wire                      bank1_station_u__i_req_ring_if_arready;
  wire                      bank1_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank1_station_u__i_req_ring_if_aw;
  wire                      bank1_station_u__i_req_ring_if_awready;
  wire                      bank1_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       bank1_station_u__i_req_ring_if_w;
  wire                      bank1_station_u__i_req_ring_if_wready;
  wire                      bank1_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank1_station_u__i_resp_local_if_b;
  wire                      bank1_station_u__i_resp_local_if_bready;
  wire                      bank1_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank1_station_u__i_resp_local_if_r;
  wire                      bank1_station_u__i_resp_local_if_rready;
  wire                      bank1_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank1_station_u__i_resp_ring_if_b;
  wire                      bank1_station_u__i_resp_ring_if_bready;
  wire                      bank1_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank1_station_u__i_resp_ring_if_r;
  wire                      bank1_station_u__i_resp_ring_if_rready;
  wire                      bank1_station_u__i_resp_ring_if_rvalid;
  oursring_req_if_ar_t      bank1_station_u__o_req_local_if_ar;
  wire                      bank1_station_u__o_req_local_if_arready;
  wire                      bank1_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      bank1_station_u__o_req_local_if_aw;
  wire                      bank1_station_u__o_req_local_if_awready;
  wire                      bank1_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       bank1_station_u__o_req_local_if_w;
  wire                      bank1_station_u__o_req_local_if_wready;
  wire                      bank1_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      bank1_station_u__o_req_ring_if_ar;
  wire                      bank1_station_u__o_req_ring_if_arready;
  wire                      bank1_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank1_station_u__o_req_ring_if_aw;
  wire                      bank1_station_u__o_req_ring_if_awready;
  wire                      bank1_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       bank1_station_u__o_req_ring_if_w;
  wire                      bank1_station_u__o_req_ring_if_wready;
  wire                      bank1_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank1_station_u__o_resp_local_if_b;
  wire                      bank1_station_u__o_resp_local_if_bready;
  wire                      bank1_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank1_station_u__o_resp_local_if_r;
  wire                      bank1_station_u__o_resp_local_if_rready;
  wire                      bank1_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank1_station_u__o_resp_ring_if_b;
  wire                      bank1_station_u__o_resp_ring_if_bready;
  wire                      bank1_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank1_station_u__o_resp_ring_if_r;
  wire                      bank1_station_u__o_resp_ring_if_rready;
  wire                      bank1_station_u__o_resp_ring_if_rvalid;
  ctrl_reg_t                bank1_station_u__out_s2b_ctrl_reg;
  wire                      bank1_station_u__out_s2b_icg_disable;
  wire                      bank1_station_u__out_s2b_rstn;
  wire                      bank1_station_u__out_s2icg_clk_en;
  wire                      bank1_station_u__rstn;
  wire                      bank1_u__cache_is_idle;
  wire                      bank1_u__clk;
  cpu_cache_if_req_t        bank1_u__cpu_l2_req_if_req;
  wire                      bank1_u__cpu_l2_req_if_req_ready;
  wire                      bank1_u__cpu_l2_req_if_req_valid;
  cpu_cache_if_resp_t       bank1_u__cpu_l2_resp_if_resp;
  wire                      bank1_u__cpu_l2_resp_if_resp_ready;
  wire                      bank1_u__cpu_l2_resp_if_resp_valid;
  bank_index_t              bank1_u__debug_addr;
  wire[7:0]                 bank1_u__debug_data_ram_en_pway;
  wire                      bank1_u__debug_dirty_ram_en;
  wire                      bank1_u__debug_en;
  wire                      bank1_u__debug_hpmcounter_en;
  wire                      bank1_u__debug_lru_ram_en;
  cpu_data_t                bank1_u__debug_rdata;
  wire                      bank1_u__debug_ready;
  wire                      bank1_u__debug_rw;
  wire[7:0]                 bank1_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank1_u__debug_valid_dirty_bit_mask;
  wire                      bank1_u__debug_valid_ram_en;
  mem_data_t                bank1_u__debug_wdata;
  cpu_byte_mask_t           bank1_u__debug_wdata_byte_mask;
  cpu_cache_if_req_t        bank1_u__l2_amo_store_req;
  wire                      bank1_u__l2_amo_store_req_ready;
  wire                      bank1_u__l2_amo_store_req_valid;
  cache_mem_if_ar_t         bank1_u__l2_req_if_ar;
  wire                      bank1_u__l2_req_if_arready;
  wire                      bank1_u__l2_req_if_arvalid;
  cache_mem_if_aw_t         bank1_u__l2_req_if_aw;
  wire                      bank1_u__l2_req_if_awready;
  wire                      bank1_u__l2_req_if_awvalid;
  cache_mem_if_w_t          bank1_u__l2_req_if_w;
  wire                      bank1_u__l2_req_if_wready;
  wire                      bank1_u__l2_req_if_wvalid;
  cache_mem_if_b_t          bank1_u__l2_resp_if_b;
  wire                      bank1_u__l2_resp_if_bready;
  wire                      bank1_u__l2_resp_if_bvalid;
  cache_mem_if_r_t          bank1_u__l2_resp_if_r;
  wire                      bank1_u__l2_resp_if_rready;
  wire                      bank1_u__l2_resp_if_rvalid;
  mem_barrier_sts_t[2:0]    bank1_u__mem_barrier_clr_pbank_in;
  mem_barrier_sts_t[2:0]    bank1_u__mem_barrier_clr_pbank_out;
  mem_barrier_sts_t[2:0]    bank1_u__mem_barrier_status_in;
  mem_barrier_sts_t         bank1_u__mem_barrier_status_out;
  ctrl_reg_t                bank1_u__s2b_ctrl_reg;
  wire                      bank1_u__s2b_icg_disable;
  wire                      bank1_u__s2b_rstn;
  wire                      bank1_u__scan_mode;
  wire                      bank1_u__tst_en;
  `ifdef IFNDEF_SOC_NO_BANK2
  wire                      bank2_da_u__clk;
  bank_index_t              bank2_da_u__debug_addr;
  wire[7:0]                 bank2_da_u__debug_data_ram_en_pway;
  wire                      bank2_da_u__debug_dirty_ram_en;
  wire                      bank2_da_u__debug_en;
  wire                      bank2_da_u__debug_hpmcounter_en;
  wire                      bank2_da_u__debug_lru_ram_en;
  cpu_data_t                bank2_da_u__debug_rdata;
  wire                      bank2_da_u__debug_ready;
  wire                      bank2_da_u__debug_rw;
  wire[7:0]                 bank2_da_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank2_da_u__debug_valid_dirty_bit_mask;
  wire                      bank2_da_u__debug_valid_ram_en;
  mem_data_t                bank2_da_u__debug_wdata;
  cpu_byte_mask_t           bank2_da_u__debug_wdata_byte_mask;
  oursring_req_if_ar_t      bank2_da_u__ring_req_if_ar;
  wire                      bank2_da_u__ring_req_if_arready;
  wire                      bank2_da_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      bank2_da_u__ring_req_if_aw;
  wire                      bank2_da_u__ring_req_if_awready;
  wire                      bank2_da_u__ring_req_if_awvalid;
  oursring_req_if_w_t       bank2_da_u__ring_req_if_w;
  wire                      bank2_da_u__ring_req_if_wready;
  wire                      bank2_da_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      bank2_da_u__ring_resp_if_b;
  wire                      bank2_da_u__ring_resp_if_bready;
  wire                      bank2_da_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      bank2_da_u__ring_resp_if_r;
  wire                      bank2_da_u__ring_resp_if_rready;
  wire                      bank2_da_u__ring_resp_if_rvalid;
  wire                      bank2_da_u__rstn;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK2
  wire                      bank2_icg_u__clk;
  wire                      bank2_icg_u__clkg;
  wire                      bank2_icg_u__en;
  wire                      bank2_icg_u__rstn;
  wire                      bank2_icg_u__tst_en;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK2
  wire                      bank2_rstn_sync_u__clk;
  wire                      bank2_rstn_sync_u__rstn_in;
  wire                      bank2_rstn_sync_u__rstn_out;
  wire                      bank2_rstn_sync_u__scan_en;
  wire                      bank2_rstn_sync_u__scan_rstn;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK2
  wire                      bank2_station_u__clk;
  oursring_req_if_ar_t      bank2_station_u__i_req_local_if_ar;
  wire                      bank2_station_u__i_req_local_if_arready;
  wire                      bank2_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      bank2_station_u__i_req_local_if_aw;
  wire                      bank2_station_u__i_req_local_if_awready;
  wire                      bank2_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       bank2_station_u__i_req_local_if_w;
  wire                      bank2_station_u__i_req_local_if_wready;
  wire                      bank2_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      bank2_station_u__i_req_ring_if_ar;
  wire                      bank2_station_u__i_req_ring_if_arready;
  wire                      bank2_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank2_station_u__i_req_ring_if_aw;
  wire                      bank2_station_u__i_req_ring_if_awready;
  wire                      bank2_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       bank2_station_u__i_req_ring_if_w;
  wire                      bank2_station_u__i_req_ring_if_wready;
  wire                      bank2_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank2_station_u__i_resp_local_if_b;
  wire                      bank2_station_u__i_resp_local_if_bready;
  wire                      bank2_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank2_station_u__i_resp_local_if_r;
  wire                      bank2_station_u__i_resp_local_if_rready;
  wire                      bank2_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank2_station_u__i_resp_ring_if_b;
  wire                      bank2_station_u__i_resp_ring_if_bready;
  wire                      bank2_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank2_station_u__i_resp_ring_if_r;
  wire                      bank2_station_u__i_resp_ring_if_rready;
  wire                      bank2_station_u__i_resp_ring_if_rvalid;
  oursring_req_if_ar_t      bank2_station_u__o_req_local_if_ar;
  wire                      bank2_station_u__o_req_local_if_arready;
  wire                      bank2_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      bank2_station_u__o_req_local_if_aw;
  wire                      bank2_station_u__o_req_local_if_awready;
  wire                      bank2_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       bank2_station_u__o_req_local_if_w;
  wire                      bank2_station_u__o_req_local_if_wready;
  wire                      bank2_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      bank2_station_u__o_req_ring_if_ar;
  wire                      bank2_station_u__o_req_ring_if_arready;
  wire                      bank2_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank2_station_u__o_req_ring_if_aw;
  wire                      bank2_station_u__o_req_ring_if_awready;
  wire                      bank2_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       bank2_station_u__o_req_ring_if_w;
  wire                      bank2_station_u__o_req_ring_if_wready;
  wire                      bank2_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank2_station_u__o_resp_local_if_b;
  wire                      bank2_station_u__o_resp_local_if_bready;
  wire                      bank2_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank2_station_u__o_resp_local_if_r;
  wire                      bank2_station_u__o_resp_local_if_rready;
  wire                      bank2_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank2_station_u__o_resp_ring_if_b;
  wire                      bank2_station_u__o_resp_ring_if_bready;
  wire                      bank2_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank2_station_u__o_resp_ring_if_r;
  wire                      bank2_station_u__o_resp_ring_if_rready;
  wire                      bank2_station_u__o_resp_ring_if_rvalid;
  ctrl_reg_t                bank2_station_u__out_s2b_ctrl_reg;
  wire                      bank2_station_u__out_s2b_icg_disable;
  wire                      bank2_station_u__out_s2b_rstn;
  wire                      bank2_station_u__out_s2icg_clk_en;
  wire                      bank2_station_u__rstn;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK2
  wire                      bank2_u__cache_is_idle;
  wire                      bank2_u__clk;
  cpu_cache_if_req_t        bank2_u__cpu_l2_req_if_req;
  wire                      bank2_u__cpu_l2_req_if_req_ready;
  wire                      bank2_u__cpu_l2_req_if_req_valid;
  cpu_cache_if_resp_t       bank2_u__cpu_l2_resp_if_resp;
  wire                      bank2_u__cpu_l2_resp_if_resp_ready;
  wire                      bank2_u__cpu_l2_resp_if_resp_valid;
  bank_index_t              bank2_u__debug_addr;
  wire[7:0]                 bank2_u__debug_data_ram_en_pway;
  wire                      bank2_u__debug_dirty_ram_en;
  wire                      bank2_u__debug_en;
  wire                      bank2_u__debug_hpmcounter_en;
  wire                      bank2_u__debug_lru_ram_en;
  cpu_data_t                bank2_u__debug_rdata;
  wire                      bank2_u__debug_ready;
  wire                      bank2_u__debug_rw;
  wire[7:0]                 bank2_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank2_u__debug_valid_dirty_bit_mask;
  wire                      bank2_u__debug_valid_ram_en;
  mem_data_t                bank2_u__debug_wdata;
  cpu_byte_mask_t           bank2_u__debug_wdata_byte_mask;
  cpu_cache_if_req_t        bank2_u__l2_amo_store_req;
  wire                      bank2_u__l2_amo_store_req_ready;
  wire                      bank2_u__l2_amo_store_req_valid;
  cache_mem_if_ar_t         bank2_u__l2_req_if_ar;
  wire                      bank2_u__l2_req_if_arready;
  wire                      bank2_u__l2_req_if_arvalid;
  cache_mem_if_aw_t         bank2_u__l2_req_if_aw;
  wire                      bank2_u__l2_req_if_awready;
  wire                      bank2_u__l2_req_if_awvalid;
  cache_mem_if_w_t          bank2_u__l2_req_if_w;
  wire                      bank2_u__l2_req_if_wready;
  wire                      bank2_u__l2_req_if_wvalid;
  cache_mem_if_b_t          bank2_u__l2_resp_if_b;
  wire                      bank2_u__l2_resp_if_bready;
  wire                      bank2_u__l2_resp_if_bvalid;
  cache_mem_if_r_t          bank2_u__l2_resp_if_r;
  wire                      bank2_u__l2_resp_if_rready;
  wire                      bank2_u__l2_resp_if_rvalid;
  mem_barrier_sts_t[2:0]    bank2_u__mem_barrier_clr_pbank_in;
  mem_barrier_sts_t[2:0]    bank2_u__mem_barrier_clr_pbank_out;
  mem_barrier_sts_t[2:0]    bank2_u__mem_barrier_status_in;
  mem_barrier_sts_t         bank2_u__mem_barrier_status_out;
  ctrl_reg_t                bank2_u__s2b_ctrl_reg;
  wire                      bank2_u__s2b_icg_disable;
  wire                      bank2_u__s2b_rstn;
  wire                      bank2_u__scan_mode;
  wire                      bank2_u__tst_en;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK3
  wire                      bank3_da_u__clk;
  bank_index_t              bank3_da_u__debug_addr;
  wire[7:0]                 bank3_da_u__debug_data_ram_en_pway;
  wire                      bank3_da_u__debug_dirty_ram_en;
  wire                      bank3_da_u__debug_en;
  wire                      bank3_da_u__debug_hpmcounter_en;
  wire                      bank3_da_u__debug_lru_ram_en;
  cpu_data_t                bank3_da_u__debug_rdata;
  wire                      bank3_da_u__debug_ready;
  wire                      bank3_da_u__debug_rw;
  wire[7:0]                 bank3_da_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank3_da_u__debug_valid_dirty_bit_mask;
  wire                      bank3_da_u__debug_valid_ram_en;
  mem_data_t                bank3_da_u__debug_wdata;
  cpu_byte_mask_t           bank3_da_u__debug_wdata_byte_mask;
  oursring_req_if_ar_t      bank3_da_u__ring_req_if_ar;
  wire                      bank3_da_u__ring_req_if_arready;
  wire                      bank3_da_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      bank3_da_u__ring_req_if_aw;
  wire                      bank3_da_u__ring_req_if_awready;
  wire                      bank3_da_u__ring_req_if_awvalid;
  oursring_req_if_w_t       bank3_da_u__ring_req_if_w;
  wire                      bank3_da_u__ring_req_if_wready;
  wire                      bank3_da_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      bank3_da_u__ring_resp_if_b;
  wire                      bank3_da_u__ring_resp_if_bready;
  wire                      bank3_da_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      bank3_da_u__ring_resp_if_r;
  wire                      bank3_da_u__ring_resp_if_rready;
  wire                      bank3_da_u__ring_resp_if_rvalid;
  wire                      bank3_da_u__rstn;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK3
  wire                      bank3_icg_u__clk;
  wire                      bank3_icg_u__clkg;
  wire                      bank3_icg_u__en;
  wire                      bank3_icg_u__rstn;
  wire                      bank3_icg_u__tst_en;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK3
  wire                      bank3_rstn_sync_u__clk;
  wire                      bank3_rstn_sync_u__rstn_in;
  wire                      bank3_rstn_sync_u__rstn_out;
  wire                      bank3_rstn_sync_u__scan_en;
  wire                      bank3_rstn_sync_u__scan_rstn;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK3
  wire                      bank3_station_u__clk;
  oursring_req_if_ar_t      bank3_station_u__i_req_local_if_ar;
  wire                      bank3_station_u__i_req_local_if_arready;
  wire                      bank3_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      bank3_station_u__i_req_local_if_aw;
  wire                      bank3_station_u__i_req_local_if_awready;
  wire                      bank3_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       bank3_station_u__i_req_local_if_w;
  wire                      bank3_station_u__i_req_local_if_wready;
  wire                      bank3_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      bank3_station_u__i_req_ring_if_ar;
  wire                      bank3_station_u__i_req_ring_if_arready;
  wire                      bank3_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank3_station_u__i_req_ring_if_aw;
  wire                      bank3_station_u__i_req_ring_if_awready;
  wire                      bank3_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       bank3_station_u__i_req_ring_if_w;
  wire                      bank3_station_u__i_req_ring_if_wready;
  wire                      bank3_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank3_station_u__i_resp_local_if_b;
  wire                      bank3_station_u__i_resp_local_if_bready;
  wire                      bank3_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank3_station_u__i_resp_local_if_r;
  wire                      bank3_station_u__i_resp_local_if_rready;
  wire                      bank3_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank3_station_u__i_resp_ring_if_b;
  wire                      bank3_station_u__i_resp_ring_if_bready;
  wire                      bank3_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank3_station_u__i_resp_ring_if_r;
  wire                      bank3_station_u__i_resp_ring_if_rready;
  wire                      bank3_station_u__i_resp_ring_if_rvalid;
  oursring_req_if_ar_t      bank3_station_u__o_req_local_if_ar;
  wire                      bank3_station_u__o_req_local_if_arready;
  wire                      bank3_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      bank3_station_u__o_req_local_if_aw;
  wire                      bank3_station_u__o_req_local_if_awready;
  wire                      bank3_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       bank3_station_u__o_req_local_if_w;
  wire                      bank3_station_u__o_req_local_if_wready;
  wire                      bank3_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      bank3_station_u__o_req_ring_if_ar;
  wire                      bank3_station_u__o_req_ring_if_arready;
  wire                      bank3_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      bank3_station_u__o_req_ring_if_aw;
  wire                      bank3_station_u__o_req_ring_if_awready;
  wire                      bank3_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       bank3_station_u__o_req_ring_if_w;
  wire                      bank3_station_u__o_req_ring_if_wready;
  wire                      bank3_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      bank3_station_u__o_resp_local_if_b;
  wire                      bank3_station_u__o_resp_local_if_bready;
  wire                      bank3_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      bank3_station_u__o_resp_local_if_r;
  wire                      bank3_station_u__o_resp_local_if_rready;
  wire                      bank3_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      bank3_station_u__o_resp_ring_if_b;
  wire                      bank3_station_u__o_resp_ring_if_bready;
  wire                      bank3_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      bank3_station_u__o_resp_ring_if_r;
  wire                      bank3_station_u__o_resp_ring_if_rready;
  wire                      bank3_station_u__o_resp_ring_if_rvalid;
  ctrl_reg_t                bank3_station_u__out_s2b_ctrl_reg;
  wire                      bank3_station_u__out_s2b_icg_disable;
  wire                      bank3_station_u__out_s2b_rstn;
  wire                      bank3_station_u__out_s2icg_clk_en;
  wire                      bank3_station_u__rstn;
  `endif
  `ifdef IFNDEF_SOC_NO_BANK3
  wire                      bank3_u__cache_is_idle;
  wire                      bank3_u__clk;
  cpu_cache_if_req_t        bank3_u__cpu_l2_req_if_req;
  wire                      bank3_u__cpu_l2_req_if_req_ready;
  wire                      bank3_u__cpu_l2_req_if_req_valid;
  cpu_cache_if_resp_t       bank3_u__cpu_l2_resp_if_resp;
  wire                      bank3_u__cpu_l2_resp_if_resp_ready;
  wire                      bank3_u__cpu_l2_resp_if_resp_valid;
  bank_index_t              bank3_u__debug_addr;
  wire[7:0]                 bank3_u__debug_data_ram_en_pway;
  wire                      bank3_u__debug_dirty_ram_en;
  wire                      bank3_u__debug_en;
  wire                      bank3_u__debug_hpmcounter_en;
  wire                      bank3_u__debug_lru_ram_en;
  cpu_data_t                bank3_u__debug_rdata;
  wire                      bank3_u__debug_ready;
  wire                      bank3_u__debug_rw;
  wire[7:0]                 bank3_u__debug_tag_ram_en_pway;
  wire[7:0]                 bank3_u__debug_valid_dirty_bit_mask;
  wire                      bank3_u__debug_valid_ram_en;
  mem_data_t                bank3_u__debug_wdata;
  cpu_byte_mask_t           bank3_u__debug_wdata_byte_mask;
  cpu_cache_if_req_t        bank3_u__l2_amo_store_req;
  wire                      bank3_u__l2_amo_store_req_ready;
  wire                      bank3_u__l2_amo_store_req_valid;
  cache_mem_if_ar_t         bank3_u__l2_req_if_ar;
  wire                      bank3_u__l2_req_if_arready;
  wire                      bank3_u__l2_req_if_arvalid;
  cache_mem_if_aw_t         bank3_u__l2_req_if_aw;
  wire                      bank3_u__l2_req_if_awready;
  wire                      bank3_u__l2_req_if_awvalid;
  cache_mem_if_w_t          bank3_u__l2_req_if_w;
  wire                      bank3_u__l2_req_if_wready;
  wire                      bank3_u__l2_req_if_wvalid;
  cache_mem_if_b_t          bank3_u__l2_resp_if_b;
  wire                      bank3_u__l2_resp_if_bready;
  wire                      bank3_u__l2_resp_if_bvalid;
  cache_mem_if_r_t          bank3_u__l2_resp_if_r;
  wire                      bank3_u__l2_resp_if_rready;
  wire                      bank3_u__l2_resp_if_rvalid;
  mem_barrier_sts_t[2:0]    bank3_u__mem_barrier_clr_pbank_in;
  mem_barrier_sts_t[2:0]    bank3_u__mem_barrier_clr_pbank_out;
  mem_barrier_sts_t[2:0]    bank3_u__mem_barrier_status_in;
  mem_barrier_sts_t         bank3_u__mem_barrier_status_out;
  ctrl_reg_t                bank3_u__s2b_ctrl_reg;
  wire                      bank3_u__s2b_icg_disable;
  wire                      bank3_u__s2b_rstn;
  wire                      bank3_u__scan_mode;
  wire                      bank3_u__tst_en;
  `endif
  wire                      boot_from_flash_en_u__in0;
  wire                      boot_from_flash_en_u__in1;
  wire                      boot_from_flash_en_u__out;
  wire[0:0]                 boot_from_flash_mux_u__din0;
  wire[0:0]                 boot_from_flash_mux_u__din1;
  wire[0:0]                 boot_from_flash_mux_u__dout;
  wire                      boot_from_flash_mux_u__sel;
  oursring_req_if_ar_t      boot_from_flash_u__axim_req_if_ar;
  wire                      boot_from_flash_u__axim_req_if_arready;
  wire                      boot_from_flash_u__axim_req_if_arvalid;
  oursring_req_if_aw_t      boot_from_flash_u__axim_req_if_aw;
  wire                      boot_from_flash_u__axim_req_if_awready;
  wire                      boot_from_flash_u__axim_req_if_awvalid;
  oursring_req_if_w_t       boot_from_flash_u__axim_req_if_w;
  wire                      boot_from_flash_u__axim_req_if_wready;
  wire                      boot_from_flash_u__axim_req_if_wvalid;
  oursring_resp_if_b_t      boot_from_flash_u__axim_rsp_if_b;
  wire                      boot_from_flash_u__axim_rsp_if_bready;
  wire                      boot_from_flash_u__axim_rsp_if_bvalid;
  oursring_resp_if_r_t      boot_from_flash_u__axim_rsp_if_r;
  wire                      boot_from_flash_u__axim_rsp_if_rready;
  wire                      boot_from_flash_u__axim_rsp_if_rvalid;
  oursring_req_if_ar_t      boot_from_flash_u__axis_req_if_ar;
  wire                      boot_from_flash_u__axis_req_if_arready;
  wire                      boot_from_flash_u__axis_req_if_arvalid;
  oursring_req_if_aw_t      boot_from_flash_u__axis_req_if_aw;
  wire                      boot_from_flash_u__axis_req_if_awready;
  wire                      boot_from_flash_u__axis_req_if_awvalid;
  oursring_req_if_w_t       boot_from_flash_u__axis_req_if_w;
  wire                      boot_from_flash_u__axis_req_if_wready;
  wire                      boot_from_flash_u__axis_req_if_wvalid;
  oursring_resp_if_b_t      boot_from_flash_u__axis_rsp_if_b;
  wire                      boot_from_flash_u__axis_rsp_if_bready;
  wire                      boot_from_flash_u__axis_rsp_if_bvalid;
  oursring_resp_if_r_t      boot_from_flash_u__axis_rsp_if_r;
  wire                      boot_from_flash_u__axis_rsp_if_rready;
  wire                      boot_from_flash_u__axis_rsp_if_rvalid;
  wire                      boot_from_flash_u__clk;
  wire                      boot_from_flash_u__rstn;
  wire                      boot_from_flash_u__s2b_boot_from_flash_ena;
  wire                      boot_fsm_en_u__in0;
  wire                      boot_fsm_en_u__in1;
  wire                      boot_fsm_en_u__out;
  wire[0:0]                 boot_fsm_mux_u__din0;
  wire[0:0]                 boot_fsm_mux_u__din1;
  wire[0:0]                 boot_fsm_mux_u__dout;
  wire                      boot_fsm_mux_u__sel;
  wire[0:0]                 boot_mode_orv32_rstn_mux_u__din0;
  wire[0:0]                 boot_mode_orv32_rstn_mux_u__din1;
  wire[0:0]                 boot_mode_orv32_rstn_mux_u__dout;
  wire                      boot_mode_orv32_rstn_mux_u__sel;
  wire                      bootup_fsm_u__clk;
  oursring_req_if_ar_t      bootup_fsm_u__or_req_if_ar;
  wire                      bootup_fsm_u__or_req_if_arready;
  wire                      bootup_fsm_u__or_req_if_arvalid;
  oursring_req_if_aw_t      bootup_fsm_u__or_req_if_aw;
  wire                      bootup_fsm_u__or_req_if_awready;
  wire                      bootup_fsm_u__or_req_if_awvalid;
  oursring_req_if_w_t       bootup_fsm_u__or_req_if_w;
  wire                      bootup_fsm_u__or_req_if_wready;
  wire                      bootup_fsm_u__or_req_if_wvalid;
  oursring_resp_if_b_t      bootup_fsm_u__or_rsp_if_b;
  wire                      bootup_fsm_u__or_rsp_if_bready;
  wire                      bootup_fsm_u__or_rsp_if_bvalid;
  oursring_resp_if_r_t      bootup_fsm_u__or_rsp_if_r;
  wire                      bootup_fsm_u__or_rsp_if_rready;
  wire                      bootup_fsm_u__or_rsp_if_rvalid;
  wire                      bootup_fsm_u__rstn;
  wire                      bootup_fsm_u__s2b_bootup_ena;
  wire[11:0]                buf_BypassInDataAC_u__in;
  wire[11:0]                buf_BypassInDataAC_u__out;
  wire[23:0]                buf_BypassInDataDAT_u__in;
  wire[23:0]                buf_BypassInDataDAT_u__out;
  wire[1:0]                 buf_BypassInDataMASTER_u__in;
  wire[1:0]                 buf_BypassInDataMASTER_u__out;
  wire                      byp_rstn_sync_u__clk;
  wire                      byp_rstn_sync_u__rstn_in;
  wire                      byp_rstn_sync_u__rstn_out;
  wire                      byp_rstn_sync_u__scan_en;
  wire                      byp_rstn_sync_u__scan_rstn;
  wire                      byp_station_u__clk;
  oursring_req_if_ar_t      byp_station_u__i_req_local_if_ar;
  wire                      byp_station_u__i_req_local_if_arready;
  wire                      byp_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      byp_station_u__i_req_local_if_aw;
  wire                      byp_station_u__i_req_local_if_awready;
  wire                      byp_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       byp_station_u__i_req_local_if_w;
  wire                      byp_station_u__i_req_local_if_wready;
  wire                      byp_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      byp_station_u__i_req_ring_if_ar;
  wire                      byp_station_u__i_req_ring_if_arready;
  wire                      byp_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      byp_station_u__i_req_ring_if_aw;
  wire                      byp_station_u__i_req_ring_if_awready;
  wire                      byp_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       byp_station_u__i_req_ring_if_w;
  wire                      byp_station_u__i_req_ring_if_wready;
  wire                      byp_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      byp_station_u__i_resp_local_if_b;
  wire                      byp_station_u__i_resp_local_if_bready;
  wire                      byp_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      byp_station_u__i_resp_local_if_r;
  wire                      byp_station_u__i_resp_local_if_rready;
  wire                      byp_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      byp_station_u__i_resp_ring_if_b;
  wire                      byp_station_u__i_resp_ring_if_bready;
  wire                      byp_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      byp_station_u__i_resp_ring_if_r;
  wire                      byp_station_u__i_resp_ring_if_rready;
  wire                      byp_station_u__i_resp_ring_if_rvalid;
  oursring_req_if_ar_t      byp_station_u__o_req_local_if_ar;
  wire                      byp_station_u__o_req_local_if_arready;
  wire                      byp_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      byp_station_u__o_req_local_if_aw;
  wire                      byp_station_u__o_req_local_if_awready;
  wire                      byp_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       byp_station_u__o_req_local_if_w;
  wire                      byp_station_u__o_req_local_if_wready;
  wire                      byp_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      byp_station_u__o_req_ring_if_ar;
  wire                      byp_station_u__o_req_ring_if_arready;
  wire                      byp_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      byp_station_u__o_req_ring_if_aw;
  wire                      byp_station_u__o_req_ring_if_awready;
  wire                      byp_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       byp_station_u__o_req_ring_if_w;
  wire                      byp_station_u__o_req_ring_if_wready;
  wire                      byp_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      byp_station_u__o_resp_local_if_b;
  wire                      byp_station_u__o_resp_local_if_bready;
  wire                      byp_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      byp_station_u__o_resp_local_if_r;
  wire                      byp_station_u__o_resp_local_if_rready;
  wire                      byp_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      byp_station_u__o_resp_ring_if_b;
  wire                      byp_station_u__o_resp_ring_if_bready;
  wire                      byp_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      byp_station_u__o_resp_ring_if_r;
  wire                      byp_station_u__o_resp_ring_if_rready;
  wire                      byp_station_u__o_resp_ring_if_rvalid;
  wire                      byp_station_u__out_s2b_ddr_bypass_en;
  wire                      byp_station_u__out_s2b_ddr_top_icg_en;
  wire                      byp_station_u__out_s2b_ddrls_clkdiv_divclk_sel;
  wire[2:0]                 byp_station_u__out_s2b_ddrls_clkdiv_half_div_less_1;
  wire[15:0]                byp_station_u__out_s2b_sdio_cclk_tx_half_div_less_1;
  wire[15:0]                byp_station_u__out_s2b_sdio_clk_half_div_less_1;
  wire[15:0]                byp_station_u__out_s2b_sdio_tmclk_half_div_less_1;
  wire                      byp_station_u__out_s2b_slow_io_clkdiv_divclk_sel;
  wire[3:0]                 byp_station_u__out_s2b_slow_io_clkdiv_half_div_less_1;
  wire                      byp_station_u__rstn;
  wire[3:0]                 chip_idle_u__bank_idle;
  wire[3:0]                 chip_idle_u__bank_rstn;
  wire                      chip_idle_u__chip_is_idle;
  wire[4:0]                 chip_idle_u__cpu_rstn;
  wire[4:0]                 chip_idle_u__cpu_wfe;
  wire[4:0]                 chip_idle_u__cpu_wfi;
  wire                      cpu_noc_rstn_sync_u__clk;
  wire                      cpu_noc_rstn_sync_u__rstn_in;
  wire                      cpu_noc_rstn_sync_u__rstn_out;
  wire                      cpu_noc_rstn_sync_u__scan_en;
  wire                      cpu_noc_rstn_sync_u__scan_rstn;
  wire                      cpu_noc_u__clk;
  cpu_cache_if_req_t        cpu_noc_u__cpu_amo_store_noc_req[6:0];
  wire                      cpu_noc_u__cpu_amo_store_noc_req_ready[6:0];
  wire                      cpu_noc_u__cpu_amo_store_noc_req_valid[6:0];
  cpu_cache_if_req_t        cpu_noc_u__cpu_noc_req_if_req[6:0];
  wire                      cpu_noc_u__cpu_noc_req_if_req_ready[6:0];
  wire                      cpu_noc_u__cpu_noc_req_if_req_valid[6:0];
  wire[3:0]                 cpu_noc_u__entry_vld_pbank;
  wire[3:0]                 cpu_noc_u__is_oldest_pbank;
  cpu_cache_if_req_t        cpu_noc_u__l2_amo_store_req[3:0];
  wire                      cpu_noc_u__l2_amo_store_req_ready[3:0];
  wire                      cpu_noc_u__l2_amo_store_req_valid[3:0];
  cpu_cache_if_resp_t       cpu_noc_u__l2_noc_resp[3:0];
  wire                      cpu_noc_u__l2_noc_resp_ready[3:0];
  wire                      cpu_noc_u__l2_noc_resp_valid[3:0];
  cpu_cache_if_resp_t       cpu_noc_u__noc_cpu_resp_if_resp[6:0];
  wire                      cpu_noc_u__noc_cpu_resp_if_resp_ready[6:0];
  wire                      cpu_noc_u__noc_cpu_resp_if_resp_valid[6:0];
  cpu_cache_if_req_t        cpu_noc_u__noc_l2_req[3:0];
  wire                      cpu_noc_u__noc_l2_req_ready[3:0];
  wire                      cpu_noc_u__noc_l2_req_valid[3:0];
  wire                      cpu_noc_u__rstn;
  wire                      ddr_bypass_clk_div_u__dft_en;
  wire                      ddr_bypass_clk_div_u__divclk;
  wire                      ddr_bypass_clk_div_u__divclk_sel;
  wire                      ddr_bypass_clk_div_u__refclk;
  wire                      ddr_bypass_en_sync_u__clk;
  wire                      ddr_bypass_en_sync_u__d;
  wire                      ddr_bypass_en_sync_u__q;
  wire                      ddr_clk_mux_u__clk0;
  wire                      ddr_clk_mux_u__clk1;
  wire                      ddr_clk_mux_u__clk_out;
  wire                      ddr_clk_mux_u__sel;
  wire                      ddr_ddrls_clkdiv_sel_sync_u__clk;
  wire                      ddr_ddrls_clkdiv_sel_sync_u__d;
  wire                      ddr_ddrls_clkdiv_sel_sync_u__q;
  wire                      ddr_hs_rstn_sync_u__clk;
  wire                      ddr_hs_rstn_sync_u__rstn_in;
  wire                      ddr_hs_rstn_sync_u__rstn_out;
  wire                      ddr_hs_rstn_sync_u__scan_en;
  wire                      ddr_hs_rstn_sync_u__scan_rstn;
  wire[0:0]                 ddr_iso_or_u__in_0;
  wire[0:0]                 ddr_iso_or_u__in_1;
  wire[0:0]                 ddr_iso_or_u__out;
  wire                      ddr_ls_rstn_sync_u__clk;
  wire                      ddr_ls_rstn_sync_u__rstn_in;
  wire                      ddr_ls_rstn_sync_u__rstn_out;
  wire                      ddr_ls_rstn_sync_u__scan_en;
  wire                      ddr_ls_rstn_sync_u__scan_rstn;
  wire                      ddr_slow_clk_div_u__dft_en;
  wire                      ddr_slow_clk_div_u__divclk;
  wire                      ddr_slow_clk_div_u__divclk_sel;
  wire[2:0]                 ddr_slow_clk_div_u__half_div_less_1;
  wire                      ddr_slow_clk_div_u__refclk;
  `ifdef IFDEF_ZEBU_SRAM_DDR
  wire                      ddr_sram_top_u__clk;
  cache_mem_if_ar_t         ddr_sram_top_u__req_if_ar;
  wire                      ddr_sram_top_u__req_if_arready;
  wire                      ddr_sram_top_u__req_if_arvalid;
  cache_mem_if_aw_t         ddr_sram_top_u__req_if_aw;
  wire                      ddr_sram_top_u__req_if_awready;
  wire                      ddr_sram_top_u__req_if_awvalid;
  cache_mem_if_w_t          ddr_sram_top_u__req_if_w;
  wire                      ddr_sram_top_u__req_if_wready;
  wire                      ddr_sram_top_u__req_if_wvalid;
  cache_mem_if_b_t          ddr_sram_top_u__rsp_if_b;
  wire                      ddr_sram_top_u__rsp_if_bready;
  wire                      ddr_sram_top_u__rsp_if_bvalid;
  cache_mem_if_r_t          ddr_sram_top_u__rsp_if_r;
  wire                      ddr_sram_top_u__rsp_if_rready;
  wire                      ddr_sram_top_u__rsp_if_rvalid;
  wire                      ddr_sram_top_u__rst_n;
  `endif
  wire                      ddr_station_u__clk;
  oursring_req_if_ar_t      ddr_station_u__i_req_local_if_ar;
  wire                      ddr_station_u__i_req_local_if_arready;
  wire                      ddr_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      ddr_station_u__i_req_local_if_aw;
  wire                      ddr_station_u__i_req_local_if_awready;
  wire                      ddr_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       ddr_station_u__i_req_local_if_w;
  wire                      ddr_station_u__i_req_local_if_wready;
  wire                      ddr_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      ddr_station_u__i_req_ring_if_ar;
  wire                      ddr_station_u__i_req_ring_if_arready;
  wire                      ddr_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      ddr_station_u__i_req_ring_if_aw;
  wire                      ddr_station_u__i_req_ring_if_awready;
  wire                      ddr_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       ddr_station_u__i_req_ring_if_w;
  wire                      ddr_station_u__i_req_ring_if_wready;
  wire                      ddr_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      ddr_station_u__i_resp_local_if_b;
  wire                      ddr_station_u__i_resp_local_if_bready;
  wire                      ddr_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      ddr_station_u__i_resp_local_if_r;
  wire                      ddr_station_u__i_resp_local_if_rready;
  wire                      ddr_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      ddr_station_u__i_resp_ring_if_b;
  wire                      ddr_station_u__i_resp_ring_if_bready;
  wire                      ddr_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      ddr_station_u__i_resp_ring_if_r;
  wire                      ddr_station_u__i_resp_ring_if_rready;
  wire                      ddr_station_u__i_resp_ring_if_rvalid;
  wire[11:0]                ddr_station_u__in_b2s_BypassInDataAC;
  wire[23:0]                ddr_station_u__in_b2s_BypassInDataDAT;
  wire[1:0]                 ddr_station_u__in_b2s_BypassInDataMASTER;
  wire                      ddr_station_u__in_b2s_cactive_0;
  wire                      ddr_station_u__in_b2s_cactive_ddrc;
  wire                      ddr_station_u__in_b2s_csysack_0;
  wire                      ddr_station_u__in_b2s_csysack_ddrc;
  wire                      ddr_station_u__in_b2s_dfi_alert_err_intr;
  wire                      ddr_station_u__in_b2s_dfi_reset_n_ref;
  wire[5:0]                 ddr_station_u__in_b2s_hif_refresh_req_bank;
  wire                      ddr_station_u__in_b2s_init_mr_done_out;
  wire[15:0]                ddr_station_u__in_b2s_rd_mrr_data;
  wire                      ddr_station_u__in_b2s_rd_mrr_data_valid;
  wire[1:0]                 ddr_station_u__in_b2s_stat_ddrc_reg_selfref_type;
  oursring_req_if_ar_t      ddr_station_u__o_req_local_if_ar;
  wire                      ddr_station_u__o_req_local_if_arready;
  wire                      ddr_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      ddr_station_u__o_req_local_if_aw;
  wire                      ddr_station_u__o_req_local_if_awready;
  wire                      ddr_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       ddr_station_u__o_req_local_if_w;
  wire                      ddr_station_u__o_req_local_if_wready;
  wire                      ddr_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      ddr_station_u__o_req_ring_if_ar;
  wire                      ddr_station_u__o_req_ring_if_arready;
  wire                      ddr_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      ddr_station_u__o_req_ring_if_aw;
  wire                      ddr_station_u__o_req_ring_if_awready;
  wire                      ddr_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       ddr_station_u__o_req_ring_if_w;
  wire                      ddr_station_u__o_req_ring_if_wready;
  wire                      ddr_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      ddr_station_u__o_resp_local_if_b;
  wire                      ddr_station_u__o_resp_local_if_bready;
  wire                      ddr_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      ddr_station_u__o_resp_local_if_r;
  wire                      ddr_station_u__o_resp_local_if_rready;
  wire                      ddr_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      ddr_station_u__o_resp_ring_if_b;
  wire                      ddr_station_u__o_resp_ring_if_bready;
  wire                      ddr_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      ddr_station_u__o_resp_ring_if_r;
  wire                      ddr_station_u__o_resp_ring_if_rready;
  wire                      ddr_station_u__o_resp_ring_if_rvalid;
  wire[11:0]                ddr_station_u__out_b2s_BypassInDataAC;
  wire[23:0]                ddr_station_u__out_b2s_BypassInDataDAT;
  wire[1:0]                 ddr_station_u__out_b2s_BypassInDataMASTER;
  wire                      ddr_station_u__out_b2s_cactive_0;
  wire                      ddr_station_u__out_b2s_cactive_ddrc;
  wire                      ddr_station_u__out_b2s_csysack_0;
  wire                      ddr_station_u__out_b2s_csysack_ddrc;
  wire                      ddr_station_u__out_b2s_dfi_alert_err_intr;
  wire                      ddr_station_u__out_b2s_dfi_reset_n_ref;
  wire[5:0]                 ddr_station_u__out_b2s_hif_refresh_req_bank;
  wire                      ddr_station_u__out_b2s_init_mr_done_out;
  wire[15:0]                ddr_station_u__out_b2s_rd_mrr_data;
  wire                      ddr_station_u__out_b2s_rd_mrr_data_valid;
  wire[1:0]                 ddr_station_u__out_b2s_stat_ddrc_reg_selfref_type;
  wire                      ddr_station_u__out_ddr_pwr_on;
  wire                      ddr_station_u__out_debug_info_enable;
  wire                      ddr_station_u__out_s2b_BypassModeEnAC;
  wire                      ddr_station_u__out_s2b_BypassModeEnDAT;
  wire                      ddr_station_u__out_s2b_BypassModeEnMASTER;
  wire[11:0]                ddr_station_u__out_s2b_BypassOutDataAC;
  wire[23:0]                ddr_station_u__out_s2b_BypassOutDataDAT;
  wire[1:0]                 ddr_station_u__out_s2b_BypassOutDataMASTER;
  wire[11:0]                ddr_station_u__out_s2b_BypassOutEnAC;
  wire[23:0]                ddr_station_u__out_s2b_BypassOutEnDAT;
  wire[1:0]                 ddr_station_u__out_s2b_BypassOutEnMASTER;
  wire                      ddr_station_u__out_s2b_aresetn_0;
  wire                      ddr_station_u__out_s2b_core_ddrc_rstn;
  wire                      ddr_station_u__out_s2b_csysreq_0;
  wire                      ddr_station_u__out_s2b_csysreq_ddrc;
  wire                      ddr_station_u__out_s2b_dfi_ctrlupd_ack2_ch0;
  wire                      ddr_station_u__out_s2b_dfi_reset_n_in;
  wire                      ddr_station_u__out_s2b_init_mr_done_in;
  wire[1:0]                 ddr_station_u__out_s2b_pa_rmask;
  wire                      ddr_station_u__out_s2b_pa_wmask;
  wire                      ddr_station_u__out_s2b_presetn;
  wire                      ddr_station_u__out_s2b_pwr_ok_in;
  wire                      ddr_station_u__rstn;
  wire                      ddr_station_u__vld_in_b2s_BypassInDataAC;
  wire                      ddr_station_u__vld_in_b2s_BypassInDataDAT;
  wire                      ddr_station_u__vld_in_b2s_BypassInDataMASTER;
  wire                      ddr_station_u__vld_in_b2s_cactive_0;
  wire                      ddr_station_u__vld_in_b2s_cactive_ddrc;
  wire                      ddr_station_u__vld_in_b2s_csysack_0;
  wire                      ddr_station_u__vld_in_b2s_csysack_ddrc;
  wire                      ddr_station_u__vld_in_b2s_dfi_alert_err_intr;
  wire                      ddr_station_u__vld_in_b2s_dfi_reset_n_ref;
  wire                      ddr_station_u__vld_in_b2s_hif_refresh_req_bank;
  wire                      ddr_station_u__vld_in_b2s_init_mr_done_out;
  wire                      ddr_station_u__vld_in_b2s_rd_mrr_data;
  wire                      ddr_station_u__vld_in_b2s_rd_mrr_data_valid;
  wire                      ddr_station_u__vld_in_b2s_stat_ddrc_reg_selfref_type;
  wire                      ddr_top_icg_u__clk;
  wire                      ddr_top_icg_u__clkg;
  wire                      ddr_top_icg_u__en;
  wire                      ddr_top_icg_u__tst_en;
  `ifdef IFNDEF_NO_DDR
  wire                      ddr_top_u__APBCLK;
  wire                      ddr_top_u__BP_MEMRESET_L;
  wire                      ddr_top_u__BP_ZN;
  wire                      ddr_top_u__BP_ZN_SENSE;
  wire                      ddr_top_u__DfiClk;
  wire                      ddr_top_u__DfiCtlClk;
  wire                      ddr_top_u__aclk_0;
  wire[31:0]                ddr_top_u__apb_paddr;
  wire                      ddr_top_u__apb_penable;
  wire                      ddr_top_u__apb_psel_s0;
  wire[31:0]                ddr_top_u__apb_pwdata;
  wire                      ddr_top_u__apb_pwrite;
  wire                      ddr_top_u__atpg_Pclk;
  wire                      ddr_top_u__atpg_RDQSClk;
  wire                      ddr_top_u__atpg_TxDllClk;
  wire                      ddr_top_u__atpg_mode;
  wire[5:0]                 ddr_top_u__atpg_se;
  wire[167:0]               ddr_top_u__atpg_si;
  wire[167:0]               ddr_top_u__atpg_so;
  wire[11:0]                ddr_top_u__b2s_BypassInDataAC;
  wire[23:0]                ddr_top_u__b2s_BypassInDataDAT;
  wire[1:0]                 ddr_top_u__b2s_BypassInDataMASTER;
  wire                      ddr_top_u__b2s_cactive_0;
  wire                      ddr_top_u__b2s_cactive_ddrc;
  wire                      ddr_top_u__b2s_csysack_0;
  wire                      ddr_top_u__b2s_csysack_ddrc;
  wire                      ddr_top_u__b2s_dfi_alert_err_intr;
  wire                      ddr_top_u__b2s_dfi_reset_n_ref;
  wire[5:0]                 ddr_top_u__b2s_hif_refresh_req_bank;
  wire                      ddr_top_u__b2s_init_mr_done_out;
  wire[15:0]                ddr_top_u__b2s_rd_mrr_data;
  wire                      ddr_top_u__b2s_rd_mrr_data_valid;
  wire[1:0]                 ddr_top_u__b2s_stat_ddrc_reg_selfref_type;
  wire[31:0]                ddr_top_u__cdc_prdata;
  wire                      ddr_top_u__cdc_pready;
  wire                      ddr_top_u__cdc_pslverr;
  wire                      ddr_top_u__core_ddrc_core_clk;
  wire                      ddr_top_u__mbist_mode;
  wire                      ddr_top_u__pclk;
  wire                      ddr_top_u__phy_ddr_clk;
  cache_mem_if_ar_t         ddr_top_u__req_if_ar;
  wire                      ddr_top_u__req_if_arready;
  wire                      ddr_top_u__req_if_arvalid;
  cache_mem_if_aw_t         ddr_top_u__req_if_aw;
  wire                      ddr_top_u__req_if_awready;
  wire                      ddr_top_u__req_if_awvalid;
  cache_mem_if_w_t          ddr_top_u__req_if_w;
  wire                      ddr_top_u__req_if_wready;
  wire                      ddr_top_u__req_if_wvalid;
  cache_mem_if_b_t          ddr_top_u__rsp_if_b;
  wire                      ddr_top_u__rsp_if_bready;
  wire                      ddr_top_u__rsp_if_bvalid;
  cache_mem_if_r_t          ddr_top_u__rsp_if_r;
  wire                      ddr_top_u__rsp_if_rready;
  wire                      ddr_top_u__rsp_if_rvalid;
  wire                      ddr_top_u__s2b_BypassModeEnAC;
  wire                      ddr_top_u__s2b_BypassModeEnDAT;
  wire                      ddr_top_u__s2b_BypassModeEnMASTER;
  wire[11:0]                ddr_top_u__s2b_BypassOutDataAC;
  wire[23:0]                ddr_top_u__s2b_BypassOutDataDAT;
  wire[1:0]                 ddr_top_u__s2b_BypassOutDataMASTER;
  wire[11:0]                ddr_top_u__s2b_BypassOutEnAC;
  wire[23:0]                ddr_top_u__s2b_BypassOutEnDAT;
  wire[1:0]                 ddr_top_u__s2b_BypassOutEnMASTER;
  wire                      ddr_top_u__s2b_aresetn_0;
  wire                      ddr_top_u__s2b_core_ddrc_rstn;
  wire                      ddr_top_u__s2b_csysreq_0;
  wire                      ddr_top_u__s2b_csysreq_ddrc;
  wire                      ddr_top_u__s2b_dfi_ctrlupd_ack2_ch0;
  wire                      ddr_top_u__s2b_dfi_reset_n_in;
  wire                      ddr_top_u__s2b_init_mr_done_in;
  wire[1:0]                 ddr_top_u__s2b_pa_rmask;
  wire                      ddr_top_u__s2b_pa_wmask;
  wire                      ddr_top_u__s2b_presetn;
  wire                      ddr_top_u__s2b_pwr_ok_in;
  `endif
  wire[0:0]                 dft_bank0_rstn_mux_u__din0;
  wire[0:0]                 dft_bank0_rstn_mux_u__din1;
  wire[0:0]                 dft_bank0_rstn_mux_u__dout;
  wire                      dft_bank0_rstn_mux_u__sel;
  wire[0:0]                 dft_bank1_rstn_mux_u__din0;
  wire[0:0]                 dft_bank1_rstn_mux_u__din1;
  wire[0:0]                 dft_bank1_rstn_mux_u__dout;
  wire                      dft_bank1_rstn_mux_u__sel;
  wire[0:0]                 dft_bank2_rstn_mux_u__din0;
  wire[0:0]                 dft_bank2_rstn_mux_u__din1;
  wire[0:0]                 dft_bank2_rstn_mux_u__dout;
  wire                      dft_bank2_rstn_mux_u__sel;
  wire[0:0]                 dft_bank3_rstn_mux_u__din0;
  wire[0:0]                 dft_bank3_rstn_mux_u__din1;
  wire[0:0]                 dft_bank3_rstn_mux_u__dout;
  wire                      dft_bank3_rstn_mux_u__sel;
  wire                      dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_APBClk;
  wire                      dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_DfiClk;
  wire                      dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_DfiCtlClk;
  wire                      dft_ddr_atpg_one_hot_u__clk;
  wire                      dft_ddr_atpg_one_hot_u__dft_ddr_APBClk;
  wire                      dft_ddr_atpg_one_hot_u__dft_ddr_DfiClk;
  wire                      dft_ddr_atpg_one_hot_u__dft_ddr_DfiCtlClk;
  wire                      dft_ddr_atpg_one_hot_u__rstn;
  wire                      dft_ddr_atpg_one_hot_u__scan_mode;
  wire                      dft_ddr_clk_mux_sel_u__scan_mode;
  wire                      dft_ddr_clk_mux_sel_u__sel_in;
  wire                      dft_ddr_clk_mux_sel_u__sel_out;
  wire[0:0]                 dft_ddr_rstn_mux_aresetn_u__din0;
  wire[0:0]                 dft_ddr_rstn_mux_aresetn_u__din1;
  wire[0:0]                 dft_ddr_rstn_mux_aresetn_u__dout;
  wire                      dft_ddr_rstn_mux_aresetn_u__sel;
  wire[0:0]                 dft_ddr_rstn_mux_core_ddrc_rstn_u__din0;
  wire[0:0]                 dft_ddr_rstn_mux_core_ddrc_rstn_u__din1;
  wire[0:0]                 dft_ddr_rstn_mux_core_ddrc_rstn_u__dout;
  wire                      dft_ddr_rstn_mux_core_ddrc_rstn_u__sel;
  wire[0:0]                 dft_ddr_rstn_mux_dfi_reset_n_u__din0;
  wire[0:0]                 dft_ddr_rstn_mux_dfi_reset_n_u__din1;
  wire[0:0]                 dft_ddr_rstn_mux_dfi_reset_n_u__dout;
  wire                      dft_ddr_rstn_mux_dfi_reset_n_u__sel;
  wire[0:0]                 dft_ddr_rstn_mux_presetn_u__din0;
  wire[0:0]                 dft_ddr_rstn_mux_presetn_u__din1;
  wire[0:0]                 dft_ddr_rstn_mux_presetn_u__dout;
  wire                      dft_ddr_rstn_mux_presetn_u__sel;
  wire                      dft_ddrls_clkdiv_sel_mux_sel_u__scan_mode;
  wire                      dft_ddrls_clkdiv_sel_mux_sel_u__sel_in;
  wire                      dft_ddrls_clkdiv_sel_mux_sel_u__sel_out;
  wire                      dft_mode_enable_u__B3_dft_mbist_mode;
  wire                      dft_mode_enable_u__dft_mode;
  wire                      dft_mode_enable_u__p2c_scan_mode;
  wire                      dft_mode_vp_enable_u__B3_dft_mbist_mode;
  wire                      dft_mode_vp_enable_u__dft_mode;
  wire                      dft_mode_vp_enable_u__p2c_scan_mode;
  wire[0:0]                 dft_mux_BypassModeEnAC_u__din0;
  wire[0:0]                 dft_mux_BypassModeEnAC_u__din1;
  wire[0:0]                 dft_mux_BypassModeEnAC_u__dout;
  wire                      dft_mux_BypassModeEnAC_u__sel;
  wire[0:0]                 dft_mux_BypassModeEnDAT_u__din0;
  wire[0:0]                 dft_mux_BypassModeEnDAT_u__din1;
  wire[0:0]                 dft_mux_BypassModeEnDAT_u__dout;
  wire                      dft_mux_BypassModeEnDAT_u__sel;
  wire[0:0]                 dft_mux_BypassModeEnMASTER_u__din0;
  wire[0:0]                 dft_mux_BypassModeEnMASTER_u__din1;
  wire[0:0]                 dft_mux_BypassModeEnMASTER_u__dout;
  wire                      dft_mux_BypassModeEnMASTER_u__sel;
  wire[11:0]                dft_mux_BypassOutDataAC_u__din0;
  wire[11:0]                dft_mux_BypassOutDataAC_u__din1;
  wire[11:0]                dft_mux_BypassOutDataAC_u__dout;
  wire                      dft_mux_BypassOutDataAC_u__sel;
  wire[23:0]                dft_mux_BypassOutDataDAT_u__din0;
  wire[23:0]                dft_mux_BypassOutDataDAT_u__din1;
  wire[23:0]                dft_mux_BypassOutDataDAT_u__dout;
  wire                      dft_mux_BypassOutDataDAT_u__sel;
  wire[1:0]                 dft_mux_BypassOutDataMASTER_u__din0;
  wire[1:0]                 dft_mux_BypassOutDataMASTER_u__din1;
  wire[1:0]                 dft_mux_BypassOutDataMASTER_u__dout;
  wire                      dft_mux_BypassOutDataMASTER_u__sel;
  wire[11:0]                dft_mux_BypassOutEnAC_u__din0;
  wire[11:0]                dft_mux_BypassOutEnAC_u__din1;
  wire[11:0]                dft_mux_BypassOutEnAC_u__dout;
  wire                      dft_mux_BypassOutEnAC_u__sel;
  wire[23:0]                dft_mux_BypassOutEnDAT_u__din0;
  wire[23:0]                dft_mux_BypassOutEnDAT_u__din1;
  wire[23:0]                dft_mux_BypassOutEnDAT_u__dout;
  wire                      dft_mux_BypassOutEnDAT_u__sel;
  wire[1:0]                 dft_mux_BypassOutEnMASTER_u__din0;
  wire[1:0]                 dft_mux_BypassOutEnMASTER_u__din1;
  wire[1:0]                 dft_mux_BypassOutEnMASTER_u__dout;
  wire                      dft_mux_BypassOutEnMASTER_u__sel;
  wire[0:0]                 dft_mux_ddr_s2b_pwr_ok_in_u__din0;
  wire[0:0]                 dft_mux_ddr_s2b_pwr_ok_in_u__din1;
  wire[0:0]                 dft_mux_ddr_s2b_pwr_ok_in_u__dout;
  wire                      dft_mux_ddr_s2b_pwr_ok_in_u__sel;
  wire[0:0]                 dft_mux_s2b_ref_ssp_en_u__din0;
  wire[0:0]                 dft_mux_s2b_ref_ssp_en_u__din1;
  wire[0:0]                 dft_mux_s2b_ref_ssp_en_u__dout;
  wire                      dft_mux_s2b_ref_ssp_en_u__sel;
  wire[0:0]                 dft_mux_s2b_ref_use_pad_u__din0;
  wire[0:0]                 dft_mux_s2b_ref_use_pad_u__din1;
  wire[0:0]                 dft_mux_s2b_ref_use_pad_u__dout;
  wire                      dft_mux_s2b_ref_use_pad_u__sel;
  wire[0:0]                 dft_mux_test_powerdown_hsp_u__din0;
  wire[0:0]                 dft_mux_test_powerdown_hsp_u__din1;
  wire[0:0]                 dft_mux_test_powerdown_hsp_u__dout;
  wire                      dft_mux_test_powerdown_hsp_u__sel;
  wire[0:0]                 dft_mux_test_powerdown_ssp_u__din0;
  wire[0:0]                 dft_mux_test_powerdown_ssp_u__din1;
  wire[0:0]                 dft_mux_test_powerdown_ssp_u__dout;
  wire                      dft_mux_test_powerdown_ssp_u__sel;
  wire[0:0]                 dft_orv32_early_rstn_mux_u__din0;
  wire[0:0]                 dft_orv32_early_rstn_mux_u__din1;
  wire[0:0]                 dft_orv32_early_rstn_mux_u__dout;
  wire                      dft_orv32_early_rstn_mux_u__sel;
  wire[0:0]                 dft_orv32_rstn_mux_u__din0;
  wire[0:0]                 dft_orv32_rstn_mux_u__din1;
  wire[0:0]                 dft_orv32_rstn_mux_u__dout;
  wire                      dft_orv32_rstn_mux_u__sel;
  wire                      dft_phy_ddr_clk_u__clk_in;
  wire                      dft_phy_ddr_clk_u__clk_out;
  wire                      dft_phy_ddr_clk_u__scan_mode;
  wire                      dft_pllclk_clk_buf_u0__in;
  wire                      dft_pllclk_clk_buf_u0__out;
  wire                      dft_pllclk_clk_buf_u1__in;
  wire                      dft_pllclk_clk_buf_u1__out;
  wire                      dft_pllclk_clk_buf_u2__in;
  wire                      dft_pllclk_clk_buf_u2__out;
  wire                      dft_scan_f_usb_clk_icg_u__clk;
  wire                      dft_scan_f_usb_clk_icg_u__clkg;
  wire                      dft_scan_f_usb_clk_icg_u__en;
  wire                      dft_scan_f_usb_clk_icg_u__tst_en;
  wire                      dft_scan_f_vp_clk_icg_u__clk;
  wire                      dft_scan_f_vp_clk_icg_u__clkg;
  wire                      dft_scan_f_vp_clk_icg_u__en;
  wire                      dft_scan_f_vp_clk_icg_u__tst_en;
  wire                      dft_scan_reset_inv_u__in;
  wire                      dft_scan_reset_inv_u__out;
  wire[0:0]                 dft_sdio_cclk_rx_mux_u__din0;
  wire[0:0]                 dft_sdio_cclk_rx_mux_u__din1;
  wire[0:0]                 dft_sdio_cclk_rx_mux_u__dout;
  wire                      dft_sdio_cclk_rx_mux_u__sel;
  wire[0:0]                 dft_sdio_refclk_mux_u__din0;
  wire[0:0]                 dft_sdio_refclk_mux_u__din1;
  wire[0:0]                 dft_sdio_refclk_mux_u__dout;
  wire                      dft_sdio_refclk_mux_u__sel;
  wire[0:0]                 dft_sdio_resetn_u__din0;
  wire[0:0]                 dft_sdio_resetn_u__din1;
  wire[0:0]                 dft_sdio_resetn_u__dout;
  wire                      dft_sdio_resetn_u__sel;
  wire[0:0]                 dft_usb_bus_clk_early_clk_mux_u__din0;
  wire[0:0]                 dft_usb_bus_clk_early_clk_mux_u__din1;
  wire[0:0]                 dft_usb_bus_clk_early_clk_mux_u__dout;
  wire                      dft_usb_bus_clk_early_clk_mux_u__sel;
  wire[0:0]                 dft_usb_ram_clk_in_u__din0;
  wire[0:0]                 dft_usb_ram_clk_in_u__din1;
  wire[0:0]                 dft_usb_ram_clk_in_u__dout;
  wire                      dft_usb_ram_clk_in_u__sel;
  wire[0:0]                 dft_usb_suspend_clk_mux_u__din0;
  wire[0:0]                 dft_usb_suspend_clk_mux_u__din1;
  wire[0:0]                 dft_usb_suspend_clk_mux_u__dout;
  wire                      dft_usb_suspend_clk_mux_u__sel;
  wire[0:0]                 dft_usb_vaux_reset_n_u__din0;
  wire[0:0]                 dft_usb_vaux_reset_n_u__din1;
  wire[0:0]                 dft_usb_vaux_reset_n_u__dout;
  wire                      dft_usb_vaux_reset_n_u__sel;
  wire[0:0]                 dft_usb_vcc_reset_n_u__din0;
  wire[0:0]                 dft_usb_vcc_reset_n_u__din1;
  wire[0:0]                 dft_usb_vcc_reset_n_u__dout;
  wire                      dft_usb_vcc_reset_n_u__sel;
  wire                      dft_vp0_clk_in_u__clk0;
  wire                      dft_vp0_clk_in_u__clk1;
  wire                      dft_vp0_clk_in_u__clk_out;
  wire                      dft_vp0_clk_in_u__rstn;
  wire                      dft_vp0_clk_in_u__sel;
  wire[0:0]                 dft_vp0_early_rstn_mux_u__din0;
  wire[0:0]                 dft_vp0_early_rstn_mux_u__din1;
  wire[0:0]                 dft_vp0_early_rstn_mux_u__dout;
  wire                      dft_vp0_early_rstn_mux_u__sel;
  wire[0:0]                 dft_vp0_rstn_mux_u__din0;
  wire[0:0]                 dft_vp0_rstn_mux_u__din1;
  wire[0:0]                 dft_vp0_rstn_mux_u__dout;
  wire                      dft_vp0_rstn_mux_u__sel;
  wire                      dft_vp1_clk_in_u__clk0;
  wire                      dft_vp1_clk_in_u__clk1;
  wire                      dft_vp1_clk_in_u__clk_out;
  wire                      dft_vp1_clk_in_u__rstn;
  wire                      dft_vp1_clk_in_u__sel;
  wire[0:0]                 dft_vp1_early_rstn_mux_u__din0;
  wire[0:0]                 dft_vp1_early_rstn_mux_u__din1;
  wire[0:0]                 dft_vp1_early_rstn_mux_u__dout;
  wire                      dft_vp1_early_rstn_mux_u__sel;
  wire[0:0]                 dft_vp1_rstn_mux_u__din0;
  wire[0:0]                 dft_vp1_rstn_mux_u__din1;
  wire[0:0]                 dft_vp1_rstn_mux_u__dout;
  wire                      dft_vp1_rstn_mux_u__sel;
  wire                      dft_vp2_clk_in_u__clk0;
  wire                      dft_vp2_clk_in_u__clk1;
  wire                      dft_vp2_clk_in_u__clk_out;
  wire                      dft_vp2_clk_in_u__rstn;
  wire                      dft_vp2_clk_in_u__sel;
  wire[0:0]                 dft_vp2_early_rstn_mux_u__din0;
  wire[0:0]                 dft_vp2_early_rstn_mux_u__din1;
  wire[0:0]                 dft_vp2_early_rstn_mux_u__dout;
  wire                      dft_vp2_early_rstn_mux_u__sel;
  wire[0:0]                 dft_vp2_rstn_mux_u__din0;
  wire[0:0]                 dft_vp2_rstn_mux_u__din1;
  wire[0:0]                 dft_vp2_rstn_mux_u__dout;
  wire                      dft_vp2_rstn_mux_u__sel;
  wire                      dft_vp3_clk_in_u__clk0;
  wire                      dft_vp3_clk_in_u__clk1;
  wire                      dft_vp3_clk_in_u__clk_out;
  wire                      dft_vp3_clk_in_u__rstn;
  wire                      dft_vp3_clk_in_u__sel;
  wire[0:0]                 dft_vp3_early_rstn_mux_u__din0;
  wire[0:0]                 dft_vp3_early_rstn_mux_u__din1;
  wire[0:0]                 dft_vp3_early_rstn_mux_u__dout;
  wire                      dft_vp3_early_rstn_mux_u__sel;
  wire[0:0]                 dft_vp3_rstn_mux_u__din0;
  wire[0:0]                 dft_vp3_rstn_mux_u__din1;
  wire[0:0]                 dft_vp3_rstn_mux_u__dout;
  wire                      dft_vp3_rstn_mux_u__sel;
  wire                      dma_icg_u__clk;
  wire                      dma_icg_u__clkg;
  wire                      dma_icg_u__en;
  wire                      dma_icg_u__tst_en;
  wire                      dma_rstn_sync_u__clk;
  wire                      dma_rstn_sync_u__rstn_in;
  wire                      dma_rstn_sync_u__rstn_out;
  wire                      dma_rstn_sync_u__scan_en;
  wire                      dma_rstn_sync_u__scan_rstn;
  wire                      dma_station_u__clk;
  oursring_req_if_ar_t      dma_station_u__i_req_local_if_ar;
  wire                      dma_station_u__i_req_local_if_arready;
  wire                      dma_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      dma_station_u__i_req_local_if_aw;
  wire                      dma_station_u__i_req_local_if_awready;
  wire                      dma_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       dma_station_u__i_req_local_if_w;
  wire                      dma_station_u__i_req_local_if_wready;
  wire                      dma_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      dma_station_u__i_req_ring_if_ar;
  wire                      dma_station_u__i_req_ring_if_arready;
  wire                      dma_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      dma_station_u__i_req_ring_if_aw;
  wire                      dma_station_u__i_req_ring_if_awready;
  wire                      dma_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       dma_station_u__i_req_ring_if_w;
  wire                      dma_station_u__i_req_ring_if_wready;
  wire                      dma_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      dma_station_u__i_resp_local_if_b;
  wire                      dma_station_u__i_resp_local_if_bready;
  wire                      dma_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      dma_station_u__i_resp_local_if_r;
  wire                      dma_station_u__i_resp_local_if_rready;
  wire                      dma_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      dma_station_u__i_resp_ring_if_b;
  wire                      dma_station_u__i_resp_ring_if_bready;
  wire                      dma_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      dma_station_u__i_resp_ring_if_r;
  wire                      dma_station_u__i_resp_ring_if_rready;
  wire                      dma_station_u__i_resp_ring_if_rvalid;
  wire[3:0]                 dma_station_u__in_b2s_dma_thread_idle;
  plic_intr_src_t[4:0]      dma_station_u__in_b2s_plic_intr_src;
  wire                      dma_station_u__in_b2s_thread0_intr;
  wire                      dma_station_u__in_b2s_thread1_intr;
  wire                      dma_station_u__in_b2s_thread2_intr;
  wire                      dma_station_u__in_b2s_thread3_intr;
  wire                      dma_station_u__in_dma_flush_cmd_vld;
  wire[3:0]                 dma_station_u__in_dma_thread_cbuf_full_seen;
  ring_addr_t[3:0]          dma_station_u__in_dma_thread_cbuf_rp_addr;
  ring_addr_t[3:0]          dma_station_u__in_dma_thread_cbuf_wp_addr;
  dma_thread_cmd_vld_t[3:0] dma_station_u__in_dma_thread_cmd_vld;
  oursring_req_if_ar_t      dma_station_u__o_req_local_if_ar;
  wire                      dma_station_u__o_req_local_if_arready;
  wire                      dma_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      dma_station_u__o_req_local_if_aw;
  wire                      dma_station_u__o_req_local_if_awready;
  wire                      dma_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       dma_station_u__o_req_local_if_w;
  wire                      dma_station_u__o_req_local_if_wready;
  wire                      dma_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      dma_station_u__o_req_ring_if_ar;
  wire                      dma_station_u__o_req_ring_if_arready;
  wire                      dma_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      dma_station_u__o_req_ring_if_aw;
  wire                      dma_station_u__o_req_ring_if_awready;
  wire                      dma_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       dma_station_u__o_req_ring_if_w;
  wire                      dma_station_u__o_req_ring_if_wready;
  wire                      dma_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      dma_station_u__o_resp_local_if_b;
  wire                      dma_station_u__o_resp_local_if_bready;
  wire                      dma_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      dma_station_u__o_resp_local_if_r;
  wire                      dma_station_u__o_resp_local_if_rready;
  wire                      dma_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      dma_station_u__o_resp_ring_if_b;
  wire                      dma_station_u__o_resp_ring_if_bready;
  wire                      dma_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      dma_station_u__o_resp_ring_if_r;
  wire                      dma_station_u__o_resp_ring_if_rready;
  wire                      dma_station_u__o_resp_ring_if_rvalid;
  wire[3:0]                 dma_station_u__out_b2s_dma_thread_idle;
  plic_intr_src_t[4:0]      dma_station_u__out_b2s_plic_intr_src;
  wire                      dma_station_u__out_b2s_thread0_intr;
  wire                      dma_station_u__out_b2s_thread1_intr;
  wire                      dma_station_u__out_b2s_thread2_intr;
  wire                      dma_station_u__out_b2s_thread3_intr;
  wire                      dma_station_u__out_dma_flush_cmd_vld;
  wire[2:0]                 dma_station_u__out_dma_thread0_data_avail_src_sel;
  wire[2:0]                 dma_station_u__out_dma_thread1_data_avail_src_sel;
  wire[2:0]                 dma_station_u__out_dma_thread2_data_avail_src_sel;
  wire[2:0]                 dma_station_u__out_dma_thread3_data_avail_src_sel;
  wire[3:0]                 dma_station_u__out_dma_thread_cbuf_full_seen;
  ring_addr_t[3:0]          dma_station_u__out_dma_thread_cbuf_rp_addr;
  ring_addr_t[3:0]          dma_station_u__out_dma_thread_cbuf_wp_addr;
  dma_thread_cmd_vld_t[3:0] dma_station_u__out_dma_thread_cmd_vld;
  ring_addr_t               dma_station_u__out_s2b_dma_flush_addr;
  dma_flush_type_t          dma_station_u__out_s2b_dma_flush_req_type;
  wire[3:0]                 dma_station_u__out_s2b_dma_thread_cbuf_mode;
  ring_addr_t[3:0]          dma_station_u__out_s2b_dma_thread_cbuf_size;
  ring_addr_t[3:0]          dma_station_u__out_s2b_dma_thread_cbuf_thold;
  ring_addr_t[3:0]          dma_station_u__out_s2b_dma_thread_dst_addr;
  ring_addr_t[3:0]          dma_station_u__out_s2b_dma_thread_gather_grpdepth;
  ring_addr_t[3:0]          dma_station_u__out_s2b_dma_thread_gather_stride;
  ring_data_t[3:0]          dma_station_u__out_s2b_dma_thread_length_in_bytes;
  dma_thread_rpt_cnt_t[3:0] dma_station_u__out_s2b_dma_thread_rpt_cnt_less_1;
  ring_addr_t[3:0]          dma_station_u__out_s2b_dma_thread_src_addr;
  dma_thread_align_t[3:0]   dma_station_u__out_s2b_dma_thread_use_8b_align;
  plic_dbg_en_t[34:0]       dma_station_u__out_s2b_plic_dbg_en;
  plic_intr_core_id_t[34:0] dma_station_u__out_s2b_plic_intr_core_id;
  plic_intr_en_t[34:0]      dma_station_u__out_s2b_plic_intr_en;
  wire                      dma_station_u__out_s2icg_clk_en;
  wire                      dma_station_u__rstn;
  wire[3:0]                 dma_station_u__vld_in_b2s_dma_thread_idle;
  wire[4:0]                 dma_station_u__vld_in_b2s_plic_intr_src;
  wire                      dma_station_u__vld_in_b2s_thread0_intr;
  wire                      dma_station_u__vld_in_b2s_thread1_intr;
  wire                      dma_station_u__vld_in_b2s_thread2_intr;
  wire                      dma_station_u__vld_in_b2s_thread3_intr;
  wire                      dma_station_u__vld_in_dma_flush_cmd_vld;
  wire[3:0]                 dma_station_u__vld_in_dma_thread_cbuf_full_seen;
  wire[3:0]                 dma_station_u__vld_in_dma_thread_cbuf_rp_addr;
  wire[3:0]                 dma_station_u__vld_in_dma_thread_cbuf_wp_addr;
  wire[3:0]                 dma_station_u__vld_in_dma_thread_cmd_vld;
  wire[6:0]                 dma_thread0_mux_u__in;
  wire                      dma_thread0_mux_u__out;
  wire[2:0]                 dma_thread0_mux_u__sel;
  wire[6:0]                 dma_thread1_mux_u__in;
  wire                      dma_thread1_mux_u__out;
  wire[2:0]                 dma_thread1_mux_u__sel;
  wire[6:0]                 dma_thread2_mux_u__in;
  wire                      dma_thread2_mux_u__out;
  wire[2:0]                 dma_thread2_mux_u__sel;
  wire[6:0]                 dma_thread3_mux_u__in;
  wire                      dma_thread3_mux_u__out;
  wire[2:0]                 dma_thread3_mux_u__sel;
  wire[3:0]                 dma_u__b2s_dma_thread_idle;
  wire[3:0]                 dma_u__cbuf_mode_data_avail;
  wire                      dma_u__clk;
  cpu_cache_if_req_t        dma_u__cpu_cache_req_if_req;
  wire                      dma_u__cpu_cache_req_if_req_ready;
  wire                      dma_u__cpu_cache_req_if_req_valid;
  cpu_cache_if_resp_t       dma_u__cpu_cache_resp_if_resp;
  wire                      dma_u__cpu_cache_resp_if_resp_ready;
  wire                      dma_u__cpu_cache_resp_if_resp_valid;
  wire                      dma_u__dma_flush_cmd_vld;
  wire                      dma_u__dma_flush_cmd_vld_wdata;
  wire[3:0]                 dma_u__dma_intr;
  dma_thread_cmd_vld_t[3:0] dma_u__dma_thread_cmd_vld;
  dma_thread_cmd_vld_t[3:0] dma_u__dma_thread_cmd_vld_wdata;
  oursring_req_if_ar_t      dma_u__i_req_if_ar;
  wire                      dma_u__i_req_if_arready;
  wire                      dma_u__i_req_if_arvalid;
  oursring_req_if_aw_t      dma_u__i_req_if_aw;
  wire                      dma_u__i_req_if_awready;
  wire                      dma_u__i_req_if_awvalid;
  oursring_req_if_w_t       dma_u__i_req_if_w;
  wire                      dma_u__i_req_if_wready;
  wire                      dma_u__i_req_if_wvalid;
  oursring_resp_if_b_t      dma_u__i_rsp_if_b;
  wire                      dma_u__i_rsp_if_bready;
  wire                      dma_u__i_rsp_if_bvalid;
  oursring_resp_if_r_t      dma_u__i_rsp_if_r;
  wire                      dma_u__i_rsp_if_rready;
  wire                      dma_u__i_rsp_if_rvalid;
  oursring_req_if_ar_t      dma_u__o_req_if_ar;
  wire                      dma_u__o_req_if_arready;
  wire                      dma_u__o_req_if_arvalid;
  oursring_req_if_aw_t      dma_u__o_req_if_aw;
  wire                      dma_u__o_req_if_awready;
  wire                      dma_u__o_req_if_awvalid;
  oursring_req_if_w_t       dma_u__o_req_if_w;
  wire                      dma_u__o_req_if_wready;
  wire                      dma_u__o_req_if_wvalid;
  oursring_resp_if_b_t      dma_u__o_rsp_if_b;
  wire                      dma_u__o_rsp_if_bready;
  wire                      dma_u__o_rsp_if_bvalid;
  oursring_resp_if_r_t      dma_u__o_rsp_if_r;
  wire                      dma_u__o_rsp_if_rready;
  wire                      dma_u__o_rsp_if_rvalid;
  wire                      dma_u__rstn;
  ring_addr_t               dma_u__s2b_dma_flush_addr;
  dma_flush_type_t          dma_u__s2b_dma_flush_req_type;
  wire[3:0]                 dma_u__s2b_dma_thread_cbuf_mode;
  ring_addr_t[3:0]          dma_u__s2b_dma_thread_cbuf_size;
  ring_addr_t[3:0]          dma_u__s2b_dma_thread_cbuf_thold;
  ring_addr_t[3:0]          dma_u__s2b_dma_thread_dst_addr;
  ring_addr_t[3:0]          dma_u__s2b_dma_thread_gather_grpdepth;
  ring_addr_t[3:0]          dma_u__s2b_dma_thread_gather_stride;
  ring_data_t[3:0]          dma_u__s2b_dma_thread_length_in_bytes;
  dma_thread_rpt_cnt_t[3:0] dma_u__s2b_dma_thread_rpt_cnt_less_1;
  ring_addr_t[3:0]          dma_u__s2b_dma_thread_src_addr;
  dma_thread_align_t[3:0]   dma_u__s2b_dma_thread_use_8b_align;
  wire[3:0]                 dma_u__station_in_dma_thread_cbuf_full_seen;
  ring_addr_t[3:0]          dma_u__station_in_dma_thread_cbuf_rp_addr;
  ring_addr_t[3:0]          dma_u__station_in_dma_thread_cbuf_wp_addr;
  wire[3:0]                 dma_u__station_out_dma_thread_cbuf_full_seen;
  ring_addr_t[3:0]          dma_u__station_out_dma_thread_cbuf_rp_addr;
  ring_addr_t[3:0]          dma_u__station_out_dma_thread_cbuf_wp_addr;
  wire[3:0]                 dma_u__station_vld_in_dma_thread_cbuf_full_seen;
  wire[3:0]                 dma_u__station_vld_in_dma_thread_cbuf_rp_addr;
  wire[3:0]                 dma_u__station_vld_in_dma_thread_cbuf_wp_addr;
  wire                      dt_icg_u__clk;
  wire                      dt_icg_u__clkg;
  wire                      dt_icg_u__en;
  wire                      dt_icg_u__tst_en;
  wire                      dt_rstn_sync_u__clk;
  wire                      dt_rstn_sync_u__rstn_in;
  wire                      dt_rstn_sync_u__rstn_out;
  wire                      dt_rstn_sync_u__scan_en;
  wire                      dt_rstn_sync_u__scan_rstn;
  wire                      dt_station_u__clk;
  oursring_req_if_ar_t      dt_station_u__i_req_local_if_ar;
  wire                      dt_station_u__i_req_local_if_arready;
  wire                      dt_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      dt_station_u__i_req_local_if_aw;
  wire                      dt_station_u__i_req_local_if_awready;
  wire                      dt_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       dt_station_u__i_req_local_if_w;
  wire                      dt_station_u__i_req_local_if_wready;
  wire                      dt_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      dt_station_u__i_req_ring_if_ar;
  wire                      dt_station_u__i_req_ring_if_arready;
  wire                      dt_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      dt_station_u__i_req_ring_if_aw;
  wire                      dt_station_u__i_req_ring_if_awready;
  wire                      dt_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       dt_station_u__i_req_ring_if_w;
  wire                      dt_station_u__i_req_ring_if_wready;
  wire                      dt_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      dt_station_u__i_resp_local_if_b;
  wire                      dt_station_u__i_resp_local_if_bready;
  wire                      dt_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      dt_station_u__i_resp_local_if_r;
  wire                      dt_station_u__i_resp_local_if_rready;
  wire                      dt_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      dt_station_u__i_resp_ring_if_b;
  wire                      dt_station_u__i_resp_ring_if_bready;
  wire                      dt_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      dt_station_u__i_resp_ring_if_r;
  wire                      dt_station_u__i_resp_ring_if_rready;
  wire                      dt_station_u__i_resp_ring_if_rvalid;
  oursring_req_if_ar_t      dt_station_u__o_req_local_if_ar;
  wire                      dt_station_u__o_req_local_if_arready;
  wire                      dt_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      dt_station_u__o_req_local_if_aw;
  wire                      dt_station_u__o_req_local_if_awready;
  wire                      dt_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       dt_station_u__o_req_local_if_w;
  wire                      dt_station_u__o_req_local_if_wready;
  wire                      dt_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      dt_station_u__o_req_ring_if_ar;
  wire                      dt_station_u__o_req_ring_if_arready;
  wire                      dt_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      dt_station_u__o_req_ring_if_aw;
  wire                      dt_station_u__o_req_ring_if_awready;
  wire                      dt_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       dt_station_u__o_req_ring_if_w;
  wire                      dt_station_u__o_req_ring_if_wready;
  wire                      dt_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      dt_station_u__o_resp_local_if_b;
  wire                      dt_station_u__o_resp_local_if_bready;
  wire                      dt_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      dt_station_u__o_resp_local_if_r;
  wire                      dt_station_u__o_resp_local_if_rready;
  wire                      dt_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      dt_station_u__o_resp_ring_if_b;
  wire                      dt_station_u__o_resp_ring_if_bready;
  wire                      dt_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      dt_station_u__o_resp_ring_if_r;
  wire                      dt_station_u__o_resp_ring_if_rready;
  wire                      dt_station_u__o_resp_ring_if_rvalid;
  wire                      dt_station_u__out_s2icg_clk_en;
  wire                      dt_station_u__rstn;
  
  wire                      i2ss0_intr_sync_u__clk;
  wire                      i2ss0_intr_sync_u__d;
  wire                      i2ss0_intr_sync_u__q;
  wire                      i2ss1_intr_sync_u__clk;
  wire                      i2ss1_intr_sync_u__d;
  wire                      i2ss1_intr_sync_u__q;
  wire                      i2ss2_intr_sync_u__clk;
  wire                      i2ss2_intr_sync_u__d;
  wire                      i2ss2_intr_sync_u__q;
  wire                      i2ss3_intr_sync_u__clk;
  wire                      i2ss3_intr_sync_u__d;
  wire                      i2ss3_intr_sync_u__q;
  wire                      i2ss4_intr_sync_u__clk;
  wire                      i2ss4_intr_sync_u__d;
  wire                      i2ss4_intr_sync_u__q;
  wire                      i2ss5_intr_sync_u__clk;
  wire                      i2ss5_intr_sync_u__d;
  wire                      i2ss5_intr_sync_u__q;
  wire                      jtag2or_rstn_sync_u__clk;
  wire                      jtag2or_rstn_sync_u__rstn_in;
  wire                      jtag2or_rstn_sync_u__rstn_out;
  wire                      jtag2or_rstn_sync_u__scan_en;
  wire                      jtag2or_rstn_sync_u__scan_rstn;
  wire                      jtag2or_u__clk;
  wire                      jtag2or_u__cmd_vld_in;
  wire[127:0]               jtag2or_u__cmdbuf_in;
  oursring_req_if_ar_t      jtag2or_u__or_req_if_ar;
  wire                      jtag2or_u__or_req_if_arready;
  wire                      jtag2or_u__or_req_if_arvalid;
  oursring_req_if_aw_t      jtag2or_u__or_req_if_aw;
  wire                      jtag2or_u__or_req_if_awready;
  wire                      jtag2or_u__or_req_if_awvalid;
  oursring_req_if_w_t       jtag2or_u__or_req_if_w;
  wire                      jtag2or_u__or_req_if_wready;
  wire                      jtag2or_u__or_req_if_wvalid;
  oursring_resp_if_b_t      jtag2or_u__or_rsp_if_b;
  wire                      jtag2or_u__or_rsp_if_bready;
  wire                      jtag2or_u__or_rsp_if_bvalid;
  oursring_resp_if_r_t      jtag2or_u__or_rsp_if_r;
  wire                      jtag2or_u__or_rsp_if_rready;
  wire                      jtag2or_u__or_rsp_if_rvalid;
  wire[63:0]                jtag2or_u__rdata_out;
  wire                      jtag2or_u__rdata_vld_out;
  wire                      jtag2or_u__rstn;
  wire                      mbist_mode_buf__in;
  wire                      mbist_mode_buf__out;
  `ifdef IFNDEF_NO_DDR
  cache_mem_if_ar_t         mem_noc_ddr_cdc_u__cdc2ddr_req_if_ar;
  wire                      mem_noc_ddr_cdc_u__cdc2ddr_req_if_arready;
  wire                      mem_noc_ddr_cdc_u__cdc2ddr_req_if_arvalid;
  cache_mem_if_aw_t         mem_noc_ddr_cdc_u__cdc2ddr_req_if_aw;
  wire                      mem_noc_ddr_cdc_u__cdc2ddr_req_if_awready;
  wire                      mem_noc_ddr_cdc_u__cdc2ddr_req_if_awvalid;
  cache_mem_if_w_t          mem_noc_ddr_cdc_u__cdc2ddr_req_if_w;
  wire                      mem_noc_ddr_cdc_u__cdc2ddr_req_if_wready;
  wire                      mem_noc_ddr_cdc_u__cdc2ddr_req_if_wvalid;
  cache_mem_if_b_t          mem_noc_ddr_cdc_u__cdc2noc_resp_if_b;
  wire                      mem_noc_ddr_cdc_u__cdc2noc_resp_if_bready;
  wire                      mem_noc_ddr_cdc_u__cdc2noc_resp_if_bvalid;
  cache_mem_if_r_t          mem_noc_ddr_cdc_u__cdc2noc_resp_if_r;
  wire                      mem_noc_ddr_cdc_u__cdc2noc_resp_if_rready;
  wire                      mem_noc_ddr_cdc_u__cdc2noc_resp_if_rvalid;
  wire                      mem_noc_ddr_cdc_u__clk_m;
  wire                      mem_noc_ddr_cdc_u__clk_s;
  cache_mem_if_b_t          mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_b;
  wire                      mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bready;
  wire                      mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bvalid;
  cache_mem_if_r_t          mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_r;
  wire                      mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rready;
  wire                      mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rvalid;
  cache_mem_if_ar_t         mem_noc_ddr_cdc_u__noc2cdc_req_if_ar;
  wire                      mem_noc_ddr_cdc_u__noc2cdc_req_if_arready;
  wire                      mem_noc_ddr_cdc_u__noc2cdc_req_if_arvalid;
  cache_mem_if_aw_t         mem_noc_ddr_cdc_u__noc2cdc_req_if_aw;
  wire                      mem_noc_ddr_cdc_u__noc2cdc_req_if_awready;
  wire                      mem_noc_ddr_cdc_u__noc2cdc_req_if_awvalid;
  cache_mem_if_w_t          mem_noc_ddr_cdc_u__noc2cdc_req_if_w;
  wire                      mem_noc_ddr_cdc_u__noc2cdc_req_if_wready;
  wire                      mem_noc_ddr_cdc_u__noc2cdc_req_if_wvalid;
  wire                      mem_noc_ddr_cdc_u__rstn_m;
  wire                      mem_noc_ddr_cdc_u__rstn_s;
  `endif
  wire                      mem_noc_rstn_sync_u__clk;
  wire                      mem_noc_rstn_sync_u__rstn_in;
  wire                      mem_noc_rstn_sync_u__rstn_out;
  wire                      mem_noc_rstn_sync_u__scan_en;
  wire                      mem_noc_rstn_sync_u__scan_rstn;
  wire                      mem_noc_u__clk;
  cache_mem_if_ar_t[4:0]    mem_noc_u__l2_req_if_ar;
  wire[4:0]                 mem_noc_u__l2_req_if_arready;
  wire[4:0]                 mem_noc_u__l2_req_if_arvalid;
  cache_mem_if_aw_t[4:0]    mem_noc_u__l2_req_if_aw;
  wire[4:0]                 mem_noc_u__l2_req_if_awready;
  wire[4:0]                 mem_noc_u__l2_req_if_awvalid;
  cache_mem_if_w_t[4:0]     mem_noc_u__l2_req_if_w;
  wire[4:0]                 mem_noc_u__l2_req_if_wready;
  wire[4:0]                 mem_noc_u__l2_req_if_wvalid;
  cache_mem_if_b_t[4:0]     mem_noc_u__l2_resp_if_b;
  wire[4:0]                 mem_noc_u__l2_resp_if_bready;
  wire[4:0]                 mem_noc_u__l2_resp_if_bvalid;
  cache_mem_if_r_t[4:0]     mem_noc_u__l2_resp_if_r;
  wire[4:0]                 mem_noc_u__l2_resp_if_rready;
  wire[4:0]                 mem_noc_u__l2_resp_if_rvalid;
  cache_mem_if_ar_t[0:0]    mem_noc_u__mem_req_if_ar;
  wire[0:0]                 mem_noc_u__mem_req_if_arready;
  wire[0:0]                 mem_noc_u__mem_req_if_arvalid;
  cache_mem_if_aw_t[0:0]    mem_noc_u__mem_req_if_aw;
  wire[0:0]                 mem_noc_u__mem_req_if_awready;
  wire[0:0]                 mem_noc_u__mem_req_if_awvalid;
  cache_mem_if_w_t[0:0]     mem_noc_u__mem_req_if_w;
  wire[0:0]                 mem_noc_u__mem_req_if_wready;
  wire[0:0]                 mem_noc_u__mem_req_if_wvalid;
  cache_mem_if_b_t[0:0]     mem_noc_u__mem_resp_if_b;
  wire[0:0]                 mem_noc_u__mem_resp_if_bready;
  wire[0:0]                 mem_noc_u__mem_resp_if_bvalid;
  cache_mem_if_r_t[0:0]     mem_noc_u__mem_resp_if_r;
  wire[0:0]                 mem_noc_u__mem_resp_if_rready;
  wire[0:0]                 mem_noc_u__mem_resp_if_rvalid;
  wire                      mem_noc_u__rstn;
  
  
  
  
  oursring_req_if_ar_t      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_ar;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_arready;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_arvalid;
  oursring_req_if_aw_t      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_aw;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_awready;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_awvalid;
  oursring_req_if_w_t       oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_w;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_wready;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_wvalid;
  oursring_resp_if_b_t      oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_b;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_bready;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_bvalid;
  oursring_resp_if_r_t      oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_r;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_rready;
  wire                      oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_rvalid;
  wire                      oursring_cdc_byp2ddr_u__master_clk;
  wire                      oursring_cdc_byp2ddr_u__master_resetn;
  oursring_resp_if_b_t      oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_b;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_bready;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_bvalid;
  oursring_resp_if_r_t      oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_r;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_rready;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_rvalid;
  oursring_req_if_ar_t      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_ar;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_arready;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_arvalid;
  oursring_req_if_aw_t      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_aw;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_awready;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_awvalid;
  oursring_req_if_w_t       oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_w;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_wready;
  wire                      oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_wvalid;
  wire                      oursring_cdc_byp2ddr_u__slave_clk;
  wire                      oursring_cdc_byp2ddr_u__slave_resetn;
  oursring_req_if_ar_t      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_ar;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_arready;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_arvalid;
  oursring_req_if_aw_t      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_aw;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_awready;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_awvalid;
  oursring_req_if_w_t       oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_w;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_wready;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_wvalid;
  oursring_resp_if_b_t      oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_b;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_bready;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_bvalid;
  oursring_resp_if_r_t      oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_r;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_rready;
  wire                      oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_rvalid;
  wire                      oursring_cdc_ddr2io_u__master_clk;
  wire                      oursring_cdc_ddr2io_u__master_resetn;
  oursring_resp_if_b_t      oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_b;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_bready;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_bvalid;
  oursring_resp_if_r_t      oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_r;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_rready;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_rvalid;
  oursring_req_if_ar_t      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_ar;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_arready;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_arvalid;
  oursring_req_if_aw_t      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_aw;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_awready;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_awvalid;
  oursring_req_if_w_t       oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_w;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_wready;
  wire                      oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_wvalid;
  wire                      oursring_cdc_ddr2io_u__slave_clk;
  wire                      oursring_cdc_ddr2io_u__slave_resetn;
  oursring_req_if_ar_t      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_ar;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_arready;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_arvalid;
  oursring_req_if_aw_t      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_aw;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_awready;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_awvalid;
  oursring_req_if_w_t       oursring_cdc_io2byp_u__cdc_oursring_master_req_if_w;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_wready;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_master_req_if_wvalid;
  oursring_resp_if_b_t      oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_b;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_bready;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_bvalid;
  oursring_resp_if_r_t      oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_r;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_rready;
  wire                      oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_rvalid;
  wire                      oursring_cdc_io2byp_u__master_clk;
  wire                      oursring_cdc_io2byp_u__master_resetn;
  oursring_resp_if_b_t      oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_b;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_bready;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_bvalid;
  oursring_resp_if_r_t      oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_r;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_rready;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_rvalid;
  oursring_req_if_ar_t      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_ar;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_arready;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_arvalid;
  oursring_req_if_aw_t      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_aw;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_awready;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_awvalid;
  oursring_req_if_w_t       oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_w;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_wready;
  wire                      oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_wvalid;
  wire                      oursring_cdc_io2byp_u__slave_clk;
  wire                      oursring_cdc_io2byp_u__slave_resetn;
  `ifdef IFNDEF_NO_DDR
  wire[31:0]                oursring_ddr_cdc_u__apb_cdc_prdata;
  wire                      oursring_ddr_cdc_u__apb_cdc_pready;
  wire                      oursring_ddr_cdc_u__apb_cdc_pslverr;
  wire                      oursring_ddr_cdc_u__apb_clk;
  wire                      oursring_ddr_cdc_u__apb_resetn;
  wire                      oursring_ddr_cdc_u__axi_clk;
  wire                      oursring_ddr_cdc_u__axi_resetn;
  wire[31:0]                oursring_ddr_cdc_u__cdc_apb_paddr;
  wire                      oursring_ddr_cdc_u__cdc_apb_penable;
  wire                      oursring_ddr_cdc_u__cdc_apb_psel_s0;
  wire[31:0]                oursring_ddr_cdc_u__cdc_apb_pwdata;
  wire                      oursring_ddr_cdc_u__cdc_apb_pwrite;
  oursring_resp_if_b_t      oursring_ddr_cdc_u__cdc_oursring_rsp_if_b;
  wire                      oursring_ddr_cdc_u__cdc_oursring_rsp_if_bready;
  wire                      oursring_ddr_cdc_u__cdc_oursring_rsp_if_bvalid;
  oursring_resp_if_r_t      oursring_ddr_cdc_u__cdc_oursring_rsp_if_r;
  wire                      oursring_ddr_cdc_u__cdc_oursring_rsp_if_rready;
  wire                      oursring_ddr_cdc_u__cdc_oursring_rsp_if_rvalid;
  oursring_req_if_ar_t      oursring_ddr_cdc_u__oursring_cdc_req_if_ar;
  wire                      oursring_ddr_cdc_u__oursring_cdc_req_if_arready;
  wire                      oursring_ddr_cdc_u__oursring_cdc_req_if_arvalid;
  oursring_req_if_aw_t      oursring_ddr_cdc_u__oursring_cdc_req_if_aw;
  wire                      oursring_ddr_cdc_u__oursring_cdc_req_if_awready;
  wire                      oursring_ddr_cdc_u__oursring_cdc_req_if_awvalid;
  oursring_req_if_w_t       oursring_ddr_cdc_u__oursring_cdc_req_if_w;
  wire                      oursring_ddr_cdc_u__oursring_cdc_req_if_wready;
  wire                      oursring_ddr_cdc_u__oursring_cdc_req_if_wvalid;
  `endif
  plic_intr_src_t[4:0]      plic_u__b2s_intr_src;
  wire                      plic_u__clk;
  wire[4:0]                 plic_u__external_int;
  wire[34:0]                plic_u__irq_in;
  plic_dbg_en_t[34:0]       plic_u__s2b_dbg_en;
  plic_intr_core_id_t[34:0] plic_u__s2b_intr_core_id;
  plic_intr_en_t[34:0]      plic_u__s2b_intr_en;
  wire                      pll_rstn_sync_u__clk;
  wire                      pll_rstn_sync_u__rstn_in;
  wire                      pll_rstn_sync_u__rstn_out;
  wire                      pll_rstn_sync_u__scan_en;
  wire                      pll_rstn_sync_u__scan_rstn;
  wire                      pll_station_u__clk;
  oursring_req_if_ar_t      pll_station_u__i_req_local_if_ar;
  wire                      pll_station_u__i_req_local_if_arready;
  wire                      pll_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      pll_station_u__i_req_local_if_aw;
  wire                      pll_station_u__i_req_local_if_awready;
  wire                      pll_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       pll_station_u__i_req_local_if_w;
  wire                      pll_station_u__i_req_local_if_wready;
  wire                      pll_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      pll_station_u__i_req_ring_if_ar;
  wire                      pll_station_u__i_req_ring_if_arready;
  wire                      pll_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      pll_station_u__i_req_ring_if_aw;
  wire                      pll_station_u__i_req_ring_if_awready;
  wire                      pll_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       pll_station_u__i_req_ring_if_w;
  wire                      pll_station_u__i_req_ring_if_wready;
  wire                      pll_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      pll_station_u__i_resp_local_if_b;
  wire                      pll_station_u__i_resp_local_if_bready;
  wire                      pll_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      pll_station_u__i_resp_local_if_r;
  wire                      pll_station_u__i_resp_local_if_rready;
  wire                      pll_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      pll_station_u__i_resp_ring_if_b;
  wire                      pll_station_u__i_resp_ring_if_bready;
  wire                      pll_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      pll_station_u__i_resp_ring_if_r;
  wire                      pll_station_u__i_resp_ring_if_rready;
  wire                      pll_station_u__i_resp_ring_if_rvalid;
  timer_t                   pll_station_u__in_mtime;
  oursring_req_if_ar_t      pll_station_u__o_req_local_if_ar;
  wire                      pll_station_u__o_req_local_if_arready;
  wire                      pll_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      pll_station_u__o_req_local_if_aw;
  wire                      pll_station_u__o_req_local_if_awready;
  wire                      pll_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       pll_station_u__o_req_local_if_w;
  wire                      pll_station_u__o_req_local_if_wready;
  wire                      pll_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      pll_station_u__o_req_ring_if_ar;
  wire                      pll_station_u__o_req_ring_if_arready;
  wire                      pll_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      pll_station_u__o_req_ring_if_aw;
  wire                      pll_station_u__o_req_ring_if_awready;
  wire                      pll_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       pll_station_u__o_req_ring_if_w;
  wire                      pll_station_u__o_req_ring_if_wready;
  wire                      pll_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      pll_station_u__o_resp_local_if_b;
  wire                      pll_station_u__o_resp_local_if_bready;
  wire                      pll_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      pll_station_u__o_resp_local_if_r;
  wire                      pll_station_u__o_resp_local_if_rready;
  wire                      pll_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      pll_station_u__o_resp_ring_if_b;
  wire                      pll_station_u__o_resp_ring_if_bready;
  wire                      pll_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      pll_station_u__o_resp_ring_if_r;
  wire                      pll_station_u__o_resp_ring_if_rready;
  wire                      pll_station_u__o_resp_ring_if_rvalid;
  wire                      pll_station_u__out_debug_info_enable;
  timer_t                   pll_station_u__out_mtime;
  timer_t                   pll_station_u__out_mtimecmp_vp_0;
  timer_t                   pll_station_u__out_mtimecmp_vp_1;
  timer_t                   pll_station_u__out_mtimecmp_vp_2;
  timer_t                   pll_station_u__out_mtimecmp_vp_3;
  wire[63:0]                pll_station_u__out_software_int_vp_0_1;
  wire[63:0]                pll_station_u__out_software_int_vp_2_3;
  wire[63:0]                pll_station_u__out_system_cfg;
  wire                      pll_station_u__rstn;
  wire                      pll_station_u__vld_in_mtime;
  wire                      pll_u__clk_anchor_buf__in;
  wire                      pll_u__clk_anchor_buf__out;
  wire                      rob_rstn_sync_u__clk;
  wire                      rob_rstn_sync_u__rstn_in;
  wire                      rob_rstn_sync_u__rstn_out;
  wire                      rob_rstn_sync_u__scan_en;
  wire                      rob_rstn_sync_u__scan_rstn;
  wire                      rob_u__clk;
  wire[3:0]                 rob_u__entry_vld_pbank;
  cpu_cache_if_req_t[1:0]   rob_u__io_rob_req_if_req;
  wire[1:0]                 rob_u__io_rob_req_if_req_ready;
  wire[1:0]                 rob_u__io_rob_req_if_req_valid;
  wire[3:0]                 rob_u__is_oldest_pbank;
  cpu_cache_if_resp_t       rob_u__noc_rob_resp_if_resp;
  wire                      rob_u__noc_rob_resp_if_resp_ready;
  wire                      rob_u__noc_rob_resp_if_resp_valid;
  cpu_cache_if_resp_t[1:0]  rob_u__rob_io_resp_if_resp;
  wire[1:0]                 rob_u__rob_io_resp_if_resp_ready;
  wire[1:0]                 rob_u__rob_io_resp_if_resp_valid;
  cpu_cache_if_req_t        rob_u__rob_noc_req_if_req;
  wire                      rob_u__rob_noc_req_if_req_ready;
  wire                      rob_u__rob_noc_req_if_req_valid;
  wire                      rob_u__rstn;
  wire                      sdio_pllclk_icg_u__clk;
  wire                      sdio_pllclk_icg_u__clkg;
  wire                      sdio_pllclk_icg_u__en;
  wire                      sdio_pllclk_icg_u__rstn;
  wire                      sdio_pllclk_icg_u__tst_en;
  wire                      sdio_rstn_sync_u__clk;
  wire                      sdio_rstn_sync_u__rstn_in;
  wire                      sdio_rstn_sync_u__rstn_out;
  wire                      sdio_rstn_sync_u__scan_en;
  wire                      sdio_rstn_sync_u__scan_rstn;
  wire                      sdio_station_u__clk;
  oursring_req_if_ar_t      sdio_station_u__i_req_local_if_ar;
  wire                      sdio_station_u__i_req_local_if_arready;
  wire                      sdio_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      sdio_station_u__i_req_local_if_aw;
  wire                      sdio_station_u__i_req_local_if_awready;
  wire                      sdio_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       sdio_station_u__i_req_local_if_w;
  wire                      sdio_station_u__i_req_local_if_wready;
  wire                      sdio_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      sdio_station_u__i_req_ring_if_ar;
  wire                      sdio_station_u__i_req_ring_if_arready;
  wire                      sdio_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      sdio_station_u__i_req_ring_if_aw;
  wire                      sdio_station_u__i_req_ring_if_awready;
  wire                      sdio_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       sdio_station_u__i_req_ring_if_w;
  wire                      sdio_station_u__i_req_ring_if_wready;
  wire                      sdio_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      sdio_station_u__i_resp_local_if_b;
  wire                      sdio_station_u__i_resp_local_if_bready;
  wire                      sdio_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      sdio_station_u__i_resp_local_if_r;
  wire                      sdio_station_u__i_resp_local_if_rready;
  wire                      sdio_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      sdio_station_u__i_resp_ring_if_b;
  wire                      sdio_station_u__i_resp_ring_if_bready;
  wire                      sdio_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      sdio_station_u__i_resp_ring_if_r;
  wire                      sdio_station_u__i_resp_ring_if_rready;
  wire                      sdio_station_u__i_resp_ring_if_rvalid;
  wire[9:0]                 sdio_station_u__in_b2s_card_clk_freq_sel;
  wire                      sdio_station_u__in_b2s_card_clk_gen_sel;
  wire                      sdio_station_u__in_b2s_led_control;
  wire[1:0]                 sdio_station_u__in_b2s_sd_datxfer_width;
  wire                      sdio_station_u__in_b2s_sd_vdd1_on;
  wire[2:0]                 sdio_station_u__in_b2s_sd_vdd1_sel;
  wire                      sdio_station_u__in_b2s_sd_vdd2_on;
  wire[2:0]                 sdio_station_u__in_b2s_sd_vdd2_sel;
  oursring_req_if_ar_t      sdio_station_u__o_req_local_if_ar;
  wire                      sdio_station_u__o_req_local_if_arready;
  wire                      sdio_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      sdio_station_u__o_req_local_if_aw;
  wire                      sdio_station_u__o_req_local_if_awready;
  wire                      sdio_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       sdio_station_u__o_req_local_if_w;
  wire                      sdio_station_u__o_req_local_if_wready;
  wire                      sdio_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      sdio_station_u__o_req_ring_if_ar;
  wire                      sdio_station_u__o_req_ring_if_arready;
  wire                      sdio_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      sdio_station_u__o_req_ring_if_aw;
  wire                      sdio_station_u__o_req_ring_if_awready;
  wire                      sdio_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       sdio_station_u__o_req_ring_if_w;
  wire                      sdio_station_u__o_req_ring_if_wready;
  wire                      sdio_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      sdio_station_u__o_resp_local_if_b;
  wire                      sdio_station_u__o_resp_local_if_bready;
  wire                      sdio_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      sdio_station_u__o_resp_local_if_r;
  wire                      sdio_station_u__o_resp_local_if_rready;
  wire                      sdio_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      sdio_station_u__o_resp_ring_if_b;
  wire                      sdio_station_u__o_resp_ring_if_bready;
  wire                      sdio_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      sdio_station_u__o_resp_ring_if_r;
  wire                      sdio_station_u__o_resp_ring_if_rready;
  wire                      sdio_station_u__o_resp_ring_if_rvalid;
  wire[9:0]                 sdio_station_u__out_b2s_card_clk_freq_sel;
  wire                      sdio_station_u__out_b2s_card_clk_gen_sel;
  wire                      sdio_station_u__out_b2s_led_control;
  wire[1:0]                 sdio_station_u__out_b2s_sd_datxfer_width;
  wire                      sdio_station_u__out_b2s_sd_vdd1_on;
  wire[2:0]                 sdio_station_u__out_b2s_sd_vdd1_sel;
  wire                      sdio_station_u__out_b2s_sd_vdd2_on;
  wire[2:0]                 sdio_station_u__out_b2s_sd_vdd2_sel;
  wire                      sdio_station_u__out_debug_info_enable;
  wire                      sdio_station_u__out_s2b_host_reg_vol_stable;
  wire                      sdio_station_u__out_s2b_icg_en;
  wire                      sdio_station_u__out_s2b_int_aclk_stable;
  wire                      sdio_station_u__out_s2b_int_bclk_stable;
  wire                      sdio_station_u__out_s2b_resetn;
  wire                      sdio_station_u__out_s2b_sd;
  wire                      sdio_station_u__out_s2b_slp;
  wire[9:0]                 sdio_station_u__out_s2b_test_io_clkdiv_half_div_less_1;
  wire                      sdio_station_u__out_s2b_test_io_pllclk_en;
  wire                      sdio_station_u__out_s2icg_pllclk_en;
  wire                      sdio_station_u__rstn;
  wire                      sdio_station_u__vld_in_b2s_card_clk_freq_sel;
  wire                      sdio_station_u__vld_in_b2s_card_clk_gen_sel;
  wire                      sdio_station_u__vld_in_b2s_led_control;
  wire                      sdio_station_u__vld_in_b2s_sd_datxfer_width;
  wire                      sdio_station_u__vld_in_b2s_sd_vdd1_on;
  wire                      sdio_station_u__vld_in_b2s_sd_vdd1_sel;
  wire                      sdio_station_u__vld_in_b2s_sd_vdd2_on;
  wire                      sdio_station_u__vld_in_b2s_sd_vdd2_sel;
  
  wire                      slow_io_clk_div_u__dft_en;
  wire                      slow_io_clk_div_u__divclk;
  wire                      slow_io_clk_div_u__divclk_sel;
  wire[3:0]                 slow_io_clk_div_u__half_div_less_1;
  wire                      slow_io_clk_div_u__refclk;
  wire                      slow_io_local_1_to_2_u__clk;
  oursring_req_if_ar_t[0:0] slow_io_local_1_to_2_u__i_or_req_if_ar;
  wire[0:0]                 slow_io_local_1_to_2_u__i_or_req_if_arready;
  wire[0:0]                 slow_io_local_1_to_2_u__i_or_req_if_arvalid;
  oursring_req_if_aw_t[0:0] slow_io_local_1_to_2_u__i_or_req_if_aw;
  wire[0:0]                 slow_io_local_1_to_2_u__i_or_req_if_awready;
  wire[0:0]                 slow_io_local_1_to_2_u__i_or_req_if_awvalid;
  oursring_req_if_w_t[0:0]  slow_io_local_1_to_2_u__i_or_req_if_w;
  wire[0:0]                 slow_io_local_1_to_2_u__i_or_req_if_wready;
  wire[0:0]                 slow_io_local_1_to_2_u__i_or_req_if_wvalid;
  oursring_resp_if_b_t[1:0] slow_io_local_1_to_2_u__i_or_rsp_if_b;
  wire[1:0]                 slow_io_local_1_to_2_u__i_or_rsp_if_bready;
  wire[1:0]                 slow_io_local_1_to_2_u__i_or_rsp_if_bvalid;
  oursring_resp_if_r_t[1:0] slow_io_local_1_to_2_u__i_or_rsp_if_r;
  wire[1:0]                 slow_io_local_1_to_2_u__i_or_rsp_if_rready;
  wire[1:0]                 slow_io_local_1_to_2_u__i_or_rsp_if_rvalid;
  oursring_req_if_ar_t[1:0] slow_io_local_1_to_2_u__o_or_req_if_ar;
  wire[1:0]                 slow_io_local_1_to_2_u__o_or_req_if_arready;
  wire[1:0]                 slow_io_local_1_to_2_u__o_or_req_if_arvalid;
  oursring_req_if_aw_t[1:0] slow_io_local_1_to_2_u__o_or_req_if_aw;
  wire[1:0]                 slow_io_local_1_to_2_u__o_or_req_if_awready;
  wire[1:0]                 slow_io_local_1_to_2_u__o_or_req_if_awvalid;
  oursring_req_if_w_t[1:0]  slow_io_local_1_to_2_u__o_or_req_if_w;
  wire[1:0]                 slow_io_local_1_to_2_u__o_or_req_if_wready;
  wire[1:0]                 slow_io_local_1_to_2_u__o_or_req_if_wvalid;
  oursring_resp_if_b_t[0:0] slow_io_local_1_to_2_u__o_or_rsp_if_b;
  wire[0:0]                 slow_io_local_1_to_2_u__o_or_rsp_if_bready;
  wire[0:0]                 slow_io_local_1_to_2_u__o_or_rsp_if_bvalid;
  oursring_resp_if_r_t[0:0] slow_io_local_1_to_2_u__o_or_rsp_if_r;
  wire[0:0]                 slow_io_local_1_to_2_u__o_or_rsp_if_rready;
  wire[0:0]                 slow_io_local_1_to_2_u__o_or_rsp_if_rvalid;
  wire                      slow_io_local_1_to_2_u__rstn;
  wire                      slow_io_local_2_to_1_u__clk;
  oursring_req_if_ar_t[1:0] slow_io_local_2_to_1_u__i_or_req_if_ar;
  wire[1:0]                 slow_io_local_2_to_1_u__i_or_req_if_arready;
  wire[1:0]                 slow_io_local_2_to_1_u__i_or_req_if_arvalid;
  oursring_req_if_aw_t[1:0] slow_io_local_2_to_1_u__i_or_req_if_aw;
  wire[1:0]                 slow_io_local_2_to_1_u__i_or_req_if_awready;
  wire[1:0]                 slow_io_local_2_to_1_u__i_or_req_if_awvalid;
  oursring_req_if_w_t[1:0]  slow_io_local_2_to_1_u__i_or_req_if_w;
  wire[1:0]                 slow_io_local_2_to_1_u__i_or_req_if_wready;
  wire[1:0]                 slow_io_local_2_to_1_u__i_or_req_if_wvalid;
  oursring_resp_if_b_t[0:0] slow_io_local_2_to_1_u__i_or_rsp_if_b;
  wire[0:0]                 slow_io_local_2_to_1_u__i_or_rsp_if_bready;
  wire[0:0]                 slow_io_local_2_to_1_u__i_or_rsp_if_bvalid;
  oursring_resp_if_r_t[0:0] slow_io_local_2_to_1_u__i_or_rsp_if_r;
  wire[0:0]                 slow_io_local_2_to_1_u__i_or_rsp_if_rready;
  wire[0:0]                 slow_io_local_2_to_1_u__i_or_rsp_if_rvalid;
  oursring_req_if_ar_t[0:0] slow_io_local_2_to_1_u__o_or_req_if_ar;
  wire[0:0]                 slow_io_local_2_to_1_u__o_or_req_if_arready;
  wire[0:0]                 slow_io_local_2_to_1_u__o_or_req_if_arvalid;
  oursring_req_if_aw_t[0:0] slow_io_local_2_to_1_u__o_or_req_if_aw;
  wire[0:0]                 slow_io_local_2_to_1_u__o_or_req_if_awready;
  wire[0:0]                 slow_io_local_2_to_1_u__o_or_req_if_awvalid;
  oursring_req_if_w_t[0:0]  slow_io_local_2_to_1_u__o_or_req_if_w;
  wire[0:0]                 slow_io_local_2_to_1_u__o_or_req_if_wready;
  wire[0:0]                 slow_io_local_2_to_1_u__o_or_req_if_wvalid;
  oursring_resp_if_b_t[1:0] slow_io_local_2_to_1_u__o_or_rsp_if_b;
  wire[1:0]                 slow_io_local_2_to_1_u__o_or_rsp_if_bready;
  wire[1:0]                 slow_io_local_2_to_1_u__o_or_rsp_if_bvalid;
  oursring_resp_if_r_t[1:0] slow_io_local_2_to_1_u__o_or_rsp_if_r;
  wire[1:0]                 slow_io_local_2_to_1_u__o_or_rsp_if_rready;
  wire[1:0]                 slow_io_local_2_to_1_u__o_or_rsp_if_rvalid;
  wire                      slow_io_local_2_to_1_u__rstn;
  wire                      slow_io_rstn_sync_u__clk;
  wire                      slow_io_rstn_sync_u__rstn_in;
  wire                      slow_io_rstn_sync_u__rstn_out;
  wire                      slow_io_rstn_sync_u__scan_en;
  wire                      slow_io_rstn_sync_u__scan_rstn;
  wire                      slow_io_station_u__clk;
  oursring_req_if_ar_t      slow_io_station_u__i_req_local_if_ar;
  wire                      slow_io_station_u__i_req_local_if_arready;
  wire                      slow_io_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      slow_io_station_u__i_req_local_if_aw;
  wire                      slow_io_station_u__i_req_local_if_awready;
  wire                      slow_io_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       slow_io_station_u__i_req_local_if_w;
  wire                      slow_io_station_u__i_req_local_if_wready;
  wire                      slow_io_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      slow_io_station_u__i_req_ring_if_ar;
  wire                      slow_io_station_u__i_req_ring_if_arready;
  wire                      slow_io_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      slow_io_station_u__i_req_ring_if_aw;
  wire                      slow_io_station_u__i_req_ring_if_awready;
  wire                      slow_io_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       slow_io_station_u__i_req_ring_if_w;
  wire                      slow_io_station_u__i_req_ring_if_wready;
  wire                      slow_io_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      slow_io_station_u__i_resp_local_if_b;
  wire                      slow_io_station_u__i_resp_local_if_bready;
  wire                      slow_io_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      slow_io_station_u__i_resp_local_if_r;
  wire                      slow_io_station_u__i_resp_local_if_rready;
  wire                      slow_io_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      slow_io_station_u__i_resp_ring_if_b;
  wire                      slow_io_station_u__i_resp_ring_if_bready;
  wire                      slow_io_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      slow_io_station_u__i_resp_ring_if_r;
  wire                      slow_io_station_u__i_resp_ring_if_rready;
  wire                      slow_io_station_u__i_resp_ring_if_rvalid;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_addr;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_addr_10bit;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_data;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_hs;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_master_act;
  wire[4:0]                 slow_io_station_u__in_b2s_i2c0_debug_mst_cstate;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_p_gen;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_rd;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_s_gen;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_slave_act;
  wire[3:0]                 slow_io_station_u__in_b2s_i2c0_debug_slv_cstate;
  wire                      slow_io_station_u__in_b2s_i2c0_debug_wr;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_addr;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_addr_10bit;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_data;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_hs;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_master_act;
  wire[4:0]                 slow_io_station_u__in_b2s_i2c1_debug_mst_cstate;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_p_gen;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_rd;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_s_gen;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_slave_act;
  wire[3:0]                 slow_io_station_u__in_b2s_i2c1_debug_slv_cstate;
  wire                      slow_io_station_u__in_b2s_i2c1_debug_wr;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_addr;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_addr_10bit;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_data;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_hs;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_master_act;
  wire[4:0]                 slow_io_station_u__in_b2s_i2c2_debug_mst_cstate;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_p_gen;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_rd;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_s_gen;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_slave_act;
  wire[3:0]                 slow_io_station_u__in_b2s_i2c2_debug_slv_cstate;
  wire                      slow_io_station_u__in_b2s_i2c2_debug_wr;
  wire                      slow_io_station_u__in_b2s_qspim_ssi_busy;
  wire                      slow_io_station_u__in_b2s_qspim_ssi_sleep;
  wire                      slow_io_station_u__in_b2s_rtc_en;
  wire                      slow_io_station_u__in_b2s_spis_ssi_sleep;
  wire                      slow_io_station_u__in_b2s_sspim0_ssi_sleep;
  wire                      slow_io_station_u__in_b2s_sspim1_ssi_sleep;
  wire                      slow_io_station_u__in_b2s_sspim2_ssi_sleep;
  wire[7:0]                 slow_io_station_u__in_b2s_timer_en;
  oursring_req_if_ar_t      slow_io_station_u__o_req_local_if_ar;
  wire                      slow_io_station_u__o_req_local_if_arready;
  wire                      slow_io_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      slow_io_station_u__o_req_local_if_aw;
  wire                      slow_io_station_u__o_req_local_if_awready;
  wire                      slow_io_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       slow_io_station_u__o_req_local_if_w;
  wire                      slow_io_station_u__o_req_local_if_wready;
  wire                      slow_io_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      slow_io_station_u__o_req_ring_if_ar;
  wire                      slow_io_station_u__o_req_ring_if_arready;
  wire                      slow_io_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      slow_io_station_u__o_req_ring_if_aw;
  wire                      slow_io_station_u__o_req_ring_if_awready;
  wire                      slow_io_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       slow_io_station_u__o_req_ring_if_w;
  wire                      slow_io_station_u__o_req_ring_if_wready;
  wire                      slow_io_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      slow_io_station_u__o_resp_local_if_b;
  wire                      slow_io_station_u__o_resp_local_if_bready;
  wire                      slow_io_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      slow_io_station_u__o_resp_local_if_r;
  wire                      slow_io_station_u__o_resp_local_if_rready;
  wire                      slow_io_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      slow_io_station_u__o_resp_ring_if_b;
  wire                      slow_io_station_u__o_resp_ring_if_bready;
  wire                      slow_io_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      slow_io_station_u__o_resp_ring_if_r;
  wire                      slow_io_station_u__o_resp_ring_if_rready;
  wire                      slow_io_station_u__o_resp_ring_if_rvalid;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_0;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_1;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_10;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_11;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_12;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_13;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_14;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_15;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_16;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_17;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_18;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_19;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_2;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_20;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_21;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_22;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_23;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_24;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_25;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_26;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_27;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_28;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_29;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_3;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_30;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_31;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_32;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_33;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_34;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_35;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_36;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_37;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_38;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_39;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_4;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_40;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_41;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_42;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_43;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_44;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_45;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_46;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_47;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_5;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_6;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_7;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_8;
  wire[1:0]                 slow_io_station_u__out_SSP_SHARED_sel_9;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_addr;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_addr_10bit;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_data;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_hs;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_master_act;
  wire[4:0]                 slow_io_station_u__out_b2s_i2c0_debug_mst_cstate;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_p_gen;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_rd;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_s_gen;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_slave_act;
  wire[3:0]                 slow_io_station_u__out_b2s_i2c0_debug_slv_cstate;
  wire                      slow_io_station_u__out_b2s_i2c0_debug_wr;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_addr;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_addr_10bit;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_data;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_hs;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_master_act;
  wire[4:0]                 slow_io_station_u__out_b2s_i2c1_debug_mst_cstate;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_p_gen;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_rd;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_s_gen;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_slave_act;
  wire[3:0]                 slow_io_station_u__out_b2s_i2c1_debug_slv_cstate;
  wire                      slow_io_station_u__out_b2s_i2c1_debug_wr;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_addr;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_addr_10bit;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_data;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_hs;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_master_act;
  wire[4:0]                 slow_io_station_u__out_b2s_i2c2_debug_mst_cstate;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_p_gen;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_rd;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_s_gen;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_slave_act;
  wire[3:0]                 slow_io_station_u__out_b2s_i2c2_debug_slv_cstate;
  wire                      slow_io_station_u__out_b2s_i2c2_debug_wr;
  wire                      slow_io_station_u__out_b2s_qspim_ssi_busy;
  wire                      slow_io_station_u__out_b2s_qspim_ssi_sleep;
  wire                      slow_io_station_u__out_b2s_rtc_en;
  wire                      slow_io_station_u__out_b2s_spis_ssi_sleep;
  wire                      slow_io_station_u__out_b2s_sspim0_ssi_sleep;
  wire                      slow_io_station_u__out_b2s_sspim1_ssi_sleep;
  wire                      slow_io_station_u__out_b2s_sspim2_ssi_sleep;
  wire[7:0]                 slow_io_station_u__out_b2s_timer_en;
  wire                      slow_io_station_u__out_debug_info_enable;
  wire                      slow_io_station_u__out_s2b_boot_from_flash_ena;
  wire                      slow_io_station_u__out_s2b_boot_from_flash_ena_sw_ctrl;
  wire                      slow_io_station_u__out_s2b_bootup_ena;
  wire                      slow_io_station_u__out_s2b_bootup_ena_sw_ctrl;
  wire                      slow_io_station_u__out_s2b_gpio_clk_en;
  wire                      slow_io_station_u__out_s2b_i2c0_clk_en;
  wire                      slow_io_station_u__out_s2b_i2c1_clk_en;
  wire                      slow_io_station_u__out_s2b_i2c2_clk_en;
  wire                      slow_io_station_u__out_s2b_i2sm_clkdiv_divclk_sel;
  wire[15:0]                slow_io_station_u__out_s2b_i2sm_clkdiv_half_div_less_1;
  wire                      slow_io_station_u__out_s2b_i2ss0_clkdiv_divclk_sel;
  wire[15:0]                slow_io_station_u__out_s2b_i2ss0_clkdiv_half_div_less_1;
  wire                      slow_io_station_u__out_s2b_i2ss1_clkdiv_divclk_sel;
  wire[15:0]                slow_io_station_u__out_s2b_i2ss1_clkdiv_half_div_less_1;
  wire                      slow_io_station_u__out_s2b_i2ss2_clkdiv_divclk_sel;
  wire[15:0]                slow_io_station_u__out_s2b_i2ss2_clkdiv_half_div_less_1;
  wire                      slow_io_station_u__out_s2b_i2ss3_clkdiv_divclk_sel;
  wire[15:0]                slow_io_station_u__out_s2b_i2ss3_clkdiv_half_div_less_1;
  wire                      slow_io_station_u__out_s2b_i2ss4_clkdiv_divclk_sel;
  wire[15:0]                slow_io_station_u__out_s2b_i2ss4_clkdiv_half_div_less_1;
  wire                      slow_io_station_u__out_s2b_i2ss5_clkdiv_divclk_sel;
  wire[15:0]                slow_io_station_u__out_s2b_i2ss5_clkdiv_half_div_less_1;
  wire                      slow_io_station_u__out_s2b_qspim_ssi_clk_en;
  wire                      slow_io_station_u__out_s2b_rtc_clk_en;
  wire                      slow_io_station_u__out_s2b_sspim0_ssi_clk_en;
  wire                      slow_io_station_u__out_s2b_sspim1_ssi_clk_en;
  wire                      slow_io_station_u__out_s2b_sspim2_ssi_clk_en;
  wire                      slow_io_station_u__out_s2b_timers_1_resetn;
  wire                      slow_io_station_u__out_s2b_timers_2_resetn;
  wire                      slow_io_station_u__out_s2b_timers_3_resetn;
  wire                      slow_io_station_u__out_s2b_timers_4_resetn;
  wire                      slow_io_station_u__out_s2b_timers_5_resetn;
  wire                      slow_io_station_u__out_s2b_timers_6_resetn;
  wire                      slow_io_station_u__out_s2b_timers_7_resetn;
  wire                      slow_io_station_u__out_s2b_timers_8_resetn;
  wire                      slow_io_station_u__out_s2b_wdt_clk_en;
  wire                      slow_io_station_u__out_s2b_wdt_pause;
  wire                      slow_io_station_u__out_s2b_wdt_speed_up;
  wire                      slow_io_station_u__out_s2icg_gpio_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2c0_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2c1_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2c2_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2sm_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2ss0_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2ss1_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2ss2_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2ss3_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2ss4_pclk_en;
  wire                      slow_io_station_u__out_s2icg_i2ss5_pclk_en;
  wire                      slow_io_station_u__out_s2icg_qspim_pclk_en;
  wire                      slow_io_station_u__out_s2icg_rtc_pclk_en;
  wire                      slow_io_station_u__out_s2icg_spis_pclk_en;
  wire                      slow_io_station_u__out_s2icg_sspim0_pclk_en;
  wire                      slow_io_station_u__out_s2icg_sspim1_pclk_en;
  wire                      slow_io_station_u__out_s2icg_sspim2_pclk_en;
  wire                      slow_io_station_u__out_s2icg_timers_pclk_en;
  wire                      slow_io_station_u__out_s2icg_uart0_pclk_en;
  wire                      slow_io_station_u__out_s2icg_uart1_pclk_en;
  wire                      slow_io_station_u__out_s2icg_uart2_pclk_en;
  wire                      slow_io_station_u__out_s2icg_uart3_pclk_en;
  wire                      slow_io_station_u__out_s2icg_wdt_pclk_en;
  wire                      slow_io_station_u__rstn;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_addr;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_addr_10bit;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_data;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_hs;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_master_act;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_mst_cstate;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_p_gen;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_rd;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_s_gen;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_slave_act;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_slv_cstate;
  wire                      slow_io_station_u__vld_in_b2s_i2c0_debug_wr;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_addr;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_addr_10bit;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_data;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_hs;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_master_act;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_mst_cstate;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_p_gen;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_rd;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_s_gen;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_slave_act;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_slv_cstate;
  wire                      slow_io_station_u__vld_in_b2s_i2c1_debug_wr;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_addr;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_addr_10bit;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_data;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_hs;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_master_act;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_mst_cstate;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_p_gen;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_rd;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_s_gen;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_slave_act;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_slv_cstate;
  wire                      slow_io_station_u__vld_in_b2s_i2c2_debug_wr;
  wire                      slow_io_station_u__vld_in_b2s_qspim_ssi_busy;
  wire                      slow_io_station_u__vld_in_b2s_qspim_ssi_sleep;
  wire                      slow_io_station_u__vld_in_b2s_rtc_en;
  wire                      slow_io_station_u__vld_in_b2s_spis_ssi_sleep;
  wire                      slow_io_station_u__vld_in_b2s_sspim0_ssi_sleep;
  wire                      slow_io_station_u__vld_in_b2s_sspim1_ssi_sleep;
  wire                      slow_io_station_u__vld_in_b2s_sspim2_ssi_sleep;
  wire                      slow_io_station_u__vld_in_b2s_timer_en;
  wire                      soc_top__chip_resetn;
  wire                      soc_top__dft_mode;
  wire                      soc_top__dft_mode_vp;
  
  wire                      test_io_pllclk_icg_u__clk;
  wire                      test_io_pllclk_icg_u__clkg;
  wire                      test_io_pllclk_icg_u__en;
  wire                      test_io_pllclk_icg_u__tst_en;
  wire                      test_io_rstn_sync_u__clk;
  wire                      test_io_rstn_sync_u__rstn_in;
  wire                      test_io_rstn_sync_u__rstn_out;
  wire                      test_io_rstn_sync_u__scan_en;
  wire                      test_io_rstn_sync_u__scan_rstn;
  wire                      test_io_test_rstn_sync_u__clk;
  wire                      test_io_test_rstn_sync_u__rstn_in;
  wire                      test_io_test_rstn_sync_u__rstn_out;
  wire                      test_io_test_rstn_sync_u__scan_en;
  wire                      test_io_test_rstn_sync_u__scan_rstn;
  wire                      test_io_u__clk_div;
  wire[9:0]                 test_io_u__clk_div_half;
  wire                      test_io_u__clk_oen;
  oursring_req_if_ar_t      test_io_u__or_req_if_ar;
  wire                      test_io_u__or_req_if_arready;
  wire                      test_io_u__or_req_if_arvalid;
  oursring_req_if_aw_t      test_io_u__or_req_if_aw;
  wire                      test_io_u__or_req_if_awready;
  wire                      test_io_u__or_req_if_awvalid;
  oursring_req_if_w_t       test_io_u__or_req_if_w;
  wire                      test_io_u__or_req_if_wready;
  wire                      test_io_u__or_req_if_wvalid;
  oursring_resp_if_b_t      test_io_u__or_rsp_if_b;
  wire                      test_io_u__or_rsp_if_bready;
  wire                      test_io_u__or_rsp_if_bvalid;
  oursring_resp_if_r_t      test_io_u__or_rsp_if_r;
  wire                      test_io_u__or_rsp_if_rready;
  wire                      test_io_u__or_rsp_if_rvalid;
  wire                      test_io_u__pllclk;
  wire                      test_io_u__rstn;
  wire                      test_io_u__test_clk;
  wire                      test_io_u__test_din;
  wire                      test_io_u__test_doen;
  wire                      test_io_u__test_dout;
  wire                      test_io_u__test_ein;
  wire                      test_io_u__test_eoen;
  wire                      test_io_u__test_eout;
  wire                      test_io_u__test_rstn;
  timer_t                   timer_interrupt_u__mtime_in;
  timer_t                   timer_interrupt_u__mtime_out;
  timer_t[3:0]              timer_interrupt_u__mtimecmp;
  wire[3:0]                 timer_interrupt_u__timer_int;
  wire                      usb_pllclk_icg_u__clk;
  wire                      usb_pllclk_icg_u__clkg;
  wire                      usb_pllclk_icg_u__en;
  wire                      usb_pllclk_icg_u__tst_en;
  wire                      usb_refclk_icg_u__clk;
  wire                      usb_refclk_icg_u__clkg;
  wire                      usb_refclk_icg_u__en;
  wire                      usb_refclk_icg_u__tst_en;
  wire                      usb_rstn_sync_u__clk;
  wire                      usb_rstn_sync_u__rstn_in;
  wire                      usb_rstn_sync_u__rstn_out;
  wire                      usb_rstn_sync_u__scan_en;
  wire                      usb_rstn_sync_u__scan_rstn;
  wire                      usb_station_u__clk;
  oursring_req_if_ar_t      usb_station_u__i_req_local_if_ar;
  wire                      usb_station_u__i_req_local_if_arready;
  wire                      usb_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      usb_station_u__i_req_local_if_aw;
  wire                      usb_station_u__i_req_local_if_awready;
  wire                      usb_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       usb_station_u__i_req_local_if_w;
  wire                      usb_station_u__i_req_local_if_wready;
  wire                      usb_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      usb_station_u__i_req_ring_if_ar;
  wire                      usb_station_u__i_req_ring_if_arready;
  wire                      usb_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      usb_station_u__i_req_ring_if_aw;
  wire                      usb_station_u__i_req_ring_if_awready;
  wire                      usb_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       usb_station_u__i_req_ring_if_w;
  wire                      usb_station_u__i_req_ring_if_wready;
  wire                      usb_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      usb_station_u__i_resp_local_if_b;
  wire                      usb_station_u__i_resp_local_if_bready;
  wire                      usb_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      usb_station_u__i_resp_local_if_r;
  wire                      usb_station_u__i_resp_local_if_rready;
  wire                      usb_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      usb_station_u__i_resp_ring_if_b;
  wire                      usb_station_u__i_resp_ring_if_bready;
  wire                      usb_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      usb_station_u__i_resp_ring_if_r;
  wire                      usb_station_u__i_resp_ring_if_rready;
  wire                      usb_station_u__i_resp_ring_if_rvalid;
  wire[2:0]                 usb_station_u__in_b2s_clk_gate_ctrl;
  wire                      usb_station_u__in_b2s_connect_state_u2pmu;
  wire                      usb_station_u__in_b2s_connect_state_u3pmu;
  wire                      usb_station_u__in_b2s_cr_ack;
  wire[15:0]                usb_station_u__in_b2s_cr_data_out;
  wire[1:0]                 usb_station_u__in_b2s_current_power_state_u2pmu;
  wire[1:0]                 usb_station_u__in_b2s_current_power_state_u3pmu;
  wire[61:0]                usb_station_u__in_b2s_debug;
  wire[3:0]                 usb_station_u__in_b2s_debug_u2pmu_hi;
  wire[63:0]                usb_station_u__in_b2s_debug_u2pmu_lo;
  wire[38:0]                usb_station_u__in_b2s_debug_u3pmu;
  wire[15:0]                usb_station_u__in_b2s_gp_out;
  wire                      usb_station_u__in_b2s_mpll_refssc_clk;
  wire                      usb_station_u__in_b2s_pme_generation_u2pmu;
  wire                      usb_station_u__in_b2s_pme_generation_u3pmu;
  wire                      usb_station_u__in_b2s_rtune_ack;
  oursring_req_if_ar_t      usb_station_u__o_req_local_if_ar;
  wire                      usb_station_u__o_req_local_if_arready;
  wire                      usb_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      usb_station_u__o_req_local_if_aw;
  wire                      usb_station_u__o_req_local_if_awready;
  wire                      usb_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       usb_station_u__o_req_local_if_w;
  wire                      usb_station_u__o_req_local_if_wready;
  wire                      usb_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      usb_station_u__o_req_ring_if_ar;
  wire                      usb_station_u__o_req_ring_if_arready;
  wire                      usb_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      usb_station_u__o_req_ring_if_aw;
  wire                      usb_station_u__o_req_ring_if_awready;
  wire                      usb_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       usb_station_u__o_req_ring_if_w;
  wire                      usb_station_u__o_req_ring_if_wready;
  wire                      usb_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      usb_station_u__o_resp_local_if_b;
  wire                      usb_station_u__o_resp_local_if_bready;
  wire                      usb_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      usb_station_u__o_resp_local_if_r;
  wire                      usb_station_u__o_resp_local_if_rready;
  wire                      usb_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      usb_station_u__o_resp_ring_if_b;
  wire                      usb_station_u__o_resp_ring_if_bready;
  wire                      usb_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      usb_station_u__o_resp_ring_if_r;
  wire                      usb_station_u__o_resp_ring_if_rready;
  wire                      usb_station_u__o_resp_ring_if_rvalid;
  wire[2:0]                 usb_station_u__out_b2s_clk_gate_ctrl;
  wire                      usb_station_u__out_b2s_connect_state_u2pmu;
  wire                      usb_station_u__out_b2s_connect_state_u3pmu;
  wire                      usb_station_u__out_b2s_cr_ack;
  wire[15:0]                usb_station_u__out_b2s_cr_data_out;
  wire[1:0]                 usb_station_u__out_b2s_current_power_state_u2pmu;
  wire[1:0]                 usb_station_u__out_b2s_current_power_state_u3pmu;
  wire[61:0]                usb_station_u__out_b2s_debug;
  wire[3:0]                 usb_station_u__out_b2s_debug_u2pmu_hi;
  wire[63:0]                usb_station_u__out_b2s_debug_u2pmu_lo;
  wire[38:0]                usb_station_u__out_b2s_debug_u3pmu;
  wire[15:0]                usb_station_u__out_b2s_gp_out;
  wire                      usb_station_u__out_b2s_mpll_refssc_clk;
  wire                      usb_station_u__out_b2s_pme_generation_u2pmu;
  wire                      usb_station_u__out_b2s_pme_generation_u3pmu;
  wire                      usb_station_u__out_b2s_rtune_ack;
  wire                      usb_station_u__out_debug_info_enable;
  wire                      usb_station_u__out_s2b_ATERESET;
  wire[2:0]                 usb_station_u__out_s2b_COMPDISTUNE0;
  wire                      usb_station_u__out_s2b_LOOPBACKENB0;
  wire[2:0]                 usb_station_u__out_s2b_OTGTUNE0;
  wire[2:0]                 usb_station_u__out_s2b_SQRXTUNE0;
  wire[3:0]                 usb_station_u__out_s2b_TXFSLSTUNE0;
  wire[1:0]                 usb_station_u__out_s2b_TXHSXVTUNE0;
  wire[1:0]                 usb_station_u__out_s2b_TXPREEMPAMPTUNE0;
  wire                      usb_station_u__out_s2b_TXPREEMPPULSETUNE0;
  wire[1:0]                 usb_station_u__out_s2b_TXRESTUNE0;
  wire[1:0]                 usb_station_u__out_s2b_TXRISETUNE0;
  wire[3:0]                 usb_station_u__out_s2b_TXVREFTUNE0;
  wire                      usb_station_u__out_s2b_VATESTENB;
  wire[1:0]                 usb_station_u__out_s2b_VDATREFTUNE0;
  wire                      usb_station_u__out_s2b_cr_cap_addr;
  wire                      usb_station_u__out_s2b_cr_cap_data;
  wire[15:0]                usb_station_u__out_s2b_cr_data_in;
  wire                      usb_station_u__out_s2b_cr_read;
  wire                      usb_station_u__out_s2b_cr_write;
  wire[5:0]                 usb_station_u__out_s2b_fsel;
  wire[15:0]                usb_station_u__out_s2b_gp_in;
  wire                      usb_station_u__out_s2b_lane0_ext_pclk_req;
  wire                      usb_station_u__out_s2b_lane0_tx2rx_loopbk;
  wire[4:0]                 usb_station_u__out_s2b_lane0_tx_term_offset;
  wire[2:0]                 usb_station_u__out_s2b_los_bias;
  wire[4:0]                 usb_station_u__out_s2b_los_level;
  wire[6:0]                 usb_station_u__out_s2b_mpll_multiplier;
  wire[9:0]                 usb_station_u__out_s2b_pcs_rx_los_mask_val;
  wire[5:0]                 usb_station_u__out_s2b_pcs_tx_deemph_3p5db;
  wire[5:0]                 usb_station_u__out_s2b_pcs_tx_deemph_6db;
  wire[6:0]                 usb_station_u__out_s2b_pcs_tx_swing_full;
  wire[29:0]                usb_station_u__out_s2b_pm_pmu_config_strap;
  wire[1:0]                 usb_station_u__out_s2b_pm_power_state_request;
  wire                      usb_station_u__out_s2b_power_switch_control;
  wire                      usb_station_u__out_s2b_ram0_sd;
  wire                      usb_station_u__out_s2b_ram0_slp;
  wire                      usb_station_u__out_s2b_ram1_sd;
  wire                      usb_station_u__out_s2b_ram1_slp;
  wire                      usb_station_u__out_s2b_ram2_sd;
  wire                      usb_station_u__out_s2b_ram2_slp;
  wire                      usb_station_u__out_s2b_ref_clkdiv2;
  wire                      usb_station_u__out_s2b_ref_ssp_en;
  wire                      usb_station_u__out_s2b_ref_use_pad;
  wire                      usb_station_u__out_s2b_rtune_req;
  wire[2:0]                 usb_station_u__out_s2b_ssc_range;
  wire[8:0]                 usb_station_u__out_s2b_ssc_ref_clk_sel;
  wire                      usb_station_u__out_s2b_test_powerdown_hsp;
  wire                      usb_station_u__out_s2b_test_powerdown_ssp;
  wire[2:0]                 usb_station_u__out_s2b_tx_vboost_lvl;
  wire                      usb_station_u__out_s2b_vaux_reset_n;
  wire                      usb_station_u__out_s2b_vcc_reset_n;
  wire                      usb_station_u__out_s2dft_mbist_done;
  wire[63:0]                usb_station_u__out_s2dft_mbist_error_log_hi;
  wire[63:0]                usb_station_u__out_s2dft_mbist_error_log_lo;
  wire                      usb_station_u__out_s2dft_mbist_func_en;
  wire                      usb_station_u__out_s2icg_pllclk_en;
  wire                      usb_station_u__out_s2icg_refclk_en;
  wire                      usb_station_u__rstn;
  wire                      usb_station_u__vld_in_b2s_clk_gate_ctrl;
  wire                      usb_station_u__vld_in_b2s_connect_state_u2pmu;
  wire                      usb_station_u__vld_in_b2s_connect_state_u3pmu;
  wire                      usb_station_u__vld_in_b2s_cr_ack;
  wire                      usb_station_u__vld_in_b2s_cr_data_out;
  wire                      usb_station_u__vld_in_b2s_current_power_state_u2pmu;
  wire                      usb_station_u__vld_in_b2s_current_power_state_u3pmu;
  wire                      usb_station_u__vld_in_b2s_debug;
  wire                      usb_station_u__vld_in_b2s_debug_u2pmu_hi;
  wire                      usb_station_u__vld_in_b2s_debug_u2pmu_lo;
  wire                      usb_station_u__vld_in_b2s_debug_u3pmu;
  wire                      usb_station_u__vld_in_b2s_gp_out;
  wire                      usb_station_u__vld_in_b2s_mpll_refssc_clk;
  wire                      usb_station_u__vld_in_b2s_pme_generation_u2pmu;
  wire                      usb_station_u__vld_in_b2s_pme_generation_u3pmu;
  wire                      usb_station_u__vld_in_b2s_rtune_ack;
  
  wire                      vp0_cpunoc_amoreq_valid_and_u__in0;
  wire                      vp0_cpunoc_amoreq_valid_and_u__in1;
  wire                      vp0_cpunoc_amoreq_valid_and_u__out;
  wire                      vp0_cpunoc_req_valid_and_u__in0;
  wire                      vp0_cpunoc_req_valid_and_u__in1;
  wire                      vp0_cpunoc_req_valid_and_u__out;
  wire                      vp0_icg_u__clk;
  wire                      vp0_icg_u__clkg;
  wire                      vp0_icg_u__en;
  wire                      vp0_icg_u__tst_en;
  wire[0:0]                 vp0_iso_or_u__in_0;
  wire[0:0]                 vp0_iso_or_u__in_1;
  wire[0:0]                 vp0_iso_or_u__out;
  wire                      vp0_ring_bvalid_and_u__in0;
  wire                      vp0_ring_bvalid_and_u__in1;
  wire                      vp0_ring_bvalid_and_u__out;
  wire                      vp0_ring_rvalid_and_u__in0;
  wire                      vp0_ring_rvalid_and_u__in1;
  wire                      vp0_ring_rvalid_and_u__out;
  wire                      vp0_rstn_sync_u__clk;
  wire                      vp0_rstn_sync_u__rstn_in;
  wire                      vp0_rstn_sync_u__rstn_out;
  wire                      vp0_rstn_sync_u__scan_en;
  wire                      vp0_rstn_sync_u__scan_rstn;
  wire[0:0]                 vp0_scan_reset_u__in_0;
  wire[0:0]                 vp0_scan_reset_u__in_1;
  wire[0:0]                 vp0_scan_reset_u__out;
  wire                      vp0_station_u__clk;
  oursring_req_if_ar_t      vp0_station_u__i_req_local_if_ar;
  wire                      vp0_station_u__i_req_local_if_arready;
  wire                      vp0_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      vp0_station_u__i_req_local_if_aw;
  wire                      vp0_station_u__i_req_local_if_awready;
  wire                      vp0_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       vp0_station_u__i_req_local_if_w;
  wire                      vp0_station_u__i_req_local_if_wready;
  wire                      vp0_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      vp0_station_u__i_req_ring_if_ar;
  wire                      vp0_station_u__i_req_ring_if_arready;
  wire                      vp0_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp0_station_u__i_req_ring_if_aw;
  wire                      vp0_station_u__i_req_ring_if_awready;
  wire                      vp0_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       vp0_station_u__i_req_ring_if_w;
  wire                      vp0_station_u__i_req_ring_if_wready;
  wire                      vp0_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp0_station_u__i_resp_local_if_b;
  wire                      vp0_station_u__i_resp_local_if_bready;
  wire                      vp0_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp0_station_u__i_resp_local_if_r;
  wire                      vp0_station_u__i_resp_local_if_rready;
  wire                      vp0_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp0_station_u__i_resp_ring_if_b;
  wire                      vp0_station_u__i_resp_ring_if_bready;
  wire                      vp0_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp0_station_u__i_resp_ring_if_r;
  wire                      vp0_station_u__i_resp_ring_if_rready;
  wire                      vp0_station_u__i_resp_ring_if_rvalid;
  wire                      vp0_station_u__in_b2s_debug_stall_out;
  wire                      vp0_station_u__in_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp0_station_u__in_b2s_itb_last_ptr;
  wire                      vp0_station_u__in_b2s_vload_drt_req_vlen_illegal;
  oursring_req_if_ar_t      vp0_station_u__o_req_local_if_ar;
  wire                      vp0_station_u__o_req_local_if_arready;
  wire                      vp0_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      vp0_station_u__o_req_local_if_aw;
  wire                      vp0_station_u__o_req_local_if_awready;
  wire                      vp0_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       vp0_station_u__o_req_local_if_w;
  wire                      vp0_station_u__o_req_local_if_wready;
  wire                      vp0_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      vp0_station_u__o_req_ring_if_ar;
  wire                      vp0_station_u__o_req_ring_if_arready;
  wire                      vp0_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp0_station_u__o_req_ring_if_aw;
  wire                      vp0_station_u__o_req_ring_if_awready;
  wire                      vp0_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       vp0_station_u__o_req_ring_if_w;
  wire                      vp0_station_u__o_req_ring_if_wready;
  wire                      vp0_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp0_station_u__o_resp_local_if_b;
  wire                      vp0_station_u__o_resp_local_if_bready;
  wire                      vp0_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp0_station_u__o_resp_local_if_r;
  wire                      vp0_station_u__o_resp_local_if_rready;
  wire                      vp0_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp0_station_u__o_resp_ring_if_b;
  wire                      vp0_station_u__o_resp_ring_if_bready;
  wire                      vp0_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp0_station_u__o_resp_ring_if_r;
  wire                      vp0_station_u__o_resp_ring_if_rready;
  wire                      vp0_station_u__o_resp_ring_if_rvalid;
  wire                      vp0_station_u__out_b2s_debug_stall_out;
  wire                      vp0_station_u__out_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp0_station_u__out_b2s_itb_last_ptr;
  wire                      vp0_station_u__out_b2s_vload_drt_req_vlen_illegal;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_if_pc_0;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_if_pc_1;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_if_pc_2;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_if_pc_3;
  orv64_data_t              vp0_station_u__out_s2b_bp_instret;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp0_station_u__out_s2b_bp_wb_pc_3;
  wire                      vp0_station_u__out_s2b_cfg_bypass_ic;
  wire                      vp0_station_u__out_s2b_cfg_bypass_tlb;
  wire                      vp0_station_u__out_s2b_cfg_en_hpmcounter;
  wire                      vp0_station_u__out_s2b_cfg_itb_en;
  orv64_itb_sel_t           vp0_station_u__out_s2b_cfg_itb_sel;
  wire                      vp0_station_u__out_s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp0_station_u__out_s2b_cfg_lfsr_seed;
  wire                      vp0_station_u__out_s2b_cfg_pwr_on;
  orv64_vaddr_t             vp0_station_u__out_s2b_cfg_rst_pc;
  wire                      vp0_station_u__out_s2b_cfg_sleep;
  wire                      vp0_station_u__out_s2b_debug_resume;
  wire                      vp0_station_u__out_s2b_debug_stall;
  wire                      vp0_station_u__out_s2b_early_rstn;
  wire                      vp0_station_u__out_s2b_en_bp_if_pc_0;
  wire                      vp0_station_u__out_s2b_en_bp_if_pc_1;
  wire                      vp0_station_u__out_s2b_en_bp_if_pc_2;
  wire                      vp0_station_u__out_s2b_en_bp_if_pc_3;
  wire                      vp0_station_u__out_s2b_en_bp_instret;
  wire                      vp0_station_u__out_s2b_en_bp_wb_pc_0;
  wire                      vp0_station_u__out_s2b_en_bp_wb_pc_1;
  wire                      vp0_station_u__out_s2b_en_bp_wb_pc_2;
  wire                      vp0_station_u__out_s2b_en_bp_wb_pc_3;
  wire                      vp0_station_u__out_s2b_ext_event;
  powerline_ctrl_t          vp0_station_u__out_s2b_powerline_ctrl;
  powervbank_ctrl_t         vp0_station_u__out_s2b_powervbank_ctrl;
  wire                      vp0_station_u__out_s2b_rstn;
  wire                      vp0_station_u__out_s2b_vcore_en;
  orv_vcore_icg_disable_t   vp0_station_u__out_s2b_vcore_icg_disable;
  wire                      vp0_station_u__out_s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp0_station_u__out_s2b_vcore_pmu_evt_mask;
  wire                      vp0_station_u__out_s2icg_clk_en;
  wire                      vp0_station_u__rstn;
  wire                      vp0_station_u__vld_in_b2s_debug_stall_out;
  wire                      vp0_station_u__vld_in_b2s_is_vtlb_excp;
  wire                      vp0_station_u__vld_in_b2s_itb_last_ptr;
  wire                      vp0_station_u__vld_in_b2s_vload_drt_req_vlen_illegal;
  wire                      vp0_sysbus_arvalid_and_u__in0;
  wire                      vp0_sysbus_arvalid_and_u__in1;
  wire                      vp0_sysbus_arvalid_and_u__out;
  wire                      vp0_sysbus_awvalid_and_u__in0;
  wire                      vp0_sysbus_awvalid_and_u__in1;
  wire                      vp0_sysbus_awvalid_and_u__out;
  wire                      vp0_sysbus_wvalid_and_u__in0;
  wire                      vp0_sysbus_wvalid_and_u__in1;
  wire                      vp0_sysbus_wvalid_and_u__out;
  wire                      vp0_u__b2s_debug_stall_out;
  orv64_itb_addr_t          vp0_u__b2s_itb_last_ptr;
  wire                      vp0_u__b2s_vload_drt_req_vlen_illegal;
  cpu_cache_if_req_t        vp0_u__cache_req_if_req;
  wire                      vp0_u__cache_req_if_req_ready;
  wire                      vp0_u__cache_req_if_req_valid;
  cpu_cache_if_resp_t       vp0_u__cache_resp_if_resp;
  wire                      vp0_u__cache_resp_if_resp_ready;
  wire                      vp0_u__cache_resp_if_resp_valid;
  wire                      vp0_u__clk;
  wire[7:0]                 vp0_u__core_id;
  cpu_cache_if_req_t        vp0_u__cpu_amo_store_req;
  wire                      vp0_u__cpu_amo_store_req_ready;
  wire                      vp0_u__cpu_amo_store_req_valid;
  wire                      vp0_u__external_int;
  wire                      vp0_u__load_vtlb_excp;
  oursring_req_if_ar_t      vp0_u__ring_req_if_ar;
  wire                      vp0_u__ring_req_if_arready;
  wire                      vp0_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      vp0_u__ring_req_if_aw;
  wire                      vp0_u__ring_req_if_awready;
  wire                      vp0_u__ring_req_if_awvalid;
  oursring_req_if_w_t       vp0_u__ring_req_if_w;
  wire                      vp0_u__ring_req_if_wready;
  wire                      vp0_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      vp0_u__ring_resp_if_b;
  wire                      vp0_u__ring_resp_if_bready;
  wire                      vp0_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      vp0_u__ring_resp_if_r;
  wire                      vp0_u__ring_resp_if_rready;
  wire                      vp0_u__ring_resp_if_rvalid;
  orv64_vaddr_t             vp0_u__s2b_bp_if_pc_0;
  orv64_vaddr_t             vp0_u__s2b_bp_if_pc_1;
  orv64_vaddr_t             vp0_u__s2b_bp_if_pc_2;
  orv64_vaddr_t             vp0_u__s2b_bp_if_pc_3;
  orv64_data_t              vp0_u__s2b_bp_instret;
  orv64_vaddr_t             vp0_u__s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp0_u__s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp0_u__s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp0_u__s2b_bp_wb_pc_3;
  wire                      vp0_u__s2b_cfg_bypass_ic;
  wire                      vp0_u__s2b_cfg_bypass_tlb;
  wire                      vp0_u__s2b_cfg_en_hpmcounter;
  wire                      vp0_u__s2b_cfg_itb_en;
  orv64_itb_sel_t           vp0_u__s2b_cfg_itb_sel;
  wire                      vp0_u__s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp0_u__s2b_cfg_lfsr_seed;
  wire                      vp0_u__s2b_cfg_pwr_on;
  orv64_vaddr_t             vp0_u__s2b_cfg_rst_pc;
  wire                      vp0_u__s2b_cfg_sleep;
  wire                      vp0_u__s2b_debug_resume;
  wire                      vp0_u__s2b_debug_stall;
  wire                      vp0_u__s2b_early_rstn;
  wire                      vp0_u__s2b_en_bp_if_pc_0;
  wire                      vp0_u__s2b_en_bp_if_pc_1;
  wire                      vp0_u__s2b_en_bp_if_pc_2;
  wire                      vp0_u__s2b_en_bp_if_pc_3;
  wire                      vp0_u__s2b_en_bp_instret;
  wire                      vp0_u__s2b_en_bp_wb_pc_0;
  wire                      vp0_u__s2b_en_bp_wb_pc_1;
  wire                      vp0_u__s2b_en_bp_wb_pc_2;
  wire                      vp0_u__s2b_en_bp_wb_pc_3;
  wire                      vp0_u__s2b_ext_event;
  powerline_ctrl_t          vp0_u__s2b_powerline_ctrl;
  powervbank_ctrl_t         vp0_u__s2b_powervbank_ctrl;
  wire                      vp0_u__s2b_rstn;
  wire                      vp0_u__s2b_vcore_en;
  orv_vcore_icg_disable_t   vp0_u__s2b_vcore_icg_disable;
  wire                      vp0_u__s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp0_u__s2b_vcore_pmu_evt_mask;
  wire                      vp0_u__software_int;
  oursring_req_if_ar_t      vp0_u__sysbus_req_if_ar;
  wire                      vp0_u__sysbus_req_if_arready;
  wire                      vp0_u__sysbus_req_if_arvalid;
  oursring_req_if_aw_t      vp0_u__sysbus_req_if_aw;
  wire                      vp0_u__sysbus_req_if_awready;
  wire                      vp0_u__sysbus_req_if_awvalid;
  oursring_req_if_w_t       vp0_u__sysbus_req_if_w;
  wire                      vp0_u__sysbus_req_if_wready;
  wire                      vp0_u__sysbus_req_if_wvalid;
  oursring_resp_if_b_t      vp0_u__sysbus_resp_if_b;
  wire                      vp0_u__sysbus_resp_if_bready;
  wire                      vp0_u__sysbus_resp_if_bvalid;
  oursring_resp_if_r_t      vp0_u__sysbus_resp_if_r;
  wire                      vp0_u__sysbus_resp_if_rready;
  wire                      vp0_u__sysbus_resp_if_rvalid;
  wire                      vp0_u__timer_int;
  wire                      vp0_u__wfe_stall;
  wire                      vp0_u__wfi_stall;
  wire                      vp0_vlsu_int_and_u__in0;
  wire                      vp0_vlsu_int_and_u__in1;
  wire                      vp0_vlsu_int_and_u__out;
  wire                      vp1_cpunoc_amoreq_valid_and_u__in0;
  wire                      vp1_cpunoc_amoreq_valid_and_u__in1;
  wire                      vp1_cpunoc_amoreq_valid_and_u__out;
  wire                      vp1_cpunoc_req_valid_and_u__in0;
  wire                      vp1_cpunoc_req_valid_and_u__in1;
  wire                      vp1_cpunoc_req_valid_and_u__out;
  wire                      vp1_icg_u__clk;
  wire                      vp1_icg_u__clkg;
  wire                      vp1_icg_u__en;
  wire                      vp1_icg_u__tst_en;
  wire[0:0]                 vp1_iso_or_u__in_0;
  wire[0:0]                 vp1_iso_or_u__in_1;
  wire[0:0]                 vp1_iso_or_u__out;
  wire                      vp1_ring_bvalid_and_u__in0;
  wire                      vp1_ring_bvalid_and_u__in1;
  wire                      vp1_ring_bvalid_and_u__out;
  wire                      vp1_ring_rvalid_and_u__in0;
  wire                      vp1_ring_rvalid_and_u__in1;
  wire                      vp1_ring_rvalid_and_u__out;
  wire                      vp1_rstn_sync_u__clk;
  wire                      vp1_rstn_sync_u__rstn_in;
  wire                      vp1_rstn_sync_u__rstn_out;
  wire                      vp1_rstn_sync_u__scan_en;
  wire                      vp1_rstn_sync_u__scan_rstn;
  wire[0:0]                 vp1_scan_reset_u__in_0;
  wire[0:0]                 vp1_scan_reset_u__in_1;
  wire[0:0]                 vp1_scan_reset_u__out;
  `ifdef IFNDEF_SINGLE_VP
  wire                      vp1_station_u__clk;
  oursring_req_if_ar_t      vp1_station_u__i_req_local_if_ar;
  wire                      vp1_station_u__i_req_local_if_arready;
  wire                      vp1_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      vp1_station_u__i_req_local_if_aw;
  wire                      vp1_station_u__i_req_local_if_awready;
  wire                      vp1_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       vp1_station_u__i_req_local_if_w;
  wire                      vp1_station_u__i_req_local_if_wready;
  wire                      vp1_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      vp1_station_u__i_req_ring_if_ar;
  wire                      vp1_station_u__i_req_ring_if_arready;
  wire                      vp1_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp1_station_u__i_req_ring_if_aw;
  wire                      vp1_station_u__i_req_ring_if_awready;
  wire                      vp1_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       vp1_station_u__i_req_ring_if_w;
  wire                      vp1_station_u__i_req_ring_if_wready;
  wire                      vp1_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp1_station_u__i_resp_local_if_b;
  wire                      vp1_station_u__i_resp_local_if_bready;
  wire                      vp1_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp1_station_u__i_resp_local_if_r;
  wire                      vp1_station_u__i_resp_local_if_rready;
  wire                      vp1_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp1_station_u__i_resp_ring_if_b;
  wire                      vp1_station_u__i_resp_ring_if_bready;
  wire                      vp1_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp1_station_u__i_resp_ring_if_r;
  wire                      vp1_station_u__i_resp_ring_if_rready;
  wire                      vp1_station_u__i_resp_ring_if_rvalid;
  wire                      vp1_station_u__in_b2s_debug_stall_out;
  wire                      vp1_station_u__in_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp1_station_u__in_b2s_itb_last_ptr;
  wire                      vp1_station_u__in_b2s_vload_drt_req_vlen_illegal;
  oursring_req_if_ar_t      vp1_station_u__o_req_local_if_ar;
  wire                      vp1_station_u__o_req_local_if_arready;
  wire                      vp1_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      vp1_station_u__o_req_local_if_aw;
  wire                      vp1_station_u__o_req_local_if_awready;
  wire                      vp1_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       vp1_station_u__o_req_local_if_w;
  wire                      vp1_station_u__o_req_local_if_wready;
  wire                      vp1_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      vp1_station_u__o_req_ring_if_ar;
  wire                      vp1_station_u__o_req_ring_if_arready;
  wire                      vp1_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp1_station_u__o_req_ring_if_aw;
  wire                      vp1_station_u__o_req_ring_if_awready;
  wire                      vp1_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       vp1_station_u__o_req_ring_if_w;
  wire                      vp1_station_u__o_req_ring_if_wready;
  wire                      vp1_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp1_station_u__o_resp_local_if_b;
  wire                      vp1_station_u__o_resp_local_if_bready;
  wire                      vp1_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp1_station_u__o_resp_local_if_r;
  wire                      vp1_station_u__o_resp_local_if_rready;
  wire                      vp1_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp1_station_u__o_resp_ring_if_b;
  wire                      vp1_station_u__o_resp_ring_if_bready;
  wire                      vp1_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp1_station_u__o_resp_ring_if_r;
  wire                      vp1_station_u__o_resp_ring_if_rready;
  wire                      vp1_station_u__o_resp_ring_if_rvalid;
  wire                      vp1_station_u__out_b2s_debug_stall_out;
  wire                      vp1_station_u__out_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp1_station_u__out_b2s_itb_last_ptr;
  wire                      vp1_station_u__out_b2s_vload_drt_req_vlen_illegal;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_if_pc_0;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_if_pc_1;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_if_pc_2;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_if_pc_3;
  orv64_data_t              vp1_station_u__out_s2b_bp_instret;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp1_station_u__out_s2b_bp_wb_pc_3;
  wire                      vp1_station_u__out_s2b_cfg_bypass_ic;
  wire                      vp1_station_u__out_s2b_cfg_bypass_tlb;
  wire                      vp1_station_u__out_s2b_cfg_en_hpmcounter;
  wire                      vp1_station_u__out_s2b_cfg_itb_en;
  orv64_itb_sel_t           vp1_station_u__out_s2b_cfg_itb_sel;
  wire                      vp1_station_u__out_s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp1_station_u__out_s2b_cfg_lfsr_seed;
  wire                      vp1_station_u__out_s2b_cfg_pwr_on;
  orv64_vaddr_t             vp1_station_u__out_s2b_cfg_rst_pc;
  wire                      vp1_station_u__out_s2b_cfg_sleep;
  wire                      vp1_station_u__out_s2b_debug_resume;
  wire                      vp1_station_u__out_s2b_debug_stall;
  wire                      vp1_station_u__out_s2b_early_rstn;
  wire                      vp1_station_u__out_s2b_en_bp_if_pc_0;
  wire                      vp1_station_u__out_s2b_en_bp_if_pc_1;
  wire                      vp1_station_u__out_s2b_en_bp_if_pc_2;
  wire                      vp1_station_u__out_s2b_en_bp_if_pc_3;
  wire                      vp1_station_u__out_s2b_en_bp_instret;
  wire                      vp1_station_u__out_s2b_en_bp_wb_pc_0;
  wire                      vp1_station_u__out_s2b_en_bp_wb_pc_1;
  wire                      vp1_station_u__out_s2b_en_bp_wb_pc_2;
  wire                      vp1_station_u__out_s2b_en_bp_wb_pc_3;
  wire                      vp1_station_u__out_s2b_ext_event;
  powerline_ctrl_t          vp1_station_u__out_s2b_powerline_ctrl;
  powervbank_ctrl_t         vp1_station_u__out_s2b_powervbank_ctrl;
  wire                      vp1_station_u__out_s2b_rstn;
  wire                      vp1_station_u__out_s2b_vcore_en;
  orv_vcore_icg_disable_t   vp1_station_u__out_s2b_vcore_icg_disable;
  wire                      vp1_station_u__out_s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp1_station_u__out_s2b_vcore_pmu_evt_mask;
  wire                      vp1_station_u__out_s2icg_clk_en;
  wire                      vp1_station_u__rstn;
  wire                      vp1_station_u__vld_in_b2s_debug_stall_out;
  wire                      vp1_station_u__vld_in_b2s_is_vtlb_excp;
  wire                      vp1_station_u__vld_in_b2s_itb_last_ptr;
  wire                      vp1_station_u__vld_in_b2s_vload_drt_req_vlen_illegal;
  `endif
  wire                      vp1_sysbus_arvalid_and_u__in0;
  wire                      vp1_sysbus_arvalid_and_u__in1;
  wire                      vp1_sysbus_arvalid_and_u__out;
  wire                      vp1_sysbus_awvalid_and_u__in0;
  wire                      vp1_sysbus_awvalid_and_u__in1;
  wire                      vp1_sysbus_awvalid_and_u__out;
  wire                      vp1_sysbus_wvalid_and_u__in0;
  wire                      vp1_sysbus_wvalid_and_u__in1;
  wire                      vp1_sysbus_wvalid_and_u__out;
  wire                      vp1_u__b2s_debug_stall_out;
  orv64_itb_addr_t          vp1_u__b2s_itb_last_ptr;
  wire                      vp1_u__b2s_vload_drt_req_vlen_illegal;
  cpu_cache_if_req_t        vp1_u__cache_req_if_req;
  wire                      vp1_u__cache_req_if_req_ready;
  wire                      vp1_u__cache_req_if_req_valid;
  cpu_cache_if_resp_t       vp1_u__cache_resp_if_resp;
  wire                      vp1_u__cache_resp_if_resp_ready;
  wire                      vp1_u__cache_resp_if_resp_valid;
  wire                      vp1_u__clk;
  wire[7:0]                 vp1_u__core_id;
  cpu_cache_if_req_t        vp1_u__cpu_amo_store_req;
  wire                      vp1_u__cpu_amo_store_req_ready;
  wire                      vp1_u__cpu_amo_store_req_valid;
  wire                      vp1_u__external_int;
  wire                      vp1_u__load_vtlb_excp;
  oursring_req_if_ar_t      vp1_u__ring_req_if_ar;
  wire                      vp1_u__ring_req_if_arready;
  wire                      vp1_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      vp1_u__ring_req_if_aw;
  wire                      vp1_u__ring_req_if_awready;
  wire                      vp1_u__ring_req_if_awvalid;
  oursring_req_if_w_t       vp1_u__ring_req_if_w;
  wire                      vp1_u__ring_req_if_wready;
  wire                      vp1_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      vp1_u__ring_resp_if_b;
  wire                      vp1_u__ring_resp_if_bready;
  wire                      vp1_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      vp1_u__ring_resp_if_r;
  wire                      vp1_u__ring_resp_if_rready;
  wire                      vp1_u__ring_resp_if_rvalid;
  orv64_vaddr_t             vp1_u__s2b_bp_if_pc_0;
  orv64_vaddr_t             vp1_u__s2b_bp_if_pc_1;
  orv64_vaddr_t             vp1_u__s2b_bp_if_pc_2;
  orv64_vaddr_t             vp1_u__s2b_bp_if_pc_3;
  orv64_data_t              vp1_u__s2b_bp_instret;
  orv64_vaddr_t             vp1_u__s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp1_u__s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp1_u__s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp1_u__s2b_bp_wb_pc_3;
  wire                      vp1_u__s2b_cfg_bypass_ic;
  wire                      vp1_u__s2b_cfg_bypass_tlb;
  wire                      vp1_u__s2b_cfg_en_hpmcounter;
  wire                      vp1_u__s2b_cfg_itb_en;
  orv64_itb_sel_t           vp1_u__s2b_cfg_itb_sel;
  wire                      vp1_u__s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp1_u__s2b_cfg_lfsr_seed;
  wire                      vp1_u__s2b_cfg_pwr_on;
  orv64_vaddr_t             vp1_u__s2b_cfg_rst_pc;
  wire                      vp1_u__s2b_cfg_sleep;
  wire                      vp1_u__s2b_debug_resume;
  wire                      vp1_u__s2b_debug_stall;
  wire                      vp1_u__s2b_early_rstn;
  wire                      vp1_u__s2b_en_bp_if_pc_0;
  wire                      vp1_u__s2b_en_bp_if_pc_1;
  wire                      vp1_u__s2b_en_bp_if_pc_2;
  wire                      vp1_u__s2b_en_bp_if_pc_3;
  wire                      vp1_u__s2b_en_bp_instret;
  wire                      vp1_u__s2b_en_bp_wb_pc_0;
  wire                      vp1_u__s2b_en_bp_wb_pc_1;
  wire                      vp1_u__s2b_en_bp_wb_pc_2;
  wire                      vp1_u__s2b_en_bp_wb_pc_3;
  wire                      vp1_u__s2b_ext_event;
  powerline_ctrl_t          vp1_u__s2b_powerline_ctrl;
  powervbank_ctrl_t         vp1_u__s2b_powervbank_ctrl;
  wire                      vp1_u__s2b_rstn;
  wire                      vp1_u__s2b_vcore_en;
  orv_vcore_icg_disable_t   vp1_u__s2b_vcore_icg_disable;
  wire                      vp1_u__s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp1_u__s2b_vcore_pmu_evt_mask;
  wire                      vp1_u__software_int;
  oursring_req_if_ar_t      vp1_u__sysbus_req_if_ar;
  wire                      vp1_u__sysbus_req_if_arready;
  wire                      vp1_u__sysbus_req_if_arvalid;
  oursring_req_if_aw_t      vp1_u__sysbus_req_if_aw;
  wire                      vp1_u__sysbus_req_if_awready;
  wire                      vp1_u__sysbus_req_if_awvalid;
  oursring_req_if_w_t       vp1_u__sysbus_req_if_w;
  wire                      vp1_u__sysbus_req_if_wready;
  wire                      vp1_u__sysbus_req_if_wvalid;
  oursring_resp_if_b_t      vp1_u__sysbus_resp_if_b;
  wire                      vp1_u__sysbus_resp_if_bready;
  wire                      vp1_u__sysbus_resp_if_bvalid;
  oursring_resp_if_r_t      vp1_u__sysbus_resp_if_r;
  wire                      vp1_u__sysbus_resp_if_rready;
  wire                      vp1_u__sysbus_resp_if_rvalid;
  wire                      vp1_u__timer_int;
  wire                      vp1_u__wfe_stall;
  wire                      vp1_u__wfi_stall;
  wire                      vp1_vlsu_int_and_u__in0;
  wire                      vp1_vlsu_int_and_u__in1;
  wire                      vp1_vlsu_int_and_u__out;
  wire                      vp2_cpunoc_amoreq_valid_and_u__in0;
  wire                      vp2_cpunoc_amoreq_valid_and_u__in1;
  wire                      vp2_cpunoc_amoreq_valid_and_u__out;
  wire                      vp2_cpunoc_req_valid_and_u__in0;
  wire                      vp2_cpunoc_req_valid_and_u__in1;
  wire                      vp2_cpunoc_req_valid_and_u__out;
  wire                      vp2_icg_u__clk;
  wire                      vp2_icg_u__clkg;
  wire                      vp2_icg_u__en;
  wire                      vp2_icg_u__tst_en;
  wire[0:0]                 vp2_iso_or_u__in_0;
  wire[0:0]                 vp2_iso_or_u__in_1;
  wire[0:0]                 vp2_iso_or_u__out;
  wire                      vp2_ring_bvalid_and_u__in0;
  wire                      vp2_ring_bvalid_and_u__in1;
  wire                      vp2_ring_bvalid_and_u__out;
  wire                      vp2_ring_rvalid_and_u__in0;
  wire                      vp2_ring_rvalid_and_u__in1;
  wire                      vp2_ring_rvalid_and_u__out;
  wire                      vp2_rstn_sync_u__clk;
  wire                      vp2_rstn_sync_u__rstn_in;
  wire                      vp2_rstn_sync_u__rstn_out;
  wire                      vp2_rstn_sync_u__scan_en;
  wire                      vp2_rstn_sync_u__scan_rstn;
  wire[0:0]                 vp2_scan_reset_u__in_0;
  wire[0:0]                 vp2_scan_reset_u__in_1;
  wire[0:0]                 vp2_scan_reset_u__out;
  `ifdef IFNDEF_SINGLE_VP
  wire                      vp2_station_u__clk;
  oursring_req_if_ar_t      vp2_station_u__i_req_local_if_ar;
  wire                      vp2_station_u__i_req_local_if_arready;
  wire                      vp2_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      vp2_station_u__i_req_local_if_aw;
  wire                      vp2_station_u__i_req_local_if_awready;
  wire                      vp2_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       vp2_station_u__i_req_local_if_w;
  wire                      vp2_station_u__i_req_local_if_wready;
  wire                      vp2_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      vp2_station_u__i_req_ring_if_ar;
  wire                      vp2_station_u__i_req_ring_if_arready;
  wire                      vp2_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp2_station_u__i_req_ring_if_aw;
  wire                      vp2_station_u__i_req_ring_if_awready;
  wire                      vp2_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       vp2_station_u__i_req_ring_if_w;
  wire                      vp2_station_u__i_req_ring_if_wready;
  wire                      vp2_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp2_station_u__i_resp_local_if_b;
  wire                      vp2_station_u__i_resp_local_if_bready;
  wire                      vp2_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp2_station_u__i_resp_local_if_r;
  wire                      vp2_station_u__i_resp_local_if_rready;
  wire                      vp2_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp2_station_u__i_resp_ring_if_b;
  wire                      vp2_station_u__i_resp_ring_if_bready;
  wire                      vp2_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp2_station_u__i_resp_ring_if_r;
  wire                      vp2_station_u__i_resp_ring_if_rready;
  wire                      vp2_station_u__i_resp_ring_if_rvalid;
  wire                      vp2_station_u__in_b2s_debug_stall_out;
  wire                      vp2_station_u__in_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp2_station_u__in_b2s_itb_last_ptr;
  wire                      vp2_station_u__in_b2s_vload_drt_req_vlen_illegal;
  oursring_req_if_ar_t      vp2_station_u__o_req_local_if_ar;
  wire                      vp2_station_u__o_req_local_if_arready;
  wire                      vp2_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      vp2_station_u__o_req_local_if_aw;
  wire                      vp2_station_u__o_req_local_if_awready;
  wire                      vp2_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       vp2_station_u__o_req_local_if_w;
  wire                      vp2_station_u__o_req_local_if_wready;
  wire                      vp2_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      vp2_station_u__o_req_ring_if_ar;
  wire                      vp2_station_u__o_req_ring_if_arready;
  wire                      vp2_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp2_station_u__o_req_ring_if_aw;
  wire                      vp2_station_u__o_req_ring_if_awready;
  wire                      vp2_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       vp2_station_u__o_req_ring_if_w;
  wire                      vp2_station_u__o_req_ring_if_wready;
  wire                      vp2_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp2_station_u__o_resp_local_if_b;
  wire                      vp2_station_u__o_resp_local_if_bready;
  wire                      vp2_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp2_station_u__o_resp_local_if_r;
  wire                      vp2_station_u__o_resp_local_if_rready;
  wire                      vp2_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp2_station_u__o_resp_ring_if_b;
  wire                      vp2_station_u__o_resp_ring_if_bready;
  wire                      vp2_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp2_station_u__o_resp_ring_if_r;
  wire                      vp2_station_u__o_resp_ring_if_rready;
  wire                      vp2_station_u__o_resp_ring_if_rvalid;
  wire                      vp2_station_u__out_b2s_debug_stall_out;
  wire                      vp2_station_u__out_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp2_station_u__out_b2s_itb_last_ptr;
  wire                      vp2_station_u__out_b2s_vload_drt_req_vlen_illegal;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_if_pc_0;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_if_pc_1;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_if_pc_2;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_if_pc_3;
  orv64_data_t              vp2_station_u__out_s2b_bp_instret;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp2_station_u__out_s2b_bp_wb_pc_3;
  wire                      vp2_station_u__out_s2b_cfg_bypass_ic;
  wire                      vp2_station_u__out_s2b_cfg_bypass_tlb;
  wire                      vp2_station_u__out_s2b_cfg_en_hpmcounter;
  wire                      vp2_station_u__out_s2b_cfg_itb_en;
  orv64_itb_sel_t           vp2_station_u__out_s2b_cfg_itb_sel;
  wire                      vp2_station_u__out_s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp2_station_u__out_s2b_cfg_lfsr_seed;
  wire                      vp2_station_u__out_s2b_cfg_pwr_on;
  orv64_vaddr_t             vp2_station_u__out_s2b_cfg_rst_pc;
  wire                      vp2_station_u__out_s2b_cfg_sleep;
  wire                      vp2_station_u__out_s2b_debug_resume;
  wire                      vp2_station_u__out_s2b_debug_stall;
  wire                      vp2_station_u__out_s2b_early_rstn;
  wire                      vp2_station_u__out_s2b_en_bp_if_pc_0;
  wire                      vp2_station_u__out_s2b_en_bp_if_pc_1;
  wire                      vp2_station_u__out_s2b_en_bp_if_pc_2;
  wire                      vp2_station_u__out_s2b_en_bp_if_pc_3;
  wire                      vp2_station_u__out_s2b_en_bp_instret;
  wire                      vp2_station_u__out_s2b_en_bp_wb_pc_0;
  wire                      vp2_station_u__out_s2b_en_bp_wb_pc_1;
  wire                      vp2_station_u__out_s2b_en_bp_wb_pc_2;
  wire                      vp2_station_u__out_s2b_en_bp_wb_pc_3;
  wire                      vp2_station_u__out_s2b_ext_event;
  powerline_ctrl_t          vp2_station_u__out_s2b_powerline_ctrl;
  powervbank_ctrl_t         vp2_station_u__out_s2b_powervbank_ctrl;
  wire                      vp2_station_u__out_s2b_rstn;
  wire                      vp2_station_u__out_s2b_vcore_en;
  orv_vcore_icg_disable_t   vp2_station_u__out_s2b_vcore_icg_disable;
  wire                      vp2_station_u__out_s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp2_station_u__out_s2b_vcore_pmu_evt_mask;
  wire                      vp2_station_u__out_s2icg_clk_en;
  wire                      vp2_station_u__rstn;
  wire                      vp2_station_u__vld_in_b2s_debug_stall_out;
  wire                      vp2_station_u__vld_in_b2s_is_vtlb_excp;
  wire                      vp2_station_u__vld_in_b2s_itb_last_ptr;
  wire                      vp2_station_u__vld_in_b2s_vload_drt_req_vlen_illegal;
  `endif
  wire                      vp2_sysbus_arvalid_and_u__in0;
  wire                      vp2_sysbus_arvalid_and_u__in1;
  wire                      vp2_sysbus_arvalid_and_u__out;
  wire                      vp2_sysbus_awvalid_and_u__in0;
  wire                      vp2_sysbus_awvalid_and_u__in1;
  wire                      vp2_sysbus_awvalid_and_u__out;
  wire                      vp2_sysbus_wvalid_and_u__in0;
  wire                      vp2_sysbus_wvalid_and_u__in1;
  wire                      vp2_sysbus_wvalid_and_u__out;
  wire                      vp2_u__b2s_debug_stall_out;
  orv64_itb_addr_t          vp2_u__b2s_itb_last_ptr;
  wire                      vp2_u__b2s_vload_drt_req_vlen_illegal;
  cpu_cache_if_req_t        vp2_u__cache_req_if_req;
  wire                      vp2_u__cache_req_if_req_ready;
  wire                      vp2_u__cache_req_if_req_valid;
  cpu_cache_if_resp_t       vp2_u__cache_resp_if_resp;
  wire                      vp2_u__cache_resp_if_resp_ready;
  wire                      vp2_u__cache_resp_if_resp_valid;
  wire                      vp2_u__clk;
  wire[7:0]                 vp2_u__core_id;
  cpu_cache_if_req_t        vp2_u__cpu_amo_store_req;
  wire                      vp2_u__cpu_amo_store_req_ready;
  wire                      vp2_u__cpu_amo_store_req_valid;
  wire                      vp2_u__external_int;
  wire                      vp2_u__load_vtlb_excp;
  oursring_req_if_ar_t      vp2_u__ring_req_if_ar;
  wire                      vp2_u__ring_req_if_arready;
  wire                      vp2_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      vp2_u__ring_req_if_aw;
  wire                      vp2_u__ring_req_if_awready;
  wire                      vp2_u__ring_req_if_awvalid;
  oursring_req_if_w_t       vp2_u__ring_req_if_w;
  wire                      vp2_u__ring_req_if_wready;
  wire                      vp2_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      vp2_u__ring_resp_if_b;
  wire                      vp2_u__ring_resp_if_bready;
  wire                      vp2_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      vp2_u__ring_resp_if_r;
  wire                      vp2_u__ring_resp_if_rready;
  wire                      vp2_u__ring_resp_if_rvalid;
  orv64_vaddr_t             vp2_u__s2b_bp_if_pc_0;
  orv64_vaddr_t             vp2_u__s2b_bp_if_pc_1;
  orv64_vaddr_t             vp2_u__s2b_bp_if_pc_2;
  orv64_vaddr_t             vp2_u__s2b_bp_if_pc_3;
  orv64_data_t              vp2_u__s2b_bp_instret;
  orv64_vaddr_t             vp2_u__s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp2_u__s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp2_u__s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp2_u__s2b_bp_wb_pc_3;
  wire                      vp2_u__s2b_cfg_bypass_ic;
  wire                      vp2_u__s2b_cfg_bypass_tlb;
  wire                      vp2_u__s2b_cfg_en_hpmcounter;
  wire                      vp2_u__s2b_cfg_itb_en;
  orv64_itb_sel_t           vp2_u__s2b_cfg_itb_sel;
  wire                      vp2_u__s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp2_u__s2b_cfg_lfsr_seed;
  wire                      vp2_u__s2b_cfg_pwr_on;
  orv64_vaddr_t             vp2_u__s2b_cfg_rst_pc;
  wire                      vp2_u__s2b_cfg_sleep;
  wire                      vp2_u__s2b_debug_resume;
  wire                      vp2_u__s2b_debug_stall;
  wire                      vp2_u__s2b_early_rstn;
  wire                      vp2_u__s2b_en_bp_if_pc_0;
  wire                      vp2_u__s2b_en_bp_if_pc_1;
  wire                      vp2_u__s2b_en_bp_if_pc_2;
  wire                      vp2_u__s2b_en_bp_if_pc_3;
  wire                      vp2_u__s2b_en_bp_instret;
  wire                      vp2_u__s2b_en_bp_wb_pc_0;
  wire                      vp2_u__s2b_en_bp_wb_pc_1;
  wire                      vp2_u__s2b_en_bp_wb_pc_2;
  wire                      vp2_u__s2b_en_bp_wb_pc_3;
  wire                      vp2_u__s2b_ext_event;
  powerline_ctrl_t          vp2_u__s2b_powerline_ctrl;
  powervbank_ctrl_t         vp2_u__s2b_powervbank_ctrl;
  wire                      vp2_u__s2b_rstn;
  wire                      vp2_u__s2b_vcore_en;
  orv_vcore_icg_disable_t   vp2_u__s2b_vcore_icg_disable;
  wire                      vp2_u__s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp2_u__s2b_vcore_pmu_evt_mask;
  wire                      vp2_u__software_int;
  oursring_req_if_ar_t      vp2_u__sysbus_req_if_ar;
  wire                      vp2_u__sysbus_req_if_arready;
  wire                      vp2_u__sysbus_req_if_arvalid;
  oursring_req_if_aw_t      vp2_u__sysbus_req_if_aw;
  wire                      vp2_u__sysbus_req_if_awready;
  wire                      vp2_u__sysbus_req_if_awvalid;
  oursring_req_if_w_t       vp2_u__sysbus_req_if_w;
  wire                      vp2_u__sysbus_req_if_wready;
  wire                      vp2_u__sysbus_req_if_wvalid;
  oursring_resp_if_b_t      vp2_u__sysbus_resp_if_b;
  wire                      vp2_u__sysbus_resp_if_bready;
  wire                      vp2_u__sysbus_resp_if_bvalid;
  oursring_resp_if_r_t      vp2_u__sysbus_resp_if_r;
  wire                      vp2_u__sysbus_resp_if_rready;
  wire                      vp2_u__sysbus_resp_if_rvalid;
  wire                      vp2_u__timer_int;
  wire                      vp2_u__wfe_stall;
  wire                      vp2_u__wfi_stall;
  wire                      vp2_vlsu_int_and_u__in0;
  wire                      vp2_vlsu_int_and_u__in1;
  wire                      vp2_vlsu_int_and_u__out;
  wire                      vp3_cpunoc_amoreq_valid_and_u__in0;
  wire                      vp3_cpunoc_amoreq_valid_and_u__in1;
  wire                      vp3_cpunoc_amoreq_valid_and_u__out;
  wire                      vp3_cpunoc_req_valid_and_u__in0;
  wire                      vp3_cpunoc_req_valid_and_u__in1;
  wire                      vp3_cpunoc_req_valid_and_u__out;
  wire                      vp3_icg_u__clk;
  wire                      vp3_icg_u__clkg;
  wire                      vp3_icg_u__en;
  wire                      vp3_icg_u__tst_en;
  wire[0:0]                 vp3_iso_or_u__in_0;
  wire[0:0]                 vp3_iso_or_u__in_1;
  wire[0:0]                 vp3_iso_or_u__out;
  wire                      vp3_ring_bvalid_and_u__in0;
  wire                      vp3_ring_bvalid_and_u__in1;
  wire                      vp3_ring_bvalid_and_u__out;
  wire                      vp3_ring_rvalid_and_u__in0;
  wire                      vp3_ring_rvalid_and_u__in1;
  wire                      vp3_ring_rvalid_and_u__out;
  wire                      vp3_rstn_sync_u__clk;
  wire                      vp3_rstn_sync_u__rstn_in;
  wire                      vp3_rstn_sync_u__rstn_out;
  wire                      vp3_rstn_sync_u__scan_en;
  wire                      vp3_rstn_sync_u__scan_rstn;
  wire[0:0]                 vp3_scan_reset_u__in_0;
  wire[0:0]                 vp3_scan_reset_u__in_1;
  wire[0:0]                 vp3_scan_reset_u__out;
  `ifdef IFNDEF_SINGLE_VP
  wire                      vp3_station_u__clk;
  oursring_req_if_ar_t      vp3_station_u__i_req_local_if_ar;
  wire                      vp3_station_u__i_req_local_if_arready;
  wire                      vp3_station_u__i_req_local_if_arvalid;
  oursring_req_if_aw_t      vp3_station_u__i_req_local_if_aw;
  wire                      vp3_station_u__i_req_local_if_awready;
  wire                      vp3_station_u__i_req_local_if_awvalid;
  oursring_req_if_w_t       vp3_station_u__i_req_local_if_w;
  wire                      vp3_station_u__i_req_local_if_wready;
  wire                      vp3_station_u__i_req_local_if_wvalid;
  oursring_req_if_ar_t      vp3_station_u__i_req_ring_if_ar;
  wire                      vp3_station_u__i_req_ring_if_arready;
  wire                      vp3_station_u__i_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp3_station_u__i_req_ring_if_aw;
  wire                      vp3_station_u__i_req_ring_if_awready;
  wire                      vp3_station_u__i_req_ring_if_awvalid;
  oursring_req_if_w_t       vp3_station_u__i_req_ring_if_w;
  wire                      vp3_station_u__i_req_ring_if_wready;
  wire                      vp3_station_u__i_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp3_station_u__i_resp_local_if_b;
  wire                      vp3_station_u__i_resp_local_if_bready;
  wire                      vp3_station_u__i_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp3_station_u__i_resp_local_if_r;
  wire                      vp3_station_u__i_resp_local_if_rready;
  wire                      vp3_station_u__i_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp3_station_u__i_resp_ring_if_b;
  wire                      vp3_station_u__i_resp_ring_if_bready;
  wire                      vp3_station_u__i_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp3_station_u__i_resp_ring_if_r;
  wire                      vp3_station_u__i_resp_ring_if_rready;
  wire                      vp3_station_u__i_resp_ring_if_rvalid;
  wire                      vp3_station_u__in_b2s_debug_stall_out;
  wire                      vp3_station_u__in_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp3_station_u__in_b2s_itb_last_ptr;
  wire                      vp3_station_u__in_b2s_vload_drt_req_vlen_illegal;
  oursring_req_if_ar_t      vp3_station_u__o_req_local_if_ar;
  wire                      vp3_station_u__o_req_local_if_arready;
  wire                      vp3_station_u__o_req_local_if_arvalid;
  oursring_req_if_aw_t      vp3_station_u__o_req_local_if_aw;
  wire                      vp3_station_u__o_req_local_if_awready;
  wire                      vp3_station_u__o_req_local_if_awvalid;
  oursring_req_if_w_t       vp3_station_u__o_req_local_if_w;
  wire                      vp3_station_u__o_req_local_if_wready;
  wire                      vp3_station_u__o_req_local_if_wvalid;
  oursring_req_if_ar_t      vp3_station_u__o_req_ring_if_ar;
  wire                      vp3_station_u__o_req_ring_if_arready;
  wire                      vp3_station_u__o_req_ring_if_arvalid;
  oursring_req_if_aw_t      vp3_station_u__o_req_ring_if_aw;
  wire                      vp3_station_u__o_req_ring_if_awready;
  wire                      vp3_station_u__o_req_ring_if_awvalid;
  oursring_req_if_w_t       vp3_station_u__o_req_ring_if_w;
  wire                      vp3_station_u__o_req_ring_if_wready;
  wire                      vp3_station_u__o_req_ring_if_wvalid;
  oursring_resp_if_b_t      vp3_station_u__o_resp_local_if_b;
  wire                      vp3_station_u__o_resp_local_if_bready;
  wire                      vp3_station_u__o_resp_local_if_bvalid;
  oursring_resp_if_r_t      vp3_station_u__o_resp_local_if_r;
  wire                      vp3_station_u__o_resp_local_if_rready;
  wire                      vp3_station_u__o_resp_local_if_rvalid;
  oursring_resp_if_b_t      vp3_station_u__o_resp_ring_if_b;
  wire                      vp3_station_u__o_resp_ring_if_bready;
  wire                      vp3_station_u__o_resp_ring_if_bvalid;
  oursring_resp_if_r_t      vp3_station_u__o_resp_ring_if_r;
  wire                      vp3_station_u__o_resp_ring_if_rready;
  wire                      vp3_station_u__o_resp_ring_if_rvalid;
  wire                      vp3_station_u__out_b2s_debug_stall_out;
  wire                      vp3_station_u__out_b2s_is_vtlb_excp;
  orv64_itb_addr_t          vp3_station_u__out_b2s_itb_last_ptr;
  wire                      vp3_station_u__out_b2s_vload_drt_req_vlen_illegal;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_if_pc_0;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_if_pc_1;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_if_pc_2;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_if_pc_3;
  orv64_data_t              vp3_station_u__out_s2b_bp_instret;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp3_station_u__out_s2b_bp_wb_pc_3;
  wire                      vp3_station_u__out_s2b_cfg_bypass_ic;
  wire                      vp3_station_u__out_s2b_cfg_bypass_tlb;
  wire                      vp3_station_u__out_s2b_cfg_en_hpmcounter;
  wire                      vp3_station_u__out_s2b_cfg_itb_en;
  orv64_itb_sel_t           vp3_station_u__out_s2b_cfg_itb_sel;
  wire                      vp3_station_u__out_s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp3_station_u__out_s2b_cfg_lfsr_seed;
  wire                      vp3_station_u__out_s2b_cfg_pwr_on;
  orv64_vaddr_t             vp3_station_u__out_s2b_cfg_rst_pc;
  wire                      vp3_station_u__out_s2b_cfg_sleep;
  wire                      vp3_station_u__out_s2b_debug_resume;
  wire                      vp3_station_u__out_s2b_debug_stall;
  wire                      vp3_station_u__out_s2b_early_rstn;
  wire                      vp3_station_u__out_s2b_en_bp_if_pc_0;
  wire                      vp3_station_u__out_s2b_en_bp_if_pc_1;
  wire                      vp3_station_u__out_s2b_en_bp_if_pc_2;
  wire                      vp3_station_u__out_s2b_en_bp_if_pc_3;
  wire                      vp3_station_u__out_s2b_en_bp_instret;
  wire                      vp3_station_u__out_s2b_en_bp_wb_pc_0;
  wire                      vp3_station_u__out_s2b_en_bp_wb_pc_1;
  wire                      vp3_station_u__out_s2b_en_bp_wb_pc_2;
  wire                      vp3_station_u__out_s2b_en_bp_wb_pc_3;
  wire                      vp3_station_u__out_s2b_ext_event;
  powerline_ctrl_t          vp3_station_u__out_s2b_powerline_ctrl;
  powervbank_ctrl_t         vp3_station_u__out_s2b_powervbank_ctrl;
  wire                      vp3_station_u__out_s2b_rstn;
  wire                      vp3_station_u__out_s2b_vcore_en;
  orv_vcore_icg_disable_t   vp3_station_u__out_s2b_vcore_icg_disable;
  wire                      vp3_station_u__out_s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp3_station_u__out_s2b_vcore_pmu_evt_mask;
  wire                      vp3_station_u__out_s2icg_clk_en;
  wire                      vp3_station_u__rstn;
  wire                      vp3_station_u__vld_in_b2s_debug_stall_out;
  wire                      vp3_station_u__vld_in_b2s_is_vtlb_excp;
  wire                      vp3_station_u__vld_in_b2s_itb_last_ptr;
  wire                      vp3_station_u__vld_in_b2s_vload_drt_req_vlen_illegal;
  `endif
  wire                      vp3_sysbus_arvalid_and_u__in0;
  wire                      vp3_sysbus_arvalid_and_u__in1;
  wire                      vp3_sysbus_arvalid_and_u__out;
  wire                      vp3_sysbus_awvalid_and_u__in0;
  wire                      vp3_sysbus_awvalid_and_u__in1;
  wire                      vp3_sysbus_awvalid_and_u__out;
  wire                      vp3_sysbus_wvalid_and_u__in0;
  wire                      vp3_sysbus_wvalid_and_u__in1;
  wire                      vp3_sysbus_wvalid_and_u__out;
  wire                      vp3_u__b2s_debug_stall_out;
  orv64_itb_addr_t          vp3_u__b2s_itb_last_ptr;
  wire                      vp3_u__b2s_vload_drt_req_vlen_illegal;
  cpu_cache_if_req_t        vp3_u__cache_req_if_req;
  wire                      vp3_u__cache_req_if_req_ready;
  wire                      vp3_u__cache_req_if_req_valid;
  cpu_cache_if_resp_t       vp3_u__cache_resp_if_resp;
  wire                      vp3_u__cache_resp_if_resp_ready;
  wire                      vp3_u__cache_resp_if_resp_valid;
  wire                      vp3_u__clk;
  wire[7:0]                 vp3_u__core_id;
  cpu_cache_if_req_t        vp3_u__cpu_amo_store_req;
  wire                      vp3_u__cpu_amo_store_req_ready;
  wire                      vp3_u__cpu_amo_store_req_valid;
  wire                      vp3_u__external_int;
  wire                      vp3_u__load_vtlb_excp;
  oursring_req_if_ar_t      vp3_u__ring_req_if_ar;
  wire                      vp3_u__ring_req_if_arready;
  wire                      vp3_u__ring_req_if_arvalid;
  oursring_req_if_aw_t      vp3_u__ring_req_if_aw;
  wire                      vp3_u__ring_req_if_awready;
  wire                      vp3_u__ring_req_if_awvalid;
  oursring_req_if_w_t       vp3_u__ring_req_if_w;
  wire                      vp3_u__ring_req_if_wready;
  wire                      vp3_u__ring_req_if_wvalid;
  oursring_resp_if_b_t      vp3_u__ring_resp_if_b;
  wire                      vp3_u__ring_resp_if_bready;
  wire                      vp3_u__ring_resp_if_bvalid;
  oursring_resp_if_r_t      vp3_u__ring_resp_if_r;
  wire                      vp3_u__ring_resp_if_rready;
  wire                      vp3_u__ring_resp_if_rvalid;
  orv64_vaddr_t             vp3_u__s2b_bp_if_pc_0;
  orv64_vaddr_t             vp3_u__s2b_bp_if_pc_1;
  orv64_vaddr_t             vp3_u__s2b_bp_if_pc_2;
  orv64_vaddr_t             vp3_u__s2b_bp_if_pc_3;
  orv64_data_t              vp3_u__s2b_bp_instret;
  orv64_vaddr_t             vp3_u__s2b_bp_wb_pc_0;
  orv64_vaddr_t             vp3_u__s2b_bp_wb_pc_1;
  orv64_vaddr_t             vp3_u__s2b_bp_wb_pc_2;
  orv64_vaddr_t             vp3_u__s2b_bp_wb_pc_3;
  wire                      vp3_u__s2b_cfg_bypass_ic;
  wire                      vp3_u__s2b_cfg_bypass_tlb;
  wire                      vp3_u__s2b_cfg_en_hpmcounter;
  wire                      vp3_u__s2b_cfg_itb_en;
  orv64_itb_sel_t           vp3_u__s2b_cfg_itb_sel;
  wire                      vp3_u__s2b_cfg_itb_wrap_around;
  wire[5:0]                 vp3_u__s2b_cfg_lfsr_seed;
  wire                      vp3_u__s2b_cfg_pwr_on;
  orv64_vaddr_t             vp3_u__s2b_cfg_rst_pc;
  wire                      vp3_u__s2b_cfg_sleep;
  wire                      vp3_u__s2b_debug_resume;
  wire                      vp3_u__s2b_debug_stall;
  wire                      vp3_u__s2b_early_rstn;
  wire                      vp3_u__s2b_en_bp_if_pc_0;
  wire                      vp3_u__s2b_en_bp_if_pc_1;
  wire                      vp3_u__s2b_en_bp_if_pc_2;
  wire                      vp3_u__s2b_en_bp_if_pc_3;
  wire                      vp3_u__s2b_en_bp_instret;
  wire                      vp3_u__s2b_en_bp_wb_pc_0;
  wire                      vp3_u__s2b_en_bp_wb_pc_1;
  wire                      vp3_u__s2b_en_bp_wb_pc_2;
  wire                      vp3_u__s2b_en_bp_wb_pc_3;
  wire                      vp3_u__s2b_ext_event;
  powerline_ctrl_t          vp3_u__s2b_powerline_ctrl;
  powervbank_ctrl_t         vp3_u__s2b_powervbank_ctrl;
  wire                      vp3_u__s2b_rstn;
  wire                      vp3_u__s2b_vcore_en;
  orv_vcore_icg_disable_t   vp3_u__s2b_vcore_icg_disable;
  wire                      vp3_u__s2b_vcore_pmu_en;
  vcore_pmu_evt_mask_t      vp3_u__s2b_vcore_pmu_evt_mask;
  wire                      vp3_u__software_int;
  oursring_req_if_ar_t      vp3_u__sysbus_req_if_ar;
  wire                      vp3_u__sysbus_req_if_arready;
  wire                      vp3_u__sysbus_req_if_arvalid;
  oursring_req_if_aw_t      vp3_u__sysbus_req_if_aw;
  wire                      vp3_u__sysbus_req_if_awready;
  wire                      vp3_u__sysbus_req_if_awvalid;
  oursring_req_if_w_t       vp3_u__sysbus_req_if_w;
  wire                      vp3_u__sysbus_req_if_wready;
  wire                      vp3_u__sysbus_req_if_wvalid;
  oursring_resp_if_b_t      vp3_u__sysbus_resp_if_b;
  wire                      vp3_u__sysbus_resp_if_bready;
  wire                      vp3_u__sysbus_resp_if_bvalid;
  oursring_resp_if_r_t      vp3_u__sysbus_resp_if_r;
  wire                      vp3_u__sysbus_resp_if_rready;
  wire                      vp3_u__sysbus_resp_if_rvalid;
  wire                      vp3_u__timer_int;
  wire                      vp3_u__wfe_stall;
  wire                      vp3_u__wfi_stall;
  wire                      vp3_vlsu_int_and_u__in0;
  wire                      vp3_vlsu_int_and_u__in1;
  wire                      vp3_vlsu_int_and_u__out;

  // bank0_da_u/clk <-> bank0_icg_u/clkg
  assign bank0_da_u__clk                                            = bank0_icg_u__clkg;

  // bank0_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank0_icg_u__clk                                           = dft_pllclk_clk_buf_u0__out;

  // bank0_icg_u/en <-> bank0_station_u/out_s2icg_clk_en
  assign bank0_icg_u__en                                            = bank0_station_u__out_s2icg_clk_en;

  // bank0_icg_u/rstn <-> soc_top/chip_resetn
  assign bank0_icg_u__rstn                                          = soc_top__chip_resetn;

  // bank0_icg_u/tst_en <-> 'b0
  assign bank0_icg_u__tst_en                                        = {{($bits(bank0_icg_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // bank0_station_u.i_req_local_if <-> jtag2or_u.or_req_if
  assign bank0_station_u__i_req_local_if_ar                         = jtag2or_u__or_req_if_ar;
  assign bank0_station_u__i_req_local_if_arvalid                    = jtag2or_u__or_req_if_arvalid;
  assign bank0_station_u__i_req_local_if_aw                         = jtag2or_u__or_req_if_aw;
  assign bank0_station_u__i_req_local_if_awvalid                    = jtag2or_u__or_req_if_awvalid;
  assign bank0_station_u__i_req_local_if_w                          = jtag2or_u__or_req_if_w;
  assign bank0_station_u__i_req_local_if_wvalid                     = jtag2or_u__or_req_if_wvalid;
  assign jtag2or_u__or_req_if_arready                               = bank0_station_u__i_req_local_if_arready;
  assign jtag2or_u__or_req_if_awready                               = bank0_station_u__i_req_local_if_awready;
  assign jtag2or_u__or_req_if_wready                                = bank0_station_u__i_req_local_if_wready;
  `endif

  // bank0_station_u.i_resp_local_if <-> bank0_da_u.ring_resp_if
  assign bank0_da_u__ring_resp_if_bready                            = bank0_station_u__i_resp_local_if_bready;
  assign bank0_da_u__ring_resp_if_rready                            = bank0_station_u__i_resp_local_if_rready;
  assign bank0_station_u__i_resp_local_if_b                         = bank0_da_u__ring_resp_if_b;
  assign bank0_station_u__i_resp_local_if_bvalid                    = bank0_da_u__ring_resp_if_bvalid;
  assign bank0_station_u__i_resp_local_if_r                         = bank0_da_u__ring_resp_if_r;
  assign bank0_station_u__i_resp_local_if_rvalid                    = bank0_da_u__ring_resp_if_rvalid;

  // bank0_station_u.i_resp_ring_if <-> bank1_station_u.o_resp_ring_if
  assign bank0_station_u__i_resp_ring_if_b                          = bank1_station_u__o_resp_ring_if_b;
  assign bank0_station_u__i_resp_ring_if_bvalid                     = bank1_station_u__o_resp_ring_if_bvalid;
  assign bank0_station_u__i_resp_ring_if_r                          = bank1_station_u__o_resp_ring_if_r;
  assign bank0_station_u__i_resp_ring_if_rvalid                     = bank1_station_u__o_resp_ring_if_rvalid;
  assign bank1_station_u__o_resp_ring_if_bready                     = bank0_station_u__i_resp_ring_if_bready;
  assign bank1_station_u__o_resp_ring_if_rready                     = bank0_station_u__i_resp_ring_if_rready;

  // bank0_station_u.o_req_local_if <-> bank0_da_u.ring_req_if
  assign bank0_da_u__ring_req_if_ar                                 = bank0_station_u__o_req_local_if_ar;
  assign bank0_da_u__ring_req_if_arvalid                            = bank0_station_u__o_req_local_if_arvalid;
  assign bank0_da_u__ring_req_if_aw                                 = bank0_station_u__o_req_local_if_aw;
  assign bank0_da_u__ring_req_if_awvalid                            = bank0_station_u__o_req_local_if_awvalid;
  assign bank0_da_u__ring_req_if_w                                  = bank0_station_u__o_req_local_if_w;
  assign bank0_da_u__ring_req_if_wvalid                             = bank0_station_u__o_req_local_if_wvalid;
  assign bank0_station_u__o_req_local_if_arready                    = bank0_da_u__ring_req_if_arready;
  assign bank0_station_u__o_req_local_if_awready                    = bank0_da_u__ring_req_if_awready;
  assign bank0_station_u__o_req_local_if_wready                     = bank0_da_u__ring_req_if_wready;

  // bank0_station_u.o_req_ring_if <-> bank1_station_u.i_req_ring_if
  assign bank0_station_u__o_req_ring_if_arready                     = bank1_station_u__i_req_ring_if_arready;
  assign bank0_station_u__o_req_ring_if_awready                     = bank1_station_u__i_req_ring_if_awready;
  assign bank0_station_u__o_req_ring_if_wready                      = bank1_station_u__i_req_ring_if_wready;
  assign bank1_station_u__i_req_ring_if_ar                          = bank0_station_u__o_req_ring_if_ar;
  assign bank1_station_u__i_req_ring_if_arvalid                     = bank0_station_u__o_req_ring_if_arvalid;
  assign bank1_station_u__i_req_ring_if_aw                          = bank0_station_u__o_req_ring_if_aw;
  assign bank1_station_u__i_req_ring_if_awvalid                     = bank0_station_u__o_req_ring_if_awvalid;
  assign bank1_station_u__i_req_ring_if_w                           = bank0_station_u__o_req_ring_if_w;
  assign bank1_station_u__i_req_ring_if_wvalid                      = bank0_station_u__o_req_ring_if_wvalid;

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // bank0_station_u.o_resp_local_if <-> jtag2or_u.or_rsp_if
  assign bank0_station_u__o_resp_local_if_bready                    = jtag2or_u__or_rsp_if_bready;
  assign bank0_station_u__o_resp_local_if_rready                    = jtag2or_u__or_rsp_if_rready;
  assign jtag2or_u__or_rsp_if_b                                     = bank0_station_u__o_resp_local_if_b;
  assign jtag2or_u__or_rsp_if_bvalid                                = bank0_station_u__o_resp_local_if_bvalid;
  assign jtag2or_u__or_rsp_if_r                                     = bank0_station_u__o_resp_local_if_r;
  assign jtag2or_u__or_rsp_if_rvalid                                = bank0_station_u__o_resp_local_if_rvalid;
  `endif

  // bank0_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank0_station_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // bank0_station_u/rstn <-> bank0_rstn_sync_u/rstn_out
  assign bank0_station_u__rstn                                      = bank0_rstn_sync_u__rstn_out;

  // bank0_u.cpu_l2_req_if <-> cpu_noc_u.noc_l2[0]
  assign bank0_u__cpu_l2_req_if_req                                 = cpu_noc_u__noc_l2_req[0];
  assign bank0_u__cpu_l2_req_if_req_valid                           = cpu_noc_u__noc_l2_req_valid[0];
  assign cpu_noc_u__noc_l2_req_ready[0]                             = bank0_u__cpu_l2_req_if_req_ready;

  // bank0_u.cpu_l2_resp_if <-> cpu_noc_u.l2_noc[0]
  assign bank0_u__cpu_l2_resp_if_resp_ready                         = cpu_noc_u__l2_noc_resp_ready[0];
  assign cpu_noc_u__l2_noc_resp[0]                                  = bank0_u__cpu_l2_resp_if_resp;
  assign cpu_noc_u__l2_noc_resp_valid[0]                            = bank0_u__cpu_l2_resp_if_resp_valid;

  // bank0_u.debug <-> bank0_da_u.debug
  assign bank0_da_u__debug_rdata                                    = bank0_u__debug_rdata;
  assign bank0_da_u__debug_ready                                    = bank0_u__debug_ready;
  assign bank0_u__debug_addr                                        = bank0_da_u__debug_addr;
  assign bank0_u__debug_data_ram_en_pway                            = bank0_da_u__debug_data_ram_en_pway;
  assign bank0_u__debug_dirty_ram_en                                = bank0_da_u__debug_dirty_ram_en;
  assign bank0_u__debug_en                                          = bank0_da_u__debug_en;
  assign bank0_u__debug_hpmcounter_en                               = bank0_da_u__debug_hpmcounter_en;
  assign bank0_u__debug_lru_ram_en                                  = bank0_da_u__debug_lru_ram_en;
  assign bank0_u__debug_rw                                          = bank0_da_u__debug_rw;
  assign bank0_u__debug_tag_ram_en_pway                             = bank0_da_u__debug_tag_ram_en_pway;
  assign bank0_u__debug_valid_dirty_bit_mask                        = bank0_da_u__debug_valid_dirty_bit_mask;
  assign bank0_u__debug_valid_ram_en                                = bank0_da_u__debug_valid_ram_en;
  assign bank0_u__debug_wdata                                       = bank0_da_u__debug_wdata;
  assign bank0_u__debug_wdata_byte_mask                             = bank0_da_u__debug_wdata_byte_mask;

  // bank0_u.l2_amo_store <-> cpu_noc_u.l2_amo_store[0]
  assign bank0_u__l2_amo_store_req                                  = cpu_noc_u__l2_amo_store_req[0];
  assign bank0_u__l2_amo_store_req_valid                            = cpu_noc_u__l2_amo_store_req_valid[0];
  assign cpu_noc_u__l2_amo_store_req_ready[0]                       = bank0_u__l2_amo_store_req_ready;

  `ifndef IFNDEF_TB_USE_MEM_NOC
  // bank0_u.l2_req_if <-> 'b0
  assign bank0_u__l2_req_if_arready                                 = {{($bits(bank0_u__l2_req_if_arready)-1){1'b0}}, 1'b0};
  assign bank0_u__l2_req_if_awready                                 = {{($bits(bank0_u__l2_req_if_awready)-1){1'b0}}, 1'b0};
  assign bank0_u__l2_req_if_wready                                  = {{($bits(bank0_u__l2_req_if_wready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_MEM_NOC
  // bank0_u.l2_req_if <-> mem_noc_u.l2_req_if[0]
  assign bank0_u__l2_req_if_arready                                 = mem_noc_u__l2_req_if_arready[0];
  assign bank0_u__l2_req_if_awready                                 = mem_noc_u__l2_req_if_awready[0];
  assign bank0_u__l2_req_if_wready                                  = mem_noc_u__l2_req_if_wready[0];
  assign mem_noc_u__l2_req_if_ar[0]                                 = bank0_u__l2_req_if_ar;
  assign mem_noc_u__l2_req_if_arvalid[0]                            = bank0_u__l2_req_if_arvalid;
  assign mem_noc_u__l2_req_if_aw[0]                                 = bank0_u__l2_req_if_aw;
  assign mem_noc_u__l2_req_if_awvalid[0]                            = bank0_u__l2_req_if_awvalid;
  assign mem_noc_u__l2_req_if_w[0]                                  = bank0_u__l2_req_if_w;
  assign mem_noc_u__l2_req_if_wvalid[0]                             = bank0_u__l2_req_if_wvalid;
  `endif

  `ifndef IFNDEF_TB_USE_MEM_NOC
  // bank0_u.l2_resp_if <-> 'b0
  assign bank0_u__l2_resp_if_b                                      = {{($bits(bank0_u__l2_resp_if_b)-1){1'b0}}, 1'b0};
  assign bank0_u__l2_resp_if_bvalid                                 = {{($bits(bank0_u__l2_resp_if_bvalid)-1){1'b0}}, 1'b0};
  assign bank0_u__l2_resp_if_r                                      = {{($bits(bank0_u__l2_resp_if_r)-1){1'b0}}, 1'b0};
  assign bank0_u__l2_resp_if_rvalid                                 = {{($bits(bank0_u__l2_resp_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_MEM_NOC
  // bank0_u.l2_resp_if <-> mem_noc_u.l2_resp_if[0]
  assign bank0_u__l2_resp_if_b                                      = mem_noc_u__l2_resp_if_b[0];
  assign bank0_u__l2_resp_if_bvalid                                 = mem_noc_u__l2_resp_if_bvalid[0];
  assign bank0_u__l2_resp_if_r                                      = mem_noc_u__l2_resp_if_r[0];
  assign bank0_u__l2_resp_if_rvalid                                 = mem_noc_u__l2_resp_if_rvalid[0];
  assign mem_noc_u__l2_resp_if_bready[0]                            = bank0_u__l2_resp_if_bready;
  assign mem_noc_u__l2_resp_if_rready[0]                            = bank0_u__l2_resp_if_rready;
  `endif

  // bank0_u.s2b <-> bank0_station_u.out_s2b
  assign bank0_u__s2b_ctrl_reg                                      = bank0_station_u__out_s2b_ctrl_reg;
  assign bank0_u__s2b_icg_disable                                   = bank0_station_u__out_s2b_icg_disable;

  // bank0_u/clk <-> bank0_icg_u/clkg
  assign bank0_u__clk                                               = bank0_icg_u__clkg;

  // bank0_u/mem_barrier_clr_pbank_in[0] <-> bank1_u/mem_barrier_clr_pbank_out[0]
  assign bank0_u__mem_barrier_clr_pbank_in[0]                       = bank1_u__mem_barrier_clr_pbank_out[0];

  `ifdef IFDEF_SOC_NO_BANK2
  // bank0_u/mem_barrier_clr_pbank_in[1] <-> 'b0
  assign bank0_u__mem_barrier_clr_pbank_in[1]                       = {{($bits(bank0_u__mem_barrier_clr_pbank_in[1])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank0_u/mem_barrier_clr_pbank_in[1] <-> bank2_u/mem_barrier_clr_pbank_out[0]
  assign bank0_u__mem_barrier_clr_pbank_in[1]                       = bank2_u__mem_barrier_clr_pbank_out[0];
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // bank0_u/mem_barrier_clr_pbank_in[2] <-> 'b0
  assign bank0_u__mem_barrier_clr_pbank_in[2]                       = {{($bits(bank0_u__mem_barrier_clr_pbank_in[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank0_u/mem_barrier_clr_pbank_in[2] <-> bank3_u/mem_barrier_clr_pbank_out[0]
  assign bank0_u__mem_barrier_clr_pbank_in[2]                       = bank3_u__mem_barrier_clr_pbank_out[0];
  `endif

  // bank0_u/mem_barrier_status_in[0] <-> bank1_u/mem_barrier_status_out
  assign bank0_u__mem_barrier_status_in[0]                          = bank1_u__mem_barrier_status_out;

  `ifdef IFDEF_SOC_NO_BANK2
  // bank0_u/mem_barrier_status_in[1] <-> 'b1
  assign bank0_u__mem_barrier_status_in[1]                          = {{($bits(bank0_u__mem_barrier_status_in[1])-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank0_u/mem_barrier_status_in[1] <-> bank2_u/mem_barrier_status_out
  assign bank0_u__mem_barrier_status_in[1]                          = bank2_u__mem_barrier_status_out;
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // bank0_u/mem_barrier_status_in[2] <-> 'b1
  assign bank0_u__mem_barrier_status_in[2]                          = {{($bits(bank0_u__mem_barrier_status_in[2])-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank0_u/mem_barrier_status_in[2] <-> bank3_u/mem_barrier_status_out
  assign bank0_u__mem_barrier_status_in[2]                          = bank3_u__mem_barrier_status_out;
  `endif

  // bank0_u/scan_mode <-> soc_top/dft_mode
  assign bank0_u__scan_mode                                         = soc_top__dft_mode;

  // bank0_u/tst_en <-> 'b0
  assign bank0_u__tst_en                                            = {{($bits(bank0_u__tst_en)-1){1'b0}}, 1'b0};

  // bank1_da_u/clk <-> bank1_icg_u/clkg
  assign bank1_da_u__clk                                            = bank1_icg_u__clkg;

  // bank1_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank1_icg_u__clk                                           = dft_pllclk_clk_buf_u0__out;

  // bank1_icg_u/en <-> bank1_station_u/out_s2icg_clk_en
  assign bank1_icg_u__en                                            = bank1_station_u__out_s2icg_clk_en;

  // bank1_icg_u/rstn <-> soc_top/chip_resetn
  assign bank1_icg_u__rstn                                          = soc_top__chip_resetn;

  // bank1_icg_u/tst_en <-> 'b0
  assign bank1_icg_u__tst_en                                        = {{($bits(bank1_icg_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // bank1_station_u.i_req_local_if <-> 'b0
  assign bank1_station_u__i_req_local_if_ar                         = {{($bits(bank1_station_u__i_req_local_if_ar)-1){1'b0}}, 1'b0};
  assign bank1_station_u__i_req_local_if_arvalid                    = {{($bits(bank1_station_u__i_req_local_if_arvalid)-1){1'b0}}, 1'b0};
  assign bank1_station_u__i_req_local_if_aw                         = {{($bits(bank1_station_u__i_req_local_if_aw)-1){1'b0}}, 1'b0};
  assign bank1_station_u__i_req_local_if_awvalid                    = {{($bits(bank1_station_u__i_req_local_if_awvalid)-1){1'b0}}, 1'b0};
  assign bank1_station_u__i_req_local_if_w                          = {{($bits(bank1_station_u__i_req_local_if_w)-1){1'b0}}, 1'b0};
  assign bank1_station_u__i_req_local_if_wvalid                     = {{($bits(bank1_station_u__i_req_local_if_wvalid)-1){1'b0}}, 1'b0};
  `endif

  // bank1_station_u.i_resp_local_if <-> bank1_da_u.ring_resp_if
  assign bank1_da_u__ring_resp_if_bready                            = bank1_station_u__i_resp_local_if_bready;
  assign bank1_da_u__ring_resp_if_rready                            = bank1_station_u__i_resp_local_if_rready;
  assign bank1_station_u__i_resp_local_if_b                         = bank1_da_u__ring_resp_if_b;
  assign bank1_station_u__i_resp_local_if_bvalid                    = bank1_da_u__ring_resp_if_bvalid;
  assign bank1_station_u__i_resp_local_if_r                         = bank1_da_u__ring_resp_if_r;
  assign bank1_station_u__i_resp_local_if_rvalid                    = bank1_da_u__ring_resp_if_rvalid;

  // bank1_station_u.i_resp_ring_if <-> dt_station_u.o_resp_ring_if
  assign bank1_station_u__i_resp_ring_if_b                          = dt_station_u__o_resp_ring_if_b;
  assign bank1_station_u__i_resp_ring_if_bvalid                     = dt_station_u__o_resp_ring_if_bvalid;
  assign bank1_station_u__i_resp_ring_if_r                          = dt_station_u__o_resp_ring_if_r;
  assign bank1_station_u__i_resp_ring_if_rvalid                     = dt_station_u__o_resp_ring_if_rvalid;
  assign dt_station_u__o_resp_ring_if_bready                        = bank1_station_u__i_resp_ring_if_bready;
  assign dt_station_u__o_resp_ring_if_rready                        = bank1_station_u__i_resp_ring_if_rready;

  // bank1_station_u.o_req_local_if <-> bank1_da_u.ring_req_if
  assign bank1_da_u__ring_req_if_ar                                 = bank1_station_u__o_req_local_if_ar;
  assign bank1_da_u__ring_req_if_arvalid                            = bank1_station_u__o_req_local_if_arvalid;
  assign bank1_da_u__ring_req_if_aw                                 = bank1_station_u__o_req_local_if_aw;
  assign bank1_da_u__ring_req_if_awvalid                            = bank1_station_u__o_req_local_if_awvalid;
  assign bank1_da_u__ring_req_if_w                                  = bank1_station_u__o_req_local_if_w;
  assign bank1_da_u__ring_req_if_wvalid                             = bank1_station_u__o_req_local_if_wvalid;
  assign bank1_station_u__o_req_local_if_arready                    = bank1_da_u__ring_req_if_arready;
  assign bank1_station_u__o_req_local_if_awready                    = bank1_da_u__ring_req_if_awready;
  assign bank1_station_u__o_req_local_if_wready                     = bank1_da_u__ring_req_if_wready;

  // bank1_station_u.o_req_ring_if <-> dt_station_u.i_req_ring_if
  assign bank1_station_u__o_req_ring_if_arready                     = dt_station_u__i_req_ring_if_arready;
  assign bank1_station_u__o_req_ring_if_awready                     = dt_station_u__i_req_ring_if_awready;
  assign bank1_station_u__o_req_ring_if_wready                      = dt_station_u__i_req_ring_if_wready;
  assign dt_station_u__i_req_ring_if_ar                             = bank1_station_u__o_req_ring_if_ar;
  assign dt_station_u__i_req_ring_if_arvalid                        = bank1_station_u__o_req_ring_if_arvalid;
  assign dt_station_u__i_req_ring_if_aw                             = bank1_station_u__o_req_ring_if_aw;
  assign dt_station_u__i_req_ring_if_awvalid                        = bank1_station_u__o_req_ring_if_awvalid;
  assign dt_station_u__i_req_ring_if_w                              = bank1_station_u__o_req_ring_if_w;
  assign dt_station_u__i_req_ring_if_wvalid                         = bank1_station_u__o_req_ring_if_wvalid;

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // bank1_station_u.o_resp_local_if <-> 'b0
  assign bank1_station_u__o_resp_local_if_bready                    = {{($bits(bank1_station_u__o_resp_local_if_bready)-1){1'b0}}, 1'b0};
  assign bank1_station_u__o_resp_local_if_rready                    = {{($bits(bank1_station_u__o_resp_local_if_rready)-1){1'b0}}, 1'b0};
  `endif

  // bank1_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank1_station_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // bank1_station_u/rstn <-> bank1_rstn_sync_u/rstn_out
  assign bank1_station_u__rstn                                      = bank1_rstn_sync_u__rstn_out;

  // bank1_u.cpu_l2_req_if <-> cpu_noc_u.noc_l2[1]
  assign bank1_u__cpu_l2_req_if_req                                 = cpu_noc_u__noc_l2_req[1];
  assign bank1_u__cpu_l2_req_if_req_valid                           = cpu_noc_u__noc_l2_req_valid[1];
  assign cpu_noc_u__noc_l2_req_ready[1]                             = bank1_u__cpu_l2_req_if_req_ready;

  // bank1_u.cpu_l2_resp_if <-> cpu_noc_u.l2_noc[1]
  assign bank1_u__cpu_l2_resp_if_resp_ready                         = cpu_noc_u__l2_noc_resp_ready[1];
  assign cpu_noc_u__l2_noc_resp[1]                                  = bank1_u__cpu_l2_resp_if_resp;
  assign cpu_noc_u__l2_noc_resp_valid[1]                            = bank1_u__cpu_l2_resp_if_resp_valid;

  // bank1_u.debug <-> bank1_da_u.debug
  assign bank1_da_u__debug_rdata                                    = bank1_u__debug_rdata;
  assign bank1_da_u__debug_ready                                    = bank1_u__debug_ready;
  assign bank1_u__debug_addr                                        = bank1_da_u__debug_addr;
  assign bank1_u__debug_data_ram_en_pway                            = bank1_da_u__debug_data_ram_en_pway;
  assign bank1_u__debug_dirty_ram_en                                = bank1_da_u__debug_dirty_ram_en;
  assign bank1_u__debug_en                                          = bank1_da_u__debug_en;
  assign bank1_u__debug_hpmcounter_en                               = bank1_da_u__debug_hpmcounter_en;
  assign bank1_u__debug_lru_ram_en                                  = bank1_da_u__debug_lru_ram_en;
  assign bank1_u__debug_rw                                          = bank1_da_u__debug_rw;
  assign bank1_u__debug_tag_ram_en_pway                             = bank1_da_u__debug_tag_ram_en_pway;
  assign bank1_u__debug_valid_dirty_bit_mask                        = bank1_da_u__debug_valid_dirty_bit_mask;
  assign bank1_u__debug_valid_ram_en                                = bank1_da_u__debug_valid_ram_en;
  assign bank1_u__debug_wdata                                       = bank1_da_u__debug_wdata;
  assign bank1_u__debug_wdata_byte_mask                             = bank1_da_u__debug_wdata_byte_mask;

  // bank1_u.l2_amo_store <-> cpu_noc_u.l2_amo_store[1]
  assign bank1_u__l2_amo_store_req                                  = cpu_noc_u__l2_amo_store_req[1];
  assign bank1_u__l2_amo_store_req_valid                            = cpu_noc_u__l2_amo_store_req_valid[1];
  assign cpu_noc_u__l2_amo_store_req_ready[1]                       = bank1_u__l2_amo_store_req_ready;

  `ifndef IFNDEF_TB_USE_MEM_NOC
  // bank1_u.l2_req_if <-> 'b0
  assign bank1_u__l2_req_if_arready                                 = {{($bits(bank1_u__l2_req_if_arready)-1){1'b0}}, 1'b0};
  assign bank1_u__l2_req_if_awready                                 = {{($bits(bank1_u__l2_req_if_awready)-1){1'b0}}, 1'b0};
  assign bank1_u__l2_req_if_wready                                  = {{($bits(bank1_u__l2_req_if_wready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_MEM_NOC
  // bank1_u.l2_req_if <-> mem_noc_u.l2_req_if[1]
  assign bank1_u__l2_req_if_arready                                 = mem_noc_u__l2_req_if_arready[1];
  assign bank1_u__l2_req_if_awready                                 = mem_noc_u__l2_req_if_awready[1];
  assign bank1_u__l2_req_if_wready                                  = mem_noc_u__l2_req_if_wready[1];
  assign mem_noc_u__l2_req_if_ar[1]                                 = bank1_u__l2_req_if_ar;
  assign mem_noc_u__l2_req_if_arvalid[1]                            = bank1_u__l2_req_if_arvalid;
  assign mem_noc_u__l2_req_if_aw[1]                                 = bank1_u__l2_req_if_aw;
  assign mem_noc_u__l2_req_if_awvalid[1]                            = bank1_u__l2_req_if_awvalid;
  assign mem_noc_u__l2_req_if_w[1]                                  = bank1_u__l2_req_if_w;
  assign mem_noc_u__l2_req_if_wvalid[1]                             = bank1_u__l2_req_if_wvalid;
  `endif

  `ifndef IFNDEF_TB_USE_MEM_NOC
  // bank1_u.l2_resp_if <-> 'b0
  assign bank1_u__l2_resp_if_b                                      = {{($bits(bank1_u__l2_resp_if_b)-1){1'b0}}, 1'b0};
  assign bank1_u__l2_resp_if_bvalid                                 = {{($bits(bank1_u__l2_resp_if_bvalid)-1){1'b0}}, 1'b0};
  assign bank1_u__l2_resp_if_r                                      = {{($bits(bank1_u__l2_resp_if_r)-1){1'b0}}, 1'b0};
  assign bank1_u__l2_resp_if_rvalid                                 = {{($bits(bank1_u__l2_resp_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_MEM_NOC
  // bank1_u.l2_resp_if <-> mem_noc_u.l2_resp_if[1]
  assign bank1_u__l2_resp_if_b                                      = mem_noc_u__l2_resp_if_b[1];
  assign bank1_u__l2_resp_if_bvalid                                 = mem_noc_u__l2_resp_if_bvalid[1];
  assign bank1_u__l2_resp_if_r                                      = mem_noc_u__l2_resp_if_r[1];
  assign bank1_u__l2_resp_if_rvalid                                 = mem_noc_u__l2_resp_if_rvalid[1];
  assign mem_noc_u__l2_resp_if_bready[1]                            = bank1_u__l2_resp_if_bready;
  assign mem_noc_u__l2_resp_if_rready[1]                            = bank1_u__l2_resp_if_rready;
  `endif

  // bank1_u.s2b <-> bank1_station_u.out_s2b
  assign bank1_u__s2b_ctrl_reg                                      = bank1_station_u__out_s2b_ctrl_reg;
  assign bank1_u__s2b_icg_disable                                   = bank1_station_u__out_s2b_icg_disable;

  // bank1_u/clk <-> bank1_icg_u/clkg
  assign bank1_u__clk                                               = bank1_icg_u__clkg;

  // bank1_u/mem_barrier_clr_pbank_in[0] <-> bank0_u/mem_barrier_clr_pbank_out[0]
  assign bank1_u__mem_barrier_clr_pbank_in[0]                       = bank0_u__mem_barrier_clr_pbank_out[0];

  `ifdef IFDEF_SOC_NO_BANK2
  // bank1_u/mem_barrier_clr_pbank_in[1] <-> 'b0
  assign bank1_u__mem_barrier_clr_pbank_in[1]                       = {{($bits(bank1_u__mem_barrier_clr_pbank_in[1])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank1_u/mem_barrier_clr_pbank_in[1] <-> bank2_u/mem_barrier_clr_pbank_out[1]
  assign bank1_u__mem_barrier_clr_pbank_in[1]                       = bank2_u__mem_barrier_clr_pbank_out[1];
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // bank1_u/mem_barrier_clr_pbank_in[2] <-> 'b0
  assign bank1_u__mem_barrier_clr_pbank_in[2]                       = {{($bits(bank1_u__mem_barrier_clr_pbank_in[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank1_u/mem_barrier_clr_pbank_in[2] <-> bank3_u/mem_barrier_clr_pbank_out[1]
  assign bank1_u__mem_barrier_clr_pbank_in[2]                       = bank3_u__mem_barrier_clr_pbank_out[1];
  `endif

  // bank1_u/mem_barrier_status_in[0] <-> bank0_u/mem_barrier_status_out
  assign bank1_u__mem_barrier_status_in[0]                          = bank0_u__mem_barrier_status_out;

  `ifdef IFDEF_SOC_NO_BANK2
  // bank1_u/mem_barrier_status_in[1] <-> 'b1
  assign bank1_u__mem_barrier_status_in[1]                          = {{($bits(bank1_u__mem_barrier_status_in[1])-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank1_u/mem_barrier_status_in[1] <-> bank2_u/mem_barrier_status_out
  assign bank1_u__mem_barrier_status_in[1]                          = bank2_u__mem_barrier_status_out;
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // bank1_u/mem_barrier_status_in[2] <-> 'b1
  assign bank1_u__mem_barrier_status_in[2]                          = {{($bits(bank1_u__mem_barrier_status_in[2])-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank1_u/mem_barrier_status_in[2] <-> bank3_u/mem_barrier_status_out
  assign bank1_u__mem_barrier_status_in[2]                          = bank3_u__mem_barrier_status_out;
  `endif

  // bank1_u/scan_mode <-> soc_top/dft_mode
  assign bank1_u__scan_mode                                         = soc_top__dft_mode;

  // bank1_u/tst_en <-> 'b0
  assign bank1_u__tst_en                                            = {{($bits(bank1_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_da_u/clk <-> bank2_icg_u/clkg
  assign bank2_da_u__clk                                            = bank2_icg_u__clkg;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank2_icg_u__clk                                           = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_icg_u/en <-> bank2_station_u/out_s2icg_clk_en
  assign bank2_icg_u__en                                            = bank2_station_u__out_s2icg_clk_en;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_icg_u/rstn <-> soc_top/chip_resetn
  assign bank2_icg_u__rstn                                          = soc_top__chip_resetn;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_icg_u/tst_en <-> 'b0
  assign bank2_icg_u__tst_en                                        = {{($bits(bank2_icg_u__tst_en)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2__IFNDEF_TB_TORTURE_OURSRING
  // bank2_station_u.i_req_local_if <-> 'b0
  assign bank2_station_u__i_req_local_if_ar                         = {{($bits(bank2_station_u__i_req_local_if_ar)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_req_local_if_arvalid                    = {{($bits(bank2_station_u__i_req_local_if_arvalid)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_req_local_if_aw                         = {{($bits(bank2_station_u__i_req_local_if_aw)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_req_local_if_awvalid                    = {{($bits(bank2_station_u__i_req_local_if_awvalid)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_req_local_if_w                          = {{($bits(bank2_station_u__i_req_local_if_w)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_req_local_if_wvalid                     = {{($bits(bank2_station_u__i_req_local_if_wvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // bank2_station_u.i_resp_local_if <-> 'b0
  assign bank2_station_u__i_resp_local_if_b                         = {{($bits(bank2_station_u__i_resp_local_if_b)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_resp_local_if_bvalid                    = {{($bits(bank2_station_u__i_resp_local_if_bvalid)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_resp_local_if_r                         = {{($bits(bank2_station_u__i_resp_local_if_r)-1){1'b0}}, 1'b0};
  assign bank2_station_u__i_resp_local_if_rvalid                    = {{($bits(bank2_station_u__i_resp_local_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_station_u.i_resp_local_if <-> bank2_da_u.ring_resp_if
  assign bank2_da_u__ring_resp_if_bready                            = bank2_station_u__i_resp_local_if_bready;
  assign bank2_da_u__ring_resp_if_rready                            = bank2_station_u__i_resp_local_if_rready;
  assign bank2_station_u__i_resp_local_if_b                         = bank2_da_u__ring_resp_if_b;
  assign bank2_station_u__i_resp_local_if_bvalid                    = bank2_da_u__ring_resp_if_bvalid;
  assign bank2_station_u__i_resp_local_if_r                         = bank2_da_u__ring_resp_if_r;
  assign bank2_station_u__i_resp_local_if_rvalid                    = bank2_da_u__ring_resp_if_rvalid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_station_u.i_resp_ring_if <-> bank3_station_u.o_resp_ring_if
  assign bank2_station_u__i_resp_ring_if_b                          = bank3_station_u__o_resp_ring_if_b;
  assign bank2_station_u__i_resp_ring_if_bvalid                     = bank3_station_u__o_resp_ring_if_bvalid;
  assign bank2_station_u__i_resp_ring_if_r                          = bank3_station_u__o_resp_ring_if_r;
  assign bank2_station_u__i_resp_ring_if_rvalid                     = bank3_station_u__o_resp_ring_if_rvalid;
  assign bank3_station_u__o_resp_ring_if_bready                     = bank2_station_u__i_resp_ring_if_bready;
  assign bank3_station_u__o_resp_ring_if_rready                     = bank2_station_u__i_resp_ring_if_rready;
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // bank2_station_u.o_req_local_if <-> 'b0
  assign bank2_station_u__o_req_local_if_arready                    = {{($bits(bank2_station_u__o_req_local_if_arready)-1){1'b0}}, 1'b0};
  assign bank2_station_u__o_req_local_if_awready                    = {{($bits(bank2_station_u__o_req_local_if_awready)-1){1'b0}}, 1'b0};
  assign bank2_station_u__o_req_local_if_wready                     = {{($bits(bank2_station_u__o_req_local_if_wready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_station_u.o_req_local_if <-> bank2_da_u.ring_req_if
  assign bank2_da_u__ring_req_if_ar                                 = bank2_station_u__o_req_local_if_ar;
  assign bank2_da_u__ring_req_if_arvalid                            = bank2_station_u__o_req_local_if_arvalid;
  assign bank2_da_u__ring_req_if_aw                                 = bank2_station_u__o_req_local_if_aw;
  assign bank2_da_u__ring_req_if_awvalid                            = bank2_station_u__o_req_local_if_awvalid;
  assign bank2_da_u__ring_req_if_w                                  = bank2_station_u__o_req_local_if_w;
  assign bank2_da_u__ring_req_if_wvalid                             = bank2_station_u__o_req_local_if_wvalid;
  assign bank2_station_u__o_req_local_if_arready                    = bank2_da_u__ring_req_if_arready;
  assign bank2_station_u__o_req_local_if_awready                    = bank2_da_u__ring_req_if_awready;
  assign bank2_station_u__o_req_local_if_wready                     = bank2_da_u__ring_req_if_wready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_station_u.o_req_ring_if <-> bank3_station_u.i_req_ring_if
  assign bank2_station_u__o_req_ring_if_arready                     = bank3_station_u__i_req_ring_if_arready;
  assign bank2_station_u__o_req_ring_if_awready                     = bank3_station_u__i_req_ring_if_awready;
  assign bank2_station_u__o_req_ring_if_wready                      = bank3_station_u__i_req_ring_if_wready;
  assign bank3_station_u__i_req_ring_if_ar                          = bank2_station_u__o_req_ring_if_ar;
  assign bank3_station_u__i_req_ring_if_arvalid                     = bank2_station_u__o_req_ring_if_arvalid;
  assign bank3_station_u__i_req_ring_if_aw                          = bank2_station_u__o_req_ring_if_aw;
  assign bank3_station_u__i_req_ring_if_awvalid                     = bank2_station_u__o_req_ring_if_awvalid;
  assign bank3_station_u__i_req_ring_if_w                           = bank2_station_u__o_req_ring_if_w;
  assign bank3_station_u__i_req_ring_if_wvalid                      = bank2_station_u__o_req_ring_if_wvalid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2__IFNDEF_TB_TORTURE_OURSRING
  // bank2_station_u.o_resp_local_if <-> 'b0
  assign bank2_station_u__o_resp_local_if_bready                    = {{($bits(bank2_station_u__o_resp_local_if_bready)-1){1'b0}}, 1'b0};
  assign bank2_station_u__o_resp_local_if_rready                    = {{($bits(bank2_station_u__o_resp_local_if_rready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank2_station_u__clk                                       = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_station_u/rstn <-> bank2_rstn_sync_u/rstn_out
  assign bank2_station_u__rstn                                      = bank2_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u.cpu_l2_req_if <-> cpu_noc_u.noc_l2[2]
  assign bank2_u__cpu_l2_req_if_req                                 = cpu_noc_u__noc_l2_req[2];
  assign bank2_u__cpu_l2_req_if_req_valid                           = cpu_noc_u__noc_l2_req_valid[2];
  assign cpu_noc_u__noc_l2_req_ready[2]                             = bank2_u__cpu_l2_req_if_req_ready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u.cpu_l2_resp_if <-> cpu_noc_u.l2_noc[2]
  assign bank2_u__cpu_l2_resp_if_resp_ready                         = cpu_noc_u__l2_noc_resp_ready[2];
  assign cpu_noc_u__l2_noc_resp[2]                                  = bank2_u__cpu_l2_resp_if_resp;
  assign cpu_noc_u__l2_noc_resp_valid[2]                            = bank2_u__cpu_l2_resp_if_resp_valid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u.debug <-> bank2_da_u.debug
  assign bank2_da_u__debug_rdata                                    = bank2_u__debug_rdata;
  assign bank2_da_u__debug_ready                                    = bank2_u__debug_ready;
  assign bank2_u__debug_addr                                        = bank2_da_u__debug_addr;
  assign bank2_u__debug_data_ram_en_pway                            = bank2_da_u__debug_data_ram_en_pway;
  assign bank2_u__debug_dirty_ram_en                                = bank2_da_u__debug_dirty_ram_en;
  assign bank2_u__debug_en                                          = bank2_da_u__debug_en;
  assign bank2_u__debug_hpmcounter_en                               = bank2_da_u__debug_hpmcounter_en;
  assign bank2_u__debug_lru_ram_en                                  = bank2_da_u__debug_lru_ram_en;
  assign bank2_u__debug_rw                                          = bank2_da_u__debug_rw;
  assign bank2_u__debug_tag_ram_en_pway                             = bank2_da_u__debug_tag_ram_en_pway;
  assign bank2_u__debug_valid_dirty_bit_mask                        = bank2_da_u__debug_valid_dirty_bit_mask;
  assign bank2_u__debug_valid_ram_en                                = bank2_da_u__debug_valid_ram_en;
  assign bank2_u__debug_wdata                                       = bank2_da_u__debug_wdata;
  assign bank2_u__debug_wdata_byte_mask                             = bank2_da_u__debug_wdata_byte_mask;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u.l2_amo_store <-> cpu_noc_u.l2_amo_store[2]
  assign bank2_u__l2_amo_store_req                                  = cpu_noc_u__l2_amo_store_req[2];
  assign bank2_u__l2_amo_store_req_valid                            = cpu_noc_u__l2_amo_store_req_valid[2];
  assign cpu_noc_u__l2_amo_store_req_ready[2]                       = bank2_u__l2_amo_store_req_ready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK__IFDEF_TB_USE_MEM_NOC
  // bank2_u.l2_req_if <-> 'b0
  assign bank2_u__l2_req_if_arready                                 = {{($bits(bank2_u__l2_req_if_arready)-1){1'b0}}, 1'b0};
  assign bank2_u__l2_req_if_awready                                 = {{($bits(bank2_u__l2_req_if_awready)-1){1'b0}}, 1'b0};
  assign bank2_u__l2_req_if_wready                                  = {{($bits(bank2_u__l2_req_if_wready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2__IFNDEF_TB_USE_MEM_NOC
  // bank2_u.l2_req_if <-> mem_noc_u.l2_req_if[2]
  assign bank2_u__l2_req_if_arready                                 = mem_noc_u__l2_req_if_arready[2];
  assign bank2_u__l2_req_if_awready                                 = mem_noc_u__l2_req_if_awready[2];
  assign bank2_u__l2_req_if_wready                                  = mem_noc_u__l2_req_if_wready[2];
  assign mem_noc_u__l2_req_if_ar[2]                                 = bank2_u__l2_req_if_ar;
  assign mem_noc_u__l2_req_if_arvalid[2]                            = bank2_u__l2_req_if_arvalid;
  assign mem_noc_u__l2_req_if_aw[2]                                 = bank2_u__l2_req_if_aw;
  assign mem_noc_u__l2_req_if_awvalid[2]                            = bank2_u__l2_req_if_awvalid;
  assign mem_noc_u__l2_req_if_w[2]                                  = bank2_u__l2_req_if_w;
  assign mem_noc_u__l2_req_if_wvalid[2]                             = bank2_u__l2_req_if_wvalid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK__IFDEF_TB_USE_MEM_NOC
  // bank2_u.l2_resp_if <-> 'b0
  assign bank2_u__l2_resp_if_b                                      = {{($bits(bank2_u__l2_resp_if_b)-1){1'b0}}, 1'b0};
  assign bank2_u__l2_resp_if_bvalid                                 = {{($bits(bank2_u__l2_resp_if_bvalid)-1){1'b0}}, 1'b0};
  assign bank2_u__l2_resp_if_r                                      = {{($bits(bank2_u__l2_resp_if_r)-1){1'b0}}, 1'b0};
  assign bank2_u__l2_resp_if_rvalid                                 = {{($bits(bank2_u__l2_resp_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2__IFNDEF_TB_USE_MEM_NOC
  // bank2_u.l2_resp_if <-> mem_noc_u.l2_resp_if[2]
  assign bank2_u__l2_resp_if_b                                      = mem_noc_u__l2_resp_if_b[2];
  assign bank2_u__l2_resp_if_bvalid                                 = mem_noc_u__l2_resp_if_bvalid[2];
  assign bank2_u__l2_resp_if_r                                      = mem_noc_u__l2_resp_if_r[2];
  assign bank2_u__l2_resp_if_rvalid                                 = mem_noc_u__l2_resp_if_rvalid[2];
  assign mem_noc_u__l2_resp_if_bready[2]                            = bank2_u__l2_resp_if_bready;
  assign mem_noc_u__l2_resp_if_rready[2]                            = bank2_u__l2_resp_if_rready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u.s2b <-> bank2_station_u.out_s2b
  assign bank2_u__s2b_ctrl_reg                                      = bank2_station_u__out_s2b_ctrl_reg;
  assign bank2_u__s2b_icg_disable                                   = bank2_station_u__out_s2b_icg_disable;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/clk <-> bank2_icg_u/clkg
  assign bank2_u__clk                                               = bank2_icg_u__clkg;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/mem_barrier_clr_pbank_in[0] <-> bank0_u/mem_barrier_clr_pbank_out[1]
  assign bank2_u__mem_barrier_clr_pbank_in[0]                       = bank0_u__mem_barrier_clr_pbank_out[1];
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/mem_barrier_clr_pbank_in[1] <-> bank1_u/mem_barrier_clr_pbank_out[1]
  assign bank2_u__mem_barrier_clr_pbank_in[1]                       = bank1_u__mem_barrier_clr_pbank_out[1];
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/mem_barrier_clr_pbank_in[2] <-> bank3_u/mem_barrier_clr_pbank_out[2]
  assign bank2_u__mem_barrier_clr_pbank_in[2]                       = bank3_u__mem_barrier_clr_pbank_out[2];
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/mem_barrier_status_in[0] <-> bank0_u/mem_barrier_status_out
  assign bank2_u__mem_barrier_status_in[0]                          = bank0_u__mem_barrier_status_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/mem_barrier_status_in[1] <-> bank1_u/mem_barrier_status_out
  assign bank2_u__mem_barrier_status_in[1]                          = bank1_u__mem_barrier_status_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/mem_barrier_status_in[2] <-> bank3_u/mem_barrier_status_out
  assign bank2_u__mem_barrier_status_in[2]                          = bank3_u__mem_barrier_status_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/scan_mode <-> soc_top/dft_mode
  assign bank2_u__scan_mode                                         = soc_top__dft_mode;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank2_u/tst_en <-> 'b0
  assign bank2_u__tst_en                                            = {{($bits(bank2_u__tst_en)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_da_u/clk <-> bank3_icg_u/clkg
  assign bank3_da_u__clk                                            = bank3_icg_u__clkg;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank3_icg_u__clk                                           = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_icg_u/en <-> bank3_station_u/out_s2icg_clk_en
  assign bank3_icg_u__en                                            = bank3_station_u__out_s2icg_clk_en;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_icg_u/rstn <-> soc_top/chip_resetn
  assign bank3_icg_u__rstn                                          = soc_top__chip_resetn;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_icg_u/tst_en <-> 'b0
  assign bank3_icg_u__tst_en                                        = {{($bits(bank3_icg_u__tst_en)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3__IFNDEF_TB_TORTURE_OURSRING
  // bank3_station_u.i_req_local_if <-> 'b0
  assign bank3_station_u__i_req_local_if_ar                         = {{($bits(bank3_station_u__i_req_local_if_ar)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_req_local_if_arvalid                    = {{($bits(bank3_station_u__i_req_local_if_arvalid)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_req_local_if_aw                         = {{($bits(bank3_station_u__i_req_local_if_aw)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_req_local_if_awvalid                    = {{($bits(bank3_station_u__i_req_local_if_awvalid)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_req_local_if_w                          = {{($bits(bank3_station_u__i_req_local_if_w)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_req_local_if_wvalid                     = {{($bits(bank3_station_u__i_req_local_if_wvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // bank3_station_u.i_resp_local_if <-> 'b0
  assign bank3_station_u__i_resp_local_if_b                         = {{($bits(bank3_station_u__i_resp_local_if_b)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_resp_local_if_bvalid                    = {{($bits(bank3_station_u__i_resp_local_if_bvalid)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_resp_local_if_r                         = {{($bits(bank3_station_u__i_resp_local_if_r)-1){1'b0}}, 1'b0};
  assign bank3_station_u__i_resp_local_if_rvalid                    = {{($bits(bank3_station_u__i_resp_local_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_station_u.i_resp_local_if <-> bank3_da_u.ring_resp_if
  assign bank3_da_u__ring_resp_if_bready                            = bank3_station_u__i_resp_local_if_bready;
  assign bank3_da_u__ring_resp_if_rready                            = bank3_station_u__i_resp_local_if_rready;
  assign bank3_station_u__i_resp_local_if_b                         = bank3_da_u__ring_resp_if_b;
  assign bank3_station_u__i_resp_local_if_bvalid                    = bank3_da_u__ring_resp_if_bvalid;
  assign bank3_station_u__i_resp_local_if_r                         = bank3_da_u__ring_resp_if_r;
  assign bank3_station_u__i_resp_local_if_rvalid                    = bank3_da_u__ring_resp_if_rvalid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank3_station_u.i_resp_ring_if <-> byp_station_u.o_resp_ring_if
  assign bank3_station_u__i_resp_ring_if_b                          = byp_station_u__o_resp_ring_if_b;
  assign bank3_station_u__i_resp_ring_if_bvalid                     = byp_station_u__o_resp_ring_if_bvalid;
  assign bank3_station_u__i_resp_ring_if_r                          = byp_station_u__o_resp_ring_if_r;
  assign bank3_station_u__i_resp_ring_if_rvalid                     = byp_station_u__o_resp_ring_if_rvalid;
  assign byp_station_u__o_resp_ring_if_bready                       = bank3_station_u__i_resp_ring_if_bready;
  assign byp_station_u__o_resp_ring_if_rready                       = bank3_station_u__i_resp_ring_if_rready;
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // bank3_station_u.o_req_local_if <-> 'b0
  assign bank3_station_u__o_req_local_if_arready                    = {{($bits(bank3_station_u__o_req_local_if_arready)-1){1'b0}}, 1'b0};
  assign bank3_station_u__o_req_local_if_awready                    = {{($bits(bank3_station_u__o_req_local_if_awready)-1){1'b0}}, 1'b0};
  assign bank3_station_u__o_req_local_if_wready                     = {{($bits(bank3_station_u__o_req_local_if_wready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_station_u.o_req_local_if <-> bank3_da_u.ring_req_if
  assign bank3_da_u__ring_req_if_ar                                 = bank3_station_u__o_req_local_if_ar;
  assign bank3_da_u__ring_req_if_arvalid                            = bank3_station_u__o_req_local_if_arvalid;
  assign bank3_da_u__ring_req_if_aw                                 = bank3_station_u__o_req_local_if_aw;
  assign bank3_da_u__ring_req_if_awvalid                            = bank3_station_u__o_req_local_if_awvalid;
  assign bank3_da_u__ring_req_if_w                                  = bank3_station_u__o_req_local_if_w;
  assign bank3_da_u__ring_req_if_wvalid                             = bank3_station_u__o_req_local_if_wvalid;
  assign bank3_station_u__o_req_local_if_arready                    = bank3_da_u__ring_req_if_arready;
  assign bank3_station_u__o_req_local_if_awready                    = bank3_da_u__ring_req_if_awready;
  assign bank3_station_u__o_req_local_if_wready                     = bank3_da_u__ring_req_if_wready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // bank3_station_u.o_req_ring_if <-> byp_station_u.i_req_ring_if
  assign bank3_station_u__o_req_ring_if_arready                     = byp_station_u__i_req_ring_if_arready;
  assign bank3_station_u__o_req_ring_if_awready                     = byp_station_u__i_req_ring_if_awready;
  assign bank3_station_u__o_req_ring_if_wready                      = byp_station_u__i_req_ring_if_wready;
  assign byp_station_u__i_req_ring_if_ar                            = bank3_station_u__o_req_ring_if_ar;
  assign byp_station_u__i_req_ring_if_arvalid                       = bank3_station_u__o_req_ring_if_arvalid;
  assign byp_station_u__i_req_ring_if_aw                            = bank3_station_u__o_req_ring_if_aw;
  assign byp_station_u__i_req_ring_if_awvalid                       = bank3_station_u__o_req_ring_if_awvalid;
  assign byp_station_u__i_req_ring_if_w                             = bank3_station_u__o_req_ring_if_w;
  assign byp_station_u__i_req_ring_if_wvalid                        = bank3_station_u__o_req_ring_if_wvalid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3__IFNDEF_TB_TORTURE_OURSRING
  // bank3_station_u.o_resp_local_if <-> 'b0
  assign bank3_station_u__o_resp_local_if_bready                    = {{($bits(bank3_station_u__o_resp_local_if_bready)-1){1'b0}}, 1'b0};
  assign bank3_station_u__o_resp_local_if_rready                    = {{($bits(bank3_station_u__o_resp_local_if_rready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign bank3_station_u__clk                                       = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_station_u/rstn <-> bank3_rstn_sync_u/rstn_out
  assign bank3_station_u__rstn                                      = bank3_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u.cpu_l2_req_if <-> cpu_noc_u.noc_l2[3]
  assign bank3_u__cpu_l2_req_if_req                                 = cpu_noc_u__noc_l2_req[3];
  assign bank3_u__cpu_l2_req_if_req_valid                           = cpu_noc_u__noc_l2_req_valid[3];
  assign cpu_noc_u__noc_l2_req_ready[3]                             = bank3_u__cpu_l2_req_if_req_ready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u.cpu_l2_resp_if <-> cpu_noc_u.l2_noc[3]
  assign bank3_u__cpu_l2_resp_if_resp_ready                         = cpu_noc_u__l2_noc_resp_ready[3];
  assign cpu_noc_u__l2_noc_resp[3]                                  = bank3_u__cpu_l2_resp_if_resp;
  assign cpu_noc_u__l2_noc_resp_valid[3]                            = bank3_u__cpu_l2_resp_if_resp_valid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u.debug <-> bank3_da_u.debug
  assign bank3_da_u__debug_rdata                                    = bank3_u__debug_rdata;
  assign bank3_da_u__debug_ready                                    = bank3_u__debug_ready;
  assign bank3_u__debug_addr                                        = bank3_da_u__debug_addr;
  assign bank3_u__debug_data_ram_en_pway                            = bank3_da_u__debug_data_ram_en_pway;
  assign bank3_u__debug_dirty_ram_en                                = bank3_da_u__debug_dirty_ram_en;
  assign bank3_u__debug_en                                          = bank3_da_u__debug_en;
  assign bank3_u__debug_hpmcounter_en                               = bank3_da_u__debug_hpmcounter_en;
  assign bank3_u__debug_lru_ram_en                                  = bank3_da_u__debug_lru_ram_en;
  assign bank3_u__debug_rw                                          = bank3_da_u__debug_rw;
  assign bank3_u__debug_tag_ram_en_pway                             = bank3_da_u__debug_tag_ram_en_pway;
  assign bank3_u__debug_valid_dirty_bit_mask                        = bank3_da_u__debug_valid_dirty_bit_mask;
  assign bank3_u__debug_valid_ram_en                                = bank3_da_u__debug_valid_ram_en;
  assign bank3_u__debug_wdata                                       = bank3_da_u__debug_wdata;
  assign bank3_u__debug_wdata_byte_mask                             = bank3_da_u__debug_wdata_byte_mask;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u.l2_amo_store <-> cpu_noc_u.l2_amo_store[3]
  assign bank3_u__l2_amo_store_req                                  = cpu_noc_u__l2_amo_store_req[3];
  assign bank3_u__l2_amo_store_req_valid                            = cpu_noc_u__l2_amo_store_req_valid[3];
  assign cpu_noc_u__l2_amo_store_req_ready[3]                       = bank3_u__l2_amo_store_req_ready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3__IFDEF_TB_USE_MEM_NOC
  // bank3_u.l2_req_if <-> 'b0
  assign bank3_u__l2_req_if_arready                                 = {{($bits(bank3_u__l2_req_if_arready)-1){1'b0}}, 1'b0};
  assign bank3_u__l2_req_if_awready                                 = {{($bits(bank3_u__l2_req_if_awready)-1){1'b0}}, 1'b0};
  assign bank3_u__l2_req_if_wready                                  = {{($bits(bank3_u__l2_req_if_wready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3__IFNDEF_TB_USE_MEM_NOC
  // bank3_u.l2_req_if <-> mem_noc_u.l2_req_if[3]
  assign bank3_u__l2_req_if_arready                                 = mem_noc_u__l2_req_if_arready[3];
  assign bank3_u__l2_req_if_awready                                 = mem_noc_u__l2_req_if_awready[3];
  assign bank3_u__l2_req_if_wready                                  = mem_noc_u__l2_req_if_wready[3];
  assign mem_noc_u__l2_req_if_ar[3]                                 = bank3_u__l2_req_if_ar;
  assign mem_noc_u__l2_req_if_arvalid[3]                            = bank3_u__l2_req_if_arvalid;
  assign mem_noc_u__l2_req_if_aw[3]                                 = bank3_u__l2_req_if_aw;
  assign mem_noc_u__l2_req_if_awvalid[3]                            = bank3_u__l2_req_if_awvalid;
  assign mem_noc_u__l2_req_if_w[3]                                  = bank3_u__l2_req_if_w;
  assign mem_noc_u__l2_req_if_wvalid[3]                             = bank3_u__l2_req_if_wvalid;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3__IFDEF_TB_USE_MEM_NOC
  // bank3_u.l2_resp_if <-> 'b0
  assign bank3_u__l2_resp_if_b                                      = {{($bits(bank3_u__l2_resp_if_b)-1){1'b0}}, 1'b0};
  assign bank3_u__l2_resp_if_bvalid                                 = {{($bits(bank3_u__l2_resp_if_bvalid)-1){1'b0}}, 1'b0};
  assign bank3_u__l2_resp_if_r                                      = {{($bits(bank3_u__l2_resp_if_r)-1){1'b0}}, 1'b0};
  assign bank3_u__l2_resp_if_rvalid                                 = {{($bits(bank3_u__l2_resp_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3__IFNDEF_TB_USE_MEM_NOC
  // bank3_u.l2_resp_if <-> mem_noc_u.l2_resp_if[3]
  assign bank3_u__l2_resp_if_b                                      = mem_noc_u__l2_resp_if_b[3];
  assign bank3_u__l2_resp_if_bvalid                                 = mem_noc_u__l2_resp_if_bvalid[3];
  assign bank3_u__l2_resp_if_r                                      = mem_noc_u__l2_resp_if_r[3];
  assign bank3_u__l2_resp_if_rvalid                                 = mem_noc_u__l2_resp_if_rvalid[3];
  assign mem_noc_u__l2_resp_if_bready[3]                            = bank3_u__l2_resp_if_bready;
  assign mem_noc_u__l2_resp_if_rready[3]                            = bank3_u__l2_resp_if_rready;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u.s2b <-> bank3_station_u.out_s2b
  assign bank3_u__s2b_ctrl_reg                                      = bank3_station_u__out_s2b_ctrl_reg;
  assign bank3_u__s2b_icg_disable                                   = bank3_station_u__out_s2b_icg_disable;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/clk <-> bank3_icg_u/clkg
  assign bank3_u__clk                                               = bank3_icg_u__clkg;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/mem_barrier_clr_pbank_in[0] <-> bank0_u/mem_barrier_clr_pbank_out[2]
  assign bank3_u__mem_barrier_clr_pbank_in[0]                       = bank0_u__mem_barrier_clr_pbank_out[2];
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/mem_barrier_clr_pbank_in[1] <-> bank1_u/mem_barrier_clr_pbank_out[2]
  assign bank3_u__mem_barrier_clr_pbank_in[1]                       = bank1_u__mem_barrier_clr_pbank_out[2];
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/mem_barrier_clr_pbank_in[2] <-> bank2_u/mem_barrier_clr_pbank_out[2]
  assign bank3_u__mem_barrier_clr_pbank_in[2]                       = bank2_u__mem_barrier_clr_pbank_out[2];
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/mem_barrier_status_in[0] <-> bank0_u/mem_barrier_status_out
  assign bank3_u__mem_barrier_status_in[0]                          = bank0_u__mem_barrier_status_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/mem_barrier_status_in[1] <-> bank1_u/mem_barrier_status_out
  assign bank3_u__mem_barrier_status_in[1]                          = bank1_u__mem_barrier_status_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/mem_barrier_status_in[2] <-> bank2_u/mem_barrier_status_out
  assign bank3_u__mem_barrier_status_in[2]                          = bank2_u__mem_barrier_status_out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/scan_mode <-> soc_top/dft_mode
  assign bank3_u__scan_mode                                         = soc_top__dft_mode;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // bank3_u/tst_en <-> 'b0
  assign bank3_u__tst_en                                            = {{($bits(bank3_u__tst_en)-1){1'b0}}, 1'b0};
  `endif

  // boot_from_flash_en_u/out <-> boot_from_flash_mux_u/din0
  assign boot_from_flash_mux_u__din0                                = boot_from_flash_en_u__out;

  // boot_from_flash_mux_u/dout <-> boot_from_flash_u/s2b_boot_from_flash_ena
  assign boot_from_flash_u__s2b_boot_from_flash_ena                 = boot_from_flash_mux_u__dout;

  // boot_from_flash_u/clk <-> slow_io_clk_div_u/divclk
  assign boot_from_flash_u__clk                                     = slow_io_clk_div_u__divclk;

  // boot_fsm_en_u/out <-> boot_fsm_mux_u/din0
  assign boot_fsm_mux_u__din0                                       = boot_fsm_en_u__out;

  // boot_fsm_mux_u/dout <-> bootup_fsm_u/s2b_bootup_ena
  assign bootup_fsm_u__s2b_bootup_ena                               = boot_fsm_mux_u__dout;

  // bootup_fsm_u/clk <-> slow_io_clk_div_u/divclk
  assign bootup_fsm_u__clk                                          = slow_io_clk_div_u__divclk;

  `ifdef IFNDEF_NO_DDR
  // buf_BypassInDataAC_u/in <-> ddr_top_u/b2s_BypassInDataAC
  assign buf_BypassInDataAC_u__in                                   = ddr_top_u__b2s_BypassInDataAC;
  `endif

  `ifdef IFNDEF_NO_DDR
  // buf_BypassInDataDAT_u/in <-> ddr_top_u/b2s_BypassInDataDAT
  assign buf_BypassInDataDAT_u__in                                  = ddr_top_u__b2s_BypassInDataDAT;
  `endif

  `ifdef IFNDEF_NO_DDR
  // buf_BypassInDataMASTER_u/in <-> ddr_top_u/b2s_BypassInDataMASTER
  assign buf_BypassInDataMASTER_u__in                               = ddr_top_u__b2s_BypassInDataMASTER;
  `endif

  // byp_rstn_sync_u/rstn_out <-> oursring_cdc_io2byp_u/master_resetn
  assign oursring_cdc_io2byp_u__master_resetn                       = byp_rstn_sync_u__rstn_out;

  // byp_station_u.i_resp_local_if <-> oursring_cdc_byp2ddr_u.cdc_oursring_slave_rsp_if
  assign byp_station_u__i_resp_local_if_b                           = oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_b;
  assign byp_station_u__i_resp_local_if_bvalid                      = oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_bvalid;
  assign byp_station_u__i_resp_local_if_r                           = oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_r;
  assign byp_station_u__i_resp_local_if_rvalid                      = oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_rvalid;
  assign oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_bready   = byp_station_u__i_resp_local_if_bready;
  assign oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_rready   = byp_station_u__i_resp_local_if_rready;

  // byp_station_u.i_resp_ring_if <-> pll_station_u.o_resp_local_if
  assign byp_station_u__i_resp_ring_if_b                            = pll_station_u__o_resp_local_if_b;
  assign byp_station_u__i_resp_ring_if_bvalid                       = pll_station_u__o_resp_local_if_bvalid;
  assign byp_station_u__i_resp_ring_if_r                            = pll_station_u__o_resp_local_if_r;
  assign byp_station_u__i_resp_ring_if_rvalid                       = pll_station_u__o_resp_local_if_rvalid;
  assign pll_station_u__o_resp_local_if_bready                      = byp_station_u__i_resp_ring_if_bready;
  assign pll_station_u__o_resp_local_if_rready                      = byp_station_u__i_resp_ring_if_rready;

  // byp_station_u.o_req_local_if <-> oursring_cdc_byp2ddr_u.oursring_cdc_slave_req_if
  assign byp_station_u__o_req_local_if_arready                      = oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_arready;
  assign byp_station_u__o_req_local_if_awready                      = oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_awready;
  assign byp_station_u__o_req_local_if_wready                       = oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_wready;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_ar       = byp_station_u__o_req_local_if_ar;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_arvalid  = byp_station_u__o_req_local_if_arvalid;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_aw       = byp_station_u__o_req_local_if_aw;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_awvalid  = byp_station_u__o_req_local_if_awvalid;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_w        = byp_station_u__o_req_local_if_w;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_wvalid   = byp_station_u__o_req_local_if_wvalid;

  // byp_station_u.o_req_ring_if <-> pll_station_u.i_req_local_if
  assign byp_station_u__o_req_ring_if_arready                       = pll_station_u__i_req_local_if_arready;
  assign byp_station_u__o_req_ring_if_awready                       = pll_station_u__i_req_local_if_awready;
  assign byp_station_u__o_req_ring_if_wready                        = pll_station_u__i_req_local_if_wready;
  assign pll_station_u__i_req_local_if_ar                           = byp_station_u__o_req_ring_if_ar;
  assign pll_station_u__i_req_local_if_arvalid                      = byp_station_u__o_req_ring_if_arvalid;
  assign pll_station_u__i_req_local_if_aw                           = byp_station_u__o_req_ring_if_aw;
  assign pll_station_u__i_req_local_if_awvalid                      = byp_station_u__o_req_ring_if_awvalid;
  assign pll_station_u__i_req_local_if_w                            = byp_station_u__o_req_ring_if_w;
  assign pll_station_u__i_req_local_if_wvalid                       = byp_station_u__o_req_ring_if_wvalid;

  // byp_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign byp_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;

  // byp_station_u/rstn <-> byp_rstn_sync_u/rstn_out
  assign byp_station_u__rstn                                        = byp_rstn_sync_u__rstn_out;

  // chip_idle_u/bank_idle[0] <-> bank0_u/cache_is_idle
  assign chip_idle_u__bank_idle[0]                                  = bank0_u__cache_is_idle;

  // chip_idle_u/bank_idle[1] <-> bank1_u/cache_is_idle
  assign chip_idle_u__bank_idle[1]                                  = bank1_u__cache_is_idle;

  `ifdef IFNDEF_SOC_NO_BANK2
  // chip_idle_u/bank_idle[2] <-> bank2_u/cache_is_idle
  assign chip_idle_u__bank_idle[2]                                  = bank2_u__cache_is_idle;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // chip_idle_u/bank_idle[3] <-> bank3_u/cache_is_idle
  assign chip_idle_u__bank_idle[3]                                  = bank3_u__cache_is_idle;
  `endif

  // chip_idle_u/bank_rstn[0] <-> dft_bank0_rstn_mux_u/dout
  assign chip_idle_u__bank_rstn[0]                                  = dft_bank0_rstn_mux_u__dout;

  // chip_idle_u/bank_rstn[1] <-> dft_bank1_rstn_mux_u/dout
  assign chip_idle_u__bank_rstn[1]                                  = dft_bank1_rstn_mux_u__dout;

  // chip_idle_u/bank_rstn[2] <-> dft_bank2_rstn_mux_u/dout
  assign chip_idle_u__bank_rstn[2]                                  = dft_bank2_rstn_mux_u__dout;

  // chip_idle_u/bank_rstn[3] <-> dft_bank3_rstn_mux_u/dout
  assign chip_idle_u__bank_rstn[3]                                  = dft_bank3_rstn_mux_u__dout;

  

  // chip_idle_u/cpu_rstn[0] <-> dft_vp0_rstn_mux_u/dout
  assign chip_idle_u__cpu_rstn[0]                                   = dft_vp0_rstn_mux_u__dout;

  // chip_idle_u/cpu_rstn[1] <-> dft_vp1_rstn_mux_u/dout
  assign chip_idle_u__cpu_rstn[1]                                   = dft_vp1_rstn_mux_u__dout;

  // chip_idle_u/cpu_rstn[2] <-> dft_vp2_rstn_mux_u/dout
  assign chip_idle_u__cpu_rstn[2]                                   = dft_vp2_rstn_mux_u__dout;

  // chip_idle_u/cpu_rstn[3] <-> dft_vp3_rstn_mux_u/dout
  assign chip_idle_u__cpu_rstn[3]                                   = dft_vp3_rstn_mux_u__dout;

  // chip_idle_u/cpu_rstn[4] <-> dft_orv32_rstn_mux_u/dout
  assign chip_idle_u__cpu_rstn[4]                                   = dft_orv32_rstn_mux_u__dout;

  // chip_idle_u/cpu_wfe[0] <-> vp0_u/wfe_stall
  assign chip_idle_u__cpu_wfe[0]                                    = vp0_u__wfe_stall;

  // chip_idle_u/cpu_wfe[1] <-> vp1_u/wfe_stall
  assign chip_idle_u__cpu_wfe[1]                                    = vp1_u__wfe_stall;

  // chip_idle_u/cpu_wfe[2] <-> vp2_u/wfe_stall
  assign chip_idle_u__cpu_wfe[2]                                    = vp2_u__wfe_stall;

  // chip_idle_u/cpu_wfe[3] <-> vp3_u/wfe_stall
  assign chip_idle_u__cpu_wfe[3]                                    = vp3_u__wfe_stall;

  

  // chip_idle_u/cpu_wfi[0] <-> vp0_u/wfi_stall
  assign chip_idle_u__cpu_wfi[0]                                    = vp0_u__wfi_stall;

  // chip_idle_u/cpu_wfi[1] <-> vp1_u/wfi_stall
  assign chip_idle_u__cpu_wfi[1]                                    = vp1_u__wfi_stall;

  // chip_idle_u/cpu_wfi[2] <-> vp2_u/wfi_stall
  assign chip_idle_u__cpu_wfi[2]                                    = vp2_u__wfi_stall;

  // chip_idle_u/cpu_wfi[3] <-> vp3_u/wfi_stall
  assign chip_idle_u__cpu_wfi[3]                                    = vp3_u__wfi_stall;

  

  // cpu_noc_u.cpu_amo_store_noc[0] <-> 'b0
  assign cpu_noc_u__cpu_amo_store_noc_req[0]                        = {{($bits(cpu_noc_u__cpu_amo_store_noc_req[0])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[0]                  = {{($bits(cpu_noc_u__cpu_amo_store_noc_req_valid[0])-1){1'b0}}, 1'b0};

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.cpu_amo_store_noc[2] <-> 'b0
  assign cpu_noc_u__cpu_amo_store_noc_req[2]                        = {{($bits(cpu_noc_u__cpu_amo_store_noc_req[2])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[2]                  = {{($bits(cpu_noc_u__cpu_amo_store_noc_req_valid[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.cpu_amo_store_noc[3] <-> 'b0
  assign cpu_noc_u__cpu_amo_store_noc_req[3]                        = {{($bits(cpu_noc_u__cpu_amo_store_noc_req[3])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[3]                  = {{($bits(cpu_noc_u__cpu_amo_store_noc_req_valid[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.cpu_amo_store_noc[4] <-> 'b0
  assign cpu_noc_u__cpu_amo_store_noc_req[4]                        = {{($bits(cpu_noc_u__cpu_amo_store_noc_req[4])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[4]                  = {{($bits(cpu_noc_u__cpu_amo_store_noc_req_valid[4])-1){1'b0}}, 1'b0};
  `endif

  // cpu_noc_u.cpu_amo_store_noc[5] <-> 'b0
  assign cpu_noc_u__cpu_amo_store_noc_req[5]                        = {{($bits(cpu_noc_u__cpu_amo_store_noc_req[5])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[5]                  = {{($bits(cpu_noc_u__cpu_amo_store_noc_req_valid[5])-1){1'b0}}, 1'b0};

  // cpu_noc_u.cpu_amo_store_noc[6] <-> 'b0
  assign cpu_noc_u__cpu_amo_store_noc_req[6]                        = {{($bits(cpu_noc_u__cpu_amo_store_noc_req[6])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[6]                  = {{($bits(cpu_noc_u__cpu_amo_store_noc_req_valid[6])-1){1'b0}}, 1'b0};

  `ifdef IFDEF_NO_ORV32
  // cpu_noc_u.cpu_noc_req_if[0] <-> 'b0
  assign cpu_noc_u__cpu_noc_req_if_req[0]                           = {{($bits(cpu_noc_u__cpu_noc_req_if_req[0])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_noc_req_if_req_valid[0]                     = {{($bits(cpu_noc_u__cpu_noc_req_if_req_valid[0])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.cpu_noc_req_if[2] <-> 'b0
  assign cpu_noc_u__cpu_noc_req_if_req[2]                           = {{($bits(cpu_noc_u__cpu_noc_req_if_req[2])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_noc_req_if_req_valid[2]                     = {{($bits(cpu_noc_u__cpu_noc_req_if_req_valid[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.cpu_noc_req_if[3] <-> 'b0
  assign cpu_noc_u__cpu_noc_req_if_req[3]                           = {{($bits(cpu_noc_u__cpu_noc_req_if_req[3])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_noc_req_if_req_valid[3]                     = {{($bits(cpu_noc_u__cpu_noc_req_if_req_valid[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.cpu_noc_req_if[4] <-> 'b0
  assign cpu_noc_u__cpu_noc_req_if_req[4]                           = {{($bits(cpu_noc_u__cpu_noc_req_if_req[4])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__cpu_noc_req_if_req_valid[4]                     = {{($bits(cpu_noc_u__cpu_noc_req_if_req_valid[4])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // cpu_noc_u.l2_amo_store[2] <-> 'b0
  assign cpu_noc_u__l2_amo_store_req_ready[2]                       = {{($bits(cpu_noc_u__l2_amo_store_req_ready[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // cpu_noc_u.l2_amo_store[3] <-> 'b0
  assign cpu_noc_u__l2_amo_store_req_ready[3]                       = {{($bits(cpu_noc_u__l2_amo_store_req_ready[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // cpu_noc_u.l2_noc[2] <-> 'b0
  assign cpu_noc_u__l2_noc_resp[2]                                  = {{($bits(cpu_noc_u__l2_noc_resp[2])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__l2_noc_resp_valid[2]                            = {{($bits(cpu_noc_u__l2_noc_resp_valid[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // cpu_noc_u.l2_noc[3] <-> 'b0
  assign cpu_noc_u__l2_noc_resp[3]                                  = {{($bits(cpu_noc_u__l2_noc_resp[3])-1){1'b0}}, 1'b0};
  assign cpu_noc_u__l2_noc_resp_valid[3]                            = {{($bits(cpu_noc_u__l2_noc_resp_valid[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_ORV32
  // cpu_noc_u.noc_cpu_resp_if[0] <-> 'b0
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[0]                   = {{($bits(cpu_noc_u__noc_cpu_resp_if_resp_ready[0])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.noc_cpu_resp_if[2] <-> 'b0
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[2]                   = {{($bits(cpu_noc_u__noc_cpu_resp_if_resp_ready[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.noc_cpu_resp_if[3] <-> 'b0
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[3]                   = {{($bits(cpu_noc_u__noc_cpu_resp_if_resp_ready[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SINGLE_VP
  // cpu_noc_u.noc_cpu_resp_if[4] <-> 'b0
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[4]                   = {{($bits(cpu_noc_u__noc_cpu_resp_if_resp_ready[4])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // cpu_noc_u.noc_l2[2] <-> 'b0
  assign cpu_noc_u__noc_l2_req_ready[2]                             = {{($bits(cpu_noc_u__noc_l2_req_ready[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // cpu_noc_u.noc_l2[3] <-> 'b0
  assign cpu_noc_u__noc_l2_req_ready[3]                             = {{($bits(cpu_noc_u__noc_l2_req_ready[3])-1){1'b0}}, 1'b0};
  `endif

  // cpu_noc_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign cpu_noc_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  `ifndef IFNDEF_TB_USE_CPU_NOC
  // cpu_noc_u/entry_vld_pbank <-> 'b0
  assign cpu_noc_u__entry_vld_pbank                                 = {{($bits(cpu_noc_u__entry_vld_pbank)-1){1'b0}}, 1'b0};
  `endif

  `ifndef IFNDEF_TB_USE_CPU_NOC
  // cpu_noc_u/is_oldest_pbank <-> 'b0
  assign cpu_noc_u__is_oldest_pbank                                 = {{($bits(cpu_noc_u__is_oldest_pbank)-1){1'b0}}, 1'b0};
  `endif

  // cpu_noc_u/rstn <-> cpu_noc_rstn_sync_u/rstn_out
  assign cpu_noc_u__rstn                                            = cpu_noc_rstn_sync_u__rstn_out;

  // ddr_bypass_clk_div_u/dft_en <-> soc_top/dft_mode
  assign ddr_bypass_clk_div_u__dft_en                               = soc_top__dft_mode;

  // ddr_bypass_clk_div_u/divclk_sel <-> ddr_bypass_en_sync_u/q
  assign ddr_bypass_clk_div_u__divclk_sel                           = ddr_bypass_en_sync_u__q;

  // ddr_bypass_clk_div_u/refclk <-> ddr_slow_clk_div_u/divclk
  assign ddr_bypass_clk_div_u__refclk                               = ddr_slow_clk_div_u__divclk;

  // ddr_bypass_en_sync_u/clk <-> ddr_slow_clk_div_u/divclk
  assign ddr_bypass_en_sync_u__clk                                  = ddr_slow_clk_div_u__divclk;

  // ddr_bypass_en_sync_u/d <-> byp_station_u/out_s2b_ddr_bypass_en
  assign ddr_bypass_en_sync_u__d                                    = byp_station_u__out_s2b_ddr_bypass_en;

  // ddr_clk_mux_u/clk0 <-> ddr_slow_clk_div_u/divclk
  assign ddr_clk_mux_u__clk0                                        = ddr_slow_clk_div_u__divclk;

  // ddr_clk_mux_u/clk1 <-> ddr_bypass_clk_div_u/divclk
  assign ddr_clk_mux_u__clk1                                        = ddr_bypass_clk_div_u__divclk;

  // ddr_clk_mux_u/clk_out <-> ddr_ls_rstn_sync_u/clk
  assign ddr_ls_rstn_sync_u__clk                                    = ddr_clk_mux_u__clk_out;

  // ddr_clk_mux_u/clk_out <-> oursring_cdc_byp2ddr_u/master_clk
  assign oursring_cdc_byp2ddr_u__master_clk                         = ddr_clk_mux_u__clk_out;

  

  // ddr_ddrls_clkdiv_sel_sync_u/d <-> byp_station_u/out_s2b_ddrls_clkdiv_divclk_sel
  assign ddr_ddrls_clkdiv_sel_sync_u__d                             = byp_station_u__out_s2b_ddrls_clkdiv_divclk_sel;

  // ddr_ddrls_clkdiv_sel_sync_u/q <-> dft_ddrls_clkdiv_sel_mux_sel_u/sel_in
  assign dft_ddrls_clkdiv_sel_mux_sel_u__sel_in                     = ddr_ddrls_clkdiv_sel_sync_u__q;

  // ddr_ls_rstn_sync_u/rstn_out <-> oursring_cdc_ddr2io_u/slave_resetn
  assign oursring_cdc_ddr2io_u__slave_resetn                        = ddr_ls_rstn_sync_u__rstn_out;

  // ddr_slow_clk_div_u/dft_en <-> soc_top/dft_mode
  assign ddr_slow_clk_div_u__dft_en                                 = soc_top__dft_mode;

  // ddr_slow_clk_div_u/divclk_sel <-> dft_ddrls_clkdiv_sel_mux_sel_u/sel_out
  assign ddr_slow_clk_div_u__divclk_sel                             = dft_ddrls_clkdiv_sel_mux_sel_u__sel_out;

  // ddr_slow_clk_div_u/half_div_less_1 <-> byp_station_u/out_s2b_ddrls_clkdiv_half_div_less_1
  assign ddr_slow_clk_div_u__half_div_less_1                        = byp_station_u__out_s2b_ddrls_clkdiv_half_div_less_1;

  // ddr_slow_clk_div_u/refclk <-> ddr_top_icg_u/clkg
  assign ddr_slow_clk_div_u__refclk                                 = ddr_top_icg_u__clkg;

  `ifdef IFDEF_ZEBU_SRAM_DDR
  // ddr_sram_top_u.req_if <-> mem_noc_ddr_cdc_u.cdc2ddr_req_if
  assign ddr_sram_top_u__req_if_ar                                  = mem_noc_ddr_cdc_u__cdc2ddr_req_if_ar;
  assign ddr_sram_top_u__req_if_arvalid                             = mem_noc_ddr_cdc_u__cdc2ddr_req_if_arvalid;
  assign ddr_sram_top_u__req_if_aw                                  = mem_noc_ddr_cdc_u__cdc2ddr_req_if_aw;
  assign ddr_sram_top_u__req_if_awvalid                             = mem_noc_ddr_cdc_u__cdc2ddr_req_if_awvalid;
  assign ddr_sram_top_u__req_if_w                                   = mem_noc_ddr_cdc_u__cdc2ddr_req_if_w;
  assign ddr_sram_top_u__req_if_wvalid                              = mem_noc_ddr_cdc_u__cdc2ddr_req_if_wvalid;
  assign mem_noc_ddr_cdc_u__cdc2ddr_req_if_arready                  = ddr_sram_top_u__req_if_arready;
  assign mem_noc_ddr_cdc_u__cdc2ddr_req_if_awready                  = ddr_sram_top_u__req_if_awready;
  assign mem_noc_ddr_cdc_u__cdc2ddr_req_if_wready                   = ddr_sram_top_u__req_if_wready;
  `endif

  `ifdef IFDEF_ZEBU_SRAM_DDR
  // ddr_sram_top_u.rsp_if <-> mem_noc_ddr_cdc_u.ddr2cdc_rsp_if
  assign ddr_sram_top_u__rsp_if_bready                              = mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bready;
  assign ddr_sram_top_u__rsp_if_rready                              = mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rready;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_b                        = ddr_sram_top_u__rsp_if_b;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bvalid                   = ddr_sram_top_u__rsp_if_bvalid;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_r                        = ddr_sram_top_u__rsp_if_r;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rvalid                   = ddr_sram_top_u__rsp_if_rvalid;
  `endif

  `ifdef IFDEF_ZEBU_SRAM_DDR
  // ddr_sram_top_u/clk <-> ddr_clk_mux_u/clk_out
  assign ddr_sram_top_u__clk                                        = ddr_clk_mux_u__clk_out;
  `endif

  `ifdef IFDEF_ZEBU_SRAM_DDR
  // ddr_sram_top_u/rst_n <-> soc_top/chip_resetn
  assign ddr_sram_top_u__rst_n                                      = soc_top__chip_resetn;
  `endif

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // ddr_station_u.i_req_local_if <-> 'b0
  assign ddr_station_u__i_req_local_if_ar                           = {{($bits(ddr_station_u__i_req_local_if_ar)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_req_local_if_arvalid                      = {{($bits(ddr_station_u__i_req_local_if_arvalid)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_req_local_if_aw                           = {{($bits(ddr_station_u__i_req_local_if_aw)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_req_local_if_awvalid                      = {{($bits(ddr_station_u__i_req_local_if_awvalid)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_req_local_if_w                            = {{($bits(ddr_station_u__i_req_local_if_w)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_req_local_if_wvalid                       = {{($bits(ddr_station_u__i_req_local_if_wvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_DDR
  // ddr_station_u.i_resp_local_if <-> 'b0
  assign ddr_station_u__i_resp_local_if_b                           = {{($bits(ddr_station_u__i_resp_local_if_b)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_resp_local_if_bvalid                      = {{($bits(ddr_station_u__i_resp_local_if_bvalid)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_resp_local_if_r                           = {{($bits(ddr_station_u__i_resp_local_if_r)-1){1'b0}}, 1'b0};
  assign ddr_station_u__i_resp_local_if_rvalid                      = {{($bits(ddr_station_u__i_resp_local_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_station_u.i_resp_local_if <-> oursring_ddr_cdc_u.cdc_oursring_rsp_if
  assign ddr_station_u__i_resp_local_if_b                           = oursring_ddr_cdc_u__cdc_oursring_rsp_if_b;
  assign ddr_station_u__i_resp_local_if_bvalid                      = oursring_ddr_cdc_u__cdc_oursring_rsp_if_bvalid;
  assign ddr_station_u__i_resp_local_if_r                           = oursring_ddr_cdc_u__cdc_oursring_rsp_if_r;
  assign ddr_station_u__i_resp_local_if_rvalid                      = oursring_ddr_cdc_u__cdc_oursring_rsp_if_rvalid;
  assign oursring_ddr_cdc_u__cdc_oursring_rsp_if_bready             = ddr_station_u__i_resp_local_if_bready;
  assign oursring_ddr_cdc_u__cdc_oursring_rsp_if_rready             = ddr_station_u__i_resp_local_if_rready;
  `endif

  // ddr_station_u.i_resp_ring_if <-> oursring_cdc_ddr2io_u.cdc_oursring_slave_rsp_if
  assign ddr_station_u__i_resp_ring_if_b                            = oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_b;
  assign ddr_station_u__i_resp_ring_if_bvalid                       = oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_bvalid;
  assign ddr_station_u__i_resp_ring_if_r                            = oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_r;
  assign ddr_station_u__i_resp_ring_if_rvalid                       = oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_rvalid;
  assign oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_bready    = ddr_station_u__i_resp_ring_if_bready;
  assign oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_rready    = ddr_station_u__i_resp_ring_if_rready;

  `ifdef IFDEF_NO_DDR
  // ddr_station_u.in_b2s <-> 'b0
  assign ddr_station_u__in_b2s_BypassInDataAC                       = {{($bits(ddr_station_u__in_b2s_BypassInDataAC)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_BypassInDataDAT                      = {{($bits(ddr_station_u__in_b2s_BypassInDataDAT)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_BypassInDataMASTER                   = {{($bits(ddr_station_u__in_b2s_BypassInDataMASTER)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_cactive_0                            = {{($bits(ddr_station_u__in_b2s_cactive_0)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_cactive_ddrc                         = {{($bits(ddr_station_u__in_b2s_cactive_ddrc)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_csysack_0                            = {{($bits(ddr_station_u__in_b2s_csysack_0)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_csysack_ddrc                         = {{($bits(ddr_station_u__in_b2s_csysack_ddrc)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_dfi_alert_err_intr                   = {{($bits(ddr_station_u__in_b2s_dfi_alert_err_intr)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_dfi_reset_n_ref                      = {{($bits(ddr_station_u__in_b2s_dfi_reset_n_ref)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_hif_refresh_req_bank                 = {{($bits(ddr_station_u__in_b2s_hif_refresh_req_bank)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_init_mr_done_out                     = {{($bits(ddr_station_u__in_b2s_init_mr_done_out)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_rd_mrr_data                          = {{($bits(ddr_station_u__in_b2s_rd_mrr_data)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_rd_mrr_data_valid                    = {{($bits(ddr_station_u__in_b2s_rd_mrr_data_valid)-1){1'b0}}, 1'b0};
  assign ddr_station_u__in_b2s_stat_ddrc_reg_selfref_type           = {{($bits(ddr_station_u__in_b2s_stat_ddrc_reg_selfref_type)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_DDR
  // ddr_station_u.o_req_local_if <-> 'b0
  assign ddr_station_u__o_req_local_if_arready                      = {{($bits(ddr_station_u__o_req_local_if_arready)-1){1'b0}}, 1'b0};
  assign ddr_station_u__o_req_local_if_awready                      = {{($bits(ddr_station_u__o_req_local_if_awready)-1){1'b0}}, 1'b0};
  assign ddr_station_u__o_req_local_if_wready                       = {{($bits(ddr_station_u__o_req_local_if_wready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_station_u.o_req_local_if <-> oursring_ddr_cdc_u.oursring_cdc_req_if
  assign ddr_station_u__o_req_local_if_arready                      = oursring_ddr_cdc_u__oursring_cdc_req_if_arready;
  assign ddr_station_u__o_req_local_if_awready                      = oursring_ddr_cdc_u__oursring_cdc_req_if_awready;
  assign ddr_station_u__o_req_local_if_wready                       = oursring_ddr_cdc_u__oursring_cdc_req_if_wready;
  assign oursring_ddr_cdc_u__oursring_cdc_req_if_ar                 = ddr_station_u__o_req_local_if_ar;
  assign oursring_ddr_cdc_u__oursring_cdc_req_if_arvalid            = ddr_station_u__o_req_local_if_arvalid;
  assign oursring_ddr_cdc_u__oursring_cdc_req_if_aw                 = ddr_station_u__o_req_local_if_aw;
  assign oursring_ddr_cdc_u__oursring_cdc_req_if_awvalid            = ddr_station_u__o_req_local_if_awvalid;
  assign oursring_ddr_cdc_u__oursring_cdc_req_if_w                  = ddr_station_u__o_req_local_if_w;
  assign oursring_ddr_cdc_u__oursring_cdc_req_if_wvalid             = ddr_station_u__o_req_local_if_wvalid;
  `endif

  // ddr_station_u.o_req_ring_if <-> oursring_cdc_ddr2io_u.oursring_cdc_slave_req_if
  assign ddr_station_u__o_req_ring_if_arready                       = oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_arready;
  assign ddr_station_u__o_req_ring_if_awready                       = oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_awready;
  assign ddr_station_u__o_req_ring_if_wready                        = oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_wready;
  assign oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_ar        = ddr_station_u__o_req_ring_if_ar;
  assign oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_arvalid   = ddr_station_u__o_req_ring_if_arvalid;
  assign oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_aw        = ddr_station_u__o_req_ring_if_aw;
  assign oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_awvalid   = ddr_station_u__o_req_ring_if_awvalid;
  assign oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_w         = ddr_station_u__o_req_ring_if_w;
  assign oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_wvalid    = ddr_station_u__o_req_ring_if_wvalid;

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // ddr_station_u.o_resp_local_if <-> 'b0
  assign ddr_station_u__o_resp_local_if_bready                      = {{($bits(ddr_station_u__o_resp_local_if_bready)-1){1'b0}}, 1'b0};
  assign ddr_station_u__o_resp_local_if_rready                      = {{($bits(ddr_station_u__o_resp_local_if_rready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_DDR
  // ddr_station_u.vld_in_b2s <-> 'b0
  assign ddr_station_u__vld_in_b2s_BypassInDataAC                   = {{($bits(ddr_station_u__vld_in_b2s_BypassInDataAC)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_BypassInDataDAT                  = {{($bits(ddr_station_u__vld_in_b2s_BypassInDataDAT)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_BypassInDataMASTER               = {{($bits(ddr_station_u__vld_in_b2s_BypassInDataMASTER)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_cactive_0                        = {{($bits(ddr_station_u__vld_in_b2s_cactive_0)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_cactive_ddrc                     = {{($bits(ddr_station_u__vld_in_b2s_cactive_ddrc)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_csysack_0                        = {{($bits(ddr_station_u__vld_in_b2s_csysack_0)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_csysack_ddrc                     = {{($bits(ddr_station_u__vld_in_b2s_csysack_ddrc)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_dfi_alert_err_intr               = {{($bits(ddr_station_u__vld_in_b2s_dfi_alert_err_intr)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_dfi_reset_n_ref                  = {{($bits(ddr_station_u__vld_in_b2s_dfi_reset_n_ref)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_hif_refresh_req_bank             = {{($bits(ddr_station_u__vld_in_b2s_hif_refresh_req_bank)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_init_mr_done_out                 = {{($bits(ddr_station_u__vld_in_b2s_init_mr_done_out)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_rd_mrr_data                      = {{($bits(ddr_station_u__vld_in_b2s_rd_mrr_data)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_rd_mrr_data_valid                = {{($bits(ddr_station_u__vld_in_b2s_rd_mrr_data_valid)-1){1'b0}}, 1'b0};
  assign ddr_station_u__vld_in_b2s_stat_ddrc_reg_selfref_type       = {{($bits(ddr_station_u__vld_in_b2s_stat_ddrc_reg_selfref_type)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_station_u.vld_in_b2s <-> ddr_station_u/out_debug_info_enable
  assign ddr_station_u__vld_in_b2s_BypassInDataAC                   = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_BypassInDataDAT                  = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_BypassInDataMASTER               = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_cactive_0                        = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_cactive_ddrc                     = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_csysack_0                        = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_csysack_ddrc                     = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_dfi_alert_err_intr               = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_dfi_reset_n_ref                  = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_hif_refresh_req_bank             = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_init_mr_done_out                 = ddr_station_u__out_debug_info_enable;
  assign ddr_station_u__vld_in_b2s_stat_ddrc_reg_selfref_type       = ddr_station_u__out_debug_info_enable;
  `endif

  // ddr_station_u/clk <-> ddr_clk_mux_u/clk_out
  assign ddr_station_u__clk                                         = ddr_clk_mux_u__clk_out;

  `ifdef IFNDEF_NO_DDR
  // ddr_station_u/out_ddr_pwr_on <-> ddr_iso_or_u/in_0
  assign ddr_iso_or_u__in_0                                         = ddr_station_u__out_ddr_pwr_on;
  `endif

  // ddr_station_u/rstn <-> ddr_ls_rstn_sync_u/rstn_out
  assign ddr_station_u__rstn                                        = ddr_ls_rstn_sync_u__rstn_out;

  `ifdef IFNDEF_NO_DDR
  // ddr_station_u/vld_in_b2s_rd_mrr_data <-> ddr_top_u/b2s_rd_mrr_data_valid
  assign ddr_station_u__vld_in_b2s_rd_mrr_data                      = ddr_top_u__b2s_rd_mrr_data_valid;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_station_u/vld_in_b2s_rd_mrr_data_valid <-> ddr_top_u/b2s_rd_mrr_data_valid
  assign ddr_station_u__vld_in_b2s_rd_mrr_data_valid                = ddr_top_u__b2s_rd_mrr_data_valid;
  `endif

  // ddr_top_icg_u/clk <-> dft_pllclk_clk_buf_u1/out
  assign ddr_top_icg_u__clk                                         = dft_pllclk_clk_buf_u1__out;

  // ddr_top_icg_u/en <-> byp_station_u/out_s2b_ddr_top_icg_en
  assign ddr_top_icg_u__en                                          = byp_station_u__out_s2b_ddr_top_icg_en;

  // ddr_top_icg_u/tst_en <-> soc_top/dft_mode
  assign ddr_top_icg_u__tst_en                                      = soc_top__dft_mode;

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u.apb <-> oursring_ddr_cdc_u.cdc_apb
  assign ddr_top_u__apb_paddr                                       = oursring_ddr_cdc_u__cdc_apb_paddr;
  assign ddr_top_u__apb_penable                                     = oursring_ddr_cdc_u__cdc_apb_penable;
  assign ddr_top_u__apb_psel_s0                                     = oursring_ddr_cdc_u__cdc_apb_psel_s0;
  assign ddr_top_u__apb_pwdata                                      = oursring_ddr_cdc_u__cdc_apb_pwdata;
  assign ddr_top_u__apb_pwrite                                      = oursring_ddr_cdc_u__cdc_apb_pwrite;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u.b2s <-> ddr_station_u.in_b2s
  assign ddr_station_u__in_b2s_BypassInDataAC                       = ddr_top_u__b2s_BypassInDataAC;
  assign ddr_station_u__in_b2s_BypassInDataDAT                      = ddr_top_u__b2s_BypassInDataDAT;
  assign ddr_station_u__in_b2s_BypassInDataMASTER                   = ddr_top_u__b2s_BypassInDataMASTER;
  assign ddr_station_u__in_b2s_cactive_0                            = ddr_top_u__b2s_cactive_0;
  assign ddr_station_u__in_b2s_cactive_ddrc                         = ddr_top_u__b2s_cactive_ddrc;
  assign ddr_station_u__in_b2s_csysack_0                            = ddr_top_u__b2s_csysack_0;
  assign ddr_station_u__in_b2s_csysack_ddrc                         = ddr_top_u__b2s_csysack_ddrc;
  assign ddr_station_u__in_b2s_dfi_alert_err_intr                   = ddr_top_u__b2s_dfi_alert_err_intr;
  assign ddr_station_u__in_b2s_dfi_reset_n_ref                      = ddr_top_u__b2s_dfi_reset_n_ref;
  assign ddr_station_u__in_b2s_hif_refresh_req_bank                 = ddr_top_u__b2s_hif_refresh_req_bank;
  assign ddr_station_u__in_b2s_init_mr_done_out                     = ddr_top_u__b2s_init_mr_done_out;
  assign ddr_station_u__in_b2s_rd_mrr_data                          = ddr_top_u__b2s_rd_mrr_data;
  assign ddr_station_u__in_b2s_rd_mrr_data_valid                    = ddr_top_u__b2s_rd_mrr_data_valid;
  assign ddr_station_u__in_b2s_stat_ddrc_reg_selfref_type           = ddr_top_u__b2s_stat_ddrc_reg_selfref_type;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u.cdc <-> oursring_ddr_cdc_u.apb_cdc
  assign oursring_ddr_cdc_u__apb_cdc_prdata                         = ddr_top_u__cdc_prdata;
  assign oursring_ddr_cdc_u__apb_cdc_pready                         = ddr_top_u__cdc_pready;
  assign oursring_ddr_cdc_u__apb_cdc_pslverr                        = ddr_top_u__cdc_pslverr;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u.req_if <-> mem_noc_ddr_cdc_u.cdc2ddr_req_if
  assign ddr_top_u__req_if_ar                                       = mem_noc_ddr_cdc_u__cdc2ddr_req_if_ar;
  assign ddr_top_u__req_if_arvalid                                  = mem_noc_ddr_cdc_u__cdc2ddr_req_if_arvalid;
  assign ddr_top_u__req_if_aw                                       = mem_noc_ddr_cdc_u__cdc2ddr_req_if_aw;
  assign ddr_top_u__req_if_awvalid                                  = mem_noc_ddr_cdc_u__cdc2ddr_req_if_awvalid;
  assign ddr_top_u__req_if_w                                        = mem_noc_ddr_cdc_u__cdc2ddr_req_if_w;
  assign ddr_top_u__req_if_wvalid                                   = mem_noc_ddr_cdc_u__cdc2ddr_req_if_wvalid;
  assign mem_noc_ddr_cdc_u__cdc2ddr_req_if_arready                  = ddr_top_u__req_if_arready;
  assign mem_noc_ddr_cdc_u__cdc2ddr_req_if_awready                  = ddr_top_u__req_if_awready;
  assign mem_noc_ddr_cdc_u__cdc2ddr_req_if_wready                   = ddr_top_u__req_if_wready;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u.rsp_if <-> mem_noc_ddr_cdc_u.ddr2cdc_rsp_if
  assign ddr_top_u__rsp_if_bready                                   = mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bready;
  assign ddr_top_u__rsp_if_rready                                   = mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rready;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_b                        = ddr_top_u__rsp_if_b;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bvalid                   = ddr_top_u__rsp_if_bvalid;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_r                        = ddr_top_u__rsp_if_r;
  assign mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rvalid                   = ddr_top_u__rsp_if_rvalid;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/aclk_0 <-> ddr_clk_mux_u/clk_out
  assign ddr_top_u__aclk_0                                          = ddr_clk_mux_u__clk_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/atpg_Pclk <-> 'b0
  assign ddr_top_u__atpg_Pclk                                       = {{($bits(ddr_top_u__atpg_Pclk)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/atpg_RDQSClk <-> 'b0
  assign ddr_top_u__atpg_RDQSClk                                    = {{($bits(ddr_top_u__atpg_RDQSClk)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/atpg_TxDllClk <-> 'b0
  assign ddr_top_u__atpg_TxDllClk                                   = {{($bits(ddr_top_u__atpg_TxDllClk)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/atpg_se[1] <-> 'b0
  assign ddr_top_u__atpg_se[1]                                      = {{($bits(ddr_top_u__atpg_se[1])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/atpg_se[2] <-> 'b0
  assign ddr_top_u__atpg_se[2]                                      = {{($bits(ddr_top_u__atpg_se[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/atpg_se[3] <-> 'b0
  assign ddr_top_u__atpg_se[3]                                      = {{($bits(ddr_top_u__atpg_se[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/atpg_si <-> 'b0
  assign ddr_top_u__atpg_si                                         = {{($bits(ddr_top_u__atpg_si)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/core_ddrc_core_clk <-> ddr_clk_mux_u/clk_out
  assign ddr_top_u__core_ddrc_core_clk                              = ddr_clk_mux_u__clk_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/pclk <-> ddr_clk_mux_u/clk_out
  assign ddr_top_u__pclk                                            = ddr_clk_mux_u__clk_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/s2b_csysreq_0 <-> ddr_station_u/out_s2b_csysreq_0
  assign ddr_top_u__s2b_csysreq_0                                   = ddr_station_u__out_s2b_csysreq_0;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/s2b_csysreq_ddrc <-> ddr_station_u/out_s2b_csysreq_ddrc
  assign ddr_top_u__s2b_csysreq_ddrc                                = ddr_station_u__out_s2b_csysreq_ddrc;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/s2b_dfi_ctrlupd_ack2_ch0 <-> ddr_station_u/out_s2b_dfi_ctrlupd_ack2_ch0
  assign ddr_top_u__s2b_dfi_ctrlupd_ack2_ch0                        = ddr_station_u__out_s2b_dfi_ctrlupd_ack2_ch0;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/s2b_init_mr_done_in <-> ddr_station_u/out_s2b_init_mr_done_in
  assign ddr_top_u__s2b_init_mr_done_in                             = ddr_station_u__out_s2b_init_mr_done_in;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/s2b_pa_rmask <-> ddr_station_u/out_s2b_pa_rmask
  assign ddr_top_u__s2b_pa_rmask                                    = ddr_station_u__out_s2b_pa_rmask;
  `endif

  `ifdef IFNDEF_NO_DDR
  // ddr_top_u/s2b_pa_wmask <-> ddr_station_u/out_s2b_pa_wmask
  assign ddr_top_u__s2b_pa_wmask                                    = ddr_station_u__out_s2b_pa_wmask;
  `endif

  // dft_bank0_rstn_mux_u/din0 <-> bank0_station_u/out_s2b_rstn
  assign dft_bank0_rstn_mux_u__din0                                 = bank0_station_u__out_s2b_rstn;

  // dft_bank0_rstn_mux_u/dout <-> bank0_da_u/rstn
  assign bank0_da_u__rstn                                           = dft_bank0_rstn_mux_u__dout;

  // dft_bank0_rstn_mux_u/dout <-> bank0_u/s2b_rstn
  assign bank0_u__s2b_rstn                                          = dft_bank0_rstn_mux_u__dout;

  // dft_bank1_rstn_mux_u/din0 <-> bank1_station_u/out_s2b_rstn
  assign dft_bank1_rstn_mux_u__din0                                 = bank1_station_u__out_s2b_rstn;

  // dft_bank1_rstn_mux_u/dout <-> bank1_da_u/rstn
  assign bank1_da_u__rstn                                           = dft_bank1_rstn_mux_u__dout;

  // dft_bank1_rstn_mux_u/dout <-> bank1_u/s2b_rstn
  assign bank1_u__s2b_rstn                                          = dft_bank1_rstn_mux_u__dout;

  `ifdef IFNDEF_SOC_NO_BANK2
  // dft_bank2_rstn_mux_u/din0 <-> bank2_station_u/out_s2b_rstn
  assign dft_bank2_rstn_mux_u__din0                                 = bank2_station_u__out_s2b_rstn;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // dft_bank2_rstn_mux_u/dout <-> bank2_da_u/rstn
  assign bank2_da_u__rstn                                           = dft_bank2_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK2
  // dft_bank2_rstn_mux_u/dout <-> bank2_u/s2b_rstn
  assign bank2_u__s2b_rstn                                          = dft_bank2_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // dft_bank3_rstn_mux_u/din0 <-> bank3_station_u/out_s2b_rstn
  assign dft_bank3_rstn_mux_u__din0                                 = bank3_station_u__out_s2b_rstn;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // dft_bank3_rstn_mux_u/dout <-> bank3_da_u/rstn
  assign bank3_da_u__rstn                                           = dft_bank3_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // dft_bank3_rstn_mux_u/dout <-> bank3_u/s2b_rstn
  assign bank3_u__s2b_rstn                                          = dft_bank3_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_atpg_one_hot_u/DFT_ONE_HOT_APBClk <-> ddr_top_u/APBCLK
  assign ddr_top_u__APBCLK                                          = dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_APBClk;
  `endif

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_atpg_one_hot_u/DFT_ONE_HOT_DfiClk <-> ddr_top_u/DfiClk
  assign ddr_top_u__DfiClk                                          = dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_DfiClk;
  `endif

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_atpg_one_hot_u/DFT_ONE_HOT_DfiCtlClk <-> ddr_top_u/DfiCtlClk
  assign ddr_top_u__DfiCtlClk                                       = dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_DfiCtlClk;
  `endif

  // dft_ddr_atpg_one_hot_u/clk <-> ddr_clk_mux_u/clk_out
  assign dft_ddr_atpg_one_hot_u__clk                                = ddr_clk_mux_u__clk_out;

  // dft_ddr_atpg_one_hot_u/dft_ddr_APBClk <-> ddr_clk_mux_u/clk_out
  assign dft_ddr_atpg_one_hot_u__dft_ddr_APBClk                     = ddr_clk_mux_u__clk_out;

  // dft_ddr_atpg_one_hot_u/dft_ddr_DfiClk <-> ddr_clk_mux_u/clk_out
  assign dft_ddr_atpg_one_hot_u__dft_ddr_DfiClk                     = ddr_clk_mux_u__clk_out;

  // dft_ddr_atpg_one_hot_u/dft_ddr_DfiCtlClk <-> ddr_clk_mux_u/clk_out
  assign dft_ddr_atpg_one_hot_u__dft_ddr_DfiCtlClk                  = ddr_clk_mux_u__clk_out;

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_atpg_one_hot_u/rstn <-> dft_ddr_rstn_mux_core_ddrc_rstn_u/dout
  assign dft_ddr_atpg_one_hot_u__rstn                               = dft_ddr_rstn_mux_core_ddrc_rstn_u__dout;
  `endif

  // dft_ddr_clk_mux_sel_u/scan_mode <-> soc_top/dft_mode
  assign dft_ddr_clk_mux_sel_u__scan_mode                           = soc_top__dft_mode;

  // dft_ddr_clk_mux_sel_u/sel_in <-> ddr_bypass_en_sync_u/q
  assign dft_ddr_clk_mux_sel_u__sel_in                              = ddr_bypass_en_sync_u__q;

  // dft_ddr_clk_mux_sel_u/sel_out <-> ddr_clk_mux_u/sel
  assign ddr_clk_mux_u__sel                                         = dft_ddr_clk_mux_sel_u__sel_out;

  // dft_ddr_rstn_mux_aresetn_u/din0 <-> ddr_station_u/out_s2b_aresetn_0
  assign dft_ddr_rstn_mux_aresetn_u__din0                           = ddr_station_u__out_s2b_aresetn_0;

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_rstn_mux_aresetn_u/dout <-> ddr_top_u/s2b_aresetn_0
  assign ddr_top_u__s2b_aresetn_0                                   = dft_ddr_rstn_mux_aresetn_u__dout;
  `endif

  // dft_ddr_rstn_mux_core_ddrc_rstn_u/din0 <-> ddr_station_u/out_s2b_core_ddrc_rstn
  assign dft_ddr_rstn_mux_core_ddrc_rstn_u__din0                    = ddr_station_u__out_s2b_core_ddrc_rstn;

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_rstn_mux_core_ddrc_rstn_u/dout <-> ddr_top_u/s2b_core_ddrc_rstn
  assign ddr_top_u__s2b_core_ddrc_rstn                              = dft_ddr_rstn_mux_core_ddrc_rstn_u__dout;
  `endif

  // dft_ddr_rstn_mux_dfi_reset_n_u/din0 <-> ddr_station_u/out_s2b_dfi_reset_n_in
  assign dft_ddr_rstn_mux_dfi_reset_n_u__din0                       = ddr_station_u__out_s2b_dfi_reset_n_in;

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_rstn_mux_dfi_reset_n_u/dout <-> ddr_top_u/s2b_dfi_reset_n_in
  assign ddr_top_u__s2b_dfi_reset_n_in                              = dft_ddr_rstn_mux_dfi_reset_n_u__dout;
  `endif

  // dft_ddr_rstn_mux_presetn_u/din0 <-> ddr_station_u/out_s2b_presetn
  assign dft_ddr_rstn_mux_presetn_u__din0                           = ddr_station_u__out_s2b_presetn;

  `ifdef IFNDEF_NO_DDR
  // dft_ddr_rstn_mux_presetn_u/dout <-> ddr_top_u/s2b_presetn
  assign ddr_top_u__s2b_presetn                                     = dft_ddr_rstn_mux_presetn_u__dout;
  `endif

  // dft_mux_BypassModeEnAC_u/din0 <-> ddr_station_u/out_s2b_BypassModeEnAC
  assign dft_mux_BypassModeEnAC_u__din0                             = ddr_station_u__out_s2b_BypassModeEnAC;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassModeEnAC_u/dout <-> ddr_top_u/s2b_BypassModeEnAC
  assign ddr_top_u__s2b_BypassModeEnAC                              = dft_mux_BypassModeEnAC_u__dout;
  `endif

  // dft_mux_BypassModeEnDAT_u/din0 <-> ddr_station_u/out_s2b_BypassModeEnDAT
  assign dft_mux_BypassModeEnDAT_u__din0                            = ddr_station_u__out_s2b_BypassModeEnDAT;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassModeEnDAT_u/dout <-> ddr_top_u/s2b_BypassModeEnDAT
  assign ddr_top_u__s2b_BypassModeEnDAT                             = dft_mux_BypassModeEnDAT_u__dout;
  `endif

  // dft_mux_BypassModeEnMASTER_u/din0 <-> ddr_station_u/out_s2b_BypassModeEnMASTER
  assign dft_mux_BypassModeEnMASTER_u__din0                         = ddr_station_u__out_s2b_BypassModeEnMASTER;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassModeEnMASTER_u/dout <-> ddr_top_u/s2b_BypassModeEnMASTER
  assign ddr_top_u__s2b_BypassModeEnMASTER                          = dft_mux_BypassModeEnMASTER_u__dout;
  `endif

  // dft_mux_BypassOutDataAC_u/din0 <-> ddr_station_u/out_s2b_BypassOutDataAC
  assign dft_mux_BypassOutDataAC_u__din0                            = ddr_station_u__out_s2b_BypassOutDataAC;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassOutDataAC_u/dout <-> ddr_top_u/s2b_BypassOutDataAC
  assign ddr_top_u__s2b_BypassOutDataAC                             = dft_mux_BypassOutDataAC_u__dout;
  `endif

  // dft_mux_BypassOutDataDAT_u/din0 <-> ddr_station_u/out_s2b_BypassOutDataDAT
  assign dft_mux_BypassOutDataDAT_u__din0                           = ddr_station_u__out_s2b_BypassOutDataDAT;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassOutDataDAT_u/dout <-> ddr_top_u/s2b_BypassOutDataDAT
  assign ddr_top_u__s2b_BypassOutDataDAT                            = dft_mux_BypassOutDataDAT_u__dout;
  `endif

  // dft_mux_BypassOutDataMASTER_u/din0 <-> ddr_station_u/out_s2b_BypassOutDataMASTER
  assign dft_mux_BypassOutDataMASTER_u__din0                        = ddr_station_u__out_s2b_BypassOutDataMASTER;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassOutDataMASTER_u/dout <-> ddr_top_u/s2b_BypassOutDataMASTER
  assign ddr_top_u__s2b_BypassOutDataMASTER                         = dft_mux_BypassOutDataMASTER_u__dout;
  `endif

  // dft_mux_BypassOutEnAC_u/din0 <-> ddr_station_u/out_s2b_BypassOutEnAC
  assign dft_mux_BypassOutEnAC_u__din0                              = ddr_station_u__out_s2b_BypassOutEnAC;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassOutEnAC_u/dout <-> ddr_top_u/s2b_BypassOutEnAC
  assign ddr_top_u__s2b_BypassOutEnAC                               = dft_mux_BypassOutEnAC_u__dout;
  `endif

  // dft_mux_BypassOutEnDAT_u/din0 <-> ddr_station_u/out_s2b_BypassOutEnDAT
  assign dft_mux_BypassOutEnDAT_u__din0                             = ddr_station_u__out_s2b_BypassOutEnDAT;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassOutEnDAT_u/dout <-> ddr_top_u/s2b_BypassOutEnDAT
  assign ddr_top_u__s2b_BypassOutEnDAT                              = dft_mux_BypassOutEnDAT_u__dout;
  `endif

  // dft_mux_BypassOutEnMASTER_u/din0 <-> ddr_station_u/out_s2b_BypassOutEnMASTER
  assign dft_mux_BypassOutEnMASTER_u__din0                          = ddr_station_u__out_s2b_BypassOutEnMASTER;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_BypassOutEnMASTER_u/dout <-> ddr_top_u/s2b_BypassOutEnMASTER
  assign ddr_top_u__s2b_BypassOutEnMASTER                           = dft_mux_BypassOutEnMASTER_u__dout;
  `endif

  // dft_mux_ddr_s2b_pwr_ok_in_u/din0 <-> ddr_station_u/out_s2b_pwr_ok_in
  assign dft_mux_ddr_s2b_pwr_ok_in_u__din0                          = ddr_station_u__out_s2b_pwr_ok_in;

  `ifdef IFNDEF_NO_DDR
  // dft_mux_ddr_s2b_pwr_ok_in_u/dout <-> ddr_top_u/s2b_pwr_ok_in
  assign ddr_top_u__s2b_pwr_ok_in                                   = dft_mux_ddr_s2b_pwr_ok_in_u__dout;
  `endif

  // dft_mux_s2b_ref_ssp_en_u/din0 <-> usb_station_u/out_s2b_ref_ssp_en
  assign dft_mux_s2b_ref_ssp_en_u__din0                             = usb_station_u__out_s2b_ref_ssp_en;

  

  // dft_mux_s2b_ref_use_pad_u/din0 <-> usb_station_u/out_s2b_ref_use_pad
  assign dft_mux_s2b_ref_use_pad_u__din0                            = usb_station_u__out_s2b_ref_use_pad;

  

  // dft_mux_test_powerdown_hsp_u/din0 <-> usb_station_u/out_s2b_test_powerdown_hsp
  assign dft_mux_test_powerdown_hsp_u__din0                         = usb_station_u__out_s2b_test_powerdown_hsp;

  

  // dft_mux_test_powerdown_ssp_u/din0 <-> usb_station_u/out_s2b_test_powerdown_ssp
  assign dft_mux_test_powerdown_ssp_u__din0                         = usb_station_u__out_s2b_test_powerdown_ssp;

  

  

  

  // dft_orv32_rstn_mux_u/din0 <-> boot_mode_orv32_rstn_mux_u/dout
  assign dft_orv32_rstn_mux_u__din0                                 = boot_mode_orv32_rstn_mux_u__dout;

  

  // dft_phy_ddr_clk_u/clk_in <-> ddr_slow_clk_div_u/divclk
  assign dft_phy_ddr_clk_u__clk_in                                  = ddr_slow_clk_div_u__divclk;

  `ifdef IFNDEF_NO_DDR
  // dft_phy_ddr_clk_u/clk_out <-> ddr_top_u/phy_ddr_clk
  assign ddr_top_u__phy_ddr_clk                                     = dft_phy_ddr_clk_u__clk_out;
  `endif

  // dft_pllclk_clk_buf_u0/in <-> pll_u__clk_anchor_buf/out
  assign dft_pllclk_clk_buf_u0__in                                  = pll_u__clk_anchor_buf__out;

  // dft_pllclk_clk_buf_u0/out <-> bank0_rstn_sync_u/clk
  assign bank0_rstn_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> bank1_rstn_sync_u/clk
  assign bank1_rstn_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  `ifdef IFNDEF_SOC_NO_BANK2
  // dft_pllclk_clk_buf_u0/out <-> bank2_rstn_sync_u/clk
  assign bank2_rstn_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // dft_pllclk_clk_buf_u0/out <-> bank3_rstn_sync_u/clk
  assign bank3_rstn_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;
  `endif

  // dft_pllclk_clk_buf_u0/out <-> byp_rstn_sync_u/clk
  assign byp_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> cpu_noc_rstn_sync_u/clk
  assign cpu_noc_rstn_sync_u__clk                                   = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> ddr_hs_rstn_sync_u/clk
  assign ddr_hs_rstn_sync_u__clk                                    = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> dma_rstn_sync_u/clk
  assign dma_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> dt_rstn_sync_u/clk
  assign dt_rstn_sync_u__clk                                        = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> jtag2or_rstn_sync_u/clk
  assign jtag2or_rstn_sync_u__clk                                   = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> jtag2or_u/clk
  assign jtag2or_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> mem_noc_rstn_sync_u/clk
  assign mem_noc_rstn_sync_u__clk                                   = dft_pllclk_clk_buf_u0__out;

  

  // dft_pllclk_clk_buf_u0/out <-> oursring_cdc_byp2ddr_u/slave_clk
  assign oursring_cdc_byp2ddr_u__slave_clk                          = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> pll_rstn_sync_u/clk
  assign pll_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> rob_rstn_sync_u/clk
  assign rob_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> sdio_rstn_sync_u/clk
  assign sdio_rstn_sync_u__clk                                      = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> test_io_rstn_sync_u/clk
  assign test_io_rstn_sync_u__clk                                   = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> usb_rstn_sync_u/clk
  assign usb_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> vp0_rstn_sync_u/clk
  assign vp0_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> vp1_rstn_sync_u/clk
  assign vp1_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> vp2_rstn_sync_u/clk
  assign vp2_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u0/out <-> vp3_rstn_sync_u/clk
  assign vp3_rstn_sync_u__clk                                       = dft_pllclk_clk_buf_u0__out;

  // dft_pllclk_clk_buf_u1/in <-> pll_u__clk_anchor_buf/out
  assign dft_pllclk_clk_buf_u1__in                                  = pll_u__clk_anchor_buf__out;

  // dft_pllclk_clk_buf_u2/in <-> pll_u__clk_anchor_buf/out
  assign dft_pllclk_clk_buf_u2__in                                  = pll_u__clk_anchor_buf__out;

  // dft_scan_f_usb_clk_icg_u/en <-> 'b0
  assign dft_scan_f_usb_clk_icg_u__en                               = {{($bits(dft_scan_f_usb_clk_icg_u__en)-1){1'b0}}, 1'b0};

  // dft_scan_f_vp_clk_icg_u/en <-> 'b0
  assign dft_scan_f_vp_clk_icg_u__en                                = {{($bits(dft_scan_f_vp_clk_icg_u__en)-1){1'b0}}, 1'b0};

  // dft_sdio_resetn_u/din0 <-> sdio_station_u/out_s2b_resetn
  assign dft_sdio_resetn_u__din0                                    = sdio_station_u__out_s2b_resetn;

  

  // dft_usb_bus_clk_early_clk_mux_u/din0 <-> usb_pllclk_icg_u/clkg
  assign dft_usb_bus_clk_early_clk_mux_u__din0                      = usb_pllclk_icg_u__clkg;

  // dft_usb_bus_clk_early_clk_mux_u/din1 <-> dft_scan_f_usb_clk_icg_u/clkg
  assign dft_usb_bus_clk_early_clk_mux_u__din1                      = dft_scan_f_usb_clk_icg_u__clkg;

  

  

  // dft_usb_ram_clk_in_u/din1 <-> dft_scan_f_usb_clk_icg_u/clkg
  assign dft_usb_ram_clk_in_u__din1                                 = dft_scan_f_usb_clk_icg_u__clkg;

  

  // dft_usb_suspend_clk_mux_u/din0 <-> usb_refclk_icg_u/clkg
  assign dft_usb_suspend_clk_mux_u__din0                            = usb_refclk_icg_u__clkg;

  // dft_usb_suspend_clk_mux_u/din1 <-> dft_scan_f_usb_clk_icg_u/clkg
  assign dft_usb_suspend_clk_mux_u__din1                            = dft_scan_f_usb_clk_icg_u__clkg;

  

  // dft_usb_vaux_reset_n_u/din0 <-> usb_station_u/out_s2b_vaux_reset_n
  assign dft_usb_vaux_reset_n_u__din0                               = usb_station_u__out_s2b_vaux_reset_n;

  

  // dft_usb_vcc_reset_n_u/din0 <-> usb_station_u/out_s2b_vcc_reset_n
  assign dft_usb_vcc_reset_n_u__din0                                = usb_station_u__out_s2b_vcc_reset_n;

  

  // dft_vp0_clk_in_u/clk0 <-> vp0_icg_u/clkg
  assign dft_vp0_clk_in_u__clk0                                     = vp0_icg_u__clkg;

  // dft_vp0_clk_in_u/clk1 <-> dft_scan_f_vp_clk_icg_u/clkg
  assign dft_vp0_clk_in_u__clk1                                     = dft_scan_f_vp_clk_icg_u__clkg;

  // dft_vp0_clk_in_u/clk_out <-> vp0_u/clk
  assign vp0_u__clk                                                 = dft_vp0_clk_in_u__clk_out;

  // dft_vp0_clk_in_u/rstn <-> vp0_rstn_sync_u/rstn_out
  assign dft_vp0_clk_in_u__rstn                                     = vp0_rstn_sync_u__rstn_out;

  // dft_vp0_early_rstn_mux_u/din0 <-> vp0_station_u/out_s2b_early_rstn
  assign dft_vp0_early_rstn_mux_u__din0                             = vp0_station_u__out_s2b_early_rstn;

  // dft_vp0_early_rstn_mux_u/dout <-> vp0_u/s2b_early_rstn
  assign vp0_u__s2b_early_rstn                                      = dft_vp0_early_rstn_mux_u__dout;

  // dft_vp0_rstn_mux_u/din0 <-> vp0_station_u/out_s2b_rstn
  assign dft_vp0_rstn_mux_u__din0                                   = vp0_station_u__out_s2b_rstn;

  // dft_vp0_rstn_mux_u/dout <-> vp0_u/s2b_rstn
  assign vp0_u__s2b_rstn                                            = dft_vp0_rstn_mux_u__dout;

  // dft_vp1_clk_in_u/clk0 <-> vp1_icg_u/clkg
  assign dft_vp1_clk_in_u__clk0                                     = vp1_icg_u__clkg;

  // dft_vp1_clk_in_u/clk1 <-> dft_scan_f_vp_clk_icg_u/clkg
  assign dft_vp1_clk_in_u__clk1                                     = dft_scan_f_vp_clk_icg_u__clkg;

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp1_clk_in_u/clk_out <-> vp1_u/clk
  assign vp1_u__clk                                                 = dft_vp1_clk_in_u__clk_out;
  `endif

  // dft_vp1_clk_in_u/rstn <-> vp1_rstn_sync_u/rstn_out
  assign dft_vp1_clk_in_u__rstn                                     = vp1_rstn_sync_u__rstn_out;

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp1_early_rstn_mux_u/din0 <-> vp1_station_u/out_s2b_early_rstn
  assign dft_vp1_early_rstn_mux_u__din0                             = vp1_station_u__out_s2b_early_rstn;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp1_early_rstn_mux_u/dout <-> vp1_u/s2b_early_rstn
  assign vp1_u__s2b_early_rstn                                      = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp1_rstn_mux_u/din0 <-> vp1_station_u/out_s2b_rstn
  assign dft_vp1_rstn_mux_u__din0                                   = vp1_station_u__out_s2b_rstn;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp1_rstn_mux_u/dout <-> vp1_u/s2b_rstn
  assign vp1_u__s2b_rstn                                            = dft_vp1_rstn_mux_u__dout;
  `endif

  // dft_vp2_clk_in_u/clk0 <-> vp2_icg_u/clkg
  assign dft_vp2_clk_in_u__clk0                                     = vp2_icg_u__clkg;

  // dft_vp2_clk_in_u/clk1 <-> dft_scan_f_vp_clk_icg_u/clkg
  assign dft_vp2_clk_in_u__clk1                                     = dft_scan_f_vp_clk_icg_u__clkg;

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp2_clk_in_u/clk_out <-> vp2_u/clk
  assign vp2_u__clk                                                 = dft_vp2_clk_in_u__clk_out;
  `endif

  // dft_vp2_clk_in_u/rstn <-> vp2_rstn_sync_u/rstn_out
  assign dft_vp2_clk_in_u__rstn                                     = vp2_rstn_sync_u__rstn_out;

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp2_early_rstn_mux_u/din0 <-> vp2_station_u/out_s2b_early_rstn
  assign dft_vp2_early_rstn_mux_u__din0                             = vp2_station_u__out_s2b_early_rstn;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp2_early_rstn_mux_u/dout <-> vp2_u/s2b_early_rstn
  assign vp2_u__s2b_early_rstn                                      = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp2_rstn_mux_u/din0 <-> vp2_station_u/out_s2b_rstn
  assign dft_vp2_rstn_mux_u__din0                                   = vp2_station_u__out_s2b_rstn;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp2_rstn_mux_u/dout <-> vp2_u/s2b_rstn
  assign vp2_u__s2b_rstn                                            = dft_vp2_rstn_mux_u__dout;
  `endif

  // dft_vp3_clk_in_u/clk0 <-> vp3_icg_u/clkg
  assign dft_vp3_clk_in_u__clk0                                     = vp3_icg_u__clkg;

  // dft_vp3_clk_in_u/clk1 <-> dft_scan_f_vp_clk_icg_u/clkg
  assign dft_vp3_clk_in_u__clk1                                     = dft_scan_f_vp_clk_icg_u__clkg;

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp3_clk_in_u/clk_out <-> vp3_u/clk
  assign vp3_u__clk                                                 = dft_vp3_clk_in_u__clk_out;
  `endif

  // dft_vp3_clk_in_u/rstn <-> vp3_rstn_sync_u/rstn_out
  assign dft_vp3_clk_in_u__rstn                                     = vp3_rstn_sync_u__rstn_out;

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp3_early_rstn_mux_u/din0 <-> vp3_station_u/out_s2b_early_rstn
  assign dft_vp3_early_rstn_mux_u__din0                             = vp3_station_u__out_s2b_early_rstn;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp3_early_rstn_mux_u/dout <-> vp3_u/s2b_early_rstn
  assign vp3_u__s2b_early_rstn                                      = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp3_rstn_mux_u/din0 <-> vp3_station_u/out_s2b_rstn
  assign dft_vp3_rstn_mux_u__din0                                   = vp3_station_u__out_s2b_rstn;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // dft_vp3_rstn_mux_u/dout <-> vp3_u/s2b_rstn
  assign vp3_u__s2b_rstn                                            = dft_vp3_rstn_mux_u__dout;
  `endif

  // dma_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign dma_icg_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  // dma_icg_u/en <-> dma_station_u/out_s2icg_clk_en
  assign dma_icg_u__en                                              = dma_station_u__out_s2icg_clk_en;

  // dma_icg_u/tst_en <-> 'b0
  assign dma_icg_u__tst_en                                          = {{($bits(dma_icg_u__tst_en)-1){1'b0}}, 1'b0};

  // dma_station_u.i_req_local_if <-> dma_u.o_req_if
  assign dma_station_u__i_req_local_if_ar                           = dma_u__o_req_if_ar;
  assign dma_station_u__i_req_local_if_arvalid                      = dma_u__o_req_if_arvalid;
  assign dma_station_u__i_req_local_if_aw                           = dma_u__o_req_if_aw;
  assign dma_station_u__i_req_local_if_awvalid                      = dma_u__o_req_if_awvalid;
  assign dma_station_u__i_req_local_if_w                            = dma_u__o_req_if_w;
  assign dma_station_u__i_req_local_if_wvalid                       = dma_u__o_req_if_wvalid;
  assign dma_u__o_req_if_arready                                    = dma_station_u__i_req_local_if_arready;
  assign dma_u__o_req_if_awready                                    = dma_station_u__i_req_local_if_awready;
  assign dma_u__o_req_if_wready                                     = dma_station_u__i_req_local_if_wready;

  // dma_station_u.i_resp_local_if <-> dma_u.o_rsp_if
  assign dma_station_u__i_resp_local_if_b                           = dma_u__o_rsp_if_b;
  assign dma_station_u__i_resp_local_if_bvalid                      = dma_u__o_rsp_if_bvalid;
  assign dma_station_u__i_resp_local_if_r                           = dma_u__o_rsp_if_r;
  assign dma_station_u__i_resp_local_if_rvalid                      = dma_u__o_rsp_if_rvalid;
  assign dma_u__o_rsp_if_bready                                     = dma_station_u__i_resp_local_if_bready;
  assign dma_u__o_rsp_if_rready                                     = dma_station_u__i_resp_local_if_rready;

  // dma_station_u.i_resp_ring_if <-> vp0_station_u.o_resp_ring_if
  assign dma_station_u__i_resp_ring_if_b                            = vp0_station_u__o_resp_ring_if_b;
  assign dma_station_u__i_resp_ring_if_bvalid                       = vp0_station_u__o_resp_ring_if_bvalid;
  assign dma_station_u__i_resp_ring_if_r                            = vp0_station_u__o_resp_ring_if_r;
  assign dma_station_u__i_resp_ring_if_rvalid                       = vp0_station_u__o_resp_ring_if_rvalid;
  assign vp0_station_u__o_resp_ring_if_bready                       = dma_station_u__i_resp_ring_if_bready;
  assign vp0_station_u__o_resp_ring_if_rready                       = dma_station_u__i_resp_ring_if_rready;

  // dma_station_u.in_b2s_dma <-> dma_u.b2s_dma
  assign dma_station_u__in_b2s_dma_thread_idle                      = dma_u__b2s_dma_thread_idle;

  // dma_station_u.in_b2s_plic <-> plic_u.b2s
  assign dma_station_u__in_b2s_plic_intr_src                        = plic_u__b2s_intr_src;

  // dma_station_u.o_req_local_if <-> dma_u.i_req_if
  assign dma_station_u__o_req_local_if_arready                      = dma_u__i_req_if_arready;
  assign dma_station_u__o_req_local_if_awready                      = dma_u__i_req_if_awready;
  assign dma_station_u__o_req_local_if_wready                       = dma_u__i_req_if_wready;
  assign dma_u__i_req_if_ar                                         = dma_station_u__o_req_local_if_ar;
  assign dma_u__i_req_if_arvalid                                    = dma_station_u__o_req_local_if_arvalid;
  assign dma_u__i_req_if_aw                                         = dma_station_u__o_req_local_if_aw;
  assign dma_u__i_req_if_awvalid                                    = dma_station_u__o_req_local_if_awvalid;
  assign dma_u__i_req_if_w                                          = dma_station_u__o_req_local_if_w;
  assign dma_u__i_req_if_wvalid                                     = dma_station_u__o_req_local_if_wvalid;

  // dma_station_u.o_req_ring_if <-> vp0_station_u.i_req_ring_if
  assign dma_station_u__o_req_ring_if_arready                       = vp0_station_u__i_req_ring_if_arready;
  assign dma_station_u__o_req_ring_if_awready                       = vp0_station_u__i_req_ring_if_awready;
  assign dma_station_u__o_req_ring_if_wready                        = vp0_station_u__i_req_ring_if_wready;
  assign vp0_station_u__i_req_ring_if_ar                            = dma_station_u__o_req_ring_if_ar;
  assign vp0_station_u__i_req_ring_if_arvalid                       = dma_station_u__o_req_ring_if_arvalid;
  assign vp0_station_u__i_req_ring_if_aw                            = dma_station_u__o_req_ring_if_aw;
  assign vp0_station_u__i_req_ring_if_awvalid                       = dma_station_u__o_req_ring_if_awvalid;
  assign vp0_station_u__i_req_ring_if_w                             = dma_station_u__o_req_ring_if_w;
  assign vp0_station_u__i_req_ring_if_wvalid                        = dma_station_u__o_req_ring_if_wvalid;

  // dma_station_u.o_resp_local_if <-> dma_u.i_rsp_if
  assign dma_station_u__o_resp_local_if_bready                      = dma_u__i_rsp_if_bready;
  assign dma_station_u__o_resp_local_if_rready                      = dma_u__i_rsp_if_rready;
  assign dma_u__i_rsp_if_b                                          = dma_station_u__o_resp_local_if_b;
  assign dma_u__i_rsp_if_bvalid                                     = dma_station_u__o_resp_local_if_bvalid;
  assign dma_u__i_rsp_if_r                                          = dma_station_u__o_resp_local_if_r;
  assign dma_u__i_rsp_if_rvalid                                     = dma_station_u__o_resp_local_if_rvalid;

  // dma_station_u.out_s2b_dma <-> dma_u.s2b_dma
  assign dma_u__s2b_dma_flush_addr                                  = dma_station_u__out_s2b_dma_flush_addr;
  assign dma_u__s2b_dma_flush_req_type                              = dma_station_u__out_s2b_dma_flush_req_type;
  assign dma_u__s2b_dma_thread_cbuf_mode                            = dma_station_u__out_s2b_dma_thread_cbuf_mode;
  assign dma_u__s2b_dma_thread_cbuf_size                            = dma_station_u__out_s2b_dma_thread_cbuf_size;
  assign dma_u__s2b_dma_thread_cbuf_thold                           = dma_station_u__out_s2b_dma_thread_cbuf_thold;
  assign dma_u__s2b_dma_thread_dst_addr                             = dma_station_u__out_s2b_dma_thread_dst_addr;
  assign dma_u__s2b_dma_thread_gather_grpdepth                      = dma_station_u__out_s2b_dma_thread_gather_grpdepth;
  assign dma_u__s2b_dma_thread_gather_stride                        = dma_station_u__out_s2b_dma_thread_gather_stride;
  assign dma_u__s2b_dma_thread_length_in_bytes                      = dma_station_u__out_s2b_dma_thread_length_in_bytes;
  assign dma_u__s2b_dma_thread_rpt_cnt_less_1                       = dma_station_u__out_s2b_dma_thread_rpt_cnt_less_1;
  assign dma_u__s2b_dma_thread_src_addr                             = dma_station_u__out_s2b_dma_thread_src_addr;
  assign dma_u__s2b_dma_thread_use_8b_align                         = dma_station_u__out_s2b_dma_thread_use_8b_align;

  // dma_station_u.out_s2b_plic <-> plic_u.s2b
  assign plic_u__s2b_dbg_en                                         = dma_station_u__out_s2b_plic_dbg_en;
  assign plic_u__s2b_intr_core_id                                   = dma_station_u__out_s2b_plic_intr_core_id;
  assign plic_u__s2b_intr_en                                        = dma_station_u__out_s2b_plic_intr_en;

  // dma_station_u.vld_in <-> '1
  assign dma_station_u__vld_in_b2s_dma_thread_idle                  = {$bits(dma_station_u__vld_in_b2s_dma_thread_idle){1'b1}};
  assign dma_station_u__vld_in_dma_flush_cmd_vld                    = {$bits(dma_station_u__vld_in_dma_flush_cmd_vld){1'b1}};

  // dma_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign dma_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;

  // dma_station_u/in_b2s_thread0_intr <-> dma_u/dma_intr[0]
  assign dma_station_u__in_b2s_thread0_intr                         = dma_u__dma_intr[0];

  // dma_station_u/in_b2s_thread1_intr <-> dma_u/dma_intr[1]
  assign dma_station_u__in_b2s_thread1_intr                         = dma_u__dma_intr[1];

  // dma_station_u/in_b2s_thread2_intr <-> dma_u/dma_intr[2]
  assign dma_station_u__in_b2s_thread2_intr                         = dma_u__dma_intr[2];

  // dma_station_u/in_b2s_thread3_intr <-> dma_u/dma_intr[3]
  assign dma_station_u__in_b2s_thread3_intr                         = dma_u__dma_intr[3];

  // dma_station_u/in_dma_flush_cmd_vld <-> dma_u/dma_flush_cmd_vld_wdata
  assign dma_station_u__in_dma_flush_cmd_vld                        = dma_u__dma_flush_cmd_vld_wdata;

  // dma_station_u/in_dma_thread_cbuf_full_seen <-> dma_u/station_in_dma_thread_cbuf_full_seen
  assign dma_station_u__in_dma_thread_cbuf_full_seen                = dma_u__station_in_dma_thread_cbuf_full_seen;

  // dma_station_u/in_dma_thread_cbuf_rp_addr <-> dma_u/station_in_dma_thread_cbuf_rp_addr
  assign dma_station_u__in_dma_thread_cbuf_rp_addr                  = dma_u__station_in_dma_thread_cbuf_rp_addr;

  // dma_station_u/in_dma_thread_cbuf_wp_addr <-> dma_u/station_in_dma_thread_cbuf_wp_addr
  assign dma_station_u__in_dma_thread_cbuf_wp_addr                  = dma_u__station_in_dma_thread_cbuf_wp_addr;

  // dma_station_u/in_dma_thread_cmd_vld <-> dma_u/dma_thread_cmd_vld_wdata
  assign dma_station_u__in_dma_thread_cmd_vld                       = dma_u__dma_thread_cmd_vld_wdata;

  // dma_station_u/out_dma_flush_cmd_vld <-> dma_u/dma_flush_cmd_vld
  assign dma_u__dma_flush_cmd_vld                                   = dma_station_u__out_dma_flush_cmd_vld;

  // dma_station_u/out_dma_thread_cbuf_full_seen <-> dma_u/station_out_dma_thread_cbuf_full_seen
  assign dma_u__station_out_dma_thread_cbuf_full_seen               = dma_station_u__out_dma_thread_cbuf_full_seen;

  // dma_station_u/out_dma_thread_cbuf_rp_addr <-> dma_u/station_out_dma_thread_cbuf_rp_addr
  assign dma_u__station_out_dma_thread_cbuf_rp_addr                 = dma_station_u__out_dma_thread_cbuf_rp_addr;

  // dma_station_u/out_dma_thread_cbuf_wp_addr <-> dma_u/station_out_dma_thread_cbuf_wp_addr
  assign dma_u__station_out_dma_thread_cbuf_wp_addr                 = dma_station_u__out_dma_thread_cbuf_wp_addr;

  // dma_station_u/out_dma_thread_cmd_vld <-> dma_u/dma_thread_cmd_vld
  assign dma_u__dma_thread_cmd_vld                                  = dma_station_u__out_dma_thread_cmd_vld;

  // dma_station_u/rstn <-> dma_rstn_sync_u/rstn_out
  assign dma_station_u__rstn                                        = dma_rstn_sync_u__rstn_out;

  // dma_station_u/vld_in_b2s_plic_intr_src <-> 'b11111
  assign dma_station_u__vld_in_b2s_plic_intr_src                    = {{($bits(dma_station_u__vld_in_b2s_plic_intr_src)-5){1'b0}}, 5'b11111};

  // dma_station_u/vld_in_b2s_thread0_intr <-> dma_u/dma_intr[0]
  assign dma_station_u__vld_in_b2s_thread0_intr                     = dma_u__dma_intr[0];

  // dma_station_u/vld_in_b2s_thread1_intr <-> dma_u/dma_intr[1]
  assign dma_station_u__vld_in_b2s_thread1_intr                     = dma_u__dma_intr[1];

  // dma_station_u/vld_in_b2s_thread2_intr <-> dma_u/dma_intr[2]
  assign dma_station_u__vld_in_b2s_thread2_intr                     = dma_u__dma_intr[2];

  // dma_station_u/vld_in_b2s_thread3_intr <-> dma_u/dma_intr[3]
  assign dma_station_u__vld_in_b2s_thread3_intr                     = dma_u__dma_intr[3];

  // dma_station_u/vld_in_dma_thread_cbuf_full_seen <-> dma_u/station_vld_in_dma_thread_cbuf_full_seen
  assign dma_station_u__vld_in_dma_thread_cbuf_full_seen            = dma_u__station_vld_in_dma_thread_cbuf_full_seen;

  // dma_station_u/vld_in_dma_thread_cbuf_rp_addr <-> dma_u/station_vld_in_dma_thread_cbuf_rp_addr
  assign dma_station_u__vld_in_dma_thread_cbuf_rp_addr              = dma_u__station_vld_in_dma_thread_cbuf_rp_addr;

  // dma_station_u/vld_in_dma_thread_cbuf_wp_addr <-> dma_u/station_vld_in_dma_thread_cbuf_wp_addr
  assign dma_station_u__vld_in_dma_thread_cbuf_wp_addr              = dma_u__station_vld_in_dma_thread_cbuf_wp_addr;

  // dma_station_u/vld_in_dma_thread_cmd_vld <-> 'b1111
  assign dma_station_u__vld_in_dma_thread_cmd_vld                   = {{($bits(dma_station_u__vld_in_dma_thread_cmd_vld)-4){1'b0}}, 4'b1111};

  // dma_thread0_mux_u/in[0] <-> 'b0
  assign dma_thread0_mux_u__in[0]                                   = {{($bits(dma_thread0_mux_u__in[0])-1){1'b0}}, 1'b0};

  // dma_thread0_mux_u/in[1] <-> i2ss0_intr_sync_u/q
  assign dma_thread0_mux_u__in[1]                                   = i2ss0_intr_sync_u__q;

  // dma_thread0_mux_u/in[2] <-> i2ss1_intr_sync_u/q
  assign dma_thread0_mux_u__in[2]                                   = i2ss1_intr_sync_u__q;

  // dma_thread0_mux_u/in[3] <-> i2ss2_intr_sync_u/q
  assign dma_thread0_mux_u__in[3]                                   = i2ss2_intr_sync_u__q;

  // dma_thread0_mux_u/in[4] <-> i2ss3_intr_sync_u/q
  assign dma_thread0_mux_u__in[4]                                   = i2ss3_intr_sync_u__q;

  // dma_thread0_mux_u/in[5] <-> i2ss4_intr_sync_u/q
  assign dma_thread0_mux_u__in[5]                                   = i2ss4_intr_sync_u__q;

  // dma_thread0_mux_u/in[6] <-> i2ss5_intr_sync_u/q
  assign dma_thread0_mux_u__in[6]                                   = i2ss5_intr_sync_u__q;

  // dma_thread0_mux_u/sel <-> dma_station_u/out_dma_thread0_data_avail_src_sel
  assign dma_thread0_mux_u__sel                                     = dma_station_u__out_dma_thread0_data_avail_src_sel;

  // dma_thread1_mux_u/in[0] <-> 'b0
  assign dma_thread1_mux_u__in[0]                                   = {{($bits(dma_thread1_mux_u__in[0])-1){1'b0}}, 1'b0};

  // dma_thread1_mux_u/in[1] <-> i2ss0_intr_sync_u/q
  assign dma_thread1_mux_u__in[1]                                   = i2ss0_intr_sync_u__q;

  // dma_thread1_mux_u/in[2] <-> i2ss1_intr_sync_u/q
  assign dma_thread1_mux_u__in[2]                                   = i2ss1_intr_sync_u__q;

  // dma_thread1_mux_u/in[3] <-> i2ss2_intr_sync_u/q
  assign dma_thread1_mux_u__in[3]                                   = i2ss2_intr_sync_u__q;

  // dma_thread1_mux_u/in[4] <-> i2ss3_intr_sync_u/q
  assign dma_thread1_mux_u__in[4]                                   = i2ss3_intr_sync_u__q;

  // dma_thread1_mux_u/in[5] <-> i2ss4_intr_sync_u/q
  assign dma_thread1_mux_u__in[5]                                   = i2ss4_intr_sync_u__q;

  // dma_thread1_mux_u/in[6] <-> i2ss5_intr_sync_u/q
  assign dma_thread1_mux_u__in[6]                                   = i2ss5_intr_sync_u__q;

  // dma_thread1_mux_u/sel <-> dma_station_u/out_dma_thread1_data_avail_src_sel
  assign dma_thread1_mux_u__sel                                     = dma_station_u__out_dma_thread1_data_avail_src_sel;

  // dma_thread2_mux_u/in[0] <-> 'b0
  assign dma_thread2_mux_u__in[0]                                   = {{($bits(dma_thread2_mux_u__in[0])-1){1'b0}}, 1'b0};

  // dma_thread2_mux_u/in[1] <-> i2ss0_intr_sync_u/q
  assign dma_thread2_mux_u__in[1]                                   = i2ss0_intr_sync_u__q;

  // dma_thread2_mux_u/in[2] <-> i2ss1_intr_sync_u/q
  assign dma_thread2_mux_u__in[2]                                   = i2ss1_intr_sync_u__q;

  // dma_thread2_mux_u/in[3] <-> i2ss2_intr_sync_u/q
  assign dma_thread2_mux_u__in[3]                                   = i2ss2_intr_sync_u__q;

  // dma_thread2_mux_u/in[4] <-> i2ss3_intr_sync_u/q
  assign dma_thread2_mux_u__in[4]                                   = i2ss3_intr_sync_u__q;

  // dma_thread2_mux_u/in[5] <-> i2ss4_intr_sync_u/q
  assign dma_thread2_mux_u__in[5]                                   = i2ss4_intr_sync_u__q;

  // dma_thread2_mux_u/in[6] <-> i2ss5_intr_sync_u/q
  assign dma_thread2_mux_u__in[6]                                   = i2ss5_intr_sync_u__q;

  // dma_thread2_mux_u/sel <-> dma_station_u/out_dma_thread2_data_avail_src_sel
  assign dma_thread2_mux_u__sel                                     = dma_station_u__out_dma_thread2_data_avail_src_sel;

  // dma_thread3_mux_u/in[0] <-> 'b0
  assign dma_thread3_mux_u__in[0]                                   = {{($bits(dma_thread3_mux_u__in[0])-1){1'b0}}, 1'b0};

  // dma_thread3_mux_u/in[1] <-> i2ss0_intr_sync_u/q
  assign dma_thread3_mux_u__in[1]                                   = i2ss0_intr_sync_u__q;

  // dma_thread3_mux_u/in[2] <-> i2ss1_intr_sync_u/q
  assign dma_thread3_mux_u__in[2]                                   = i2ss1_intr_sync_u__q;

  // dma_thread3_mux_u/in[3] <-> i2ss2_intr_sync_u/q
  assign dma_thread3_mux_u__in[3]                                   = i2ss2_intr_sync_u__q;

  // dma_thread3_mux_u/in[4] <-> i2ss3_intr_sync_u/q
  assign dma_thread3_mux_u__in[4]                                   = i2ss3_intr_sync_u__q;

  // dma_thread3_mux_u/in[5] <-> i2ss4_intr_sync_u/q
  assign dma_thread3_mux_u__in[5]                                   = i2ss4_intr_sync_u__q;

  // dma_thread3_mux_u/in[6] <-> i2ss5_intr_sync_u/q
  assign dma_thread3_mux_u__in[6]                                   = i2ss5_intr_sync_u__q;

  // dma_thread3_mux_u/sel <-> dma_station_u/out_dma_thread3_data_avail_src_sel
  assign dma_thread3_mux_u__sel                                     = dma_station_u__out_dma_thread3_data_avail_src_sel;

  `ifndef IFNDEF_TB_USE_CPU_NOC
  // dma_u.cpu_cache_req_if <-> 'b0
  assign dma_u__cpu_cache_req_if_req_ready                          = {{($bits(dma_u__cpu_cache_req_if_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // dma_u.cpu_cache_req_if <-> cpu_noc_u.cpu_noc_req_if[5]
  assign cpu_noc_u__cpu_noc_req_if_req[5]                           = dma_u__cpu_cache_req_if_req;
  assign cpu_noc_u__cpu_noc_req_if_req_valid[5]                     = dma_u__cpu_cache_req_if_req_valid;
  assign dma_u__cpu_cache_req_if_req_ready                          = cpu_noc_u__cpu_noc_req_if_req_ready[5];
  `endif

  `ifndef IFNDEF_TB_USE_CPU_NOC
  // dma_u.cpu_cache_resp_if <-> 'b0
  assign dma_u__cpu_cache_resp_if_resp                              = {{($bits(dma_u__cpu_cache_resp_if_resp)-1){1'b0}}, 1'b0};
  assign dma_u__cpu_cache_resp_if_resp_valid                        = {{($bits(dma_u__cpu_cache_resp_if_resp_valid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // dma_u.cpu_cache_resp_if <-> cpu_noc_u.noc_cpu_resp_if[5]
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[5]                   = dma_u__cpu_cache_resp_if_resp_ready;
  assign dma_u__cpu_cache_resp_if_resp                              = cpu_noc_u__noc_cpu_resp_if_resp[5];
  assign dma_u__cpu_cache_resp_if_resp_valid                        = cpu_noc_u__noc_cpu_resp_if_resp_valid[5];
  `endif

  // dma_u/cbuf_mode_data_avail[0] <-> dma_thread0_mux_u/out
  assign dma_u__cbuf_mode_data_avail[0]                             = dma_thread0_mux_u__out;

  // dma_u/cbuf_mode_data_avail[1] <-> dma_thread1_mux_u/out
  assign dma_u__cbuf_mode_data_avail[1]                             = dma_thread1_mux_u__out;

  // dma_u/cbuf_mode_data_avail[2] <-> dma_thread2_mux_u/out
  assign dma_u__cbuf_mode_data_avail[2]                             = dma_thread2_mux_u__out;

  // dma_u/cbuf_mode_data_avail[3] <-> dma_thread3_mux_u/out
  assign dma_u__cbuf_mode_data_avail[3]                             = dma_thread3_mux_u__out;

  // dma_u/clk <-> dma_icg_u/clkg
  assign dma_u__clk                                                 = dma_icg_u__clkg;

  // dma_u/rstn <-> dma_rstn_sync_u/rstn_out
  assign dma_u__rstn                                                = dma_rstn_sync_u__rstn_out;

  // dt_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign dt_icg_u__clk                                              = dft_pllclk_clk_buf_u0__out;

  // dt_icg_u/en <-> dt_station_u/out_s2icg_clk_en
  assign dt_icg_u__en                                               = dt_station_u__out_s2icg_clk_en;

  // dt_icg_u/tst_en <-> 'b0
  assign dt_icg_u__tst_en                                           = {{($bits(dt_icg_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // dt_station_u.i_req_local_if <-> 'b0
  assign dt_station_u__i_req_local_if_ar                            = {{($bits(dt_station_u__i_req_local_if_ar)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_req_local_if_arvalid                       = {{($bits(dt_station_u__i_req_local_if_arvalid)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_req_local_if_aw                            = {{($bits(dt_station_u__i_req_local_if_aw)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_req_local_if_awvalid                       = {{($bits(dt_station_u__i_req_local_if_awvalid)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_req_local_if_w                             = {{($bits(dt_station_u__i_req_local_if_w)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_req_local_if_wvalid                        = {{($bits(dt_station_u__i_req_local_if_wvalid)-1){1'b0}}, 1'b0};
  `endif

  `ifndef IFNDEF_NO_DT
  // dt_station_u.i_resp_local_if <-> 'b0
  assign dt_station_u__i_resp_local_if_b                            = {{($bits(dt_station_u__i_resp_local_if_b)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_resp_local_if_bvalid                       = {{($bits(dt_station_u__i_resp_local_if_bvalid)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_resp_local_if_r                            = {{($bits(dt_station_u__i_resp_local_if_r)-1){1'b0}}, 1'b0};
  assign dt_station_u__i_resp_local_if_rvalid                       = {{($bits(dt_station_u__i_resp_local_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  

  `ifdef IFNDEF_SOC_NO_BANK2
  // dt_station_u.i_resp_ring_if <-> bank2_station_u.o_resp_ring_if
  assign bank2_station_u__o_resp_ring_if_bready                     = dt_station_u__i_resp_ring_if_bready;
  assign bank2_station_u__o_resp_ring_if_rready                     = dt_station_u__i_resp_ring_if_rready;
  assign dt_station_u__i_resp_ring_if_b                             = bank2_station_u__o_resp_ring_if_b;
  assign dt_station_u__i_resp_ring_if_bvalid                        = bank2_station_u__o_resp_ring_if_bvalid;
  assign dt_station_u__i_resp_ring_if_r                             = bank2_station_u__o_resp_ring_if_r;
  assign dt_station_u__i_resp_ring_if_rvalid                        = bank2_station_u__o_resp_ring_if_rvalid;
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // dt_station_u.i_resp_ring_if <-> byp_station_u.o_resp_ring_if
  assign byp_station_u__o_resp_ring_if_bready                       = dt_station_u__i_resp_ring_if_bready;
  assign byp_station_u__o_resp_ring_if_rready                       = dt_station_u__i_resp_ring_if_rready;
  assign dt_station_u__i_resp_ring_if_b                             = byp_station_u__o_resp_ring_if_b;
  assign dt_station_u__i_resp_ring_if_bvalid                        = byp_station_u__o_resp_ring_if_bvalid;
  assign dt_station_u__i_resp_ring_if_r                             = byp_station_u__o_resp_ring_if_r;
  assign dt_station_u__i_resp_ring_if_rvalid                        = byp_station_u__o_resp_ring_if_rvalid;
  `endif

  `ifndef IFNDEF_NO_DT
  // dt_station_u.o_req_local_if <-> 'b0
  assign dt_station_u__o_req_local_if_arready                       = {{($bits(dt_station_u__o_req_local_if_arready)-1){1'b0}}, 1'b0};
  assign dt_station_u__o_req_local_if_awready                       = {{($bits(dt_station_u__o_req_local_if_awready)-1){1'b0}}, 1'b0};
  assign dt_station_u__o_req_local_if_wready                        = {{($bits(dt_station_u__o_req_local_if_wready)-1){1'b0}}, 1'b0};
  `endif

  

  `ifdef IFNDEF_SOC_NO_BANK2
  // dt_station_u.o_req_ring_if <-> bank2_station_u.i_req_ring_if
  assign bank2_station_u__i_req_ring_if_ar                          = dt_station_u__o_req_ring_if_ar;
  assign bank2_station_u__i_req_ring_if_arvalid                     = dt_station_u__o_req_ring_if_arvalid;
  assign bank2_station_u__i_req_ring_if_aw                          = dt_station_u__o_req_ring_if_aw;
  assign bank2_station_u__i_req_ring_if_awvalid                     = dt_station_u__o_req_ring_if_awvalid;
  assign bank2_station_u__i_req_ring_if_w                           = dt_station_u__o_req_ring_if_w;
  assign bank2_station_u__i_req_ring_if_wvalid                      = dt_station_u__o_req_ring_if_wvalid;
  assign dt_station_u__o_req_ring_if_arready                        = bank2_station_u__i_req_ring_if_arready;
  assign dt_station_u__o_req_ring_if_awready                        = bank2_station_u__i_req_ring_if_awready;
  assign dt_station_u__o_req_ring_if_wready                         = bank2_station_u__i_req_ring_if_wready;
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // dt_station_u.o_req_ring_if <-> byp_station_u.i_req_ring_if
  assign byp_station_u__i_req_ring_if_ar                            = dt_station_u__o_req_ring_if_ar;
  assign byp_station_u__i_req_ring_if_arvalid                       = dt_station_u__o_req_ring_if_arvalid;
  assign byp_station_u__i_req_ring_if_aw                            = dt_station_u__o_req_ring_if_aw;
  assign byp_station_u__i_req_ring_if_awvalid                       = dt_station_u__o_req_ring_if_awvalid;
  assign byp_station_u__i_req_ring_if_w                             = dt_station_u__o_req_ring_if_w;
  assign byp_station_u__i_req_ring_if_wvalid                        = dt_station_u__o_req_ring_if_wvalid;
  assign dt_station_u__o_req_ring_if_arready                        = byp_station_u__i_req_ring_if_arready;
  assign dt_station_u__o_req_ring_if_awready                        = byp_station_u__i_req_ring_if_awready;
  assign dt_station_u__o_req_ring_if_wready                         = byp_station_u__i_req_ring_if_wready;
  `endif

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // dt_station_u.o_resp_local_if <-> 'b0
  assign dt_station_u__o_resp_local_if_bready                       = {{($bits(dt_station_u__o_resp_local_if_bready)-1){1'b0}}, 1'b0};
  assign dt_station_u__o_resp_local_if_rready                       = {{($bits(dt_station_u__o_resp_local_if_rready)-1){1'b0}}, 1'b0};
  `endif

  // dt_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign dt_station_u__clk                                          = dft_pllclk_clk_buf_u0__out;

  // dt_station_u/rstn <-> dt_rstn_sync_u/rstn_out
  assign dt_station_u__rstn                                         = dt_rstn_sync_u__rstn_out;

  

  

  

  

  

  

  

  

  // i2ss0_intr_sync_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign i2ss0_intr_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  

  // i2ss1_intr_sync_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign i2ss1_intr_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  

  // i2ss2_intr_sync_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign i2ss2_intr_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  

  // i2ss3_intr_sync_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign i2ss3_intr_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  

  // i2ss4_intr_sync_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign i2ss4_intr_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  

  // i2ss5_intr_sync_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign i2ss5_intr_sync_u__clk                                     = dft_pllclk_clk_buf_u0__out;

  

  // jtag2or_u/rstn <-> jtag2or_rstn_sync_u/rstn_out
  assign jtag2or_u__rstn                                            = jtag2or_rstn_sync_u__rstn_out;

  `ifdef IFNDEF_NO_DDR
  // mbist_mode_buf/out <-> ddr_top_u/mbist_mode
  assign ddr_top_u__mbist_mode                                      = mbist_mode_buf__out;
  `endif

  

  `ifdef IFNDEF_TB_USE_DDR__IFNDEF_EXT_MEM_NOC_BRIDGE
  // mem_noc_ddr_cdc_u.cdc2noc_resp_if <-> mem_noc_u.mem_resp_if[0]
  assign mem_noc_ddr_cdc_u__cdc2noc_resp_if_bready                  = mem_noc_u__mem_resp_if_bready[0];
  assign mem_noc_ddr_cdc_u__cdc2noc_resp_if_rready                  = mem_noc_u__mem_resp_if_rready[0];
  assign mem_noc_u__mem_resp_if_b[0]                                = mem_noc_ddr_cdc_u__cdc2noc_resp_if_b;
  assign mem_noc_u__mem_resp_if_bvalid[0]                           = mem_noc_ddr_cdc_u__cdc2noc_resp_if_bvalid;
  assign mem_noc_u__mem_resp_if_r[0]                                = mem_noc_ddr_cdc_u__cdc2noc_resp_if_r;
  assign mem_noc_u__mem_resp_if_rvalid[0]                           = mem_noc_ddr_cdc_u__cdc2noc_resp_if_rvalid;
  `endif

  `ifdef IFNDEF_TB_USE_DDR__IFNDEF_EXT_MEM_NOC_BRIDGE
  // mem_noc_ddr_cdc_u.noc2cdc_req_if <-> mem_noc_u.mem_req_if[0]
  assign mem_noc_ddr_cdc_u__noc2cdc_req_if_ar                       = mem_noc_u__mem_req_if_ar[0];
  assign mem_noc_ddr_cdc_u__noc2cdc_req_if_arvalid                  = mem_noc_u__mem_req_if_arvalid[0];
  assign mem_noc_ddr_cdc_u__noc2cdc_req_if_aw                       = mem_noc_u__mem_req_if_aw[0];
  assign mem_noc_ddr_cdc_u__noc2cdc_req_if_awvalid                  = mem_noc_u__mem_req_if_awvalid[0];
  assign mem_noc_ddr_cdc_u__noc2cdc_req_if_w                        = mem_noc_u__mem_req_if_w[0];
  assign mem_noc_ddr_cdc_u__noc2cdc_req_if_wvalid                   = mem_noc_u__mem_req_if_wvalid[0];
  assign mem_noc_u__mem_req_if_arready[0]                           = mem_noc_ddr_cdc_u__noc2cdc_req_if_arready;
  assign mem_noc_u__mem_req_if_awready[0]                           = mem_noc_ddr_cdc_u__noc2cdc_req_if_awready;
  assign mem_noc_u__mem_req_if_wready[0]                            = mem_noc_ddr_cdc_u__noc2cdc_req_if_wready;
  `endif

  `ifdef IFNDEF_NO_DDR
  // mem_noc_ddr_cdc_u/clk_m <-> dft_pllclk_clk_buf_u0/out
  assign mem_noc_ddr_cdc_u__clk_m                                   = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // mem_noc_ddr_cdc_u/clk_s <-> ddr_clk_mux_u/clk_out
  assign mem_noc_ddr_cdc_u__clk_s                                   = ddr_clk_mux_u__clk_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // mem_noc_ddr_cdc_u/rstn_m <-> ddr_hs_rstn_sync_u/rstn_out
  assign mem_noc_ddr_cdc_u__rstn_m                                  = ddr_hs_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // mem_noc_ddr_cdc_u/rstn_s <-> ddr_ls_rstn_sync_u/rstn_out
  assign mem_noc_ddr_cdc_u__rstn_s                                  = ddr_ls_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // mem_noc_u.l2_req_if[2] <-> 'b0
  assign mem_noc_u__l2_req_if_ar[2]                                 = {{($bits(mem_noc_u__l2_req_if_ar[2])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_arvalid[2]                            = {{($bits(mem_noc_u__l2_req_if_arvalid[2])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_aw[2]                                 = {{($bits(mem_noc_u__l2_req_if_aw[2])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_awvalid[2]                            = {{($bits(mem_noc_u__l2_req_if_awvalid[2])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_w[2]                                  = {{($bits(mem_noc_u__l2_req_if_w[2])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_wvalid[2]                             = {{($bits(mem_noc_u__l2_req_if_wvalid[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // mem_noc_u.l2_req_if[3] <-> 'b0
  assign mem_noc_u__l2_req_if_ar[3]                                 = {{($bits(mem_noc_u__l2_req_if_ar[3])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_arvalid[3]                            = {{($bits(mem_noc_u__l2_req_if_arvalid[3])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_aw[3]                                 = {{($bits(mem_noc_u__l2_req_if_aw[3])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_awvalid[3]                            = {{($bits(mem_noc_u__l2_req_if_awvalid[3])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_w[3]                                  = {{($bits(mem_noc_u__l2_req_if_w[3])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_wvalid[3]                             = {{($bits(mem_noc_u__l2_req_if_wvalid[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_DT
  // mem_noc_u.l2_req_if[4] <-> 'b0
  assign mem_noc_u__l2_req_if_ar[4]                                 = {{($bits(mem_noc_u__l2_req_if_ar[4])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_arvalid[4]                            = {{($bits(mem_noc_u__l2_req_if_arvalid[4])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_aw[4]                                 = {{($bits(mem_noc_u__l2_req_if_aw[4])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_awvalid[4]                            = {{($bits(mem_noc_u__l2_req_if_awvalid[4])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_w[4]                                  = {{($bits(mem_noc_u__l2_req_if_w[4])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_req_if_wvalid[4]                             = {{($bits(mem_noc_u__l2_req_if_wvalid[4])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK2
  // mem_noc_u.l2_resp_if[2] <-> 'b0
  assign mem_noc_u__l2_resp_if_bready[2]                            = {{($bits(mem_noc_u__l2_resp_if_bready[2])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_resp_if_rready[2]                            = {{($bits(mem_noc_u__l2_resp_if_rready[2])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_SOC_NO_BANK3
  // mem_noc_u.l2_resp_if[3] <-> 'b0
  assign mem_noc_u__l2_resp_if_bready[3]                            = {{($bits(mem_noc_u__l2_resp_if_bready[3])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_resp_if_rready[3]                            = {{($bits(mem_noc_u__l2_resp_if_rready[3])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_DT
  // mem_noc_u.l2_resp_if[4] <-> 'b0
  assign mem_noc_u__l2_resp_if_bready[4]                            = {{($bits(mem_noc_u__l2_resp_if_bready[4])-1){1'b0}}, 1'b0};
  assign mem_noc_u__l2_resp_if_rready[4]                            = {{($bits(mem_noc_u__l2_resp_if_rready[4])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_TB_USE_DDR
  // mem_noc_u.mem_req_if[0] <-> 'b0
  assign mem_noc_u__mem_req_if_arready[0]                           = {{($bits(mem_noc_u__mem_req_if_arready[0])-1){1'b0}}, 1'b0};
  assign mem_noc_u__mem_req_if_awready[0]                           = {{($bits(mem_noc_u__mem_req_if_awready[0])-1){1'b0}}, 1'b0};
  assign mem_noc_u__mem_req_if_wready[0]                            = {{($bits(mem_noc_u__mem_req_if_wready[0])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_TB_USE_DDR
  // mem_noc_u.mem_resp_if[0] <-> 'b0
  assign mem_noc_u__mem_resp_if_b[0]                                = {{($bits(mem_noc_u__mem_resp_if_b[0])-1){1'b0}}, 1'b0};
  assign mem_noc_u__mem_resp_if_bvalid[0]                           = {{($bits(mem_noc_u__mem_resp_if_bvalid[0])-1){1'b0}}, 1'b0};
  assign mem_noc_u__mem_resp_if_r[0]                                = {{($bits(mem_noc_u__mem_resp_if_r[0])-1){1'b0}}, 1'b0};
  assign mem_noc_u__mem_resp_if_rvalid[0]                           = {{($bits(mem_noc_u__mem_resp_if_rvalid[0])-1){1'b0}}, 1'b0};
  `endif

  // mem_noc_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign mem_noc_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  // mem_noc_u/rstn <-> mem_noc_rstn_sync_u/rstn_out
  assign mem_noc_u__rstn                                            = mem_noc_rstn_sync_u__rstn_out;

  

  

  

  

  

  


  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  // oursring_cdc_byp2ddr_u.cdc_oursring_master_req_if <-> ddr_station_u.i_req_ring_if
  assign ddr_station_u__i_req_ring_if_ar                            = oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_ar;
  assign ddr_station_u__i_req_ring_if_arvalid                       = oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_arvalid;
  assign ddr_station_u__i_req_ring_if_aw                            = oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_aw;
  assign ddr_station_u__i_req_ring_if_awvalid                       = oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_awvalid;
  assign ddr_station_u__i_req_ring_if_w                             = oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_w;
  assign ddr_station_u__i_req_ring_if_wvalid                        = oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_wvalid;
  assign oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_arready = ddr_station_u__i_req_ring_if_arready;
  assign oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_awready = ddr_station_u__i_req_ring_if_awready;
  assign oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_wready  = ddr_station_u__i_req_ring_if_wready;

  // oursring_cdc_byp2ddr_u.oursring_cdc_master_rsp_if <-> ddr_station_u.o_resp_ring_if
  assign ddr_station_u__o_resp_ring_if_bready                       = oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_bready;
  assign ddr_station_u__o_resp_ring_if_rready                       = oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_rready;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_b       = ddr_station_u__o_resp_ring_if_b;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_bvalid  = ddr_station_u__o_resp_ring_if_bvalid;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_r       = ddr_station_u__o_resp_ring_if_r;
  assign oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_rvalid  = ddr_station_u__o_resp_ring_if_rvalid;

  // oursring_cdc_byp2ddr_u/master_resetn <-> ddr_ls_rstn_sync_u/rstn_out
  assign oursring_cdc_byp2ddr_u__master_resetn                      = ddr_ls_rstn_sync_u__rstn_out;

  // oursring_cdc_byp2ddr_u/slave_resetn <-> ddr_hs_rstn_sync_u/rstn_out
  assign oursring_cdc_byp2ddr_u__slave_resetn                       = ddr_hs_rstn_sync_u__rstn_out;

  // oursring_cdc_ddr2io_u.cdc_oursring_master_req_if <-> slow_io_station_u.i_req_ring_if
  assign oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_arready  = slow_io_station_u__i_req_ring_if_arready;
  assign oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_awready  = slow_io_station_u__i_req_ring_if_awready;
  assign oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_wready   = slow_io_station_u__i_req_ring_if_wready;
  assign slow_io_station_u__i_req_ring_if_ar                        = oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_ar;
  assign slow_io_station_u__i_req_ring_if_arvalid                   = oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_arvalid;
  assign slow_io_station_u__i_req_ring_if_aw                        = oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_aw;
  assign slow_io_station_u__i_req_ring_if_awvalid                   = oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_awvalid;
  assign slow_io_station_u__i_req_ring_if_w                         = oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_w;
  assign slow_io_station_u__i_req_ring_if_wvalid                    = oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_wvalid;

  // oursring_cdc_ddr2io_u.oursring_cdc_master_rsp_if <-> slow_io_station_u.o_resp_ring_if
  assign oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_b        = slow_io_station_u__o_resp_ring_if_b;
  assign oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_bvalid   = slow_io_station_u__o_resp_ring_if_bvalid;
  assign oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_r        = slow_io_station_u__o_resp_ring_if_r;
  assign oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_rvalid   = slow_io_station_u__o_resp_ring_if_rvalid;
  assign slow_io_station_u__o_resp_ring_if_bready                   = oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_bready;
  assign slow_io_station_u__o_resp_ring_if_rready                   = oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_rready;

  // oursring_cdc_ddr2io_u/master_clk <-> slow_io_clk_div_u/divclk
  assign oursring_cdc_ddr2io_u__master_clk                          = slow_io_clk_div_u__divclk;

  // oursring_cdc_ddr2io_u/slave_clk <-> ddr_clk_mux_u/clk_out
  assign oursring_cdc_ddr2io_u__slave_clk                           = ddr_clk_mux_u__clk_out;

  // oursring_cdc_io2byp_u.cdc_oursring_master_req_if <-> byp_station_u.i_req_local_if
  assign byp_station_u__i_req_local_if_ar                           = oursring_cdc_io2byp_u__cdc_oursring_master_req_if_ar;
  assign byp_station_u__i_req_local_if_arvalid                      = oursring_cdc_io2byp_u__cdc_oursring_master_req_if_arvalid;
  assign byp_station_u__i_req_local_if_aw                           = oursring_cdc_io2byp_u__cdc_oursring_master_req_if_aw;
  assign byp_station_u__i_req_local_if_awvalid                      = oursring_cdc_io2byp_u__cdc_oursring_master_req_if_awvalid;
  assign byp_station_u__i_req_local_if_w                            = oursring_cdc_io2byp_u__cdc_oursring_master_req_if_w;
  assign byp_station_u__i_req_local_if_wvalid                       = oursring_cdc_io2byp_u__cdc_oursring_master_req_if_wvalid;
  assign oursring_cdc_io2byp_u__cdc_oursring_master_req_if_arready  = byp_station_u__i_req_local_if_arready;
  assign oursring_cdc_io2byp_u__cdc_oursring_master_req_if_awready  = byp_station_u__i_req_local_if_awready;
  assign oursring_cdc_io2byp_u__cdc_oursring_master_req_if_wready   = byp_station_u__i_req_local_if_wready;

  // oursring_cdc_io2byp_u.oursring_cdc_master_rsp_if <-> byp_station_u.o_resp_local_if
  assign byp_station_u__o_resp_local_if_bready                      = oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_bready;
  assign byp_station_u__o_resp_local_if_rready                      = oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_rready;
  assign oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_b        = byp_station_u__o_resp_local_if_b;
  assign oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_bvalid   = byp_station_u__o_resp_local_if_bvalid;
  assign oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_r        = byp_station_u__o_resp_local_if_r;
  assign oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_rvalid   = byp_station_u__o_resp_local_if_rvalid;

  // oursring_cdc_io2byp_u/master_clk <-> dft_pllclk_clk_buf_u0/out
  assign oursring_cdc_io2byp_u__master_clk                          = dft_pllclk_clk_buf_u0__out;

  // oursring_cdc_io2byp_u/slave_clk <-> slow_io_clk_div_u/divclk
  assign oursring_cdc_io2byp_u__slave_clk                           = slow_io_clk_div_u__divclk;

  `ifdef IFNDEF_NO_DDR
  // oursring_ddr_cdc_u/apb_clk <-> ddr_clk_mux_u/clk_out
  assign oursring_ddr_cdc_u__apb_clk                                = ddr_clk_mux_u__clk_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // oursring_ddr_cdc_u/apb_resetn <-> ddr_ls_rstn_sync_u/rstn_out
  assign oursring_ddr_cdc_u__apb_resetn                             = ddr_ls_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // oursring_ddr_cdc_u/axi_clk <-> ddr_clk_mux_u/clk_out
  assign oursring_ddr_cdc_u__axi_clk                                = ddr_clk_mux_u__clk_out;
  `endif

  `ifdef IFNDEF_NO_DDR
  // oursring_ddr_cdc_u/axi_resetn <-> ddr_ls_rstn_sync_u/rstn_out
  assign oursring_ddr_cdc_u__axi_resetn                             = ddr_ls_rstn_sync_u__rstn_out;
  `endif

  // plic_u/clk <-> dma_icg_u/clkg
  assign plic_u__clk                                                = dma_icg_u__clkg;

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[0] <-> 'b0
  assign plic_u__irq_in[0]                                          = {{($bits(plic_u__irq_in[0])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[10] <-> 'b0
  assign plic_u__irq_in[10]                                         = {{($bits(plic_u__irq_in[10])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[11] <-> 'b0
  assign plic_u__irq_in[11]                                         = {{($bits(plic_u__irq_in[11])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[12] <-> 'b0
  assign plic_u__irq_in[12]                                         = {{($bits(plic_u__irq_in[12])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[13] <-> 'b0
  assign plic_u__irq_in[13]                                         = {{($bits(plic_u__irq_in[13])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[14] <-> 'b0
  assign plic_u__irq_in[14]                                         = {{($bits(plic_u__irq_in[14])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[15] <-> 'b0
  assign plic_u__irq_in[15]                                         = {{($bits(plic_u__irq_in[15])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[16] <-> 'b0
  assign plic_u__irq_in[16]                                         = {{($bits(plic_u__irq_in[16])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[17] <-> 'b0
  assign plic_u__irq_in[17]                                         = {{($bits(plic_u__irq_in[17])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[18] <-> 'b0
  assign plic_u__irq_in[18]                                         = {{($bits(plic_u__irq_in[18])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[19] <-> 'b0
  assign plic_u__irq_in[19]                                         = {{($bits(plic_u__irq_in[19])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[1] <-> 'b0
  assign plic_u__irq_in[1]                                          = {{($bits(plic_u__irq_in[1])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[20] <-> 'b0
  assign plic_u__irq_in[20]                                         = {{($bits(plic_u__irq_in[20])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[21] <-> 'b0
  assign plic_u__irq_in[21]                                         = {{($bits(plic_u__irq_in[21])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[22] <-> 'b0
  assign plic_u__irq_in[22]                                         = {{($bits(plic_u__irq_in[22])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SDIO
  // plic_u/irq_in[23] <-> 'b0
  assign plic_u__irq_in[23]                                         = {{($bits(plic_u__irq_in[23])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SDIO
  // plic_u/irq_in[24] <-> 'b0
  assign plic_u__irq_in[24]                                         = {{($bits(plic_u__irq_in[24])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_USB
  // plic_u/irq_in[25] <-> 'b0
  assign plic_u__irq_in[25]                                         = {{($bits(plic_u__irq_in[25])-1){1'b0}}, 1'b0};
  `endif

  

  // plic_u/irq_in[26] <-> vp0_station_u/out_b2s_is_vtlb_excp
  assign plic_u__irq_in[26]                                         = vp0_station_u__out_b2s_is_vtlb_excp;

  `ifdef IFNDEF_SINGLE_VP
  // plic_u/irq_in[27] <-> vp1_station_u/out_b2s_is_vtlb_excp
  assign plic_u__irq_in[27]                                         = vp1_station_u__out_b2s_is_vtlb_excp;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // plic_u/irq_in[28] <-> vp2_station_u/out_b2s_is_vtlb_excp
  assign plic_u__irq_in[28]                                         = vp2_station_u__out_b2s_is_vtlb_excp;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // plic_u/irq_in[29] <-> vp3_station_u/out_b2s_is_vtlb_excp
  assign plic_u__irq_in[29]                                         = vp3_station_u__out_b2s_is_vtlb_excp;
  `endif

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[2] <-> 'b0
  assign plic_u__irq_in[2]                                          = {{($bits(plic_u__irq_in[2])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[30] <-> 'b0
  assign plic_u__irq_in[30]                                         = {{($bits(plic_u__irq_in[30])-1){1'b0}}, 1'b0};
  `endif

  

  // plic_u/irq_in[31] <-> dma_station_u/out_b2s_thread0_intr
  assign plic_u__irq_in[31]                                         = dma_station_u__out_b2s_thread0_intr;

  // plic_u/irq_in[32] <-> dma_station_u/out_b2s_thread1_intr
  assign plic_u__irq_in[32]                                         = dma_station_u__out_b2s_thread1_intr;

  // plic_u/irq_in[33] <-> dma_station_u/out_b2s_thread2_intr
  assign plic_u__irq_in[33]                                         = dma_station_u__out_b2s_thread2_intr;

  // plic_u/irq_in[34] <-> dma_station_u/out_b2s_thread3_intr
  assign plic_u__irq_in[34]                                         = dma_station_u__out_b2s_thread3_intr;

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[3] <-> 'b0
  assign plic_u__irq_in[3]                                          = {{($bits(plic_u__irq_in[3])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[4] <-> 'b0
  assign plic_u__irq_in[4]                                          = {{($bits(plic_u__irq_in[4])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[5] <-> 'b0
  assign plic_u__irq_in[5]                                          = {{($bits(plic_u__irq_in[5])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[6] <-> 'b0
  assign plic_u__irq_in[6]                                          = {{($bits(plic_u__irq_in[6])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[7] <-> 'b0
  assign plic_u__irq_in[7]                                          = {{($bits(plic_u__irq_in[7])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[8] <-> 'b0
  assign plic_u__irq_in[8]                                          = {{($bits(plic_u__irq_in[8])-1){1'b0}}, 1'b0};
  `endif

  

  `ifndef IFNDEF_NO_SSP_TOP
  // plic_u/irq_in[9] <-> 'b0
  assign plic_u__irq_in[9]                                          = {{($bits(plic_u__irq_in[9])-1){1'b0}}, 1'b0};
  `endif

  

  // pll_station_u.i_resp_local_if <-> bank0_station_u.o_resp_ring_if
  assign bank0_station_u__o_resp_ring_if_bready                     = pll_station_u__i_resp_local_if_bready;
  assign bank0_station_u__o_resp_ring_if_rready                     = pll_station_u__i_resp_local_if_rready;
  assign pll_station_u__i_resp_local_if_b                           = bank0_station_u__o_resp_ring_if_b;
  assign pll_station_u__i_resp_local_if_bvalid                      = bank0_station_u__o_resp_ring_if_bvalid;
  assign pll_station_u__i_resp_local_if_r                           = bank0_station_u__o_resp_ring_if_r;
  assign pll_station_u__i_resp_local_if_rvalid                      = bank0_station_u__o_resp_ring_if_rvalid;

  // pll_station_u.i_resp_ring_if <-> sdio_station_u.o_resp_ring_if
  assign pll_station_u__i_resp_ring_if_b                            = sdio_station_u__o_resp_ring_if_b;
  assign pll_station_u__i_resp_ring_if_bvalid                       = sdio_station_u__o_resp_ring_if_bvalid;
  assign pll_station_u__i_resp_ring_if_r                            = sdio_station_u__o_resp_ring_if_r;
  assign pll_station_u__i_resp_ring_if_rvalid                       = sdio_station_u__o_resp_ring_if_rvalid;
  assign sdio_station_u__o_resp_ring_if_bready                      = pll_station_u__i_resp_ring_if_bready;
  assign sdio_station_u__o_resp_ring_if_rready                      = pll_station_u__i_resp_ring_if_rready;

  // pll_station_u.o_req_local_if <-> bank0_station_u.i_req_ring_if
  assign bank0_station_u__i_req_ring_if_ar                          = pll_station_u__o_req_local_if_ar;
  assign bank0_station_u__i_req_ring_if_arvalid                     = pll_station_u__o_req_local_if_arvalid;
  assign bank0_station_u__i_req_ring_if_aw                          = pll_station_u__o_req_local_if_aw;
  assign bank0_station_u__i_req_ring_if_awvalid                     = pll_station_u__o_req_local_if_awvalid;
  assign bank0_station_u__i_req_ring_if_w                           = pll_station_u__o_req_local_if_w;
  assign bank0_station_u__i_req_ring_if_wvalid                      = pll_station_u__o_req_local_if_wvalid;
  assign pll_station_u__o_req_local_if_arready                      = bank0_station_u__i_req_ring_if_arready;
  assign pll_station_u__o_req_local_if_awready                      = bank0_station_u__i_req_ring_if_awready;
  assign pll_station_u__o_req_local_if_wready                       = bank0_station_u__i_req_ring_if_wready;

  // pll_station_u.o_req_ring_if <-> sdio_station_u.i_req_ring_if
  assign pll_station_u__o_req_ring_if_arready                       = sdio_station_u__i_req_ring_if_arready;
  assign pll_station_u__o_req_ring_if_awready                       = sdio_station_u__i_req_ring_if_awready;
  assign pll_station_u__o_req_ring_if_wready                        = sdio_station_u__i_req_ring_if_wready;
  assign sdio_station_u__i_req_ring_if_ar                           = pll_station_u__o_req_ring_if_ar;
  assign sdio_station_u__i_req_ring_if_arvalid                      = pll_station_u__o_req_ring_if_arvalid;
  assign sdio_station_u__i_req_ring_if_aw                           = pll_station_u__o_req_ring_if_aw;
  assign sdio_station_u__i_req_ring_if_awvalid                      = pll_station_u__o_req_ring_if_awvalid;
  assign sdio_station_u__i_req_ring_if_w                            = pll_station_u__o_req_ring_if_w;
  assign sdio_station_u__i_req_ring_if_wvalid                       = pll_station_u__o_req_ring_if_wvalid;

  // pll_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign pll_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;

  // pll_station_u/in_mtime <-> timer_interrupt_u/mtime_out
  assign pll_station_u__in_mtime                                    = timer_interrupt_u__mtime_out;

  // pll_station_u/rstn <-> pll_rstn_sync_u/rstn_out
  assign pll_station_u__rstn                                        = pll_rstn_sync_u__rstn_out;

  // pll_station_u/vld_in_mtime <-> pll_station_u/out_debug_info_enable
  assign pll_station_u__vld_in_mtime                                = pll_station_u__out_debug_info_enable;

  

  `ifdef IFDEF_NO_USB__IFNDEF_TB_USE_ROB
  // rob_u.io_rob_req_if[0] <-> 'b0
  assign rob_u__io_rob_req_if_req[0]                                = {{($bits(rob_u__io_rob_req_if_req[0])-1){1'b0}}, 1'b0};
  assign rob_u__io_rob_req_if_req_valid[0]                          = {{($bits(rob_u__io_rob_req_if_req_valid[0])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_SDIO__IFNDEF_TB_USE_ROB
  // rob_u.io_rob_req_if[1] <-> 'b0
  assign rob_u__io_rob_req_if_req[1]                                = {{($bits(rob_u__io_rob_req_if_req[1])-1){1'b0}}, 1'b0};
  assign rob_u__io_rob_req_if_req_valid[1]                          = {{($bits(rob_u__io_rob_req_if_req_valid[1])-1){1'b0}}, 1'b0};
  `endif

  `ifndef IFNDEF_TB_USE_CPU_NOC
  // rob_u.noc_rob_resp_if <-> 'b0
  assign rob_u__noc_rob_resp_if_resp                                = {{($bits(rob_u__noc_rob_resp_if_resp)-1){1'b0}}, 1'b0};
  assign rob_u__noc_rob_resp_if_resp_valid                          = {{($bits(rob_u__noc_rob_resp_if_resp_valid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // rob_u.noc_rob_resp_if <-> cpu_noc_u.noc_cpu_resp_if[6]
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[6]                   = rob_u__noc_rob_resp_if_resp_ready;
  assign rob_u__noc_rob_resp_if_resp                                = cpu_noc_u__noc_cpu_resp_if_resp[6];
  assign rob_u__noc_rob_resp_if_resp_valid                          = cpu_noc_u__noc_cpu_resp_if_resp_valid[6];
  `endif

  `ifdef IFDEF_NO_USB__IFNDEF_TB_USE_ROB
  // rob_u.rob_io_resp_if[0] <-> 'b0
  assign rob_u__rob_io_resp_if_resp_ready[0]                        = {{($bits(rob_u__rob_io_resp_if_resp_ready[0])-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFDEF_NO_SDIO__IFNDEF_TB_USE_ROB
  // rob_u.rob_io_resp_if[1] <-> 'b0
  assign rob_u__rob_io_resp_if_resp_ready[1]                        = {{($bits(rob_u__rob_io_resp_if_resp_ready[1])-1){1'b0}}, 1'b0};
  `endif

  `ifndef IFNDEF_TB_USE_CPU_NOC
  // rob_u.rob_noc_req_if <-> 'b0
  assign rob_u__rob_noc_req_if_req_ready                            = {{($bits(rob_u__rob_noc_req_if_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // rob_u.rob_noc_req_if <-> cpu_noc_u.cpu_noc_req_if[6]
  assign cpu_noc_u__cpu_noc_req_if_req[6]                           = rob_u__rob_noc_req_if_req;
  assign cpu_noc_u__cpu_noc_req_if_req_valid[6]                     = rob_u__rob_noc_req_if_req_valid;
  assign rob_u__rob_noc_req_if_req_ready                            = cpu_noc_u__cpu_noc_req_if_req_ready[6];
  `endif

  // rob_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign rob_u__clk                                                 = dft_pllclk_clk_buf_u0__out;

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // rob_u/entry_vld_pbank <-> cpu_noc_u/entry_vld_pbank
  assign cpu_noc_u__entry_vld_pbank                                 = rob_u__entry_vld_pbank;
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // rob_u/is_oldest_pbank <-> cpu_noc_u/is_oldest_pbank
  assign cpu_noc_u__is_oldest_pbank                                 = rob_u__is_oldest_pbank;
  `endif

  // rob_u/rstn <-> rob_rstn_sync_u/rstn_out
  assign rob_u__rstn                                                = rob_rstn_sync_u__rstn_out;

  // sdio_pllclk_icg_u/clk <-> dft_pllclk_clk_buf_u1/out
  assign sdio_pllclk_icg_u__clk                                     = dft_pllclk_clk_buf_u1__out;

  // sdio_pllclk_icg_u/clkg <-> dft_sdio_refclk_mux_u/din0
  assign dft_sdio_refclk_mux_u__din0                                = sdio_pllclk_icg_u__clkg;

  // sdio_pllclk_icg_u/en <-> sdio_station_u/out_s2icg_pllclk_en
  assign sdio_pllclk_icg_u__en                                      = sdio_station_u__out_s2icg_pllclk_en;

  // sdio_pllclk_icg_u/rstn <-> soc_top/chip_resetn
  assign sdio_pllclk_icg_u__rstn                                    = soc_top__chip_resetn;

  // sdio_pllclk_icg_u/tst_en <-> 'b0
  assign sdio_pllclk_icg_u__tst_en                                  = {{($bits(sdio_pllclk_icg_u__tst_en)-1){1'b0}}, 1'b0};

  // sdio_station_u.i_req_local_if <-> test_io_u.or_req_if
  assign sdio_station_u__i_req_local_if_ar                          = test_io_u__or_req_if_ar;
  assign sdio_station_u__i_req_local_if_arvalid                     = test_io_u__or_req_if_arvalid;
  assign sdio_station_u__i_req_local_if_aw                          = test_io_u__or_req_if_aw;
  assign sdio_station_u__i_req_local_if_awvalid                     = test_io_u__or_req_if_awvalid;
  assign sdio_station_u__i_req_local_if_w                           = test_io_u__or_req_if_w;
  assign sdio_station_u__i_req_local_if_wvalid                      = test_io_u__or_req_if_wvalid;
  assign test_io_u__or_req_if_arready                               = sdio_station_u__i_req_local_if_arready;
  assign test_io_u__or_req_if_awready                               = sdio_station_u__i_req_local_if_awready;
  assign test_io_u__or_req_if_wready                                = sdio_station_u__i_req_local_if_wready;

  `ifndef IFNDEF_NO_SDIO
  // sdio_station_u.i_resp_local_if <-> 'b0
  assign sdio_station_u__i_resp_local_if_b                          = {{($bits(sdio_station_u__i_resp_local_if_b)-1){1'b0}}, 1'b0};
  assign sdio_station_u__i_resp_local_if_bvalid                     = {{($bits(sdio_station_u__i_resp_local_if_bvalid)-1){1'b0}}, 1'b0};
  assign sdio_station_u__i_resp_local_if_r                          = {{($bits(sdio_station_u__i_resp_local_if_r)-1){1'b0}}, 1'b0};
  assign sdio_station_u__i_resp_local_if_rvalid                     = {{($bits(sdio_station_u__i_resp_local_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  

  // sdio_station_u.i_resp_ring_if <-> dma_station_u.o_resp_ring_if
  assign dma_station_u__o_resp_ring_if_bready                       = sdio_station_u__i_resp_ring_if_bready;
  assign dma_station_u__o_resp_ring_if_rready                       = sdio_station_u__i_resp_ring_if_rready;
  assign sdio_station_u__i_resp_ring_if_b                           = dma_station_u__o_resp_ring_if_b;
  assign sdio_station_u__i_resp_ring_if_bvalid                      = dma_station_u__o_resp_ring_if_bvalid;
  assign sdio_station_u__i_resp_ring_if_r                           = dma_station_u__o_resp_ring_if_r;
  assign sdio_station_u__i_resp_ring_if_rvalid                      = dma_station_u__o_resp_ring_if_rvalid;


  `ifdef IFDEF_NO_SDIO__IFNDEF_TB_USE_ROB
  // sdio_station_u.in_b2s <-> 'b0
  assign sdio_station_u__in_b2s_card_clk_freq_sel                   = {{($bits(sdio_station_u__in_b2s_card_clk_freq_sel)-1){1'b0}}, 1'b0};
  assign sdio_station_u__in_b2s_card_clk_gen_sel                    = {{($bits(sdio_station_u__in_b2s_card_clk_gen_sel)-1){1'b0}}, 1'b0};
  assign sdio_station_u__in_b2s_led_control                         = {{($bits(sdio_station_u__in_b2s_led_control)-1){1'b0}}, 1'b0};
  assign sdio_station_u__in_b2s_sd_datxfer_width                    = {{($bits(sdio_station_u__in_b2s_sd_datxfer_width)-1){1'b0}}, 1'b0};
  assign sdio_station_u__in_b2s_sd_vdd1_on                          = {{($bits(sdio_station_u__in_b2s_sd_vdd1_on)-1){1'b0}}, 1'b0};
  assign sdio_station_u__in_b2s_sd_vdd1_sel                         = {{($bits(sdio_station_u__in_b2s_sd_vdd1_sel)-1){1'b0}}, 1'b0};
  assign sdio_station_u__in_b2s_sd_vdd2_on                          = {{($bits(sdio_station_u__in_b2s_sd_vdd2_on)-1){1'b0}}, 1'b0};
  assign sdio_station_u__in_b2s_sd_vdd2_sel                         = {{($bits(sdio_station_u__in_b2s_sd_vdd2_sel)-1){1'b0}}, 1'b0};
  `endif

  `ifndef IFNDEF_NO_SDIO
  // sdio_station_u.o_req_local_if <-> 'b0
  assign sdio_station_u__o_req_local_if_arready                     = {{($bits(sdio_station_u__o_req_local_if_arready)-1){1'b0}}, 1'b0};
  assign sdio_station_u__o_req_local_if_awready                     = {{($bits(sdio_station_u__o_req_local_if_awready)-1){1'b0}}, 1'b0};
  assign sdio_station_u__o_req_local_if_wready                      = {{($bits(sdio_station_u__o_req_local_if_wready)-1){1'b0}}, 1'b0};
  `endif

  

  // sdio_station_u.o_req_ring_if <-> dma_station_u.i_req_ring_if
  assign dma_station_u__i_req_ring_if_ar                            = sdio_station_u__o_req_ring_if_ar;
  assign dma_station_u__i_req_ring_if_arvalid                       = sdio_station_u__o_req_ring_if_arvalid;
  assign dma_station_u__i_req_ring_if_aw                            = sdio_station_u__o_req_ring_if_aw;
  assign dma_station_u__i_req_ring_if_awvalid                       = sdio_station_u__o_req_ring_if_awvalid;
  assign dma_station_u__i_req_ring_if_w                             = sdio_station_u__o_req_ring_if_w;
  assign dma_station_u__i_req_ring_if_wvalid                        = sdio_station_u__o_req_ring_if_wvalid;
  assign sdio_station_u__o_req_ring_if_arready                      = dma_station_u__i_req_ring_if_arready;
  assign sdio_station_u__o_req_ring_if_awready                      = dma_station_u__i_req_ring_if_awready;
  assign sdio_station_u__o_req_ring_if_wready                       = dma_station_u__i_req_ring_if_wready;


  // sdio_station_u.o_resp_local_if <-> test_io_u.or_rsp_if
  assign sdio_station_u__o_resp_local_if_bready                     = test_io_u__or_rsp_if_bready;
  assign sdio_station_u__o_resp_local_if_rready                     = test_io_u__or_rsp_if_rready;
  assign test_io_u__or_rsp_if_b                                     = sdio_station_u__o_resp_local_if_b;
  assign test_io_u__or_rsp_if_bvalid                                = sdio_station_u__o_resp_local_if_bvalid;
  assign test_io_u__or_rsp_if_r                                     = sdio_station_u__o_resp_local_if_r;
  assign test_io_u__or_rsp_if_rvalid                                = sdio_station_u__o_resp_local_if_rvalid;

  // sdio_station_u.vld_in_b2s <-> sdio_station_u/out_debug_info_enable
  assign sdio_station_u__vld_in_b2s_card_clk_freq_sel               = sdio_station_u__out_debug_info_enable;
  assign sdio_station_u__vld_in_b2s_card_clk_gen_sel                = sdio_station_u__out_debug_info_enable;
  assign sdio_station_u__vld_in_b2s_led_control                     = sdio_station_u__out_debug_info_enable;
  assign sdio_station_u__vld_in_b2s_sd_datxfer_width                = sdio_station_u__out_debug_info_enable;
  assign sdio_station_u__vld_in_b2s_sd_vdd1_on                      = sdio_station_u__out_debug_info_enable;
  assign sdio_station_u__vld_in_b2s_sd_vdd1_sel                     = sdio_station_u__out_debug_info_enable;
  assign sdio_station_u__vld_in_b2s_sd_vdd2_on                      = sdio_station_u__out_debug_info_enable;
  assign sdio_station_u__vld_in_b2s_sd_vdd2_sel                     = sdio_station_u__out_debug_info_enable;

  // sdio_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign sdio_station_u__clk                                        = dft_pllclk_clk_buf_u0__out;

  // sdio_station_u/out_s2b_test_io_clkdiv_half_div_less_1 <-> test_io_u/clk_div_half
  assign test_io_u__clk_div_half                                    = sdio_station_u__out_s2b_test_io_clkdiv_half_div_less_1;

  // sdio_station_u/rstn <-> sdio_rstn_sync_u/rstn_out
  assign sdio_station_u__rstn                                       = sdio_rstn_sync_u__rstn_out;

  

  

  

  

  

  

  

  

  

  // slow_io_clk_div_u/dft_en <-> soc_top/dft_mode
  assign slow_io_clk_div_u__dft_en                                  = soc_top__dft_mode;

  // slow_io_clk_div_u/divclk <-> slow_io_rstn_sync_u/clk
  assign slow_io_rstn_sync_u__clk                                   = slow_io_clk_div_u__divclk;

  // slow_io_clk_div_u/divclk_sel <-> byp_station_u/out_s2b_slow_io_clkdiv_divclk_sel
  assign slow_io_clk_div_u__divclk_sel                              = byp_station_u__out_s2b_slow_io_clkdiv_divclk_sel;

  // slow_io_clk_div_u/half_div_less_1 <-> byp_station_u/out_s2b_slow_io_clkdiv_half_div_less_1
  assign slow_io_clk_div_u__half_div_less_1                         = byp_station_u__out_s2b_slow_io_clkdiv_half_div_less_1;

  // slow_io_clk_div_u/refclk <-> dft_pllclk_clk_buf_u2/out
  assign slow_io_clk_div_u__refclk                                  = dft_pllclk_clk_buf_u2__out;

  

  

  

  

  // slow_io_local_1_to_2_u/clk <-> slow_io_clk_div_u/divclk
  assign slow_io_local_1_to_2_u__clk                                = slow_io_clk_div_u__divclk;

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // slow_io_local_2_to_1_u.i_or_req_if[0] <-> bootup_fsm_u.or_req_if
  assign bootup_fsm_u__or_req_if_arready                            = slow_io_local_2_to_1_u__i_or_req_if_arready[0];
  assign bootup_fsm_u__or_req_if_awready                            = slow_io_local_2_to_1_u__i_or_req_if_awready[0];
  assign bootup_fsm_u__or_req_if_wready                             = slow_io_local_2_to_1_u__i_or_req_if_wready[0];
  assign slow_io_local_2_to_1_u__i_or_req_if_ar[0]                  = bootup_fsm_u__or_req_if_ar;
  assign slow_io_local_2_to_1_u__i_or_req_if_arvalid[0]             = bootup_fsm_u__or_req_if_arvalid;
  assign slow_io_local_2_to_1_u__i_or_req_if_aw[0]                  = bootup_fsm_u__or_req_if_aw;
  assign slow_io_local_2_to_1_u__i_or_req_if_awvalid[0]             = bootup_fsm_u__or_req_if_awvalid;
  assign slow_io_local_2_to_1_u__i_or_req_if_w[0]                   = bootup_fsm_u__or_req_if_w;
  assign slow_io_local_2_to_1_u__i_or_req_if_wvalid[0]              = bootup_fsm_u__or_req_if_wvalid;
  `endif

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // slow_io_local_2_to_1_u.i_or_req_if[1] <-> boot_from_flash_u.axim_req_if
  assign boot_from_flash_u__axim_req_if_arready                     = slow_io_local_2_to_1_u__i_or_req_if_arready[1];
  assign boot_from_flash_u__axim_req_if_awready                     = slow_io_local_2_to_1_u__i_or_req_if_awready[1];
  assign boot_from_flash_u__axim_req_if_wready                      = slow_io_local_2_to_1_u__i_or_req_if_wready[1];
  assign slow_io_local_2_to_1_u__i_or_req_if_ar[1]                  = boot_from_flash_u__axim_req_if_ar;
  assign slow_io_local_2_to_1_u__i_or_req_if_arvalid[1]             = boot_from_flash_u__axim_req_if_arvalid;
  assign slow_io_local_2_to_1_u__i_or_req_if_aw[1]                  = boot_from_flash_u__axim_req_if_aw;
  assign slow_io_local_2_to_1_u__i_or_req_if_awvalid[1]             = boot_from_flash_u__axim_req_if_awvalid;
  assign slow_io_local_2_to_1_u__i_or_req_if_w[1]                   = boot_from_flash_u__axim_req_if_w;
  assign slow_io_local_2_to_1_u__i_or_req_if_wvalid[1]              = boot_from_flash_u__axim_req_if_wvalid;
  `endif

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // slow_io_local_2_to_1_u.o_or_rsp_if[0] <-> bootup_fsm_u.or_rsp_if
  assign bootup_fsm_u__or_rsp_if_b                                  = slow_io_local_2_to_1_u__o_or_rsp_if_b[0];
  assign bootup_fsm_u__or_rsp_if_bvalid                             = slow_io_local_2_to_1_u__o_or_rsp_if_bvalid[0];
  assign bootup_fsm_u__or_rsp_if_r                                  = slow_io_local_2_to_1_u__o_or_rsp_if_r[0];
  assign bootup_fsm_u__or_rsp_if_rvalid                             = slow_io_local_2_to_1_u__o_or_rsp_if_rvalid[0];
  assign slow_io_local_2_to_1_u__o_or_rsp_if_bready[0]              = bootup_fsm_u__or_rsp_if_bready;
  assign slow_io_local_2_to_1_u__o_or_rsp_if_rready[0]              = bootup_fsm_u__or_rsp_if_rready;
  `endif

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // slow_io_local_2_to_1_u.o_or_rsp_if[1] <-> boot_from_flash_u.axim_rsp_if
  assign boot_from_flash_u__axim_rsp_if_b                           = slow_io_local_2_to_1_u__o_or_rsp_if_b[1];
  assign boot_from_flash_u__axim_rsp_if_bvalid                      = slow_io_local_2_to_1_u__o_or_rsp_if_bvalid[1];
  assign boot_from_flash_u__axim_rsp_if_r                           = slow_io_local_2_to_1_u__o_or_rsp_if_r[1];
  assign boot_from_flash_u__axim_rsp_if_rvalid                      = slow_io_local_2_to_1_u__o_or_rsp_if_rvalid[1];
  assign slow_io_local_2_to_1_u__o_or_rsp_if_bready[1]              = boot_from_flash_u__axim_rsp_if_bready;
  assign slow_io_local_2_to_1_u__o_or_rsp_if_rready[1]              = boot_from_flash_u__axim_rsp_if_rready;
  `endif

  // slow_io_local_2_to_1_u/clk <-> slow_io_clk_div_u/divclk
  assign slow_io_local_2_to_1_u__clk                                = slow_io_clk_div_u__divclk;

  // slow_io_rstn_sync_u/rstn_out <-> boot_from_flash_u/rstn
  assign boot_from_flash_u__rstn                                    = slow_io_rstn_sync_u__rstn_out;

  // slow_io_rstn_sync_u/rstn_out <-> bootup_fsm_u/rstn
  assign bootup_fsm_u__rstn                                         = slow_io_rstn_sync_u__rstn_out;

  // slow_io_rstn_sync_u/rstn_out <-> oursring_cdc_ddr2io_u/master_resetn
  assign oursring_cdc_ddr2io_u__master_resetn                       = slow_io_rstn_sync_u__rstn_out;

  // slow_io_rstn_sync_u/rstn_out <-> oursring_cdc_io2byp_u/slave_resetn
  assign oursring_cdc_io2byp_u__slave_resetn                        = slow_io_rstn_sync_u__rstn_out;

  // slow_io_rstn_sync_u/rstn_out <-> slow_io_local_1_to_2_u/rstn
  assign slow_io_local_1_to_2_u__rstn                               = slow_io_rstn_sync_u__rstn_out;

  // slow_io_rstn_sync_u/rstn_out <-> slow_io_local_2_to_1_u/rstn
  assign slow_io_local_2_to_1_u__rstn                               = slow_io_rstn_sync_u__rstn_out;

  // slow_io_rstn_sync_u/rstn_out <-> slow_io_station_u/rstn
  assign slow_io_station_u__rstn                                    = slow_io_rstn_sync_u__rstn_out;

  

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // slow_io_station_u.i_req_local_if <-> slow_io_local_2_to_1_u.o_or_req_if
  assign slow_io_local_2_to_1_u__o_or_req_if_arready                = slow_io_station_u__i_req_local_if_arready;
  assign slow_io_local_2_to_1_u__o_or_req_if_awready                = slow_io_station_u__i_req_local_if_awready;
  assign slow_io_local_2_to_1_u__o_or_req_if_wready                 = slow_io_station_u__i_req_local_if_wready;
  assign slow_io_station_u__i_req_local_if_ar                       = slow_io_local_2_to_1_u__o_or_req_if_ar;
  assign slow_io_station_u__i_req_local_if_arvalid                  = slow_io_local_2_to_1_u__o_or_req_if_arvalid;
  assign slow_io_station_u__i_req_local_if_aw                       = slow_io_local_2_to_1_u__o_or_req_if_aw;
  assign slow_io_station_u__i_req_local_if_awvalid                  = slow_io_local_2_to_1_u__o_or_req_if_awvalid;
  assign slow_io_station_u__i_req_local_if_w                        = slow_io_local_2_to_1_u__o_or_req_if_w;
  assign slow_io_station_u__i_req_local_if_wvalid                   = slow_io_local_2_to_1_u__o_or_req_if_wvalid;
  `endif

  `ifdef IFDEF_NO_SSP_TOP
  // slow_io_station_u.i_resp_local_if <-> 'b0
  assign slow_io_station_u__i_resp_local_if_b                       = {{($bits(slow_io_station_u__i_resp_local_if_b)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__i_resp_local_if_bvalid                  = {{($bits(slow_io_station_u__i_resp_local_if_bvalid)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__i_resp_local_if_r                       = {{($bits(slow_io_station_u__i_resp_local_if_r)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__i_resp_local_if_rvalid                  = {{($bits(slow_io_station_u__i_resp_local_if_rvalid)-1){1'b0}}, 1'b0};
  `endif

  

  // slow_io_station_u.i_resp_ring_if <-> oursring_cdc_io2byp_u.cdc_oursring_slave_rsp_if
  assign oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_bready    = slow_io_station_u__i_resp_ring_if_bready;
  assign oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_rready    = slow_io_station_u__i_resp_ring_if_rready;
  assign slow_io_station_u__i_resp_ring_if_b                        = oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_b;
  assign slow_io_station_u__i_resp_ring_if_bvalid                   = oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_bvalid;
  assign slow_io_station_u__i_resp_ring_if_r                        = oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_r;
  assign slow_io_station_u__i_resp_ring_if_rvalid                   = oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_rvalid;

  `ifdef IFDEF_NO_SSP_TOP
  // slow_io_station_u.in_b2s <-> 'b0
  assign slow_io_station_u__in_b2s_i2c0_debug_addr                  = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_addr)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_addr_10bit            = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_addr_10bit)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_data                  = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_data)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_hs                    = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_hs)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_master_act            = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_master_act)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_mst_cstate            = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_mst_cstate)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_p_gen                 = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_p_gen)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_rd                    = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_rd)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_s_gen                 = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_s_gen)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_slave_act             = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_slave_act)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_slv_cstate            = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_slv_cstate)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c0_debug_wr                    = {{($bits(slow_io_station_u__in_b2s_i2c0_debug_wr)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_addr                  = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_addr)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_addr_10bit            = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_addr_10bit)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_data                  = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_data)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_hs                    = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_hs)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_master_act            = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_master_act)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_mst_cstate            = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_mst_cstate)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_p_gen                 = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_p_gen)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_rd                    = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_rd)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_s_gen                 = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_s_gen)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_slave_act             = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_slave_act)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_slv_cstate            = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_slv_cstate)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c1_debug_wr                    = {{($bits(slow_io_station_u__in_b2s_i2c1_debug_wr)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_addr                  = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_addr)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_addr_10bit            = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_addr_10bit)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_data                  = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_data)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_hs                    = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_hs)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_master_act            = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_master_act)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_mst_cstate            = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_mst_cstate)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_p_gen                 = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_p_gen)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_rd                    = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_rd)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_s_gen                 = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_s_gen)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_slave_act             = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_slave_act)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_slv_cstate            = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_slv_cstate)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_i2c2_debug_wr                    = {{($bits(slow_io_station_u__in_b2s_i2c2_debug_wr)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_qspim_ssi_busy                   = {{($bits(slow_io_station_u__in_b2s_qspim_ssi_busy)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_qspim_ssi_sleep                  = {{($bits(slow_io_station_u__in_b2s_qspim_ssi_sleep)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_rtc_en                           = {{($bits(slow_io_station_u__in_b2s_rtc_en)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_spis_ssi_sleep                   = {{($bits(slow_io_station_u__in_b2s_spis_ssi_sleep)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_sspim0_ssi_sleep                 = {{($bits(slow_io_station_u__in_b2s_sspim0_ssi_sleep)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_sspim1_ssi_sleep                 = {{($bits(slow_io_station_u__in_b2s_sspim1_ssi_sleep)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_sspim2_ssi_sleep                 = {{($bits(slow_io_station_u__in_b2s_sspim2_ssi_sleep)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__in_b2s_timer_en                         = {{($bits(slow_io_station_u__in_b2s_timer_en)-1){1'b0}}, 1'b0};
  `endif

  

  `ifdef IFDEF_NO_SSP_TOP
  // slow_io_station_u.o_req_local_if <-> 'b0
  assign slow_io_station_u__o_req_local_if_arready                  = {{($bits(slow_io_station_u__o_req_local_if_arready)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__o_req_local_if_awready                  = {{($bits(slow_io_station_u__o_req_local_if_awready)-1){1'b0}}, 1'b0};
  assign slow_io_station_u__o_req_local_if_wready                   = {{($bits(slow_io_station_u__o_req_local_if_wready)-1){1'b0}}, 1'b0};
  `endif

  

  // slow_io_station_u.o_req_ring_if <-> oursring_cdc_io2byp_u.oursring_cdc_slave_req_if
  assign oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_ar        = slow_io_station_u__o_req_ring_if_ar;
  assign oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_arvalid   = slow_io_station_u__o_req_ring_if_arvalid;
  assign oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_aw        = slow_io_station_u__o_req_ring_if_aw;
  assign oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_awvalid   = slow_io_station_u__o_req_ring_if_awvalid;
  assign oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_w         = slow_io_station_u__o_req_ring_if_w;
  assign oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_wvalid    = slow_io_station_u__o_req_ring_if_wvalid;
  assign slow_io_station_u__o_req_ring_if_arready                   = oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_arready;
  assign slow_io_station_u__o_req_ring_if_awready                   = oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_awready;
  assign slow_io_station_u__o_req_ring_if_wready                    = oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_wready;

  `ifdef IFNDEF_TB_TORTURE_OURSRING
  // slow_io_station_u.o_resp_local_if <-> slow_io_local_2_to_1_u.i_or_rsp_if
  assign slow_io_local_2_to_1_u__i_or_rsp_if_b                      = slow_io_station_u__o_resp_local_if_b;
  assign slow_io_local_2_to_1_u__i_or_rsp_if_bvalid                 = slow_io_station_u__o_resp_local_if_bvalid;
  assign slow_io_local_2_to_1_u__i_or_rsp_if_r                      = slow_io_station_u__o_resp_local_if_r;
  assign slow_io_local_2_to_1_u__i_or_rsp_if_rvalid                 = slow_io_station_u__o_resp_local_if_rvalid;
  assign slow_io_station_u__o_resp_local_if_bready                  = slow_io_local_2_to_1_u__i_or_rsp_if_bready;
  assign slow_io_station_u__o_resp_local_if_rready                  = slow_io_local_2_to_1_u__i_or_rsp_if_rready;
  `endif

  

  

  // slow_io_station_u.vld_in_b2s <-> slow_io_station_u/out_debug_info_enable
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_addr              = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_addr_10bit        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_data              = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_hs                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_master_act        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_mst_cstate        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_p_gen             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_rd                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_s_gen             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_slave_act         = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_slv_cstate        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c0_debug_wr                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_addr              = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_addr_10bit        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_data              = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_hs                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_master_act        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_mst_cstate        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_p_gen             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_rd                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_s_gen             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_slave_act         = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_slv_cstate        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c1_debug_wr                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_addr              = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_addr_10bit        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_data              = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_hs                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_master_act        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_mst_cstate        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_p_gen             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_rd                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_s_gen             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_slave_act         = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_slv_cstate        = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_i2c2_debug_wr                = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_qspim_ssi_busy               = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_qspim_ssi_sleep              = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_rtc_en                       = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_spis_ssi_sleep               = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_sspim0_ssi_sleep             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_sspim1_ssi_sleep             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_sspim2_ssi_sleep             = slow_io_station_u__out_debug_info_enable;
  assign slow_io_station_u__vld_in_b2s_timer_en                     = slow_io_station_u__out_debug_info_enable;

  // slow_io_station_u/clk <-> slow_io_clk_div_u/divclk
  assign slow_io_station_u__clk                                     = slow_io_clk_div_u__divclk;

  // slow_io_station_u/out_s2b_boot_from_flash_ena <-> boot_from_flash_en_u/in1
  assign boot_from_flash_en_u__in1                                  = slow_io_station_u__out_s2b_boot_from_flash_ena;

  // slow_io_station_u/out_s2b_boot_from_flash_ena <-> boot_from_flash_mux_u/din1
  assign boot_from_flash_mux_u__din1                                = slow_io_station_u__out_s2b_boot_from_flash_ena;

  // slow_io_station_u/out_s2b_boot_from_flash_ena_sw_ctrl <-> boot_from_flash_mux_u/sel
  assign boot_from_flash_mux_u__sel                                 = slow_io_station_u__out_s2b_boot_from_flash_ena_sw_ctrl;

  // slow_io_station_u/out_s2b_bootup_ena <-> boot_fsm_en_u/in1
  assign boot_fsm_en_u__in1                                         = slow_io_station_u__out_s2b_bootup_ena;

  // slow_io_station_u/out_s2b_bootup_ena <-> boot_fsm_mux_u/din1
  assign boot_fsm_mux_u__din1                                       = slow_io_station_u__out_s2b_bootup_ena;

  // slow_io_station_u/out_s2b_bootup_ena_sw_ctrl <-> boot_fsm_mux_u/sel
  assign boot_fsm_mux_u__sel                                        = slow_io_station_u__out_s2b_bootup_ena_sw_ctrl;

  

  

  

  

  

  

  

  

  

  

  

  // soc_top/B1_ddr_pwr_ok_in <-> dft_mux_ddr_s2b_pwr_ok_in_u/din1
  assign dft_mux_ddr_s2b_pwr_ok_in_u__din1                          = B1_ddr_pwr_ok_in;

  

  

  

  

  

  

  

  // soc_top/B3_dft_mbist_mode <-> dft_mode_enable_u/B3_dft_mbist_mode
  assign dft_mode_enable_u__B3_dft_mbist_mode                       = B3_dft_mbist_mode;

  // soc_top/B3_dft_mbist_mode <-> mbist_mode_buf/in
  assign mbist_mode_buf__in                                         = B3_dft_mbist_mode;

  

  

  

  

  

  

  

  `ifdef IFNDEF_NO_DDR
  // soc_top/BP_MEMRESET_L <-> ddr_top_u/BP_MEMRESET_L
  assign BP_MEMRESET_L                                              = ddr_top_u__BP_MEMRESET_L;
  `endif

  `ifdef IFNDEF_NO_DDR
  // soc_top/BP_ZN <-> ddr_top_u/BP_ZN
  assign BP_ZN                                                      = ddr_top_u__BP_ZN;
  `endif

  `ifdef IFNDEF_NO_DDR
  // soc_top/BP_ZN_SENSE <-> ddr_top_u/BP_ZN_SENSE
  assign ddr_top_u__BP_ZN_SENSE                                     = BP_ZN_SENSE;
  `endif

  // soc_top/BypassInDataAC <-> buf_BypassInDataAC_u/out
  assign BypassInDataAC                                             = buf_BypassInDataAC_u__out;

  // soc_top/BypassInDataDAT <-> buf_BypassInDataDAT_u/out
  assign BypassInDataDAT                                            = buf_BypassInDataDAT_u__out;

  // soc_top/BypassInDataMASTER <-> buf_BypassInDataMASTER_u/out
  assign BypassInDataMASTER                                         = buf_BypassInDataMASTER_u__out;

  // soc_top/BypassModeEnAC <-> dft_mux_BypassModeEnAC_u/din1
  assign dft_mux_BypassModeEnAC_u__din1                             = BypassModeEnAC;

  // soc_top/BypassModeEnDAT <-> dft_mux_BypassModeEnDAT_u/din1
  assign dft_mux_BypassModeEnDAT_u__din1                            = BypassModeEnDAT;

  // soc_top/BypassModeEnMASTER <-> dft_mux_BypassModeEnMASTER_u/din1
  assign dft_mux_BypassModeEnMASTER_u__din1                         = BypassModeEnMASTER;

  // soc_top/BypassOutDataAC <-> dft_mux_BypassOutDataAC_u/din1
  assign dft_mux_BypassOutDataAC_u__din1                            = BypassOutDataAC;

  // soc_top/BypassOutDataDAT <-> dft_mux_BypassOutDataDAT_u/din1
  assign dft_mux_BypassOutDataDAT_u__din1                           = BypassOutDataDAT;

  // soc_top/BypassOutDataMASTER <-> dft_mux_BypassOutDataMASTER_u/din1
  assign dft_mux_BypassOutDataMASTER_u__din1                        = BypassOutDataMASTER;

  // soc_top/BypassOutEnAC <-> dft_mux_BypassOutEnAC_u/din1
  assign dft_mux_BypassOutEnAC_u__din1                              = BypassOutEnAC;

  // soc_top/BypassOutEnDAT <-> dft_mux_BypassOutEnDAT_u/din1
  assign dft_mux_BypassOutEnDAT_u__din1                             = BypassOutEnDAT;

  // soc_top/BypassOutEnMASTER <-> dft_mux_BypassOutEnMASTER_u/din1
  assign dft_mux_BypassOutEnMASTER_u__din1                          = BypassOutEnMASTER;

  // soc_top/C25_usb_pwrdown_ssp <-> dft_mux_test_powerdown_ssp_u/din1
  assign dft_mux_test_powerdown_ssp_u__din1                         = C25_usb_pwrdown_ssp;

  // soc_top/C26_usb_pwrdown_hsp <-> dft_mux_test_powerdown_hsp_u/din1
  assign dft_mux_test_powerdown_hsp_u__din1                         = C26_usb_pwrdown_hsp;

  // soc_top/C27_usb_ref_ssp_en <-> dft_mux_s2b_ref_ssp_en_u/din1
  assign dft_mux_s2b_ref_ssp_en_u__din1                             = C27_usb_ref_ssp_en;

  // soc_top/C28_usb_ref_use_pad <-> dft_mux_s2b_ref_use_pad_u/din1
  assign dft_mux_s2b_ref_use_pad_u__din1                            = C28_usb_ref_use_pad;

  // soc_top/DIN_DONE <-> usb_station_u/out_s2dft_mbist_done
  assign DIN_DONE                                                   = usb_station_u__out_s2dft_mbist_done;

  // soc_top/DIN_ERROR_LOG_HI <-> usb_station_u/out_s2dft_mbist_error_log_hi
  assign DIN_ERROR_LOG_HI                                           = usb_station_u__out_s2dft_mbist_error_log_hi;

  // soc_top/DIN_ERROR_LOG_LO <-> usb_station_u/out_s2dft_mbist_error_log_lo
  assign DIN_ERROR_LOG_LO                                           = usb_station_u__out_s2dft_mbist_error_log_lo;

  // soc_top/FUNC_CLK <-> dft_pllclk_clk_buf_u0/out
  assign FUNC_CLK                                                   = dft_pllclk_clk_buf_u0__out;

  // soc_top/FUNC_EN_CUS_MBIST <-> usb_station_u/out_s2dft_mbist_func_en
  assign FUNC_EN_CUS_MBIST                                          = usb_station_u__out_s2dft_mbist_func_en;

  

  // soc_top/boot_from_flash_mode <-> boot_from_flash_en_u/in0
  assign boot_from_flash_en_u__in0                                  = boot_from_flash_mode;

  // soc_top/boot_from_flash_mode <-> boot_mode_orv32_rstn_mux_u/sel
  assign boot_mode_orv32_rstn_mux_u__sel                            = boot_from_flash_mode;

  // soc_top/boot_fsm_mode <-> boot_fsm_en_u/in0
  assign boot_fsm_en_u__in0                                         = boot_fsm_mode;

  // soc_top/c2p_SSP_SHARED_sel_0 <-> slow_io_station_u/out_SSP_SHARED_sel_0
  assign c2p_SSP_SHARED_sel_0                                       = slow_io_station_u__out_SSP_SHARED_sel_0;

  // soc_top/c2p_SSP_SHARED_sel_1 <-> slow_io_station_u/out_SSP_SHARED_sel_1
  assign c2p_SSP_SHARED_sel_1                                       = slow_io_station_u__out_SSP_SHARED_sel_1;

  // soc_top/c2p_SSP_SHARED_sel_10 <-> slow_io_station_u/out_SSP_SHARED_sel_10
  assign c2p_SSP_SHARED_sel_10                                      = slow_io_station_u__out_SSP_SHARED_sel_10;

  // soc_top/c2p_SSP_SHARED_sel_11 <-> slow_io_station_u/out_SSP_SHARED_sel_11
  assign c2p_SSP_SHARED_sel_11                                      = slow_io_station_u__out_SSP_SHARED_sel_11;

  // soc_top/c2p_SSP_SHARED_sel_12 <-> slow_io_station_u/out_SSP_SHARED_sel_12
  assign c2p_SSP_SHARED_sel_12                                      = slow_io_station_u__out_SSP_SHARED_sel_12;

  // soc_top/c2p_SSP_SHARED_sel_13 <-> slow_io_station_u/out_SSP_SHARED_sel_13
  assign c2p_SSP_SHARED_sel_13                                      = slow_io_station_u__out_SSP_SHARED_sel_13;

  // soc_top/c2p_SSP_SHARED_sel_14 <-> slow_io_station_u/out_SSP_SHARED_sel_14
  assign c2p_SSP_SHARED_sel_14                                      = slow_io_station_u__out_SSP_SHARED_sel_14;

  // soc_top/c2p_SSP_SHARED_sel_15 <-> slow_io_station_u/out_SSP_SHARED_sel_15
  assign c2p_SSP_SHARED_sel_15                                      = slow_io_station_u__out_SSP_SHARED_sel_15;

  // soc_top/c2p_SSP_SHARED_sel_16 <-> slow_io_station_u/out_SSP_SHARED_sel_16
  assign c2p_SSP_SHARED_sel_16                                      = slow_io_station_u__out_SSP_SHARED_sel_16;

  // soc_top/c2p_SSP_SHARED_sel_17 <-> slow_io_station_u/out_SSP_SHARED_sel_17
  assign c2p_SSP_SHARED_sel_17                                      = slow_io_station_u__out_SSP_SHARED_sel_17;

  // soc_top/c2p_SSP_SHARED_sel_18 <-> slow_io_station_u/out_SSP_SHARED_sel_18
  assign c2p_SSP_SHARED_sel_18                                      = slow_io_station_u__out_SSP_SHARED_sel_18;

  // soc_top/c2p_SSP_SHARED_sel_19 <-> slow_io_station_u/out_SSP_SHARED_sel_19
  assign c2p_SSP_SHARED_sel_19                                      = slow_io_station_u__out_SSP_SHARED_sel_19;

  // soc_top/c2p_SSP_SHARED_sel_2 <-> slow_io_station_u/out_SSP_SHARED_sel_2
  assign c2p_SSP_SHARED_sel_2                                       = slow_io_station_u__out_SSP_SHARED_sel_2;

  // soc_top/c2p_SSP_SHARED_sel_20 <-> slow_io_station_u/out_SSP_SHARED_sel_20
  assign c2p_SSP_SHARED_sel_20                                      = slow_io_station_u__out_SSP_SHARED_sel_20;

  // soc_top/c2p_SSP_SHARED_sel_21 <-> slow_io_station_u/out_SSP_SHARED_sel_21
  assign c2p_SSP_SHARED_sel_21                                      = slow_io_station_u__out_SSP_SHARED_sel_21;

  // soc_top/c2p_SSP_SHARED_sel_22 <-> slow_io_station_u/out_SSP_SHARED_sel_22
  assign c2p_SSP_SHARED_sel_22                                      = slow_io_station_u__out_SSP_SHARED_sel_22;

  // soc_top/c2p_SSP_SHARED_sel_23 <-> slow_io_station_u/out_SSP_SHARED_sel_23
  assign c2p_SSP_SHARED_sel_23                                      = slow_io_station_u__out_SSP_SHARED_sel_23;

  // soc_top/c2p_SSP_SHARED_sel_24 <-> slow_io_station_u/out_SSP_SHARED_sel_24
  assign c2p_SSP_SHARED_sel_24                                      = slow_io_station_u__out_SSP_SHARED_sel_24;

  // soc_top/c2p_SSP_SHARED_sel_25 <-> slow_io_station_u/out_SSP_SHARED_sel_25
  assign c2p_SSP_SHARED_sel_25                                      = slow_io_station_u__out_SSP_SHARED_sel_25;

  // soc_top/c2p_SSP_SHARED_sel_26 <-> slow_io_station_u/out_SSP_SHARED_sel_26
  assign c2p_SSP_SHARED_sel_26                                      = slow_io_station_u__out_SSP_SHARED_sel_26;

  // soc_top/c2p_SSP_SHARED_sel_27 <-> slow_io_station_u/out_SSP_SHARED_sel_27
  assign c2p_SSP_SHARED_sel_27                                      = slow_io_station_u__out_SSP_SHARED_sel_27;

  // soc_top/c2p_SSP_SHARED_sel_28 <-> slow_io_station_u/out_SSP_SHARED_sel_28
  assign c2p_SSP_SHARED_sel_28                                      = slow_io_station_u__out_SSP_SHARED_sel_28;

  // soc_top/c2p_SSP_SHARED_sel_29 <-> slow_io_station_u/out_SSP_SHARED_sel_29
  assign c2p_SSP_SHARED_sel_29                                      = slow_io_station_u__out_SSP_SHARED_sel_29;

  // soc_top/c2p_SSP_SHARED_sel_3 <-> slow_io_station_u/out_SSP_SHARED_sel_3
  assign c2p_SSP_SHARED_sel_3                                       = slow_io_station_u__out_SSP_SHARED_sel_3;

  // soc_top/c2p_SSP_SHARED_sel_30 <-> slow_io_station_u/out_SSP_SHARED_sel_30
  assign c2p_SSP_SHARED_sel_30                                      = slow_io_station_u__out_SSP_SHARED_sel_30;

  // soc_top/c2p_SSP_SHARED_sel_31 <-> slow_io_station_u/out_SSP_SHARED_sel_31
  assign c2p_SSP_SHARED_sel_31                                      = slow_io_station_u__out_SSP_SHARED_sel_31;

  // soc_top/c2p_SSP_SHARED_sel_32 <-> slow_io_station_u/out_SSP_SHARED_sel_32
  assign c2p_SSP_SHARED_sel_32                                      = slow_io_station_u__out_SSP_SHARED_sel_32;

  // soc_top/c2p_SSP_SHARED_sel_33 <-> slow_io_station_u/out_SSP_SHARED_sel_33
  assign c2p_SSP_SHARED_sel_33                                      = slow_io_station_u__out_SSP_SHARED_sel_33;

  // soc_top/c2p_SSP_SHARED_sel_34 <-> slow_io_station_u/out_SSP_SHARED_sel_34
  assign c2p_SSP_SHARED_sel_34                                      = slow_io_station_u__out_SSP_SHARED_sel_34;

  // soc_top/c2p_SSP_SHARED_sel_35 <-> slow_io_station_u/out_SSP_SHARED_sel_35
  assign c2p_SSP_SHARED_sel_35                                      = slow_io_station_u__out_SSP_SHARED_sel_35;

  // soc_top/c2p_SSP_SHARED_sel_36 <-> slow_io_station_u/out_SSP_SHARED_sel_36
  assign c2p_SSP_SHARED_sel_36                                      = slow_io_station_u__out_SSP_SHARED_sel_36;

  // soc_top/c2p_SSP_SHARED_sel_37 <-> slow_io_station_u/out_SSP_SHARED_sel_37
  assign c2p_SSP_SHARED_sel_37                                      = slow_io_station_u__out_SSP_SHARED_sel_37;

  // soc_top/c2p_SSP_SHARED_sel_38 <-> slow_io_station_u/out_SSP_SHARED_sel_38
  assign c2p_SSP_SHARED_sel_38                                      = slow_io_station_u__out_SSP_SHARED_sel_38;

  // soc_top/c2p_SSP_SHARED_sel_39 <-> slow_io_station_u/out_SSP_SHARED_sel_39
  assign c2p_SSP_SHARED_sel_39                                      = slow_io_station_u__out_SSP_SHARED_sel_39;

  // soc_top/c2p_SSP_SHARED_sel_4 <-> slow_io_station_u/out_SSP_SHARED_sel_4
  assign c2p_SSP_SHARED_sel_4                                       = slow_io_station_u__out_SSP_SHARED_sel_4;

  // soc_top/c2p_SSP_SHARED_sel_40 <-> slow_io_station_u/out_SSP_SHARED_sel_40
  assign c2p_SSP_SHARED_sel_40                                      = slow_io_station_u__out_SSP_SHARED_sel_40;

  // soc_top/c2p_SSP_SHARED_sel_41 <-> slow_io_station_u/out_SSP_SHARED_sel_41
  assign c2p_SSP_SHARED_sel_41                                      = slow_io_station_u__out_SSP_SHARED_sel_41;

  // soc_top/c2p_SSP_SHARED_sel_42 <-> slow_io_station_u/out_SSP_SHARED_sel_42
  assign c2p_SSP_SHARED_sel_42                                      = slow_io_station_u__out_SSP_SHARED_sel_42;

  // soc_top/c2p_SSP_SHARED_sel_43 <-> slow_io_station_u/out_SSP_SHARED_sel_43
  assign c2p_SSP_SHARED_sel_43                                      = slow_io_station_u__out_SSP_SHARED_sel_43;

  // soc_top/c2p_SSP_SHARED_sel_44 <-> slow_io_station_u/out_SSP_SHARED_sel_44
  assign c2p_SSP_SHARED_sel_44                                      = slow_io_station_u__out_SSP_SHARED_sel_44;

  // soc_top/c2p_SSP_SHARED_sel_45 <-> slow_io_station_u/out_SSP_SHARED_sel_45
  assign c2p_SSP_SHARED_sel_45                                      = slow_io_station_u__out_SSP_SHARED_sel_45;

  // soc_top/c2p_SSP_SHARED_sel_46 <-> slow_io_station_u/out_SSP_SHARED_sel_46
  assign c2p_SSP_SHARED_sel_46                                      = slow_io_station_u__out_SSP_SHARED_sel_46;

  // soc_top/c2p_SSP_SHARED_sel_47 <-> slow_io_station_u/out_SSP_SHARED_sel_47
  assign c2p_SSP_SHARED_sel_47                                      = slow_io_station_u__out_SSP_SHARED_sel_47;

  // soc_top/c2p_SSP_SHARED_sel_5 <-> slow_io_station_u/out_SSP_SHARED_sel_5
  assign c2p_SSP_SHARED_sel_5                                       = slow_io_station_u__out_SSP_SHARED_sel_5;

  // soc_top/c2p_SSP_SHARED_sel_6 <-> slow_io_station_u/out_SSP_SHARED_sel_6
  assign c2p_SSP_SHARED_sel_6                                       = slow_io_station_u__out_SSP_SHARED_sel_6;

  // soc_top/c2p_SSP_SHARED_sel_7 <-> slow_io_station_u/out_SSP_SHARED_sel_7
  assign c2p_SSP_SHARED_sel_7                                       = slow_io_station_u__out_SSP_SHARED_sel_7;

  // soc_top/c2p_SSP_SHARED_sel_8 <-> slow_io_station_u/out_SSP_SHARED_sel_8
  assign c2p_SSP_SHARED_sel_8                                       = slow_io_station_u__out_SSP_SHARED_sel_8;

  // soc_top/c2p_SSP_SHARED_sel_9 <-> slow_io_station_u/out_SSP_SHARED_sel_9
  assign c2p_SSP_SHARED_sel_9                                       = slow_io_station_u__out_SSP_SHARED_sel_9;

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  // soc_top/c2p_test_io_clk <-> test_io_u/clk_div
  assign c2p_test_io_clk                                            = test_io_u__clk_div;

  // soc_top/c2p_test_io_clk_oen <-> test_io_u/clk_oen
  assign c2p_test_io_clk_oen                                        = test_io_u__clk_oen;

  // soc_top/c2p_test_io_data <-> test_io_u/test_dout
  assign c2p_test_io_data                                           = test_io_u__test_dout;

  // soc_top/c2p_test_io_data_oen <-> test_io_u/test_doen
  assign c2p_test_io_data_oen                                       = test_io_u__test_doen;

  // soc_top/c2p_test_io_en <-> test_io_u/test_eout
  assign c2p_test_io_en                                             = test_io_u__test_eout;

  // soc_top/c2p_test_io_en_oen <-> test_io_u/test_eoen
  assign c2p_test_io_en_oen                                         = test_io_u__test_eoen;

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  // soc_top/cclk_rx <-> dft_sdio_cclk_rx_mux_u/din0
  assign dft_sdio_cclk_rx_mux_u__din0                               = cclk_rx;

  // soc_top/chip_resetn <-> bank0_rstn_sync_u/rstn_in
  assign bank0_rstn_sync_u__rstn_in                                 = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> bank1_rstn_sync_u/rstn_in
  assign bank1_rstn_sync_u__rstn_in                                 = soc_top__chip_resetn;

  `ifdef IFNDEF_SOC_NO_BANK2
  // soc_top/chip_resetn <-> bank2_rstn_sync_u/rstn_in
  assign bank2_rstn_sync_u__rstn_in                                 = soc_top__chip_resetn;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // soc_top/chip_resetn <-> bank3_rstn_sync_u/rstn_in
  assign bank3_rstn_sync_u__rstn_in                                 = soc_top__chip_resetn;
  `endif

  // soc_top/chip_resetn <-> byp_rstn_sync_u/rstn_in
  assign byp_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> cpu_noc_rstn_sync_u/rstn_in
  assign cpu_noc_rstn_sync_u__rstn_in                               = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> ddr_hs_rstn_sync_u/rstn_in
  assign ddr_hs_rstn_sync_u__rstn_in                                = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> ddr_ls_rstn_sync_u/rstn_in
  assign ddr_ls_rstn_sync_u__rstn_in                                = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> dma_rstn_sync_u/rstn_in
  assign dma_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> dt_rstn_sync_u/rstn_in
  assign dt_rstn_sync_u__rstn_in                                    = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> jtag2or_rstn_sync_u/rstn_in
  assign jtag2or_rstn_sync_u__rstn_in                               = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> mem_noc_rstn_sync_u/rstn_in
  assign mem_noc_rstn_sync_u__rstn_in                               = soc_top__chip_resetn;

  

  // soc_top/chip_resetn <-> pll_rstn_sync_u/rstn_in
  assign pll_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> rob_rstn_sync_u/rstn_in
  assign rob_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> sdio_rstn_sync_u/rstn_in
  assign sdio_rstn_sync_u__rstn_in                                  = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> slow_io_rstn_sync_u/rstn_in
  assign slow_io_rstn_sync_u__rstn_in                               = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> test_io_rstn_sync_u/rstn_in
  assign test_io_rstn_sync_u__rstn_in                               = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> test_io_test_rstn_sync_u/rstn_in
  assign test_io_test_rstn_sync_u__rstn_in                          = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> usb_rstn_sync_u/rstn_in
  assign usb_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> vp0_rstn_sync_u/rstn_in
  assign vp0_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> vp1_rstn_sync_u/rstn_in
  assign vp1_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> vp2_rstn_sync_u/rstn_in
  assign vp2_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/chip_resetn <-> vp3_rstn_sync_u/rstn_in
  assign vp3_rstn_sync_u__rstn_in                                   = soc_top__chip_resetn;

  // soc_top/cmd_vld_in <-> jtag2or_u/cmd_vld_in
  assign jtag2or_u__cmd_vld_in                                      = cmd_vld_in;

  // soc_top/cmdbuf_in <-> jtag2or_u/cmdbuf_in
  assign jtag2or_u__cmdbuf_in                                       = cmdbuf_in;

  

  // soc_top/dft_mode <-> bank0_rstn_sync_u/scan_en
  assign bank0_rstn_sync_u__scan_en                                 = soc_top__dft_mode;

  // soc_top/dft_mode <-> bank1_rstn_sync_u/scan_en
  assign bank1_rstn_sync_u__scan_en                                 = soc_top__dft_mode;

  `ifdef IFNDEF_SOC_NO_BANK2
  // soc_top/dft_mode <-> bank2_rstn_sync_u/scan_en
  assign bank2_rstn_sync_u__scan_en                                 = soc_top__dft_mode;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // soc_top/dft_mode <-> bank3_rstn_sync_u/scan_en
  assign bank3_rstn_sync_u__scan_en                                 = soc_top__dft_mode;
  `endif

  // soc_top/dft_mode <-> byp_rstn_sync_u/scan_en
  assign byp_rstn_sync_u__scan_en                                   = soc_top__dft_mode;

  // soc_top/dft_mode <-> cpu_noc_rstn_sync_u/scan_en
  assign cpu_noc_rstn_sync_u__scan_en                               = soc_top__dft_mode;

  // soc_top/dft_mode <-> ddr_hs_rstn_sync_u/scan_en
  assign ddr_hs_rstn_sync_u__scan_en                                = soc_top__dft_mode;

  `ifdef IFNDEF_NO_DDR
  // soc_top/dft_mode <-> ddr_iso_or_u/in_1
  assign ddr_iso_or_u__in_1                                         = soc_top__dft_mode;
  `endif

  // soc_top/dft_mode <-> ddr_ls_rstn_sync_u/scan_en
  assign ddr_ls_rstn_sync_u__scan_en                                = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_bank0_rstn_mux_u/sel
  assign dft_bank0_rstn_mux_u__sel                                  = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_bank1_rstn_mux_u/sel
  assign dft_bank1_rstn_mux_u__sel                                  = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_bank2_rstn_mux_u/sel
  assign dft_bank2_rstn_mux_u__sel                                  = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_bank3_rstn_mux_u/sel
  assign dft_bank3_rstn_mux_u__sel                                  = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_ddr_rstn_mux_aresetn_u/sel
  assign dft_ddr_rstn_mux_aresetn_u__sel                            = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_ddr_rstn_mux_core_ddrc_rstn_u/sel
  assign dft_ddr_rstn_mux_core_ddrc_rstn_u__sel                     = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_ddr_rstn_mux_dfi_reset_n_u/sel
  assign dft_ddr_rstn_mux_dfi_reset_n_u__sel                        = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_ddr_rstn_mux_presetn_u/sel
  assign dft_ddr_rstn_mux_presetn_u__sel                            = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_ddrls_clkdiv_sel_mux_sel_u/scan_mode
  assign dft_ddrls_clkdiv_sel_mux_sel_u__scan_mode                  = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mode_enable_u/dft_mode
  assign soc_top__dft_mode                                          = dft_mode_enable_u__dft_mode;

  // soc_top/dft_mode <-> dft_mode_vp_enable_u/B3_dft_mbist_mode
  assign dft_mode_vp_enable_u__B3_dft_mbist_mode                    = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassModeEnAC_u/sel
  assign dft_mux_BypassModeEnAC_u__sel                              = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassModeEnDAT_u/sel
  assign dft_mux_BypassModeEnDAT_u__sel                             = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassModeEnMASTER_u/sel
  assign dft_mux_BypassModeEnMASTER_u__sel                          = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassOutDataAC_u/sel
  assign dft_mux_BypassOutDataAC_u__sel                             = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassOutDataDAT_u/sel
  assign dft_mux_BypassOutDataDAT_u__sel                            = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassOutDataMASTER_u/sel
  assign dft_mux_BypassOutDataMASTER_u__sel                         = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassOutEnAC_u/sel
  assign dft_mux_BypassOutEnAC_u__sel                               = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassOutEnDAT_u/sel
  assign dft_mux_BypassOutEnDAT_u__sel                              = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_BypassOutEnMASTER_u/sel
  assign dft_mux_BypassOutEnMASTER_u__sel                           = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_ddr_s2b_pwr_ok_in_u/sel
  assign dft_mux_ddr_s2b_pwr_ok_in_u__sel                           = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_s2b_ref_ssp_en_u/sel
  assign dft_mux_s2b_ref_ssp_en_u__sel                              = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_mux_s2b_ref_use_pad_u/sel
  assign dft_mux_s2b_ref_use_pad_u__sel                             = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_orv32_early_rstn_mux_u/sel
  assign dft_orv32_early_rstn_mux_u__sel                            = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_orv32_rstn_mux_u/sel
  assign dft_orv32_rstn_mux_u__sel                                  = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_phy_ddr_clk_u/scan_mode
  assign dft_phy_ddr_clk_u__scan_mode                               = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_sdio_resetn_u/sel
  assign dft_sdio_resetn_u__sel                                     = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_usb_vaux_reset_n_u/sel
  assign dft_usb_vaux_reset_n_u__sel                                = soc_top__dft_mode;

  // soc_top/dft_mode <-> dft_usb_vcc_reset_n_u/sel
  assign dft_usb_vcc_reset_n_u__sel                                 = soc_top__dft_mode;

  // soc_top/dft_mode <-> dma_rstn_sync_u/scan_en
  assign dma_rstn_sync_u__scan_en                                   = soc_top__dft_mode;

  // soc_top/dft_mode <-> dt_rstn_sync_u/scan_en
  assign dt_rstn_sync_u__scan_en                                    = soc_top__dft_mode;

  // soc_top/dft_mode <-> jtag2or_rstn_sync_u/scan_en
  assign jtag2or_rstn_sync_u__scan_en                               = soc_top__dft_mode;

  // soc_top/dft_mode <-> mem_noc_rstn_sync_u/scan_en
  assign mem_noc_rstn_sync_u__scan_en                               = soc_top__dft_mode;

  

  // soc_top/dft_mode <-> pll_rstn_sync_u/scan_en
  assign pll_rstn_sync_u__scan_en                                   = soc_top__dft_mode;

  // soc_top/dft_mode <-> rob_rstn_sync_u/scan_en
  assign rob_rstn_sync_u__scan_en                                   = soc_top__dft_mode;

  // soc_top/dft_mode <-> sdio_rstn_sync_u/scan_en
  assign sdio_rstn_sync_u__scan_en                                  = soc_top__dft_mode;

  

  // soc_top/dft_mode <-> slow_io_rstn_sync_u/scan_en
  assign slow_io_rstn_sync_u__scan_en                               = soc_top__dft_mode;

  

  // soc_top/dft_mode <-> test_io_rstn_sync_u/scan_en
  assign test_io_rstn_sync_u__scan_en                               = soc_top__dft_mode;

  // soc_top/dft_mode <-> test_io_test_rstn_sync_u/scan_en
  assign test_io_test_rstn_sync_u__scan_en                          = soc_top__dft_mode;

  // soc_top/dft_mode <-> usb_rstn_sync_u/scan_en
  assign usb_rstn_sync_u__scan_en                                   = soc_top__dft_mode;

  

  // soc_top/dft_mode_vp <-> dft_mode_vp_enable_u/dft_mode
  assign soc_top__dft_mode_vp                                       = dft_mode_vp_enable_u__dft_mode;

  // soc_top/dft_mode_vp <-> dft_vp0_early_rstn_mux_u/sel
  assign dft_vp0_early_rstn_mux_u__sel                              = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> dft_vp0_rstn_mux_u/sel
  assign dft_vp0_rstn_mux_u__sel                                    = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> dft_vp1_early_rstn_mux_u/sel
  assign dft_vp1_early_rstn_mux_u__sel                              = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> dft_vp1_rstn_mux_u/sel
  assign dft_vp1_rstn_mux_u__sel                                    = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> dft_vp2_early_rstn_mux_u/sel
  assign dft_vp2_early_rstn_mux_u__sel                              = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> dft_vp2_rstn_mux_u/sel
  assign dft_vp2_rstn_mux_u__sel                                    = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> dft_vp3_early_rstn_mux_u/sel
  assign dft_vp3_early_rstn_mux_u__sel                              = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> dft_vp3_rstn_mux_u/sel
  assign dft_vp3_rstn_mux_u__sel                                    = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> vp0_iso_or_u/in_1
  assign vp0_iso_or_u__in_1                                         = soc_top__dft_mode_vp;

  // soc_top/dft_mode_vp <-> vp0_rstn_sync_u/scan_en
  assign vp0_rstn_sync_u__scan_en                                   = soc_top__dft_mode_vp;

  `ifdef IFNDEF_SINGLE_VP
  // soc_top/dft_mode_vp <-> vp1_iso_or_u/in_1
  assign vp1_iso_or_u__in_1                                         = soc_top__dft_mode_vp;
  `endif

  // soc_top/dft_mode_vp <-> vp1_rstn_sync_u/scan_en
  assign vp1_rstn_sync_u__scan_en                                   = soc_top__dft_mode_vp;

  `ifdef IFNDEF_SINGLE_VP
  // soc_top/dft_mode_vp <-> vp2_iso_or_u/in_1
  assign vp2_iso_or_u__in_1                                         = soc_top__dft_mode_vp;
  `endif

  // soc_top/dft_mode_vp <-> vp2_rstn_sync_u/scan_en
  assign vp2_rstn_sync_u__scan_en                                   = soc_top__dft_mode_vp;

  `ifdef IFNDEF_SINGLE_VP
  // soc_top/dft_mode_vp <-> vp3_iso_or_u/in_1
  assign vp3_iso_or_u__in_1                                         = soc_top__dft_mode_vp;
  `endif

  // soc_top/dft_mode_vp <-> vp3_rstn_sync_u/scan_en
  assign vp3_rstn_sync_u__scan_en                                   = soc_top__dft_mode_vp;

  

  `ifdef IFNDEF_NO_DDR
  // soc_top/global_scan_enable <-> ddr_top_u/atpg_se
  assign ddr_top_u__atpg_se[0]                                      = global_scan_enable;
  assign ddr_top_u__atpg_se[4]                                      = global_scan_enable;
  assign ddr_top_u__atpg_se[5]                                      = global_scan_enable;
  `endif

  

  

  // soc_top/io_test_mode <-> dft_mode_enable_u/dft_mode
  assign io_test_mode                                               = dft_mode_enable_u__dft_mode;

  

  

  

  

  

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_ar <-> mem_noc_u/mem_req_if_ar
  assign mem_noc_req_if_ar                                          = mem_noc_u__mem_req_if_ar[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_arready <-> mem_noc_u/mem_req_if_arready
  assign mem_noc_u__mem_req_if_arready[0]                           = mem_noc_req_if_arready;
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_arvalid <-> mem_noc_u/mem_req_if_arvalid
  assign mem_noc_req_if_arvalid                                     = mem_noc_u__mem_req_if_arvalid[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_aw <-> mem_noc_u/mem_req_if_aw
  assign mem_noc_req_if_aw                                          = mem_noc_u__mem_req_if_aw[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_awready <-> mem_noc_u/mem_req_if_awready
  assign mem_noc_u__mem_req_if_awready[0]                           = mem_noc_req_if_awready;
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_awvalid <-> mem_noc_u/mem_req_if_awvalid
  assign mem_noc_req_if_awvalid                                     = mem_noc_u__mem_req_if_awvalid[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_w <-> mem_noc_u/mem_req_if_w
  assign mem_noc_req_if_w                                           = mem_noc_u__mem_req_if_w[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_wready <-> mem_noc_u/mem_req_if_wready
  assign mem_noc_u__mem_req_if_wready[0]                            = mem_noc_req_if_wready;
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_req_if_wvalid <-> mem_noc_u/mem_req_if_wvalid
  assign mem_noc_req_if_wvalid                                      = mem_noc_u__mem_req_if_wvalid[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_resp_if_b <-> mem_noc_u/mem_resp_if_b
  assign mem_noc_u__mem_resp_if_b[0]                                = mem_noc_resp_if_b;
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_resp_if_bready <-> mem_noc_u/mem_resp_if_bready
  assign mem_noc_resp_if_bready                                     = mem_noc_u__mem_resp_if_bready[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_resp_if_bvalid <-> mem_noc_u/mem_resp_if_bvalid
  assign mem_noc_u__mem_resp_if_bvalid[0]                           = mem_noc_resp_if_bvalid;
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_resp_if_r <-> mem_noc_u/mem_resp_if_r
  assign mem_noc_u__mem_resp_if_r[0]                                = mem_noc_resp_if_r;
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_resp_if_rready <-> mem_noc_u/mem_resp_if_rready
  assign mem_noc_resp_if_rready                                     = mem_noc_u__mem_resp_if_rready[0];
  `endif

  `ifdef IFDEF_EXT_MEM_NOC_BRIDGE
  // soc_top/mem_noc_resp_if_rvalid <-> mem_noc_u/mem_resp_if_rvalid
  assign mem_noc_u__mem_resp_if_rvalid[0]                           = mem_noc_resp_if_rvalid;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_ar <-> usb_station_u/i_req_local_if_ar
  assign usb_station_u__i_req_local_if_ar                           = or_req_if_ar;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_arready <-> usb_station_u/i_req_local_if_arready
  assign or_req_if_arready                                          = usb_station_u__i_req_local_if_arready;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_arvalid <-> usb_station_u/i_req_local_if_arvalid
  assign usb_station_u__i_req_local_if_arvalid                      = or_req_if_arvalid;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_aw <-> usb_station_u/i_req_local_if_aw
  assign usb_station_u__i_req_local_if_aw                           = or_req_if_aw;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_awready <-> usb_station_u/i_req_local_if_awready
  assign or_req_if_awready                                          = usb_station_u__i_req_local_if_awready;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_awvalid <-> usb_station_u/i_req_local_if_awvalid
  assign usb_station_u__i_req_local_if_awvalid                      = or_req_if_awvalid;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_w <-> usb_station_u/i_req_local_if_w
  assign usb_station_u__i_req_local_if_w                            = or_req_if_w;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_wready <-> usb_station_u/i_req_local_if_wready
  assign or_req_if_wready                                           = usb_station_u__i_req_local_if_wready;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_req_if_wvalid <-> usb_station_u/i_req_local_if_wvalid
  assign usb_station_u__i_req_local_if_wvalid                       = or_req_if_wvalid;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_resp_if_b <-> usb_station_u/o_resp_local_if_b
  assign or_resp_if_b                                               = usb_station_u__o_resp_local_if_b;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_resp_if_bready <-> usb_station_u/o_resp_local_if_bready
  assign usb_station_u__o_resp_local_if_bready                      = or_resp_if_bready;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_resp_if_bvalid <-> usb_station_u/o_resp_local_if_bvalid
  assign or_resp_if_bvalid                                          = usb_station_u__o_resp_local_if_bvalid;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_resp_if_r <-> usb_station_u/o_resp_local_if_r
  assign or_resp_if_r                                               = usb_station_u__o_resp_local_if_r;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_resp_if_rready <-> usb_station_u/o_resp_local_if_rready
  assign usb_station_u__o_resp_local_if_rready                      = or_resp_if_rready;
  `endif

  `ifdef IFDEF_EXT_OR_BRIDGE
  // soc_top/or_resp_if_rvalid <-> usb_station_u/o_resp_local_if_rvalid
  assign or_resp_if_rvalid                                          = usb_station_u__o_resp_local_if_rvalid;
  `endif

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  `ifndef IFNDEF_NO_SSP_TOP
  // soc_top/p2c_refclk <-> pll_u__clk_anchor_buf/in
  assign pll_u__clk_anchor_buf__in                                  = p2c_refclk;
  `endif

  

  // soc_top/p2c_refclk <-> usb_refclk_icg_u/clk
  assign usb_refclk_icg_u__clk                                      = p2c_refclk;

  `ifndef IFNDEF_NO_SSP_TOP
  // soc_top/p2c_resetn <-> soc_top/chip_resetn
  assign soc_top__chip_resetn                                       = p2c_resetn;
  `endif

  

  

  // soc_top/p2c_scan_f_clk <-> dft_scan_f_usb_clk_icg_u/clk
  assign dft_scan_f_usb_clk_icg_u__clk                              = p2c_scan_f_clk;

  // soc_top/p2c_scan_f_clk <-> dft_scan_f_vp_clk_icg_u/clk
  assign dft_scan_f_vp_clk_icg_u__clk                               = p2c_scan_f_clk;

  // soc_top/p2c_scan_f_clk <-> dft_sdio_cclk_rx_mux_u/din1
  assign dft_sdio_cclk_rx_mux_u__din1                               = p2c_scan_f_clk;

  // soc_top/p2c_scan_f_clk <-> dft_sdio_refclk_mux_u/din1
  assign dft_sdio_refclk_mux_u__din1                                = p2c_scan_f_clk;

  

  // soc_top/p2c_scan_f_mode <-> dft_mode_vp_enable_u/p2c_scan_mode
  assign dft_mode_vp_enable_u__p2c_scan_mode                        = p2c_scan_f_mode;

  // soc_top/p2c_scan_f_mode <-> dft_vp0_clk_in_u/sel
  assign dft_vp0_clk_in_u__sel                                      = p2c_scan_f_mode;

  // soc_top/p2c_scan_f_mode <-> dft_vp1_clk_in_u/sel
  assign dft_vp1_clk_in_u__sel                                      = p2c_scan_f_mode;

  // soc_top/p2c_scan_f_mode <-> dft_vp2_clk_in_u/sel
  assign dft_vp2_clk_in_u__sel                                      = p2c_scan_f_mode;

  // soc_top/p2c_scan_f_mode <-> dft_vp3_clk_in_u/sel
  assign dft_vp3_clk_in_u__sel                                      = p2c_scan_f_mode;

  // soc_top/p2c_scan_f_reset <-> vp0_scan_reset_u/in_1
  assign vp0_scan_reset_u__in_1                                     = p2c_scan_f_reset;

  // soc_top/p2c_scan_f_reset <-> vp1_scan_reset_u/in_1
  assign vp1_scan_reset_u__in_1                                     = p2c_scan_f_reset;

  // soc_top/p2c_scan_f_reset <-> vp2_scan_reset_u/in_1
  assign vp2_scan_reset_u__in_1                                     = p2c_scan_f_reset;

  // soc_top/p2c_scan_f_reset <-> vp3_scan_reset_u/in_1
  assign vp3_scan_reset_u__in_1                                     = p2c_scan_f_reset;

  `ifdef IFNDEF_NO_DDR
  // soc_top/p2c_scan_mode <-> ddr_top_u/atpg_mode
  assign ddr_top_u__atpg_mode                                       = p2c_scan_mode;
  `endif

  // soc_top/p2c_scan_mode <-> dft_ddr_atpg_one_hot_u/scan_mode
  assign dft_ddr_atpg_one_hot_u__scan_mode                          = p2c_scan_mode;

  // soc_top/p2c_scan_mode <-> dft_mode_enable_u/p2c_scan_mode
  assign dft_mode_enable_u__p2c_scan_mode                           = p2c_scan_mode;

  // soc_top/p2c_scan_mode <-> dft_sdio_cclk_rx_mux_u/sel
  assign dft_sdio_cclk_rx_mux_u__sel                                = p2c_scan_mode;

  // soc_top/p2c_scan_mode <-> dft_sdio_refclk_mux_u/sel
  assign dft_sdio_refclk_mux_u__sel                                 = p2c_scan_mode;

  // soc_top/p2c_scan_mode <-> dft_usb_bus_clk_early_clk_mux_u/sel
  assign dft_usb_bus_clk_early_clk_mux_u__sel                       = p2c_scan_mode;

  // soc_top/p2c_scan_mode <-> dft_usb_ram_clk_in_u/sel
  assign dft_usb_ram_clk_in_u__sel                                  = p2c_scan_mode;

  // soc_top/p2c_scan_mode <-> dft_usb_suspend_clk_mux_u/sel
  assign dft_usb_suspend_clk_mux_u__sel                             = p2c_scan_mode;

  

  

  

  

  // soc_top/p2c_scan_reset <-> bank0_rstn_sync_u/scan_rstn
  assign bank0_rstn_sync_u__scan_rstn                               = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> bank1_rstn_sync_u/scan_rstn
  assign bank1_rstn_sync_u__scan_rstn                               = p2c_scan_reset;

  `ifdef IFNDEF_SOC_NO_BANK2
  // soc_top/p2c_scan_reset <-> bank2_rstn_sync_u/scan_rstn
  assign bank2_rstn_sync_u__scan_rstn                               = p2c_scan_reset;
  `endif

  `ifdef IFNDEF_SOC_NO_BANK3
  // soc_top/p2c_scan_reset <-> bank3_rstn_sync_u/scan_rstn
  assign bank3_rstn_sync_u__scan_rstn                               = p2c_scan_reset;
  `endif

  // soc_top/p2c_scan_reset <-> byp_rstn_sync_u/scan_rstn
  assign byp_rstn_sync_u__scan_rstn                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> cpu_noc_rstn_sync_u/scan_rstn
  assign cpu_noc_rstn_sync_u__scan_rstn                             = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> ddr_hs_rstn_sync_u/scan_rstn
  assign ddr_hs_rstn_sync_u__scan_rstn                              = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> ddr_ls_rstn_sync_u/scan_rstn
  assign ddr_ls_rstn_sync_u__scan_rstn                              = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_bank0_rstn_mux_u/din1
  assign dft_bank0_rstn_mux_u__din1                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_bank1_rstn_mux_u/din1
  assign dft_bank1_rstn_mux_u__din1                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_bank2_rstn_mux_u/din1
  assign dft_bank2_rstn_mux_u__din1                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_bank3_rstn_mux_u/din1
  assign dft_bank3_rstn_mux_u__din1                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_ddr_rstn_mux_aresetn_u/din1
  assign dft_ddr_rstn_mux_aresetn_u__din1                           = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_ddr_rstn_mux_core_ddrc_rstn_u/din1
  assign dft_ddr_rstn_mux_core_ddrc_rstn_u__din1                    = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_ddr_rstn_mux_dfi_reset_n_u/din1
  assign dft_ddr_rstn_mux_dfi_reset_n_u__din1                       = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_ddr_rstn_mux_presetn_u/din1
  assign dft_ddr_rstn_mux_presetn_u__din1                           = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_orv32_early_rstn_mux_u/din1
  assign dft_orv32_early_rstn_mux_u__din1                           = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_orv32_rstn_mux_u/din1
  assign dft_orv32_rstn_mux_u__din1                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_scan_reset_inv_u/in
  assign dft_scan_reset_inv_u__in                                   = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_sdio_resetn_u/din1
  assign dft_sdio_resetn_u__din1                                    = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_usb_vaux_reset_n_u/din1
  assign dft_usb_vaux_reset_n_u__din1                               = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_usb_vcc_reset_n_u/din1
  assign dft_usb_vcc_reset_n_u__din1                                = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp0_early_rstn_mux_u/din1
  assign dft_vp0_early_rstn_mux_u__din1                             = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp0_rstn_mux_u/din1
  assign dft_vp0_rstn_mux_u__din1                                   = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp1_early_rstn_mux_u/din1
  assign dft_vp1_early_rstn_mux_u__din1                             = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp1_rstn_mux_u/din1
  assign dft_vp1_rstn_mux_u__din1                                   = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp2_early_rstn_mux_u/din1
  assign dft_vp2_early_rstn_mux_u__din1                             = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp2_rstn_mux_u/din1
  assign dft_vp2_rstn_mux_u__din1                                   = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp3_early_rstn_mux_u/din1
  assign dft_vp3_early_rstn_mux_u__din1                             = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dft_vp3_rstn_mux_u/din1
  assign dft_vp3_rstn_mux_u__din1                                   = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dma_rstn_sync_u/scan_rstn
  assign dma_rstn_sync_u__scan_rstn                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> dt_rstn_sync_u/scan_rstn
  assign dt_rstn_sync_u__scan_rstn                                  = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> jtag2or_rstn_sync_u/scan_rstn
  assign jtag2or_rstn_sync_u__scan_rstn                             = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> mem_noc_rstn_sync_u/scan_rstn
  assign mem_noc_rstn_sync_u__scan_rstn                             = p2c_scan_reset;

  

  // soc_top/p2c_scan_reset <-> pll_rstn_sync_u/scan_rstn
  assign pll_rstn_sync_u__scan_rstn                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> rob_rstn_sync_u/scan_rstn
  assign rob_rstn_sync_u__scan_rstn                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> sdio_rstn_sync_u/scan_rstn
  assign sdio_rstn_sync_u__scan_rstn                                = p2c_scan_reset;

  

  // soc_top/p2c_scan_reset <-> slow_io_rstn_sync_u/scan_rstn
  assign slow_io_rstn_sync_u__scan_rstn                             = p2c_scan_reset;

  

  // soc_top/p2c_scan_reset <-> test_io_rstn_sync_u/scan_rstn
  assign test_io_rstn_sync_u__scan_rstn                             = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> test_io_test_rstn_sync_u/scan_rstn
  assign test_io_test_rstn_sync_u__scan_rstn                        = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> usb_rstn_sync_u/scan_rstn
  assign usb_rstn_sync_u__scan_rstn                                 = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> vp0_scan_reset_u/in_0
  assign vp0_scan_reset_u__in_0                                     = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> vp1_scan_reset_u/in_0
  assign vp1_scan_reset_u__in_0                                     = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> vp2_scan_reset_u/in_0
  assign vp2_scan_reset_u__in_0                                     = p2c_scan_reset;

  // soc_top/p2c_scan_reset <-> vp3_scan_reset_u/in_0
  assign vp3_scan_reset_u__in_0                                     = p2c_scan_reset;

  // soc_top/p2c_scan_tap_compliance <-> dft_mux_test_powerdown_hsp_u/sel
  assign dft_mux_test_powerdown_hsp_u__sel                          = p2c_scan_tap_compliance;

  // soc_top/p2c_scan_tap_compliance <-> dft_mux_test_powerdown_ssp_u/sel
  assign dft_mux_test_powerdown_ssp_u__sel                          = p2c_scan_tap_compliance;

  

  

  

  

  

  

  // soc_top/p2c_test_io_clk <-> test_io_test_rstn_sync_u/clk
  assign test_io_test_rstn_sync_u__clk                              = p2c_test_io_clk;

  // soc_top/p2c_test_io_clk <-> test_io_u/test_clk
  assign test_io_u__test_clk                                        = p2c_test_io_clk;

  // soc_top/p2c_test_io_data <-> test_io_u/test_din
  assign test_io_u__test_din                                        = p2c_test_io_data;

  // soc_top/p2c_test_io_en <-> test_io_u/test_ein
  assign test_io_u__test_ein                                        = p2c_test_io_en;

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  // soc_top/rdata_out <-> jtag2or_u/rdata_out
  assign rdata_out                                                  = jtag2or_u__rdata_out;

  // soc_top/rdata_vld_out <-> jtag2or_u/rdata_vld_out
  assign rdata_vld_out                                              = jtag2or_u__rdata_vld_out;

  

  

  

  

  

  

  

  

  

  

  

  

  

  // soc_top/usb_icg_ten <-> dft_scan_f_usb_clk_icg_u/tst_en
  assign dft_scan_f_usb_clk_icg_u__tst_en                           = usb_icg_ten;

  

  

  // soc_top/vcore_icg_ten <-> dft_scan_f_vp_clk_icg_u/tst_en
  assign dft_scan_f_vp_clk_icg_u__tst_en                            = vcore_icg_ten;

  

  `ifdef IFDEF_NO_USB__IFNDEF_NO_SSP_TOP
  // ssp_top_u/fast_io_intr <-> 'b0
  assign ssp_top_u__fast_io_intr                                    = {{($bits(ssp_top_u__fast_io_intr)-1){1'b0}}, 1'b0};
  `endif

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  // test_io_pllclk_icg_u/clk <-> dft_pllclk_clk_buf_u1/out
  assign test_io_pllclk_icg_u__clk                                  = dft_pllclk_clk_buf_u1__out;

  // test_io_pllclk_icg_u/clkg <-> test_io_u/pllclk
  assign test_io_u__pllclk                                          = test_io_pllclk_icg_u__clkg;

  // test_io_pllclk_icg_u/en <-> sdio_station_u/out_s2b_test_io_pllclk_en
  assign test_io_pllclk_icg_u__en                                   = sdio_station_u__out_s2b_test_io_pllclk_en;

  // test_io_pllclk_icg_u/tst_en <-> 'b0
  assign test_io_pllclk_icg_u__tst_en                               = {{($bits(test_io_pllclk_icg_u__tst_en)-1){1'b0}}, 1'b0};

  // test_io_u/rstn <-> test_io_rstn_sync_u/rstn_out
  assign test_io_u__rstn                                            = test_io_rstn_sync_u__rstn_out;

  // test_io_u/test_rstn <-> test_io_test_rstn_sync_u/rstn_out
  assign test_io_u__test_rstn                                       = test_io_test_rstn_sync_u__rstn_out;

  // timer_interrupt_u/mtime_in <-> pll_station_u/out_mtime
  assign timer_interrupt_u__mtime_in                                = pll_station_u__out_mtime;

  // timer_interrupt_u/mtimecmp[0] <-> pll_station_u/out_mtimecmp_vp_0
  assign timer_interrupt_u__mtimecmp[0]                             = pll_station_u__out_mtimecmp_vp_0;

  // timer_interrupt_u/mtimecmp[1] <-> pll_station_u/out_mtimecmp_vp_1
  assign timer_interrupt_u__mtimecmp[1]                             = pll_station_u__out_mtimecmp_vp_1;

  // timer_interrupt_u/mtimecmp[2] <-> pll_station_u/out_mtimecmp_vp_2
  assign timer_interrupt_u__mtimecmp[2]                             = pll_station_u__out_mtimecmp_vp_2;

  // timer_interrupt_u/mtimecmp[3] <-> pll_station_u/out_mtimecmp_vp_3
  assign timer_interrupt_u__mtimecmp[3]                             = pll_station_u__out_mtimecmp_vp_3;

  // usb_pllclk_icg_u/clk <-> dft_pllclk_clk_buf_u1/out
  assign usb_pllclk_icg_u__clk                                      = dft_pllclk_clk_buf_u1__out;

  // usb_pllclk_icg_u/en <-> usb_station_u/out_s2icg_pllclk_en
  assign usb_pllclk_icg_u__en                                       = usb_station_u__out_s2icg_pllclk_en;

  // usb_pllclk_icg_u/tst_en <-> soc_top/dft_mode
  assign usb_pllclk_icg_u__tst_en                                   = soc_top__dft_mode;

  // usb_refclk_icg_u/en <-> usb_station_u/out_s2icg_refclk_en
  assign usb_refclk_icg_u__en                                       = usb_station_u__out_s2icg_refclk_en;

  // usb_refclk_icg_u/tst_en <-> 'b0
  assign usb_refclk_icg_u__tst_en                                   = {{($bits(usb_refclk_icg_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_EXT_OR_BRIDGE__IFNDEF_TB_USE_USB_STATION_LOCAL_IF
  // usb_station_u.i_req_local_if <-> 'b0
  assign usb_station_u__i_req_local_if_ar                           = {{($bits(usb_station_u__i_req_local_if_ar)-1){1'b0}}, 1'b0};
  assign usb_station_u__i_req_local_if_arvalid                      = {{($bits(usb_station_u__i_req_local_if_arvalid)-1){1'b0}}, 1'b0};
  assign usb_station_u__i_req_local_if_aw                           = {{($bits(usb_station_u__i_req_local_if_aw)-1){1'b0}}, 1'b0};
  assign usb_station_u__i_req_local_if_awvalid                      = {{($bits(usb_station_u__i_req_local_if_awvalid)-1){1'b0}}, 1'b0};
  assign usb_station_u__i_req_local_if_w                            = {{($bits(usb_station_u__i_req_local_if_w)-1){1'b0}}, 1'b0};
  assign usb_station_u__i_req_local_if_wvalid                       = {{($bits(usb_station_u__i_req_local_if_wvalid)-1){1'b0}}, 1'b0};
  `endif

  

  // usb_station_u.i_resp_ring_if <-> pll_station_u.o_resp_ring_if
  assign pll_station_u__o_resp_ring_if_bready                       = usb_station_u__i_resp_ring_if_bready;
  assign pll_station_u__o_resp_ring_if_rready                       = usb_station_u__i_resp_ring_if_rready;
  assign usb_station_u__i_resp_ring_if_b                            = pll_station_u__o_resp_ring_if_b;
  assign usb_station_u__i_resp_ring_if_bvalid                       = pll_station_u__o_resp_ring_if_bvalid;
  assign usb_station_u__i_resp_ring_if_r                            = pll_station_u__o_resp_ring_if_r;
  assign usb_station_u__i_resp_ring_if_rvalid                       = pll_station_u__o_resp_ring_if_rvalid;

  

  

  // usb_station_u.o_req_ring_if <-> pll_station_u.i_req_ring_if
  assign pll_station_u__i_req_ring_if_ar                            = usb_station_u__o_req_ring_if_ar;
  assign pll_station_u__i_req_ring_if_arvalid                       = usb_station_u__o_req_ring_if_arvalid;
  assign pll_station_u__i_req_ring_if_aw                            = usb_station_u__o_req_ring_if_aw;
  assign pll_station_u__i_req_ring_if_awvalid                       = usb_station_u__o_req_ring_if_awvalid;
  assign pll_station_u__i_req_ring_if_w                             = usb_station_u__o_req_ring_if_w;
  assign pll_station_u__i_req_ring_if_wvalid                        = usb_station_u__o_req_ring_if_wvalid;
  assign usb_station_u__o_req_ring_if_arready                       = pll_station_u__i_req_ring_if_arready;
  assign usb_station_u__o_req_ring_if_awready                       = pll_station_u__i_req_ring_if_awready;
  assign usb_station_u__o_req_ring_if_wready                        = pll_station_u__i_req_ring_if_wready;

  `ifdef IFNDEF_EXT_OR_BRIDGE__IFNDEF_TB_USE_USB_STATION_LOCAL_IF
  // usb_station_u.o_resp_local_if <-> 'b0
  assign usb_station_u__o_resp_local_if_bready                      = {{($bits(usb_station_u__o_resp_local_if_bready)-1){1'b0}}, 1'b0};
  assign usb_station_u__o_resp_local_if_rready                      = {{($bits(usb_station_u__o_resp_local_if_rready)-1){1'b0}}, 1'b0};
  `endif

  // usb_station_u.vld_in_b2s <-> usb_station_u/out_debug_info_enable
  assign usb_station_u__vld_in_b2s_clk_gate_ctrl                    = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_connect_state_u2pmu              = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_connect_state_u3pmu              = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_cr_ack                           = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_cr_data_out                      = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_current_power_state_u2pmu        = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_current_power_state_u3pmu        = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_debug                            = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_debug_u2pmu_hi                   = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_debug_u2pmu_lo                   = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_debug_u3pmu                      = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_gp_out                           = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_mpll_refssc_clk                  = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_pme_generation_u2pmu             = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_pme_generation_u3pmu             = usb_station_u__out_debug_info_enable;
  assign usb_station_u__vld_in_b2s_rtune_ack                        = usb_station_u__out_debug_info_enable;

  // usb_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign usb_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;

  

  // usb_station_u/rstn <-> usb_rstn_sync_u/rstn_out
  assign usb_station_u__rstn                                        = usb_rstn_sync_u__rstn_out;

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_cpunoc_amoreq_valid_and_u/in0 <-> vp0_u/cpu_amo_store_req_valid
  assign vp0_cpunoc_amoreq_valid_and_u__in0                         = vp0_u__cpu_amo_store_req_valid;
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_cpunoc_amoreq_valid_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_cpunoc_amoreq_valid_and_u__in1                         = dft_vp0_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_cpunoc_amoreq_valid_and_u/out <-> cpu_noc_u/cpu_amo_store_noc_req_valid[1]
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[1]                  = vp0_cpunoc_amoreq_valid_and_u__out;
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_cpunoc_req_valid_and_u/in0 <-> vp0_u/cache_req_if_req_valid
  assign vp0_cpunoc_req_valid_and_u__in0                            = vp0_u__cache_req_if_req_valid;
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_cpunoc_req_valid_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_cpunoc_req_valid_and_u__in1                            = dft_vp0_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_cpunoc_req_valid_and_u/out <-> cpu_noc_u/cpu_noc_req_if_req_valid[1]
  assign cpu_noc_u__cpu_noc_req_if_req_valid[1]                     = vp0_cpunoc_req_valid_and_u__out;
  `endif

  // vp0_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp0_icg_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  // vp0_icg_u/en <-> vp0_station_u/out_s2icg_clk_en
  assign vp0_icg_u__en                                              = vp0_station_u__out_s2icg_clk_en;

  // vp0_icg_u/tst_en <-> 'b0
  assign vp0_icg_u__tst_en                                          = {{($bits(vp0_icg_u__tst_en)-1){1'b0}}, 1'b0};

  // vp0_ring_bvalid_and_u/in0 <-> vp0_u/ring_resp_if_bvalid
  assign vp0_ring_bvalid_and_u__in0                                 = vp0_u__ring_resp_if_bvalid;

  // vp0_ring_bvalid_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_ring_bvalid_and_u__in1                                 = dft_vp0_early_rstn_mux_u__dout;

  // vp0_ring_bvalid_and_u/out <-> vp0_station_u/i_resp_local_if_bvalid
  assign vp0_station_u__i_resp_local_if_bvalid                      = vp0_ring_bvalid_and_u__out;

  // vp0_ring_rvalid_and_u/in0 <-> vp0_u/ring_resp_if_rvalid
  assign vp0_ring_rvalid_and_u__in0                                 = vp0_u__ring_resp_if_rvalid;

  // vp0_ring_rvalid_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_ring_rvalid_and_u__in1                                 = dft_vp0_early_rstn_mux_u__dout;

  // vp0_ring_rvalid_and_u/out <-> vp0_station_u/i_resp_local_if_rvalid
  assign vp0_station_u__i_resp_local_if_rvalid                      = vp0_ring_rvalid_and_u__out;

  // vp0_scan_reset_u/out <-> vp0_rstn_sync_u/scan_rstn
  assign vp0_rstn_sync_u__scan_rstn                                 = vp0_scan_reset_u__out;

  // vp0_station_u.i_req_local_if <-> vp0_u.sysbus_req_if
  assign vp0_station_u__i_req_local_if_ar                           = vp0_u__sysbus_req_if_ar;
  assign vp0_station_u__i_req_local_if_aw                           = vp0_u__sysbus_req_if_aw;
  assign vp0_station_u__i_req_local_if_w                            = vp0_u__sysbus_req_if_w;
  assign vp0_u__sysbus_req_if_arready                               = vp0_station_u__i_req_local_if_arready;
  assign vp0_u__sysbus_req_if_awready                               = vp0_station_u__i_req_local_if_awready;
  assign vp0_u__sysbus_req_if_wready                                = vp0_station_u__i_req_local_if_wready;

  // vp0_station_u.i_resp_local_if <-> vp0_u.ring_resp_if
  assign vp0_station_u__i_resp_local_if_b                           = vp0_u__ring_resp_if_b;
  assign vp0_station_u__i_resp_local_if_r                           = vp0_u__ring_resp_if_r;
  assign vp0_u__ring_resp_if_bready                                 = vp0_station_u__i_resp_local_if_bready;
  assign vp0_u__ring_resp_if_rready                                 = vp0_station_u__i_resp_local_if_rready;

  `ifndef IFNDEF_SINGLE_VP
  // vp0_station_u.i_resp_ring_if <-> usb_station_u.o_resp_ring_if
  assign usb_station_u__o_resp_ring_if_bready                       = vp0_station_u__i_resp_ring_if_bready;
  assign usb_station_u__o_resp_ring_if_rready                       = vp0_station_u__i_resp_ring_if_rready;
  assign vp0_station_u__i_resp_ring_if_b                            = usb_station_u__o_resp_ring_if_b;
  assign vp0_station_u__i_resp_ring_if_bvalid                       = usb_station_u__o_resp_ring_if_bvalid;
  assign vp0_station_u__i_resp_ring_if_r                            = usb_station_u__o_resp_ring_if_r;
  assign vp0_station_u__i_resp_ring_if_rvalid                       = usb_station_u__o_resp_ring_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp0_station_u.i_resp_ring_if <-> vp1_station_u.o_resp_ring_if
  assign vp0_station_u__i_resp_ring_if_b                            = vp1_station_u__o_resp_ring_if_b;
  assign vp0_station_u__i_resp_ring_if_bvalid                       = vp1_station_u__o_resp_ring_if_bvalid;
  assign vp0_station_u__i_resp_ring_if_r                            = vp1_station_u__o_resp_ring_if_r;
  assign vp0_station_u__i_resp_ring_if_rvalid                       = vp1_station_u__o_resp_ring_if_rvalid;
  assign vp1_station_u__o_resp_ring_if_bready                       = vp0_station_u__i_resp_ring_if_bready;
  assign vp1_station_u__o_resp_ring_if_rready                       = vp0_station_u__i_resp_ring_if_rready;
  `endif

  // vp0_station_u.o_req_local_if <-> vp0_u.ring_req_if
  assign vp0_station_u__o_req_local_if_arready                      = vp0_u__ring_req_if_arready;
  assign vp0_station_u__o_req_local_if_awready                      = vp0_u__ring_req_if_awready;
  assign vp0_station_u__o_req_local_if_wready                       = vp0_u__ring_req_if_wready;
  assign vp0_u__ring_req_if_ar                                      = vp0_station_u__o_req_local_if_ar;
  assign vp0_u__ring_req_if_arvalid                                 = vp0_station_u__o_req_local_if_arvalid;
  assign vp0_u__ring_req_if_aw                                      = vp0_station_u__o_req_local_if_aw;
  assign vp0_u__ring_req_if_awvalid                                 = vp0_station_u__o_req_local_if_awvalid;
  assign vp0_u__ring_req_if_w                                       = vp0_station_u__o_req_local_if_w;
  assign vp0_u__ring_req_if_wvalid                                  = vp0_station_u__o_req_local_if_wvalid;

  `ifndef IFNDEF_SINGLE_VP
  // vp0_station_u.o_req_ring_if <-> usb_station_u.i_req_ring_if
  assign usb_station_u__i_req_ring_if_ar                            = vp0_station_u__o_req_ring_if_ar;
  assign usb_station_u__i_req_ring_if_arvalid                       = vp0_station_u__o_req_ring_if_arvalid;
  assign usb_station_u__i_req_ring_if_aw                            = vp0_station_u__o_req_ring_if_aw;
  assign usb_station_u__i_req_ring_if_awvalid                       = vp0_station_u__o_req_ring_if_awvalid;
  assign usb_station_u__i_req_ring_if_w                             = vp0_station_u__o_req_ring_if_w;
  assign usb_station_u__i_req_ring_if_wvalid                        = vp0_station_u__o_req_ring_if_wvalid;
  assign vp0_station_u__o_req_ring_if_arready                       = usb_station_u__i_req_ring_if_arready;
  assign vp0_station_u__o_req_ring_if_awready                       = usb_station_u__i_req_ring_if_awready;
  assign vp0_station_u__o_req_ring_if_wready                        = usb_station_u__i_req_ring_if_wready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp0_station_u.o_req_ring_if <-> vp1_station_u.i_req_ring_if
  assign vp0_station_u__o_req_ring_if_arready                       = vp1_station_u__i_req_ring_if_arready;
  assign vp0_station_u__o_req_ring_if_awready                       = vp1_station_u__i_req_ring_if_awready;
  assign vp0_station_u__o_req_ring_if_wready                        = vp1_station_u__i_req_ring_if_wready;
  assign vp1_station_u__i_req_ring_if_ar                            = vp0_station_u__o_req_ring_if_ar;
  assign vp1_station_u__i_req_ring_if_arvalid                       = vp0_station_u__o_req_ring_if_arvalid;
  assign vp1_station_u__i_req_ring_if_aw                            = vp0_station_u__o_req_ring_if_aw;
  assign vp1_station_u__i_req_ring_if_awvalid                       = vp0_station_u__o_req_ring_if_awvalid;
  assign vp1_station_u__i_req_ring_if_w                             = vp0_station_u__o_req_ring_if_w;
  assign vp1_station_u__i_req_ring_if_wvalid                        = vp0_station_u__o_req_ring_if_wvalid;
  `endif

  // vp0_station_u.o_resp_local_if <-> vp0_u.sysbus_resp_if
  assign vp0_station_u__o_resp_local_if_bready                      = vp0_u__sysbus_resp_if_bready;
  assign vp0_station_u__o_resp_local_if_rready                      = vp0_u__sysbus_resp_if_rready;
  assign vp0_u__sysbus_resp_if_b                                    = vp0_station_u__o_resp_local_if_b;
  assign vp0_u__sysbus_resp_if_bvalid                               = vp0_station_u__o_resp_local_if_bvalid;
  assign vp0_u__sysbus_resp_if_r                                    = vp0_station_u__o_resp_local_if_r;
  assign vp0_u__sysbus_resp_if_rvalid                               = vp0_station_u__o_resp_local_if_rvalid;

  // vp0_station_u.vld_in_b2s <-> 'b1
  assign vp0_station_u__vld_in_b2s_debug_stall_out                  = {{($bits(vp0_station_u__vld_in_b2s_debug_stall_out)-1){1'b0}}, 1'b1};
  assign vp0_station_u__vld_in_b2s_itb_last_ptr                     = {{($bits(vp0_station_u__vld_in_b2s_itb_last_ptr)-1){1'b0}}, 1'b1};
  assign vp0_station_u__vld_in_b2s_vload_drt_req_vlen_illegal       = {{($bits(vp0_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)-1){1'b0}}, 1'b1};

  // vp0_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp0_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;

  // vp0_station_u/in_b2s_is_vtlb_excp <-> 'b1
  assign vp0_station_u__in_b2s_is_vtlb_excp                         = {{($bits(vp0_station_u__in_b2s_is_vtlb_excp)-1){1'b0}}, 1'b1};

  // vp0_station_u/out_s2b_cfg_pwr_on <-> vp0_iso_or_u/in_0
  assign vp0_iso_or_u__in_0                                         = vp0_station_u__out_s2b_cfg_pwr_on;

  // vp0_station_u/rstn <-> vp0_rstn_sync_u/rstn_out
  assign vp0_station_u__rstn                                        = vp0_rstn_sync_u__rstn_out;

  // vp0_sysbus_arvalid_and_u/in0 <-> vp0_u/sysbus_req_if_arvalid
  assign vp0_sysbus_arvalid_and_u__in0                              = vp0_u__sysbus_req_if_arvalid;

  // vp0_sysbus_arvalid_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_sysbus_arvalid_and_u__in1                              = dft_vp0_early_rstn_mux_u__dout;

  // vp0_sysbus_arvalid_and_u/out <-> vp0_station_u/i_req_local_if_arvalid
  assign vp0_station_u__i_req_local_if_arvalid                      = vp0_sysbus_arvalid_and_u__out;

  // vp0_sysbus_awvalid_and_u/in0 <-> vp0_u/sysbus_req_if_awvalid
  assign vp0_sysbus_awvalid_and_u__in0                              = vp0_u__sysbus_req_if_awvalid;

  // vp0_sysbus_awvalid_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_sysbus_awvalid_and_u__in1                              = dft_vp0_early_rstn_mux_u__dout;

  // vp0_sysbus_awvalid_and_u/out <-> vp0_station_u/i_req_local_if_awvalid
  assign vp0_station_u__i_req_local_if_awvalid                      = vp0_sysbus_awvalid_and_u__out;

  // vp0_sysbus_wvalid_and_u/in0 <-> vp0_u/sysbus_req_if_wvalid
  assign vp0_sysbus_wvalid_and_u__in0                               = vp0_u__sysbus_req_if_wvalid;

  // vp0_sysbus_wvalid_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_sysbus_wvalid_and_u__in1                               = dft_vp0_early_rstn_mux_u__dout;

  // vp0_sysbus_wvalid_and_u/out <-> vp0_station_u/i_req_local_if_wvalid
  assign vp0_station_u__i_req_local_if_wvalid                       = vp0_sysbus_wvalid_and_u__out;

  // vp0_u.b2s <-> vp0_station_u.in_b2s
  assign vp0_station_u__in_b2s_debug_stall_out                      = vp0_u__b2s_debug_stall_out;
  assign vp0_station_u__in_b2s_itb_last_ptr                         = vp0_u__b2s_itb_last_ptr;
  assign vp0_station_u__in_b2s_vload_drt_req_vlen_illegal           = vp0_u__b2s_vload_drt_req_vlen_illegal;

  `ifdef IFDEF_TB_USE_CPU_NOC
  // vp0_u.cache_req_if <-> 'b0
  assign vp0_u__cache_req_if_req_ready                              = {{($bits(vp0_u__cache_req_if_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_u.cache_req_if <-> cpu_noc_u.cpu_noc_req_if[1]
  assign cpu_noc_u__cpu_noc_req_if_req[1]                           = vp0_u__cache_req_if_req;
  assign vp0_u__cache_req_if_req_ready                              = cpu_noc_u__cpu_noc_req_if_req_ready[1];
  `endif

  `ifdef IFDEF_TB_USE_CPU_NOC
  // vp0_u.cache_resp_if <-> 'b0
  assign vp0_u__cache_resp_if_resp                                  = {{($bits(vp0_u__cache_resp_if_resp)-1){1'b0}}, 1'b0};
  assign vp0_u__cache_resp_if_resp_valid                            = {{($bits(vp0_u__cache_resp_if_resp_valid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_u.cache_resp_if <-> cpu_noc_u.noc_cpu_resp_if[1]
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[1]                   = vp0_u__cache_resp_if_resp_ready;
  assign vp0_u__cache_resp_if_resp                                  = cpu_noc_u__noc_cpu_resp_if_resp[1];
  assign vp0_u__cache_resp_if_resp_valid                            = cpu_noc_u__noc_cpu_resp_if_resp_valid[1];
  `endif

  `ifdef IFDEF_TB_USE_CPU_NOC
  // vp0_u.cpu_amo_store <-> 'b0
  assign vp0_u__cpu_amo_store_req_ready                             = {{($bits(vp0_u__cpu_amo_store_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_TB_USE_CPU_NOC
  // vp0_u.cpu_amo_store <-> cpu_noc_u.cpu_amo_store_noc[1]
  assign cpu_noc_u__cpu_amo_store_noc_req[1]                        = vp0_u__cpu_amo_store_req;
  assign vp0_u__cpu_amo_store_req_ready                             = cpu_noc_u__cpu_amo_store_noc_req_ready[1];
  `endif

  // vp0_u.s2b <-> vp0_station_u.out_s2b
  assign vp0_u__s2b_bp_if_pc_0                                      = vp0_station_u__out_s2b_bp_if_pc_0;
  assign vp0_u__s2b_bp_if_pc_1                                      = vp0_station_u__out_s2b_bp_if_pc_1;
  assign vp0_u__s2b_bp_if_pc_2                                      = vp0_station_u__out_s2b_bp_if_pc_2;
  assign vp0_u__s2b_bp_if_pc_3                                      = vp0_station_u__out_s2b_bp_if_pc_3;
  assign vp0_u__s2b_bp_instret                                      = vp0_station_u__out_s2b_bp_instret;
  assign vp0_u__s2b_bp_wb_pc_0                                      = vp0_station_u__out_s2b_bp_wb_pc_0;
  assign vp0_u__s2b_bp_wb_pc_1                                      = vp0_station_u__out_s2b_bp_wb_pc_1;
  assign vp0_u__s2b_bp_wb_pc_2                                      = vp0_station_u__out_s2b_bp_wb_pc_2;
  assign vp0_u__s2b_bp_wb_pc_3                                      = vp0_station_u__out_s2b_bp_wb_pc_3;
  assign vp0_u__s2b_cfg_bypass_ic                                   = vp0_station_u__out_s2b_cfg_bypass_ic;
  assign vp0_u__s2b_cfg_bypass_tlb                                  = vp0_station_u__out_s2b_cfg_bypass_tlb;
  assign vp0_u__s2b_cfg_en_hpmcounter                               = vp0_station_u__out_s2b_cfg_en_hpmcounter;
  assign vp0_u__s2b_cfg_itb_en                                      = vp0_station_u__out_s2b_cfg_itb_en;
  assign vp0_u__s2b_cfg_itb_sel                                     = vp0_station_u__out_s2b_cfg_itb_sel;
  assign vp0_u__s2b_cfg_itb_wrap_around                             = vp0_station_u__out_s2b_cfg_itb_wrap_around;
  assign vp0_u__s2b_cfg_lfsr_seed                                   = vp0_station_u__out_s2b_cfg_lfsr_seed;
  assign vp0_u__s2b_cfg_rst_pc                                      = vp0_station_u__out_s2b_cfg_rst_pc;
  assign vp0_u__s2b_cfg_sleep                                       = vp0_station_u__out_s2b_cfg_sleep;
  assign vp0_u__s2b_debug_resume                                    = vp0_station_u__out_s2b_debug_resume;
  assign vp0_u__s2b_debug_stall                                     = vp0_station_u__out_s2b_debug_stall;
  assign vp0_u__s2b_en_bp_if_pc_0                                   = vp0_station_u__out_s2b_en_bp_if_pc_0;
  assign vp0_u__s2b_en_bp_if_pc_1                                   = vp0_station_u__out_s2b_en_bp_if_pc_1;
  assign vp0_u__s2b_en_bp_if_pc_2                                   = vp0_station_u__out_s2b_en_bp_if_pc_2;
  assign vp0_u__s2b_en_bp_if_pc_3                                   = vp0_station_u__out_s2b_en_bp_if_pc_3;
  assign vp0_u__s2b_en_bp_instret                                   = vp0_station_u__out_s2b_en_bp_instret;
  assign vp0_u__s2b_en_bp_wb_pc_0                                   = vp0_station_u__out_s2b_en_bp_wb_pc_0;
  assign vp0_u__s2b_en_bp_wb_pc_1                                   = vp0_station_u__out_s2b_en_bp_wb_pc_1;
  assign vp0_u__s2b_en_bp_wb_pc_2                                   = vp0_station_u__out_s2b_en_bp_wb_pc_2;
  assign vp0_u__s2b_en_bp_wb_pc_3                                   = vp0_station_u__out_s2b_en_bp_wb_pc_3;
  assign vp0_u__s2b_ext_event                                       = vp0_station_u__out_s2b_ext_event;
  assign vp0_u__s2b_powerline_ctrl                                  = vp0_station_u__out_s2b_powerline_ctrl;
  assign vp0_u__s2b_powervbank_ctrl                                 = vp0_station_u__out_s2b_powervbank_ctrl;
  assign vp0_u__s2b_vcore_en                                        = vp0_station_u__out_s2b_vcore_en;
  assign vp0_u__s2b_vcore_icg_disable                               = vp0_station_u__out_s2b_vcore_icg_disable;
  assign vp0_u__s2b_vcore_pmu_en                                    = vp0_station_u__out_s2b_vcore_pmu_en;
  assign vp0_u__s2b_vcore_pmu_evt_mask                              = vp0_station_u__out_s2b_vcore_pmu_evt_mask;

  // vp0_u/core_id <-> 'b0
  assign vp0_u__core_id                                             = {{($bits(vp0_u__core_id)-1){1'b0}}, 1'b0};

  // vp0_u/external_int <-> plic_u/external_int[0]
  assign vp0_u__external_int                                        = plic_u__external_int[0];

  // vp0_u/s2b_cfg_pwr_on <-> vp0_iso_or_u/out
  assign vp0_u__s2b_cfg_pwr_on                                      = vp0_iso_or_u__out;

  // vp0_u/software_int <-> pll_station_u/out_software_int_vp_0_1[0]
  assign vp0_u__software_int                                        = pll_station_u__out_software_int_vp_0_1[0];

  // vp0_u/timer_int <-> timer_interrupt_u/timer_int[0]
  assign vp0_u__timer_int                                           = timer_interrupt_u__timer_int[0];

  // vp0_vlsu_int_and_u/in0 <-> vp0_u/load_vtlb_excp
  assign vp0_vlsu_int_and_u__in0                                    = vp0_u__load_vtlb_excp;

  // vp0_vlsu_int_and_u/in1 <-> dft_vp0_early_rstn_mux_u/dout
  assign vp0_vlsu_int_and_u__in1                                    = dft_vp0_early_rstn_mux_u__dout;

  // vp0_vlsu_int_and_u/out <-> vp0_station_u/vld_in_b2s_is_vtlb_excp
  assign vp0_station_u__vld_in_b2s_is_vtlb_excp                     = vp0_vlsu_int_and_u__out;

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_cpunoc_amoreq_valid_and_u/in0 <-> vp1_u/cpu_amo_store_req_valid
  assign vp1_cpunoc_amoreq_valid_and_u__in0                         = vp1_u__cpu_amo_store_req_valid;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_cpunoc_amoreq_valid_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_cpunoc_amoreq_valid_and_u__in1                         = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_cpunoc_amoreq_valid_and_u/out <-> cpu_noc_u/cpu_amo_store_noc_req_valid[2]
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[2]                  = vp1_cpunoc_amoreq_valid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_cpunoc_req_valid_and_u/in0 <-> vp1_u/cache_req_if_req_valid
  assign vp1_cpunoc_req_valid_and_u__in0                            = vp1_u__cache_req_if_req_valid;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_cpunoc_req_valid_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_cpunoc_req_valid_and_u__in1                            = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_cpunoc_req_valid_and_u/out <-> cpu_noc_u/cpu_noc_req_if_req_valid[2]
  assign cpu_noc_u__cpu_noc_req_if_req_valid[2]                     = vp1_cpunoc_req_valid_and_u__out;
  `endif

  // vp1_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp1_icg_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  `ifdef IFNDEF_SINGLE_VP
  // vp1_icg_u/en <-> vp1_station_u/out_s2icg_clk_en
  assign vp1_icg_u__en                                              = vp1_station_u__out_s2icg_clk_en;
  `endif

  // vp1_icg_u/tst_en <-> 'b0
  assign vp1_icg_u__tst_en                                          = {{($bits(vp1_icg_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_SINGLE_VP
  // vp1_ring_bvalid_and_u/in0 <-> vp1_u/ring_resp_if_bvalid
  assign vp1_ring_bvalid_and_u__in0                                 = vp1_u__ring_resp_if_bvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_ring_bvalid_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_ring_bvalid_and_u__in1                                 = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_ring_bvalid_and_u/out <-> vp1_station_u/i_resp_local_if_bvalid
  assign vp1_station_u__i_resp_local_if_bvalid                      = vp1_ring_bvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_ring_rvalid_and_u/in0 <-> vp1_u/ring_resp_if_rvalid
  assign vp1_ring_rvalid_and_u__in0                                 = vp1_u__ring_resp_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_ring_rvalid_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_ring_rvalid_and_u__in1                                 = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_ring_rvalid_and_u/out <-> vp1_station_u/i_resp_local_if_rvalid
  assign vp1_station_u__i_resp_local_if_rvalid                      = vp1_ring_rvalid_and_u__out;
  `endif

  // vp1_scan_reset_u/out <-> vp1_rstn_sync_u/scan_rstn
  assign vp1_rstn_sync_u__scan_rstn                                 = vp1_scan_reset_u__out;

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u.i_req_local_if <-> vp1_u.sysbus_req_if
  assign vp1_station_u__i_req_local_if_ar                           = vp1_u__sysbus_req_if_ar;
  assign vp1_station_u__i_req_local_if_aw                           = vp1_u__sysbus_req_if_aw;
  assign vp1_station_u__i_req_local_if_w                            = vp1_u__sysbus_req_if_w;
  assign vp1_u__sysbus_req_if_arready                               = vp1_station_u__i_req_local_if_arready;
  assign vp1_u__sysbus_req_if_awready                               = vp1_station_u__i_req_local_if_awready;
  assign vp1_u__sysbus_req_if_wready                                = vp1_station_u__i_req_local_if_wready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u.i_resp_local_if <-> vp1_u.ring_resp_if
  assign vp1_station_u__i_resp_local_if_b                           = vp1_u__ring_resp_if_b;
  assign vp1_station_u__i_resp_local_if_r                           = vp1_u__ring_resp_if_r;
  assign vp1_u__ring_resp_if_bready                                 = vp1_station_u__i_resp_local_if_bready;
  assign vp1_u__ring_resp_if_rready                                 = vp1_station_u__i_resp_local_if_rready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u.i_resp_ring_if <-> vp2_station_u.o_resp_ring_if
  assign vp1_station_u__i_resp_ring_if_b                            = vp2_station_u__o_resp_ring_if_b;
  assign vp1_station_u__i_resp_ring_if_bvalid                       = vp2_station_u__o_resp_ring_if_bvalid;
  assign vp1_station_u__i_resp_ring_if_r                            = vp2_station_u__o_resp_ring_if_r;
  assign vp1_station_u__i_resp_ring_if_rvalid                       = vp2_station_u__o_resp_ring_if_rvalid;
  assign vp2_station_u__o_resp_ring_if_bready                       = vp1_station_u__i_resp_ring_if_bready;
  assign vp2_station_u__o_resp_ring_if_rready                       = vp1_station_u__i_resp_ring_if_rready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u.o_req_local_if <-> vp1_u.ring_req_if
  assign vp1_station_u__o_req_local_if_arready                      = vp1_u__ring_req_if_arready;
  assign vp1_station_u__o_req_local_if_awready                      = vp1_u__ring_req_if_awready;
  assign vp1_station_u__o_req_local_if_wready                       = vp1_u__ring_req_if_wready;
  assign vp1_u__ring_req_if_ar                                      = vp1_station_u__o_req_local_if_ar;
  assign vp1_u__ring_req_if_arvalid                                 = vp1_station_u__o_req_local_if_arvalid;
  assign vp1_u__ring_req_if_aw                                      = vp1_station_u__o_req_local_if_aw;
  assign vp1_u__ring_req_if_awvalid                                 = vp1_station_u__o_req_local_if_awvalid;
  assign vp1_u__ring_req_if_w                                       = vp1_station_u__o_req_local_if_w;
  assign vp1_u__ring_req_if_wvalid                                  = vp1_station_u__o_req_local_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u.o_req_ring_if <-> vp2_station_u.i_req_ring_if
  assign vp1_station_u__o_req_ring_if_arready                       = vp2_station_u__i_req_ring_if_arready;
  assign vp1_station_u__o_req_ring_if_awready                       = vp2_station_u__i_req_ring_if_awready;
  assign vp1_station_u__o_req_ring_if_wready                        = vp2_station_u__i_req_ring_if_wready;
  assign vp2_station_u__i_req_ring_if_ar                            = vp1_station_u__o_req_ring_if_ar;
  assign vp2_station_u__i_req_ring_if_arvalid                       = vp1_station_u__o_req_ring_if_arvalid;
  assign vp2_station_u__i_req_ring_if_aw                            = vp1_station_u__o_req_ring_if_aw;
  assign vp2_station_u__i_req_ring_if_awvalid                       = vp1_station_u__o_req_ring_if_awvalid;
  assign vp2_station_u__i_req_ring_if_w                             = vp1_station_u__o_req_ring_if_w;
  assign vp2_station_u__i_req_ring_if_wvalid                        = vp1_station_u__o_req_ring_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u.o_resp_local_if <-> vp1_u.sysbus_resp_if
  assign vp1_station_u__o_resp_local_if_bready                      = vp1_u__sysbus_resp_if_bready;
  assign vp1_station_u__o_resp_local_if_rready                      = vp1_u__sysbus_resp_if_rready;
  assign vp1_u__sysbus_resp_if_b                                    = vp1_station_u__o_resp_local_if_b;
  assign vp1_u__sysbus_resp_if_bvalid                               = vp1_station_u__o_resp_local_if_bvalid;
  assign vp1_u__sysbus_resp_if_r                                    = vp1_station_u__o_resp_local_if_r;
  assign vp1_u__sysbus_resp_if_rvalid                               = vp1_station_u__o_resp_local_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u.vld_in_b2s <-> 'b1
  assign vp1_station_u__vld_in_b2s_debug_stall_out                  = {{($bits(vp1_station_u__vld_in_b2s_debug_stall_out)-1){1'b0}}, 1'b1};
  assign vp1_station_u__vld_in_b2s_itb_last_ptr                     = {{($bits(vp1_station_u__vld_in_b2s_itb_last_ptr)-1){1'b0}}, 1'b1};
  assign vp1_station_u__vld_in_b2s_vload_drt_req_vlen_illegal       = {{($bits(vp1_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp1_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u/in_b2s_is_vtlb_excp <-> 'b1
  assign vp1_station_u__in_b2s_is_vtlb_excp                         = {{($bits(vp1_station_u__in_b2s_is_vtlb_excp)-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u/out_s2b_cfg_pwr_on <-> vp1_iso_or_u/in_0
  assign vp1_iso_or_u__in_0                                         = vp1_station_u__out_s2b_cfg_pwr_on;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_station_u/rstn <-> vp1_rstn_sync_u/rstn_out
  assign vp1_station_u__rstn                                        = vp1_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_arvalid_and_u/in0 <-> vp1_u/sysbus_req_if_arvalid
  assign vp1_sysbus_arvalid_and_u__in0                              = vp1_u__sysbus_req_if_arvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_arvalid_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_sysbus_arvalid_and_u__in1                              = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_arvalid_and_u/out <-> vp1_station_u/i_req_local_if_arvalid
  assign vp1_station_u__i_req_local_if_arvalid                      = vp1_sysbus_arvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_awvalid_and_u/in0 <-> vp1_u/sysbus_req_if_awvalid
  assign vp1_sysbus_awvalid_and_u__in0                              = vp1_u__sysbus_req_if_awvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_awvalid_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_sysbus_awvalid_and_u__in1                              = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_awvalid_and_u/out <-> vp1_station_u/i_req_local_if_awvalid
  assign vp1_station_u__i_req_local_if_awvalid                      = vp1_sysbus_awvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_wvalid_and_u/in0 <-> vp1_u/sysbus_req_if_wvalid
  assign vp1_sysbus_wvalid_and_u__in0                               = vp1_u__sysbus_req_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_wvalid_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_sysbus_wvalid_and_u__in1                               = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_sysbus_wvalid_and_u/out <-> vp1_station_u/i_req_local_if_wvalid
  assign vp1_station_u__i_req_local_if_wvalid                       = vp1_sysbus_wvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_u.b2s <-> vp1_station_u.in_b2s
  assign vp1_station_u__in_b2s_debug_stall_out                      = vp1_u__b2s_debug_stall_out;
  assign vp1_station_u__in_b2s_itb_last_ptr                         = vp1_u__b2s_itb_last_ptr;
  assign vp1_station_u__in_b2s_vload_drt_req_vlen_illegal           = vp1_u__b2s_vload_drt_req_vlen_illegal;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp1_u.cache_req_if <-> 'b0
  assign vp1_u__cache_req_if_req_ready                              = {{($bits(vp1_u__cache_req_if_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_u.cache_req_if <-> cpu_noc_u.cpu_noc_req_if[2]
  assign cpu_noc_u__cpu_noc_req_if_req[2]                           = vp1_u__cache_req_if_req;
  assign vp1_u__cache_req_if_req_ready                              = cpu_noc_u__cpu_noc_req_if_req_ready[2];
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp1_u.cache_resp_if <-> 'b0
  assign vp1_u__cache_resp_if_resp                                  = {{($bits(vp1_u__cache_resp_if_resp)-1){1'b0}}, 1'b0};
  assign vp1_u__cache_resp_if_resp_valid                            = {{($bits(vp1_u__cache_resp_if_resp_valid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_u.cache_resp_if <-> cpu_noc_u.noc_cpu_resp_if[2]
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[2]                   = vp1_u__cache_resp_if_resp_ready;
  assign vp1_u__cache_resp_if_resp                                  = cpu_noc_u__noc_cpu_resp_if_resp[2];
  assign vp1_u__cache_resp_if_resp_valid                            = cpu_noc_u__noc_cpu_resp_if_resp_valid[2];
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp1_u.cpu_amo_store <-> 'b0
  assign vp1_u__cpu_amo_store_req_ready                             = {{($bits(vp1_u__cpu_amo_store_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp1_u.cpu_amo_store <-> cpu_noc_u.cpu_amo_store_noc[2]
  assign cpu_noc_u__cpu_amo_store_noc_req[2]                        = vp1_u__cpu_amo_store_req;
  assign vp1_u__cpu_amo_store_req_ready                             = cpu_noc_u__cpu_amo_store_noc_req_ready[2];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_u.s2b <-> vp1_station_u.out_s2b
  assign vp1_u__s2b_bp_if_pc_0                                      = vp1_station_u__out_s2b_bp_if_pc_0;
  assign vp1_u__s2b_bp_if_pc_1                                      = vp1_station_u__out_s2b_bp_if_pc_1;
  assign vp1_u__s2b_bp_if_pc_2                                      = vp1_station_u__out_s2b_bp_if_pc_2;
  assign vp1_u__s2b_bp_if_pc_3                                      = vp1_station_u__out_s2b_bp_if_pc_3;
  assign vp1_u__s2b_bp_instret                                      = vp1_station_u__out_s2b_bp_instret;
  assign vp1_u__s2b_bp_wb_pc_0                                      = vp1_station_u__out_s2b_bp_wb_pc_0;
  assign vp1_u__s2b_bp_wb_pc_1                                      = vp1_station_u__out_s2b_bp_wb_pc_1;
  assign vp1_u__s2b_bp_wb_pc_2                                      = vp1_station_u__out_s2b_bp_wb_pc_2;
  assign vp1_u__s2b_bp_wb_pc_3                                      = vp1_station_u__out_s2b_bp_wb_pc_3;
  assign vp1_u__s2b_cfg_bypass_ic                                   = vp1_station_u__out_s2b_cfg_bypass_ic;
  assign vp1_u__s2b_cfg_bypass_tlb                                  = vp1_station_u__out_s2b_cfg_bypass_tlb;
  assign vp1_u__s2b_cfg_en_hpmcounter                               = vp1_station_u__out_s2b_cfg_en_hpmcounter;
  assign vp1_u__s2b_cfg_itb_en                                      = vp1_station_u__out_s2b_cfg_itb_en;
  assign vp1_u__s2b_cfg_itb_sel                                     = vp1_station_u__out_s2b_cfg_itb_sel;
  assign vp1_u__s2b_cfg_itb_wrap_around                             = vp1_station_u__out_s2b_cfg_itb_wrap_around;
  assign vp1_u__s2b_cfg_lfsr_seed                                   = vp1_station_u__out_s2b_cfg_lfsr_seed;
  assign vp1_u__s2b_cfg_rst_pc                                      = vp1_station_u__out_s2b_cfg_rst_pc;
  assign vp1_u__s2b_cfg_sleep                                       = vp1_station_u__out_s2b_cfg_sleep;
  assign vp1_u__s2b_debug_resume                                    = vp1_station_u__out_s2b_debug_resume;
  assign vp1_u__s2b_debug_stall                                     = vp1_station_u__out_s2b_debug_stall;
  assign vp1_u__s2b_en_bp_if_pc_0                                   = vp1_station_u__out_s2b_en_bp_if_pc_0;
  assign vp1_u__s2b_en_bp_if_pc_1                                   = vp1_station_u__out_s2b_en_bp_if_pc_1;
  assign vp1_u__s2b_en_bp_if_pc_2                                   = vp1_station_u__out_s2b_en_bp_if_pc_2;
  assign vp1_u__s2b_en_bp_if_pc_3                                   = vp1_station_u__out_s2b_en_bp_if_pc_3;
  assign vp1_u__s2b_en_bp_instret                                   = vp1_station_u__out_s2b_en_bp_instret;
  assign vp1_u__s2b_en_bp_wb_pc_0                                   = vp1_station_u__out_s2b_en_bp_wb_pc_0;
  assign vp1_u__s2b_en_bp_wb_pc_1                                   = vp1_station_u__out_s2b_en_bp_wb_pc_1;
  assign vp1_u__s2b_en_bp_wb_pc_2                                   = vp1_station_u__out_s2b_en_bp_wb_pc_2;
  assign vp1_u__s2b_en_bp_wb_pc_3                                   = vp1_station_u__out_s2b_en_bp_wb_pc_3;
  assign vp1_u__s2b_ext_event                                       = vp1_station_u__out_s2b_ext_event;
  assign vp1_u__s2b_powerline_ctrl                                  = vp1_station_u__out_s2b_powerline_ctrl;
  assign vp1_u__s2b_powervbank_ctrl                                 = vp1_station_u__out_s2b_powervbank_ctrl;
  assign vp1_u__s2b_vcore_en                                        = vp1_station_u__out_s2b_vcore_en;
  assign vp1_u__s2b_vcore_icg_disable                               = vp1_station_u__out_s2b_vcore_icg_disable;
  assign vp1_u__s2b_vcore_pmu_en                                    = vp1_station_u__out_s2b_vcore_pmu_en;
  assign vp1_u__s2b_vcore_pmu_evt_mask                              = vp1_station_u__out_s2b_vcore_pmu_evt_mask;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_u/core_id <-> 'b1
  assign vp1_u__core_id                                             = {{($bits(vp1_u__core_id)-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_u/external_int <-> plic_u/external_int[1]
  assign vp1_u__external_int                                        = plic_u__external_int[1];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_u/s2b_cfg_pwr_on <-> vp1_iso_or_u/out
  assign vp1_u__s2b_cfg_pwr_on                                      = vp1_iso_or_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_u/software_int <-> pll_station_u/out_software_int_vp_0_1[32]
  assign vp1_u__software_int                                        = pll_station_u__out_software_int_vp_0_1[32];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_u/timer_int <-> timer_interrupt_u/timer_int[1]
  assign vp1_u__timer_int                                           = timer_interrupt_u__timer_int[1];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_vlsu_int_and_u/in0 <-> vp1_u/load_vtlb_excp
  assign vp1_vlsu_int_and_u__in0                                    = vp1_u__load_vtlb_excp;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_vlsu_int_and_u/in1 <-> dft_vp1_early_rstn_mux_u/dout
  assign vp1_vlsu_int_and_u__in1                                    = dft_vp1_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp1_vlsu_int_and_u/out <-> vp1_station_u/vld_in_b2s_is_vtlb_excp
  assign vp1_station_u__vld_in_b2s_is_vtlb_excp                     = vp1_vlsu_int_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_cpunoc_amoreq_valid_and_u/in0 <-> vp2_u/cpu_amo_store_req_valid
  assign vp2_cpunoc_amoreq_valid_and_u__in0                         = vp2_u__cpu_amo_store_req_valid;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_cpunoc_amoreq_valid_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_cpunoc_amoreq_valid_and_u__in1                         = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_cpunoc_amoreq_valid_and_u/out <-> cpu_noc_u/cpu_amo_store_noc_req_valid[3]
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[3]                  = vp2_cpunoc_amoreq_valid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_cpunoc_req_valid_and_u/in0 <-> vp2_u/cache_req_if_req_valid
  assign vp2_cpunoc_req_valid_and_u__in0                            = vp2_u__cache_req_if_req_valid;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_cpunoc_req_valid_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_cpunoc_req_valid_and_u__in1                            = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_cpunoc_req_valid_and_u/out <-> cpu_noc_u/cpu_noc_req_if_req_valid[3]
  assign cpu_noc_u__cpu_noc_req_if_req_valid[3]                     = vp2_cpunoc_req_valid_and_u__out;
  `endif

  // vp2_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp2_icg_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  `ifdef IFNDEF_SINGLE_VP
  // vp2_icg_u/en <-> vp2_station_u/out_s2icg_clk_en
  assign vp2_icg_u__en                                              = vp2_station_u__out_s2icg_clk_en;
  `endif

  // vp2_icg_u/tst_en <-> 'b0
  assign vp2_icg_u__tst_en                                          = {{($bits(vp2_icg_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_SINGLE_VP
  // vp2_ring_bvalid_and_u/in0 <-> vp2_u/ring_resp_if_bvalid
  assign vp2_ring_bvalid_and_u__in0                                 = vp2_u__ring_resp_if_bvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_ring_bvalid_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_ring_bvalid_and_u__in1                                 = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_ring_bvalid_and_u/out <-> vp2_station_u/i_resp_local_if_bvalid
  assign vp2_station_u__i_resp_local_if_bvalid                      = vp2_ring_bvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_ring_rvalid_and_u/in0 <-> vp2_u/ring_resp_if_rvalid
  assign vp2_ring_rvalid_and_u__in0                                 = vp2_u__ring_resp_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_ring_rvalid_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_ring_rvalid_and_u__in1                                 = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_ring_rvalid_and_u/out <-> vp2_station_u/i_resp_local_if_rvalid
  assign vp2_station_u__i_resp_local_if_rvalid                      = vp2_ring_rvalid_and_u__out;
  `endif

  // vp2_scan_reset_u/out <-> vp2_rstn_sync_u/scan_rstn
  assign vp2_rstn_sync_u__scan_rstn                                 = vp2_scan_reset_u__out;

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u.i_req_local_if <-> vp2_u.sysbus_req_if
  assign vp2_station_u__i_req_local_if_ar                           = vp2_u__sysbus_req_if_ar;
  assign vp2_station_u__i_req_local_if_aw                           = vp2_u__sysbus_req_if_aw;
  assign vp2_station_u__i_req_local_if_w                            = vp2_u__sysbus_req_if_w;
  assign vp2_u__sysbus_req_if_arready                               = vp2_station_u__i_req_local_if_arready;
  assign vp2_u__sysbus_req_if_awready                               = vp2_station_u__i_req_local_if_awready;
  assign vp2_u__sysbus_req_if_wready                                = vp2_station_u__i_req_local_if_wready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u.i_resp_local_if <-> vp2_u.ring_resp_if
  assign vp2_station_u__i_resp_local_if_b                           = vp2_u__ring_resp_if_b;
  assign vp2_station_u__i_resp_local_if_r                           = vp2_u__ring_resp_if_r;
  assign vp2_u__ring_resp_if_bready                                 = vp2_station_u__i_resp_local_if_bready;
  assign vp2_u__ring_resp_if_rready                                 = vp2_station_u__i_resp_local_if_rready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u.i_resp_ring_if <-> vp3_station_u.o_resp_ring_if
  assign vp2_station_u__i_resp_ring_if_b                            = vp3_station_u__o_resp_ring_if_b;
  assign vp2_station_u__i_resp_ring_if_bvalid                       = vp3_station_u__o_resp_ring_if_bvalid;
  assign vp2_station_u__i_resp_ring_if_r                            = vp3_station_u__o_resp_ring_if_r;
  assign vp2_station_u__i_resp_ring_if_rvalid                       = vp3_station_u__o_resp_ring_if_rvalid;
  assign vp3_station_u__o_resp_ring_if_bready                       = vp2_station_u__i_resp_ring_if_bready;
  assign vp3_station_u__o_resp_ring_if_rready                       = vp2_station_u__i_resp_ring_if_rready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u.o_req_local_if <-> vp2_u.ring_req_if
  assign vp2_station_u__o_req_local_if_arready                      = vp2_u__ring_req_if_arready;
  assign vp2_station_u__o_req_local_if_awready                      = vp2_u__ring_req_if_awready;
  assign vp2_station_u__o_req_local_if_wready                       = vp2_u__ring_req_if_wready;
  assign vp2_u__ring_req_if_ar                                      = vp2_station_u__o_req_local_if_ar;
  assign vp2_u__ring_req_if_arvalid                                 = vp2_station_u__o_req_local_if_arvalid;
  assign vp2_u__ring_req_if_aw                                      = vp2_station_u__o_req_local_if_aw;
  assign vp2_u__ring_req_if_awvalid                                 = vp2_station_u__o_req_local_if_awvalid;
  assign vp2_u__ring_req_if_w                                       = vp2_station_u__o_req_local_if_w;
  assign vp2_u__ring_req_if_wvalid                                  = vp2_station_u__o_req_local_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u.o_req_ring_if <-> vp3_station_u.i_req_ring_if
  assign vp2_station_u__o_req_ring_if_arready                       = vp3_station_u__i_req_ring_if_arready;
  assign vp2_station_u__o_req_ring_if_awready                       = vp3_station_u__i_req_ring_if_awready;
  assign vp2_station_u__o_req_ring_if_wready                        = vp3_station_u__i_req_ring_if_wready;
  assign vp3_station_u__i_req_ring_if_ar                            = vp2_station_u__o_req_ring_if_ar;
  assign vp3_station_u__i_req_ring_if_arvalid                       = vp2_station_u__o_req_ring_if_arvalid;
  assign vp3_station_u__i_req_ring_if_aw                            = vp2_station_u__o_req_ring_if_aw;
  assign vp3_station_u__i_req_ring_if_awvalid                       = vp2_station_u__o_req_ring_if_awvalid;
  assign vp3_station_u__i_req_ring_if_w                             = vp2_station_u__o_req_ring_if_w;
  assign vp3_station_u__i_req_ring_if_wvalid                        = vp2_station_u__o_req_ring_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u.o_resp_local_if <-> vp2_u.sysbus_resp_if
  assign vp2_station_u__o_resp_local_if_bready                      = vp2_u__sysbus_resp_if_bready;
  assign vp2_station_u__o_resp_local_if_rready                      = vp2_u__sysbus_resp_if_rready;
  assign vp2_u__sysbus_resp_if_b                                    = vp2_station_u__o_resp_local_if_b;
  assign vp2_u__sysbus_resp_if_bvalid                               = vp2_station_u__o_resp_local_if_bvalid;
  assign vp2_u__sysbus_resp_if_r                                    = vp2_station_u__o_resp_local_if_r;
  assign vp2_u__sysbus_resp_if_rvalid                               = vp2_station_u__o_resp_local_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u.vld_in_b2s <-> 'b1
  assign vp2_station_u__vld_in_b2s_debug_stall_out                  = {{($bits(vp2_station_u__vld_in_b2s_debug_stall_out)-1){1'b0}}, 1'b1};
  assign vp2_station_u__vld_in_b2s_itb_last_ptr                     = {{($bits(vp2_station_u__vld_in_b2s_itb_last_ptr)-1){1'b0}}, 1'b1};
  assign vp2_station_u__vld_in_b2s_vload_drt_req_vlen_illegal       = {{($bits(vp2_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp2_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u/in_b2s_is_vtlb_excp <-> 'b1
  assign vp2_station_u__in_b2s_is_vtlb_excp                         = {{($bits(vp2_station_u__in_b2s_is_vtlb_excp)-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u/out_s2b_cfg_pwr_on <-> vp2_iso_or_u/in_0
  assign vp2_iso_or_u__in_0                                         = vp2_station_u__out_s2b_cfg_pwr_on;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_station_u/rstn <-> vp2_rstn_sync_u/rstn_out
  assign vp2_station_u__rstn                                        = vp2_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_arvalid_and_u/in0 <-> vp2_u/sysbus_req_if_arvalid
  assign vp2_sysbus_arvalid_and_u__in0                              = vp2_u__sysbus_req_if_arvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_arvalid_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_sysbus_arvalid_and_u__in1                              = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_arvalid_and_u/out <-> vp2_station_u/i_req_local_if_arvalid
  assign vp2_station_u__i_req_local_if_arvalid                      = vp2_sysbus_arvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_awvalid_and_u/in0 <-> vp2_u/sysbus_req_if_awvalid
  assign vp2_sysbus_awvalid_and_u__in0                              = vp2_u__sysbus_req_if_awvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_awvalid_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_sysbus_awvalid_and_u__in1                              = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_awvalid_and_u/out <-> vp2_station_u/i_req_local_if_awvalid
  assign vp2_station_u__i_req_local_if_awvalid                      = vp2_sysbus_awvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_wvalid_and_u/in0 <-> vp2_u/sysbus_req_if_wvalid
  assign vp2_sysbus_wvalid_and_u__in0                               = vp2_u__sysbus_req_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_wvalid_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_sysbus_wvalid_and_u__in1                               = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_sysbus_wvalid_and_u/out <-> vp2_station_u/i_req_local_if_wvalid
  assign vp2_station_u__i_req_local_if_wvalid                       = vp2_sysbus_wvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_u.b2s <-> vp2_station_u.in_b2s
  assign vp2_station_u__in_b2s_debug_stall_out                      = vp2_u__b2s_debug_stall_out;
  assign vp2_station_u__in_b2s_itb_last_ptr                         = vp2_u__b2s_itb_last_ptr;
  assign vp2_station_u__in_b2s_vload_drt_req_vlen_illegal           = vp2_u__b2s_vload_drt_req_vlen_illegal;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp2_u.cache_req_if <-> 'b0
  assign vp2_u__cache_req_if_req_ready                              = {{($bits(vp2_u__cache_req_if_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_u.cache_req_if <-> cpu_noc_u.cpu_noc_req_if[3]
  assign cpu_noc_u__cpu_noc_req_if_req[3]                           = vp2_u__cache_req_if_req;
  assign vp2_u__cache_req_if_req_ready                              = cpu_noc_u__cpu_noc_req_if_req_ready[3];
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp2_u.cache_resp_if <-> 'b0
  assign vp2_u__cache_resp_if_resp                                  = {{($bits(vp2_u__cache_resp_if_resp)-1){1'b0}}, 1'b0};
  assign vp2_u__cache_resp_if_resp_valid                            = {{($bits(vp2_u__cache_resp_if_resp_valid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_u.cache_resp_if <-> cpu_noc_u.noc_cpu_resp_if[3]
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[3]                   = vp2_u__cache_resp_if_resp_ready;
  assign vp2_u__cache_resp_if_resp                                  = cpu_noc_u__noc_cpu_resp_if_resp[3];
  assign vp2_u__cache_resp_if_resp_valid                            = cpu_noc_u__noc_cpu_resp_if_resp_valid[3];
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp2_u.cpu_amo_store <-> 'b0
  assign vp2_u__cpu_amo_store_req_ready                             = {{($bits(vp2_u__cpu_amo_store_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp2_u.cpu_amo_store <-> cpu_noc_u.cpu_amo_store_noc[3]
  assign cpu_noc_u__cpu_amo_store_noc_req[3]                        = vp2_u__cpu_amo_store_req;
  assign vp2_u__cpu_amo_store_req_ready                             = cpu_noc_u__cpu_amo_store_noc_req_ready[3];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_u.s2b <-> vp2_station_u.out_s2b
  assign vp2_u__s2b_bp_if_pc_0                                      = vp2_station_u__out_s2b_bp_if_pc_0;
  assign vp2_u__s2b_bp_if_pc_1                                      = vp2_station_u__out_s2b_bp_if_pc_1;
  assign vp2_u__s2b_bp_if_pc_2                                      = vp2_station_u__out_s2b_bp_if_pc_2;
  assign vp2_u__s2b_bp_if_pc_3                                      = vp2_station_u__out_s2b_bp_if_pc_3;
  assign vp2_u__s2b_bp_instret                                      = vp2_station_u__out_s2b_bp_instret;
  assign vp2_u__s2b_bp_wb_pc_0                                      = vp2_station_u__out_s2b_bp_wb_pc_0;
  assign vp2_u__s2b_bp_wb_pc_1                                      = vp2_station_u__out_s2b_bp_wb_pc_1;
  assign vp2_u__s2b_bp_wb_pc_2                                      = vp2_station_u__out_s2b_bp_wb_pc_2;
  assign vp2_u__s2b_bp_wb_pc_3                                      = vp2_station_u__out_s2b_bp_wb_pc_3;
  assign vp2_u__s2b_cfg_bypass_ic                                   = vp2_station_u__out_s2b_cfg_bypass_ic;
  assign vp2_u__s2b_cfg_bypass_tlb                                  = vp2_station_u__out_s2b_cfg_bypass_tlb;
  assign vp2_u__s2b_cfg_en_hpmcounter                               = vp2_station_u__out_s2b_cfg_en_hpmcounter;
  assign vp2_u__s2b_cfg_itb_en                                      = vp2_station_u__out_s2b_cfg_itb_en;
  assign vp2_u__s2b_cfg_itb_sel                                     = vp2_station_u__out_s2b_cfg_itb_sel;
  assign vp2_u__s2b_cfg_itb_wrap_around                             = vp2_station_u__out_s2b_cfg_itb_wrap_around;
  assign vp2_u__s2b_cfg_lfsr_seed                                   = vp2_station_u__out_s2b_cfg_lfsr_seed;
  assign vp2_u__s2b_cfg_rst_pc                                      = vp2_station_u__out_s2b_cfg_rst_pc;
  assign vp2_u__s2b_cfg_sleep                                       = vp2_station_u__out_s2b_cfg_sleep;
  assign vp2_u__s2b_debug_resume                                    = vp2_station_u__out_s2b_debug_resume;
  assign vp2_u__s2b_debug_stall                                     = vp2_station_u__out_s2b_debug_stall;
  assign vp2_u__s2b_en_bp_if_pc_0                                   = vp2_station_u__out_s2b_en_bp_if_pc_0;
  assign vp2_u__s2b_en_bp_if_pc_1                                   = vp2_station_u__out_s2b_en_bp_if_pc_1;
  assign vp2_u__s2b_en_bp_if_pc_2                                   = vp2_station_u__out_s2b_en_bp_if_pc_2;
  assign vp2_u__s2b_en_bp_if_pc_3                                   = vp2_station_u__out_s2b_en_bp_if_pc_3;
  assign vp2_u__s2b_en_bp_instret                                   = vp2_station_u__out_s2b_en_bp_instret;
  assign vp2_u__s2b_en_bp_wb_pc_0                                   = vp2_station_u__out_s2b_en_bp_wb_pc_0;
  assign vp2_u__s2b_en_bp_wb_pc_1                                   = vp2_station_u__out_s2b_en_bp_wb_pc_1;
  assign vp2_u__s2b_en_bp_wb_pc_2                                   = vp2_station_u__out_s2b_en_bp_wb_pc_2;
  assign vp2_u__s2b_en_bp_wb_pc_3                                   = vp2_station_u__out_s2b_en_bp_wb_pc_3;
  assign vp2_u__s2b_ext_event                                       = vp2_station_u__out_s2b_ext_event;
  assign vp2_u__s2b_powerline_ctrl                                  = vp2_station_u__out_s2b_powerline_ctrl;
  assign vp2_u__s2b_powervbank_ctrl                                 = vp2_station_u__out_s2b_powervbank_ctrl;
  assign vp2_u__s2b_vcore_en                                        = vp2_station_u__out_s2b_vcore_en;
  assign vp2_u__s2b_vcore_icg_disable                               = vp2_station_u__out_s2b_vcore_icg_disable;
  assign vp2_u__s2b_vcore_pmu_en                                    = vp2_station_u__out_s2b_vcore_pmu_en;
  assign vp2_u__s2b_vcore_pmu_evt_mask                              = vp2_station_u__out_s2b_vcore_pmu_evt_mask;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_u/core_id <-> 'b10
  assign vp2_u__core_id                                             = {{($bits(vp2_u__core_id)-2){1'b0}}, 2'b10};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_u/external_int <-> plic_u/external_int[2]
  assign vp2_u__external_int                                        = plic_u__external_int[2];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_u/s2b_cfg_pwr_on <-> vp2_iso_or_u/out
  assign vp2_u__s2b_cfg_pwr_on                                      = vp2_iso_or_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_u/software_int <-> pll_station_u/out_software_int_vp_2_3[0]
  assign vp2_u__software_int                                        = pll_station_u__out_software_int_vp_2_3[0];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_u/timer_int <-> timer_interrupt_u/timer_int[2]
  assign vp2_u__timer_int                                           = timer_interrupt_u__timer_int[2];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_vlsu_int_and_u/in0 <-> vp2_u/load_vtlb_excp
  assign vp2_vlsu_int_and_u__in0                                    = vp2_u__load_vtlb_excp;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_vlsu_int_and_u/in1 <-> dft_vp2_early_rstn_mux_u/dout
  assign vp2_vlsu_int_and_u__in1                                    = dft_vp2_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp2_vlsu_int_and_u/out <-> vp2_station_u/vld_in_b2s_is_vtlb_excp
  assign vp2_station_u__vld_in_b2s_is_vtlb_excp                     = vp2_vlsu_int_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_cpunoc_amoreq_valid_and_u/in0 <-> vp3_u/cpu_amo_store_req_valid
  assign vp3_cpunoc_amoreq_valid_and_u__in0                         = vp3_u__cpu_amo_store_req_valid;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_cpunoc_amoreq_valid_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_cpunoc_amoreq_valid_and_u__in1                         = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_cpunoc_amoreq_valid_and_u/out <-> cpu_noc_u/cpu_amo_store_noc_req_valid[4]
  assign cpu_noc_u__cpu_amo_store_noc_req_valid[4]                  = vp3_cpunoc_amoreq_valid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_cpunoc_req_valid_and_u/in0 <-> vp3_u/cache_req_if_req_valid
  assign vp3_cpunoc_req_valid_and_u__in0                            = vp3_u__cache_req_if_req_valid;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_cpunoc_req_valid_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_cpunoc_req_valid_and_u__in1                            = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_cpunoc_req_valid_and_u/out <-> cpu_noc_u/cpu_noc_req_if_req_valid[4]
  assign cpu_noc_u__cpu_noc_req_if_req_valid[4]                     = vp3_cpunoc_req_valid_and_u__out;
  `endif

  // vp3_icg_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp3_icg_u__clk                                             = dft_pllclk_clk_buf_u0__out;

  `ifdef IFNDEF_SINGLE_VP
  // vp3_icg_u/en <-> vp3_station_u/out_s2icg_clk_en
  assign vp3_icg_u__en                                              = vp3_station_u__out_s2icg_clk_en;
  `endif

  // vp3_icg_u/tst_en <-> 'b0
  assign vp3_icg_u__tst_en                                          = {{($bits(vp3_icg_u__tst_en)-1){1'b0}}, 1'b0};

  `ifdef IFNDEF_SINGLE_VP
  // vp3_ring_bvalid_and_u/in0 <-> vp3_u/ring_resp_if_bvalid
  assign vp3_ring_bvalid_and_u__in0                                 = vp3_u__ring_resp_if_bvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_ring_bvalid_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_ring_bvalid_and_u__in1                                 = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_ring_bvalid_and_u/out <-> vp3_station_u/i_resp_local_if_bvalid
  assign vp3_station_u__i_resp_local_if_bvalid                      = vp3_ring_bvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_ring_rvalid_and_u/in0 <-> vp3_u/ring_resp_if_rvalid
  assign vp3_ring_rvalid_and_u__in0                                 = vp3_u__ring_resp_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_ring_rvalid_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_ring_rvalid_and_u__in1                                 = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_ring_rvalid_and_u/out <-> vp3_station_u/i_resp_local_if_rvalid
  assign vp3_station_u__i_resp_local_if_rvalid                      = vp3_ring_rvalid_and_u__out;
  `endif

  // vp3_scan_reset_u/out <-> vp3_rstn_sync_u/scan_rstn
  assign vp3_rstn_sync_u__scan_rstn                                 = vp3_scan_reset_u__out;

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u.i_req_local_if <-> vp3_u.sysbus_req_if
  assign vp3_station_u__i_req_local_if_ar                           = vp3_u__sysbus_req_if_ar;
  assign vp3_station_u__i_req_local_if_aw                           = vp3_u__sysbus_req_if_aw;
  assign vp3_station_u__i_req_local_if_w                            = vp3_u__sysbus_req_if_w;
  assign vp3_u__sysbus_req_if_arready                               = vp3_station_u__i_req_local_if_arready;
  assign vp3_u__sysbus_req_if_awready                               = vp3_station_u__i_req_local_if_awready;
  assign vp3_u__sysbus_req_if_wready                                = vp3_station_u__i_req_local_if_wready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u.i_resp_local_if <-> vp3_u.ring_resp_if
  assign vp3_station_u__i_resp_local_if_b                           = vp3_u__ring_resp_if_b;
  assign vp3_station_u__i_resp_local_if_r                           = vp3_u__ring_resp_if_r;
  assign vp3_u__ring_resp_if_bready                                 = vp3_station_u__i_resp_local_if_bready;
  assign vp3_u__ring_resp_if_rready                                 = vp3_station_u__i_resp_local_if_rready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u.i_resp_ring_if <-> usb_station_u.o_resp_ring_if
  assign usb_station_u__o_resp_ring_if_bready                       = vp3_station_u__i_resp_ring_if_bready;
  assign usb_station_u__o_resp_ring_if_rready                       = vp3_station_u__i_resp_ring_if_rready;
  assign vp3_station_u__i_resp_ring_if_b                            = usb_station_u__o_resp_ring_if_b;
  assign vp3_station_u__i_resp_ring_if_bvalid                       = usb_station_u__o_resp_ring_if_bvalid;
  assign vp3_station_u__i_resp_ring_if_r                            = usb_station_u__o_resp_ring_if_r;
  assign vp3_station_u__i_resp_ring_if_rvalid                       = usb_station_u__o_resp_ring_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u.o_req_local_if <-> vp3_u.ring_req_if
  assign vp3_station_u__o_req_local_if_arready                      = vp3_u__ring_req_if_arready;
  assign vp3_station_u__o_req_local_if_awready                      = vp3_u__ring_req_if_awready;
  assign vp3_station_u__o_req_local_if_wready                       = vp3_u__ring_req_if_wready;
  assign vp3_u__ring_req_if_ar                                      = vp3_station_u__o_req_local_if_ar;
  assign vp3_u__ring_req_if_arvalid                                 = vp3_station_u__o_req_local_if_arvalid;
  assign vp3_u__ring_req_if_aw                                      = vp3_station_u__o_req_local_if_aw;
  assign vp3_u__ring_req_if_awvalid                                 = vp3_station_u__o_req_local_if_awvalid;
  assign vp3_u__ring_req_if_w                                       = vp3_station_u__o_req_local_if_w;
  assign vp3_u__ring_req_if_wvalid                                  = vp3_station_u__o_req_local_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u.o_req_ring_if <-> usb_station_u.i_req_ring_if
  assign usb_station_u__i_req_ring_if_ar                            = vp3_station_u__o_req_ring_if_ar;
  assign usb_station_u__i_req_ring_if_arvalid                       = vp3_station_u__o_req_ring_if_arvalid;
  assign usb_station_u__i_req_ring_if_aw                            = vp3_station_u__o_req_ring_if_aw;
  assign usb_station_u__i_req_ring_if_awvalid                       = vp3_station_u__o_req_ring_if_awvalid;
  assign usb_station_u__i_req_ring_if_w                             = vp3_station_u__o_req_ring_if_w;
  assign usb_station_u__i_req_ring_if_wvalid                        = vp3_station_u__o_req_ring_if_wvalid;
  assign vp3_station_u__o_req_ring_if_arready                       = usb_station_u__i_req_ring_if_arready;
  assign vp3_station_u__o_req_ring_if_awready                       = usb_station_u__i_req_ring_if_awready;
  assign vp3_station_u__o_req_ring_if_wready                        = usb_station_u__i_req_ring_if_wready;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u.o_resp_local_if <-> vp3_u.sysbus_resp_if
  assign vp3_station_u__o_resp_local_if_bready                      = vp3_u__sysbus_resp_if_bready;
  assign vp3_station_u__o_resp_local_if_rready                      = vp3_u__sysbus_resp_if_rready;
  assign vp3_u__sysbus_resp_if_b                                    = vp3_station_u__o_resp_local_if_b;
  assign vp3_u__sysbus_resp_if_bvalid                               = vp3_station_u__o_resp_local_if_bvalid;
  assign vp3_u__sysbus_resp_if_r                                    = vp3_station_u__o_resp_local_if_r;
  assign vp3_u__sysbus_resp_if_rvalid                               = vp3_station_u__o_resp_local_if_rvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u.vld_in_b2s <-> 'b1
  assign vp3_station_u__vld_in_b2s_debug_stall_out                  = {{($bits(vp3_station_u__vld_in_b2s_debug_stall_out)-1){1'b0}}, 1'b1};
  assign vp3_station_u__vld_in_b2s_itb_last_ptr                     = {{($bits(vp3_station_u__vld_in_b2s_itb_last_ptr)-1){1'b0}}, 1'b1};
  assign vp3_station_u__vld_in_b2s_vload_drt_req_vlen_illegal       = {{($bits(vp3_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u/clk <-> dft_pllclk_clk_buf_u0/out
  assign vp3_station_u__clk                                         = dft_pllclk_clk_buf_u0__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u/in_b2s_is_vtlb_excp <-> 'b1
  assign vp3_station_u__in_b2s_is_vtlb_excp                         = {{($bits(vp3_station_u__in_b2s_is_vtlb_excp)-1){1'b0}}, 1'b1};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u/out_s2b_cfg_pwr_on <-> vp3_iso_or_u/in_0
  assign vp3_iso_or_u__in_0                                         = vp3_station_u__out_s2b_cfg_pwr_on;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_station_u/rstn <-> vp3_rstn_sync_u/rstn_out
  assign vp3_station_u__rstn                                        = vp3_rstn_sync_u__rstn_out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_arvalid_and_u/in0 <-> vp3_u/sysbus_req_if_arvalid
  assign vp3_sysbus_arvalid_and_u__in0                              = vp3_u__sysbus_req_if_arvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_arvalid_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_sysbus_arvalid_and_u__in1                              = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_arvalid_and_u/out <-> vp3_station_u/i_req_local_if_arvalid
  assign vp3_station_u__i_req_local_if_arvalid                      = vp3_sysbus_arvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_awvalid_and_u/in0 <-> vp3_u/sysbus_req_if_awvalid
  assign vp3_sysbus_awvalid_and_u__in0                              = vp3_u__sysbus_req_if_awvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_awvalid_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_sysbus_awvalid_and_u__in1                              = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_awvalid_and_u/out <-> vp3_station_u/i_req_local_if_awvalid
  assign vp3_station_u__i_req_local_if_awvalid                      = vp3_sysbus_awvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_wvalid_and_u/in0 <-> vp3_u/sysbus_req_if_wvalid
  assign vp3_sysbus_wvalid_and_u__in0                               = vp3_u__sysbus_req_if_wvalid;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_wvalid_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_sysbus_wvalid_and_u__in1                               = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_sysbus_wvalid_and_u/out <-> vp3_station_u/i_req_local_if_wvalid
  assign vp3_station_u__i_req_local_if_wvalid                       = vp3_sysbus_wvalid_and_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_u.b2s <-> vp3_station_u.in_b2s
  assign vp3_station_u__in_b2s_debug_stall_out                      = vp3_u__b2s_debug_stall_out;
  assign vp3_station_u__in_b2s_itb_last_ptr                         = vp3_u__b2s_itb_last_ptr;
  assign vp3_station_u__in_b2s_vload_drt_req_vlen_illegal           = vp3_u__b2s_vload_drt_req_vlen_illegal;
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp3_u.cache_req_if <-> 'b0
  assign vp3_u__cache_req_if_req_ready                              = {{($bits(vp3_u__cache_req_if_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_u.cache_req_if <-> cpu_noc_u.cpu_noc_req_if[4]
  assign cpu_noc_u__cpu_noc_req_if_req[4]                           = vp3_u__cache_req_if_req;
  assign vp3_u__cache_req_if_req_ready                              = cpu_noc_u__cpu_noc_req_if_req_ready[4];
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp3_u.cache_resp_if <-> 'b0
  assign vp3_u__cache_resp_if_resp                                  = {{($bits(vp3_u__cache_resp_if_resp)-1){1'b0}}, 1'b0};
  assign vp3_u__cache_resp_if_resp_valid                            = {{($bits(vp3_u__cache_resp_if_resp_valid)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_u.cache_resp_if <-> cpu_noc_u.noc_cpu_resp_if[4]
  assign cpu_noc_u__noc_cpu_resp_if_resp_ready[4]                   = vp3_u__cache_resp_if_resp_ready;
  assign vp3_u__cache_resp_if_resp                                  = cpu_noc_u__noc_cpu_resp_if_resp[4];
  assign vp3_u__cache_resp_if_resp_valid                            = cpu_noc_u__noc_cpu_resp_if_resp_valid[4];
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFDEF_TB_USE_CPU_NOC
  // vp3_u.cpu_amo_store <-> 'b0
  assign vp3_u__cpu_amo_store_req_ready                             = {{($bits(vp3_u__cpu_amo_store_req_ready)-1){1'b0}}, 1'b0};
  `endif

  `ifdef IFNDEF_SINGLE_VP__IFNDEF_TB_USE_CPU_NOC
  // vp3_u.cpu_amo_store <-> cpu_noc_u.cpu_amo_store_noc[4]
  assign cpu_noc_u__cpu_amo_store_noc_req[4]                        = vp3_u__cpu_amo_store_req;
  assign vp3_u__cpu_amo_store_req_ready                             = cpu_noc_u__cpu_amo_store_noc_req_ready[4];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_u.s2b <-> vp3_station_u.out_s2b
  assign vp3_u__s2b_bp_if_pc_0                                      = vp3_station_u__out_s2b_bp_if_pc_0;
  assign vp3_u__s2b_bp_if_pc_1                                      = vp3_station_u__out_s2b_bp_if_pc_1;
  assign vp3_u__s2b_bp_if_pc_2                                      = vp3_station_u__out_s2b_bp_if_pc_2;
  assign vp3_u__s2b_bp_if_pc_3                                      = vp3_station_u__out_s2b_bp_if_pc_3;
  assign vp3_u__s2b_bp_instret                                      = vp3_station_u__out_s2b_bp_instret;
  assign vp3_u__s2b_bp_wb_pc_0                                      = vp3_station_u__out_s2b_bp_wb_pc_0;
  assign vp3_u__s2b_bp_wb_pc_1                                      = vp3_station_u__out_s2b_bp_wb_pc_1;
  assign vp3_u__s2b_bp_wb_pc_2                                      = vp3_station_u__out_s2b_bp_wb_pc_2;
  assign vp3_u__s2b_bp_wb_pc_3                                      = vp3_station_u__out_s2b_bp_wb_pc_3;
  assign vp3_u__s2b_cfg_bypass_ic                                   = vp3_station_u__out_s2b_cfg_bypass_ic;
  assign vp3_u__s2b_cfg_bypass_tlb                                  = vp3_station_u__out_s2b_cfg_bypass_tlb;
  assign vp3_u__s2b_cfg_en_hpmcounter                               = vp3_station_u__out_s2b_cfg_en_hpmcounter;
  assign vp3_u__s2b_cfg_itb_en                                      = vp3_station_u__out_s2b_cfg_itb_en;
  assign vp3_u__s2b_cfg_itb_sel                                     = vp3_station_u__out_s2b_cfg_itb_sel;
  assign vp3_u__s2b_cfg_itb_wrap_around                             = vp3_station_u__out_s2b_cfg_itb_wrap_around;
  assign vp3_u__s2b_cfg_lfsr_seed                                   = vp3_station_u__out_s2b_cfg_lfsr_seed;
  assign vp3_u__s2b_cfg_rst_pc                                      = vp3_station_u__out_s2b_cfg_rst_pc;
  assign vp3_u__s2b_cfg_sleep                                       = vp3_station_u__out_s2b_cfg_sleep;
  assign vp3_u__s2b_debug_resume                                    = vp3_station_u__out_s2b_debug_resume;
  assign vp3_u__s2b_debug_stall                                     = vp3_station_u__out_s2b_debug_stall;
  assign vp3_u__s2b_en_bp_if_pc_0                                   = vp3_station_u__out_s2b_en_bp_if_pc_0;
  assign vp3_u__s2b_en_bp_if_pc_1                                   = vp3_station_u__out_s2b_en_bp_if_pc_1;
  assign vp3_u__s2b_en_bp_if_pc_2                                   = vp3_station_u__out_s2b_en_bp_if_pc_2;
  assign vp3_u__s2b_en_bp_if_pc_3                                   = vp3_station_u__out_s2b_en_bp_if_pc_3;
  assign vp3_u__s2b_en_bp_instret                                   = vp3_station_u__out_s2b_en_bp_instret;
  assign vp3_u__s2b_en_bp_wb_pc_0                                   = vp3_station_u__out_s2b_en_bp_wb_pc_0;
  assign vp3_u__s2b_en_bp_wb_pc_1                                   = vp3_station_u__out_s2b_en_bp_wb_pc_1;
  assign vp3_u__s2b_en_bp_wb_pc_2                                   = vp3_station_u__out_s2b_en_bp_wb_pc_2;
  assign vp3_u__s2b_en_bp_wb_pc_3                                   = vp3_station_u__out_s2b_en_bp_wb_pc_3;
  assign vp3_u__s2b_ext_event                                       = vp3_station_u__out_s2b_ext_event;
  assign vp3_u__s2b_powerline_ctrl                                  = vp3_station_u__out_s2b_powerline_ctrl;
  assign vp3_u__s2b_powervbank_ctrl                                 = vp3_station_u__out_s2b_powervbank_ctrl;
  assign vp3_u__s2b_vcore_en                                        = vp3_station_u__out_s2b_vcore_en;
  assign vp3_u__s2b_vcore_icg_disable                               = vp3_station_u__out_s2b_vcore_icg_disable;
  assign vp3_u__s2b_vcore_pmu_en                                    = vp3_station_u__out_s2b_vcore_pmu_en;
  assign vp3_u__s2b_vcore_pmu_evt_mask                              = vp3_station_u__out_s2b_vcore_pmu_evt_mask;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_u/core_id <-> 'b11
  assign vp3_u__core_id                                             = {{($bits(vp3_u__core_id)-2){1'b0}}, 2'b11};
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_u/external_int <-> plic_u/external_int[3]
  assign vp3_u__external_int                                        = plic_u__external_int[3];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_u/s2b_cfg_pwr_on <-> vp3_iso_or_u/out
  assign vp3_u__s2b_cfg_pwr_on                                      = vp3_iso_or_u__out;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_u/software_int <-> pll_station_u/out_software_int_vp_2_3[32]
  assign vp3_u__software_int                                        = pll_station_u__out_software_int_vp_2_3[32];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_u/timer_int <-> timer_interrupt_u/timer_int[3]
  assign vp3_u__timer_int                                           = timer_interrupt_u__timer_int[3];
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_vlsu_int_and_u/in0 <-> vp3_u/load_vtlb_excp
  assign vp3_vlsu_int_and_u__in0                                    = vp3_u__load_vtlb_excp;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_vlsu_int_and_u/in1 <-> dft_vp3_early_rstn_mux_u/dout
  assign vp3_vlsu_int_and_u__in1                                    = dft_vp3_early_rstn_mux_u__dout;
  `endif

  `ifdef IFNDEF_SINGLE_VP
  // vp3_vlsu_int_and_u/out <-> vp3_station_u/vld_in_b2s_is_vtlb_excp
  assign vp3_station_u__vld_in_b2s_is_vtlb_excp                     = vp3_vlsu_int_and_u__out;
  `endif


cache_da_rw bank0_da_u(
  .clk(bank0_da_u__clk),
  .debug_addr(bank0_da_u__debug_addr),
  .debug_data_ram_en_pway(bank0_da_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank0_da_u__debug_dirty_ram_en),
  .debug_en(bank0_da_u__debug_en),
  .debug_hpmcounter_en(bank0_da_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank0_da_u__debug_lru_ram_en),
  .debug_rdata(bank0_da_u__debug_rdata),
  .debug_ready(bank0_da_u__debug_ready),
  .debug_rw(bank0_da_u__debug_rw),
  .debug_tag_ram_en_pway(bank0_da_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank0_da_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank0_da_u__debug_valid_ram_en),
  .debug_wdata(bank0_da_u__debug_wdata),
  .debug_wdata_byte_mask(bank0_da_u__debug_wdata_byte_mask),
  .ring_req_if_ar(bank0_da_u__ring_req_if_ar),
  .ring_req_if_arready(bank0_da_u__ring_req_if_arready),
  .ring_req_if_arvalid(bank0_da_u__ring_req_if_arvalid),
  .ring_req_if_aw(bank0_da_u__ring_req_if_aw),
  .ring_req_if_awready(bank0_da_u__ring_req_if_awready),
  .ring_req_if_awvalid(bank0_da_u__ring_req_if_awvalid),
  .ring_req_if_w(bank0_da_u__ring_req_if_w),
  .ring_req_if_wready(bank0_da_u__ring_req_if_wready),
  .ring_req_if_wvalid(bank0_da_u__ring_req_if_wvalid),
  .ring_resp_if_b(bank0_da_u__ring_resp_if_b),
  .ring_resp_if_bready(bank0_da_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(bank0_da_u__ring_resp_if_bvalid),
  .ring_resp_if_r(bank0_da_u__ring_resp_if_r),
  .ring_resp_if_rready(bank0_da_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(bank0_da_u__ring_resp_if_rvalid),
  .rstn(bank0_da_u__rstn)
);

icg_rstn bank0_icg_u(
  .clk(bank0_icg_u__clk),
  .clkg(bank0_icg_u__clkg),
  .en(bank0_icg_u__en),
  .rstn(bank0_icg_u__rstn),
  .tst_en(bank0_icg_u__tst_en)
);

rstn_sync bank0_rstn_sync_u(
  .clk(bank0_rstn_sync_u__clk),
  .rstn_in(bank0_rstn_sync_u__rstn_in),
  .rstn_out(bank0_rstn_sync_u__rstn_out),
  .scan_en(bank0_rstn_sync_u__scan_en),
  .scan_rstn(bank0_rstn_sync_u__scan_rstn)
);

station_cache #(.BLOCK_INST_ID(0)) bank0_station_u(
  .clk(bank0_station_u__clk),
  .i_req_local_if_ar(bank0_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(bank0_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(bank0_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(bank0_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(bank0_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(bank0_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(bank0_station_u__i_req_local_if_w),
  .i_req_local_if_wready(bank0_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(bank0_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(bank0_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(bank0_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(bank0_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(bank0_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(bank0_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(bank0_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(bank0_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(bank0_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(bank0_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(bank0_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(bank0_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(bank0_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(bank0_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(bank0_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(bank0_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(bank0_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(bank0_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(bank0_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(bank0_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(bank0_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(bank0_station_u__i_resp_ring_if_rvalid),
  .o_req_local_if_ar(bank0_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(bank0_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(bank0_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(bank0_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(bank0_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(bank0_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(bank0_station_u__o_req_local_if_w),
  .o_req_local_if_wready(bank0_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(bank0_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(bank0_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(bank0_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(bank0_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(bank0_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(bank0_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(bank0_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(bank0_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(bank0_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(bank0_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(bank0_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(bank0_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(bank0_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(bank0_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(bank0_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(bank0_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(bank0_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(bank0_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(bank0_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(bank0_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(bank0_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(bank0_station_u__o_resp_ring_if_rvalid),
  .out_s2b_ctrl_reg(bank0_station_u__out_s2b_ctrl_reg),
  .out_s2b_icg_disable(bank0_station_u__out_s2b_icg_disable),
  .out_s2b_rstn(bank0_station_u__out_s2b_rstn),
  .out_s2icg_clk_en(bank0_station_u__out_s2icg_clk_en),
  .rstn(bank0_station_u__rstn)
);

cache_bank #(.BANK_ID(0)) bank0_u(
  .cache_is_idle(bank0_u__cache_is_idle),
  .clk(bank0_u__clk),
  .cpu_l2_req_if_req(bank0_u__cpu_l2_req_if_req),
  .cpu_l2_req_if_req_ready(bank0_u__cpu_l2_req_if_req_ready),
  .cpu_l2_req_if_req_valid(bank0_u__cpu_l2_req_if_req_valid),
  .cpu_l2_resp_if_resp(bank0_u__cpu_l2_resp_if_resp),
  .cpu_l2_resp_if_resp_ready(bank0_u__cpu_l2_resp_if_resp_ready),
  .cpu_l2_resp_if_resp_valid(bank0_u__cpu_l2_resp_if_resp_valid),
  .debug_addr(bank0_u__debug_addr),
  .debug_data_ram_en_pway(bank0_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank0_u__debug_dirty_ram_en),
  .debug_en(bank0_u__debug_en),
  .debug_hpmcounter_en(bank0_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank0_u__debug_lru_ram_en),
  .debug_rdata(bank0_u__debug_rdata),
  .debug_ready(bank0_u__debug_ready),
  .debug_rw(bank0_u__debug_rw),
  .debug_tag_ram_en_pway(bank0_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank0_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank0_u__debug_valid_ram_en),
  .debug_wdata(bank0_u__debug_wdata),
  .debug_wdata_byte_mask(bank0_u__debug_wdata_byte_mask),
  .l2_amo_store_req(bank0_u__l2_amo_store_req),
  .l2_amo_store_req_ready(bank0_u__l2_amo_store_req_ready),
  .l2_amo_store_req_valid(bank0_u__l2_amo_store_req_valid),
  .l2_req_if_ar(bank0_u__l2_req_if_ar),
  .l2_req_if_arready(bank0_u__l2_req_if_arready),
  .l2_req_if_arvalid(bank0_u__l2_req_if_arvalid),
  .l2_req_if_aw(bank0_u__l2_req_if_aw),
  .l2_req_if_awready(bank0_u__l2_req_if_awready),
  .l2_req_if_awvalid(bank0_u__l2_req_if_awvalid),
  .l2_req_if_w(bank0_u__l2_req_if_w),
  .l2_req_if_wready(bank0_u__l2_req_if_wready),
  .l2_req_if_wvalid(bank0_u__l2_req_if_wvalid),
  .l2_resp_if_b(bank0_u__l2_resp_if_b),
  .l2_resp_if_bready(bank0_u__l2_resp_if_bready),
  .l2_resp_if_bvalid(bank0_u__l2_resp_if_bvalid),
  .l2_resp_if_r(bank0_u__l2_resp_if_r),
  .l2_resp_if_rready(bank0_u__l2_resp_if_rready),
  .l2_resp_if_rvalid(bank0_u__l2_resp_if_rvalid),
  .mem_barrier_clr_pbank_in(bank0_u__mem_barrier_clr_pbank_in),
  .mem_barrier_clr_pbank_out(bank0_u__mem_barrier_clr_pbank_out),
  .mem_barrier_status_in(bank0_u__mem_barrier_status_in),
  .mem_barrier_status_out(bank0_u__mem_barrier_status_out),
  .s2b_ctrl_reg(bank0_u__s2b_ctrl_reg),
  .s2b_icg_disable(bank0_u__s2b_icg_disable),
  .s2b_rstn(bank0_u__s2b_rstn),
  .scan_mode(bank0_u__scan_mode),
  .tst_en(bank0_u__tst_en)
);

cache_da_rw bank1_da_u(
  .clk(bank1_da_u__clk),
  .debug_addr(bank1_da_u__debug_addr),
  .debug_data_ram_en_pway(bank1_da_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank1_da_u__debug_dirty_ram_en),
  .debug_en(bank1_da_u__debug_en),
  .debug_hpmcounter_en(bank1_da_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank1_da_u__debug_lru_ram_en),
  .debug_rdata(bank1_da_u__debug_rdata),
  .debug_ready(bank1_da_u__debug_ready),
  .debug_rw(bank1_da_u__debug_rw),
  .debug_tag_ram_en_pway(bank1_da_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank1_da_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank1_da_u__debug_valid_ram_en),
  .debug_wdata(bank1_da_u__debug_wdata),
  .debug_wdata_byte_mask(bank1_da_u__debug_wdata_byte_mask),
  .ring_req_if_ar(bank1_da_u__ring_req_if_ar),
  .ring_req_if_arready(bank1_da_u__ring_req_if_arready),
  .ring_req_if_arvalid(bank1_da_u__ring_req_if_arvalid),
  .ring_req_if_aw(bank1_da_u__ring_req_if_aw),
  .ring_req_if_awready(bank1_da_u__ring_req_if_awready),
  .ring_req_if_awvalid(bank1_da_u__ring_req_if_awvalid),
  .ring_req_if_w(bank1_da_u__ring_req_if_w),
  .ring_req_if_wready(bank1_da_u__ring_req_if_wready),
  .ring_req_if_wvalid(bank1_da_u__ring_req_if_wvalid),
  .ring_resp_if_b(bank1_da_u__ring_resp_if_b),
  .ring_resp_if_bready(bank1_da_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(bank1_da_u__ring_resp_if_bvalid),
  .ring_resp_if_r(bank1_da_u__ring_resp_if_r),
  .ring_resp_if_rready(bank1_da_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(bank1_da_u__ring_resp_if_rvalid),
  .rstn(bank1_da_u__rstn)
);

icg_rstn bank1_icg_u(
  .clk(bank1_icg_u__clk),
  .clkg(bank1_icg_u__clkg),
  .en(bank1_icg_u__en),
  .rstn(bank1_icg_u__rstn),
  .tst_en(bank1_icg_u__tst_en)
);

rstn_sync bank1_rstn_sync_u(
  .clk(bank1_rstn_sync_u__clk),
  .rstn_in(bank1_rstn_sync_u__rstn_in),
  .rstn_out(bank1_rstn_sync_u__rstn_out),
  .scan_en(bank1_rstn_sync_u__scan_en),
  .scan_rstn(bank1_rstn_sync_u__scan_rstn)
);

station_cache #(.BLOCK_INST_ID(1)) bank1_station_u(
  .clk(bank1_station_u__clk),
  .i_req_local_if_ar(bank1_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(bank1_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(bank1_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(bank1_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(bank1_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(bank1_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(bank1_station_u__i_req_local_if_w),
  .i_req_local_if_wready(bank1_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(bank1_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(bank1_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(bank1_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(bank1_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(bank1_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(bank1_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(bank1_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(bank1_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(bank1_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(bank1_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(bank1_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(bank1_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(bank1_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(bank1_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(bank1_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(bank1_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(bank1_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(bank1_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(bank1_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(bank1_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(bank1_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(bank1_station_u__i_resp_ring_if_rvalid),
  .o_req_local_if_ar(bank1_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(bank1_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(bank1_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(bank1_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(bank1_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(bank1_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(bank1_station_u__o_req_local_if_w),
  .o_req_local_if_wready(bank1_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(bank1_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(bank1_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(bank1_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(bank1_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(bank1_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(bank1_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(bank1_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(bank1_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(bank1_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(bank1_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(bank1_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(bank1_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(bank1_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(bank1_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(bank1_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(bank1_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(bank1_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(bank1_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(bank1_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(bank1_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(bank1_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(bank1_station_u__o_resp_ring_if_rvalid),
  .out_s2b_ctrl_reg(bank1_station_u__out_s2b_ctrl_reg),
  .out_s2b_icg_disable(bank1_station_u__out_s2b_icg_disable),
  .out_s2b_rstn(bank1_station_u__out_s2b_rstn),
  .out_s2icg_clk_en(bank1_station_u__out_s2icg_clk_en),
  .rstn(bank1_station_u__rstn)
);

cache_bank #(.BANK_ID(1)) bank1_u(
  .cache_is_idle(bank1_u__cache_is_idle),
  .clk(bank1_u__clk),
  .cpu_l2_req_if_req(bank1_u__cpu_l2_req_if_req),
  .cpu_l2_req_if_req_ready(bank1_u__cpu_l2_req_if_req_ready),
  .cpu_l2_req_if_req_valid(bank1_u__cpu_l2_req_if_req_valid),
  .cpu_l2_resp_if_resp(bank1_u__cpu_l2_resp_if_resp),
  .cpu_l2_resp_if_resp_ready(bank1_u__cpu_l2_resp_if_resp_ready),
  .cpu_l2_resp_if_resp_valid(bank1_u__cpu_l2_resp_if_resp_valid),
  .debug_addr(bank1_u__debug_addr),
  .debug_data_ram_en_pway(bank1_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank1_u__debug_dirty_ram_en),
  .debug_en(bank1_u__debug_en),
  .debug_hpmcounter_en(bank1_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank1_u__debug_lru_ram_en),
  .debug_rdata(bank1_u__debug_rdata),
  .debug_ready(bank1_u__debug_ready),
  .debug_rw(bank1_u__debug_rw),
  .debug_tag_ram_en_pway(bank1_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank1_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank1_u__debug_valid_ram_en),
  .debug_wdata(bank1_u__debug_wdata),
  .debug_wdata_byte_mask(bank1_u__debug_wdata_byte_mask),
  .l2_amo_store_req(bank1_u__l2_amo_store_req),
  .l2_amo_store_req_ready(bank1_u__l2_amo_store_req_ready),
  .l2_amo_store_req_valid(bank1_u__l2_amo_store_req_valid),
  .l2_req_if_ar(bank1_u__l2_req_if_ar),
  .l2_req_if_arready(bank1_u__l2_req_if_arready),
  .l2_req_if_arvalid(bank1_u__l2_req_if_arvalid),
  .l2_req_if_aw(bank1_u__l2_req_if_aw),
  .l2_req_if_awready(bank1_u__l2_req_if_awready),
  .l2_req_if_awvalid(bank1_u__l2_req_if_awvalid),
  .l2_req_if_w(bank1_u__l2_req_if_w),
  .l2_req_if_wready(bank1_u__l2_req_if_wready),
  .l2_req_if_wvalid(bank1_u__l2_req_if_wvalid),
  .l2_resp_if_b(bank1_u__l2_resp_if_b),
  .l2_resp_if_bready(bank1_u__l2_resp_if_bready),
  .l2_resp_if_bvalid(bank1_u__l2_resp_if_bvalid),
  .l2_resp_if_r(bank1_u__l2_resp_if_r),
  .l2_resp_if_rready(bank1_u__l2_resp_if_rready),
  .l2_resp_if_rvalid(bank1_u__l2_resp_if_rvalid),
  .mem_barrier_clr_pbank_in(bank1_u__mem_barrier_clr_pbank_in),
  .mem_barrier_clr_pbank_out(bank1_u__mem_barrier_clr_pbank_out),
  .mem_barrier_status_in(bank1_u__mem_barrier_status_in),
  .mem_barrier_status_out(bank1_u__mem_barrier_status_out),
  .s2b_ctrl_reg(bank1_u__s2b_ctrl_reg),
  .s2b_icg_disable(bank1_u__s2b_icg_disable),
  .s2b_rstn(bank1_u__s2b_rstn),
  .scan_mode(bank1_u__scan_mode),
  .tst_en(bank1_u__tst_en)
);

`ifdef IFNDEF_SOC_NO_BANK2
cache_da_rw bank2_da_u(
  .clk(bank2_da_u__clk),
  .debug_addr(bank2_da_u__debug_addr),
  .debug_data_ram_en_pway(bank2_da_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank2_da_u__debug_dirty_ram_en),
  .debug_en(bank2_da_u__debug_en),
  .debug_hpmcounter_en(bank2_da_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank2_da_u__debug_lru_ram_en),
  .debug_rdata(bank2_da_u__debug_rdata),
  .debug_ready(bank2_da_u__debug_ready),
  .debug_rw(bank2_da_u__debug_rw),
  .debug_tag_ram_en_pway(bank2_da_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank2_da_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank2_da_u__debug_valid_ram_en),
  .debug_wdata(bank2_da_u__debug_wdata),
  .debug_wdata_byte_mask(bank2_da_u__debug_wdata_byte_mask),
  .ring_req_if_ar(bank2_da_u__ring_req_if_ar),
  .ring_req_if_arready(bank2_da_u__ring_req_if_arready),
  .ring_req_if_arvalid(bank2_da_u__ring_req_if_arvalid),
  .ring_req_if_aw(bank2_da_u__ring_req_if_aw),
  .ring_req_if_awready(bank2_da_u__ring_req_if_awready),
  .ring_req_if_awvalid(bank2_da_u__ring_req_if_awvalid),
  .ring_req_if_w(bank2_da_u__ring_req_if_w),
  .ring_req_if_wready(bank2_da_u__ring_req_if_wready),
  .ring_req_if_wvalid(bank2_da_u__ring_req_if_wvalid),
  .ring_resp_if_b(bank2_da_u__ring_resp_if_b),
  .ring_resp_if_bready(bank2_da_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(bank2_da_u__ring_resp_if_bvalid),
  .ring_resp_if_r(bank2_da_u__ring_resp_if_r),
  .ring_resp_if_rready(bank2_da_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(bank2_da_u__ring_resp_if_rvalid),
  .rstn(bank2_da_u__rstn)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK2
icg_rstn bank2_icg_u(
  .clk(bank2_icg_u__clk),
  .clkg(bank2_icg_u__clkg),
  .en(bank2_icg_u__en),
  .rstn(bank2_icg_u__rstn),
  .tst_en(bank2_icg_u__tst_en)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK2
rstn_sync bank2_rstn_sync_u(
  .clk(bank2_rstn_sync_u__clk),
  .rstn_in(bank2_rstn_sync_u__rstn_in),
  .rstn_out(bank2_rstn_sync_u__rstn_out),
  .scan_en(bank2_rstn_sync_u__scan_en),
  .scan_rstn(bank2_rstn_sync_u__scan_rstn)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK2
station_cache #(.BLOCK_INST_ID(2)) bank2_station_u(
  .clk(bank2_station_u__clk),
  .i_req_local_if_ar(bank2_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(bank2_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(bank2_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(bank2_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(bank2_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(bank2_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(bank2_station_u__i_req_local_if_w),
  .i_req_local_if_wready(bank2_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(bank2_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(bank2_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(bank2_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(bank2_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(bank2_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(bank2_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(bank2_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(bank2_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(bank2_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(bank2_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(bank2_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(bank2_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(bank2_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(bank2_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(bank2_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(bank2_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(bank2_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(bank2_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(bank2_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(bank2_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(bank2_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(bank2_station_u__i_resp_ring_if_rvalid),
  .o_req_local_if_ar(bank2_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(bank2_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(bank2_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(bank2_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(bank2_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(bank2_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(bank2_station_u__o_req_local_if_w),
  .o_req_local_if_wready(bank2_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(bank2_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(bank2_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(bank2_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(bank2_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(bank2_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(bank2_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(bank2_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(bank2_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(bank2_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(bank2_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(bank2_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(bank2_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(bank2_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(bank2_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(bank2_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(bank2_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(bank2_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(bank2_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(bank2_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(bank2_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(bank2_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(bank2_station_u__o_resp_ring_if_rvalid),
  .out_s2b_ctrl_reg(bank2_station_u__out_s2b_ctrl_reg),
  .out_s2b_icg_disable(bank2_station_u__out_s2b_icg_disable),
  .out_s2b_rstn(bank2_station_u__out_s2b_rstn),
  .out_s2icg_clk_en(bank2_station_u__out_s2icg_clk_en),
  .rstn(bank2_station_u__rstn)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK2
cache_bank #(.BANK_ID(2)) bank2_u(
  .cache_is_idle(bank2_u__cache_is_idle),
  .clk(bank2_u__clk),
  .cpu_l2_req_if_req(bank2_u__cpu_l2_req_if_req),
  .cpu_l2_req_if_req_ready(bank2_u__cpu_l2_req_if_req_ready),
  .cpu_l2_req_if_req_valid(bank2_u__cpu_l2_req_if_req_valid),
  .cpu_l2_resp_if_resp(bank2_u__cpu_l2_resp_if_resp),
  .cpu_l2_resp_if_resp_ready(bank2_u__cpu_l2_resp_if_resp_ready),
  .cpu_l2_resp_if_resp_valid(bank2_u__cpu_l2_resp_if_resp_valid),
  .debug_addr(bank2_u__debug_addr),
  .debug_data_ram_en_pway(bank2_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank2_u__debug_dirty_ram_en),
  .debug_en(bank2_u__debug_en),
  .debug_hpmcounter_en(bank2_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank2_u__debug_lru_ram_en),
  .debug_rdata(bank2_u__debug_rdata),
  .debug_ready(bank2_u__debug_ready),
  .debug_rw(bank2_u__debug_rw),
  .debug_tag_ram_en_pway(bank2_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank2_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank2_u__debug_valid_ram_en),
  .debug_wdata(bank2_u__debug_wdata),
  .debug_wdata_byte_mask(bank2_u__debug_wdata_byte_mask),
  .l2_amo_store_req(bank2_u__l2_amo_store_req),
  .l2_amo_store_req_ready(bank2_u__l2_amo_store_req_ready),
  .l2_amo_store_req_valid(bank2_u__l2_amo_store_req_valid),
  .l2_req_if_ar(bank2_u__l2_req_if_ar),
  .l2_req_if_arready(bank2_u__l2_req_if_arready),
  .l2_req_if_arvalid(bank2_u__l2_req_if_arvalid),
  .l2_req_if_aw(bank2_u__l2_req_if_aw),
  .l2_req_if_awready(bank2_u__l2_req_if_awready),
  .l2_req_if_awvalid(bank2_u__l2_req_if_awvalid),
  .l2_req_if_w(bank2_u__l2_req_if_w),
  .l2_req_if_wready(bank2_u__l2_req_if_wready),
  .l2_req_if_wvalid(bank2_u__l2_req_if_wvalid),
  .l2_resp_if_b(bank2_u__l2_resp_if_b),
  .l2_resp_if_bready(bank2_u__l2_resp_if_bready),
  .l2_resp_if_bvalid(bank2_u__l2_resp_if_bvalid),
  .l2_resp_if_r(bank2_u__l2_resp_if_r),
  .l2_resp_if_rready(bank2_u__l2_resp_if_rready),
  .l2_resp_if_rvalid(bank2_u__l2_resp_if_rvalid),
  .mem_barrier_clr_pbank_in(bank2_u__mem_barrier_clr_pbank_in),
  .mem_barrier_clr_pbank_out(bank2_u__mem_barrier_clr_pbank_out),
  .mem_barrier_status_in(bank2_u__mem_barrier_status_in),
  .mem_barrier_status_out(bank2_u__mem_barrier_status_out),
  .s2b_ctrl_reg(bank2_u__s2b_ctrl_reg),
  .s2b_icg_disable(bank2_u__s2b_icg_disable),
  .s2b_rstn(bank2_u__s2b_rstn),
  .scan_mode(bank2_u__scan_mode),
  .tst_en(bank2_u__tst_en)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK3
cache_da_rw bank3_da_u(
  .clk(bank3_da_u__clk),
  .debug_addr(bank3_da_u__debug_addr),
  .debug_data_ram_en_pway(bank3_da_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank3_da_u__debug_dirty_ram_en),
  .debug_en(bank3_da_u__debug_en),
  .debug_hpmcounter_en(bank3_da_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank3_da_u__debug_lru_ram_en),
  .debug_rdata(bank3_da_u__debug_rdata),
  .debug_ready(bank3_da_u__debug_ready),
  .debug_rw(bank3_da_u__debug_rw),
  .debug_tag_ram_en_pway(bank3_da_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank3_da_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank3_da_u__debug_valid_ram_en),
  .debug_wdata(bank3_da_u__debug_wdata),
  .debug_wdata_byte_mask(bank3_da_u__debug_wdata_byte_mask),
  .ring_req_if_ar(bank3_da_u__ring_req_if_ar),
  .ring_req_if_arready(bank3_da_u__ring_req_if_arready),
  .ring_req_if_arvalid(bank3_da_u__ring_req_if_arvalid),
  .ring_req_if_aw(bank3_da_u__ring_req_if_aw),
  .ring_req_if_awready(bank3_da_u__ring_req_if_awready),
  .ring_req_if_awvalid(bank3_da_u__ring_req_if_awvalid),
  .ring_req_if_w(bank3_da_u__ring_req_if_w),
  .ring_req_if_wready(bank3_da_u__ring_req_if_wready),
  .ring_req_if_wvalid(bank3_da_u__ring_req_if_wvalid),
  .ring_resp_if_b(bank3_da_u__ring_resp_if_b),
  .ring_resp_if_bready(bank3_da_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(bank3_da_u__ring_resp_if_bvalid),
  .ring_resp_if_r(bank3_da_u__ring_resp_if_r),
  .ring_resp_if_rready(bank3_da_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(bank3_da_u__ring_resp_if_rvalid),
  .rstn(bank3_da_u__rstn)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK3
icg_rstn bank3_icg_u(
  .clk(bank3_icg_u__clk),
  .clkg(bank3_icg_u__clkg),
  .en(bank3_icg_u__en),
  .rstn(bank3_icg_u__rstn),
  .tst_en(bank3_icg_u__tst_en)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK3
rstn_sync bank3_rstn_sync_u(
  .clk(bank3_rstn_sync_u__clk),
  .rstn_in(bank3_rstn_sync_u__rstn_in),
  .rstn_out(bank3_rstn_sync_u__rstn_out),
  .scan_en(bank3_rstn_sync_u__scan_en),
  .scan_rstn(bank3_rstn_sync_u__scan_rstn)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK3
station_cache #(.BLOCK_INST_ID(3)) bank3_station_u(
  .clk(bank3_station_u__clk),
  .i_req_local_if_ar(bank3_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(bank3_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(bank3_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(bank3_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(bank3_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(bank3_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(bank3_station_u__i_req_local_if_w),
  .i_req_local_if_wready(bank3_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(bank3_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(bank3_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(bank3_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(bank3_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(bank3_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(bank3_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(bank3_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(bank3_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(bank3_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(bank3_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(bank3_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(bank3_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(bank3_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(bank3_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(bank3_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(bank3_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(bank3_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(bank3_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(bank3_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(bank3_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(bank3_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(bank3_station_u__i_resp_ring_if_rvalid),
  .o_req_local_if_ar(bank3_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(bank3_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(bank3_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(bank3_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(bank3_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(bank3_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(bank3_station_u__o_req_local_if_w),
  .o_req_local_if_wready(bank3_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(bank3_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(bank3_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(bank3_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(bank3_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(bank3_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(bank3_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(bank3_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(bank3_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(bank3_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(bank3_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(bank3_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(bank3_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(bank3_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(bank3_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(bank3_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(bank3_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(bank3_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(bank3_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(bank3_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(bank3_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(bank3_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(bank3_station_u__o_resp_ring_if_rvalid),
  .out_s2b_ctrl_reg(bank3_station_u__out_s2b_ctrl_reg),
  .out_s2b_icg_disable(bank3_station_u__out_s2b_icg_disable),
  .out_s2b_rstn(bank3_station_u__out_s2b_rstn),
  .out_s2icg_clk_en(bank3_station_u__out_s2icg_clk_en),
  .rstn(bank3_station_u__rstn)
);
`endif

`ifdef IFNDEF_SOC_NO_BANK3
cache_bank #(.BANK_ID(3)) bank3_u(
  .cache_is_idle(bank3_u__cache_is_idle),
  .clk(bank3_u__clk),
  .cpu_l2_req_if_req(bank3_u__cpu_l2_req_if_req),
  .cpu_l2_req_if_req_ready(bank3_u__cpu_l2_req_if_req_ready),
  .cpu_l2_req_if_req_valid(bank3_u__cpu_l2_req_if_req_valid),
  .cpu_l2_resp_if_resp(bank3_u__cpu_l2_resp_if_resp),
  .cpu_l2_resp_if_resp_ready(bank3_u__cpu_l2_resp_if_resp_ready),
  .cpu_l2_resp_if_resp_valid(bank3_u__cpu_l2_resp_if_resp_valid),
  .debug_addr(bank3_u__debug_addr),
  .debug_data_ram_en_pway(bank3_u__debug_data_ram_en_pway),
  .debug_dirty_ram_en(bank3_u__debug_dirty_ram_en),
  .debug_en(bank3_u__debug_en),
  .debug_hpmcounter_en(bank3_u__debug_hpmcounter_en),
  .debug_lru_ram_en(bank3_u__debug_lru_ram_en),
  .debug_rdata(bank3_u__debug_rdata),
  .debug_ready(bank3_u__debug_ready),
  .debug_rw(bank3_u__debug_rw),
  .debug_tag_ram_en_pway(bank3_u__debug_tag_ram_en_pway),
  .debug_valid_dirty_bit_mask(bank3_u__debug_valid_dirty_bit_mask),
  .debug_valid_ram_en(bank3_u__debug_valid_ram_en),
  .debug_wdata(bank3_u__debug_wdata),
  .debug_wdata_byte_mask(bank3_u__debug_wdata_byte_mask),
  .l2_amo_store_req(bank3_u__l2_amo_store_req),
  .l2_amo_store_req_ready(bank3_u__l2_amo_store_req_ready),
  .l2_amo_store_req_valid(bank3_u__l2_amo_store_req_valid),
  .l2_req_if_ar(bank3_u__l2_req_if_ar),
  .l2_req_if_arready(bank3_u__l2_req_if_arready),
  .l2_req_if_arvalid(bank3_u__l2_req_if_arvalid),
  .l2_req_if_aw(bank3_u__l2_req_if_aw),
  .l2_req_if_awready(bank3_u__l2_req_if_awready),
  .l2_req_if_awvalid(bank3_u__l2_req_if_awvalid),
  .l2_req_if_w(bank3_u__l2_req_if_w),
  .l2_req_if_wready(bank3_u__l2_req_if_wready),
  .l2_req_if_wvalid(bank3_u__l2_req_if_wvalid),
  .l2_resp_if_b(bank3_u__l2_resp_if_b),
  .l2_resp_if_bready(bank3_u__l2_resp_if_bready),
  .l2_resp_if_bvalid(bank3_u__l2_resp_if_bvalid),
  .l2_resp_if_r(bank3_u__l2_resp_if_r),
  .l2_resp_if_rready(bank3_u__l2_resp_if_rready),
  .l2_resp_if_rvalid(bank3_u__l2_resp_if_rvalid),
  .mem_barrier_clr_pbank_in(bank3_u__mem_barrier_clr_pbank_in),
  .mem_barrier_clr_pbank_out(bank3_u__mem_barrier_clr_pbank_out),
  .mem_barrier_status_in(bank3_u__mem_barrier_status_in),
  .mem_barrier_status_out(bank3_u__mem_barrier_status_out),
  .s2b_ctrl_reg(bank3_u__s2b_ctrl_reg),
  .s2b_icg_disable(bank3_u__s2b_icg_disable),
  .s2b_rstn(bank3_u__s2b_rstn),
  .scan_mode(bank3_u__scan_mode),
  .tst_en(bank3_u__tst_en)
);
`endif

dft_and boot_from_flash_en_u(
  .in0(boot_from_flash_en_u__in0),
  .in1(boot_from_flash_en_u__in1),
  .out(boot_from_flash_en_u__out)
);

dft_mux boot_from_flash_mux_u(
  .din0(boot_from_flash_mux_u__din0),
  .din1(boot_from_flash_mux_u__din1),
  .dout(boot_from_flash_mux_u__dout),
  .sel(boot_from_flash_mux_u__sel)
);

boot_from_flash_with_buf boot_from_flash_u(
  .axim_req_if_ar(boot_from_flash_u__axim_req_if_ar),
  .axim_req_if_arready(boot_from_flash_u__axim_req_if_arready),
  .axim_req_if_arvalid(boot_from_flash_u__axim_req_if_arvalid),
  .axim_req_if_aw(boot_from_flash_u__axim_req_if_aw),
  .axim_req_if_awready(boot_from_flash_u__axim_req_if_awready),
  .axim_req_if_awvalid(boot_from_flash_u__axim_req_if_awvalid),
  .axim_req_if_w(boot_from_flash_u__axim_req_if_w),
  .axim_req_if_wready(boot_from_flash_u__axim_req_if_wready),
  .axim_req_if_wvalid(boot_from_flash_u__axim_req_if_wvalid),
  .axim_rsp_if_b(boot_from_flash_u__axim_rsp_if_b),
  .axim_rsp_if_bready(boot_from_flash_u__axim_rsp_if_bready),
  .axim_rsp_if_bvalid(boot_from_flash_u__axim_rsp_if_bvalid),
  .axim_rsp_if_r(boot_from_flash_u__axim_rsp_if_r),
  .axim_rsp_if_rready(boot_from_flash_u__axim_rsp_if_rready),
  .axim_rsp_if_rvalid(boot_from_flash_u__axim_rsp_if_rvalid),
  .axis_req_if_ar(boot_from_flash_u__axis_req_if_ar),
  .axis_req_if_arready(boot_from_flash_u__axis_req_if_arready),
  .axis_req_if_arvalid(boot_from_flash_u__axis_req_if_arvalid),
  .axis_req_if_aw(boot_from_flash_u__axis_req_if_aw),
  .axis_req_if_awready(boot_from_flash_u__axis_req_if_awready),
  .axis_req_if_awvalid(boot_from_flash_u__axis_req_if_awvalid),
  .axis_req_if_w(boot_from_flash_u__axis_req_if_w),
  .axis_req_if_wready(boot_from_flash_u__axis_req_if_wready),
  .axis_req_if_wvalid(boot_from_flash_u__axis_req_if_wvalid),
  .axis_rsp_if_b(boot_from_flash_u__axis_rsp_if_b),
  .axis_rsp_if_bready(boot_from_flash_u__axis_rsp_if_bready),
  .axis_rsp_if_bvalid(boot_from_flash_u__axis_rsp_if_bvalid),
  .axis_rsp_if_r(boot_from_flash_u__axis_rsp_if_r),
  .axis_rsp_if_rready(boot_from_flash_u__axis_rsp_if_rready),
  .axis_rsp_if_rvalid(boot_from_flash_u__axis_rsp_if_rvalid),
  .clk(boot_from_flash_u__clk),
  .rstn(boot_from_flash_u__rstn),
  .s2b_boot_from_flash_ena(boot_from_flash_u__s2b_boot_from_flash_ena)
);

dft_and boot_fsm_en_u(
  .in0(boot_fsm_en_u__in0),
  .in1(boot_fsm_en_u__in1),
  .out(boot_fsm_en_u__out)
);

dft_mux boot_fsm_mux_u(
  .din0(boot_fsm_mux_u__din0),
  .din1(boot_fsm_mux_u__din1),
  .dout(boot_fsm_mux_u__dout),
  .sel(boot_fsm_mux_u__sel)
);

dft_mux boot_mode_orv32_rstn_mux_u(
  .din0(boot_mode_orv32_rstn_mux_u__din0),
  .din1(boot_mode_orv32_rstn_mux_u__din1),
  .dout(boot_mode_orv32_rstn_mux_u__dout),
  .sel(boot_mode_orv32_rstn_mux_u__sel)
);

bootup_fsm bootup_fsm_u(
  .clk(bootup_fsm_u__clk),
  .or_req_if_ar(bootup_fsm_u__or_req_if_ar),
  .or_req_if_arready(bootup_fsm_u__or_req_if_arready),
  .or_req_if_arvalid(bootup_fsm_u__or_req_if_arvalid),
  .or_req_if_aw(bootup_fsm_u__or_req_if_aw),
  .or_req_if_awready(bootup_fsm_u__or_req_if_awready),
  .or_req_if_awvalid(bootup_fsm_u__or_req_if_awvalid),
  .or_req_if_w(bootup_fsm_u__or_req_if_w),
  .or_req_if_wready(bootup_fsm_u__or_req_if_wready),
  .or_req_if_wvalid(bootup_fsm_u__or_req_if_wvalid),
  .or_rsp_if_b(bootup_fsm_u__or_rsp_if_b),
  .or_rsp_if_bready(bootup_fsm_u__or_rsp_if_bready),
  .or_rsp_if_bvalid(bootup_fsm_u__or_rsp_if_bvalid),
  .or_rsp_if_r(bootup_fsm_u__or_rsp_if_r),
  .or_rsp_if_rready(bootup_fsm_u__or_rsp_if_rready),
  .or_rsp_if_rvalid(bootup_fsm_u__or_rsp_if_rvalid),
  .rstn(bootup_fsm_u__rstn),
  .s2b_bootup_ena(bootup_fsm_u__s2b_bootup_ena)
);

buffer #(.WIDTH(12)) buf_BypassInDataAC_u(
  .in(buf_BypassInDataAC_u__in),
  .out(buf_BypassInDataAC_u__out)
);

buffer #(.WIDTH(24)) buf_BypassInDataDAT_u(
  .in(buf_BypassInDataDAT_u__in),
  .out(buf_BypassInDataDAT_u__out)
);

buffer #(.WIDTH(2)) buf_BypassInDataMASTER_u(
  .in(buf_BypassInDataMASTER_u__in),
  .out(buf_BypassInDataMASTER_u__out)
);

rstn_sync byp_rstn_sync_u(
  .clk(byp_rstn_sync_u__clk),
  .rstn_in(byp_rstn_sync_u__rstn_in),
  .rstn_out(byp_rstn_sync_u__rstn_out),
  .scan_en(byp_rstn_sync_u__scan_en),
  .scan_rstn(byp_rstn_sync_u__scan_rstn)
);

station_byp byp_station_u(
  .clk(byp_station_u__clk),
  .i_req_local_if_ar(byp_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(byp_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(byp_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(byp_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(byp_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(byp_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(byp_station_u__i_req_local_if_w),
  .i_req_local_if_wready(byp_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(byp_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(byp_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(byp_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(byp_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(byp_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(byp_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(byp_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(byp_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(byp_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(byp_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(byp_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(byp_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(byp_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(byp_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(byp_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(byp_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(byp_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(byp_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(byp_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(byp_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(byp_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(byp_station_u__i_resp_ring_if_rvalid),
  .o_req_local_if_ar(byp_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(byp_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(byp_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(byp_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(byp_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(byp_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(byp_station_u__o_req_local_if_w),
  .o_req_local_if_wready(byp_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(byp_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(byp_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(byp_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(byp_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(byp_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(byp_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(byp_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(byp_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(byp_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(byp_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(byp_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(byp_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(byp_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(byp_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(byp_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(byp_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(byp_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(byp_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(byp_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(byp_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(byp_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(byp_station_u__o_resp_ring_if_rvalid),
  .out_s2b_ddr_bypass_en(byp_station_u__out_s2b_ddr_bypass_en),
  .out_s2b_ddr_top_icg_en(byp_station_u__out_s2b_ddr_top_icg_en),
  .out_s2b_ddrls_clkdiv_divclk_sel(byp_station_u__out_s2b_ddrls_clkdiv_divclk_sel),
  .out_s2b_ddrls_clkdiv_half_div_less_1(byp_station_u__out_s2b_ddrls_clkdiv_half_div_less_1),
  .out_s2b_sdio_cclk_tx_half_div_less_1(byp_station_u__out_s2b_sdio_cclk_tx_half_div_less_1),
  .out_s2b_sdio_clk_half_div_less_1(byp_station_u__out_s2b_sdio_clk_half_div_less_1),
  .out_s2b_sdio_tmclk_half_div_less_1(byp_station_u__out_s2b_sdio_tmclk_half_div_less_1),
  .out_s2b_slow_io_clkdiv_divclk_sel(byp_station_u__out_s2b_slow_io_clkdiv_divclk_sel),
  .out_s2b_slow_io_clkdiv_half_div_less_1(byp_station_u__out_s2b_slow_io_clkdiv_half_div_less_1),
  .rstn(byp_station_u__rstn)
);

chip_idle_gen chip_idle_u(
  .bank_idle(chip_idle_u__bank_idle),
  .bank_rstn(chip_idle_u__bank_rstn),
  .chip_is_idle(chip_idle_u__chip_is_idle),
  .cpu_rstn(chip_idle_u__cpu_rstn),
  .cpu_wfe(chip_idle_u__cpu_wfe),
  .cpu_wfi(chip_idle_u__cpu_wfi)
);

rstn_sync cpu_noc_rstn_sync_u(
  .clk(cpu_noc_rstn_sync_u__clk),
  .rstn_in(cpu_noc_rstn_sync_u__rstn_in),
  .rstn_out(cpu_noc_rstn_sync_u__rstn_out),
  .scan_en(cpu_noc_rstn_sync_u__scan_en),
  .scan_rstn(cpu_noc_rstn_sync_u__scan_rstn)
);

cpu_noc cpu_noc_u(
  .clk(cpu_noc_u__clk),
  .cpu_amo_store_noc_req(cpu_noc_u__cpu_amo_store_noc_req),
  .cpu_amo_store_noc_req_ready(cpu_noc_u__cpu_amo_store_noc_req_ready),
  .cpu_amo_store_noc_req_valid(cpu_noc_u__cpu_amo_store_noc_req_valid),
  .cpu_noc_req_if_req(cpu_noc_u__cpu_noc_req_if_req),
  .cpu_noc_req_if_req_ready(cpu_noc_u__cpu_noc_req_if_req_ready),
  .cpu_noc_req_if_req_valid(cpu_noc_u__cpu_noc_req_if_req_valid),
  .entry_vld_pbank(cpu_noc_u__entry_vld_pbank),
  .is_oldest_pbank(cpu_noc_u__is_oldest_pbank),
  .l2_amo_store_req(cpu_noc_u__l2_amo_store_req),
  .l2_amo_store_req_ready(cpu_noc_u__l2_amo_store_req_ready),
  .l2_amo_store_req_valid(cpu_noc_u__l2_amo_store_req_valid),
  .l2_noc_resp(cpu_noc_u__l2_noc_resp),
  .l2_noc_resp_ready(cpu_noc_u__l2_noc_resp_ready),
  .l2_noc_resp_valid(cpu_noc_u__l2_noc_resp_valid),
  .noc_cpu_resp_if_resp(cpu_noc_u__noc_cpu_resp_if_resp),
  .noc_cpu_resp_if_resp_ready(cpu_noc_u__noc_cpu_resp_if_resp_ready),
  .noc_cpu_resp_if_resp_valid(cpu_noc_u__noc_cpu_resp_if_resp_valid),
  .noc_l2_req(cpu_noc_u__noc_l2_req),
  .noc_l2_req_ready(cpu_noc_u__noc_l2_req_ready),
  .noc_l2_req_valid(cpu_noc_u__noc_l2_req_valid),
  .rstn(cpu_noc_u__rstn)
);

clk_div_fix_pwr2 #(.DIV(4), .WITH_CLK_MUX(1)) ddr_bypass_clk_div_u(
  .dft_en(ddr_bypass_clk_div_u__dft_en),
  .divclk(ddr_bypass_clk_div_u__divclk),
  .divclk_sel(ddr_bypass_clk_div_u__divclk_sel),
  .refclk(ddr_bypass_clk_div_u__refclk)
);

sync ddr_bypass_en_sync_u(
  .clk(ddr_bypass_en_sync_u__clk),
  .d(ddr_bypass_en_sync_u__d),
  .q(ddr_bypass_en_sync_u__q)
);

glitch_free_clk_switch ddr_clk_mux_u(
  .clk0(ddr_clk_mux_u__clk0),
  .clk1(ddr_clk_mux_u__clk1),
  .clk_out(ddr_clk_mux_u__clk_out),
  .sel(ddr_clk_mux_u__sel)
);

sync ddr_ddrls_clkdiv_sel_sync_u(
  .clk(ddr_ddrls_clkdiv_sel_sync_u__clk),
  .d(ddr_ddrls_clkdiv_sel_sync_u__d),
  .q(ddr_ddrls_clkdiv_sel_sync_u__q)
);

rstn_sync ddr_hs_rstn_sync_u(
  .clk(ddr_hs_rstn_sync_u__clk),
  .rstn_in(ddr_hs_rstn_sync_u__rstn_in),
  .rstn_out(ddr_hs_rstn_sync_u__rstn_out),
  .scan_en(ddr_hs_rstn_sync_u__scan_en),
  .scan_rstn(ddr_hs_rstn_sync_u__scan_rstn)
);

or_gate ddr_iso_or_u(
  .in_0(ddr_iso_or_u__in_0),
  .in_1(ddr_iso_or_u__in_1),
  .out(ddr_iso_or_u__out)
);

rstn_sync ddr_ls_rstn_sync_u(
  .clk(ddr_ls_rstn_sync_u__clk),
  .rstn_in(ddr_ls_rstn_sync_u__rstn_in),
  .rstn_out(ddr_ls_rstn_sync_u__rstn_out),
  .scan_en(ddr_ls_rstn_sync_u__scan_en),
  .scan_rstn(ddr_ls_rstn_sync_u__scan_rstn)
);

clk_div_cfg #(.MAX_DIV(8), .WITH_CLK_MUX(1)) ddr_slow_clk_div_u(
  .dft_en(ddr_slow_clk_div_u__dft_en),
  .divclk(ddr_slow_clk_div_u__divclk),
  .divclk_sel(ddr_slow_clk_div_u__divclk_sel),
  .half_div_less_1(ddr_slow_clk_div_u__half_div_less_1),
  .refclk(ddr_slow_clk_div_u__refclk)
);

`ifdef IFDEF_ZEBU_SRAM_DDR
ddr_sram_top ddr_sram_top_u(
  .clk(ddr_sram_top_u__clk),
  .req_if_ar(ddr_sram_top_u__req_if_ar),
  .req_if_arready(ddr_sram_top_u__req_if_arready),
  .req_if_arvalid(ddr_sram_top_u__req_if_arvalid),
  .req_if_aw(ddr_sram_top_u__req_if_aw),
  .req_if_awready(ddr_sram_top_u__req_if_awready),
  .req_if_awvalid(ddr_sram_top_u__req_if_awvalid),
  .req_if_w(ddr_sram_top_u__req_if_w),
  .req_if_wready(ddr_sram_top_u__req_if_wready),
  .req_if_wvalid(ddr_sram_top_u__req_if_wvalid),
  .rsp_if_b(ddr_sram_top_u__rsp_if_b),
  .rsp_if_bready(ddr_sram_top_u__rsp_if_bready),
  .rsp_if_bvalid(ddr_sram_top_u__rsp_if_bvalid),
  .rsp_if_r(ddr_sram_top_u__rsp_if_r),
  .rsp_if_rready(ddr_sram_top_u__rsp_if_rready),
  .rsp_if_rvalid(ddr_sram_top_u__rsp_if_rvalid),
  .rst_n(ddr_sram_top_u__rst_n)
);
`endif

station_ddr_top ddr_station_u(
  .clk(ddr_station_u__clk),
  .i_req_local_if_ar(ddr_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(ddr_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(ddr_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(ddr_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(ddr_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(ddr_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(ddr_station_u__i_req_local_if_w),
  .i_req_local_if_wready(ddr_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(ddr_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(ddr_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(ddr_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(ddr_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(ddr_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(ddr_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(ddr_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(ddr_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(ddr_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(ddr_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(ddr_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(ddr_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(ddr_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(ddr_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(ddr_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(ddr_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(ddr_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(ddr_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(ddr_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(ddr_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(ddr_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(ddr_station_u__i_resp_ring_if_rvalid),
  .in_b2s_BypassInDataAC(ddr_station_u__in_b2s_BypassInDataAC),
  .in_b2s_BypassInDataDAT(ddr_station_u__in_b2s_BypassInDataDAT),
  .in_b2s_BypassInDataMASTER(ddr_station_u__in_b2s_BypassInDataMASTER),
  .in_b2s_cactive_0(ddr_station_u__in_b2s_cactive_0),
  .in_b2s_cactive_ddrc(ddr_station_u__in_b2s_cactive_ddrc),
  .in_b2s_csysack_0(ddr_station_u__in_b2s_csysack_0),
  .in_b2s_csysack_ddrc(ddr_station_u__in_b2s_csysack_ddrc),
  .in_b2s_dfi_alert_err_intr(ddr_station_u__in_b2s_dfi_alert_err_intr),
  .in_b2s_dfi_reset_n_ref(ddr_station_u__in_b2s_dfi_reset_n_ref),
  .in_b2s_hif_refresh_req_bank(ddr_station_u__in_b2s_hif_refresh_req_bank),
  .in_b2s_init_mr_done_out(ddr_station_u__in_b2s_init_mr_done_out),
  .in_b2s_rd_mrr_data(ddr_station_u__in_b2s_rd_mrr_data),
  .in_b2s_rd_mrr_data_valid(ddr_station_u__in_b2s_rd_mrr_data_valid),
  .in_b2s_stat_ddrc_reg_selfref_type(ddr_station_u__in_b2s_stat_ddrc_reg_selfref_type),
  .o_req_local_if_ar(ddr_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(ddr_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(ddr_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(ddr_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(ddr_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(ddr_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(ddr_station_u__o_req_local_if_w),
  .o_req_local_if_wready(ddr_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(ddr_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(ddr_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(ddr_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(ddr_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(ddr_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(ddr_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(ddr_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(ddr_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(ddr_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(ddr_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(ddr_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(ddr_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(ddr_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(ddr_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(ddr_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(ddr_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(ddr_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(ddr_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(ddr_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(ddr_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(ddr_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(ddr_station_u__o_resp_ring_if_rvalid),
  .out_b2s_BypassInDataAC(ddr_station_u__out_b2s_BypassInDataAC),
  .out_b2s_BypassInDataDAT(ddr_station_u__out_b2s_BypassInDataDAT),
  .out_b2s_BypassInDataMASTER(ddr_station_u__out_b2s_BypassInDataMASTER),
  .out_b2s_cactive_0(ddr_station_u__out_b2s_cactive_0),
  .out_b2s_cactive_ddrc(ddr_station_u__out_b2s_cactive_ddrc),
  .out_b2s_csysack_0(ddr_station_u__out_b2s_csysack_0),
  .out_b2s_csysack_ddrc(ddr_station_u__out_b2s_csysack_ddrc),
  .out_b2s_dfi_alert_err_intr(ddr_station_u__out_b2s_dfi_alert_err_intr),
  .out_b2s_dfi_reset_n_ref(ddr_station_u__out_b2s_dfi_reset_n_ref),
  .out_b2s_hif_refresh_req_bank(ddr_station_u__out_b2s_hif_refresh_req_bank),
  .out_b2s_init_mr_done_out(ddr_station_u__out_b2s_init_mr_done_out),
  .out_b2s_rd_mrr_data(ddr_station_u__out_b2s_rd_mrr_data),
  .out_b2s_rd_mrr_data_valid(ddr_station_u__out_b2s_rd_mrr_data_valid),
  .out_b2s_stat_ddrc_reg_selfref_type(ddr_station_u__out_b2s_stat_ddrc_reg_selfref_type),
  .out_ddr_pwr_on(ddr_station_u__out_ddr_pwr_on),
  .out_debug_info_enable(ddr_station_u__out_debug_info_enable),
  .out_s2b_BypassModeEnAC(ddr_station_u__out_s2b_BypassModeEnAC),
  .out_s2b_BypassModeEnDAT(ddr_station_u__out_s2b_BypassModeEnDAT),
  .out_s2b_BypassModeEnMASTER(ddr_station_u__out_s2b_BypassModeEnMASTER),
  .out_s2b_BypassOutDataAC(ddr_station_u__out_s2b_BypassOutDataAC),
  .out_s2b_BypassOutDataDAT(ddr_station_u__out_s2b_BypassOutDataDAT),
  .out_s2b_BypassOutDataMASTER(ddr_station_u__out_s2b_BypassOutDataMASTER),
  .out_s2b_BypassOutEnAC(ddr_station_u__out_s2b_BypassOutEnAC),
  .out_s2b_BypassOutEnDAT(ddr_station_u__out_s2b_BypassOutEnDAT),
  .out_s2b_BypassOutEnMASTER(ddr_station_u__out_s2b_BypassOutEnMASTER),
  .out_s2b_aresetn_0(ddr_station_u__out_s2b_aresetn_0),
  .out_s2b_core_ddrc_rstn(ddr_station_u__out_s2b_core_ddrc_rstn),
  .out_s2b_csysreq_0(ddr_station_u__out_s2b_csysreq_0),
  .out_s2b_csysreq_ddrc(ddr_station_u__out_s2b_csysreq_ddrc),
  .out_s2b_dfi_ctrlupd_ack2_ch0(ddr_station_u__out_s2b_dfi_ctrlupd_ack2_ch0),
  .out_s2b_dfi_reset_n_in(ddr_station_u__out_s2b_dfi_reset_n_in),
  .out_s2b_init_mr_done_in(ddr_station_u__out_s2b_init_mr_done_in),
  .out_s2b_pa_rmask(ddr_station_u__out_s2b_pa_rmask),
  .out_s2b_pa_wmask(ddr_station_u__out_s2b_pa_wmask),
  .out_s2b_presetn(ddr_station_u__out_s2b_presetn),
  .out_s2b_pwr_ok_in(ddr_station_u__out_s2b_pwr_ok_in),
  .rstn(ddr_station_u__rstn),
  .vld_in_b2s_BypassInDataAC(ddr_station_u__vld_in_b2s_BypassInDataAC),
  .vld_in_b2s_BypassInDataDAT(ddr_station_u__vld_in_b2s_BypassInDataDAT),
  .vld_in_b2s_BypassInDataMASTER(ddr_station_u__vld_in_b2s_BypassInDataMASTER),
  .vld_in_b2s_cactive_0(ddr_station_u__vld_in_b2s_cactive_0),
  .vld_in_b2s_cactive_ddrc(ddr_station_u__vld_in_b2s_cactive_ddrc),
  .vld_in_b2s_csysack_0(ddr_station_u__vld_in_b2s_csysack_0),
  .vld_in_b2s_csysack_ddrc(ddr_station_u__vld_in_b2s_csysack_ddrc),
  .vld_in_b2s_dfi_alert_err_intr(ddr_station_u__vld_in_b2s_dfi_alert_err_intr),
  .vld_in_b2s_dfi_reset_n_ref(ddr_station_u__vld_in_b2s_dfi_reset_n_ref),
  .vld_in_b2s_hif_refresh_req_bank(ddr_station_u__vld_in_b2s_hif_refresh_req_bank),
  .vld_in_b2s_init_mr_done_out(ddr_station_u__vld_in_b2s_init_mr_done_out),
  .vld_in_b2s_rd_mrr_data(ddr_station_u__vld_in_b2s_rd_mrr_data),
  .vld_in_b2s_rd_mrr_data_valid(ddr_station_u__vld_in_b2s_rd_mrr_data_valid),
  .vld_in_b2s_stat_ddrc_reg_selfref_type(ddr_station_u__vld_in_b2s_stat_ddrc_reg_selfref_type)
);

icg ddr_top_icg_u(
  .clk(ddr_top_icg_u__clk),
  .clkg(ddr_top_icg_u__clkg),
  .en(ddr_top_icg_u__en),
  .tst_en(ddr_top_icg_u__tst_en)
);

`ifdef IFNDEF_NO_DDR
ddr_top ddr_top_u(
  .APBCLK(ddr_top_u__APBCLK),
  .BP_A(BP_A),
  .BP_ALERT_N(BP_ALERT_N),
  .BP_D(BP_D),
  .BP_MEMRESET_L(ddr_top_u__BP_MEMRESET_L),
  .BP_VREF(BP_VREF),
  .BP_ZN(ddr_top_u__BP_ZN),
  .BP_ZN_SENSE(ddr_top_u__BP_ZN_SENSE),
  .DfiClk(ddr_top_u__DfiClk),
  .DfiCtlClk(ddr_top_u__DfiCtlClk),
  .aclk_0(ddr_top_u__aclk_0),
  .apb_paddr(ddr_top_u__apb_paddr),
  .apb_penable(ddr_top_u__apb_penable),
  .apb_psel_s0(ddr_top_u__apb_psel_s0),
  .apb_pwdata(ddr_top_u__apb_pwdata),
  .apb_pwrite(ddr_top_u__apb_pwrite),
  .atpg_Pclk(ddr_top_u__atpg_Pclk),
  .atpg_RDQSClk(ddr_top_u__atpg_RDQSClk),
  .atpg_TxDllClk(ddr_top_u__atpg_TxDllClk),
  .atpg_mode(ddr_top_u__atpg_mode),
  .atpg_se(ddr_top_u__atpg_se),
  .atpg_si(ddr_top_u__atpg_si),
  .atpg_so(ddr_top_u__atpg_so),
  .b2s_BypassInDataAC(ddr_top_u__b2s_BypassInDataAC),
  .b2s_BypassInDataDAT(ddr_top_u__b2s_BypassInDataDAT),
  .b2s_BypassInDataMASTER(ddr_top_u__b2s_BypassInDataMASTER),
  .b2s_cactive_0(ddr_top_u__b2s_cactive_0),
  .b2s_cactive_ddrc(ddr_top_u__b2s_cactive_ddrc),
  .b2s_csysack_0(ddr_top_u__b2s_csysack_0),
  .b2s_csysack_ddrc(ddr_top_u__b2s_csysack_ddrc),
  .b2s_dfi_alert_err_intr(ddr_top_u__b2s_dfi_alert_err_intr),
  .b2s_dfi_reset_n_ref(ddr_top_u__b2s_dfi_reset_n_ref),
  .b2s_hif_refresh_req_bank(ddr_top_u__b2s_hif_refresh_req_bank),
  .b2s_init_mr_done_out(ddr_top_u__b2s_init_mr_done_out),
  .b2s_rd_mrr_data(ddr_top_u__b2s_rd_mrr_data),
  .b2s_rd_mrr_data_valid(ddr_top_u__b2s_rd_mrr_data_valid),
  .b2s_stat_ddrc_reg_selfref_type(ddr_top_u__b2s_stat_ddrc_reg_selfref_type),
  .cdc_prdata(ddr_top_u__cdc_prdata),
  .cdc_pready(ddr_top_u__cdc_pready),
  .cdc_pslverr(ddr_top_u__cdc_pslverr),
  .core_ddrc_core_clk(ddr_top_u__core_ddrc_core_clk),
  .mbist_mode(ddr_top_u__mbist_mode),
  .pclk(ddr_top_u__pclk),
  .phy_ddr_clk(ddr_top_u__phy_ddr_clk),
  .req_if_ar(ddr_top_u__req_if_ar),
  .req_if_arready(ddr_top_u__req_if_arready),
  .req_if_arvalid(ddr_top_u__req_if_arvalid),
  .req_if_aw(ddr_top_u__req_if_aw),
  .req_if_awready(ddr_top_u__req_if_awready),
  .req_if_awvalid(ddr_top_u__req_if_awvalid),
  .req_if_w(ddr_top_u__req_if_w),
  .req_if_wready(ddr_top_u__req_if_wready),
  .req_if_wvalid(ddr_top_u__req_if_wvalid),
  .rsp_if_b(ddr_top_u__rsp_if_b),
  .rsp_if_bready(ddr_top_u__rsp_if_bready),
  .rsp_if_bvalid(ddr_top_u__rsp_if_bvalid),
  .rsp_if_r(ddr_top_u__rsp_if_r),
  .rsp_if_rready(ddr_top_u__rsp_if_rready),
  .rsp_if_rvalid(ddr_top_u__rsp_if_rvalid),
  .s2b_BypassModeEnAC(ddr_top_u__s2b_BypassModeEnAC),
  .s2b_BypassModeEnDAT(ddr_top_u__s2b_BypassModeEnDAT),
  .s2b_BypassModeEnMASTER(ddr_top_u__s2b_BypassModeEnMASTER),
  .s2b_BypassOutDataAC(ddr_top_u__s2b_BypassOutDataAC),
  .s2b_BypassOutDataDAT(ddr_top_u__s2b_BypassOutDataDAT),
  .s2b_BypassOutDataMASTER(ddr_top_u__s2b_BypassOutDataMASTER),
  .s2b_BypassOutEnAC(ddr_top_u__s2b_BypassOutEnAC),
  .s2b_BypassOutEnDAT(ddr_top_u__s2b_BypassOutEnDAT),
  .s2b_BypassOutEnMASTER(ddr_top_u__s2b_BypassOutEnMASTER),
  .s2b_aresetn_0(ddr_top_u__s2b_aresetn_0),
  .s2b_core_ddrc_rstn(ddr_top_u__s2b_core_ddrc_rstn),
  .s2b_csysreq_0(ddr_top_u__s2b_csysreq_0),
  .s2b_csysreq_ddrc(ddr_top_u__s2b_csysreq_ddrc),
  .s2b_dfi_ctrlupd_ack2_ch0(ddr_top_u__s2b_dfi_ctrlupd_ack2_ch0),
  .s2b_dfi_reset_n_in(ddr_top_u__s2b_dfi_reset_n_in),
  .s2b_init_mr_done_in(ddr_top_u__s2b_init_mr_done_in),
  .s2b_pa_rmask(ddr_top_u__s2b_pa_rmask),
  .s2b_pa_wmask(ddr_top_u__s2b_pa_wmask),
  .s2b_presetn(ddr_top_u__s2b_presetn),
  .s2b_pwr_ok_in(ddr_top_u__s2b_pwr_ok_in)
);
`endif

dft_mux dft_bank0_rstn_mux_u(
  .din0(dft_bank0_rstn_mux_u__din0),
  .din1(dft_bank0_rstn_mux_u__din1),
  .dout(dft_bank0_rstn_mux_u__dout),
  .sel(dft_bank0_rstn_mux_u__sel)
);

dft_mux dft_bank1_rstn_mux_u(
  .din0(dft_bank1_rstn_mux_u__din0),
  .din1(dft_bank1_rstn_mux_u__din1),
  .dout(dft_bank1_rstn_mux_u__dout),
  .sel(dft_bank1_rstn_mux_u__sel)
);

dft_mux dft_bank2_rstn_mux_u(
  .din0(dft_bank2_rstn_mux_u__din0),
  .din1(dft_bank2_rstn_mux_u__din1),
  .dout(dft_bank2_rstn_mux_u__dout),
  .sel(dft_bank2_rstn_mux_u__sel)
);

dft_mux dft_bank3_rstn_mux_u(
  .din0(dft_bank3_rstn_mux_u__din0),
  .din1(dft_bank3_rstn_mux_u__din1),
  .dout(dft_bank3_rstn_mux_u__dout),
  .sel(dft_bank3_rstn_mux_u__sel)
);

dft_ddr_atpg_one_hot dft_ddr_atpg_one_hot_u(
  .DFT_ONE_HOT_APBClk(dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_APBClk),
  .DFT_ONE_HOT_DfiClk(dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_DfiClk),
  .DFT_ONE_HOT_DfiCtlClk(dft_ddr_atpg_one_hot_u__DFT_ONE_HOT_DfiCtlClk),
  .clk(dft_ddr_atpg_one_hot_u__clk),
  .dft_ddr_APBClk(dft_ddr_atpg_one_hot_u__dft_ddr_APBClk),
  .dft_ddr_DfiClk(dft_ddr_atpg_one_hot_u__dft_ddr_DfiClk),
  .dft_ddr_DfiCtlClk(dft_ddr_atpg_one_hot_u__dft_ddr_DfiCtlClk),
  .rstn(dft_ddr_atpg_one_hot_u__rstn),
  .scan_mode(dft_ddr_atpg_one_hot_u__scan_mode)
);

dft_clk_mux_sel dft_ddr_clk_mux_sel_u(
  .scan_mode(dft_ddr_clk_mux_sel_u__scan_mode),
  .sel_in(dft_ddr_clk_mux_sel_u__sel_in),
  .sel_out(dft_ddr_clk_mux_sel_u__sel_out)
);

dft_mux dft_ddr_rstn_mux_aresetn_u(
  .din0(dft_ddr_rstn_mux_aresetn_u__din0),
  .din1(dft_ddr_rstn_mux_aresetn_u__din1),
  .dout(dft_ddr_rstn_mux_aresetn_u__dout),
  .sel(dft_ddr_rstn_mux_aresetn_u__sel)
);

dft_mux dft_ddr_rstn_mux_core_ddrc_rstn_u(
  .din0(dft_ddr_rstn_mux_core_ddrc_rstn_u__din0),
  .din1(dft_ddr_rstn_mux_core_ddrc_rstn_u__din1),
  .dout(dft_ddr_rstn_mux_core_ddrc_rstn_u__dout),
  .sel(dft_ddr_rstn_mux_core_ddrc_rstn_u__sel)
);

dft_mux dft_ddr_rstn_mux_dfi_reset_n_u(
  .din0(dft_ddr_rstn_mux_dfi_reset_n_u__din0),
  .din1(dft_ddr_rstn_mux_dfi_reset_n_u__din1),
  .dout(dft_ddr_rstn_mux_dfi_reset_n_u__dout),
  .sel(dft_ddr_rstn_mux_dfi_reset_n_u__sel)
);

dft_mux dft_ddr_rstn_mux_presetn_u(
  .din0(dft_ddr_rstn_mux_presetn_u__din0),
  .din1(dft_ddr_rstn_mux_presetn_u__din1),
  .dout(dft_ddr_rstn_mux_presetn_u__dout),
  .sel(dft_ddr_rstn_mux_presetn_u__sel)
);

dft_clk_mux_sel dft_ddrls_clkdiv_sel_mux_sel_u(
  .scan_mode(dft_ddrls_clkdiv_sel_mux_sel_u__scan_mode),
  .sel_in(dft_ddrls_clkdiv_sel_mux_sel_u__sel_in),
  .sel_out(dft_ddrls_clkdiv_sel_mux_sel_u__sel_out)
);

dft_mode_enable dft_mode_enable_u(
  .B3_dft_mbist_mode(dft_mode_enable_u__B3_dft_mbist_mode),
  .dft_mode(dft_mode_enable_u__dft_mode),
  .p2c_scan_mode(dft_mode_enable_u__p2c_scan_mode)
);

dft_mode_enable dft_mode_vp_enable_u(
  .B3_dft_mbist_mode(dft_mode_vp_enable_u__B3_dft_mbist_mode),
  .dft_mode(dft_mode_vp_enable_u__dft_mode),
  .p2c_scan_mode(dft_mode_vp_enable_u__p2c_scan_mode)
);

dft_mux dft_mux_BypassModeEnAC_u(
  .din0(dft_mux_BypassModeEnAC_u__din0),
  .din1(dft_mux_BypassModeEnAC_u__din1),
  .dout(dft_mux_BypassModeEnAC_u__dout),
  .sel(dft_mux_BypassModeEnAC_u__sel)
);

dft_mux dft_mux_BypassModeEnDAT_u(
  .din0(dft_mux_BypassModeEnDAT_u__din0),
  .din1(dft_mux_BypassModeEnDAT_u__din1),
  .dout(dft_mux_BypassModeEnDAT_u__dout),
  .sel(dft_mux_BypassModeEnDAT_u__sel)
);

dft_mux dft_mux_BypassModeEnMASTER_u(
  .din0(dft_mux_BypassModeEnMASTER_u__din0),
  .din1(dft_mux_BypassModeEnMASTER_u__din1),
  .dout(dft_mux_BypassModeEnMASTER_u__dout),
  .sel(dft_mux_BypassModeEnMASTER_u__sel)
);

dft_mux #(.width(12)) dft_mux_BypassOutDataAC_u(
  .din0(dft_mux_BypassOutDataAC_u__din0),
  .din1(dft_mux_BypassOutDataAC_u__din1),
  .dout(dft_mux_BypassOutDataAC_u__dout),
  .sel(dft_mux_BypassOutDataAC_u__sel)
);

dft_mux #(.width(24)) dft_mux_BypassOutDataDAT_u(
  .din0(dft_mux_BypassOutDataDAT_u__din0),
  .din1(dft_mux_BypassOutDataDAT_u__din1),
  .dout(dft_mux_BypassOutDataDAT_u__dout),
  .sel(dft_mux_BypassOutDataDAT_u__sel)
);

dft_mux #(.width(2)) dft_mux_BypassOutDataMASTER_u(
  .din0(dft_mux_BypassOutDataMASTER_u__din0),
  .din1(dft_mux_BypassOutDataMASTER_u__din1),
  .dout(dft_mux_BypassOutDataMASTER_u__dout),
  .sel(dft_mux_BypassOutDataMASTER_u__sel)
);

dft_mux #(.width(12)) dft_mux_BypassOutEnAC_u(
  .din0(dft_mux_BypassOutEnAC_u__din0),
  .din1(dft_mux_BypassOutEnAC_u__din1),
  .dout(dft_mux_BypassOutEnAC_u__dout),
  .sel(dft_mux_BypassOutEnAC_u__sel)
);

dft_mux #(.width(24)) dft_mux_BypassOutEnDAT_u(
  .din0(dft_mux_BypassOutEnDAT_u__din0),
  .din1(dft_mux_BypassOutEnDAT_u__din1),
  .dout(dft_mux_BypassOutEnDAT_u__dout),
  .sel(dft_mux_BypassOutEnDAT_u__sel)
);

dft_mux #(.width(2)) dft_mux_BypassOutEnMASTER_u(
  .din0(dft_mux_BypassOutEnMASTER_u__din0),
  .din1(dft_mux_BypassOutEnMASTER_u__din1),
  .dout(dft_mux_BypassOutEnMASTER_u__dout),
  .sel(dft_mux_BypassOutEnMASTER_u__sel)
);

dft_mux dft_mux_ddr_s2b_pwr_ok_in_u(
  .din0(dft_mux_ddr_s2b_pwr_ok_in_u__din0),
  .din1(dft_mux_ddr_s2b_pwr_ok_in_u__din1),
  .dout(dft_mux_ddr_s2b_pwr_ok_in_u__dout),
  .sel(dft_mux_ddr_s2b_pwr_ok_in_u__sel)
);

dft_mux dft_mux_s2b_ref_ssp_en_u(
  .din0(dft_mux_s2b_ref_ssp_en_u__din0),
  .din1(dft_mux_s2b_ref_ssp_en_u__din1),
  .dout(dft_mux_s2b_ref_ssp_en_u__dout),
  .sel(dft_mux_s2b_ref_ssp_en_u__sel)
);

dft_mux dft_mux_s2b_ref_use_pad_u(
  .din0(dft_mux_s2b_ref_use_pad_u__din0),
  .din1(dft_mux_s2b_ref_use_pad_u__din1),
  .dout(dft_mux_s2b_ref_use_pad_u__dout),
  .sel(dft_mux_s2b_ref_use_pad_u__sel)
);

dft_mux dft_mux_test_powerdown_hsp_u(
  .din0(dft_mux_test_powerdown_hsp_u__din0),
  .din1(dft_mux_test_powerdown_hsp_u__din1),
  .dout(dft_mux_test_powerdown_hsp_u__dout),
  .sel(dft_mux_test_powerdown_hsp_u__sel)
);

dft_mux dft_mux_test_powerdown_ssp_u(
  .din0(dft_mux_test_powerdown_ssp_u__din0),
  .din1(dft_mux_test_powerdown_ssp_u__din1),
  .dout(dft_mux_test_powerdown_ssp_u__dout),
  .sel(dft_mux_test_powerdown_ssp_u__sel)
);

dft_mux dft_orv32_early_rstn_mux_u(
  .din0(dft_orv32_early_rstn_mux_u__din0),
  .din1(dft_orv32_early_rstn_mux_u__din1),
  .dout(dft_orv32_early_rstn_mux_u__dout),
  .sel(dft_orv32_early_rstn_mux_u__sel)
);

dft_mux dft_orv32_rstn_mux_u(
  .din0(dft_orv32_rstn_mux_u__din0),
  .din1(dft_orv32_rstn_mux_u__din1),
  .dout(dft_orv32_rstn_mux_u__dout),
  .sel(dft_orv32_rstn_mux_u__sel)
);

scan_supressed_clk dft_phy_ddr_clk_u(
  .clk_in(dft_phy_ddr_clk_u__clk_in),
  .clk_out(dft_phy_ddr_clk_u__clk_out),
  .scan_mode(dft_phy_ddr_clk_u__scan_mode)
);

dft_clk_buf dft_pllclk_clk_buf_u0(
  .in(dft_pllclk_clk_buf_u0__in),
  .out(dft_pllclk_clk_buf_u0__out)
);

dft_clk_buf dft_pllclk_clk_buf_u1(
  .in(dft_pllclk_clk_buf_u1__in),
  .out(dft_pllclk_clk_buf_u1__out)
);

dft_clk_buf dft_pllclk_clk_buf_u2(
  .in(dft_pllclk_clk_buf_u2__in),
  .out(dft_pllclk_clk_buf_u2__out)
);

icg dft_scan_f_usb_clk_icg_u(
  .clk(dft_scan_f_usb_clk_icg_u__clk),
  .clkg(dft_scan_f_usb_clk_icg_u__clkg),
  .en(dft_scan_f_usb_clk_icg_u__en),
  .tst_en(dft_scan_f_usb_clk_icg_u__tst_en)
);

icg dft_scan_f_vp_clk_icg_u(
  .clk(dft_scan_f_vp_clk_icg_u__clk),
  .clkg(dft_scan_f_vp_clk_icg_u__clkg),
  .en(dft_scan_f_vp_clk_icg_u__en),
  .tst_en(dft_scan_f_vp_clk_icg_u__tst_en)
);

dft_inv dft_scan_reset_inv_u(
  .in(dft_scan_reset_inv_u__in),
  .out(dft_scan_reset_inv_u__out)
);

dft_mux dft_sdio_cclk_rx_mux_u(
  .din0(dft_sdio_cclk_rx_mux_u__din0),
  .din1(dft_sdio_cclk_rx_mux_u__din1),
  .dout(dft_sdio_cclk_rx_mux_u__dout),
  .sel(dft_sdio_cclk_rx_mux_u__sel)
);

dft_mux dft_sdio_refclk_mux_u(
  .din0(dft_sdio_refclk_mux_u__din0),
  .din1(dft_sdio_refclk_mux_u__din1),
  .dout(dft_sdio_refclk_mux_u__dout),
  .sel(dft_sdio_refclk_mux_u__sel)
);

dft_mux dft_sdio_resetn_u(
  .din0(dft_sdio_resetn_u__din0),
  .din1(dft_sdio_resetn_u__din1),
  .dout(dft_sdio_resetn_u__dout),
  .sel(dft_sdio_resetn_u__sel)
);

dft_mux dft_usb_bus_clk_early_clk_mux_u(
  .din0(dft_usb_bus_clk_early_clk_mux_u__din0),
  .din1(dft_usb_bus_clk_early_clk_mux_u__din1),
  .dout(dft_usb_bus_clk_early_clk_mux_u__dout),
  .sel(dft_usb_bus_clk_early_clk_mux_u__sel)
);

dft_mux dft_usb_ram_clk_in_u(
  .din0(dft_usb_ram_clk_in_u__din0),
  .din1(dft_usb_ram_clk_in_u__din1),
  .dout(dft_usb_ram_clk_in_u__dout),
  .sel(dft_usb_ram_clk_in_u__sel)
);

dft_mux dft_usb_suspend_clk_mux_u(
  .din0(dft_usb_suspend_clk_mux_u__din0),
  .din1(dft_usb_suspend_clk_mux_u__din1),
  .dout(dft_usb_suspend_clk_mux_u__dout),
  .sel(dft_usb_suspend_clk_mux_u__sel)
);

dft_mux dft_usb_vaux_reset_n_u(
  .din0(dft_usb_vaux_reset_n_u__din0),
  .din1(dft_usb_vaux_reset_n_u__din1),
  .dout(dft_usb_vaux_reset_n_u__dout),
  .sel(dft_usb_vaux_reset_n_u__sel)
);

dft_mux dft_usb_vcc_reset_n_u(
  .din0(dft_usb_vcc_reset_n_u__din0),
  .din1(dft_usb_vcc_reset_n_u__din1),
  .dout(dft_usb_vcc_reset_n_u__dout),
  .sel(dft_usb_vcc_reset_n_u__sel)
);

glitch_free_clk_switch_rstn dft_vp0_clk_in_u(
  .clk0(dft_vp0_clk_in_u__clk0),
  .clk1(dft_vp0_clk_in_u__clk1),
  .clk_out(dft_vp0_clk_in_u__clk_out),
  .rstn(dft_vp0_clk_in_u__rstn),
  .sel(dft_vp0_clk_in_u__sel)
);

dft_mux dft_vp0_early_rstn_mux_u(
  .din0(dft_vp0_early_rstn_mux_u__din0),
  .din1(dft_vp0_early_rstn_mux_u__din1),
  .dout(dft_vp0_early_rstn_mux_u__dout),
  .sel(dft_vp0_early_rstn_mux_u__sel)
);

dft_mux dft_vp0_rstn_mux_u(
  .din0(dft_vp0_rstn_mux_u__din0),
  .din1(dft_vp0_rstn_mux_u__din1),
  .dout(dft_vp0_rstn_mux_u__dout),
  .sel(dft_vp0_rstn_mux_u__sel)
);

glitch_free_clk_switch_rstn dft_vp1_clk_in_u(
  .clk0(dft_vp1_clk_in_u__clk0),
  .clk1(dft_vp1_clk_in_u__clk1),
  .clk_out(dft_vp1_clk_in_u__clk_out),
  .rstn(dft_vp1_clk_in_u__rstn),
  .sel(dft_vp1_clk_in_u__sel)
);

dft_mux dft_vp1_early_rstn_mux_u(
  .din0(dft_vp1_early_rstn_mux_u__din0),
  .din1(dft_vp1_early_rstn_mux_u__din1),
  .dout(dft_vp1_early_rstn_mux_u__dout),
  .sel(dft_vp1_early_rstn_mux_u__sel)
);

dft_mux dft_vp1_rstn_mux_u(
  .din0(dft_vp1_rstn_mux_u__din0),
  .din1(dft_vp1_rstn_mux_u__din1),
  .dout(dft_vp1_rstn_mux_u__dout),
  .sel(dft_vp1_rstn_mux_u__sel)
);

glitch_free_clk_switch_rstn dft_vp2_clk_in_u(
  .clk0(dft_vp2_clk_in_u__clk0),
  .clk1(dft_vp2_clk_in_u__clk1),
  .clk_out(dft_vp2_clk_in_u__clk_out),
  .rstn(dft_vp2_clk_in_u__rstn),
  .sel(dft_vp2_clk_in_u__sel)
);

dft_mux dft_vp2_early_rstn_mux_u(
  .din0(dft_vp2_early_rstn_mux_u__din0),
  .din1(dft_vp2_early_rstn_mux_u__din1),
  .dout(dft_vp2_early_rstn_mux_u__dout),
  .sel(dft_vp2_early_rstn_mux_u__sel)
);

dft_mux dft_vp2_rstn_mux_u(
  .din0(dft_vp2_rstn_mux_u__din0),
  .din1(dft_vp2_rstn_mux_u__din1),
  .dout(dft_vp2_rstn_mux_u__dout),
  .sel(dft_vp2_rstn_mux_u__sel)
);

glitch_free_clk_switch_rstn dft_vp3_clk_in_u(
  .clk0(dft_vp3_clk_in_u__clk0),
  .clk1(dft_vp3_clk_in_u__clk1),
  .clk_out(dft_vp3_clk_in_u__clk_out),
  .rstn(dft_vp3_clk_in_u__rstn),
  .sel(dft_vp3_clk_in_u__sel)
);

dft_mux dft_vp3_early_rstn_mux_u(
  .din0(dft_vp3_early_rstn_mux_u__din0),
  .din1(dft_vp3_early_rstn_mux_u__din1),
  .dout(dft_vp3_early_rstn_mux_u__dout),
  .sel(dft_vp3_early_rstn_mux_u__sel)
);

dft_mux dft_vp3_rstn_mux_u(
  .din0(dft_vp3_rstn_mux_u__din0),
  .din1(dft_vp3_rstn_mux_u__din1),
  .dout(dft_vp3_rstn_mux_u__dout),
  .sel(dft_vp3_rstn_mux_u__sel)
);

icg dma_icg_u(
  .clk(dma_icg_u__clk),
  .clkg(dma_icg_u__clkg),
  .en(dma_icg_u__en),
  .tst_en(dma_icg_u__tst_en)
);

rstn_sync dma_rstn_sync_u(
  .clk(dma_rstn_sync_u__clk),
  .rstn_in(dma_rstn_sync_u__rstn_in),
  .rstn_out(dma_rstn_sync_u__rstn_out),
  .scan_en(dma_rstn_sync_u__scan_en),
  .scan_rstn(dma_rstn_sync_u__scan_rstn)
);

station_dma dma_station_u(
  .clk(dma_station_u__clk),
  .i_req_local_if_ar(dma_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(dma_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(dma_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(dma_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(dma_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(dma_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(dma_station_u__i_req_local_if_w),
  .i_req_local_if_wready(dma_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(dma_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(dma_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(dma_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(dma_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(dma_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(dma_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(dma_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(dma_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(dma_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(dma_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(dma_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(dma_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(dma_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(dma_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(dma_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(dma_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(dma_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(dma_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(dma_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(dma_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(dma_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(dma_station_u__i_resp_ring_if_rvalid),
  .in_b2s_dma_thread_idle(dma_station_u__in_b2s_dma_thread_idle),
  .in_b2s_plic_intr_src(dma_station_u__in_b2s_plic_intr_src),
  .in_b2s_thread0_intr(dma_station_u__in_b2s_thread0_intr),
  .in_b2s_thread1_intr(dma_station_u__in_b2s_thread1_intr),
  .in_b2s_thread2_intr(dma_station_u__in_b2s_thread2_intr),
  .in_b2s_thread3_intr(dma_station_u__in_b2s_thread3_intr),
  .in_dma_flush_cmd_vld(dma_station_u__in_dma_flush_cmd_vld),
  .in_dma_thread_cbuf_full_seen(dma_station_u__in_dma_thread_cbuf_full_seen),
  .in_dma_thread_cbuf_rp_addr(dma_station_u__in_dma_thread_cbuf_rp_addr),
  .in_dma_thread_cbuf_wp_addr(dma_station_u__in_dma_thread_cbuf_wp_addr),
  .in_dma_thread_cmd_vld(dma_station_u__in_dma_thread_cmd_vld),
  .o_req_local_if_ar(dma_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(dma_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(dma_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(dma_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(dma_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(dma_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(dma_station_u__o_req_local_if_w),
  .o_req_local_if_wready(dma_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(dma_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(dma_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(dma_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(dma_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(dma_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(dma_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(dma_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(dma_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(dma_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(dma_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(dma_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(dma_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(dma_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(dma_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(dma_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(dma_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(dma_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(dma_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(dma_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(dma_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(dma_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(dma_station_u__o_resp_ring_if_rvalid),
  .out_b2s_dma_thread_idle(dma_station_u__out_b2s_dma_thread_idle),
  .out_b2s_plic_intr_src(dma_station_u__out_b2s_plic_intr_src),
  .out_b2s_thread0_intr(dma_station_u__out_b2s_thread0_intr),
  .out_b2s_thread1_intr(dma_station_u__out_b2s_thread1_intr),
  .out_b2s_thread2_intr(dma_station_u__out_b2s_thread2_intr),
  .out_b2s_thread3_intr(dma_station_u__out_b2s_thread3_intr),
  .out_dma_flush_cmd_vld(dma_station_u__out_dma_flush_cmd_vld),
  .out_dma_thread0_data_avail_src_sel(dma_station_u__out_dma_thread0_data_avail_src_sel),
  .out_dma_thread1_data_avail_src_sel(dma_station_u__out_dma_thread1_data_avail_src_sel),
  .out_dma_thread2_data_avail_src_sel(dma_station_u__out_dma_thread2_data_avail_src_sel),
  .out_dma_thread3_data_avail_src_sel(dma_station_u__out_dma_thread3_data_avail_src_sel),
  .out_dma_thread_cbuf_full_seen(dma_station_u__out_dma_thread_cbuf_full_seen),
  .out_dma_thread_cbuf_rp_addr(dma_station_u__out_dma_thread_cbuf_rp_addr),
  .out_dma_thread_cbuf_wp_addr(dma_station_u__out_dma_thread_cbuf_wp_addr),
  .out_dma_thread_cmd_vld(dma_station_u__out_dma_thread_cmd_vld),
  .out_s2b_dma_flush_addr(dma_station_u__out_s2b_dma_flush_addr),
  .out_s2b_dma_flush_req_type(dma_station_u__out_s2b_dma_flush_req_type),
  .out_s2b_dma_thread_cbuf_mode(dma_station_u__out_s2b_dma_thread_cbuf_mode),
  .out_s2b_dma_thread_cbuf_size(dma_station_u__out_s2b_dma_thread_cbuf_size),
  .out_s2b_dma_thread_cbuf_thold(dma_station_u__out_s2b_dma_thread_cbuf_thold),
  .out_s2b_dma_thread_dst_addr(dma_station_u__out_s2b_dma_thread_dst_addr),
  .out_s2b_dma_thread_gather_grpdepth(dma_station_u__out_s2b_dma_thread_gather_grpdepth),
  .out_s2b_dma_thread_gather_stride(dma_station_u__out_s2b_dma_thread_gather_stride),
  .out_s2b_dma_thread_length_in_bytes(dma_station_u__out_s2b_dma_thread_length_in_bytes),
  .out_s2b_dma_thread_rpt_cnt_less_1(dma_station_u__out_s2b_dma_thread_rpt_cnt_less_1),
  .out_s2b_dma_thread_src_addr(dma_station_u__out_s2b_dma_thread_src_addr),
  .out_s2b_dma_thread_use_8b_align(dma_station_u__out_s2b_dma_thread_use_8b_align),
  .out_s2b_plic_dbg_en(dma_station_u__out_s2b_plic_dbg_en),
  .out_s2b_plic_intr_core_id(dma_station_u__out_s2b_plic_intr_core_id),
  .out_s2b_plic_intr_en(dma_station_u__out_s2b_plic_intr_en),
  .out_s2icg_clk_en(dma_station_u__out_s2icg_clk_en),
  .rstn(dma_station_u__rstn),
  .vld_in_b2s_dma_thread_idle(dma_station_u__vld_in_b2s_dma_thread_idle),
  .vld_in_b2s_plic_intr_src(dma_station_u__vld_in_b2s_plic_intr_src),
  .vld_in_b2s_thread0_intr(dma_station_u__vld_in_b2s_thread0_intr),
  .vld_in_b2s_thread1_intr(dma_station_u__vld_in_b2s_thread1_intr),
  .vld_in_b2s_thread2_intr(dma_station_u__vld_in_b2s_thread2_intr),
  .vld_in_b2s_thread3_intr(dma_station_u__vld_in_b2s_thread3_intr),
  .vld_in_dma_flush_cmd_vld(dma_station_u__vld_in_dma_flush_cmd_vld),
  .vld_in_dma_thread_cbuf_full_seen(dma_station_u__vld_in_dma_thread_cbuf_full_seen),
  .vld_in_dma_thread_cbuf_rp_addr(dma_station_u__vld_in_dma_thread_cbuf_rp_addr),
  .vld_in_dma_thread_cbuf_wp_addr(dma_station_u__vld_in_dma_thread_cbuf_wp_addr),
  .vld_in_dma_thread_cmd_vld(dma_station_u__vld_in_dma_thread_cmd_vld)
);

mux_Nto1_1bit #(.N_PORT(7)) dma_thread0_mux_u(
  .in(dma_thread0_mux_u__in),
  .out(dma_thread0_mux_u__out),
  .sel(dma_thread0_mux_u__sel)
);

mux_Nto1_1bit #(.N_PORT(7)) dma_thread1_mux_u(
  .in(dma_thread1_mux_u__in),
  .out(dma_thread1_mux_u__out),
  .sel(dma_thread1_mux_u__sel)
);

mux_Nto1_1bit #(.N_PORT(7)) dma_thread2_mux_u(
  .in(dma_thread2_mux_u__in),
  .out(dma_thread2_mux_u__out),
  .sel(dma_thread2_mux_u__sel)
);

mux_Nto1_1bit #(.N_PORT(7)) dma_thread3_mux_u(
  .in(dma_thread3_mux_u__in),
  .out(dma_thread3_mux_u__out),
  .sel(dma_thread3_mux_u__sel)
);

dma dma_u(
  .b2s_dma_thread_idle(dma_u__b2s_dma_thread_idle),
  .cbuf_mode_data_avail(dma_u__cbuf_mode_data_avail),
  .clk(dma_u__clk),
  .cpu_cache_req_if_req(dma_u__cpu_cache_req_if_req),
  .cpu_cache_req_if_req_ready(dma_u__cpu_cache_req_if_req_ready),
  .cpu_cache_req_if_req_valid(dma_u__cpu_cache_req_if_req_valid),
  .cpu_cache_resp_if_resp(dma_u__cpu_cache_resp_if_resp),
  .cpu_cache_resp_if_resp_ready(dma_u__cpu_cache_resp_if_resp_ready),
  .cpu_cache_resp_if_resp_valid(dma_u__cpu_cache_resp_if_resp_valid),
  .dma_flush_cmd_vld(dma_u__dma_flush_cmd_vld),
  .dma_flush_cmd_vld_wdata(dma_u__dma_flush_cmd_vld_wdata),
  .dma_intr(dma_u__dma_intr),
  .dma_thread_cmd_vld(dma_u__dma_thread_cmd_vld),
  .dma_thread_cmd_vld_wdata(dma_u__dma_thread_cmd_vld_wdata),
  .i_req_if_ar(dma_u__i_req_if_ar),
  .i_req_if_arready(dma_u__i_req_if_arready),
  .i_req_if_arvalid(dma_u__i_req_if_arvalid),
  .i_req_if_aw(dma_u__i_req_if_aw),
  .i_req_if_awready(dma_u__i_req_if_awready),
  .i_req_if_awvalid(dma_u__i_req_if_awvalid),
  .i_req_if_w(dma_u__i_req_if_w),
  .i_req_if_wready(dma_u__i_req_if_wready),
  .i_req_if_wvalid(dma_u__i_req_if_wvalid),
  .i_rsp_if_b(dma_u__i_rsp_if_b),
  .i_rsp_if_bready(dma_u__i_rsp_if_bready),
  .i_rsp_if_bvalid(dma_u__i_rsp_if_bvalid),
  .i_rsp_if_r(dma_u__i_rsp_if_r),
  .i_rsp_if_rready(dma_u__i_rsp_if_rready),
  .i_rsp_if_rvalid(dma_u__i_rsp_if_rvalid),
  .o_req_if_ar(dma_u__o_req_if_ar),
  .o_req_if_arready(dma_u__o_req_if_arready),
  .o_req_if_arvalid(dma_u__o_req_if_arvalid),
  .o_req_if_aw(dma_u__o_req_if_aw),
  .o_req_if_awready(dma_u__o_req_if_awready),
  .o_req_if_awvalid(dma_u__o_req_if_awvalid),
  .o_req_if_w(dma_u__o_req_if_w),
  .o_req_if_wready(dma_u__o_req_if_wready),
  .o_req_if_wvalid(dma_u__o_req_if_wvalid),
  .o_rsp_if_b(dma_u__o_rsp_if_b),
  .o_rsp_if_bready(dma_u__o_rsp_if_bready),
  .o_rsp_if_bvalid(dma_u__o_rsp_if_bvalid),
  .o_rsp_if_r(dma_u__o_rsp_if_r),
  .o_rsp_if_rready(dma_u__o_rsp_if_rready),
  .o_rsp_if_rvalid(dma_u__o_rsp_if_rvalid),
  .rstn(dma_u__rstn),
  .s2b_dma_flush_addr(dma_u__s2b_dma_flush_addr),
  .s2b_dma_flush_req_type(dma_u__s2b_dma_flush_req_type),
  .s2b_dma_thread_cbuf_mode(dma_u__s2b_dma_thread_cbuf_mode),
  .s2b_dma_thread_cbuf_size(dma_u__s2b_dma_thread_cbuf_size),
  .s2b_dma_thread_cbuf_thold(dma_u__s2b_dma_thread_cbuf_thold),
  .s2b_dma_thread_dst_addr(dma_u__s2b_dma_thread_dst_addr),
  .s2b_dma_thread_gather_grpdepth(dma_u__s2b_dma_thread_gather_grpdepth),
  .s2b_dma_thread_gather_stride(dma_u__s2b_dma_thread_gather_stride),
  .s2b_dma_thread_length_in_bytes(dma_u__s2b_dma_thread_length_in_bytes),
  .s2b_dma_thread_rpt_cnt_less_1(dma_u__s2b_dma_thread_rpt_cnt_less_1),
  .s2b_dma_thread_src_addr(dma_u__s2b_dma_thread_src_addr),
  .s2b_dma_thread_use_8b_align(dma_u__s2b_dma_thread_use_8b_align),
  .station_in_dma_thread_cbuf_full_seen(dma_u__station_in_dma_thread_cbuf_full_seen),
  .station_in_dma_thread_cbuf_rp_addr(dma_u__station_in_dma_thread_cbuf_rp_addr),
  .station_in_dma_thread_cbuf_wp_addr(dma_u__station_in_dma_thread_cbuf_wp_addr),
  .station_out_dma_thread_cbuf_full_seen(dma_u__station_out_dma_thread_cbuf_full_seen),
  .station_out_dma_thread_cbuf_rp_addr(dma_u__station_out_dma_thread_cbuf_rp_addr),
  .station_out_dma_thread_cbuf_wp_addr(dma_u__station_out_dma_thread_cbuf_wp_addr),
  .station_vld_in_dma_thread_cbuf_full_seen(dma_u__station_vld_in_dma_thread_cbuf_full_seen),
  .station_vld_in_dma_thread_cbuf_rp_addr(dma_u__station_vld_in_dma_thread_cbuf_rp_addr),
  .station_vld_in_dma_thread_cbuf_wp_addr(dma_u__station_vld_in_dma_thread_cbuf_wp_addr)
);

icg dt_icg_u(
  .clk(dt_icg_u__clk),
  .clkg(dt_icg_u__clkg),
  .en(dt_icg_u__en),
  .tst_en(dt_icg_u__tst_en)
);

rstn_sync dt_rstn_sync_u(
  .clk(dt_rstn_sync_u__clk),
  .rstn_in(dt_rstn_sync_u__rstn_in),
  .rstn_out(dt_rstn_sync_u__rstn_out),
  .scan_en(dt_rstn_sync_u__scan_en),
  .scan_rstn(dt_rstn_sync_u__scan_rstn)
);

station_dt dt_station_u(
  .clk(dt_station_u__clk),
  .i_req_local_if_ar(dt_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(dt_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(dt_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(dt_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(dt_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(dt_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(dt_station_u__i_req_local_if_w),
  .i_req_local_if_wready(dt_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(dt_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(dt_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(dt_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(dt_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(dt_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(dt_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(dt_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(dt_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(dt_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(dt_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(dt_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(dt_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(dt_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(dt_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(dt_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(dt_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(dt_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(dt_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(dt_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(dt_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(dt_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(dt_station_u__i_resp_ring_if_rvalid),
  .o_req_local_if_ar(dt_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(dt_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(dt_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(dt_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(dt_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(dt_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(dt_station_u__o_req_local_if_w),
  .o_req_local_if_wready(dt_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(dt_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(dt_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(dt_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(dt_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(dt_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(dt_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(dt_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(dt_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(dt_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(dt_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(dt_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(dt_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(dt_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(dt_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(dt_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(dt_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(dt_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(dt_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(dt_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(dt_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(dt_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(dt_station_u__o_resp_ring_if_rvalid),
  .out_s2icg_clk_en(dt_station_u__out_s2icg_clk_en),
  .rstn(dt_station_u__rstn)
);



sync i2ss0_intr_sync_u(
  .clk(i2ss0_intr_sync_u__clk),
  .d(i2ss0_intr_sync_u__d),
  .q(i2ss0_intr_sync_u__q)
);

sync i2ss1_intr_sync_u(
  .clk(i2ss1_intr_sync_u__clk),
  .d(i2ss1_intr_sync_u__d),
  .q(i2ss1_intr_sync_u__q)
);

sync i2ss2_intr_sync_u(
  .clk(i2ss2_intr_sync_u__clk),
  .d(i2ss2_intr_sync_u__d),
  .q(i2ss2_intr_sync_u__q)
);

sync i2ss3_intr_sync_u(
  .clk(i2ss3_intr_sync_u__clk),
  .d(i2ss3_intr_sync_u__d),
  .q(i2ss3_intr_sync_u__q)
);

sync i2ss4_intr_sync_u(
  .clk(i2ss4_intr_sync_u__clk),
  .d(i2ss4_intr_sync_u__d),
  .q(i2ss4_intr_sync_u__q)
);

sync i2ss5_intr_sync_u(
  .clk(i2ss5_intr_sync_u__clk),
  .d(i2ss5_intr_sync_u__d),
  .q(i2ss5_intr_sync_u__q)
);

rstn_sync jtag2or_rstn_sync_u(
  .clk(jtag2or_rstn_sync_u__clk),
  .rstn_in(jtag2or_rstn_sync_u__rstn_in),
  .rstn_out(jtag2or_rstn_sync_u__rstn_out),
  .scan_en(jtag2or_rstn_sync_u__scan_en),
  .scan_rstn(jtag2or_rstn_sync_u__scan_rstn)
);

jtag2or jtag2or_u(
  .clk(jtag2or_u__clk),
  .cmd_vld_in(jtag2or_u__cmd_vld_in),
  .cmdbuf_in(jtag2or_u__cmdbuf_in),
  .or_req_if_ar(jtag2or_u__or_req_if_ar),
  .or_req_if_arready(jtag2or_u__or_req_if_arready),
  .or_req_if_arvalid(jtag2or_u__or_req_if_arvalid),
  .or_req_if_aw(jtag2or_u__or_req_if_aw),
  .or_req_if_awready(jtag2or_u__or_req_if_awready),
  .or_req_if_awvalid(jtag2or_u__or_req_if_awvalid),
  .or_req_if_w(jtag2or_u__or_req_if_w),
  .or_req_if_wready(jtag2or_u__or_req_if_wready),
  .or_req_if_wvalid(jtag2or_u__or_req_if_wvalid),
  .or_rsp_if_b(jtag2or_u__or_rsp_if_b),
  .or_rsp_if_bready(jtag2or_u__or_rsp_if_bready),
  .or_rsp_if_bvalid(jtag2or_u__or_rsp_if_bvalid),
  .or_rsp_if_r(jtag2or_u__or_rsp_if_r),
  .or_rsp_if_rready(jtag2or_u__or_rsp_if_rready),
  .or_rsp_if_rvalid(jtag2or_u__or_rsp_if_rvalid),
  .rdata_out(jtag2or_u__rdata_out),
  .rdata_vld_out(jtag2or_u__rdata_vld_out),
  .rstn(jtag2or_u__rstn)
);

dft_clk_buf mbist_mode_buf(
  .in(mbist_mode_buf__in),
  .out(mbist_mode_buf__out)
);

`ifdef IFNDEF_NO_DDR
mem_noc_ddr_cdc_wrapper mem_noc_ddr_cdc_u(
  .cdc2ddr_req_if_ar(mem_noc_ddr_cdc_u__cdc2ddr_req_if_ar),
  .cdc2ddr_req_if_arready(mem_noc_ddr_cdc_u__cdc2ddr_req_if_arready),
  .cdc2ddr_req_if_arvalid(mem_noc_ddr_cdc_u__cdc2ddr_req_if_arvalid),
  .cdc2ddr_req_if_aw(mem_noc_ddr_cdc_u__cdc2ddr_req_if_aw),
  .cdc2ddr_req_if_awready(mem_noc_ddr_cdc_u__cdc2ddr_req_if_awready),
  .cdc2ddr_req_if_awvalid(mem_noc_ddr_cdc_u__cdc2ddr_req_if_awvalid),
  .cdc2ddr_req_if_w(mem_noc_ddr_cdc_u__cdc2ddr_req_if_w),
  .cdc2ddr_req_if_wready(mem_noc_ddr_cdc_u__cdc2ddr_req_if_wready),
  .cdc2ddr_req_if_wvalid(mem_noc_ddr_cdc_u__cdc2ddr_req_if_wvalid),
  .cdc2noc_resp_if_b(mem_noc_ddr_cdc_u__cdc2noc_resp_if_b),
  .cdc2noc_resp_if_bready(mem_noc_ddr_cdc_u__cdc2noc_resp_if_bready),
  .cdc2noc_resp_if_bvalid(mem_noc_ddr_cdc_u__cdc2noc_resp_if_bvalid),
  .cdc2noc_resp_if_r(mem_noc_ddr_cdc_u__cdc2noc_resp_if_r),
  .cdc2noc_resp_if_rready(mem_noc_ddr_cdc_u__cdc2noc_resp_if_rready),
  .cdc2noc_resp_if_rvalid(mem_noc_ddr_cdc_u__cdc2noc_resp_if_rvalid),
  .clk_m(mem_noc_ddr_cdc_u__clk_m),
  .clk_s(mem_noc_ddr_cdc_u__clk_s),
  .ddr2cdc_rsp_if_b(mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_b),
  .ddr2cdc_rsp_if_bready(mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bready),
  .ddr2cdc_rsp_if_bvalid(mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_bvalid),
  .ddr2cdc_rsp_if_r(mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_r),
  .ddr2cdc_rsp_if_rready(mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rready),
  .ddr2cdc_rsp_if_rvalid(mem_noc_ddr_cdc_u__ddr2cdc_rsp_if_rvalid),
  .noc2cdc_req_if_ar(mem_noc_ddr_cdc_u__noc2cdc_req_if_ar),
  .noc2cdc_req_if_arready(mem_noc_ddr_cdc_u__noc2cdc_req_if_arready),
  .noc2cdc_req_if_arvalid(mem_noc_ddr_cdc_u__noc2cdc_req_if_arvalid),
  .noc2cdc_req_if_aw(mem_noc_ddr_cdc_u__noc2cdc_req_if_aw),
  .noc2cdc_req_if_awready(mem_noc_ddr_cdc_u__noc2cdc_req_if_awready),
  .noc2cdc_req_if_awvalid(mem_noc_ddr_cdc_u__noc2cdc_req_if_awvalid),
  .noc2cdc_req_if_w(mem_noc_ddr_cdc_u__noc2cdc_req_if_w),
  .noc2cdc_req_if_wready(mem_noc_ddr_cdc_u__noc2cdc_req_if_wready),
  .noc2cdc_req_if_wvalid(mem_noc_ddr_cdc_u__noc2cdc_req_if_wvalid),
  .rstn_m(mem_noc_ddr_cdc_u__rstn_m),
  .rstn_s(mem_noc_ddr_cdc_u__rstn_s)
);
`endif

rstn_sync mem_noc_rstn_sync_u(
  .clk(mem_noc_rstn_sync_u__clk),
  .rstn_in(mem_noc_rstn_sync_u__rstn_in),
  .rstn_out(mem_noc_rstn_sync_u__rstn_out),
  .scan_en(mem_noc_rstn_sync_u__scan_en),
  .scan_rstn(mem_noc_rstn_sync_u__scan_rstn)
);

mem_noc #(.NUM_MASTERS(5), .NUM_SLAVES(1)) mem_noc_u(
  .clk(mem_noc_u__clk),
  .l2_req_if_ar(mem_noc_u__l2_req_if_ar),
  .l2_req_if_arready(mem_noc_u__l2_req_if_arready),
  .l2_req_if_arvalid(mem_noc_u__l2_req_if_arvalid),
  .l2_req_if_aw(mem_noc_u__l2_req_if_aw),
  .l2_req_if_awready(mem_noc_u__l2_req_if_awready),
  .l2_req_if_awvalid(mem_noc_u__l2_req_if_awvalid),
  .l2_req_if_w(mem_noc_u__l2_req_if_w),
  .l2_req_if_wready(mem_noc_u__l2_req_if_wready),
  .l2_req_if_wvalid(mem_noc_u__l2_req_if_wvalid),
  .l2_resp_if_b(mem_noc_u__l2_resp_if_b),
  .l2_resp_if_bready(mem_noc_u__l2_resp_if_bready),
  .l2_resp_if_bvalid(mem_noc_u__l2_resp_if_bvalid),
  .l2_resp_if_r(mem_noc_u__l2_resp_if_r),
  .l2_resp_if_rready(mem_noc_u__l2_resp_if_rready),
  .l2_resp_if_rvalid(mem_noc_u__l2_resp_if_rvalid),
  .mem_req_if_ar(mem_noc_u__mem_req_if_ar),
  .mem_req_if_arready(mem_noc_u__mem_req_if_arready),
  .mem_req_if_arvalid(mem_noc_u__mem_req_if_arvalid),
  .mem_req_if_aw(mem_noc_u__mem_req_if_aw),
  .mem_req_if_awready(mem_noc_u__mem_req_if_awready),
  .mem_req_if_awvalid(mem_noc_u__mem_req_if_awvalid),
  .mem_req_if_w(mem_noc_u__mem_req_if_w),
  .mem_req_if_wready(mem_noc_u__mem_req_if_wready),
  .mem_req_if_wvalid(mem_noc_u__mem_req_if_wvalid),
  .mem_resp_if_b(mem_noc_u__mem_resp_if_b),
  .mem_resp_if_bready(mem_noc_u__mem_resp_if_bready),
  .mem_resp_if_bvalid(mem_noc_u__mem_resp_if_bvalid),
  .mem_resp_if_r(mem_noc_u__mem_resp_if_r),
  .mem_resp_if_rready(mem_noc_u__mem_resp_if_rready),
  .mem_resp_if_rvalid(mem_noc_u__mem_resp_if_rvalid),
  .rstn(mem_noc_u__rstn)
);









oursring_cdc oursring_cdc_byp2ddr_u(
  .cdc_oursring_master_req_if_ar(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_ar),
  .cdc_oursring_master_req_if_arready(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_arready),
  .cdc_oursring_master_req_if_arvalid(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_arvalid),
  .cdc_oursring_master_req_if_aw(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_aw),
  .cdc_oursring_master_req_if_awready(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_awready),
  .cdc_oursring_master_req_if_awvalid(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_awvalid),
  .cdc_oursring_master_req_if_w(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_w),
  .cdc_oursring_master_req_if_wready(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_wready),
  .cdc_oursring_master_req_if_wvalid(oursring_cdc_byp2ddr_u__cdc_oursring_master_req_if_wvalid),
  .cdc_oursring_slave_rsp_if_b(oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_b),
  .cdc_oursring_slave_rsp_if_bready(oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_bready),
  .cdc_oursring_slave_rsp_if_bvalid(oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_bvalid),
  .cdc_oursring_slave_rsp_if_r(oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_r),
  .cdc_oursring_slave_rsp_if_rready(oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_rready),
  .cdc_oursring_slave_rsp_if_rvalid(oursring_cdc_byp2ddr_u__cdc_oursring_slave_rsp_if_rvalid),
  .master_clk(oursring_cdc_byp2ddr_u__master_clk),
  .master_resetn(oursring_cdc_byp2ddr_u__master_resetn),
  .oursring_cdc_master_rsp_if_b(oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_b),
  .oursring_cdc_master_rsp_if_bready(oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_bready),
  .oursring_cdc_master_rsp_if_bvalid(oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_bvalid),
  .oursring_cdc_master_rsp_if_r(oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_r),
  .oursring_cdc_master_rsp_if_rready(oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_rready),
  .oursring_cdc_master_rsp_if_rvalid(oursring_cdc_byp2ddr_u__oursring_cdc_master_rsp_if_rvalid),
  .oursring_cdc_slave_req_if_ar(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_ar),
  .oursring_cdc_slave_req_if_arready(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_arready),
  .oursring_cdc_slave_req_if_arvalid(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_arvalid),
  .oursring_cdc_slave_req_if_aw(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_aw),
  .oursring_cdc_slave_req_if_awready(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_awready),
  .oursring_cdc_slave_req_if_awvalid(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_awvalid),
  .oursring_cdc_slave_req_if_w(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_w),
  .oursring_cdc_slave_req_if_wready(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_wready),
  .oursring_cdc_slave_req_if_wvalid(oursring_cdc_byp2ddr_u__oursring_cdc_slave_req_if_wvalid),
  .slave_clk(oursring_cdc_byp2ddr_u__slave_clk),
  .slave_resetn(oursring_cdc_byp2ddr_u__slave_resetn)
);

oursring_cdc oursring_cdc_ddr2io_u(
  .cdc_oursring_master_req_if_ar(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_ar),
  .cdc_oursring_master_req_if_arready(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_arready),
  .cdc_oursring_master_req_if_arvalid(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_arvalid),
  .cdc_oursring_master_req_if_aw(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_aw),
  .cdc_oursring_master_req_if_awready(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_awready),
  .cdc_oursring_master_req_if_awvalid(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_awvalid),
  .cdc_oursring_master_req_if_w(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_w),
  .cdc_oursring_master_req_if_wready(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_wready),
  .cdc_oursring_master_req_if_wvalid(oursring_cdc_ddr2io_u__cdc_oursring_master_req_if_wvalid),
  .cdc_oursring_slave_rsp_if_b(oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_b),
  .cdc_oursring_slave_rsp_if_bready(oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_bready),
  .cdc_oursring_slave_rsp_if_bvalid(oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_bvalid),
  .cdc_oursring_slave_rsp_if_r(oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_r),
  .cdc_oursring_slave_rsp_if_rready(oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_rready),
  .cdc_oursring_slave_rsp_if_rvalid(oursring_cdc_ddr2io_u__cdc_oursring_slave_rsp_if_rvalid),
  .master_clk(oursring_cdc_ddr2io_u__master_clk),
  .master_resetn(oursring_cdc_ddr2io_u__master_resetn),
  .oursring_cdc_master_rsp_if_b(oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_b),
  .oursring_cdc_master_rsp_if_bready(oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_bready),
  .oursring_cdc_master_rsp_if_bvalid(oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_bvalid),
  .oursring_cdc_master_rsp_if_r(oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_r),
  .oursring_cdc_master_rsp_if_rready(oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_rready),
  .oursring_cdc_master_rsp_if_rvalid(oursring_cdc_ddr2io_u__oursring_cdc_master_rsp_if_rvalid),
  .oursring_cdc_slave_req_if_ar(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_ar),
  .oursring_cdc_slave_req_if_arready(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_arready),
  .oursring_cdc_slave_req_if_arvalid(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_arvalid),
  .oursring_cdc_slave_req_if_aw(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_aw),
  .oursring_cdc_slave_req_if_awready(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_awready),
  .oursring_cdc_slave_req_if_awvalid(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_awvalid),
  .oursring_cdc_slave_req_if_w(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_w),
  .oursring_cdc_slave_req_if_wready(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_wready),
  .oursring_cdc_slave_req_if_wvalid(oursring_cdc_ddr2io_u__oursring_cdc_slave_req_if_wvalid),
  .slave_clk(oursring_cdc_ddr2io_u__slave_clk),
  .slave_resetn(oursring_cdc_ddr2io_u__slave_resetn)
);

oursring_cdc oursring_cdc_io2byp_u(
  .cdc_oursring_master_req_if_ar(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_ar),
  .cdc_oursring_master_req_if_arready(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_arready),
  .cdc_oursring_master_req_if_arvalid(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_arvalid),
  .cdc_oursring_master_req_if_aw(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_aw),
  .cdc_oursring_master_req_if_awready(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_awready),
  .cdc_oursring_master_req_if_awvalid(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_awvalid),
  .cdc_oursring_master_req_if_w(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_w),
  .cdc_oursring_master_req_if_wready(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_wready),
  .cdc_oursring_master_req_if_wvalid(oursring_cdc_io2byp_u__cdc_oursring_master_req_if_wvalid),
  .cdc_oursring_slave_rsp_if_b(oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_b),
  .cdc_oursring_slave_rsp_if_bready(oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_bready),
  .cdc_oursring_slave_rsp_if_bvalid(oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_bvalid),
  .cdc_oursring_slave_rsp_if_r(oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_r),
  .cdc_oursring_slave_rsp_if_rready(oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_rready),
  .cdc_oursring_slave_rsp_if_rvalid(oursring_cdc_io2byp_u__cdc_oursring_slave_rsp_if_rvalid),
  .master_clk(oursring_cdc_io2byp_u__master_clk),
  .master_resetn(oursring_cdc_io2byp_u__master_resetn),
  .oursring_cdc_master_rsp_if_b(oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_b),
  .oursring_cdc_master_rsp_if_bready(oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_bready),
  .oursring_cdc_master_rsp_if_bvalid(oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_bvalid),
  .oursring_cdc_master_rsp_if_r(oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_r),
  .oursring_cdc_master_rsp_if_rready(oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_rready),
  .oursring_cdc_master_rsp_if_rvalid(oursring_cdc_io2byp_u__oursring_cdc_master_rsp_if_rvalid),
  .oursring_cdc_slave_req_if_ar(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_ar),
  .oursring_cdc_slave_req_if_arready(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_arready),
  .oursring_cdc_slave_req_if_arvalid(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_arvalid),
  .oursring_cdc_slave_req_if_aw(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_aw),
  .oursring_cdc_slave_req_if_awready(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_awready),
  .oursring_cdc_slave_req_if_awvalid(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_awvalid),
  .oursring_cdc_slave_req_if_w(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_w),
  .oursring_cdc_slave_req_if_wready(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_wready),
  .oursring_cdc_slave_req_if_wvalid(oursring_cdc_io2byp_u__oursring_cdc_slave_req_if_wvalid),
  .slave_clk(oursring_cdc_io2byp_u__slave_clk),
  .slave_resetn(oursring_cdc_io2byp_u__slave_resetn)
);

`ifdef IFNDEF_NO_DDR
oursring_ddr_cdc_wrapper oursring_ddr_cdc_u(
  .apb_cdc_prdata(oursring_ddr_cdc_u__apb_cdc_prdata),
  .apb_cdc_pready(oursring_ddr_cdc_u__apb_cdc_pready),
  .apb_cdc_pslverr(oursring_ddr_cdc_u__apb_cdc_pslverr),
  .apb_clk(oursring_ddr_cdc_u__apb_clk),
  .apb_resetn(oursring_ddr_cdc_u__apb_resetn),
  .axi_clk(oursring_ddr_cdc_u__axi_clk),
  .axi_resetn(oursring_ddr_cdc_u__axi_resetn),
  .cdc_apb_paddr(oursring_ddr_cdc_u__cdc_apb_paddr),
  .cdc_apb_penable(oursring_ddr_cdc_u__cdc_apb_penable),
  .cdc_apb_psel_s0(oursring_ddr_cdc_u__cdc_apb_psel_s0),
  .cdc_apb_pwdata(oursring_ddr_cdc_u__cdc_apb_pwdata),
  .cdc_apb_pwrite(oursring_ddr_cdc_u__cdc_apb_pwrite),
  .cdc_oursring_rsp_if_b(oursring_ddr_cdc_u__cdc_oursring_rsp_if_b),
  .cdc_oursring_rsp_if_bready(oursring_ddr_cdc_u__cdc_oursring_rsp_if_bready),
  .cdc_oursring_rsp_if_bvalid(oursring_ddr_cdc_u__cdc_oursring_rsp_if_bvalid),
  .cdc_oursring_rsp_if_r(oursring_ddr_cdc_u__cdc_oursring_rsp_if_r),
  .cdc_oursring_rsp_if_rready(oursring_ddr_cdc_u__cdc_oursring_rsp_if_rready),
  .cdc_oursring_rsp_if_rvalid(oursring_ddr_cdc_u__cdc_oursring_rsp_if_rvalid),
  .oursring_cdc_req_if_ar(oursring_ddr_cdc_u__oursring_cdc_req_if_ar),
  .oursring_cdc_req_if_arready(oursring_ddr_cdc_u__oursring_cdc_req_if_arready),
  .oursring_cdc_req_if_arvalid(oursring_ddr_cdc_u__oursring_cdc_req_if_arvalid),
  .oursring_cdc_req_if_aw(oursring_ddr_cdc_u__oursring_cdc_req_if_aw),
  .oursring_cdc_req_if_awready(oursring_ddr_cdc_u__oursring_cdc_req_if_awready),
  .oursring_cdc_req_if_awvalid(oursring_ddr_cdc_u__oursring_cdc_req_if_awvalid),
  .oursring_cdc_req_if_w(oursring_ddr_cdc_u__oursring_cdc_req_if_w),
  .oursring_cdc_req_if_wready(oursring_ddr_cdc_u__oursring_cdc_req_if_wready),
  .oursring_cdc_req_if_wvalid(oursring_ddr_cdc_u__oursring_cdc_req_if_wvalid)
);
`endif

ric #(.NCORE(5), .NIRQ(35)) plic_u(
  .b2s_intr_src(plic_u__b2s_intr_src),
  .clk(plic_u__clk),
  .external_int(plic_u__external_int),
  .irq_in(plic_u__irq_in),
  .s2b_dbg_en(plic_u__s2b_dbg_en),
  .s2b_intr_core_id(plic_u__s2b_intr_core_id),
  .s2b_intr_en(plic_u__s2b_intr_en)
);

rstn_sync pll_rstn_sync_u(
  .clk(pll_rstn_sync_u__clk),
  .rstn_in(pll_rstn_sync_u__rstn_in),
  .rstn_out(pll_rstn_sync_u__rstn_out),
  .scan_en(pll_rstn_sync_u__scan_en),
  .scan_rstn(pll_rstn_sync_u__scan_rstn)
);

station_pll pll_station_u(
  .clk(pll_station_u__clk),
  .i_req_local_if_ar(pll_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(pll_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(pll_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(pll_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(pll_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(pll_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(pll_station_u__i_req_local_if_w),
  .i_req_local_if_wready(pll_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(pll_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(pll_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(pll_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(pll_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(pll_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(pll_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(pll_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(pll_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(pll_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(pll_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(pll_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(pll_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(pll_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(pll_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(pll_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(pll_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(pll_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(pll_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(pll_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(pll_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(pll_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(pll_station_u__i_resp_ring_if_rvalid),
  .in_mtime(pll_station_u__in_mtime),
  .o_req_local_if_ar(pll_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(pll_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(pll_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(pll_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(pll_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(pll_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(pll_station_u__o_req_local_if_w),
  .o_req_local_if_wready(pll_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(pll_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(pll_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(pll_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(pll_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(pll_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(pll_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(pll_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(pll_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(pll_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(pll_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(pll_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(pll_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(pll_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(pll_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(pll_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(pll_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(pll_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(pll_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(pll_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(pll_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(pll_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(pll_station_u__o_resp_ring_if_rvalid),
  .out_debug_info_enable(pll_station_u__out_debug_info_enable),
  .out_mtime(pll_station_u__out_mtime),
  .out_mtimecmp_vp_0(pll_station_u__out_mtimecmp_vp_0),
  .out_mtimecmp_vp_1(pll_station_u__out_mtimecmp_vp_1),
  .out_mtimecmp_vp_2(pll_station_u__out_mtimecmp_vp_2),
  .out_mtimecmp_vp_3(pll_station_u__out_mtimecmp_vp_3),
  .out_software_int_vp_0_1(pll_station_u__out_software_int_vp_0_1),
  .out_software_int_vp_2_3(pll_station_u__out_software_int_vp_2_3),
  .out_system_cfg(pll_station_u__out_system_cfg),
  .rstn(pll_station_u__rstn),
  .vld_in_mtime(pll_station_u__vld_in_mtime)
);

dft_clk_buf pll_u__clk_anchor_buf(
  .in(pll_u__clk_anchor_buf__in),
  .out(pll_u__clk_anchor_buf__out)
);

rstn_sync rob_rstn_sync_u(
  .clk(rob_rstn_sync_u__clk),
  .rstn_in(rob_rstn_sync_u__rstn_in),
  .rstn_out(rob_rstn_sync_u__rstn_out),
  .scan_en(rob_rstn_sync_u__scan_en),
  .scan_rstn(rob_rstn_sync_u__scan_rstn)
);

usb_rob rob_u(
  .clk(rob_u__clk),
  .entry_vld_pbank(rob_u__entry_vld_pbank),
  .io_rob_req_if_req(rob_u__io_rob_req_if_req),
  .io_rob_req_if_req_ready(rob_u__io_rob_req_if_req_ready),
  .io_rob_req_if_req_valid(rob_u__io_rob_req_if_req_valid),
  .is_oldest_pbank(rob_u__is_oldest_pbank),
  .noc_rob_resp_if_resp(rob_u__noc_rob_resp_if_resp),
  .noc_rob_resp_if_resp_ready(rob_u__noc_rob_resp_if_resp_ready),
  .noc_rob_resp_if_resp_valid(rob_u__noc_rob_resp_if_resp_valid),
  .rob_io_resp_if_resp(rob_u__rob_io_resp_if_resp),
  .rob_io_resp_if_resp_ready(rob_u__rob_io_resp_if_resp_ready),
  .rob_io_resp_if_resp_valid(rob_u__rob_io_resp_if_resp_valid),
  .rob_noc_req_if_req(rob_u__rob_noc_req_if_req),
  .rob_noc_req_if_req_ready(rob_u__rob_noc_req_if_req_ready),
  .rob_noc_req_if_req_valid(rob_u__rob_noc_req_if_req_valid),
  .rstn(rob_u__rstn)
);

icg_rstn sdio_pllclk_icg_u(
  .clk(sdio_pllclk_icg_u__clk),
  .clkg(sdio_pllclk_icg_u__clkg),
  .en(sdio_pllclk_icg_u__en),
  .rstn(sdio_pllclk_icg_u__rstn),
  .tst_en(sdio_pllclk_icg_u__tst_en)
);

rstn_sync sdio_rstn_sync_u(
  .clk(sdio_rstn_sync_u__clk),
  .rstn_in(sdio_rstn_sync_u__rstn_in),
  .rstn_out(sdio_rstn_sync_u__rstn_out),
  .scan_en(sdio_rstn_sync_u__scan_en),
  .scan_rstn(sdio_rstn_sync_u__scan_rstn)
);

station_sdio sdio_station_u(
  .clk(sdio_station_u__clk),
  .i_req_local_if_ar(sdio_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(sdio_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(sdio_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(sdio_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(sdio_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(sdio_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(sdio_station_u__i_req_local_if_w),
  .i_req_local_if_wready(sdio_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(sdio_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(sdio_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(sdio_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(sdio_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(sdio_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(sdio_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(sdio_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(sdio_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(sdio_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(sdio_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(sdio_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(sdio_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(sdio_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(sdio_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(sdio_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(sdio_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(sdio_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(sdio_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(sdio_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(sdio_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(sdio_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(sdio_station_u__i_resp_ring_if_rvalid),
  .in_b2s_card_clk_freq_sel(sdio_station_u__in_b2s_card_clk_freq_sel),
  .in_b2s_card_clk_gen_sel(sdio_station_u__in_b2s_card_clk_gen_sel),
  .in_b2s_led_control(sdio_station_u__in_b2s_led_control),
  .in_b2s_sd_datxfer_width(sdio_station_u__in_b2s_sd_datxfer_width),
  .in_b2s_sd_vdd1_on(sdio_station_u__in_b2s_sd_vdd1_on),
  .in_b2s_sd_vdd1_sel(sdio_station_u__in_b2s_sd_vdd1_sel),
  .in_b2s_sd_vdd2_on(sdio_station_u__in_b2s_sd_vdd2_on),
  .in_b2s_sd_vdd2_sel(sdio_station_u__in_b2s_sd_vdd2_sel),
  .o_req_local_if_ar(sdio_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(sdio_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(sdio_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(sdio_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(sdio_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(sdio_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(sdio_station_u__o_req_local_if_w),
  .o_req_local_if_wready(sdio_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(sdio_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(sdio_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(sdio_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(sdio_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(sdio_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(sdio_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(sdio_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(sdio_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(sdio_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(sdio_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(sdio_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(sdio_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(sdio_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(sdio_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(sdio_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(sdio_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(sdio_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(sdio_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(sdio_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(sdio_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(sdio_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(sdio_station_u__o_resp_ring_if_rvalid),
  .out_b2s_card_clk_freq_sel(sdio_station_u__out_b2s_card_clk_freq_sel),
  .out_b2s_card_clk_gen_sel(sdio_station_u__out_b2s_card_clk_gen_sel),
  .out_b2s_led_control(sdio_station_u__out_b2s_led_control),
  .out_b2s_sd_datxfer_width(sdio_station_u__out_b2s_sd_datxfer_width),
  .out_b2s_sd_vdd1_on(sdio_station_u__out_b2s_sd_vdd1_on),
  .out_b2s_sd_vdd1_sel(sdio_station_u__out_b2s_sd_vdd1_sel),
  .out_b2s_sd_vdd2_on(sdio_station_u__out_b2s_sd_vdd2_on),
  .out_b2s_sd_vdd2_sel(sdio_station_u__out_b2s_sd_vdd2_sel),
  .out_debug_info_enable(sdio_station_u__out_debug_info_enable),
  .out_s2b_host_reg_vol_stable(sdio_station_u__out_s2b_host_reg_vol_stable),
  .out_s2b_icg_en(sdio_station_u__out_s2b_icg_en),
  .out_s2b_int_aclk_stable(sdio_station_u__out_s2b_int_aclk_stable),
  .out_s2b_int_bclk_stable(sdio_station_u__out_s2b_int_bclk_stable),
  .out_s2b_resetn(sdio_station_u__out_s2b_resetn),
  .out_s2b_sd(sdio_station_u__out_s2b_sd),
  .out_s2b_slp(sdio_station_u__out_s2b_slp),
  .out_s2b_test_io_clkdiv_half_div_less_1(sdio_station_u__out_s2b_test_io_clkdiv_half_div_less_1),
  .out_s2b_test_io_pllclk_en(sdio_station_u__out_s2b_test_io_pllclk_en),
  .out_s2icg_pllclk_en(sdio_station_u__out_s2icg_pllclk_en),
  .rstn(sdio_station_u__rstn),
  .vld_in_b2s_card_clk_freq_sel(sdio_station_u__vld_in_b2s_card_clk_freq_sel),
  .vld_in_b2s_card_clk_gen_sel(sdio_station_u__vld_in_b2s_card_clk_gen_sel),
  .vld_in_b2s_led_control(sdio_station_u__vld_in_b2s_led_control),
  .vld_in_b2s_sd_datxfer_width(sdio_station_u__vld_in_b2s_sd_datxfer_width),
  .vld_in_b2s_sd_vdd1_on(sdio_station_u__vld_in_b2s_sd_vdd1_on),
  .vld_in_b2s_sd_vdd1_sel(sdio_station_u__vld_in_b2s_sd_vdd1_sel),
  .vld_in_b2s_sd_vdd2_on(sdio_station_u__vld_in_b2s_sd_vdd2_on),
  .vld_in_b2s_sd_vdd2_sel(sdio_station_u__vld_in_b2s_sd_vdd2_sel)
);



clk_div_cfg #(.MAX_DIV(16), .WITH_CLK_MUX(1)) slow_io_clk_div_u(
  .dft_en(slow_io_clk_div_u__dft_en),
  .divclk(slow_io_clk_div_u__divclk),
  .divclk_sel(slow_io_clk_div_u__divclk_sel),
  .half_div_less_1(slow_io_clk_div_u__half_div_less_1),
  .refclk(slow_io_clk_div_u__refclk)
);

oursring_1_to_many_noc #(.ADDR_CHUNK(STATION_SLOW_IO_FLASH_OFFSET)) slow_io_local_1_to_2_u(
  .clk(slow_io_local_1_to_2_u__clk),
  .i_or_req_if_ar(slow_io_local_1_to_2_u__i_or_req_if_ar),
  .i_or_req_if_arready(slow_io_local_1_to_2_u__i_or_req_if_arready),
  .i_or_req_if_arvalid(slow_io_local_1_to_2_u__i_or_req_if_arvalid),
  .i_or_req_if_aw(slow_io_local_1_to_2_u__i_or_req_if_aw),
  .i_or_req_if_awready(slow_io_local_1_to_2_u__i_or_req_if_awready),
  .i_or_req_if_awvalid(slow_io_local_1_to_2_u__i_or_req_if_awvalid),
  .i_or_req_if_w(slow_io_local_1_to_2_u__i_or_req_if_w),
  .i_or_req_if_wready(slow_io_local_1_to_2_u__i_or_req_if_wready),
  .i_or_req_if_wvalid(slow_io_local_1_to_2_u__i_or_req_if_wvalid),
  .i_or_rsp_if_b(slow_io_local_1_to_2_u__i_or_rsp_if_b),
  .i_or_rsp_if_bready(slow_io_local_1_to_2_u__i_or_rsp_if_bready),
  .i_or_rsp_if_bvalid(slow_io_local_1_to_2_u__i_or_rsp_if_bvalid),
  .i_or_rsp_if_r(slow_io_local_1_to_2_u__i_or_rsp_if_r),
  .i_or_rsp_if_rready(slow_io_local_1_to_2_u__i_or_rsp_if_rready),
  .i_or_rsp_if_rvalid(slow_io_local_1_to_2_u__i_or_rsp_if_rvalid),
  .o_or_req_if_ar(slow_io_local_1_to_2_u__o_or_req_if_ar),
  .o_or_req_if_arready(slow_io_local_1_to_2_u__o_or_req_if_arready),
  .o_or_req_if_arvalid(slow_io_local_1_to_2_u__o_or_req_if_arvalid),
  .o_or_req_if_aw(slow_io_local_1_to_2_u__o_or_req_if_aw),
  .o_or_req_if_awready(slow_io_local_1_to_2_u__o_or_req_if_awready),
  .o_or_req_if_awvalid(slow_io_local_1_to_2_u__o_or_req_if_awvalid),
  .o_or_req_if_w(slow_io_local_1_to_2_u__o_or_req_if_w),
  .o_or_req_if_wready(slow_io_local_1_to_2_u__o_or_req_if_wready),
  .o_or_req_if_wvalid(slow_io_local_1_to_2_u__o_or_req_if_wvalid),
  .o_or_rsp_if_b(slow_io_local_1_to_2_u__o_or_rsp_if_b),
  .o_or_rsp_if_bready(slow_io_local_1_to_2_u__o_or_rsp_if_bready),
  .o_or_rsp_if_bvalid(slow_io_local_1_to_2_u__o_or_rsp_if_bvalid),
  .o_or_rsp_if_r(slow_io_local_1_to_2_u__o_or_rsp_if_r),
  .o_or_rsp_if_rready(slow_io_local_1_to_2_u__o_or_rsp_if_rready),
  .o_or_rsp_if_rvalid(slow_io_local_1_to_2_u__o_or_rsp_if_rvalid),
  .rstn(slow_io_local_1_to_2_u__rstn)
);

oursring_many_to_1_noc slow_io_local_2_to_1_u(
  .clk(slow_io_local_2_to_1_u__clk),
  .i_or_req_if_ar(slow_io_local_2_to_1_u__i_or_req_if_ar),
  .i_or_req_if_arready(slow_io_local_2_to_1_u__i_or_req_if_arready),
  .i_or_req_if_arvalid(slow_io_local_2_to_1_u__i_or_req_if_arvalid),
  .i_or_req_if_aw(slow_io_local_2_to_1_u__i_or_req_if_aw),
  .i_or_req_if_awready(slow_io_local_2_to_1_u__i_or_req_if_awready),
  .i_or_req_if_awvalid(slow_io_local_2_to_1_u__i_or_req_if_awvalid),
  .i_or_req_if_w(slow_io_local_2_to_1_u__i_or_req_if_w),
  .i_or_req_if_wready(slow_io_local_2_to_1_u__i_or_req_if_wready),
  .i_or_req_if_wvalid(slow_io_local_2_to_1_u__i_or_req_if_wvalid),
  .i_or_rsp_if_b(slow_io_local_2_to_1_u__i_or_rsp_if_b),
  .i_or_rsp_if_bready(slow_io_local_2_to_1_u__i_or_rsp_if_bready),
  .i_or_rsp_if_bvalid(slow_io_local_2_to_1_u__i_or_rsp_if_bvalid),
  .i_or_rsp_if_r(slow_io_local_2_to_1_u__i_or_rsp_if_r),
  .i_or_rsp_if_rready(slow_io_local_2_to_1_u__i_or_rsp_if_rready),
  .i_or_rsp_if_rvalid(slow_io_local_2_to_1_u__i_or_rsp_if_rvalid),
  .o_or_req_if_ar(slow_io_local_2_to_1_u__o_or_req_if_ar),
  .o_or_req_if_arready(slow_io_local_2_to_1_u__o_or_req_if_arready),
  .o_or_req_if_arvalid(slow_io_local_2_to_1_u__o_or_req_if_arvalid),
  .o_or_req_if_aw(slow_io_local_2_to_1_u__o_or_req_if_aw),
  .o_or_req_if_awready(slow_io_local_2_to_1_u__o_or_req_if_awready),
  .o_or_req_if_awvalid(slow_io_local_2_to_1_u__o_or_req_if_awvalid),
  .o_or_req_if_w(slow_io_local_2_to_1_u__o_or_req_if_w),
  .o_or_req_if_wready(slow_io_local_2_to_1_u__o_or_req_if_wready),
  .o_or_req_if_wvalid(slow_io_local_2_to_1_u__o_or_req_if_wvalid),
  .o_or_rsp_if_b(slow_io_local_2_to_1_u__o_or_rsp_if_b),
  .o_or_rsp_if_bready(slow_io_local_2_to_1_u__o_or_rsp_if_bready),
  .o_or_rsp_if_bvalid(slow_io_local_2_to_1_u__o_or_rsp_if_bvalid),
  .o_or_rsp_if_r(slow_io_local_2_to_1_u__o_or_rsp_if_r),
  .o_or_rsp_if_rready(slow_io_local_2_to_1_u__o_or_rsp_if_rready),
  .o_or_rsp_if_rvalid(slow_io_local_2_to_1_u__o_or_rsp_if_rvalid),
  .rstn(slow_io_local_2_to_1_u__rstn)
);

rstn_sync slow_io_rstn_sync_u(
  .clk(slow_io_rstn_sync_u__clk),
  .rstn_in(slow_io_rstn_sync_u__rstn_in),
  .rstn_out(slow_io_rstn_sync_u__rstn_out),
  .scan_en(slow_io_rstn_sync_u__scan_en),
  .scan_rstn(slow_io_rstn_sync_u__scan_rstn)
);

station_slow_io slow_io_station_u(
  .clk(slow_io_station_u__clk),
  .i_req_local_if_ar(slow_io_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(slow_io_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(slow_io_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(slow_io_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(slow_io_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(slow_io_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(slow_io_station_u__i_req_local_if_w),
  .i_req_local_if_wready(slow_io_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(slow_io_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(slow_io_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(slow_io_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(slow_io_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(slow_io_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(slow_io_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(slow_io_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(slow_io_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(slow_io_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(slow_io_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(slow_io_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(slow_io_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(slow_io_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(slow_io_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(slow_io_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(slow_io_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(slow_io_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(slow_io_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(slow_io_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(slow_io_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(slow_io_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(slow_io_station_u__i_resp_ring_if_rvalid),
  .in_b2s_i2c0_debug_addr(slow_io_station_u__in_b2s_i2c0_debug_addr),
  .in_b2s_i2c0_debug_addr_10bit(slow_io_station_u__in_b2s_i2c0_debug_addr_10bit),
  .in_b2s_i2c0_debug_data(slow_io_station_u__in_b2s_i2c0_debug_data),
  .in_b2s_i2c0_debug_hs(slow_io_station_u__in_b2s_i2c0_debug_hs),
  .in_b2s_i2c0_debug_master_act(slow_io_station_u__in_b2s_i2c0_debug_master_act),
  .in_b2s_i2c0_debug_mst_cstate(slow_io_station_u__in_b2s_i2c0_debug_mst_cstate),
  .in_b2s_i2c0_debug_p_gen(slow_io_station_u__in_b2s_i2c0_debug_p_gen),
  .in_b2s_i2c0_debug_rd(slow_io_station_u__in_b2s_i2c0_debug_rd),
  .in_b2s_i2c0_debug_s_gen(slow_io_station_u__in_b2s_i2c0_debug_s_gen),
  .in_b2s_i2c0_debug_slave_act(slow_io_station_u__in_b2s_i2c0_debug_slave_act),
  .in_b2s_i2c0_debug_slv_cstate(slow_io_station_u__in_b2s_i2c0_debug_slv_cstate),
  .in_b2s_i2c0_debug_wr(slow_io_station_u__in_b2s_i2c0_debug_wr),
  .in_b2s_i2c1_debug_addr(slow_io_station_u__in_b2s_i2c1_debug_addr),
  .in_b2s_i2c1_debug_addr_10bit(slow_io_station_u__in_b2s_i2c1_debug_addr_10bit),
  .in_b2s_i2c1_debug_data(slow_io_station_u__in_b2s_i2c1_debug_data),
  .in_b2s_i2c1_debug_hs(slow_io_station_u__in_b2s_i2c1_debug_hs),
  .in_b2s_i2c1_debug_master_act(slow_io_station_u__in_b2s_i2c1_debug_master_act),
  .in_b2s_i2c1_debug_mst_cstate(slow_io_station_u__in_b2s_i2c1_debug_mst_cstate),
  .in_b2s_i2c1_debug_p_gen(slow_io_station_u__in_b2s_i2c1_debug_p_gen),
  .in_b2s_i2c1_debug_rd(slow_io_station_u__in_b2s_i2c1_debug_rd),
  .in_b2s_i2c1_debug_s_gen(slow_io_station_u__in_b2s_i2c1_debug_s_gen),
  .in_b2s_i2c1_debug_slave_act(slow_io_station_u__in_b2s_i2c1_debug_slave_act),
  .in_b2s_i2c1_debug_slv_cstate(slow_io_station_u__in_b2s_i2c1_debug_slv_cstate),
  .in_b2s_i2c1_debug_wr(slow_io_station_u__in_b2s_i2c1_debug_wr),
  .in_b2s_i2c2_debug_addr(slow_io_station_u__in_b2s_i2c2_debug_addr),
  .in_b2s_i2c2_debug_addr_10bit(slow_io_station_u__in_b2s_i2c2_debug_addr_10bit),
  .in_b2s_i2c2_debug_data(slow_io_station_u__in_b2s_i2c2_debug_data),
  .in_b2s_i2c2_debug_hs(slow_io_station_u__in_b2s_i2c2_debug_hs),
  .in_b2s_i2c2_debug_master_act(slow_io_station_u__in_b2s_i2c2_debug_master_act),
  .in_b2s_i2c2_debug_mst_cstate(slow_io_station_u__in_b2s_i2c2_debug_mst_cstate),
  .in_b2s_i2c2_debug_p_gen(slow_io_station_u__in_b2s_i2c2_debug_p_gen),
  .in_b2s_i2c2_debug_rd(slow_io_station_u__in_b2s_i2c2_debug_rd),
  .in_b2s_i2c2_debug_s_gen(slow_io_station_u__in_b2s_i2c2_debug_s_gen),
  .in_b2s_i2c2_debug_slave_act(slow_io_station_u__in_b2s_i2c2_debug_slave_act),
  .in_b2s_i2c2_debug_slv_cstate(slow_io_station_u__in_b2s_i2c2_debug_slv_cstate),
  .in_b2s_i2c2_debug_wr(slow_io_station_u__in_b2s_i2c2_debug_wr),
  .in_b2s_qspim_ssi_busy(slow_io_station_u__in_b2s_qspim_ssi_busy),
  .in_b2s_qspim_ssi_sleep(slow_io_station_u__in_b2s_qspim_ssi_sleep),
  .in_b2s_rtc_en(slow_io_station_u__in_b2s_rtc_en),
  .in_b2s_spis_ssi_sleep(slow_io_station_u__in_b2s_spis_ssi_sleep),
  .in_b2s_sspim0_ssi_sleep(slow_io_station_u__in_b2s_sspim0_ssi_sleep),
  .in_b2s_sspim1_ssi_sleep(slow_io_station_u__in_b2s_sspim1_ssi_sleep),
  .in_b2s_sspim2_ssi_sleep(slow_io_station_u__in_b2s_sspim2_ssi_sleep),
  .in_b2s_timer_en(slow_io_station_u__in_b2s_timer_en),
  .o_req_local_if_ar(slow_io_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(slow_io_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(slow_io_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(slow_io_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(slow_io_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(slow_io_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(slow_io_station_u__o_req_local_if_w),
  .o_req_local_if_wready(slow_io_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(slow_io_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(slow_io_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(slow_io_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(slow_io_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(slow_io_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(slow_io_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(slow_io_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(slow_io_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(slow_io_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(slow_io_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(slow_io_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(slow_io_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(slow_io_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(slow_io_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(slow_io_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(slow_io_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(slow_io_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(slow_io_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(slow_io_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(slow_io_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(slow_io_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(slow_io_station_u__o_resp_ring_if_rvalid),
  .out_SSP_SHARED_sel_0(slow_io_station_u__out_SSP_SHARED_sel_0),
  .out_SSP_SHARED_sel_1(slow_io_station_u__out_SSP_SHARED_sel_1),
  .out_SSP_SHARED_sel_10(slow_io_station_u__out_SSP_SHARED_sel_10),
  .out_SSP_SHARED_sel_11(slow_io_station_u__out_SSP_SHARED_sel_11),
  .out_SSP_SHARED_sel_12(slow_io_station_u__out_SSP_SHARED_sel_12),
  .out_SSP_SHARED_sel_13(slow_io_station_u__out_SSP_SHARED_sel_13),
  .out_SSP_SHARED_sel_14(slow_io_station_u__out_SSP_SHARED_sel_14),
  .out_SSP_SHARED_sel_15(slow_io_station_u__out_SSP_SHARED_sel_15),
  .out_SSP_SHARED_sel_16(slow_io_station_u__out_SSP_SHARED_sel_16),
  .out_SSP_SHARED_sel_17(slow_io_station_u__out_SSP_SHARED_sel_17),
  .out_SSP_SHARED_sel_18(slow_io_station_u__out_SSP_SHARED_sel_18),
  .out_SSP_SHARED_sel_19(slow_io_station_u__out_SSP_SHARED_sel_19),
  .out_SSP_SHARED_sel_2(slow_io_station_u__out_SSP_SHARED_sel_2),
  .out_SSP_SHARED_sel_20(slow_io_station_u__out_SSP_SHARED_sel_20),
  .out_SSP_SHARED_sel_21(slow_io_station_u__out_SSP_SHARED_sel_21),
  .out_SSP_SHARED_sel_22(slow_io_station_u__out_SSP_SHARED_sel_22),
  .out_SSP_SHARED_sel_23(slow_io_station_u__out_SSP_SHARED_sel_23),
  .out_SSP_SHARED_sel_24(slow_io_station_u__out_SSP_SHARED_sel_24),
  .out_SSP_SHARED_sel_25(slow_io_station_u__out_SSP_SHARED_sel_25),
  .out_SSP_SHARED_sel_26(slow_io_station_u__out_SSP_SHARED_sel_26),
  .out_SSP_SHARED_sel_27(slow_io_station_u__out_SSP_SHARED_sel_27),
  .out_SSP_SHARED_sel_28(slow_io_station_u__out_SSP_SHARED_sel_28),
  .out_SSP_SHARED_sel_29(slow_io_station_u__out_SSP_SHARED_sel_29),
  .out_SSP_SHARED_sel_3(slow_io_station_u__out_SSP_SHARED_sel_3),
  .out_SSP_SHARED_sel_30(slow_io_station_u__out_SSP_SHARED_sel_30),
  .out_SSP_SHARED_sel_31(slow_io_station_u__out_SSP_SHARED_sel_31),
  .out_SSP_SHARED_sel_32(slow_io_station_u__out_SSP_SHARED_sel_32),
  .out_SSP_SHARED_sel_33(slow_io_station_u__out_SSP_SHARED_sel_33),
  .out_SSP_SHARED_sel_34(slow_io_station_u__out_SSP_SHARED_sel_34),
  .out_SSP_SHARED_sel_35(slow_io_station_u__out_SSP_SHARED_sel_35),
  .out_SSP_SHARED_sel_36(slow_io_station_u__out_SSP_SHARED_sel_36),
  .out_SSP_SHARED_sel_37(slow_io_station_u__out_SSP_SHARED_sel_37),
  .out_SSP_SHARED_sel_38(slow_io_station_u__out_SSP_SHARED_sel_38),
  .out_SSP_SHARED_sel_39(slow_io_station_u__out_SSP_SHARED_sel_39),
  .out_SSP_SHARED_sel_4(slow_io_station_u__out_SSP_SHARED_sel_4),
  .out_SSP_SHARED_sel_40(slow_io_station_u__out_SSP_SHARED_sel_40),
  .out_SSP_SHARED_sel_41(slow_io_station_u__out_SSP_SHARED_sel_41),
  .out_SSP_SHARED_sel_42(slow_io_station_u__out_SSP_SHARED_sel_42),
  .out_SSP_SHARED_sel_43(slow_io_station_u__out_SSP_SHARED_sel_43),
  .out_SSP_SHARED_sel_44(slow_io_station_u__out_SSP_SHARED_sel_44),
  .out_SSP_SHARED_sel_45(slow_io_station_u__out_SSP_SHARED_sel_45),
  .out_SSP_SHARED_sel_46(slow_io_station_u__out_SSP_SHARED_sel_46),
  .out_SSP_SHARED_sel_47(slow_io_station_u__out_SSP_SHARED_sel_47),
  .out_SSP_SHARED_sel_5(slow_io_station_u__out_SSP_SHARED_sel_5),
  .out_SSP_SHARED_sel_6(slow_io_station_u__out_SSP_SHARED_sel_6),
  .out_SSP_SHARED_sel_7(slow_io_station_u__out_SSP_SHARED_sel_7),
  .out_SSP_SHARED_sel_8(slow_io_station_u__out_SSP_SHARED_sel_8),
  .out_SSP_SHARED_sel_9(slow_io_station_u__out_SSP_SHARED_sel_9),
  .out_b2s_i2c0_debug_addr(slow_io_station_u__out_b2s_i2c0_debug_addr),
  .out_b2s_i2c0_debug_addr_10bit(slow_io_station_u__out_b2s_i2c0_debug_addr_10bit),
  .out_b2s_i2c0_debug_data(slow_io_station_u__out_b2s_i2c0_debug_data),
  .out_b2s_i2c0_debug_hs(slow_io_station_u__out_b2s_i2c0_debug_hs),
  .out_b2s_i2c0_debug_master_act(slow_io_station_u__out_b2s_i2c0_debug_master_act),
  .out_b2s_i2c0_debug_mst_cstate(slow_io_station_u__out_b2s_i2c0_debug_mst_cstate),
  .out_b2s_i2c0_debug_p_gen(slow_io_station_u__out_b2s_i2c0_debug_p_gen),
  .out_b2s_i2c0_debug_rd(slow_io_station_u__out_b2s_i2c0_debug_rd),
  .out_b2s_i2c0_debug_s_gen(slow_io_station_u__out_b2s_i2c0_debug_s_gen),
  .out_b2s_i2c0_debug_slave_act(slow_io_station_u__out_b2s_i2c0_debug_slave_act),
  .out_b2s_i2c0_debug_slv_cstate(slow_io_station_u__out_b2s_i2c0_debug_slv_cstate),
  .out_b2s_i2c0_debug_wr(slow_io_station_u__out_b2s_i2c0_debug_wr),
  .out_b2s_i2c1_debug_addr(slow_io_station_u__out_b2s_i2c1_debug_addr),
  .out_b2s_i2c1_debug_addr_10bit(slow_io_station_u__out_b2s_i2c1_debug_addr_10bit),
  .out_b2s_i2c1_debug_data(slow_io_station_u__out_b2s_i2c1_debug_data),
  .out_b2s_i2c1_debug_hs(slow_io_station_u__out_b2s_i2c1_debug_hs),
  .out_b2s_i2c1_debug_master_act(slow_io_station_u__out_b2s_i2c1_debug_master_act),
  .out_b2s_i2c1_debug_mst_cstate(slow_io_station_u__out_b2s_i2c1_debug_mst_cstate),
  .out_b2s_i2c1_debug_p_gen(slow_io_station_u__out_b2s_i2c1_debug_p_gen),
  .out_b2s_i2c1_debug_rd(slow_io_station_u__out_b2s_i2c1_debug_rd),
  .out_b2s_i2c1_debug_s_gen(slow_io_station_u__out_b2s_i2c1_debug_s_gen),
  .out_b2s_i2c1_debug_slave_act(slow_io_station_u__out_b2s_i2c1_debug_slave_act),
  .out_b2s_i2c1_debug_slv_cstate(slow_io_station_u__out_b2s_i2c1_debug_slv_cstate),
  .out_b2s_i2c1_debug_wr(slow_io_station_u__out_b2s_i2c1_debug_wr),
  .out_b2s_i2c2_debug_addr(slow_io_station_u__out_b2s_i2c2_debug_addr),
  .out_b2s_i2c2_debug_addr_10bit(slow_io_station_u__out_b2s_i2c2_debug_addr_10bit),
  .out_b2s_i2c2_debug_data(slow_io_station_u__out_b2s_i2c2_debug_data),
  .out_b2s_i2c2_debug_hs(slow_io_station_u__out_b2s_i2c2_debug_hs),
  .out_b2s_i2c2_debug_master_act(slow_io_station_u__out_b2s_i2c2_debug_master_act),
  .out_b2s_i2c2_debug_mst_cstate(slow_io_station_u__out_b2s_i2c2_debug_mst_cstate),
  .out_b2s_i2c2_debug_p_gen(slow_io_station_u__out_b2s_i2c2_debug_p_gen),
  .out_b2s_i2c2_debug_rd(slow_io_station_u__out_b2s_i2c2_debug_rd),
  .out_b2s_i2c2_debug_s_gen(slow_io_station_u__out_b2s_i2c2_debug_s_gen),
  .out_b2s_i2c2_debug_slave_act(slow_io_station_u__out_b2s_i2c2_debug_slave_act),
  .out_b2s_i2c2_debug_slv_cstate(slow_io_station_u__out_b2s_i2c2_debug_slv_cstate),
  .out_b2s_i2c2_debug_wr(slow_io_station_u__out_b2s_i2c2_debug_wr),
  .out_b2s_qspim_ssi_busy(slow_io_station_u__out_b2s_qspim_ssi_busy),
  .out_b2s_qspim_ssi_sleep(slow_io_station_u__out_b2s_qspim_ssi_sleep),
  .out_b2s_rtc_en(slow_io_station_u__out_b2s_rtc_en),
  .out_b2s_spis_ssi_sleep(slow_io_station_u__out_b2s_spis_ssi_sleep),
  .out_b2s_sspim0_ssi_sleep(slow_io_station_u__out_b2s_sspim0_ssi_sleep),
  .out_b2s_sspim1_ssi_sleep(slow_io_station_u__out_b2s_sspim1_ssi_sleep),
  .out_b2s_sspim2_ssi_sleep(slow_io_station_u__out_b2s_sspim2_ssi_sleep),
  .out_b2s_timer_en(slow_io_station_u__out_b2s_timer_en),
  .out_debug_info_enable(slow_io_station_u__out_debug_info_enable),
  .out_s2b_boot_from_flash_ena(slow_io_station_u__out_s2b_boot_from_flash_ena),
  .out_s2b_boot_from_flash_ena_sw_ctrl(slow_io_station_u__out_s2b_boot_from_flash_ena_sw_ctrl),
  .out_s2b_bootup_ena(slow_io_station_u__out_s2b_bootup_ena),
  .out_s2b_bootup_ena_sw_ctrl(slow_io_station_u__out_s2b_bootup_ena_sw_ctrl),
  .out_s2b_gpio_clk_en(slow_io_station_u__out_s2b_gpio_clk_en),
  .out_s2b_i2c0_clk_en(slow_io_station_u__out_s2b_i2c0_clk_en),
  .out_s2b_i2c1_clk_en(slow_io_station_u__out_s2b_i2c1_clk_en),
  .out_s2b_i2c2_clk_en(slow_io_station_u__out_s2b_i2c2_clk_en),
  .out_s2b_i2sm_clkdiv_divclk_sel(slow_io_station_u__out_s2b_i2sm_clkdiv_divclk_sel),
  .out_s2b_i2sm_clkdiv_half_div_less_1(slow_io_station_u__out_s2b_i2sm_clkdiv_half_div_less_1),
  .out_s2b_i2ss0_clkdiv_divclk_sel(slow_io_station_u__out_s2b_i2ss0_clkdiv_divclk_sel),
  .out_s2b_i2ss0_clkdiv_half_div_less_1(slow_io_station_u__out_s2b_i2ss0_clkdiv_half_div_less_1),
  .out_s2b_i2ss1_clkdiv_divclk_sel(slow_io_station_u__out_s2b_i2ss1_clkdiv_divclk_sel),
  .out_s2b_i2ss1_clkdiv_half_div_less_1(slow_io_station_u__out_s2b_i2ss1_clkdiv_half_div_less_1),
  .out_s2b_i2ss2_clkdiv_divclk_sel(slow_io_station_u__out_s2b_i2ss2_clkdiv_divclk_sel),
  .out_s2b_i2ss2_clkdiv_half_div_less_1(slow_io_station_u__out_s2b_i2ss2_clkdiv_half_div_less_1),
  .out_s2b_i2ss3_clkdiv_divclk_sel(slow_io_station_u__out_s2b_i2ss3_clkdiv_divclk_sel),
  .out_s2b_i2ss3_clkdiv_half_div_less_1(slow_io_station_u__out_s2b_i2ss3_clkdiv_half_div_less_1),
  .out_s2b_i2ss4_clkdiv_divclk_sel(slow_io_station_u__out_s2b_i2ss4_clkdiv_divclk_sel),
  .out_s2b_i2ss4_clkdiv_half_div_less_1(slow_io_station_u__out_s2b_i2ss4_clkdiv_half_div_less_1),
  .out_s2b_i2ss5_clkdiv_divclk_sel(slow_io_station_u__out_s2b_i2ss5_clkdiv_divclk_sel),
  .out_s2b_i2ss5_clkdiv_half_div_less_1(slow_io_station_u__out_s2b_i2ss5_clkdiv_half_div_less_1),
  .out_s2b_qspim_ssi_clk_en(slow_io_station_u__out_s2b_qspim_ssi_clk_en),
  .out_s2b_rtc_clk_en(slow_io_station_u__out_s2b_rtc_clk_en),
  .out_s2b_sspim0_ssi_clk_en(slow_io_station_u__out_s2b_sspim0_ssi_clk_en),
  .out_s2b_sspim1_ssi_clk_en(slow_io_station_u__out_s2b_sspim1_ssi_clk_en),
  .out_s2b_sspim2_ssi_clk_en(slow_io_station_u__out_s2b_sspim2_ssi_clk_en),
  .out_s2b_timers_1_resetn(slow_io_station_u__out_s2b_timers_1_resetn),
  .out_s2b_timers_2_resetn(slow_io_station_u__out_s2b_timers_2_resetn),
  .out_s2b_timers_3_resetn(slow_io_station_u__out_s2b_timers_3_resetn),
  .out_s2b_timers_4_resetn(slow_io_station_u__out_s2b_timers_4_resetn),
  .out_s2b_timers_5_resetn(slow_io_station_u__out_s2b_timers_5_resetn),
  .out_s2b_timers_6_resetn(slow_io_station_u__out_s2b_timers_6_resetn),
  .out_s2b_timers_7_resetn(slow_io_station_u__out_s2b_timers_7_resetn),
  .out_s2b_timers_8_resetn(slow_io_station_u__out_s2b_timers_8_resetn),
  .out_s2b_wdt_clk_en(slow_io_station_u__out_s2b_wdt_clk_en),
  .out_s2b_wdt_pause(slow_io_station_u__out_s2b_wdt_pause),
  .out_s2b_wdt_speed_up(slow_io_station_u__out_s2b_wdt_speed_up),
  .out_s2icg_gpio_pclk_en(slow_io_station_u__out_s2icg_gpio_pclk_en),
  .out_s2icg_i2c0_pclk_en(slow_io_station_u__out_s2icg_i2c0_pclk_en),
  .out_s2icg_i2c1_pclk_en(slow_io_station_u__out_s2icg_i2c1_pclk_en),
  .out_s2icg_i2c2_pclk_en(slow_io_station_u__out_s2icg_i2c2_pclk_en),
  .out_s2icg_i2sm_pclk_en(slow_io_station_u__out_s2icg_i2sm_pclk_en),
  .out_s2icg_i2ss0_pclk_en(slow_io_station_u__out_s2icg_i2ss0_pclk_en),
  .out_s2icg_i2ss1_pclk_en(slow_io_station_u__out_s2icg_i2ss1_pclk_en),
  .out_s2icg_i2ss2_pclk_en(slow_io_station_u__out_s2icg_i2ss2_pclk_en),
  .out_s2icg_i2ss3_pclk_en(slow_io_station_u__out_s2icg_i2ss3_pclk_en),
  .out_s2icg_i2ss4_pclk_en(slow_io_station_u__out_s2icg_i2ss4_pclk_en),
  .out_s2icg_i2ss5_pclk_en(slow_io_station_u__out_s2icg_i2ss5_pclk_en),
  .out_s2icg_qspim_pclk_en(slow_io_station_u__out_s2icg_qspim_pclk_en),
  .out_s2icg_rtc_pclk_en(slow_io_station_u__out_s2icg_rtc_pclk_en),
  .out_s2icg_spis_pclk_en(slow_io_station_u__out_s2icg_spis_pclk_en),
  .out_s2icg_sspim0_pclk_en(slow_io_station_u__out_s2icg_sspim0_pclk_en),
  .out_s2icg_sspim1_pclk_en(slow_io_station_u__out_s2icg_sspim1_pclk_en),
  .out_s2icg_sspim2_pclk_en(slow_io_station_u__out_s2icg_sspim2_pclk_en),
  .out_s2icg_timers_pclk_en(slow_io_station_u__out_s2icg_timers_pclk_en),
  .out_s2icg_uart0_pclk_en(slow_io_station_u__out_s2icg_uart0_pclk_en),
  .out_s2icg_uart1_pclk_en(slow_io_station_u__out_s2icg_uart1_pclk_en),
  .out_s2icg_uart2_pclk_en(slow_io_station_u__out_s2icg_uart2_pclk_en),
  .out_s2icg_uart3_pclk_en(slow_io_station_u__out_s2icg_uart3_pclk_en),
  .out_s2icg_wdt_pclk_en(slow_io_station_u__out_s2icg_wdt_pclk_en),
  .rstn(slow_io_station_u__rstn),
  .vld_in_b2s_i2c0_debug_addr(slow_io_station_u__vld_in_b2s_i2c0_debug_addr),
  .vld_in_b2s_i2c0_debug_addr_10bit(slow_io_station_u__vld_in_b2s_i2c0_debug_addr_10bit),
  .vld_in_b2s_i2c0_debug_data(slow_io_station_u__vld_in_b2s_i2c0_debug_data),
  .vld_in_b2s_i2c0_debug_hs(slow_io_station_u__vld_in_b2s_i2c0_debug_hs),
  .vld_in_b2s_i2c0_debug_master_act(slow_io_station_u__vld_in_b2s_i2c0_debug_master_act),
  .vld_in_b2s_i2c0_debug_mst_cstate(slow_io_station_u__vld_in_b2s_i2c0_debug_mst_cstate),
  .vld_in_b2s_i2c0_debug_p_gen(slow_io_station_u__vld_in_b2s_i2c0_debug_p_gen),
  .vld_in_b2s_i2c0_debug_rd(slow_io_station_u__vld_in_b2s_i2c0_debug_rd),
  .vld_in_b2s_i2c0_debug_s_gen(slow_io_station_u__vld_in_b2s_i2c0_debug_s_gen),
  .vld_in_b2s_i2c0_debug_slave_act(slow_io_station_u__vld_in_b2s_i2c0_debug_slave_act),
  .vld_in_b2s_i2c0_debug_slv_cstate(slow_io_station_u__vld_in_b2s_i2c0_debug_slv_cstate),
  .vld_in_b2s_i2c0_debug_wr(slow_io_station_u__vld_in_b2s_i2c0_debug_wr),
  .vld_in_b2s_i2c1_debug_addr(slow_io_station_u__vld_in_b2s_i2c1_debug_addr),
  .vld_in_b2s_i2c1_debug_addr_10bit(slow_io_station_u__vld_in_b2s_i2c1_debug_addr_10bit),
  .vld_in_b2s_i2c1_debug_data(slow_io_station_u__vld_in_b2s_i2c1_debug_data),
  .vld_in_b2s_i2c1_debug_hs(slow_io_station_u__vld_in_b2s_i2c1_debug_hs),
  .vld_in_b2s_i2c1_debug_master_act(slow_io_station_u__vld_in_b2s_i2c1_debug_master_act),
  .vld_in_b2s_i2c1_debug_mst_cstate(slow_io_station_u__vld_in_b2s_i2c1_debug_mst_cstate),
  .vld_in_b2s_i2c1_debug_p_gen(slow_io_station_u__vld_in_b2s_i2c1_debug_p_gen),
  .vld_in_b2s_i2c1_debug_rd(slow_io_station_u__vld_in_b2s_i2c1_debug_rd),
  .vld_in_b2s_i2c1_debug_s_gen(slow_io_station_u__vld_in_b2s_i2c1_debug_s_gen),
  .vld_in_b2s_i2c1_debug_slave_act(slow_io_station_u__vld_in_b2s_i2c1_debug_slave_act),
  .vld_in_b2s_i2c1_debug_slv_cstate(slow_io_station_u__vld_in_b2s_i2c1_debug_slv_cstate),
  .vld_in_b2s_i2c1_debug_wr(slow_io_station_u__vld_in_b2s_i2c1_debug_wr),
  .vld_in_b2s_i2c2_debug_addr(slow_io_station_u__vld_in_b2s_i2c2_debug_addr),
  .vld_in_b2s_i2c2_debug_addr_10bit(slow_io_station_u__vld_in_b2s_i2c2_debug_addr_10bit),
  .vld_in_b2s_i2c2_debug_data(slow_io_station_u__vld_in_b2s_i2c2_debug_data),
  .vld_in_b2s_i2c2_debug_hs(slow_io_station_u__vld_in_b2s_i2c2_debug_hs),
  .vld_in_b2s_i2c2_debug_master_act(slow_io_station_u__vld_in_b2s_i2c2_debug_master_act),
  .vld_in_b2s_i2c2_debug_mst_cstate(slow_io_station_u__vld_in_b2s_i2c2_debug_mst_cstate),
  .vld_in_b2s_i2c2_debug_p_gen(slow_io_station_u__vld_in_b2s_i2c2_debug_p_gen),
  .vld_in_b2s_i2c2_debug_rd(slow_io_station_u__vld_in_b2s_i2c2_debug_rd),
  .vld_in_b2s_i2c2_debug_s_gen(slow_io_station_u__vld_in_b2s_i2c2_debug_s_gen),
  .vld_in_b2s_i2c2_debug_slave_act(slow_io_station_u__vld_in_b2s_i2c2_debug_slave_act),
  .vld_in_b2s_i2c2_debug_slv_cstate(slow_io_station_u__vld_in_b2s_i2c2_debug_slv_cstate),
  .vld_in_b2s_i2c2_debug_wr(slow_io_station_u__vld_in_b2s_i2c2_debug_wr),
  .vld_in_b2s_qspim_ssi_busy(slow_io_station_u__vld_in_b2s_qspim_ssi_busy),
  .vld_in_b2s_qspim_ssi_sleep(slow_io_station_u__vld_in_b2s_qspim_ssi_sleep),
  .vld_in_b2s_rtc_en(slow_io_station_u__vld_in_b2s_rtc_en),
  .vld_in_b2s_spis_ssi_sleep(slow_io_station_u__vld_in_b2s_spis_ssi_sleep),
  .vld_in_b2s_sspim0_ssi_sleep(slow_io_station_u__vld_in_b2s_sspim0_ssi_sleep),
  .vld_in_b2s_sspim1_ssi_sleep(slow_io_station_u__vld_in_b2s_sspim1_ssi_sleep),
  .vld_in_b2s_sspim2_ssi_sleep(slow_io_station_u__vld_in_b2s_sspim2_ssi_sleep),
  .vld_in_b2s_timer_en(slow_io_station_u__vld_in_b2s_timer_en)
);



icg test_io_pllclk_icg_u(
  .clk(test_io_pllclk_icg_u__clk),
  .clkg(test_io_pllclk_icg_u__clkg),
  .en(test_io_pllclk_icg_u__en),
  .tst_en(test_io_pllclk_icg_u__tst_en)
);

rstn_sync test_io_rstn_sync_u(
  .clk(test_io_rstn_sync_u__clk),
  .rstn_in(test_io_rstn_sync_u__rstn_in),
  .rstn_out(test_io_rstn_sync_u__rstn_out),
  .scan_en(test_io_rstn_sync_u__scan_en),
  .scan_rstn(test_io_rstn_sync_u__scan_rstn)
);

rstn_sync test_io_test_rstn_sync_u(
  .clk(test_io_test_rstn_sync_u__clk),
  .rstn_in(test_io_test_rstn_sync_u__rstn_in),
  .rstn_out(test_io_test_rstn_sync_u__rstn_out),
  .scan_en(test_io_test_rstn_sync_u__scan_en),
  .scan_rstn(test_io_test_rstn_sync_u__scan_rstn)
);

test_io test_io_u(
  .clk_div(test_io_u__clk_div),
  .clk_div_half(test_io_u__clk_div_half),
  .clk_oen(test_io_u__clk_oen),
  .or_req_if_ar(test_io_u__or_req_if_ar),
  .or_req_if_arready(test_io_u__or_req_if_arready),
  .or_req_if_arvalid(test_io_u__or_req_if_arvalid),
  .or_req_if_aw(test_io_u__or_req_if_aw),
  .or_req_if_awready(test_io_u__or_req_if_awready),
  .or_req_if_awvalid(test_io_u__or_req_if_awvalid),
  .or_req_if_w(test_io_u__or_req_if_w),
  .or_req_if_wready(test_io_u__or_req_if_wready),
  .or_req_if_wvalid(test_io_u__or_req_if_wvalid),
  .or_rsp_if_b(test_io_u__or_rsp_if_b),
  .or_rsp_if_bready(test_io_u__or_rsp_if_bready),
  .or_rsp_if_bvalid(test_io_u__or_rsp_if_bvalid),
  .or_rsp_if_r(test_io_u__or_rsp_if_r),
  .or_rsp_if_rready(test_io_u__or_rsp_if_rready),
  .or_rsp_if_rvalid(test_io_u__or_rsp_if_rvalid),
  .pllclk(test_io_u__pllclk),
  .rstn(test_io_u__rstn),
  .test_clk(test_io_u__test_clk),
  .test_din(test_io_u__test_din),
  .test_doen(test_io_u__test_doen),
  .test_dout(test_io_u__test_dout),
  .test_ein(test_io_u__test_ein),
  .test_eoen(test_io_u__test_eoen),
  .test_eout(test_io_u__test_eout),
  .test_rstn(test_io_u__test_rstn)
);

timer_interrupt timer_interrupt_u(
  .mtime_in(timer_interrupt_u__mtime_in),
  .mtime_out(timer_interrupt_u__mtime_out),
  .mtimecmp(timer_interrupt_u__mtimecmp),
  .timer_int(timer_interrupt_u__timer_int)
);

icg usb_pllclk_icg_u(
  .clk(usb_pllclk_icg_u__clk),
  .clkg(usb_pllclk_icg_u__clkg),
  .en(usb_pllclk_icg_u__en),
  .tst_en(usb_pllclk_icg_u__tst_en)
);

icg usb_refclk_icg_u(
  .clk(usb_refclk_icg_u__clk),
  .clkg(usb_refclk_icg_u__clkg),
  .en(usb_refclk_icg_u__en),
  .tst_en(usb_refclk_icg_u__tst_en)
);

rstn_sync usb_rstn_sync_u(
  .clk(usb_rstn_sync_u__clk),
  .rstn_in(usb_rstn_sync_u__rstn_in),
  .rstn_out(usb_rstn_sync_u__rstn_out),
  .scan_en(usb_rstn_sync_u__scan_en),
  .scan_rstn(usb_rstn_sync_u__scan_rstn)
);

station_usb_top usb_station_u(
  .clk(usb_station_u__clk),
  .i_req_local_if_ar(usb_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(usb_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(usb_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(usb_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(usb_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(usb_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(usb_station_u__i_req_local_if_w),
  .i_req_local_if_wready(usb_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(usb_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(usb_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(usb_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(usb_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(usb_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(usb_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(usb_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(usb_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(usb_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(usb_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(usb_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(usb_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(usb_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(usb_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(usb_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(usb_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(usb_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(usb_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(usb_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(usb_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(usb_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(usb_station_u__i_resp_ring_if_rvalid),
  .in_b2s_clk_gate_ctrl(usb_station_u__in_b2s_clk_gate_ctrl),
  .in_b2s_connect_state_u2pmu(usb_station_u__in_b2s_connect_state_u2pmu),
  .in_b2s_connect_state_u3pmu(usb_station_u__in_b2s_connect_state_u3pmu),
  .in_b2s_cr_ack(usb_station_u__in_b2s_cr_ack),
  .in_b2s_cr_data_out(usb_station_u__in_b2s_cr_data_out),
  .in_b2s_current_power_state_u2pmu(usb_station_u__in_b2s_current_power_state_u2pmu),
  .in_b2s_current_power_state_u3pmu(usb_station_u__in_b2s_current_power_state_u3pmu),
  .in_b2s_debug(usb_station_u__in_b2s_debug),
  .in_b2s_debug_u2pmu_hi(usb_station_u__in_b2s_debug_u2pmu_hi),
  .in_b2s_debug_u2pmu_lo(usb_station_u__in_b2s_debug_u2pmu_lo),
  .in_b2s_debug_u3pmu(usb_station_u__in_b2s_debug_u3pmu),
  .in_b2s_gp_out(usb_station_u__in_b2s_gp_out),
  .in_b2s_mpll_refssc_clk(usb_station_u__in_b2s_mpll_refssc_clk),
  .in_b2s_pme_generation_u2pmu(usb_station_u__in_b2s_pme_generation_u2pmu),
  .in_b2s_pme_generation_u3pmu(usb_station_u__in_b2s_pme_generation_u3pmu),
  .in_b2s_rtune_ack(usb_station_u__in_b2s_rtune_ack),
  .o_req_local_if_ar(usb_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(usb_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(usb_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(usb_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(usb_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(usb_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(usb_station_u__o_req_local_if_w),
  .o_req_local_if_wready(usb_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(usb_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(usb_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(usb_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(usb_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(usb_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(usb_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(usb_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(usb_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(usb_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(usb_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(usb_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(usb_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(usb_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(usb_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(usb_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(usb_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(usb_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(usb_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(usb_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(usb_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(usb_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(usb_station_u__o_resp_ring_if_rvalid),
  .out_b2s_clk_gate_ctrl(usb_station_u__out_b2s_clk_gate_ctrl),
  .out_b2s_connect_state_u2pmu(usb_station_u__out_b2s_connect_state_u2pmu),
  .out_b2s_connect_state_u3pmu(usb_station_u__out_b2s_connect_state_u3pmu),
  .out_b2s_cr_ack(usb_station_u__out_b2s_cr_ack),
  .out_b2s_cr_data_out(usb_station_u__out_b2s_cr_data_out),
  .out_b2s_current_power_state_u2pmu(usb_station_u__out_b2s_current_power_state_u2pmu),
  .out_b2s_current_power_state_u3pmu(usb_station_u__out_b2s_current_power_state_u3pmu),
  .out_b2s_debug(usb_station_u__out_b2s_debug),
  .out_b2s_debug_u2pmu_hi(usb_station_u__out_b2s_debug_u2pmu_hi),
  .out_b2s_debug_u2pmu_lo(usb_station_u__out_b2s_debug_u2pmu_lo),
  .out_b2s_debug_u3pmu(usb_station_u__out_b2s_debug_u3pmu),
  .out_b2s_gp_out(usb_station_u__out_b2s_gp_out),
  .out_b2s_mpll_refssc_clk(usb_station_u__out_b2s_mpll_refssc_clk),
  .out_b2s_pme_generation_u2pmu(usb_station_u__out_b2s_pme_generation_u2pmu),
  .out_b2s_pme_generation_u3pmu(usb_station_u__out_b2s_pme_generation_u3pmu),
  .out_b2s_rtune_ack(usb_station_u__out_b2s_rtune_ack),
  .out_debug_info_enable(usb_station_u__out_debug_info_enable),
  .out_s2b_ATERESET(usb_station_u__out_s2b_ATERESET),
  .out_s2b_COMPDISTUNE0(usb_station_u__out_s2b_COMPDISTUNE0),
  .out_s2b_LOOPBACKENB0(usb_station_u__out_s2b_LOOPBACKENB0),
  .out_s2b_OTGTUNE0(usb_station_u__out_s2b_OTGTUNE0),
  .out_s2b_SQRXTUNE0(usb_station_u__out_s2b_SQRXTUNE0),
  .out_s2b_TXFSLSTUNE0(usb_station_u__out_s2b_TXFSLSTUNE0),
  .out_s2b_TXHSXVTUNE0(usb_station_u__out_s2b_TXHSXVTUNE0),
  .out_s2b_TXPREEMPAMPTUNE0(usb_station_u__out_s2b_TXPREEMPAMPTUNE0),
  .out_s2b_TXPREEMPPULSETUNE0(usb_station_u__out_s2b_TXPREEMPPULSETUNE0),
  .out_s2b_TXRESTUNE0(usb_station_u__out_s2b_TXRESTUNE0),
  .out_s2b_TXRISETUNE0(usb_station_u__out_s2b_TXRISETUNE0),
  .out_s2b_TXVREFTUNE0(usb_station_u__out_s2b_TXVREFTUNE0),
  .out_s2b_VATESTENB(usb_station_u__out_s2b_VATESTENB),
  .out_s2b_VDATREFTUNE0(usb_station_u__out_s2b_VDATREFTUNE0),
  .out_s2b_cr_cap_addr(usb_station_u__out_s2b_cr_cap_addr),
  .out_s2b_cr_cap_data(usb_station_u__out_s2b_cr_cap_data),
  .out_s2b_cr_data_in(usb_station_u__out_s2b_cr_data_in),
  .out_s2b_cr_read(usb_station_u__out_s2b_cr_read),
  .out_s2b_cr_write(usb_station_u__out_s2b_cr_write),
  .out_s2b_fsel(usb_station_u__out_s2b_fsel),
  .out_s2b_gp_in(usb_station_u__out_s2b_gp_in),
  .out_s2b_lane0_ext_pclk_req(usb_station_u__out_s2b_lane0_ext_pclk_req),
  .out_s2b_lane0_tx2rx_loopbk(usb_station_u__out_s2b_lane0_tx2rx_loopbk),
  .out_s2b_lane0_tx_term_offset(usb_station_u__out_s2b_lane0_tx_term_offset),
  .out_s2b_los_bias(usb_station_u__out_s2b_los_bias),
  .out_s2b_los_level(usb_station_u__out_s2b_los_level),
  .out_s2b_mpll_multiplier(usb_station_u__out_s2b_mpll_multiplier),
  .out_s2b_pcs_rx_los_mask_val(usb_station_u__out_s2b_pcs_rx_los_mask_val),
  .out_s2b_pcs_tx_deemph_3p5db(usb_station_u__out_s2b_pcs_tx_deemph_3p5db),
  .out_s2b_pcs_tx_deemph_6db(usb_station_u__out_s2b_pcs_tx_deemph_6db),
  .out_s2b_pcs_tx_swing_full(usb_station_u__out_s2b_pcs_tx_swing_full),
  .out_s2b_pm_pmu_config_strap(usb_station_u__out_s2b_pm_pmu_config_strap),
  .out_s2b_pm_power_state_request(usb_station_u__out_s2b_pm_power_state_request),
  .out_s2b_power_switch_control(usb_station_u__out_s2b_power_switch_control),
  .out_s2b_ram0_sd(usb_station_u__out_s2b_ram0_sd),
  .out_s2b_ram0_slp(usb_station_u__out_s2b_ram0_slp),
  .out_s2b_ram1_sd(usb_station_u__out_s2b_ram1_sd),
  .out_s2b_ram1_slp(usb_station_u__out_s2b_ram1_slp),
  .out_s2b_ram2_sd(usb_station_u__out_s2b_ram2_sd),
  .out_s2b_ram2_slp(usb_station_u__out_s2b_ram2_slp),
  .out_s2b_ref_clkdiv2(usb_station_u__out_s2b_ref_clkdiv2),
  .out_s2b_ref_ssp_en(usb_station_u__out_s2b_ref_ssp_en),
  .out_s2b_ref_use_pad(usb_station_u__out_s2b_ref_use_pad),
  .out_s2b_rtune_req(usb_station_u__out_s2b_rtune_req),
  .out_s2b_ssc_range(usb_station_u__out_s2b_ssc_range),
  .out_s2b_ssc_ref_clk_sel(usb_station_u__out_s2b_ssc_ref_clk_sel),
  .out_s2b_test_powerdown_hsp(usb_station_u__out_s2b_test_powerdown_hsp),
  .out_s2b_test_powerdown_ssp(usb_station_u__out_s2b_test_powerdown_ssp),
  .out_s2b_tx_vboost_lvl(usb_station_u__out_s2b_tx_vboost_lvl),
  .out_s2b_vaux_reset_n(usb_station_u__out_s2b_vaux_reset_n),
  .out_s2b_vcc_reset_n(usb_station_u__out_s2b_vcc_reset_n),
  .out_s2dft_mbist_done(usb_station_u__out_s2dft_mbist_done),
  .out_s2dft_mbist_error_log_hi(usb_station_u__out_s2dft_mbist_error_log_hi),
  .out_s2dft_mbist_error_log_lo(usb_station_u__out_s2dft_mbist_error_log_lo),
  .out_s2dft_mbist_func_en(usb_station_u__out_s2dft_mbist_func_en),
  .out_s2icg_pllclk_en(usb_station_u__out_s2icg_pllclk_en),
  .out_s2icg_refclk_en(usb_station_u__out_s2icg_refclk_en),
  .rstn(usb_station_u__rstn),
  .vld_in_b2s_clk_gate_ctrl(usb_station_u__vld_in_b2s_clk_gate_ctrl),
  .vld_in_b2s_connect_state_u2pmu(usb_station_u__vld_in_b2s_connect_state_u2pmu),
  .vld_in_b2s_connect_state_u3pmu(usb_station_u__vld_in_b2s_connect_state_u3pmu),
  .vld_in_b2s_cr_ack(usb_station_u__vld_in_b2s_cr_ack),
  .vld_in_b2s_cr_data_out(usb_station_u__vld_in_b2s_cr_data_out),
  .vld_in_b2s_current_power_state_u2pmu(usb_station_u__vld_in_b2s_current_power_state_u2pmu),
  .vld_in_b2s_current_power_state_u3pmu(usb_station_u__vld_in_b2s_current_power_state_u3pmu),
  .vld_in_b2s_debug(usb_station_u__vld_in_b2s_debug),
  .vld_in_b2s_debug_u2pmu_hi(usb_station_u__vld_in_b2s_debug_u2pmu_hi),
  .vld_in_b2s_debug_u2pmu_lo(usb_station_u__vld_in_b2s_debug_u2pmu_lo),
  .vld_in_b2s_debug_u3pmu(usb_station_u__vld_in_b2s_debug_u3pmu),
  .vld_in_b2s_gp_out(usb_station_u__vld_in_b2s_gp_out),
  .vld_in_b2s_mpll_refssc_clk(usb_station_u__vld_in_b2s_mpll_refssc_clk),
  .vld_in_b2s_pme_generation_u2pmu(usb_station_u__vld_in_b2s_pme_generation_u2pmu),
  .vld_in_b2s_pme_generation_u3pmu(usb_station_u__vld_in_b2s_pme_generation_u3pmu),
  .vld_in_b2s_rtune_ack(usb_station_u__vld_in_b2s_rtune_ack)
);



dft_and vp0_cpunoc_amoreq_valid_and_u(
  .in0(vp0_cpunoc_amoreq_valid_and_u__in0),
  .in1(vp0_cpunoc_amoreq_valid_and_u__in1),
  .out(vp0_cpunoc_amoreq_valid_and_u__out)
);

dft_and vp0_cpunoc_req_valid_and_u(
  .in0(vp0_cpunoc_req_valid_and_u__in0),
  .in1(vp0_cpunoc_req_valid_and_u__in1),
  .out(vp0_cpunoc_req_valid_and_u__out)
);

icg vp0_icg_u(
  .clk(vp0_icg_u__clk),
  .clkg(vp0_icg_u__clkg),
  .en(vp0_icg_u__en),
  .tst_en(vp0_icg_u__tst_en)
);

or_gate vp0_iso_or_u(
  .in_0(vp0_iso_or_u__in_0),
  .in_1(vp0_iso_or_u__in_1),
  .out(vp0_iso_or_u__out)
);

dft_and vp0_ring_bvalid_and_u(
  .in0(vp0_ring_bvalid_and_u__in0),
  .in1(vp0_ring_bvalid_and_u__in1),
  .out(vp0_ring_bvalid_and_u__out)
);

dft_and vp0_ring_rvalid_and_u(
  .in0(vp0_ring_rvalid_and_u__in0),
  .in1(vp0_ring_rvalid_and_u__in1),
  .out(vp0_ring_rvalid_and_u__out)
);

rstn_sync vp0_rstn_sync_u(
  .clk(vp0_rstn_sync_u__clk),
  .rstn_in(vp0_rstn_sync_u__rstn_in),
  .rstn_out(vp0_rstn_sync_u__rstn_out),
  .scan_en(vp0_rstn_sync_u__scan_en),
  .scan_rstn(vp0_rstn_sync_u__scan_rstn)
);

or_gate vp0_scan_reset_u(
  .in_0(vp0_scan_reset_u__in_0),
  .in_1(vp0_scan_reset_u__in_1),
  .out(vp0_scan_reset_u__out)
);

station_vp #(.BLOCK_INST_ID(0)) vp0_station_u(
  .clk(vp0_station_u__clk),
  .i_req_local_if_ar(vp0_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(vp0_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(vp0_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(vp0_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(vp0_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(vp0_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(vp0_station_u__i_req_local_if_w),
  .i_req_local_if_wready(vp0_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(vp0_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(vp0_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(vp0_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(vp0_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(vp0_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(vp0_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(vp0_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(vp0_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(vp0_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(vp0_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(vp0_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(vp0_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(vp0_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(vp0_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(vp0_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(vp0_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(vp0_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(vp0_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(vp0_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(vp0_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(vp0_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(vp0_station_u__i_resp_ring_if_rvalid),
  .in_b2s_debug_stall_out(vp0_station_u__in_b2s_debug_stall_out),
  .in_b2s_is_vtlb_excp(vp0_station_u__in_b2s_is_vtlb_excp),
  .in_b2s_itb_last_ptr(vp0_station_u__in_b2s_itb_last_ptr),
  .in_b2s_vload_drt_req_vlen_illegal(vp0_station_u__in_b2s_vload_drt_req_vlen_illegal),
  .o_req_local_if_ar(vp0_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(vp0_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(vp0_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(vp0_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(vp0_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(vp0_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(vp0_station_u__o_req_local_if_w),
  .o_req_local_if_wready(vp0_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(vp0_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(vp0_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(vp0_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(vp0_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(vp0_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(vp0_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(vp0_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(vp0_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(vp0_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(vp0_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(vp0_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(vp0_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(vp0_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(vp0_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(vp0_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(vp0_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(vp0_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(vp0_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(vp0_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(vp0_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(vp0_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(vp0_station_u__o_resp_ring_if_rvalid),
  .out_b2s_debug_stall_out(vp0_station_u__out_b2s_debug_stall_out),
  .out_b2s_is_vtlb_excp(vp0_station_u__out_b2s_is_vtlb_excp),
  .out_b2s_itb_last_ptr(vp0_station_u__out_b2s_itb_last_ptr),
  .out_b2s_vload_drt_req_vlen_illegal(vp0_station_u__out_b2s_vload_drt_req_vlen_illegal),
  .out_s2b_bp_if_pc_0(vp0_station_u__out_s2b_bp_if_pc_0),
  .out_s2b_bp_if_pc_1(vp0_station_u__out_s2b_bp_if_pc_1),
  .out_s2b_bp_if_pc_2(vp0_station_u__out_s2b_bp_if_pc_2),
  .out_s2b_bp_if_pc_3(vp0_station_u__out_s2b_bp_if_pc_3),
  .out_s2b_bp_instret(vp0_station_u__out_s2b_bp_instret),
  .out_s2b_bp_wb_pc_0(vp0_station_u__out_s2b_bp_wb_pc_0),
  .out_s2b_bp_wb_pc_1(vp0_station_u__out_s2b_bp_wb_pc_1),
  .out_s2b_bp_wb_pc_2(vp0_station_u__out_s2b_bp_wb_pc_2),
  .out_s2b_bp_wb_pc_3(vp0_station_u__out_s2b_bp_wb_pc_3),
  .out_s2b_cfg_bypass_ic(vp0_station_u__out_s2b_cfg_bypass_ic),
  .out_s2b_cfg_bypass_tlb(vp0_station_u__out_s2b_cfg_bypass_tlb),
  .out_s2b_cfg_en_hpmcounter(vp0_station_u__out_s2b_cfg_en_hpmcounter),
  .out_s2b_cfg_itb_en(vp0_station_u__out_s2b_cfg_itb_en),
  .out_s2b_cfg_itb_sel(vp0_station_u__out_s2b_cfg_itb_sel),
  .out_s2b_cfg_itb_wrap_around(vp0_station_u__out_s2b_cfg_itb_wrap_around),
  .out_s2b_cfg_lfsr_seed(vp0_station_u__out_s2b_cfg_lfsr_seed),
  .out_s2b_cfg_pwr_on(vp0_station_u__out_s2b_cfg_pwr_on),
  .out_s2b_cfg_rst_pc(vp0_station_u__out_s2b_cfg_rst_pc),
  .out_s2b_cfg_sleep(vp0_station_u__out_s2b_cfg_sleep),
  .out_s2b_debug_resume(vp0_station_u__out_s2b_debug_resume),
  .out_s2b_debug_stall(vp0_station_u__out_s2b_debug_stall),
  .out_s2b_early_rstn(vp0_station_u__out_s2b_early_rstn),
  .out_s2b_en_bp_if_pc_0(vp0_station_u__out_s2b_en_bp_if_pc_0),
  .out_s2b_en_bp_if_pc_1(vp0_station_u__out_s2b_en_bp_if_pc_1),
  .out_s2b_en_bp_if_pc_2(vp0_station_u__out_s2b_en_bp_if_pc_2),
  .out_s2b_en_bp_if_pc_3(vp0_station_u__out_s2b_en_bp_if_pc_3),
  .out_s2b_en_bp_instret(vp0_station_u__out_s2b_en_bp_instret),
  .out_s2b_en_bp_wb_pc_0(vp0_station_u__out_s2b_en_bp_wb_pc_0),
  .out_s2b_en_bp_wb_pc_1(vp0_station_u__out_s2b_en_bp_wb_pc_1),
  .out_s2b_en_bp_wb_pc_2(vp0_station_u__out_s2b_en_bp_wb_pc_2),
  .out_s2b_en_bp_wb_pc_3(vp0_station_u__out_s2b_en_bp_wb_pc_3),
  .out_s2b_ext_event(vp0_station_u__out_s2b_ext_event),
  .out_s2b_powerline_ctrl(vp0_station_u__out_s2b_powerline_ctrl),
  .out_s2b_powervbank_ctrl(vp0_station_u__out_s2b_powervbank_ctrl),
  .out_s2b_rstn(vp0_station_u__out_s2b_rstn),
  .out_s2b_vcore_en(vp0_station_u__out_s2b_vcore_en),
  .out_s2b_vcore_icg_disable(vp0_station_u__out_s2b_vcore_icg_disable),
  .out_s2b_vcore_pmu_en(vp0_station_u__out_s2b_vcore_pmu_en),
  .out_s2b_vcore_pmu_evt_mask(vp0_station_u__out_s2b_vcore_pmu_evt_mask),
  .out_s2icg_clk_en(vp0_station_u__out_s2icg_clk_en),
  .rstn(vp0_station_u__rstn),
  .vld_in_b2s_debug_stall_out(vp0_station_u__vld_in_b2s_debug_stall_out),
  .vld_in_b2s_is_vtlb_excp(vp0_station_u__vld_in_b2s_is_vtlb_excp),
  .vld_in_b2s_itb_last_ptr(vp0_station_u__vld_in_b2s_itb_last_ptr),
  .vld_in_b2s_vload_drt_req_vlen_illegal(vp0_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)
);

dft_and vp0_sysbus_arvalid_and_u(
  .in0(vp0_sysbus_arvalid_and_u__in0),
  .in1(vp0_sysbus_arvalid_and_u__in1),
  .out(vp0_sysbus_arvalid_and_u__out)
);

dft_and vp0_sysbus_awvalid_and_u(
  .in0(vp0_sysbus_awvalid_and_u__in0),
  .in1(vp0_sysbus_awvalid_and_u__in1),
  .out(vp0_sysbus_awvalid_and_u__out)
);

dft_and vp0_sysbus_wvalid_and_u(
  .in0(vp0_sysbus_wvalid_and_u__in0),
  .in1(vp0_sysbus_wvalid_and_u__in1),
  .out(vp0_sysbus_wvalid_and_u__out)
);

`ifdef IFDEF_FPGA__IFNDEF_SINGLE_VP
vcore_fp_top #(.USEDW(2)) vp0_u(
  .b2s_debug_stall_out(vp0_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp0_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp0_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp0_u__cache_req_if_req),
  .cache_req_if_req_ready(vp0_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp0_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp0_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp0_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp0_u__cache_resp_if_resp_valid),
  .clk(vp0_u__clk),
  .core_id(vp0_u__core_id),
  .cpu_amo_store_req(vp0_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp0_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp0_u__cpu_amo_store_req_valid),
  .external_int(vp0_u__external_int),
  .load_vtlb_excp(vp0_u__load_vtlb_excp),
  .ring_req_if_ar(vp0_u__ring_req_if_ar),
  .ring_req_if_arready(vp0_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp0_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp0_u__ring_req_if_aw),
  .ring_req_if_awready(vp0_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp0_u__ring_req_if_awvalid),
  .ring_req_if_w(vp0_u__ring_req_if_w),
  .ring_req_if_wready(vp0_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp0_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp0_u__ring_resp_if_b),
  .ring_resp_if_bready(vp0_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp0_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp0_u__ring_resp_if_r),
  .ring_resp_if_rready(vp0_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp0_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp0_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp0_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp0_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp0_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp0_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp0_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp0_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp0_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp0_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp0_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp0_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp0_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp0_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp0_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp0_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp0_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp0_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp0_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp0_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp0_u__s2b_debug_resume),
  .s2b_debug_stall(vp0_u__s2b_debug_stall),
  .s2b_early_rstn(vp0_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp0_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp0_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp0_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp0_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp0_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp0_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp0_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp0_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp0_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp0_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp0_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp0_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp0_u__s2b_rstn),
  .s2b_vcore_en(vp0_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp0_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp0_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp0_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp0_u__software_int),
  .sysbus_req_if_ar(vp0_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp0_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp0_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp0_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp0_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp0_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp0_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp0_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp0_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp0_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp0_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp0_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp0_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp0_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp0_u__sysbus_resp_if_rvalid),
  .timer_int(vp0_u__timer_int),
  .wfe_stall(vp0_u__wfe_stall),
  .wfi_stall(vp0_u__wfi_stall)
);
`endif

dft_and vp0_vlsu_int_and_u(
  .in0(vp0_vlsu_int_and_u__in0),
  .in1(vp0_vlsu_int_and_u__in1),
  .out(vp0_vlsu_int_and_u__out)
);

dft_and vp1_cpunoc_amoreq_valid_and_u(
  .in0(vp1_cpunoc_amoreq_valid_and_u__in0),
  .in1(vp1_cpunoc_amoreq_valid_and_u__in1),
  .out(vp1_cpunoc_amoreq_valid_and_u__out)
);

dft_and vp1_cpunoc_req_valid_and_u(
  .in0(vp1_cpunoc_req_valid_and_u__in0),
  .in1(vp1_cpunoc_req_valid_and_u__in1),
  .out(vp1_cpunoc_req_valid_and_u__out)
);

icg vp1_icg_u(
  .clk(vp1_icg_u__clk),
  .clkg(vp1_icg_u__clkg),
  .en(vp1_icg_u__en),
  .tst_en(vp1_icg_u__tst_en)
);

or_gate vp1_iso_or_u(
  .in_0(vp1_iso_or_u__in_0),
  .in_1(vp1_iso_or_u__in_1),
  .out(vp1_iso_or_u__out)
);

dft_and vp1_ring_bvalid_and_u(
  .in0(vp1_ring_bvalid_and_u__in0),
  .in1(vp1_ring_bvalid_and_u__in1),
  .out(vp1_ring_bvalid_and_u__out)
);

dft_and vp1_ring_rvalid_and_u(
  .in0(vp1_ring_rvalid_and_u__in0),
  .in1(vp1_ring_rvalid_and_u__in1),
  .out(vp1_ring_rvalid_and_u__out)
);

rstn_sync vp1_rstn_sync_u(
  .clk(vp1_rstn_sync_u__clk),
  .rstn_in(vp1_rstn_sync_u__rstn_in),
  .rstn_out(vp1_rstn_sync_u__rstn_out),
  .scan_en(vp1_rstn_sync_u__scan_en),
  .scan_rstn(vp1_rstn_sync_u__scan_rstn)
);

or_gate vp1_scan_reset_u(
  .in_0(vp1_scan_reset_u__in_0),
  .in_1(vp1_scan_reset_u__in_1),
  .out(vp1_scan_reset_u__out)
);

`ifdef IFNDEF_SINGLE_VP
station_vp #(.BLOCK_INST_ID(1)) vp1_station_u(
  .clk(vp1_station_u__clk),
  .i_req_local_if_ar(vp1_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(vp1_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(vp1_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(vp1_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(vp1_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(vp1_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(vp1_station_u__i_req_local_if_w),
  .i_req_local_if_wready(vp1_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(vp1_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(vp1_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(vp1_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(vp1_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(vp1_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(vp1_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(vp1_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(vp1_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(vp1_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(vp1_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(vp1_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(vp1_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(vp1_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(vp1_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(vp1_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(vp1_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(vp1_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(vp1_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(vp1_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(vp1_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(vp1_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(vp1_station_u__i_resp_ring_if_rvalid),
  .in_b2s_debug_stall_out(vp1_station_u__in_b2s_debug_stall_out),
  .in_b2s_is_vtlb_excp(vp1_station_u__in_b2s_is_vtlb_excp),
  .in_b2s_itb_last_ptr(vp1_station_u__in_b2s_itb_last_ptr),
  .in_b2s_vload_drt_req_vlen_illegal(vp1_station_u__in_b2s_vload_drt_req_vlen_illegal),
  .o_req_local_if_ar(vp1_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(vp1_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(vp1_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(vp1_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(vp1_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(vp1_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(vp1_station_u__o_req_local_if_w),
  .o_req_local_if_wready(vp1_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(vp1_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(vp1_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(vp1_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(vp1_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(vp1_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(vp1_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(vp1_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(vp1_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(vp1_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(vp1_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(vp1_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(vp1_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(vp1_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(vp1_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(vp1_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(vp1_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(vp1_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(vp1_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(vp1_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(vp1_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(vp1_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(vp1_station_u__o_resp_ring_if_rvalid),
  .out_b2s_debug_stall_out(vp1_station_u__out_b2s_debug_stall_out),
  .out_b2s_is_vtlb_excp(vp1_station_u__out_b2s_is_vtlb_excp),
  .out_b2s_itb_last_ptr(vp1_station_u__out_b2s_itb_last_ptr),
  .out_b2s_vload_drt_req_vlen_illegal(vp1_station_u__out_b2s_vload_drt_req_vlen_illegal),
  .out_s2b_bp_if_pc_0(vp1_station_u__out_s2b_bp_if_pc_0),
  .out_s2b_bp_if_pc_1(vp1_station_u__out_s2b_bp_if_pc_1),
  .out_s2b_bp_if_pc_2(vp1_station_u__out_s2b_bp_if_pc_2),
  .out_s2b_bp_if_pc_3(vp1_station_u__out_s2b_bp_if_pc_3),
  .out_s2b_bp_instret(vp1_station_u__out_s2b_bp_instret),
  .out_s2b_bp_wb_pc_0(vp1_station_u__out_s2b_bp_wb_pc_0),
  .out_s2b_bp_wb_pc_1(vp1_station_u__out_s2b_bp_wb_pc_1),
  .out_s2b_bp_wb_pc_2(vp1_station_u__out_s2b_bp_wb_pc_2),
  .out_s2b_bp_wb_pc_3(vp1_station_u__out_s2b_bp_wb_pc_3),
  .out_s2b_cfg_bypass_ic(vp1_station_u__out_s2b_cfg_bypass_ic),
  .out_s2b_cfg_bypass_tlb(vp1_station_u__out_s2b_cfg_bypass_tlb),
  .out_s2b_cfg_en_hpmcounter(vp1_station_u__out_s2b_cfg_en_hpmcounter),
  .out_s2b_cfg_itb_en(vp1_station_u__out_s2b_cfg_itb_en),
  .out_s2b_cfg_itb_sel(vp1_station_u__out_s2b_cfg_itb_sel),
  .out_s2b_cfg_itb_wrap_around(vp1_station_u__out_s2b_cfg_itb_wrap_around),
  .out_s2b_cfg_lfsr_seed(vp1_station_u__out_s2b_cfg_lfsr_seed),
  .out_s2b_cfg_pwr_on(vp1_station_u__out_s2b_cfg_pwr_on),
  .out_s2b_cfg_rst_pc(vp1_station_u__out_s2b_cfg_rst_pc),
  .out_s2b_cfg_sleep(vp1_station_u__out_s2b_cfg_sleep),
  .out_s2b_debug_resume(vp1_station_u__out_s2b_debug_resume),
  .out_s2b_debug_stall(vp1_station_u__out_s2b_debug_stall),
  .out_s2b_early_rstn(vp1_station_u__out_s2b_early_rstn),
  .out_s2b_en_bp_if_pc_0(vp1_station_u__out_s2b_en_bp_if_pc_0),
  .out_s2b_en_bp_if_pc_1(vp1_station_u__out_s2b_en_bp_if_pc_1),
  .out_s2b_en_bp_if_pc_2(vp1_station_u__out_s2b_en_bp_if_pc_2),
  .out_s2b_en_bp_if_pc_3(vp1_station_u__out_s2b_en_bp_if_pc_3),
  .out_s2b_en_bp_instret(vp1_station_u__out_s2b_en_bp_instret),
  .out_s2b_en_bp_wb_pc_0(vp1_station_u__out_s2b_en_bp_wb_pc_0),
  .out_s2b_en_bp_wb_pc_1(vp1_station_u__out_s2b_en_bp_wb_pc_1),
  .out_s2b_en_bp_wb_pc_2(vp1_station_u__out_s2b_en_bp_wb_pc_2),
  .out_s2b_en_bp_wb_pc_3(vp1_station_u__out_s2b_en_bp_wb_pc_3),
  .out_s2b_ext_event(vp1_station_u__out_s2b_ext_event),
  .out_s2b_powerline_ctrl(vp1_station_u__out_s2b_powerline_ctrl),
  .out_s2b_powervbank_ctrl(vp1_station_u__out_s2b_powervbank_ctrl),
  .out_s2b_rstn(vp1_station_u__out_s2b_rstn),
  .out_s2b_vcore_en(vp1_station_u__out_s2b_vcore_en),
  .out_s2b_vcore_icg_disable(vp1_station_u__out_s2b_vcore_icg_disable),
  .out_s2b_vcore_pmu_en(vp1_station_u__out_s2b_vcore_pmu_en),
  .out_s2b_vcore_pmu_evt_mask(vp1_station_u__out_s2b_vcore_pmu_evt_mask),
  .out_s2icg_clk_en(vp1_station_u__out_s2icg_clk_en),
  .rstn(vp1_station_u__rstn),
  .vld_in_b2s_debug_stall_out(vp1_station_u__vld_in_b2s_debug_stall_out),
  .vld_in_b2s_is_vtlb_excp(vp1_station_u__vld_in_b2s_is_vtlb_excp),
  .vld_in_b2s_itb_last_ptr(vp1_station_u__vld_in_b2s_itb_last_ptr),
  .vld_in_b2s_vload_drt_req_vlen_illegal(vp1_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)
);
`endif

dft_and vp1_sysbus_arvalid_and_u(
  .in0(vp1_sysbus_arvalid_and_u__in0),
  .in1(vp1_sysbus_arvalid_and_u__in1),
  .out(vp1_sysbus_arvalid_and_u__out)
);

dft_and vp1_sysbus_awvalid_and_u(
  .in0(vp1_sysbus_awvalid_and_u__in0),
  .in1(vp1_sysbus_awvalid_and_u__in1),
  .out(vp1_sysbus_awvalid_and_u__out)
);

dft_and vp1_sysbus_wvalid_and_u(
  .in0(vp1_sysbus_wvalid_and_u__in0),
  .in1(vp1_sysbus_wvalid_and_u__in1),
  .out(vp1_sysbus_wvalid_and_u__out)
);

`ifdef IFDEF_FPGA__IFNDEF_SINGLE_VP
vcore_fp_top #(.USEDW(2)) vp1_u(
  .b2s_debug_stall_out(vp1_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp1_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp1_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp1_u__cache_req_if_req),
  .cache_req_if_req_ready(vp1_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp1_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp1_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp1_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp1_u__cache_resp_if_resp_valid),
  .clk(vp1_u__clk),
  .core_id(vp1_u__core_id),
  .cpu_amo_store_req(vp1_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp1_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp1_u__cpu_amo_store_req_valid),
  .external_int(vp1_u__external_int),
  .load_vtlb_excp(vp1_u__load_vtlb_excp),
  .ring_req_if_ar(vp1_u__ring_req_if_ar),
  .ring_req_if_arready(vp1_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp1_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp1_u__ring_req_if_aw),
  .ring_req_if_awready(vp1_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp1_u__ring_req_if_awvalid),
  .ring_req_if_w(vp1_u__ring_req_if_w),
  .ring_req_if_wready(vp1_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp1_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp1_u__ring_resp_if_b),
  .ring_resp_if_bready(vp1_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp1_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp1_u__ring_resp_if_r),
  .ring_resp_if_rready(vp1_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp1_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp1_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp1_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp1_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp1_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp1_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp1_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp1_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp1_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp1_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp1_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp1_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp1_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp1_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp1_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp1_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp1_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp1_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp1_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp1_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp1_u__s2b_debug_resume),
  .s2b_debug_stall(vp1_u__s2b_debug_stall),
  .s2b_early_rstn(vp1_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp1_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp1_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp1_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp1_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp1_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp1_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp1_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp1_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp1_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp1_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp1_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp1_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp1_u__s2b_rstn),
  .s2b_vcore_en(vp1_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp1_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp1_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp1_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp1_u__software_int),
  .sysbus_req_if_ar(vp1_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp1_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp1_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp1_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp1_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp1_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp1_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp1_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp1_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp1_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp1_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp1_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp1_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp1_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp1_u__sysbus_resp_if_rvalid),
  .timer_int(vp1_u__timer_int),
  .wfe_stall(vp1_u__wfe_stall),
  .wfi_stall(vp1_u__wfi_stall)
);
`endif

dft_and vp1_vlsu_int_and_u(
  .in0(vp1_vlsu_int_and_u__in0),
  .in1(vp1_vlsu_int_and_u__in1),
  .out(vp1_vlsu_int_and_u__out)
);

dft_and vp2_cpunoc_amoreq_valid_and_u(
  .in0(vp2_cpunoc_amoreq_valid_and_u__in0),
  .in1(vp2_cpunoc_amoreq_valid_and_u__in1),
  .out(vp2_cpunoc_amoreq_valid_and_u__out)
);

dft_and vp2_cpunoc_req_valid_and_u(
  .in0(vp2_cpunoc_req_valid_and_u__in0),
  .in1(vp2_cpunoc_req_valid_and_u__in1),
  .out(vp2_cpunoc_req_valid_and_u__out)
);

icg vp2_icg_u(
  .clk(vp2_icg_u__clk),
  .clkg(vp2_icg_u__clkg),
  .en(vp2_icg_u__en),
  .tst_en(vp2_icg_u__tst_en)
);

or_gate vp2_iso_or_u(
  .in_0(vp2_iso_or_u__in_0),
  .in_1(vp2_iso_or_u__in_1),
  .out(vp2_iso_or_u__out)
);

dft_and vp2_ring_bvalid_and_u(
  .in0(vp2_ring_bvalid_and_u__in0),
  .in1(vp2_ring_bvalid_and_u__in1),
  .out(vp2_ring_bvalid_and_u__out)
);

dft_and vp2_ring_rvalid_and_u(
  .in0(vp2_ring_rvalid_and_u__in0),
  .in1(vp2_ring_rvalid_and_u__in1),
  .out(vp2_ring_rvalid_and_u__out)
);

rstn_sync vp2_rstn_sync_u(
  .clk(vp2_rstn_sync_u__clk),
  .rstn_in(vp2_rstn_sync_u__rstn_in),
  .rstn_out(vp2_rstn_sync_u__rstn_out),
  .scan_en(vp2_rstn_sync_u__scan_en),
  .scan_rstn(vp2_rstn_sync_u__scan_rstn)
);

or_gate vp2_scan_reset_u(
  .in_0(vp2_scan_reset_u__in_0),
  .in_1(vp2_scan_reset_u__in_1),
  .out(vp2_scan_reset_u__out)
);

`ifdef IFNDEF_SINGLE_VP
station_vp #(.BLOCK_INST_ID(2)) vp2_station_u(
  .clk(vp2_station_u__clk),
  .i_req_local_if_ar(vp2_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(vp2_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(vp2_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(vp2_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(vp2_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(vp2_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(vp2_station_u__i_req_local_if_w),
  .i_req_local_if_wready(vp2_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(vp2_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(vp2_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(vp2_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(vp2_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(vp2_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(vp2_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(vp2_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(vp2_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(vp2_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(vp2_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(vp2_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(vp2_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(vp2_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(vp2_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(vp2_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(vp2_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(vp2_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(vp2_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(vp2_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(vp2_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(vp2_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(vp2_station_u__i_resp_ring_if_rvalid),
  .in_b2s_debug_stall_out(vp2_station_u__in_b2s_debug_stall_out),
  .in_b2s_is_vtlb_excp(vp2_station_u__in_b2s_is_vtlb_excp),
  .in_b2s_itb_last_ptr(vp2_station_u__in_b2s_itb_last_ptr),
  .in_b2s_vload_drt_req_vlen_illegal(vp2_station_u__in_b2s_vload_drt_req_vlen_illegal),
  .o_req_local_if_ar(vp2_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(vp2_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(vp2_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(vp2_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(vp2_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(vp2_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(vp2_station_u__o_req_local_if_w),
  .o_req_local_if_wready(vp2_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(vp2_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(vp2_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(vp2_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(vp2_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(vp2_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(vp2_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(vp2_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(vp2_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(vp2_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(vp2_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(vp2_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(vp2_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(vp2_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(vp2_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(vp2_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(vp2_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(vp2_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(vp2_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(vp2_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(vp2_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(vp2_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(vp2_station_u__o_resp_ring_if_rvalid),
  .out_b2s_debug_stall_out(vp2_station_u__out_b2s_debug_stall_out),
  .out_b2s_is_vtlb_excp(vp2_station_u__out_b2s_is_vtlb_excp),
  .out_b2s_itb_last_ptr(vp2_station_u__out_b2s_itb_last_ptr),
  .out_b2s_vload_drt_req_vlen_illegal(vp2_station_u__out_b2s_vload_drt_req_vlen_illegal),
  .out_s2b_bp_if_pc_0(vp2_station_u__out_s2b_bp_if_pc_0),
  .out_s2b_bp_if_pc_1(vp2_station_u__out_s2b_bp_if_pc_1),
  .out_s2b_bp_if_pc_2(vp2_station_u__out_s2b_bp_if_pc_2),
  .out_s2b_bp_if_pc_3(vp2_station_u__out_s2b_bp_if_pc_3),
  .out_s2b_bp_instret(vp2_station_u__out_s2b_bp_instret),
  .out_s2b_bp_wb_pc_0(vp2_station_u__out_s2b_bp_wb_pc_0),
  .out_s2b_bp_wb_pc_1(vp2_station_u__out_s2b_bp_wb_pc_1),
  .out_s2b_bp_wb_pc_2(vp2_station_u__out_s2b_bp_wb_pc_2),
  .out_s2b_bp_wb_pc_3(vp2_station_u__out_s2b_bp_wb_pc_3),
  .out_s2b_cfg_bypass_ic(vp2_station_u__out_s2b_cfg_bypass_ic),
  .out_s2b_cfg_bypass_tlb(vp2_station_u__out_s2b_cfg_bypass_tlb),
  .out_s2b_cfg_en_hpmcounter(vp2_station_u__out_s2b_cfg_en_hpmcounter),
  .out_s2b_cfg_itb_en(vp2_station_u__out_s2b_cfg_itb_en),
  .out_s2b_cfg_itb_sel(vp2_station_u__out_s2b_cfg_itb_sel),
  .out_s2b_cfg_itb_wrap_around(vp2_station_u__out_s2b_cfg_itb_wrap_around),
  .out_s2b_cfg_lfsr_seed(vp2_station_u__out_s2b_cfg_lfsr_seed),
  .out_s2b_cfg_pwr_on(vp2_station_u__out_s2b_cfg_pwr_on),
  .out_s2b_cfg_rst_pc(vp2_station_u__out_s2b_cfg_rst_pc),
  .out_s2b_cfg_sleep(vp2_station_u__out_s2b_cfg_sleep),
  .out_s2b_debug_resume(vp2_station_u__out_s2b_debug_resume),
  .out_s2b_debug_stall(vp2_station_u__out_s2b_debug_stall),
  .out_s2b_early_rstn(vp2_station_u__out_s2b_early_rstn),
  .out_s2b_en_bp_if_pc_0(vp2_station_u__out_s2b_en_bp_if_pc_0),
  .out_s2b_en_bp_if_pc_1(vp2_station_u__out_s2b_en_bp_if_pc_1),
  .out_s2b_en_bp_if_pc_2(vp2_station_u__out_s2b_en_bp_if_pc_2),
  .out_s2b_en_bp_if_pc_3(vp2_station_u__out_s2b_en_bp_if_pc_3),
  .out_s2b_en_bp_instret(vp2_station_u__out_s2b_en_bp_instret),
  .out_s2b_en_bp_wb_pc_0(vp2_station_u__out_s2b_en_bp_wb_pc_0),
  .out_s2b_en_bp_wb_pc_1(vp2_station_u__out_s2b_en_bp_wb_pc_1),
  .out_s2b_en_bp_wb_pc_2(vp2_station_u__out_s2b_en_bp_wb_pc_2),
  .out_s2b_en_bp_wb_pc_3(vp2_station_u__out_s2b_en_bp_wb_pc_3),
  .out_s2b_ext_event(vp2_station_u__out_s2b_ext_event),
  .out_s2b_powerline_ctrl(vp2_station_u__out_s2b_powerline_ctrl),
  .out_s2b_powervbank_ctrl(vp2_station_u__out_s2b_powervbank_ctrl),
  .out_s2b_rstn(vp2_station_u__out_s2b_rstn),
  .out_s2b_vcore_en(vp2_station_u__out_s2b_vcore_en),
  .out_s2b_vcore_icg_disable(vp2_station_u__out_s2b_vcore_icg_disable),
  .out_s2b_vcore_pmu_en(vp2_station_u__out_s2b_vcore_pmu_en),
  .out_s2b_vcore_pmu_evt_mask(vp2_station_u__out_s2b_vcore_pmu_evt_mask),
  .out_s2icg_clk_en(vp2_station_u__out_s2icg_clk_en),
  .rstn(vp2_station_u__rstn),
  .vld_in_b2s_debug_stall_out(vp2_station_u__vld_in_b2s_debug_stall_out),
  .vld_in_b2s_is_vtlb_excp(vp2_station_u__vld_in_b2s_is_vtlb_excp),
  .vld_in_b2s_itb_last_ptr(vp2_station_u__vld_in_b2s_itb_last_ptr),
  .vld_in_b2s_vload_drt_req_vlen_illegal(vp2_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)
);
`endif

dft_and vp2_sysbus_arvalid_and_u(
  .in0(vp2_sysbus_arvalid_and_u__in0),
  .in1(vp2_sysbus_arvalid_and_u__in1),
  .out(vp2_sysbus_arvalid_and_u__out)
);

dft_and vp2_sysbus_awvalid_and_u(
  .in0(vp2_sysbus_awvalid_and_u__in0),
  .in1(vp2_sysbus_awvalid_and_u__in1),
  .out(vp2_sysbus_awvalid_and_u__out)
);

dft_and vp2_sysbus_wvalid_and_u(
  .in0(vp2_sysbus_wvalid_and_u__in0),
  .in1(vp2_sysbus_wvalid_and_u__in1),
  .out(vp2_sysbus_wvalid_and_u__out)
);

`ifdef IFDEF_FPGA__IFNDEF_SINGLE_VP
vcore_fp_top #(.USEDW(2)) vp2_u(
  .b2s_debug_stall_out(vp2_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp2_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp2_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp2_u__cache_req_if_req),
  .cache_req_if_req_ready(vp2_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp2_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp2_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp2_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp2_u__cache_resp_if_resp_valid),
  .clk(vp2_u__clk),
  .core_id(vp2_u__core_id),
  .cpu_amo_store_req(vp2_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp2_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp2_u__cpu_amo_store_req_valid),
  .external_int(vp2_u__external_int),
  .load_vtlb_excp(vp2_u__load_vtlb_excp),
  .ring_req_if_ar(vp2_u__ring_req_if_ar),
  .ring_req_if_arready(vp2_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp2_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp2_u__ring_req_if_aw),
  .ring_req_if_awready(vp2_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp2_u__ring_req_if_awvalid),
  .ring_req_if_w(vp2_u__ring_req_if_w),
  .ring_req_if_wready(vp2_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp2_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp2_u__ring_resp_if_b),
  .ring_resp_if_bready(vp2_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp2_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp2_u__ring_resp_if_r),
  .ring_resp_if_rready(vp2_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp2_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp2_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp2_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp2_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp2_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp2_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp2_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp2_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp2_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp2_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp2_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp2_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp2_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp2_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp2_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp2_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp2_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp2_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp2_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp2_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp2_u__s2b_debug_resume),
  .s2b_debug_stall(vp2_u__s2b_debug_stall),
  .s2b_early_rstn(vp2_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp2_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp2_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp2_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp2_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp2_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp2_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp2_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp2_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp2_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp2_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp2_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp2_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp2_u__s2b_rstn),
  .s2b_vcore_en(vp2_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp2_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp2_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp2_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp2_u__software_int),
  .sysbus_req_if_ar(vp2_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp2_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp2_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp2_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp2_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp2_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp2_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp2_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp2_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp2_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp2_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp2_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp2_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp2_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp2_u__sysbus_resp_if_rvalid),
  .timer_int(vp2_u__timer_int),
  .wfe_stall(vp2_u__wfe_stall),
  .wfi_stall(vp2_u__wfi_stall)
);
`endif

dft_and vp2_vlsu_int_and_u(
  .in0(vp2_vlsu_int_and_u__in0),
  .in1(vp2_vlsu_int_and_u__in1),
  .out(vp2_vlsu_int_and_u__out)
);

dft_and vp3_cpunoc_amoreq_valid_and_u(
  .in0(vp3_cpunoc_amoreq_valid_and_u__in0),
  .in1(vp3_cpunoc_amoreq_valid_and_u__in1),
  .out(vp3_cpunoc_amoreq_valid_and_u__out)
);

dft_and vp3_cpunoc_req_valid_and_u(
  .in0(vp3_cpunoc_req_valid_and_u__in0),
  .in1(vp3_cpunoc_req_valid_and_u__in1),
  .out(vp3_cpunoc_req_valid_and_u__out)
);

icg vp3_icg_u(
  .clk(vp3_icg_u__clk),
  .clkg(vp3_icg_u__clkg),
  .en(vp3_icg_u__en),
  .tst_en(vp3_icg_u__tst_en)
);

or_gate vp3_iso_or_u(
  .in_0(vp3_iso_or_u__in_0),
  .in_1(vp3_iso_or_u__in_1),
  .out(vp3_iso_or_u__out)
);

dft_and vp3_ring_bvalid_and_u(
  .in0(vp3_ring_bvalid_and_u__in0),
  .in1(vp3_ring_bvalid_and_u__in1),
  .out(vp3_ring_bvalid_and_u__out)
);

dft_and vp3_ring_rvalid_and_u(
  .in0(vp3_ring_rvalid_and_u__in0),
  .in1(vp3_ring_rvalid_and_u__in1),
  .out(vp3_ring_rvalid_and_u__out)
);

rstn_sync vp3_rstn_sync_u(
  .clk(vp3_rstn_sync_u__clk),
  .rstn_in(vp3_rstn_sync_u__rstn_in),
  .rstn_out(vp3_rstn_sync_u__rstn_out),
  .scan_en(vp3_rstn_sync_u__scan_en),
  .scan_rstn(vp3_rstn_sync_u__scan_rstn)
);

or_gate vp3_scan_reset_u(
  .in_0(vp3_scan_reset_u__in_0),
  .in_1(vp3_scan_reset_u__in_1),
  .out(vp3_scan_reset_u__out)
);

`ifdef IFNDEF_SINGLE_VP
station_vp #(.BLOCK_INST_ID(3)) vp3_station_u(
  .clk(vp3_station_u__clk),
  .i_req_local_if_ar(vp3_station_u__i_req_local_if_ar),
  .i_req_local_if_arready(vp3_station_u__i_req_local_if_arready),
  .i_req_local_if_arvalid(vp3_station_u__i_req_local_if_arvalid),
  .i_req_local_if_aw(vp3_station_u__i_req_local_if_aw),
  .i_req_local_if_awready(vp3_station_u__i_req_local_if_awready),
  .i_req_local_if_awvalid(vp3_station_u__i_req_local_if_awvalid),
  .i_req_local_if_w(vp3_station_u__i_req_local_if_w),
  .i_req_local_if_wready(vp3_station_u__i_req_local_if_wready),
  .i_req_local_if_wvalid(vp3_station_u__i_req_local_if_wvalid),
  .i_req_ring_if_ar(vp3_station_u__i_req_ring_if_ar),
  .i_req_ring_if_arready(vp3_station_u__i_req_ring_if_arready),
  .i_req_ring_if_arvalid(vp3_station_u__i_req_ring_if_arvalid),
  .i_req_ring_if_aw(vp3_station_u__i_req_ring_if_aw),
  .i_req_ring_if_awready(vp3_station_u__i_req_ring_if_awready),
  .i_req_ring_if_awvalid(vp3_station_u__i_req_ring_if_awvalid),
  .i_req_ring_if_w(vp3_station_u__i_req_ring_if_w),
  .i_req_ring_if_wready(vp3_station_u__i_req_ring_if_wready),
  .i_req_ring_if_wvalid(vp3_station_u__i_req_ring_if_wvalid),
  .i_resp_local_if_b(vp3_station_u__i_resp_local_if_b),
  .i_resp_local_if_bready(vp3_station_u__i_resp_local_if_bready),
  .i_resp_local_if_bvalid(vp3_station_u__i_resp_local_if_bvalid),
  .i_resp_local_if_r(vp3_station_u__i_resp_local_if_r),
  .i_resp_local_if_rready(vp3_station_u__i_resp_local_if_rready),
  .i_resp_local_if_rvalid(vp3_station_u__i_resp_local_if_rvalid),
  .i_resp_ring_if_b(vp3_station_u__i_resp_ring_if_b),
  .i_resp_ring_if_bready(vp3_station_u__i_resp_ring_if_bready),
  .i_resp_ring_if_bvalid(vp3_station_u__i_resp_ring_if_bvalid),
  .i_resp_ring_if_r(vp3_station_u__i_resp_ring_if_r),
  .i_resp_ring_if_rready(vp3_station_u__i_resp_ring_if_rready),
  .i_resp_ring_if_rvalid(vp3_station_u__i_resp_ring_if_rvalid),
  .in_b2s_debug_stall_out(vp3_station_u__in_b2s_debug_stall_out),
  .in_b2s_is_vtlb_excp(vp3_station_u__in_b2s_is_vtlb_excp),
  .in_b2s_itb_last_ptr(vp3_station_u__in_b2s_itb_last_ptr),
  .in_b2s_vload_drt_req_vlen_illegal(vp3_station_u__in_b2s_vload_drt_req_vlen_illegal),
  .o_req_local_if_ar(vp3_station_u__o_req_local_if_ar),
  .o_req_local_if_arready(vp3_station_u__o_req_local_if_arready),
  .o_req_local_if_arvalid(vp3_station_u__o_req_local_if_arvalid),
  .o_req_local_if_aw(vp3_station_u__o_req_local_if_aw),
  .o_req_local_if_awready(vp3_station_u__o_req_local_if_awready),
  .o_req_local_if_awvalid(vp3_station_u__o_req_local_if_awvalid),
  .o_req_local_if_w(vp3_station_u__o_req_local_if_w),
  .o_req_local_if_wready(vp3_station_u__o_req_local_if_wready),
  .o_req_local_if_wvalid(vp3_station_u__o_req_local_if_wvalid),
  .o_req_ring_if_ar(vp3_station_u__o_req_ring_if_ar),
  .o_req_ring_if_arready(vp3_station_u__o_req_ring_if_arready),
  .o_req_ring_if_arvalid(vp3_station_u__o_req_ring_if_arvalid),
  .o_req_ring_if_aw(vp3_station_u__o_req_ring_if_aw),
  .o_req_ring_if_awready(vp3_station_u__o_req_ring_if_awready),
  .o_req_ring_if_awvalid(vp3_station_u__o_req_ring_if_awvalid),
  .o_req_ring_if_w(vp3_station_u__o_req_ring_if_w),
  .o_req_ring_if_wready(vp3_station_u__o_req_ring_if_wready),
  .o_req_ring_if_wvalid(vp3_station_u__o_req_ring_if_wvalid),
  .o_resp_local_if_b(vp3_station_u__o_resp_local_if_b),
  .o_resp_local_if_bready(vp3_station_u__o_resp_local_if_bready),
  .o_resp_local_if_bvalid(vp3_station_u__o_resp_local_if_bvalid),
  .o_resp_local_if_r(vp3_station_u__o_resp_local_if_r),
  .o_resp_local_if_rready(vp3_station_u__o_resp_local_if_rready),
  .o_resp_local_if_rvalid(vp3_station_u__o_resp_local_if_rvalid),
  .o_resp_ring_if_b(vp3_station_u__o_resp_ring_if_b),
  .o_resp_ring_if_bready(vp3_station_u__o_resp_ring_if_bready),
  .o_resp_ring_if_bvalid(vp3_station_u__o_resp_ring_if_bvalid),
  .o_resp_ring_if_r(vp3_station_u__o_resp_ring_if_r),
  .o_resp_ring_if_rready(vp3_station_u__o_resp_ring_if_rready),
  .o_resp_ring_if_rvalid(vp3_station_u__o_resp_ring_if_rvalid),
  .out_b2s_debug_stall_out(vp3_station_u__out_b2s_debug_stall_out),
  .out_b2s_is_vtlb_excp(vp3_station_u__out_b2s_is_vtlb_excp),
  .out_b2s_itb_last_ptr(vp3_station_u__out_b2s_itb_last_ptr),
  .out_b2s_vload_drt_req_vlen_illegal(vp3_station_u__out_b2s_vload_drt_req_vlen_illegal),
  .out_s2b_bp_if_pc_0(vp3_station_u__out_s2b_bp_if_pc_0),
  .out_s2b_bp_if_pc_1(vp3_station_u__out_s2b_bp_if_pc_1),
  .out_s2b_bp_if_pc_2(vp3_station_u__out_s2b_bp_if_pc_2),
  .out_s2b_bp_if_pc_3(vp3_station_u__out_s2b_bp_if_pc_3),
  .out_s2b_bp_instret(vp3_station_u__out_s2b_bp_instret),
  .out_s2b_bp_wb_pc_0(vp3_station_u__out_s2b_bp_wb_pc_0),
  .out_s2b_bp_wb_pc_1(vp3_station_u__out_s2b_bp_wb_pc_1),
  .out_s2b_bp_wb_pc_2(vp3_station_u__out_s2b_bp_wb_pc_2),
  .out_s2b_bp_wb_pc_3(vp3_station_u__out_s2b_bp_wb_pc_3),
  .out_s2b_cfg_bypass_ic(vp3_station_u__out_s2b_cfg_bypass_ic),
  .out_s2b_cfg_bypass_tlb(vp3_station_u__out_s2b_cfg_bypass_tlb),
  .out_s2b_cfg_en_hpmcounter(vp3_station_u__out_s2b_cfg_en_hpmcounter),
  .out_s2b_cfg_itb_en(vp3_station_u__out_s2b_cfg_itb_en),
  .out_s2b_cfg_itb_sel(vp3_station_u__out_s2b_cfg_itb_sel),
  .out_s2b_cfg_itb_wrap_around(vp3_station_u__out_s2b_cfg_itb_wrap_around),
  .out_s2b_cfg_lfsr_seed(vp3_station_u__out_s2b_cfg_lfsr_seed),
  .out_s2b_cfg_pwr_on(vp3_station_u__out_s2b_cfg_pwr_on),
  .out_s2b_cfg_rst_pc(vp3_station_u__out_s2b_cfg_rst_pc),
  .out_s2b_cfg_sleep(vp3_station_u__out_s2b_cfg_sleep),
  .out_s2b_debug_resume(vp3_station_u__out_s2b_debug_resume),
  .out_s2b_debug_stall(vp3_station_u__out_s2b_debug_stall),
  .out_s2b_early_rstn(vp3_station_u__out_s2b_early_rstn),
  .out_s2b_en_bp_if_pc_0(vp3_station_u__out_s2b_en_bp_if_pc_0),
  .out_s2b_en_bp_if_pc_1(vp3_station_u__out_s2b_en_bp_if_pc_1),
  .out_s2b_en_bp_if_pc_2(vp3_station_u__out_s2b_en_bp_if_pc_2),
  .out_s2b_en_bp_if_pc_3(vp3_station_u__out_s2b_en_bp_if_pc_3),
  .out_s2b_en_bp_instret(vp3_station_u__out_s2b_en_bp_instret),
  .out_s2b_en_bp_wb_pc_0(vp3_station_u__out_s2b_en_bp_wb_pc_0),
  .out_s2b_en_bp_wb_pc_1(vp3_station_u__out_s2b_en_bp_wb_pc_1),
  .out_s2b_en_bp_wb_pc_2(vp3_station_u__out_s2b_en_bp_wb_pc_2),
  .out_s2b_en_bp_wb_pc_3(vp3_station_u__out_s2b_en_bp_wb_pc_3),
  .out_s2b_ext_event(vp3_station_u__out_s2b_ext_event),
  .out_s2b_powerline_ctrl(vp3_station_u__out_s2b_powerline_ctrl),
  .out_s2b_powervbank_ctrl(vp3_station_u__out_s2b_powervbank_ctrl),
  .out_s2b_rstn(vp3_station_u__out_s2b_rstn),
  .out_s2b_vcore_en(vp3_station_u__out_s2b_vcore_en),
  .out_s2b_vcore_icg_disable(vp3_station_u__out_s2b_vcore_icg_disable),
  .out_s2b_vcore_pmu_en(vp3_station_u__out_s2b_vcore_pmu_en),
  .out_s2b_vcore_pmu_evt_mask(vp3_station_u__out_s2b_vcore_pmu_evt_mask),
  .out_s2icg_clk_en(vp3_station_u__out_s2icg_clk_en),
  .rstn(vp3_station_u__rstn),
  .vld_in_b2s_debug_stall_out(vp3_station_u__vld_in_b2s_debug_stall_out),
  .vld_in_b2s_is_vtlb_excp(vp3_station_u__vld_in_b2s_is_vtlb_excp),
  .vld_in_b2s_itb_last_ptr(vp3_station_u__vld_in_b2s_itb_last_ptr),
  .vld_in_b2s_vload_drt_req_vlen_illegal(vp3_station_u__vld_in_b2s_vload_drt_req_vlen_illegal)
);
`endif

dft_and vp3_sysbus_arvalid_and_u(
  .in0(vp3_sysbus_arvalid_and_u__in0),
  .in1(vp3_sysbus_arvalid_and_u__in1),
  .out(vp3_sysbus_arvalid_and_u__out)
);

dft_and vp3_sysbus_awvalid_and_u(
  .in0(vp3_sysbus_awvalid_and_u__in0),
  .in1(vp3_sysbus_awvalid_and_u__in1),
  .out(vp3_sysbus_awvalid_and_u__out)
);

dft_and vp3_sysbus_wvalid_and_u(
  .in0(vp3_sysbus_wvalid_and_u__in0),
  .in1(vp3_sysbus_wvalid_and_u__in1),
  .out(vp3_sysbus_wvalid_and_u__out)
);

`ifdef IFDEF_FPGA__IFNDEF_SINGLE_VP
vcore_fp_top #(.USEDW(2)) vp3_u(
  .b2s_debug_stall_out(vp3_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp3_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp3_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp3_u__cache_req_if_req),
  .cache_req_if_req_ready(vp3_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp3_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp3_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp3_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp3_u__cache_resp_if_resp_valid),
  .clk(vp3_u__clk),
  .core_id(vp3_u__core_id),
  .cpu_amo_store_req(vp3_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp3_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp3_u__cpu_amo_store_req_valid),
  .external_int(vp3_u__external_int),
  .load_vtlb_excp(vp3_u__load_vtlb_excp),
  .ring_req_if_ar(vp3_u__ring_req_if_ar),
  .ring_req_if_arready(vp3_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp3_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp3_u__ring_req_if_aw),
  .ring_req_if_awready(vp3_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp3_u__ring_req_if_awvalid),
  .ring_req_if_w(vp3_u__ring_req_if_w),
  .ring_req_if_wready(vp3_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp3_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp3_u__ring_resp_if_b),
  .ring_resp_if_bready(vp3_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp3_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp3_u__ring_resp_if_r),
  .ring_resp_if_rready(vp3_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp3_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp3_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp3_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp3_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp3_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp3_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp3_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp3_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp3_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp3_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp3_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp3_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp3_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp3_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp3_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp3_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp3_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp3_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp3_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp3_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp3_u__s2b_debug_resume),
  .s2b_debug_stall(vp3_u__s2b_debug_stall),
  .s2b_early_rstn(vp3_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp3_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp3_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp3_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp3_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp3_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp3_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp3_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp3_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp3_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp3_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp3_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp3_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp3_u__s2b_rstn),
  .s2b_vcore_en(vp3_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp3_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp3_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp3_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp3_u__software_int),
  .sysbus_req_if_ar(vp3_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp3_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp3_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp3_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp3_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp3_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp3_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp3_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp3_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp3_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp3_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp3_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp3_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp3_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp3_u__sysbus_resp_if_rvalid),
  .timer_int(vp3_u__timer_int),
  .wfe_stall(vp3_u__wfe_stall),
  .wfi_stall(vp3_u__wfi_stall)
);
`endif

dft_and vp3_vlsu_int_and_u(
  .in0(vp3_vlsu_int_and_u__in0),
  .in1(vp3_vlsu_int_and_u__in1),
  .out(vp3_vlsu_int_and_u__out)
);

`ifdef IFNDEF_FPGA
vcore_fp_top #() vp0_u(
  .b2s_debug_stall_out(vp0_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp0_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp0_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp0_u__cache_req_if_req),
  .cache_req_if_req_ready(vp0_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp0_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp0_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp0_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp0_u__cache_resp_if_resp_valid),
  .clk(vp0_u__clk),
  .core_id(vp0_u__core_id),
  .cpu_amo_store_req(vp0_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp0_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp0_u__cpu_amo_store_req_valid),
  .external_int(vp0_u__external_int),
  .load_vtlb_excp(vp0_u__load_vtlb_excp),
  .ring_req_if_ar(vp0_u__ring_req_if_ar),
  .ring_req_if_arready(vp0_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp0_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp0_u__ring_req_if_aw),
  .ring_req_if_awready(vp0_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp0_u__ring_req_if_awvalid),
  .ring_req_if_w(vp0_u__ring_req_if_w),
  .ring_req_if_wready(vp0_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp0_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp0_u__ring_resp_if_b),
  .ring_resp_if_bready(vp0_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp0_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp0_u__ring_resp_if_r),
  .ring_resp_if_rready(vp0_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp0_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp0_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp0_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp0_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp0_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp0_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp0_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp0_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp0_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp0_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp0_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp0_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp0_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp0_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp0_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp0_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp0_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp0_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp0_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp0_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp0_u__s2b_debug_resume),
  .s2b_debug_stall(vp0_u__s2b_debug_stall),
  .s2b_early_rstn(vp0_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp0_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp0_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp0_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp0_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp0_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp0_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp0_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp0_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp0_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp0_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp0_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp0_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp0_u__s2b_rstn),
  .s2b_vcore_en(vp0_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp0_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp0_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp0_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp0_u__software_int),
  .sysbus_req_if_ar(vp0_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp0_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp0_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp0_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp0_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp0_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp0_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp0_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp0_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp0_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp0_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp0_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp0_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp0_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp0_u__sysbus_resp_if_rvalid),
  .timer_int(vp0_u__timer_int),
  .wfe_stall(vp0_u__wfe_stall),
  .wfi_stall(vp0_u__wfi_stall)
);
`endif

`ifdef IFDEF_FPGA__IFDEF_SINGLE_VP
vcore_fp_top #(.USEDW(2)) vp0_u(
  .b2s_debug_stall_out(vp0_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp0_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp0_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp0_u__cache_req_if_req),
  .cache_req_if_req_ready(vp0_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp0_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp0_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp0_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp0_u__cache_resp_if_resp_valid),
  .clk(vp0_u__clk),
  .core_id(vp0_u__core_id),
  .cpu_amo_store_req(vp0_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp0_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp0_u__cpu_amo_store_req_valid),
  .external_int(vp0_u__external_int),
  .load_vtlb_excp(vp0_u__load_vtlb_excp),
  .ring_req_if_ar(vp0_u__ring_req_if_ar),
  .ring_req_if_arready(vp0_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp0_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp0_u__ring_req_if_aw),
  .ring_req_if_awready(vp0_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp0_u__ring_req_if_awvalid),
  .ring_req_if_w(vp0_u__ring_req_if_w),
  .ring_req_if_wready(vp0_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp0_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp0_u__ring_resp_if_b),
  .ring_resp_if_bready(vp0_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp0_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp0_u__ring_resp_if_r),
  .ring_resp_if_rready(vp0_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp0_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp0_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp0_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp0_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp0_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp0_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp0_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp0_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp0_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp0_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp0_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp0_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp0_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp0_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp0_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp0_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp0_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp0_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp0_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp0_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp0_u__s2b_debug_resume),
  .s2b_debug_stall(vp0_u__s2b_debug_stall),
  .s2b_early_rstn(vp0_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp0_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp0_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp0_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp0_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp0_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp0_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp0_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp0_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp0_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp0_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp0_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp0_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp0_u__s2b_rstn),
  .s2b_vcore_en(vp0_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp0_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp0_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp0_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp0_u__software_int),
  .sysbus_req_if_ar(vp0_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp0_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp0_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp0_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp0_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp0_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp0_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp0_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp0_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp0_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp0_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp0_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp0_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp0_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp0_u__sysbus_resp_if_rvalid),
  .timer_int(vp0_u__timer_int),
  .wfe_stall(vp0_u__wfe_stall),
  .wfi_stall(vp0_u__wfi_stall)
);
`endif

`ifdef IFNDEF_FPGA
vcore_fp_top #() vp1_u(
  .b2s_debug_stall_out(vp1_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp1_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp1_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp1_u__cache_req_if_req),
  .cache_req_if_req_ready(vp1_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp1_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp1_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp1_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp1_u__cache_resp_if_resp_valid),
  .clk(vp1_u__clk),
  .core_id(vp1_u__core_id),
  .cpu_amo_store_req(vp1_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp1_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp1_u__cpu_amo_store_req_valid),
  .external_int(vp1_u__external_int),
  .load_vtlb_excp(vp1_u__load_vtlb_excp),
  .ring_req_if_ar(vp1_u__ring_req_if_ar),
  .ring_req_if_arready(vp1_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp1_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp1_u__ring_req_if_aw),
  .ring_req_if_awready(vp1_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp1_u__ring_req_if_awvalid),
  .ring_req_if_w(vp1_u__ring_req_if_w),
  .ring_req_if_wready(vp1_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp1_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp1_u__ring_resp_if_b),
  .ring_resp_if_bready(vp1_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp1_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp1_u__ring_resp_if_r),
  .ring_resp_if_rready(vp1_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp1_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp1_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp1_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp1_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp1_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp1_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp1_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp1_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp1_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp1_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp1_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp1_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp1_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp1_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp1_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp1_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp1_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp1_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp1_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp1_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp1_u__s2b_debug_resume),
  .s2b_debug_stall(vp1_u__s2b_debug_stall),
  .s2b_early_rstn(vp1_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp1_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp1_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp1_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp1_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp1_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp1_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp1_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp1_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp1_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp1_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp1_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp1_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp1_u__s2b_rstn),
  .s2b_vcore_en(vp1_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp1_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp1_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp1_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp1_u__software_int),
  .sysbus_req_if_ar(vp1_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp1_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp1_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp1_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp1_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp1_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp1_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp1_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp1_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp1_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp1_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp1_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp1_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp1_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp1_u__sysbus_resp_if_rvalid),
  .timer_int(vp1_u__timer_int),
  .wfe_stall(vp1_u__wfe_stall),
  .wfi_stall(vp1_u__wfi_stall)
);
`endif

`ifdef IFNDEF_FPGA
vcore_fp_top #() vp2_u(
  .b2s_debug_stall_out(vp2_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp2_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp2_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp2_u__cache_req_if_req),
  .cache_req_if_req_ready(vp2_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp2_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp2_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp2_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp2_u__cache_resp_if_resp_valid),
  .clk(vp2_u__clk),
  .core_id(vp2_u__core_id),
  .cpu_amo_store_req(vp2_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp2_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp2_u__cpu_amo_store_req_valid),
  .external_int(vp2_u__external_int),
  .load_vtlb_excp(vp2_u__load_vtlb_excp),
  .ring_req_if_ar(vp2_u__ring_req_if_ar),
  .ring_req_if_arready(vp2_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp2_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp2_u__ring_req_if_aw),
  .ring_req_if_awready(vp2_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp2_u__ring_req_if_awvalid),
  .ring_req_if_w(vp2_u__ring_req_if_w),
  .ring_req_if_wready(vp2_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp2_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp2_u__ring_resp_if_b),
  .ring_resp_if_bready(vp2_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp2_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp2_u__ring_resp_if_r),
  .ring_resp_if_rready(vp2_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp2_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp2_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp2_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp2_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp2_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp2_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp2_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp2_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp2_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp2_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp2_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp2_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp2_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp2_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp2_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp2_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp2_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp2_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp2_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp2_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp2_u__s2b_debug_resume),
  .s2b_debug_stall(vp2_u__s2b_debug_stall),
  .s2b_early_rstn(vp2_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp2_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp2_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp2_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp2_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp2_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp2_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp2_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp2_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp2_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp2_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp2_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp2_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp2_u__s2b_rstn),
  .s2b_vcore_en(vp2_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp2_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp2_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp2_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp2_u__software_int),
  .sysbus_req_if_ar(vp2_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp2_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp2_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp2_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp2_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp2_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp2_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp2_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp2_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp2_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp2_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp2_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp2_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp2_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp2_u__sysbus_resp_if_rvalid),
  .timer_int(vp2_u__timer_int),
  .wfe_stall(vp2_u__wfe_stall),
  .wfi_stall(vp2_u__wfi_stall)
);
`endif

`ifdef IFNDEF_FPGA
vcore_fp_top #() vp3_u(
  .b2s_debug_stall_out(vp3_u__b2s_debug_stall_out),
  .b2s_itb_last_ptr(vp3_u__b2s_itb_last_ptr),
  .b2s_vload_drt_req_vlen_illegal(vp3_u__b2s_vload_drt_req_vlen_illegal),
  .cache_req_if_req(vp3_u__cache_req_if_req),
  .cache_req_if_req_ready(vp3_u__cache_req_if_req_ready),
  .cache_req_if_req_valid(vp3_u__cache_req_if_req_valid),
  .cache_resp_if_resp(vp3_u__cache_resp_if_resp),
  .cache_resp_if_resp_ready(vp3_u__cache_resp_if_resp_ready),
  .cache_resp_if_resp_valid(vp3_u__cache_resp_if_resp_valid),
  .clk(vp3_u__clk),
  .core_id(vp3_u__core_id),
  .cpu_amo_store_req(vp3_u__cpu_amo_store_req),
  .cpu_amo_store_req_ready(vp3_u__cpu_amo_store_req_ready),
  .cpu_amo_store_req_valid(vp3_u__cpu_amo_store_req_valid),
  .external_int(vp3_u__external_int),
  .load_vtlb_excp(vp3_u__load_vtlb_excp),
  .ring_req_if_ar(vp3_u__ring_req_if_ar),
  .ring_req_if_arready(vp3_u__ring_req_if_arready),
  .ring_req_if_arvalid(vp3_u__ring_req_if_arvalid),
  .ring_req_if_aw(vp3_u__ring_req_if_aw),
  .ring_req_if_awready(vp3_u__ring_req_if_awready),
  .ring_req_if_awvalid(vp3_u__ring_req_if_awvalid),
  .ring_req_if_w(vp3_u__ring_req_if_w),
  .ring_req_if_wready(vp3_u__ring_req_if_wready),
  .ring_req_if_wvalid(vp3_u__ring_req_if_wvalid),
  .ring_resp_if_b(vp3_u__ring_resp_if_b),
  .ring_resp_if_bready(vp3_u__ring_resp_if_bready),
  .ring_resp_if_bvalid(vp3_u__ring_resp_if_bvalid),
  .ring_resp_if_r(vp3_u__ring_resp_if_r),
  .ring_resp_if_rready(vp3_u__ring_resp_if_rready),
  .ring_resp_if_rvalid(vp3_u__ring_resp_if_rvalid),
  .s2b_bp_if_pc_0(vp3_u__s2b_bp_if_pc_0),
  .s2b_bp_if_pc_1(vp3_u__s2b_bp_if_pc_1),
  .s2b_bp_if_pc_2(vp3_u__s2b_bp_if_pc_2),
  .s2b_bp_if_pc_3(vp3_u__s2b_bp_if_pc_3),
  .s2b_bp_instret(vp3_u__s2b_bp_instret),
  .s2b_bp_wb_pc_0(vp3_u__s2b_bp_wb_pc_0),
  .s2b_bp_wb_pc_1(vp3_u__s2b_bp_wb_pc_1),
  .s2b_bp_wb_pc_2(vp3_u__s2b_bp_wb_pc_2),
  .s2b_bp_wb_pc_3(vp3_u__s2b_bp_wb_pc_3),
  .s2b_cfg_bypass_ic(vp3_u__s2b_cfg_bypass_ic),
  .s2b_cfg_bypass_tlb(vp3_u__s2b_cfg_bypass_tlb),
  .s2b_cfg_en_hpmcounter(vp3_u__s2b_cfg_en_hpmcounter),
  .s2b_cfg_itb_en(vp3_u__s2b_cfg_itb_en),
  .s2b_cfg_itb_sel(vp3_u__s2b_cfg_itb_sel),
  .s2b_cfg_itb_wrap_around(vp3_u__s2b_cfg_itb_wrap_around),
  .s2b_cfg_lfsr_seed(vp3_u__s2b_cfg_lfsr_seed),
  .s2b_cfg_pwr_on(vp3_u__s2b_cfg_pwr_on),
  .s2b_cfg_rst_pc(vp3_u__s2b_cfg_rst_pc),
  .s2b_cfg_sleep(vp3_u__s2b_cfg_sleep),
  .s2b_debug_resume(vp3_u__s2b_debug_resume),
  .s2b_debug_stall(vp3_u__s2b_debug_stall),
  .s2b_early_rstn(vp3_u__s2b_early_rstn),
  .s2b_en_bp_if_pc_0(vp3_u__s2b_en_bp_if_pc_0),
  .s2b_en_bp_if_pc_1(vp3_u__s2b_en_bp_if_pc_1),
  .s2b_en_bp_if_pc_2(vp3_u__s2b_en_bp_if_pc_2),
  .s2b_en_bp_if_pc_3(vp3_u__s2b_en_bp_if_pc_3),
  .s2b_en_bp_instret(vp3_u__s2b_en_bp_instret),
  .s2b_en_bp_wb_pc_0(vp3_u__s2b_en_bp_wb_pc_0),
  .s2b_en_bp_wb_pc_1(vp3_u__s2b_en_bp_wb_pc_1),
  .s2b_en_bp_wb_pc_2(vp3_u__s2b_en_bp_wb_pc_2),
  .s2b_en_bp_wb_pc_3(vp3_u__s2b_en_bp_wb_pc_3),
  .s2b_ext_event(vp3_u__s2b_ext_event),
  .s2b_powerline_ctrl(vp3_u__s2b_powerline_ctrl),
  .s2b_powervbank_ctrl(vp3_u__s2b_powervbank_ctrl),
  .s2b_rstn(vp3_u__s2b_rstn),
  .s2b_vcore_en(vp3_u__s2b_vcore_en),
  .s2b_vcore_icg_disable(vp3_u__s2b_vcore_icg_disable),
  .s2b_vcore_pmu_en(vp3_u__s2b_vcore_pmu_en),
  .s2b_vcore_pmu_evt_mask(vp3_u__s2b_vcore_pmu_evt_mask),
  .software_int(vp3_u__software_int),
  .sysbus_req_if_ar(vp3_u__sysbus_req_if_ar),
  .sysbus_req_if_arready(vp3_u__sysbus_req_if_arready),
  .sysbus_req_if_arvalid(vp3_u__sysbus_req_if_arvalid),
  .sysbus_req_if_aw(vp3_u__sysbus_req_if_aw),
  .sysbus_req_if_awready(vp3_u__sysbus_req_if_awready),
  .sysbus_req_if_awvalid(vp3_u__sysbus_req_if_awvalid),
  .sysbus_req_if_w(vp3_u__sysbus_req_if_w),
  .sysbus_req_if_wready(vp3_u__sysbus_req_if_wready),
  .sysbus_req_if_wvalid(vp3_u__sysbus_req_if_wvalid),
  .sysbus_resp_if_b(vp3_u__sysbus_resp_if_b),
  .sysbus_resp_if_bready(vp3_u__sysbus_resp_if_bready),
  .sysbus_resp_if_bvalid(vp3_u__sysbus_resp_if_bvalid),
  .sysbus_resp_if_r(vp3_u__sysbus_resp_if_r),
  .sysbus_resp_if_rready(vp3_u__sysbus_resp_if_rready),
  .sysbus_resp_if_rvalid(vp3_u__sysbus_resp_if_rvalid),
  .timer_int(vp3_u__timer_int),
  .wfe_stall(vp3_u__wfe_stall),
  .wfi_stall(vp3_u__wfi_stall)
);
`endif

endmodule
