module orv64_inst_trace_buf
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_typedef_pkg::*;
(
  // function port
  input   orv64_vaddr_t     if_pc, id_pc, ex_pc, ma_pc, wb_pc,
  input   logic             if_valid, id_valid, ex_valid, ma_valid, wb_valid,
                            id_ready, ex_ready, ma_ready, wb_ready,

  input   orv64_itb_sel_t   cfg_itb_sel,

  // debug access port
  input   orv64_da2itb_t    da2itb,
  output  orv64_itb2da_t    itb2da,

  // crb port
  output  orv64_itb_addr_t  itb_last_ptr,

  // clk & rst
  input   logic       cfg_itb_en,
  input   logic       cfg_itb_wrap_around,
  input   logic       rst, clk
);

  logic             en_ram;
  logic             rff_buf_full;
  orv64_itb_data_t  data;
  orv64_itb_addr_t  rff_addr, next_addr;
  orv64_itb_addr_t  dff_last_addr;

  logic             dbg_en, dbg_rw;
  orv64_itb_data_t  dbg_din;
  orv64_itb_addr_t  dbg_addr;
  orv64_itb_data_t  dbg_dout;

  assign itb_last_ptr = dff_last_addr;

  orv64_itb_ram ram_u (.en(en_ram), .addr(rff_addr), .cfg_pwr_on(cfg_itb_en), .cfg_sleep('0), .*);

  always_comb begin
    case (cfg_itb_sel)
      ORV64_ITB_SEL_IF: begin
        en_ram = if_valid & id_ready;
        data.vpc = if_pc;
      end
      ORV64_ITB_SEL_ID: begin
        en_ram = id_valid & ex_ready;
        data.vpc = id_pc;
      end
      ORV64_ITB_SEL_EX: begin
        en_ram = ex_valid & ma_ready;
        data.vpc = ex_pc;
      end
      ORV64_ITB_SEL_MA: begin
        en_ram = ma_valid & wb_ready;
        data.vpc = ma_pc;
      end
      default: begin // ITB_SEL_WB
        en_ram = wb_valid;
        data.vpc = wb_pc;
      end
    endcase
    en_ram &= cfg_itb_en;
    if (~cfg_itb_wrap_around & rff_buf_full) begin
      en_ram = 1'b0;
    end
  end

  assign  next_addr = rff_addr + 1;

  assign  dbg_en = da2itb.en;
  assign  dbg_rw = da2itb.rw;
  assign  dbg_addr = da2itb.addr;
  assign  dbg_din = da2itb.din;
  assign  itb2da.dout = dbg_dout;

  always_ff @ (posedge clk) begin
    if (rst | ~cfg_itb_en) begin
      rff_addr <= '0;
    end else begin
      if (en_ram) begin
        rff_addr <= next_addr;
        dff_last_addr <= rff_addr;
      end
    end
  end

  always_ff @ (posedge clk) begin
    if (rst | ~cfg_itb_en) begin
      rff_buf_full <= '0;
    end else begin
      if (en_ram & (rff_addr == '1)) begin
        rff_buf_full <= '1;
      end
    end
  end

endmodule
