
`timescale 1 ns / 1 ps

module reset_block (
  output logic rstblk_out,
  input  logic S_AXI_ACLK,
  input  logic S_AXI_ARESETN,
  // AXI
  input [39:0]S_AXI_ARADDR,
  input [1:0]S_AXI_ARBURST,
  input [3:0]S_AXI_ARCACHE,
  input [15:0]S_AXI_ARID,
  input [7:0]S_AXI_ARLEN,
  input [0:0]S_AXI_ARLOCK,
  input [2:0]S_AXI_ARPROT,
  input [3:0]S_AXI_ARQOS,
  output S_AXI_ARREADY,
  input [3:0]S_AXI_ARREGION,
  input [2:0]S_AXI_ARSIZE,
  input [15:0]S_AXI_ARUSER,
  input S_AXI_ARVALID,
  input [39:0]S_AXI_AWADDR,
  input [1:0]S_AXI_AWBURST,
  input [3:0]S_AXI_AWCACHE,
  input [15:0]S_AXI_AWID,
  input [7:0]S_AXI_AWLEN,
  input [0:0]S_AXI_AWLOCK,
  input [2:0]S_AXI_AWPROT,
  input [3:0]S_AXI_AWQOS,
  output S_AXI_AWREADY,
  input [3:0]S_AXI_AWREGION,
  input [2:0]S_AXI_AWSIZE,
  input [15:0]S_AXI_AWUSER,
  input S_AXI_AWVALID,
  output [15:0]S_AXI_BID,
  input S_AXI_BREADY,
  output [1:0]S_AXI_BRESP,
  output S_AXI_BVALID,
  output [63:0]S_AXI_RDATA,
  output [15:0]S_AXI_RID,
  output S_AXI_RLAST,
  input S_AXI_RREADY,
  output [1:0]S_AXI_RRESP,
  output S_AXI_RVALID,
  input [63:0]S_AXI_WDATA,
  input [15 : 0] S_AXI_WUSER,
  output [15 : 0] S_AXI_RUSER,
  input S_AXI_WLAST,
  output S_AXI_WREADY,
  input [7:0]S_AXI_WSTRB,
  input S_AXI_WVALID,
  output [15 : 0] S_AXI_BUSER
  );


  wire clk;
  wire rst;

  assign clk =  S_AXI_ACLK;
  assign rst = ~S_AXI_ARESETN;

  typedef enum logic [2:0] {IDLE, WR, RD, WACK, RACK, WRSP, RRSP} state_e;

  struct {state_e state; logic rstblk_out;} v, r;

  always_ff @(posedge clk) begin
    if (rst) begin
      r <= '{default: '0};
    end else begin
      r <= v;
    end
  end

  always_comb begin
    v = r;
    case(r.state)
      IDLE: begin
        if (S_AXI_AWVALID & S_AXI_WVALID) begin
          v.rstblk_out = S_AXI_WDATA[0];
          v.state = WACK;
        end else if (S_AXI_ARVALID) begin
          v.state = RACK;
        end
      end
      WACK: begin
        v.state = WRSP;
      end
      RACK: begin
        v.state = RRSP;
      end
      WRSP: begin
        if (S_AXI_BREADY) begin
          v.state = IDLE;
        end
      end
      RRSP: begin
        if (S_AXI_RREADY) begin
          v.state = IDLE;
        end
      end
    endcase
  end

  logic [15:0] bid_ff;
  logic [15:0] rid_ff;
  always_ff @(posedge clk) begin
    if (rst) begin
      rid_ff <= '0;
    end else if (S_AXI_ARVALID) begin
      rid_ff <= S_AXI_ARID;
    end
  end
  always_ff @(posedge clk) begin
    if (rst) begin
      bid_ff <= '0;
    end else if (S_AXI_AWVALID) begin
      bid_ff <= S_AXI_AWID;
    end
  end

  assign S_AXI_ARREADY = (r.state == RACK);
  assign S_AXI_AWREADY = (r.state == WACK);
  assign S_AXI_WREADY = (r.state == WACK);

  assign S_AXI_BVALID = (r.state == WRSP);
  assign S_AXI_BRESP = '0;
  assign S_AXI_BID = bid_ff;

  assign S_AXI_RVALID = (r.state == RRSP);
  assign S_AXI_RDATA = {63'b0, r.rstblk_out};
  assign S_AXI_RLAST = '1;
  assign S_AXI_RRESP = '0;
  assign S_AXI_RID = rid_ff;
  
  assign S_AXI_BUSER	= '0;
  assign S_AXI_RUSER	= '0;
  assign rstblk_out = r.rstblk_out;
endmodule
