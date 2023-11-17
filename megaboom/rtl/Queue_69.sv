// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_69(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
  input          io_enq_bits_edge_inst_0,
                 io_enq_bits_edge_inst_1,
  input  [31:0]  io_enq_bits_insts_0,
                 io_enq_bits_insts_1,
                 io_enq_bits_insts_2,
                 io_enq_bits_insts_3,
                 io_enq_bits_insts_4,
                 io_enq_bits_insts_5,
                 io_enq_bits_insts_6,
                 io_enq_bits_insts_7,
                 io_enq_bits_exp_insts_0,
                 io_enq_bits_exp_insts_1,
                 io_enq_bits_exp_insts_2,
                 io_enq_bits_exp_insts_3,
                 io_enq_bits_exp_insts_4,
                 io_enq_bits_exp_insts_5,
                 io_enq_bits_exp_insts_6,
                 io_enq_bits_exp_insts_7,
  input          io_enq_bits_sfbs_0,
                 io_enq_bits_sfbs_1,
                 io_enq_bits_sfbs_2,
                 io_enq_bits_sfbs_3,
                 io_enq_bits_sfbs_4,
                 io_enq_bits_sfbs_5,
                 io_enq_bits_sfbs_6,
                 io_enq_bits_sfbs_7,
                 io_enq_bits_cfi_idx_valid,
  input  [2:0]   io_enq_bits_cfi_idx_bits,
                 io_enq_bits_cfi_type,
  input          io_enq_bits_cfi_is_call,
                 io_enq_bits_cfi_is_ret,
  input  [39:0]  io_enq_bits_ras_top,
  input  [7:0]   io_enq_bits_mask,
                 io_enq_bits_br_mask,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input          io_enq_bits_xcpt_pf_if,
                 io_enq_bits_xcpt_ae_if,
  input  [119:0] io_enq_bits_bpd_meta_0,
                 io_enq_bits_bpd_meta_1,
  input          io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [39:0]  io_deq_bits_pc,
  output         io_deq_bits_edge_inst_0,
                 io_deq_bits_edge_inst_1,
  output [31:0]  io_deq_bits_insts_0,
                 io_deq_bits_insts_1,
                 io_deq_bits_insts_2,
                 io_deq_bits_insts_3,
                 io_deq_bits_insts_4,
                 io_deq_bits_insts_5,
                 io_deq_bits_insts_6,
                 io_deq_bits_insts_7,
                 io_deq_bits_exp_insts_0,
                 io_deq_bits_exp_insts_1,
                 io_deq_bits_exp_insts_2,
                 io_deq_bits_exp_insts_3,
                 io_deq_bits_exp_insts_4,
                 io_deq_bits_exp_insts_5,
                 io_deq_bits_exp_insts_6,
                 io_deq_bits_exp_insts_7,
  output         io_deq_bits_sfbs_0,
                 io_deq_bits_sfbs_1,
                 io_deq_bits_sfbs_2,
                 io_deq_bits_sfbs_3,
                 io_deq_bits_sfbs_4,
                 io_deq_bits_sfbs_5,
                 io_deq_bits_sfbs_6,
                 io_deq_bits_sfbs_7,
                 io_deq_bits_shadowed_mask_0,
                 io_deq_bits_shadowed_mask_1,
                 io_deq_bits_shadowed_mask_2,
                 io_deq_bits_shadowed_mask_3,
                 io_deq_bits_shadowed_mask_4,
                 io_deq_bits_shadowed_mask_5,
                 io_deq_bits_shadowed_mask_6,
                 io_deq_bits_shadowed_mask_7,
                 io_deq_bits_cfi_idx_valid,
  output [2:0]   io_deq_bits_cfi_idx_bits,
                 io_deq_bits_cfi_type,
  output         io_deq_bits_cfi_is_call,
                 io_deq_bits_cfi_is_ret,
  output [39:0]  io_deq_bits_ras_top,
  output [7:0]   io_deq_bits_mask,
                 io_deq_bits_br_mask,
  output [63:0]  io_deq_bits_ghist_old_history,
  output         io_deq_bits_ghist_current_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_taken,
  output [4:0]   io_deq_bits_ghist_ras_idx,
  output         io_deq_bits_xcpt_pf_if,
                 io_deq_bits_xcpt_ae_if,
                 io_deq_bits_bp_debug_if_oh_0,
                 io_deq_bits_bp_debug_if_oh_1,
                 io_deq_bits_bp_debug_if_oh_2,
                 io_deq_bits_bp_debug_if_oh_3,
                 io_deq_bits_bp_debug_if_oh_4,
                 io_deq_bits_bp_debug_if_oh_5,
                 io_deq_bits_bp_debug_if_oh_6,
                 io_deq_bits_bp_debug_if_oh_7,
                 io_deq_bits_bp_xcpt_if_oh_0,
                 io_deq_bits_bp_xcpt_if_oh_1,
                 io_deq_bits_bp_xcpt_if_oh_2,
                 io_deq_bits_bp_xcpt_if_oh_3,
                 io_deq_bits_bp_xcpt_if_oh_4,
                 io_deq_bits_bp_xcpt_if_oh_5,
                 io_deq_bits_bp_xcpt_if_oh_6,
                 io_deq_bits_bp_xcpt_if_oh_7,
  output [119:0] io_deq_bits_bpd_meta_0,
                 io_deq_bits_bpd_meta_1
);

  reg          full;
  reg  [119:0] ram_bpd_meta_1;
  reg  [119:0] ram_bpd_meta_0;
  reg          ram_bp_xcpt_if_oh_7;
  reg          ram_bp_xcpt_if_oh_6;
  reg          ram_bp_xcpt_if_oh_5;
  reg          ram_bp_xcpt_if_oh_4;
  reg          ram_bp_xcpt_if_oh_3;
  reg          ram_bp_xcpt_if_oh_2;
  reg          ram_bp_xcpt_if_oh_1;
  reg          ram_bp_xcpt_if_oh_0;
  reg          ram_bp_debug_if_oh_7;
  reg          ram_bp_debug_if_oh_6;
  reg          ram_bp_debug_if_oh_5;
  reg          ram_bp_debug_if_oh_4;
  reg          ram_bp_debug_if_oh_3;
  reg          ram_bp_debug_if_oh_2;
  reg          ram_bp_debug_if_oh_1;
  reg          ram_bp_debug_if_oh_0;
  reg          ram_xcpt_ae_if;
  reg          ram_xcpt_pf_if;
  reg  [4:0]   ram_ghist_ras_idx;
  reg          ram_ghist_new_saw_branch_taken;
  reg          ram_ghist_new_saw_branch_not_taken;
  reg          ram_ghist_current_saw_branch_not_taken;
  reg  [63:0]  ram_ghist_old_history;
  reg  [7:0]   ram_br_mask;
  reg  [7:0]   ram_mask;
  reg  [39:0]  ram_ras_top;
  reg          ram_cfi_is_ret;
  reg          ram_cfi_is_call;
  reg  [2:0]   ram_cfi_type;
  reg  [2:0]   ram_cfi_idx_bits;
  reg          ram_cfi_idx_valid;
  reg          ram_shadowed_mask_7;
  reg          ram_shadowed_mask_6;
  reg          ram_shadowed_mask_5;
  reg          ram_shadowed_mask_4;
  reg          ram_shadowed_mask_3;
  reg          ram_shadowed_mask_2;
  reg          ram_shadowed_mask_1;
  reg          ram_shadowed_mask_0;
  reg          ram_sfbs_7;
  reg          ram_sfbs_6;
  reg          ram_sfbs_5;
  reg          ram_sfbs_4;
  reg          ram_sfbs_3;
  reg          ram_sfbs_2;
  reg          ram_sfbs_1;
  reg          ram_sfbs_0;
  reg  [31:0]  ram_exp_insts_7;
  reg  [31:0]  ram_exp_insts_6;
  reg  [31:0]  ram_exp_insts_5;
  reg  [31:0]  ram_exp_insts_4;
  reg  [31:0]  ram_exp_insts_3;
  reg  [31:0]  ram_exp_insts_2;
  reg  [31:0]  ram_exp_insts_1;
  reg  [31:0]  ram_exp_insts_0;
  reg  [31:0]  ram_insts_7;
  reg  [31:0]  ram_insts_6;
  reg  [31:0]  ram_insts_5;
  reg  [31:0]  ram_insts_4;
  reg  [31:0]  ram_insts_3;
  reg  [31:0]  ram_insts_2;
  reg  [31:0]  ram_insts_1;
  reg  [31:0]  ram_insts_0;
  reg          ram_edge_inst_1;
  reg          ram_edge_inst_0;
  reg  [39:0]  ram_pc;
  wire         _io_enq_ready_output = io_deq_ready | ~full;
  wire         do_enq = _io_enq_ready_output & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_bpd_meta_1 <= io_enq_bits_bpd_meta_1;
      ram_bpd_meta_0 <= io_enq_bits_bpd_meta_0;
      ram_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
      ram_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      ram_ghist_ras_idx <= io_enq_bits_ghist_ras_idx;
      ram_ghist_new_saw_branch_taken <= io_enq_bits_ghist_new_saw_branch_taken;
      ram_ghist_new_saw_branch_not_taken <= io_enq_bits_ghist_new_saw_branch_not_taken;
      ram_ghist_current_saw_branch_not_taken <= io_enq_bits_ghist_current_saw_branch_not_taken;
      ram_ghist_old_history <= io_enq_bits_ghist_old_history;
      ram_br_mask <= io_enq_bits_br_mask;
      ram_mask <= io_enq_bits_mask;
      ram_ras_top <= io_enq_bits_ras_top;
      ram_cfi_is_ret <= io_enq_bits_cfi_is_ret;
      ram_cfi_is_call <= io_enq_bits_cfi_is_call;
      ram_cfi_type <= io_enq_bits_cfi_type;
      ram_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;
      ram_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;
      ram_sfbs_7 <= io_enq_bits_sfbs_7;
      ram_sfbs_6 <= io_enq_bits_sfbs_6;
      ram_sfbs_5 <= io_enq_bits_sfbs_5;
      ram_sfbs_4 <= io_enq_bits_sfbs_4;
      ram_sfbs_3 <= io_enq_bits_sfbs_3;
      ram_sfbs_2 <= io_enq_bits_sfbs_2;
      ram_sfbs_1 <= io_enq_bits_sfbs_1;
      ram_sfbs_0 <= io_enq_bits_sfbs_0;
      ram_exp_insts_7 <= io_enq_bits_exp_insts_7;
      ram_exp_insts_6 <= io_enq_bits_exp_insts_6;
      ram_exp_insts_5 <= io_enq_bits_exp_insts_5;
      ram_exp_insts_4 <= io_enq_bits_exp_insts_4;
      ram_exp_insts_3 <= io_enq_bits_exp_insts_3;
      ram_exp_insts_2 <= io_enq_bits_exp_insts_2;
      ram_exp_insts_1 <= io_enq_bits_exp_insts_1;
      ram_exp_insts_0 <= io_enq_bits_exp_insts_0;
      ram_insts_7 <= io_enq_bits_insts_7;
      ram_insts_6 <= io_enq_bits_insts_6;
      ram_insts_5 <= io_enq_bits_insts_5;
      ram_insts_4 <= io_enq_bits_insts_4;
      ram_insts_3 <= io_enq_bits_insts_3;
      ram_insts_2 <= io_enq_bits_insts_2;
      ram_insts_1 <= io_enq_bits_insts_1;
      ram_insts_0 <= io_enq_bits_insts_0;
      ram_edge_inst_1 <= io_enq_bits_edge_inst_1;
      ram_edge_inst_0 <= io_enq_bits_edge_inst_0;
      ram_pc <= io_enq_bits_pc;
    end
    ram_bp_xcpt_if_oh_7 <= ~do_enq & ram_bp_xcpt_if_oh_7;
    ram_bp_xcpt_if_oh_6 <= ~do_enq & ram_bp_xcpt_if_oh_6;
    ram_bp_xcpt_if_oh_5 <= ~do_enq & ram_bp_xcpt_if_oh_5;
    ram_bp_xcpt_if_oh_4 <= ~do_enq & ram_bp_xcpt_if_oh_4;
    ram_bp_xcpt_if_oh_3 <= ~do_enq & ram_bp_xcpt_if_oh_3;
    ram_bp_xcpt_if_oh_2 <= ~do_enq & ram_bp_xcpt_if_oh_2;
    ram_bp_xcpt_if_oh_1 <= ~do_enq & ram_bp_xcpt_if_oh_1;
    ram_bp_xcpt_if_oh_0 <= ~do_enq & ram_bp_xcpt_if_oh_0;
    ram_bp_debug_if_oh_7 <= ~do_enq & ram_bp_debug_if_oh_7;
    ram_bp_debug_if_oh_6 <= ~do_enq & ram_bp_debug_if_oh_6;
    ram_bp_debug_if_oh_5 <= ~do_enq & ram_bp_debug_if_oh_5;
    ram_bp_debug_if_oh_4 <= ~do_enq & ram_bp_debug_if_oh_4;
    ram_bp_debug_if_oh_3 <= ~do_enq & ram_bp_debug_if_oh_3;
    ram_bp_debug_if_oh_2 <= ~do_enq & ram_bp_debug_if_oh_2;
    ram_bp_debug_if_oh_1 <= ~do_enq & ram_bp_debug_if_oh_1;
    ram_bp_debug_if_oh_0 <= ~do_enq & ram_bp_debug_if_oh_0;
    ram_shadowed_mask_7 <= ~do_enq & ram_shadowed_mask_7;
    ram_shadowed_mask_6 <= ~do_enq & ram_shadowed_mask_6;
    ram_shadowed_mask_5 <= ~do_enq & ram_shadowed_mask_5;
    ram_shadowed_mask_4 <= ~do_enq & ram_shadowed_mask_4;
    ram_shadowed_mask_3 <= ~do_enq & ram_shadowed_mask_3;
    ram_shadowed_mask_2 <= ~do_enq & ram_shadowed_mask_2;
    ram_shadowed_mask_1 <= ~do_enq & ram_shadowed_mask_1;
    ram_shadowed_mask_0 <= ~do_enq & ram_shadowed_mask_0;
  end // always @(posedge)
  assign io_enq_ready = _io_enq_ready_output;
  assign io_deq_valid = full;
  assign io_deq_bits_pc = ram_pc;
  assign io_deq_bits_edge_inst_0 = ram_edge_inst_0;
  assign io_deq_bits_edge_inst_1 = ram_edge_inst_1;
  assign io_deq_bits_insts_0 = ram_insts_0;
  assign io_deq_bits_insts_1 = ram_insts_1;
  assign io_deq_bits_insts_2 = ram_insts_2;
  assign io_deq_bits_insts_3 = ram_insts_3;
  assign io_deq_bits_insts_4 = ram_insts_4;
  assign io_deq_bits_insts_5 = ram_insts_5;
  assign io_deq_bits_insts_6 = ram_insts_6;
  assign io_deq_bits_insts_7 = ram_insts_7;
  assign io_deq_bits_exp_insts_0 = ram_exp_insts_0;
  assign io_deq_bits_exp_insts_1 = ram_exp_insts_1;
  assign io_deq_bits_exp_insts_2 = ram_exp_insts_2;
  assign io_deq_bits_exp_insts_3 = ram_exp_insts_3;
  assign io_deq_bits_exp_insts_4 = ram_exp_insts_4;
  assign io_deq_bits_exp_insts_5 = ram_exp_insts_5;
  assign io_deq_bits_exp_insts_6 = ram_exp_insts_6;
  assign io_deq_bits_exp_insts_7 = ram_exp_insts_7;
  assign io_deq_bits_sfbs_0 = ram_sfbs_0;
  assign io_deq_bits_sfbs_1 = ram_sfbs_1;
  assign io_deq_bits_sfbs_2 = ram_sfbs_2;
  assign io_deq_bits_sfbs_3 = ram_sfbs_3;
  assign io_deq_bits_sfbs_4 = ram_sfbs_4;
  assign io_deq_bits_sfbs_5 = ram_sfbs_5;
  assign io_deq_bits_sfbs_6 = ram_sfbs_6;
  assign io_deq_bits_sfbs_7 = ram_sfbs_7;
  assign io_deq_bits_shadowed_mask_0 = ram_shadowed_mask_0;
  assign io_deq_bits_shadowed_mask_1 = ram_shadowed_mask_1;
  assign io_deq_bits_shadowed_mask_2 = ram_shadowed_mask_2;
  assign io_deq_bits_shadowed_mask_3 = ram_shadowed_mask_3;
  assign io_deq_bits_shadowed_mask_4 = ram_shadowed_mask_4;
  assign io_deq_bits_shadowed_mask_5 = ram_shadowed_mask_5;
  assign io_deq_bits_shadowed_mask_6 = ram_shadowed_mask_6;
  assign io_deq_bits_shadowed_mask_7 = ram_shadowed_mask_7;
  assign io_deq_bits_cfi_idx_valid = ram_cfi_idx_valid;
  assign io_deq_bits_cfi_idx_bits = ram_cfi_idx_bits;
  assign io_deq_bits_cfi_type = ram_cfi_type;
  assign io_deq_bits_cfi_is_call = ram_cfi_is_call;
  assign io_deq_bits_cfi_is_ret = ram_cfi_is_ret;
  assign io_deq_bits_ras_top = ram_ras_top;
  assign io_deq_bits_mask = ram_mask;
  assign io_deq_bits_br_mask = ram_br_mask;
  assign io_deq_bits_ghist_old_history = ram_ghist_old_history;
  assign io_deq_bits_ghist_current_saw_branch_not_taken = ram_ghist_current_saw_branch_not_taken;
  assign io_deq_bits_ghist_new_saw_branch_not_taken = ram_ghist_new_saw_branch_not_taken;
  assign io_deq_bits_ghist_new_saw_branch_taken = ram_ghist_new_saw_branch_taken;
  assign io_deq_bits_ghist_ras_idx = ram_ghist_ras_idx;
  assign io_deq_bits_xcpt_pf_if = ram_xcpt_pf_if;
  assign io_deq_bits_xcpt_ae_if = ram_xcpt_ae_if;
  assign io_deq_bits_bp_debug_if_oh_0 = ram_bp_debug_if_oh_0;
  assign io_deq_bits_bp_debug_if_oh_1 = ram_bp_debug_if_oh_1;
  assign io_deq_bits_bp_debug_if_oh_2 = ram_bp_debug_if_oh_2;
  assign io_deq_bits_bp_debug_if_oh_3 = ram_bp_debug_if_oh_3;
  assign io_deq_bits_bp_debug_if_oh_4 = ram_bp_debug_if_oh_4;
  assign io_deq_bits_bp_debug_if_oh_5 = ram_bp_debug_if_oh_5;
  assign io_deq_bits_bp_debug_if_oh_6 = ram_bp_debug_if_oh_6;
  assign io_deq_bits_bp_debug_if_oh_7 = ram_bp_debug_if_oh_7;
  assign io_deq_bits_bp_xcpt_if_oh_0 = ram_bp_xcpt_if_oh_0;
  assign io_deq_bits_bp_xcpt_if_oh_1 = ram_bp_xcpt_if_oh_1;
  assign io_deq_bits_bp_xcpt_if_oh_2 = ram_bp_xcpt_if_oh_2;
  assign io_deq_bits_bp_xcpt_if_oh_3 = ram_bp_xcpt_if_oh_3;
  assign io_deq_bits_bp_xcpt_if_oh_4 = ram_bp_xcpt_if_oh_4;
  assign io_deq_bits_bp_xcpt_if_oh_5 = ram_bp_xcpt_if_oh_5;
  assign io_deq_bits_bp_xcpt_if_oh_6 = ram_bp_xcpt_if_oh_6;
  assign io_deq_bits_bp_xcpt_if_oh_7 = ram_bp_xcpt_if_oh_7;
  assign io_deq_bits_bpd_meta_0 = ram_bpd_meta_0;
  assign io_deq_bits_bpd_meta_1 = ram_bpd_meta_1;
endmodule

