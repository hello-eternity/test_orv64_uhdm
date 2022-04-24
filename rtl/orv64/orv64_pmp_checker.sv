// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_pmp_checker 
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_func_pkg::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
(
  // ORV CSR i/f
  input   orv64_prv_t                prv,
  input   orv64_csr_mstatus_t        mstatus,
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr,

  // PTW i/f
  input   logic                      paddr_valid,
  input   orv64_paddr_t              paddr,
  input   orv64_access_type_t        access_type,
  input   cpu_byte_mask_t            access_byte_width,
  output  logic                      excp_valid,
  output  orv64_excp_cause_t         excp_cause
);

  orv64_paddr_t                                 access_base, access_bounds; // inclusive base and bounds of memory access
  orv64_paddr_t           [ORV64_N_PMP_CSR:0]   pmpaddr_addr; // Add 1 for handling tor for cfg[0]
  logic                   [ORV64_N_PMP_CSR-1:0] excp_valid_pcsr, access_fail_pcsr;
  orv64_paddr_t           [ORV64_N_PMP_CSR-1:0] napot_base_pcsr, napot_bounds_pcsr;
  orv64_prv_t                                   effective_prv;

  assign effective_prv = (access_type == ORV64_ACCESS_FETCH) ? prv: (mstatus.MPRV ? orv64_prv_t'(mstatus.MPP): prv);

  assign pmpaddr_addr[0] = '0;
  generate
    for (genvar i=1; i<ORV64_N_PMP_CSR+1; i++) begin // Add 1 for handling tor for cfg[0]
      assign pmpaddr_addr[i] = {pmpaddr[i-1].addr, 2'b00};
    end
  endgenerate

  assign access_base = paddr;
  assign access_bounds = access_base + orv64_paddr_t'(access_byte_width-cpu_byte_mask_t'('h1));

  generate 
    for (genvar i=0; i<ORV64_N_PMP_CSR; i++) begin
      orv64_napot_addr napot_addr_u(
        .pmpaddr(pmpaddr[i]),
        .napot_base(napot_base_pcsr[i]),
        .napot_bounds(napot_bounds_pcsr[i])
      );
    end
  endgenerate

  generate 
    for (genvar i=0; i<ORV64_N_PMP_CSR; i++) begin
      orv64_perm_checker perm_checker_u (
        .perm_x(pmpcfg[i].x), 
        .perm_r(pmpcfg[i].r), 
        .perm_w(pmpcfg[i].w), 
        .access_type(access_type), 
        .mstatus(mstatus), 
        .excp_valid(access_fail_pcsr[i])
      );
    end
  endgenerate

  always_comb begin
    orv64_get_excp_perm_type (
      .access_type(access_type),
      .excp_cause(excp_cause)
    );
  end

  logic [ORV64_N_PMP_CSR-1:0] is_csr_configured, is_range_match;
  logic                       is_outside_valid_range;
  logic [$clog2(ORV64_N_PMP_CSR)-1:0] match_ptr;
  logic [ORV64_N_PMP_CSR-1:0] do_check_perm;

  generate
    for (genvar i=0; i<ORV64_N_PMP_CSR; i++) begin
      assign do_check_perm[i] = (~(effective_prv == ORV64_PRV_M) | pmpcfg[i].l);
    end
  endgenerate

  generate
    for (genvar i=0; i<ORV64_N_PMP_CSR; i++) begin
      assign is_csr_configured[i] = ~(pmpcfg[i].a == ORV64_OFF);
    end
  endgenerate
  int i ;
  always_comb begin
    match_ptr = '0;
    // for (int i=0; i<ORV64_N_PMP_CSR; i++) begin
    //   if (is_range_match[i]) begin
    //     match_ptr = i;
    //     break;
    //   end
    // end
    i=0;
    while (!(is_range_match[i]) && i<ORV64_N_PMP_CSR) begin
      i++;
    end
    if (is_range_match[i]) begin
      match_ptr = i;
    end
  end

  orv64_pmp_match pmp_matcher_u
  (
    .access_base, 
    .access_bounds,
    .pmpcfg,
    .pmpaddr_addr,
    .do_check_perm,
    .napot_base_pcsr, 
    .napot_bounds_pcsr,
    .is_range_match,
    .excp_valid_pcsr, 
    .access_fail_pcsr
  );


  assign is_outside_valid_range = ~(paddr[ORV64_PHY_ADDR_WIDTH-1:32] == '0);

  always_comb begin
    if (paddr_valid) begin
      excp_valid = excp_valid_pcsr[match_ptr] | (|is_csr_configured & ~(|is_range_match) & ~(prv == ORV64_PRV_M)) | is_outside_valid_range;
    end else begin
      excp_valid = '0;
    end
  end

endmodule
