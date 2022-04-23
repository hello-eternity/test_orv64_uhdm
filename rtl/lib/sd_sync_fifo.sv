// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module sd_sync_fifo
# (
  parameter int WIDTH = 8,
  parameter int DEPTH = 8,
  parameter int TYPE = 0
) (
  // source side
  input   logic             s_valid,
  input   logic [WIDTH-1:0] s_data,
  output  logic             s_ready,
  // destination sid
  output  logic             d_valid,
  output  logic [WIDTH-1:0] d_data,
  input   logic             d_ready,
  // status logic
  output  logic             is_full, is_almost_full,
                            is_empty, is_almost_empty,
  // rst & clk
  input   logic             rstn,   // active-low reset
                            clk_s,  // source side clock
                            clk_d   // destination side clock
);

`ifndef SYNTHESIS
  initial begin
    assert (2**$clog2(DEPTH) == DEPTH) else $error("%m");
    assert (DEPTH >= 4) else $error("%m");
    assert ((TYPE == 0) || (TYPE == 1)) else $error("%m");
  end
`endif

  logic   [$clog2(DEPTH)-1:0] rff_wptr, next_wptr, // write pointer
                              rff_rptr, next_rptr; // read pointer
  logic                       re, we;
  logic   [WIDTH-1:0]         din, dout;

  generate
    if (TYPE == 0) begin: sram
`ifdef FPGA
      xsram_1r1w #(.WIDTH(WIDTH), .DEPTH(DEPTH)) sram_u (
        .AA(rff_wptr), .D(din), .BWEB(), .WEB(~we), .CLKW(clk_s),
        .AB(rff_rptr), .REB(~re), .CLKR(clk_d), .Q(dout), .SD(), .SLP()
      );
`endif
    end
    if (TYPE == 1) begin: flop
      flop_sram_1r1w #(.WIDTH(WIDTH), .DEPTH(DEPTH), .WITH_MASK(0), .WITH_SD(0), .WITH_SLP(0)) sram_u (
        .AA(rff_wptr), .D(din), .BWEB(), .WEB(~we), .CLKW(clk_s), //spyglass disable W287a BWEB
        .AB(rff_rptr), .REB(~re), .CLKR(clk_d), .Q(dout), .SD(), .SLP() //spyglass disable W287a
      );
    end
  endgenerate


  //==========================================================
  // full & empty {{{

  //logic   is_full,            is_empty;
  //logic   is_almost_full,     is_almost_empty;
  logic   rff_is_almost_full, rff_is_almost_empty;

  assign  next_wptr = rff_wptr + 1;
  assign  next_rptr = rff_rptr + 1;
  assign  is_almost_full = (next_wptr == rff_rptr) | is_full;
  assign  is_almost_empty = (next_rptr == rff_wptr) | is_empty;

  always_ff @ (posedge clk_s) begin
    if (~rstn) begin
      rff_wptr <= '0;
      rff_is_almost_full <= '0;
    end else begin
      if (we) begin
        rff_wptr <= next_wptr;
`ifndef SYNTHESIS
        assert (!is_full) else $error("sd_sync_fifo: write while full");
`endif
      end
      rff_is_almost_full <= is_almost_full;
    end
  end

  always_ff @ (posedge clk_d) begin
    if (~rstn) begin
      rff_rptr <= '0;
      rff_is_almost_empty <= '1;
    end else begin
      if (re) begin
        rff_rptr <= next_rptr;
`ifndef SYNTHESIS
        assert (!is_empty) else $error("sd_sync_fifo: read while empty");
`endif
      end
      rff_is_almost_empty <= is_almost_empty;
    end
  end

  assign  is_full = rff_is_almost_full & (rff_wptr == rff_rptr);
  assign  is_empty = rff_is_almost_empty & (rff_wptr == rff_rptr);
  // }}}

  //==========================================================
  // write {{{

  assign  din = s_data;
  assign  we = s_valid & ~is_full;

  assign  s_ready = ~is_full;
  // }}}

  //==========================================================
  // read {{{

  enum logic [1:0] {
    ST_EMPTY = 2'h0,
    ST_BYPASS = 2'h1,
    ST_HOLD = 2'h2
  } rff_state, next_state;

  logic [WIDTH-1:0] data_saved;
  logic             en_save;

  always_comb begin
    d_valid = '0;
    d_data = dout;

    next_state = rff_state;
    re = '0;
    en_save = '0;
    case (rff_state)
      ST_BYPASS: begin
        d_valid = '1;
        d_data = dout;

        if (d_ready) begin
          if (~is_empty) begin
            // d_ready & ~is_empty
            next_state = ST_BYPASS;
            re = '1;
            en_save = '0;
          end else begin
            // d_ready & is_empty
            next_state = ST_EMPTY;
            re = '0;
            en_save = '0;
          end
        end else begin
          // ~d_ready
          next_state = ST_HOLD;
          re = '0;
          en_save = '1;
        end
      end
      ST_HOLD: begin
        d_valid = '1;
        d_data = data_saved;

        if (d_ready) begin
          if (~is_empty) begin
            // d_ready & ~is_empty
            next_state = ST_BYPASS;
            re = '1;
            en_save = '0;
          end else begin
            // d_ready & is_empty
            next_state = ST_EMPTY;
            re = '0;
            en_save = '0;
          end
        end else begin
          // ~d_ready
          next_state = ST_HOLD;
          re = '0;
          en_save = '0;
        end
      end
      default: begin // ST_EMPTY
        d_valid ='0;
        if (~is_empty) begin
          next_state = ST_BYPASS;
          re = '1;
          en_save = '0;
        end else begin
          next_state = ST_EMPTY;
          re = '0;
          en_save = '0;
        end
      end
    endcase
  end

  always_ff @ (posedge clk_d) begin
    if (~rstn) begin
      rff_state <= ST_EMPTY;
    end else begin
      rff_state <= next_state;
      if (en_save) begin
        data_saved <= d_data;
      end
    end
  end

  // }}}
endmodule
