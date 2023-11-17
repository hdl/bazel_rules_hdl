// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ALUUnit_2(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input         io_req_bits_uop_is_rvc,
  input  [3:0]  io_req_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_bits_uop_ctrl_op2_sel,
                io_req_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
                io_req_bits_uop_is_br,
                io_req_bits_uop_is_jalr,
                io_req_bits_uop_is_jal,
                io_req_bits_uop_is_sfb,
  input  [19:0] io_req_bits_uop_br_mask,
  input  [4:0]  io_req_bits_uop_br_tag,
  input  [5:0]  io_req_bits_uop_ftq_idx,
  input         io_req_bits_uop_edge_inst,
  input  [5:0]  io_req_bits_uop_pc_lob,
  input         io_req_bits_uop_taken,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_ldq_idx,
                io_req_bits_uop_stq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
                io_req_bits_uop_prs1,
  input         io_req_bits_uop_bypassable,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input  [63:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_resp_valid,
  output [6:0]  io_resp_bits_uop_rob_idx,
                io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_bypassable,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output [63:0] io_resp_bits_data,
  output        io_bypass_0_valid,
  output [6:0]  io_bypass_0_bits_uop_pdst,
  output [1:0]  io_bypass_0_bits_uop_dst_rtype,
  output [63:0] io_bypass_0_bits_data,
  output        io_bypass_1_valid,
  output [6:0]  io_bypass_1_bits_uop_pdst,
  output [1:0]  io_bypass_1_bits_uop_dst_rtype,
  output [63:0] io_bypass_1_bits_data,
  output        io_bypass_2_valid,
  output [6:0]  io_bypass_2_bits_uop_pdst,
  output [1:0]  io_bypass_2_bits_uop_dst_rtype,
  output [63:0] io_bypass_2_bits_data,
  output        io_brinfo_uop_is_rvc,
  output [19:0] io_brinfo_uop_br_mask,
  output [4:0]  io_brinfo_uop_br_tag,
  output [5:0]  io_brinfo_uop_ftq_idx,
  output        io_brinfo_uop_edge_inst,
  output [5:0]  io_brinfo_uop_pc_lob,
  output [6:0]  io_brinfo_uop_rob_idx,
  output [4:0]  io_brinfo_uop_ldq_idx,
                io_brinfo_uop_stq_idx,
  output        io_brinfo_valid,
                io_brinfo_mispredict,
                io_brinfo_taken,
  output [2:0]  io_brinfo_cfi_type,
  output [1:0]  io_brinfo_pc_sel,
  output [20:0] io_brinfo_target_offset
);

  wire [63:0] _alu_io_out;
  reg         r_valids_0;
  reg         r_valids_1;
  reg         r_valids_2;
  reg  [19:0] r_uops_0_br_mask;
  reg  [6:0]  r_uops_0_rob_idx;
  reg  [6:0]  r_uops_0_pdst;
  reg         r_uops_0_bypassable;
  reg         r_uops_0_is_amo;
  reg         r_uops_0_uses_stq;
  reg  [1:0]  r_uops_0_dst_rtype;
  reg  [19:0] r_uops_1_br_mask;
  reg  [6:0]  r_uops_1_rob_idx;
  reg  [6:0]  r_uops_1_pdst;
  reg         r_uops_1_bypassable;
  reg         r_uops_1_is_amo;
  reg         r_uops_1_uses_stq;
  reg  [1:0]  r_uops_1_dst_rtype;
  reg  [19:0] r_uops_2_br_mask;
  reg  [6:0]  r_uops_2_rob_idx;
  reg  [6:0]  r_uops_2_pdst;
  reg         r_uops_2_bypassable;
  reg         r_uops_2_is_amo;
  reg         r_uops_2_uses_stq;
  reg  [1:0]  r_uops_2_dst_rtype;
  wire [19:0] _r_valids_0_T = io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask;
  wire        _imm_xprlen_i4_1_T = io_req_bits_uop_ctrl_imm_sel == 3'h3;
  wire [10:0] imm_xprlen_i30_20 = _imm_xprlen_i4_1_T ? io_req_bits_uop_imm_packed[18:8] : {11{io_req_bits_uop_imm_packed[19]}};
  wire        _imm_xprlen_i11_T_1 = io_req_bits_uop_ctrl_imm_sel == 3'h4;
  wire [7:0]  imm_xprlen_i19_12 = _imm_xprlen_i4_1_T | _imm_xprlen_i11_T_1 ? io_req_bits_uop_imm_packed[7:0] : {8{io_req_bits_uop_imm_packed[19]}};
  wire        imm_xprlen_i11 = ~_imm_xprlen_i4_1_T & (_imm_xprlen_i11_T_1 | io_req_bits_uop_ctrl_imm_sel == 3'h2 ? io_req_bits_uop_imm_packed[8] : io_req_bits_uop_imm_packed[19]);
  wire [4:0]  imm_xprlen_i10_5 = _imm_xprlen_i4_1_T ? 5'h0 : io_req_bits_uop_imm_packed[18:14];
  wire [4:0]  imm_xprlen_i4_1 = _imm_xprlen_i4_1_T ? 5'h0 : io_req_bits_uop_imm_packed[13:9];
  wire        imm_xprlen_i0 = (io_req_bits_uop_ctrl_imm_sel == 3'h1 | io_req_bits_uop_ctrl_imm_sel == 3'h0) & io_req_bits_uop_imm_packed[8];
  wire        killed = io_req_bits_kill | (|_r_valids_0_T);
  wire        br_eq = io_req_bits_rs1_data == io_req_bits_rs2_data;
  wire        br_ltu = io_req_bits_rs1_data < io_req_bits_rs2_data;
  wire        br_lt = (io_req_bits_rs1_data[63] ^ ~(io_req_bits_rs2_data[63])) & br_ltu | io_req_bits_rs1_data[63] & ~(io_req_bits_rs2_data[63]);
  wire [1:0]  pc_sel = io_req_bits_uop_ctrl_br_type == 4'h8 ? 2'h2 : io_req_bits_uop_ctrl_br_type == 4'h7 ? 2'h1 : {1'h0, io_req_bits_uop_ctrl_br_type == 4'h6 ? br_ltu : io_req_bits_uop_ctrl_br_type == 4'h5 ? br_lt : io_req_bits_uop_ctrl_br_type == 4'h4 ? ~br_ltu : io_req_bits_uop_ctrl_br_type == 4'h3 ? ~br_lt : io_req_bits_uop_ctrl_br_type == 4'h2 ? br_eq : io_req_bits_uop_ctrl_br_type == 4'h1 & ~br_eq};
  wire        is_br = io_req_valid & ~killed & io_req_bits_uop_is_br & ~io_req_bits_uop_is_sfb;
  wire        is_jalr = io_req_valid & ~killed & io_req_bits_uop_is_jalr;
  wire        brinfo_valid = is_br | is_jalr;
  reg         r_val_0;
  reg         r_val_1;
  reg  [63:0] r_data_0;
  reg  [63:0] r_data_1;
  reg  [63:0] r_data_2;
  wire        _alu_out_T_5 = io_req_bits_uop_uopc == 7'h6D;
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;
      r_valids_1 <= 1'h0;
      r_valids_2 <= 1'h0;
      r_val_0 <= 1'h0;
      r_val_1 <= 1'h0;
    end
    else begin
      r_valids_0 <= io_req_valid & _r_valids_0_T == 20'h0 & ~io_req_bits_kill;
      r_valids_1 <= r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_valids_2 <= r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 20'h0 & ~io_req_bits_kill;
      r_val_0 <= io_req_valid;
      r_val_1 <= r_val_0;
    end
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;
    r_uops_0_pdst <= io_req_bits_uop_pdst;
    r_uops_0_bypassable <= io_req_bits_uop_bypassable;
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;
    r_uops_1_br_mask <= r_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_1_rob_idx <= r_uops_0_rob_idx;
    r_uops_1_pdst <= r_uops_0_pdst;
    r_uops_1_bypassable <= r_uops_0_bypassable;
    r_uops_1_is_amo <= r_uops_0_is_amo;
    r_uops_1_uses_stq <= r_uops_0_uses_stq;
    r_uops_1_dst_rtype <= r_uops_0_dst_rtype;
    r_uops_2_br_mask <= r_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;
    r_uops_2_rob_idx <= r_uops_1_rob_idx;
    r_uops_2_pdst <= r_uops_1_pdst;
    r_uops_2_bypassable <= r_uops_1_bypassable;
    r_uops_2_is_amo <= r_uops_1_is_amo;
    r_uops_2_uses_stq <= r_uops_1_uses_stq;
    r_uops_2_dst_rtype <= r_uops_1_dst_rtype;
    if (_alu_out_T_5)
      r_data_0 <= io_req_bits_rs2_data;
    else
      r_data_0 <= _alu_io_out;
    r_data_1 <= r_data_0;
    r_data_2 <= r_data_1;
  end // always @(posedge)
  ALU alu (
    .io_dw  (io_req_bits_uop_ctrl_fcn_dw),
    .io_fn  (io_req_bits_uop_ctrl_op_fcn),
    .io_in2 (io_req_bits_uop_ctrl_op2_sel == 3'h1 ? {{33{io_req_bits_uop_imm_packed[19]}}, imm_xprlen_i30_20, imm_xprlen_i19_12, imm_xprlen_i11, imm_xprlen_i10_5, imm_xprlen_i4_1, imm_xprlen_i0} : io_req_bits_uop_ctrl_op2_sel == 3'h4 ? {59'h0, io_req_bits_uop_prs1[4:0]} : io_req_bits_uop_ctrl_op2_sel == 3'h0 ? io_req_bits_rs2_data : {61'h0, io_req_bits_uop_ctrl_op2_sel == 3'h3 ? (io_req_bits_uop_is_rvc ? 3'h2 : 3'h4) : 3'h0}),
    .io_in1 (io_req_bits_uop_ctrl_op1_sel == 2'h0 ? io_req_bits_rs1_data : 64'h0),
    .io_out (_alu_io_out)
  );
  assign io_resp_valid = r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 20'h0;
  assign io_resp_bits_uop_rob_idx = r_uops_2_rob_idx;
  assign io_resp_bits_uop_pdst = r_uops_2_pdst;
  assign io_resp_bits_uop_bypassable = r_uops_2_bypassable;
  assign io_resp_bits_uop_is_amo = r_uops_2_is_amo;
  assign io_resp_bits_uop_uses_stq = r_uops_2_uses_stq;
  assign io_resp_bits_uop_dst_rtype = r_uops_2_dst_rtype;
  assign io_resp_bits_data = r_data_2;
  assign io_bypass_0_valid = io_req_valid;
  assign io_bypass_0_bits_uop_pdst = io_req_bits_uop_pdst;
  assign io_bypass_0_bits_uop_dst_rtype = io_req_bits_uop_dst_rtype;
  assign io_bypass_0_bits_data = _alu_out_T_5 ? io_req_bits_rs2_data : _alu_io_out;
  assign io_bypass_1_valid = r_val_0;
  assign io_bypass_1_bits_uop_pdst = r_uops_0_pdst;
  assign io_bypass_1_bits_uop_dst_rtype = r_uops_0_dst_rtype;
  assign io_bypass_1_bits_data = r_data_0;
  assign io_bypass_2_valid = r_val_1;
  assign io_bypass_2_bits_uop_pdst = r_uops_1_pdst;
  assign io_bypass_2_bits_uop_dst_rtype = r_uops_1_dst_rtype;
  assign io_bypass_2_bits_data = r_data_1;
  assign io_brinfo_uop_is_rvc = io_req_bits_uop_is_rvc;
  assign io_brinfo_uop_br_mask = io_req_bits_uop_br_mask;
  assign io_brinfo_uop_br_tag = io_req_bits_uop_br_tag;
  assign io_brinfo_uop_ftq_idx = io_req_bits_uop_ftq_idx;
  assign io_brinfo_uop_edge_inst = io_req_bits_uop_edge_inst;
  assign io_brinfo_uop_pc_lob = io_req_bits_uop_pc_lob;
  assign io_brinfo_uop_rob_idx = io_req_bits_uop_rob_idx;
  assign io_brinfo_uop_ldq_idx = io_req_bits_uop_ldq_idx;
  assign io_brinfo_uop_stq_idx = io_req_bits_uop_stq_idx;
  assign io_brinfo_valid = brinfo_valid;
  assign io_brinfo_mispredict = brinfo_valid & (pc_sel == 2'h1 ? ~io_req_bits_uop_taken : pc_sel == 2'h0 & io_req_bits_uop_taken);
  assign io_brinfo_taken = io_req_valid & ~killed & (io_req_bits_uop_is_br | io_req_bits_uop_is_jalr | io_req_bits_uop_is_jal) & (|pc_sel);
  assign io_brinfo_cfi_type = is_jalr ? 3'h3 : {2'h0, is_br};
  assign io_brinfo_pc_sel = pc_sel;
  assign io_brinfo_target_offset = {imm_xprlen_i30_20[0], imm_xprlen_i19_12, imm_xprlen_i11, imm_xprlen_i10_5, imm_xprlen_i4_1, imm_xprlen_i0};
endmodule

