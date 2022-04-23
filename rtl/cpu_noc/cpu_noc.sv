module cpu_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  # (
    parameter BUF_IN_DEPTH  = 2,
    parameter BUF_OUT_DEPTH = 2,
    parameter CPU_PORT_CNT  = 7,
    parameter L2_PORT_CNT   = 4
  )
  (
    //------- CPU to NoC (to L2$) req interfaces
    //cpu_cache_if.slave  cpu_noc[CPU_PORT_CNT],
    input   logic                 cpu_noc_req_if_req_valid  [CPU_PORT_CNT-1:0],
    output  logic                 cpu_noc_req_if_req_ready  [CPU_PORT_CNT-1:0],
    input   cpu_cache_if_req_t    cpu_noc_req_if_req        [CPU_PORT_CNT-1:0],

    output  logic                 noc_cpu_resp_if_resp_valid [CPU_PORT_CNT-1:0],
    input   logic                 noc_cpu_resp_if_resp_ready [CPU_PORT_CNT-1:0],
    output  cpu_cache_if_resp_t   noc_cpu_resp_if_resp       [CPU_PORT_CNT-1:0],

    //------- NoC to L2$ req interfaces
    //cpu_cache_if.master  noc_l2_if[L2_PORT_CNT] 
    output  logic                 noc_l2_req_valid  [L2_PORT_CNT-1:0],
    input   logic                 noc_l2_req_ready  [L2_PORT_CNT-1:0],
    output  cpu_cache_if_req_t    noc_l2_req        [L2_PORT_CNT-1:0],

    input   logic                 l2_noc_resp_valid [L2_PORT_CNT-1:0],
    output  logic                 l2_noc_resp_ready [L2_PORT_CNT-1:0],
    input   cpu_cache_if_resp_t   l2_noc_resp       [L2_PORT_CNT-1:0],

    //------- CPU to NoC (to L2$) amo store req interfaces
    input   logic                 cpu_amo_store_noc_req_valid  [CPU_PORT_CNT-1:0],
    output  logic                 cpu_amo_store_noc_req_ready  [CPU_PORT_CNT-1:0],
    input   cpu_cache_if_req_t    cpu_amo_store_noc_req        [CPU_PORT_CNT-1:0],

    //------- NoC to L2$ amo store req interfaces
    output  logic                 l2_amo_store_req_valid  [L2_PORT_CNT-1:0],
    input   logic                 l2_amo_store_req_ready  [L2_PORT_CNT-1:0],
    output  cpu_cache_if_req_t    l2_amo_store_req        [L2_PORT_CNT-1:0],

    //------- USB AR request age info
    input   logic [L2_PORT_CNT-1:0] 	  entry_vld_pbank,
    input   logic [L2_PORT_CNT-1:0] 	  is_oldest_pbank,

    input   logic clk,
    input   logic rstn

    );

  // atomic store channel to unlock l2 bank
  cpu_amo_store_noc #(.BUF_IN_DEPTH(BUF_IN_DEPTH), 
                      .BUF_OUT_DEPTH(BUF_OUT_DEPTH), 
                      .CPU_PORT_CNT(CPU_PORT_CNT), 
                      .L2_PORT_CNT(L2_PORT_CNT)) 
  amo_store_noc (
    .cpu_amo_store_noc_req_valid,
    .cpu_amo_store_noc_req_ready,
    .cpu_amo_store_noc_req,
    .l2_amo_store_req_valid,
    .l2_amo_store_req_ready,
    .l2_amo_store_req,
    .clk, 
    .rstn
    );

  // REQUEST
  // Appending REQUEST cpu_noc_id
  cpu_cache_if_req_t  cpu_noc_req_if_req_id_fixed[CPU_PORT_CNT];
  generate
    for (genvar i = 0; i < CPU_PORT_CNT; i++) begin : CPU_NOC_REQ_IF_REQ_ID_FIXED
      always_comb begin
        cpu_noc_req_if_req_id_fixed[i] = cpu_noc_req_if_req[i];
        cpu_noc_req_if_req_id_fixed[i].req_tid.cpu_noc_id = i;
      end
    end
  endgenerate

  // Request Buffer
  logic               [CPU_PORT_CNT-1:0] cpu_noc_req_if_req_valid_buf_o;
  cpu_cache_if_req_t  [CPU_PORT_CNT-1:0] cpu_noc_req_if_req_info_buf_o ;
  logic               [CPU_PORT_CNT-1:0] cpu_noc_req_if_req_ready_buf_o;

  generate
    for (genvar i = 0; i < CPU_PORT_CNT; i++) begin : REQ_IN_BUFFER
      ours_vld_rdy_buf #(.WIDTH($bits(cpu_cache_if_req_t)), .DEPTH(BUF_IN_DEPTH)) req_buf_u (
        .slave_valid  (cpu_noc_req_if_req_valid[i]),
        .slave_info   (cpu_noc_req_if_req_id_fixed[i]),
        .slave_ready  (cpu_noc_req_if_req_ready[i]),
        .master_valid (cpu_noc_req_if_req_valid_buf_o[i]),
        .master_info  (cpu_noc_req_if_req_info_buf_o[i]),
        .master_ready (cpu_noc_req_if_req_ready_buf_o[i]),
        .clk_en       (),
        .rstn         (rstn),
        .clk          (clk));
    end
  endgenerate

  logic               [CPU_PORT_CNT-1:0] req_valid_arb_i[L2_PORT_CNT];
  cpu_cache_if_req_t  [CPU_PORT_CNT-1:0] req_info_arb_i [L2_PORT_CNT];
  logic               [CPU_PORT_CNT-1:0] req_ready_arb_i[L2_PORT_CNT];
  logic               [L2_PORT_CNT-1:0] req_ready_arb_i_tmp[CPU_PORT_CNT];

  generate
    for (genvar i = 0; i < L2_PORT_CNT; i++) begin : REQ_ARB_I_L2_PORT_CNT
      for (genvar j = 0; j < CPU_PORT_CNT; j++) begin : REQ_ARB_I_CPU_PORT_CNT
        assign req_valid_arb_i[i][j] = cpu_noc_req_if_req_valid_buf_o[j] & (cpu_noc_req_if_req_info_buf_o[j].req_paddr[CACHE_OFFSET_WIDTH +: BANK_ID_WIDTH] == i);
        assign req_info_arb_i[i][j]  = cpu_noc_req_if_req_info_buf_o[j];
      end
    end
    for (genvar i = 0; i < CPU_PORT_CNT; i++) begin : REQ_RDY_ARB_I_CPU_PORT_CNT
      for (genvar j = 0; j < L2_PORT_CNT; j++) begin
        assign req_ready_arb_i_tmp[i][j] = req_ready_arb_i[j][i];
      end
      assign cpu_noc_req_if_req_ready_buf_o[i] = |req_ready_arb_i_tmp[i];
    end
  endgenerate

  generate
    for (genvar i = 0; i < L2_PORT_CNT; i++) begin : MULTI_LYR_REQ_ARBITOR
      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT        (CPU_PORT_CNT),
        .WIDTH          ($bits(cpu_cache_if_req_t)),
        .BUF_IN_DEPTH   (0),
        .BUF_OUT_DEPTH  (BUF_OUT_DEPTH),
        .BUF_MID_DEPTH  (2),
        .ARB_MAX_N_PORT (4)
      ) multi_lyr_req_arb_u (
        .slave_valid    (req_valid_arb_i[i]),
        .slave_info     (req_info_arb_i[i]),
        .slave_ready    (req_ready_arb_i[i]),
        .master_valid   (noc_l2_req_valid[i]),
        .master_info    (noc_l2_req[i]),
        .master_ready   (noc_l2_req_ready[i]),
        .clk_en         (),
        .rstn           (rstn),
        .clk            (clk));
    end : MULTI_LYR_REQ_ARBITOR
  endgenerate

  // RESPONSE
  // Response Buffer
  logic               [L2_PORT_CNT-1:0] l2_noc_resp_valid_buf_o;
  cpu_cache_if_resp_t [L2_PORT_CNT-1:0] l2_noc_resp_info_buf_o ;
  logic               [L2_PORT_CNT-1:0] l2_noc_resp_ready_buf_o;

  logic               [L2_PORT_CNT-1:0] l2_noc_resp_valid_new;
  logic               [L2_PORT_CNT-1:0] l2_noc_resp_ready_new;
  cpu_cache_if_resp_t [L2_PORT_CNT-1:0] l2_noc_resp_info_new;
  logic               [L2_PORT_CNT-1:0] l2_noc_resp_valid_final;
  logic               [L2_PORT_CNT-1:0] l2_noc_resp_ready_final;

  generate
    for (genvar i = 0; i < L2_PORT_CNT; i++) begin : RESP_IN_BUFFER
      ours_vld_rdy_buf #(.WIDTH($bits(cpu_cache_if_resp_t)), .DEPTH(2)) resp_flow_ctrl_buf_u (
        .slave_valid  (l2_noc_resp_valid[i]),
        .slave_info   (l2_noc_resp[i]),
        .slave_ready  (l2_noc_resp_ready[i]),
        .master_valid (l2_noc_resp_valid_new[i]),
        .master_info  (l2_noc_resp_info_new[i]),
        .master_ready (l2_noc_resp_ready_new[i]),
        .clk_en       (),
        .rstn         (rstn),
        .clk          (clk));

    // check if resp to usb
    // l2_noc_resp.resp_tid.cpu_noc_id == (CPU_PORT_ID_WIDTH)'(6)) and is_oldest_pbank[i] => assert ready back to l2
    assign l2_noc_resp_valid_final[i] = l2_noc_resp_valid_new[i] & ((l2_noc_resp_info_new[i].resp_tid.cpu_noc_id != (CPU_PORT_ID_WIDTH)'(6)) | is_oldest_pbank[i]); 
    assign l2_noc_resp_ready_new[i] = l2_noc_resp_ready_final[i] & (~(entry_vld_pbank[i] & (l2_noc_resp_info_new[i].resp_tid.cpu_noc_id == (CPU_PORT_ID_WIDTH)'(6))) | is_oldest_pbank[i]);
      ours_vld_rdy_buf #(.WIDTH($bits(cpu_cache_if_resp_t)), .DEPTH(BUF_IN_DEPTH)) resp_buf_u (
        .slave_valid  (l2_noc_resp_valid_final[i]),
        .slave_info   (l2_noc_resp_info_new[i]),
        .slave_ready  (l2_noc_resp_ready_final[i]),
        .master_valid (l2_noc_resp_valid_buf_o[i]),
        .master_info  (l2_noc_resp_info_buf_o[i]),
        .master_ready (l2_noc_resp_ready_buf_o[i]),
        .clk_en       (),
        .rstn         (rstn),
        .clk          (clk));
    end
  endgenerate

  logic               [L2_PORT_CNT-1:0] rsp_valid_arb_i[CPU_PORT_CNT];
  cpu_cache_if_resp_t [L2_PORT_CNT-1:0] rsp_info_arb_i [CPU_PORT_CNT];
  logic               [L2_PORT_CNT-1:0] rsp_ready_arb_i[CPU_PORT_CNT];

  generate
    for (genvar i = 0; i < CPU_PORT_CNT; i++) begin : RSP_ARB_I_CPU_PORT_CNT
      for (genvar j = 0; j < L2_PORT_CNT; j++) begin : RSP_ARB_I_L2_PORT_CNT
        assign rsp_valid_arb_i[i][j] = l2_noc_resp_valid_buf_o[j] & (l2_noc_resp_info_buf_o[j].resp_tid.cpu_noc_id == i);
        assign rsp_info_arb_i[i][j]  = l2_noc_resp_info_buf_o[j];
      end
    end
    for (genvar i = 0; i < L2_PORT_CNT; i++) begin : RSP_RDY_ARB_I_L2_PORT_CNT
      logic [CPU_PORT_CNT-1:0] rsp_ready_arb_i_tmp;
      for (genvar j = 0; j < CPU_PORT_CNT; j++) begin
        assign rsp_ready_arb_i_tmp[j] = rsp_ready_arb_i[j][i];
      end
      assign l2_noc_resp_ready_buf_o[i] = |rsp_ready_arb_i_tmp;
    end
  endgenerate

  generate
    for (genvar i = 0; i < CPU_PORT_CNT; i++) begin : MULTI_LYR_RSP_ARBITOR
      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT        (L2_PORT_CNT),
        .WIDTH          ($bits(cpu_cache_if_resp_t)),
        .BUF_IN_DEPTH   (0),
        .BUF_OUT_DEPTH  (BUF_OUT_DEPTH),
        .BUF_MID_DEPTH  (2),
        .ARB_MAX_N_PORT (4)
      ) multi_lyr_rsp_arb_u (
        .slave_valid    (rsp_valid_arb_i[i]),
        .slave_info     (rsp_info_arb_i[i]),
        .slave_ready    (rsp_ready_arb_i[i]),
        .master_valid   (noc_cpu_resp_if_resp_valid[i]),
        .master_info    (noc_cpu_resp_if_resp[i]),
        .master_ready   (noc_cpu_resp_if_resp_ready[i]),
        .clk_en         (),
        .rstn           (rstn),
        .clk            (clk));
    end : MULTI_LYR_RSP_ARBITOR
  endgenerate

endmodule
