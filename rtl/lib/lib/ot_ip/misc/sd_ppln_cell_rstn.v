//===========================================================================================
// File   : sd_ppln_cell_rstn.v
// Author : Shrikant S Lnu
//===========================================================================================
// Description:
//    A pipeline cell with srdy/drdy protocol
// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// For more information, please refer to <http://unlicense.org/>
//===========================================================================================

`ifndef __SD_PPLN_CELL_RSTN_V__
`define __SD_PPLN_CELL_RSTN_V__

module sd_ppln_cell_rstn
    #(  parameter   width = 32,
        parameter   pp_type = 1    //0: not pipelined; 1: sd_flop; 2: sd_output; 3: sd_iofull
    )
    (
    input clk,
    input rstn,

    //--------- config
    input   cfg_is_clk_gated, //spyglass disable W240

    //-------- interrupt

    //--------- I/O
    input               c_srdy,
    output              c_drdy,
    input [width-1:0]   c_data,

    output logic                p_srdy,
    input                       p_drdy,
    output logic [width-1:0]    p_data
    );

    logic   rstn_d;
    logic   move_en;

    //================== BODY ========================
generate

	case(pp_type)
	0:
	begin
	    assign p_srdy = c_srdy;
	    assign c_drdy = p_drdy;
	    assign p_data = c_data;

	end
	1:
	begin
	    assign c_drdy = (~rstn)?1'b0:(p_drdy | ~p_srdy);// & rstn_d;
	//     assign c_drdy = (p_drdy | ~p_srdy);
	    assign move_en = c_srdy & (p_drdy | ~p_srdy);

	    always @(posedge clk ) begin
		if (~rstn)
		    p_srdy <= 1'b0;
		else if (p_drdy | ~p_srdy)
		    p_srdy <= move_en;

		if (/*~cfg_is_clk_gated &*/ (p_drdy | ~p_srdy) & move_en) begin
		    p_data <= c_data;
		end

		//rstn_d <= rstn;
	    end

	end
	2:
	begin
	 sd_output_rstn
	    #(.width    (width))
	    sd_output_u
	    (
		.clk        (clk),
		.resetn      (rstn),
		.ic_srdy    (c_srdy),
		.ic_drdy    (c_drdy),
		.ic_data    (c_data),

		.p_srdy     (p_srdy),
		.p_drdy     (p_drdy),
		.p_data     (p_data)
	    );

	end
	3:
	begin
	logic                p_srdy_tmp;
	    logic                p_drdy_tmp;
	    logic [width-1:0]    p_data_tmp;

	    sd_input_rstn
	    #(.width    (width))
	    sd_input_u
	    (
		.clk    (clk),
		.resetn  (rstn),

		.c_srdy (c_srdy),
		.c_drdy (c_drdy),
		.c_data (c_data),

		.ip_srdy    (p_srdy_tmp),
		.ip_drdy    (p_drdy_tmp),
		.ip_data    (p_data_tmp)
	   );

	    sd_output_rstn
	    #(.width    (width))
	    sd_output_u
	    (
		.clk        (clk),
		.resetn      (rstn),

		.ic_srdy    (p_srdy_tmp),
		.ic_drdy    (p_drdy_tmp),
		.ic_data    (p_data_tmp),

		.p_srdy     (p_srdy),
		.p_drdy     (p_drdy),
		.p_data     (p_data)
	    );

	end

	endcase

//if (pp_type == 0) begin: type_0  // not pipelined
//    assign p_srdy = c_srdy;
//    assign c_drdy = p_drdy;
//    assign p_data = c_data;
//  end
//
//  if (pp_type == 1) begin: type_1  // sd_flop
//    assign c_drdy = (p_drdy | ~p_srdy) & rstn_d;
////     assign c_drdy = (p_drdy | ~p_srdy);
//    assign move_en = c_srdy & (p_drdy | ~p_srdy);
//
//    always @(posedge clk ) begin
//        if (~rstn)
//            p_srdy <= 1'b0;
//        else if (p_drdy | ~p_srdy)
//            p_srdy <= move_en;
//
//        if (/*~cfg_is_clk_gated &*/ (p_drdy | ~p_srdy) & move_en) begin
//            p_data <= c_data;
//        end
//
//        rstn_d <= rstn;
//    end
//  end
//
//  if (pp_type == 2) begin: type_2  // sd_output
//    sd_output_rstn
//    #(.width    (width))
//    sd_output_u
//    (
//        .clk        (clk),
//        .resetn      (rstn),
//        .ic_srdy    (c_srdy),
//        .ic_drdy    (c_drdy),
//        .ic_data    (c_data),
//
//        .p_srdy     (p_srdy),
//        .p_drdy     (p_drdy),
//        .p_data     (p_data)
//    );
//  end
//
//  if (pp_type == 3) begin: type_3  // sd_iofull
//    logic                p_srdy_tmp;
//    logic                p_drdy_tmp;
//    logic [width-1:0]    p_data_tmp;
//
//    sd_input_rstn
//    #(.width    (width))
//    sd_input_u
//    (
//        .clk    (clk),
//        .resetn  (rstn),
//
//        .c_srdy (c_srdy),
//        .c_drdy (c_drdy),
//        .c_data (c_data),
//
//        .ip_srdy    (p_srdy_tmp),
//        .ip_drdy    (p_drdy_tmp),
//        .ip_data    (p_data_tmp)
//   );
//
//    sd_output_rstn
//    #(.width    (width))
//    sd_output_u
//    (
//        .clk        (clk),
//        .resetn      (rstn),
//
//        .ic_srdy    (p_srdy_tmp),
//        .ic_drdy    (p_drdy_tmp),
//        .ic_data    (p_data_tmp),
//
//        .p_srdy     (p_srdy),
//        .p_drdy     (p_drdy),
//        .p_data     (p_data)
//    );
//  end

endgenerate


endmodule
`endif  // __SD_PPLN_CELL_RSTN_V__
// Local Variables:
// verilog-typedef-regexp:"_[t]$"
// verilog-library-directories:("." "./*")
// verilog-library-extensions:(".v" ".vh")
// verilog-auto-inst-param-value:t
// verilog-auto-ignore-concat:nil
