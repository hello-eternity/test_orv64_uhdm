// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
`ifndef __ORV_PTW_CORE__SV__
`define __ORV_PTW_CORE__SV__

module orv64_ptw_core
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
# (
  parameter SRC_ID       = 0
)
(
  // CSR
  input   orv64_csr_satp_t      satp,
  input   orv64_csr_mstatus_t   mstatus,
  input   orv64_prv_t           prv,

  // PMA 

  // PMP
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr,

  // TLB i/f
  input   logic          tlb2ptw_valid,
  input   orv64_tlb_ptw_if_req_t      tlb2ptw,
  output  logic          ptw2tlb_ready,

  output  logic          ptw2tlb_valid,
  output  orv64_tlb_ptw_if_resp_t      ptw2tlb,
  input   logic          tlb2ptw_ready,

  // L2$ i/f
  output logic              cache_if_req_valid, 
  output cpu_cache_if_req_t cache_if_req, 
  input logic               cache_if_req_ready, 

  input logic               cache_if_resp_valid, 
  input cpu_cache_if_resp_t cache_if_resp, 
  output logic              cache_if_resp_ready,

  // rst & clk
  input   logic           rstn, clk
);

  localparam PTE_SEL_WIDTH = $clog2((CPU_DATA_WIDTH/ORV64_PTE_WIDTH));

  enum logic [2:0] {
    ST_PTE_REQ       = 3'b000, // send read req to L2
    ST_PTE_RESP      = 3'b001, // check PTE read back from L2
    ST_PTE_WB        = 3'b010, // send pte to L2 for write-back
    ST_PTE_WB_RESP   = 3'b011, // receive writeback response
    ST_PTE_RETURN    = 3'b100, // return pte back to tlb
    ST_PAGE_FAULT    = 3'b101, // checking PTE gives page fault
    ST_READY         = 3'b111  // default state, ready to receive request
  } rff_state, next_state;

  orv64_ptw_lvl_t           rff_lvl, next_lvl;
  orv64_ppn_t               dff_pd_base_addr, next_pd_base_addr; // Base address of page directory
  logic                     rff_excp_valid, next_excp_valid;
  orv64_excp_cause_t        rff_excp_cause, next_excp_cause;

  orv64_paddr_t             pte_req_addr;
  orv64_pte_idx_t           pte_idx;
  orv64_tlb_ptw_if_req_t    dff_tlb2ptw;

  logic                     pma_pmp_check_req_valid;
  logic                     do_update_pd_base_addr;

  // L2 signals
  orv64_pte_t               dff_pte, pte;
  logic [PTE_SEL_WIDTH-1:0] dff_pte_sel;

  // PTE check signals
  logic                     pte_is_valid, pte_is_leaf, pte_is_page_fault;
  logic                     pmp_excp_valid, pma_excp_valid;
  orv64_excp_cause_t        pmp_excp_cause, pma_excp_cause;

  //==========================================================
  // ICG {{{

  logic en_tlb2ptw, en_dff_pte_clk;
  logic base_addr_clkg, tlb_clkg, pte_clkg;

  assign en_dff_pte_clk = (rff_state == ST_PTE_RESP) & cache_if_resp_valid & pte_is_leaf;
  assign en_tlb2ptw = tlb2ptw_valid & ptw2tlb_ready;

  icg base_addr_clk_u(
    .en       (do_update_pd_base_addr),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (base_addr_clkg)
  );

  icg tlb_clk_u(
    .en       (en_tlb2ptw),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (tlb_clkg)
  );

  icg pte_clk_u(
    .en       (en_dff_pte_clk),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (pte_clkg)
  );

  // }}}

  assign pte = orv64_pte_t'(cache_if_resp.resp_data[dff_pte_sel*ORV64_PTE_WIDTH +: ORV64_PTE_WIDTH]);

  always_ff @ (posedge clk) begin
    if (~rstn) begin
      rff_state <= ST_READY;
      rff_lvl <= '0;
      rff_excp_valid <= '0;
      rff_excp_cause <= ORV64_EXCP_CAUSE_NONE;
    end else begin
      rff_state <= next_state;
      rff_lvl <= next_lvl;
      rff_excp_valid <= next_excp_valid;
      rff_excp_cause <= next_excp_cause;
    end
  end

  always_ff @(posedge base_addr_clkg) begin
    if (do_update_pd_base_addr) begin
      dff_pd_base_addr <= next_pd_base_addr;
    end
  end

  always_ff @ (posedge tlb_clkg) begin
    if (en_tlb2ptw) begin
      dff_tlb2ptw <= tlb2ptw;
    end
  end

  always_ff @ (posedge pte_clkg) begin
    if (en_dff_pte_clk) begin
      dff_pte <= pte;
    end
  end

  always_ff @ (posedge clk) begin
    if (cache_if_req_valid & cache_if_req_ready) begin
      dff_pte_sel <= pte_req_addr[ORV64_PTE_OFFSET_WIDTH +: PTE_SEL_WIDTH];
    end
  end

  //==========================================================
  // TLB interface {{{

  assign ptw2tlb_valid = (rff_state == ST_PTE_RETURN);
  assign ptw2tlb_ready = (rff_state == ST_READY);
  assign ptw2tlb.resp_pte = dff_pte;
  assign ptw2tlb.resp_lvl = rff_lvl;
  assign ptw2tlb.resp_excp_valid = rff_excp_valid;
  assign ptw2tlb.resp_excp_cause = rff_excp_cause;

  assign pma_excp_valid = '0; // TODO: implement pma check

  ppn_part_t [ORV64_NUM_PAGE_LEVELS-1:0] ppn_parts;
  generate
    for (genvar i=0; i<ORV64_NUM_PAGE_LEVELS; i++) begin
      assign ppn_parts[i] = pte.ppn[($bits(ppn_part_t)*i)+:$bits(ppn_part_t)]; 
    end
  endgenerate

  //==========================================================
  // FSM Logic {{{
  always_comb begin
    next_state = rff_state;
    next_lvl = rff_lvl;
    next_pd_base_addr = dff_pd_base_addr;
    next_excp_valid = rff_excp_valid;
    next_excp_cause = rff_excp_cause;

    do_update_pd_base_addr = '0;
    case (rff_state)
      ST_READY: begin // ST_READY
        if (tlb2ptw_valid) begin
          next_lvl = ORV64_NUM_PAGE_LEVELS-1;
          next_pd_base_addr = satp.ppn;
          do_update_pd_base_addr = '1;
          next_state = ST_PTE_REQ;
        end
      end
      ST_PTE_REQ: begin
        if (pmp_excp_valid) begin
          next_excp_valid = '1;
          orv64_get_excp_perm_type(.access_type(dff_tlb2ptw.req_access_type), .excp_cause(next_excp_cause));
          next_state = ST_PTE_RETURN;
        end else if (cache_if_req_ready) begin
          next_state = ST_PTE_RESP;
        end
      end
      ST_PTE_RESP: begin
        if (cache_if_resp_valid) begin
          if (pte_is_leaf) begin
            next_state = ST_PTE_RETURN;
            for (int i=0; i<rff_lvl; i++) begin // superpage
              if (ppn_parts[i] != '0) begin
                next_excp_valid = '1;
                orv64_get_fault_type(.access_type(dff_tlb2ptw.req_access_type), .excp_cause(next_excp_cause));
              end
            end
          end else begin // not leaf
            if (rff_lvl == '0) begin // have traversed all levels
              next_excp_valid = '1;
              orv64_get_fault_type(.access_type(dff_tlb2ptw.req_access_type), .excp_cause(next_excp_cause));
              next_state = ST_PTE_RETURN;
            end else begin
              next_lvl = rff_lvl - {{(ORV64_PTW_LVL_CNT_WIDTH-1){1'b0}}, 1'b1};
              next_pd_base_addr = pte.ppn;
              do_update_pd_base_addr = '1;
              next_state = ST_PTE_REQ;
            end
          end

          if (pte_is_page_fault) begin
            next_excp_valid = '1;
            orv64_get_fault_type(.access_type(dff_tlb2ptw.req_access_type), .excp_cause(next_excp_cause));
            next_state = ST_PTE_RETURN;
          end
        end
      end
      ST_PTE_RETURN: begin
        if (tlb2ptw_ready) begin
          next_excp_valid = '0;
          next_state = ST_READY;
        end
      end
      default: begin
        next_excp_valid = '0;
        next_state = ST_READY;
      end
    endcase
  end

  // }}}

  //==========================================================
  // L2 interface {{{

  assign cache_if_req_valid = (rff_state == ST_PTE_REQ) & ~pmp_excp_valid;
  assign cache_if_resp_ready = (rff_state == ST_PTE_RESP);

  assign pte_idx = (dff_tlb2ptw.req_vpn[(rff_lvl*ORV64_VPN_PART_WIDTH) +: ORV64_VPN_PART_WIDTH]);
  assign pte_req_addr = {dff_pd_base_addr, pte_idx, {ORV64_PTE_OFFSET_WIDTH{1'b0}}};

  assign cache_if_req.req_paddr = pte_req_addr;
  assign cache_if_req.req_data = '0;
  assign cache_if_req.req_mask = '0;
  assign cache_if_req.req_tid.cpu_noc_id = '0;
  assign cache_if_req.req_tid.src = CPUNOC_TID_SRCID_SIZE'(SRC_ID);
  assign cache_if_req.req_tid.tid = '0;
  assign cache_if_req.req_type = REQ_READ;

  // }}}

  //==========================================================
  // check PTE {{{

  assign pma_pmp_check_req_valid = (rff_state == ST_PTE_REQ);

  always_comb begin
    pte_is_valid = '0;
    pte_is_leaf = '0;
    pte_is_page_fault = '0;
    if ((rff_state == ST_PTE_RESP) & (cache_if_resp_valid)) begin
      if (~pte.valid | (~pte.perm_r & pte.perm_w)) begin
        pte_is_page_fault = '1;
      end else begin
        pte_is_valid = '1;
        if (pte.perm_r | pte.perm_x) begin
          pte_is_leaf = '1;
        end
      end
    end
    if (pte_is_leaf & ~pte_is_page_fault) begin // Accessed and dirty bit checking
      pte_is_page_fault = ~pte.accessed | (~pte.dirty & (dff_tlb2ptw.req_access_type == ORV64_ACCESS_STORE));
    end
  end

  orv64_pmp_checker pmp_check_u 
  (
    .prv,
    .mstatus,
    .pmpcfg, 
    .pmpaddr,
  
    // PTW i/f
    .paddr_valid(pma_pmp_check_req_valid),
    .paddr({16'h0, cache_if_req.req_paddr}),
    .access_type(dff_tlb2ptw.req_access_type),
    .access_byte_width(cpu_byte_mask_t'(ORV64_PTE_WIDTH/8)),
    .excp_valid(pmp_excp_valid),
    .excp_cause(pmp_excp_cause)
  );

  // PMA checker
  // }}}

endmodule

`endif
