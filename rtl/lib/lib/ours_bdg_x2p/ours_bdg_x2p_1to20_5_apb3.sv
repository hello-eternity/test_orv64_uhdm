
////////////////////////////////////////////
// This is an auto-generated file         //
// Support: Tian Lan (tian@ours-tech.com) //
////////////////////////////////////////////
  



















module ours_bdg_x2p_1to20_5_apb3
import ours_bdg_x2p_pkg::*;
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

    ,output logic  psel_s4

    ,output logic  psel_s5

    ,output logic  psel_s6

    ,output logic  psel_s7

    ,output logic  psel_s8

    ,output logic  psel_s9

    ,output logic  psel_s10

    ,output logic  psel_s11

    ,output logic  psel_s12

    ,output logic  psel_s13

    ,output logic  psel_s14

    ,output logic  psel_s15

    ,output logic  psel_s16

    ,output logic  psel_s17

    ,output logic  psel_s18

    ,output logic  psel_s19



    ,output logic  penable_s0

    ,output logic  penable_s1

    ,output logic  penable_s2

    ,output logic  penable_s3

    ,output logic  penable_s4

    ,output logic  penable_s5

    ,output logic  penable_s6

    ,output logic  penable_s7

    ,output logic  penable_s8

    ,output logic  penable_s9

    ,output logic  penable_s10

    ,output logic  penable_s11

    ,output logic  penable_s12

    ,output logic  penable_s13

    ,output logic  penable_s14

    ,output logic  penable_s15

    ,output logic  penable_s16

    ,output logic  penable_s17

    ,output logic  penable_s18

    ,output logic  penable_s19




    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s0

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s1

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s2

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s3

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s4

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s5

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s6

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s7

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s8

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s9

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s10

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s11

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s12

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s13

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s14

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s15

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s16

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s17

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s18

    ,output logic [OURS_BDG_X2P_APB_DATA_W-1:0] pwdata_s19



    ,output logic  pwrite_s0

    ,output logic  pwrite_s1

    ,output logic  pwrite_s2

    ,output logic  pwrite_s3

    ,output logic  pwrite_s4

    ,output logic  pwrite_s5

    ,output logic  pwrite_s6

    ,output logic  pwrite_s7

    ,output logic  pwrite_s8

    ,output logic  pwrite_s9

    ,output logic  pwrite_s10

    ,output logic  pwrite_s11

    ,output logic  pwrite_s12

    ,output logic  pwrite_s13

    ,output logic  pwrite_s14

    ,output logic  pwrite_s15

    ,output logic  pwrite_s16

    ,output logic  pwrite_s17

    ,output logic  pwrite_s18

    ,output logic  pwrite_s19



    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s0

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s1

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s2

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s3

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s4

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s5

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s6

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s7

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s8

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s9

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s10

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s11

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s12

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s13

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s14

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s15

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s16

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s17

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s18

    ,output logic [OURS_BDG_X2P_APB_ADDR_W-1:0] paddr_s19




    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s0

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s1

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s2

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s3

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s4

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s5

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s6

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s7

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s8

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s9

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s10

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s11

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s12

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s13

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s14

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s15

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s16

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s17

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s18

    ,input  logic [OURS_BDG_X2P_APB_DATA_W-1:0] prdata_s19




    ,input  logic  pready_s0

    ,input  logic  pready_s1

    ,input  logic  pready_s2

    ,input  logic  pready_s3

    ,input  logic  pready_s4



    ,input  logic  pslverr_s0

    ,input  logic  pslverr_s1

    ,input  logic  pslverr_s2

    ,input  logic  pslverr_s3

    ,input  logic  pslverr_s4



);
    localparam WRAPPER_OURS_BDG_X2P_PERI_NUM                   = 20,
               WRAPPER_OURS_BDG_X2P_PERI_BASE_ADDR             = 0,
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

assign psel_s4 = pm_psel[4];

assign psel_s5 = pm_psel[5];

assign psel_s6 = pm_psel[6];

assign psel_s7 = pm_psel[7];

assign psel_s8 = pm_psel[8];

assign psel_s9 = pm_psel[9];

assign psel_s10 = pm_psel[10];

assign psel_s11 = pm_psel[11];

assign psel_s12 = pm_psel[12];

assign psel_s13 = pm_psel[13];

assign psel_s14 = pm_psel[14];

assign psel_s15 = pm_psel[15];

assign psel_s16 = pm_psel[16];

assign psel_s17 = pm_psel[17];

assign psel_s18 = pm_psel[18];

assign psel_s19 = pm_psel[19];



assign penable_s0 = pm_penable[0];

assign penable_s1 = pm_penable[1];

assign penable_s2 = pm_penable[2];

assign penable_s3 = pm_penable[3];

assign penable_s4 = pm_penable[4];

assign penable_s5 = pm_penable[5];

assign penable_s6 = pm_penable[6];

assign penable_s7 = pm_penable[7];

assign penable_s8 = pm_penable[8];

assign penable_s9 = pm_penable[9];

assign penable_s10 = pm_penable[10];

assign penable_s11 = pm_penable[11];

assign penable_s12 = pm_penable[12];

assign penable_s13 = pm_penable[13];

assign penable_s14 = pm_penable[14];

assign penable_s15 = pm_penable[15];

assign penable_s16 = pm_penable[16];

assign penable_s17 = pm_penable[17];

assign penable_s18 = pm_penable[18];

assign penable_s19 = pm_penable[19];




assign pwdata_s0 = pm_preq_t[0].pwdata;

assign pwdata_s1 = pm_preq_t[1].pwdata;

assign pwdata_s2 = pm_preq_t[2].pwdata;

assign pwdata_s3 = pm_preq_t[3].pwdata;

assign pwdata_s4 = pm_preq_t[4].pwdata;

assign pwdata_s5 = pm_preq_t[5].pwdata;

assign pwdata_s6 = pm_preq_t[6].pwdata;

assign pwdata_s7 = pm_preq_t[7].pwdata;

assign pwdata_s8 = pm_preq_t[8].pwdata;

assign pwdata_s9 = pm_preq_t[9].pwdata;

assign pwdata_s10 = pm_preq_t[10].pwdata;

assign pwdata_s11 = pm_preq_t[11].pwdata;

assign pwdata_s12 = pm_preq_t[12].pwdata;

assign pwdata_s13 = pm_preq_t[13].pwdata;

assign pwdata_s14 = pm_preq_t[14].pwdata;

assign pwdata_s15 = pm_preq_t[15].pwdata;

assign pwdata_s16 = pm_preq_t[16].pwdata;

assign pwdata_s17 = pm_preq_t[17].pwdata;

assign pwdata_s18 = pm_preq_t[18].pwdata;

assign pwdata_s19 = pm_preq_t[19].pwdata;



assign pwrite_s0 = pm_preq_t[0].pwrite;

assign pwrite_s1 = pm_preq_t[1].pwrite;

assign pwrite_s2 = pm_preq_t[2].pwrite;

assign pwrite_s3 = pm_preq_t[3].pwrite;

assign pwrite_s4 = pm_preq_t[4].pwrite;

assign pwrite_s5 = pm_preq_t[5].pwrite;

assign pwrite_s6 = pm_preq_t[6].pwrite;

assign pwrite_s7 = pm_preq_t[7].pwrite;

assign pwrite_s8 = pm_preq_t[8].pwrite;

assign pwrite_s9 = pm_preq_t[9].pwrite;

assign pwrite_s10 = pm_preq_t[10].pwrite;

assign pwrite_s11 = pm_preq_t[11].pwrite;

assign pwrite_s12 = pm_preq_t[12].pwrite;

assign pwrite_s13 = pm_preq_t[13].pwrite;

assign pwrite_s14 = pm_preq_t[14].pwrite;

assign pwrite_s15 = pm_preq_t[15].pwrite;

assign pwrite_s16 = pm_preq_t[16].pwrite;

assign pwrite_s17 = pm_preq_t[17].pwrite;

assign pwrite_s18 = pm_preq_t[18].pwrite;

assign pwrite_s19 = pm_preq_t[19].pwrite;



assign paddr_s0 = pm_preq_t[0].paddr;

assign paddr_s1 = pm_preq_t[1].paddr;

assign paddr_s2 = pm_preq_t[2].paddr;

assign paddr_s3 = pm_preq_t[3].paddr;

assign paddr_s4 = pm_preq_t[4].paddr;

assign paddr_s5 = pm_preq_t[5].paddr;

assign paddr_s6 = pm_preq_t[6].paddr;

assign paddr_s7 = pm_preq_t[7].paddr;

assign paddr_s8 = pm_preq_t[8].paddr;

assign paddr_s9 = pm_preq_t[9].paddr;

assign paddr_s10 = pm_preq_t[10].paddr;

assign paddr_s11 = pm_preq_t[11].paddr;

assign paddr_s12 = pm_preq_t[12].paddr;

assign paddr_s13 = pm_preq_t[13].paddr;

assign paddr_s14 = pm_preq_t[14].paddr;

assign paddr_s15 = pm_preq_t[15].paddr;

assign paddr_s16 = pm_preq_t[16].paddr;

assign paddr_s17 = pm_preq_t[17].paddr;

assign paddr_s18 = pm_preq_t[18].paddr;

assign paddr_s19 = pm_preq_t[19].paddr;



assign pm_presp_t[0].prdata = prdata_s0;

assign pm_presp_t[1].prdata = prdata_s1;

assign pm_presp_t[2].prdata = prdata_s2;

assign pm_presp_t[3].prdata = prdata_s3;

assign pm_presp_t[4].prdata = prdata_s4;

assign pm_presp_t[5].prdata = prdata_s5;

assign pm_presp_t[6].prdata = prdata_s6;

assign pm_presp_t[7].prdata = prdata_s7;

assign pm_presp_t[8].prdata = prdata_s8;

assign pm_presp_t[9].prdata = prdata_s9;

assign pm_presp_t[10].prdata = prdata_s10;

assign pm_presp_t[11].prdata = prdata_s11;

assign pm_presp_t[12].prdata = prdata_s12;

assign pm_presp_t[13].prdata = prdata_s13;

assign pm_presp_t[14].prdata = prdata_s14;

assign pm_presp_t[15].prdata = prdata_s15;

assign pm_presp_t[16].prdata = prdata_s16;

assign pm_presp_t[17].prdata = prdata_s17;

assign pm_presp_t[18].prdata = prdata_s18;

assign pm_presp_t[19].prdata = prdata_s19;


assign pm_presp_t[0].pslverr = pslverr_s0;
assign pm_pready[0] = pready_s0;

assign pm_presp_t[1].pslverr = pslverr_s1;
assign pm_pready[1] = pready_s1;

assign pm_presp_t[2].pslverr = pslverr_s2;
assign pm_pready[2] = pready_s2;

assign pm_presp_t[3].pslverr = pslverr_s3;
assign pm_pready[3] = pready_s3;

assign pm_presp_t[4].pslverr = pslverr_s4;
assign pm_pready[4] = pready_s4;


assign pm_presp_t[5].pslverr = 'b0;
assign pm_pready[5] = 1'b1;

assign pm_presp_t[6].pslverr = 'b0;
assign pm_pready[6] = 1'b1;

assign pm_presp_t[7].pslverr = 'b0;
assign pm_pready[7] = 1'b1;

assign pm_presp_t[8].pslverr = 'b0;
assign pm_pready[8] = 1'b1;

assign pm_presp_t[9].pslverr = 'b0;
assign pm_pready[9] = 1'b1;

assign pm_presp_t[10].pslverr = 'b0;
assign pm_pready[10] = 1'b1;

assign pm_presp_t[11].pslverr = 'b0;
assign pm_pready[11] = 1'b1;

assign pm_presp_t[12].pslverr = 'b0;
assign pm_pready[12] = 1'b1;

assign pm_presp_t[13].pslverr = 'b0;
assign pm_pready[13] = 1'b1;

assign pm_presp_t[14].pslverr = 'b0;
assign pm_pready[14] = 1'b1;

assign pm_presp_t[15].pslverr = 'b0;
assign pm_pready[15] = 1'b1;

assign pm_presp_t[16].pslverr = 'b0;
assign pm_pready[16] = 1'b1;

assign pm_presp_t[17].pslverr = 'b0;
assign pm_pready[17] = 1'b1;

assign pm_presp_t[18].pslverr = 'b0;
assign pm_pready[18] = 1'b1;

assign pm_presp_t[19].pslverr = 'b0;
assign pm_pready[19] = 1'b1;


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