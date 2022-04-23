
module clk_div_pwr2 # (parameter int DIV=64)
(
  input   logic refclk,
  input   logic divclk_sel, 
  output  logic dff_cnt_msb
);

  localparam HALF_DIV_LESS_1 = DIV / 2 - 1;

  logic [$clog2(DIV)-1:0] dff_cnt, next_cnt;
  logic dff_round;

  `ifndef SYNTHESIS
    initial begin
      assert (2 ** $clog2(DIV) == DIV) else $fatal("%m clk_div_fix DIV (%d) is not a power of 2", DIV);
      dff_cnt = $urandom;
      dff_round = $urandom;
      repeat(10) @(posedge refclk);
      //assert (divclk_sel == 1'b1) else $fatal("%m clk_div_fix has to be turned on when initialized");
    end
  `endif

  // Divider
  assign dff_cnt_msb = dff_cnt[$clog2(DIV)-1];

  always @(posedge refclk) begin
    if (divclk_sel) begin
      dff_cnt <= dff_cnt + 1;
      dff_round <= 1'b0;
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b0) & (dff_cnt[$clog2(DIV)-1] == 1'b1)) begin
      dff_cnt <= dff_cnt + 1;
      dff_round <= 1'b0;
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b0) & (dff_cnt[$clog2(DIV)-1] == 1'b0)) begin
      dff_cnt <= dff_cnt + 1;
      if (dff_cnt == HALF_DIV_LESS_1) begin
        dff_round <= 1'b1;
      end
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b1) & (dff_cnt[$clog2(DIV)-1] == 1'b1)) begin
      dff_cnt <= dff_cnt + 1;
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b1) & (dff_cnt[$clog2(DIV)-1] == 1'b0)) begin
      dff_cnt <= dff_cnt;
    end
  end
 
endmodule
