// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*
  Cache Debug Access

  Valid/Dirty/Tag/Data Rams Read/Write
  (Data Ram is accessed 64-bit at a time)

  Read/write address bus is decoded according to following table

  +-------------------------------------------------------------------------+
  | target  | way_id       | data_chunk_id       | index            | align |
  +-------------------------------------------------------------------------+
  | 3 bits  | WAY_ID_WIDTH | DATA_CHUNK_ID_WIDTH | BANK_INDEX_WIDTH | 3'b0  |
  +-------------------------------------------------------------------------+
*/

`ifndef _CACHE_DA_RW__SV_
`define _CACHE_DA_RW__SV_

module cache_da_rw
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import cache_da_cfg::*;
(
  input                   clk,
  input                   rstn,

  // OURS RING
  // AR
  input  logic 				  ring_req_if_arvalid,
  output logic 				  ring_req_if_arready,
  input  oursring_req_if_ar_t             ring_req_if_ar,
  // AW
  input  logic 				  ring_req_if_awvalid,
  output logic 				  ring_req_if_awready,
  input  oursring_req_if_aw_t             ring_req_if_aw,
   // W
  input  logic 				  ring_req_if_wvalid,
  output logic 				  ring_req_if_wready,
  input  oursring_req_if_w_t              ring_req_if_w,
  // R 
  output logic 				  ring_resp_if_rvalid,
  input  logic 				  ring_resp_if_rready,
  output oursring_resp_if_r_t             ring_resp_if_r,
  // B
  output logic 				  ring_resp_if_bvalid,
  input  logic 				  ring_resp_if_bready,
  output oursring_resp_if_b_t             ring_resp_if_b,

  // L2
  output debug_en,
  output debug_rw,
  output mem_data_t debug_wdata,
  output bank_index_t debug_addr,
  input  cpu_data_t debug_rdata,

    // Tag Ram
  output [N_WAY - 1 : 0] debug_tag_ram_en_pway,
    // Data Ram
  output [N_WAY * N_DATA_RAM_BANK - 1 : 0] debug_data_ram_en_pway,
  output cpu_byte_mask_t debug_wdata_byte_mask,
    // Valid Ram
  output debug_valid_ram_en,
  output [N_WAY - 1 : 0] debug_valid_dirty_bit_mask,
    // Dirty Ram
  output debug_dirty_ram_en,
  output debug_lru_ram_en,
    // Performance counter
  output debug_hpmcounter_en,
  // TODO
  input  debug_ready
);

  // OURS RING
  da_state_t    rff_state;
  da_state_t    next_state;
  ring_tid_t    dff_tid;
  ring_tid_t    next_tid;
  axi4_resp_t   dff_resp;
  axi4_resp_t   next_resp;
  logic         bad_target;
  ram_id_t      dff_target;
  ram_id_t      next_target;
  way_id_t      next_way_id;
  bank_index_t  next_addr;

  // L2
  logic next_debug_en;
  logic dff_rw;
  logic next_rw;
  logic vld_use_batch;

  // Tag Ram
  logic [N_WAY - 1 : 0] next_tag_ram_en_pway;
  // Data Ram
  logic [N_WAY * N_DATA_RAM_BANK - 1 : 0] next_data_ram_en_pway;
  // Valid Ram
  logic next_vld_ram_en;
  // Dirty Ram
  logic next_dirty_ram_en;
  // LRU Ram
  logic next_lru_ram_en;
  // Performance counter
  logic next_hpmcounter_en;

  logic [DATA_CHUNK_ID_WIDTH-1:0] next_datachunk_id;

  // Flops
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_state <= DA_IDLE;
    end else begin
      rff_state <= next_state;
    end
    if ((rff_state == DA_IDLE) & ((ring_req_if_awvalid & ring_req_if_wvalid) | ring_req_if_arvalid)) begin
      dff_rw      <= next_rw;
      dff_resp    <= next_resp;
      dff_tid     <= next_tid;
      dff_target  <= next_target;
    end
  end

  // next state. Note that RAM block guarantee that debug access has highest
  // priority so both read/write takes one cycle. There is no flow control.
  always_comb begin
    next_state = rff_state;
    next_rw    = dff_rw;
    next_resp  = dff_resp;
    next_tid   = dff_tid;

    case (rff_state)
      DA_IDLE: begin
        if (ring_req_if_awvalid & ring_req_if_wvalid) begin
          next_state = bad_target ? DA_WR_ACK : DA_REQ;
          next_resp  = bad_target ? AXI_RESP_DECERR : AXI_RESP_OKAY;
          next_tid   = ring_req_if_aw.awid;
          next_rw    = 1'b1;
        end else if (ring_req_if_arvalid) begin
          next_state = bad_target ? DA_RD_ACK : DA_REQ;
          next_resp  = bad_target ? AXI_RESP_DECERR : AXI_RESP_OKAY;
          next_tid   = ring_req_if_ar.arid;
          next_rw    = 1'b0;
        end
      end
      DA_REQ: begin
        next_state = dff_rw ? DA_WR_ACK : DA_RD_ACK;
      end
      DA_WR_ACK: begin
        if (ring_resp_if_bready)
          next_state = DA_IDLE;
      end
      DA_RD_ACK: begin
        if (ring_resp_if_rready)
          next_state = DA_IDLE;
      end
    endcase
  end

  // next
  assign next_debug_en      = (rff_state == DA_REQ);
  assign vld_use_batch      = (next_datachunk_id == '1 && dff_target == VLDRAM);
  assign next_target        = next_rw ?
                              ram_id_t'(ring_req_if_aw.awaddr[WAY_ID_WIDTH + DATA_CHUNK_ID_WIDTH + BANK_INDEX_WIDTH + 3 +: 3]) :
                              ram_id_t'(ring_req_if_ar.araddr[WAY_ID_WIDTH + DATA_CHUNK_ID_WIDTH + BANK_INDEX_WIDTH + 3 +: 3]);
  assign bad_target         = (next_target >= ILLEGAL);
  assign next_way_id        = dff_rw ?
                              way_id_t'(ring_req_if_aw.awaddr[DATA_CHUNK_ID_WIDTH + BANK_INDEX_WIDTH + 3 +: WAY_ID_WIDTH]) :
                              way_id_t'(ring_req_if_ar.araddr[DATA_CHUNK_ID_WIDTH + BANK_INDEX_WIDTH + 3 +: WAY_ID_WIDTH]);
  assign next_datachunk_id  = dff_rw ?
                              ring_req_if_aw.awaddr[BANK_INDEX_WIDTH + 3 +: DATA_CHUNK_ID_WIDTH] :
                              ring_req_if_ar.araddr[BANK_INDEX_WIDTH + 3 +: DATA_CHUNK_ID_WIDTH];
  assign next_addr          = dff_rw ?
                              bank_index_t'(ring_req_if_aw.awaddr[BANK_INDEX_WIDTH-1 + 3 -: BANK_INDEX_WIDTH]) :
                              bank_index_t'(ring_req_if_ar.araddr[BANK_INDEX_WIDTH-1 + 3 -: BANK_INDEX_WIDTH]);

  assign next_vld_ram_en    = ((rff_state == DA_REQ) && (dff_target == VLDRAM)) ? 1'b1 : 1'b0;
  assign next_dirty_ram_en  = ((rff_state == DA_REQ) && (dff_target == DIRTYRAM)) ? 1'b1 : 1'b0;
  assign next_tag_ram_en_pway = ((rff_state == DA_REQ) && (dff_target == TAGRAM)) ? (({N_WAY{1'b0}} | 1'b1) << next_way_id) : '0;
  assign next_data_ram_en_pway = ((rff_state == DA_REQ) && (dff_target == DATARAM)) ? (({N_WAY * N_DATA_RAM_BANK{1'b0}} | 1'b1) << (next_way_id * N_DATA_RAM_BANK)) : '0;
  assign next_lru_ram_en    = ((rff_state == DA_REQ) && (dff_target == LRURAM)) ? 1'b1 : 1'b0;
  assign next_hpmcounter_en = ((rff_state == DA_REQ) && (dff_target == HPMCOUNTER)) ? 1'b1 : 1'b0;

  // Output
  // Passing Through
  assign debug_en             = next_debug_en;
  assign debug_valid_ram_en   = next_vld_ram_en;
  assign debug_dirty_ram_en   = next_dirty_ram_en;
  assign debug_tag_ram_en_pway = next_tag_ram_en_pway;
  assign debug_data_ram_en_pway = next_data_ram_en_pway;
  assign debug_lru_ram_en     = next_lru_ram_en;
  assign debug_hpmcounter_en  = next_hpmcounter_en;
  assign debug_rw             = dff_rw;
  assign debug_wdata          = ring_req_if_w.wdata;
  assign debug_addr           = next_addr;

  // Response to OURS Ring
  assign ring_resp_if_r.rid     = dff_tid;
  assign ring_resp_if_rvalid  = (rff_state == DA_RD_ACK);
  assign ring_resp_if_r.rresp   = dff_resp;
  assign ring_resp_if_r.rlast   = 1'b1;
  assign ring_resp_if_r.rdata = (dff_target == DATARAM) ?
                             debug_rdata[{next_datachunk_id, 6'b0} +: 64] :
                             debug_rdata[63:0];

  assign ring_resp_if_b.bid     = dff_tid;
  assign ring_resp_if_b.bresp   = dff_resp;
  assign ring_resp_if_bvalid  = (rff_state == DA_WR_ACK);

  // send ready back once request is accepted
  assign ring_req_if_awready = (rff_state == DA_REQ) & dff_rw;
  assign ring_req_if_wready  = (rff_state == DA_REQ) & dff_rw;
  assign ring_req_if_arready = (rff_state == DA_REQ) & ~dff_rw;

  // data byte mask
  localparam SLICE_WIDTH = (RING_DATA_WIDTH / 8); // (4 bits enable 32-bit for read/write)
  generate
    for (genvar i = 0; i < MEM_BURST_LEN / N_DATA_RAM_BANK; i ++)
      assign debug_wdata_byte_mask[(i + 1) * SLICE_WIDTH - 1 : i * SLICE_WIDTH] = {SLICE_WIDTH{i == next_datachunk_id}};
  endgenerate

  // vld/dirty bit mask
  generate
    for (genvar i = 0; i < N_WAY; i ++)
      assign debug_valid_dirty_bit_mask[i] = vld_use_batch ? '1 : (i == next_way_id);
  endgenerate

endmodule
`endif
