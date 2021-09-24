// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_div
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
(
  output  orv64_data_t      rdq, rdr,
  output  logic       complete,
  input   orv64_data_t      rs1, rs2,
  input   orv64_div_type_t  div_type,
  input   logic       start_pulse,
  input   logic       rst, clk
);
  parameter a_width = 65;
  parameter b_width = 65;
  parameter tc_mode = 1;
  parameter num_cyc = ORV64_N_CYCLE_INT_DIV;
  parameter rst_mode = 1;
  parameter input_mode = 0;
  parameter output_mode = 0;
  parameter early_start = 0;

  logic         int_complete;
  logic [ 64:0] a, b, q, r;
  always_comb
    case (div_type)
      ORV64_DIV_TYPE_QU, ORV64_DIV_TYPE_RU: begin
        a = {1'b0, rs1};
        b = {1'b0, rs2};
      end
      ORV64_DIV_TYPE_QW, ORV64_DIV_TYPE_RW: begin
        a = { {33{rs1[31]}}, rs1[31:0] };
        b = { {33{rs2[31]}}, rs2[31:0] };
      end
      ORV64_DIV_TYPE_QUW, ORV64_DIV_TYPE_RUW: begin
        a = { {33'b0}, rs1[31:0] };
        b = { {33'b0}, rs2[31:0] };
      end
      default: begin
        a = {rs1[63], rs1};
        b = {rs2[63], rs2};
      end
    endcase

  // Instance of DW_div_seq
  logic is_div_0, is_overflow;
  assign is_div_0 = (b == 65'b0);
  // assign is_overflow = ((q[64] ^ q[63]) == 1'b1);
  assign is_overflow = ((a == {2'b11, 63'b0}) & (b == '1));
  assign complete = int_complete & ~start_pulse;

`ifndef FPGA
  DW_div_seq #(a_width, b_width, tc_mode, num_cyc, rst_mode, input_mode, output_mode, early_start) DW_DIV_SEQ(
    .clk(clk), .rst_n(~rst), .hold(1'b0), .start(start_pulse), .a(a), .b(b),
    .complete(int_complete), .divide_by_0(), .quotient(q), .remainder(r));
`else
  //==========================================================
  // Xilinx FPGA

  logic [8:0] cnt_ff;
  logic ce_u, ce_s;
  logic [63:0] q_u, q_s, r_u, r_s;
  logic [3:0] tready;
  logic [1:0] tvalid;

  always_ff @ (posedge clk) begin
    if (rst)
      cnt_ff <= '0;
    else if (start_pulse)
      cnt_ff <= 1;
    else if (cnt_ff != ORV64_N_CYCLE_INT_DIV_FPGA * 2)
      cnt_ff <= cnt_ff + 1;
  end

  always_comb begin
    case (div_type)
      ORV64_DIV_TYPE_QU, ORV64_DIV_TYPE_RU: begin
        ce_u = '1; ce_s = '0;
        q = q_u; r = r_u;
      end
      ORV64_DIV_TYPE_QW, ORV64_DIV_TYPE_RW: begin
        ce_u = '0; ce_s = '1;
        q = q_s; r = r_s;
      end
      ORV64_DIV_TYPE_QUW, ORV64_DIV_TYPE_RUW: begin
        ce_u = '1; ce_s = '0;
        q = q_u; r = r_u;
      end
      ORV64_DIV_TYPE_Q, ORV64_DIV_TYPE_R: begin
        ce_u = '0; ce_s = '1;
        q = q_s; r = r_s;
      end
      ORV64_DIV_TYPE_NONE: begin
        ce_u = '0; ce_s = '0;
        q = q_s; r = r_s;
      end
      default: begin
        ce_u = '0; ce_s = '0;
        q = q_s; r = r_s;
      end
    endcase

    int_complete = '0;
    if (cnt_ff == ORV64_N_CYCLE_INT_DIV_FPGA * 2)
      int_complete = '1;
  end

  div_u XDIV_U (
    .aclk(clk), .aclken(ce_u),
    .s_axis_dividend_tvalid(start_pulse), .s_axis_dividend_tdata(a[63:0]), .s_axis_dividend_tready(tready[1]),
    .s_axis_divisor_tvalid(start_pulse), .s_axis_divisor_tdata(b[63:0]), .s_axis_divisor_tready(tready[0]),
    .m_axis_dout_tvalid(tvalid[0]), .m_axis_dout_tdata({q_u, r_u})
  );

  div_s XDIV_S (
    .aclk(clk), .aclken(ce_s),
    .s_axis_dividend_tvalid(start_pulse), .s_axis_dividend_tdata(a[63:0]), .s_axis_dividend_tready(tready[3]),
    .s_axis_divisor_tvalid(start_pulse), .s_axis_divisor_tdata(b[63:0]), .s_axis_divisor_tready(tready[2]),
    .m_axis_dout_tvalid(tvalid[1]), .m_axis_dout_tdata({q_s, r_s})
  );

`ifndef SYNTHESIS
  chk_xdiv_tready_u: assert property (@(posedge clk) disable iff (rst !== '0) ((start_pulse & ce_u) |-> (tready[1:0] == '1))) else `olog_error("ORV_DIV_FPGA", $sformatf("%m: start_pulse=%b tready=%b", start_pulse, tready));
  chk_xdiv_tready_s: assert property (@(posedge clk) disable iff (rst !== '0) ((start_pulse & ce_s) |-> (tready[3:2] == '1))) else `olog_error("ORV_DIV_FPGA", $sformatf("%m: start_pulse=%b tready=%b", start_pulse, tready));
//   chk_xdiv_tvalid_u: assert property (@(posedge clk) disable iff (rst !== '0) ((complete & ce_u) |-> tvalid[0])) else `olog_error("ORV_DIV_FPGA", $sformatf("%m: complete=%b tvalid=%b", complete, tvalid));
//   chk_xdiv_tvalid_s: assert property (@(posedge clk) disable iff (rst !== '0) ((complete & ce_s) |-> tvalid[1])) else `olog_error("ORV_DIV_FPGA", $sformatf("%m: complete=%b tvalid=%b", complete, tvalid));
`endif

`endif


  orv64_data_t q_64, q_32;
  assign q_64 = q[63:0];
  assign q_32 = { {32{q[31]}}, q[31:0] };

  always_comb
    case (div_type)
      ORV64_DIV_TYPE_QW:
        unique case (1'b1)
          is_div_0:     rdq = '1;
          is_overflow:  rdq = a[63:0];
          default:      rdq = q_32;
        endcase
      ORV64_DIV_TYPE_QUW:
        if (is_div_0)   rdq = {64{1'b1}};
        else            rdq = q_32;
      ORV64_DIV_TYPE_Q:
        unique case (1'b1)
          is_div_0:     rdq = {64{1'b1}};
          is_overflow:  rdq = a[63:0];
          default:      rdq = q_64;
        endcase
      ORV64_DIV_TYPE_QU:
        if (is_div_0)   rdq = {64{1'b1}};
        else            rdq = q_64;
      default:
        rdq = q_64;
    endcase

  orv64_data_t r_64, r_32;
  assign r_64 = r[63:0];
  assign r_32 = { {32{r[31]}}, r[31:0] };

  always_comb
    case (div_type)
      ORV64_DIV_TYPE_RW:
        unique case (1'b1)
          is_div_0:     rdr = { {32{a[31]}}, r[31:0] };
          is_overflow:  rdr = 64'b0;
          default:      rdr = r_32;
        endcase
      ORV64_DIV_TYPE_RUW:
        if (is_div_0)   rdr = { {32{a[31]}}, r[31:0] };
        else            rdr = r_32;
      ORV64_DIV_TYPE_R:
        unique case (1'b1)
          is_div_0:     rdr = a[63:0];
          is_overflow:  rdr = 64'b0;
          default:      rdr = r_64;
        endcase
      ORV64_DIV_TYPE_RU:
        if (is_div_0)   rdr = a[63:0];
        else            rdr = r_64;
      default:
        rdr = r[63:0];
    endcase

endmodule
