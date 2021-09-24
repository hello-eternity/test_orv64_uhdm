//===============================================
// Filename     : ours_bdg_x2p_pdec.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2019-12-16 17:41:22
// Description  : 1) domain, receive cmds from ours_bdg_x2p_fifo,send rsp to ours_bdg_x2p_fifo
//                2) handshake with apb peripheral  
//================================================

module ours_bdg_x2p_pdec 
import ours_bdg_x2p_pkg::*;
(
     input                      aclk
    ,input                      aresetn

    ,input                      fifo_pdec_preq_valid
    ,output logic               pdec_fifo_preq_ready
    ,input  apb_req_t           fifo_pdec_preq_t
    ,output logic               pdec_fifo_presp_valid
    ,input                      fifo_pdec_presp_ready
    ,output apb_resp_t          pdec_fifo_presp_t

    ,output logic               pm_psel
    ,output logic               pm_penable
    ,input                      pm_pready
    ,output apb_req_t           pm_preq_t
    ,input  apb_resp_t          pm_presp_t
);

localparam      ST_IDLE     = 2'b00,
                ST_TRANS    = 2'b01;
logic   [1:0]   rff_st;
logic   [1:0]   rff_st_nxt;

assign  pdec_fifo_presp_t   = pm_presp_t;

always_ff @(posedge aclk)begin
    if(~aresetn)begin
        rff_st  <= ST_IDLE;
    end
    else begin
        rff_st  <= rff_st_nxt;
    end 
end

assign  pm_preq_t           = fifo_pdec_preq_t;

always_comb begin
    rff_st_nxt              = rff_st;
    pm_psel                 = 1'b0;
    pm_penable              = 1'b0;
    pdec_fifo_preq_ready    = 1'b0;
    pdec_fifo_presp_valid   = 1'b0;
    case(rff_st)
    ST_IDLE  : begin
        if(fifo_pdec_preq_valid & fifo_pdec_presp_ready)begin
            rff_st_nxt              = ST_TRANS;
            pm_psel                 = 1'b1;
        end
    end
    ST_TRANS : begin
        pm_psel                     = 1'b1;
        pm_penable                  = 1'b1;
        if(pm_pready)begin
            rff_st_nxt              = ST_IDLE;
            pdec_fifo_presp_valid   = 1'b1;
            pdec_fifo_preq_ready    = 1'b1;
        end

    end
    endcase
end

endmodule

