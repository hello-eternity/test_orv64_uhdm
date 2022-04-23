
module pll (
  input   logic       refclk,
  input   logic       rstn,

  // Functional Mode
  input   logic [3:0] func_clkr,
  input   logic [5:0] func_clkf,
  input   logic [3:0] func_clkod,
  input   logic [5:0] func_bwadj,
  input   logic       func_reset,
  input   logic       func_intfb,
  input   logic       func_bypass,
  input   logic       func_test,
  input   logic       func_pwrdn,
  input   logic       func_clk_sel,
  input   logic       func_prog_done,

  // DFT Mode
  input   logic [3:0] dft_clkr,
  input   logic [5:0] dft_clkf,
  input   logic [3:0] dft_clkod,
  input   logic [5:0] dft_bwadj,
  input   logic       dft_reset,
  input   logic       dft_intfb,
  input   logic       dft_bypass,
  input   logic       dft_test,
  input   logic       dft_pwrdn,
  input   logic       dft_clk_sel,
  input   logic       dft_prog_done,

  // Mode Selection
  input   logic       mode_select,

  output  logic       pllclk,
  output  logic       rfslip,
  output  logic       fbslip
);

`ifdef USE_T28HPCP
  logic       pllclk_out;

  logic       pll_reset, pll_reset_d;
  assign pll_reset = mode_select ? dft_reset : func_reset;
  sync pll_reset_sync_u (.q(pll_reset_d), .d(pll_reset), .clk(refclk));

  logic       pll_bypass, pll_bypass_d;
  assign pll_bypass = mode_select ? dft_bypass : func_bypass;
  sync pll_bypass_sync_u (.q(pll_bypass_d), .d(pll_bypass), .clk(refclk));

  logic       pll_test, pll_test_d;
  assign pll_test = mode_select ? dft_test : func_test;
  sync pll_test_sync_u (.q(pll_test_d), .d(pll_test), .clk(refclk));

  logic       pll_pwrdn, pll_pwrdn_d;
  assign pll_pwrdn = mode_select ? dft_pwrdn : func_pwrdn;
  sync pll_pwrdn_sync_u (.q(pll_pwrdn_d), .d(pll_pwrdn), .clk(refclk));

  TCITSMCN28HPCPGPMPLLA1 tci_pll_u (
    .VDDA(), .VSSA(), .VDD(), .VSS(),
    .RCLK(refclk),
    .FCLK(pllclk_out),
    .CLKOUT(pllclk_out),
    .CLKR_0 (mode_select ? dft_clkr[0]  : func_clkr[0] ),
    .CLKR_1 (mode_select ? dft_clkr[1]  : func_clkr[1] ),
    .CLKR_2 (mode_select ? dft_clkr[2]  : func_clkr[2] ),
    .CLKR_3 (mode_select ? dft_clkr[3]  : func_clkr[3] ),
    .CLKF_0 (mode_select ? dft_clkf[0]  : func_clkf[0] ),
    .CLKF_1 (mode_select ? dft_clkf[1]  : func_clkf[1] ),
    .CLKF_2 (mode_select ? dft_clkf[2]  : func_clkf[2] ),
    .CLKF_3 (mode_select ? dft_clkf[3]  : func_clkf[3] ),
    .CLKF_4 (mode_select ? dft_clkf[4]  : func_clkf[4] ),
    .CLKF_5 (mode_select ? dft_clkf[5]  : func_clkf[5] ),
    .CLKOD_0(mode_select ? dft_clkod[0] : func_clkod[0]),
    .CLKOD_1(mode_select ? dft_clkod[1] : func_clkod[1]),
    .CLKOD_2(mode_select ? dft_clkod[2] : func_clkod[2]),
    .CLKOD_3(mode_select ? dft_clkod[3] : func_clkod[3]),
    .BWADJ_0(mode_select ? dft_bwadj[0] : func_bwadj[0]),
    .BWADJ_1(mode_select ? dft_bwadj[1] : func_bwadj[1]),
    .BWADJ_2(mode_select ? dft_bwadj[2] : func_bwadj[2]),
    .BWADJ_3(mode_select ? dft_bwadj[3] : func_bwadj[3]),
    .BWADJ_4(mode_select ? dft_bwadj[4] : func_bwadj[4]),
    .BWADJ_5(mode_select ? dft_bwadj[5] : func_bwadj[5]),
    .RESET  (pll_reset_d),
    .INTFB  (mode_select ? dft_intfb    : func_intfb   ),
    .BYPASS (pll_bypass_d),
    .TEST   (pll_test_d),
    .RFSLIP (rfslip),
    .FBSLIP (fbslip),
    .PWRDN  (pll_pwrdn_d)
  );

  glitch_free_clk_switch_rstn clk_sel_u (
  	.rstn	    (mode_select ? dft_clk_sel : rstn),
    .clk0     (refclk),
    .clk1     (pllclk_out),
    .sel      (mode_select ? dft_clk_sel : (rstn ? func_clk_sel : 1'b0)),
    .clk_out  (pllclk)
  );
`endif
`ifdef FPGA
  assign pllclk = refclk;
`endif
endmodule

