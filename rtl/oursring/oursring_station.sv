// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module oursring_station
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter int                           NUM_STATION_ID      = 1,
  parameter int                           STATION_ID_WIDTH_0  = 5,
  parameter int                           STATION_ID_WIDTH_1  = 5,
  parameter logic [STATION_ID_WIDTH_0-1:0]  LOCAL_STATION_ID_0  = {STATION_ID_WIDTH_0{1'b0}},
  parameter logic [STATION_ID_WIDTH_1-1:0]  LOCAL_STATION_ID_1  = {STATION_ID_WIDTH_1{1'b0}},
  parameter int                           RING_ADDR_WIDTH     = 25,
  parameter logic [RING_ADDR_WIDTH-1:0]   MAX_RING_ADDR       = 25'h1ffffff
) (
  // req interface
  input oursring_req_if_ar_t i_req_local_if_ar, 
  input logic i_req_local_if_awvalid, 
  output logic i_req_local_if_awready, 
  input logic i_req_local_if_wvalid, 
  output logic i_req_local_if_wready, 
  input logic i_req_local_if_arvalid, 
  output logic i_req_local_if_arready, 
  input oursring_req_if_w_t i_req_local_if_w, 
  input oursring_req_if_aw_t i_req_local_if_aw,
  input oursring_req_if_ar_t i_req_ring_if_ar, 
  input logic i_req_ring_if_awvalid, 
  output logic i_req_ring_if_awready, 
  input logic i_req_ring_if_wvalid, 
  output logic i_req_ring_if_wready, 
  input logic i_req_ring_if_arvalid, 
  output logic i_req_ring_if_arready, 
  input oursring_req_if_w_t i_req_ring_if_w, 
  input oursring_req_if_aw_t i_req_ring_if_aw,
  output oursring_req_if_ar_t o_req_local_if_ar, 
  output logic o_req_local_if_awvalid, 
  input logic o_req_local_if_awready, 
  output logic o_req_local_if_wvalid, 
  input logic o_req_local_if_wready, 
  output logic o_req_local_if_arvalid, 
  input logic o_req_local_if_arready, 
  output oursring_req_if_w_t o_req_local_if_w, 
  output oursring_req_if_aw_t o_req_local_if_aw,
  output oursring_req_if_ar_t o_req_ring_if_ar, 
  output logic o_req_ring_if_awvalid, 
  input logic o_req_ring_if_awready, 
  output logic o_req_ring_if_wvalid, 
  input logic o_req_ring_if_wready, 
  output logic o_req_ring_if_arvalid, 
  input logic o_req_ring_if_arready, 
  output oursring_req_if_w_t o_req_ring_if_w, 
  output oursring_req_if_aw_t o_req_ring_if_aw,
  // resp interface
  input oursring_resp_if_b_t i_resp_local_if_b, 
  input oursring_resp_if_r_t i_resp_local_if_r, 
  input logic i_resp_local_if_rvalid, 
  output logic i_resp_local_if_rready, 
  input logic i_resp_local_if_bvalid, 
  output logic i_resp_local_if_bready,
  input oursring_resp_if_b_t i_resp_ring_if_b, 
  input oursring_resp_if_r_t i_resp_ring_if_r, 
  input logic i_resp_ring_if_rvalid, 
  output logic i_resp_ring_if_rready, 
  input logic i_resp_ring_if_bvalid, 
  output logic i_resp_ring_if_bready,
  output oursring_resp_if_b_t o_resp_local_if_b, 
  output oursring_resp_if_r_t o_resp_local_if_r, 
  output logic o_resp_local_if_rvalid, 
  input logic o_resp_local_if_rready, 
  output logic o_resp_local_if_bvalid, 
  input logic o_resp_local_if_bready,
  output oursring_resp_if_b_t o_resp_ring_if_b, 
  output oursring_resp_if_r_t o_resp_ring_if_r, 
  output logic o_resp_ring_if_rvalid, 
  input logic o_resp_ring_if_rready, 
  output logic o_resp_ring_if_bvalid, 
  input logic o_resp_ring_if_bready,
  // rst & clk
  input   logic           rstn,
  input   logic           clk
);
  localparam int N_IN_PORT = 2;
  localparam int N_OUT_PORT = 2;
  localparam int RING_PORT = 0; // higher priority
  localparam int LOCAL_PORT = 1;
  localparam int ERR_IN_PORT = 2;
  localparam int ERR_OUT_PORT = 2;
  function automatic logic is_req_dst_match (int j, ring_addr_t dst_addr);
    // if MSB of the addr matches LOCAL_STATION_ID, then goes to local,
    // otherwise, goes to ring
    logic [STATION_ID_WIDTH_0-1:0] dst0_sid; // destination station id
    logic [STATION_ID_WIDTH_1-1:0] dst1_sid; // destination station id
    logic is_dst_match_local;
    dst0_sid = dst_addr[RING_ADDR_WIDTH -1 -: STATION_ID_WIDTH_0];
    dst1_sid = dst_addr[RING_ADDR_WIDTH -1 -: STATION_ID_WIDTH_1];
    is_dst_match_local = (NUM_STATION_ID == 1) ? (dst0_sid == LOCAL_STATION_ID_0) : (NUM_STATION_ID == 2) ? ((dst0_sid == LOCAL_STATION_ID_0) || (dst1_sid == LOCAL_STATION_ID_1)) : 1'b0;
    case (j)
      LOCAL_PORT: is_req_dst_match = is_dst_match_local; //spyglass disable W263
      default: is_req_dst_match = ~is_dst_match_local;
    endcase
  endfunction
  function automatic logic is_req_err (ring_addr_t dst_addr);
    is_req_err = (dst_addr > {{($bits(ring_addr_t)-RING_ADDR_WIDTH){1'b0}}, MAX_RING_ADDR});
  endfunction
  function automatic logic is_resp_dst_match (int j, ring_tid_t dst_tid);
    // if MSB of the tid matches LOCAL_STATION_ID, then goes to local,
    // otherwise goes to ring
    logic [STATION_ID_WIDTH_0-1:0] dst_sid0, dst_sid1; // destination station id
    logic is_dst_match_local;
    dst_sid0 = dst_tid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0];
    dst_sid1 = (NUM_STATION_ID == 2) ? dst_tid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_1] : dst_sid0;
    is_dst_match_local = (NUM_STATION_ID == 1) ? (dst_sid0 == LOCAL_STATION_ID_0) : (NUM_STATION_ID == 2) ? ((dst_sid0 == LOCAL_STATION_ID_0) || (dst_sid1 == LOCAL_STATION_ID_1)) : 1'b0;
    case (j)
      LOCAL_PORT: is_resp_dst_match = is_dst_match_local; //spyglass disable W263
      default: is_resp_dst_match = ~is_dst_match_local;
    endcase
  endfunction
  //==========================================================
  oursring_req_if_t [N_IN_PORT-1:0]   i_req;
  oursring_req_if_t [N_OUT_PORT:0]    o_req; // +1 for error handling port
  oursring_req_if_ar_t i_req_if_ar[N_IN_PORT]; 
  logic i_req_if_awvalid[N_IN_PORT]; 
  logic i_req_if_awready[N_IN_PORT]; 
  logic i_req_if_wvalid[N_IN_PORT]; 
  logic i_req_if_wready[N_IN_PORT]; 
  logic i_req_if_arvalid[N_IN_PORT]; 
  logic i_req_if_arready[N_IN_PORT]; 
  oursring_req_if_w_t i_req_if_w[N_IN_PORT]; 
  oursring_req_if_aw_t i_req_if_aw[N_IN_PORT]; 
  oursring_req_if_ar_t o_req_if_ar[N_OUT_PORT+1]; 
  logic o_req_if_awvalid[N_OUT_PORT+1]; 
  logic o_req_if_awready[N_OUT_PORT+1]; 
  logic o_req_if_wvalid[N_OUT_PORT+1]; 
  logic o_req_if_wready[N_OUT_PORT+1]; 
  logic o_req_if_arvalid[N_OUT_PORT+1]; 
  logic o_req_if_arready[N_OUT_PORT+1]; 
  oursring_req_if_w_t o_req_if_w[N_OUT_PORT+1]; 
  oursring_req_if_aw_t o_req_if_aw[N_OUT_PORT+1]; 
  oursring_resp_if_t  [N_IN_PORT:0]   i_resp; // +1 fro error handling port
  oursring_resp_if_t  [N_OUT_PORT-1:0]  o_resp;
  oursring_resp_if_b_t i_resp_if_b[N_IN_PORT+1]; 
  oursring_resp_if_r_t i_resp_if_r[N_IN_PORT+1]; 
  logic i_resp_if_rvalid[N_IN_PORT+1]; 
  logic i_resp_if_rready[N_IN_PORT+1]; 
  logic i_resp_if_bvalid[N_IN_PORT+1]; 
  logic i_resp_if_bready[N_IN_PORT+1]; 
  oursring_resp_if_b_t o_resp_if_b[N_OUT_PORT]; 
  oursring_resp_if_r_t o_resp_if_r[N_OUT_PORT]; 
  logic o_resp_if_rvalid[N_OUT_PORT]; 
  logic o_resp_if_rready[N_OUT_PORT]; 
  logic o_resp_if_bvalid[N_OUT_PORT]; 
  logic o_resp_if_bready[N_OUT_PORT]; 
  // logic [N_OUT_PORT-1:0] o_resp_prev_rvalid, o_resp_prev_rready, o_resp_prev_bvalid, o_resp_prev_bready;
  // IO interface <-> struct
  always_comb begin
    i_req[1].ar = i_req_local_if_ar; 
    i_req[1].awvalid = i_req_local_if_awvalid; 
    i_req_local_if_awready = i_req[1].awready; 
    i_req[1].wvalid = i_req_local_if_wvalid; 
    i_req_local_if_wready = i_req[1].wready; 
    i_req[1].arvalid = i_req_local_if_arvalid; 
    i_req_local_if_arready = i_req[1].arready; 
    i_req[1].w = i_req_local_if_w; 
    i_req[1].aw = i_req_local_if_aw; 
    o_req_local_if_ar = o_req[1].ar; 
    o_req_local_if_awvalid = o_req[1].awvalid; 
    o_req[1].awready = o_req_local_if_awready; 
    o_req_local_if_wvalid = o_req[1].wvalid; 
    o_req[1].wready = o_req_local_if_wready; 
    o_req_local_if_arvalid = o_req[1].arvalid; 
    o_req[1].arready = o_req_local_if_arready; 
    o_req_local_if_w = o_req[1].w; 
    o_req_local_if_aw = o_req[1].aw; 
    i_req[0].ar = i_req_ring_if_ar; 
    i_req[0].awvalid = i_req_ring_if_awvalid; 
    i_req_ring_if_awready = i_req[0].awready; 
    i_req[0].wvalid = i_req_ring_if_wvalid; 
    i_req_ring_if_wready = i_req[0].wready; 
    i_req[0].arvalid = i_req_ring_if_arvalid; 
    i_req_ring_if_arready = i_req[0].arready; 
    i_req[0].w = i_req_ring_if_w; 
    i_req[0].aw = i_req_ring_if_aw; 
    o_req_ring_if_ar = o_req[0].ar; 
    o_req_ring_if_awvalid = o_req[0].awvalid; 
    o_req[0].awready = o_req_ring_if_awready; 
    o_req_ring_if_wvalid = o_req[0].wvalid; 
    o_req[0].wready = o_req_ring_if_wready; 
    o_req_ring_if_arvalid = o_req[0].arvalid; 
    o_req[0].arready = o_req_ring_if_arready; 
    o_req_ring_if_w = o_req[0].w; 
    o_req_ring_if_aw = o_req[0].aw; 
    i_resp[1].b = i_resp_local_if_b; 
    i_resp[1].r = i_resp_local_if_r; 
    i_resp[1].rvalid = i_resp_local_if_rvalid; 
    i_resp_local_if_rready = i_resp[1].rready; 
    i_resp[1].bvalid = i_resp_local_if_bvalid; 
    i_resp_local_if_bready = i_resp[1].bready; 
    o_resp_local_if_b = o_resp[1].b; 
    o_resp_local_if_r = o_resp[1].r; 
    o_resp_local_if_rvalid = o_resp[1].rvalid; 
    o_resp[1].rready = o_resp_local_if_rready; 
    o_resp_local_if_bvalid = o_resp[1].bvalid; 
    o_resp[1].bready = o_resp_local_if_bready; 
    i_resp[0].b = i_resp_ring_if_b; 
    i_resp[0].r = i_resp_ring_if_r; 
    i_resp[0].rvalid = i_resp_ring_if_rvalid; 
    i_resp_ring_if_rready = i_resp[0].rready; 
    i_resp[0].bvalid = i_resp_ring_if_bvalid; 
    i_resp_ring_if_bready = i_resp[0].bready; 
    o_resp_ring_if_b = o_resp[0].b; 
    o_resp_ring_if_r = o_resp[0].r; 
    o_resp_ring_if_rvalid = o_resp[0].rvalid; 
    o_resp[0].rready = o_resp_ring_if_rready; 
    o_resp_ring_if_bvalid = o_resp[0].bvalid; 
    o_resp[0].bready = o_resp_ring_if_bready; 
    // correct arid and awid from local port
    // Tian: NUM_STATION_ID == 2 ? only if the tid does not match LOCAL_STATION_ID_0 AND LOCAL_STATION_ID_1
    // Tian: NUM_STATION_ID == 1 ? always replace is fine
    if (NUM_STATION_ID == 2) begin
      if ((i_req[LOCAL_PORT].ar.arid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] != LOCAL_STATION_ID_0) && (i_req[LOCAL_PORT].ar.arid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_1] != LOCAL_STATION_ID_1)) begin
        i_req[LOCAL_PORT].ar.arid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] = LOCAL_STATION_ID_0; //spyglass disable W415a
      end
      if ((i_req[LOCAL_PORT].aw.awid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] != LOCAL_STATION_ID_0) && (i_req[LOCAL_PORT].aw.awid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_1] != LOCAL_STATION_ID_1)) begin
        i_req[LOCAL_PORT].aw.awid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] = LOCAL_STATION_ID_0; //spyglass disable W415a
      end
    end else begin
      i_req[LOCAL_PORT].ar.arid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] = LOCAL_STATION_ID_0; //spyglass disable W415a
      i_req[LOCAL_PORT].aw.awid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] = LOCAL_STATION_ID_0; //spyglass disable W415a
    end
    // error handling
    o_req[ERR_OUT_PORT].arready = i_resp[ERR_IN_PORT].rready;
    o_req[ERR_OUT_PORT].awready = i_resp[ERR_IN_PORT].bready;
    o_req[ERR_OUT_PORT].wready  = 1'b1;
    i_resp[ERR_IN_PORT].rvalid = o_req[ERR_OUT_PORT].arvalid;
    i_resp[ERR_IN_PORT].r.rlast = 1'b1;
    i_resp[ERR_IN_PORT].r.rid = o_req[ERR_OUT_PORT].ar.arid;
    i_resp[ERR_IN_PORT].r.rresp = AXI_RESP_DECERR;
    i_resp[ERR_IN_PORT].r.rdata = '0;
    i_resp[ERR_IN_PORT].bvalid = o_req[ERR_OUT_PORT].awvalid;
    i_resp[ERR_IN_PORT].b.bid = o_req[ERR_OUT_PORT].aw.awid;
    i_resp[ERR_IN_PORT].b.bresp = AXI_RESP_DECERR;
  end
  // struct <-> internal interface
  generate
    for (genvar i=0; i<N_IN_PORT; i++) begin : st2if_loop_i_port
      always_comb begin
        i_req_if_ar[i] = i_req[i].ar; 
        i_req_if_awvalid[i] = i_req[i].awvalid; 
        i_req[i].awready = i_req_if_awready[i]; 
        i_req_if_wvalid[i] = i_req[i].wvalid; 
        i_req[i].wready = i_req_if_wready[i]; 
        i_req_if_arvalid[i] = i_req[i].arvalid; 
        i_req[i].arready = i_req_if_arready[i]; 
        i_req_if_w[i] = i_req[i].w; 
        i_req_if_aw[i] = i_req[i].aw; 
        i_resp_if_b[i] = i_resp[i].b; 
        i_resp_if_r[i] = i_resp[i].r; 
        i_resp_if_rvalid[i] = i_resp[i].rvalid; 
        i_resp[i].rready = i_resp_if_rready[i]; 
        i_resp_if_bvalid[i] = i_resp[i].bvalid; 
        i_resp[i].bready = i_resp_if_bready[i]; 
      end
    end
    for (genvar j=0; j<N_OUT_PORT; j++) begin : st2if_loop_o_port
      always_comb begin
        o_req[j].ar = o_req_if_ar[j]; 
        o_req[j].awvalid = o_req_if_awvalid[j]; 
        o_req_if_awready[j] = o_req[j].awready; 
        o_req[j].wvalid = o_req_if_wvalid[j]; 
        o_req_if_wready[j] = o_req[j].wready; 
        o_req[j].arvalid = o_req_if_arvalid[j]; 
        o_req_if_arready[j] = o_req[j].arready; 
        o_req[j].w = o_req_if_w[j]; 
        o_req[j].aw = o_req_if_aw[j]; 
        o_resp[j].b = o_resp_if_b[j]; 
        o_resp[j].r = o_resp_if_r[j]; 
        o_resp[j].rvalid = o_resp_if_rvalid[j]; 
        o_resp_if_rready[j] = o_resp[j].rready; 
        o_resp[j].bvalid = o_resp_if_bvalid[j]; 
        o_resp_if_bready[j] = o_resp[j].bready; 
      end
    end
  endgenerate
  always_comb begin
    //spyglass disable_block W528
    o_req[ERR_OUT_PORT].ar = o_req_if_ar[ERR_OUT_PORT]; 
    o_req[ERR_OUT_PORT].awvalid = o_req_if_awvalid[ERR_OUT_PORT]; 
    o_req_if_awready[ERR_OUT_PORT] = o_req[ERR_OUT_PORT].awready; 
    o_req[ERR_OUT_PORT].wvalid = o_req_if_wvalid[ERR_OUT_PORT]; 
    o_req_if_wready[ERR_OUT_PORT] = o_req[ERR_OUT_PORT].wready; 
    o_req[ERR_OUT_PORT].arvalid = o_req_if_arvalid[ERR_OUT_PORT]; 
    o_req_if_arready[ERR_OUT_PORT] = o_req[ERR_OUT_PORT].arready; 
    o_req[ERR_OUT_PORT].w = o_req_if_w[ERR_OUT_PORT]; 
    o_req[ERR_OUT_PORT].aw = o_req_if_aw[ERR_OUT_PORT]; 
    //spyglass enable_block W528
  end
  always_comb begin
    i_resp_if_b[ERR_OUT_PORT] = i_resp[ERR_OUT_PORT].b; 
    i_resp_if_r[ERR_OUT_PORT] = i_resp[ERR_OUT_PORT].r; 
    i_resp_if_rvalid[ERR_OUT_PORT] = i_resp[ERR_OUT_PORT].rvalid; 
    i_resp[ERR_OUT_PORT].rready = i_resp_if_rready[ERR_OUT_PORT]; 
    i_resp_if_bvalid[ERR_OUT_PORT] = i_resp[ERR_OUT_PORT].bvalid; 
    i_resp[ERR_OUT_PORT].bready = i_resp_if_bready[ERR_OUT_PORT]; 
  end
  logic [N_IN_PORT-1:0] [N_OUT_PORT:0]  is_aw_dst_match,  is_ar_dst_match;
  logic [N_IN_PORT:0] [N_OUT_PORT-1:0]  is_r_dst_match,   is_b_dst_match;
  always_comb begin
    for (int i=0; i<N_IN_PORT; i++) begin
      for (int j=0; j<N_OUT_PORT; j++) begin
        is_aw_dst_match[i][j] = is_req_dst_match(.j(j), .dst_addr(i_req[i].aw.awaddr)) & i_req[i].awvalid;
        is_ar_dst_match[i][j] = is_req_dst_match(.j(j), .dst_addr(i_req[i].ar.araddr)) & i_req[i].arvalid;
        is_r_dst_match[i][j]  = is_resp_dst_match(.j(j), .dst_tid(i_resp[i].r.rid)) & i_resp[i].rvalid;
        is_b_dst_match[i][j]  = is_resp_dst_match(.j(j), .dst_tid(i_resp[i].b.bid)) & i_resp[i].bvalid;
      end
    end
    // error handling: forward error to error out port
    for (int i=0; i<N_IN_PORT; i++) begin
      if (i == LOCAL_PORT) begin
        if (i_req[i].arvalid & (is_req_err(i_req[i].ar.araddr))) begin
          // ar req is wrong
          for (int j=0; j<N_OUT_PORT; j++) begin
            is_ar_dst_match[i][j] = 1'b0;
          end
          is_ar_dst_match[i][ERR_OUT_PORT] = 1'b1;
        end else begin
          is_ar_dst_match[i][ERR_OUT_PORT] = 1'b0;
        end
        if (i_req[i].awvalid & (is_req_err(i_req[i].aw.awaddr))) begin
          // aw req is wrong
          for (int j=0; j<N_OUT_PORT; j++) begin
            is_aw_dst_match[i][j] = 1'b0;
          end
          is_aw_dst_match[i][ERR_OUT_PORT] = 1'b1;
        end else begin
          is_aw_dst_match[i][ERR_OUT_PORT] = 1'b0;
        end
      end else begin
        is_ar_dst_match[i][ERR_OUT_PORT] = 1'b0;
        is_aw_dst_match[i][ERR_OUT_PORT] = 1'b0;
      end
    end
    // error handling: forward error resp to local
    for (int j=0; j<N_OUT_PORT; j++) begin
      if (j == LOCAL_PORT) begin
        is_r_dst_match[ERR_IN_PORT][j] = i_resp[ERR_IN_PORT].rvalid;
        is_b_dst_match[ERR_IN_PORT][j] = i_resp[ERR_IN_PORT].bvalid;
      end else begin
        is_r_dst_match[ERR_IN_PORT][j] = 1'b0;
        is_b_dst_match[ERR_IN_PORT][j] = 1'b0;
      end
    end
  end
  oursring_req #(.N_IN_PORT(2), .N_OUT_PORT(3)) req_u (
    //.i_req,
    .i_req_if_ar, 
    .i_req_if_awvalid, 
    .i_req_if_awready, 
    .i_req_if_wvalid, 
    .i_req_if_wready, 
    .i_req_if_arvalid, 
    .i_req_if_arready, 
    .i_req_if_w, 
    .i_req_if_aw,
    //.o_req_ppln_if(o_req_if),
    .o_req_ppln_if_ar(o_req_if_ar), 
    .o_req_ppln_if_awvalid(o_req_if_awvalid), 
    .o_req_ppln_if_awready(o_req_if_awready), 
    .o_req_ppln_if_wvalid(o_req_if_wvalid), 
    .o_req_ppln_if_wready(o_req_if_wready), 
    .o_req_ppln_if_arvalid(o_req_if_arvalid), 
    .o_req_ppln_if_arready(o_req_if_arready), 
    .o_req_ppln_if_w(o_req_if_w), 
    .o_req_ppln_if_aw(o_req_if_aw),
    .is_aw_dst_match, .is_ar_dst_match, .*);

  oursring_resp #(.N_IN_PORT(3), .N_OUT_PORT(2)) resp_u (
    //.i_resp_if,
    .i_resp_if_b, 
    .i_resp_if_r, 
    .i_resp_if_rvalid, 
    .i_resp_if_rready, 
    .i_resp_if_bvalid, 
    .i_resp_if_bready,
    .o_resp_ppln_if_b(o_resp_if_b), 
    .o_resp_ppln_if_r(o_resp_if_r), 
    .o_resp_ppln_if_rvalid(o_resp_if_rvalid), 
    .o_resp_ppln_if_rready(o_resp_if_rready), 
    .o_resp_ppln_if_bvalid(o_resp_if_bvalid), 
    .o_resp_ppln_if_bready(o_resp_if_bready),
    .is_r_dst_match, .is_b_dst_match, .*);
  //==========================================================
`ifndef SYNTHESIS
  import ours_logging::*;
  initial begin
    chk_id_width_0: assert ($bits(LOCAL_STATION_ID_0) == STATION_ID_WIDTH_0);
    chk_id_width_1: assert ($bits(LOCAL_STATION_ID_1) == STATION_ID_WIDTH_1);
    //chk_reset_ready: assert property (@(posedge rstn) (o_req_local_if_arready & o_req_local_if_awready & o_req_local_if_wready & o_req_ring_if_arready & o_req_ring_if_awready & o_req_ring_if_wready == 1'b1)) else `olog_error("OURSRING_STATION", $sformatf("o_req_local_if_arready = %d, o_req_local_if_awready = %d, o_req_local_if_wready = %d, o_req_ring_if_arready = %d, o_req_ring_if_awready %d, o_req_ring_if_wready = %d", o_req_local_if_arready, o_req_local_if_awready, o_req_local_if_wready, o_req_ring_if_arready, o_req_ring_if_awready, o_req_ring_if_wready));
  end

//   chk_o_req_local_araddr_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_req_local_if_arvalid |-> (o_req_local_if_ar.araddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_local_if_ar.araddr=%h is wrong", o_req_local_if_ar.araddr));
//   chk_o_req_local_awaddr_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_req_local_if_awvalid |-> (o_req_local_if_aw.awaddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_local_if_aw.awaddr=%h is wrong", o_req_local_if_aw.awaddr));
//   chk_o_req_ring_araddr_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_req_ring_if_arvalid |-> ~(o_req_ring_if_ar.araddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_ring_if_ar.araddr=%h is wrong", o_req_ring_if_ar.araddr));
//   chk_o_req_ring_awaddr_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_req_ring_if_awvalid |-> ~(o_req_ring_if_aw.awaddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_ring_if_aw.awaddr=%h is wrong", o_req_ring_if_aw.awaddr));
//   chk_o_resp_local_rid_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_resp_local_if_rvalid |-> (o_resp_local_if_r.rid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_local_if_r.rid=%h is wrong", o_resp_local_if_r.rid));
//   chk_o_resp_local_bid_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_resp_local_if_bvalid |-> (o_resp_local_if_b.bid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_local_if_b.bid=%h is wrong", o_resp_local_if_b.bid));
//   chk_o_resp_ring_rid_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_resp_ring_if_rvalid |-> ~(o_resp_ring_if_r.rid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_ring_if_r.rid=%h is wrong", o_resp_ring_if_r.rid));
//   chk_o_resp_ring_bid_0: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 1)) (o_resp_ring_if_bvalid |-> ~(o_resp_ring_if_b.bid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_ring_if_b.bid=%h is wrong", o_resp_ring_if_b.bid));
// 
//   chk_o_req_local_araddr_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_req_local_if_arvalid |-> (o_req_local_if_ar.araddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_local_if_ar.araddr=%h is wrong", o_req_local_if_ar.araddr));
//   chk_o_req_local_awaddr_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_req_local_if_awvalid |-> (o_req_local_if_aw.awaddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_local_if_aw.awaddr=%h is wrong", o_req_local_if_aw.awaddr));
//   chk_o_req_ring_araddr_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_req_ring_if_arvalid |-> ~(o_req_ring_if_ar.araddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_ring_if_ar.araddr=%h is wrong", o_req_ring_if_ar.araddr));
//   chk_o_req_ring_awaddr_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_req_ring_if_awvalid |-> ~(o_req_ring_if_aw.awaddr[RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_req_ring_if_aw.awaddr=%h is wrong", o_req_ring_if_aw.awaddr));
//   chk_o_resp_local_rid_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_resp_local_if_rvalid |-> (o_resp_local_if_r.rid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_local_if_r.rid=%h is wrong", o_resp_local_if_r.rid));
//   chk_o_resp_local_bid_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_resp_local_if_bvalid |-> (o_resp_local_if_b.bid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_local_if_b.bid=%h is wrong", o_resp_local_if_b.bid));
//   chk_o_resp_ring_rid_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_resp_ring_if_rvalid |-> ~(o_resp_ring_if_r.rid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_ring_if_r.rid=%h is wrong", o_resp_ring_if_r.rid));
//   chk_o_resp_ring_bid_1: assert property (@(posedge clk) disable iff ((rstn === '0) | (NUM_STATION_ID != 2)) (o_resp_ring_if_bvalid |-> ~(o_resp_ring_if_b.bid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH_0] inside {LOCAL_STATION_ID_0, LOCAL_STATION_ID_1}))) else `olog_error("OURSRING_STATION", $sformatf("%m: o_resp_ring_if_b.bid=%h is wrong", o_resp_ring_if_b.bid));
`endif
endmodule
