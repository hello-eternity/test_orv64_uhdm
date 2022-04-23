// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//===========================================================================================
// Description:
//  A perfect L2$ model. For simulation only.
//  The access is always hit.
//  The request and response can be back-to-back but latency is parameterized.
//===========================================================================================

module ot_perfect_l2_model
import pygmy_typedef::*;
import pygmy_intf_typedef::*;
    #( parameter L2_PORT_CNT = 8,
       parameter REQ_LATENCY = 4,
       parameter RESP_LATENCY = 4
    )
    (
    input   clk,
    input   rstn,

    //------------------------------------------------------
    input   logic                [L2_PORT_CNT-1:0] cpu_req_valid,
    output  logic                [L2_PORT_CNT-1:0] cpu_req_ready,
    input   cpu_cache_if_req_t   [L2_PORT_CNT-1:0] cpu_req,
 
    //------------------------------------------------------
    // atomic 
    input  logic                [L2_PORT_CNT-1:0] cpu_amo_store_req_valid, 
    input  cpu_cache_if_req_t   [L2_PORT_CNT-1:0] cpu_amo_store_req, 
    output logic                [L2_PORT_CNT-1:0] cpu_amo_store_req_ready, 
    //------------------------------------------------------  
 
    output  logic                [L2_PORT_CNT-1:0] cpu_resp_valid,
    input   logic                [L2_PORT_CNT-1:0] cpu_resp_ready,
    output  cpu_cache_if_resp_t  [L2_PORT_CNT-1:0] cpu_resp

    );

    localparam PORT_ID_WIDTH = (L2_PORT_CNT > 1) ? $clog2(L2_PORT_CNT): 1;
    
    logic [32-1:0] array_data [bit[36:0]];    // This is word addressed, so 37 bit idx = 39 bit byte addr

    //-------- add latency on the req paths
    logic                [L2_PORT_CNT-1:0] cpu_req_srdy_delayed;
    logic                [L2_PORT_CNT-1:0] cpu_req_drdy_delayed;
    cpu_cache_if_req_t   [L2_PORT_CNT-1:0] cpu_req_info_delayed;

    cpu_cache_if_req_t   [L2_PORT_CNT-1:0] cpu_req_masked;

    logic                [L2_PORT_CNT-1:0] cpu_req_valid_new;
    logic                [L2_PORT_CNT-1:0] cpu_req_ready_new;

    always_comb begin
      for (int i=0; i<L2_PORT_CNT; i++) begin
        cpu_req_masked[i] = cpu_amo_store_req_valid[i] ? cpu_amo_store_req[i] : cpu_req[i];
      end
    end

    always_comb begin
      for (int i=0; i<L2_PORT_CNT; i++) begin
	    cpu_req_valid_new[i] = cpu_amo_store_req_valid[i] ? 1'b1 : cpu_req_valid[i];
	    cpu_amo_store_req_ready[i] = cpu_amo_store_req_valid[i] & cpu_req_ready_new[i]; 
  		cpu_req_ready[i] = ~cpu_amo_store_req_valid[i] & cpu_req_ready_new[i];
      end
    end

generate
    for (genvar ii=0; ii<L2_PORT_CNT; ii++) begin
      sd_ppln_delay_rstn
        #( .width   ($bits(cpu_cache_if_req_t)),
           .latency (REQ_LATENCY)
        )
        req_delay_u
        (
          .clk    (clk),
          .rstn   (rstn),    
        
          .cfg_is_clk_gated   (1'b0),

          .in_srdy    (cpu_req_valid_new[ii]),
          .in_drdy    (cpu_req_ready_new[ii]),
          .in_data    (cpu_req_masked[ii]),
        
          .out_srdy   (cpu_req_srdy_delayed[ii]),
          .out_drdy   (cpu_req_drdy_delayed[ii]),
          .out_data   (cpu_req_info_delayed[ii])
        );
    end
endgenerate
    
    //--------- read or write
    paddr_t [L2_PORT_CNT-1:0] req_paddr_masked;
    logic   [L2_PORT_CNT-1:0] wr_req;
    logic   [L2_PORT_CNT-1:0] rd_req;

    logic [L2_PORT_CNT-1:0]  clear_reservation;
    logic                    reservation_valid;
    logic [PORT_ID_WIDTH-1:0] reserve_port_id;
    paddr_t                  reserve_addr;
     
generate
    for (genvar ii=0; ii<L2_PORT_CNT; ii++) begin    
        assign wr_req[ii] = cpu_req_srdy_delayed[ii] & ((cpu_req_info_delayed[ii].req_type == REQ_WRITE) || (cpu_req_info_delayed[ii].req_type == REQ_AMO_SC) || (cpu_req_info_delayed[ii].req_type == REQ_SC));
        assign rd_req[ii] = cpu_req_srdy_delayed[ii] & ((cpu_req_info_delayed[ii].req_type == REQ_READ) || (cpu_req_info_delayed[ii].req_type == REQ_AMO_LR) || (cpu_req_info_delayed[ii].req_type == REQ_LR) || (cpu_req_info_delayed[ii].req_type == REQ_SC) || (cpu_req_info_delayed[ii].req_type == REQ_BARRIER_SYNC));
    end
endgenerate    

    always_comb begin
      for(int ii=0; ii<L2_PORT_CNT; ii++) begin
        req_paddr_masked[ii] = cpu_req_info_delayed[ii].req_paddr;
        req_paddr_masked[ii][4:0] = 5'h00;
      end
    end
    
    //-------- write
    logic[31:0] struct_addr;
    logic[31:0] addr;
    logic[31:0] len;
    logic[31:0] cnt;
    logic stop_printf;
    integer i;
    integer do_cosim;

    import "DPI-C" context function void cosim_exit_callback();

    bit[$bits(orv64_vaddr_t)-1 : 0] tohost_addr, fromhost_addr;
    initial begin
      tohost_addr = 39'h80001000;
      fromhost_addr = 39'h80001040;
      $value$plusargs("set_tohost_addr=%h", tohost_addr);
      $value$plusargs("set_fromhost_addr=%h", fromhost_addr);
      if ($test$plusargs("cosim")) begin
        do_cosim = 1'b1;
      end else begin
        do_cosim = 1'b0;
      end
    end
    
    always @(posedge clk) begin
      for(int ii=0; ii<L2_PORT_CNT; ii++) begin
        if (~rstn) begin
        end    
        else if (wr_req[ii] & ((cpu_req_info_delayed[ii].req_type != REQ_SC) | clear_reservation[ii])) begin
          for (int kk = 0; kk < 32; kk++) begin
            if (cpu_req_info_delayed[ii].req_mask[kk])
            begin
                array_data[{37{1'b1}} & ((req_paddr_masked[ii]>>2)+kk/4)][(kk%4+1)*8-1 -: 8] = cpu_req_info_delayed[ii].req_data[(kk+1)*8-1 -: 8];
                //$display("%t Write cpu_req_info_delayed[%0d].req_paddr = %h, array_data['h13c50 >> 2] = %h", $time, ii, req_paddr_masked[ii], array_data['h13c50 >> 2]);
            end
          end
          
//--------------------------------------------------------------------------------------------------------------------------------------
          if (req_paddr_masked[ii] == tohost_addr && cpu_req_info_delayed[ii].req_mask[7:0] != 8'h00)
          begin
            //$display("data to write = %h", cpu_req_info_delayed[ii].req_data[32:0]);
            struct_addr = cpu_req_info_delayed[ii].req_data[31:0];
            if (cpu_req_info_delayed[ii].req_data[0:0] == 1'b1)
            begin
                $display("receive exit code: %x", cpu_req_info_delayed[ii].req_data[31:0]);
                if (do_cosim)
                  cosim_exit_callback();
                $finish;
            end
            else
            begin
                if(array_data[struct_addr >> 2] == 32'd64)
                begin
                /*    
                    $display("%d, %d, %x, %d", array_data[struct_addr >> 2], 
                                                        array_data[(struct_addr+32'd8) >> 2], 
			                                            array_data[(struct_addr+32'd16) >> 2], 
                                                        array_data[(struct_addr+32'd24) >> 2], 
                                                        );
                 */  
                    addr = array_data[(struct_addr+32'd16) >> 2];
                    len = array_data[(struct_addr+32'd24) >> 2];
                    /*
                    for (i = 0; i * 4 < len; i = i + 1)
                    begin
                        $write("%c", array_data[(addr >> 2) + i][7:0]);
                        $write("%c", array_data[(addr >> 2) + i][15:8]);
                        $write("%c", array_data[(addr >> 2) + i][23:16]);
                        $write("%c", array_data[(addr >> 2) + i][31:24]);
                        
                    end
                    */
                    i = 0;
                    cnt = 0;
                    stop_printf = 1'b0;
                    while(stop_printf == 1'b0)
                    begin
                        if (cnt >= len)
                        begin
                            stop_printf = 1'b1;
                        end
                        else
                        begin
                            case (cnt[1:0])
                            2'b00:
                                $write("%c", array_data[(addr >> 2) + i][7:0]);
                            2'b01:
                                $write("%c", array_data[(addr >> 2) + i][15:8]);
                            2'b10:
                                $write("%c", array_data[(addr >> 2) + i][23:16]);
                            default: //2'b11:
                                $write("%c", array_data[(addr >> 2) + i][31:24]);
                            endcase
                            cnt = cnt + 1;
                            if (cnt[1:0] == 2'b00)
                            begin
                                i = i + 1;
                            end
                        end
                    end
                    array_data[fromhost_addr >> 2] = 32'b1;
                end
                else
                begin
                    $display("receive unknown syscall: %x", array_data[struct_addr >> 2]);
                    if (do_cosim)
                      cosim_exit_callback();
                    $finish;
                end
            end
//--------------------------------------------------------------------------------------------------------------------------------------

          end
        end
      end  
    end

    //-------- read
    logic                [L2_PORT_CNT-1:0] cpu_resp_srdy_tmp;
    logic                [L2_PORT_CNT-1:0] cpu_resp_drdy_tmp;
    cpu_cache_if_resp_t  [L2_PORT_CNT-1:0] cpu_resp_info_tmp;

   
    always @* begin
      for(int ii=0; ii<L2_PORT_CNT; ii++) begin
        cpu_resp_srdy_tmp[ii] = rd_req[ii];
        clear_reservation[ii] = 1'b0;
    
        cpu_resp_info_tmp[ii].resp_tid =  cpu_req_info_delayed[ii].req_tid;
        cpu_resp_info_tmp[ii].resp_mask = cpu_req_info_delayed[ii].req_mask;
        //$display("%t Read cpu_req_info_delayed[%0d].req_paddr = %h, array_data['h13c50 >> 2] = %h", $time, ii, req_paddr_masked[ii], array_data['h13c50 >> 2]);
 
        cpu_resp_info_tmp[ii].resp_data = ~rstn ? '0 : {(array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+7))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+7)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef : 32'hXXXXXXXX, 
                                      (array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+6))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+6)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef :  32'hXXXXXXXX, 
                                      (array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+5))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+5)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef :  32'hXXXXXXXX, 
                                      (array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+4))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+4)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef :  32'hXXXXXXXX, 
                                      (array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+3))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+3)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef :  32'hXXXXXXXX, 
                                      (array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+2))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+2)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef :  32'hXXXXXXXX, 
                                      (array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+1))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+1)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef :  32'hXXXXXXXX, 
                                      (array_data.exists({37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+0))) ? array_data[{37{cpu_req_srdy_delayed[ii]}} & ((req_paddr_masked[ii]>>2)+0)] : ($test$plusargs("no_unknown_mem")) ? 32'hdeadbeef :  32'hXXXXXXXX};

/*
        cpu_resp_info_tmp[ii].resp_data = ~rstn ? '0 : {array_data[(req_paddr_masked[ii]>>2)+7], 
                                      array_data[(req_paddr_masked[ii]>>2)+6], 
                                      array_data[(req_paddr_masked[ii]>>2)+5], 
                                      array_data[(req_paddr_masked[ii]>>2)+4], 
                                      array_data[(req_paddr_masked[ii]>>2)+3], 
                                      array_data[(req_paddr_masked[ii]>>2)+2], 
                                      array_data[(req_paddr_masked[ii]>>2)+1], 
                                      array_data[(req_paddr_masked[ii]>>2)+0]};
*/
	if ((cpu_req_info_delayed[ii].req_type == REQ_SC)) begin
          if (reservation_valid & (cpu_req_info_delayed[ii].req_paddr == reserve_addr) & (reserve_port_id == PORT_ID_WIDTH'(ii))) begin
            cpu_resp_info_tmp[ii].resp_data = '0;
            clear_reservation[ii] = 1'b1;
          end else begin
            cpu_resp_info_tmp[ii].resp_data = 256'h1;
          end
        end
        /*
        if ($test$plusargs("zero_unknown_mem")) begin
          for(int jj=0; jj<$bits(cpu_resp_info_tmp[ii].resp_data)/8; jj++) begin
            if (cpu_resp_info_tmp[ii].resp_data[jj*8 +: 8] === 8'hXX) begin
              cpu_resp_info_tmp[ii].resp_data[jj*8 +: 8] = 8'h00;
            end
          end
        end
        */
      end
    end

    always_ff @(posedge clk) begin
      if (~rstn) begin
        reservation_valid <= '0;
        reserve_port_id <= '0;
        reserve_addr <= '0;
      end else begin
        for(int ii=0; ii<L2_PORT_CNT; ii++) begin
          if (cpu_req_info_delayed[ii].req_type == REQ_LR) begin
            reservation_valid <= '1;
            reserve_port_id <= PORT_ID_WIDTH'(ii);
            reserve_addr <= cpu_req_info_delayed[ii].req_paddr;
          end else if (|clear_reservation) begin
            reservation_valid <= '0;
            reserve_port_id <= '0;
            reserve_addr <= '0;
          end
        end
      end
    end 

    //-------- resp latency
generate
    for (genvar ii=0; ii<L2_PORT_CNT; ii++) begin   
      sd_ppln_delay_rstn
        #( .width   ($bits(cpu_cache_if_resp_t)),
           .latency (RESP_LATENCY)
        )
        resp_delay_u
        (
          .clk    (clk),
          .rstn   (rstn),    
        
          .cfg_is_clk_gated   (1'b0),

          .in_srdy    (cpu_resp_srdy_tmp[ii]),
          .in_drdy    (cpu_resp_drdy_tmp[ii]),
          .in_data    (cpu_resp_info_tmp[ii]),
    
          .out_srdy   (cpu_resp_valid[ii]),
          .out_drdy   (cpu_resp_ready[ii]),
          .out_data   (cpu_resp[ii])

        );
    end
endgenerate    
    
    //--------- flowcontrol back to the reqs
generate
    for (genvar ii=0; ii<L2_PORT_CNT; ii++) begin
        assign cpu_req_drdy_delayed[ii] = wr_req[ii] ? 1'b1 :
                                          rd_req[ii] ? cpu_resp_drdy_tmp[ii] : 1'b1;
    end
endgenerate    

endmodule

