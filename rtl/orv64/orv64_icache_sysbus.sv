// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_icache_sysbus
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(

  input  orv64_ic2sys_t       ic2isys,
  output orv64_sys2ic_t       isys2ic,

  // SYSBUS
  output logic                sysbus_req_if_awvalid,
  output logic                sysbus_req_if_wvalid,
  output logic                sysbus_req_if_arvalid,
  output oursring_req_if_ar_t sysbus_req_if_ar,
  output oursring_req_if_aw_t sysbus_req_if_aw,
  output oursring_req_if_w_t  sysbus_req_if_w,
  input                       sysbus_req_if_arready,
  input                       sysbus_req_if_wready,
  input                       sysbus_req_if_awready,

  input oursring_resp_if_b_t  sysbus_resp_if_b,
  input oursring_resp_if_r_t  sysbus_resp_if_r,
  input                       sysbus_resp_if_rvalid,
  output                      sysbus_resp_if_rready,
  input                       sysbus_resp_if_bvalid,
  output                      sysbus_resp_if_bready,

  input logic                 rst, clk
);

  localparam NUM_CHUNKS = (CACHE_LINE_BYTE*8)/RING_DATA_WIDTH; // equals cache_line_size/ring_data_size
  localparam CHUNKS_CNTR_WIDTH = $clog2(NUM_CHUNKS);

  enum logic [1:0] {
    ST_IDLE     = 2'b00,
    ST_SYS_REQ  = 2'b01,
    ST_SYS_RESP = 2'b10,
    ST_DONE     = 2'b11
  } rff_state, next_state;

  logic [CHUNKS_CNTR_WIDTH-1:0]       rff_sys_cnt;
  ring_data_t [NUM_CHUNKS-1:0] dff_rdata, next_rdata;
  orv64_ic2sys_t                      dff_ic2isys;
  logic [3:0]                         rff_arid;
  ring_addr_t                         req_addr;
  
  //==========================================================
  // ICG {{{

  logic clkg;

  icg ic2isys_clk_u (
    .en       (ic2isys.en),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (clkg)
  );

  // }}}

  always_comb begin
    if (isys2ic.valid) begin
      for (int i=0; i<NUM_CHUNKS; i++) begin
        isys2ic.rdata[i*RING_DATA_WIDTH +: RING_DATA_WIDTH] = dff_rdata[i];
      end
    end else begin
      isys2ic.rdata = '0;
    end
  end

  assign isys2ic.valid = (rff_state == ST_DONE);

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_state <= ST_IDLE;
    end else begin
      rff_state <= next_state;
    end
  end

  always_ff @(posedge clkg) begin
    if (ic2isys.en) begin
      dff_rdata <= next_rdata;
      dff_ic2isys <= ic2isys;
    end
  end


  always_ff @(posedge clk) begin
    if (rst) begin
      rff_arid <= '0;
    end else begin
      if (sysbus_req_if_arvalid & sysbus_req_if_arready) begin
        rff_arid <= rff_arid + {{($bits(ring_tid_t)-1){1'b0}}, 1'b1};
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_sys_cnt <= '0;
    end else begin
      if (sysbus_resp_if_rvalid & sysbus_resp_if_rready) begin
        rff_sys_cnt <= rff_sys_cnt + {{(CHUNKS_CNTR_WIDTH-1){1'b0}}, 1'b1};
      end
    end
  end

  assign last_sys_resp = (rff_sys_cnt == '1);

  always_comb begin
    next_state = rff_state;
    next_rdata = dff_rdata;
    case (rff_state)
      ST_IDLE: begin
        if (ic2isys.en) begin
          next_state = ST_SYS_REQ;
        end
      end
      ST_SYS_REQ: begin
        if (sysbus_req_if_arready) begin
          next_state = ST_SYS_RESP;
        end
      end
      ST_SYS_RESP: begin
        if (sysbus_resp_if_rvalid) begin
          next_state = last_sys_resp ? ST_DONE: ST_SYS_REQ;
          next_rdata[rff_sys_cnt] = sysbus_resp_if_r.rdata;
        end
      end
      default: begin
        next_state = ST_IDLE;
      end 
    endcase
  end

  assign req_addr = {dff_ic2isys.pc[ORV64_PHY_ADDR_WIDTH-1:5], rff_sys_cnt, 3'b000};

  //-----------------------------------------------------------
  // Sysbus

  assign sysbus_req_if_arvalid = (rff_state == ST_SYS_REQ);
  assign sysbus_req_if_ar.arid = {{($bits(ring_tid_t)-4){1'b0}}, rff_arid};
  assign sysbus_req_if_ar.araddr = req_addr;
  assign sysbus_resp_if_rready = (rff_state == ST_SYS_RESP);

  assign sysbus_req_if_awvalid = '0;
  assign sysbus_req_if_wvalid  = '0;
  assign sysbus_req_if_aw      = '0;
  assign sysbus_req_if_w       = '0;

  assign sysbus_resp_if_bready = '1;

endmodule
