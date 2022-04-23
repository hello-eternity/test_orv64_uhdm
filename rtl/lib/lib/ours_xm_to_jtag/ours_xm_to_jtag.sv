//===============================================
// Filename     : ours_xm_to_jtag.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2019-12-25 12:22:51
// Description  : 
//                  1) axi master to jtag
//================================================


module ours_xm_to_jtag
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  # (
    parameter BACKEND_DOMAIN                = 0,
    parameter AXI_ID_W                      = 12,
    parameter AXI_ADDR_W                    = 64,
    parameter AXI_BURST_W                   = 4,
    parameter AXI_MISC_W                    = 4,
    parameter AXI_DATA_W                    = 64,
    parameter AXI_WSTRB_W                   = 8,
    parameter XM_RD_REQ_FIFO_DEPTH          = 4,
    parameter JTAG_RD_RESP_FIFO_DEPTH       = 1,
    parameter JTAG_ADDR_W                   = 40
  )
(
  input                                      clk,
  input                                      rstn,
  // AW channel
  input  logic [AXI_ID_W-1:0]                xm_awid,           // AXI Master - Write Request ID
  input  logic [AXI_ADDR_W-1:0]              xm_awaddr,         // AXI Master - Write Request Address
  input  logic [AXI_BURST_W-1:0]             xm_awlen,          // AXI Master - Write Request Length
  input  logic [2:0]                         xm_awsize,         // AXI Master - Write Request Size
  input  logic [1:0]                         xm_awburst,        // AXI Master - Write Request Burst Type
  input  logic [1:0]                         xm_awlock,         // AXI Master - Write Request Lock
  input  logic [3:0]                         xm_awcache,        // AXI Master - Write Request Cache
  input  logic [2:0]                         xm_awprot,         // AXI Master - Write Request Protect
  input  logic                               xm_awvalid,        // AXI Master - Write Request Valid
  input  logic [AXI_MISC_W-1:0]              xm_awmisc_info,    // AXI Master - Write Request Misc Info
  output logic                               xm_awready,        // AXI Master - Write Request Ready
  // W channel
  input  logic [AXI_ID_W-1:0]                xm_wid,            // AXI Master - Write Data ID
  input  logic                               xm_wvalid,         // AXI Master - Write Data Valid
  input  logic                               xm_wlast,          // AXI Master - Write Data Last
  input  logic [AXI_DATA_W-1:0]              xm_wdata,          // AXI Master - Write Data WrData
  input  logic [AXI_WSTRB_W-1:0]             xm_wstrb,          // AXI Master - Write Data Strobe
  output logic                               xm_wready,         // AXI Master - Write Data Ready
  // B channel
  output logic [AXI_ID_W-1:0]                xm_bid,            // AXI Master - Write Response ID
  output logic                               xm_bvalid,         // AXI Master - Write Response Valid
  output logic [1:0]                         xm_bresp,          // AXI Master - Write Response Response
  output logic [AXI_MISC_W-1:0]              xm_bmisc_info,     // AXI Master - Write Response Misc Info
  input  logic                               xm_bready,         // AXI Master - Write Response Ready

  // AR channel
  input  logic [AXI_ID_W-1:0]                xm_arid,           // AXI Master - Read Request ID
  input  logic                               xm_arvalid,        // AXI Master - Read Request Valid
  input  logic [AXI_ADDR_W-1:0]              xm_araddr,         // AXI Master - Read Request Address
  input  logic [AXI_BURST_W-1:0]             xm_arlen,          // AXI Master - Read Request Length
  input  logic [2:0]                         xm_arsize,         // AXI Master - Read Request Size
  input  logic [1:0]                         xm_arburst,        // AXI Master - Read Request Burst Type
  input  logic [1:0]                         xm_arlock,         // AXI Master - Read Request Lock
  input  logic [3:0]                         xm_arcache,        // AXI Master - Read Request Cache
  input  logic [2:0]                         xm_arprot,         // AXI Master - Read Request Protect
  input  logic [AXI_MISC_W-1:0]              xm_armisc_info,    // AXI Master - Read Request Misc Info
  output logic                               xm_arready,        // AXI Master - Read Request Ready
  // R channel
  output logic [AXI_ID_W-1:0]                   xm_rid,            // AXI Master - Read Response ID
  output logic                                  xm_rvalid,         // AXI Master - Read Response Valid
  output logic                                  xm_rlast,          // AXI Master - Read Response Last
  output logic [AXI_DATA_W-1:0]                 xm_rdata,          // AXI Master - Read Response RdData
  output logic [AXI_MISC_W-1:0]                 xm_rmisc_info,     // AXI Master - Read Response Misc Info
  output logic [1:0]                            xm_rresp,          // AXI Master - Read Response Response
  input  logic                                  xm_rready,         // AXI Master - Read Response Ready
  // Low power 
  output logic                                  xm_csysreq,        // AXI Master - Low Power Request
  input  logic                                  xm_csysack,        // AXI Master - Low Power Acknowledge
  input  logic                                  xm_cactive,        // AXI Master - Low Power Active

  //jtag interface
  output logic                                  jtag_trst_n,
//  output logic                                  jtag_tck,//FIXME
  output logic                                  jtag_tms,
  output logic                                  jtag_tdi,
  input  logic                                  jtag_tdo
);

localparam  REQ_SEND_ST_IDLE    = 2'b00 ,
            REQ_SEND_ST_WR      = 2'b01 ,
            REQ_SEND_ST_RD      = 2'b10 ;
localparam  RD_RESP_ST_IDLE     = 2'b00 ,
            RD_RESP_ST_BUSY     = 2'b01 ;
localparam  JTAG_RD_REQ_ID_W = $clog2(XM_RD_REQ_FIFO_DEPTH);

typedef struct packed{
logic                       req_type;//0 - read 1 - write
logic   [AXI_ID_W-1:0]      axid;
logic   [AXI_ADDR_W-1:0]    axaddr;
logic   [AXI_BURST_W-1:0]   axlen;
logic   [2:0]               axsize;
} ax_req_t;

//{{{wires
logic   [1:0]                   rr_arb_grt;
logic                           rr_arb_en;
logic   [1:0]                   xm_req_sel; //[0] - axi read
                                            //[1] - axi write
ax_req_t                        xm_req_buf_slave_info;
logic                           xm_req_buf_slave_valid;
logic                           xm_req_buf_slave_ready;
logic                           xm_req_buf_master_valid;
logic                           xm_req_buf_master_ready;
ax_req_t                        xm_req_buf_master_info;

logic                           xm_bresp_slave_valid;
logic                           xm_bresp_slave_ready;

logic                           xm_ar_req_fifo_slave_valid;
ax_req_t                        xm_ar_req_fifo_slave_info;
logic                           xm_ar_req_fifo_slave_ready;
logic                           xm_ar_req_fifo_master_valid;
ax_req_t                        xm_ar_req_fifo_master_info;
logic                           xm_ar_req_fifo_master_ready;
logic                           jtag_rd_resp_fifo_slave_valid;
logic [AXI_DATA_W-1:0]          jtag_rd_resp_fifo_slave_info;
logic                           jtag_rd_resp_fifo_slave_ready;
logic                           jtag_rd_resp_fifo_master_valid;
logic [AXI_DATA_W-1:0]          jtag_rd_resp_fifo_master_info;
logic                           jtag_rd_resp_fifo_master_ready;

logic  [1:0]                    jtag_req_op;
logic  [JTAG_ADDR_W-1:0]        jtag_req_addr;
logic  [AXI_DATA_W-1:0]         jtag_req_data;

logic                           jtag_rd_resp_valid;
logic                           jtag_rd_resp_rdy;
logic   [AXI_DATA_W-1:0]        jtag_rd_resp_data;

logic                           jtag_req_vld;
logic                           jtag_req_rdy;

//}}}

assign  xm_csysreq                      = '0;

assign  xm_awready                      = xm_req_buf_slave_ready & xm_req_sel[1];
assign  xm_arready                      = xm_req_buf_slave_ready & xm_req_sel[0];
assign  xm_req_sel                      = xm_arvalid & xm_awvalid ? rr_arb_grt : {xm_awvalid,xm_arvalid};
assign  xm_req_buf_slave_info.req_type  = ~xm_req_sel[0];
assign  xm_req_buf_slave_info.axid      = xm_req_sel[0] ? xm_arid   : xm_awid;
assign  xm_req_buf_slave_info.axaddr    = xm_req_sel[0] ? xm_araddr : xm_awaddr;
assign  xm_req_buf_slave_info.axlen     = xm_req_sel[0] ? xm_arlen  : xm_awlen;
assign  xm_req_buf_slave_info.axsize    = xm_req_sel[0] ? xm_arsize : xm_awsize;

assign  xm_req_buf_slave_valid          = |xm_req_sel;
//--------------------------------------------------
//round robin to select the read / write request
//--------------------------------------------------
assign  rr_arb_en   = xm_req_buf_slave_valid & xm_req_buf_slave_ready;

ours_one_hot_rr_arb
#(
    .N_INPUT ( 2 )
)
RR_ARB_U
(
    .en     ( rr_arb_en     ),
    .grt    ( rr_arb_grt    ),
    .rstn   ( rstn          ),
    .clk    ( clk           )
);

ours_vld_rdy_buf 
#(
    .WIDTH( $bits( ax_req_t )   ),
    .DEPTH( 1                   )
)
XM_REQ_BUF_U
(
    .clk            ( clk                       ),
    .rstn           ( rstn                      ),
    .clk_en         ( ),
    .slave_valid    ( xm_req_buf_slave_valid    ),
    .slave_info     ( xm_req_buf_slave_info     ),
    .slave_ready    ( xm_req_buf_slave_ready    ),
    .master_valid   ( xm_req_buf_master_valid   ),
    .master_info    ( xm_req_buf_master_info    ),
    .master_ready   ( xm_req_buf_master_ready   )
);

//----------------------
// bresp auto send
//----------------------
assign  xm_bresp_slave_valid    = xm_req_buf_master_valid & xm_req_buf_master_ready & xm_req_buf_master_info.req_type;
ours_vld_rdy_buf 
#(
    .WIDTH( AXI_ID_W + 2 + AXI_MISC_W   ),
    .DEPTH( 1                           )
)
XM_BRESP_U
(
    .clk            ( clk                               ),
    .rstn           ( rstn                              ),
    .clk_en         ( ),
    .slave_valid    ( xm_bresp_slave_valid              ),
    .slave_info     ( {xm_req_buf_master_info.axid,2'd0,{AXI_MISC_W{1'b0}}} ),
    .slave_ready    ( xm_bresp_slave_ready              ),
    .master_valid   ( xm_bvalid                         ),
    .master_info    ( {xm_bid,xm_bresp,xm_bmisc_info}   ),
    .master_ready   ( xm_bready                         )
);

//---------------------------------
//read request info record
//---------------------------------
assign  xm_ar_req_fifo_slave_valid  = xm_req_buf_master_valid & xm_req_buf_master_ready & ~xm_req_buf_master_info.req_type;
assign  xm_ar_req_fifo_slave_info   = xm_req_buf_master_info;

ours_vld_rdy_buf 
#(
    .WIDTH( $bits( ax_req_t )                       ),
    .DEPTH( XM_RD_REQ_FIFO_DEPTH                    )
)
XM_AR_REQ_FIFO_U
(
    .clk            ( clk                               ),
    .rstn           ( rstn                             ),
    .clk_en         ( ),
    .slave_valid    ( xm_ar_req_fifo_slave_valid        ),
    .slave_info     ( xm_ar_req_fifo_slave_info         ),
    .slave_ready    ( xm_ar_req_fifo_slave_ready        ),
    .master_valid   ( xm_ar_req_fifo_master_valid       ),
    .master_info    ( xm_ar_req_fifo_master_info        ),
    .master_ready   ( xm_ar_req_fifo_master_ready       )
);

//--------------------------------
//jtag return data buffer
//--------------------------------

ours_vld_rdy_buf 
#(
    .WIDTH( AXI_DATA_W              ),
    .DEPTH( JTAG_RD_RESP_FIFO_DEPTH )
)
JTAG_RD_RESP_FIFO_U
(
    .clk            ( clk                                    ),
    .rstn           ( rstn                                   ),
    .clk_en         ( ),
    .slave_valid    ( jtag_rd_resp_fifo_slave_valid          ),
    .slave_info     ( jtag_rd_resp_fifo_slave_info           ),
    .slave_ready    ( jtag_rd_resp_fifo_slave_ready          ),
    .master_valid   ( jtag_rd_resp_fifo_master_valid         ),
    .master_info    ( jtag_rd_resp_fifo_master_info          ),
    .master_ready   ( jtag_rd_resp_fifo_master_ready         )
);

assign  xm_ar_req_fifo_master_ready      = xm_rvalid & xm_rready;
assign  jtag_rd_resp_fifo_master_ready   = xm_rvalid & xm_rready;
//--------------------------------------------------
//xm rdata return
//--------------------------------------------------
assign  xm_rid                              = xm_ar_req_fifo_master_info.axid;
assign  xm_rresp                            = '0;
assign  xm_rmisc_info                       = '0;
assign  xm_rdata                            = jtag_rd_resp_fifo_master_info;
assign  xm_rlast                            = 1'b1;
assign  xm_rvalid                           = xm_ar_req_fifo_master_valid & jtag_rd_resp_fifo_master_valid;

//======================================
//jtag side handling
//======================================

assign  xm_req_buf_master_ready     = jtag_req_vld & jtag_req_rdy;
assign  xm_wready                   = jtag_req_vld & jtag_req_op[0] & jtag_req_rdy;
assign  jtag_req_vld                = xm_req_buf_master_valid & (xm_req_buf_master_info.req_type ? xm_bresp_slave_ready & xm_wvalid : xm_ar_req_fifo_slave_ready);
assign  jtag_req_op                 = {1'b0,xm_req_buf_master_info.req_type};
assign  jtag_req_addr               = xm_req_buf_master_info.axaddr;
assign  jtag_req_data               = xm_wdata ;

assign  jtag_rd_resp_fifo_slave_valid    = jtag_rd_resp_valid;
assign  jtag_rd_resp_ready               = jtag_rd_resp_fifo_slave_ready;
assign  jtag_rd_resp_fifo_slave_info     = jtag_rd_resp_data;


ours_xm_to_jtag_req_proc
#(
    .JTAG_OP_W      ( 2             ),
    .JTAG_ADDR_W    ( JTAG_ADDR_W   ),
    .JTAG_DATA_W    ( AXI_DATA_W    )
)

OURS_XM_TO_JTAG_REQ_PROC_U
    (
        .clk                ( clk               ),
        .rst_n              ( rstn              ),
        .jtag_req_vld       ( jtag_req_vld      ),
        .jtag_req_rdy       ( jtag_req_rdy      ),
        .jtag_req_op        ( jtag_req_op       ),
        .jtag_req_addr      ( jtag_req_addr     ),
        .jtag_req_data      ( jtag_req_data     ),
        .jtag_rd_resp_vld   ( jtag_rd_resp_valid),
        .jtag_rd_resp_rdy   ( jtag_rd_resp_ready),
        .jtag_rd_resp_data  ( jtag_rd_resp_data ),
        .jtag_trst_n        ( jtag_trst_n       ),
//        .jtag_tck           ( jtag_tck          ),
        .jtag_tms           ( jtag_tms          ),
        .jtag_tdi           ( jtag_tdi          ),
        .jtag_tdo           ( jtag_tdo          )
    );


endmodule

