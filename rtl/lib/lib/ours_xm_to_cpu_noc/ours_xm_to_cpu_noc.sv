//===============================================
// Filename     : ours_xm_to_cpu_noc.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2019-12-25 12:22:51
// Description  : 
//                  1) axi master to cpu noc req
//                  2) 1st version will always think awsize / arsize is 3,means 8B 
//================================================

module ours_xm_to_cpu_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  # (
    parameter BACKEND_DOMAIN                = 0,
    parameter AXI_ID_W                      = 4,
    parameter AXI_ADDR_W                    = 64,
    parameter AXI_BURST_W                   = 4,
    parameter AXI_MISC_W                    = 4,
    parameter AXI_DATA_W                    = 64,
    parameter AXI_WSTRB_W                   = 8,
    parameter XM_RD_REQ_FIFO_DEPTH          = 4,
    parameter CPU_NOC_RD_RESP_FIFO_DEPTH    = 1
  )
(
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
  // cpu noc request
  output logic                         cpu_noc_req_valid,
  input  logic                         cpu_noc_req_ready,
  output cpu_cache_if_req_t            cpu_noc_req,
  // cpu noc response
  input  logic                         cpu_noc_resp_valid,
  output logic                         cpu_noc_resp_ready,
  input  cpu_cache_if_resp_t           cpu_noc_resp, 
  input  clk,
  input  rstn
);

localparam  REQ_SEND_ST_IDLE    = 2'b00 ,
            REQ_SEND_ST_WR      = 2'b01 ,
            REQ_SEND_ST_RD      = 2'b10 ;
localparam  RD_RESP_ST_IDLE     = 2'b00 ,
            RD_RESP_ST_BUSY     = 2'b01 ;
localparam  CPU_NOC_RD_REQ_ID_W = $clog2(XM_RD_REQ_FIFO_DEPTH);

typedef struct packed{
logic                       req_type;//0 - read 1 - write
logic   [AXI_ID_W-1:0]      axid;
logic   [AXI_ADDR_W-1:0]    axaddr;
logic   [AXI_BURST_W-1:0]   axlen;
logic   [2:0]               axsize;
} ax_req_t;

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

logic   [1:0]                   rff_req_send_st;
logic   [1:0]                   rff_req_send_st_nxt;
logic   [4-1:0]                 rff_req_cnt;//to record the current request count number
logic   [4-1:0]                 rff_req_cnt_nxt;

logic                           xm_bresp_slave_valid;
logic                           xm_bresp_slave_ready;

logic   [PHY_ADDR_WIDTH-1:0]    xm_req_buf_araddr_end;
logic                           xm_req_buf_last_rd_req;
logic                           xm_ar_req_fifo_slave_valid;
ax_req_t                        xm_ar_req_fifo_slave_info;
logic                           xm_ar_req_fifo_slave_ready;
logic                           xm_ar_req_fifo_master_valid;
ax_req_t                        xm_ar_req_fifo_master_info;
logic                           xm_ar_req_fifo_master_ready;
logic                           cpu_noc_rd_resp_fifo_slave_valid;
logic [CPU_DATA_WIDTH-1:0]      cpu_noc_rd_resp_fifo_slave_info;
logic                           cpu_noc_rd_resp_fifo_slave_ready;
logic                           cpu_noc_rd_resp_fifo_master_valid;
logic [CPU_DATA_WIDTH-1:0]      cpu_noc_rd_resp_fifo_master_info;
logic                           cpu_noc_rd_resp_fifo_master_ready;

logic   [1:0]                   rff_rd_resp_st;
logic   [1:0]                   rff_rd_resp_st_nxt;
logic   [4-1:0]                 rff_rd_resp_cnt;
logic   [4-1:0]                 rff_rd_resp_cnt_nxt;

logic   [CACHE_OFFSET_WIDTH-1:0]    cur_rd_resp_addr_offset;

logic   [PHY_ADDR_WIDTH-1:0]        cpu_noc_wr_req_paddr;
logic   [PHY_ADDR_WIDTH-1:0]        cpu_noc_rd_req_paddr;
logic   [CACHE_LINE_BYTE-1:0]       cpu_noc_wr_req_mask;
logic   [CACHE_LINE_BYTE-1:0]       cpu_noc_rd_req_mask;
logic   [CPU_NOC_RD_REQ_ID_W-1:0]   rff_cpu_noc_rd_req_id;
assign  xm_csysreq                      = '0;

assign  xm_awready                      = xm_req_buf_slave_ready & xm_req_sel[1];
assign  xm_arready                      = xm_req_buf_slave_ready & xm_req_sel[0];
assign  xm_req_sel                      = xm_arvalid & xm_awvalid ? rr_arb_grt : {xm_awvalid,xm_arvalid};
assign  xm_req_buf_slave_info.req_type  = ~xm_req_sel[0];
assign  xm_req_buf_slave_info.axid      = xm_req_sel[0] ? xm_arid   : xm_awid;
assign  xm_req_buf_slave_info.axaddr    = xm_req_sel[0] ? xm_araddr : xm_awaddr;
assign  xm_req_buf_slave_info.axlen     = xm_req_sel[0] ? xm_arlen  : xm_awlen;
assign  xm_req_buf_slave_info.axsize    = xm_req_sel[0] ? xm_arsize : xm_awsize;

assign  xm_req_buf_slave_valid  = |xm_req_sel;
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
    .rstn   ( rstn         ),
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
    .rstn           ( rstn                     ),
    .clk_en         ( ),
    .slave_valid    ( xm_req_buf_slave_valid    ),
    .slave_info     ( xm_req_buf_slave_info     ),
    .slave_ready    ( xm_req_buf_slave_ready    ),
    .master_valid   ( xm_req_buf_master_valid   ),
    .master_info    ( xm_req_buf_master_info    ),
    .master_ready   ( xm_req_buf_master_ready   )
);


always_ff @(posedge clk )begin
    if(~rstn)begin
        rff_cpu_noc_rd_req_id   <= '0;
    end
    else if(xm_ar_req_fifo_slave_valid & xm_ar_req_fifo_slave_ready)begin
        rff_cpu_noc_rd_req_id   <= rff_cpu_noc_rd_req_id + 1'b1;
    end
end
//-----------------------------------------
// request send FSM for read / write
//-----------------------------------------
always_ff @(posedge clk)begin
    if(~rstn)begin
        rff_req_send_st <= REQ_SEND_ST_IDLE;
        rff_req_cnt     <= 4'd0;
    end
    else begin
        rff_req_send_st <= rff_req_send_st_nxt;
        rff_req_cnt     <= rff_req_cnt_nxt;
    end
end

assign  cpu_noc_req.req_data    = {CPU_DATA_WIDTH{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd0}} & {{CPU_DATA_WIDTH-AXI_DATA_W{1'b0}},xm_wdata} |
                                  {CPU_DATA_WIDTH{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd1}} & {{CPU_DATA_WIDTH-2*AXI_DATA_W{1'b0}},xm_wdata,{AXI_DATA_W{1'b0}}} |
                                  {CPU_DATA_WIDTH{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd2}} & {{CPU_DATA_WIDTH-3*AXI_DATA_W{1'b0}},xm_wdata,{2*AXI_DATA_W{1'b0}}} |
                                  {CPU_DATA_WIDTH{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd3}} & {xm_wdata,{3*AXI_DATA_W{1'b0}}} ;
assign  cpu_noc_wr_req_mask     = {CACHE_LINE_BYTE{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd0}} & {{CACHE_LINE_BYTE-AXI_WSTRB_W{1'b0}},xm_wstrb} |
                                  {CACHE_LINE_BYTE{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd1}} & {{CACHE_LINE_BYTE-2*AXI_WSTRB_W{1'b0}},xm_wstrb,{AXI_WSTRB_W{1'b0}}} |
                                  {CACHE_LINE_BYTE{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd2}} & {{CACHE_LINE_BYTE-3*AXI_WSTRB_W{1'b0}},xm_wstrb,{2*AXI_WSTRB_W{1'b0}}} |
                                  {CACHE_LINE_BYTE{cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd3}} & {xm_wstrb,{3*AXI_WSTRB_W{1'b0}}};
assign  cpu_noc_rd_req_mask     = {CACHE_LINE_BYTE{1'b1}};
assign  cpu_noc_req.req_mask    = xm_req_buf_master_info.req_type ? cpu_noc_wr_req_mask : cpu_noc_rd_req_mask;
assign  cpu_noc_wr_req_paddr    = (xm_req_buf_master_info.axaddr + {{PHY_ADDR_WIDTH-7{1'b0}},rff_req_cnt,3'd0});
assign  cpu_noc_rd_req_paddr    = ({xm_req_buf_master_info.axaddr[CACHE_OFFSET_WIDTH+:PHY_ADDR_WIDTH-CACHE_OFFSET_WIDTH],{CACHE_OFFSET_WIDTH{1'b0}}} + {{PHY_ADDR_WIDTH-4-CACHE_OFFSET_WIDTH{1'b0}},rff_req_cnt,{CACHE_OFFSET_WIDTH{1'b0}}});
assign  cpu_noc_req.req_paddr   = xm_req_buf_master_info.req_type ? cpu_noc_wr_req_paddr : cpu_noc_rd_req_paddr;
assign  cpu_noc_req.req_tid     = xm_req_buf_master_info.req_type ? {{$bits(cpu_tid_t)-2*AXI_ID_W{1'b0}},xm_req_buf_master_info.axid,xm_wid}           :
                                                                    {{$bits(cpu_tid_t)-CPU_NOC_RD_REQ_ID_W-4{1'b0}},rff_cpu_noc_rd_req_id,rff_req_cnt} ;
assign  xm_req_buf_araddr_end   = xm_req_buf_master_info.axaddr + {xm_req_buf_master_info.axlen,3'b111};
assign  xm_req_buf_last_rd_req  = (cpu_noc_req.req_paddr[CACHE_OFFSET_WIDTH+:PHY_ADDR_WIDTH-CACHE_OFFSET_WIDTH] == 
                                  xm_req_buf_araddr_end[CACHE_OFFSET_WIDTH+:PHY_ADDR_WIDTH-CACHE_OFFSET_WIDTH]);

                                                                
always_comb begin
    cpu_noc_req_valid                   = 1'b0;
    cpu_noc_req.req_type                = REQ_READ;
    rff_req_send_st_nxt                 = rff_req_send_st;
    rff_req_cnt_nxt                     = rff_req_cnt;
    xm_req_buf_master_ready             = 1'b0;
    xm_wready                           = 1'b0;
    case(rff_req_send_st)
        REQ_SEND_ST_IDLE : begin
            if(xm_req_buf_master_valid & xm_req_buf_master_info.req_type & xm_wvalid & ( ~xm_wlast | xm_bresp_slave_ready))begin//axi write request
                cpu_noc_req_valid       = 1'b1;
                cpu_noc_req.req_type    = REQ_WRITE;
                xm_req_buf_master_ready = cpu_noc_req_ready & xm_wlast;
                xm_wready               = cpu_noc_req_ready;
                if( cpu_noc_req_ready & ~xm_wlast )begin
                    rff_req_send_st_nxt = REQ_SEND_ST_WR;
                    rff_req_cnt_nxt     = rff_req_cnt + 1'b1;
                end
            end
            else if(xm_req_buf_master_valid & ~xm_req_buf_master_info.req_type & (~xm_req_buf_last_rd_req | xm_ar_req_fifo_slave_ready))begin//axi read request
                cpu_noc_req_valid       = 1'b1;
                cpu_noc_req.req_type    = REQ_READ;
                xm_req_buf_master_ready = cpu_noc_req_ready & xm_req_buf_last_rd_req;
                if(cpu_noc_req_ready & ~xm_req_buf_last_rd_req)begin//
                    rff_req_send_st_nxt = REQ_SEND_ST_RD;
                    rff_req_cnt_nxt     = rff_req_cnt + 1;

                end
            end
        end
        REQ_SEND_ST_WR : begin
            if(xm_wvalid & (~xm_wlast | xm_bresp_slave_ready))begin
                cpu_noc_req_valid       = 1'b1;
                cpu_noc_req.req_type    = REQ_WRITE;
                xm_wready               = cpu_noc_req_ready;
                xm_req_buf_master_ready = cpu_noc_req_ready & xm_wlast;
                if(cpu_noc_req_ready)begin
                    if(~xm_wlast)begin
                        rff_req_send_st_nxt = REQ_SEND_ST_WR;
                        rff_req_cnt_nxt     = rff_req_cnt + 1'b1;
                    end
                    else begin
                        rff_req_send_st_nxt = REQ_SEND_ST_IDLE;
                        rff_req_cnt_nxt     = '0;
                    end

                end
            end
        end
        REQ_SEND_ST_RD : begin
            if(~xm_req_buf_last_rd_req | xm_ar_req_fifo_slave_ready)begin
                cpu_noc_req_valid       = 1'b1;
                cpu_noc_req.req_type    = REQ_READ;
                xm_req_buf_master_ready = cpu_noc_req_ready & xm_req_buf_last_rd_req;
                if(cpu_noc_req_ready)begin
                    if(~xm_req_buf_last_rd_req)begin
                        rff_req_send_st_nxt = REQ_SEND_ST_RD;
                        rff_req_cnt_nxt     = rff_req_cnt + 1'b1;
                    end
                    else begin
                        rff_req_send_st_nxt = REQ_SEND_ST_IDLE;
                        rff_req_cnt_nxt     = '0;
                    end
                end
            end
        end
    endcase

end

//----------------------
// bresp auto send
//----------------------
assign  xm_bresp_slave_valid    = xm_req_buf_master_valid & xm_req_buf_master_ready & xm_req_buf_master_info.req_type;
ours_vld_rdy_buf 
#(
    .WIDTH( AXI_ID_W + 2 + AXI_MISC_W ),
    .DEPTH( 1                   )
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
//cpu noc response return buffer
//--------------------------------
assign  cpu_noc_rd_resp_fifo_slave_valid    = cpu_noc_resp_valid;
assign  cpu_noc_resp_ready                  = cpu_noc_rd_resp_fifo_slave_ready;
assign  cpu_noc_rd_resp_fifo_slave_info     = cpu_noc_resp.resp_data;

ours_vld_rdy_buf 
#(
    .WIDTH( CPU_DATA_WIDTH                  ),
    .DEPTH( CPU_NOC_RD_RESP_FIFO_DEPTH      )
)
CPU_NOC_RD_RESP_FIFO_U
(
    .clk            ( clk                                       ),
    .rstn           ( rstn                                     ),
    .clk_en         ( ),
    .slave_valid    ( cpu_noc_rd_resp_fifo_slave_valid          ),
    .slave_info     ( cpu_noc_rd_resp_fifo_slave_info           ),
    .slave_ready    ( cpu_noc_rd_resp_fifo_slave_ready          ),
    .master_valid   ( cpu_noc_rd_resp_fifo_master_valid         ),
    .master_info    ( cpu_noc_rd_resp_fifo_master_info          ),
    .master_ready   ( cpu_noc_rd_resp_fifo_master_ready         )
);

//--------------------------------------------------
//xm rdata return
//--------------------------------------------------
assign  xm_rid                              = xm_ar_req_fifo_master_info.axid;
assign  xm_rresp                            = '0;
assign  xm_rmisc_info                       = '0;
assign  cur_rd_resp_addr_offset             = xm_ar_req_fifo_master_info.axaddr[CACHE_OFFSET_WIDTH-1:0] + {rff_rd_resp_cnt,3'd0};
assign  xm_rdata                            = {AXI_DATA_W{cur_rd_resp_addr_offset[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd0}} & cpu_noc_rd_resp_fifo_master_info[0+:AXI_DATA_W]   |
                                              {AXI_DATA_W{cur_rd_resp_addr_offset[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd1}} & cpu_noc_rd_resp_fifo_master_info[AXI_DATA_W+:AXI_DATA_W]   |
                                              {AXI_DATA_W{cur_rd_resp_addr_offset[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd2}} & cpu_noc_rd_resp_fifo_master_info[2*AXI_DATA_W+:AXI_DATA_W]   |
                                              {AXI_DATA_W{cur_rd_resp_addr_offset[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'd3}} & cpu_noc_rd_resp_fifo_master_info[3*AXI_DATA_W+:AXI_DATA_W]   ;
assign  xm_rlast                            = (xm_ar_req_fifo_master_info.axlen == rff_rd_resp_cnt);//xm_ar_req_fifo_master_valid & xm_ar_req_fifo_master_ready;
assign  xm_ar_req_fifo_master_ready         = xm_rlast & xm_rvalid & xm_rready;
assign  cpu_noc_rd_resp_fifo_master_ready   = (xm_rlast | (cur_rd_resp_addr_offset[CACHE_OFFSET_WIDTH-1:CACHE_OFFSET_WIDTH-2] == 2'b11)) & xm_rvalid & xm_rready;

always_ff @(posedge clk)begin
    if(~rstn)begin
        rff_rd_resp_st  <= RD_RESP_ST_IDLE;
        rff_rd_resp_cnt <= 4'd0;
    end
    else begin
        rff_rd_resp_st  <= rff_rd_resp_st_nxt;
        rff_rd_resp_cnt <= rff_rd_resp_cnt_nxt;
    end
end

always_comb begin
    rff_rd_resp_st_nxt              = rff_rd_resp_st;
    rff_rd_resp_cnt_nxt             = rff_rd_resp_cnt;
    xm_rvalid                       = 1'b0;
    case(rff_rd_resp_st)
    RD_RESP_ST_IDLE : begin
        if(xm_ar_req_fifo_master_valid & cpu_noc_rd_resp_fifo_master_valid)begin
            xm_rvalid               = 1'b1;
            if(xm_rready & ~xm_rlast)begin
                rff_rd_resp_st_nxt  = RD_RESP_ST_BUSY;
                rff_rd_resp_cnt_nxt = rff_rd_resp_cnt + 1'b1;
            end
        end
    end
    RD_RESP_ST_BUSY : begin
        if(cpu_noc_rd_resp_fifo_master_valid)begin
            xm_rvalid                   = 1'b1;
            if(xm_rready)begin
                if(~xm_rlast)begin
                    rff_rd_resp_st_nxt  = RD_RESP_ST_BUSY;
                    rff_rd_resp_cnt_nxt = rff_rd_resp_cnt + 1'b1;
                end
                else begin
                    rff_rd_resp_st_nxt  = RD_RESP_ST_IDLE;
                    rff_rd_resp_cnt_nxt = '0;
                end
            end
        end
    end
    endcase
end

endmodule

