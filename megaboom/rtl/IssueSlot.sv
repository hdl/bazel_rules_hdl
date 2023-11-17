// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IssueSlot(
  input         clock,
                reset,
                io_grant,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_kill,
                io_clear,
                io_wakeup_ports_0_valid,
  input  [6:0]  io_wakeup_ports_0_bits_pdst,
  input         io_wakeup_ports_1_valid,
  input  [6:0]  io_wakeup_ports_1_bits_pdst,
  input         io_wakeup_ports_2_valid,
  input  [6:0]  io_wakeup_ports_2_bits_pdst,
  input         io_wakeup_ports_3_valid,
  input  [6:0]  io_wakeup_ports_3_bits_pdst,
  input         io_in_uop_valid,
  input  [6:0]  io_in_uop_bits_uopc,
  input  [9:0]  io_in_uop_bits_fu_code,
  input  [1:0]  io_in_uop_bits_iw_state,
  input  [19:0] io_in_uop_bits_br_mask,
                io_in_uop_bits_imm_packed,
  input  [6:0]  io_in_uop_bits_rob_idx,
  input  [4:0]  io_in_uop_bits_stq_idx,
  input  [6:0]  io_in_uop_bits_pdst,
                io_in_uop_bits_prs1,
                io_in_uop_bits_prs2,
                io_in_uop_bits_prs3,
  input         io_in_uop_bits_prs1_busy,
                io_in_uop_bits_prs2_busy,
                io_in_uop_bits_prs3_busy,
                io_in_uop_bits_ppred_busy,
  input  [4:0]  io_in_uop_bits_mem_cmd,
  input         io_in_uop_bits_is_amo,
                io_in_uop_bits_uses_ldq,
                io_in_uop_bits_uses_stq,
  input  [1:0]  io_in_uop_bits_dst_rtype,
  input         io_in_uop_bits_fp_val,
  output        io_valid,
                io_will_be_valid,
                io_request,
  output [6:0]  io_out_uop_uopc,
  output [9:0]  io_out_uop_fu_code,
  output [1:0]  io_out_uop_iw_state,
  output [19:0] io_out_uop_br_mask,
                io_out_uop_imm_packed,
  output [6:0]  io_out_uop_rob_idx,
  output [4:0]  io_out_uop_stq_idx,
  output [6:0]  io_out_uop_pdst,
                io_out_uop_prs1,
                io_out_uop_prs2,
                io_out_uop_prs3,
  output        io_out_uop_prs1_busy,
                io_out_uop_prs2_busy,
                io_out_uop_prs3_busy,
                io_out_uop_ppred_busy,
  output [4:0]  io_out_uop_mem_cmd,
  output        io_out_uop_is_amo,
                io_out_uop_uses_ldq,
                io_out_uop_uses_stq,
  output [1:0]  io_out_uop_dst_rtype,
  output        io_out_uop_fp_val,
  output [6:0]  io_uop_uopc,
  output [9:0]  io_uop_fu_code,
  output [19:0] io_uop_br_mask,
                io_uop_imm_packed,
  output [6:0]  io_uop_rob_idx,
  output [4:0]  io_uop_stq_idx,
  output [6:0]  io_uop_pdst,
                io_uop_prs1,
                io_uop_prs2,
                io_uop_prs3,
  output [4:0]  io_uop_mem_cmd,
  output        io_uop_is_amo,
                io_uop_uses_ldq,
                io_uop_uses_stq,
  output [1:0]  io_uop_dst_rtype,
  output        io_uop_fp_val
);

  reg  [1:0]  state;
  reg         p1;
  reg         p2;
  reg         p3;
  reg         ppred;
  reg  [6:0]  slot_uop_uopc;
  reg  [9:0]  slot_uop_fu_code;
  reg  [19:0] slot_uop_br_mask;
  reg  [19:0] slot_uop_imm_packed;
  reg  [6:0]  slot_uop_rob_idx;
  reg  [4:0]  slot_uop_stq_idx;
  reg  [6:0]  slot_uop_pdst;
  reg  [6:0]  slot_uop_prs1;
  reg  [6:0]  slot_uop_prs2;
  reg  [6:0]  slot_uop_prs3;
  reg  [4:0]  slot_uop_mem_cmd;
  reg         slot_uop_is_amo;
  reg         slot_uop_uses_ldq;
  reg         slot_uop_uses_stq;
  reg  [1:0]  slot_uop_dst_rtype;
  reg         slot_uop_fp_val;
  wire        _may_vacate_T = state == 2'h1;
  wire        _may_vacate_T_1 = state == 2'h2;
  wire        _GEN = io_grant & _may_vacate_T_1;
  wire        _GEN_0 = _GEN & p1;
  wire        _GEN_1 = io_grant & _may_vacate_T | _GEN_0 & p2 & ppred;
  wire        _GEN_2 = (|(io_brupdate_b1_mispredict_mask & slot_uop_br_mask)) | io_kill;
  wire        _GEN_3 = io_kill | _GEN_1 | ~_GEN_0;
  wire [19:0] next_br_mask = slot_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  wire        _io_request_T_7 = p1 & p2;
  wire [6:0]  next_uop_prs1 = io_in_uop_valid ? io_in_uop_bits_prs1 : slot_uop_prs1;
  wire [6:0]  next_uop_prs2 = io_in_uop_valid ? io_in_uop_bits_prs2 : slot_uop_prs2;
  wire [6:0]  next_uop_prs3 = io_in_uop_valid ? io_in_uop_bits_prs3 : slot_uop_prs3;
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
      p1 <= 1'h0;
      p2 <= 1'h0;
      p3 <= 1'h0;
      ppred <= 1'h0;
      slot_uop_uopc <= 7'h0;
      slot_uop_pdst <= 7'h0;
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
      else if (io_clear | _GEN_2 | _GEN_1)
        state <= 2'h0;
      else if (_GEN)
        state <= 2'h1;
      p1 <= io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs1 | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs1 | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs1 | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs1 | (io_in_uop_valid ? ~io_in_uop_bits_prs1_busy : p1);
      p2 <= io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs2 | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs2 | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs2 | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs2 | (io_in_uop_valid ? ~io_in_uop_bits_prs2_busy : p2);
      p3 <= io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs3 | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs3 | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs3 | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs3 | (io_in_uop_valid ? ~io_in_uop_bits_prs3_busy : p3);
      if (io_in_uop_valid) begin
        ppred <= ~io_in_uop_bits_ppred_busy;
        slot_uop_uopc <= io_in_uop_bits_uopc;
        slot_uop_pdst <= io_in_uop_bits_pdst;
        slot_uop_uses_ldq <= io_in_uop_bits_uses_ldq;
        slot_uop_uses_stq <= io_in_uop_bits_uses_stq;
        slot_uop_dst_rtype <= io_in_uop_bits_dst_rtype;
        slot_uop_fp_val <= io_in_uop_bits_fp_val;
      end
      else if (_GEN_3) begin
      end
      else
        slot_uop_uopc <= 7'h3;
    end
    if (io_in_uop_valid) begin
      slot_uop_fu_code <= io_in_uop_bits_fu_code;
      slot_uop_br_mask <= io_in_uop_bits_br_mask;
      slot_uop_imm_packed <= io_in_uop_bits_imm_packed;
      slot_uop_rob_idx <= io_in_uop_bits_rob_idx;
      slot_uop_stq_idx <= io_in_uop_bits_stq_idx;
      slot_uop_prs1 <= io_in_uop_bits_prs1;
      slot_uop_prs2 <= io_in_uop_bits_prs2;
      slot_uop_prs3 <= io_in_uop_bits_prs3;
      slot_uop_mem_cmd <= io_in_uop_bits_mem_cmd;
      slot_uop_is_amo <= io_in_uop_bits_is_amo;
    end
    else
      slot_uop_br_mask <= next_br_mask;
  end // always @(posedge)
  assign io_valid = |state;
  assign io_will_be_valid = (|state) & ~(io_grant & (_may_vacate_T | _may_vacate_T_1 & p1 & p2 & ppred));
  assign io_request = _may_vacate_T ? _io_request_T_7 & p3 & ppred & ~io_kill : _may_vacate_T_1 & (p1 | p2) & ppred & ~io_kill;
  assign io_out_uop_uopc = _GEN_3 ? slot_uop_uopc : 7'h3;
  assign io_out_uop_fu_code = slot_uop_fu_code;
  assign io_out_uop_iw_state = _GEN_2 | _GEN_1 ? 2'h0 : _GEN ? 2'h1 : state;
  assign io_out_uop_br_mask = next_br_mask;
  assign io_out_uop_imm_packed = slot_uop_imm_packed;
  assign io_out_uop_rob_idx = slot_uop_rob_idx;
  assign io_out_uop_stq_idx = slot_uop_stq_idx;
  assign io_out_uop_pdst = slot_uop_pdst;
  assign io_out_uop_prs1 = slot_uop_prs1;
  assign io_out_uop_prs2 = slot_uop_prs2;
  assign io_out_uop_prs3 = slot_uop_prs3;
  assign io_out_uop_prs1_busy = ~p1;
  assign io_out_uop_prs2_busy = ~p2;
  assign io_out_uop_prs3_busy = ~p3;
  assign io_out_uop_ppred_busy = ~ppred;
  assign io_out_uop_mem_cmd = slot_uop_mem_cmd;
  assign io_out_uop_is_amo = slot_uop_is_amo;
  assign io_out_uop_uses_ldq = slot_uop_uses_ldq;
  assign io_out_uop_uses_stq = slot_uop_uses_stq;
  assign io_out_uop_dst_rtype = slot_uop_dst_rtype;
  assign io_out_uop_fp_val = slot_uop_fp_val;
  assign io_uop_uopc = ~_may_vacate_T_1 | _io_request_T_7 & ppred | p1 & ppred | ~(p2 & ppred) ? slot_uop_uopc : 7'h3;
  assign io_uop_fu_code = slot_uop_fu_code;
  assign io_uop_br_mask = slot_uop_br_mask;
  assign io_uop_imm_packed = slot_uop_imm_packed;
  assign io_uop_rob_idx = slot_uop_rob_idx;
  assign io_uop_stq_idx = slot_uop_stq_idx;
  assign io_uop_pdst = slot_uop_pdst;
  assign io_uop_prs1 = slot_uop_prs1;
  assign io_uop_prs2 = slot_uop_prs2;
  assign io_uop_prs3 = slot_uop_prs3;
  assign io_uop_mem_cmd = slot_uop_mem_cmd;
  assign io_uop_is_amo = slot_uop_is_amo;
  assign io_uop_uses_ldq = slot_uop_uses_ldq;
  assign io_uop_uses_stq = slot_uop_uses_stq;
  assign io_uop_dst_rtype = slot_uop_dst_rtype;
  assign io_uop_fp_val = slot_uop_fp_val;
endmodule

