module orv64_clk_gating
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
#(parameter DRIVEN=4) (
  output  clkg,
  input   en, tst_en, rst, clk
);
    assign clkg = clk;
endmodule
