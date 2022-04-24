// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module simple_mult(
    input[63:0]             a,                            
    input[63:0]             b,
    input                   ce,
    
    input                   is_signed_a,
    input                   is_signed_b,
    
    output reg              done,
    output reg[127:0]       product,
    input                    clk,
    input                    rst_n
    );
    
    reg[127:0] _product;
    reg[6:0] cnt; 
    wire[63:0] op_a, op_b;
    assign op_a = is_signed_a & a[63] ? (~a) + 1 : a;
    assign op_b = is_signed_b & b[63] ? (~b) + 1 : b;
    
    always @(posedge clk, negedge rst_n)
    begin
        if (!rst_n)
        begin
            cnt <= 7'b0;
            _product <= 128'd0;
            done <= 1'b0;
        end
        else if (!cnt[6])
        begin
            done <= 1'b0;
            if (ce)
            begin
                if (op_b[cnt])
                    if (cnt == 7'd0)
                        _product <= op_a;
                    else
                        _product <= _product + (op_a << cnt);
                if ((op_b >> cnt) == 'b0)
                    cnt <= 7'b1000000;
                else
                    cnt <= cnt + 1;
            end
            else
            begin
                _product <= 'b0;
                cnt <= 1'b0;
            end
        end
        else
        begin
            cnt <= 7'd0;
            done <= 1'b1;
        end
    end
    
    always_comb
    begin
        product = _product;
        if (is_signed_b) // must be ss
            if(a[63] ^ b[63])
                product = (~_product) + 1;
        else if (is_signed_a)   //must be su
            if(a[63])
                product = (~_product) + 1;
    end
    
endmodule

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


  simlpe_mult #(a_width, b_width, tc_mode, num_cyc, rst_mode, input_mode, output_mode, early_start) SIMPLE_MULT(
    .clk(clk), .rst_n(~rst), .ce(start_pulse), .is_signed_a(is_rs1_signed), .is_signed_b(is_rs2_signed),
    .a(a), .b(b), .done(complete), .product(p));

  assign rdl = (mul_type == ORV64_MUL_TYPE_W) ? { {32{p[31]}}, p[31:0] } : p[63:0];
  assign rdh = p[127:64];

endmodule

