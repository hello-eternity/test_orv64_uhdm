module dma_dbg
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_dma_pkg::*;
#(
  parameter THREAD_ID = 0
) (
  input  logic                ring_req_if_arvalid,
  output logic                ring_req_if_arready,
  input  oursring_req_if_ar_t ring_req_if_ar,
  input  logic                ring_req_if_awvalid,
  output logic                ring_req_if_awready,
  input  oursring_req_if_aw_t ring_req_if_aw,
  input  logic                ring_req_if_wvalid,
  output logic                ring_req_if_wready,
  input  oursring_req_if_w_t  ring_req_if_w,

  output logic                ring_resp_if_rvalid,
  input  logic                ring_resp_if_rready,
  output oursring_resp_if_r_t ring_resp_if_r,
  output logic                ring_resp_if_bvalid,
  input  logic                ring_resp_if_bready,
  output oursring_resp_if_b_t ring_resp_if_b,

  output  logic          dma_dbg_req_vld,
  output  dma_req_t      dma_dbg_req,
  input   logic          dma_dbg_req_rdy,

  input   logic          dma_dbg_rsp_vld,
  input   dma_rsp_t      dma_dbg_rsp,
  output  logic          dma_dbg_rsp_rdy,

  input   logic          clk,
  input   logic          rstn
);

  enum logic [3:0] {
    ST_IDLE        = 4'b0000,
    ST_WR_EXE      = 4'b0001,
    ST_RD_EXE      = 4'b0010,
    ST_WR_RESP     = 4'b0011,
    ST_RD_RESP     = 4'b0100,
    ST_WR_EXE_ERR  = 4'b0101,
    ST_RD_EXE_ERR  = 4'b0110,
    ST_WR_EXE_RESP = 4'b0111,
    ST_RD_EXE_RESP = 4'b1000
  } rff_state, next_state;

  ring_addr_t         rff_dma_req_addr, next_dma_req_addr;
  ring_data_t         rff_wdata, next_wdata;
  ring_strb_t         rff_req_mask, next_req_mask;
  ring_tid_t          rff_tid, next_tid;
  dma_dbg_req_type_t  rff_req_type;

  ring_addr_t         rff_ring_addr, next_ring_addr;

  ring_addr_t         addr_increment_val;
  axi4_resp_t         dbg_reg_resp;
  ring_data_t         dbg_reg_rdata;

  cpu_req_type_t      dma_req_type;

  logic               is_8B_access;
  logic               do_incr_addr;
  logic               is_dst_addr_oursring;
  logic               is_dma_wr_req, is_dma_wr_req_err;
  logic               is_dma_rd_req, is_dma_rd_req_err;

  assign is_8B_access = (rff_req_type == DMA_DEBUG_WR_8B) | (rff_req_type == DMA_DEBUG_RD_8B);

  assign is_dma_wr_req = (ring_req_if_aw.awaddr[STATION_DMA_RING_ADDR_WIDTH-STATION_DMA_BLKID_WIDTH-1:0] == STATION_DMA_DMA_DEBUG_WR_DATA_OFFSET);
  assign is_dma_wr_req_err = ~((rff_req_type == DMA_DEBUG_WR_4B) | ((rff_req_type == DMA_DEBUG_WR_8B) & ~rff_dma_req_addr[2]));

  assign is_dma_rd_req = (ring_req_if_ar.araddr[STATION_DMA_RING_ADDR_WIDTH-STATION_DMA_BLKID_WIDTH-1:0] == STATION_DMA_DMA_DEBUG_RD_DATA_OFFSET);
  assign is_dma_rd_req_err = ~((rff_req_type == DMA_DEBUG_RD_4B) | ((rff_req_type == DMA_DEBUG_RD_8B) & ~rff_dma_req_addr[2]));

  assign is_dst_addr_oursring = ~rff_dma_req_addr[31];

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_state <= ST_IDLE;
      rff_tid <= '0;
      rff_wdata <= '0;
      rff_req_mask <= '0;
      rff_ring_addr <= '0;
    end else begin
      rff_state <= next_state;
      rff_tid <= next_tid;
      rff_wdata <= next_wdata;
      rff_req_mask <= next_req_mask;
      rff_ring_addr <= next_ring_addr;
    end
  end

  always_comb begin
    next_state = rff_state;
    next_tid = rff_tid;
    next_wdata = rff_wdata;
    next_req_mask = rff_req_mask;
    next_dma_req_addr = rff_dma_req_addr;
    next_ring_addr = rff_ring_addr;

    ring_req_if_awready = '0;
    ring_req_if_wready = '0;
    ring_req_if_arready = '0;
    case (rff_state)
      ST_IDLE: begin
        if (ring_req_if_awvalid & ring_req_if_wvalid) begin
          ring_req_if_awready = '1;
          ring_req_if_wready = '1;
          next_tid = ring_req_if_aw.awid;
          if (is_dma_wr_req) begin
            next_dma_req_addr = ring_req_if_aw.awaddr;
            next_state = is_dma_wr_req_err ? ST_WR_EXE_ERR: ST_WR_EXE;
            next_wdata = ring_req_if_w.wdata;
            next_req_mask = ring_req_if_w.wstrb;
          end else begin
            next_ring_addr = ring_req_if_aw.awaddr;
            next_state = ST_WR_RESP;
          end
        end else if (ring_req_if_arvalid) begin
          ring_req_if_arready = '1;
          next_tid = ring_req_if_ar.arid;
          if (is_dma_rd_req) begin
            next_dma_req_addr = ring_req_if_ar.araddr;
            next_state = (is_dma_rd_req_err) ? ST_RD_EXE_ERR: ST_RD_EXE;
            next_req_mask = is_8B_access ? 8'hff: (ring_req_if_ar.araddr[2] ? 8'hf0: 8'h0f);
          end else begin
            next_ring_addr = ring_req_if_ar.araddr;
            next_state = ST_RD_RESP;
          end
        end
      end
      ST_WR_EXE: begin
        if (dma_dbg_req_rdy) begin
          next_state = ST_WR_EXE_RESP;
        end
      end
      ST_RD_EXE: begin
        if (dma_dbg_req_rdy) begin
          next_state = ST_RD_EXE_RESP;
        end
      end
      ST_WR_RESP, ST_WR_EXE_ERR, ST_WR_EXE_RESP: begin
        if (ring_resp_if_bvalid & ring_resp_if_bready) begin
          next_state = ST_IDLE;
        end
      end
      ST_RD_RESP, ST_RD_EXE_ERR, ST_RD_EXE_RESP: begin
        if (ring_resp_if_rvalid & ring_resp_if_rready) begin
          next_state = ST_IDLE;
        end
      end
      default: begin
        next_state = ST_IDLE;
      end
    endcase
  end

  //==========================================================
  // Oursring write responses {{{

  assign ring_resp_if_b.bid = rff_tid;
  always_comb begin
    case (rff_state)
      ST_WR_RESP: begin
        ring_resp_if_bvalid = '1;
        ring_resp_if_b.bresp = dbg_reg_resp;
      end
      ST_WR_EXE_ERR: begin
        ring_resp_if_bvalid = '1;
        ring_resp_if_b.bresp = AXI_RESP_SLVERR;
      end
      ST_WR_EXE_RESP: begin
        ring_resp_if_bvalid = is_dst_addr_oursring ? dma_dbg_rsp_vld: '1;
        ring_resp_if_b.bresp = AXI_RESP_OKAY;
      end
      default: begin
        ring_resp_if_bvalid = '0;
        ring_resp_if_b.bresp = AXI_RESP_OKAY;
      end
    endcase
  end
  
  // }}}

  //==========================================================
  // Oursring read responses {{{

  assign ring_resp_if_r.rid = rff_tid;
  assign ring_resp_if_r.rlast = '1;
  always_comb begin
    case (rff_state)
      ST_RD_RESP: begin
        ring_resp_if_rvalid = '1;
        ring_resp_if_r.rresp = dbg_reg_resp;
        ring_resp_if_r.rdata = dbg_reg_rdata;
      end
      ST_RD_EXE_ERR: begin
        ring_resp_if_rvalid = '1;
        ring_resp_if_r.rresp = AXI_RESP_SLVERR;
        ring_resp_if_r.rdata = '0;
      end
      ST_RD_EXE_RESP: begin
        ring_resp_if_rvalid  = dma_dbg_rsp_vld;
        ring_resp_if_r.rresp = AXI_RESP_OKAY;
        ring_resp_if_r.rdata = ring_data_t'(dma_dbg_rsp.rdata);
      end
      default: begin
        ring_resp_if_rvalid = '0;
        ring_resp_if_r.rresp = AXI_RESP_OKAY;
        ring_resp_if_r.rdata = '0;
      end
    endcase
  end

  // }}}

  //==========================================================
  // Responses for local block registers{{{

  always_comb begin
    case (rff_ring_addr[STATION_DMA_RING_ADDR_WIDTH - STATION_DMA_BLKID_WIDTH - 1 : 0])
      STATION_DMA_DMA_DEBUG_ADDR_OFFSET: begin
        dbg_reg_rdata = rff_ring_addr;
        dbg_reg_resp = AXI_RESP_OKAY;
      end
      STATION_DMA_DMA_DEBUG_REQ_TYPE_OFFSET: begin
        dbg_reg_rdata = rff_req_type;
        dbg_reg_resp = AXI_RESP_OKAY;
      end
      STATION_DMA_DMA_DEBUG_WR_DATA_OFFSET: begin
        dbg_reg_rdata = rff_wdata;
        dbg_reg_resp = AXI_RESP_OKAY;
      end
      default: begin
        dbg_reg_rdata = '0;
        dbg_reg_resp = AXI_RESP_DECERR;
      end
    endcase
  end
  
  // }}}

  //==========================================================
  // Local block register updates {{{

  assign do_or_update_req_type = ((ring_req_if_awvalid & ring_req_if_awready) & (ring_req_if_wvalid & ring_req_if_wready)) & (ring_req_if_aw.awaddr[STATION_DMA_RING_ADDR_WIDTH-STATION_DMA_BLKID_WIDTH-1:0] == STATION_DMA_DMA_DEBUG_REQ_TYPE_OFFSET);
  assign do_or_update_dma_req_addr = ((ring_req_if_awvalid & ring_req_if_awready) & (ring_req_if_wvalid & ring_req_if_wready)) & (ring_req_if_aw.awaddr[STATION_DMA_RING_ADDR_WIDTH-STATION_DMA_BLKID_WIDTH-1:0] == STATION_DMA_DMA_DEBUG_ADDR_OFFSET);

  assign do_incr_addr = dma_dbg_req_vld & dma_dbg_req_rdy;
  assign addr_increment_val = do_incr_addr ? (is_8B_access ? ring_addr_t'(32'h8): ring_addr_t'(32'h4)): '0;

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_dma_req_addr <= '0;
    end else begin
      if (do_or_update_dma_req_addr) begin
        rff_dma_req_addr <= ring_addr_t'(ring_req_if_w.wdata);
      end else begin
        rff_dma_req_addr <= rff_dma_req_addr + addr_increment_val;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_req_type <= DMA_DEBUG_RD_8B;
    end else begin
      if (do_or_update_req_type) begin
        rff_req_type <= dma_dbg_req_type_t'(ring_req_if_w.wdata);
      end
    end
  end

  // }}}

  //==========================================================
  // DMA req type {{{

  always_comb begin
    case (rff_req_type)
      DMA_DEBUG_WR_8B, DMA_DEBUG_WR_4B: begin
        dma_req_type = REQ_WRITE;
      end
      DMA_DEBUG_BARRIER: begin
        dma_req_type = REQ_BARRIER_SYNC;
      end
      default: begin
        dma_req_type = REQ_READ;
      end
    endcase
  end

  // }}}

  //==========================================================
  // Req {{{

  assign dma_dbg_req_vld = (rff_state == ST_RD_EXE) | (rff_state == ST_WR_EXE);
  assign dma_dbg_rsp_rdy = (rff_state == ST_RD_EXE_RESP) | ((rff_state == ST_WR_EXE_RESP) & is_dst_addr_oursring);

  assign dma_dbg_req.tid[6]    = 1'b1; // not DMA thread
  assign dma_dbg_req.tid[5:4]  = THREAD_ID; // Thread ID
  assign dma_dbg_req.tid[3:0]  = rff_tid[3:0];
  assign dma_dbg_req.req_type  = dma_req_type;
  assign dma_dbg_req.addr      = rff_dma_req_addr;
  assign dma_dbg_req.wdata     = rff_wdata;
  assign dma_dbg_req.mask      = rff_req_mask;

  // }}}

`ifndef SYNTHESIS
  dma_dbg_req_vld_is_x: assert property (@(posedge clk) disable iff (rstn !== '1) (!$isunknown(dma_dbg_req_vld)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: dma_dbg_req_vld is x"));
  dma_dbg_rsp_rdy_is_x: assert property (@(posedge clk) disable iff (rstn !== '1) (!$isunknown(dma_dbg_rsp_rdy)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: dma_dbg_rsp_rdy is x"));
`endif

endmodule


