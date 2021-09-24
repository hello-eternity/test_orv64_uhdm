// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_magicmem
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
(
  // req
  input   logic     ob_req, ob_rwn,
  input   paddr_t   ob_addr,
  input   data_t    ob_wdata,
  // resp
  output  data_t    ob_rdata,
  output  logic     ob_resp, ob_resp_err,
  // config
  input   paddr_t   cfg_magicmem_start_addr,
                    cfg_magicmem_end_addr,
                    cfg_from_host_addr,
                    cfg_to_host_addr,
  // else
  input   logic   rst, clk
);
`ifndef SYNTHESIS
  import ours_logging::*;
`endif

  assign ob_resp_err = '0;

  // SRAM
  logic         en, we;
  logic [ 8:0]  addr;
  logic [63:0]  din, dout;

`ifndef FPGA
  TS1N28HPCPHVTB384X64M4SWSO SRAM(
    .SLP('0), .SD('0),
    .CLK(clk), .CEB(~en), .WEB(~we),
    .A(addr), .D(din), .BWEB('0),
    .Q(dout)
  );
`else
  xilinx_spsram #(.BYTE_WIDTH(8), .WIDTH(64), .DEPTH(384)) SRAM(
    .SLP('0), .SD('0),
    .CLK(clk), .CEB(~en), .WEB(~we),
    .A(addr), .D(din), .BWEB('0),
    .Q(dout)
  );
//   logic [17:0] [63:0] mem;
// 
//   always_ff @ (posedge clk) begin
//     if (en) begin
//       if (we)
//         mem[addr] <= din;
//       else
//         dout <= mem[addr];
//     end
//   end
`endif

  typedef enum logic [1:0] {IDLE, REQ, DONE} mm_state_t;

  struct { mm_state_t state; } v, r;

  always_ff @(posedge clk) begin
    if (rst) begin
      r <= '{default: '0};
    end else begin
      r <= v;
    end
  end

  always_comb begin
    v = r;
    case(r.state)
      IDLE: begin
        if ((ob_req == 1'b1) && (ob_addr[PHY_ADDR_WIDTH - 1 -: 6] == MAGICMEM_OURSBUS_ID)) begin
          v.state = REQ;
        end
      end
      REQ: begin
        v.state = DONE;
      end
      DONE: begin
        v.state = IDLE;
      end
    endcase
  end

  always_comb begin
    paddr_t ob_addr_offset;
    // req
    din = ob_wdata;
    en = (r.state == REQ);
    we = ~ob_rwn;

// `ifndef FPGA
    case ({6'b0, ob_addr[33:3], 3'b0})
      cfg_from_host_addr:
        addr = 'd382;
      cfg_to_host_addr:
        addr = 'd383;
      default: begin
        ob_addr_offset = {6'b0, ob_addr[PHY_ADDR_WIDTH-6-1:3], 3'b0} - cfg_magicmem_start_addr;
        addr = ob_addr_offset[8:3];
      end
    endcase
// `else // FPGA
//     case ({6'b0, ob_addr[33:3], 3'b0})
//       cfg_from_host_addr:
//         addr = 'd17;
//       cfg_to_host_addr:
//         addr = 'd16;
//       default: begin
//         ob_addr_offset = {6'b0, ob_addr[PHY_ADDR_WIDTH-6-1:3], 3'b0} - cfg_magicmem_start_addr;
//         addr = ob_addr_offset[6:3];
//       end
//     endcase
// `endif

    // resp
    ob_rdata = dout;
    ob_resp = (r.state == DONE);
  end

endmodule
