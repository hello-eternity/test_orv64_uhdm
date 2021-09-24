// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module oursring_resp_arbiter
#(
  parameter N_IN_PORT = 3
) (
  // input side
  input   logic [N_IN_PORT-1:0] i_rvalid, i_rlast,   // R
                                i_bvalid,            // B

  output  logic [N_IN_PORT-1:0] i_rready,            // R
                                i_bready,            // B

  input   logic                 o_rready,
                                o_bready,

  // rst & clk
  input   logic                 rstn, clk
);

`ifndef SYNTHESIS
  import ours_logging::*;
  chk_rready_one_hot: assert property (@(posedge clk) disable iff (rstn === '0) ((|i_rready) |-> $onehot(i_rready))) else `olog_error("OURSRING_REQ_ARBITER", $sformatf("%m: i_rready is not one-hot 'b%b", i_rready));
  chk_bready_one_hot: assert property (@(posedge clk) disable iff (rstn === '0) ((|i_bready) |-> $onehot(i_bready))) else `olog_error("OURSRING_REQ_ARBITER", $sformatf("%m: i_bready is not one-hot 'b%b", i_bready));
`endif

  //==========================================================
  // R {{{
  // R support burst
  logic [N_IN_PORT-1:0] is_hold_r, rff_is_hold_r;
  logic busy_r;

  always_comb begin
    for (int i=0; i<N_IN_PORT; i++) begin
      i_rready[i] = '0;
    end

    is_hold_r = rff_is_hold_r;
    busy_r = |rff_is_hold_r;
    if (~busy_r) begin
      for (int i=0; i<N_IN_PORT; i++) begin
        if (i_rvalid[i]) begin
          i_rready[i] = o_rready; //spyglass disable W415a
          is_hold_r[i] = i_rready[i] & ~i_rlast[i]; //spyglass disable W415a
          break;
        end
      end
    end else begin
      for (int i=0; i<N_IN_PORT; i++) begin
        if (i_rvalid[i] & rff_is_hold_r[i]) begin
          i_rready[i] = o_rready; //spyglass disable W415a
          is_hold_r[i] = i_rready[i] & ~i_rlast[i]; //spyglass disable W415a
        end
      end
    end
  end
  // }}}

  //==========================================================
  // B {{{
  always_comb begin
    for (int i=0; i<N_IN_PORT; i++) begin
      i_bready[i] = '0;
    end

    for (int i=0; i<N_IN_PORT; i++) begin
      if (i_bvalid[i]) begin
        i_bready[i] = o_bready; //spyglass disable W415a
        break;
      end
    end
  end
  // }}}

  always_ff @ (posedge clk) begin
    if (~rstn) begin
      rff_is_hold_r <= '0;
    end else begin
      rff_is_hold_r <= is_hold_r;
    end
  end

endmodule
