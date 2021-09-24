
module clk_div # (parameter int MAX_DIV=64)
(
  input   logic refclk,
  input   logic [$clog2(MAX_DIV)-1:0] half_div_less_1,
  input   logic divclk_sel, // 1 -> select divided clock, 0 -> select refclk
  output  logic dff_divclk
);

  logic [$clog2(MAX_DIV)-1:0] dff_cnt, next_cnt;
  logic                       next_divclk;
  logic                       dff_round;

  `ifndef SYNTHESIS
    initial begin
      assert (MAX_DIV > 1) else $fatal("%m clk_div_cfg MAX_DIV (%d) <= 1", MAX_DIV);
      dff_cnt = $urandom;
      dff_divclk = $urandom;
      dff_round = $urandom;
      repeat(10) @(posedge refclk);
      //assert (divclk_sel == 1'b1) else $fatal ("%m clk_div_clg has to be turned on when initialized");
    end
  `endif

  // Divider
  always @(posedge refclk) begin
    if (divclk_sel) begin
      dff_cnt <= next_cnt;
      dff_round <= 1'b0;
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b0) & (dff_divclk == 1'b1)) begin
      dff_cnt <= next_cnt;
      dff_round <= 1'b0;
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b0) & (dff_divclk == 1'b0)) begin
      dff_cnt <= next_cnt;
      if (dff_cnt == half_div_less_1) begin
        dff_round <= 1'b1;
      end
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b1) & (dff_divclk == 1'b1)) begin
      dff_cnt <= next_cnt;
    end else if ((divclk_sel == 1'b0) & (dff_round == 1'b1) & (dff_divclk == 1'b0)) begin
      dff_cnt <= dff_cnt;
    end
  end
  always_comb begin
    next_cnt = dff_cnt + 1;
    if (dff_cnt >= half_div_less_1) begin
      next_cnt = {$clog2(MAX_DIV){1'b0}};
    end
  end

  // Div Clock Generation
  always @(posedge refclk) begin
    dff_divclk <= next_divclk;
  end
  always_comb begin
    next_divclk = dff_divclk;
    if (dff_cnt == half_div_less_1) begin
      next_divclk = ~dff_divclk;
    end
  end
 
endmodule
