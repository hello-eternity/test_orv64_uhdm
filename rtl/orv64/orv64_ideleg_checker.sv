// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_ideleg_checker
  import orv64_typedef_pkg::*;
(
  input  logic                int_valid,
  input  orv64_int_cause_t    int_cause,
  input  orv64_csr_ideleg_t   ideleg,
  output logic                do_delegate
);

  always_comb begin
    if (int_valid) begin
      case (int_cause)
        ORV64_INT_U_SW: begin
          do_delegate = ideleg.usip ? '1: '0;
        end
        ORV64_INT_S_SW: begin
          do_delegate = ideleg.ssip ? '1: '0;
        end
        ORV64_INT_M_SW: begin
          do_delegate = ideleg.msip ? '1: '0;
        end
        ORV64_INT_U_TIME: begin
          do_delegate = ideleg.utip ? '1: '0;
        end
        ORV64_INT_S_TIME: begin
          do_delegate = ideleg.stip ? '1: '0;
        end
        ORV64_INT_M_TIME: begin
          do_delegate = ideleg.mtip ? '1: '0;
        end
        ORV64_INT_U_EXT: begin
          do_delegate = ideleg.ueip ? '1: '0;
        end
        ORV64_INT_S_EXT: begin
          do_delegate = ideleg.seip ? '1: '0;
        end
        ORV64_INT_M_EXT: begin
          do_delegate = ideleg.meip ? '1: '0;
        end
        default: begin
          do_delegate = '0;
        end
      endcase
    end else begin
      do_delegate = '0;
    end
  end

endmodule
