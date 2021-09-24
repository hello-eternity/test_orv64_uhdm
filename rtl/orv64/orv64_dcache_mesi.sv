`undef SINGLE_WAY
// `define SINGLE_WAY
module data_cache_mesi
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
  #(
  parameter ADDR_SIZE           = 40, 
  parameter LINE_BYTE           = 32,
  parameter BYTE_LEN            = 8,

  parameter Invalid             = 2'b00,
  parameter Shared              = 2'b01,
  parameter Exclusive           = 2'b10,
  parameter Modified            = 2'b11,

  parameter MEM_DEPTH           = 1024, //1024,
  parameter DATA_WIDTH          = LINE_BYTE*BYTE_LEN, // line = 256
  parameter ADDR_WIDTH          = $clog2(MEM_DEPTH), // index = 10
  parameter OFFSET_WIDTH        = $clog2(LINE_BYTE), // offset = 5
  parameter TAG_WIDTH           = ADDR_SIZE - ADDR_WIDTH -OFFSET_WIDTH, // tag 40-10-5 = 25 

  parameter OUT_DATA_WIDTH      = ORV64_XLEN, // out 64 bits

  parameter ORV64_N_DCACHE_WAY  = 2

  ) 
  (
  input  logic                       clk,
  input  logic                       rst,
  input  logic                       dc_inst_finish_en,
  input  logic [ADDR_SIZE-1:0]       data_addr_i, 
  input  logic [DATA_WIDTH-1:0]      store_data_i, 
  output logic [OUT_DATA_WIDTH-1:0]  load_data_o,
  input  logic                       CS, 
  input  logic                       MemR_en_i, 
  input  logic                       MemW_en_i,
  input  logic [LINE_BYTE-1:0]       byte_enable_i,
  // output logic                       read_valid_o,  // read hit        
  // output logic                       write_ready_o, // write hit
  output logic                       readMiss_o,    // read miss
  output logic                       writeMiss_o,    // write miss
  output logic                       resp_valid_o,

  // L2
  // L2 signals
  input  logic                       l2_ready_i,
  input  logic                       first_cycle_en,
  // write back
  output logic                       l2_wb_en_o,
  output logic [ADDR_SIZE-1:0]       l2_wb_addr_o,
  output logic [DATA_WIDTH-1:0]      l2_wb_data_o,
  // read miss
  output logic                       l2_rm_en_o,
  output logic [ADDR_SIZE-1:0]       l2_rm_addr_o,
  input  logic                       l2_valid_en_i,
  input  logic [ADDR_SIZE-1:0]       l2_addr_i,
  input  logic [DATA_WIDTH-1:0]      l2_data_i,
  // uncached
  input  logic                       uncached_addr_range_en,
  input  logic [LINE_BYTE-1:0]       l2_mask_i

  //////////////////////////////////////////////
  //        input  logic [31:0]                data_mem_i [0:4096-1],

  // if no other transaction in the bus(memory controller), the bus is ready, 
  // TODO: so the wire should connect to the mem controller and set only if no transaction in mem
  //        input  logic                       transInFlight_en_i  
  );

    typedef logic [1:0]                      lineStage; 
    typedef logic [$clog2(DATA_WIDTH)-1 : 0] line_offset_t;  // 8
    //control signal
    logic                 l2_rm_en_o_last;
    logic                 l2_rm_en_o_wait_last;
    logic                 l2_wb_en_o_last;
    logic                 l2_wb_en_o_last_finished;
    logic                 l2_valid_en_i_last;
    logic                 l2_ready_i_last;
    lineStage [ORV64_N_DCACHE_WAY-1:0]            valid_ram_qout;
    logic  clk_gated;
    assign clk_gated     = CS & clk;
    assign resp_valid_o  = MemR_en_i | MemW_en_i;
    assign l2_wb_en_o_last_finished = l2_wb_en_o_last & l2_ready_i_last; 
    // assign read_valid_o  = MemR_en_i & readHit;
    // assign write_ready_o = MemW_en_i & writeHit;

    // uncached buffer
    logic [OUT_DATA_WIDTH-1:0]  load_data_o_last;
    always_ff @(posedge clk_gated) begin
      if(rst)
        load_data_o_last <= '0;
      else if(uncached_addr_range_en & l2_valid_en_i & l2_rm_en_o)
        load_data_o_last <= load_data_o;
    end
    
    //ram
    lineStage              cacheLineValid_next;
    logic                  cacheLineValid_refresh_en;


    logic   l2_rm_out_valid;
    logic   l2_rm_in_valid;
    logic   l2_wb_out_valid;
    // logic   l2_wb_in_valid;
    assign  l2_rm_out_valid = l2_rm_en_o;
    assign  l2_rm_in_valid  = l2_rm_en_o_wait_last & l2_valid_en_i;
    assign  l2_wb_out_valid = l2_wb_en_o & l2_ready_i;

    logic [ADDR_SIZE-1:0]         reqAddr;
    logic [TAG_WIDTH-1:0]         reqTag;
    logic [ADDR_WIDTH-1:0]        reqIndex;
    logic [OFFSET_WIDTH-1:0]      reqOffset;

    assign reqAddr   =  data_addr_i; // l2_rm_in_valid ? l2_addr_i : data_addr_i;
    assign reqTag    =  reqAddr[ADDR_SIZE-1 : ADDR_WIDTH+OFFSET_WIDTH];
    assign reqIndex  =  reqAddr[ADDR_WIDTH+OFFSET_WIDTH-1 : OFFSET_WIDTH];
    assign reqOffset =  reqAddr[OFFSET_WIDTH-1 : 0];
    
    logic [TAG_WIDTH-1:0]               tag_ram_qout_selected;
    lineStage                           valid_ram_qout_selected;
    // lineStage                           valid_ram_qout_selected_last;
    // lineStage                           valid_ram_selected;
    logic[ORV64_N_DCACHE_WAY-1:0]       tag_ram_rd_valid;
    logic[ORV64_N_DCACHE_WAY-1:0]       valid_ram_rd_valid;
    logic[ORV64_N_DCACHE_WAY-1:0]       data_ram_rd_valid;
    // logic                               tag_ram_rd_valid_selected;
    logic                               valid_ram_rd_valid_selected;
    logic[DATA_WIDTH-1:0]               data_ram_qout_selected;

    logic[ORV64_N_DCACHE_WAY-1:0]                 tag_match;
    logic                                         write_same_line_en; 
    logic                                         read_same_line_en; // TODO
    logic                                         TagHit;
    logic                                         readHit;
    logic                                         writeHit;
    logic                                         atMESstage;
    logic[ORV64_N_DCACHE_WAY-1:0][TAG_WIDTH-1:0]  localTag ;
    logic                                         cacheModified;
    logic                                         cacheExclusive;
    logic                                         cacheShared;
    logic                                         cacheInvalid;
    
    // Tag check
    always_comb begin
      for (int i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        tag_match[i] = tag_ram_rd_valid[i] & (localTag[i] == reqTag);
      end
    end
    // assign TagHit         = (reqTag == localTag) & tag_ram_rd_valid;
    assign TagHit = (|tag_match);

    assign atMESstage     = (cacheModified | cacheExclusive | cacheShared);
    assign readHit        = TagHit && atMESstage;    // read hit when S/E/M

    // assign valid_ram_selected = write_same_line_en ? valid_ram_qout_selected_last : valid_ram_qout_selected;
    assign cacheModified  = (valid_ram_qout_selected == Modified) & valid_ram_rd_valid_selected;
    assign cacheExclusive = (valid_ram_qout_selected == Exclusive) & valid_ram_rd_valid_selected;
    assign cacheShared    = (valid_ram_qout_selected == Shared) & valid_ram_rd_valid_selected;
    assign cacheInvalid   = (valid_ram_qout_selected == Invalid) & valid_ram_rd_valid_selected;
    assign writeHit       = TagHit && (cacheModified | cacheExclusive); // write hit when M
    
    assign readMiss_o     = MemR_en_i & (uncached_addr_range_en ? ~(/*~first_cycle_en &*/ l2_valid_en_i) : ( ~(readHit | l2_rm_in_valid | read_same_line_en) ) );
    assign writeMiss_o    = MemW_en_i & (uncached_addr_range_en ? ~(l2_wb_en_o_last & l2_wb_out_valid/* & l2_ready_i*/) 
                                                     : ( ~(writeHit | l2_rm_in_valid | write_same_line_en/*| l2_wb_en_o_last */ ) ) );

    logic tagHit_E;
    logic writeHit_EtoM;
    // logic readHit_EtoS;

    assign tagHit_E       = TagHit & cacheExclusive;
    assign writeHit_EtoM  = MemW_en_i & tagHit_E;
    // assign readHit_EtoS   = MemR_en_i & tagHit_E; 

    line_offset_t  reqAddrInLine; // the byte position in 256-bit line
    //assign reqAddrInLine = l2_rm_out_valid ? '0 : { reqOffset, 3'b0 };
    assign reqAddrInLine = /*l2_rm_out_valid & ~uncached_addr_range_en ? '0 :*/ { reqOffset[OFFSET_WIDTH-1 : 3], 6'b0 };

    logic dc_new_inst_en;
    always_ff @(posedge clk) begin
      if(rst)
        dc_new_inst_en <= '0;
      else
        dc_new_inst_en <= dc_inst_finish_en;
    end

  //==========================================================
  // PRBS (for random replacement)
`ifndef SINGLE_WAY
  logic       lfsr_en, lfsr_fb;
  logic [6:0] lfsr_ff;
  logic [$clog2(ORV64_N_DCACHE_WAY)-1:0] replace_wyid, replace_wyid_ff;
  logic [5:0] cfg_lfsr_seed;
  assign cfg_lfsr_seed = 6'h1;

  assign lfsr_en = dc_new_inst_en;

  assign lfsr_fb = lfsr_ff[6] ^ lfsr_ff[5];

  always_ff @ (posedge clk) begin
    if (rst) begin
      lfsr_ff[0] <= 'b1;
      lfsr_ff[6:1] <= cfg_lfsr_seed;
      replace_wyid_ff <= '0;
    end else if (lfsr_en) begin
      lfsr_ff <= {lfsr_ff[5:0], lfsr_fb};
      replace_wyid_ff <= replace_wyid;
    end
  end

  always_comb begin
    replace_wyid = lfsr_ff[$clog2(ORV64_N_DCACHE_WAY)-1:0];
    for (int i=ORV64_N_DCACHE_WAY-1; i>=0; i--) begin
      if ( (valid_ram_qout[i]==Shared || valid_ram_qout[i]==Exclusive) ) begin
        replace_wyid = i;
      end
    end
    for (int i=ORV64_N_DCACHE_WAY-1; i>=0; i--) begin
      if ( (valid_ram_qout[i]==Invalid) ) begin
        replace_wyid = i;
      end
    end
  end
`else
  logic replace_wyid;
  assign replace_wyid = 0;
`endif

  // PLRU (for pseudo-LRU replacement)
  // TODO


  //==========================================================
  // Write Access bypass (for continuous mem write access hit to the same cache line)
  logic [TAG_WIDTH-1:0]         reqTag_last;
  logic [ADDR_WIDTH-1:0]        reqIndex_last;
  logic                         valid_EorM_en_last;
  logic[ORV64_N_DCACHE_WAY-1:0] tag_match_last;
  logic[ORV64_N_DCACHE_WAY-1:0] tag_match_last_next;

  logic  l2_valid_en_i_thisinst;
  logic  l2_ready_i_thisinst;
  logic  valid_EorM_en;
  logic  tag_index_hit;
  logic  ma_inst_finish_en;
  logic  rw_last;

  always_ff @(posedge clk) begin
    if(rst) begin
      l2_valid_en_i_thisinst <= '0;
      l2_ready_i_thisinst    <= '0;
    end else if(dc_inst_finish_en) begin
      l2_valid_en_i_thisinst <= '0;
      l2_ready_i_thisinst    <= '0;
    end else if(l2_valid_en_i)
      l2_valid_en_i_thisinst <= '1;
    else if(l2_ready_i)
      l2_ready_i_thisinst    <= '1;
  end

  always_ff @(posedge clk) begin
    if(rst) begin
      reqTag_last                   <= '0;
      reqIndex_last                 <= '0;
      rw_last                       <= '0;
      // valid_ram_qout_selected_last  <= '0;
      valid_EorM_en_last            <= '0;
      tag_match_last                <= '0;
    end else if(ma_inst_finish_en) begin
      reqTag_last                   <= reqTag;
      reqIndex_last                 <= reqIndex;
      rw_last                       <= MemW_en_i;
      // valid_ram_qout_selected_last  <= line_changed_en ? cacheLineValid_next : valid_ram_qout_selected;
      valid_EorM_en_last            <= valid_EorM_en;
      tag_match_last                <= tag_match_last_next;
    end
  end

  generate
    for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin
      assign tag_match_last_next[i]  = TagHit ? tag_match[i] 
                                          : write_same_line_en ? tag_match_last[i] : (i == replace_wyid);
    end
  endgenerate

  assign ma_inst_finish_en          = dc_inst_finish_en & ~uncached_addr_range_en & resp_valid_o;
  assign tag_index_hit              = (reqTag == reqTag_last) & (reqIndex == reqIndex_last);
  assign write_same_line_en         = valid_EorM_en_last & tag_index_hit;


  //==========================================================
  // Read Access bypass (buffer line for continuous mem read access hit to the same cache line)
  logic [DATA_WIDTH-1:0]  read_buffer_line_data;
  logic [DATA_WIDTH-1:0]  read_buffer_line_data_next;
  logic                   read_buffer_line_valid;
  logic                   read_buffer_line_valid_next;
  assign read_same_line_en            = read_buffer_line_valid & tag_index_hit & MemR_en_i & ~rw_last;
  assign read_buffer_line_valid_next  = (uncached_addr_range_en | (tag_index_hit & MemW_en_i))     ? 0 : 
                                        (ma_inst_finish_en & MemR_en_i)                            ? 1 : read_buffer_line_valid;
  assign read_buffer_line_data_next   = readHit ? data_ram_qout_selected : (l2_valid_en_i ? l2_data_i : '0);
  always_ff @(posedge clk) begin
    if(rst) begin
      read_buffer_line_valid <= '0; 
    end else begin
      read_buffer_line_valid <= read_buffer_line_valid_next;
    end
  end

  always_ff @(posedge clk) begin
    if(ma_inst_finish_en & MemR_en_i & ~read_same_line_en & ~uncached_addr_range_en)
      read_buffer_line_data <= read_buffer_line_data_next;
  end

  // logic [DATA_WIDTH-1:0]  read_buffer_line_data = '0;

  // assign read_same_line_en = 0;

  //==========================================================
  // SRAM

    logic[ORV64_N_DCACHE_WAY-1:0]                 tag_ram_en;
    logic[ORV64_N_DCACHE_WAY-1:0]                 tag_ram_rw;
    logic[ORV64_N_DCACHE_WAY-1:0]                 tag_ram_rw_last;
    logic[ORV64_N_DCACHE_WAY-1:0][TAG_WIDTH-1:0]  tag_ram_qout;
    logic[ORV64_N_DCACHE_WAY-1:0][TAG_WIDTH-1:0]  tag_ram_qout_matched;

    always_comb begin
      for(int i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        // tag_ram_qout_matched[i] = {$bits(logic[TAG_WIDTH-1:0]){(TagHit ? tag_match[i] : (i==replace_wyid))}} & tag_ram_qout[i];
        tag_ram_qout_matched[i] = {TAG_WIDTH{(TagHit ? tag_match[i] : (i==replace_wyid))}} & tag_ram_qout[i];
      end
    end

    always_comb begin
      tag_ram_qout_selected = '0;
      for(int i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        tag_ram_qout_selected |= tag_ram_qout_matched[i];
      end
    end

    generate
      for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        assign tag_ram_en[i] = ~uncached_addr_range_en & resp_valid_o & ((dc_new_inst_en & ~(write_same_line_en & MemW_en_i) ) | (tag_ram_rw[i] & ( TagHit ? tag_match[i] : (i==replace_wyid) ) ) );
        assign tag_ram_rw[i] = (l2_rm_in_valid & ~tag_ram_rw_last[i]) | (l2_wb_en_o_last_finished & MemW_en_i);
      end
    endgenerate

    assign localTag   = tag_ram_qout;

    generate
      for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin
      `ifndef SYNTHESIS
        dc_ram #(
          .DEPTH (MEM_DEPTH),
          .WIDTH (TAG_WIDTH)
        ) TAG_RAM
        (
          .clk        ( clk                         ), 
          .rst        ( rst                         ), 
          .en         ( tag_ram_en[i]               ), 
          .rw         ( tag_ram_rw[i]               ),  // rw=0 (read), rw=1 (write)
          .bit_mask   ( '1                          ), 
          .addr       ( reqIndex                    ), 
          .din        ( reqTag                      ), 
          .qout       ( tag_ram_qout[i]             )
        );
      `else
        DW_ram_rw_s_dff #(.data_width(TAG_WIDTH), .depth(MEM_DEPTH), .rst_mode(1)) DATA_RAM(
          .clk(clk),
          .rst_n(~rst),
          .cs_n(~tag_ram_en[i]),
          .wr_n(~tag_ram_rw[i]),
          .rw_addr(reqIndex),
          .data_in(reqTag),
          .data_out(tag_ram_qout[i])
        );
      `endif
      end
    endgenerate

    logic[ORV64_N_DCACHE_WAY-1:0]                 valid_ram_en;
    logic[ORV64_N_DCACHE_WAY-1:0]                 valid_ram_rw;
    logic[ORV64_N_DCACHE_WAY-1:0]                 valid_ram_rw_last;
    // lineStage [ORV64_N_DCACHE_WAY-1:0]            valid_ram_qout;
    lineStage [ORV64_N_DCACHE_WAY-1:0]            valid_ram_qout_matched;

    assign valid_EorM_en = ((|valid_ram_en) & (|valid_ram_rw) & (l2_valid_en_i_thisinst | l2_valid_en_i)) 
                          ? ((cacheLineValid_next == Modified) | (cacheLineValid_next == Exclusive)) 
                          : ((valid_ram_qout_selected == Modified) | (valid_ram_qout_selected == Exclusive));

    always_comb begin
      for(int i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        valid_ram_qout_matched[i] = {$bits(lineStage){(TagHit ? tag_match[i] : (i==replace_wyid))}} & valid_ram_qout[i];
      end
    end

    always_comb begin
      valid_ram_qout_selected = '0;
      if(TagHit)begin
        for(int i=0; i<ORV64_N_DCACHE_WAY; i++) begin
          valid_ram_qout_selected |= valid_ram_qout_matched[i];
        end 
      end else begin
        valid_ram_qout_selected = valid_ram_qout[replace_wyid];
      end
    end
    
    generate
      for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin 
        assign valid_ram_en[i] = ~uncached_addr_range_en & resp_valid_o & (dc_new_inst_en | ( valid_ram_rw[i] & ( TagHit ? tag_match[i] : (i==replace_wyid) ) ) );
        assign valid_ram_rw[i] = ~uncached_addr_range_en & ( writeHit_EtoM   // E -> M // shift silently
                                            // |  readHit_EtoS    // E -> S // shift silently
                                            | (l2_wb_en_o & l2_ready_i)
                                            |  l2_rm_in_valid
                                            | (MemW_en_i & (( l2_wb_en_o_last_finished & (i==replace_wyid) ) | write_same_line_en ) )
                                            ); // Line from L2, I -> E
                                           // & ~valid_ram_rw_last[i];
      end
    endgenerate
    
    generate
      for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin
      `ifndef SYNTHESIS
        dc_ram #(
          .DEPTH (MEM_DEPTH),
          .WIDTH (2)
        ) VALID_RAM
        (
          .clk        ( clk                         ), 
          .rst        ( rst                         ), 
          .en         ( valid_ram_en[i]             ), 
          .rw         ( valid_ram_rw[i]             ),  // rw=0 (read), rw=1 (write)
          .bit_mask   ( '1                          ), 
          .addr       ( reqIndex                    ), 
          .din        ( cacheLineValid_next         ), 
          .qout       ( valid_ram_qout[i]           )
        );
      `else
        DW_ram_rw_s_dff #(.data_width(2), .depth(MEM_DEPTH), .rst_mode(1)) DATA_RAM(
          .clk(clk),
          .rst_n(~rst),
          .cs_n(~valid_ram_en[i]),
          .wr_n(~valid_ram_rw[i]),
          .rw_addr(reqIndex),
          .data_in(cacheLineValid_next),
          .data_out(valid_ram_qout[i])
        );
      `endif
      end
    endgenerate

    logic [ORV64_N_DCACHE_WAY-1:0]                  wb_rd_en;
    logic [ORV64_N_DCACHE_WAY-1:0]                  wb_rd_en_last;

    logic [ORV64_N_DCACHE_WAY-1:0]                  data_ram_en;
    logic [ORV64_N_DCACHE_WAY-1:0]                  data_ram_rw;
    logic [DATA_WIDTH-1:0]                          byte2bit_enable;
    logic [DATA_WIDTH-1:0]                          data_ram_bit_mask;
    logic [ORV64_N_DCACHE_WAY-1:0][DATA_WIDTH-1:0]  data_ram_qout;
    logic [ORV64_N_DCACHE_WAY-1:0][DATA_WIDTH-1:0]  data_ram_qout_matched;

    always_comb begin
      for(int i=0; i<ORV64_N_DCACHE_WAY; i++)begin
        // data_ram_qout_matched[i] = {$bits(logic[DATA_WIDTH-1:0]){tag_match[i]}} & data_ram_qout[i];
        data_ram_qout_matched[i] = {DATA_WIDTH{tag_match[i]}} & data_ram_qout[i];
      end
    end

    always_comb begin
      data_ram_qout_selected = '0;
      for(int i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        data_ram_qout_selected |= data_ram_qout_matched[i];
      end
    end

    generate
      for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin 
        assign data_ram_en[i]        = ~uncached_addr_range_en & ( 
                                              ( MemW_en_i & ( 
                                                    (writeHit & tag_match[i])                         // store with write hit
                                                  | (l2_wb_en_o_last_finished & (i==replace_wyid))    // in write, after a write back, need to write new data into the cache line
                                                  | (dc_new_inst_en & ~write_same_line_en)                  // read data at the first cycle of a inst if it does not hit to the same line as last one
                                                  | (write_same_line_en & tag_match_last[i])
                                                ) 
                                              )              
                                            | ( MemR_en_i & (
                                                    dc_new_inst_en                  // read data at the first cycle of a inst if it does not hit to the same line as last one
                                                  | (i==replace_wyid) 
                                                ) 
                                              )  
                                            | ( l2_valid_en_i & (
                                                    TagHit ? tag_match[i] : (i==replace_wyid)
                                                ) 
                                              ) 
                                            | wb_rd_en[i] 
                                          );
        assign data_ram_rw[i]        = (MemW_en_i & (writeHit | l2_wb_en_o_last_finished | write_same_line_en)) | l2_valid_en_i;
      end
    endgenerate

    generate
      for(genvar i = 0; i < LINE_BYTE; i++) begin
        assign byte2bit_enable[(i+1)*BYTE_LEN-1 : i*BYTE_LEN] = { BYTE_LEN{ byte_enable_i[i] } };
      end
    endgenerate


    assign data_ram_bit_mask  = l2_valid_en_i ? '1 : byte2bit_enable;

    logic [DATA_WIDTH-1:0] store_data;
    logic [DATA_WIDTH-1:0] mixed_data;
    assign mixed_data = (byte2bit_enable & store_data_i) | (~byte2bit_enable & l2_data_i);
    assign store_data = l2_rm_in_valid ? (MemW_en_i & l2_rm_en_o_wait_last) 
                                       ? mixed_data : l2_data_i 
                                       : store_data_i;
    generate
      for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        `ifndef SYNTHESIS
        dc_ram #(
          .DEPTH (MEM_DEPTH),
          .WIDTH (DATA_WIDTH)
        ) DATA_RAM
        (
          .clk        ( clk                         ), 
          .rst        ( rst                         ), 
          .en         ( data_ram_en[i]              ), 
          .rw         ( data_ram_rw[i]              ),  // rw=0 (read), rw=1 (write)
          .bit_mask   ( data_ram_bit_mask           ), 
          .addr       ( reqIndex                    ), 
          .din        ( store_data                  ), 
          .qout       ( data_ram_qout[i]            )
        );
        `else
          DW_ram_rw_s_dff #(.data_width(DATA_WIDTH), .depth(MEM_DEPTH), .rst_mode(1)) DATA_RAM(
          .clk(clk),
          .rst_n(~rst),
          .cs_n(~data_ram_en[i]),
          .wr_n(~data_ram_rw[i]),
          .rw_addr(reqIndex),
          .data_in(store_data),
          .data_out(data_ram_qout[i])
        );
        `endif
      end
    endgenerate


    logic[ORV64_N_DCACHE_WAY-1:0] valid_ram_rd_valid_next;
    logic[ORV64_N_DCACHE_WAY-1:0] tag_ram_rd_valid_next;
    logic[ORV64_N_DCACHE_WAY-1:0] valid_ram_rd_valid_matched;
    logic[ORV64_N_DCACHE_WAY-1:0] data_ram_rd_valid_next;
    generate
      for(genvar i=0; i<ORV64_N_DCACHE_WAY; i++) begin
        assign valid_ram_rd_valid_next[i] = valid_ram_en[i] & ~valid_ram_rw[i] & ~dc_inst_finish_en;
        assign tag_ram_rd_valid_next[i]   = tag_ram_en[i] & ~tag_ram_rw[i];
        assign data_ram_rd_valid_next[i]  = data_ram_en[i] & ~data_ram_rw[i];
      end
    endgenerate

    always_ff @ (posedge clk) begin
      if(rst) begin
        valid_ram_rw_last  <= '0;
        tag_ram_rw_last    <= '0;

        valid_ram_rd_valid <= '0;
        tag_ram_rd_valid   <= '0;
        data_ram_rd_valid  <= '0;
      end else begin
        valid_ram_rw_last  <= valid_ram_rw;
        tag_ram_rw_last    <= tag_ram_rw;

        valid_ram_rd_valid <= valid_ram_rd_valid_next;
        tag_ram_rd_valid   <= tag_ram_rd_valid_next;
        data_ram_rd_valid  <= data_ram_rd_valid_next;
      end
    end
    
    // always_comb begin
    //   for(int i=0; i<ORV64_N_DCACHE_WAY; i++)begin
    //     valid_ram_rd_valid_matched[i] = {$bits(logic){tag_match[i]}} & valid_ram_rd_valid[i];
    //   end
    // end

    // always_comb begin
    //   valid_ram_rd_valid_selected = '0;
    //   for(int i=0; i<ORV64_N_DCACHE_WAY; i++)begin
    //     valid_ram_rd_valid_selected |= valid_ram_rd_valid_matched[i];
    //   end
    // end
    assign valid_ram_rd_valid_selected = (&valid_ram_rd_valid);



    //read
    logic [DATA_WIDTH-1:0] read_data_line_select;
    logic [OUT_DATA_WIDTH-1:0] read_data_select;
    // logic [DATA_WIDTH-1:0] read_data_line_select_old;
    // logic [OUT_DATA_WIDTH-1:0] read_data_select_old;
    assign read_data_line_select  = (~uncached_addr_range_en & read_same_line_en) ? read_buffer_line_data
                                  : (~uncached_addr_range_en & MemR_en_i & readHit) ? data_ram_qout_selected 
                                  : l2_data_i;
    assign read_data_select       = read_data_line_select[reqAddrInLine +: OUT_DATA_WIDTH];
    assign load_data_o            = (uncached_addr_range_en & ~l2_valid_en_i) ? load_data_o_last : read_data_select;
    

    //write
    logic [LINE_BYTE-1:0] write_en;
    assign      write_en = uncached_addr_range_en ? '0 
                          : l2_valid_en_i ? '1 
                          : {LINE_BYTE{MemW_en_i & writeHit}} & byte_enable_i ;

    always_comb begin: cache_line_state_next
      cacheLineValid_next = valid_ram_qout_selected;
      if(TagHit) begin
        if(writeHit_EtoM)      // E silently upgrade to M
          cacheLineValid_next = Modified;
        // else if(readHit_EtoS ) // E silently downgrade to S
        //   cacheLineValid_next = Shared;

      end else if (l2_rm_in_valid & MemR_en_i) begin // if(l2_rm_in_valid)
        cacheLineValid_next = Exclusive;
      end else if ( MemW_en_i & (l2_rm_in_valid | l2_wb_en_o_last_finished | write_same_line_en) ) begin
        cacheLineValid_next = Modified;
      end else begin // if(l2_wb_en_o & l2_ready_i)
        cacheLineValid_next = Invalid;
      end
    end


    // L2
    // write back
    logic [ADDR_SIZE-1:0] ori_line_addr; // the line addr of the dirty line for write-back
    logic l2_rm_en_o_wait_next;
    logic l2_rm_en_o_wait;
    assign l2_rm_en_o_wait_next = l2_rm_en_o_wait_last ? (l2_valid_en_i ? '0 : '1) : l2_rm_en_o;
    always_ff @(posedge clk_gated) begin
      if(rst)begin
        l2_valid_en_i_last    <= '0;
        l2_rm_en_o_last       <= '0;
        l2_wb_en_o_last       <= '0;
        l2_ready_i_last       <= '0;
      end else begin
        l2_valid_en_i_last    <= l2_valid_en_i;
        l2_rm_en_o_last       <= l2_rm_en_o;
        l2_rm_en_o_wait_last  <= l2_rm_en_o_wait_next;
        l2_wb_en_o_last       <= l2_wb_en_o;
        l2_ready_i_last       <= l2_ready_i;
      end
    end

    generate
      for(genvar i = 0; i<ORV64_N_DCACHE_WAY; i++) begin
        assign wb_rd_en[i]   = ~uncached_addr_range_en & ~wb_rd_en_last[i] &
                              (MemR_en_i | MemW_en_i) & cacheModified & (~TagHit & tag_ram_rd_valid[i]) &
                              (i==replace_wyid);
      end
    endgenerate

    
    assign ori_line_addr = {tag_ram_qout_selected, reqIndex, {OFFSET_WIDTH{1'b0}}};
    assign l2_wb_en_o    = uncached_addr_range_en ? MemW_en_i /*& ~l2_ready_i*/
                          : (l2_wb_en_o_last & ~l2_ready_i_last) ? '1
                          : (~l2_wb_en_o_last & ( wb_rd_en_last[replace_wyid] | ( wb_rd_en[replace_wyid] & data_ram_rd_valid[replace_wyid] ) ) );
    assign l2_wb_addr_o  = uncached_addr_range_en ? data_addr_i 
                          : ori_line_addr;
    assign l2_wb_data_o  = uncached_addr_range_en ? store_data_i
                          : data_ram_qout[replace_wyid];
    // read miss
    assign l2_rm_en_o    = uncached_addr_range_en ? readMiss_o & ~l2_valid_en_i & ~l2_ready_i_thisinst/*& ~rff_is_l2_resp*/ /*& l2_ready_i*/
                          : (TagHit ? (((MemR_en_i | MemW_en_i) & cacheInvalid) | (MemW_en_i & cacheShared))
                          : (MemR_en_i | MemW_en_i) & (cacheInvalid | cacheShared |cacheExclusive) )
                          | (l2_wb_en_o_last_finished & l2_ready_i_last) | (l2_rm_en_o_last & ~l2_ready_i_last);
    assign l2_rm_addr_o  = reqAddr; 
    //
    always_ff @ (posedge clk) begin
      if(rst)
        wb_rd_en_last <= '0;
      else
        wb_rd_en_last <= wb_rd_en; 
    end


//==========================================================
  // Debug prints {{{
// `ifndef SYNTHESIS
// `ifndef VERILATOR
//   unexpected_rm_resp: assert property (@(posedge clk) disable iff (rst !== '0) (l2_valid_en_i |-> l2_rm_en_o_last)) else `olog_fatal("ORV_DCACHE", $sformatf("%m: received dcache l2 resp with no request"));
// `endif
// `endif
logic a_cache_addr;
assign a_cache_addr = (data_addr_i >= 40'h8101fe20 && data_addr_i < 40'h8101fe40);
  // }}}
endmodule