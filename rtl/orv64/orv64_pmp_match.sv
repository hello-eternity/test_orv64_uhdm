
module orv64_pmp_match 
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_func_pkg::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
(
  input orv64_paddr_t                                 access_base, access_bounds,
  input orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input orv64_paddr_t           [ORV64_N_PMP_CSR:0]   pmpaddr_addr,
  input logic                   [ORV64_N_PMP_CSR-1:0] do_check_perm,
  input orv64_paddr_t           [ORV64_N_PMP_CSR-1:0] napot_base_pcsr, napot_bounds_pcsr,
  input logic                   [ORV64_N_PMP_CSR-1:0] access_fail_pcsr,

  output logic                  [ORV64_N_PMP_CSR-1:0] is_range_match,
  output logic                  [ORV64_N_PMP_CSR-1:0] excp_valid_pcsr
);

  orv64_paddr_t [ORV64_N_PMP_CSR:0] pmp_base, pmp_bounds;

  logic   [ORV64_N_PMP_CSR-1:0] base_gt_pmp_bounds;
  logic   [ORV64_N_PMP_CSR-1:0] bounds_lt_pmp_base;
  logic   [ORV64_N_PMP_CSR-1:0] base_lt_pmp_base;
  logic   [ORV64_N_PMP_CSR-1:0] bounds_gt_pmp_bounds;

  generate
    for (genvar i=0; i<ORV64_N_PMP_CSR; i++) begin
      assign base_gt_pmp_bounds[i] = unsigned'(access_base) > unsigned'(pmp_bounds[i]);
      assign bounds_lt_pmp_base[i] = unsigned'(access_bounds) < unsigned'(pmp_base[i]);
      assign base_lt_pmp_base[i] = unsigned'(access_base) < unsigned'(pmp_base[i]);
      assign bounds_gt_pmp_bounds[i] = unsigned'(access_bounds) > unsigned'(pmp_bounds[i]);
    end
  endgenerate


  always_comb begin
    for (int i=0; i<ORV64_N_PMP_CSR; i++) begin
      case (pmpcfg[i].a)
        ORV64_NAPOT: begin
          pmp_base[i]  = napot_base_pcsr[i];
          pmp_bounds[i] = napot_bounds_pcsr[i];
        end
        ORV64_NA4: begin
          pmp_base[i]  = pmpaddr_addr[i+1];
          pmp_bounds[i] = pmpaddr_addr[i+1] + orv64_paddr_t'('h4 - 'h1);
        end
        default: begin
          pmp_base[i]  = pmpaddr_addr[i];
          pmp_bounds[i] = pmpaddr_addr[i+1] - orv64_paddr_t'('h1);
        end
      endcase
    end
  end

  generate
    for (genvar i=0; i<ORV64_N_PMP_CSR; i++) begin
      always_comb begin
        if ((pmpcfg[i].a == ORV64_OFF)) begin
          is_range_match[i] = '0;
          excp_valid_pcsr[i] = '0;
        end else if (base_gt_pmp_bounds[i] | bounds_lt_pmp_base[i]) begin
          is_range_match[i] = '0;
          excp_valid_pcsr[i] = '0;
        end else begin
          is_range_match[i] = '1;
          excp_valid_pcsr[i] = (access_fail_pcsr[i] & do_check_perm[i]) | (base_lt_pmp_base[i] | bounds_gt_pmp_bounds[i]);
        end
      end
    end
  endgenerate

endmodule


