module oursring_1_to_many_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_slow_io_pkg::*;
#(
  parameter ADDR_CHUNK  = 1024,
  parameter NUM_MASTERS = 1,
  parameter NUM_SLAVES  = 2
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

  localparam REQID_SLAVEID_SIZE   = $clog2(NUM_SLAVES);
  localparam REQID_SLAVEID_LSB    = MEMNOC_TID_TID_SIZE - REQID_SLAVEID_SIZE;
  localparam RSPID_MASTERID_SIZE  = MEMNOC_TID_MASTERID_SIZE;
  localparam RSPID_MASTERID_LSB   = MEMNOC_TID_TID_SIZE;

  logic [NUM_SLAVES-1:0]  aw_w_clk_en;
  logic [NUM_SLAVES-1:0]  ar_clk_en;
  logic [NUM_MASTERS-1:0] b_clk_en;
  logic [NUM_MASTERS-1:0] r_clk_en;
  logic                   clkg;

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
        .slave_aw         (i_or_req_if_aw),
        .slave_awrdy      (i_or_req_if_awready),
        .slave_wvld       (i_or_req_if_wvalid),
        .slave_w          (i_or_req_if_w),
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
        .slave_info       (i_or_req_if_ar),
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

      assign i_or_req_if_awready = |(tmp_awready & tmp_awvalid);
      assign i_or_req_if_wready  = |(tmp_wready  & tmp_wvalid);
      assign i_or_req_if_arready = |(tmp_arready & tmp_arvalid);

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
    end
  endgenerate

endmodule
