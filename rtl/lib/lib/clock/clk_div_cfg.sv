
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

`ifndef FPGA
  
  logic  dff_divclk;
  logic  divclk_temp;
  logic  clk_sel_final;
  logic  div_en;

  assign div_en        = dft_en ? 1'b1 : divclk_sel;
  assign clk_sel_final = dft_en ? 1'b0 : divclk_sel;

  clk_div #(.MAX_DIV(MAX_DIV)) clk_div_u (
    .refclk				(refclk),
    .half_div_less_1	(half_div_less_1),
    .divclk_sel			(div_en),
    .dff_divclk			(dff_divclk)
  );

`ifdef USE_T28HPCP
  CKBD8BWP30P140 clk_buf (.Z(divclk_temp), .I(dff_divclk));
`else
  assign divclk_temp = dff_divclk;
`endif

  // Clock Mux
  generate
    if (WITH_CLK_MUX == 1) begin : WITH_CLK_MUX_1
      glitch_free_clk_switch clk_mux_u (
        .clk0   (refclk),
        .clk1   (divclk_temp),
        .sel    (clk_sel_final),
        .clk_out(divclk)
        );
    end 
    else begin : WITH_CLK_MUX_0
      assign divclk = divclk_temp;
    end
  endgenerate

`else
  assign divclk = refclk;
`endif

endmodule

