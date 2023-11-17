// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RegisterReadDecode_2(
  input         io_iss_valid,
  input  [6:0]  io_iss_uop_uopc,
  input  [9:0]  io_iss_uop_fu_code,
  input  [19:0] io_iss_uop_br_mask,
                io_iss_uop_imm_packed,
  input  [6:0]  io_iss_uop_rob_idx,
  input  [4:0]  io_iss_uop_ldq_idx,
                io_iss_uop_stq_idx,
  input  [6:0]  io_iss_uop_pdst,
                io_iss_uop_prs1,
                io_iss_uop_prs2,
  input  [4:0]  io_iss_uop_mem_cmd,
  input  [1:0]  io_iss_uop_mem_size,
  input         io_iss_uop_mem_signed,
                io_iss_uop_is_fence,
                io_iss_uop_is_amo,
                io_iss_uop_uses_ldq,
                io_iss_uop_uses_stq,
  input  [1:0]  io_iss_uop_lrs1_rtype,
                io_iss_uop_lrs2_rtype,
  input         io_iss_uop_fp_val,
  output        io_rrd_valid,
  output [6:0]  io_rrd_uop_uopc,
  output [9:0]  io_rrd_uop_fu_code,
  output        io_rrd_uop_ctrl_is_load,
                io_rrd_uop_ctrl_is_sta,
                io_rrd_uop_ctrl_is_std,
  output [19:0] io_rrd_uop_br_mask,
                io_rrd_uop_imm_packed,
  output [6:0]  io_rrd_uop_rob_idx,
  output [4:0]  io_rrd_uop_ldq_idx,
                io_rrd_uop_stq_idx,
  output [6:0]  io_rrd_uop_pdst,
                io_rrd_uop_prs1,
                io_rrd_uop_prs2,
  output [4:0]  io_rrd_uop_mem_cmd,
  output [1:0]  io_rrd_uop_mem_size,
  output        io_rrd_uop_mem_signed,
                io_rrd_uop_is_fence,
                io_rrd_uop_is_amo,
                io_rrd_uop_uses_ldq,
                io_rrd_uop_uses_stq,
  output [1:0]  io_rrd_uop_lrs1_rtype,
                io_rrd_uop_lrs2_rtype,
  output        io_rrd_uop_fp_val
);

  wire _io_rrd_uop_ctrl_is_load_T = io_iss_uop_uopc == 7'h1;
  wire _io_rrd_uop_ctrl_is_sta_T_1 = io_iss_uop_uopc == 7'h43;
  wire _io_rrd_uop_ctrl_is_sta_output = io_iss_uop_uopc == 7'h2 | _io_rrd_uop_ctrl_is_sta_T_1;
  assign io_rrd_valid = io_iss_valid;
  assign io_rrd_uop_uopc = io_iss_uop_uopc;
  assign io_rrd_uop_fu_code = io_iss_uop_fu_code;
  assign io_rrd_uop_ctrl_is_load = _io_rrd_uop_ctrl_is_load_T;
  assign io_rrd_uop_ctrl_is_sta = _io_rrd_uop_ctrl_is_sta_output;
  assign io_rrd_uop_ctrl_is_std = io_iss_uop_uopc == 7'h3 | _io_rrd_uop_ctrl_is_sta_output & io_iss_uop_lrs2_rtype == 2'h0;
  assign io_rrd_uop_br_mask = io_iss_uop_br_mask;
  assign io_rrd_uop_imm_packed = _io_rrd_uop_ctrl_is_sta_T_1 | _io_rrd_uop_ctrl_is_load_T & io_iss_uop_mem_cmd == 5'h6 ? 20'h0 : io_iss_uop_imm_packed;
  assign io_rrd_uop_rob_idx = io_iss_uop_rob_idx;
  assign io_rrd_uop_ldq_idx = io_iss_uop_ldq_idx;
  assign io_rrd_uop_stq_idx = io_iss_uop_stq_idx;
  assign io_rrd_uop_pdst = io_iss_uop_pdst;
  assign io_rrd_uop_prs1 = io_iss_uop_prs1;
  assign io_rrd_uop_prs2 = io_iss_uop_prs2;
  assign io_rrd_uop_mem_cmd = io_iss_uop_mem_cmd;
  assign io_rrd_uop_mem_size = io_iss_uop_mem_size;
  assign io_rrd_uop_mem_signed = io_iss_uop_mem_signed;
  assign io_rrd_uop_is_fence = io_iss_uop_is_fence;
  assign io_rrd_uop_is_amo = io_iss_uop_is_amo;
  assign io_rrd_uop_uses_ldq = io_iss_uop_uses_ldq;
  assign io_rrd_uop_uses_stq = io_iss_uop_uses_stq;
  assign io_rrd_uop_lrs1_rtype = io_iss_uop_lrs1_rtype;
  assign io_rrd_uop_lrs2_rtype = io_iss_uop_lrs2_rtype;
  assign io_rrd_uop_fp_val = io_iss_uop_fp_val;
endmodule

