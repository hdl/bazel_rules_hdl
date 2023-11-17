// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ALUExeUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [9:0]  io_req_bits_uop_fu_code,
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
  input         io_lsu_io_iresp_valid,
  input  [6:0]  io_lsu_io_iresp_bits_uop_rob_idx,
                io_lsu_io_iresp_bits_uop_pdst,
  input         io_lsu_io_iresp_bits_uop_is_amo,
                io_lsu_io_iresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_io_iresp_bits_uop_dst_rtype,
  input  [63:0] io_lsu_io_iresp_bits_data,
  input         io_lsu_io_fresp_valid,
  input  [6:0]  io_lsu_io_fresp_bits_uop_uopc,
  input  [19:0] io_lsu_io_fresp_bits_uop_br_mask,
  input  [6:0]  io_lsu_io_fresp_bits_uop_rob_idx,
  input  [4:0]  io_lsu_io_fresp_bits_uop_stq_idx,
  input  [6:0]  io_lsu_io_fresp_bits_uop_pdst,
  input  [1:0]  io_lsu_io_fresp_bits_uop_mem_size,
  input         io_lsu_io_fresp_bits_uop_is_amo,
                io_lsu_io_fresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_io_fresp_bits_uop_dst_rtype,
  input         io_lsu_io_fresp_bits_uop_fp_val,
  input  [64:0] io_lsu_io_fresp_bits_data,
  output        io_ll_iresp_valid,
  output [6:0]  io_ll_iresp_bits_uop_rob_idx,
                io_ll_iresp_bits_uop_pdst,
  output        io_ll_iresp_bits_uop_is_amo,
                io_ll_iresp_bits_uop_uses_stq,
  output [1:0]  io_ll_iresp_bits_uop_dst_rtype,
  output [64:0] io_ll_iresp_bits_data,
  output        io_ll_fresp_valid,
  output [6:0]  io_ll_fresp_bits_uop_uopc,
  output [19:0] io_ll_fresp_bits_uop_br_mask,
  output [6:0]  io_ll_fresp_bits_uop_rob_idx,
  output [4:0]  io_ll_fresp_bits_uop_stq_idx,
  output [6:0]  io_ll_fresp_bits_uop_pdst,
  output [1:0]  io_ll_fresp_bits_uop_mem_size,
  output        io_ll_fresp_bits_uop_is_amo,
                io_ll_fresp_bits_uop_uses_stq,
  output [1:0]  io_ll_fresp_bits_uop_dst_rtype,
  output        io_ll_fresp_bits_uop_fp_val,
  output [64:0] io_ll_fresp_bits_data,
  output        io_lsu_io_req_valid,
                io_lsu_io_req_bits_uop_ctrl_is_load,
                io_lsu_io_req_bits_uop_ctrl_is_sta,
                io_lsu_io_req_bits_uop_ctrl_is_std,
  output [19:0] io_lsu_io_req_bits_uop_br_mask,
  output [6:0]  io_lsu_io_req_bits_uop_rob_idx,
  output [4:0]  io_lsu_io_req_bits_uop_ldq_idx,
                io_lsu_io_req_bits_uop_stq_idx,
  output [6:0]  io_lsu_io_req_bits_uop_pdst,
  output [4:0]  io_lsu_io_req_bits_uop_mem_cmd,
  output [1:0]  io_lsu_io_req_bits_uop_mem_size,
  output        io_lsu_io_req_bits_uop_mem_signed,
                io_lsu_io_req_bits_uop_is_fence,
                io_lsu_io_req_bits_uop_is_amo,
                io_lsu_io_req_bits_uop_uses_ldq,
                io_lsu_io_req_bits_uop_uses_stq,
                io_lsu_io_req_bits_uop_fp_val,
  output [63:0] io_lsu_io_req_bits_data,
  output [39:0] io_lsu_io_req_bits_addr,
  output        io_lsu_io_req_bits_mxcpt_valid,
                io_lsu_io_req_bits_sfence_valid,
                io_lsu_io_req_bits_sfence_bits_rs1,
                io_lsu_io_req_bits_sfence_bits_rs2,
  output [38:0] io_lsu_io_req_bits_sfence_bits_addr
);

  wire [64:0] _maddrcalc_io_resp_bits_data;
  MemAddrCalcUnit maddrcalc (
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (io_req_valid & io_req_bits_uop_fu_code[2]),
    .io_req_bits_uop_uopc           (io_req_bits_uop_uopc),
    .io_req_bits_uop_ctrl_is_load   (io_req_bits_uop_ctrl_is_load),
    .io_req_bits_uop_ctrl_is_sta    (io_req_bits_uop_ctrl_is_sta),
    .io_req_bits_uop_ctrl_is_std    (io_req_bits_uop_ctrl_is_std),
    .io_req_bits_uop_br_mask        (io_req_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed     (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx        (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx        (io_req_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx        (io_req_bits_uop_stq_idx),
    .io_req_bits_uop_pdst           (io_req_bits_uop_pdst),
    .io_req_bits_uop_mem_cmd        (io_req_bits_uop_mem_cmd),
    .io_req_bits_uop_mem_size       (io_req_bits_uop_mem_size),
    .io_req_bits_uop_mem_signed     (io_req_bits_uop_mem_signed),
    .io_req_bits_uop_is_fence       (io_req_bits_uop_is_fence),
    .io_req_bits_uop_is_amo         (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq       (io_req_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq       (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_fp_val         (io_req_bits_uop_fp_val),
    .io_req_bits_rs1_data           (io_req_bits_rs1_data),
    .io_req_bits_rs2_data           (io_req_bits_rs2_data),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_resp_valid                  (io_lsu_io_req_valid),
    .io_resp_bits_uop_ctrl_is_load  (io_lsu_io_req_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta   (io_lsu_io_req_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std   (io_lsu_io_req_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_br_mask       (io_lsu_io_req_bits_uop_br_mask),
    .io_resp_bits_uop_rob_idx       (io_lsu_io_req_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx       (io_lsu_io_req_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx       (io_lsu_io_req_bits_uop_stq_idx),
    .io_resp_bits_uop_pdst          (io_lsu_io_req_bits_uop_pdst),
    .io_resp_bits_uop_mem_cmd       (io_lsu_io_req_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size      (io_lsu_io_req_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed    (io_lsu_io_req_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence      (io_lsu_io_req_bits_uop_is_fence),
    .io_resp_bits_uop_is_amo        (io_lsu_io_req_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq      (io_lsu_io_req_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq      (io_lsu_io_req_bits_uop_uses_stq),
    .io_resp_bits_uop_fp_val        (io_lsu_io_req_bits_uop_fp_val),
    .io_resp_bits_data              (_maddrcalc_io_resp_bits_data),
    .io_resp_bits_addr              (io_lsu_io_req_bits_addr),
    .io_resp_bits_mxcpt_valid       (io_lsu_io_req_bits_mxcpt_valid),
    .io_resp_bits_sfence_valid      (io_lsu_io_req_bits_sfence_valid),
    .io_resp_bits_sfence_bits_rs1   (io_lsu_io_req_bits_sfence_bits_rs1),
    .io_resp_bits_sfence_bits_rs2   (io_lsu_io_req_bits_sfence_bits_rs2),
    .io_resp_bits_sfence_bits_addr  (io_lsu_io_req_bits_sfence_bits_addr)
  );
  assign io_ll_iresp_valid = io_lsu_io_iresp_valid;
  assign io_ll_iresp_bits_uop_rob_idx = io_lsu_io_iresp_bits_uop_rob_idx;
  assign io_ll_iresp_bits_uop_pdst = io_lsu_io_iresp_bits_uop_pdst;
  assign io_ll_iresp_bits_uop_is_amo = io_lsu_io_iresp_bits_uop_is_amo;
  assign io_ll_iresp_bits_uop_uses_stq = io_lsu_io_iresp_bits_uop_uses_stq;
  assign io_ll_iresp_bits_uop_dst_rtype = io_lsu_io_iresp_bits_uop_dst_rtype;
  assign io_ll_iresp_bits_data = {1'h0, io_lsu_io_iresp_bits_data};
  assign io_ll_fresp_valid = io_lsu_io_fresp_valid;
  assign io_ll_fresp_bits_uop_uopc = io_lsu_io_fresp_bits_uop_uopc;
  assign io_ll_fresp_bits_uop_br_mask = io_lsu_io_fresp_bits_uop_br_mask;
  assign io_ll_fresp_bits_uop_rob_idx = io_lsu_io_fresp_bits_uop_rob_idx;
  assign io_ll_fresp_bits_uop_stq_idx = io_lsu_io_fresp_bits_uop_stq_idx;
  assign io_ll_fresp_bits_uop_pdst = io_lsu_io_fresp_bits_uop_pdst;
  assign io_ll_fresp_bits_uop_mem_size = io_lsu_io_fresp_bits_uop_mem_size;
  assign io_ll_fresp_bits_uop_is_amo = io_lsu_io_fresp_bits_uop_is_amo;
  assign io_ll_fresp_bits_uop_uses_stq = io_lsu_io_fresp_bits_uop_uses_stq;
  assign io_ll_fresp_bits_uop_dst_rtype = io_lsu_io_fresp_bits_uop_dst_rtype;
  assign io_ll_fresp_bits_uop_fp_val = io_lsu_io_fresp_bits_uop_fp_val;
  assign io_ll_fresp_bits_data = io_lsu_io_fresp_bits_data;
  assign io_lsu_io_req_bits_data = _maddrcalc_io_resp_bits_data[63:0];
endmodule

