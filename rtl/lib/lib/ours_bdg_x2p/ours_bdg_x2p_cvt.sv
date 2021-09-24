//===============================================
// Filename     : ours_bdg_x2p_cvt.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2019-12-16 17:32:41
// Description  : aclk domain, convert logic, aix -> apb
//                1) axi write has higher priority than axi read if target for the same peripheral
//================================================

module  ours_bdg_x2p_cvt 
import ours_bdg_x2p_pkg::*;
#(
    parameter OURS_BDG_X2P_PERI_NUM                   = 20,
    parameter OURS_BDG_X2P_PERI_BASE_ADDR             = '0,
    parameter OURS_BDG_X2P_PERI_ADDR_SPACE_SZ         = 'h400,
    parameter OURS_BDG_X2P_FIFO_DEPTH                 = 2
)
(
        input                                                           aclk
       ,input                                                           aresetn
       ,input                                                           xs_awvalid
       ,output                                                          xs_awready
       ,input   axi_aw_t                                                xs_aw_t
       ,input                                                           xs_wvalid
       ,output                                                          xs_wready
       ,input   axi_w_t                                                 xs_w_t
       ,output                                                          xs_bvalid
       ,input                                                           xs_bready
       ,output  axi_b_t                                                 xs_b_t
       ,input                                                           xs_arvalid
       ,output                                                          xs_arready
       ,input   axi_ar_t                                                xs_ar_t
       ,output                                                          xs_rvalid
       ,input                                                           xs_rready
       ,output  axi_r_t                                                 xs_r_t
       //interface with fifo
       ,output  [OURS_BDG_X2P_PERI_NUM-1:0]                             cvt_fifo_preq_valid
       ,input   [OURS_BDG_X2P_PERI_NUM-1:0]                             fifo_cvt_preq_ready
       ,output  apb_req_t  [OURS_BDG_X2P_PERI_NUM-1:0]                  cvt_fifo_preq_t
       ,input   [OURS_BDG_X2P_PERI_NUM-1:0]                             fifo_cvt_presp_valid
       ,output  [OURS_BDG_X2P_PERI_NUM-1:0]                             cvt_fifo_presp_ready
       ,input   apb_resp_t [OURS_BDG_X2P_PERI_NUM-1:0]                  fifo_cvt_presp_t
);

genvar i;
logic               [OURS_BDG_X2P_PERI_NUM-1:0]                 cvt_pwr_vld;
logic               [OURS_BDG_X2P_PERI_NUM-1:0]                 cvt_prd_vld;
cvt_queue_req_id_t  [OURS_BDG_X2P_PERI_NUM-1:0]                 cvt_queue_req_id_t_in;
cvt_queue_req_id_t  [OURS_BDG_X2P_PERI_NUM-1:0]                 cvt_queue_req_id_t_out;
logic               [OURS_BDG_X2P_PERI_NUM-1:0]                 cvt_req_id_fifo_we;
logic               [OURS_BDG_X2P_PERI_NUM-1:0]                 cvt_req_id_fifo_re;

logic               [$clog2(OURS_BDG_X2P_PERI_NUM)-1:0]         rffce_cvt_rr_sel_ctr;
logic               [2*OURS_BDG_X2P_PERI_NUM-1:0]               fifo_cvt_valid_crshf_tmp;
logic               [OURS_BDG_X2P_PERI_NUM-1:0]                 fifo_cvt_valid_crshf;
logic               [OURS_BDG_X2P_PERI_NUM-1:0]                 fifo_cvt_valid_crshf_onehot;
logic               [2*OURS_BDG_X2P_PERI_NUM-1:0]               fifo_cvt_valid_rr_onehot_tmp;
logic               [OURS_BDG_X2P_PERI_NUM-1:0]                 fifo_cvt_valid_rr_onehot;

apb_resp_t          [OURS_BDG_X2P_PERI_NUM-1:0]                 fifo_cvt_presp_t_history;
apb_resp_t                                                      fifo_cvt_presp_t_mux;
cvt_queue_req_id_t  [OURS_BDG_X2P_PERI_NUM-1:0]                 cvt_queue_req_id_t_out_history;
cvt_queue_req_id_t                                              cvt_queue_req_id_t_out_mux;

logic                                                           cvt_bresp_ppln_valid_in;
logic                                                           cvt_bresp_ppln_ready_out;
axi_b_t                                                         cvt_bresp_ppln_data_in;
logic                                                           cvt_rresp_ppln_valid_in;
logic                                                           cvt_rresp_ppln_ready_out;
axi_r_t                                                         cvt_rresp_ppln_data_in;
//-------------------------
//request channel
//-------------------------
//axi write has higher priority than read in being requested if target for the same peripheral
assign  xs_awready  = |(cvt_pwr_vld & fifo_cvt_preq_ready);
assign  xs_wready   = xs_awready;
assign  xs_arready  = |((~cvt_pwr_vld) & cvt_prd_vld & fifo_cvt_preq_ready);
generate
for(i=0;i<OURS_BDG_X2P_PERI_NUM;i++)begin : GEN_CVT_PWR_VLD
    assign  cvt_pwr_vld[i]  = xs_awvalid & xs_wvalid & (xs_aw_t.awaddr >= (OURS_BDG_X2P_PERI_BASE_ADDR + OURS_BDG_X2P_PERI_ADDR_SPACE_SZ*i)) & 
                                                       (xs_aw_t.awaddr <  (OURS_BDG_X2P_PERI_BASE_ADDR + OURS_BDG_X2P_PERI_ADDR_SPACE_SZ*(i+1))) ;
    assign  cvt_prd_vld[i]  = xs_arvalid & (xs_ar_t.araddr >= (OURS_BDG_X2P_PERI_BASE_ADDR + OURS_BDG_X2P_PERI_ADDR_SPACE_SZ*i)) & 
                                           (xs_ar_t.araddr <  (OURS_BDG_X2P_PERI_BASE_ADDR + OURS_BDG_X2P_PERI_ADDR_SPACE_SZ*(i+1))) ;
end
endgenerate

generate
for(i=0;i<OURS_BDG_X2P_PERI_NUM;i++)begin : GEN_CVT_FIFO_PREQ
    assign  cvt_fifo_preq_valid[i]          = cvt_pwr_vld[i] | cvt_prd_vld[i];
    assign  cvt_fifo_preq_t[i].pwrite       = cvt_pwr_vld[i];
    assign  cvt_fifo_preq_t[i].paddr        = cvt_pwr_vld[i] ? xs_aw_t.awaddr[0+:OURS_BDG_X2P_APB_ADDR_W] : xs_ar_t.araddr[0+:OURS_BDG_X2P_APB_ADDR_W] ;
    assign  cvt_fifo_preq_t[i].pwdata       = xs_w_t.wdata;
    assign  cvt_queue_req_id_t_in[i].pwrite = cvt_pwr_vld[i];
    assign  cvt_queue_req_id_t_in[i].req_id = cvt_pwr_vld[i] ? xs_aw_t.awid : xs_ar_t.arid;

    assign  cvt_req_id_fifo_we[i]           = cvt_fifo_preq_valid[i] & fifo_cvt_preq_ready[i];
    assign  cvt_req_id_fifo_re[i]           = fifo_cvt_valid_rr_onehot[i] & (cvt_queue_req_id_t_out[i].pwrite ? cvt_bresp_ppln_ready_out : cvt_rresp_ppln_ready_out);
    ours_fifo 
    #(
        .WIDTH ( $bits( cvt_queue_req_id_t )    ),
        .DEPTH ( 2*OURS_BDG_X2P_FIFO_DEPTH     )
    )
    CVT_REQ_ID_FIFO
    (
        .empty  ( ),
        .full   ( ),
        .dout   ( cvt_queue_req_id_t_out[i] ),
        .din    ( cvt_queue_req_id_t_in[i]  ),
        .we     ( cvt_req_id_fifo_we[i]     ),
        .re     ( cvt_req_id_fifo_re[i]     ),
        .rstn   ( aresetn                   ),
        .clk    ( aclk                      )
    );
end

endgenerate
//--------------------------------
//response channel
//--------------------------------

//round robin to select the device response
always_ff @(posedge aclk )begin
    if(~aresetn)begin
        rffce_cvt_rr_sel_ctr    <= '0;
    end
    else if(|(fifo_cvt_presp_valid & cvt_fifo_presp_ready)) begin
        if(rffce_cvt_rr_sel_ctr == OURS_BDG_X2P_PERI_NUM - 1)begin
            rffce_cvt_rr_sel_ctr    <= '0;
        end
        else begin
            rffce_cvt_rr_sel_ctr    <= rffce_cvt_rr_sel_ctr + 1'b1;
        end
    end
end

assign  fifo_cvt_valid_crshf_tmp= ({2{fifo_cvt_presp_valid}} >> rffce_cvt_rr_sel_ctr);
assign  fifo_cvt_valid_crshf    = fifo_cvt_valid_crshf_tmp[0+:OURS_BDG_X2P_PERI_NUM] ;

generate
    assign  fifo_cvt_valid_crshf_onehot[0]  = fifo_cvt_valid_crshf[0];
for(i=1;i<OURS_BDG_X2P_PERI_NUM;i++)begin : GEN_FIFO_CVT_VALID_CRSHF_ONEHOT
    assign  fifo_cvt_valid_crshf_onehot[i]  = (~|fifo_cvt_valid_crshf[0+:i]) & fifo_cvt_valid_crshf[i];
end
    assign  fifo_cvt_valid_rr_onehot_tmp    = ({2{fifo_cvt_valid_crshf_onehot}} << rffce_cvt_rr_sel_ctr);
    assign  fifo_cvt_valid_rr_onehot        = fifo_cvt_valid_rr_onehot_tmp[OURS_BDG_X2P_PERI_NUM+:OURS_BDG_X2P_PERI_NUM] ;

    assign  fifo_cvt_presp_t_history[0]     = {$bits(apb_resp_t){fifo_cvt_valid_rr_onehot[0]}} & fifo_cvt_presp_t[0];
    assign  cvt_queue_req_id_t_out_history[0]   = {$bits(cvt_queue_req_id_t){fifo_cvt_valid_rr_onehot[0]}} & cvt_queue_req_id_t_out[0];
    for(i=1;i<OURS_BDG_X2P_PERI_NUM;i++)begin : GEN_FIFO_CVT_PRESP_T_HISTORY
        assign  fifo_cvt_presp_t_history[i]     = fifo_cvt_presp_t_history[i-1]                         | 
                                                  {$bits(apb_resp_t){fifo_cvt_valid_rr_onehot[i]}} & fifo_cvt_presp_t[i];
        assign  cvt_queue_req_id_t_out_history[i]   = cvt_queue_req_id_t_out_history[i-1]                         |
                                                  {$bits(cvt_queue_req_id_t){fifo_cvt_valid_rr_onehot[i]}} & cvt_queue_req_id_t_out[i];
    end
    assign  fifo_cvt_presp_t_mux        = fifo_cvt_presp_t_history[OURS_BDG_X2P_PERI_NUM-1] ;
    assign  cvt_queue_req_id_t_out_mux  = cvt_queue_req_id_t_out_history[OURS_BDG_X2P_PERI_NUM-1] ;
endgenerate

assign  cvt_bresp_ppln_valid_in         = (|fifo_cvt_presp_valid) & cvt_queue_req_id_t_out_mux.pwrite;
assign  cvt_bresp_ppln_data_in.bid      = cvt_queue_req_id_t_out_mux.req_id;
assign  cvt_bresp_ppln_data_in.bresp[1] = fifo_cvt_presp_t_mux.pslverr;
assign  cvt_bresp_ppln_data_in.bresp[0] = 1'b0;

assign  cvt_rresp_ppln_valid_in         = (|fifo_cvt_presp_valid) & ~cvt_queue_req_id_t_out_mux.pwrite;
assign  cvt_rresp_ppln_data_in.rid      = cvt_queue_req_id_t_out_mux.req_id;
assign  cvt_rresp_ppln_data_in.rdata    = fifo_cvt_presp_t_mux.prdata;
assign  cvt_rresp_ppln_data_in.rresp[1] = fifo_cvt_presp_t_mux.pslverr;
assign  cvt_rresp_ppln_data_in.rresp[0] = 1'b0;
assign  cvt_rresp_ppln_data_in.rlast    = 1'b1;

assign  cvt_fifo_presp_ready            = fifo_cvt_valid_rr_onehot & {OURS_BDG_X2P_PERI_NUM{(cvt_queue_req_id_t_out_mux.pwrite ? cvt_bresp_ppln_ready_out : 
                                                                                                                              cvt_rresp_ppln_ready_out)}};

ours_ppln_cell
#(
 .WIDTH ($bits(axi_b_t) ),
 .TYPE  ( 2             )
 )
XS_BRESP_PPLN
(
   .clk         ( aclk                      )
  ,.rstn        ( aresetn                   )
  ,.valid_in    ( cvt_bresp_ppln_valid_in   )
  ,.ready_out   ( cvt_bresp_ppln_ready_out  )
  ,.data_in     ( cvt_bresp_ppln_data_in    )
  ,.valid_out   ( xs_bvalid                 )
  ,.ready_in    ( xs_bready                 )
  ,.data_out    ( xs_b_t                    )
);
ours_ppln_cell
#(
 .WIDTH ($bits(axi_r_t) ),
 .TYPE  ( 2             )
 )
XS_RRESP_PPLN
(
   .clk         ( aclk                      )
  ,.rstn        ( aresetn                   )
  ,.valid_in    ( cvt_rresp_ppln_valid_in   )
  ,.ready_out   ( cvt_rresp_ppln_ready_out  )
  ,.data_in     ( cvt_rresp_ppln_data_in    )
  ,.valid_out   ( xs_rvalid                 )
  ,.ready_in    ( xs_rready                 )
  ,.data_out    ( xs_r_t                    )
);

endmodule

