// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IssueSlot_32(
  input         clock,
                reset,
                io_grant,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_kill,
                io_clear,
                io_ldspec_miss,
                io_wakeup_ports_0_valid,
  input  [6:0]  io_wakeup_ports_0_bits_pdst,
  input         io_wakeup_ports_1_valid,
  input  [6:0]  io_wakeup_ports_1_bits_pdst,
  input         io_wakeup_ports_2_valid,
  input  [6:0]  io_wakeup_ports_2_bits_pdst,
  input         io_wakeup_ports_3_valid,
  input  [6:0]  io_wakeup_ports_3_bits_pdst,
  input         io_wakeup_ports_4_valid,
  input  [6:0]  io_wakeup_ports_4_bits_pdst,
  input         io_wakeup_ports_5_valid,
  input  [6:0]  io_wakeup_ports_5_bits_pdst,
  input         io_wakeup_ports_6_valid,
  input  [6:0]  io_wakeup_ports_6_bits_pdst,
  input         io_wakeup_ports_7_valid,
  input  [6:0]  io_wakeup_ports_7_bits_pdst,
  input         io_wakeup_ports_8_valid,
  input  [6:0]  io_wakeup_ports_8_bits_pdst,
  input         io_wakeup_ports_9_valid,
  input  [6:0]  io_wakeup_ports_9_bits_pdst,
  input         io_spec_ld_wakeup_0_valid,
  input  [6:0]  io_spec_ld_wakeup_0_bits,
  input         io_spec_ld_wakeup_1_valid,
  input  [6:0]  io_spec_ld_wakeup_1_bits,
  input         io_in_uop_valid,
  input  [6:0]  io_in_uop_bits_uopc,
  input         io_in_uop_bits_is_rvc,
  input  [9:0]  io_in_uop_bits_fu_code,
  input  [1:0]  io_in_uop_bits_iw_state,
  input         io_in_uop_bits_iw_p1_poisoned,
                io_in_uop_bits_iw_p2_poisoned,
                io_in_uop_bits_is_br,
                io_in_uop_bits_is_jalr,
                io_in_uop_bits_is_jal,
                io_in_uop_bits_is_sfb,
  input  [19:0] io_in_uop_bits_br_mask,
  input  [4:0]  io_in_uop_bits_br_tag,
  input  [5:0]  io_in_uop_bits_ftq_idx,
  input         io_in_uop_bits_edge_inst,
  input  [5:0]  io_in_uop_bits_pc_lob,
  input         io_in_uop_bits_taken,
  input  [19:0] io_in_uop_bits_imm_packed,
  input  [6:0]  io_in_uop_bits_rob_idx,
  input  [4:0]  io_in_uop_bits_ldq_idx,
                io_in_uop_bits_stq_idx,
  input  [6:0]  io_in_uop_bits_pdst,
                io_in_uop_bits_prs1,
                io_in_uop_bits_prs2,
                io_in_uop_bits_prs3,
  input         io_in_uop_bits_prs1_busy,
                io_in_uop_bits_prs2_busy,
                io_in_uop_bits_prs3_busy,
                io_in_uop_bits_ppred_busy,
                io_in_uop_bits_bypassable,
  input  [4:0]  io_in_uop_bits_mem_cmd,
  input  [1:0]  io_in_uop_bits_mem_size,
  input         io_in_uop_bits_mem_signed,
                io_in_uop_bits_is_fence,
                io_in_uop_bits_is_amo,
                io_in_uop_bits_uses_ldq,
                io_in_uop_bits_uses_stq,
                io_in_uop_bits_ldst_val,
  input  [1:0]  io_in_uop_bits_dst_rtype,
                io_in_uop_bits_lrs1_rtype,
                io_in_uop_bits_lrs2_rtype,
  input         io_in_uop_bits_fp_val,
  output        io_valid,
                io_will_be_valid,
                io_request,
  output [6:0]  io_out_uop_uopc,
  output        io_out_uop_is_rvc,
  output [9:0]  io_out_uop_fu_code,
  output [1:0]  io_out_uop_iw_state,
  output        io_out_uop_iw_p1_poisoned,
                io_out_uop_iw_p2_poisoned,
                io_out_uop_is_br,
                io_out_uop_is_jalr,
                io_out_uop_is_jal,
                io_out_uop_is_sfb,
  output [19:0] io_out_uop_br_mask,
  output [4:0]  io_out_uop_br_tag,
  output [5:0]  io_out_uop_ftq_idx,
  output        io_out_uop_edge_inst,
  output [5:0]  io_out_uop_pc_lob,
  output        io_out_uop_taken,
  output [19:0] io_out_uop_imm_packed,
  output [6:0]  io_out_uop_rob_idx,
  output [4:0]  io_out_uop_ldq_idx,
                io_out_uop_stq_idx,
  output [6:0]  io_out_uop_pdst,
                io_out_uop_prs1,
                io_out_uop_prs2,
                io_out_uop_prs3,
  output        io_out_uop_prs1_busy,
                io_out_uop_prs2_busy,
                io_out_uop_prs3_busy,
                io_out_uop_ppred_busy,
                io_out_uop_bypassable,
  output [4:0]  io_out_uop_mem_cmd,
  output [1:0]  io_out_uop_mem_size,
  output        io_out_uop_mem_signed,
                io_out_uop_is_fence,
                io_out_uop_is_amo,
                io_out_uop_uses_ldq,
                io_out_uop_uses_stq,
                io_out_uop_ldst_val,
  output [1:0]  io_out_uop_dst_rtype,
                io_out_uop_lrs1_rtype,
                io_out_uop_lrs2_rtype,
  output        io_out_uop_fp_val,
  output [6:0]  io_uop_uopc,
  output        io_uop_is_rvc,
  output [9:0]  io_uop_fu_code,
  output        io_uop_iw_p1_poisoned,
                io_uop_iw_p2_poisoned,
                io_uop_is_br,
                io_uop_is_jalr,
                io_uop_is_jal,
                io_uop_is_sfb,
  output [19:0] io_uop_br_mask,
  output [4:0]  io_uop_br_tag,
  output [5:0]  io_uop_ftq_idx,
  output        io_uop_edge_inst,
  output [5:0]  io_uop_pc_lob,
  output        io_uop_taken,
  output [19:0] io_uop_imm_packed,
  output [6:0]  io_uop_rob_idx,
  output [4:0]  io_uop_ldq_idx,
                io_uop_stq_idx,
  output [6:0]  io_uop_pdst,
                io_uop_prs1,
                io_uop_prs2,
  output        io_uop_bypassable,
  output [4:0]  io_uop_mem_cmd,
  output [1:0]  io_uop_mem_size,
  output        io_uop_mem_signed,
                io_uop_is_fence,
                io_uop_is_amo,
                io_uop_uses_ldq,
                io_uop_uses_stq,
                io_uop_ldst_val,
  output [1:0]  io_uop_dst_rtype,
                io_uop_lrs1_rtype,
                io_uop_lrs2_rtype,
  output        io_uop_fp_val
);

  reg  [1:0]  state;
  reg         p1;
  reg         p2;
  reg         p3;
  reg         ppred;
  reg         p1_poisoned;
  reg         p2_poisoned;
  wire        next_p1_poisoned = io_in_uop_valid ? io_in_uop_bits_iw_p1_poisoned : p1_poisoned;
  wire        next_p2_poisoned = io_in_uop_valid ? io_in_uop_bits_iw_p2_poisoned : p2_poisoned;
  reg  [6:0]  slot_uop_uopc;
  reg         slot_uop_is_rvc;
  reg  [9:0]  slot_uop_fu_code;
  reg         slot_uop_is_br;
  reg         slot_uop_is_jalr;
  reg         slot_uop_is_jal;
  reg         slot_uop_is_sfb;
  reg  [19:0] slot_uop_br_mask;
  reg  [4:0]  slot_uop_br_tag;
  reg  [5:0]  slot_uop_ftq_idx;
  reg         slot_uop_edge_inst;
  reg  [5:0]  slot_uop_pc_lob;
  reg         slot_uop_taken;
  reg  [19:0] slot_uop_imm_packed;
  reg  [6:0]  slot_uop_rob_idx;
  reg  [4:0]  slot_uop_ldq_idx;
  reg  [4:0]  slot_uop_stq_idx;
  reg  [6:0]  slot_uop_pdst;
  reg  [6:0]  slot_uop_prs1;
  reg  [6:0]  slot_uop_prs2;
  reg  [6:0]  slot_uop_prs3;
  reg         slot_uop_bypassable;
  reg  [4:0]  slot_uop_mem_cmd;
  reg  [1:0]  slot_uop_mem_size;
  reg         slot_uop_mem_signed;
  reg         slot_uop_is_fence;
  reg         slot_uop_is_amo;
  reg         slot_uop_uses_ldq;
  reg         slot_uop_uses_stq;
  reg         slot_uop_ldst_val;
  reg  [1:0]  slot_uop_dst_rtype;
  reg  [1:0]  slot_uop_lrs1_rtype;
  reg  [1:0]  slot_uop_lrs2_rtype;
  reg         slot_uop_fp_val;
  wire [6:0]  next_uop_prs1 = io_in_uop_valid ? io_in_uop_bits_prs1 : slot_uop_prs1;
  wire [6:0]  next_uop_prs2 = io_in_uop_valid ? io_in_uop_bits_prs2 : slot_uop_prs2;
  wire        _may_vacate_T = state == 2'h1;
  wire        _may_vacate_T_1 = state == 2'h2;
  wire        _GEN = io_grant & _may_vacate_T_1;
  wire        _GEN_0 = io_grant & _may_vacate_T | _GEN & p1 & p2 & ppred;
  wire        _squash_grant_T = p1_poisoned | p2_poisoned;
  wire        _GEN_1 = io_ldspec_miss & _squash_grant_T;
  wire        _GEN_2 = _GEN & ~_GEN_1;
  wire        _GEN_3 = (|(io_brupdate_b1_mispredict_mask & slot_uop_br_mask)) | io_kill;
  wire        _GEN_4 = io_kill | _GEN_0;
  wire        _GEN_5 = _GEN_4 | ~(_GEN & ~_GEN_1 & p1);
  wire        _GEN_6 = _GEN_4 | ~_GEN_2 | p1;
  wire        _GEN_7 = io_ldspec_miss & next_p1_poisoned;
  wire        _GEN_8 = io_ldspec_miss & next_p2_poisoned;
  wire        _GEN_9 = (io_in_uop_valid ? io_in_uop_bits_lrs1_rtype : slot_uop_lrs1_rtype) == 2'h0;
  wire        _GEN_140 = io_spec_ld_wakeup_0_valid & io_spec_ld_wakeup_0_bits == next_uop_prs1 & _GEN_9;
  wire        _GEN_10 = (io_in_uop_valid ? io_in_uop_bits_lrs2_rtype : slot_uop_lrs2_rtype) == 2'h0;
  wire        _GEN_142 = io_spec_ld_wakeup_0_valid & io_spec_ld_wakeup_0_bits == next_uop_prs2 & _GEN_10;
  wire        _GEN_11 = io_spec_ld_wakeup_1_valid & io_spec_ld_wakeup_1_bits == next_uop_prs1 & _GEN_9;
  wire        _GEN_12 = io_spec_ld_wakeup_1_valid & io_spec_ld_wakeup_1_bits == next_uop_prs2 & _GEN_10;
  wire [19:0] next_br_mask = slot_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  wire        _io_request_T_7 = p1 & p2;
  wire        _GEN_13 = _io_request_T_7 & ppred;
  wire        _GEN_14 = p1 & ppred;
  wire        _GEN_15 = ~_may_vacate_T_1 | _GEN_13 | _GEN_14 | ~(p2 & ppred);
  wire [6:0]  next_uop_prs3 = io_in_uop_valid ? io_in_uop_bits_prs3 : slot_uop_prs3;
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
      p1 <= 1'h0;
      p2 <= 1'h0;
      p3 <= 1'h0;
      ppred <= 1'h0;
      p1_poisoned <= 1'h0;
      p2_poisoned <= 1'h0;
      slot_uop_uopc <= 7'h0;
      slot_uop_pdst <= 7'h0;
      slot_uop_bypassable <= 1'h0;
      slot_uop_uses_ldq <= 1'h0;
      slot_uop_uses_stq <= 1'h0;
      slot_uop_dst_rtype <= 2'h2;
      slot_uop_fp_val <= 1'h0;
    end
    else begin
      if (io_kill)
        state <= 2'h0;
      else if (io_in_uop_valid)
        state <= io_in_uop_bits_iw_state;
      else if (io_clear | _GEN_3)
        state <= 2'h0;
      else if (_GEN_0) begin
        if (~_GEN_1)
          state <= 2'h0;
      end
      else if (_GEN_2)
        state <= 2'h1;
      p1 <= _GEN_11 | _GEN_140 | io_wakeup_ports_9_valid & io_wakeup_ports_9_bits_pdst == next_uop_prs1 | io_wakeup_ports_8_valid & io_wakeup_ports_8_bits_pdst == next_uop_prs1 | io_wakeup_ports_7_valid & io_wakeup_ports_7_bits_pdst == next_uop_prs1 | io_wakeup_ports_6_valid & io_wakeup_ports_6_bits_pdst == next_uop_prs1 | io_wakeup_ports_5_valid & io_wakeup_ports_5_bits_pdst == next_uop_prs1 | io_wakeup_ports_4_valid & io_wakeup_ports_4_bits_pdst == next_uop_prs1 | io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs1 | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs1 | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs1 | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs1 | ~_GEN_7 & (io_in_uop_valid ? ~io_in_uop_bits_prs1_busy : p1);
      p2 <= _GEN_12 | _GEN_142 | io_wakeup_ports_9_valid & io_wakeup_ports_9_bits_pdst == next_uop_prs2 | io_wakeup_ports_8_valid & io_wakeup_ports_8_bits_pdst == next_uop_prs2 | io_wakeup_ports_7_valid & io_wakeup_ports_7_bits_pdst == next_uop_prs2 | io_wakeup_ports_6_valid & io_wakeup_ports_6_bits_pdst == next_uop_prs2 | io_wakeup_ports_5_valid & io_wakeup_ports_5_bits_pdst == next_uop_prs2 | io_wakeup_ports_4_valid & io_wakeup_ports_4_bits_pdst == next_uop_prs2 | io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs2 | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs2 | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs2 | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs2 | ~_GEN_8 & (io_in_uop_valid ? ~io_in_uop_bits_prs2_busy : p2);
      p3 <= io_wakeup_ports_9_valid & io_wakeup_ports_9_bits_pdst == next_uop_prs3 | io_wakeup_ports_8_valid & io_wakeup_ports_8_bits_pdst == next_uop_prs3 | io_wakeup_ports_7_valid & io_wakeup_ports_7_bits_pdst == next_uop_prs3 | io_wakeup_ports_6_valid & io_wakeup_ports_6_bits_pdst == next_uop_prs3 | io_wakeup_ports_5_valid & io_wakeup_ports_5_bits_pdst == next_uop_prs3 | io_wakeup_ports_4_valid & io_wakeup_ports_4_bits_pdst == next_uop_prs3 | io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs3 | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs3 | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs3 | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs3 | (io_in_uop_valid ? ~io_in_uop_bits_prs3_busy : p3);
      if (io_in_uop_valid) begin
        ppred <= ~io_in_uop_bits_ppred_busy;
        slot_uop_uopc <= io_in_uop_bits_uopc;
        slot_uop_pdst <= io_in_uop_bits_pdst;
        slot_uop_bypassable <= io_in_uop_bits_bypassable;
        slot_uop_uses_ldq <= io_in_uop_bits_uses_ldq;
        slot_uop_uses_stq <= io_in_uop_bits_uses_stq;
        slot_uop_dst_rtype <= io_in_uop_bits_dst_rtype;
        slot_uop_fp_val <= io_in_uop_bits_fp_val;
      end
      else if (_GEN_5) begin
      end
      else
        slot_uop_uopc <= 7'h3;
      p1_poisoned <= _GEN_11 | _GEN_140;
      p2_poisoned <= _GEN_12 | _GEN_142;
    end
    if (io_in_uop_valid) begin
      slot_uop_is_rvc <= io_in_uop_bits_is_rvc;
      slot_uop_fu_code <= io_in_uop_bits_fu_code;
      slot_uop_is_br <= io_in_uop_bits_is_br;
      slot_uop_is_jalr <= io_in_uop_bits_is_jalr;
      slot_uop_is_jal <= io_in_uop_bits_is_jal;
      slot_uop_is_sfb <= io_in_uop_bits_is_sfb;
      slot_uop_br_mask <= io_in_uop_bits_br_mask;
      slot_uop_br_tag <= io_in_uop_bits_br_tag;
      slot_uop_ftq_idx <= io_in_uop_bits_ftq_idx;
      slot_uop_edge_inst <= io_in_uop_bits_edge_inst;
      slot_uop_pc_lob <= io_in_uop_bits_pc_lob;
      slot_uop_taken <= io_in_uop_bits_taken;
      slot_uop_imm_packed <= io_in_uop_bits_imm_packed;
      slot_uop_rob_idx <= io_in_uop_bits_rob_idx;
      slot_uop_ldq_idx <= io_in_uop_bits_ldq_idx;
      slot_uop_stq_idx <= io_in_uop_bits_stq_idx;
      slot_uop_prs1 <= io_in_uop_bits_prs1;
      slot_uop_prs2 <= io_in_uop_bits_prs2;
      slot_uop_prs3 <= io_in_uop_bits_prs3;
      slot_uop_mem_cmd <= io_in_uop_bits_mem_cmd;
      slot_uop_mem_size <= io_in_uop_bits_mem_size;
      slot_uop_mem_signed <= io_in_uop_bits_mem_signed;
      slot_uop_is_fence <= io_in_uop_bits_is_fence;
      slot_uop_is_amo <= io_in_uop_bits_is_amo;
      slot_uop_ldst_val <= io_in_uop_bits_ldst_val;
      slot_uop_lrs1_rtype <= io_in_uop_bits_lrs1_rtype;
      slot_uop_lrs2_rtype <= io_in_uop_bits_lrs2_rtype;
    end
    else begin
      slot_uop_br_mask <= next_br_mask;
      if (_GEN_5) begin
      end
      else
        slot_uop_lrs1_rtype <= 2'h2;
      if (_GEN_6) begin
      end
      else
        slot_uop_lrs2_rtype <= 2'h2;
    end
  end // always @(posedge)
  assign io_valid = |state;
  assign io_will_be_valid = (|state) & ~(io_grant & (_may_vacate_T | _may_vacate_T_1 & p1 & p2 & ppred) & ~(io_ldspec_miss & _squash_grant_T));
  assign io_request = _may_vacate_T ? _io_request_T_7 & p3 & ppred & ~io_kill : _may_vacate_T_1 & (p1 | p2) & ppred & ~io_kill;
  assign io_out_uop_uopc = _GEN_5 ? slot_uop_uopc : 7'h3;
  assign io_out_uop_is_rvc = slot_uop_is_rvc;
  assign io_out_uop_fu_code = slot_uop_fu_code;
  assign io_out_uop_iw_state = _GEN_3 ? 2'h0 : _GEN_0 ? (_GEN_1 ? state : 2'h0) : _GEN_2 ? 2'h1 : state;
  assign io_out_uop_iw_p1_poisoned = p1_poisoned;
  assign io_out_uop_iw_p2_poisoned = p2_poisoned;
  assign io_out_uop_is_br = slot_uop_is_br;
  assign io_out_uop_is_jalr = slot_uop_is_jalr;
  assign io_out_uop_is_jal = slot_uop_is_jal;
  assign io_out_uop_is_sfb = slot_uop_is_sfb;
  assign io_out_uop_br_mask = next_br_mask;
  assign io_out_uop_br_tag = slot_uop_br_tag;
  assign io_out_uop_ftq_idx = slot_uop_ftq_idx;
  assign io_out_uop_edge_inst = slot_uop_edge_inst;
  assign io_out_uop_pc_lob = slot_uop_pc_lob;
  assign io_out_uop_taken = slot_uop_taken;
  assign io_out_uop_imm_packed = slot_uop_imm_packed;
  assign io_out_uop_rob_idx = slot_uop_rob_idx;
  assign io_out_uop_ldq_idx = slot_uop_ldq_idx;
  assign io_out_uop_stq_idx = slot_uop_stq_idx;
  assign io_out_uop_pdst = slot_uop_pdst;
  assign io_out_uop_prs1 = slot_uop_prs1;
  assign io_out_uop_prs2 = slot_uop_prs2;
  assign io_out_uop_prs3 = slot_uop_prs3;
  assign io_out_uop_prs1_busy = ~p1;
  assign io_out_uop_prs2_busy = ~p2;
  assign io_out_uop_prs3_busy = ~p3;
  assign io_out_uop_ppred_busy = ~ppred;
  assign io_out_uop_bypassable = slot_uop_bypassable;
  assign io_out_uop_mem_cmd = slot_uop_mem_cmd;
  assign io_out_uop_mem_size = slot_uop_mem_size;
  assign io_out_uop_mem_signed = slot_uop_mem_signed;
  assign io_out_uop_is_fence = slot_uop_is_fence;
  assign io_out_uop_is_amo = slot_uop_is_amo;
  assign io_out_uop_uses_ldq = slot_uop_uses_ldq;
  assign io_out_uop_uses_stq = slot_uop_uses_stq;
  assign io_out_uop_ldst_val = slot_uop_ldst_val;
  assign io_out_uop_dst_rtype = slot_uop_dst_rtype;
  assign io_out_uop_lrs1_rtype = _GEN_5 ? slot_uop_lrs1_rtype : 2'h2;
  assign io_out_uop_lrs2_rtype = _GEN_6 ? slot_uop_lrs2_rtype : 2'h2;
  assign io_out_uop_fp_val = slot_uop_fp_val;
  assign io_uop_uopc = _GEN_15 ? slot_uop_uopc : 7'h3;
  assign io_uop_is_rvc = slot_uop_is_rvc;
  assign io_uop_fu_code = slot_uop_fu_code;
  assign io_uop_iw_p1_poisoned = p1_poisoned;
  assign io_uop_iw_p2_poisoned = p2_poisoned;
  assign io_uop_is_br = slot_uop_is_br;
  assign io_uop_is_jalr = slot_uop_is_jalr;
  assign io_uop_is_jal = slot_uop_is_jal;
  assign io_uop_is_sfb = slot_uop_is_sfb;
  assign io_uop_br_mask = slot_uop_br_mask;
  assign io_uop_br_tag = slot_uop_br_tag;
  assign io_uop_ftq_idx = slot_uop_ftq_idx;
  assign io_uop_edge_inst = slot_uop_edge_inst;
  assign io_uop_pc_lob = slot_uop_pc_lob;
  assign io_uop_taken = slot_uop_taken;
  assign io_uop_imm_packed = slot_uop_imm_packed;
  assign io_uop_rob_idx = slot_uop_rob_idx;
  assign io_uop_ldq_idx = slot_uop_ldq_idx;
  assign io_uop_stq_idx = slot_uop_stq_idx;
  assign io_uop_pdst = slot_uop_pdst;
  assign io_uop_prs1 = slot_uop_prs1;
  assign io_uop_prs2 = slot_uop_prs2;
  assign io_uop_bypassable = slot_uop_bypassable;
  assign io_uop_mem_cmd = slot_uop_mem_cmd;
  assign io_uop_mem_size = slot_uop_mem_size;
  assign io_uop_mem_signed = slot_uop_mem_signed;
  assign io_uop_is_fence = slot_uop_is_fence;
  assign io_uop_is_amo = slot_uop_is_amo;
  assign io_uop_uses_ldq = slot_uop_uses_ldq;
  assign io_uop_uses_stq = slot_uop_uses_stq;
  assign io_uop_ldst_val = slot_uop_ldst_val;
  assign io_uop_dst_rtype = slot_uop_dst_rtype;
  assign io_uop_lrs1_rtype = _GEN_15 ? slot_uop_lrs1_rtype : 2'h2;
  assign io_uop_lrs2_rtype = ~_may_vacate_T_1 | _GEN_13 | ~_GEN_14 ? slot_uop_lrs2_rtype : 2'h2;
  assign io_uop_fp_val = slot_uop_fp_val;
endmodule

