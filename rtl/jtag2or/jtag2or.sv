
module jtag2or
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  // Oursring Master
  input  oursring_resp_if_b_t or_rsp_if_b,
  input  oursring_resp_if_r_t or_rsp_if_r,
  input  logic                or_rsp_if_rvalid,
  output logic                or_rsp_if_rready,
  input  logic                or_rsp_if_bvalid,
  output logic                or_rsp_if_bready,
  output logic                or_req_if_awvalid,
  output logic                or_req_if_wvalid,
  output logic                or_req_if_arvalid,
  output oursring_req_if_ar_t or_req_if_ar,
  output oursring_req_if_aw_t or_req_if_aw,
  output oursring_req_if_w_t  or_req_if_w,
  input  logic                or_req_if_arready,
  input  logic                or_req_if_wready,
  input  logic                or_req_if_awready,

  input  logic                clk,
  input  logic                rstn,

  // IO Ports
  input  logic [127:0]        cmdbuf_in,
  input  logic                cmd_vld_in,
  output logic [63:0]         rdata_out,
  output logic                rdata_vld_out
  );

  // TODO
  localparam int                  N_CNT_BITS   = 7;
  localparam bit [N_CNT_BITS-1:0] N_CMD_BITS   = 2;
  localparam bit [N_CNT_BITS-1:0] N_ADDR_BITS  = 40;
  localparam bit [N_CNT_BITS-1:0] N_DATA_BITS  = 64;
  localparam bit [N_CNT_BITS-1:0] N_CMDBUF_BITS = N_CMD_BITS + N_ADDR_BITS + N_DATA_BITS;

  localparam bit [N_CMD_BITS-1:0] CMD_RD       = 0;
  localparam bit [N_CMD_BITS-1:0] CMD_WR       = 1;

  enum logic [2:0] {
    IDLE,
    CMD,
    RREQ,
    RRSP,
    WREQ,
    WAIT_AWREADY,
    WAIT_WREADY,
    WRSP
  } rff_st, next_st;

  logic [N_CMD_BITS-1:0]    cmd;
  logic [N_ADDR_BITS-1:0]   addr;
  logic [N_DATA_BITS-1:0]   wdata;

  generate
    for (genvar i = 0; i < N_CMD_BITS; i++) begin : CMD_REORDER_GEN
      assign cmd[i] = cmdbuf_in[i];
    end
    for (genvar i = 0; i < N_ADDR_BITS; i++) begin : ADDR_REORDER_GEN
      assign addr[i] = cmdbuf_in[N_CMD_BITS + i];
    end
    for (genvar i = 0; i < N_DATA_BITS; i++) begin : WDATA_REORDER_GEN
      assign wdata[i] = cmdbuf_in[N_CMD_BITS + N_ADDR_BITS + i];
    end
  endgenerate

  logic dff_cmd_vld_in;
  always_ff @(posedge clk) begin
    dff_cmd_vld_in <= cmd_vld_in;
  end

  logic [N_DATA_BITS-1:0]   dff_rdata;
  always_ff @(posedge clk) begin
    if (or_rsp_if_rvalid & or_rsp_if_rready) begin
      dff_rdata <= or_rsp_if_r.rdata;
    end
  end
  assign rdata_out = dff_rdata;

  logic                     rff_rdata_vld;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_rdata_vld <= 1'b0;
    end else if (or_rsp_if_rvalid & or_rsp_if_rready) begin
      rff_rdata_vld <= 1'b1;
    end else if (or_rsp_if_bvalid & or_rsp_if_bready) begin
      rff_rdata_vld <= 1'b1;
    end else if (cmd_vld_in == 1'b1) begin
      rff_rdata_vld <= 1'b0;
    end
  end

  assign rdata_vld_out = rff_rdata_vld;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_st <= IDLE;
    end else begin
      rff_st <= next_st;
    end
  end

  always_comb begin
    next_st = rff_st;
    case (rff_st)
      IDLE: begin
        if ((cmd_vld_in == 1'b0) && (dff_cmd_vld_in == 1'b1)) begin
          next_st = CMD;
        end
      end
      CMD: begin
        case (cmd)
          CMD_RD: begin
            next_st = RREQ;
          end
          CMD_WR: begin
            next_st = WREQ;
          end
          default: begin
            next_st = IDLE; // Add bad cmd state
          end
        endcase
      end
      RREQ: begin
        if (or_req_if_arready) begin
          next_st = RRSP;
        end
      end
      RRSP: begin
        if (or_rsp_if_rvalid) begin
          next_st = IDLE;
        end
      end
      WREQ: begin
        case ({or_req_if_awready, or_req_if_wready})
          2'b11: begin
            next_st = WRSP;
          end
          2'b10: begin
            next_st = WAIT_WREADY;
          end
          2'b01: begin
            next_st = WAIT_AWREADY;
          end
          default: begin
            next_st = WREQ;
          end
        endcase
      end
      WAIT_AWREADY: begin
        if (or_req_if_awready) begin
          next_st = WRSP;
        end
      end
      WAIT_WREADY: begin
        if (or_req_if_wready) begin
          next_st = WRSP;
        end
      end
      WRSP: begin
        if (or_rsp_if_bvalid) begin
          next_st = IDLE;
        end
      end
    endcase
  end

  assign or_rsp_if_rready    = (rff_st == RRSP);
  assign or_rsp_if_bready    = (rff_st == WRSP);
  assign or_req_if_awvalid   = (rff_st == WREQ) | (rff_st == WAIT_AWREADY);
  assign or_req_if_wvalid    = (rff_st == WREQ) | (rff_st == WAIT_WREADY);
  assign or_req_if_arvalid   = (rff_st == RREQ);
  assign or_req_if_ar.araddr = addr;
  assign or_req_if_ar.arid   = {$bits(ring_tid_t){1'b0}};
  assign or_req_if_aw.awaddr = addr;
  assign or_req_if_aw.awid   = {$bits(ring_tid_t){1'b1}};
  assign or_req_if_w.wdata   = wdata;
  assign or_req_if_w.wlast   = 1'b1;
  assign or_req_if_w.wstrb   = 8'hff;

 endmodule 

  
