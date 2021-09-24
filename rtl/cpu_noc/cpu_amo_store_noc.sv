module cpu_amo_store_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  # (
    parameter BUF_IN_DEPTH  = 2,
    parameter BUF_OUT_DEPTH = 2,
    parameter CPU_PORT_CNT  = 8,
    parameter L2_PORT_CNT   = 8
  )
  (
    //------- CPU to NoC (to L2$) amo store req interfaces
    input   logic                 cpu_amo_store_noc_req_valid  [CPU_PORT_CNT-1:0],
    output  logic                 cpu_amo_store_noc_req_ready  [CPU_PORT_CNT-1:0],
    input   cpu_cache_if_req_t    cpu_amo_store_noc_req        [CPU_PORT_CNT-1:0],

    //------- NoC to L2$ amo store req interfaces
    output  logic                 l2_amo_store_req_valid  [L2_PORT_CNT-1:0],
    input   logic                 l2_amo_store_req_ready  [L2_PORT_CNT-1:0],
    output  cpu_cache_if_req_t    l2_amo_store_req        [L2_PORT_CNT-1:0],

    input clk, rstn

    );

  // REQUEST
  // Appending REQUEST cpu_noc_id
  cpu_cache_if_req_t  cpu_noc_req_if_req_id_fixed[CPU_PORT_CNT];
  generate
    for (genvar i = 0; i < CPU_PORT_CNT; i++) begin : CPU_NOC_REQ_IF_REQ_ID_FIXED
      always_comb begin
        cpu_noc_req_if_req_id_fixed[i] = cpu_amo_store_noc_req[i];
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
        .slave_valid  (cpu_amo_store_noc_req_valid[i]),
        .slave_info   (cpu_noc_req_if_req_id_fixed[i]),
        .slave_ready  (cpu_amo_store_noc_req_ready[i]),
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

  generate
    for (genvar i = 0; i < L2_PORT_CNT; i++) begin : REQ_ARB_I_L2_PORT_CNT
      for (genvar j = 0; j < CPU_PORT_CNT; j++) begin : REQ_ARB_I_CPU_PORT_CNT
        assign req_valid_arb_i[i][j] = cpu_noc_req_if_req_valid_buf_o[j] & (cpu_noc_req_if_req_info_buf_o[j].req_paddr[CACHE_OFFSET_WIDTH +: BANK_ID_WIDTH] == i);
        assign req_info_arb_i[i][j]  = cpu_noc_req_if_req_info_buf_o[j];
      end
    end
    for (genvar i = 0; i < CPU_PORT_CNT; i++) begin : REQ_RDY_ARB_I_CPU_PORT_CNT
      logic [L2_PORT_CNT-1:0] req_ready_arb_i_tmp;
      for (genvar j = 0; j < L2_PORT_CNT; j++) begin
        assign req_ready_arb_i_tmp[j] = req_ready_arb_i[j][i];
      end
      assign cpu_noc_req_if_req_ready_buf_o[i] = |req_ready_arb_i_tmp;
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
      ) amo_store_noc_arb_u (
        .slave_valid    (req_valid_arb_i[i]),
        .slave_info     (req_info_arb_i[i]),
        .slave_ready    (req_ready_arb_i[i]),
        .master_valid   (l2_amo_store_req_valid[i]),
        .master_info    (l2_amo_store_req[i]),
        .master_ready   (l2_amo_store_req_ready[i]),
		.clk_en       	(),
        .rstn           (rstn),
        .clk            (clk));
    end : MULTI_LYR_REQ_ARBITOR
  endgenerate

endmodule
