// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RegisterRead(
  input         clock,
                reset,
                io_iss_valids_0,
                io_iss_valids_1,
  input  [6:0]  io_iss_uops_0_uopc,
  input  [9:0]  io_iss_uops_0_fu_code,
  input  [19:0] io_iss_uops_0_br_mask,
                io_iss_uops_0_imm_packed,
  input  [6:0]  io_iss_uops_0_rob_idx,
  input  [4:0]  io_iss_uops_0_stq_idx,
  input  [6:0]  io_iss_uops_0_pdst,
                io_iss_uops_0_prs1,
                io_iss_uops_0_prs2,
                io_iss_uops_0_prs3,
  input  [4:0]  io_iss_uops_0_mem_cmd,
  input         io_iss_uops_0_is_amo,
                io_iss_uops_0_uses_ldq,
                io_iss_uops_0_uses_stq,
  input  [1:0]  io_iss_uops_0_dst_rtype,
  input         io_iss_uops_0_fp_val,
  input  [6:0]  io_iss_uops_1_uopc,
  input  [9:0]  io_iss_uops_1_fu_code,
  input  [19:0] io_iss_uops_1_br_mask,
                io_iss_uops_1_imm_packed,
  input  [6:0]  io_iss_uops_1_rob_idx,
  input  [4:0]  io_iss_uops_1_stq_idx,
  input  [6:0]  io_iss_uops_1_pdst,
                io_iss_uops_1_prs1,
                io_iss_uops_1_prs2,
                io_iss_uops_1_prs3,
  input  [4:0]  io_iss_uops_1_mem_cmd,
  input         io_iss_uops_1_is_amo,
                io_iss_uops_1_uses_ldq,
                io_iss_uops_1_uses_stq,
  input  [1:0]  io_iss_uops_1_dst_rtype,
  input         io_iss_uops_1_fp_val,
  input  [64:0] io_rf_read_ports_0_data,
                io_rf_read_ports_1_data,
                io_rf_read_ports_2_data,
                io_rf_read_ports_3_data,
                io_rf_read_ports_4_data,
                io_rf_read_ports_5_data,
  input         io_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output [6:0]  io_rf_read_ports_0_addr,
                io_rf_read_ports_1_addr,
                io_rf_read_ports_2_addr,
                io_rf_read_ports_3_addr,
                io_rf_read_ports_4_addr,
                io_rf_read_ports_5_addr,
  output        io_exe_reqs_0_valid,
  output [6:0]  io_exe_reqs_0_bits_uop_uopc,
  output [9:0]  io_exe_reqs_0_bits_uop_fu_code,
  output [19:0] io_exe_reqs_0_bits_uop_br_mask,
                io_exe_reqs_0_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_0_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_0_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_0_bits_uop_pdst,
  output        io_exe_reqs_0_bits_uop_is_amo,
                io_exe_reqs_0_bits_uop_uses_ldq,
                io_exe_reqs_0_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_0_bits_uop_dst_rtype,
  output        io_exe_reqs_0_bits_uop_fp_val,
  output [64:0] io_exe_reqs_0_bits_rs1_data,
                io_exe_reqs_0_bits_rs2_data,
                io_exe_reqs_0_bits_rs3_data,
  output        io_exe_reqs_1_valid,
  output [6:0]  io_exe_reqs_1_bits_uop_uopc,
  output [9:0]  io_exe_reqs_1_bits_uop_fu_code,
  output [19:0] io_exe_reqs_1_bits_uop_br_mask,
                io_exe_reqs_1_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_1_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_1_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_1_bits_uop_pdst,
  output        io_exe_reqs_1_bits_uop_is_amo,
                io_exe_reqs_1_bits_uop_uses_ldq,
                io_exe_reqs_1_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_1_bits_uop_dst_rtype,
  output        io_exe_reqs_1_bits_uop_fp_val,
  output [64:0] io_exe_reqs_1_bits_rs1_data,
                io_exe_reqs_1_bits_rs2_data,
                io_exe_reqs_1_bits_rs3_data
);

  wire        _rrd_decode_unit_1_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_uopc;
  wire [9:0]  _rrd_decode_unit_1_io_rrd_uop_fu_code;
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_br_mask;
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_pdst;
  wire        _rrd_decode_unit_1_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_1_io_rrd_uop_uses_ldq;
  wire        _rrd_decode_unit_1_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_dst_rtype;
  wire        _rrd_decode_unit_1_io_rrd_uop_fp_val;
  wire        _rrd_decode_unit_io_rrd_valid;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_uopc;
  wire [9:0]  _rrd_decode_unit_io_rrd_uop_fu_code;
  wire [19:0] _rrd_decode_unit_io_rrd_uop_br_mask;
  wire [19:0] _rrd_decode_unit_io_rrd_uop_imm_packed;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_rob_idx;
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_stq_idx;
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_pdst;
  wire        _rrd_decode_unit_io_rrd_uop_is_amo;
  wire        _rrd_decode_unit_io_rrd_uop_uses_ldq;
  wire        _rrd_decode_unit_io_rrd_uop_uses_stq;
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_dst_rtype;
  wire        _rrd_decode_unit_io_rrd_uop_fp_val;
  reg         exe_reg_valids_0;
  reg         exe_reg_valids_1;
  reg  [6:0]  exe_reg_uops_0_uopc;
  reg  [9:0]  exe_reg_uops_0_fu_code;
  reg  [19:0] exe_reg_uops_0_br_mask;
  reg  [19:0] exe_reg_uops_0_imm_packed;
  reg  [6:0]  exe_reg_uops_0_rob_idx;
  reg  [4:0]  exe_reg_uops_0_stq_idx;
  reg  [6:0]  exe_reg_uops_0_pdst;
  reg         exe_reg_uops_0_is_amo;
  reg         exe_reg_uops_0_uses_ldq;
  reg         exe_reg_uops_0_uses_stq;
  reg  [1:0]  exe_reg_uops_0_dst_rtype;
  reg         exe_reg_uops_0_fp_val;
  reg  [6:0]  exe_reg_uops_1_uopc;
  reg  [9:0]  exe_reg_uops_1_fu_code;
  reg  [19:0] exe_reg_uops_1_br_mask;
  reg  [19:0] exe_reg_uops_1_imm_packed;
  reg  [6:0]  exe_reg_uops_1_rob_idx;
  reg  [4:0]  exe_reg_uops_1_stq_idx;
  reg  [6:0]  exe_reg_uops_1_pdst;
  reg         exe_reg_uops_1_is_amo;
  reg         exe_reg_uops_1_uses_ldq;
  reg         exe_reg_uops_1_uses_stq;
  reg  [1:0]  exe_reg_uops_1_dst_rtype;
  reg         exe_reg_uops_1_fp_val;
  reg  [64:0] exe_reg_rs1_data_0;
  reg  [64:0] exe_reg_rs1_data_1;
  reg  [64:0] exe_reg_rs2_data_0;
  reg  [64:0] exe_reg_rs2_data_1;
  reg  [64:0] exe_reg_rs3_data_0;
  reg  [64:0] exe_reg_rs3_data_1;
  reg         rrd_valids_0;
  reg  [6:0]  rrd_uops_0_uopc;
  reg  [9:0]  rrd_uops_0_fu_code;
  reg  [19:0] rrd_uops_0_br_mask;
  reg  [19:0] rrd_uops_0_imm_packed;
  reg  [6:0]  rrd_uops_0_rob_idx;
  reg  [4:0]  rrd_uops_0_stq_idx;
  reg  [6:0]  rrd_uops_0_pdst;
  reg         rrd_uops_0_is_amo;
  reg         rrd_uops_0_uses_ldq;
  reg         rrd_uops_0_uses_stq;
  reg  [1:0]  rrd_uops_0_dst_rtype;
  reg         rrd_uops_0_fp_val;
  reg         rrd_valids_1;
  reg  [6:0]  rrd_uops_1_uopc;
  reg  [9:0]  rrd_uops_1_fu_code;
  reg  [19:0] rrd_uops_1_br_mask;
  reg  [19:0] rrd_uops_1_imm_packed;
  reg  [6:0]  rrd_uops_1_rob_idx;
  reg  [4:0]  rrd_uops_1_stq_idx;
  reg  [6:0]  rrd_uops_1_pdst;
  reg         rrd_uops_1_is_amo;
  reg         rrd_uops_1_uses_ldq;
  reg         rrd_uops_1_uses_stq;
  reg  [1:0]  rrd_uops_1_dst_rtype;
  reg         rrd_uops_1_fp_val;
  reg         rrd_rs1_data_0_REG;
  reg         rrd_rs2_data_0_REG;
  reg         rrd_rs3_data_0_REG;
  reg         rrd_rs1_data_1_REG;
  reg         rrd_rs2_data_1_REG;
  reg         rrd_rs3_data_1_REG;
  wire        rrd_kill = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_0_br_mask));
  wire        rrd_kill_1 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_1_br_mask));
  always @(posedge clock) begin
    exe_reg_valids_0 <= ~(reset | rrd_kill) & rrd_valids_0;
    exe_reg_valids_1 <= ~(reset | rrd_kill_1) & rrd_valids_1;
    if (rrd_kill) begin
      exe_reg_uops_0_uopc <= 7'h0;
      exe_reg_uops_0_fu_code <= 10'h0;
      exe_reg_uops_0_imm_packed <= 20'h0;
      exe_reg_uops_0_rob_idx <= 7'h0;
      exe_reg_uops_0_stq_idx <= 5'h0;
      exe_reg_uops_0_pdst <= 7'h0;
      exe_reg_uops_0_dst_rtype <= 2'h2;
    end
    else begin
      exe_reg_uops_0_uopc <= rrd_uops_0_uopc;
      exe_reg_uops_0_fu_code <= rrd_uops_0_fu_code;
      exe_reg_uops_0_imm_packed <= rrd_uops_0_imm_packed;
      exe_reg_uops_0_rob_idx <= rrd_uops_0_rob_idx;
      exe_reg_uops_0_stq_idx <= rrd_uops_0_stq_idx;
      exe_reg_uops_0_pdst <= rrd_uops_0_pdst;
      exe_reg_uops_0_dst_rtype <= rrd_uops_0_dst_rtype;
    end
    exe_reg_uops_0_br_mask <= rrd_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_0_is_amo <= ~rrd_kill & rrd_uops_0_is_amo;
    exe_reg_uops_0_uses_ldq <= ~rrd_kill & rrd_uops_0_uses_ldq;
    exe_reg_uops_0_uses_stq <= ~rrd_kill & rrd_uops_0_uses_stq;
    exe_reg_uops_0_fp_val <= ~rrd_kill & rrd_uops_0_fp_val;
    if (rrd_kill_1) begin
      exe_reg_uops_1_uopc <= 7'h0;
      exe_reg_uops_1_fu_code <= 10'h0;
      exe_reg_uops_1_imm_packed <= 20'h0;
      exe_reg_uops_1_rob_idx <= 7'h0;
      exe_reg_uops_1_stq_idx <= 5'h0;
      exe_reg_uops_1_pdst <= 7'h0;
      exe_reg_uops_1_dst_rtype <= 2'h2;
    end
    else begin
      exe_reg_uops_1_uopc <= rrd_uops_1_uopc;
      exe_reg_uops_1_fu_code <= rrd_uops_1_fu_code;
      exe_reg_uops_1_imm_packed <= rrd_uops_1_imm_packed;
      exe_reg_uops_1_rob_idx <= rrd_uops_1_rob_idx;
      exe_reg_uops_1_stq_idx <= rrd_uops_1_stq_idx;
      exe_reg_uops_1_pdst <= rrd_uops_1_pdst;
      exe_reg_uops_1_dst_rtype <= rrd_uops_1_dst_rtype;
    end
    exe_reg_uops_1_br_mask <= rrd_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;
    exe_reg_uops_1_is_amo <= ~rrd_kill_1 & rrd_uops_1_is_amo;
    exe_reg_uops_1_uses_ldq <= ~rrd_kill_1 & rrd_uops_1_uses_ldq;
    exe_reg_uops_1_uses_stq <= ~rrd_kill_1 & rrd_uops_1_uses_stq;
    exe_reg_uops_1_fp_val <= ~rrd_kill_1 & rrd_uops_1_fp_val;
    if (rrd_rs1_data_0_REG)
      exe_reg_rs1_data_0 <= 65'h0;
    else
      exe_reg_rs1_data_0 <= io_rf_read_ports_0_data;
    if (rrd_rs1_data_1_REG)
      exe_reg_rs1_data_1 <= 65'h0;
    else
      exe_reg_rs1_data_1 <= io_rf_read_ports_3_data;
    if (rrd_rs2_data_0_REG)
      exe_reg_rs2_data_0 <= 65'h0;
    else
      exe_reg_rs2_data_0 <= io_rf_read_ports_1_data;
    if (rrd_rs2_data_1_REG)
      exe_reg_rs2_data_1 <= 65'h0;
    else
      exe_reg_rs2_data_1 <= io_rf_read_ports_4_data;
    if (rrd_rs3_data_0_REG)
      exe_reg_rs3_data_0 <= 65'h0;
    else
      exe_reg_rs3_data_0 <= io_rf_read_ports_2_data;
    if (rrd_rs3_data_1_REG)
      exe_reg_rs3_data_1 <= 65'h0;
    else
      exe_reg_rs3_data_1 <= io_rf_read_ports_5_data;
    rrd_valids_0 <= _rrd_decode_unit_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_0_uopc <= _rrd_decode_unit_io_rrd_uop_uopc;
    rrd_uops_0_fu_code <= _rrd_decode_unit_io_rrd_uop_fu_code;
    rrd_uops_0_br_mask <= _rrd_decode_unit_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_0_imm_packed <= _rrd_decode_unit_io_rrd_uop_imm_packed;
    rrd_uops_0_rob_idx <= _rrd_decode_unit_io_rrd_uop_rob_idx;
    rrd_uops_0_stq_idx <= _rrd_decode_unit_io_rrd_uop_stq_idx;
    rrd_uops_0_pdst <= _rrd_decode_unit_io_rrd_uop_pdst;
    rrd_uops_0_is_amo <= _rrd_decode_unit_io_rrd_uop_is_amo;
    rrd_uops_0_uses_ldq <= _rrd_decode_unit_io_rrd_uop_uses_ldq;
    rrd_uops_0_uses_stq <= _rrd_decode_unit_io_rrd_uop_uses_stq;
    rrd_uops_0_dst_rtype <= _rrd_decode_unit_io_rrd_uop_dst_rtype;
    rrd_uops_0_fp_val <= _rrd_decode_unit_io_rrd_uop_fp_val;
    rrd_valids_1 <= _rrd_decode_unit_1_io_rrd_valid & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_1_io_rrd_uop_br_mask) == 20'h0;
    rrd_uops_1_uopc <= _rrd_decode_unit_1_io_rrd_uop_uopc;
    rrd_uops_1_fu_code <= _rrd_decode_unit_1_io_rrd_uop_fu_code;
    rrd_uops_1_br_mask <= _rrd_decode_unit_1_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;
    rrd_uops_1_imm_packed <= _rrd_decode_unit_1_io_rrd_uop_imm_packed;
    rrd_uops_1_rob_idx <= _rrd_decode_unit_1_io_rrd_uop_rob_idx;
    rrd_uops_1_stq_idx <= _rrd_decode_unit_1_io_rrd_uop_stq_idx;
    rrd_uops_1_pdst <= _rrd_decode_unit_1_io_rrd_uop_pdst;
    rrd_uops_1_is_amo <= _rrd_decode_unit_1_io_rrd_uop_is_amo;
    rrd_uops_1_uses_ldq <= _rrd_decode_unit_1_io_rrd_uop_uses_ldq;
    rrd_uops_1_uses_stq <= _rrd_decode_unit_1_io_rrd_uop_uses_stq;
    rrd_uops_1_dst_rtype <= _rrd_decode_unit_1_io_rrd_uop_dst_rtype;
    rrd_uops_1_fp_val <= _rrd_decode_unit_1_io_rrd_uop_fp_val;
    rrd_rs1_data_0_REG <= io_iss_uops_0_prs1 == 7'h0;
    rrd_rs2_data_0_REG <= io_iss_uops_0_prs2 == 7'h0;
    rrd_rs3_data_0_REG <= io_iss_uops_0_prs3 == 7'h0;
    rrd_rs1_data_1_REG <= io_iss_uops_1_prs1 == 7'h0;
    rrd_rs2_data_1_REG <= io_iss_uops_1_prs2 == 7'h0;
    rrd_rs3_data_1_REG <= io_iss_uops_1_prs3 == 7'h0;
  end // always @(posedge)
  RegisterReadDecode rrd_decode_unit (
    .io_iss_valid          (io_iss_valids_0),
    .io_iss_uop_uopc       (io_iss_uops_0_uopc),
    .io_iss_uop_fu_code    (io_iss_uops_0_fu_code),
    .io_iss_uop_br_mask    (io_iss_uops_0_br_mask),
    .io_iss_uop_imm_packed (io_iss_uops_0_imm_packed),
    .io_iss_uop_rob_idx    (io_iss_uops_0_rob_idx),
    .io_iss_uop_stq_idx    (io_iss_uops_0_stq_idx),
    .io_iss_uop_pdst       (io_iss_uops_0_pdst),
    .io_iss_uop_mem_cmd    (io_iss_uops_0_mem_cmd),
    .io_iss_uop_is_amo     (io_iss_uops_0_is_amo),
    .io_iss_uop_uses_ldq   (io_iss_uops_0_uses_ldq),
    .io_iss_uop_uses_stq   (io_iss_uops_0_uses_stq),
    .io_iss_uop_dst_rtype  (io_iss_uops_0_dst_rtype),
    .io_iss_uop_fp_val     (io_iss_uops_0_fp_val),
    .io_rrd_valid          (_rrd_decode_unit_io_rrd_valid),
    .io_rrd_uop_uopc       (_rrd_decode_unit_io_rrd_uop_uopc),
    .io_rrd_uop_fu_code    (_rrd_decode_unit_io_rrd_uop_fu_code),
    .io_rrd_uop_br_mask    (_rrd_decode_unit_io_rrd_uop_br_mask),
    .io_rrd_uop_imm_packed (_rrd_decode_unit_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx    (_rrd_decode_unit_io_rrd_uop_rob_idx),
    .io_rrd_uop_stq_idx    (_rrd_decode_unit_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst       (_rrd_decode_unit_io_rrd_uop_pdst),
    .io_rrd_uop_is_amo     (_rrd_decode_unit_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_ldq   (_rrd_decode_unit_io_rrd_uop_uses_ldq),
    .io_rrd_uop_uses_stq   (_rrd_decode_unit_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype  (_rrd_decode_unit_io_rrd_uop_dst_rtype),
    .io_rrd_uop_fp_val     (_rrd_decode_unit_io_rrd_uop_fp_val)
  );
  RegisterReadDecode_1 rrd_decode_unit_1 (
    .io_iss_valid          (io_iss_valids_1),
    .io_iss_uop_uopc       (io_iss_uops_1_uopc),
    .io_iss_uop_fu_code    (io_iss_uops_1_fu_code),
    .io_iss_uop_br_mask    (io_iss_uops_1_br_mask),
    .io_iss_uop_imm_packed (io_iss_uops_1_imm_packed),
    .io_iss_uop_rob_idx    (io_iss_uops_1_rob_idx),
    .io_iss_uop_stq_idx    (io_iss_uops_1_stq_idx),
    .io_iss_uop_pdst       (io_iss_uops_1_pdst),
    .io_iss_uop_mem_cmd    (io_iss_uops_1_mem_cmd),
    .io_iss_uop_is_amo     (io_iss_uops_1_is_amo),
    .io_iss_uop_uses_ldq   (io_iss_uops_1_uses_ldq),
    .io_iss_uop_uses_stq   (io_iss_uops_1_uses_stq),
    .io_iss_uop_dst_rtype  (io_iss_uops_1_dst_rtype),
    .io_iss_uop_fp_val     (io_iss_uops_1_fp_val),
    .io_rrd_valid          (_rrd_decode_unit_1_io_rrd_valid),
    .io_rrd_uop_uopc       (_rrd_decode_unit_1_io_rrd_uop_uopc),
    .io_rrd_uop_fu_code    (_rrd_decode_unit_1_io_rrd_uop_fu_code),
    .io_rrd_uop_br_mask    (_rrd_decode_unit_1_io_rrd_uop_br_mask),
    .io_rrd_uop_imm_packed (_rrd_decode_unit_1_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx    (_rrd_decode_unit_1_io_rrd_uop_rob_idx),
    .io_rrd_uop_stq_idx    (_rrd_decode_unit_1_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst       (_rrd_decode_unit_1_io_rrd_uop_pdst),
    .io_rrd_uop_is_amo     (_rrd_decode_unit_1_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_ldq   (_rrd_decode_unit_1_io_rrd_uop_uses_ldq),
    .io_rrd_uop_uses_stq   (_rrd_decode_unit_1_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype  (_rrd_decode_unit_1_io_rrd_uop_dst_rtype),
    .io_rrd_uop_fp_val     (_rrd_decode_unit_1_io_rrd_uop_fp_val)
  );
  assign io_rf_read_ports_0_addr = io_iss_uops_0_prs1;
  assign io_rf_read_ports_1_addr = io_iss_uops_0_prs2;
  assign io_rf_read_ports_2_addr = io_iss_uops_0_prs3;
  assign io_rf_read_ports_3_addr = io_iss_uops_1_prs1;
  assign io_rf_read_ports_4_addr = io_iss_uops_1_prs2;
  assign io_rf_read_ports_5_addr = io_iss_uops_1_prs3;
  assign io_exe_reqs_0_valid = exe_reg_valids_0;
  assign io_exe_reqs_0_bits_uop_uopc = exe_reg_uops_0_uopc;
  assign io_exe_reqs_0_bits_uop_fu_code = exe_reg_uops_0_fu_code;
  assign io_exe_reqs_0_bits_uop_br_mask = exe_reg_uops_0_br_mask;
  assign io_exe_reqs_0_bits_uop_imm_packed = exe_reg_uops_0_imm_packed;
  assign io_exe_reqs_0_bits_uop_rob_idx = exe_reg_uops_0_rob_idx;
  assign io_exe_reqs_0_bits_uop_stq_idx = exe_reg_uops_0_stq_idx;
  assign io_exe_reqs_0_bits_uop_pdst = exe_reg_uops_0_pdst;
  assign io_exe_reqs_0_bits_uop_is_amo = exe_reg_uops_0_is_amo;
  assign io_exe_reqs_0_bits_uop_uses_ldq = exe_reg_uops_0_uses_ldq;
  assign io_exe_reqs_0_bits_uop_uses_stq = exe_reg_uops_0_uses_stq;
  assign io_exe_reqs_0_bits_uop_dst_rtype = exe_reg_uops_0_dst_rtype;
  assign io_exe_reqs_0_bits_uop_fp_val = exe_reg_uops_0_fp_val;
  assign io_exe_reqs_0_bits_rs1_data = exe_reg_rs1_data_0;
  assign io_exe_reqs_0_bits_rs2_data = exe_reg_rs2_data_0;
  assign io_exe_reqs_0_bits_rs3_data = exe_reg_rs3_data_0;
  assign io_exe_reqs_1_valid = exe_reg_valids_1;
  assign io_exe_reqs_1_bits_uop_uopc = exe_reg_uops_1_uopc;
  assign io_exe_reqs_1_bits_uop_fu_code = exe_reg_uops_1_fu_code;
  assign io_exe_reqs_1_bits_uop_br_mask = exe_reg_uops_1_br_mask;
  assign io_exe_reqs_1_bits_uop_imm_packed = exe_reg_uops_1_imm_packed;
  assign io_exe_reqs_1_bits_uop_rob_idx = exe_reg_uops_1_rob_idx;
  assign io_exe_reqs_1_bits_uop_stq_idx = exe_reg_uops_1_stq_idx;
  assign io_exe_reqs_1_bits_uop_pdst = exe_reg_uops_1_pdst;
  assign io_exe_reqs_1_bits_uop_is_amo = exe_reg_uops_1_is_amo;
  assign io_exe_reqs_1_bits_uop_uses_ldq = exe_reg_uops_1_uses_ldq;
  assign io_exe_reqs_1_bits_uop_uses_stq = exe_reg_uops_1_uses_stq;
  assign io_exe_reqs_1_bits_uop_dst_rtype = exe_reg_uops_1_dst_rtype;
  assign io_exe_reqs_1_bits_uop_fp_val = exe_reg_uops_1_fp_val;
  assign io_exe_reqs_1_bits_rs1_data = exe_reg_rs1_data_1;
  assign io_exe_reqs_1_bits_rs2_data = exe_reg_rs2_data_1;
  assign io_exe_reqs_1_bits_rs3_data = exe_reg_rs3_data_1;
endmodule

