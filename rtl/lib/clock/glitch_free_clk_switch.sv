module glitch_free_clk_switch (
  input  logic clk0,
  input  logic clk1,
  input  logic sel,
  output logic clk_out
);

  // Synthesis
  // 1. set don't touch to the whole block, including nets and cells
  // PnR
  // 1. double space, double width for all the signals inside
  // 2. relative placement
  //  row-1: AND_SEL_CLK1, DF_SEL_CLK1_D1, DF_SEL_CLK1_D2, AND_CLK1
  //  row-2: INV_SEL
  //  row-3: AND_SEL_CLK0, DF_SEL_CLK0_D1, DF_SEL_CLK0_D2, AND_CLK0
  //  row-4: OR_OUT
`ifndef FPGA
`ifdef USE_T28HPCP
  wire clk_temp;
  wire sel_bar;
  wire sel_clk0, sel_clk0_d1_ff, sel_clk0_d2_ff, sel_clk0_d2_ff_bar, clk0_selected;
  wire sel_clk1, sel_clk1_d1_ff, sel_clk1_d2_ff, sel_clk1_d2_ff_bar, clk1_selected;

  CKAN2D4BWP35P140  AND_SEL_CLK1    (.A1(sel), .A2(sel_clk0_d2_ff_bar), .Z(sel_clk1));
  DFD4BWP35P140     DF_SEL_CLK1_D1  (.D(sel_clk1), .CP(clk1), .Q(sel_clk1_d1_ff), .QN());
  DFND4BWP35P140    DF_SEL_CLK1_D2  (.D(sel_clk1_d1_ff), .CPN(clk1), .Q(sel_clk1_d2_ff), .QN(sel_clk1_d2_ff_bar));
  CKAN2D8BWP35P140  AND_CLK1        (.A1(clk1), .A2(sel_clk1_d2_ff), .Z(clk1_selected));

  INVD4BWP35P140    INV_SEL         (.I(sel), .ZN(sel_bar));
  CKAN2D4BWP35P140  AND_SEL_CLK0    (.A1(sel_bar), .A2(sel_clk1_d2_ff_bar), .Z(sel_clk0));
  DFD4BWP35P140     DF_SEL_CLK0_D1  (.D(sel_clk0), .CP(clk0), .Q(sel_clk0_d1_ff), .QN());
  DFND4BWP35P140    DF_SEL_CLK0_D2  (.D(sel_clk0_d1_ff), .CPN(clk0), .Q(sel_clk0_d2_ff), .QN(sel_clk0_d2_ff_bar));
  CKAN2D8BWP35P140  AND_CLK0        (.A1(clk0), .A2(sel_clk0_d2_ff), .Z(clk0_selected));

  OR2D16BWP35P140   OR_OUT          (.A1(clk0_selected), .A2(clk1_selected), .Z(clk_temp));
  CKBD8BWP30P140    clk_buf (.Z(clk_out), .I(clk_temp));
`endif
`else
  assign clk_out = sel? clk1: clk0;
`endif


endmodule
