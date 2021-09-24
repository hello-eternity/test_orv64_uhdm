module fpga_jtag2or
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  // AXI i/f
  input  logic                axi2or_awvalid,
  input  logic [39:0]         axi2or_awaddr,
  input  logic [1:0]          axi2or_awburst,
  input  logic [7:0]          axi2or_awlen,
  input  logic [2:0]          axi2or_awsize,
  output logic                axi2or_awready,

  input  logic                axi2or_wvalid,
  input  logic [63:0]         axi2or_wdata,
  input  logic [7:0]          axi2or_wstrb,
  input  logic                axi2or_wlast,
  output logic                axi2or_wready,

  output logic                axi2or_bvalid,
  output logic [1:0]          axi2or_bresp,
  input  logic                axi2or_bready,

  input  logic                axi2or_arvalid,
  input  logic [39:0]         axi2or_araddr,
  input  logic [1:0]          axi2or_arburst,
  input  logic [7:0]          axi2or_arlen,
  input  logic [2:0]          axi2or_arsize,
  output logic                axi2or_arready,

  output logic                axi2or_rvalid,
  output logic [63:0]         axi2or_rdata,
  output logic [1:0]          axi2or_rresp,
  output logic                axi2or_rlast,
  input  logic                axi2or_rready,

  output logic                or_req_awvalid,
  output logic                or_req_wvalid,
  output logic                or_req_arvalid,
  output oursring_req_if_ar_t or_req_ar,
  output oursring_req_if_aw_t or_req_aw,
  output oursring_req_if_w_t  or_req_w,
  input                       or_req_arready,
  input                       or_req_wready,
  input                       or_req_awready,

  input oursring_resp_if_b_t  or_rsp_b,
  input oursring_resp_if_r_t  or_rsp_r,
  input                       or_rsp_rvalid,
  output                      or_rsp_rready,
  input                       or_rsp_bvalid,
  output                      or_rsp_bready,

  input clk,
  input rstn
);

  typedef logic [64-1:0] axi2or_data_t;
  typedef logic [40-1:0] axi2or_addr_t;

  bit[8:0] dff_resp_cnt, next_resp_cnt;
  bit or_wr_req_vld;

  axi2or_addr_t dff_axi2or_awaddr;

  // Directly wire read
  assign or_req_arvalid   = axi2or_arvalid;
  assign or_req_ar.araddr = axi2or_araddr;
  assign or_req_ar.arid   = '0;
  assign axi2or_arready = or_req_arready;
  assign axi2or_rvalid  = or_rsp_rvalid;
  assign axi2or_rdata   = or_rsp_r.rdata;
  assign axi2or_rlast   = or_rsp_r.rlast;
  assign axi2or_rresp   = or_rsp_r.rresp;
  assign or_rsp_rready    = axi2or_rready;

  //****************************************
  always_ff @ (posedge clk) begin
    if (~rstn) begin
      dff_resp_cnt <= '1;
    end else begin
      if (axi2or_awvalid) begin
        dff_axi2or_awaddr <= axi2or_awaddr;
        dff_resp_cnt <= axi2or_awlen + 1;
      end else begin
        dff_resp_cnt <= next_resp_cnt;
      end
    end
  end

  assign axi2or_awready	= 1'b1;
  assign axi2or_wready  = or_req_wready;
  assign axi2or_bresp   = 2'b00;

  always_ff @(posedge clk) begin
    if (~rstn) begin
      axi2or_bvalid <= 1'b0;
    end else if (axi2or_bvalid & axi2or_bready) begin
      axi2or_bvalid <= 1'b0;
    end else if (dff_resp_cnt == 0) begin
      axi2or_bvalid <= 1'b1;
    end
  end


  //****************************************
  // Counter logic
  always_comb begin
    next_resp_cnt = dff_resp_cnt;
    if (or_rsp_bvalid & or_rsp_bready) begin
      next_resp_cnt--;
    end else if (axi2or_bvalid & axi2or_bready) begin // reset counter
      next_resp_cnt = '1;
    end
  end

  //****************************************
  // OR

  always_ff @(posedge clk) begin
    if (~rstn) begin
      or_wr_req_vld <= 1'b0;
    end else if (or_wr_req_vld & or_req_awready & or_req_wready) begin
      or_wr_req_vld <= 1'b0;
    end else if (axi2or_wvalid) begin
      or_wr_req_vld <= 1'b1;
    end
  end

  assign or_req_awvalid = axi2or_wvalid;
  assign or_req_aw.awid = '0;
  assign or_req_aw.awaddr = (axi2or_awvalid)? axi2or_awaddr : dff_axi2or_awaddr;

  assign or_req_wvalid  = axi2or_wvalid;
  assign or_req_w.wdata = axi2or_wdata;
  assign or_req_w.wstrb = axi2or_wstrb;
  assign or_req_w.wlast = '1;

  assign or_rsp_bready = 1'b1;

endmodule
