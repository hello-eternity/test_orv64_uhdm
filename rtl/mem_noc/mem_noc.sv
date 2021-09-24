module mem_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter NUM_MASTERS = 5,
  parameter NUM_SLAVES  = 1
) (
  input clk,
  input rstn,

  //L2->NOC write addr channel:
  input   logic             [NUM_MASTERS-1:0] l2_req_if_awvalid,
  input   cache_mem_if_aw_t [NUM_MASTERS-1:0] l2_req_if_aw,
  output  logic             [NUM_MASTERS-1:0] l2_req_if_awready,
  
  //L2->NOC write data channel:
  input   logic             [NUM_MASTERS-1:0] l2_req_if_wvalid,
  input   cache_mem_if_w_t  [NUM_MASTERS-1:0] l2_req_if_w,
  output  logic             [NUM_MASTERS-1:0] l2_req_if_wready,
  
  //L2->NOC read reqest channel:
  input   logic             [NUM_MASTERS-1:0] l2_req_if_arvalid,
  input   cache_mem_if_ar_t [NUM_MASTERS-1:0] l2_req_if_ar,
  output  logic             [NUM_MASTERS-1:0] l2_req_if_arready,

  //NOC->L2 write response channel:
  output  logic             [NUM_MASTERS-1:0] l2_resp_if_bvalid,
  output  cache_mem_if_b_t  [NUM_MASTERS-1:0] l2_resp_if_b,
  input   logic             [NUM_MASTERS-1:0] l2_resp_if_bready,
   
  //NOC->L2 read data channel:
  output  logic             [NUM_MASTERS-1:0] l2_resp_if_rvalid,
  output  cache_mem_if_r_t  [NUM_MASTERS-1:0] l2_resp_if_r,
  input   logic             [NUM_MASTERS-1:0] l2_resp_if_rready,
  
  //NOC->mem write addr channel:
  output  logic             [NUM_SLAVES-1:0]  mem_req_if_awvalid,
  output  cache_mem_if_aw_t [NUM_SLAVES-1:0]  mem_req_if_aw,
  input   logic             [NUM_SLAVES-1:0]  mem_req_if_awready,
  
  //NOC->mem write data channel:
  output  logic             [NUM_SLAVES-1:0]  mem_req_if_wvalid,
  output  cache_mem_if_w_t  [NUM_SLAVES-1:0]  mem_req_if_w,
  input   logic             [NUM_SLAVES-1:0]  mem_req_if_wready,
  
  //NOC->mem read request channel:
  output  logic             [NUM_SLAVES-1:0]  mem_req_if_arvalid,
  output  cache_mem_if_ar_t [NUM_SLAVES-1:0]  mem_req_if_ar,
  input   logic             [NUM_SLAVES-1:0]  mem_req_if_arready,
  
  //mem->NOC write response channel:
  input   logic             [NUM_SLAVES-1:0]  mem_resp_if_bvalid,
  input   cache_mem_if_b_t  [NUM_SLAVES-1:0]  mem_resp_if_b,
  output  logic             [NUM_SLAVES-1:0]  mem_resp_if_bready,
  
  //mem->NOC read data channel:
  input   logic             [NUM_SLAVES-1:0]  mem_resp_if_rvalid,
  input   cache_mem_if_r_t  [NUM_SLAVES-1:0]  mem_resp_if_r,
  output  logic             [NUM_SLAVES-1:0]  mem_resp_if_rready
);

  localparam BUF_IN_DEPTH_AW      = 2;
  localparam BUF_IN_DEPTH_W       = 8;
  localparam BUF_IN_DEPTH_B       = 2;
  localparam BUF_IN_DEPTH_AR      = 2;
  localparam BUF_IN_DEPTH_R       = 8;

  localparam BUF_MID_DEPTH_AW     = 2;
  localparam BUF_MID_DEPTH_W      = 8;
  localparam BUF_MID_DEPTH_B      = 2;
  localparam BUF_MID_DEPTH_AR     = 2;
  localparam BUF_MID_DEPTH_R      = 8;

  localparam BUF_OUT_DEPTH_AW     = 2;
  localparam BUF_OUT_DEPTH_W      = 8;
  localparam BUF_OUT_DEPTH_B      = 2;
  localparam BUF_OUT_DEPTH_AR     = 2;
  localparam BUF_OUT_DEPTH_R      = 8;

  localparam ARB_MAX_N_PORT       = 4;
  localparam WLAST_POSITION       = $bits(mem_tid_t);
  localparam RLAST_POSITION       = 0;

  localparam REQID_SLAVEID_SIZE   = $clog2(NUM_SLAVES);
  localparam REQID_SLAVEID_LSB    = MEMNOC_TID_TID_SIZE - REQID_SLAVEID_SIZE;
  localparam RSPID_MASTERID_SIZE  = MEMNOC_TID_MASTERID_SIZE;
  localparam RSPID_MASTERID_LSB   = MEMNOC_TID_TID_SIZE;

  logic [NUM_SLAVES-1:0]  aw_w_clk_en;
  logic [NUM_SLAVES-1:0]  ar_clk_en;
  logic [NUM_MASTERS-1:0] b_clk_en;
  logic [NUM_MASTERS-1:0] r_clk_en;
  logic                   clkg;

  cache_mem_if_aw_t [NUM_MASTERS-1:0] aw_id_fix;
  cache_mem_if_w_t  [NUM_MASTERS-1:0] w_id_fix;
  cache_mem_if_ar_t [NUM_MASTERS-1:0] ar_id_fix;

  generate
    for (genvar i = 0; i < NUM_MASTERS; i++) begin : ID_FIX
      assign aw_id_fix[i].awaddr   = l2_req_if_aw[i].awaddr;
      assign aw_id_fix[i].awlen    = l2_req_if_aw[i].awlen;
      assign aw_id_fix[i].awid.bid = i[MEMNOC_TID_MASTERID_SIZE-1:0];
      assign aw_id_fix[i].awid.tid = l2_req_if_aw[i].awid.tid;

      assign w_id_fix[i].wdata     = l2_req_if_w[i].wdata;
      assign w_id_fix[i].wlast     = l2_req_if_w[i].wlast;
      assign w_id_fix[i].wid.bid   = i[MEMNOC_TID_MASTERID_SIZE-1:0];
      assign w_id_fix[i].wid.tid   = l2_req_if_w[i].wid.tid;

      assign ar_id_fix[i].araddr   = l2_req_if_ar[i].araddr;
      assign ar_id_fix[i].arlen    = l2_req_if_ar[i].arlen;
      assign ar_id_fix[i].arid.bid = i[MEMNOC_TID_MASTERID_SIZE-1:0];
      assign ar_id_fix[i].arid.tid = l2_req_if_ar[i].arid.tid;
    end
  endgenerate

  icg icg_u (
    .clkg   (clkg),
    .en     (clk_en),
    .tst_en (1'b0),
    .clk    (clk));

  assign clk_en = (|aw_w_clk_en) | (|ar_clk_en) | (|b_clk_en) | (|r_clk_en);

  generate
    if (NUM_SLAVES == 1) begin : REQ_NUM_SLAVES_EQ_1
      ours_multi_lyr_axi4_aw_w_rr_arb #(
        .BUF_IN_DEPTH_AW  (BUF_IN_DEPTH_AW),
        .BUF_OUT_DEPTH_AW (BUF_OUT_DEPTH_AW),
        .BUF_MID_DEPTH_AW (BUF_MID_DEPTH_AW),
        .BUF_IN_DEPTH_W   (BUF_IN_DEPTH_W),
        .BUF_OUT_DEPTH_W  (BUF_OUT_DEPTH_W),
        .BUF_MID_DEPTH_W  (BUF_MID_DEPTH_W),
        .N_INPUT          (NUM_MASTERS),
        .AW_WIDTH         ($bits(cache_mem_if_aw_t)),
        .W_WIDTH          ($bits(cache_mem_if_w_t)),
        .WLAST_POSITION   (WLAST_POSITION),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) aw_w_u (
        .slave_awvld      (l2_req_if_awvalid),
        .slave_aw         (aw_id_fix),
        .slave_awrdy      (l2_req_if_awready),
        .slave_wvld       (l2_req_if_wvalid),
        .slave_w          (w_id_fix),
        .slave_wrdy       (l2_req_if_wready),
        .master_awvld     (mem_req_if_awvalid),
        .master_aw        (mem_req_if_aw),
        .master_awrdy     (mem_req_if_awready),
        .master_wvld      (mem_req_if_wvalid),
        .master_w         (mem_req_if_w),
        .master_wrdy      (mem_req_if_wready),
        .clk_en           (aw_w_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT          (NUM_MASTERS),
        .WIDTH            ($bits(cache_mem_if_ar_t)),
        .BUF_IN_DEPTH     (BUF_IN_DEPTH_AR),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_AR),
        .BUF_MID_DEPTH    (BUF_MID_DEPTH_AR),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) ar_u (
        .slave_valid      (l2_req_if_arvalid),
        .slave_info       (ar_id_fix),
        .slave_ready      (l2_req_if_arready),
        .master_valid     (mem_req_if_arvalid),
        .master_info      (mem_req_if_ar),
        .master_ready     (mem_req_if_arready),
        .clk_en           (ar_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

    end else begin : REQ_NUM_SLAVES_GT_1
    end

  endgenerate

  generate
    if (NUM_MASTERS == 1) begin : RSP_NUM_MASTERS_EQ_1
      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT          (NUM_SLAVES),
        .WIDTH            ($bits(cache_mem_if_b_t)),
        .BUF_IN_DEPTH     (BUF_IN_DEPTH_B),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_B),
        .BUF_MID_DEPTH    (BUF_MID_DEPTH_B),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) b_u (
        .slave_valid      (mem_resp_if_bvalid[0]),
        .slave_info       (mem_resp_if_b[0]),
        .slave_ready      (mem_resp_if_bready[0]),
        .master_valid     (l2_resp_if_bvalid[0]),
        .master_info      (l2_resp_if_b[0]),
        .master_ready     (l2_resp_if_bready[0]),
        .clk_en           (b_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

      ours_multi_lyr_axi4_r_rr_arb #(
        .N_INPUT          (NUM_SLAVES),
        .WIDTH            ($bits(cache_mem_if_r_t)),
        .BUF_IN_DEPTH     (BUF_IN_DEPTH_R),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_R),
        .BUF_MID_DEPTH    (BUF_MID_DEPTH_R),
        .RLAST_POSITION   (RLAST_POSITION),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) r_u (
        .slave_rvld       (mem_resp_if_rvalid[0]),
        .slave_r          (mem_resp_if_r[0]),
        .slave_rrdy       (mem_resp_if_rready[0]),
        .master_rvld      (l2_resp_if_rvalid[0]),
        .master_r         (l2_resp_if_r[0]),
        .master_rrdy      (l2_resp_if_rready[0]),
        .clk_en           (r_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

    end else begin : RSP_NUM_MASTERS_GT_1

      logic             [NUM_SLAVES-1:0][NUM_MASTERS-1:0] bvld_s_m;
      cache_mem_if_b_t  [NUM_SLAVES-1:0][NUM_MASTERS-1:0] b_s_m;
      logic             [NUM_SLAVES-1:0][NUM_MASTERS-1:0] brdy_s_m;

      logic             [NUM_MASTERS-1:0][NUM_SLAVES-1:0] bvld_m_s;
      cache_mem_if_b_t  [NUM_MASTERS-1:0][NUM_SLAVES-1:0] b_m_s;
      logic             [NUM_MASTERS-1:0][NUM_SLAVES-1:0] brdy_m_s;
                                                         
      logic             [NUM_SLAVES-1:0][NUM_MASTERS-1:0] rvld_s_m;
      cache_mem_if_r_t  [NUM_SLAVES-1:0][NUM_MASTERS-1:0] r_s_m;
      logic             [NUM_SLAVES-1:0][NUM_MASTERS-1:0] rrdy_s_m;

      logic             [NUM_MASTERS-1:0][NUM_SLAVES-1:0] rvld_m_s;
      cache_mem_if_r_t  [NUM_MASTERS-1:0][NUM_SLAVES-1:0] r_m_s;
      logic             [NUM_MASTERS-1:0][NUM_SLAVES-1:0] rrdy_m_s;

	  logic 			[NUM_MASTERS-1:0]	bready_temp;
	  logic 			[NUM_MASTERS-1:0]	rready_temp;

      for (genvar j = 0; j < NUM_SLAVES; j++) begin : CONNECTION_LOOP_SLAVE
        for (genvar i = 0; i < NUM_MASTERS; i++) begin : CONNECTION_LOOP_MASTER
          assign bvld_s_m[j][i] = mem_resp_if_bvalid[j] & (mem_resp_if_b[j].bid.bid == i[RSPID_MASTERID_SIZE-1:0]);
          assign bvld_m_s[i][j] = mem_resp_if_bvalid[j] & (mem_resp_if_b[j].bid.bid == i[RSPID_MASTERID_SIZE-1:0]);
          assign b_s_m[j][i]    = mem_resp_if_b;
          assign b_m_s[i][j]    = mem_resp_if_b;
          assign rvld_s_m[j][i] = mem_resp_if_rvalid[j] & (mem_resp_if_r[j].rid.bid == i[RSPID_MASTERID_SIZE-1:0]);
          assign rvld_m_s[i][j] = mem_resp_if_rvalid[j] & (mem_resp_if_r[j].rid.bid == i[RSPID_MASTERID_SIZE-1:0]);
          assign r_s_m[j][i]    = mem_resp_if_r;
          assign r_m_s[i][j]    = mem_resp_if_r;
          assign brdy_s_m[j][i] = brdy_m_s[i][j];
          assign rrdy_s_m[j][i] = rrdy_m_s[i][j];
        end
        always_comb begin
          for (int ii = 0; ii < NUM_MASTERS; ii++) begin
            bready_temp[ii] = brdy_s_m[j][ii] & (mem_resp_if_b[j].bid.bid == ii) & mem_resp_if_bvalid[j];
          end
          for (int ii = 0; ii < NUM_MASTERS; ii++) begin
            rready_temp[ii] = rrdy_s_m[j][ii] & (mem_resp_if_r[j].rid.bid == ii) & mem_resp_if_rvalid[j];
          end
		  mem_resp_if_bready[j] = |bready_temp;
		  mem_resp_if_rready[j] = |rready_temp;
        end
      end

      for (genvar i = 0; i < NUM_MASTERS; i++) begin : RSP_NUM_MASTERS_LOOP
        ours_multi_lyr_vld_rdy_rr_arb #(
          .N_INPUT          (NUM_SLAVES),
          .WIDTH            ($bits(cache_mem_if_b_t)),
          .BUF_IN_DEPTH     (BUF_IN_DEPTH_B),
          .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_B),
          .BUF_MID_DEPTH    (BUF_MID_DEPTH_B),
          .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
        ) b_u (
          .slave_valid      (bvld_m_s[i]),
          .slave_info       (b_m_s[i]),
          .slave_ready      (brdy_m_s[i]),
          .master_valid     (l2_resp_if_bvalid[i]),
          .master_info      (l2_resp_if_b[i]),
          .master_ready     (l2_resp_if_bready[i]),
          .clk_en           (b_clk_en[i]),
          .rstn             (rstn),
          .clk              (clkg));
  
        ours_multi_lyr_axi4_r_rr_arb #(
          .N_INPUT          (NUM_SLAVES),
          .WIDTH            ($bits(cache_mem_if_r_t)),
          .BUF_IN_DEPTH     (BUF_IN_DEPTH_R),
          .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_R),
          .BUF_MID_DEPTH    (BUF_MID_DEPTH_R),
          .RLAST_POSITION   (RLAST_POSITION),
          .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
        ) r_u (
          .slave_rvld       (rvld_m_s[i]),
          .slave_r          (r_m_s[i]),
          .slave_rrdy       (rrdy_m_s[i]),
          .master_rvld      (l2_resp_if_rvalid[i]),
          .master_r         (l2_resp_if_r[i]),
          .master_rrdy      (l2_resp_if_rready[i]),
          .clk_en           (r_clk_en[i]),
          .rstn             (rstn),
          .clk              (clkg));

      end
    end
  endgenerate

endmodule
