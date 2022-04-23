// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_perm_checker
  import orv64_func_pkg::*;
  import orv64_typedef_pkg::*;
(
  input logic               perm_x,
  input logic               perm_r,
  input logic               perm_w,
  input orv64_access_type_t access_type,
  input orv64_csr_mstatus_t mstatus,

  output logic              excp_valid
);

  always_comb begin
    case (access_type)
      ORV64_ACCESS_FETCH: begin
        excp_valid = ~perm_x;
      end
      ORV64_ACCESS_LOAD: begin
        excp_valid = (mstatus.MXR) ? ~(perm_r | perm_x): ~perm_r;
      end
      ORV64_ACCESS_STORE: begin
        excp_valid = ~perm_w;
      end
      ORV64_ACCESS_AMO: begin
        excp_valid = ((mstatus.MXR) ? ~(perm_r | perm_x): ~perm_r) | ~perm_w;
      end
      default: begin
        excp_valid = '0;
      end
    endcase
  end

endmodule


