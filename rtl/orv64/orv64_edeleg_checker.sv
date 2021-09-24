// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_edeleg_checker 
  import orv64_typedef_pkg::*;
(
  input  logic                excp_valid,
  input  orv64_excp_cause_t   excp_cause,
  input  orv64_csr_edeleg_t   edeleg,
  output logic                do_delegate
);

  always_comb begin
    if (excp_valid) begin
      case (excp_cause)
        ORV64_EXCP_CAUSE_INST_ADDR_MISALIGNED: begin
          do_delegate = edeleg.inst_addr_misaligned ? '1: '0;
        end
        ORV64_EXCP_CAUSE_INST_ACCESS_FAULT: begin
          do_delegate = edeleg.inst_access_fault ? '1: '0;
        end
        ORV64_EXCP_CAUSE_ILLEGAL_INST: begin
          do_delegate = edeleg.illegal_inst ? '1: '0;
        end
        ORV64_EXCP_CAUSE_BREAKPOINT: begin
          do_delegate = edeleg.breakpoint ? '1: '0;
        end
        ORV64_EXCP_CAUSE_LOAD_ADDR_MISALIGNED: begin
          do_delegate = edeleg.load_addr_misaligned ? '1: '0;
        end
        ORV64_EXCP_CAUSE_LOAD_ACCESS_FAULT: begin
          do_delegate = edeleg.load_access_fault ? '1: '0;
        end
        ORV64_EXCP_CAUSE_STORE_ADDR_MISALIGNED: begin
          do_delegate = edeleg.store_addr_misaligned ? '1: '0;
        end
        ORV64_EXCP_CAUSE_STORE_ACCESS_FAULT: begin
          do_delegate = edeleg.store_access_fault ? '1: '0;
        end
        ORV64_EXCP_CAUSE_ECALL_FROM_U: begin
          do_delegate = edeleg.ecall_from_u ? '1: '0;
        end
        ORV64_EXCP_CAUSE_ECALL_FROM_S: begin
          do_delegate = edeleg.ecall_from_s ? '1: '0;
        end
        ORV64_EXCP_CAUSE_ECALL_FROM_M: begin
          do_delegate = edeleg.ecall_from_m ? '1: '0;
        end
        ORV64_EXCP_CAUSE_INST_PAGE_FAULT: begin
          do_delegate = edeleg.inst_page_fault ? '1: '0;
        end
        ORV64_EXCP_CAUSE_LOAD_PAGE_FAULT: begin
          do_delegate = edeleg.load_page_fault ? '1: '0;
        end
        ORV64_EXCP_CAUSE_STORE_PAGE_FAULT: begin
          do_delegate = edeleg.store_page_fault ? '1: '0;
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
