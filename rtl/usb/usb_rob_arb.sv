module usb_rob_arb
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter N_REQ = 2
)
(
  // Requester side
  input logic                [N_REQ-1:0] cpu_if_req_valid, 
  input cpu_cache_if_req_t   [N_REQ-1:0] cpu_if_req, 
  output logic               [N_REQ-1:0] cpu_if_req_ready, 
  output logic               [N_REQ-1:0] cpu_if_resp_valid, 
  output cpu_cache_if_resp_t [N_REQ-1:0] cpu_if_resp, 
  input logic                [N_REQ-1:0] cpu_if_resp_ready,

  // CPU NOC side
  output logic 				 cache_if_req_valid, 
  output cpu_cache_if_req_t  cache_if_req, 
  input  logic 				 cache_if_req_ready, 
  input  logic 				 cache_if_resp_valid, 
  input  cpu_cache_if_resp_t cache_if_resp, 
  output logic               cache_if_resp_ready,

  input rstn, clk
);
  logic                [N_REQ-1:0] req_valid;
  cpu_cache_if_req_t   [N_REQ-1:0] req; 
  logic                [N_REQ-1:0] req_ready; 

  logic [$bits(cache_if_req.req_tid.tid)-1:0]  rff_tid_gen;

  logic [N_REQ-1:0] req_gnt; 
  logic 	        req_arb_rdy;

generate
for (genvar i = 0; i < N_REQ; i++) begin : ROB_BUF_IN
  ours_vld_rdy_buf #(.WIDTH($bits(cpu_cache_if_req_t)), .DEPTH(1)) rob_buf_in_u (
    .slave_valid  (cpu_if_req_valid[i]),
    .slave_info   (cpu_if_req[i]),
    .slave_ready  (cpu_if_req_ready[i]),
    .master_valid (req_valid[i]),
    .master_info  (req[i]),
    .master_ready (req_ready[i]),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk));
end
endgenerate

  ours_vld_rdy_rr_arb #(.N_INPUT(N_REQ)) req_arb_u (
    .clk  (clk),
    .rstn (rstn),
    .rdy  (req_arb_rdy),
    .vld  (req_valid),     
    .grt  (req_gnt));

  assign req_arb_rdy = |(req_valid & req_ready);
  assign req_ready = req_gnt & {N_REQ{cache_if_req_ready}};
  // cache request
  assign cache_if_req_valid = |(req_valid & req_gnt);
  assign cache_if_req.req_tid.src = req_valid[0] & req_gnt[0] ? '0 : '1; 
  assign cache_if_req.req_tid.tid = rff_tid_gen;
  assign cache_if_req.req_tid.cpu_noc_id = '0;
  assign cache_if_req.req_paddr = req_valid[0] & req_gnt[0] ? req[0].req_paddr : req[1].req_paddr;
  assign cache_if_req.req_data  = req_valid[0] & req_gnt[0] ? req[0].req_data  : req[1].req_data;
  assign cache_if_req.req_mask  = req_valid[0] & req_gnt[0] ? req[0].req_mask  : req[1].req_mask;
  assign cache_if_req.req_type  = req_valid[0] & req_gnt[0] ? req[0].req_type  : req[1].req_type;

  // tid genertion
  always_ff @(posedge clk) begin
    if (~rstn) 
	  rff_tid_gen <= '0;
	else if (cache_if_req_valid & cache_if_req_ready)
	  rff_tid_gen <= rff_tid_gen + 1'b1;	
  end 

  // cache response
  assign cpu_if_resp_valid[0] = cache_if_resp_valid & (cache_if_resp.resp_tid.src == '0); 
  assign cpu_if_resp_valid[1] = cache_if_resp_valid & (cache_if_resp.resp_tid.src == '1); 
  assign cache_if_resp_ready = |(cpu_if_resp_valid & cpu_if_resp_ready);
  assign cpu_if_resp[0].resp_data = cache_if_resp.resp_data;
  assign cpu_if_resp[0].resp_mask = cache_if_resp.resp_mask;
  assign cpu_if_resp[0].resp_tid = '0;
  assign cpu_if_resp[1].resp_data = cache_if_resp.resp_data;
  assign cpu_if_resp[1].resp_mask = cache_if_resp.resp_mask;
  assign cpu_if_resp[1].resp_tid = '0;

endmodule
