// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module DW_mult_seq ( clk, 
		     rst_n, 
		     hold, 
		     start, 
		     a,  
		     b, 
		     complete, 
		     product);
   //----------------------------------------------------------------------
   // parameters declaration
   //----------------------------------------------------------------------
   parameter  a_width     = 3;
   parameter  b_width     = 3;
   parameter  tc_mode     = 0;
   parameter  num_cyc     = 3;
   parameter  rst_mode    = 0;
   parameter  input_mode  = 1;
   parameter  output_mode = 1;
   parameter  early_start = 0;

   
   parameter  NO_CYC = ((a_width%num_cyc)?((a_width/num_cyc)+1) : (a_width/num_cyc));
   parameter  NO_CYC_FLG = a_width/num_cyc;
   parameter  BIT = 
	      ((num_cyc-early_start+input_mode+output_mode-2)>8388608 ? 24:
	       ((num_cyc-early_start+input_mode+output_mode-2)>4194304 ? 23:
		((num_cyc-early_start+input_mode+output_mode-2)>2097152 ? 22:
		 ((num_cyc-early_start+input_mode+output_mode-2)>1048576 ? 21:
		  ((num_cyc-early_start+input_mode+output_mode-2)>524288  ? 20:
		   ((num_cyc-early_start+input_mode+output_mode-2)>262144  ? 19:
		    ((num_cyc-early_start+input_mode+output_mode-2)>131072  ? 18:
		     ((num_cyc-early_start+input_mode+output_mode-2)>65536   ? 17:
		      ((num_cyc-early_start+input_mode+output_mode-2)>32768   ? 16:
		       ((num_cyc-early_start+input_mode+output_mode-2)>16384   ? 15:
			((num_cyc-early_start+input_mode+output_mode-2)>8192    ? 14:
			 ((num_cyc-early_start+input_mode+output_mode-2)>4096    ? 13:
			  ((num_cyc-early_start+input_mode+output_mode-2)>2048    ? 12:
			   ((num_cyc-early_start+input_mode+output_mode-2)>1024    ? 11:
			    ((num_cyc-early_start+input_mode+output_mode-2)>512     ? 10:
			     ((num_cyc-early_start+input_mode+output_mode-2)>256     ? 9 :
			      ((num_cyc-early_start+input_mode+output_mode-2)>128     ? 8 :
			       ((num_cyc-early_start+input_mode+output_mode-2)>64      ? 7 :
				((num_cyc-early_start+input_mode+output_mode-2)>32      ? 6 :
				 ((num_cyc-early_start+input_mode+output_mode-2)>16      ? 5 :
				  ((num_cyc-early_start+input_mode+output_mode-2)>8       ? 4 :
				   ((num_cyc-early_start+input_mode+output_mode-2)>4       ? 3 :
				    ((num_cyc-early_start+input_mode+output_mode-2)>2       ? 2 :
				     1)))))))))))))))))))))));
   parameter  actual_cnt = (num_cyc -(1 - output_mode) - (1 - input_mode) - early_start);

   //----------------------------------------------------------------------
   // input declaration
   //----------------------------------------------------------------------
   input      clk;
   input      rst_n;
   input      hold;
   input      start;
   input [a_width-1 : 0] a;
   input [b_width-1 : 0] b;
   //----------------------------------------------------------------------
   // output declaration
   //----------------------------------------------------------------------
   output 		 complete;
   output [a_width+b_width-1 : 0] product;
   //-----------------------------------------------------------------------------
   // wire declaration
   //-----------------------------------------------------------------------------
   wire 			  clk;
   wire 			  rst_n;
   wire 			  hold;
   wire 			  start;
   wire [a_width-1 : 0] 	  a;
   wire [b_width-1 : 0] 	  b;
   wire 			  complete;
   wire [a_width+b_width-1 : 0]   product;
   
   wire 			  async_rst_n;
   wire 			  sync_rst_n;
   wire [a_width+b_width-1 : 0]   comp_a;
   wire [b_width-1 : 0] 	  comp_b;
   wire [a_width+b_width-1 : 0]   early_prod;
   wire [a_width+b_width-1 : 0]   last_prod;
   wire [a_width+b_width-1 : 0]   in_prod;
   //-----------------------------------------------------------------------------
   // reg declaration
   //-----------------------------------------------------------------------------
   reg [a_width+b_width-1 : 0] 	  pp;
   reg [b_width-1 : 0] 		  mcd;
   reg 				  new_cplt;
   reg 				  dummy;
   reg [BIT-1 : 0] 		  itr_count;
   
   assign  async_rst_n = (rst_mode == 0) ? rst_n : 1'b1;
   assign sync_rst_n  = (rst_mode == 1)   ? rst_n  : 1'b1;
   assign  complete    = new_cplt&~start;
   assign  product     =  (output_mode==0) ? last_prod : pp;

   assign comp_a      = (start && ((input_mode == 0) || early_start==1)) ? {{b_width{1'b0}},a} : pp;
   assign comp_b      = ((input_mode == 0) || (start && early_start==1)) ? b : mcd;

   assign  early_prod  = calc_partial_product(comp_b,comp_a,1'b1);
   assign last_prod    = calc_partial_product_last((input_mode==1 ? mcd : comp_b) , pp);
   assign in_prod      = calc_partial_product(comp_b, comp_a,
                                (start) ?  1'b1 :
                                ((a_width%num_cyc) >= (itr_count +1 + ((early_start==1) || (input_mode==0)) )) );


   //-----------------------------------------------------------------------------
   // function calc_partial_product
   // This function calculates the partial product to be made in the particular
   // clock and adds it to the already calculated one.
   //-----------------------------------------------------------------------------
   function [a_width+b_width-1:0] calc_partial_product_last;
      input [b_width-1:0] multpcnd;
      input [a_width+b_width-1:0] pp;
      reg   [a_width + b_width-1:0]   pp_left_temp;
      reg   [a_width-1:0] pp_right_temp;
      reg 		  dummy;
      reg   [a_width+b_width-1:0]   pp_temp;
      integer counter;
      begin
         pp_right_temp  = pp[a_width-1:0];
	   if (tc_mode)
              pp_left_temp =  {{a_width{pp[a_width+b_width-1]}},
                pp[a_width+b_width-1:a_width]};
         else
              pp_left_temp = {{a_width{1'b0}},pp[a_width+b_width-1:a_width]};

                    if (tc_mode==1) begin
        for(counter=0;counter<NO_CYC_FLG;counter=counter+1) begin
                  if (counter==(NO_CYC_FLG-1)) begin
                        if(pp_right_temp[0]) begin
                          pp_temp = (~({{a_width{multpcnd[b_width-1]}},multpcnd}) +1);
                        end
                        else begin
                          pp_temp = ({a_width+b_width{1'b0}});
                        end
                      end
                      else begin
                        if(pp_right_temp[0]) begin
                          pp_temp  = {{a_width{multpcnd[b_width-1]}},multpcnd};
                        end
                        else begin
                          pp_temp = ({a_width+b_width{1'b0}});
                        end
                      end
                  pp_left_temp = pp_left_temp + (pp_temp<<counter);
                  pp_right_temp  = pp_right_temp >> 1;
              end
                    end
                    else begin
        for(counter=0;counter<NO_CYC_FLG;counter=counter+1) begin
		      if(pp_right_temp[0])
                      pp_temp = multpcnd;
                      else
                      pp_temp = ({b_width{1'b0}});
                  pp_left_temp = pp_left_temp + (pp_temp<<counter);
                  pp_right_temp = pp_right_temp >> 1;
                    end
 
          end // tc

          calc_partial_product_last = (pp_left_temp<<(a_width-NO_CYC_FLG))|pp_right_temp;
      end
   endfunction // calc_partial_product_last

   function [a_width+b_width-1:0] calc_partial_product;
      input [b_width-1:0] multpcnd;
      input [a_width+b_width-1:0] pp;
      input                cyc;
      reg   [a_width+b_width-1:0]   pp_left_temp;
      reg   [a_width-1:0] pp_right_temp;
      reg   [a_width+b_width-1:0]   pp_temp;
      reg 		  dummy;
      reg rsh;
      integer counter;
      begin
	 pp_right_temp  = pp[a_width-1:0];
	 if (tc_mode)
              pp_left_temp = {{a_width{pp[a_width+b_width-1]}},
                pp[a_width + b_width-1:a_width]};
	 else
              pp_left_temp = {{a_width{1'b0}},pp[a_width+b_width-1:a_width]};

		    if (tc_mode==1) begin
        for(counter=0;counter<NO_CYC;counter=counter+1) begin
                  rsh = 1'b1;
                  if ((cyc == 0) && (NO_CYC != NO_CYC_FLG) && (counter == (NO_CYC-1))) begin
                      pp_temp  = ({a_width+b_width{1'b0}});
                      rsh = 1'b0;
                  end
                  else if (((counter==(NO_CYC-1)) || ((cyc == 0) && (counter==(NO_CYC_FLG-1)))) &&
                    (itr_count==(num_cyc-1-((early_start==1) ||(input_mode ==0)))) &&
                    (output_mode==1)) begin
			if(pp_right_temp[0]) begin
                          pp_temp  = (~({{a_width{multpcnd[b_width-1]}},multpcnd}) +1);
		        end
		        else begin
                          pp_temp  = ({a_width+b_width{1'b0}});
			end
		      end
		      else begin
			if(pp_right_temp[0]) begin
                          pp_temp  = {{a_width{multpcnd[b_width-1]}},multpcnd};
			end
			else begin
                          pp_temp = ({a_width+b_width{1'b0}});
		      	end
		      end
                  pp_left_temp = pp_left_temp + (pp_temp << counter);
                  pp_right_temp = pp_right_temp >> rsh;
		    end
		    end
	    else begin
	      for(counter=0;counter<NO_CYC;counter=counter+1) begin
                  rsh = 1'b1;
                  if ((cyc == 0) && (NO_CYC != NO_CYC_FLG) && (counter == (NO_CYC-1))) begin
                      pp_temp  = ({a_width+b_width{1'b0}});
                      rsh = 1'b0;
                        end
                  else if(pp_right_temp[0])
                      pp_temp = multpcnd;
                  else
                      pp_temp = ({b_width{1'b0}});
                  pp_left_temp = pp_left_temp + (pp_temp<<counter);
                  pp_right_temp = pp_right_temp >> rsh;
                      end
                    end
          if (cyc == 0)
              calc_partial_product = (pp_left_temp<<(a_width-NO_CYC_FLG))|pp_right_temp;
                      else
              calc_partial_product = (pp_left_temp<<(a_width-NO_CYC))|pp_right_temp;
      end
   endfunction // calc_partial_product
   //-----------------------------------------------------------------------------
   always @ (posedge clk or negedge async_rst_n)
     begin
	if (async_rst_n == 1'b0) 
	  begin
	     new_cplt    <= 1'b0;
	     pp          <= {a_width+b_width{1'b0}};
	     mcd         <= {b_width{1'b0}};
	     dummy       <= 1'b0;
	     itr_count   <= {BIT{1'b0}};
	  end
	else
	  if (sync_rst_n == 1'b0) 
	    begin
	       new_cplt    <= 1'b0;
	       pp          <= {a_width+b_width{1'b0}};
	       mcd         <= {b_width{1'b0}};
	       dummy       <= 1'b0;
	       itr_count   <= {BIT{1'b0}};
	    end
	  else
	    if(start)
	      begin
		 new_cplt    <= 1'b0;
		 mcd         <= b;
		 itr_count   <= {BIT{1'b0}};
		                 pp              <= (early_start==1 || input_mode==0) ? in_prod : {{b_width{1'b0}},a};

	      end // if (start)
	    else
	      if(~hold)
		if(~new_cplt)
		  begin
			  pp                <=  in_prod;
			  {dummy,itr_count} <= itr_count + 1'b1;
		 new_cplt <= (itr_count== (actual_cnt-1));
		  end // if (~new_cplt)
     end // always @(posedge clk or negedge async_rst_n)

   //----------------------------------------------------------------------   
   // cadence translate_off
   // synopsys translate_off   
   //----------------------------------------------------------------------
   initial
   begin : parameter_check
      integer err_flag;
      err_flag = 0;
      
      if (b_width < 3) begin
	 err_flag = 1;
	 $display( "%m ERROR - Incorrect Parameter, b_width = %0d (Valid range : >=3)",b_width);
	 err_flag = 1;    
      end
      
      if ((a_width < 3) || (a_width > b_width)) begin
	 $display("%m ERROR - Incorrect Parameter, a_width = %0d (Valid range : 3 to b_width)",a_width);
	 err_flag = 1;
      end
      
      if ((tc_mode < 0) || (tc_mode > 1)) begin
	 $display("%m ERROR - Incorrect Parameter, tc_mode = %0d (Valid range : 0 to 1)",tc_mode);
	 err_flag = 1;
      end
      
      if ((num_cyc < 3) || (num_cyc > a_width)) begin
	 $display("%m ERROR - Incorrect Parameter,num_cyc= %0d (Valid range : 3 to a_width)",num_cyc);
	 err_flag = 1;
      end
      
      if ((rst_mode < 0) || (rst_mode > 1)) begin
	 $display("%m ERROR - Incorrect Parameter, rst_mode = %0d (Valid range : 0 to 1)",rst_mode);
	 err_flag = 1;
      end
      
      if ((input_mode < 0) || (input_mode > 1)) begin
	 $display("%m ERROR - Incorrect Parameter, input_mode = %0d (Valid range : 0 to 1)",input_mode);
	 err_flag = 1;
      end
      
      if ((output_mode < 0) || (output_mode > 1)) begin
	 $display("%m ERROR - Incorrect Parameter, output_mode = %0d (Valid range : 0 to 1)",output_mode);
	 err_flag = 1;
      end
      
      if ((early_start < 0) || (early_start > 1)) begin
	 $display("%m ERROR - Incorrect Parameter, early_start = %0d (Valid range : 0 to 1)",early_start);
	 err_flag = 1;
      end
      
      if ((input_mode == 0) && (early_start == 1)) begin
	 $display("%m ERROR - Incorrect Parameter combination,input_mode=0 and early_start=1");
	 err_flag = 1;
      end
      
      if (err_flag) begin
	 $display("%m ERROR - Simulation stopped due to incorrect parameter values");
	 #1 $finish;
      end
   end
   //----------------------------------------------------------------------   
   // cadence translate_on
   // synopsys translate_on      
   //----------------------------------------------------------------------
   
endmodule // DW_mult_seq
//------------------------------End of file-----------------------------


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



  // Instance of DW_mult_seq
  DW_mult_seq #(a_width, b_width, tc_mode, num_cyc, rst_mode, input_mode, output_mode, early_start) DW_MULT_SEQ(
    .clk(clk), .rst_n(~rst), .hold(1'b0), .start(start_pulse), .a(a), .b(b),
    .complete(complete), .product(p));


  assign rdl = (mul_type == ORV64_MUL_TYPE_W) ? { {32{p[31]}}, p[31:0] } : p[63:0];
  assign rdh = p[127:64];

endmodule
