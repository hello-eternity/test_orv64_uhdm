module ddr_vcu118
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  // DDR4
  input  logic sys_rst,
  input  logic c0_sys_clk_p,
  input  logic c0_sys_clk_n,
  output logic c0_ddr4_act_n,
  output logic [16:0]c0_ddr4_adr,
  output logic [1:0]c0_ddr4_ba,
  output logic [0:0]c0_ddr4_bg,
  output logic [0:0]c0_ddr4_cke,
  output logic [0:0]c0_ddr4_odt,
  output logic [0:0]c0_ddr4_cs_n,
  output logic [0:0]c0_ddr4_ck_t,
  output logic [0:0]c0_ddr4_ck_c,
  output logic c0_ddr4_reset_n,
  inout  wire  [7:0]c0_ddr4_dm_dbi_n,
  inout  wire  [63:0]c0_ddr4_dq,
  inout  wire  [7:0]c0_ddr4_dqs_c,
  inout  wire  [7:0]c0_ddr4_dqs_t,
  output logic c0_init_calib_complete,
  output logic addn_ui_clkout1,

  // CACHE MEM IF
  input  logic 				req_if_awvalid,
  output logic 				req_if_awready,
  input  logic 				req_if_wvalid,
  output logic 				req_if_wready,
  input  logic 				req_if_arvalid,
  output logic 				req_if_arready,
  input  cache_mem_if_ar_t              req_if_ar,
  input  cache_mem_if_w_t               req_if_w,
  input  cache_mem_if_aw_t              req_if_aw,
  output logic 				rsp_if_rvalid,
  input  logic 				rsp_if_rready,
  output logic 				rsp_if_bvalid,
  input  logic 				rsp_if_bready,
  output cache_mem_if_b_t               rsp_if_b,
  output cache_mem_if_r_t               rsp_if_r

);

  logic  S00_AXI_ARESET_OUT_N;
  logic [7:0]  S00_AXI_AWID;
  logic [39:0] S00_AXI_AWADDR;
  logic [7:0]  S00_AXI_AWLEN;
  logic [2:0]  S00_AXI_AWSIZE;
  logic [1:0]  S00_AXI_AWBURST;
  logic S00_AXI_AWLOCK;
  logic [3:0]  S00_AXI_AWCACHE;
  logic [2:0]  S00_AXI_AWPROT;
  logic [3:0]  S00_AXI_AWQOS;
  logic S00_AXI_AWVALID;
  logic S00_AXI_AWREADY;
  logic [511:0] S00_AXI_WDATA;
  logic [63:0]  S00_AXI_WSTRB;
  logic S00_AXI_WLAST;
  logic S00_AXI_WVALID;
  logic S00_AXI_WREADY;
  logic [7:0]  S00_AXI_BID;
  logic [1:0]  S00_AXI_BRESP;
  logic S00_AXI_BVALID;
  logic S00_AXI_BREADY;
  logic [7:0]  S00_AXI_ARID;
  logic [39:0] S00_AXI_ARADDR;
  logic [7:0]  S00_AXI_ARLEN;
  logic [2:0]  S00_AXI_ARSIZE;
  logic [1:0]  S00_AXI_ARBURST;
  logic S00_AXI_ARLOCK;
  logic [3:0]  S00_AXI_ARCACHE;
  logic [2:0]  S00_AXI_ARPROT;
  logic [3:0]  S00_AXI_ARQOS;
  logic S00_AXI_ARVALID;
  logic S00_AXI_ARREADY;
  logic [7:0]  S00_AXI_RID;
  logic [511:0] S00_AXI_RDATA;
  logic [1:0]  S00_AXI_RRESP;
  logic S00_AXI_RLAST;
  logic S00_AXI_RVALID;
  logic S00_AXI_RREADY;
  logic M00_AXI_ARESET_OUT_N;
  logic M00_AXI_ACLK;
  logic [11:0] M00_AXI_AWID;
  logic [39:0] M00_AXI_AWADDR;
  logic [7:0]  M00_AXI_AWLEN;
  logic [2:0]  M00_AXI_AWSIZE;
  logic [1:0]  M00_AXI_AWBURST;
  logic M00_AXI_AWLOCK;
  logic [3:0]  M00_AXI_AWCACHE;
  logic [2:0]  M00_AXI_AWPROT;
  logic [3:0]  M00_AXI_AWQOS;
  logic M00_AXI_AWVALID;
  logic M00_AXI_AWREADY;
  logic [511:0] M00_AXI_WDATA;
  logic [63:0]  M00_AXI_WSTRB;
  logic M00_AXI_WLAST;
  logic M00_AXI_WVALID;
  logic M00_AXI_WREADY;
  logic [11:0] M00_AXI_BID;
  logic [1:0]  M00_AXI_BRESP;
  logic M00_AXI_BVALID;
  logic M00_AXI_BREADY;
  logic [11:0]  M00_AXI_ARID;
  logic [39:0] M00_AXI_ARADDR;
  logic [7:0]  M00_AXI_ARLEN;
  logic [2:0]  M00_AXI_ARSIZE;
  logic [1:0]  M00_AXI_ARBURST;
  logic M00_AXI_ARLOCK;
  logic [3:0]  M00_AXI_ARCACHE;
  logic [2:0]  M00_AXI_ARPROT;
  logic [3:0]  M00_AXI_ARQOS;
  logic M00_AXI_ARVALID;
  logic M00_AXI_ARREADY;
  logic [11:0] M00_AXI_RID;
  logic [511:0] M00_AXI_RDATA;
  logic [1:0]  M00_AXI_RRESP;
  logic M00_AXI_RLAST;
  logic M00_AXI_RVALID;
  logic M00_AXI_RREADY;
  logic c0_ddr4_ui_clk;
  logic c0_ddr4_ui_clk_sync_rst;
  logic dbg_clk;
  logic [511:0]dbg_bus;

  // wdata accumulation 
  logic [63:0] dff_w_data[3:0];
  logic [511:0] w_data_to_cdc;
  logic [2:0]	rff_w_cnt;
  logic 		dff_w_strb_to_cdc;
  logic 		w_last_accepted;
  logic         w_data_to_cdc_vld;
  logic [63:0]        w_strb_to_cdc;

  assign S00_AXI_AWID    = req_if_aw.awid;
  assign S00_AXI_AWADDR  = req_if_aw.awaddr;
  assign S00_AXI_AWLEN   = '0;
  assign S00_AXI_AWSIZE  = 3'b101; // 32 bytes
  assign S00_AXI_AWBURST = 2'b0;   // fixed
  assign S00_AXI_AWLOCK  = '0;
  assign S00_AXI_AWCACHE = '0;
  assign S00_AXI_AWPROT  = '0;
  assign S00_AXI_AWQOS   = '0;
  assign S00_AXI_AWVALID = req_if_awvalid;
  assign req_if_awready  = S00_AXI_AWREADY;

  //assign S00_AXI_WDATA   = req_if_w.wdata;
  //assign S00_AXI_WSTRB   = 8'hff;
  //assign S00_AXI_WLAST   = req_if_w.wlast;
  //assign S00_AXI_WVALID  = req_if_wvalid;
  //assign req_if_wready   = ~rff_w_cnt[2];

  assign rsp_if_b.bid    = S00_AXI_BID;
  assign rsp_if_b.bresp  = axi4_resp_t'(S00_AXI_BRESP);
  assign rsp_if_bvalid   = S00_AXI_BVALID;
  assign S00_AXI_BREADY  = rsp_if_bready;

  logic             w_buf_valid;
  cache_mem_if_w_t  w_buf_w;
  logic             w_buf_ready;

  logic w_b6_empty;
  logic w_b6_full;
  logic w_b6_dout;
  logic w_b6_din;
  logic w_b6_we;
  logic w_b6_re;

  ours_fifo #(.WIDTH(1), .DEPTH(1024)) awaddr_b6_u (
    .empty (w_b6_empty),
    .full  (w_b6_full),
    .dout  (w_b6_dout),
    .din   (w_b6_din),
    .we    (w_b6_we),
    .re    (w_b6_re),
    .rstn  (S00_AXI_ARESET_OUT_N),
    .clk   (addn_ui_clkout1));

  assign w_b6_we    = (req_if_awvalid & req_if_awready);
  assign w_b6_din   = req_if_aw.awaddr[5];
  assign w_b6_re    = S00_AXI_WVALID & S00_AXI_WREADY;

  ours_vld_rdy_buf #(.WIDTH($bits(cache_mem_if_w_t)), .DEPTH(8)) w_buf_u (
    .slave_valid  (req_if_wvalid),
    .slave_info   (req_if_w),
    .slave_ready  (req_if_wready),
    .master_valid (w_buf_valid),
    .master_info  (w_buf_w),
    .master_ready (w_buf_ready),
    .clk_en       (),
    .rstn         (S00_AXI_ARESET_OUT_N),
    .clk          (addn_ui_clkout1));

  typedef enum logic [2:0] { FETCH_LESS_4, SEND_DOWN } state_e;
  state_e rff_st, next_st;
  logic [1:0] rff_cnt, next_cnt;
  cache_mem_if_w_t [3:0] dff_w;

  always_ff @(posedge addn_ui_clkout1) begin
    if (S00_AXI_ARESET_OUT_N == 1'b0) begin
      rff_st  <= FETCH_LESS_4;
      rff_cnt <= 2'b0;
    end else begin
      rff_st  <= next_st;
      rff_cnt <= next_cnt;
    end
  end

  generate
    for (genvar i = 0; i < 4; i++) begin : DFF_WDATA_ASSIGN
      always_ff @(posedge addn_ui_clkout1) begin
        if ((rff_cnt == i) & w_buf_valid & w_buf_ready) begin
          dff_w[i] <= w_buf_w;
        end
      end
    end
  endgenerate

  always_comb begin
    next_cnt = rff_cnt;
    next_st  = rff_st;
    case (rff_st)
      FETCH_LESS_4: begin
        if (w_buf_valid & w_buf_ready) begin
          next_cnt = rff_cnt + 1;
          if (rff_cnt == 2'b11) begin
            next_st = SEND_DOWN;
          end
        end
      end
      SEND_DOWN: begin
        if (S00_AXI_WVALID & S00_AXI_WREADY) begin
          next_st = FETCH_LESS_4;
        end
      end
    endcase
  end

  assign w_buf_ready = (rff_st == FETCH_LESS_4);

  assign S00_AXI_WVALID = (rff_st == SEND_DOWN);
  assign w_strb_to_cdc  = w_b6_dout ? {{32{1'b1}},{32{1'b0}}} : {{32{1'b0}},{32{1'b1}}};
  assign S00_AXI_WDATA  = w_b6_dout ? {dff_w[3].wdata,dff_w[2].wdata,dff_w[1].wdata,dff_w[0].wdata,256'b0} : {256'b0,dff_w[3].wdata,dff_w[2].wdata,dff_w[1].wdata,dff_w[0].wdata};


  assign S00_AXI_ARID    = req_if_ar.arid;
  assign S00_AXI_ARADDR  = req_if_ar.araddr;
  assign S00_AXI_ARLEN   = '0;
  assign S00_AXI_ARSIZE  = 3'b101;
  assign S00_AXI_ARBURST = 2'h0;
  assign S00_AXI_ARLOCK  = '0;
  assign S00_AXI_ARCACHE = '0;
  assign S00_AXI_ARPROT  = '0;
  assign S00_AXI_ARQOS   = '0;
  assign S00_AXI_ARVALID = req_if_arvalid;
  assign req_if_arready  = S00_AXI_ARREADY;


  // rdata accumulation
  logic r_b6_empty;
  logic r_b6_full;
  logic r_b6_dout;
  logic r_b6_din;
  logic r_b6_we;
  logic r_b6_re;

  ours_fifo #(.WIDTH(1), .DEPTH(1024)) araddr_b6_u (
    .empty (r_b6_empty),
    .full  (r_b6_full),
    .dout  (r_b6_dout),
    .din   (r_b6_din),
    .we    (r_b6_we),
    .re    (r_b6_re),
    .rstn  (S00_AXI_ARESET_OUT_N),
    .clk   (addn_ui_clkout1));

  assign r_b6_we    = (req_if_arvalid & req_if_arready);
  assign r_b6_din   = req_if_ar.araddr[5];
  assign r_b6_re    = S00_AXI_RVALID & S00_AXI_RREADY;


  logic [1:0]   rff_r_cnt;
  logic	[63:0]	r_data[3:0];
  logic [255:0] r_data_align;
  logic         r_valid;
  logic         r_ready;
  logic	        r_last;
  logic         r_buf_valid;
  logic         r_last_accepted;

  assign r_data_align = r_b6_dout ? S00_AXI_RDATA[511:256] : S00_AXI_RDATA[255:0];

  always_ff @ (posedge addn_ui_clkout1) begin
    if (!S00_AXI_ARESET_OUT_N) begin
      rff_r_cnt <= '0;
    end else if (rsp_if_rvalid & rsp_if_rready | r_last_accepted) begin
      rff_r_cnt <= r_last_accepted ? '0 : rff_r_cnt + 1;
    end
  end
  assign rsp_if_r.rdata = r_data[rff_r_cnt];
  assign rsp_if_r.rlast = (rff_r_cnt == 2'b11); 
  assign r_last_accepted = (rff_r_cnt== 2'b11) & rsp_if_rready & rsp_if_rvalid;
  assign r_ready = r_last_accepted; 

  ours_vld_rdy_buf #(.WIDTH(256+$bits(axi4_resp_t)+$bits(S00_AXI_RID)), .DEPTH(2)) r_buf_u (
    .slave_valid  (S00_AXI_RVALID),
    .slave_info   ({r_data_align,axi4_resp_t'(S00_AXI_RRESP),S00_AXI_RID}),
    .slave_ready  (S00_AXI_RREADY),
    .master_valid (rsp_if_rvalid),
    .master_info  ({r_data[3],r_data[2],r_data[1],r_data[0],rsp_if_r.rresp,rsp_if_r.rid}),
    .master_ready (r_ready),
    .clk_en       (),
    .rstn         (S00_AXI_ARESET_OUT_N),
    .clk          (addn_ui_clkout1));
  
//  ours_vld_rdy_buf #(.WIDTH(1), .DEPTH(4)) ar_buf_u (
//    .slave_valid  (S00_AXI_ARVALID & S00_AXI_ARREADY),
//    .slave_info   (S00_AXI_ARADDR[6]),
//    .slave_ready  (ar_buf_ready),
//    .master_valid (r_buf_valid),
//    .master_info  (r_strb),
//    .master_ready (r_ready),
//    .clk_en       (),
//    .rstn         (S00_AXI_ARESET_OUT_N),
//    .clk          (addn_ui_clkout1));

  xddr_cdc xddr_cdc_u (
    .INTERCONNECT_ACLK(addn_ui_clkout1),
    .INTERCONNECT_ARESETN  (c0_init_calib_complete),
    .S00_AXI_ARESET_OUT_N,
    .S00_AXI_ACLK(addn_ui_clkout1),
    .S00_AXI_AWID,
    .S00_AXI_AWADDR,
    .S00_AXI_AWLEN,
    .S00_AXI_AWSIZE,
    .S00_AXI_AWBURST,
    .S00_AXI_AWLOCK,
    .S00_AXI_AWCACHE,
    .S00_AXI_AWPROT,
    .S00_AXI_AWQOS,
    .S00_AXI_AWVALID,
    .S00_AXI_AWREADY,
    .S00_AXI_WDATA,
    .S00_AXI_WSTRB(w_strb_to_cdc),
    .S00_AXI_WLAST(1'b1),
    .S00_AXI_WVALID,
    .S00_AXI_WREADY,
    .S00_AXI_BID,
    .S00_AXI_BRESP,
    .S00_AXI_BVALID,
    .S00_AXI_BREADY,
    .S00_AXI_ARID,
    .S00_AXI_ARADDR,
    .S00_AXI_ARLEN,
    .S00_AXI_ARSIZE,
    .S00_AXI_ARBURST,
    .S00_AXI_ARLOCK,
    .S00_AXI_ARCACHE,
    .S00_AXI_ARPROT,
    .S00_AXI_ARQOS,
    .S00_AXI_ARVALID,
    .S00_AXI_ARREADY,
    .S00_AXI_RID,
    .S00_AXI_RDATA,
    .S00_AXI_RRESP,
    .S00_AXI_RLAST,
    .S00_AXI_RVALID,
    .S00_AXI_RREADY,
    .M00_AXI_ARESET_OUT_N,
    .M00_AXI_ACLK,
    .M00_AXI_AWID,
    .M00_AXI_AWADDR,
    .M00_AXI_AWLEN,
    .M00_AXI_AWSIZE,
    .M00_AXI_AWBURST,
    .M00_AXI_AWLOCK,
    .M00_AXI_AWCACHE,
    .M00_AXI_AWPROT,
    .M00_AXI_AWQOS,
    .M00_AXI_AWVALID,
    .M00_AXI_AWREADY,
    .M00_AXI_WDATA,
    .M00_AXI_WSTRB,
    .M00_AXI_WLAST,
    .M00_AXI_WVALID,
    .M00_AXI_WREADY,
    .M00_AXI_BID,
    .M00_AXI_BRESP,
    .M00_AXI_BVALID,
    .M00_AXI_BREADY,
    .M00_AXI_ARID,
    .M00_AXI_ARADDR,
    .M00_AXI_ARLEN,
    .M00_AXI_ARSIZE,
    .M00_AXI_ARBURST,
    .M00_AXI_ARLOCK,
    .M00_AXI_ARCACHE,
    .M00_AXI_ARPROT,
    .M00_AXI_ARQOS,
    .M00_AXI_ARVALID,
    .M00_AXI_ARREADY,
    .M00_AXI_RID,
    .M00_AXI_RDATA,
    .M00_AXI_RRESP,
    .M00_AXI_RLAST,
    .M00_AXI_RVALID,
    .M00_AXI_RREADY
  );

  logic [7:0]  c0_ddr4_s_axi_awid;
  logic [30:0] c0_ddr4_s_axi_awaddr;
  logic [7:0]  c0_ddr4_s_axi_bid;
  logic [7:0]  c0_ddr4_s_axi_arid;
  logic [30:0] c0_ddr4_s_axi_araddr;
  logic [7:0]  c0_ddr4_s_axi_rid;

  assign c0_ddr4_s_axi_awid = M00_AXI_AWID;
  assign c0_ddr4_s_axi_awaddr = M00_AXI_AWADDR;
  assign M00_AXI_BID = c0_ddr4_s_axi_bid;
  assign c0_ddr4_s_axi_arid = M00_AXI_ARID;
  assign c0_ddr4_s_axi_araddr = M00_AXI_ARADDR;
  assign M00_AXI_RID = c0_ddr4_s_axi_rid;

  ddr4_0 ddr4_0_u(
   .sys_rst,
   .c0_sys_clk_p,
   .c0_sys_clk_n,
   .c0_ddr4_act_n,
   .c0_ddr4_adr,
   .c0_ddr4_ba,
   .c0_ddr4_bg,
   .c0_ddr4_cke,
   .c0_ddr4_odt,
   .c0_ddr4_cs_n,
   .c0_ddr4_ck_t,
   .c0_ddr4_ck_c,
   .c0_ddr4_reset_n,
   .c0_ddr4_dm_dbi_n,
   .c0_ddr4_dq,
   .c0_ddr4_dqs_c,
   .c0_ddr4_dqs_t,
   .c0_init_calib_complete,
   .c0_ddr4_ui_clk            (M00_AXI_ACLK),
   .c0_ddr4_ui_clk_sync_rst,
   .addn_ui_clkout1,
   .dbg_clk,
   .c0_ddr4_aresetn	      (M00_AXI_ARESET_OUT_N),
   .c0_ddr4_s_axi_awid        (c0_ddr4_s_axi_awid),
   .c0_ddr4_s_axi_awaddr      (c0_ddr4_s_axi_awaddr),
   .c0_ddr4_s_axi_awlen       (M00_AXI_AWLEN),
   .c0_ddr4_s_axi_awsize      (M00_AXI_AWSIZE),
   .c0_ddr4_s_axi_awburst     (M00_AXI_AWBURST),
   .c0_ddr4_s_axi_awlock      (M00_AXI_AWLOCK),
   .c0_ddr4_s_axi_awcache     (M00_AXI_AWCACHE),
   .c0_ddr4_s_axi_awprot      (M00_AXI_AWPROT),
   .c0_ddr4_s_axi_awqos       (M00_AXI_AWQOS),
   .c0_ddr4_s_axi_awvalid     (M00_AXI_AWVALID),
   .c0_ddr4_s_axi_awready     (M00_AXI_AWREADY),
   .c0_ddr4_s_axi_wdata       (M00_AXI_WDATA),
   .c0_ddr4_s_axi_wstrb       (M00_AXI_WSTRB),
   .c0_ddr4_s_axi_wlast       (M00_AXI_WLAST),
   .c0_ddr4_s_axi_wvalid      (M00_AXI_WVALID),
   .c0_ddr4_s_axi_wready      (M00_AXI_WREADY),
   .c0_ddr4_s_axi_bready      (M00_AXI_BREADY),
   .c0_ddr4_s_axi_bid         (c0_ddr4_s_axi_bid),
   .c0_ddr4_s_axi_bresp       (M00_AXI_BRESP),
   .c0_ddr4_s_axi_bvalid      (M00_AXI_BVALID) ,
   .c0_ddr4_s_axi_arid        (c0_ddr4_s_axi_arid),
   .c0_ddr4_s_axi_araddr      (c0_ddr4_s_axi_araddr),
   .c0_ddr4_s_axi_arlen       (M00_AXI_ARLEN),
   .c0_ddr4_s_axi_arsize      (M00_AXI_ARSIZE),
   .c0_ddr4_s_axi_arburst     (M00_AXI_ARBURST),
   .c0_ddr4_s_axi_arlock      (M00_AXI_ARLOCK),
   .c0_ddr4_s_axi_arcache     (M00_AXI_ARCACHE),
   .c0_ddr4_s_axi_arprot      (M00_AXI_ARPROT),
   .c0_ddr4_s_axi_arqos       (M00_AXI_ARQOS),
   .c0_ddr4_s_axi_arvalid     (M00_AXI_ARVALID),
   .c0_ddr4_s_axi_arready     (M00_AXI_ARREADY),
   .c0_ddr4_s_axi_rready      (M00_AXI_RREADY),
   .c0_ddr4_s_axi_rid         (c0_ddr4_s_axi_rid),
   .c0_ddr4_s_axi_rdata       (M00_AXI_RDATA),
   .c0_ddr4_s_axi_rresp       (M00_AXI_RRESP),
   .c0_ddr4_s_axi_rlast       (M00_AXI_RLAST),
   .c0_ddr4_s_axi_rvalid      (M00_AXI_RVALID),
   .dbg_bus
);

endmodule
