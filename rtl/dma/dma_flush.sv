// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module dma_flush
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter THREAD_ID = 1
) (
  input   ring_addr_t       s2b_dma_flush_addr,
  input   dma_flush_type_t  s2b_dma_flush_req_type,
  input   logic             s2b_dma_flush_cmd_vld,
  output  logic             b2s_dma_flush_cmd_vld_wdata,

  output  logic             dma_flush_req_vld,
  output  dma_req_t         dma_flush_req,
  input   logic             dma_flush_req_rdy,

  input   logic             dma_flush_rsp_vld,
  input   dma_rsp_t         dma_flush_rsp,
  output  logic             dma_flush_rsp_rdy,

  input   logic             clk,
  input   logic             rstn
);

  localparam CNT_WIDTH = (WAY_ID_WIDTH + BANK_ID_WIDTH + BANK_INDEX_WIDTH);
  localparam NUM_FLUSH_ALL_REQ = (1 << (BANK_ID_WIDTH + WAY_ID_WIDTH + BANK_INDEX_WIDTH)) - 1;

  enum logic [1:0] {
    ST_IDLE         = 2'b00,
    ST_FLUSH_REQ    = 2'b01,
    ST_BAD_REQ      = 2'b10,
    ST_WAIT_FOR_RSP = 2'b11
  } rff_state, next_state;

  logic [CNT_WIDTH-1:0] rff_flush_rsp_cnt, rff_flush_req_cnt;
  logic [CNT_WIDTH-1:0] next_flush_rsp_cnt, next_flush_req_cnt;
  paddr_t paddr, cnt_casted;

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_state <= ST_IDLE;
      rff_flush_req_cnt <= '0;
      rff_flush_rsp_cnt <= '0;
    end else begin
      rff_state <= next_state;
      rff_flush_req_cnt <= next_flush_req_cnt;
      rff_flush_rsp_cnt <= next_flush_rsp_cnt;
    end
  end

  always_comb begin
    next_state = rff_state;
    next_flush_req_cnt = rff_flush_req_cnt;
    b2s_dma_flush_cmd_vld_wdata = s2b_dma_flush_cmd_vld;
    case(rff_state)
      ST_IDLE: begin
        if (s2b_dma_flush_cmd_vld) begin
          if (s2b_dma_flush_req_type == DMA_FLUSH_ALL) begin
            next_flush_req_cnt = NUM_FLUSH_ALL_REQ;
            next_state = ST_FLUSH_REQ;
          end else if ((s2b_dma_flush_req_type == DMA_FLUSH_ADDR) | (s2b_dma_flush_req_type == DMA_FLUSH_IDX)) begin
            next_flush_req_cnt = 16'h0;
            next_state = ST_FLUSH_REQ;
          end else begin
            next_state = ST_BAD_REQ;
          end
        end
      end
      ST_FLUSH_REQ: begin
        if (dma_flush_req_rdy) begin
          next_flush_req_cnt = rff_flush_req_cnt - 16'h1;
          next_state = (rff_flush_req_cnt == '0) ? ST_WAIT_FOR_RSP: ST_FLUSH_REQ;
        end
      end
      ST_BAD_REQ: begin
        b2s_dma_flush_cmd_vld_wdata = '0;
        next_state = ST_IDLE;
      end
      ST_WAIT_FOR_RSP: begin
        if (rff_flush_rsp_cnt == '0) begin
          b2s_dma_flush_cmd_vld_wdata = '0;
          next_state = ST_IDLE;
        end
      end
      default: begin
        next_state = ST_IDLE;
      end
    endcase
  end

  always_comb begin
    next_flush_rsp_cnt = rff_flush_rsp_cnt;
    case(rff_state)
      ST_IDLE: begin
        if (s2b_dma_flush_cmd_vld) begin
          if (s2b_dma_flush_req_type == DMA_FLUSH_ALL) begin
            next_flush_rsp_cnt = NUM_FLUSH_ALL_REQ;
          end else if ((s2b_dma_flush_req_type == DMA_FLUSH_ADDR) | (s2b_dma_flush_req_type == DMA_FLUSH_IDX)) begin
            next_flush_rsp_cnt = 16'h1;
          end
        end
      end
      ST_FLUSH_REQ, ST_WAIT_FOR_RSP: begin
        if (dma_flush_rsp_vld & dma_flush_rsp_rdy) begin
          next_flush_rsp_cnt = rff_flush_rsp_cnt - 16'h1;
        end
      end
    endcase
  end

  assign dma_flush_rsp_rdy = 1'b1;
  assign dma_flush_req_vld = (rff_state == ST_FLUSH_REQ);

  assign cnt_casted = ~(rff_flush_req_cnt)  << OFFSET_WIDTH;

  always_comb begin
    paddr = s2b_dma_flush_addr;
    if (s2b_dma_flush_req_type == DMA_FLUSH_ALL) begin
      paddr[WAY_ID_MSB:WAY_ID_LSB] = cnt_casted[WAY_ID_MSB:WAY_ID_LSB];
      paddr[BANK_ID_MSB:BANK_ID_LSB] = cnt_casted[BANK_ID_MSB:BANK_ID_LSB];
      paddr[BANK_INDEX_MSB:BANK_INDEX_LSB] = cnt_casted[BANK_INDEX_MSB:BANK_INDEX_LSB];
      paddr[OFFSET_WIDTH-1:0] = '0;
    end
  end

  assign dma_flush_req.tid[6]    = 1'b1; // not DMA thread
  assign dma_flush_req.tid[5:4]  = THREAD_ID; // Thread ID
  assign dma_flush_req.tid[3:0]  = rff_flush_req_cnt[3:0];
  assign dma_flush_req.chk = '0;
  assign dma_flush_req.req_type = (s2b_dma_flush_req_type == DMA_FLUSH_ADDR) ? REQ_FLUSH_ADDR: REQ_FLUSH_IDX;
  assign dma_flush_req.addr = paddr;
  assign dma_flush_req.wdata = '0;

endmodule

