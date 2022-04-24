// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_napot_addr
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
(
  input  orv64_csr_pmpaddr_t  pmpaddr,

  output orv64_paddr_t        napot_base,
  output orv64_paddr_t        napot_bounds
);

  orv64_paddr_t temp_napot_base, temp_napot_bounds;
  orv64_paddr_t pmpaddr_addr;
  logic         is_no_zeros;
  logic [$clog2(ORV64_PHY_ADDR_WIDTH)-1:0] ptr;

  assign pmpaddr_addr = orv64_paddr_t'({pmpaddr.addr, 2'b11});

  assign is_no_zeros = &pmpaddr_addr;
  int i ;
  always_comb begin
    ptr = '0;
    // for (int i=0; i<$bits(pmpaddr_addr); i++) begin
    //   if (pmpaddr_addr[i] == 1'b0) begin
    //     ptr = i;
    //     break;
    //   end
    // end
    i=0;
    while (!(pmpaddr_addr[i] == 1'b0) && i<$bits(pmpaddr_addr)) begin
      i++;
    end
    if (pmpaddr_addr[i] == 1'b0) begin
      ptr = i;
    end
  end

  generate
    for (genvar i=0; i<ORV64_PHY_ADDR_WIDTH; i++) begin
      assign temp_napot_base[i] = (i <= ptr) ? 1'b0: pmpaddr_addr[i];
      assign temp_napot_bounds[i] = (i <= ptr) ? 1'b1: pmpaddr_addr[i];
    end
  endgenerate

  assign napot_bounds = is_no_zeros ? '1: temp_napot_bounds;
  assign napot_base = is_no_zeros ? '0: temp_napot_base;

endmodule
