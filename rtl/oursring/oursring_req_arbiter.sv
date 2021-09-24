// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module oursring_req_arbiter
#(
  parameter N_IN_PORT = 3 // num of master port
) (
  // input side
  input   logic [N_IN_PORT-1:0] i_awvalid,          // AW
                                i_wvalid, i_wlast,  // W
                                i_arvalid,          // AR

  output  logic [N_IN_PORT-1:0] i_awready,          // AW
                                i_wready,           // W
                                i_arready,          // AR

  input   logic                 o_awready,
                                o_wready,
                                o_arready,

  // rst & clk
  input   logic                 rstn, clk
);

`ifndef SYNTHESIS
  import ours_logging::*;
  chk_awready_one_hot: assert property (@(posedge clk) disable iff (rstn === '0) ((|i_awready) |-> $onehot(i_awready))) else `olog_error("OURSRING_REQ_ARBITER", $sformatf("%m: i_awready is not one-hot 'b%b", i_awready));
  chk_wready_one_hot: assert property (@(posedge clk) disable iff (rstn === '0) ((|i_wready) |-> $onehot(i_wready))) else `olog_error("OURSRING_REQ_ARBITER", $sformatf("%m: i_wready is not one-hot 'b%b", i_wready));
  chk_arready_one_hot: assert property (@(posedge clk) disable iff (rstn === '0) ((|i_arready) |-> $onehot(i_arready))) else `olog_error("OURSRING_REQ_ARBITER", $sformatf("%m: i_arready is not one-hot 'b%b", i_arready));
`endif

  //==========================================================
  // AW + W {{{
  // AW and W have to wait for each other
  // W support burst
  logic [N_IN_PORT-1:0] is_hold_w, rff_is_hold_w;
  logic busy_w;

  always_comb begin
    for (int i=0; i<N_IN_PORT; i++) begin
      i_awready[i] = '0;
      i_wready[i] = '0;
    end

    is_hold_w = rff_is_hold_w;
    busy_w = |rff_is_hold_w;
    if (~busy_w) begin
      // not busy, and Rx is ready, select a new one to grant
      for (int i=0; i<N_IN_PORT; i++) begin
        // wait for Tx side both AW and W are valid, and Rx side both AW and W are ready
        if (i_awvalid[i] & i_wvalid[i]) begin
          i_awready[i] = o_awready & o_wready; //spyglass disable W415a
          i_wready[i]  = o_awready & o_wready; //spyglass disable W415a
          is_hold_w[i] = i_wready[i] & ~i_wlast[i]; //spyglass disable W415a
          break;
        end
      end
    end else begin
      // busy, select the existing one to grant
      for (int i=0; i<N_IN_PORT; i++) begin
        if (i_wvalid[i] & rff_is_hold_w[i]) begin
          i_wready[i]  = o_wready; //spyglass disable W415a
          is_hold_w[i] = i_wready[i] & ~i_wlast[i]; //spyglass disable W415a
        end
      end
    end
  end
  // }}}

  //==========================================================
  // AR {{{
  always_comb begin
    for (int i=0; i<N_IN_PORT; i++) begin
      i_arready[i] = '0;
    end

    for (int i=0; i<N_IN_PORT; i++) begin
      if (i_arvalid[i]) begin
        i_arready[i] = o_arready; //spyglass disable W415a
        break;
      end
    end
  end
  // }}}

  always_ff @ (posedge clk) begin
    if (~rstn) begin
      rff_is_hold_w <= `ZERO(N_IN_PORT);
    end else begin
      rff_is_hold_w <= is_hold_w;
    end
  end

endmodule
