


`ifndef __ORV_FUNC_SV__
`define __ORV_FUNC_SV__
/** FIXME: Kill this, replace functions by modules
*/
package orv_func;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv_cfg::*;
  import orv_typedef::*;

  //==========================================================
  function automatic void func_break_inst (
    output  opcode_t      opcode,
    output  reg_addr_t    rd_addr, rs1_addr, rs2_addr,
    output  logic [ 1:0]  funct2,
    output  logic [ 2:0]  funct3,
    output  logic [ 4:0]  funct5,
    output  logic [ 5:0]  funct6,
    output  logic [ 6:0]  funct7,
    output  logic [11:0]  funct12,
    output  data_t        i_imm, s_imm, b_imm, u_imm, j_imm, z_imm,
    input   inst_t        inst
  );
    opcode    = opcode_t'(inst[6:2]);
    rd_addr   = inst[11:7];
    rs1_addr  = inst[19:15];
    rs2_addr  = inst[24:20];
    funct2    = inst[26:25];
    funct3    = inst[14:12];
    funct5    = inst[24:20];
    funct6    = inst[31:26];
    funct7    = inst[31:25];
    funct12   = inst[31:20];

    i_imm = XLEN'({ {64{inst[31]}}, inst[30:20] });
    s_imm = XLEN'({ {64{inst[31]}}, inst[30:25], inst[11:7] });
    b_imm = XLEN'({ {64{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 });
    u_imm = XLEN'({ {64{inst[31]}}, inst[31:12], 12'b0 });
    j_imm = XLEN'({ {64{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0 });
    z_imm = XLEN'({ 64'b0, inst[19:15] });

  endfunction

  function automatic void func_break_inst_rvc (
    output  rvc_opcode_t  rvc_opcode,
    output  logic [ 2:0]  rvc_funct3,
    output  logic [ 1:0]  rvc_funct2_hi, rvc_funct2_lo,
    output  logic         rvc_funct1,
    output  reg_addr_t    rvc_rs1_addr, rvc_rs2_addr, rvc_rd_addr, rvc_rs1_prime_addr, rvc_rs2_prime_addr, rvc_rd_prime_addr,
    output  data_t        rvc_nzuimm_9_2, rvc_uimm_7_3, rvc_uimm_8_4, rvc_uimm_6_2, rvc_nzimm_5_0, rvc_nzuimm_5_0, rvc_imm_11_1, rvc_imm_5_0, rvc_nzimm_9_4, rvc_nzimm_17_12, rvc_imm_8_1, rvc_uimm_8_3, rvc_uimm_9_4, rvc_uimm_7_2, rvc_uimm_8_3_c2, rvc_uimm_9_4_c2, rvc_uimm_7_2_c2,
    input   inst_t        inst
  );
    rvc_opcode  = rvc_opcode_t'(inst[1:0]);
    rvc_funct3  = inst[15:13];
    rvc_funct1  = inst[12];
    rvc_funct2_hi = inst[11:10];
    rvc_funct2_lo = inst[6:5];

    rvc_rs1_addr        = inst[11:7];
    rvc_rs2_addr        = inst[6:2];
    rvc_rd_addr         = inst[11:7];
    rvc_rs1_prime_addr  = REG_ADDR_WIDTH'({1'b1, inst[9:7]});
    rvc_rs2_prime_addr  = REG_ADDR_WIDTH'({1'b1, inst[4:2]});
    rvc_rd_prime_addr   = REG_ADDR_WIDTH'({1'b1, inst[9:7]});

    rvc_nzuimm_9_2  = XLEN'({ 64'b0, inst[10:7], inst[12:11], inst[5], inst[6], 2'b0});
    rvc_uimm_7_3    = XLEN'({ 64'b0, inst[6:5], inst[12:10], 3'b0});
    rvc_uimm_8_4    = XLEN'({ 64'b0, inst[10], inst[6:5], inst[12:11], 4'b0});
    rvc_uimm_6_2    = XLEN'({ 64'b0, inst[5], inst[12:10], inst[6], 2'b0});
    rvc_nzimm_5_0   = XLEN'({ {64{inst[12]}}, inst[12], inst[6:2]});
    rvc_nzuimm_5_0  = XLEN'({ 64'b0, inst[12], inst[6:2]});
    rvc_imm_11_1    = XLEN'({ {64{inst[12]}}, inst[12], inst[8], inst[10:9], inst[6], inst[7], inst[2], inst[11], inst[5:3], 1'b0});
    rvc_imm_5_0     = XLEN'({ {64{inst[12]}}, inst[12], inst[6:2]});
    rvc_nzimm_9_4   = XLEN'({ {64{inst[12]}}, inst[12], inst[4:3], inst[5], inst[2], inst[6], 4'b0});
    rvc_nzimm_17_12 = XLEN'({ {64{inst[12]}}, inst[12], inst[6:2], 12'b0});
    rvc_imm_8_1     = XLEN'({ {64{inst[12]}}, inst[12], inst[6:5], inst[2], inst[11:10], inst[4:3], 1'b0});
    rvc_uimm_8_3    = XLEN'({ 64'b0, inst[4:2], inst[12], inst[6:5], 3'b0});
    rvc_uimm_9_4    = XLEN'({ 64'b0, inst[5:2], inst[12], inst[6], 4'b0});
    rvc_uimm_7_2    = XLEN'({ 64'b0, inst[3:2], inst[12], inst[6:4], 2'b0});
    rvc_uimm_8_3_c2 = XLEN'({ 64'b0, inst[9:7], inst[12:10], 3'b0});
    rvc_uimm_9_4_c2 = XLEN'({ 64'b0, inst[10:7], inst[12:11], 4'b0});
    rvc_uimm_7_2_c2 = XLEN'({ 64'b0, inst[8:7], inst[12:9], 2'b0});

  endfunction

  //==========================================================
  function automatic data_t func_reverse (data_t in);
    for (int i=0; i<XLEN; i++) begin
      func_reverse[XLEN - 1 - i] = in[i];
    end
  endfunction

  //==========================================================
  function automatic data_t func_expand_byte_mask (logic [7:0] byte_mask);
    for (int i = 0; i < 8; i++) begin
      for (int j = 0; j < 8; j++) begin
        func_expand_byte_mask[i*8+j] = byte_mask[i];
      end
    end
  endfunction

  //==========================================================
  function automatic void check_perm (
    input logic             perm_x,
    input logic             perm_r,
    input logic             perm_w,
    input mem_access_type_t access_type,

    output logic        excp_valid,
    output excp_cause_t excp_cause
  );
    case (access_type)
      ACCESS_FETCH: begin
        excp_cause = ~perm_x ? EXCP_CAUSE_INST_ACCESS_FAULT : EXCP_CAUSE_NONE;
        excp_valid = ~perm_x ? '1: '0;
      end
      ACCESS_LOAD: begin
        excp_cause = ~perm_r ? EXCP_CAUSE_LOAD_ACCESS_FAULT : EXCP_CAUSE_NONE;
        excp_valid = ~perm_r ? '1: '0;
      end
      ACCESS_STORE: begin
        excp_cause = ~perm_w ? EXCP_CAUSE_STORE_ACCESS_FAULT : EXCP_CAUSE_NONE;
        excp_valid = ~perm_w ? '1: '0;
      end
      default: begin
        excp_cause = EXCP_CAUSE_NONE;
        excp_valid = '0;
      end
    endcase
  endfunction

  function automatic void get_excp_perm_type (
    input  mem_access_type_t access_type,
    output excp_cause_t      excp_cause
  );
    case (access_type)
      ACCESS_FETCH: begin
        excp_cause = EXCP_CAUSE_INST_ACCESS_FAULT;
      end
      ACCESS_LOAD: begin
        excp_cause = EXCP_CAUSE_LOAD_ACCESS_FAULT;
      end
      ACCESS_STORE: begin
        excp_cause = EXCP_CAUSE_STORE_ACCESS_FAULT;
      end
      default: begin
        excp_cause = EXCP_CAUSE_NONE;
      end
    endcase
  endfunction


  function automatic void get_fault_type (
    input  mem_access_type_t access_type,
    output excp_cause_t      excp_cause
  );
    case (access_type)
      ACCESS_FETCH: begin
        excp_cause = EXCP_CAUSE_INST_PAGE_FAULT;
      end
      ACCESS_LOAD: begin
        excp_cause = EXCP_CAUSE_LOAD_PAGE_FAULT;
      end
      ACCESS_STORE: begin
        excp_cause = EXCP_CAUSE_STORE_PAGE_FAULT;
      end
      default: begin
        excp_cause = EXCP_CAUSE_NONE;
      end
    endcase
  endfunction

endpackage

`endif
