// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MemAddrCalcUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input         io_req_bits_uop_ctrl_is_load,
                io_req_bits_uop_ctrl_is_sta,
                io_req_bits_uop_ctrl_is_std,
  input  [19:0] io_req_bits_uop_br_mask,
                io_req_bits_uop_imm_packed,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_ldq_idx,
                io_req_bits_uop_stq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
  input  [4:0]  io_req_bits_uop_mem_cmd,
  input  [1:0]  io_req_bits_uop_mem_size,
  input         io_req_bits_uop_mem_signed,
                io_req_bits_uop_is_fence,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_ldq,
                io_req_bits_uop_uses_stq,
                io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_resp_valid,
                io_resp_bits_uop_ctrl_is_load,
                io_resp_bits_uop_ctrl_is_sta,
                io_resp_bits_uop_ctrl_is_std,
  output [19:0] io_resp_bits_uop_br_mask,
  output [6:0]  io_resp_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_uop_ldq_idx,
                io_resp_bits_uop_stq_idx,
  output [6:0]  io_resp_bits_uop_pdst,
  output [4:0]  io_resp_bits_uop_mem_cmd,
  output [1:0]  io_resp_bits_uop_mem_size,
  output        io_resp_bits_uop_mem_signed,
                io_resp_bits_uop_is_fence,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_ldq,
                io_resp_bits_uop_uses_stq,
                io_resp_bits_uop_fp_val,
  output [64:0] io_resp_bits_data,
  output [39:0] io_resp_bits_addr,
  output        io_resp_bits_mxcpt_valid,
                io_resp_bits_sfence_valid,
                io_resp_bits_sfence_bits_rs1,
                io_resp_bits_sfence_bits_rs2,
  output [38:0] io_resp_bits_sfence_bits_addr
);

  wire [63:0] _sum_T_3 = io_req_bits_rs1_data[63:0] + {{52{io_req_bits_uop_imm_packed[19]}}, io_req_bits_uop_imm_packed[19:8]};
  wire        misaligned = io_req_bits_uop_mem_size == 2'h1 & _sum_T_3[0] | io_req_bits_uop_mem_size == 2'h2 & (|(_sum_T_3[1:0])) | (&io_req_bits_uop_mem_size) & (|(_sum_T_3[2:0]));
  wire        ma_ld = io_req_valid & io_req_bits_uop_uopc == 7'h1 & misaligned;
  wire        ma_st = io_req_valid & (io_req_bits_uop_uopc == 7'h2 | io_req_bits_uop_uopc == 7'h43) & misaligned;
  assign io_resp_valid = io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0;
  assign io_resp_bits_uop_ctrl_is_load = io_req_bits_uop_ctrl_is_load;
  assign io_resp_bits_uop_ctrl_is_sta = io_req_bits_uop_ctrl_is_sta;
  assign io_resp_bits_uop_ctrl_is_std = io_req_bits_uop_ctrl_is_std;
  assign io_resp_bits_uop_br_mask = io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  assign io_resp_bits_uop_rob_idx = io_req_bits_uop_rob_idx;
  assign io_resp_bits_uop_ldq_idx = io_req_bits_uop_ldq_idx;
  assign io_resp_bits_uop_stq_idx = io_req_bits_uop_stq_idx;
  assign io_resp_bits_uop_pdst = io_req_bits_uop_pdst;
  assign io_resp_bits_uop_mem_cmd = io_req_bits_uop_mem_cmd;
  assign io_resp_bits_uop_mem_size = io_req_bits_uop_mem_size;
  assign io_resp_bits_uop_mem_signed = io_req_bits_uop_mem_signed;
  assign io_resp_bits_uop_is_fence = io_req_bits_uop_is_fence;
  assign io_resp_bits_uop_is_amo = io_req_bits_uop_is_amo;
  assign io_resp_bits_uop_uses_ldq = io_req_bits_uop_uses_ldq;
  assign io_resp_bits_uop_uses_stq = io_req_bits_uop_uses_stq;
  assign io_resp_bits_uop_fp_val = io_req_bits_uop_fp_val;
  assign io_resp_bits_data = io_req_bits_rs2_data;
  assign io_resp_bits_addr = {_sum_T_3[38] ? (&(_sum_T_3[63:39])) : (|(_sum_T_3[63:39])), _sum_T_3[38:0]};
  assign io_resp_bits_mxcpt_valid = ma_ld | ma_st;
  assign io_resp_bits_sfence_valid = io_req_valid & io_req_bits_uop_mem_cmd == 5'h14;
  assign io_resp_bits_sfence_bits_rs1 = io_req_bits_uop_mem_size[0];
  assign io_resp_bits_sfence_bits_rs2 = io_req_bits_uop_mem_size[1];
  assign io_resp_bits_sfence_bits_addr = io_req_bits_rs1_data[38:0];
endmodule

