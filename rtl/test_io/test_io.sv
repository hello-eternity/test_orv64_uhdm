
module test_io
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
  input  logic                pllclk,
  input  logic                rstn,
  input  logic                test_rstn,

  // IO Ports
  output logic                clk_div,
  output logic                clk_oen,
  input  logic [9:0]          clk_div_half, // TODO
  input  logic                test_clk,
  input  logic                test_ein,
  output logic                test_eout,
  output logic                test_eoen,
  input  logic                test_din,
  output logic                test_dout,
  output logic                test_doen
  );

  assign clk_oen = 1'b0;
  clk_div_cfg #(.MAX_DIV(2**10), .WITH_CLK_MUX(0)) test_io_clk_div_u (
    .refclk         (pllclk),
    .half_div_less_1(clk_div_half),
    .dft_en         (1'b0),
    .divclk_sel     (1'b1),
    .divclk         (clk_div)
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
    CDC_IDLE,
    CDC_CMD,
    CDC_RREQ,
    CDC_RRSP,
    CDC_WREQ,
    CDC_WAIT_AWREADY,
    CDC_WAIT_WREADY,
    CDC_WRSP
  } rff_cdcst, next_cdcst;

  // CDC
  oursring_resp_if_b_t c2s_rsp_if_b;
  oursring_resp_if_r_t c2s_rsp_if_r;
  logic                c2s_rsp_if_rvalid;
  logic                c2s_rsp_if_rready;
  logic                c2s_rsp_if_bvalid;
  logic                c2s_rsp_if_bready;
  logic                s2c_req_if_awvalid;
  logic                s2c_req_if_wvalid;
  logic                s2c_req_if_arvalid;
  oursring_req_if_ar_t s2c_req_if_ar;
  oursring_req_if_aw_t s2c_req_if_aw;
  oursring_req_if_w_t  s2c_req_if_w;
  logic                s2c_req_if_arready;
  logic                s2c_req_if_wready;
  logic                s2c_req_if_awready;

  oursring_resp_if_b_t s2c_rsp_if_b;
  oursring_resp_if_r_t s2c_rsp_if_r;
  logic                s2c_rsp_if_rvalid;
  logic                s2c_rsp_if_rready;
  logic                s2c_rsp_if_bvalid;
  logic                s2c_rsp_if_bready;
  logic                c2s_req_if_awvalid;
  logic                c2s_req_if_wvalid;
  logic                c2s_req_if_arvalid;
  oursring_req_if_ar_t c2s_req_if_ar;
  oursring_req_if_aw_t c2s_req_if_aw;
  oursring_req_if_w_t  c2s_req_if_w;
  logic                c2s_req_if_arready;
  logic                c2s_req_if_wready;
  logic                c2s_req_if_awready;

  logic dff_test_ein;
  always_ff @(posedge test_clk) begin
    dff_test_ein <= (test_ein & test_eoen);
  end

  logic [N_CNT_BITS-1:0] rff_cmd_idx;
  always_ff @(posedge test_clk) begin
    if (test_rstn) begin
      rff_cmd_idx <= {N_CNT_BITS{1'b0}};
    end if (test_ein & test_eoen) begin
      rff_cmd_idx <= rff_cmd_idx + 1'b1;
    end else begin
      rff_cmd_idx <= {N_CNT_BITS{1'b0}};
    end
  end

  logic [N_CMDBUF_BITS-1:0] dff_cmdbuf;
  always_ff @(posedge test_clk) begin
    if (test_ein & test_eoen) begin
      dff_cmdbuf[rff_cmd_idx] <= test_din;
    end
  end

  logic [N_CMD_BITS-1:0]    cmd;
  logic [N_ADDR_BITS-1:0]   addr;
  logic [N_DATA_BITS-1:0]   wdata;

  generate
    for (genvar i = 0; i < N_CMD_BITS; i++) begin : CMD_REORDER_GEN
      assign cmd[i] = dff_cmdbuf[N_CMD_BITS - 1 - i];
    end
    for (genvar i = 0; i < N_ADDR_BITS; i++) begin : ADDR_REORDER_GEN
      assign addr[i] = dff_cmdbuf[N_CMD_BITS + N_ADDR_BITS - 1 - i];
    end
    for (genvar i = 0; i < N_DATA_BITS; i++) begin : WDATA_REORDER_GEN
      assign wdata[i] = dff_cmdbuf[N_CMD_BITS + N_ADDR_BITS + N_DATA_BITS - 1 - i];
    end
  endgenerate

  logic [N_DATA_BITS-1:0]   dff_rdata;
  always_ff @(posedge test_clk) begin
    if (c2s_rsp_if_rvalid & c2s_rsp_if_rready) begin
      dff_rdata <= c2s_rsp_if_r.rdata;
    end
  end

  logic                     rff_rdata_in_progress;
  logic [N_CNT_BITS-1:0]    rff_rdata_idx;
  always_ff @(posedge test_clk) begin
    if (test_rstn == 1'b0) begin
      rff_rdata_idx <= {N_CNT_BITS{1'b0}};
    end else if (c2s_rsp_if_rvalid & c2s_rsp_if_rready) begin
      rff_rdata_idx <= {N_CNT_BITS{1'b0}};
    end else if (rff_rdata_in_progress) begin
      rff_rdata_idx <= rff_rdata_idx + 1'b1;
    end
  end

  always_ff @(posedge test_clk) begin
    if (test_rstn == 1'b0) begin
      rff_rdata_in_progress <= 1'b0;
    end else if (c2s_rsp_if_rvalid & c2s_rsp_if_rready) begin
      rff_rdata_in_progress <= 1'b1;
    end else if (rff_rdata_idx == N_DATA_BITS-1) begin
      rff_rdata_in_progress <= 1'b0;
    end
  end

  always_ff @(posedge test_clk) begin
    if (test_rstn == 1'b0) begin
      rff_cdcst <= CDC_IDLE;
    end else begin
      rff_cdcst <= next_cdcst;
    end
  end

  always_comb begin
    next_cdcst = rff_cdcst;
    case (rff_cdcst)
      CDC_IDLE: begin
        if ((dff_test_ein == 1'b1) && (test_ein == 1'b0)) begin
          next_cdcst = CDC_CMD;
        end
      end
      CDC_CMD: begin
        case (cmd)
          CMD_RD: begin
            next_cdcst = CDC_RREQ;
          end
          CMD_WR: begin
            next_cdcst = CDC_WREQ;
          end
          default: begin
            next_cdcst = CDC_IDLE;
          end
        endcase
      end
      CDC_RREQ: begin
        if (s2c_req_if_arready) begin
          next_cdcst = CDC_RRSP;
        end
      end
      CDC_RRSP: begin
        if (c2s_rsp_if_rvalid) begin
          next_cdcst = CDC_IDLE;
        end
      end
      CDC_WREQ: begin
        case ({s2c_req_if_awready, s2c_req_if_wready})
          2'b11: begin
            next_cdcst = CDC_WRSP;
          end
          2'b10: begin
            next_cdcst = CDC_WAIT_WREADY;
          end
          2'b01: begin
            next_cdcst = CDC_WAIT_AWREADY;
          end
          default: begin
            next_cdcst = CDC_WREQ;
          end
        endcase
      end
      CDC_WAIT_AWREADY: begin
        if (s2c_req_if_awready) begin
          next_cdcst = CDC_WRSP;
        end
      end
      CDC_WAIT_WREADY: begin
        if (s2c_req_if_wready) begin
          next_cdcst = CDC_WRSP;
        end
      end
      CDC_WRSP: begin
        if (c2s_rsp_if_bvalid) begin
          next_cdcst = CDC_IDLE;
        end
      end
    endcase
  end

  always_comb begin
    test_eoen = 1'b1;
    test_eout = 1'b0;
    test_doen = 1'b1;
    test_dout = 1'b0;
    if ((rff_cdcst == CDC_WRSP) && (c2s_rsp_if_bvalid == 1'b1)) begin
      test_eoen = 1'b0;
      test_eout = 1'b1;
      test_doen = 1'b0;
      test_dout = 1'b1;
    end else if (rff_rdata_in_progress == 1'b1) begin
      test_eoen = 1'b0;
      test_eout = 1'b1;
      test_doen = 1'b0;
      test_dout = dff_rdata[N_DATA_BITS - 1 - rff_rdata_idx];
    end
  end

  assign c2s_rsp_if_rready    = (rff_cdcst == CDC_RRSP);
  assign c2s_rsp_if_bready    = (rff_cdcst == CDC_WRSP);
  assign s2c_req_if_awvalid   = (rff_cdcst == CDC_WREQ) | (rff_cdcst == CDC_WAIT_AWREADY);
  assign s2c_req_if_wvalid    = (rff_cdcst == CDC_WREQ) | (rff_cdcst == CDC_WAIT_WREADY);
  assign s2c_req_if_arvalid   = (rff_cdcst == CDC_RREQ);
  assign s2c_req_if_ar.araddr = addr;
  assign s2c_req_if_ar.arid   = {$bits(ring_tid_t){1'b0}};
  assign s2c_req_if_aw.awaddr = addr;
  assign s2c_req_if_aw.awid   = {$bits(ring_tid_t){1'b1}};
  assign s2c_req_if_w.wdata   = wdata;
  assign s2c_req_if_w.wlast   = 1'b1;
  assign s2c_req_if_w.wstrb   = 8'hff;

  oursring_cdc test_io_to_oursring_cdc 
  (
  .slave_clk(test_clk),
  .master_clk(pllclk),
  .slave_resetn(test_rstn),
  .master_resetn(rstn),

  .oursring_cdc_slave_req_if_awvalid(s2c_req_if_awvalid),
  .oursring_cdc_slave_req_if_wvalid(s2c_req_if_wvalid),
  .oursring_cdc_slave_req_if_arvalid(s2c_req_if_arvalid),
  .oursring_cdc_slave_req_if_ar(s2c_req_if_ar),
  .oursring_cdc_slave_req_if_aw(s2c_req_if_aw),
  .oursring_cdc_slave_req_if_w(s2c_req_if_w),
  .oursring_cdc_slave_req_if_arready(s2c_req_if_arready),
  .oursring_cdc_slave_req_if_wready(s2c_req_if_wready),
  .oursring_cdc_slave_req_if_awready(s2c_req_if_awready),
  .cdc_oursring_slave_rsp_if_rvalid(c2s_rsp_if_rvalid),
  .cdc_oursring_slave_rsp_if_bvalid(c2s_rsp_if_bvalid),
  .cdc_oursring_slave_rsp_if_r(c2s_rsp_if_r),
  .cdc_oursring_slave_rsp_if_b(c2s_rsp_if_b),
  .cdc_oursring_slave_rsp_if_rready(c2s_rsp_if_rready),
  .cdc_oursring_slave_rsp_if_bready(c2s_rsp_if_bready),

  .cdc_oursring_master_req_if_awvalid(or_req_if_awvalid),
  .cdc_oursring_master_req_if_wvalid(or_req_if_wvalid),
  .cdc_oursring_master_req_if_arvalid(or_req_if_arvalid),
  .cdc_oursring_master_req_if_ar(or_req_if_ar),
  .cdc_oursring_master_req_if_aw(or_req_if_aw),
  .cdc_oursring_master_req_if_w(or_req_if_w),
  .cdc_oursring_master_req_if_arready(or_req_if_arready),
  .cdc_oursring_master_req_if_wready(or_req_if_wready),
  .cdc_oursring_master_req_if_awready(or_req_if_awready),
  .oursring_cdc_master_rsp_if_rvalid(or_rsp_if_rvalid),
  .oursring_cdc_master_rsp_if_bvalid(or_rsp_if_bvalid),
  .oursring_cdc_master_rsp_if_r(or_rsp_if_r),
  .oursring_cdc_master_rsp_if_b(or_rsp_if_b),
  .oursring_cdc_master_rsp_if_rready(or_rsp_if_rready),
  .oursring_cdc_master_rsp_if_bready(or_rsp_if_bready)
);

 endmodule 

  
