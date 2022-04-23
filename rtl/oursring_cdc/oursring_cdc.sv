module oursring_cdc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  //! Inputs
  input  logic                slave_clk,
  input  logic                master_clk,
  input  logic                slave_resetn,
  input  logic                master_resetn,

  //! Oursring to Axi
  input  logic                oursring_cdc_slave_req_if_awvalid,
  input  logic                oursring_cdc_slave_req_if_wvalid,
  input  logic                oursring_cdc_slave_req_if_arvalid,
  input  oursring_req_if_ar_t oursring_cdc_slave_req_if_ar,
  input  oursring_req_if_aw_t oursring_cdc_slave_req_if_aw,
  input  oursring_req_if_w_t  oursring_cdc_slave_req_if_w,
  output logic                oursring_cdc_slave_req_if_arready,
  output logic                oursring_cdc_slave_req_if_wready,
  output logic                oursring_cdc_slave_req_if_awready,

  //! Axi to Oursring
  output logic                cdc_oursring_slave_rsp_if_rvalid,
  output logic                cdc_oursring_slave_rsp_if_bvalid,
  output oursring_resp_if_r_t cdc_oursring_slave_rsp_if_r,
  output oursring_resp_if_b_t cdc_oursring_slave_rsp_if_b,
  input  logic                cdc_oursring_slave_rsp_if_rready,
  input  logic                cdc_oursring_slave_rsp_if_bready,
  
  //! Axi to Oursring
  output logic                cdc_oursring_master_req_if_awvalid,
  output logic                cdc_oursring_master_req_if_wvalid,
  output logic                cdc_oursring_master_req_if_arvalid,
  output oursring_req_if_ar_t cdc_oursring_master_req_if_ar,
  output oursring_req_if_aw_t cdc_oursring_master_req_if_aw,
  output oursring_req_if_w_t  cdc_oursring_master_req_if_w,
  input  logic                cdc_oursring_master_req_if_arready,
  input  logic                cdc_oursring_master_req_if_wready,
  input  logic                cdc_oursring_master_req_if_awready,

  //! Axi to Oursring
  input  logic                oursring_cdc_master_rsp_if_rvalid,
  input  logic                oursring_cdc_master_rsp_if_bvalid,
  input  oursring_resp_if_r_t oursring_cdc_master_rsp_if_r,
  input  oursring_resp_if_b_t oursring_cdc_master_rsp_if_b,
  output logic                oursring_cdc_master_rsp_if_rready,
  output logic                oursring_cdc_master_rsp_if_bready
  );

//`ifndef FPGA
  // MASTER PORT I/O
  logic                       aclk_m;
  logic                       aresetn_m;
  // MP Write Address Channel
  logic                       awvalid_m;
  logic  [`X2X_MP_AW-1:0]     awaddr_m;
  logic  [`X2X_MP_IDW-1:0]    awid_m;
  logic  [`X2X_MP_BLW-1:0]    awlen_m;
  logic  [`X2X_BSW-1:0]       awsize_m;
  logic  [`X2X_BTW-1:0]       awburst_m;
  logic  [`X2X_LTW-1:0]       awlock_m;
  logic  [`X2X_CTW-1:0]       awcache_m;
  logic  [`X2X_PTW-1:0]       awprot_m;
  logic                       awready_m;
  // MP Write Data Channel from Master
  logic                       wvalid_m;
  logic  [`X2X_MP_IDW-1:0]    wid_m;
  logic  [`X2X_MP_DW-1:0]     wdata_m;
  logic  [`X2X_MP_SW-1:0]     wstrb_m;
  logic                       wlast_m;
  logic                       wready_m;
  // MP Write Response Channel from Master
  logic                       bvalid_m;
  logic  [`X2X_MP_IDW-1:0]    bid_m;
  logic  [`X2X_BRW-1:0]       bresp_m;
  logic                       bready_m;
  // MP Read Address Channel from Master
  logic                       arvalid_m;
  logic  [`X2X_MP_IDW-1:0]    arid_m;
  logic  [`X2X_MP_AW-1:0]     araddr_m;
  logic  [`X2X_MP_BLW-1:0]    arlen_m;
  logic  [`X2X_BSW-1:0]       arsize_m;
  logic  [`X2X_BTW-1:0]       arburst_m;
  logic  [`X2X_LTW-1:0]       arlock_m;
  logic  [`X2X_CTW-1:0]       arcache_m;
  logic  [`X2X_PTW-1:0]       arprot_m;
  logic                       arready_m;
  // MP Read Data Channel from Master
  logic                       rvalid_m;
  logic  [`X2X_MP_IDW-1:0]    rid_m;
  logic  [`X2X_MP_DW-1:0]     rdata_m;
  logic                       rlast_m;
  logic  [`X2X_RRW-1:0]       rresp_m;
  logic                       rready_m;
  // SLAVE PORT I/O
  logic                       aclk_s;
  logic                       aresetn_s;
  // Write Address Channel 1
  logic                       awvalid_s1;
  logic  [`X2X_SP_AW-1:0]     awaddr_s1;
  logic  [`X2X_SP_IDW-1:0]    awid_s1;
  logic  [`X2X_SP_BLW-1:0]    awlen_s1;
  logic  [`X2X_BSW-1:0]       awsize_s1;
  logic  [`X2X_BTW-1:0]       awburst_s1;
  logic  [`X2X_LTW-1:0]       awlock_s1;
  logic  [`X2X_CTW-1:0]       awcache_s1;
  logic  [`X2X_PTW-1:0]       awprot_s1;
  logic                       awready_s1;
  // Write Data Channel 1
  logic                       wvalid_s1;
  logic  [`X2X_SP_IDW-1:0]    wid_s1;
  logic  [`X2X_SP_DW-1:0]     wdata_s1;
  logic  [`X2X_SP_SW-1:0]     wstrb_s1;
  logic                       wlast_s1;
  logic                       wready_s1;
  // Write Response Channel 1
  logic                       bvalid_s1;
  logic  [`X2X_SP_IDW-1:0]    bid_s1;
  logic  [`X2X_BRW-1:0]       bresp_s1;
  logic                       bready_s1;
  // Read Address Channel
  logic                       arvalid_s;
  logic  [`X2X_SP_IDW-1:0]    arid_s;
  logic  [`X2X_SP_AW-1:0]     araddr_s;
  logic  [`X2X_SP_BLW-1:0]    arlen_s;
  logic  [`X2X_BSW-1:0]       arsize_s;
  logic  [`X2X_BTW-1:0]       arburst_s;
  logic  [`X2X_LTW-1:0]       arlock_s;
  logic  [`X2X_CTW-1:0]       arcache_s;
  logic  [`X2X_PTW-1:0]       arprot_s;
  logic                       arready_s;
  // Read Data Channel
  logic                       rvalid_s;
  logic  [`X2X_SP_IDW-1:0]    rid_s;
  logic  [`X2X_SP_DW-1:0]     rdata_s;
  logic                       rlast_s;
  logic  [`X2X_RRW-1:0]       rresp_s;
  logic                       rready_s;

  logic slave_clk_buf_out;
  clk_buffer slave_clk_buf_u (.in(slave_clk), .out(slave_clk_buf_out));

  logic master_clk_buf_out;
  clk_buffer master_clk_buf_u (.in(master_clk), .out(master_clk_buf_out));

  oursring_asyc_DW_axi_x2x oursring_cdc_u (.*
    );
 
  assign aclk_m       = slave_clk_buf_out;
  assign aresetn_m    = slave_resetn;
  assign awvalid_m    = oursring_cdc_slave_req_if_awvalid;
  assign awaddr_m     = oursring_cdc_slave_req_if_aw.awaddr;
  assign awid_m       = oursring_cdc_slave_req_if_aw.awid;
  assign awlen_m      = '0;
  assign awsize_m     = 3'h3;
  assign awburst_m    = 2'b0;
  assign awlock_m     = 1'b0;
  assign awcache_m    = '0;
  assign awprot_m     = '0;
  assign oursring_cdc_slave_req_if_awready = awready_m;
  assign wvalid_m     = oursring_cdc_slave_req_if_wvalid;
  // assign wid_m        = oursring_cdc_slave_req_if_w.wid;
  assign wdata_m      = oursring_cdc_slave_req_if_w.wdata;
  assign wstrb_m      = oursring_cdc_slave_req_if_w.wstrb;
  assign wlast_m      = oursring_cdc_slave_req_if_w.wlast;
  assign oursring_cdc_slave_req_if_wready = wready_m;
  assign cdc_oursring_slave_rsp_if_bvalid = bvalid_m;
  assign cdc_oursring_slave_rsp_if_b.bid = bid_m;
  assign cdc_oursring_slave_rsp_if_b.bresp = axi4_resp_t'(bresp_m);
  assign bready_m     = cdc_oursring_slave_rsp_if_bready;
  assign arvalid_m    = oursring_cdc_slave_req_if_arvalid;
  assign arid_m       = oursring_cdc_slave_req_if_ar.arid;
  assign araddr_m     = oursring_cdc_slave_req_if_ar.araddr;
  assign arlen_m      = '0;
  assign arsize_m     = 3'h3;
  assign arburst_m    = 2'h0;
  assign arlock_m     = 1'b0;
  assign arcache_m    = '0;
  assign arprot_m     = '0;
  assign oursring_cdc_slave_req_if_arready = arready_m;
  assign cdc_oursring_slave_rsp_if_rvalid = rvalid_m;
  assign cdc_oursring_slave_rsp_if_r.rid = rid_m;
  assign cdc_oursring_slave_rsp_if_r.rdata = rdata_m;
  assign cdc_oursring_slave_rsp_if_r.rlast = rlast_m;
  assign cdc_oursring_slave_rsp_if_r.rresp = axi4_resp_t'(rresp_m);
  assign rready_m     = cdc_oursring_slave_rsp_if_rready;
  assign aclk_s       = master_clk_buf_out;
  assign aresetn_s    = master_resetn;
  assign cdc_oursring_master_req_if_awvalid = awvalid_s1;
  assign cdc_oursring_master_req_if_aw.awaddr = awaddr_s1;
  assign cdc_oursring_master_req_if_aw.awid = awid_s1;
  assign awready_s1  = cdc_oursring_master_req_if_awready;
  assign cdc_oursring_master_req_if_wvalid = wvalid_s1;
  // assign cdc_oursring_master_req_if_w.wid = wid_s1;
  assign cdc_oursring_master_req_if_w.wdata = wdata_s1;
  assign cdc_oursring_master_req_if_w.wstrb = wstrb_s1;
  assign cdc_oursring_master_req_if_w.wlast = wlast_s1;
  assign wready_s1   = cdc_oursring_master_req_if_wready;
  assign bvalid_s1   = oursring_cdc_master_rsp_if_bvalid;
  assign bid_s1      = oursring_cdc_master_rsp_if_b.bid;
  assign bresp_s1    = oursring_cdc_master_rsp_if_b.bresp;
  assign oursring_cdc_master_rsp_if_bready = bready_s1;
  assign cdc_oursring_master_req_if_arvalid = arvalid_s;
  assign cdc_oursring_master_req_if_ar.arid = arid_s;
  assign cdc_oursring_master_req_if_ar.araddr = araddr_s;
  assign arready_s   = cdc_oursring_master_req_if_arready;
  assign rvalid_s    = oursring_cdc_master_rsp_if_rvalid;
  assign rid_s       = oursring_cdc_master_rsp_if_r.rid;
  assign rdata_s     = oursring_cdc_master_rsp_if_r.rdata;
  assign rlast_s     = oursring_cdc_master_rsp_if_r.rlast;
  assign rresp_s     = oursring_cdc_master_rsp_if_r.rresp;
  assign oursring_cdc_master_rsp_if_rready = rready_s;

//`else
//  assign cdc_oursring_master_req_if_awvalid = oursring_cdc_slave_req_if_awvalid;
//  assign cdc_oursring_master_req_if_wvalid  = oursring_cdc_slave_req_if_wvalid;
//  assign cdc_oursring_master_req_if_arvalid = oursring_cdc_slave_req_if_arvalid;
//  assign cdc_oursring_master_req_if_aw      = oursring_cdc_slave_req_if_aw;
//  assign cdc_oursring_master_req_if_w       = oursring_cdc_slave_req_if_w;
//  assign cdc_oursring_master_req_if_ar      = oursring_cdc_slave_req_if_ar;
//  assign oursring_cdc_slave_req_if_awready  = cdc_oursring_master_req_if_awready;
//  assign oursring_cdc_slave_req_if_wready   = cdc_oursring_master_req_if_wready;
//  assign oursring_cdc_slave_req_if_arready  = cdc_oursring_master_req_if_arready;
//
//  assign cdc_oursring_slave_rsp_if_rvalid   = oursring_cdc_master_rsp_if_rvalid;
//  assign cdc_oursring_slave_rsp_if_bvalid   = oursring_cdc_master_rsp_if_bvalid;
//  assign cdc_oursring_slave_rsp_if_r        = oursring_cdc_master_rsp_if_r;
//  assign cdc_oursring_slave_rsp_if_b        = oursring_cdc_master_rsp_if_b;
//  assign oursring_cdc_master_rsp_if_rready  = cdc_oursring_slave_rsp_if_rready;
//  assign oursring_cdc_master_rsp_if_bready  = cdc_oursring_slave_rsp_if_bready;
//`endif
endmodule

