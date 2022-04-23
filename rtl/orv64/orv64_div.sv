// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module DW_div_seq (
                   clk, 
                   rst_n,
                   hold,
                   start,
                   a,
                   b,
                   complete,
                   divide_by_0,
                   quotient,
                   remainder
                   );
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

// Internal parameters
   
parameter  actual_cyc   = num_cyc - (1 - input_mode)
                        - (1 - output_mode) - early_start;

parameter  counter_width = (actual_cyc+1) > 8388608 ? 24 :
  ((actual_cyc+1) > 4194304   ? 23 :
   ((actual_cyc+1) > 2097152   ? 22 :
    ((actual_cyc+1) > 1048576   ? 21 :
     ((actual_cyc+1) > 524288    ? 20 :
      ((actual_cyc+1) > 262144    ? 19 :
       ((actual_cyc+1) > 131072    ? 18 :
        ((actual_cyc+1) > 65536     ? 17 :
         ((actual_cyc+1) > 32768     ? 16 :
          ((actual_cyc+1) > 16384     ? 15 :
           ((actual_cyc+1) > 8192      ? 14 :
            ((actual_cyc+1) > 4096      ? 13 :
             ((actual_cyc+1) > 2048      ? 12 :
              ((actual_cyc+1) > 1024      ? 11 :
               ((actual_cyc+1) > 512       ? 10 :
                ((actual_cyc+1) > 256       ? 9 :
                 ((actual_cyc+1) > 128       ? 8 :
                  ((actual_cyc+1) > 64        ? 7 :
                   ((actual_cyc+1) > 32        ? 6 :
                    ((actual_cyc+1) > 16        ? 5 :
                     ((actual_cyc+1) > 8         ? 4 :
                      ((actual_cyc+1) > 4         ? 3 :
                       ((actual_cyc+1) > 2 ? 2 : 1))))))))))))))))))))));

   parameter remain    = (a_width) % actual_cyc; 
   parameter norm_cnt  = remain == 0 ? (a_width) / actual_cyc
                                    : (a_width) / actual_cyc + 1;
   parameter max_cyc   = (a_width > ((a_width/norm_cnt)*norm_cnt))
                         ? ((a_width/norm_cnt) + 1)
                         : a_width/norm_cnt;
   parameter last_step = a_width - (norm_cnt * (max_cyc-1));


//----------------------------------------------------------------------
// input declaration
//----------------------------------------------------------------------
input [a_width-1:0]    a         ;
input [b_width-1:0]    b         ;
input                  clk       ;
input                  rst_n     ;
input                  hold      ;
input                  start     ;

//----------------------------------------------------------------------
// output declaration
//----------------------------------------------------------------------
output [a_width-1 : 0] quotient   ;
output [b_width-1 : 0] remainder  ;
output                 complete   ;
output                 divide_by_0;

//----------------------------------------------------------------------
// reg declaration
//----------------------------------------------------------------------
reg [b_width-1:0]        latch_dvsr    ;
reg [a_width+b_width:0]  temp_r_q      ;
reg [a_width+b_width:0]  last_temp_r_q ;
reg [counter_width-1:0]  counter       ;
reg                      sign          ;
reg                      dvd_sign      ;
reg                      overflow_latch;
reg                      latched_b_is_0;
   
//----------------------------------------------------------------------
// wire declaration
//----------------------------------------------------------------------
wire 		          a_rst_n  ;
wire 		          ext_count; 
wire [b_width-1:0] 	  b_in     ; 
wire [a_width-1:0] 	  a_in     ;
wire                      overflow ;
wire                      dummy0   ;
wire 		          dummy1   ;
wire                      b_is_0   ;
   
// -------------------------------------------------------------------
// -- Assignments of nets
// -------------------------------------------------------------------
assign    {dummy0,quotient}  =  (overflow_latch && tc_mode) 
                                 ? {1'b0,{a_width-1{1'b1}}}
                                  : (( sign && tc_mode)
                                    ? (-temp_r_q[a_width-1:0])
                                    : temp_r_q[a_width-1:0]);

assign    {dummy1,remainder} = (overflow_latch && tc_mode )
                                 ? {b_width{1'b1}}
                                 : ((tc_mode && dvd_sign) 
                                    ? (-temp_r_q[a_width+b_width:a_width])
                                    : temp_r_q[a_width+b_width:a_width]);

assign     b_is_0 = (b_in == {b_width{1'b0}});
assign     divide_by_0 = start ? b_is_0 : latched_b_is_0;
assign     complete    = ext_count && ~start                           ;
assign     overflow    = (~|a[a_width-2:0]) & (&b) & a[a_width-1]      ;
assign     a_rst_n     = (rst_mode == 0)             ? rst_n : 1'b1    ;
assign     ext_count   = (counter == actual_cyc)     ? 1'b1  : 1'b0    ;
assign     a_in        = (tc_mode && (a[a_width-1])) ? (-a)  : a       ;
assign     b_in        = (tc_mode && (b[b_width-1])) ? (-b)  : b       ;

// -------------------------------------------------------------------
// -- Synchronous blocks
// -------------------------------------------------------------------
always @ (posedge clk or negedge a_rst_n)
  begin :seq_block
     reg dummy2;
     if (~a_rst_n) 
       begin
	  latch_dvsr         <= {b_width{1'b0}}            ;
	  sign               <= 1'b0                       ; 
	  dvd_sign           <= 1'b0                       ;
	  temp_r_q           <= {a_width+b_width+1{1'b0}}  ;
	  {dummy2,counter}   <= {counter_width+1{1'b0}}    ;
	  overflow_latch     <= 1'b0                       ;
	  latched_b_is_0   <= 1'b0			   ;
       end
     else
       if (~rst_n) 
       begin
	    latch_dvsr       <= {b_width{1'b0}}            ;
	    sign             <= 1'b0                       ; 
	    dvd_sign         <= 1'b0                       ;
	    temp_r_q         <= {a_width+b_width+1{1'b0}}  ;
	    {dummy2,counter} <= {counter_width+1{1'b0}}    ;
	    overflow_latch   <= 1'b0                       ;
	    latched_b_is_0   <= 1'b0			   ;
       end        
       else
	 if (start)
         begin
           latch_dvsr        <= b_in                        ;
           sign              <= a[a_width-1] ^ b[b_width-1] ;   
           dvd_sign          <= a[a_width-1]                ;
           temp_r_q          <= {{b_width+1{1'b0}},a_in}    ;
           {dummy2, counter} <= {counter_width+1{1'b0}}     ;
           overflow_latch    <= overflow                    ;
	   latched_b_is_0    <= b_is_0			    ;
         end
	 else 
           if(~hold)
           begin  
             if(~ext_count)
             begin 
               temp_r_q          <=  last_temp_r_q          ;
               {dummy2, counter} <= counter + 1'b1          ; 
             end
           end
end // always

always @ (temp_r_q  or latch_dvsr or counter)
  begin: DIVIDER_LOGIC
     reg [a_width+b_width :0] array_r_q [norm_cnt +1:0]    ;
     reg [a_width+b_width :0] operating_r_q                ;
     reg [b_width :0]         sub_r_q                      ;
     reg 		      dummy3                       ;
     reg 		      dummy4                       ;
     integer 		      count                        ;

     dummy3 = 1'b0;
     for(count = 0 ; count  < norm_cnt +1 ; count = count +1)
       array_r_q[count] = {dummy3,{(a_width+b_width){1'b0}}};
       array_r_q[0] = temp_r_q;

       for(count = 0 ; count < norm_cnt ; count = count +1)
       begin
         operating_r_q = array_r_q[count];
         {dummy4,operating_r_q} = operating_r_q <<1;
         {dummy4,sub_r_q} = (operating_r_q[a_width+b_width:a_width] - latch_dvsr);
         if(sub_r_q[b_width] )
         begin
           operating_r_q[0] = 1'b0;
           array_r_q[count+1] = operating_r_q;
         end
         else
             array_r_q[count+1] = {sub_r_q,operating_r_q[a_width-1:1], 1'b1};
         end // for (count =0;count < norm_cnt;count= count +1)

          
   if(remain != 0)
   begin
     if(counter < max_cyc-1)
         last_temp_r_q = array_r_q[norm_cnt];
       else
       if(counter == max_cyc-1 )
           last_temp_r_q = array_r_q[last_step];
         else
           last_temp_r_q = array_r_q[0];
     end
   else
     last_temp_r_q = array_r_q[norm_cnt];
  end // block: DIVIDER_LOGIC
  
//----------------------------------------------------------------------   
// cadence translate_off
// synopsys translate_off   
//----------------------------------------------------------------------
   initial
   begin : parameter_check
      integer err_flag;
      err_flag = 0;
      
      if (a_width < 3) begin
	 err_flag = 1;
	 $display( "%m ERROR - Incorrect Parameter, a_width = %0d (Valid range : >=3)",a_width);
	 err_flag = 1;    
      end
      
      if ((b_width < 3) || (b_width > a_width)) begin
	 $display("%m ERROR - Incorrect Parameter, b_width = %0d (Valid range : 3 to a_width)",b_width);
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
   
endmodule // DW_div_seq          
//------------------------------End of file-----------------------------





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

  DW_div_seq #(a_width, b_width, tc_mode, num_cyc, rst_mode, input_mode, output_mode, early_start) DW_DIV_SEQ(
    .clk(clk), .rst_n(~rst), .hold(1'b0), .start(start_pulse), .a(a), .b(b),
    .complete(int_complete), .divide_by_0(), .quotient(q), .remainder(r));

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
