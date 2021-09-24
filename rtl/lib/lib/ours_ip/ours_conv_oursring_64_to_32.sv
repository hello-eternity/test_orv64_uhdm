module ours_conv_oursring_64_to_32
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  (
    // oursring
    input  logic 				or_req_if_awvalid,
    output logic 				or_req_if_awready,
    input  logic 				or_req_if_wvalid,
    output logic 				or_req_if_wready,
    input  logic 				or_req_if_arvalid,
    output logic 				or_req_if_arready,
    input  oursring_req_if_aw_t or_req_if_aw,
    input  oursring_req_if_w_t  or_req_if_w,
    input  oursring_req_if_ar_t or_req_if_ar,
    output logic 				or_resp_if_rvalid,
    input  logic 				or_resp_if_rready,
    output logic 				or_resp_if_bvalid,
    input  logic 				or_resp_if_bready,
    output oursring_resp_if_r_t or_resp_if_r,
    output oursring_resp_if_b_t or_resp_if_b,

    // IP
    output logic 				awvalid,
    input  logic 				awready,
    output logic 				wvalid,
    input  logic 				wready,
    output logic 				arvalid,
    input  logic 				arready,
    output logic [11:0]         awid,
    output logic [39:0]         awaddr,
    output logic [1:0]          awburst,
    output logic [3:0]          awlen,
    output logic [3:0]          awcache,
    output logic [2:0]          awprot,
    output logic [1:0]          awlock,
    output logic [2:0]          awsize,
    output logic [11:0]         wid,
    output logic [31:0]         wdata,
    output logic [3:0]          wstrb,
    output logic                wlast,
    output logic [11:0]         arid,
    output logic [39:0]         araddr,
    output logic [1:0]          arburst,
    output logic [3:0]          arlen,
    output logic [3:0]          arcache,
    output logic [2:0]          arprot,
    output logic [1:0]          arlock,
    output logic [2:0]          arsize,
    input  logic 				rvalid,
    output logic 				rready,
    input  logic 				bvalid,
    output logic 				bready,
    input  logic [11:0]         rid,
    input  logic [31:0]         rdata,
    input  logic [1:0]          rresp, 
    input  logic                rlast,
    input  logic [11:0]         bid,
    input  logic [1:0]          bresp
  );

  assign awvalid                = or_req_if_awvalid;
  assign or_req_if_awready      = awready;
  assign wvalid                 = or_req_if_wvalid;
  assign or_req_if_wready       = wready;
  assign arvalid                = or_req_if_arvalid;
  assign or_req_if_arready      = arready;
  assign awid                   = or_req_if_aw.awid;
  assign awaddr                 = or_req_if_aw.awaddr;
  assign awburst                = '0;
  assign awlen                  = '0;
  assign awcache                = '0;
  assign awprot                 = '0;
  assign awlock                 = '0;
  assign awsize                 = 3'h2;
  assign wid                    = or_req_if_aw.awid;
  assign wdata                  = (or_req_if_w.wstrb[3:0] == 4'h0) ? or_req_if_w.wdata[63:32] : or_req_if_w.wdata[31:0];
  assign wstrb                  = (or_req_if_w.wstrb[3:0] == 4'h0) ? or_req_if_w.wstrb[7:4] : or_req_if_w.wstrb[3:0];
  assign wlast                  = or_req_if_w.wlast;
  assign arid                   = or_req_if_ar.arid;
  assign araddr                 = or_req_if_ar.araddr;
  assign arburst                = '0;
  assign arlen                  = '0;
  assign arcache                = '0;
  assign arprot                 = '0;
  assign arlock                 = '0;
  assign arsize                 = 3'h2;
  assign or_resp_if_rvalid      = rvalid;
  assign rready                 = or_resp_if_rready;
  assign or_resp_if_bvalid      = bvalid;
  assign bready                 = or_resp_if_bready;
  assign or_resp_if_r.rid       = rid;
  assign or_resp_if_r.rdata     = {rdata, rdata};
  assign or_resp_if_r.rresp     = axi4_resp_t'(rresp);
  assign or_resp_if_r.rlast     = rlast;
  assign or_resp_if_b.bid       = bid;
  assign or_resp_if_b.bresp     = axi4_resp_t'(bresp);

endmodule
