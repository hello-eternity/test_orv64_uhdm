// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_mul
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
(
  output  orv64_data_t      rdh, rdl,
  output  logic       complete,
  input   orv64_data_t      rs1, rs2,
  input   orv64_mul_type_t  mul_type,
  input   logic       start_pulse,
  input   logic       rst, clk
);
  localparam a_width = 65;
  localparam b_width = 65;
  localparam tc_mode = 1;   // signed
  // localparam num_cyc = 13;
  localparam num_cyc = ORV64_N_CYCLE_INT_MUL;
  localparam rst_mode = 1;  // sync reset
  localparam input_mode = 0;  // flop outside
  localparam output_mode = 0; // flop outside
  localparam early_start = 0; // 0 for input_mode = output_mode = 0

  logic is_rs1_signed, is_rs2_signed;
  always_comb
    case (mul_type)
      ORV64_MUL_TYPE_HUU: begin
        is_rs1_signed = 1'b0;
        is_rs2_signed = 1'b0;
      end
      ORV64_MUL_TYPE_HSU: begin
        is_rs1_signed = 1'b1;
        is_rs2_signed = 1'b0;
      end
      default: begin
        is_rs1_signed = 1'b1;
        is_rs2_signed = 1'b1;
      end
    endcase

  logic [ 64:0] a, b;
  logic [129:0] p;

  assign a = (is_rs1_signed) ? {rs1[63], rs1} : {1'b0, rs1};
  assign b = (is_rs2_signed) ? {rs2[63], rs2} : {1'b0, rs2};

`ifndef FPGA

  // Instance of DW_mult_seq
  DW_mult_seq #(a_width, b_width, tc_mode, num_cyc, rst_mode, input_mode, output_mode, early_start) DW_MULT_SEQ(
    .clk(clk), .rst_n(~rst), .hold(1'b0), .start(start_pulse), .a(a), .b(b),
    .complete(complete), .product(p));

`else
  //==========================================================
  // Xilinx FPGA

  logic [7:0] cnt_ff;
  logic ce_uu, ce_su, ce_ss;
  logic [127:0] p_uu, p_su, p_ss;
  logic int_complete;

  always_ff @ (posedge clk) begin
    if (rst)
      cnt_ff <= '0;
    else if (start_pulse)
      cnt_ff <= 1;
    else if (cnt_ff != ORV64_N_CYCLE_INT_MUL_FPGA)
      cnt_ff <= cnt_ff + 1;
  end

  always_comb begin
    ce_uu = '0; ce_su = '0; ce_ss = '0;
    p = '0;

    case (mul_type)
      ORV64_MUL_TYPE_NONE: begin
        ce_uu = '0; ce_su = '0; ce_ss = '0;
        p[127:0] = p_ss;
      end
      ORV64_MUL_TYPE_HUU: begin
        ce_uu = '1; ce_su = '0; ce_ss = '0;
        p[127:0] = p_uu;
      end
      ORV64_MUL_TYPE_HSU: begin
        ce_uu = '0; ce_su = '1; ce_ss = '0;
        p[127:0] = p_su;
      end
      default: begin
        ce_uu = '0; ce_su = '0; ce_ss = '1;
        p[127:0] = p_ss;
      end
    endcase

    if (cnt_ff == '0) begin
      ce_uu = '0; ce_su = '0; ce_ss = '0;
    end

    int_complete = '0;
    if (cnt_ff == ORV64_N_CYCLE_INT_MUL_FPGA)
      int_complete = '1;
  end

  assign complete = int_complete & ~start_pulse;

  mult_uu XMULT_UU( .CLK(clk), .A(rs1), .B(rs2), .CE(ce_uu), .P(p_uu) );
  mult_su XMULT_SU( .CLK(clk), .A(rs1), .B(rs2), .CE(ce_su), .P(p_su) );
  mult_ss XMULT_SS( .CLK(clk), .A(rs1), .B(rs2), .CE(ce_ss), .P(p_ss) );
`endif

  assign rdl = (mul_type == ORV64_MUL_TYPE_W) ? { {32{p[31]}}, p[31:0] } : p[63:0];
  assign rdh = p[127:64];

endmodule
