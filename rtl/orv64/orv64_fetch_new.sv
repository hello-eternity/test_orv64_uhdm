// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_fetch_new
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
(
  // IF -> ID
  output  orv64_if2id_t       if2id_ff,
  output  orv64_if2id_ctrl_t  if2id_ctrl_ff,
  output  orv64_excp_t        if2id_excp_ff,
  // IF -> Regfile
  //output  orv64_if2irf_t      if2irf,
  `ifdef ORV64_SUPPORT_FP
  output  orv64_if2fprf_t     if2fprf,
  `endif
  // IF -> L1I$
  output orv64_ib2icmem_t     ib2ic,
  input orv64_icmem2ib_t     ic2ib,
  input  logic           ic_hit, 
                        ic_miss,
  // next PC
  input   orv64_npc_t         id2if_npc, ex2if_npc, cs2if_npc, wb2if_npc,
  input   logic         ma2if_npc_valid,
  input   logic         branch_solved,
  // pipeline ctrl
  input   logic         if_stall, if_kill,
  input   logic         id_ready,
  output  logic         if_ready, if_valid, if_valid_ff,
  output  logic         is_wfe,
  output  logic         if_is_stable_stall,
//  input   orv64_csr_mstatus_t mstatus,
  // fence
  input   logic                 id2ib_flush_req_valid,
  input   logic                 cs2ib_flush_req_valid,
  input   logic                 id2ic_fence_req_valid,
  output  logic                 inst_buf_idle,
  // ID -> DA
  output  orv64_if2da_t if2da,
  output  orv64_inst_t  if_inst,

  // performance counter
  output  logic         wait_for_npc,
  output  logic         wait_for_icr,
  // reset PC
  input   orv64_vaddr_t       cfg_rst_pc,
  output  orv64_vaddr_t       if_pc,
  
  // Atomic 
  input  logic 	   dc2if_amo_store_sent, 
  output logic     if_has_amo_inst,

  // prv
  input   orv64_prv_t                prv,
  input   orv64_csr_mstatus_t        mstatus,
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr,
  // rst & clk
  input   logic         rst, clk

);
  orv64_if2id_t       if2id;
  orv64_if2id_ctrl_t  if2id_ctrl;
  orv64_excp_t        if2id_excp;
  orv64_itb_packet_t  if2id_itb_data;
  orv64_ic2if_t       ib2if_saved_ff;

  orv64_opcode_t      opcode;
  orv64_reg_addr_t    rd_addr, rs1_addr, rs2_addr, rs3_addr;
  logic [ 1:0]  funct2;
  logic [ 2:0]  funct3;
  logic [ 4:0]  funct5;
  logic [ 5:0]  funct6;
  logic [ 6:0]  funct7;
  logic [11:0]  funct12;
  logic [ 1:0]  fmt;
  orv64_data_t        i_imm, s_imm, b_imm, u_imm, j_imm, z_imm;
  orv64_frm_t         frm;
  orv64_csr_addr_t    csr_addr;
//  logic               is_csr_op_on_mmu;
//  logic               is_csr_op_on_frm;

  amo_fsm_t     rff_amo_state, amo_nxt;
  orv64_inst_t  ib2if_inst;
  orv64_inst_t  ib2if_rvc_inst;
  logic             ib2if_is_rvc;
  orv64_inst_t  amo_mv_instr, amo_load_instr, amo_op_instr, amo_store_instr, amo_lrsc_instr, final_amo_instr;
  logic amo_fsm_is_active, amo_is_done;
  logic   hold_ib2if, hold_ib2if_ff, if2ib_en_ff, ib2if_valid_hold;
  logic   ib2if_excp_valid;
  orv64_excp_cause_t   ib2if_excp_cause;
  logic   ib2if_is_half1_excp;
  logic   fp_access_excp, rs1_is_fp, rs2_is_fp;
  logic   is_fp_instr;

  //==========================================================
  // PC {{{
  orv64_vaddr_t   jump_pc;
  orv64_npc_t     npc, pc_ff, // next PC
            if2if_npc;  // next PC from if
//  logic     is_branch_predict, is_branch_predict_ff, wait_for_branch;
  logic     is_sfence;
  logic     is_ret_inst;
  assign if_pc = pc_ff.pc;
  always_ff @ (posedge clk) begin
    if (rst) begin
      pc_ff.valid <= '0;
      pc_ff.pc <= {cfg_rst_pc[$bits(cfg_rst_pc)-1:1], 1'b0};
    end else begin
      // PC valid
      if (if_ready & ~amo_fsm_is_active) begin
        pc_ff.valid <= if2ib.en;
      end
      // PC
      if (if_ready & if2ib.en) begin
        pc_ff.pc <= if2ib.pc;
      //  pc_ff.pc <= npc.pc;
      end
    end
  end

  assign is_sfence = (opcode == ORV64_SYSTEM) & (funct7 == 7'h09) & (funct3 == 3'h0) & (rd_addr == 5'h00);

  assign is_ret_inst = (opcode == ORV64_SYSTEM) & (funct3 == 3'h0) & (funct5 == 5'h02) & (rs1_addr == 5'h00) & (rd_addr == 5'h00);

  assign ib2if_excp_valid = (hold_ib2if_ff ? ib2if_saved_ff.valid & ib2if_saved_ff.excp_valid : ib2if.valid & ib2if.excp_valid);
  assign ib2if_excp_cause = (hold_ib2if_ff ? ib2if_saved_ff.excp_cause : ib2if.excp_cause);
  assign ib2if_is_half1_excp = (hold_ib2if_ff ? ib2if_saved_ff.is_half1_excp : ib2if.is_half1_excp);

  // generate next PC
//  assign  jump_pc = pc_ff.pc + j_imm;
  assign  if2if_npc.pc = /*(opcode == ORV64_JAL) ? jump_pc : */(ib2if_is_rvc) ? (pc_ff.pc + 'h2): (pc_ff.pc + 'h4);
//   assign  if2if_npc.valid = (opcode != ORV64_JALR) & (opcode != ORV64_MISC_MEM) & if_valid & ~if2id_excp.valid; // don't fetch if illegal inst (over-opt)
  assign  if2if_npc.valid = /*(opcode != ORV64_JALR) & (opcode != ORV64_MISC_MEM) &*/ ~is_sfence /*& ~is_csr_op_on_mmu & ~is_csr_op_on_frm*/ /*& ~is_ret_inst*/ & if_valid & (~amo_fsm_is_active | amo_is_done | if_kill);

  always_comb begin
    npc.pc = if2if_npc.pc;
    if (rst) begin
      npc.valid = 1'b0;
    end else if (cs2if_npc.valid & if_kill) begin
      // exception/interrupt happends: higher priority
      npc.pc = cs2if_npc.pc;
      npc.valid = 1'b1;
    end else if (wb2if_npc.valid & if_ready) begin
      npc.pc = wb2if_npc.pc;
      npc.valid = 1'b1;
    end else if (ex2if_npc.valid & if_ready) begin
      // branch taken: second high priority
      npc.pc = ex2if_npc.pc;
      npc.valid = 1'b1;
    end else if (id2if_npc.valid & if_ready) begin
      // jal branch taken
      npc.pc = id2if_npc.pc;
      npc.valid = 1'b1;
    end else if ((if2if_npc.valid | ma2if_npc_valid) & if_ready & ~if_kill) begin
      // normal cases
      npc.valid = 1'b1;
    end else begin
      npc.valid = 1'b0;
    end
  end

//   next_pc_invalid: assert property (@(posedge clk) disable iff (rst != '0) (if_valid |-> $onehot({npc_from_if, npc_from_id, npc_from_ex, npc_from_ma}))) else $fatal("");

  // INST_ADDR_MISALIGNED exception
  always_comb begin
    if2id_excp.inst = ib2if_is_rvc ? ib2if_rvc_inst: ib2if_inst;
    if (if_kill) begin
      if2id_excp.valid = 1'b0;
      if2id_excp.cause = ORV64_EXCP_CAUSE_NONE;
      if2id_excp.is_half1 = 1'b0;
    end else
      case (1'b1)
        (ib2if_excp_valid): begin
          if2id_excp.valid = 1'b1;
          if2id_excp.is_half1 = ib2if_is_half1_excp;
          if2id_excp.cause = ib2if_excp_cause;
        end
        (fp_access_excp): begin
          if2id_excp.valid = 1'b1;
          if2id_excp.is_half1 = 1'b0;
          if2id_excp.cause = ORV64_EXCP_CAUSE_ILLEGAL_INST;
        end
        ((pc_ff.pc[0] != 1'b0) & pc_ff.valid): begin 
          if2id_excp.valid = 1'b1;
          if2id_excp.is_half1 = 1'b0;
          if2id_excp.cause = ORV64_EXCP_CAUSE_INST_ADDR_MISALIGNED;
        end
        ((if2id.inst[1:0] != 2'b11) & if_valid): begin
          if2id_excp.valid = 1'b1;
          if2id_excp.is_half1 = 1'b0;
          if2id_excp.cause = ORV64_EXCP_CAUSE_ILLEGAL_INST;
        end
        default: begin
          if2id_excp.valid = 1'b0;
          if2id_excp.is_half1 = 1'b0;
          if2id_excp.cause = ORV64_EXCP_CAUSE_NONE;
        end
      endcase
  end

  // }}}
  //==========================================================
  // instr buffer
  orv64_if2ic_t       if2ib, temp_if2ib;
  orv64_ic2if_t       ib2if, temp_ib2if, ib_itb2if;
  orv64_ic2if_t             itb2if;
  logic                     itb_hit, itb_hit_ff;
  logic                     ib_hit;
  logic                     ib_miss;
  orv64_ib2da_t             ib2da;
  logic                     ib_kill;
  logic                     itb2ib_hit;
  assign ib_kill = if_kill;
  assign itb2ib_hit = itb_hit;

  orv64_inst_buffer inst_buf_u (
    .if2ib(itb_hit ? '0 : if2ib),
    .ib2if(temp_ib2if),
    .ic2ib,
    .ib2ic,
    .ib_hit, 
    .ib_miss,
    .l1_hit(ic_hit), 
    .l1_miss(ic_miss),
    .ib_kill,
    .itb2ib_hit,
    .prv,
    .mstatus,
    .pmpcfg,
    .pmpaddr,
    .ib_flush(id2ic_fence_req_valid | id2ib_flush_req_valid | cs2ib_flush_req_valid),
    .ib_idle(inst_buf_idle),
    .da2ib('b0),
    .ib2da,
    .rst, 
    .clk
  );

  orv64_inst_trace_buffer inst_trace_buf_u (
  .if2ib(if2ib),
  .ib2if(temp_ib2if),

  .itb2if,
  .itb_hit,
  .itb_hit_ff,

  .itb_flush(id2ic_fence_req_valid | id2ib_flush_req_valid | cs2ib_flush_req_valid),

  .rst, 
  .clk
);

  assign ib_itb2if = itb_hit_ff ? itb2if : temp_ib2if;

  orv64_inst_t expanded_inst;

  orv64_rvc_inst_build rvc_build_u (
    .rvc_inst(ib_itb2if.inst),
    .full_inst(expanded_inst)
  );

  assign ib2if.valid = ib_itb2if.valid;
  assign ib2if.is_rvc = ~(ib_itb2if.inst[1:0] == 2'b11);
  assign ib2if.inst = ib2if.is_rvc ? expanded_inst: ib_itb2if.inst;
  assign ib2if.rvc_inst = ib_itb2if.inst;
  assign ib2if.excp_valid = ib_itb2if.excp_valid;
  assign ib2if.excp_cause = ib_itb2if.excp_cause;
  assign ib2if.is_half1_excp = ib_itb2if.is_half1_excp;


  //==========================================================
  // Read I-Cache {{{
  logic   hold_if2ib;
  //logic   hold_ib2if, hold_ib2if_ff, if2ib_en_ff, ib2if_valid_hold;
  orv64_if2ic_t if2ib_saved_ff;

  logic         if2vid_vld;
  logic         vid2if_rdy;
  logic 		amo_valid;

  assign hold_if2ib = if2ib_en_ff & ~ib2if.valid;
  assign wait_for_icr = hold_if2ib;

  assign hold_ib2if = (~if2ib.en | if_stall | ~id_ready) & ib2if_valid_hold;


  always_ff @ (posedge clk) begin
    if (rst) begin
      if2ib_saved_ff.en <= '1;
      if2ib_saved_ff.pc <= {cfg_rst_pc[$bits(cfg_rst_pc)-1:1], 1'b0};
      hold_ib2if_ff <= '1;
      if2ib_en_ff <= '1;
      ib2if_saved_ff <= '0;
    end else begin
      if (if2ib.en) begin
        if2ib_saved_ff <= if2ib;
      end
//       if (~hold_if2ib) begin
//         if2ib_saved_ff <= if2ib;
//       end

      if2ib_en_ff <= if2ib.en;

      if (ib2if.valid) begin
        ib2if_saved_ff <= ib2if;
      end

      hold_ib2if_ff <= hold_ib2if;
    end
  end

  assign  if2ib.pc = hold_if2ib ? if2ib_saved_ff.pc : npc.pc;
//   assign  if2ib.en = ~rst & (rst_ff | (hold_if2ib ? if2ib_saved_ff.en : (if_ready & npc.valid)));
  assign  if2ib.en = ~rst & (hold_if2ib ? '1 : npc.valid);

  assign ib2if_inst = hold_ib2if_ff ? ib2if_saved_ff.inst: ib2if.inst;
  assign ib2if_rvc_inst = hold_ib2if_ff ? ib2if_saved_ff.rvc_inst: ib2if.rvc_inst;
  assign ib2if_is_rvc = (hold_ib2if_ff ? ib2if_saved_ff.is_rvc : ib2if.is_rvc);

  assign  if2id.inst = amo_valid ? final_amo_instr : ib2if_inst;
  assign  if2id.is_rvc = ib2if_is_rvc;
//  assign  if2id.is_csr_op_on_mmu = is_csr_op_on_mmu;
  assign  ib2if_valid_hold = if_kill ? 'b0 : (hold_ib2if_ff ? '1 : ib2if.valid);
  // }}}

  //==========================================================
  // Pre-decode {{{

  always_comb
    func_break_inst(.opcode(opcode), .rd_addr(rd_addr), .rs1_addr(rs1_addr), .rs2_addr(rs2_addr), .rs3_addr(rs3_addr), .funct2(funct2), .funct3(funct3), .funct5(funct5), .funct6(funct6), .funct7(funct7), .funct12(funct12), .fmt(fmt), .i_imm(i_imm), .s_imm(s_imm), .b_imm(b_imm), .u_imm(u_imm), .j_imm(j_imm), .z_imm(z_imm), .frm(frm), .inst(if2id.inst));

  assign csr_addr = orv64_csr_addr_t'(funct12);

  assign if_has_amo_inst = amo_valid & ~if_kill;

   
  // atomic generated instruction
  assign final_amo_instr = (rff_amo_state == AMO_MEM_BAR) ? ORV64_CONST_INST_NOP :
					   (rff_amo_state == AMO_MV)      ? amo_mv_instr         :
					   (rff_amo_state == AMO_LOAD)    ? amo_load_instr       :
					   (rff_amo_state == AMO_OP)      ? amo_op_instr         : 
					   (rff_amo_state == AMO_STORE)   ? amo_store_instr      : 
					   (rff_amo_state == AMO_LRSC)    ? amo_lrsc_instr      : ORV64_CONST_INST_NOP;
  // sll: x0 = 0 << [rs2] 
  assign amo_mv_instr[31:25] = 7'b0000000;
  assign amo_mv_instr[24:20] = ib2if_inst[24:20]; // rs2
  assign amo_mv_instr[19:15] = 5'b00000; //rs1=0
  assign amo_mv_instr[14:12] = 3'b001; 
  assign amo_mv_instr[11:7]  = 5'b00000; //rd=0
  assign amo_mv_instr[6:2]   = ORV64_OP;
  assign amo_mv_instr[1:0]   = 2'b11;
  
  // load: rd = 0(rs1)
  assign amo_load_instr[31:20] = '0;
  assign amo_load_instr[19:15] = ib2if_inst[19:15]; // rs1
  assign amo_load_instr[14:12] = ib2if_inst[14:12]; 
  assign amo_load_instr[11:7]  = ib2if_inst[11:7];  // rd
  assign amo_load_instr[6:2]   = ORV64_LOAD;
  assign amo_load_instr[1:0]   = ib2if_inst[1:0];

  // op
  assign amo_op_instr[31:25] = ib2if_inst[31:25];
  assign amo_op_instr[24:20] = ib2if_inst[24:20]; // rs2
  assign amo_op_instr[19:15] = ib2if_inst[11:7];  // replace rs1 with rd field
  assign amo_op_instr[14:12] = ib2if_inst[14:12]; 
  assign amo_op_instr[11:7]  = '0; 
  assign amo_op_instr[6:0]   = ib2if_inst[6:0];

  // store
  assign amo_store_instr[31:25] = '0;
  assign amo_store_instr[24:20] = '0;  
  assign amo_store_instr[19:15] = ib2if_inst[19:15]; // rs1
  assign amo_store_instr[14:12] = ib2if_inst[14:12]; 
  assign amo_store_instr[11:7]  = '0;  
  assign amo_store_instr[6:2]   = ORV64_STORE;
  assign amo_store_instr[1:0]   = ib2if_inst[1:0];

  assign amo_lrsc_instr = ib2if_inst;

  //------------------------------------------------------
  // AMO FSM
  logic amo_mem_op_start;
  logic is_amo_mem_op;
  logic is_aq;
  logic is_rl;
  logic amo_instr;
  logic amo_w_mem_bar;

  always_ff @ (posedge clk)
    if (rst) 
      rff_amo_state      <= AMO_IDLE;
    else if(id_ready) 
      rff_amo_state      <= amo_nxt;
  
//  assign amo_nxt =  if_kill ? AMO_IDLE : (rff_amo_state == AMO_IDLE)    & amo_w_mem_bar    ? AMO_MEM_BAR :
//								         (rff_amo_state == AMO_IDLE)    & amo_mem_op_start ? AMO_MV      :
//								         (rff_amo_state == AMO_MEM_BAR)                    ? AMO_MV      :
//								         (rff_amo_state == AMO_MV)                         ? AMO_LOAD    :
//		    							 (rff_amo_state == AMO_LOAD)              	       ? AMO_OP 	 :
//		    							 (rff_amo_state == AMO_OP)                	       ? AMO_STORE   :
//		    							 (rff_amo_state == AMO_STORE)             	       ? AMO_DONE    : AMO_IDLE;

  always_comb begin
    if (if_kill) begin
      amo_nxt = AMO_IDLE;
    end else begin
      case (rff_amo_state)
        AMO_IDLE: begin
          if (amo_w_mem_bar) begin
            amo_nxt = AMO_MEM_BAR;
          end else if (amo_mem_op_start) begin
            amo_nxt = AMO_MV;
          end else begin
            amo_nxt = AMO_IDLE;
          end
        end
        AMO_MEM_BAR: begin
          if ((ib2if_inst[31:27] == 5'h3) | (ib2if_inst[31:27] == 5'h2)) begin
            amo_nxt = AMO_LRSC;
          end else begin
            amo_nxt = AMO_MV;
          end
        end
        AMO_LRSC: begin
          amo_nxt = AMO_DONE;
        end
        AMO_MV: begin
          amo_nxt = AMO_LOAD;
        end
        AMO_LOAD: begin
          amo_nxt = AMO_GAP;
        end
        AMO_GAP: begin
          amo_nxt = AMO_OP;
        end
        AMO_OP: begin
          amo_nxt = AMO_STORE;
        end
        AMO_STORE: begin
          amo_nxt = AMO_DONE;
        end
        default: begin
          amo_nxt = AMO_IDLE;
        end
      endcase
    end
  end

  // check if amo instr needs memory barrier and starting condition 
  assign amo_w_mem_bar = amo_instr & (is_aq | is_rl) & ~if_kill & ib2if_valid_hold;
  //assign amo_w_mem_bar = '0;
  assign amo_mem_op_start = is_amo_mem_op & ~if_kill & ib2if_valid_hold;
  // stall condition 
  assign amo_fsm_is_active = (rff_amo_state == AMO_MEM_BAR) | (rff_amo_state == AMO_MV) | (rff_amo_state == AMO_LOAD)  | 
							 ((rff_amo_state == AMO_GAP) | rff_amo_state == AMO_OP)      | (rff_amo_state == AMO_STORE) | 
							 (rff_amo_state == AMO_IDLE) & (amo_w_mem_bar | amo_mem_op_start) | (rff_amo_state == AMO_LRSC);
  // valid signal to next stage
  assign amo_valid = (rff_amo_state == AMO_MEM_BAR) | (rff_amo_state == AMO_MV) | (rff_amo_state == AMO_LOAD)  | (rff_amo_state == AMO_GAP) |
					 (rff_amo_state == AMO_OP)      | (rff_amo_state == AMO_STORE) | (rff_amo_state == AMO_LRSC) | (rff_amo_state == AMO_DONE);
  assign amo_is_done = (rff_amo_state == AMO_DONE);
  // amo type including lr and sc
  assign amo_instr = (opcode == ORV64_AMO); 
  assign if2id_ctrl.is_aq_rl  	 = rff_amo_state == AMO_MEM_BAR;
  assign if2id_ctrl.is_amo_mv    = rff_amo_state == AMO_MV;
  assign if2id_ctrl.is_amo_load  = rff_amo_state == AMO_LOAD;
  assign if2id_ctrl.is_amo_op    = rff_amo_state == AMO_OP;
  assign if2id_ctrl.is_amo       = amo_valid;
  assign if2id_ctrl.is_amo_done  = (rff_amo_state == AMO_DONE);
  assign if2id_ctrl.is_amo_store = rff_amo_state == AMO_STORE;
  assign is_rl = funct7[0];
  assign is_aq = funct7[1];

  always_comb begin
    case (opcode)
	  ORV64_AMO:
	    case (funct7[6:2])
		  5'h0, 5'h1, 5'h4, 5'h8, 5'hC, 5'h10, 5'h14, 5'h18, 5'h1C: is_amo_mem_op = 1'b1;
		  default: is_amo_mem_op = 1'b0;
		endcase
	  default: is_amo_mem_op = 1'b0;
	endcase	 
  end

  //------------------------------------------------------
  // WFE
  logic is_wfe_inst;
  assign is_wfe_inst = ((ib2if_inst == ORV64_CONST_INST_WFE) & ib2if_valid_hold & ~if_kill);
  always_comb begin
    if (is_wfe_inst)
      is_wfe = '1;
    else
      is_wfe = '0;
  end

  //------------------------------------------------------
  // CSR operations that require csr update before continuing
/*
  always_comb begin
    if (opcode == ORV64_SYSTEM) begin
      case (funct3)
        3'h1, 3'h2, 3'h3, 3'h4, 3'h5, 3'h6, 3'h7: begin
          case (csr_addr)
            ORV64_CSR_ADDR_MSTATUS,            
            ORV64_CSR_ADDR_SSTATUS,
            ORV64_CSR_ADDR_SATP: begin
              is_csr_op_on_mmu = '1;
            end
            default: begin
              is_csr_op_on_mmu = '0;
            end
          endcase
        end
        default: begin
          is_csr_op_on_mmu = '0;
        end
      endcase
    end else begin
      is_csr_op_on_mmu = '0;
    end
  end

  always_comb begin
    if (opcode == ORV64_SYSTEM) begin
      case (funct3)
        3'h1, 3'h2, 3'h3, 3'h4, 3'h5, 3'h6, 3'h7: begin
          case (csr_addr)
            ORV64_CSR_ADDR_FRM: begin
              is_csr_op_on_frm = '1;
            end
            default: begin
              is_csr_op_on_frm = '0;
            end
          endcase
        end
        default: begin
          is_csr_op_on_frm = '0;
        end
      endcase
    end else begin
      is_csr_op_on_frm = '0;
    end
  end
*/
/*
  //------------------------------------------------------
  // branch prediction
  always_comb begin
    is_branch_predict = is_branch_predict_ff;
    if (if_kill | branch_solved)
      is_branch_predict = '0;
    if (((opcode == ORV64_JALR) | (opcode == ORV64_BRANCH)) & ib2if_valid_hold & ~if_kill) // has higher priority: corner case when ORV64_BRANCH -> xxx -> ORV64_BRANCH: 1st branch's branch_solved will shadow 2nd branch's is_branch_predict
      is_branch_predict = '1;

    wait_for_branch = '0;
    if (is_branch_predict & is_wfe_inst)
      wait_for_branch = '1;
  end

  always_ff @ (posedge clk) begin
    if (rst)
      is_branch_predict_ff <= '0;
    else
      is_branch_predict_ff <= is_branch_predict;
  end
  // }}}
*/
  //==========================================================
  // Check if is fp instr {{{
  
  always_comb begin
    case (opcode) 
      ORV64_LOAD_FP,
      ORV64_STORE_FP,
      ORV64_FMADD,
      ORV64_FMSUB,
      ORV64_FNMADD,
      ORV64_FNMSUB,
      ORV64_OP_FP: is_fp_instr = '1;
      default: is_fp_instr = '0;
    endcase
  end

  // }}}

  //==========================================================
  // Prepare to read Regfile {{{
//  assign  if2irf.rs1_addr = rs1_addr;
//  assign  if2irf.rs2_addr = rs2_addr;
//  assign  if2irf.rs1_re = ~if2id_ctrl.is_rs1_fp & if2id_ctrl.rs1_re & ~if2id_ctrl.is_rs1_x0 & if_valid & id_ready;
//  assign  if2irf.rs2_re = ~if2id_ctrl.is_rs2_fp & if2id_ctrl.rs2_re & ~if2id_ctrl.is_rs2_x0 & if_valid & id_ready;

  // assign  rs1_is_fp = if2id_ctrl.is_rs1_fp & if2id_ctrl.rs1_re & ~if2id_ctrl.is_rs1_x0;
  // assign  rs2_is_fp = if2id_ctrl.is_rs2_fp & if2id_ctrl.rs2_re & ~if2id_ctrl.is_rs2_x0;
  // assign  fp_access_excp = (mstatus.FS == 2'b00) & (is_fp_instr) & if_valid;

  // `ifdef ORV64_SUPPORT_FP
  // assign  if2fprf.rs1_addr = rs1_addr;
  // assign  if2fprf.rs2_addr = rs2_addr;
  // assign  if2fprf.rs3_addr = rs3_addr;
  // assign  if2fprf.rs1_re = if2id_ctrl.is_rs1_fp & if2id_ctrl.rs1_re & if_valid & id_ready & ~fp_access_excp;
  // assign  if2fprf.rs2_re = if2id_ctrl.is_rs2_fp & if2id_ctrl.rs2_re & if_valid & id_ready & ~fp_access_excp;
  // assign  if2fprf.rs3_re = if2id_ctrl.rs3_re & if_valid & id_ready;
  // `endif // ORV64_SUPPORT_FP
  // // }}}

  //==========================================================
  // pipeline ctrl {{{

  assign if_valid = ~if_kill & ((pc_ff.valid & ib2if_valid_hold & ~amo_fsm_is_active) | amo_valid) & ~rst & ~if_stall;
  assign if_ready = (id_ready | ~if_valid) & (ib2if_valid_hold | (~ib2if_valid_hold & ~if2ib_en_ff)) & ~if_stall /*& ~amo_fsm_is_active*/;

  assign if_is_stable_stall = ((if_valid & ~if_ready) | wait_for_npc) & ~if2ib.en;

  assign if2da.if_amo_st = rff_amo_state;
  assign if2da.wait_for_branch = 1'b0;
  assign if_inst = if2id.inst;

  always_ff @ (posedge clk)
    if (rst) begin
      if_valid_ff <= 1'b0;
    end else begin
      if (id_ready) begin
        if_valid_ff <= if_valid;
      end
    end  
      
`ifndef SYNTHESIS
  logic [63:0] if_status;
  always_comb
    case ({if_valid, if_ready})
      2'b00: if_status = "BUSY";
      2'b01: if_status = "IDLE";
      2'b10: if_status = "BLOCK";
      2'b11: if_status = "DONE";
      default: if_status = 64'bx;
    endcase
`endif
  // }}}

  //==========================================================
  // ITB Stack trace {{{

  assign if2id_itb_data.push_to_stack = 'b0;//(opcode == ORV64_JAL) & ~(rd_addr == 5'h00);
  assign if2id_itb_data.data.vpc = 'b0;//jump_pc;

  // }}}

  //==========================================================
  // output {{{
  assign if2id.pc = pc_ff.pc;
  always_ff @ (posedge clk) begin
    if (rst | ((if_kill | if2id_excp.valid) & id_ready)) begin
      if2id_ff.inst <= ORV64_CONST_INST_NOP;
      if2id_ff.pc <= if2id.pc;
      if2id_ctrl_ff.is_rs1_fp <= 1'b0;
      if2id_ctrl_ff.is_rs2_fp <= 1'b0;
      if2id_ctrl_ff.rs1_re <= 1'b0;
      if2id_ctrl_ff.rs2_re <= 1'b0;
      if2id_ctrl_ff.rs3_re <= 1'b0;
      if2id_ctrl_ff.is_rs1_x0 <= 1'b1;
      if2id_ctrl_ff.is_rs2_x0 <= 1'b1;
      if2id_ctrl_ff.is_aq_rl  <= 1'b0;
      if2id_ctrl_ff.is_amo_mv    <= 1'b0;
      if2id_ctrl_ff.is_amo_load  <= 1'b0;
      if2id_ctrl_ff.is_amo_op    <= 1'b0;
      if2id_ctrl_ff.is_amo       <= 1'b0;
      if2id_ctrl_ff.is_amo_done  <= 1'b0;
      if2id_ctrl_ff.is_amo_store <= 1'b0;

      rff_if2id_itb_data.push_to_stack <= 1'b0;
    end else begin 
      if (id_ready & if_valid) begin
        if2id_ff <= if2id;
        if2id_ctrl_ff <= if2id_ctrl; // spyglass disable W123
        rff_if2id_itb_data <= if2id_itb_data;
      end
    end

    if (rst | (if_kill & id_ready)) begin
      if2id_excp_ff.valid <= 1'b0;
      if2id_excp_ff.is_half1 <= 1'b0;
      if2id_excp_ff.cause <= ORV64_EXCP_CAUSE_NONE;
    end else if (id_ready & if_valid) begin
      if2id_excp_ff <= if2id_excp;
    end
  end
  assign wait_for_npc =~ npc.valid;

`ifndef SYNTHESIS
`ifndef VERILATOR
  chk_npc_valid_not_unknown: assert property (@ (posedge clk) disable iff (rst !== '0) (!$isunknown(if2if_npc.valid) && !$isunknown(ex2if_npc.valid) && !$isunknown(cs2if_npc.valid) && !$isunknown(ma2if_npc_valid))) else `olog_warning("ORV_FETCH", "one of the npc.valid is unknown, it will stall the creation of NPC");
  chk_if_valid_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(if_valid))) else `olog_fatal("ORV_FETCH", $sformatf("%m: if_vald is X after being reset"));
  chk_pc_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (if2ib.en |-> (!$isunknown(if2ib.pc)))) else `olog_error("ORV_FETCH", $sformatf("%m: PC is unknown"));
  chk_inst_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (if_valid |-> (!$isunknown(if2id.inst)))) else `olog_warning("ORV_FETCH", $sformatf("%m: inst is unknown, it's only OK when it's been killed later"));
`endif
`endif
  // }}}

logic is_here_pc;
assign is_here_pc = if_pc == 38'h80001cd4;

endmodule
