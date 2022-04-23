// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
/*
  subring                                                 subring
  station                 junction                        station
  010_111                 010_000                         010_001
  +-----+                 +-------------+                 +-----+
  |     | -- req_in -->   |             | -- req_out-->   |     |
  |     | -- resp_in -->  |             | -- resp_out-->  |     |
  +-----+                 |             |                 +-----+
                          |             |                       
  +-----+                 |             |                 +-----+
  |     | -- req_in -->   |             | -- req_out-->   |     |
  |     | -- resp_in -->  |             | -- resp_out-->  |     |
  +-----+                 +-------------+                 +-----|
  ring                     |   ^    |  ^                  ring
  station              req_out |    |  resp_in            station
  001_000                  | req_in |  |                  011_000
                           |   | resp_out                 ^ ^
                           v   |    v  |                  | |
                          +-------------+                 v v
                          |             |                 +-----+
                          |             |                 |     |
                          +-------------+                 +-----+
                          local function block            local function block
any req_out <--- ring_req_in[2] > subring_req_in[1] > local_req_in[0]
*/
module oursring_junction
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter int                           STATION_ID_WIDTH = 8,
  parameter int                           JUNCTION_ID_WIDTH = 4,
  parameter logic [STATION_ID_WIDTH-1:0]  LOCAL_STATION_ID = '0
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
  input oursring_req_if_ar_t i_req_sub_if_ar, 
  input logic i_req_sub_if_awvalid, 
  output logic i_req_sub_if_awready, 
  input logic i_req_sub_if_wvalid, 
  output logic i_req_sub_if_wready, 
  input logic i_req_sub_if_arvalid, 
  output logic i_req_sub_if_arready, 
  input oursring_req_if_w_t i_req_sub_if_w, 
  input oursring_req_if_aw_t i_req_sub_if_aw,
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
  output oursring_req_if_ar_t o_req_sub_if_ar, 
  output logic o_req_sub_if_awvalid, 
  input logic o_req_sub_if_awready, 
  output logic o_req_sub_if_wvalid, 
  input logic o_req_sub_if_wready, 
  output logic o_req_sub_if_arvalid, 
  input logic o_req_sub_if_arready, 
  output oursring_req_if_w_t o_req_sub_if_w, 
  output oursring_req_if_aw_t o_req_sub_if_aw,
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
  input oursring_resp_if_b_t i_resp_sub_if_b, 
  input oursring_resp_if_r_t i_resp_sub_if_r, 
  input logic i_resp_sub_if_rvalid, 
  output logic i_resp_sub_if_rready, 
  input logic i_resp_sub_if_bvalid, 
  output logic i_resp_sub_if_bready,
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
  output oursring_resp_if_b_t o_resp_sub_if_b, 
  output oursring_resp_if_r_t o_resp_sub_if_r, 
  output logic o_resp_sub_if_rvalid, 
  input logic o_resp_sub_if_rready, 
  output logic o_resp_sub_if_bvalid, 
  input logic o_resp_sub_if_bready,
  // rst & clk
  input   logic           rstn,
  input   logic           clk
);
  localparam int N_IN_PORT = 3;
  localparam int N_OUT_PORT = 3;
  localparam int LOCAL_PORT = 2;
  localparam int SUB_PORT = 1;
  localparam int RING_PORT = 0; // higher priority
  function automatic logic is_req_dst_match (int j, ring_addr_t dst_addr);
    // if MSB of the addr matches LOCAL_STATION_ID, then goes to local,
    // otherwise, goes to ring
    logic [STATION_ID_WIDTH-1:0] dst_sid; // destination station id
    logic is_dst_match_local, is_dst_match_sub;
    dst_sid = dst_addr[$bits(ring_addr_t)-1 -: STATION_ID_WIDTH];
    is_dst_match_local = (dst_sid == LOCAL_STATION_ID);
    is_dst_match_sub =  ~is_dst_match_local & (LOCAL_STATION_ID[STATION_ID_WIDTH - 1 -: JUNCTION_ID_WIDTH] == dst_sid[STATION_ID_WIDTH - 1 -: JUNCTION_ID_WIDTH]);
    case (j)
      LOCAL_PORT: is_req_dst_match = is_dst_match_local;
      SUB_PORT: is_req_dst_match = is_dst_match_sub;
      default: is_req_dst_match = ~is_dst_match_local & ~is_dst_match_sub;
    endcase
  endfunction
  function automatic logic is_req_err (ring_tid_t dst_tid);
    // if MSB of the tid matches LOCAL_STATION_ID for req, it's error
    // drop the req, send error resp to local resp port (o_resp_local_if)
    // TODO
  endfunction
  function automatic logic is_resp_dst_match (int j, ring_tid_t dst_tid);
    // if MSB of the tid matches LOCAL_STATION_ID, then goes to local,
    // otherwise goes to ring
    logic [STATION_ID_WIDTH-1:0] dst_sid; // destination station id
    logic is_dst_match_local, is_dst_match_sub;
    dst_sid = dst_tid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH];
    is_dst_match_local = (dst_sid == LOCAL_STATION_ID);
    is_dst_match_sub =  ~is_dst_match_local & (LOCAL_STATION_ID[STATION_ID_WIDTH - 1 -: JUNCTION_ID_WIDTH] == dst_sid[STATION_ID_WIDTH - 1 -: JUNCTION_ID_WIDTH]);
    case (j)
      LOCAL_PORT: is_resp_dst_match = is_dst_match_local;
      SUB_PORT: is_resp_dst_match = is_dst_match_sub;
      default: is_resp_dst_match = ~is_dst_match_local & ~is_dst_match_sub;
    endcase
  endfunction
  //==========================================================
  oursring_req_if_t [N_IN_PORT-1:0]   i_req;
  oursring_req_if_t [N_OUT_PORT-1:0]  o_req;
  //oursring_req_if i_req_if [N_IN_PORT] ();
  logic i_req_if_awvalid[N_IN_PORT];
  logic i_req_if_awready[N_IN_PORT];
  logic i_req_if_wvalid[N_IN_PORT];
  logic i_req_if_wready[N_IN_PORT];
  logic i_req_if_arvalid[N_IN_PORT];
  logic i_req_if_arready[N_IN_PORT];
  oursring_req_if_ar_t i_req_if_ar[N_IN_PORT];
  oursring_req_if_aw_t i_req_if_aw[N_IN_PORT];
  oursring_req_if_w_t i_req_if_w[N_IN_PORT];

  //oursring_req_if o_req_if [N_OUT_PORT] ();
  logic o_req_if_awvalid[N_OUT_PORT];
  logic o_req_if_awready[N_OUT_PORT];
  logic o_req_if_wvalid[N_OUT_PORT];
  logic o_req_if_wready[N_OUT_PORT];
  logic o_req_if_arvalid[N_OUT_PORT];
  logic o_req_if_arready[N_OUT_PORT];
  oursring_req_if_ar_t o_req_if_ar[N_OUT_PORT];
  oursring_req_if_aw_t o_req_if_aw[N_OUT_PORT];
  oursring_req_if_w_t o_req_if_w[N_OUT_PORT];

  oursring_resp_if_t  [N_IN_PORT-1:0]   i_resp;
  oursring_resp_if_t  [N_OUT_PORT-1:0]  o_resp;
  //oursring_resp_if  i_resp_if [N_IN_PORT] ();
  oursring_resp_if_b_t i_resp_if_b[N_IN_PORT];
  oursring_resp_if_r_t i_resp_if_r[N_IN_PORT];
  logic i_resp_if_rvalid[N_IN_PORT];
  logic i_resp_if_rready[N_IN_PORT];
  logic i_resp_if_bvalid[N_IN_PORT];
  logic i_resp_if_bready[N_IN_PORT];

  //oursring_resp_if  o_resp_if [N_OUT_PORT] ();
  oursring_resp_if_b_t o_resp_if_b[N_OUT_PORT];
  oursring_resp_if_r_t o_resp_if_r[N_OUT_PORT];
  logic o_resp_if_rvalid[N_OUT_PORT];
  logic o_resp_if_rready[N_OUT_PORT];
  logic o_resp_if_bvalid[N_OUT_PORT];
  logic o_resp_if_bready[N_OUT_PORT];

  // IO interface <-> struct
  // Input request ports
  always_comb begin
  i_req[0].ar = i_req_ring_if_ar; 
  i_req[0].awvalid = i_req_ring_if_awvalid; 
  i_req_ring_if_awready = i_req[0].awready; 
  i_req[0].wvalid = i_req_ring_if_wvalid; 
  i_req_ring_if_wready = i_req[0].wready; 
  i_req[0].arvalid = i_req_ring_if_arvalid; 
  i_req_ring_if_arready = i_req[0].arready; 
  i_req[0].w = i_req_ring_if_w; 
  i_req[0].aw = i_req_ring_if_w; 
  i_req[1].ar = i_req_sub_if_aw; 
  i_req[1].awvalid = i_req_sub_if_awvalid; 
  i_req_sub_if_awready = i_req[1].awready; 
  i_req[1].wvalid = i_req_sub_if_wvalid; 
  i_req_sub_if_wready = i_req[1].wready; 
  i_req[1].arvalid = i_req_sub_if_arvalid; 
  i_req_sub_if_arready = i_req[1].arready; 
  i_req[1].w = i_req_sub_if_w; 
  i_req[1].aw = i_req_sub_if_aw; 
  i_req[2].ar = i_req_local_if_ar; 
  i_req[2].awvalid = i_req_local_if_awvalid; 
  i_req_local_if_awready = i_req[2].awready; 
  i_req[2].wvalid = i_req_local_if_wvalid; 
  i_req_local_if_wready = i_req[2].wready; 
  i_req[2].arvalid = i_req_local_if_arvalid; 
  i_req_local_if_arready = i_req[2].arready; 
  i_req[2].w = i_req_local_if_w; 
  i_req[2].aw = i_req_local_if_aw; 
    // correct arid and awid from local port
    i_req[LOCAL_PORT].ar.arid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] = LOCAL_STATION_ID;
    i_req[LOCAL_PORT].aw.awid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] = LOCAL_STATION_ID;
    // // if req from ring port has a source id the same as myself's station id, then it means no body accept it. drop the request and send error resp to local port
    // if (i_req[RING_PORT].arvalid & (i_req[RING_PORT].ar.arid[$bits(ring_tid_t1)-1 -: STATION_ID_WIDTH] == LOCAL_STATION_ID) & i_req[RING_PORT].awvalid) begin
    //   i_req[RING_PORT].arvalid = '0;
    //   i_req[RING_PORT].awvalid = '0;
    // end
  end
  // Input response ports
  always_comb begin
  i_resp[0].rvalid = i_resp_ring_if_rvalid; 
  i_resp_ring_if_rready = i_resp[0].rready; 
  i_resp[0].bvalid = i_resp_ring_if_bvalid; 
  i_resp_ring_if_bready = i_resp[0].bready; 
  i_resp[0].r = i_resp_ring_if_r;
  i_resp[0].b = i_resp_ring_if_r;
  i_resp[1].rvalid = i_resp_sub_if_rvalid; 
  i_resp_sub_if_rready = i_resp[1].rready; 
  i_resp[1].bvalid = i_resp_sub_if_bvalid; 
  i_resp_sub_if_bready = i_resp[1].bready; 
  i_resp[1].r = i_resp_sub_if_r;
  i_resp[1].b = i_resp_sub_if_r;
  i_resp[2].rvalid = i_resp_local_if_rvalid; 
  i_resp_local_if_rready = i_resp[2].rready; 
  i_resp[2].bvalid = i_resp_local_if_bvalid; 
  i_resp_local_if_bready = i_resp[2].bready; 
  i_resp[2].r = i_resp_local_if_r;
  i_resp[2].b = i_resp_local_if_b;
  end
  // Output request ports
  always_comb begin
  o_req_ring_if_ar = o_req[0].ar; 
  o_req_ring_if_awvalid = o_req[0].awvalid; 
  o_req[0].awready = o_req_ring_if_awready; 
  o_req_ring_if_wvalid = o_req[0].wvalid; 
  o_req[0].wready = o_req_ring_if_wready; 
  o_req_ring_if_arvalid = o_req[0].arvalid; 
  o_req[0].arready = o_req_ring_if_arready; 
  o_req_ring_if_w = o_req[0].w; 
  o_req_ring_if_aw = o_req[0].aw; 
  o_req_sub_if_ar = o_req[1].ar; 
  o_req_sub_if_awvalid = o_req[1].awvalid; 
  o_req[1].awready = o_req_sub_if_awready; 
  o_req_sub_if_wvalid = o_req[1].wvalid; 
  o_req[1].wready = o_req_sub_if_wready; 
  o_req_sub_if_arvalid = o_req[1].arvalid; 
  o_req[1].arready = o_req_sub_if_arready; 
  o_req_sub_if_w = o_req[1].w; 
  o_req_sub_if_aw = o_req[1].aw; 
  o_req_local_if_ar = o_req[2].ar; 
  o_req_local_if_awvalid = o_req[2].awvalid; 
  o_req[2].awready = o_req_local_if_awready; 
  o_req_local_if_wvalid = o_req[2].wvalid; 
  o_req[2].wready = o_req_local_if_wready; 
  o_req_local_if_arvalid = o_req[2].arvalid; 
  o_req[2].arready = o_req_local_if_arready; 
  o_req_local_if_w = o_req[2].w; 
  o_req_local_if_aw = o_req[2].aw; 
  end
  // Output response ports
  always_comb begin
  o_resp_ring_if_rvalid = o_resp[0].rvalid; 
  o_resp[0].rready = o_resp_ring_if_rready; 
  o_resp_ring_if_bvalid = o_resp[0].bvalid; 
  o_resp[0].bready = o_resp_ring_if_bready; 
  o_resp_sub_if_rvalid = o_resp[1].rvalid; 
  o_resp_ring_if_r = o_resp[0].r; 
  o_resp_ring_if_b = o_resp[0].b; 
  o_resp[1].rready = o_resp_sub_if_rready; 
  o_resp_sub_if_bvalid = o_resp[1].bvalid; 
  o_resp[1].bready = o_resp_sub_if_bready; 
  o_resp_sub_if_r = o_resp[1].r; 
  o_resp_sub_if_b = o_resp[1].b; 
  o_resp_local_if_rvalid = o_resp[2].rvalid; 
  o_resp[2].rready = o_resp_local_if_rready; 
  o_resp_local_if_bvalid = o_resp[2].bvalid; 
  o_resp[2].bready = o_resp_local_if_bready; 
  o_resp_local_if_r = o_resp[2].r; 
  o_resp_local_if_b = o_resp[2].b; 
  end
  always_comb begin
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
  i_resp_if_rvalid[i] = i_resp[i].rvalid; 
  i_resp[i].rready = i_resp_if_rready[i]; 
  i_resp_if_bvalid[i] = i_resp[i].bvalid; 
  i_resp[i].bready = i_resp_if_bready[i]; 
  i_resp_if_b[i] = i_resp[i].b;
  i_resp_if_b[i] = i_resp[i].r;
      end
    end
    for (genvar j=0; j<N_IN_PORT; j++) begin : st2if_loop_o_port
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
  o_resp[j].rvalid = o_resp_if_rvalid[j]; 
  o_resp_if_rready[j] = o_resp[j].rready; 
  o_resp[j].bvalid = o_resp_if_bvalid[j]; 
  o_resp_if_bready[j] = o_resp[j].bready; 
  o_resp[j].b = o_resp_if_b[j];
  o_resp[j].r = o_resp_if_b[j];
      end
    end
  endgenerate
  logic [N_IN_PORT-1:0] [N_OUT_PORT-1:0]  is_aw_dst_match,  is_ar_dst_match,
                                          is_r_dst_match,   is_b_dst_match;
  always_comb begin
    for (int i=0; i<N_IN_PORT; i++) begin
      for (int j=0; j<N_OUT_PORT; j++) begin
        is_aw_dst_match[i][j] = is_req_dst_match(.j(j), .dst_addr(i_req[i].aw.awaddr)) & i_req[i].awvalid;
        is_ar_dst_match[i][j] = is_req_dst_match(.j(j), .dst_addr(i_req[i].ar.araddr)) & i_req[i].arvalid;
        is_r_dst_match[i][j]  = is_resp_dst_match(.j(j), .dst_tid(i_resp[i].r.rid)) & i_resp[i].rvalid;
        is_b_dst_match[i][j]  = is_resp_dst_match(.j(j), .dst_tid(i_resp[i].b.bid)) & i_resp[i].bvalid;
      end
    end
  end
  oursring_req #(.N_IN_PORT(N_IN_PORT), .N_OUT_PORT(N_OUT_PORT)) req_u (
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

  oursring_resp #(.N_IN_PORT(N_IN_PORT), .N_OUT_PORT(N_OUT_PORT)) resp_u (
    //.i_resp_if,
    .i_resp_if_b, 
    .i_resp_if_r, 
    .i_resp_if_rvalid, 
    .i_resp_if_rready, 
    .i_resp_if_bvalid, 
    .i_resp_if_bready,
    //.o_resp_ppln_if(o_resp_if),
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
    chk_id_width: assert ($bits(LOCAL_STATION_ID) == STATION_ID_WIDTH);
  end
  // Local request out
  chk_o_req_local_araddr: assert property (@(posedge clk) disable iff (rstn === '0) (o_req_local_if_arvalid |-> (o_req_local_if_ar.araddr[$bits(ring_addr_t)-1 -: STATION_ID_WIDTH] === LOCAL_STATION_ID))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_req_local_if_ar.araddr=%h is wrong", o_req_local_if_ar.araddr));
  chk_o_req_local_awaddr: assert property (@(posedge clk) disable iff (rstn === '0) (o_req_local_if_awvalid |-> (o_req_local_if_aw.awaddr[$bits(ring_addr_t)-1 -: STATION_ID_WIDTH] === LOCAL_STATION_ID))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_req_local_if_aw.awaddr=%h is wrong", o_req_local_if_aw.awaddr));
  // Sub request out
  chk_o_req_sub_araddr: assert property (@(posedge clk) disable iff (rstn === '0) (o_req_sub_if_arvalid |-> ((o_req_sub_if_ar.araddr[$bits(ring_addr_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_req_sub_if_ar.araddr[$bits(ring_addr_t)-1 -: JUNCTION_ID_WIDTH] === LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_req_sub_if_ar.araddr=%h is wrong", o_req_sub_if_ar.araddr));
  chk_o_req_sub_awaddr: assert property (@(posedge clk) disable iff (rstn === '0) (o_req_sub_if_awvalid |-> ((o_req_sub_if_aw.awaddr[$bits(ring_addr_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_req_sub_if_aw.awaddr[$bits(ring_addr_t)-1 -: JUNCTION_ID_WIDTH] === LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_req_sub_if_aw.awaddr=%h is wrong", o_req_sub_if_aw.awaddr));
  // Ring request out
  chk_o_req_ring_araddr: assert property (@(posedge clk) disable iff (rstn === '0) (o_req_ring_if_arvalid |-> ((o_req_ring_if_ar.araddr[$bits(ring_addr_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_req_ring_if_ar.araddr[$bits(ring_addr_t)-1 -: JUNCTION_ID_WIDTH] !== LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_req_ring_if_ar.araddr=%h is wrong", o_req_ring_if_ar.araddr));
  chk_o_req_ring_awaddr: assert property (@(posedge clk) disable iff (rstn === '0) (o_req_ring_if_awvalid |-> ((o_req_ring_if_aw.awaddr[$bits(ring_addr_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_req_ring_if_aw.awaddr[$bits(ring_addr_t)-1 -: JUNCTION_ID_WIDTH] !== LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_req_ring_if_aw.awaddr=%h is wrong", o_req_ring_if_aw.awaddr));
  // Local response out
  chk_o_resp_local_rid: assert property (@(posedge clk) disable iff (rstn === '0) (o_resp_local_if_rvalid |-> (o_resp_local_if_r.rid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] === LOCAL_STATION_ID))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_resp_local_if_r.rid=%h is wrong", o_resp_local_if_r.rid));
  chk_o_resp_local_bid: assert property (@(posedge clk) disable iff (rstn === '0) (o_resp_local_if_bvalid |-> (o_resp_local_if_b.bid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] === LOCAL_STATION_ID))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_resp_local_if_b.bid=%h is wrong", o_resp_local_if_b.bid));
  // Sub response out
  chk_o_resp_sub_rid: assert property (@(posedge clk) disable iff (rstn === '0) (o_resp_sub_if_rvalid |-> ((o_resp_sub_if_r.rid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_resp_sub_if_r.rid[$bits(ring_tid_t)-1 -: JUNCTION_ID_WIDTH] === LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_resp_sub_if_r.rid=%h is wrong", o_resp_sub_if_r.rid));
  chk_o_resp_sub_bid: assert property (@(posedge clk) disable iff (rstn === '0) (o_resp_sub_if_bvalid |-> ((o_resp_sub_if_b.bid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_resp_sub_if_b.bid[$bits(ring_tid_t)-1 -: JUNCTION_ID_WIDTH] === LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_resp_sub_if_b.bid=%h is wrong", o_resp_sub_if_b.bid));
  // Ring response out
  chk_o_resp_ring_rid: assert property (@(posedge clk) disable iff (rstn === '0) (o_resp_ring_if_rvalid |-> ((o_resp_ring_if_r.rid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_resp_ring_if_r.rid[$bits(ring_tid_t)-1 -: JUNCTION_ID_WIDTH] !== LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_resp_ring_if_r.rid=%h is wrong", o_resp_ring_if_r.rid));
  chk_o_resp_ring_bid: assert property (@(posedge clk) disable iff (rstn === '0) (o_resp_ring_if_bvalid |-> ((o_resp_ring_if_b.bid[$bits(ring_tid_t)-1 -: STATION_ID_WIDTH] !== LOCAL_STATION_ID) & (o_resp_ring_if_b.bid[$bits(ring_tid_t)-1 -: JUNCTION_ID_WIDTH] !== LOCAL_STATION_ID[STATION_ID_WIDTH-1 -: JUNCTION_ID_WIDTH])))) else `olog_error("OURSRING_JUNCTION", $sformatf("%m: o_resp_ring_if_b.bid=%h is wrong", o_resp_ring_if_b.bid));
`endif
endmodule
