module orv64_itb_ram // instruction trace buffer ram {{{
  import orv64_typedef_pkg::*;
(
  input   logic             en,   // normal port is write only
          orv64_itb_data_t  data,
          orv64_itb_addr_t  addr,
  input   logic             dbg_en, dbg_rw, // debug port is read/write
          orv64_itb_data_t  dbg_din,
          orv64_itb_addr_t  dbg_addr,
  output  orv64_itb_data_t  dbg_dout,

  input   logic       cfg_pwr_on, cfg_sleep,
  input   logic       rst, clk
);

  // SRAM ports
  orv64_itb_data_t    Q, D, BWEB, rff_q;
  orv64_itb_addr_t    A;
  logic         CEB;
  logic         WEB, SD, SLP, CLK, dff_re;

  logic rclkg;

  icg rd_clk_u(
    .en       (dff_re),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (rclkg)
  );

  assign  CLK = clk;
  assign  BWEB = `ZERO_BITS(orv64_itb_data_t);

`ifdef SYNTHESIS
 flop_sram_1rw #(
    .WIDTH($bits(orv64_itb_data_t)),
    .DEPTH(2**$bits(orv64_itb_addr_t)),
    .WITH_MASK(0),
    .WITH_SD(1),
    .WITH_SLP(1),
    .SRAM_BEH(1)
  ) sram_u (.*);
`else
  flop_sram_1rw #(
    .WIDTH($bits(orv64_itb_data_t)),
    .DEPTH(2**$bits(orv64_itb_addr_t)),
    .WITH_MASK(0),
    .WITH_SD(1),
    .WITH_SLP(1),
    .SRAM_BEH(1)
  ) sram_u (.*);
`endif

  always_comb begin
    D = dbg_en ? dbg_din : data;
    A = dbg_en ? dbg_addr : addr;
    CEB = ~(dbg_en | en);
    WEB = ~(dbg_en ? dbg_rw : 1'b1);
    SD = ~cfg_pwr_on;
    SLP = cfg_sleep;

    dbg_dout = dff_re ? Q : rff_q;
  end

  always_ff @ (posedge clk) begin
    dff_re <= ~CEB & WEB;
  end

  always_ff @(posedge rclkg) begin
    if (dff_re) begin
      rff_q <= Q;
    end
  end

endmodule // }}}

