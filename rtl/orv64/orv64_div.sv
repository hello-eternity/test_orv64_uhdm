// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module diver_simple(
	input clk,
	input rst_n,
	
	input is_signed,
	input[63:0] opdata1,
	input[63:0] opdata2,
	input start_pulse,
	
	output[63:0] resultq,
  output[63:0] resultr,
	output done
);

	wire[64:0] div_temp;
	reg[6:0] cnt;
	reg[128:0] dividend;
	reg[1:0] state;
	reg[63:0] divisor;	 
	reg[63:0] temp_op1;
	reg[63:0] temp_op2;
	
	assign div_temp = {1'b0,dividend[127:64]} - {1'b0,divisor};

	always @ (posedge clk, negedge rst_n) 
	begin
		if (!rst_n) 
		begin
			state <= 2'd0;
		end 
		else 
		begin
		  case (state)
		  	2'd0:			
			begin               //DivFree
		  		if(start_pulse) 
				begin
					
		  			if(opdata2 == 64'd0) 
					begin
		  				state <= 2'd1;
		  			end 
					else 
					begin
		  				state <= 2'd2;
		  				cnt <= 7'b0;
                        
		  				if(is_signed && opdata1[63]) 
		  					temp_op1 = ~opdata1 + 1;
						else 
		  					temp_op1 = opdata1;

		  				if(is_signed && opdata2[63]) 
		  					temp_op2 = ~opdata2 + 1;
						else 
		  					temp_op2 = opdata2;

						dividend <= {64'd0,64'd0};
						dividend[64:1] <= temp_op1;
						divisor <= temp_op2;
					end
				end        	
		  	end
		  	2'd1:		
			begin               //DivByZero
         	    dividend <= {64'd0,64'd0};
				state <= 2'd3;		 		
		  	end
		  	2'd2:				
			begin               //DivOn
                if(!cnt[6]) 
                begin
                    if(div_temp[64] == 1'b1) 
                    begin
                        dividend <= {dividend[127:0] , 1'b0};
                    end 
                    else 
                    begin
                        dividend <= {div_temp[63:0] , dividend[63:0] , 1'b1};
                    end
                    cnt <= cnt + 1;
                end 
                else 
                begin
                    if((is_signed == 1'b1) && ((opdata1[63] ^ opdata2[63]) == 1'b1)) 
                    begin
                        dividend[63:0] <= (~dividend[63:0] + 1);
                    end
                    if((is_signed == 1'b1) && ((opdata1[63] ^ dividend[128]) == 1'b1)) 
                    begin              
                        dividend[128:65] <= (~dividend[128:65] + 1);
                    end
                    state <= 2'd3;
                    cnt <= 7'b0;            	
                end
		  	end
		  	2'd3:			//DivEnd
			if(!start_pulse)
	            state <= 2'd0;

		  endcase
		end
	end

    assign resultr = dividend[63:0];
    assign resultq = dividend[128:65];
    assign done = state == 2'd3;
	
endmodule

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

  logic is_div_0, is_overflow;
  assign is_div_0 = (b == 65'b0);
  // assign is_overflow = ((q[64] ^ q[63]) == 1'b1);
  assign is_overflow = ((a == {2'b11, 63'b0}) & (b == '1));
  assign complete = int_complete & ~start_pulse;

  // diver_simple #(a_width, b_width, tc_mode, num_cyc, rst_mode, input_mode, output_mode, early_start) DIVER_SIMPLE(
  //   .clk(clk), .rst_n(~rst), .start_pulse(start_pulse), .opdata1(a), .opdata2(b),
  //   .done(int_complete), .is_signed(), .resultq(q), .resultr(r));


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

