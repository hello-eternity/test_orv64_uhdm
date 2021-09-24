
module clk_div_fix_pwr2 #(
  parameter int DIV = 8,
  parameter int WITH_CLK_MUX = 1
) (
  input   logic refclk,
  input   logic divclk_sel, // 1 -> select divided clock, 0 -> select refclk
  input   logic dft_en,
  output  logic divclk
  );

`ifndef FPGA

  logic dff_cnt;
  logic divclk_temp;
  logic  clk_sel_final;
  logic  div_en;

  assign clk_sel_final = dft_en ? 1'b0 : divclk_sel;
  assign div_en        = dft_en ? 1'b1 : divclk_sel;


  clk_div_pwr2 #(.DIV(DIV)) clk_div_pwr2_u (
    .refclk 	(refclk),
    .divclk_sel	(clk_sel_final),
    .dff_cnt_msb(dff_cnt)
  );

`ifdef USE_T28HPCP
  CKBD8BWP30P140 clk_buf (.Z(divclk_temp), .I(dff_cnt));
`else
  assign divclk_temp = dff_cnt;
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

