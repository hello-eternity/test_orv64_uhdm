module orv64_inst_buffer
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  input   orv64_if2ic_t             if2ib,
  output  orv64_ic2if_t             ib2if,
  output  orv64_ib2icmem_t          ib2ic,
  input   orv64_icmem2ib_t          ic2ib,
  input   logic                     l1_hit,
  input   logic                     l1_miss,
  output  logic                     ib_hit,
  output  logic                     ib_miss,

  input   orv64_prv_t                prv,
  input   orv64_csr_mstatus_t        mstatus,
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr,

  // L1 I$
  input   logic                     ib_flush,

  input   orv64_da2ib_t             da2ib,
  output  orv64_ib2da_t             ib2da,

  output  logic                     ib_idle,

  input logic                       rst, clk
);

  localparam L2_LINE_WIDTH = 256;
  localparam BUF_ELEMENT_SIZE = 16;
  localparam NUM_ELEMENTS_PER_LINE = L2_LINE_WIDTH/BUF_ELEMENT_SIZE;
  localparam NUM_LINES = 2;
  localparam NUM_ELEMENTS = NUM_LINES*NUM_ELEMENTS_PER_LINE;
  localparam PTR_WIDTH = $clog2(NUM_ELEMENTS);
  localparam PREFETCH_COMP_SIZE = NUM_ELEMENTS-NUM_ELEMENTS_PER_LINE;
  localparam LINE_PTR_WIDTH = $clog2(NUM_LINES);

  typedef logic [LINE_PTR_WIDTH-1:0]   ibuf_line_ptr_t;
  typedef logic [PTR_WIDTH-1:0]        ibuf_ptr_t;
  typedef logic [PTR_WIDTH:0]          ibuf_size_t;
  typedef logic [BUF_ELEMENT_SIZE-1:0] ibuf_element_t;

  ibuf_element_t       [NUM_ELEMENTS-1:0] dff_inst_buffer;
  logic                [NUM_LINES-1:0]    dff_excp_valid;
  orv64_excp_cause_t   [NUM_LINES-1:0]    dff_excp_cause;
  orv64_paddr_t        [NUM_LINES-1:0]    dff_base_pc;

  ibuf_size_t rff_ibuf_size, pop_size, push_size;

  ibuf_ptr_t rff_pop_ptr, next_pop_ptr, pop_ptr_second_half;
  ibuf_ptr_t rff_push_ptr, next_push_ptr;

  ibuf_line_ptr_t push_line_ptr, pop_line_ptr, pop_line_ptr_second_half;

  logic         do_flush;













endmodule