//===============================================
// Filename     : ours_bdg_x2p.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2019-12-16 17:44:51
// Description  : top module for axi to apb bridge
//================================================
module ours_bdg_x2p
import ours_bdg_x2p_pkg::*;
#(
    parameter OURS_BDG_X2P_PERI_NUM                   = 20,
    parameter OURS_BDG_X2P_PERI_BASE_ADDR             = '0,
    parameter OURS_BDG_X2P_PERI_ADDR_SPACE_SZ         = 'h400,
    parameter OURS_BDG_X2P_FIFO_DEPTH                 = 2
)
(
     input                                          aclk
    ,input                                          aresetn
    ,input                                          xs_awvalid
    ,output                                         xs_awready
    ,input   axi_aw_t                               xs_aw_t
    ,input                                          xs_wvalid
    ,output                                         xs_wready
    ,input   axi_w_t                                xs_w_t
    ,output                                         xs_bvalid
    ,input                                          xs_bready
    ,output  axi_b_t                                xs_b_t
    ,input                                          xs_arvalid
    ,output                                         xs_arready
    ,input   axi_ar_t                               xs_ar_t
    ,output                                         xs_rvalid
    ,input                                          xs_rready
    ,output  axi_r_t                                xs_r_t      

//    ,input                                          pclk
//    ,input                                          presetn
    ,output [OURS_BDG_X2P_PERI_NUM-1:0]             pm_psel
    ,output [OURS_BDG_X2P_PERI_NUM-1:0]             pm_penable
    ,input  [OURS_BDG_X2P_PERI_NUM-1:0]             pm_pready
    ,output apb_req_t  [OURS_BDG_X2P_PERI_NUM-1:0]  pm_preq_t
    ,input  apb_resp_t [OURS_BDG_X2P_PERI_NUM-1:0]  pm_presp_t
);

logic       [OURS_BDG_X2P_PERI_NUM-1:0]             cvt_fifo_preq_valid;
logic       [OURS_BDG_X2P_PERI_NUM-1:0]             fifo_cvt_preq_ready;
apb_req_t   [OURS_BDG_X2P_PERI_NUM-1:0]             cvt_fifo_preq_t;
logic       [OURS_BDG_X2P_PERI_NUM-1:0]             fifo_cvt_presp_valid;
logic       [OURS_BDG_X2P_PERI_NUM-1:0]             cvt_fifo_presp_ready;
apb_resp_t  [OURS_BDG_X2P_PERI_NUM-1:0]             fifo_cvt_presp_t;

logic       [OURS_BDG_X2P_PERI_NUM-1:0]             fifo_pdec_preq_valid;
logic       [OURS_BDG_X2P_PERI_NUM-1:0]             pdec_fifo_preq_ready;
apb_req_t   [OURS_BDG_X2P_PERI_NUM-1:0]             fifo_pdec_preq_t;
logic       [OURS_BDG_X2P_PERI_NUM-1:0]             pdec_fifo_presp_valid;
logic       [OURS_BDG_X2P_PERI_NUM-1:0]             fifo_pdec_presp_ready;
apb_resp_t  [OURS_BDG_X2P_PERI_NUM-1:0]             pdec_fifo_presp_t;

ours_bdg_x2p_cvt 
#(
    .OURS_BDG_X2P_PERI_NUM           ( OURS_BDG_X2P_PERI_NUM              ), 
    .OURS_BDG_X2P_PERI_BASE_ADDR     ( OURS_BDG_X2P_PERI_BASE_ADDR        ),
    .OURS_BDG_X2P_PERI_ADDR_SPACE_SZ ( OURS_BDG_X2P_PERI_ADDR_SPACE_SZ    ), 
    .OURS_BDG_X2P_FIFO_DEPTH         ( OURS_BDG_X2P_FIFO_DEPTH            ) 
)
OURS_BDG_X2P_CVT_U
(
    .aclk                       ( aclk                      ),
    .aresetn                    ( aresetn                   ),
    .xs_awvalid                 ( xs_awvalid                ),
    .xs_awready                 ( xs_awready                ),
    .xs_aw_t                    ( xs_aw_t                   ),
    .xs_wvalid                  ( xs_wvalid                 ),
    .xs_wready                  ( xs_wready                 ),
    .xs_w_t                     ( xs_w_t                    ),
    .xs_bvalid                  ( xs_bvalid                 ),
    .xs_bready                  ( xs_bready                 ),
    .xs_b_t                     ( xs_b_t                    ),
    .xs_arvalid                 ( xs_arvalid                ),
    .xs_arready                 ( xs_arready                ),
    .xs_ar_t                    ( xs_ar_t                   ),
    .xs_rvalid                  ( xs_rvalid                 ),
    .xs_rready                  ( xs_rready                 ),
    .xs_r_t                     ( xs_r_t                    ),
    .cvt_fifo_preq_valid        ( cvt_fifo_preq_valid       ),
    .fifo_cvt_preq_ready        ( fifo_cvt_preq_ready       ),
    .cvt_fifo_preq_t            ( cvt_fifo_preq_t           ),
    .fifo_cvt_presp_valid       ( fifo_cvt_presp_valid      ),
    .cvt_fifo_presp_ready       ( cvt_fifo_presp_ready      ),
    .fifo_cvt_presp_t           ( fifo_cvt_presp_t          )
);

genvar i;
generate    
for(i=0;i<OURS_BDG_X2P_PERI_NUM;i++)begin : GEN_OURS_BDG_X2P_FIFO_U

ours_bdg_x2p_fifo 
#(
    .OURS_BDG_X2P_FIFO_DEPTH ( OURS_BDG_X2P_FIFO_DEPTH  )
)
OURS_BDG_X2P_FIFO_U
(
    .aclk                       ( aclk                      ),
    .aresetn                    ( aresetn                   ),
    .cvt_fifo_preq_valid        ( cvt_fifo_preq_valid[i]    ),
    .fifo_cvt_preq_ready        ( fifo_cvt_preq_ready[i]    ),
    .cvt_fifo_preq_t            ( cvt_fifo_preq_t[i]        ),
    .fifo_cvt_presp_valid       ( fifo_cvt_presp_valid[i]   ),
    .cvt_fifo_presp_ready       ( cvt_fifo_presp_ready[i]   ),
    .fifo_cvt_presp_t           ( fifo_cvt_presp_t[i]       ),
    .fifo_pdec_preq_valid       ( fifo_pdec_preq_valid[i]   ),
    .pdec_fifo_preq_ready       ( pdec_fifo_preq_ready[i]   ),
    .fifo_pdec_preq_t           ( fifo_pdec_preq_t[i]       ),
    .pdec_fifo_presp_valid      ( pdec_fifo_presp_valid[i]  ),
    .fifo_pdec_presp_ready      ( fifo_pdec_presp_ready[i]  ),
    .pdec_fifo_presp_t          ( pdec_fifo_presp_t[i]      )
);

ours_bdg_x2p_pdec OURS_BDG_X2P_PDEC_U
(
    .aclk                       ( aclk                      ),
    .aresetn                    ( aresetn                   ),
    .fifo_pdec_preq_valid       ( fifo_pdec_preq_valid[i]   ),
    .pdec_fifo_preq_ready       ( pdec_fifo_preq_ready[i]   ),
    .fifo_pdec_preq_t           ( fifo_pdec_preq_t[i]       ),
    .pdec_fifo_presp_valid      ( pdec_fifo_presp_valid[i]  ),
    .fifo_pdec_presp_ready      ( fifo_pdec_presp_ready[i]  ),
    .pdec_fifo_presp_t          ( pdec_fifo_presp_t[i]      ),
    .pm_psel                    ( pm_psel[i]                ),
    .pm_penable                 ( pm_penable[i]             ),
    .pm_pready                  ( pm_pready[i]              ),
    .pm_preq_t                  ( pm_preq_t[i]              ),
    .pm_presp_t                 ( pm_presp_t[i]             )
);

end
endgenerate


endmodule
