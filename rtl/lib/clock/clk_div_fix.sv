
module clk_div_fix_pwr2 #(
  parameter int DIV = 8,
  parameter int WITH_CLK_MUX = 1
) (
  input   logic refclk,
  input   logic divclk_sel, // 1 -> select divided clock, 0 -> select refclk
  input   logic dft_en,
  output  logic divclk
  );



  assign divclk = refclk;

endmodule

