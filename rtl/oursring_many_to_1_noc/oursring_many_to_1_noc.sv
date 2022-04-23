module oursring_many_to_1_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_slow_io_pkg::*;
#(
  parameter NUM_MASTERS = 2,
  parameter NUM_SLAVES  = 1
) (
  input clk,
  input rstn,

  input   logic                 [NUM_MASTERS-1:0] i_or_req_if_awvalid,
  input   oursring_req_if_aw_t  [NUM_MASTERS-1:0] i_or_req_if_aw,
  output  logic                 [NUM_MASTERS-1:0] i_or_req_if_awready,
  
  input   logic                 [NUM_MASTERS-1:0] i_or_req_if_wvalid,
  input   oursring_req_if_w_t   [NUM_MASTERS-1:0] i_or_req_if_w,
  output  logic                 [NUM_MASTERS-1:0] i_or_req_if_wready,
  
  input   logic                 [NUM_MASTERS-1:0] i_or_req_if_arvalid,
  input   oursring_req_if_ar_t  [NUM_MASTERS-1:0] i_or_req_if_ar,
  output  logic                 [NUM_MASTERS-1:0] i_or_req_if_arready,

  output  logic                 [NUM_MASTERS-1:0] o_or_rsp_if_bvalid,
  output  oursring_resp_if_b_t  [NUM_MASTERS-1:0] o_or_rsp_if_b,
  input   logic                 [NUM_MASTERS-1:0] o_or_rsp_if_bready,
   
  output  logic                 [NUM_MASTERS-1:0] o_or_rsp_if_rvalid,
  output  oursring_resp_if_r_t  [NUM_MASTERS-1:0] o_or_rsp_if_r,
  input   logic                 [NUM_MASTERS-1:0] o_or_rsp_if_rready,
  
  output  logic                 [NUM_SLAVES-1:0]  o_or_req_if_awvalid,
  output  oursring_req_if_aw_t  [NUM_SLAVES-1:0]  o_or_req_if_aw,
  input   logic                 [NUM_SLAVES-1:0]  o_or_req_if_awready,
  
  output  logic                 [NUM_SLAVES-1:0]  o_or_req_if_wvalid,
  output  oursring_req_if_w_t   [NUM_SLAVES-1:0]  o_or_req_if_w,
  input   logic                 [NUM_SLAVES-1:0]  o_or_req_if_wready,
  
  output  logic                 [NUM_SLAVES-1:0]  o_or_req_if_arvalid,
  output  oursring_req_if_ar_t  [NUM_SLAVES-1:0]  o_or_req_if_ar,
  input   logic                 [NUM_SLAVES-1:0]  o_or_req_if_arready,
  
  input   logic                 [NUM_SLAVES-1:0]  i_or_rsp_if_bvalid,
  input   oursring_resp_if_b_t  [NUM_SLAVES-1:0]  i_or_rsp_if_b,
  output  logic                 [NUM_SLAVES-1:0]  i_or_rsp_if_bready,
  
  input   logic                 [NUM_SLAVES-1:0]  i_or_rsp_if_rvalid,
  input   oursring_resp_if_r_t  [NUM_SLAVES-1:0]  i_or_rsp_if_r,
  output  logic                 [NUM_SLAVES-1:0]  i_or_rsp_if_rready
);

  localparam BUF_IN_DEPTH_AW      = 1;
  localparam BUF_IN_DEPTH_W       = 1;
  localparam BUF_IN_DEPTH_B       = 1;
  localparam BUF_IN_DEPTH_AR      = 1;
  localparam BUF_IN_DEPTH_R       = 1;

  localparam BUF_MID_DEPTH_AW     = 1;
  localparam BUF_MID_DEPTH_W      = 1;
  localparam BUF_MID_DEPTH_B      = 1;
  localparam BUF_MID_DEPTH_AR     = 1;
  localparam BUF_MID_DEPTH_R      = 1;

  localparam BUF_OUT_DEPTH_AW     = 1;
  localparam BUF_OUT_DEPTH_W      = 1;
  localparam BUF_OUT_DEPTH_B      = 1;
  localparam BUF_OUT_DEPTH_AR     = 1;
  localparam BUF_OUT_DEPTH_R      = 1;

  localparam ARB_MAX_N_PORT       = 4;
  localparam WLAST_POSITION       = $bits(mem_tid_t);
  localparam RLAST_POSITION       = 0;

  localparam MASTERID_SIZE        = $clog2(NUM_MASTERS);

  localparam ADDR_CHUNK           = STATION_SLOW_IO_RTC_BLOCK_REG_OFFSET;

  logic [NUM_SLAVES-1:0]  aw_w_clk_en;
  logic [NUM_SLAVES-1:0]  ar_clk_en;
  logic [NUM_MASTERS-1:0] b_clk_en;
  logic [NUM_MASTERS-1:0] r_clk_en;
  logic                   clkg;

  oursring_req_if_aw_t [NUM_MASTERS-1:0] aw_id_fix;
  oursring_req_if_w_t  [NUM_MASTERS-1:0] w_id_fix;
  oursring_req_if_ar_t [NUM_MASTERS-1:0] ar_id_fix;

  generate
    for (genvar i = 0; i < NUM_MASTERS; i++) begin : ID_FIX
      assign aw_id_fix[i].awaddr                  = i_or_req_if_aw[i].awaddr;
      assign aw_id_fix[i].awid[11:7]              = 5'b0;
      assign aw_id_fix[i].awid[6-:MASTERID_SIZE]  = i[MASTERID_SIZE-1:0];
      assign aw_id_fix[i].awid[6-MASTERID_SIZE:0] = i_or_req_if_aw[i].awid[6-MASTERID_SIZE:0];

      assign w_id_fix[i].wdata                  = i_or_req_if_w[i].wdata;
      assign w_id_fix[i].wlast                  = i_or_req_if_w[i].wlast;
      assign w_id_fix[i].wstrb                  = i_or_req_if_w[i].wstrb;

      assign ar_id_fix[i].araddr                  = i_or_req_if_ar[i].araddr;
      assign ar_id_fix[i].arid[11:7]              = 5'b0;
      assign ar_id_fix[i].arid[6-:MASTERID_SIZE]  = i[MASTERID_SIZE-1:0];
      assign ar_id_fix[i].arid[6-MASTERID_SIZE:0] = i_or_req_if_ar[i].arid[6-MASTERID_SIZE:0];
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
        .AW_WIDTH         ($bits(oursring_req_if_aw_t)),
        .W_WIDTH          ($bits(oursring_req_if_w_t)),
        .WLAST_POSITION   (WLAST_POSITION),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) aw_w_u (
        .slave_awvld      (i_or_req_if_awvalid),
        .slave_aw         (aw_id_fix),
        .slave_awrdy      (i_or_req_if_awready),
        .slave_wvld       (i_or_req_if_wvalid),
        .slave_w          (w_id_fix),
        .slave_wrdy       (i_or_req_if_wready),
        .master_awvld     (o_or_req_if_awvalid),
        .master_aw        (o_or_req_if_aw),
        .master_awrdy     (o_or_req_if_awready),
        .master_wvld      (o_or_req_if_wvalid),
        .master_w         (o_or_req_if_w),
        .master_wrdy      (o_or_req_if_wready),
        .clk_en           (aw_w_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT          (NUM_MASTERS),
        .WIDTH            ($bits(oursring_req_if_ar_t)),
        .BUF_IN_DEPTH     (BUF_IN_DEPTH_AR),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_AR),
        .BUF_MID_DEPTH    (BUF_MID_DEPTH_AR),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) ar_u (
        .slave_valid      (i_or_req_if_arvalid),
        .slave_info       (ar_id_fix),
        .slave_ready      (i_or_req_if_arready),
        .master_valid     (o_or_req_if_arvalid),
        .master_info      (o_or_req_if_ar),
        .master_ready     (o_or_req_if_arready),
        .clk_en           (ar_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

    end else begin : REQ_NUM_SLAVES_GT_1
      logic [NUM_SLAVES - 1 : 0] tmp_awvalid;
      logic [NUM_SLAVES - 1 : 0] tmp_awready;
      logic [NUM_SLAVES - 1 : 0] tmp_wvalid;
      logic [NUM_SLAVES - 1 : 0] tmp_wready;
      logic [NUM_SLAVES - 1 : 0] tmp_arvalid;
      logic [NUM_SLAVES - 1 : 0] tmp_arready;

      for (genvar i = 0; i < NUM_SLAVES; i++) begin
        assign tmp_awvalid[i] = i_or_req_if_awvalid[0] & (i_or_req_if_aw[0].awaddr >= (i * ADDR_CHUNK)) & (i_or_req_if_aw[0].awaddr < ((i + 1) * ADDR_CHUNK));
        assign tmp_wvalid[i]  = i_or_req_if_wvalid[0]  & (i_or_req_if_aw[0].awaddr >= (i * ADDR_CHUNK)) & (i_or_req_if_aw[0].awaddr < ((i + 1) * ADDR_CHUNK)); // AW and W are checked at the same time
        assign tmp_arvalid[i] = i_or_req_if_arvalid[0] & (i_or_req_if_ar[0].araddr >= (i * ADDR_CHUNK)) & (i_or_req_if_ar[0].araddr < ((i + 1) * ADDR_CHUNK));
      end

      assign i_or_req_if_awready = |tmp_awready;
      assign i_or_req_if_wready  = |tmp_wready;
      assign i_or_req_if_arready = |tmp_arready;

      for (genvar i = 0; i < NUM_SLAVES; i++) begin
        ours_multi_lyr_axi4_aw_w_rr_arb #(
          .BUF_IN_DEPTH_AW  (BUF_IN_DEPTH_AW),
          .BUF_OUT_DEPTH_AW (BUF_OUT_DEPTH_AW),
          .BUF_MID_DEPTH_AW (BUF_MID_DEPTH_AW),
          .BUF_IN_DEPTH_W   (BUF_IN_DEPTH_W),
          .BUF_OUT_DEPTH_W  (BUF_OUT_DEPTH_W),
          .BUF_MID_DEPTH_W  (BUF_MID_DEPTH_W),
          .N_INPUT          (NUM_MASTERS),
          .AW_WIDTH         ($bits(oursring_req_if_aw_t)),
          .W_WIDTH          ($bits(oursring_req_if_w_t)),
          .WLAST_POSITION   (WLAST_POSITION),
          .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
        ) aw_w_u (
          .slave_awvld      (tmp_awvalid[i]),
          .slave_aw         (i_or_req_if_aw[0]),
          .slave_awrdy      (tmp_awready[i]),
          .slave_wvld       (tmp_wvalid[i]),
          .slave_w          (i_or_req_if_w[0]),
          .slave_wrdy       (tmp_wready[i]),
          .master_awvld     (o_or_req_if_awvalid[i]),
          .master_aw        (o_or_req_if_aw[i]),
          .master_awrdy     (o_or_req_if_awready[i]),
          .master_wvld      (o_or_req_if_wvalid[i]),
          .master_w         (o_or_req_if_w[i]),
          .master_wrdy      (o_or_req_if_wready[i]),
          .clk_en           (aw_w_clk_en[i]),
          .rstn             (rstn),
          .clk              (clkg));
    
        ours_multi_lyr_vld_rdy_rr_arb #(
          .N_INPUT          (NUM_MASTERS),
          .WIDTH            ($bits(oursring_req_if_ar_t)),
          .BUF_IN_DEPTH     (BUF_IN_DEPTH_AR),
          .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_AR),
          .BUF_MID_DEPTH    (BUF_MID_DEPTH_AR),
          .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
        ) ar_u (
          .slave_valid      (tmp_arvalid[i]),
          .slave_info       (i_or_req_if_ar[0]),
          .slave_ready      (tmp_arready[i]),
          .master_valid     (o_or_req_if_arvalid[i]),
          .master_info      (o_or_req_if_ar[i]),
          .master_ready     (o_or_req_if_arready[i]),
          .clk_en           (ar_clk_en[i]),
          .rstn             (rstn),
          .clk              (clkg));
      end
    end
  endgenerate

  generate
    if (NUM_MASTERS == 1) begin : RSP_NUM_MASTERS_EQ_1
      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT          (NUM_SLAVES),
        .WIDTH            ($bits(oursring_resp_if_b_t)),
        .BUF_IN_DEPTH     (BUF_IN_DEPTH_B),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_B),
        .BUF_MID_DEPTH    (BUF_MID_DEPTH_B),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) b_u (
        .slave_valid      (i_or_rsp_if_bvalid),
        .slave_info       (i_or_rsp_if_b),
        .slave_ready      (i_or_rsp_if_bready),
        .master_valid     (o_or_rsp_if_bvalid[0]),
        .master_info      (o_or_rsp_if_b[0]),
        .master_ready     (o_or_rsp_if_bready[0]),
        .clk_en           (b_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

      ours_multi_lyr_axi4_r_rr_arb #(
        .N_INPUT          (NUM_SLAVES),
        .WIDTH            ($bits(oursring_resp_if_r_t)),
        .BUF_IN_DEPTH     (BUF_IN_DEPTH_R),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_R),
        .BUF_MID_DEPTH    (BUF_MID_DEPTH_R),
        .RLAST_POSITION   (RLAST_POSITION),
        .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
      ) r_u (
        .slave_rvld       (i_or_rsp_if_rvalid),
        .slave_r          (i_or_rsp_if_r),
        .slave_rrdy       (i_or_rsp_if_rready),
        .master_rvld      (o_or_rsp_if_rvalid[0]),
        .master_r         (o_or_rsp_if_r[0]),
        .master_rrdy      (o_or_rsp_if_rready[0]),
        .clk_en           (r_clk_en[0]),
        .rstn             (rstn),
        .clk              (clkg));

    end else begin : RSP_NUM_MASTERS_GT_1

    logic                 [NUM_SLAVES-1:0][NUM_MASTERS-1:0] bvld_s_m;
    oursring_resp_if_b_t  [NUM_SLAVES-1:0][NUM_MASTERS-1:0] b_s_m;
    logic                 [NUM_SLAVES-1:0][NUM_MASTERS-1:0] brdy_s_m;

    logic                 [NUM_MASTERS-1:0][NUM_SLAVES-1:0] bvld_m_s;
    oursring_resp_if_b_t  [NUM_MASTERS-1:0][NUM_SLAVES-1:0] b_m_s;
    logic                 [NUM_MASTERS-1:0][NUM_SLAVES-1:0] brdy_m_s;
                                                       
    logic                 [NUM_SLAVES-1:0][NUM_MASTERS-1:0] rvld_s_m;
    oursring_resp_if_r_t  [NUM_SLAVES-1:0][NUM_MASTERS-1:0] r_s_m;
    logic                 [NUM_SLAVES-1:0][NUM_MASTERS-1:0] rrdy_s_m;

    logic                 [NUM_MASTERS-1:0][NUM_SLAVES-1:0] rvld_m_s;
    oursring_resp_if_r_t  [NUM_MASTERS-1:0][NUM_SLAVES-1:0] r_m_s;
    logic                 [NUM_MASTERS-1:0][NUM_SLAVES-1:0] rrdy_m_s;

	  logic 			[NUM_MASTERS-1:0]	bready_temp;
	  logic 			[NUM_MASTERS-1:0]	rready_temp;

      for (genvar j = 0; j < NUM_SLAVES; j++) begin : CONNECTION_LOOP_SLAVE
        for (genvar i = 0; i < NUM_MASTERS; i++) begin : CONNECTION_LOOP_MASTER
          assign bvld_s_m[j][i] = i_or_rsp_if_bvalid[j] & (i_or_rsp_if_b[j].bid[6-:MASTERID_SIZE] == i[MASTERID_SIZE-1:0]);
          assign bvld_m_s[i][j] = i_or_rsp_if_bvalid[j] & (i_or_rsp_if_b[j].bid[6-:MASTERID_SIZE] == i[MASTERID_SIZE-1:0]);
          assign b_s_m[j][i]    = i_or_rsp_if_b;
          assign b_m_s[i][j]    = i_or_rsp_if_b;
          assign rvld_s_m[j][i] = i_or_rsp_if_rvalid[j] & (i_or_rsp_if_r[j].rid[6-:MASTERID_SIZE] == i[MASTERID_SIZE-1:0]);
          assign rvld_m_s[i][j] = i_or_rsp_if_rvalid[j] & (i_or_rsp_if_r[j].rid[6-:MASTERID_SIZE] == i[MASTERID_SIZE-1:0]);
          assign r_s_m[j][i]    = i_or_rsp_if_r;
          assign r_m_s[i][j]    = i_or_rsp_if_r;
          assign brdy_s_m[j][i] = brdy_m_s[i][j];
          assign rrdy_s_m[j][i] = rrdy_m_s[i][j];
        end
        always_comb begin
          for (int ii = 0; ii < NUM_MASTERS; ii++) begin
            bready_temp[ii] = brdy_s_m[j][ii] & (i_or_rsp_if_b[j].bid[6-:MASTERID_SIZE] == ii) & i_or_rsp_if_bvalid[j];
          end
          for (int ii = 0; ii < NUM_MASTERS; ii++) begin
            rready_temp[ii] = rrdy_s_m[j][ii] & (i_or_rsp_if_r[j].rid[6-:MASTERID_SIZE] == ii) & i_or_rsp_if_rvalid[j];
          end
		  i_or_rsp_if_bready[j] = |bready_temp;
		  i_or_rsp_if_rready[j] = |rready_temp;
        end
      end

      for (genvar i = 0; i < NUM_MASTERS; i++) begin : RSP_NUM_MASTERS_LOOP
        ours_multi_lyr_vld_rdy_rr_arb #(
          .N_INPUT          (NUM_SLAVES),
          .WIDTH            ($bits(oursring_resp_if_b_t)),
          .BUF_IN_DEPTH     (BUF_IN_DEPTH_B),
          .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_B),
          .BUF_MID_DEPTH    (BUF_MID_DEPTH_B),
          .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
        ) b_u (
          .slave_valid      (bvld_m_s[i]),
          .slave_info       (b_m_s[i]),
          .slave_ready      (brdy_m_s[i]),
          .master_valid     (o_or_rsp_if_bvalid[i]),
          .master_info      (o_or_rsp_if_b[i]),
          .master_ready     (o_or_rsp_if_bready[i]),
          .clk_en           (b_clk_en[i]),
          .rstn             (rstn),
          .clk              (clkg));
  
        ours_multi_lyr_axi4_r_rr_arb #(
          .N_INPUT          (NUM_SLAVES),
          .WIDTH            ($bits(oursring_resp_if_r_t)),
          .BUF_IN_DEPTH     (BUF_IN_DEPTH_R),
          .BUF_OUT_DEPTH    (BUF_OUT_DEPTH_R),
          .BUF_MID_DEPTH    (BUF_MID_DEPTH_R),
          .RLAST_POSITION   (RLAST_POSITION),
          .ARB_MAX_N_PORT   (ARB_MAX_N_PORT)
        ) r_u (
          .slave_rvld       (rvld_m_s[i]),
          .slave_r          (r_m_s[i]),
          .slave_rrdy       (rrdy_m_s[i]),
          .master_rvld      (o_or_rsp_if_rvalid[i]),
          .master_r         (o_or_rsp_if_r[i]),
          .master_rrdy      (o_or_rsp_if_rready[i]),
          .clk_en           (r_clk_en[i]),
          .rstn             (rstn),
          .clk              (clkg));

      end

    end
  endgenerate

endmodule
