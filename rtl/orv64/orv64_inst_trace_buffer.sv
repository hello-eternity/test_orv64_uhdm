module orv64_inst_trace_buffer
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  input   orv64_if2ic_t             if2ib,
  input   orv64_ic2if_t             ib2if,

  output  orv64_ic2if_t             itb2if,
  output  logic                     itb_hit, 
  output  logic                     itb_hit_ff,

  input   logic                     itb_flush,

  input logic                       rst, clk
);

  localparam TRACE_BUF_SIZE = 64;
  localparam TRACE_PTR_WIDTH = $clog2(TRACE_BUF_SIZE);


  orv64_ic2if_t   [TRACE_BUF_SIZE-1:0]    dff_trace_buf;
  logic           [TRACE_PTR_WIDTH-1:0]   rff_tb_ptr;
  logic           [TRACE_BUF_SIZE-1:0]    rff_tb_valid;
  logic           [TRACE_PTR_WIDTH-1:0]   rff_tb_idx;

  logic         rff_ib_has_req;
  orv64_vaddr_t dff_req_vpc;

  always_comb begin
    itb_hit = '0;
    rff_tb_idx = '0;
    for (int i=0; i < TRACE_BUF_SIZE; i++) begin
      if (rff_tb_valid[i] & dff_trace_buf[i].vaddr == if2ib.pc & if2ib.en) begin
        itb_hit = 1;
        rff_tb_idx = i;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_ib_has_req <= '0;
    end
    else begin
      rff_ib_has_req <= if2ib.en;
      dff_req_vpc <= if2ib.pc;
    end
  end

  always_ff @(posedge clk) begin
    itb_hit_ff <= itb_hit;
    itb2if <= itb_hit ? dff_trace_buf[rff_tb_idx] : '0;
  end


  always_ff @(posedge clk) begin
  if (rst) begin
    rff_tb_valid <= '0;
    rff_tb_ptr <= '0;
  end
  else begin
    if (itb_flush) begin
      rff_tb_valid <= '0;
      rff_tb_ptr <= '0;
    end
    else begin
      if (ib2if.valid & ~itb_hit_ff) begin
        rff_tb_valid[rff_tb_ptr] <= '1;
        dff_trace_buf[rff_tb_ptr] <= ib2if;
        rff_tb_ptr <= rff_tb_ptr + 1'b1;
      end
    end
  end
end

endmodule
