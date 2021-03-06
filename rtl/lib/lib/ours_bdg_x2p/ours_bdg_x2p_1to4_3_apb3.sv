
////////////////////////////////////////////
// This is an auto-generated file         //
// Support: Tian Lan (tian@ours-tech.com) //
////////////////////////////////////////////
  



















module ours_bdg_x2p_1to4_3_apb3
import ours_bdg_x2p_pkg::*;
import station_slow_io_pkg::*;
(
     input  logic                                   aclk
    ,input  logic                                   aresetn
    ,input  logic                                   awvalid
    ,output logic                                   awready
    ,input  logic [OURS_BDG_X2P_AXI_ID_W-1:0]       awid
    ,input  logic [OURS_BDG_X2P_AXI_ADDR_W-1:0]     awaddr
    ,input  logic [OURS_BDG_X2P_AXI_LEN_W-1:0]      awlen
    ,input  logic [OURS_BDG_X2P_AXI_LOCK_W-1:0]     awlock
    ,input  logic [1:0]                             awburst
    ,input  logic [2:0]                             awsize
    ,input  logic [3:0]                             awcache
    ,input  logic [2:0]                             awprot
    ,input  logic                                   wvalid
    ,output logic                                   wready
    ,input  logic [OURS_BDG_X2P_AXI_ID_W-1:0]       wid
    ,input  logic [OURS_BDG_X2P_AXI_DATA_W-1:0]     wdata
    ,input  logic [OURS_BDG_X2P_AXI_WSTRB_W-1:0]    wstrb
    ,input  logic                                   wlast
    ,output logic                                   bvalid
    ,input  logic                                   bready
    ,output logic [OURS_BDG_X2P_AXI_ID_W-1:0]       bid
    ,output logic [1:0]                             bresp
    ,input  logic                                   arvalid
    ,output logic                                   arready
    ,input logic [OURS_BDG_X2P_AXI_ID_W-1:0]        arid
    ,input logic [OURS_BDG_X2P_AXI_ADDR_W-1:0]      araddr
    ,input logic [OURS_BDG_X2P_AXI_LEN_W-1:0]       arlen
    ,input logic [OURS_BDG_X2P_AXI_LOCK_W-1:0]      arlock
    ,input logic [1:0]                              arburst
    ,input logic [2:0]                              arsize
    ,input logic [3:0]                              arcache
    ,input logic [2:0]                              arprot
    ,output logic                                   rvalid
    ,input  logic                                   rready
    ,output logic [OURS_BDG_X2P_AXI_ID_W-1:0]       rid
    ,output logic [OURS_BDG_X2P_AXI_DATA_W-1:0]     rdata
    ,output logic [1:0]                             rresp
    ,output logic                                   rlast


    ,output logic  psel_s0

    ,output logic  psel_s1

    ,output logic  psel_s2

    ,output logic  psel_s3



    ,output logic  penable_s0

    ,output logic  penable_s1

    ,output logic  penable_s2

    ,output logic  penable_s3




    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s0

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s1

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s2

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s3



    ,output logic  pwrite_s0

    ,output logic  pwrite_s1

    ,output logic  pwrite_s2

    ,output logic  pwrite_s3



    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s0

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s1

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s2

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s3




    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s0

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s1

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s2

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s3




    ,input  logic  pready_s0

    ,input  logic  pready_s1

    ,input  logic  pready_s2



    ,input  logic  pslverr_s0

    ,input  logic  pslverr_s1

    ,input  logic  pslverr_s2



);
    localparam WRAPPER_OURS_BDG_X2P_PERI_NUM                   = 4,
               WRAPPER_OURS_BDG_X2P_PERI_BASE_ADDR             = STATION_SLOW_IO_RTC_BLOCK_REG_OFFSET,
               WRAPPER_OURS_BDG_X2P_PERI_ADDR_SPACE_SZ         = 1024,
               WRAPPER_OURS_BDG_X2P_FIFO_DEPTH                 = 2;
logic                                          xs_awvalid;
logic                                          xs_awready;
axi_aw_t                                       xs_aw_t   ;
logic                                          xs_wvalid ;
logic                                          xs_wready ;
axi_w_t                                        xs_w_t    ;
logic                                          xs_bvalid ;
logic                                          xs_bready ;
axi_b_t                                        xs_b_t    ;
logic                                          xs_arvalid;
logic                                          xs_arready;
axi_ar_t                                       xs_ar_t   ;
logic                                          xs_rvalid ;
logic                                          xs_rready ;
axi_r_t                                        xs_r_t    ;  
logic  [WRAPPER_OURS_BDG_X2P_PERI_NUM-1:0]             pm_psel   ;
logic  [WRAPPER_OURS_BDG_X2P_PERI_NUM-1:0]             pm_penable;
logic  [WRAPPER_OURS_BDG_X2P_PERI_NUM-1:0]             pm_pready ;
apb_req_t  [WRAPPER_OURS_BDG_X2P_PERI_NUM-1:0]         pm_preq_t ;
apb_resp_t [WRAPPER_OURS_BDG_X2P_PERI_NUM-1:0]         pm_presp_t;

assign xs_awvalid           = awvalid ; 
assign awready              = xs_awready ; 
assign xs_wvalid            = wvalid  ;
assign wready               = xs_wready  ;
assign bvalid               = xs_bvalid  ;
assign xs_bready            = bready  ;
assign xs_arvalid           = arvalid ; 
assign arready              = xs_arready ; 
assign rvalid               = xs_rvalid  ;
assign xs_rready            = rready  ;
assign xs_aw_t.awid         = awid    ;  
assign xs_aw_t.awaddr       = awaddr  ;  
assign xs_aw_t.awlen        = awlen   ;  
assign xs_aw_t.awlock       = awlock  ;  
assign xs_aw_t.awburst      = awburst ;  
assign xs_aw_t.awsize       = awsize  ;  
assign xs_aw_t.awcache      = awcache ;  
assign xs_aw_t.awprot       = awprot  ;  
assign xs_w_t.wid           = wid     ; 
assign xs_w_t.wdata         = wdata   ; 
assign xs_w_t.wstrb         = wstrb   ; 
assign xs_w_t.wlast         = wlast   ; 
assign bid                  = xs_b_t.bid     ; 
assign bresp                = xs_b_t.bresp   ; 
assign xs_ar_t.arid         = arid    ;
assign xs_ar_t.araddr       = araddr  ;
assign xs_ar_t.arlen        = arlen   ;
assign xs_ar_t.arlock       = arlock  ;
assign xs_ar_t.arburst      = arburst ;
assign xs_ar_t.arsize       = arsize  ;
assign xs_ar_t.arcache      = arcache ;
assign xs_ar_t.arprot       = arprot  ;
assign rid                  = xs_r_t.rid     ; 
assign rdata                = xs_r_t.rdata   ; 
assign rresp                = xs_r_t.rresp   ; 
assign rlast                = xs_r_t.rlast   ; 



assign psel_s0 = pm_psel[0];

assign psel_s1 = pm_psel[1];

assign psel_s2 = pm_psel[2];

assign psel_s3 = pm_psel[3];



assign penable_s0 = pm_penable[0];

assign penable_s1 = pm_penable[1];

assign penable_s2 = pm_penable[2];

assign penable_s3 = pm_penable[3];




assign pwdata_s0 = pm_preq_t[0].pwdata;

assign pwdata_s1 = pm_preq_t[1].pwdata;

assign pwdata_s2 = pm_preq_t[2].pwdata;

assign pwdata_s3 = pm_preq_t[3].pwdata;



assign pwrite_s0 = pm_preq_t[0].pwrite;

assign pwrite_s1 = pm_preq_t[1].pwrite;

assign pwrite_s2 = pm_preq_t[2].pwrite;

assign pwrite_s3 = pm_preq_t[3].pwrite;



assign paddr_s0 = pm_preq_t[0].paddr;

assign paddr_s1 = pm_preq_t[1].paddr;

assign paddr_s2 = pm_preq_t[2].paddr;

assign paddr_s3 = pm_preq_t[3].paddr;



assign pm_presp_t[0].prdata = prdata_s0;

assign pm_presp_t[1].prdata = prdata_s1;

assign pm_presp_t[2].prdata = prdata_s2;

assign pm_presp_t[3].prdata = prdata_s3;


assign pm_presp_t[0].pslverr = pslverr_s0;
assign pm_pready[0] = pready_s0;

assign pm_presp_t[1].pslverr = pslverr_s1;
assign pm_pready[1] = pready_s1;

assign pm_presp_t[2].pslverr = pslverr_s2;
assign pm_pready[2] = pready_s2;


assign pm_presp_t[3].pslverr = 'b0;
assign pm_pready[3] = 1'b1;


ours_bdg_x2p
#(
    .OURS_BDG_X2P_PERI_NUM                   ( WRAPPER_OURS_BDG_X2P_PERI_NUM                   ),
    .OURS_BDG_X2P_PERI_BASE_ADDR             ( WRAPPER_OURS_BDG_X2P_PERI_BASE_ADDR             ),
    .OURS_BDG_X2P_PERI_ADDR_SPACE_SZ         ( WRAPPER_OURS_BDG_X2P_PERI_ADDR_SPACE_SZ         ),
    .OURS_BDG_X2P_FIFO_DEPTH                 ( WRAPPER_OURS_BDG_X2P_FIFO_DEPTH                 )
)
OURS_BDG_X2P_U
(
    .aclk           ( aclk              ), 
    .aresetn        ( aresetn           ),
    .xs_awvalid     ( xs_awvalid        ),
    .xs_awready     ( xs_awready        ),
    .xs_aw_t        ( xs_aw_t           ),
    .xs_wvalid      ( xs_wvalid         ),
    .xs_wready      ( xs_wready         ),
    .xs_w_t         ( xs_w_t            ),
    .xs_bvalid      ( xs_bvalid         ),
    .xs_bready      ( xs_bready         ),
    .xs_b_t         ( xs_b_t            ),
    .xs_arvalid     ( xs_arvalid        ),
    .xs_arready     ( xs_arready        ),
    .xs_ar_t        ( xs_ar_t           ),
    .xs_rvalid      ( xs_rvalid         ),
    .xs_rready      ( xs_rready         ),
    .xs_r_t         ( xs_r_t            ), 
    .pm_psel        ( pm_psel           ),
    .pm_penable     ( pm_penable        ),
    .pm_pready      ( pm_pready         ),
    .pm_preq_t      ( pm_preq_t         ),
    .pm_presp_t     ( pm_presp_t        )
);
endmodule