//===============================================
// Filename     : ours_bdg_x2p_fifo.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2019-12-16 17:35:04
// Description  : clock domain crossing fifo
//              1) on the aclk domain,receive cmds from ours_bdg_x2p_cvt, send rsp to ours_bdg_x2p_cvt
//              2) on the pclk domain,send cmds to ours_bdg_x2p_dec, receive rsp from ours_bdg_x2p_pdec
//================================================
module ours_bdg_x2p_fifo
import ours_bdg_x2p_pkg::*;
#(
    parameter OURS_BDG_X2P_FIFO_DEPTH                 = 2
)
(
     input                      aclk
    ,input                      aresetn
    ,input                      cvt_fifo_preq_valid  
    ,output                     fifo_cvt_preq_ready  
    ,input  apb_req_t           cvt_fifo_preq_t 
    ,output                     fifo_cvt_presp_valid  
    ,input                      cvt_fifo_presp_ready  
    ,output apb_resp_t          fifo_cvt_presp_t
    ,output                     fifo_pdec_preq_valid 
    ,input                      pdec_fifo_preq_ready 
    ,output apb_req_t           fifo_pdec_preq_t     
    ,input                      pdec_fifo_presp_valid
    ,output                     fifo_pdec_presp_ready
    ,input  apb_resp_t          pdec_fifo_presp_t    
);

sd_flop_fifo
#( 
.width  ( $bits(apb_req_t)          ),
.depth  ( OURS_BDG_X2P_FIFO_DEPTH  )
)
PREQ_Q
(
    .clk            ( aclk                  ),
    .rst            ( ~aresetn              ),
    .c_srdy         ( cvt_fifo_preq_valid   ),
    .c_drdy         ( fifo_cvt_preq_ready   ),
    .c_data         ( cvt_fifo_preq_t       ),
    .p_srdy         ( fifo_pdec_preq_valid  ),
    .p_drdy         ( pdec_fifo_preq_ready  ),
    .p_data         ( fifo_pdec_preq_t      ),
    .usage          ( )
    
);

sd_flop_fifo
#( 
.width  ( $bits(apb_resp_t)         ),
.depth  ( OURS_BDG_X2P_FIFO_DEPTH  )
)
PRESP_Q
(
    .clk            ( aclk                      ),
    .rst            ( ~aresetn                  ),
    .c_srdy         ( pdec_fifo_presp_valid     ),
    .c_drdy         ( fifo_pdec_presp_ready     ),
    .c_data         ( pdec_fifo_presp_t         ),
    .p_srdy         ( fifo_cvt_presp_valid      ),
    .p_drdy         ( cvt_fifo_presp_ready      ),
    .p_data         ( fifo_cvt_presp_t          ),
    .usage          ( )
    
);

endmodule
