// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_inst_buffer
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  input   orv64_if2ic_t             if2ib,
  output  orv64_ic2if_t             ib2if,
  output  orv64_ib2icmem_t          ib2ic,
  input   orv64_icmem2ib_t          ic2ib,
  input   logic                     l1_hit,
  input   logic                     l1_miss,
  output  logic                     ib_hit,
  output  logic                     ib_miss,

  input   orv64_prv_t                prv,
  input   orv64_csr_mstatus_t        mstatus,
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr,

  // L1 I$
  input   logic                     ib_flush,

  input   orv64_da2ib_t             da2ib,
  output  orv64_ib2da_t             ib2da,

  output  logic                     ib_idle,

  input logic                       rst, clk
);

  localparam L2_LINE_WIDTH = 256;
  localparam BUF_ELEMENT_SIZE = 16;
  localparam NUM_ELEMENTS_PER_LINE = L2_LINE_WIDTH/BUF_ELEMENT_SIZE;
  localparam NUM_LINES = 2;
  localparam NUM_ELEMENTS = NUM_LINES*NUM_ELEMENTS_PER_LINE;
  localparam PTR_WIDTH = $clog2(NUM_ELEMENTS);
  localparam PREFETCH_COMP_SIZE = NUM_ELEMENTS-NUM_ELEMENTS_PER_LINE;
  localparam LINE_PTR_WIDTH = $clog2(NUM_LINES);

  typedef logic [LINE_PTR_WIDTH-1:0]   ibuf_line_ptr_t;
  typedef logic [PTR_WIDTH-1:0]        ibuf_ptr_t;
  typedef logic [PTR_WIDTH:0]          ibuf_size_t;
  typedef logic [BUF_ELEMENT_SIZE-1:0] ibuf_element_t;

  ibuf_element_t       [NUM_ELEMENTS-1:0] dff_inst_buffer;
  logic                [NUM_LINES-1:0]    dff_excp_valid;
  orv64_excp_cause_t   [NUM_LINES-1:0]    dff_excp_cause;
  orv64_paddr_t        [NUM_LINES-1:0]    dff_base_pc;

  ibuf_size_t rff_ibuf_size, pop_size, push_size;

  ibuf_ptr_t rff_pop_ptr, next_pop_ptr, pop_ptr_second_half;
  ibuf_ptr_t rff_push_ptr, next_push_ptr;

  ibuf_line_ptr_t push_line_ptr, pop_line_ptr, pop_line_ptr_second_half;

  logic         do_flush;

  //==========================================================
  // ICG {{{

  logic en_buf;

  logic ib2ic_pc_clkg;
  logic buf_clkg;
  logic prev_pc_clkg;

  assign en_buf = ic2ib.valid & ~do_flush;

  icg prev_pc_clk_u(
    .en       (ib2ic.en),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (prev_pc_clkg)
  );

  icg buf_clk_u(
    .en       (en_buf),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (buf_clkg)
  );

  icg ib2ic_pc_clk_u(
    .en       (ib2ic.en),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (ib2ic_pc_clkg)
  );

  // }}}

  //==========================================================
  // IF IB Handshake {{{

  logic         do_fence;
  logic         rff_ib_has_req;
  orv64_vaddr_t dff_req_vpc;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_ib_has_req <= '0;
    end else begin
      rff_ib_has_req <= if2ib.en;
    end
  end

  always_ff @(posedge clk) begin
    if (if2ib.en & (~rff_ib_has_req | ib2if.valid)) begin
      dff_req_vpc <= if2ib.pc;
    end
  end

  // }}}

  //==========================================================
  // Size {{{

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_ibuf_size <= '0;
    end else begin
      if (do_flush) begin
        rff_ibuf_size <= '0;
      end else begin
        rff_ibuf_size <= rff_ibuf_size - pop_size + push_size;
      end
    end
  end

  // }}}

  //==========================================================
  // Buffer pop logic {{{

  //----------------------------------------------------------
  // Valid instruction check

  logic           is_ibuf_empty;
  logic           is_first_valid, is_second_valid;
  logic           is_first_rvc;
  logic           has_full_inst;
  ibuf_element_t  first_element, second_element;

  assign is_ibuf_empty = (rff_ibuf_size == '0);
  assign is_first_valid = ~is_ibuf_empty;
  assign is_second_valid = ~((rff_ibuf_size == ibuf_size_t'('0)) | (rff_ibuf_size == ibuf_size_t'('h1)));

 
  assign first_element = dff_inst_buffer[rff_pop_ptr];
  assign second_element = dff_inst_buffer[pop_ptr_second_half];
  assign is_first_rvc = (first_element[1:0] != 2'b11);

  assign has_full_inst = is_first_valid & (is_first_rvc | is_second_valid);

  //----------------------------------------------------------
  // PC predict check

  logic   is_predict_miss, is_predict_hit;
  logic         rff_predict_vpc_valid;
  orv64_vaddr_t dff_predict_vpc;
  orv64_vaddr_t miss_pc;
  logic         sending_miss_req;

  assign is_predict_miss = rff_ib_has_req & (~rff_predict_vpc_valid | ~(dff_predict_vpc == dff_req_vpc));
  assign is_predict_hit = rff_ib_has_req & (rff_predict_vpc_valid & (dff_predict_vpc == dff_req_vpc)) & has_full_inst;

  assign miss_pc = dff_req_vpc;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_predict_vpc_valid <= '0;
    end else begin
      if (rff_predict_vpc_valid) begin
        rff_predict_vpc_valid <= (~is_predict_miss | sending_miss_req) & ~do_fence;
      end else begin
        rff_predict_vpc_valid <= sending_miss_req;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (is_predict_miss) begin
      dff_predict_vpc <= dff_req_vpc;
    end else if (ib2if.valid) begin
      dff_predict_vpc <= dff_req_vpc + (is_first_rvc ? 'h2: 'h4);
    end
  end

  //----------------------------------------------------------
  // Instruction buffer response

  logic              is_half1_excp, is_half2_excp;
  logic              pmp_excp_valid;
  orv64_excp_cause_t pmp_excp_cause;

  assign is_half1_excp = dff_excp_valid[pop_line_ptr];
  assign is_half2_excp = is_first_rvc ? '0: dff_excp_valid[pop_line_ptr_second_half];

  assign ib2if.valid = is_predict_hit;
  assign ib2if.inst = is_first_rvc ? {16'h0000, first_element}: {second_element, first_element};
  assign ib2if.is_rvc = is_first_rvc;

  // Need to pass correct paddr on exceptions. Can be caused by 1st half or 2nd half of instruction
  always_comb begin
    if (is_half1_excp) begin
      ib2if.is_half1_excp = '1;
      ib2if.excp_valid = '1;
      ib2if.excp_cause = dff_excp_cause[pop_line_ptr];
    end else if (is_half2_excp) begin
      ib2if.is_half1_excp = '0;
      ib2if.excp_valid = '1;
      ib2if.excp_cause = dff_excp_cause[pop_line_ptr_second_half];
    end else if (pmp_excp_valid) begin
      ib2if.is_half1_excp = '1;
      ib2if.excp_valid = '1;
      ib2if.excp_cause = pmp_excp_cause;
    end else begin
      ib2if.is_half1_excp = '0;
      ib2if.excp_valid = '0;
      ib2if.excp_cause = ORV64_EXCP_CAUSE_INST_ADDR_MISALIGNED;
    end
  end

  //----------------------------------------------------------
  // Update pop ptr

  assign next_pop_ptr = rff_pop_ptr + ibuf_ptr_t'(is_first_rvc ? 'h1: 'h2);
  assign pop_ptr_second_half = rff_pop_ptr + ibuf_ptr_t'('h1);

  assign pop_size = (ib2if.valid) ? ibuf_size_t'(is_first_rvc ? 'h1: 'h2): '0;

  assign pop_line_ptr = rff_pop_ptr[PTR_WIDTH-1 -: LINE_PTR_WIDTH];
  assign pop_line_ptr_second_half = pop_ptr_second_half[PTR_WIDTH-1 -: LINE_PTR_WIDTH];

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_pop_ptr <= '0;
    end else begin
      if (~rff_ib_has_req & do_fence) begin
        rff_pop_ptr <= '0;
      end else if (is_predict_miss) begin
        rff_pop_ptr <= ibuf_ptr_t'(miss_pc[OFFSET_WIDTH-1:1]);
      end else if (ib2if.valid) begin
        rff_pop_ptr <= next_pop_ptr;
      end
    end
  end

  // }}}

  //==========================================================
  // Buffer push logic {{{

  //----------------------------------------------------------
  // Save last fetched pc

  orv64_vaddr_t prefetch_pc;
  orv64_vaddr_t dff_prev_fetch_pc;
  orv64_vaddr_t next_cache_line;

  assign next_cache_line = {{($bits(orv64_vaddr_t)-OFFSET_WIDTH-1){1'b0}}, 1'b1, {OFFSET_WIDTH{1'b0}}};

  assign prefetch_pc = {dff_prev_fetch_pc[$bits(orv64_vaddr_t)-1: OFFSET_WIDTH], {OFFSET_WIDTH{1'b0}}} + next_cache_line;

  always_ff @(posedge prev_pc_clkg) begin
    if (ib2ic.en) begin
      dff_prev_fetch_pc <= ib2ic.pc;
    end
  end

  //----------------------------------------------------------
  // Update instruction buffer

  assign push_line_ptr = rff_push_ptr[PTR_WIDTH-1 -: LINE_PTR_WIDTH];

  always_ff @(posedge buf_clkg) begin
    if (en_buf) begin
      dff_excp_valid[push_line_ptr] <= ic2ib.excp_valid;
      dff_excp_cause[push_line_ptr] <= ic2ib.excp_cause;
      dff_base_pc[push_line_ptr] <= ic2ib.pc_paddr;
      for (int i=0; i<NUM_ELEMENTS_PER_LINE; i++) begin
        dff_inst_buffer[rff_push_ptr+i] <= ic2ib.rdata[i*BUF_ELEMENT_SIZE +: BUF_ELEMENT_SIZE];
      end
    end
  end

  //----------------------------------------------------------
  // Update push ptr

  assign push_size = ibuf_size_t'((ic2ib.valid & ~do_flush) ? ((next_cache_line >> 1) - dff_prev_fetch_pc[OFFSET_WIDTH-1:1]): '0);

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_push_ptr <= '0;
    end else begin
      if (do_flush) begin
        rff_push_ptr <= '0;
      end else if (ic2ib.valid) begin
        rff_push_ptr <= rff_push_ptr + ibuf_ptr_t'(NUM_ELEMENTS_PER_LINE);
      end
    end
  end

  // }}}

  //==========================================================
  // IC req/resp logic {{{

  logic           do_save_ic_req;
  logic           do_use_saved_ic_req;
  orv64_vaddr_t   dff_saved_req_vpc;
  logic           do_prefetch;
  logic           is_space_for_fetch;
  logic           do_hold_ib2ic;
  logic           rff_ib2ic_en;

  assign do_hold_ib2ic = rff_ib2ic_en & ~ic2ib.valid;

  assign is_space_for_fetch = (rff_ibuf_size <= ibuf_size_t'(PREFETCH_COMP_SIZE));
  assign do_prefetch = is_space_for_fetch & rff_predict_vpc_valid;

  assign ib2ic.en = rff_ib2ic_en ? ~ic2ib.valid: (is_predict_miss | do_prefetch) & ~do_fence;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_ib2ic_en <= '0;
    end else begin
      rff_ib2ic_en <= ib2ic.en;
    end
  end

  always_ff @(posedge ib2ic_pc_clkg) begin
    if (ib2ic.en) begin
      dff_saved_req_vpc <= ib2ic.pc;
    end
  end

  always_comb begin
    if (do_hold_ib2ic) begin
      ib2ic.pc = dff_saved_req_vpc;
      sending_miss_req = '0;
    end else begin
      if (is_predict_miss) begin
        ib2ic.pc = miss_pc;
        sending_miss_req = ib2ic.en;
      end else begin
        ib2ic.pc = prefetch_pc;
        sending_miss_req = '0;
      end
    end
  end

  // }}}

  //==========================================================
  // Fence {{{

  logic     rff_is_fence;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_is_fence <= '0;
    end else begin
      if (rff_is_fence) begin
        rff_is_fence <= ~(~ib2ic.en & (rff_ibuf_size == '0));
      end else begin
        rff_is_fence <= ib_flush;
      end
    end
  end

  assign ib_idle = ~do_hold_ib2ic & ~rff_ib_has_req;

  assign do_fence = rff_is_fence | ib_flush;

  assign do_flush = do_fence | is_predict_miss;

  // }}}

  //==========================================================
  // Hit miss logic {{{

  logic temp_ib_hit;
  logic rff_first_req_cyc;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_first_req_cyc <= '0;
    end else begin
      if (rff_ib_has_req) begin
        rff_first_req_cyc <= ib2if.valid & if2ib.en;
      end else begin
        rff_first_req_cyc <= if2ib.en;
      end
    end
  end

  assign temp_ib_hit  = ib2if.valid & rff_first_req_cyc;
  assign ic_hit  = ~has_full_inst & ic2ib.valid & l1_hit;
  assign ic_miss = ~has_full_inst & ic2ib.valid & l1_miss;

  assign ib_miss = rff_ib_has_req & ic_miss & ~do_flush;
  assign ib_hit  = rff_ib_has_req & (temp_ib_hit | (ic_hit & ~do_flush));

  // }}}

  //==========================================================
  // PMP check {{{

  logic                      paddr_valid;
  orv64_paddr_t              paddr;
  orv64_access_type_t        access_type;
  cpu_byte_mask_t            access_byte_width;

  assign paddr_valid = ib2if.valid;
  assign paddr = {dff_base_pc[pop_line_ptr][ORV64_PHY_ADDR_WIDTH-1:OFFSET_WIDTH], dff_req_vpc[OFFSET_WIDTH-1:0]};
  assign access_type = ORV64_ACCESS_FETCH;
  assign access_byte_width = ib2if.is_rvc ? 'h2: 'h4;

  orv64_pmp_checker pmp_checker_u
  (
    .prv,
    .mstatus,
    .pmpcfg, 
    .pmpaddr,
    .paddr_valid,
    .paddr,
    .access_type,
    .access_byte_width,
    .excp_valid(pmp_excp_valid),
    .excp_cause(pmp_excp_cause)
  );

  // }}}


endmodule
