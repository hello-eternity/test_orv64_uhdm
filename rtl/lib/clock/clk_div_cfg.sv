
module clk_div_cfg #(
  parameter int MAX_DIV = 64,
  parameter int WITH_CLK_MUX = 1
) (
  input   logic                       refclk,
  input   logic [$clog2(MAX_DIV)-1:0] half_div_less_1,
  input   logic						  dft_en,
  input   logic                       divclk_sel, // 1 -> select divided clock, 0 -> select refclk
  output  logic                       divclk
  );


  assign divclk = refclk;


endmodule

