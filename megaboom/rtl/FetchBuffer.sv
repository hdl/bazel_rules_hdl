// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FetchBuffer(
  input         clock,
                reset,
                io_enq_valid,
  input  [39:0] io_enq_bits_pc,
  input         io_enq_bits_edge_inst_0,
                io_enq_bits_edge_inst_1,
  input  [31:0] io_enq_bits_insts_0,
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
  input         io_enq_bits_shadowed_mask_0,
                io_enq_bits_shadowed_mask_1,
                io_enq_bits_shadowed_mask_2,
                io_enq_bits_shadowed_mask_3,
                io_enq_bits_shadowed_mask_4,
                io_enq_bits_shadowed_mask_5,
                io_enq_bits_shadowed_mask_6,
                io_enq_bits_shadowed_mask_7,
                io_enq_bits_cfi_idx_valid,
  input  [2:0]  io_enq_bits_cfi_idx_bits,
  input  [5:0]  io_enq_bits_ftq_idx,
  input  [7:0]  io_enq_bits_mask,
  input         io_enq_bits_xcpt_pf_if,
                io_enq_bits_xcpt_ae_if,
                io_enq_bits_bp_debug_if_oh_0,
                io_enq_bits_bp_debug_if_oh_1,
                io_enq_bits_bp_debug_if_oh_2,
                io_enq_bits_bp_debug_if_oh_3,
                io_enq_bits_bp_debug_if_oh_4,
                io_enq_bits_bp_debug_if_oh_5,
                io_enq_bits_bp_debug_if_oh_6,
                io_enq_bits_bp_debug_if_oh_7,
                io_enq_bits_bp_xcpt_if_oh_0,
                io_enq_bits_bp_xcpt_if_oh_1,
                io_enq_bits_bp_xcpt_if_oh_2,
                io_enq_bits_bp_xcpt_if_oh_3,
                io_enq_bits_bp_xcpt_if_oh_4,
                io_enq_bits_bp_xcpt_if_oh_5,
                io_enq_bits_bp_xcpt_if_oh_6,
                io_enq_bits_bp_xcpt_if_oh_7,
                io_deq_ready,
                io_clear,
  output        io_enq_ready,
                io_deq_valid,
                io_deq_bits_uops_0_valid,
  output [31:0] io_deq_bits_uops_0_bits_inst,
  output        io_deq_bits_uops_0_bits_is_rvc,
                io_deq_bits_uops_0_bits_ctrl_is_load,
                io_deq_bits_uops_0_bits_ctrl_is_sta,
                io_deq_bits_uops_0_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_0_bits_ftq_idx,
  output        io_deq_bits_uops_0_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_0_bits_pc_lob,
  output        io_deq_bits_uops_0_bits_taken,
                io_deq_bits_uops_0_bits_xcpt_pf_if,
                io_deq_bits_uops_0_bits_xcpt_ae_if,
                io_deq_bits_uops_0_bits_bp_debug_if,
                io_deq_bits_uops_0_bits_bp_xcpt_if,
                io_deq_bits_uops_1_valid,
  output [31:0] io_deq_bits_uops_1_bits_inst,
  output        io_deq_bits_uops_1_bits_is_rvc,
                io_deq_bits_uops_1_bits_ctrl_is_load,
                io_deq_bits_uops_1_bits_ctrl_is_sta,
                io_deq_bits_uops_1_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_1_bits_ftq_idx,
  output        io_deq_bits_uops_1_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_1_bits_pc_lob,
  output        io_deq_bits_uops_1_bits_taken,
                io_deq_bits_uops_1_bits_xcpt_pf_if,
                io_deq_bits_uops_1_bits_xcpt_ae_if,
                io_deq_bits_uops_1_bits_bp_debug_if,
                io_deq_bits_uops_1_bits_bp_xcpt_if,
                io_deq_bits_uops_2_valid,
  output [31:0] io_deq_bits_uops_2_bits_inst,
  output        io_deq_bits_uops_2_bits_is_rvc,
                io_deq_bits_uops_2_bits_ctrl_is_load,
                io_deq_bits_uops_2_bits_ctrl_is_sta,
                io_deq_bits_uops_2_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_2_bits_ftq_idx,
  output        io_deq_bits_uops_2_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_2_bits_pc_lob,
  output        io_deq_bits_uops_2_bits_taken,
                io_deq_bits_uops_2_bits_xcpt_pf_if,
                io_deq_bits_uops_2_bits_xcpt_ae_if,
                io_deq_bits_uops_2_bits_bp_debug_if,
                io_deq_bits_uops_2_bits_bp_xcpt_if,
                io_deq_bits_uops_3_valid,
  output [31:0] io_deq_bits_uops_3_bits_inst,
  output        io_deq_bits_uops_3_bits_is_rvc,
                io_deq_bits_uops_3_bits_ctrl_is_load,
                io_deq_bits_uops_3_bits_ctrl_is_sta,
                io_deq_bits_uops_3_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_3_bits_ftq_idx,
  output        io_deq_bits_uops_3_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_3_bits_pc_lob,
  output        io_deq_bits_uops_3_bits_taken,
                io_deq_bits_uops_3_bits_xcpt_pf_if,
                io_deq_bits_uops_3_bits_xcpt_ae_if,
                io_deq_bits_uops_3_bits_bp_debug_if,
                io_deq_bits_uops_3_bits_bp_xcpt_if
);

  reg  [31:0] deq_vec_0_0_inst;
  reg         deq_vec_0_0_is_rvc;
  reg         deq_vec_0_0_ctrl_is_load;
  reg         deq_vec_0_0_ctrl_is_sta;
  reg         deq_vec_0_0_is_sfb;
  reg  [5:0]  deq_vec_0_0_ftq_idx;
  reg         deq_vec_0_0_edge_inst;
  reg  [5:0]  deq_vec_0_0_pc_lob;
  reg         deq_vec_0_0_taken;
  reg         deq_vec_0_0_xcpt_pf_if;
  reg         deq_vec_0_0_xcpt_ae_if;
  reg         deq_vec_0_0_bp_debug_if;
  reg         deq_vec_0_0_bp_xcpt_if;
  reg  [31:0] deq_vec_0_1_inst;
  reg         deq_vec_0_1_is_rvc;
  reg         deq_vec_0_1_ctrl_is_load;
  reg         deq_vec_0_1_ctrl_is_sta;
  reg         deq_vec_0_1_is_sfb;
  reg  [5:0]  deq_vec_0_1_ftq_idx;
  reg         deq_vec_0_1_edge_inst;
  reg  [5:0]  deq_vec_0_1_pc_lob;
  reg         deq_vec_0_1_taken;
  reg         deq_vec_0_1_xcpt_pf_if;
  reg         deq_vec_0_1_xcpt_ae_if;
  reg         deq_vec_0_1_bp_debug_if;
  reg         deq_vec_0_1_bp_xcpt_if;
  reg  [31:0] deq_vec_0_2_inst;
  reg         deq_vec_0_2_is_rvc;
  reg         deq_vec_0_2_ctrl_is_load;
  reg         deq_vec_0_2_ctrl_is_sta;
  reg         deq_vec_0_2_is_sfb;
  reg  [5:0]  deq_vec_0_2_ftq_idx;
  reg         deq_vec_0_2_edge_inst;
  reg  [5:0]  deq_vec_0_2_pc_lob;
  reg         deq_vec_0_2_taken;
  reg         deq_vec_0_2_xcpt_pf_if;
  reg         deq_vec_0_2_xcpt_ae_if;
  reg         deq_vec_0_2_bp_debug_if;
  reg         deq_vec_0_2_bp_xcpt_if;
  reg  [31:0] deq_vec_0_3_inst;
  reg         deq_vec_0_3_is_rvc;
  reg         deq_vec_0_3_ctrl_is_load;
  reg         deq_vec_0_3_ctrl_is_sta;
  reg         deq_vec_0_3_is_sfb;
  reg  [5:0]  deq_vec_0_3_ftq_idx;
  reg         deq_vec_0_3_edge_inst;
  reg  [5:0]  deq_vec_0_3_pc_lob;
  reg         deq_vec_0_3_taken;
  reg         deq_vec_0_3_xcpt_pf_if;
  reg         deq_vec_0_3_xcpt_ae_if;
  reg         deq_vec_0_3_bp_debug_if;
  reg         deq_vec_0_3_bp_xcpt_if;
  reg  [31:0] deq_vec_1_0_inst;
  reg         deq_vec_1_0_is_rvc;
  reg         deq_vec_1_0_ctrl_is_load;
  reg         deq_vec_1_0_ctrl_is_sta;
  reg         deq_vec_1_0_is_sfb;
  reg  [5:0]  deq_vec_1_0_ftq_idx;
  reg         deq_vec_1_0_edge_inst;
  reg  [5:0]  deq_vec_1_0_pc_lob;
  reg         deq_vec_1_0_taken;
  reg         deq_vec_1_0_xcpt_pf_if;
  reg         deq_vec_1_0_xcpt_ae_if;
  reg         deq_vec_1_0_bp_debug_if;
  reg         deq_vec_1_0_bp_xcpt_if;
  reg  [31:0] deq_vec_1_1_inst;
  reg         deq_vec_1_1_is_rvc;
  reg         deq_vec_1_1_ctrl_is_load;
  reg         deq_vec_1_1_ctrl_is_sta;
  reg         deq_vec_1_1_is_sfb;
  reg  [5:0]  deq_vec_1_1_ftq_idx;
  reg         deq_vec_1_1_edge_inst;
  reg  [5:0]  deq_vec_1_1_pc_lob;
  reg         deq_vec_1_1_taken;
  reg         deq_vec_1_1_xcpt_pf_if;
  reg         deq_vec_1_1_xcpt_ae_if;
  reg         deq_vec_1_1_bp_debug_if;
  reg         deq_vec_1_1_bp_xcpt_if;
  reg  [31:0] deq_vec_1_2_inst;
  reg         deq_vec_1_2_is_rvc;
  reg         deq_vec_1_2_ctrl_is_load;
  reg         deq_vec_1_2_ctrl_is_sta;
  reg         deq_vec_1_2_is_sfb;
  reg  [5:0]  deq_vec_1_2_ftq_idx;
  reg         deq_vec_1_2_edge_inst;
  reg  [5:0]  deq_vec_1_2_pc_lob;
  reg         deq_vec_1_2_taken;
  reg         deq_vec_1_2_xcpt_pf_if;
  reg         deq_vec_1_2_xcpt_ae_if;
  reg         deq_vec_1_2_bp_debug_if;
  reg         deq_vec_1_2_bp_xcpt_if;
  reg  [31:0] deq_vec_1_3_inst;
  reg         deq_vec_1_3_is_rvc;
  reg         deq_vec_1_3_ctrl_is_load;
  reg         deq_vec_1_3_ctrl_is_sta;
  reg         deq_vec_1_3_is_sfb;
  reg  [5:0]  deq_vec_1_3_ftq_idx;
  reg         deq_vec_1_3_edge_inst;
  reg  [5:0]  deq_vec_1_3_pc_lob;
  reg         deq_vec_1_3_taken;
  reg         deq_vec_1_3_xcpt_pf_if;
  reg         deq_vec_1_3_xcpt_ae_if;
  reg         deq_vec_1_3_bp_debug_if;
  reg         deq_vec_1_3_bp_xcpt_if;
  reg  [31:0] deq_vec_2_0_inst;
  reg         deq_vec_2_0_is_rvc;
  reg         deq_vec_2_0_ctrl_is_load;
  reg         deq_vec_2_0_ctrl_is_sta;
  reg         deq_vec_2_0_is_sfb;
  reg  [5:0]  deq_vec_2_0_ftq_idx;
  reg         deq_vec_2_0_edge_inst;
  reg  [5:0]  deq_vec_2_0_pc_lob;
  reg         deq_vec_2_0_taken;
  reg         deq_vec_2_0_xcpt_pf_if;
  reg         deq_vec_2_0_xcpt_ae_if;
  reg         deq_vec_2_0_bp_debug_if;
  reg         deq_vec_2_0_bp_xcpt_if;
  reg  [31:0] deq_vec_2_1_inst;
  reg         deq_vec_2_1_is_rvc;
  reg         deq_vec_2_1_ctrl_is_load;
  reg         deq_vec_2_1_ctrl_is_sta;
  reg         deq_vec_2_1_is_sfb;
  reg  [5:0]  deq_vec_2_1_ftq_idx;
  reg         deq_vec_2_1_edge_inst;
  reg  [5:0]  deq_vec_2_1_pc_lob;
  reg         deq_vec_2_1_taken;
  reg         deq_vec_2_1_xcpt_pf_if;
  reg         deq_vec_2_1_xcpt_ae_if;
  reg         deq_vec_2_1_bp_debug_if;
  reg         deq_vec_2_1_bp_xcpt_if;
  reg  [31:0] deq_vec_2_2_inst;
  reg         deq_vec_2_2_is_rvc;
  reg         deq_vec_2_2_ctrl_is_load;
  reg         deq_vec_2_2_ctrl_is_sta;
  reg         deq_vec_2_2_is_sfb;
  reg  [5:0]  deq_vec_2_2_ftq_idx;
  reg         deq_vec_2_2_edge_inst;
  reg  [5:0]  deq_vec_2_2_pc_lob;
  reg         deq_vec_2_2_taken;
  reg         deq_vec_2_2_xcpt_pf_if;
  reg         deq_vec_2_2_xcpt_ae_if;
  reg         deq_vec_2_2_bp_debug_if;
  reg         deq_vec_2_2_bp_xcpt_if;
  reg  [31:0] deq_vec_2_3_inst;
  reg         deq_vec_2_3_is_rvc;
  reg         deq_vec_2_3_ctrl_is_load;
  reg         deq_vec_2_3_ctrl_is_sta;
  reg         deq_vec_2_3_is_sfb;
  reg  [5:0]  deq_vec_2_3_ftq_idx;
  reg         deq_vec_2_3_edge_inst;
  reg  [5:0]  deq_vec_2_3_pc_lob;
  reg         deq_vec_2_3_taken;
  reg         deq_vec_2_3_xcpt_pf_if;
  reg         deq_vec_2_3_xcpt_ae_if;
  reg         deq_vec_2_3_bp_debug_if;
  reg         deq_vec_2_3_bp_xcpt_if;
  reg  [31:0] deq_vec_3_0_inst;
  reg         deq_vec_3_0_is_rvc;
  reg         deq_vec_3_0_ctrl_is_load;
  reg         deq_vec_3_0_ctrl_is_sta;
  reg         deq_vec_3_0_is_sfb;
  reg  [5:0]  deq_vec_3_0_ftq_idx;
  reg         deq_vec_3_0_edge_inst;
  reg  [5:0]  deq_vec_3_0_pc_lob;
  reg         deq_vec_3_0_taken;
  reg         deq_vec_3_0_xcpt_pf_if;
  reg         deq_vec_3_0_xcpt_ae_if;
  reg         deq_vec_3_0_bp_debug_if;
  reg         deq_vec_3_0_bp_xcpt_if;
  reg  [31:0] deq_vec_3_1_inst;
  reg         deq_vec_3_1_is_rvc;
  reg         deq_vec_3_1_ctrl_is_load;
  reg         deq_vec_3_1_ctrl_is_sta;
  reg         deq_vec_3_1_is_sfb;
  reg  [5:0]  deq_vec_3_1_ftq_idx;
  reg         deq_vec_3_1_edge_inst;
  reg  [5:0]  deq_vec_3_1_pc_lob;
  reg         deq_vec_3_1_taken;
  reg         deq_vec_3_1_xcpt_pf_if;
  reg         deq_vec_3_1_xcpt_ae_if;
  reg         deq_vec_3_1_bp_debug_if;
  reg         deq_vec_3_1_bp_xcpt_if;
  reg  [31:0] deq_vec_3_2_inst;
  reg         deq_vec_3_2_is_rvc;
  reg         deq_vec_3_2_ctrl_is_load;
  reg         deq_vec_3_2_ctrl_is_sta;
  reg         deq_vec_3_2_is_sfb;
  reg  [5:0]  deq_vec_3_2_ftq_idx;
  reg         deq_vec_3_2_edge_inst;
  reg  [5:0]  deq_vec_3_2_pc_lob;
  reg         deq_vec_3_2_taken;
  reg         deq_vec_3_2_xcpt_pf_if;
  reg         deq_vec_3_2_xcpt_ae_if;
  reg         deq_vec_3_2_bp_debug_if;
  reg         deq_vec_3_2_bp_xcpt_if;
  reg  [31:0] deq_vec_3_3_inst;
  reg         deq_vec_3_3_is_rvc;
  reg         deq_vec_3_3_ctrl_is_load;
  reg         deq_vec_3_3_ctrl_is_sta;
  reg         deq_vec_3_3_is_sfb;
  reg  [5:0]  deq_vec_3_3_ftq_idx;
  reg         deq_vec_3_3_edge_inst;
  reg  [5:0]  deq_vec_3_3_pc_lob;
  reg         deq_vec_3_3_taken;
  reg         deq_vec_3_3_xcpt_pf_if;
  reg         deq_vec_3_3_xcpt_ae_if;
  reg         deq_vec_3_3_bp_debug_if;
  reg         deq_vec_3_3_bp_xcpt_if;
  reg  [31:0] deq_vec_4_0_inst;
  reg         deq_vec_4_0_is_rvc;
  reg         deq_vec_4_0_ctrl_is_load;
  reg         deq_vec_4_0_ctrl_is_sta;
  reg         deq_vec_4_0_is_sfb;
  reg  [5:0]  deq_vec_4_0_ftq_idx;
  reg         deq_vec_4_0_edge_inst;
  reg  [5:0]  deq_vec_4_0_pc_lob;
  reg         deq_vec_4_0_taken;
  reg         deq_vec_4_0_xcpt_pf_if;
  reg         deq_vec_4_0_xcpt_ae_if;
  reg         deq_vec_4_0_bp_debug_if;
  reg         deq_vec_4_0_bp_xcpt_if;
  reg  [31:0] deq_vec_4_1_inst;
  reg         deq_vec_4_1_is_rvc;
  reg         deq_vec_4_1_ctrl_is_load;
  reg         deq_vec_4_1_ctrl_is_sta;
  reg         deq_vec_4_1_is_sfb;
  reg  [5:0]  deq_vec_4_1_ftq_idx;
  reg         deq_vec_4_1_edge_inst;
  reg  [5:0]  deq_vec_4_1_pc_lob;
  reg         deq_vec_4_1_taken;
  reg         deq_vec_4_1_xcpt_pf_if;
  reg         deq_vec_4_1_xcpt_ae_if;
  reg         deq_vec_4_1_bp_debug_if;
  reg         deq_vec_4_1_bp_xcpt_if;
  reg  [31:0] deq_vec_4_2_inst;
  reg         deq_vec_4_2_is_rvc;
  reg         deq_vec_4_2_ctrl_is_load;
  reg         deq_vec_4_2_ctrl_is_sta;
  reg         deq_vec_4_2_is_sfb;
  reg  [5:0]  deq_vec_4_2_ftq_idx;
  reg         deq_vec_4_2_edge_inst;
  reg  [5:0]  deq_vec_4_2_pc_lob;
  reg         deq_vec_4_2_taken;
  reg         deq_vec_4_2_xcpt_pf_if;
  reg         deq_vec_4_2_xcpt_ae_if;
  reg         deq_vec_4_2_bp_debug_if;
  reg         deq_vec_4_2_bp_xcpt_if;
  reg  [31:0] deq_vec_4_3_inst;
  reg         deq_vec_4_3_is_rvc;
  reg         deq_vec_4_3_ctrl_is_load;
  reg         deq_vec_4_3_ctrl_is_sta;
  reg         deq_vec_4_3_is_sfb;
  reg  [5:0]  deq_vec_4_3_ftq_idx;
  reg         deq_vec_4_3_edge_inst;
  reg  [5:0]  deq_vec_4_3_pc_lob;
  reg         deq_vec_4_3_taken;
  reg         deq_vec_4_3_xcpt_pf_if;
  reg         deq_vec_4_3_xcpt_ae_if;
  reg         deq_vec_4_3_bp_debug_if;
  reg         deq_vec_4_3_bp_xcpt_if;
  reg  [31:0] deq_vec_5_0_inst;
  reg         deq_vec_5_0_is_rvc;
  reg         deq_vec_5_0_ctrl_is_load;
  reg         deq_vec_5_0_ctrl_is_sta;
  reg         deq_vec_5_0_is_sfb;
  reg  [5:0]  deq_vec_5_0_ftq_idx;
  reg         deq_vec_5_0_edge_inst;
  reg  [5:0]  deq_vec_5_0_pc_lob;
  reg         deq_vec_5_0_taken;
  reg         deq_vec_5_0_xcpt_pf_if;
  reg         deq_vec_5_0_xcpt_ae_if;
  reg         deq_vec_5_0_bp_debug_if;
  reg         deq_vec_5_0_bp_xcpt_if;
  reg  [31:0] deq_vec_5_1_inst;
  reg         deq_vec_5_1_is_rvc;
  reg         deq_vec_5_1_ctrl_is_load;
  reg         deq_vec_5_1_ctrl_is_sta;
  reg         deq_vec_5_1_is_sfb;
  reg  [5:0]  deq_vec_5_1_ftq_idx;
  reg         deq_vec_5_1_edge_inst;
  reg  [5:0]  deq_vec_5_1_pc_lob;
  reg         deq_vec_5_1_taken;
  reg         deq_vec_5_1_xcpt_pf_if;
  reg         deq_vec_5_1_xcpt_ae_if;
  reg         deq_vec_5_1_bp_debug_if;
  reg         deq_vec_5_1_bp_xcpt_if;
  reg  [31:0] deq_vec_5_2_inst;
  reg         deq_vec_5_2_is_rvc;
  reg         deq_vec_5_2_ctrl_is_load;
  reg         deq_vec_5_2_ctrl_is_sta;
  reg         deq_vec_5_2_is_sfb;
  reg  [5:0]  deq_vec_5_2_ftq_idx;
  reg         deq_vec_5_2_edge_inst;
  reg  [5:0]  deq_vec_5_2_pc_lob;
  reg         deq_vec_5_2_taken;
  reg         deq_vec_5_2_xcpt_pf_if;
  reg         deq_vec_5_2_xcpt_ae_if;
  reg         deq_vec_5_2_bp_debug_if;
  reg         deq_vec_5_2_bp_xcpt_if;
  reg  [31:0] deq_vec_5_3_inst;
  reg         deq_vec_5_3_is_rvc;
  reg         deq_vec_5_3_ctrl_is_load;
  reg         deq_vec_5_3_ctrl_is_sta;
  reg         deq_vec_5_3_is_sfb;
  reg  [5:0]  deq_vec_5_3_ftq_idx;
  reg         deq_vec_5_3_edge_inst;
  reg  [5:0]  deq_vec_5_3_pc_lob;
  reg         deq_vec_5_3_taken;
  reg         deq_vec_5_3_xcpt_pf_if;
  reg         deq_vec_5_3_xcpt_ae_if;
  reg         deq_vec_5_3_bp_debug_if;
  reg         deq_vec_5_3_bp_xcpt_if;
  reg  [31:0] deq_vec_6_0_inst;
  reg         deq_vec_6_0_is_rvc;
  reg         deq_vec_6_0_ctrl_is_load;
  reg         deq_vec_6_0_ctrl_is_sta;
  reg         deq_vec_6_0_is_sfb;
  reg  [5:0]  deq_vec_6_0_ftq_idx;
  reg         deq_vec_6_0_edge_inst;
  reg  [5:0]  deq_vec_6_0_pc_lob;
  reg         deq_vec_6_0_taken;
  reg         deq_vec_6_0_xcpt_pf_if;
  reg         deq_vec_6_0_xcpt_ae_if;
  reg         deq_vec_6_0_bp_debug_if;
  reg         deq_vec_6_0_bp_xcpt_if;
  reg  [31:0] deq_vec_6_1_inst;
  reg         deq_vec_6_1_is_rvc;
  reg         deq_vec_6_1_ctrl_is_load;
  reg         deq_vec_6_1_ctrl_is_sta;
  reg         deq_vec_6_1_is_sfb;
  reg  [5:0]  deq_vec_6_1_ftq_idx;
  reg         deq_vec_6_1_edge_inst;
  reg  [5:0]  deq_vec_6_1_pc_lob;
  reg         deq_vec_6_1_taken;
  reg         deq_vec_6_1_xcpt_pf_if;
  reg         deq_vec_6_1_xcpt_ae_if;
  reg         deq_vec_6_1_bp_debug_if;
  reg         deq_vec_6_1_bp_xcpt_if;
  reg  [31:0] deq_vec_6_2_inst;
  reg         deq_vec_6_2_is_rvc;
  reg         deq_vec_6_2_ctrl_is_load;
  reg         deq_vec_6_2_ctrl_is_sta;
  reg         deq_vec_6_2_is_sfb;
  reg  [5:0]  deq_vec_6_2_ftq_idx;
  reg         deq_vec_6_2_edge_inst;
  reg  [5:0]  deq_vec_6_2_pc_lob;
  reg         deq_vec_6_2_taken;
  reg         deq_vec_6_2_xcpt_pf_if;
  reg         deq_vec_6_2_xcpt_ae_if;
  reg         deq_vec_6_2_bp_debug_if;
  reg         deq_vec_6_2_bp_xcpt_if;
  reg  [31:0] deq_vec_6_3_inst;
  reg         deq_vec_6_3_is_rvc;
  reg         deq_vec_6_3_ctrl_is_load;
  reg         deq_vec_6_3_ctrl_is_sta;
  reg         deq_vec_6_3_is_sfb;
  reg  [5:0]  deq_vec_6_3_ftq_idx;
  reg         deq_vec_6_3_edge_inst;
  reg  [5:0]  deq_vec_6_3_pc_lob;
  reg         deq_vec_6_3_taken;
  reg         deq_vec_6_3_xcpt_pf_if;
  reg         deq_vec_6_3_xcpt_ae_if;
  reg         deq_vec_6_3_bp_debug_if;
  reg         deq_vec_6_3_bp_xcpt_if;
  reg  [31:0] deq_vec_7_0_inst;
  reg         deq_vec_7_0_is_rvc;
  reg         deq_vec_7_0_ctrl_is_load;
  reg         deq_vec_7_0_ctrl_is_sta;
  reg         deq_vec_7_0_is_sfb;
  reg  [5:0]  deq_vec_7_0_ftq_idx;
  reg         deq_vec_7_0_edge_inst;
  reg  [5:0]  deq_vec_7_0_pc_lob;
  reg         deq_vec_7_0_taken;
  reg         deq_vec_7_0_xcpt_pf_if;
  reg         deq_vec_7_0_xcpt_ae_if;
  reg         deq_vec_7_0_bp_debug_if;
  reg         deq_vec_7_0_bp_xcpt_if;
  reg  [31:0] deq_vec_7_1_inst;
  reg         deq_vec_7_1_is_rvc;
  reg         deq_vec_7_1_ctrl_is_load;
  reg         deq_vec_7_1_ctrl_is_sta;
  reg         deq_vec_7_1_is_sfb;
  reg  [5:0]  deq_vec_7_1_ftq_idx;
  reg         deq_vec_7_1_edge_inst;
  reg  [5:0]  deq_vec_7_1_pc_lob;
  reg         deq_vec_7_1_taken;
  reg         deq_vec_7_1_xcpt_pf_if;
  reg         deq_vec_7_1_xcpt_ae_if;
  reg         deq_vec_7_1_bp_debug_if;
  reg         deq_vec_7_1_bp_xcpt_if;
  reg  [31:0] deq_vec_7_2_inst;
  reg         deq_vec_7_2_is_rvc;
  reg         deq_vec_7_2_ctrl_is_load;
  reg         deq_vec_7_2_ctrl_is_sta;
  reg         deq_vec_7_2_is_sfb;
  reg  [5:0]  deq_vec_7_2_ftq_idx;
  reg         deq_vec_7_2_edge_inst;
  reg  [5:0]  deq_vec_7_2_pc_lob;
  reg         deq_vec_7_2_taken;
  reg         deq_vec_7_2_xcpt_pf_if;
  reg         deq_vec_7_2_xcpt_ae_if;
  reg         deq_vec_7_2_bp_debug_if;
  reg         deq_vec_7_2_bp_xcpt_if;
  reg  [31:0] deq_vec_7_3_inst;
  reg         deq_vec_7_3_is_rvc;
  reg         deq_vec_7_3_ctrl_is_load;
  reg         deq_vec_7_3_ctrl_is_sta;
  reg         deq_vec_7_3_is_sfb;
  reg  [5:0]  deq_vec_7_3_ftq_idx;
  reg         deq_vec_7_3_edge_inst;
  reg  [5:0]  deq_vec_7_3_pc_lob;
  reg         deq_vec_7_3_taken;
  reg         deq_vec_7_3_xcpt_pf_if;
  reg         deq_vec_7_3_xcpt_ae_if;
  reg         deq_vec_7_3_bp_debug_if;
  reg         deq_vec_7_3_bp_xcpt_if;
  reg  [7:0]  head;
  reg  [31:0] tail;
  reg         maybe_full;
  wire        _do_enq_T_1 = (|({tail[28], tail[24], tail[20], tail[16], tail[12], tail[8], tail[4], tail[0]} & head)) & maybe_full | (|(head & {tail[27], tail[23], tail[19], tail[15], tail[11], tail[7], tail[3], tail[31]} | head & {tail[26], tail[22], tail[18], tail[14], tail[10], tail[6], tail[2], tail[30]} | head & {tail[25], tail[21], tail[17], tail[13], tail[9], tail[5], tail[1], tail[29]} | head & {tail[24], tail[20], tail[16], tail[12], tail[8], tail[4], tail[0], tail[28]} | head & {tail[23], tail[19], tail[15], tail[11], tail[7], tail[3], tail[31], tail[27]} | head & {tail[22], tail[18], tail[14], tail[10], tail[6], tail[2], tail[30], tail[26]} | head & {tail[21], tail[17], tail[13], tail[9], tail[5], tail[1], tail[29], tail[25]}));
  wire [3:0]  slot_will_hit_tail = {{3{head[0]}}, head[0] & ~maybe_full} & tail[3:0] | {{3{head[1]}}, head[1] & ~maybe_full} & tail[7:4] | {{3{head[2]}}, head[2] & ~maybe_full} & tail[11:8] | {{3{head[3]}}, head[3] & ~maybe_full} & tail[15:12] | {{3{head[4]}}, head[4] & ~maybe_full} & tail[19:16] | {{3{head[5]}}, head[5] & ~maybe_full} & tail[23:20] | {{3{head[6]}}, head[6] & ~maybe_full} & tail[27:24] | {{3{head[7]}}, head[7] & ~maybe_full} & tail[31:28];
  wire [1:0]  _GEN = slot_will_hit_tail[2:1] | slot_will_hit_tail[1:0];
  wire [3:0]  _deq_valids_T_10 = slot_will_hit_tail | {_GEN[1] | slot_will_hit_tail[0], _GEN[0], slot_will_hit_tail[0], 1'h0};
  wire [3:0]  _deq_valids_T_11 = ~_deq_valids_T_10;
  wire        do_deq = io_deq_ready & slot_will_hit_tail == 4'h0;
  wire        in_mask_0 = io_enq_valid & io_enq_bits_mask[0];
  wire        in_uops_0_is_rvc = io_enq_bits_insts_0[1:0] != 2'h3;
  wire        in_uops_0_taken = io_enq_bits_cfi_idx_bits == 3'h0 & io_enq_bits_cfi_idx_valid;
  wire [5:0]  _GEN_0 = {io_enq_bits_pc[5:3], 3'h0};
  wire [5:0]  _pc_T_7 = _GEN_0 + 6'h2;
  wire        in_mask_1 = io_enq_valid & io_enq_bits_mask[1];
  wire        in_uops_1_is_rvc = io_enq_bits_insts_1[1:0] != 2'h3;
  wire        in_uops_1_taken = io_enq_bits_cfi_idx_bits == 3'h1 & io_enq_bits_cfi_idx_valid;
  wire [5:0]  _pc_T_11 = _GEN_0 + 6'h4;
  wire        in_mask_2 = io_enq_valid & io_enq_bits_mask[2];
  wire        in_uops_2_is_rvc = io_enq_bits_insts_2[1:0] != 2'h3;
  wire        in_uops_2_taken = io_enq_bits_cfi_idx_bits == 3'h2 & io_enq_bits_cfi_idx_valid;
  wire [5:0]  _pc_T_15 = _GEN_0 + 6'h6;
  wire        in_mask_3 = io_enq_valid & io_enq_bits_mask[3];
  wire        in_uops_3_is_rvc = io_enq_bits_insts_3[1:0] != 2'h3;
  wire        in_uops_3_taken = io_enq_bits_cfi_idx_bits == 3'h3 & io_enq_bits_cfi_idx_valid;
  wire        in_mask_4 = io_enq_valid & io_enq_bits_mask[4];
  wire [5:0]  _GEN_4 = io_enq_bits_edge_inst_1 ? _GEN_0 + 6'h8 : _GEN_0 + 6'h8;
  wire        in_uops_4_is_rvc = io_enq_bits_insts_4[1:0] != 2'h3;
  wire        in_uops_4_taken = io_enq_bits_cfi_idx_bits == 3'h4 & io_enq_bits_cfi_idx_valid;
  wire [5:0]  _pc_T_23 = _GEN_0 + 6'hA;
  wire        in_mask_5 = io_enq_valid & io_enq_bits_mask[5];
  wire        in_uops_5_is_rvc = io_enq_bits_insts_5[1:0] != 2'h3;
  wire        in_uops_5_taken = io_enq_bits_cfi_idx_bits == 3'h5 & io_enq_bits_cfi_idx_valid;
  wire [5:0]  _pc_T_27 = _GEN_0 + 6'hC;
  wire        in_mask_6 = io_enq_valid & io_enq_bits_mask[6];
  wire        in_uops_6_is_rvc = io_enq_bits_insts_6[1:0] != 2'h3;
  wire        in_uops_6_taken = io_enq_bits_cfi_idx_bits == 3'h6 & io_enq_bits_cfi_idx_valid;
  wire [5:0]  _pc_T_31 = _GEN_0 + 6'hE;
  wire        in_mask_7 = io_enq_valid & io_enq_bits_mask[7];
  wire        in_uops_7_is_rvc = io_enq_bits_insts_7[1:0] != 2'h3;
  wire        in_uops_7_taken = (&io_enq_bits_cfi_idx_bits) & io_enq_bits_cfi_idx_valid;
  wire [31:0] _GEN_1 = {tail[30:0], tail[31]};
  wire [31:0] enq_idxs_1 = in_mask_0 ? _GEN_1 : tail;
  wire [31:0] _GEN_2 = {enq_idxs_1[30:0], enq_idxs_1[31]};
  wire [31:0] enq_idxs_2 = in_mask_1 ? _GEN_2 : enq_idxs_1;
  wire [31:0] _GEN_3 = {enq_idxs_2[30:0], enq_idxs_2[31]};
  wire [31:0] enq_idxs_3 = in_mask_2 ? _GEN_3 : enq_idxs_2;
  wire [31:0] _GEN_5 = {enq_idxs_3[30:0], enq_idxs_3[31]};
  wire [31:0] enq_idxs_4 = in_mask_3 ? _GEN_5 : enq_idxs_3;
  wire [31:0] _GEN_6 = {enq_idxs_4[30:0], enq_idxs_4[31]};
  wire [31:0] enq_idxs_5 = in_mask_4 ? _GEN_6 : enq_idxs_4;
  wire [31:0] _GEN_7 = {enq_idxs_5[30:0], enq_idxs_5[31]};
  wire [31:0] enq_idxs_6 = in_mask_5 ? _GEN_7 : enq_idxs_5;
  wire [31:0] _GEN_8 = {enq_idxs_6[30:0], enq_idxs_6[31]};
  wire [31:0] enq_idxs_7 = in_mask_6 ? _GEN_8 : enq_idxs_6;
  wire        _GEN_9 = ~_do_enq_T_1 & in_mask_0;
  wire        _GEN_10 = _GEN_9 & tail[0];
  wire [5:0]  in_uops_0_pc_lob = {io_enq_bits_pc[5:3], 3'h0};
  wire        _GEN_11 = _GEN_9 & tail[1];
  wire        _GEN_12 = _GEN_9 & tail[2];
  wire        _GEN_13 = _GEN_9 & tail[3];
  wire        _GEN_14 = _GEN_9 & tail[4];
  wire        _GEN_15 = _GEN_9 & tail[5];
  wire        _GEN_16 = _GEN_9 & tail[6];
  wire        _GEN_17 = _GEN_9 & tail[7];
  wire        _GEN_18 = _GEN_9 & tail[8];
  wire        _GEN_19 = _GEN_9 & tail[9];
  wire        _GEN_20 = _GEN_9 & tail[10];
  wire        _GEN_21 = _GEN_9 & tail[11];
  wire        _GEN_22 = _GEN_9 & tail[12];
  wire        _GEN_23 = _GEN_9 & tail[13];
  wire        _GEN_24 = _GEN_9 & tail[14];
  wire        _GEN_25 = _GEN_9 & tail[15];
  wire        _GEN_26 = _GEN_9 & tail[16];
  wire        _GEN_27 = _GEN_9 & tail[17];
  wire        _GEN_28 = _GEN_9 & tail[18];
  wire        _GEN_29 = _GEN_9 & tail[19];
  wire        _GEN_30 = _GEN_9 & tail[20];
  wire        _GEN_31 = _GEN_9 & tail[21];
  wire        _GEN_32 = _GEN_9 & tail[22];
  wire        _GEN_33 = _GEN_9 & tail[23];
  wire        _GEN_34 = _GEN_9 & tail[24];
  wire        _GEN_35 = _GEN_9 & tail[25];
  wire        _GEN_36 = _GEN_9 & tail[26];
  wire        _GEN_37 = _GEN_9 & tail[27];
  wire        _GEN_38 = _GEN_9 & tail[28];
  wire        _GEN_39 = _GEN_9 & tail[29];
  wire        _GEN_40 = _GEN_9 & tail[30];
  wire        _GEN_41 = _GEN_9 & tail[31];
  wire        _GEN_42 = ~_do_enq_T_1 & in_mask_1;
  wire        _GEN_43 = _GEN_42 & enq_idxs_1[0];
  wire        _GEN_44 = _GEN_42 & enq_idxs_1[1];
  wire        _GEN_45 = _GEN_42 & enq_idxs_1[2];
  wire        _GEN_46 = _GEN_42 & enq_idxs_1[3];
  wire        _GEN_47 = _GEN_42 & enq_idxs_1[4];
  wire        _GEN_48 = _GEN_42 & enq_idxs_1[5];
  wire        _GEN_49 = _GEN_42 & enq_idxs_1[6];
  wire        _GEN_50 = _GEN_42 & enq_idxs_1[7];
  wire        _GEN_51 = _GEN_42 & enq_idxs_1[8];
  wire        _GEN_52 = _GEN_42 & enq_idxs_1[9];
  wire        _GEN_53 = _GEN_42 & enq_idxs_1[10];
  wire        _GEN_54 = _GEN_42 & enq_idxs_1[11];
  wire        _GEN_55 = _GEN_42 & enq_idxs_1[12];
  wire        _GEN_56 = _GEN_42 & enq_idxs_1[13];
  wire        _GEN_57 = _GEN_42 & enq_idxs_1[14];
  wire        _GEN_58 = _GEN_42 & enq_idxs_1[15];
  wire        _GEN_59 = _GEN_42 & enq_idxs_1[16];
  wire        _GEN_60 = _GEN_42 & enq_idxs_1[17];
  wire        _GEN_61 = _GEN_42 & enq_idxs_1[18];
  wire        _GEN_62 = _GEN_42 & enq_idxs_1[19];
  wire        _GEN_63 = _GEN_42 & enq_idxs_1[20];
  wire        _GEN_64 = _GEN_42 & enq_idxs_1[21];
  wire        _GEN_65 = _GEN_42 & enq_idxs_1[22];
  wire        _GEN_66 = _GEN_42 & enq_idxs_1[23];
  wire        _GEN_67 = _GEN_42 & enq_idxs_1[24];
  wire        _GEN_68 = _GEN_42 & enq_idxs_1[25];
  wire        _GEN_69 = _GEN_42 & enq_idxs_1[26];
  wire        _GEN_70 = _GEN_42 & enq_idxs_1[27];
  wire        _GEN_71 = _GEN_42 & enq_idxs_1[28];
  wire        _GEN_72 = _GEN_42 & enq_idxs_1[29];
  wire        _GEN_73 = _GEN_42 & enq_idxs_1[30];
  wire        _GEN_74 = _GEN_42 & enq_idxs_1[31];
  wire        _GEN_75 = ~_do_enq_T_1 & in_mask_2;
  wire        _GEN_76 = _GEN_75 & enq_idxs_2[0];
  wire        _GEN_77 = _GEN_75 & enq_idxs_2[1];
  wire        _GEN_78 = _GEN_75 & enq_idxs_2[2];
  wire        _GEN_79 = _GEN_75 & enq_idxs_2[3];
  wire        _GEN_80 = _GEN_75 & enq_idxs_2[4];
  wire        _GEN_81 = _GEN_75 & enq_idxs_2[5];
  wire        _GEN_82 = _GEN_75 & enq_idxs_2[6];
  wire        _GEN_83 = _GEN_75 & enq_idxs_2[7];
  wire        _GEN_84 = _GEN_75 & enq_idxs_2[8];
  wire        _GEN_85 = _GEN_75 & enq_idxs_2[9];
  wire        _GEN_86 = _GEN_75 & enq_idxs_2[10];
  wire        _GEN_87 = _GEN_75 & enq_idxs_2[11];
  wire        _GEN_88 = _GEN_75 & enq_idxs_2[12];
  wire        _GEN_89 = _GEN_75 & enq_idxs_2[13];
  wire        _GEN_90 = _GEN_75 & enq_idxs_2[14];
  wire        _GEN_91 = _GEN_75 & enq_idxs_2[15];
  wire        _GEN_92 = _GEN_75 & enq_idxs_2[16];
  wire        _GEN_93 = _GEN_75 & enq_idxs_2[17];
  wire        _GEN_94 = _GEN_75 & enq_idxs_2[18];
  wire        _GEN_95 = _GEN_75 & enq_idxs_2[19];
  wire        _GEN_96 = _GEN_75 & enq_idxs_2[20];
  wire        _GEN_97 = _GEN_75 & enq_idxs_2[21];
  wire        _GEN_98 = _GEN_75 & enq_idxs_2[22];
  wire        _GEN_99 = _GEN_75 & enq_idxs_2[23];
  wire        _GEN_100 = _GEN_75 & enq_idxs_2[24];
  wire        _GEN_101 = _GEN_75 & enq_idxs_2[25];
  wire        _GEN_102 = _GEN_75 & enq_idxs_2[26];
  wire        _GEN_103 = _GEN_75 & enq_idxs_2[27];
  wire        _GEN_104 = _GEN_75 & enq_idxs_2[28];
  wire        _GEN_105 = _GEN_75 & enq_idxs_2[29];
  wire        _GEN_106 = _GEN_75 & enq_idxs_2[30];
  wire        _GEN_107 = _GEN_75 & enq_idxs_2[31];
  wire        _GEN_108 = ~_do_enq_T_1 & in_mask_3;
  wire        _GEN_109 = _GEN_108 & enq_idxs_3[0];
  wire        _GEN_110 = _GEN_108 & enq_idxs_3[1];
  wire        _GEN_111 = _GEN_108 & enq_idxs_3[2];
  wire        _GEN_112 = _GEN_108 & enq_idxs_3[3];
  wire        _GEN_113 = _GEN_108 & enq_idxs_3[4];
  wire        _GEN_114 = _GEN_108 & enq_idxs_3[5];
  wire        _GEN_115 = _GEN_108 & enq_idxs_3[6];
  wire        _GEN_116 = _GEN_108 & enq_idxs_3[7];
  wire        _GEN_117 = _GEN_108 & enq_idxs_3[8];
  wire        _GEN_118 = _GEN_108 & enq_idxs_3[9];
  wire        _GEN_119 = _GEN_108 & enq_idxs_3[10];
  wire        _GEN_120 = _GEN_108 & enq_idxs_3[11];
  wire        _GEN_121 = _GEN_108 & enq_idxs_3[12];
  wire        _GEN_122 = _GEN_108 & enq_idxs_3[13];
  wire        _GEN_123 = _GEN_108 & enq_idxs_3[14];
  wire        _GEN_124 = _GEN_108 & enq_idxs_3[15];
  wire        _GEN_125 = _GEN_108 & enq_idxs_3[16];
  wire        _GEN_126 = _GEN_108 & enq_idxs_3[17];
  wire        _GEN_127 = _GEN_108 & enq_idxs_3[18];
  wire        _GEN_128 = _GEN_108 & enq_idxs_3[19];
  wire        _GEN_129 = _GEN_108 & enq_idxs_3[20];
  wire        _GEN_130 = _GEN_108 & enq_idxs_3[21];
  wire        _GEN_131 = _GEN_108 & enq_idxs_3[22];
  wire        _GEN_132 = _GEN_108 & enq_idxs_3[23];
  wire        _GEN_133 = _GEN_108 & enq_idxs_3[24];
  wire        _GEN_134 = _GEN_108 & enq_idxs_3[25];
  wire        _GEN_135 = _GEN_108 & enq_idxs_3[26];
  wire        _GEN_136 = _GEN_108 & enq_idxs_3[27];
  wire        _GEN_137 = _GEN_108 & enq_idxs_3[28];
  wire        _GEN_138 = _GEN_108 & enq_idxs_3[29];
  wire        _GEN_139 = _GEN_108 & enq_idxs_3[30];
  wire        _GEN_140 = _GEN_108 & enq_idxs_3[31];
  wire        _GEN_141 = ~_do_enq_T_1 & in_mask_4;
  wire        _GEN_142 = _GEN_141 & enq_idxs_4[0];
  wire        _GEN_143 = _GEN_141 & enq_idxs_4[1];
  wire        _GEN_144 = _GEN_141 & enq_idxs_4[2];
  wire        _GEN_145 = _GEN_141 & enq_idxs_4[3];
  wire        _GEN_146 = _GEN_141 & enq_idxs_4[4];
  wire        _GEN_147 = _GEN_141 & enq_idxs_4[5];
  wire        _GEN_148 = _GEN_141 & enq_idxs_4[6];
  wire        _GEN_149 = _GEN_141 & enq_idxs_4[7];
  wire        _GEN_150 = _GEN_141 & enq_idxs_4[8];
  wire        _GEN_151 = _GEN_141 & enq_idxs_4[9];
  wire        _GEN_152 = _GEN_141 & enq_idxs_4[10];
  wire        _GEN_153 = _GEN_141 & enq_idxs_4[11];
  wire        _GEN_154 = _GEN_141 & enq_idxs_4[12];
  wire        _GEN_155 = _GEN_141 & enq_idxs_4[13];
  wire        _GEN_156 = _GEN_141 & enq_idxs_4[14];
  wire        _GEN_157 = _GEN_141 & enq_idxs_4[15];
  wire        _GEN_158 = _GEN_141 & enq_idxs_4[16];
  wire        _GEN_159 = _GEN_141 & enq_idxs_4[17];
  wire        _GEN_160 = _GEN_141 & enq_idxs_4[18];
  wire        _GEN_161 = _GEN_141 & enq_idxs_4[19];
  wire        _GEN_162 = _GEN_141 & enq_idxs_4[20];
  wire        _GEN_163 = _GEN_141 & enq_idxs_4[21];
  wire        _GEN_164 = _GEN_141 & enq_idxs_4[22];
  wire        _GEN_165 = _GEN_141 & enq_idxs_4[23];
  wire        _GEN_166 = _GEN_141 & enq_idxs_4[24];
  wire        _GEN_167 = _GEN_141 & enq_idxs_4[25];
  wire        _GEN_168 = _GEN_141 & enq_idxs_4[26];
  wire        _GEN_169 = _GEN_141 & enq_idxs_4[27];
  wire        _GEN_170 = _GEN_141 & enq_idxs_4[28];
  wire        _GEN_171 = _GEN_141 & enq_idxs_4[29];
  wire        _GEN_172 = _GEN_141 & enq_idxs_4[30];
  wire        _GEN_173 = _GEN_141 & enq_idxs_4[31];
  wire        _GEN_174 = ~_do_enq_T_1 & in_mask_5;
  wire        _GEN_175 = _GEN_174 & enq_idxs_5[0];
  wire        _GEN_176 = _GEN_174 & enq_idxs_5[1];
  wire        _GEN_177 = _GEN_174 & enq_idxs_5[2];
  wire        _GEN_178 = _GEN_174 & enq_idxs_5[3];
  wire        _GEN_179 = _GEN_174 & enq_idxs_5[4];
  wire        _GEN_180 = _GEN_174 & enq_idxs_5[5];
  wire        _GEN_181 = _GEN_174 & enq_idxs_5[6];
  wire        _GEN_182 = _GEN_174 & enq_idxs_5[7];
  wire        _GEN_183 = _GEN_174 & enq_idxs_5[8];
  wire        _GEN_184 = _GEN_174 & enq_idxs_5[9];
  wire        _GEN_185 = _GEN_174 & enq_idxs_5[10];
  wire        _GEN_186 = _GEN_174 & enq_idxs_5[11];
  wire        _GEN_187 = _GEN_174 & enq_idxs_5[12];
  wire        _GEN_188 = _GEN_174 & enq_idxs_5[13];
  wire        _GEN_189 = _GEN_174 & enq_idxs_5[14];
  wire        _GEN_190 = _GEN_174 & enq_idxs_5[15];
  wire        _GEN_191 = _GEN_174 & enq_idxs_5[16];
  wire        _GEN_192 = _GEN_174 & enq_idxs_5[17];
  wire        _GEN_193 = _GEN_174 & enq_idxs_5[18];
  wire        _GEN_194 = _GEN_174 & enq_idxs_5[19];
  wire        _GEN_195 = _GEN_174 & enq_idxs_5[20];
  wire        _GEN_196 = _GEN_174 & enq_idxs_5[21];
  wire        _GEN_197 = _GEN_174 & enq_idxs_5[22];
  wire        _GEN_198 = _GEN_174 & enq_idxs_5[23];
  wire        _GEN_199 = _GEN_174 & enq_idxs_5[24];
  wire        _GEN_200 = _GEN_174 & enq_idxs_5[25];
  wire        _GEN_201 = _GEN_174 & enq_idxs_5[26];
  wire        _GEN_202 = _GEN_174 & enq_idxs_5[27];
  wire        _GEN_203 = _GEN_174 & enq_idxs_5[28];
  wire        _GEN_204 = _GEN_174 & enq_idxs_5[29];
  wire        _GEN_205 = _GEN_174 & enq_idxs_5[30];
  wire        _GEN_206 = _GEN_174 & enq_idxs_5[31];
  wire        _GEN_207 = ~_do_enq_T_1 & in_mask_6;
  wire        _GEN_208 = _GEN_207 & enq_idxs_6[0];
  wire        _GEN_209 = _GEN_207 & enq_idxs_6[1];
  wire        _GEN_210 = _GEN_207 & enq_idxs_6[2];
  wire        _GEN_211 = _GEN_207 & enq_idxs_6[3];
  wire        _GEN_212 = _GEN_207 & enq_idxs_6[4];
  wire        _GEN_213 = _GEN_207 & enq_idxs_6[5];
  wire        _GEN_214 = _GEN_207 & enq_idxs_6[6];
  wire        _GEN_215 = _GEN_207 & enq_idxs_6[7];
  wire        _GEN_216 = _GEN_207 & enq_idxs_6[8];
  wire        _GEN_217 = _GEN_207 & enq_idxs_6[9];
  wire        _GEN_218 = _GEN_207 & enq_idxs_6[10];
  wire        _GEN_219 = _GEN_207 & enq_idxs_6[11];
  wire        _GEN_220 = _GEN_207 & enq_idxs_6[12];
  wire        _GEN_221 = _GEN_207 & enq_idxs_6[13];
  wire        _GEN_222 = _GEN_207 & enq_idxs_6[14];
  wire        _GEN_223 = _GEN_207 & enq_idxs_6[15];
  wire        _GEN_224 = _GEN_207 & enq_idxs_6[16];
  wire        _GEN_225 = _GEN_207 & enq_idxs_6[17];
  wire        _GEN_226 = _GEN_207 & enq_idxs_6[18];
  wire        _GEN_227 = _GEN_207 & enq_idxs_6[19];
  wire        _GEN_228 = _GEN_207 & enq_idxs_6[20];
  wire        _GEN_229 = _GEN_207 & enq_idxs_6[21];
  wire        _GEN_230 = _GEN_207 & enq_idxs_6[22];
  wire        _GEN_231 = _GEN_207 & enq_idxs_6[23];
  wire        _GEN_232 = _GEN_207 & enq_idxs_6[24];
  wire        _GEN_233 = _GEN_207 & enq_idxs_6[25];
  wire        _GEN_234 = _GEN_207 & enq_idxs_6[26];
  wire        _GEN_235 = _GEN_207 & enq_idxs_6[27];
  wire        _GEN_236 = _GEN_207 & enq_idxs_6[28];
  wire        _GEN_237 = _GEN_207 & enq_idxs_6[29];
  wire        _GEN_238 = _GEN_207 & enq_idxs_6[30];
  wire        _GEN_239 = _GEN_207 & enq_idxs_6[31];
  wire        _GEN_240 = ~_do_enq_T_1 & in_mask_7;
  wire        _GEN_241 = _GEN_240 & enq_idxs_7[0];
  wire        _GEN_242 = _GEN_241 | _GEN_208 | _GEN_175 | _GEN_142 | _GEN_109 | _GEN_76 | _GEN_43 | _GEN_10;
  wire        _GEN_243 = _GEN_240 & enq_idxs_7[1];
  wire        _GEN_244 = _GEN_243 | _GEN_209 | _GEN_176 | _GEN_143 | _GEN_110 | _GEN_77 | _GEN_44 | _GEN_11;
  wire        _GEN_245 = _GEN_240 & enq_idxs_7[2];
  wire        _GEN_246 = _GEN_245 | _GEN_210 | _GEN_177 | _GEN_144 | _GEN_111 | _GEN_78 | _GEN_45 | _GEN_12;
  wire        _GEN_247 = _GEN_240 & enq_idxs_7[3];
  wire        _GEN_248 = _GEN_247 | _GEN_211 | _GEN_178 | _GEN_145 | _GEN_112 | _GEN_79 | _GEN_46 | _GEN_13;
  wire        _GEN_249 = _GEN_240 & enq_idxs_7[4];
  wire        _GEN_250 = _GEN_249 | _GEN_212 | _GEN_179 | _GEN_146 | _GEN_113 | _GEN_80 | _GEN_47 | _GEN_14;
  wire        _GEN_251 = _GEN_240 & enq_idxs_7[5];
  wire        _GEN_252 = _GEN_251 | _GEN_213 | _GEN_180 | _GEN_147 | _GEN_114 | _GEN_81 | _GEN_48 | _GEN_15;
  wire        _GEN_253 = _GEN_240 & enq_idxs_7[6];
  wire        _GEN_254 = _GEN_253 | _GEN_214 | _GEN_181 | _GEN_148 | _GEN_115 | _GEN_82 | _GEN_49 | _GEN_16;
  wire        _GEN_255 = _GEN_240 & enq_idxs_7[7];
  wire        _GEN_256 = _GEN_255 | _GEN_215 | _GEN_182 | _GEN_149 | _GEN_116 | _GEN_83 | _GEN_50 | _GEN_17;
  wire        _GEN_257 = _GEN_240 & enq_idxs_7[8];
  wire        _GEN_258 = _GEN_257 | _GEN_216 | _GEN_183 | _GEN_150 | _GEN_117 | _GEN_84 | _GEN_51 | _GEN_18;
  wire        _GEN_259 = _GEN_240 & enq_idxs_7[9];
  wire        _GEN_260 = _GEN_259 | _GEN_217 | _GEN_184 | _GEN_151 | _GEN_118 | _GEN_85 | _GEN_52 | _GEN_19;
  wire        _GEN_261 = _GEN_240 & enq_idxs_7[10];
  wire        _GEN_262 = _GEN_261 | _GEN_218 | _GEN_185 | _GEN_152 | _GEN_119 | _GEN_86 | _GEN_53 | _GEN_20;
  wire        _GEN_263 = _GEN_240 & enq_idxs_7[11];
  wire        _GEN_264 = _GEN_263 | _GEN_219 | _GEN_186 | _GEN_153 | _GEN_120 | _GEN_87 | _GEN_54 | _GEN_21;
  wire        _GEN_265 = _GEN_240 & enq_idxs_7[12];
  wire        _GEN_266 = _GEN_265 | _GEN_220 | _GEN_187 | _GEN_154 | _GEN_121 | _GEN_88 | _GEN_55 | _GEN_22;
  wire        _GEN_267 = _GEN_240 & enq_idxs_7[13];
  wire        _GEN_268 = _GEN_267 | _GEN_221 | _GEN_188 | _GEN_155 | _GEN_122 | _GEN_89 | _GEN_56 | _GEN_23;
  wire        _GEN_269 = _GEN_240 & enq_idxs_7[14];
  wire        _GEN_270 = _GEN_269 | _GEN_222 | _GEN_189 | _GEN_156 | _GEN_123 | _GEN_90 | _GEN_57 | _GEN_24;
  wire        _GEN_271 = _GEN_240 & enq_idxs_7[15];
  wire        _GEN_272 = _GEN_271 | _GEN_223 | _GEN_190 | _GEN_157 | _GEN_124 | _GEN_91 | _GEN_58 | _GEN_25;
  wire        _GEN_273 = _GEN_240 & enq_idxs_7[16];
  wire        _GEN_274 = _GEN_273 | _GEN_224 | _GEN_191 | _GEN_158 | _GEN_125 | _GEN_92 | _GEN_59 | _GEN_26;
  wire        _GEN_275 = _GEN_240 & enq_idxs_7[17];
  wire        _GEN_276 = _GEN_275 | _GEN_225 | _GEN_192 | _GEN_159 | _GEN_126 | _GEN_93 | _GEN_60 | _GEN_27;
  wire        _GEN_277 = _GEN_240 & enq_idxs_7[18];
  wire        _GEN_278 = _GEN_277 | _GEN_226 | _GEN_193 | _GEN_160 | _GEN_127 | _GEN_94 | _GEN_61 | _GEN_28;
  wire        _GEN_279 = _GEN_240 & enq_idxs_7[19];
  wire        _GEN_280 = _GEN_279 | _GEN_227 | _GEN_194 | _GEN_161 | _GEN_128 | _GEN_95 | _GEN_62 | _GEN_29;
  wire        _GEN_281 = _GEN_240 & enq_idxs_7[20];
  wire        _GEN_282 = _GEN_281 | _GEN_228 | _GEN_195 | _GEN_162 | _GEN_129 | _GEN_96 | _GEN_63 | _GEN_30;
  wire        _GEN_283 = _GEN_240 & enq_idxs_7[21];
  wire        _GEN_284 = _GEN_283 | _GEN_229 | _GEN_196 | _GEN_163 | _GEN_130 | _GEN_97 | _GEN_64 | _GEN_31;
  wire        _GEN_285 = _GEN_240 & enq_idxs_7[22];
  wire        _GEN_286 = _GEN_285 | _GEN_230 | _GEN_197 | _GEN_164 | _GEN_131 | _GEN_98 | _GEN_65 | _GEN_32;
  wire        _GEN_287 = _GEN_240 & enq_idxs_7[23];
  wire        _GEN_288 = _GEN_287 | _GEN_231 | _GEN_198 | _GEN_165 | _GEN_132 | _GEN_99 | _GEN_66 | _GEN_33;
  wire        _GEN_289 = _GEN_240 & enq_idxs_7[24];
  wire        _GEN_290 = _GEN_289 | _GEN_232 | _GEN_199 | _GEN_166 | _GEN_133 | _GEN_100 | _GEN_67 | _GEN_34;
  wire        _GEN_291 = _GEN_240 & enq_idxs_7[25];
  wire        _GEN_292 = _GEN_291 | _GEN_233 | _GEN_200 | _GEN_167 | _GEN_134 | _GEN_101 | _GEN_68 | _GEN_35;
  wire        _GEN_293 = _GEN_240 & enq_idxs_7[26];
  wire        _GEN_294 = _GEN_293 | _GEN_234 | _GEN_201 | _GEN_168 | _GEN_135 | _GEN_102 | _GEN_69 | _GEN_36;
  wire        _GEN_295 = _GEN_240 & enq_idxs_7[27];
  wire        _GEN_296 = _GEN_295 | _GEN_235 | _GEN_202 | _GEN_169 | _GEN_136 | _GEN_103 | _GEN_70 | _GEN_37;
  wire        _GEN_297 = _GEN_240 & enq_idxs_7[28];
  wire        _GEN_298 = _GEN_297 | _GEN_236 | _GEN_203 | _GEN_170 | _GEN_137 | _GEN_104 | _GEN_71 | _GEN_38;
  wire        _GEN_299 = _GEN_240 & enq_idxs_7[29];
  wire        _GEN_300 = _GEN_299 | _GEN_237 | _GEN_204 | _GEN_171 | _GEN_138 | _GEN_105 | _GEN_72 | _GEN_39;
  wire        _GEN_301 = _GEN_240 & enq_idxs_7[30];
  wire        _GEN_302 = _GEN_301 | _GEN_238 | _GEN_205 | _GEN_172 | _GEN_139 | _GEN_106 | _GEN_73 | _GEN_40;
  wire        _GEN_303 = _GEN_240 & enq_idxs_7[31];
  wire        _GEN_304 = _GEN_303 | _GEN_239 | _GEN_206 | _GEN_173 | _GEN_140 | _GEN_107 | _GEN_74 | _GEN_41;
  always @(posedge clock) begin
    if (_GEN_241) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_0_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_0_0_pc_lob <= _pc_T_31;
      deq_vec_0_0_taken <= in_uops_7_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_208) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_0_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_0_0_pc_lob <= _pc_T_27;
      deq_vec_0_0_taken <= in_uops_6_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_175) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_0_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_0_0_pc_lob <= _pc_T_23;
      deq_vec_0_0_taken <= in_uops_5_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_142) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_0_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_0_0_pc_lob <= _GEN_4;
      deq_vec_0_0_taken <= in_uops_4_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_109) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_0_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_0_0_pc_lob <= _pc_T_15;
      deq_vec_0_0_taken <= in_uops_3_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_76) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_0_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_0_0_pc_lob <= _pc_T_11;
      deq_vec_0_0_taken <= in_uops_2_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_43) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_0_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_0_0_pc_lob <= _pc_T_7;
      deq_vec_0_0_taken <= in_uops_1_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_10) begin
      deq_vec_0_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_0_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_0_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_0_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_0_0_taken <= in_uops_0_taken;
      deq_vec_0_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_0_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_0_0_ctrl_is_load <= ~_GEN_242 & deq_vec_0_0_ctrl_is_load;
    deq_vec_0_0_ctrl_is_sta <= ~_GEN_242 & deq_vec_0_0_ctrl_is_sta;
    if (_GEN_242) begin
      deq_vec_0_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_0_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_0_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_0_0_edge_inst <= ~(_GEN_241 | _GEN_208 | _GEN_175) & (_GEN_142 ? io_enq_bits_edge_inst_1 : ~(_GEN_109 | _GEN_76 | _GEN_43) & (_GEN_10 ? io_enq_bits_edge_inst_0 : deq_vec_0_0_edge_inst));
    if (_GEN_243) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_0_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_0_1_pc_lob <= _pc_T_31;
      deq_vec_0_1_taken <= in_uops_7_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_209) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_0_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_0_1_pc_lob <= _pc_T_27;
      deq_vec_0_1_taken <= in_uops_6_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_176) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_0_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_0_1_pc_lob <= _pc_T_23;
      deq_vec_0_1_taken <= in_uops_5_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_143) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_0_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_0_1_pc_lob <= _GEN_4;
      deq_vec_0_1_taken <= in_uops_4_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_110) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_0_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_0_1_pc_lob <= _pc_T_15;
      deq_vec_0_1_taken <= in_uops_3_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_77) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_0_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_0_1_pc_lob <= _pc_T_11;
      deq_vec_0_1_taken <= in_uops_2_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_44) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_0_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_0_1_pc_lob <= _pc_T_7;
      deq_vec_0_1_taken <= in_uops_1_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_11) begin
      deq_vec_0_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_0_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_0_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_0_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_0_1_taken <= in_uops_0_taken;
      deq_vec_0_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_0_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_0_1_ctrl_is_load <= ~_GEN_244 & deq_vec_0_1_ctrl_is_load;
    deq_vec_0_1_ctrl_is_sta <= ~_GEN_244 & deq_vec_0_1_ctrl_is_sta;
    if (_GEN_244) begin
      deq_vec_0_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_0_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_0_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_0_1_edge_inst <= ~(_GEN_243 | _GEN_209 | _GEN_176) & (_GEN_143 ? io_enq_bits_edge_inst_1 : ~(_GEN_110 | _GEN_77 | _GEN_44) & (_GEN_11 ? io_enq_bits_edge_inst_0 : deq_vec_0_1_edge_inst));
    if (_GEN_245) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_0_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_0_2_pc_lob <= _pc_T_31;
      deq_vec_0_2_taken <= in_uops_7_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_210) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_0_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_0_2_pc_lob <= _pc_T_27;
      deq_vec_0_2_taken <= in_uops_6_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_177) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_0_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_0_2_pc_lob <= _pc_T_23;
      deq_vec_0_2_taken <= in_uops_5_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_144) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_0_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_0_2_pc_lob <= _GEN_4;
      deq_vec_0_2_taken <= in_uops_4_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_111) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_0_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_0_2_pc_lob <= _pc_T_15;
      deq_vec_0_2_taken <= in_uops_3_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_78) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_0_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_0_2_pc_lob <= _pc_T_11;
      deq_vec_0_2_taken <= in_uops_2_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_45) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_0_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_0_2_pc_lob <= _pc_T_7;
      deq_vec_0_2_taken <= in_uops_1_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_12) begin
      deq_vec_0_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_0_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_0_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_0_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_0_2_taken <= in_uops_0_taken;
      deq_vec_0_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_0_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_0_2_ctrl_is_load <= ~_GEN_246 & deq_vec_0_2_ctrl_is_load;
    deq_vec_0_2_ctrl_is_sta <= ~_GEN_246 & deq_vec_0_2_ctrl_is_sta;
    if (_GEN_246) begin
      deq_vec_0_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_0_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_0_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_0_2_edge_inst <= ~(_GEN_245 | _GEN_210 | _GEN_177) & (_GEN_144 ? io_enq_bits_edge_inst_1 : ~(_GEN_111 | _GEN_78 | _GEN_45) & (_GEN_12 ? io_enq_bits_edge_inst_0 : deq_vec_0_2_edge_inst));
    if (_GEN_247) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_0_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_0_3_pc_lob <= _pc_T_31;
      deq_vec_0_3_taken <= in_uops_7_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_211) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_0_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_0_3_pc_lob <= _pc_T_27;
      deq_vec_0_3_taken <= in_uops_6_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_178) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_0_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_0_3_pc_lob <= _pc_T_23;
      deq_vec_0_3_taken <= in_uops_5_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_145) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_0_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_0_3_pc_lob <= _GEN_4;
      deq_vec_0_3_taken <= in_uops_4_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_112) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_0_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_0_3_pc_lob <= _pc_T_15;
      deq_vec_0_3_taken <= in_uops_3_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_79) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_0_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_0_3_pc_lob <= _pc_T_11;
      deq_vec_0_3_taken <= in_uops_2_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_46) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_0_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_0_3_pc_lob <= _pc_T_7;
      deq_vec_0_3_taken <= in_uops_1_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_13) begin
      deq_vec_0_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_0_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_0_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_0_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_0_3_taken <= in_uops_0_taken;
      deq_vec_0_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_0_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_0_3_ctrl_is_load <= ~_GEN_248 & deq_vec_0_3_ctrl_is_load;
    deq_vec_0_3_ctrl_is_sta <= ~_GEN_248 & deq_vec_0_3_ctrl_is_sta;
    if (_GEN_248) begin
      deq_vec_0_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_0_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_0_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_0_3_edge_inst <= ~(_GEN_247 | _GEN_211 | _GEN_178) & (_GEN_145 ? io_enq_bits_edge_inst_1 : ~(_GEN_112 | _GEN_79 | _GEN_46) & (_GEN_13 ? io_enq_bits_edge_inst_0 : deq_vec_0_3_edge_inst));
    if (_GEN_249) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_1_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_1_0_pc_lob <= _pc_T_31;
      deq_vec_1_0_taken <= in_uops_7_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_212) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_1_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_1_0_pc_lob <= _pc_T_27;
      deq_vec_1_0_taken <= in_uops_6_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_179) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_1_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_1_0_pc_lob <= _pc_T_23;
      deq_vec_1_0_taken <= in_uops_5_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_146) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_1_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_1_0_pc_lob <= _GEN_4;
      deq_vec_1_0_taken <= in_uops_4_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_113) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_1_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_1_0_pc_lob <= _pc_T_15;
      deq_vec_1_0_taken <= in_uops_3_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_80) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_1_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_1_0_pc_lob <= _pc_T_11;
      deq_vec_1_0_taken <= in_uops_2_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_47) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_1_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_1_0_pc_lob <= _pc_T_7;
      deq_vec_1_0_taken <= in_uops_1_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_14) begin
      deq_vec_1_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_1_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_1_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_1_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_1_0_taken <= in_uops_0_taken;
      deq_vec_1_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_1_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_1_0_ctrl_is_load <= ~_GEN_250 & deq_vec_1_0_ctrl_is_load;
    deq_vec_1_0_ctrl_is_sta <= ~_GEN_250 & deq_vec_1_0_ctrl_is_sta;
    if (_GEN_250) begin
      deq_vec_1_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_1_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_1_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_1_0_edge_inst <= ~(_GEN_249 | _GEN_212 | _GEN_179) & (_GEN_146 ? io_enq_bits_edge_inst_1 : ~(_GEN_113 | _GEN_80 | _GEN_47) & (_GEN_14 ? io_enq_bits_edge_inst_0 : deq_vec_1_0_edge_inst));
    if (_GEN_251) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_1_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_1_1_pc_lob <= _pc_T_31;
      deq_vec_1_1_taken <= in_uops_7_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_213) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_1_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_1_1_pc_lob <= _pc_T_27;
      deq_vec_1_1_taken <= in_uops_6_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_180) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_1_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_1_1_pc_lob <= _pc_T_23;
      deq_vec_1_1_taken <= in_uops_5_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_147) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_1_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_1_1_pc_lob <= _GEN_4;
      deq_vec_1_1_taken <= in_uops_4_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_114) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_1_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_1_1_pc_lob <= _pc_T_15;
      deq_vec_1_1_taken <= in_uops_3_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_81) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_1_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_1_1_pc_lob <= _pc_T_11;
      deq_vec_1_1_taken <= in_uops_2_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_48) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_1_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_1_1_pc_lob <= _pc_T_7;
      deq_vec_1_1_taken <= in_uops_1_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_15) begin
      deq_vec_1_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_1_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_1_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_1_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_1_1_taken <= in_uops_0_taken;
      deq_vec_1_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_1_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_1_1_ctrl_is_load <= ~_GEN_252 & deq_vec_1_1_ctrl_is_load;
    deq_vec_1_1_ctrl_is_sta <= ~_GEN_252 & deq_vec_1_1_ctrl_is_sta;
    if (_GEN_252) begin
      deq_vec_1_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_1_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_1_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_1_1_edge_inst <= ~(_GEN_251 | _GEN_213 | _GEN_180) & (_GEN_147 ? io_enq_bits_edge_inst_1 : ~(_GEN_114 | _GEN_81 | _GEN_48) & (_GEN_15 ? io_enq_bits_edge_inst_0 : deq_vec_1_1_edge_inst));
    if (_GEN_253) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_1_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_1_2_pc_lob <= _pc_T_31;
      deq_vec_1_2_taken <= in_uops_7_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_214) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_1_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_1_2_pc_lob <= _pc_T_27;
      deq_vec_1_2_taken <= in_uops_6_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_181) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_1_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_1_2_pc_lob <= _pc_T_23;
      deq_vec_1_2_taken <= in_uops_5_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_148) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_1_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_1_2_pc_lob <= _GEN_4;
      deq_vec_1_2_taken <= in_uops_4_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_115) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_1_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_1_2_pc_lob <= _pc_T_15;
      deq_vec_1_2_taken <= in_uops_3_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_82) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_1_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_1_2_pc_lob <= _pc_T_11;
      deq_vec_1_2_taken <= in_uops_2_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_49) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_1_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_1_2_pc_lob <= _pc_T_7;
      deq_vec_1_2_taken <= in_uops_1_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_16) begin
      deq_vec_1_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_1_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_1_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_1_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_1_2_taken <= in_uops_0_taken;
      deq_vec_1_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_1_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_1_2_ctrl_is_load <= ~_GEN_254 & deq_vec_1_2_ctrl_is_load;
    deq_vec_1_2_ctrl_is_sta <= ~_GEN_254 & deq_vec_1_2_ctrl_is_sta;
    if (_GEN_254) begin
      deq_vec_1_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_1_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_1_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_1_2_edge_inst <= ~(_GEN_253 | _GEN_214 | _GEN_181) & (_GEN_148 ? io_enq_bits_edge_inst_1 : ~(_GEN_115 | _GEN_82 | _GEN_49) & (_GEN_16 ? io_enq_bits_edge_inst_0 : deq_vec_1_2_edge_inst));
    if (_GEN_255) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_1_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_1_3_pc_lob <= _pc_T_31;
      deq_vec_1_3_taken <= in_uops_7_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_215) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_1_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_1_3_pc_lob <= _pc_T_27;
      deq_vec_1_3_taken <= in_uops_6_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_182) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_1_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_1_3_pc_lob <= _pc_T_23;
      deq_vec_1_3_taken <= in_uops_5_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_149) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_1_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_1_3_pc_lob <= _GEN_4;
      deq_vec_1_3_taken <= in_uops_4_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_116) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_1_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_1_3_pc_lob <= _pc_T_15;
      deq_vec_1_3_taken <= in_uops_3_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_83) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_1_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_1_3_pc_lob <= _pc_T_11;
      deq_vec_1_3_taken <= in_uops_2_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_50) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_1_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_1_3_pc_lob <= _pc_T_7;
      deq_vec_1_3_taken <= in_uops_1_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_17) begin
      deq_vec_1_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_1_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_1_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_1_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_1_3_taken <= in_uops_0_taken;
      deq_vec_1_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_1_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_1_3_ctrl_is_load <= ~_GEN_256 & deq_vec_1_3_ctrl_is_load;
    deq_vec_1_3_ctrl_is_sta <= ~_GEN_256 & deq_vec_1_3_ctrl_is_sta;
    if (_GEN_256) begin
      deq_vec_1_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_1_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_1_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_1_3_edge_inst <= ~(_GEN_255 | _GEN_215 | _GEN_182) & (_GEN_149 ? io_enq_bits_edge_inst_1 : ~(_GEN_116 | _GEN_83 | _GEN_50) & (_GEN_17 ? io_enq_bits_edge_inst_0 : deq_vec_1_3_edge_inst));
    if (_GEN_257) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_2_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_2_0_pc_lob <= _pc_T_31;
      deq_vec_2_0_taken <= in_uops_7_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_216) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_2_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_2_0_pc_lob <= _pc_T_27;
      deq_vec_2_0_taken <= in_uops_6_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_183) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_2_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_2_0_pc_lob <= _pc_T_23;
      deq_vec_2_0_taken <= in_uops_5_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_150) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_2_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_2_0_pc_lob <= _GEN_4;
      deq_vec_2_0_taken <= in_uops_4_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_117) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_2_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_2_0_pc_lob <= _pc_T_15;
      deq_vec_2_0_taken <= in_uops_3_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_84) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_2_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_2_0_pc_lob <= _pc_T_11;
      deq_vec_2_0_taken <= in_uops_2_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_51) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_2_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_2_0_pc_lob <= _pc_T_7;
      deq_vec_2_0_taken <= in_uops_1_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_18) begin
      deq_vec_2_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_2_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_2_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_2_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_2_0_taken <= in_uops_0_taken;
      deq_vec_2_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_2_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_2_0_ctrl_is_load <= ~_GEN_258 & deq_vec_2_0_ctrl_is_load;
    deq_vec_2_0_ctrl_is_sta <= ~_GEN_258 & deq_vec_2_0_ctrl_is_sta;
    if (_GEN_258) begin
      deq_vec_2_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_2_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_2_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_2_0_edge_inst <= ~(_GEN_257 | _GEN_216 | _GEN_183) & (_GEN_150 ? io_enq_bits_edge_inst_1 : ~(_GEN_117 | _GEN_84 | _GEN_51) & (_GEN_18 ? io_enq_bits_edge_inst_0 : deq_vec_2_0_edge_inst));
    if (_GEN_259) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_2_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_2_1_pc_lob <= _pc_T_31;
      deq_vec_2_1_taken <= in_uops_7_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_217) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_2_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_2_1_pc_lob <= _pc_T_27;
      deq_vec_2_1_taken <= in_uops_6_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_184) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_2_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_2_1_pc_lob <= _pc_T_23;
      deq_vec_2_1_taken <= in_uops_5_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_151) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_2_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_2_1_pc_lob <= _GEN_4;
      deq_vec_2_1_taken <= in_uops_4_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_118) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_2_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_2_1_pc_lob <= _pc_T_15;
      deq_vec_2_1_taken <= in_uops_3_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_85) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_2_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_2_1_pc_lob <= _pc_T_11;
      deq_vec_2_1_taken <= in_uops_2_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_52) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_2_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_2_1_pc_lob <= _pc_T_7;
      deq_vec_2_1_taken <= in_uops_1_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_19) begin
      deq_vec_2_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_2_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_2_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_2_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_2_1_taken <= in_uops_0_taken;
      deq_vec_2_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_2_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_2_1_ctrl_is_load <= ~_GEN_260 & deq_vec_2_1_ctrl_is_load;
    deq_vec_2_1_ctrl_is_sta <= ~_GEN_260 & deq_vec_2_1_ctrl_is_sta;
    if (_GEN_260) begin
      deq_vec_2_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_2_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_2_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_2_1_edge_inst <= ~(_GEN_259 | _GEN_217 | _GEN_184) & (_GEN_151 ? io_enq_bits_edge_inst_1 : ~(_GEN_118 | _GEN_85 | _GEN_52) & (_GEN_19 ? io_enq_bits_edge_inst_0 : deq_vec_2_1_edge_inst));
    if (_GEN_261) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_2_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_2_2_pc_lob <= _pc_T_31;
      deq_vec_2_2_taken <= in_uops_7_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_218) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_2_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_2_2_pc_lob <= _pc_T_27;
      deq_vec_2_2_taken <= in_uops_6_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_185) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_2_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_2_2_pc_lob <= _pc_T_23;
      deq_vec_2_2_taken <= in_uops_5_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_152) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_2_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_2_2_pc_lob <= _GEN_4;
      deq_vec_2_2_taken <= in_uops_4_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_119) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_2_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_2_2_pc_lob <= _pc_T_15;
      deq_vec_2_2_taken <= in_uops_3_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_86) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_2_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_2_2_pc_lob <= _pc_T_11;
      deq_vec_2_2_taken <= in_uops_2_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_53) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_2_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_2_2_pc_lob <= _pc_T_7;
      deq_vec_2_2_taken <= in_uops_1_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_20) begin
      deq_vec_2_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_2_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_2_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_2_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_2_2_taken <= in_uops_0_taken;
      deq_vec_2_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_2_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_2_2_ctrl_is_load <= ~_GEN_262 & deq_vec_2_2_ctrl_is_load;
    deq_vec_2_2_ctrl_is_sta <= ~_GEN_262 & deq_vec_2_2_ctrl_is_sta;
    if (_GEN_262) begin
      deq_vec_2_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_2_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_2_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_2_2_edge_inst <= ~(_GEN_261 | _GEN_218 | _GEN_185) & (_GEN_152 ? io_enq_bits_edge_inst_1 : ~(_GEN_119 | _GEN_86 | _GEN_53) & (_GEN_20 ? io_enq_bits_edge_inst_0 : deq_vec_2_2_edge_inst));
    if (_GEN_263) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_2_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_2_3_pc_lob <= _pc_T_31;
      deq_vec_2_3_taken <= in_uops_7_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_219) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_2_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_2_3_pc_lob <= _pc_T_27;
      deq_vec_2_3_taken <= in_uops_6_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_186) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_2_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_2_3_pc_lob <= _pc_T_23;
      deq_vec_2_3_taken <= in_uops_5_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_153) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_2_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_2_3_pc_lob <= _GEN_4;
      deq_vec_2_3_taken <= in_uops_4_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_120) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_2_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_2_3_pc_lob <= _pc_T_15;
      deq_vec_2_3_taken <= in_uops_3_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_87) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_2_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_2_3_pc_lob <= _pc_T_11;
      deq_vec_2_3_taken <= in_uops_2_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_54) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_2_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_2_3_pc_lob <= _pc_T_7;
      deq_vec_2_3_taken <= in_uops_1_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_21) begin
      deq_vec_2_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_2_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_2_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_2_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_2_3_taken <= in_uops_0_taken;
      deq_vec_2_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_2_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_2_3_ctrl_is_load <= ~_GEN_264 & deq_vec_2_3_ctrl_is_load;
    deq_vec_2_3_ctrl_is_sta <= ~_GEN_264 & deq_vec_2_3_ctrl_is_sta;
    if (_GEN_264) begin
      deq_vec_2_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_2_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_2_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_2_3_edge_inst <= ~(_GEN_263 | _GEN_219 | _GEN_186) & (_GEN_153 ? io_enq_bits_edge_inst_1 : ~(_GEN_120 | _GEN_87 | _GEN_54) & (_GEN_21 ? io_enq_bits_edge_inst_0 : deq_vec_2_3_edge_inst));
    if (_GEN_265) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_3_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_3_0_pc_lob <= _pc_T_31;
      deq_vec_3_0_taken <= in_uops_7_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_220) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_3_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_3_0_pc_lob <= _pc_T_27;
      deq_vec_3_0_taken <= in_uops_6_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_187) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_3_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_3_0_pc_lob <= _pc_T_23;
      deq_vec_3_0_taken <= in_uops_5_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_154) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_3_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_3_0_pc_lob <= _GEN_4;
      deq_vec_3_0_taken <= in_uops_4_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_121) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_3_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_3_0_pc_lob <= _pc_T_15;
      deq_vec_3_0_taken <= in_uops_3_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_88) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_3_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_3_0_pc_lob <= _pc_T_11;
      deq_vec_3_0_taken <= in_uops_2_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_55) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_3_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_3_0_pc_lob <= _pc_T_7;
      deq_vec_3_0_taken <= in_uops_1_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_22) begin
      deq_vec_3_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_3_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_3_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_3_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_3_0_taken <= in_uops_0_taken;
      deq_vec_3_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_3_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_3_0_ctrl_is_load <= ~_GEN_266 & deq_vec_3_0_ctrl_is_load;
    deq_vec_3_0_ctrl_is_sta <= ~_GEN_266 & deq_vec_3_0_ctrl_is_sta;
    if (_GEN_266) begin
      deq_vec_3_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_3_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_3_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_3_0_edge_inst <= ~(_GEN_265 | _GEN_220 | _GEN_187) & (_GEN_154 ? io_enq_bits_edge_inst_1 : ~(_GEN_121 | _GEN_88 | _GEN_55) & (_GEN_22 ? io_enq_bits_edge_inst_0 : deq_vec_3_0_edge_inst));
    if (_GEN_267) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_3_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_3_1_pc_lob <= _pc_T_31;
      deq_vec_3_1_taken <= in_uops_7_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_221) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_3_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_3_1_pc_lob <= _pc_T_27;
      deq_vec_3_1_taken <= in_uops_6_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_188) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_3_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_3_1_pc_lob <= _pc_T_23;
      deq_vec_3_1_taken <= in_uops_5_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_155) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_3_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_3_1_pc_lob <= _GEN_4;
      deq_vec_3_1_taken <= in_uops_4_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_122) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_3_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_3_1_pc_lob <= _pc_T_15;
      deq_vec_3_1_taken <= in_uops_3_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_89) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_3_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_3_1_pc_lob <= _pc_T_11;
      deq_vec_3_1_taken <= in_uops_2_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_56) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_3_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_3_1_pc_lob <= _pc_T_7;
      deq_vec_3_1_taken <= in_uops_1_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_23) begin
      deq_vec_3_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_3_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_3_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_3_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_3_1_taken <= in_uops_0_taken;
      deq_vec_3_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_3_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_3_1_ctrl_is_load <= ~_GEN_268 & deq_vec_3_1_ctrl_is_load;
    deq_vec_3_1_ctrl_is_sta <= ~_GEN_268 & deq_vec_3_1_ctrl_is_sta;
    if (_GEN_268) begin
      deq_vec_3_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_3_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_3_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_3_1_edge_inst <= ~(_GEN_267 | _GEN_221 | _GEN_188) & (_GEN_155 ? io_enq_bits_edge_inst_1 : ~(_GEN_122 | _GEN_89 | _GEN_56) & (_GEN_23 ? io_enq_bits_edge_inst_0 : deq_vec_3_1_edge_inst));
    if (_GEN_269) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_3_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_3_2_pc_lob <= _pc_T_31;
      deq_vec_3_2_taken <= in_uops_7_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_222) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_3_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_3_2_pc_lob <= _pc_T_27;
      deq_vec_3_2_taken <= in_uops_6_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_189) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_3_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_3_2_pc_lob <= _pc_T_23;
      deq_vec_3_2_taken <= in_uops_5_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_156) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_3_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_3_2_pc_lob <= _GEN_4;
      deq_vec_3_2_taken <= in_uops_4_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_123) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_3_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_3_2_pc_lob <= _pc_T_15;
      deq_vec_3_2_taken <= in_uops_3_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_90) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_3_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_3_2_pc_lob <= _pc_T_11;
      deq_vec_3_2_taken <= in_uops_2_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_57) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_3_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_3_2_pc_lob <= _pc_T_7;
      deq_vec_3_2_taken <= in_uops_1_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_24) begin
      deq_vec_3_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_3_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_3_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_3_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_3_2_taken <= in_uops_0_taken;
      deq_vec_3_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_3_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_3_2_ctrl_is_load <= ~_GEN_270 & deq_vec_3_2_ctrl_is_load;
    deq_vec_3_2_ctrl_is_sta <= ~_GEN_270 & deq_vec_3_2_ctrl_is_sta;
    if (_GEN_270) begin
      deq_vec_3_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_3_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_3_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_3_2_edge_inst <= ~(_GEN_269 | _GEN_222 | _GEN_189) & (_GEN_156 ? io_enq_bits_edge_inst_1 : ~(_GEN_123 | _GEN_90 | _GEN_57) & (_GEN_24 ? io_enq_bits_edge_inst_0 : deq_vec_3_2_edge_inst));
    if (_GEN_271) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_3_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_3_3_pc_lob <= _pc_T_31;
      deq_vec_3_3_taken <= in_uops_7_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_223) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_3_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_3_3_pc_lob <= _pc_T_27;
      deq_vec_3_3_taken <= in_uops_6_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_190) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_3_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_3_3_pc_lob <= _pc_T_23;
      deq_vec_3_3_taken <= in_uops_5_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_157) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_3_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_3_3_pc_lob <= _GEN_4;
      deq_vec_3_3_taken <= in_uops_4_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_124) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_3_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_3_3_pc_lob <= _pc_T_15;
      deq_vec_3_3_taken <= in_uops_3_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_91) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_3_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_3_3_pc_lob <= _pc_T_11;
      deq_vec_3_3_taken <= in_uops_2_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_58) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_3_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_3_3_pc_lob <= _pc_T_7;
      deq_vec_3_3_taken <= in_uops_1_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_25) begin
      deq_vec_3_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_3_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_3_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_3_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_3_3_taken <= in_uops_0_taken;
      deq_vec_3_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_3_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_3_3_ctrl_is_load <= ~_GEN_272 & deq_vec_3_3_ctrl_is_load;
    deq_vec_3_3_ctrl_is_sta <= ~_GEN_272 & deq_vec_3_3_ctrl_is_sta;
    if (_GEN_272) begin
      deq_vec_3_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_3_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_3_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_3_3_edge_inst <= ~(_GEN_271 | _GEN_223 | _GEN_190) & (_GEN_157 ? io_enq_bits_edge_inst_1 : ~(_GEN_124 | _GEN_91 | _GEN_58) & (_GEN_25 ? io_enq_bits_edge_inst_0 : deq_vec_3_3_edge_inst));
    if (_GEN_273) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_4_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_4_0_pc_lob <= _pc_T_31;
      deq_vec_4_0_taken <= in_uops_7_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_224) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_4_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_4_0_pc_lob <= _pc_T_27;
      deq_vec_4_0_taken <= in_uops_6_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_191) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_4_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_4_0_pc_lob <= _pc_T_23;
      deq_vec_4_0_taken <= in_uops_5_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_158) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_4_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_4_0_pc_lob <= _GEN_4;
      deq_vec_4_0_taken <= in_uops_4_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_125) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_4_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_4_0_pc_lob <= _pc_T_15;
      deq_vec_4_0_taken <= in_uops_3_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_92) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_4_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_4_0_pc_lob <= _pc_T_11;
      deq_vec_4_0_taken <= in_uops_2_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_59) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_4_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_4_0_pc_lob <= _pc_T_7;
      deq_vec_4_0_taken <= in_uops_1_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_26) begin
      deq_vec_4_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_4_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_4_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_4_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_4_0_taken <= in_uops_0_taken;
      deq_vec_4_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_4_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_4_0_ctrl_is_load <= ~_GEN_274 & deq_vec_4_0_ctrl_is_load;
    deq_vec_4_0_ctrl_is_sta <= ~_GEN_274 & deq_vec_4_0_ctrl_is_sta;
    if (_GEN_274) begin
      deq_vec_4_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_4_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_4_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_4_0_edge_inst <= ~(_GEN_273 | _GEN_224 | _GEN_191) & (_GEN_158 ? io_enq_bits_edge_inst_1 : ~(_GEN_125 | _GEN_92 | _GEN_59) & (_GEN_26 ? io_enq_bits_edge_inst_0 : deq_vec_4_0_edge_inst));
    if (_GEN_275) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_4_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_4_1_pc_lob <= _pc_T_31;
      deq_vec_4_1_taken <= in_uops_7_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_225) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_4_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_4_1_pc_lob <= _pc_T_27;
      deq_vec_4_1_taken <= in_uops_6_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_192) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_4_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_4_1_pc_lob <= _pc_T_23;
      deq_vec_4_1_taken <= in_uops_5_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_159) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_4_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_4_1_pc_lob <= _GEN_4;
      deq_vec_4_1_taken <= in_uops_4_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_126) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_4_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_4_1_pc_lob <= _pc_T_15;
      deq_vec_4_1_taken <= in_uops_3_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_93) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_4_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_4_1_pc_lob <= _pc_T_11;
      deq_vec_4_1_taken <= in_uops_2_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_60) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_4_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_4_1_pc_lob <= _pc_T_7;
      deq_vec_4_1_taken <= in_uops_1_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_27) begin
      deq_vec_4_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_4_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_4_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_4_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_4_1_taken <= in_uops_0_taken;
      deq_vec_4_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_4_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_4_1_ctrl_is_load <= ~_GEN_276 & deq_vec_4_1_ctrl_is_load;
    deq_vec_4_1_ctrl_is_sta <= ~_GEN_276 & deq_vec_4_1_ctrl_is_sta;
    if (_GEN_276) begin
      deq_vec_4_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_4_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_4_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_4_1_edge_inst <= ~(_GEN_275 | _GEN_225 | _GEN_192) & (_GEN_159 ? io_enq_bits_edge_inst_1 : ~(_GEN_126 | _GEN_93 | _GEN_60) & (_GEN_27 ? io_enq_bits_edge_inst_0 : deq_vec_4_1_edge_inst));
    if (_GEN_277) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_4_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_4_2_pc_lob <= _pc_T_31;
      deq_vec_4_2_taken <= in_uops_7_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_226) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_4_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_4_2_pc_lob <= _pc_T_27;
      deq_vec_4_2_taken <= in_uops_6_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_193) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_4_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_4_2_pc_lob <= _pc_T_23;
      deq_vec_4_2_taken <= in_uops_5_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_160) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_4_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_4_2_pc_lob <= _GEN_4;
      deq_vec_4_2_taken <= in_uops_4_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_127) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_4_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_4_2_pc_lob <= _pc_T_15;
      deq_vec_4_2_taken <= in_uops_3_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_94) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_4_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_4_2_pc_lob <= _pc_T_11;
      deq_vec_4_2_taken <= in_uops_2_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_61) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_4_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_4_2_pc_lob <= _pc_T_7;
      deq_vec_4_2_taken <= in_uops_1_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_28) begin
      deq_vec_4_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_4_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_4_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_4_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_4_2_taken <= in_uops_0_taken;
      deq_vec_4_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_4_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_4_2_ctrl_is_load <= ~_GEN_278 & deq_vec_4_2_ctrl_is_load;
    deq_vec_4_2_ctrl_is_sta <= ~_GEN_278 & deq_vec_4_2_ctrl_is_sta;
    if (_GEN_278) begin
      deq_vec_4_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_4_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_4_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_4_2_edge_inst <= ~(_GEN_277 | _GEN_226 | _GEN_193) & (_GEN_160 ? io_enq_bits_edge_inst_1 : ~(_GEN_127 | _GEN_94 | _GEN_61) & (_GEN_28 ? io_enq_bits_edge_inst_0 : deq_vec_4_2_edge_inst));
    if (_GEN_279) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_4_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_4_3_pc_lob <= _pc_T_31;
      deq_vec_4_3_taken <= in_uops_7_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_227) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_4_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_4_3_pc_lob <= _pc_T_27;
      deq_vec_4_3_taken <= in_uops_6_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_194) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_4_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_4_3_pc_lob <= _pc_T_23;
      deq_vec_4_3_taken <= in_uops_5_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_161) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_4_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_4_3_pc_lob <= _GEN_4;
      deq_vec_4_3_taken <= in_uops_4_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_128) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_4_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_4_3_pc_lob <= _pc_T_15;
      deq_vec_4_3_taken <= in_uops_3_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_95) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_4_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_4_3_pc_lob <= _pc_T_11;
      deq_vec_4_3_taken <= in_uops_2_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_62) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_4_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_4_3_pc_lob <= _pc_T_7;
      deq_vec_4_3_taken <= in_uops_1_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_29) begin
      deq_vec_4_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_4_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_4_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_4_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_4_3_taken <= in_uops_0_taken;
      deq_vec_4_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_4_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_4_3_ctrl_is_load <= ~_GEN_280 & deq_vec_4_3_ctrl_is_load;
    deq_vec_4_3_ctrl_is_sta <= ~_GEN_280 & deq_vec_4_3_ctrl_is_sta;
    if (_GEN_280) begin
      deq_vec_4_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_4_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_4_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_4_3_edge_inst <= ~(_GEN_279 | _GEN_227 | _GEN_194) & (_GEN_161 ? io_enq_bits_edge_inst_1 : ~(_GEN_128 | _GEN_95 | _GEN_62) & (_GEN_29 ? io_enq_bits_edge_inst_0 : deq_vec_4_3_edge_inst));
    if (_GEN_281) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_5_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_5_0_pc_lob <= _pc_T_31;
      deq_vec_5_0_taken <= in_uops_7_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_228) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_5_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_5_0_pc_lob <= _pc_T_27;
      deq_vec_5_0_taken <= in_uops_6_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_195) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_5_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_5_0_pc_lob <= _pc_T_23;
      deq_vec_5_0_taken <= in_uops_5_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_162) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_5_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_5_0_pc_lob <= _GEN_4;
      deq_vec_5_0_taken <= in_uops_4_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_129) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_5_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_5_0_pc_lob <= _pc_T_15;
      deq_vec_5_0_taken <= in_uops_3_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_96) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_5_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_5_0_pc_lob <= _pc_T_11;
      deq_vec_5_0_taken <= in_uops_2_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_63) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_5_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_5_0_pc_lob <= _pc_T_7;
      deq_vec_5_0_taken <= in_uops_1_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_30) begin
      deq_vec_5_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_5_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_5_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_5_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_5_0_taken <= in_uops_0_taken;
      deq_vec_5_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_5_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_5_0_ctrl_is_load <= ~_GEN_282 & deq_vec_5_0_ctrl_is_load;
    deq_vec_5_0_ctrl_is_sta <= ~_GEN_282 & deq_vec_5_0_ctrl_is_sta;
    if (_GEN_282) begin
      deq_vec_5_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_5_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_5_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_5_0_edge_inst <= ~(_GEN_281 | _GEN_228 | _GEN_195) & (_GEN_162 ? io_enq_bits_edge_inst_1 : ~(_GEN_129 | _GEN_96 | _GEN_63) & (_GEN_30 ? io_enq_bits_edge_inst_0 : deq_vec_5_0_edge_inst));
    if (_GEN_283) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_5_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_5_1_pc_lob <= _pc_T_31;
      deq_vec_5_1_taken <= in_uops_7_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_229) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_5_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_5_1_pc_lob <= _pc_T_27;
      deq_vec_5_1_taken <= in_uops_6_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_196) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_5_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_5_1_pc_lob <= _pc_T_23;
      deq_vec_5_1_taken <= in_uops_5_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_163) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_5_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_5_1_pc_lob <= _GEN_4;
      deq_vec_5_1_taken <= in_uops_4_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_130) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_5_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_5_1_pc_lob <= _pc_T_15;
      deq_vec_5_1_taken <= in_uops_3_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_97) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_5_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_5_1_pc_lob <= _pc_T_11;
      deq_vec_5_1_taken <= in_uops_2_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_64) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_5_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_5_1_pc_lob <= _pc_T_7;
      deq_vec_5_1_taken <= in_uops_1_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_31) begin
      deq_vec_5_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_5_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_5_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_5_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_5_1_taken <= in_uops_0_taken;
      deq_vec_5_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_5_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_5_1_ctrl_is_load <= ~_GEN_284 & deq_vec_5_1_ctrl_is_load;
    deq_vec_5_1_ctrl_is_sta <= ~_GEN_284 & deq_vec_5_1_ctrl_is_sta;
    if (_GEN_284) begin
      deq_vec_5_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_5_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_5_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_5_1_edge_inst <= ~(_GEN_283 | _GEN_229 | _GEN_196) & (_GEN_163 ? io_enq_bits_edge_inst_1 : ~(_GEN_130 | _GEN_97 | _GEN_64) & (_GEN_31 ? io_enq_bits_edge_inst_0 : deq_vec_5_1_edge_inst));
    if (_GEN_285) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_5_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_5_2_pc_lob <= _pc_T_31;
      deq_vec_5_2_taken <= in_uops_7_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_230) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_5_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_5_2_pc_lob <= _pc_T_27;
      deq_vec_5_2_taken <= in_uops_6_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_197) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_5_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_5_2_pc_lob <= _pc_T_23;
      deq_vec_5_2_taken <= in_uops_5_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_164) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_5_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_5_2_pc_lob <= _GEN_4;
      deq_vec_5_2_taken <= in_uops_4_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_131) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_5_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_5_2_pc_lob <= _pc_T_15;
      deq_vec_5_2_taken <= in_uops_3_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_98) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_5_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_5_2_pc_lob <= _pc_T_11;
      deq_vec_5_2_taken <= in_uops_2_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_65) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_5_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_5_2_pc_lob <= _pc_T_7;
      deq_vec_5_2_taken <= in_uops_1_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_32) begin
      deq_vec_5_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_5_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_5_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_5_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_5_2_taken <= in_uops_0_taken;
      deq_vec_5_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_5_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_5_2_ctrl_is_load <= ~_GEN_286 & deq_vec_5_2_ctrl_is_load;
    deq_vec_5_2_ctrl_is_sta <= ~_GEN_286 & deq_vec_5_2_ctrl_is_sta;
    if (_GEN_286) begin
      deq_vec_5_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_5_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_5_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_5_2_edge_inst <= ~(_GEN_285 | _GEN_230 | _GEN_197) & (_GEN_164 ? io_enq_bits_edge_inst_1 : ~(_GEN_131 | _GEN_98 | _GEN_65) & (_GEN_32 ? io_enq_bits_edge_inst_0 : deq_vec_5_2_edge_inst));
    if (_GEN_287) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_5_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_5_3_pc_lob <= _pc_T_31;
      deq_vec_5_3_taken <= in_uops_7_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_231) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_5_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_5_3_pc_lob <= _pc_T_27;
      deq_vec_5_3_taken <= in_uops_6_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_198) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_5_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_5_3_pc_lob <= _pc_T_23;
      deq_vec_5_3_taken <= in_uops_5_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_165) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_5_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_5_3_pc_lob <= _GEN_4;
      deq_vec_5_3_taken <= in_uops_4_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_132) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_5_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_5_3_pc_lob <= _pc_T_15;
      deq_vec_5_3_taken <= in_uops_3_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_99) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_5_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_5_3_pc_lob <= _pc_T_11;
      deq_vec_5_3_taken <= in_uops_2_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_66) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_5_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_5_3_pc_lob <= _pc_T_7;
      deq_vec_5_3_taken <= in_uops_1_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_33) begin
      deq_vec_5_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_5_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_5_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_5_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_5_3_taken <= in_uops_0_taken;
      deq_vec_5_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_5_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_5_3_ctrl_is_load <= ~_GEN_288 & deq_vec_5_3_ctrl_is_load;
    deq_vec_5_3_ctrl_is_sta <= ~_GEN_288 & deq_vec_5_3_ctrl_is_sta;
    if (_GEN_288) begin
      deq_vec_5_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_5_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_5_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_5_3_edge_inst <= ~(_GEN_287 | _GEN_231 | _GEN_198) & (_GEN_165 ? io_enq_bits_edge_inst_1 : ~(_GEN_132 | _GEN_99 | _GEN_66) & (_GEN_33 ? io_enq_bits_edge_inst_0 : deq_vec_5_3_edge_inst));
    if (_GEN_289) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_6_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_6_0_pc_lob <= _pc_T_31;
      deq_vec_6_0_taken <= in_uops_7_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_232) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_6_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_6_0_pc_lob <= _pc_T_27;
      deq_vec_6_0_taken <= in_uops_6_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_199) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_6_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_6_0_pc_lob <= _pc_T_23;
      deq_vec_6_0_taken <= in_uops_5_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_166) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_6_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_6_0_pc_lob <= _GEN_4;
      deq_vec_6_0_taken <= in_uops_4_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_133) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_6_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_6_0_pc_lob <= _pc_T_15;
      deq_vec_6_0_taken <= in_uops_3_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_100) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_6_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_6_0_pc_lob <= _pc_T_11;
      deq_vec_6_0_taken <= in_uops_2_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_67) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_6_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_6_0_pc_lob <= _pc_T_7;
      deq_vec_6_0_taken <= in_uops_1_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_34) begin
      deq_vec_6_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_6_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_6_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_6_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_6_0_taken <= in_uops_0_taken;
      deq_vec_6_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_6_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_6_0_ctrl_is_load <= ~_GEN_290 & deq_vec_6_0_ctrl_is_load;
    deq_vec_6_0_ctrl_is_sta <= ~_GEN_290 & deq_vec_6_0_ctrl_is_sta;
    if (_GEN_290) begin
      deq_vec_6_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_6_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_6_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_6_0_edge_inst <= ~(_GEN_289 | _GEN_232 | _GEN_199) & (_GEN_166 ? io_enq_bits_edge_inst_1 : ~(_GEN_133 | _GEN_100 | _GEN_67) & (_GEN_34 ? io_enq_bits_edge_inst_0 : deq_vec_6_0_edge_inst));
    if (_GEN_291) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_6_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_6_1_pc_lob <= _pc_T_31;
      deq_vec_6_1_taken <= in_uops_7_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_233) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_6_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_6_1_pc_lob <= _pc_T_27;
      deq_vec_6_1_taken <= in_uops_6_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_200) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_6_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_6_1_pc_lob <= _pc_T_23;
      deq_vec_6_1_taken <= in_uops_5_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_167) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_6_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_6_1_pc_lob <= _GEN_4;
      deq_vec_6_1_taken <= in_uops_4_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_134) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_6_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_6_1_pc_lob <= _pc_T_15;
      deq_vec_6_1_taken <= in_uops_3_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_101) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_6_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_6_1_pc_lob <= _pc_T_11;
      deq_vec_6_1_taken <= in_uops_2_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_68) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_6_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_6_1_pc_lob <= _pc_T_7;
      deq_vec_6_1_taken <= in_uops_1_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_35) begin
      deq_vec_6_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_6_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_6_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_6_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_6_1_taken <= in_uops_0_taken;
      deq_vec_6_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_6_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_6_1_ctrl_is_load <= ~_GEN_292 & deq_vec_6_1_ctrl_is_load;
    deq_vec_6_1_ctrl_is_sta <= ~_GEN_292 & deq_vec_6_1_ctrl_is_sta;
    if (_GEN_292) begin
      deq_vec_6_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_6_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_6_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_6_1_edge_inst <= ~(_GEN_291 | _GEN_233 | _GEN_200) & (_GEN_167 ? io_enq_bits_edge_inst_1 : ~(_GEN_134 | _GEN_101 | _GEN_68) & (_GEN_35 ? io_enq_bits_edge_inst_0 : deq_vec_6_1_edge_inst));
    if (_GEN_293) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_6_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_6_2_pc_lob <= _pc_T_31;
      deq_vec_6_2_taken <= in_uops_7_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_234) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_6_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_6_2_pc_lob <= _pc_T_27;
      deq_vec_6_2_taken <= in_uops_6_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_201) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_6_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_6_2_pc_lob <= _pc_T_23;
      deq_vec_6_2_taken <= in_uops_5_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_168) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_6_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_6_2_pc_lob <= _GEN_4;
      deq_vec_6_2_taken <= in_uops_4_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_135) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_6_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_6_2_pc_lob <= _pc_T_15;
      deq_vec_6_2_taken <= in_uops_3_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_102) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_6_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_6_2_pc_lob <= _pc_T_11;
      deq_vec_6_2_taken <= in_uops_2_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_69) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_6_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_6_2_pc_lob <= _pc_T_7;
      deq_vec_6_2_taken <= in_uops_1_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_36) begin
      deq_vec_6_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_6_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_6_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_6_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_6_2_taken <= in_uops_0_taken;
      deq_vec_6_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_6_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_6_2_ctrl_is_load <= ~_GEN_294 & deq_vec_6_2_ctrl_is_load;
    deq_vec_6_2_ctrl_is_sta <= ~_GEN_294 & deq_vec_6_2_ctrl_is_sta;
    if (_GEN_294) begin
      deq_vec_6_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_6_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_6_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_6_2_edge_inst <= ~(_GEN_293 | _GEN_234 | _GEN_201) & (_GEN_168 ? io_enq_bits_edge_inst_1 : ~(_GEN_135 | _GEN_102 | _GEN_69) & (_GEN_36 ? io_enq_bits_edge_inst_0 : deq_vec_6_2_edge_inst));
    if (_GEN_295) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_6_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_6_3_pc_lob <= _pc_T_31;
      deq_vec_6_3_taken <= in_uops_7_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_235) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_6_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_6_3_pc_lob <= _pc_T_27;
      deq_vec_6_3_taken <= in_uops_6_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_202) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_6_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_6_3_pc_lob <= _pc_T_23;
      deq_vec_6_3_taken <= in_uops_5_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_169) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_6_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_6_3_pc_lob <= _GEN_4;
      deq_vec_6_3_taken <= in_uops_4_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_136) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_6_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_6_3_pc_lob <= _pc_T_15;
      deq_vec_6_3_taken <= in_uops_3_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_103) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_6_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_6_3_pc_lob <= _pc_T_11;
      deq_vec_6_3_taken <= in_uops_2_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_70) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_6_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_6_3_pc_lob <= _pc_T_7;
      deq_vec_6_3_taken <= in_uops_1_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_37) begin
      deq_vec_6_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_6_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_6_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_6_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_6_3_taken <= in_uops_0_taken;
      deq_vec_6_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_6_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_6_3_ctrl_is_load <= ~_GEN_296 & deq_vec_6_3_ctrl_is_load;
    deq_vec_6_3_ctrl_is_sta <= ~_GEN_296 & deq_vec_6_3_ctrl_is_sta;
    if (_GEN_296) begin
      deq_vec_6_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_6_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_6_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_6_3_edge_inst <= ~(_GEN_295 | _GEN_235 | _GEN_202) & (_GEN_169 ? io_enq_bits_edge_inst_1 : ~(_GEN_136 | _GEN_103 | _GEN_70) & (_GEN_37 ? io_enq_bits_edge_inst_0 : deq_vec_6_3_edge_inst));
    if (_GEN_297) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_7;
      deq_vec_7_0_is_rvc <= in_uops_7_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_7_0_pc_lob <= _pc_T_31;
      deq_vec_7_0_taken <= in_uops_7_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_236) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_6;
      deq_vec_7_0_is_rvc <= in_uops_6_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_7_0_pc_lob <= _pc_T_27;
      deq_vec_7_0_taken <= in_uops_6_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_203) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_5;
      deq_vec_7_0_is_rvc <= in_uops_5_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_7_0_pc_lob <= _pc_T_23;
      deq_vec_7_0_taken <= in_uops_5_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_170) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_4;
      deq_vec_7_0_is_rvc <= in_uops_4_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_7_0_pc_lob <= _GEN_4;
      deq_vec_7_0_taken <= in_uops_4_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_137) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_3;
      deq_vec_7_0_is_rvc <= in_uops_3_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_7_0_pc_lob <= _pc_T_15;
      deq_vec_7_0_taken <= in_uops_3_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_104) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_2;
      deq_vec_7_0_is_rvc <= in_uops_2_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_7_0_pc_lob <= _pc_T_11;
      deq_vec_7_0_taken <= in_uops_2_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_71) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_1;
      deq_vec_7_0_is_rvc <= in_uops_1_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_7_0_pc_lob <= _pc_T_7;
      deq_vec_7_0_taken <= in_uops_1_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_38) begin
      deq_vec_7_0_inst <= io_enq_bits_exp_insts_0;
      deq_vec_7_0_is_rvc <= in_uops_0_is_rvc;
      deq_vec_7_0_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_7_0_pc_lob <= in_uops_0_pc_lob;
      deq_vec_7_0_taken <= in_uops_0_taken;
      deq_vec_7_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_7_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_7_0_ctrl_is_load <= ~_GEN_298 & deq_vec_7_0_ctrl_is_load;
    deq_vec_7_0_ctrl_is_sta <= ~_GEN_298 & deq_vec_7_0_ctrl_is_sta;
    if (_GEN_298) begin
      deq_vec_7_0_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_7_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_7_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_7_0_edge_inst <= ~(_GEN_297 | _GEN_236 | _GEN_203) & (_GEN_170 ? io_enq_bits_edge_inst_1 : ~(_GEN_137 | _GEN_104 | _GEN_71) & (_GEN_38 ? io_enq_bits_edge_inst_0 : deq_vec_7_0_edge_inst));
    if (_GEN_299) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_7;
      deq_vec_7_1_is_rvc <= in_uops_7_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_7_1_pc_lob <= _pc_T_31;
      deq_vec_7_1_taken <= in_uops_7_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_237) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_6;
      deq_vec_7_1_is_rvc <= in_uops_6_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_7_1_pc_lob <= _pc_T_27;
      deq_vec_7_1_taken <= in_uops_6_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_204) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_5;
      deq_vec_7_1_is_rvc <= in_uops_5_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_7_1_pc_lob <= _pc_T_23;
      deq_vec_7_1_taken <= in_uops_5_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_171) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_4;
      deq_vec_7_1_is_rvc <= in_uops_4_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_7_1_pc_lob <= _GEN_4;
      deq_vec_7_1_taken <= in_uops_4_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_138) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_3;
      deq_vec_7_1_is_rvc <= in_uops_3_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_7_1_pc_lob <= _pc_T_15;
      deq_vec_7_1_taken <= in_uops_3_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_105) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_2;
      deq_vec_7_1_is_rvc <= in_uops_2_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_7_1_pc_lob <= _pc_T_11;
      deq_vec_7_1_taken <= in_uops_2_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_72) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_1;
      deq_vec_7_1_is_rvc <= in_uops_1_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_7_1_pc_lob <= _pc_T_7;
      deq_vec_7_1_taken <= in_uops_1_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_39) begin
      deq_vec_7_1_inst <= io_enq_bits_exp_insts_0;
      deq_vec_7_1_is_rvc <= in_uops_0_is_rvc;
      deq_vec_7_1_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_7_1_pc_lob <= in_uops_0_pc_lob;
      deq_vec_7_1_taken <= in_uops_0_taken;
      deq_vec_7_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_7_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_7_1_ctrl_is_load <= ~_GEN_300 & deq_vec_7_1_ctrl_is_load;
    deq_vec_7_1_ctrl_is_sta <= ~_GEN_300 & deq_vec_7_1_ctrl_is_sta;
    if (_GEN_300) begin
      deq_vec_7_1_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_7_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_7_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_7_1_edge_inst <= ~(_GEN_299 | _GEN_237 | _GEN_204) & (_GEN_171 ? io_enq_bits_edge_inst_1 : ~(_GEN_138 | _GEN_105 | _GEN_72) & (_GEN_39 ? io_enq_bits_edge_inst_0 : deq_vec_7_1_edge_inst));
    if (_GEN_301) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_7;
      deq_vec_7_2_is_rvc <= in_uops_7_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_7_2_pc_lob <= _pc_T_31;
      deq_vec_7_2_taken <= in_uops_7_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_238) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_6;
      deq_vec_7_2_is_rvc <= in_uops_6_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_7_2_pc_lob <= _pc_T_27;
      deq_vec_7_2_taken <= in_uops_6_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_205) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_5;
      deq_vec_7_2_is_rvc <= in_uops_5_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_7_2_pc_lob <= _pc_T_23;
      deq_vec_7_2_taken <= in_uops_5_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_172) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_4;
      deq_vec_7_2_is_rvc <= in_uops_4_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_7_2_pc_lob <= _GEN_4;
      deq_vec_7_2_taken <= in_uops_4_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_139) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_3;
      deq_vec_7_2_is_rvc <= in_uops_3_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_7_2_pc_lob <= _pc_T_15;
      deq_vec_7_2_taken <= in_uops_3_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_106) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_2;
      deq_vec_7_2_is_rvc <= in_uops_2_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_7_2_pc_lob <= _pc_T_11;
      deq_vec_7_2_taken <= in_uops_2_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_73) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_1;
      deq_vec_7_2_is_rvc <= in_uops_1_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_7_2_pc_lob <= _pc_T_7;
      deq_vec_7_2_taken <= in_uops_1_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_40) begin
      deq_vec_7_2_inst <= io_enq_bits_exp_insts_0;
      deq_vec_7_2_is_rvc <= in_uops_0_is_rvc;
      deq_vec_7_2_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_7_2_pc_lob <= in_uops_0_pc_lob;
      deq_vec_7_2_taken <= in_uops_0_taken;
      deq_vec_7_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_7_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_7_2_ctrl_is_load <= ~_GEN_302 & deq_vec_7_2_ctrl_is_load;
    deq_vec_7_2_ctrl_is_sta <= ~_GEN_302 & deq_vec_7_2_ctrl_is_sta;
    if (_GEN_302) begin
      deq_vec_7_2_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_7_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_7_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_7_2_edge_inst <= ~(_GEN_301 | _GEN_238 | _GEN_205) & (_GEN_172 ? io_enq_bits_edge_inst_1 : ~(_GEN_139 | _GEN_106 | _GEN_73) & (_GEN_40 ? io_enq_bits_edge_inst_0 : deq_vec_7_2_edge_inst));
    if (_GEN_303) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_7;
      deq_vec_7_3_is_rvc <= in_uops_7_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_7;
      deq_vec_7_3_pc_lob <= _pc_T_31;
      deq_vec_7_3_taken <= in_uops_7_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;
    end
    else if (_GEN_239) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_6;
      deq_vec_7_3_is_rvc <= in_uops_6_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_6;
      deq_vec_7_3_pc_lob <= _pc_T_27;
      deq_vec_7_3_taken <= in_uops_6_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;
    end
    else if (_GEN_206) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_5;
      deq_vec_7_3_is_rvc <= in_uops_5_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_5;
      deq_vec_7_3_pc_lob <= _pc_T_23;
      deq_vec_7_3_taken <= in_uops_5_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;
    end
    else if (_GEN_173) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_4;
      deq_vec_7_3_is_rvc <= in_uops_4_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_4;
      deq_vec_7_3_pc_lob <= _GEN_4;
      deq_vec_7_3_taken <= in_uops_4_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;
    end
    else if (_GEN_140) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_3;
      deq_vec_7_3_is_rvc <= in_uops_3_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_3;
      deq_vec_7_3_pc_lob <= _pc_T_15;
      deq_vec_7_3_taken <= in_uops_3_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;
    end
    else if (_GEN_107) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_2;
      deq_vec_7_3_is_rvc <= in_uops_2_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_2;
      deq_vec_7_3_pc_lob <= _pc_T_11;
      deq_vec_7_3_taken <= in_uops_2_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;
    end
    else if (_GEN_74) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_1;
      deq_vec_7_3_is_rvc <= in_uops_1_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_1;
      deq_vec_7_3_pc_lob <= _pc_T_7;
      deq_vec_7_3_taken <= in_uops_1_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;
    end
    else if (_GEN_41) begin
      deq_vec_7_3_inst <= io_enq_bits_exp_insts_0;
      deq_vec_7_3_is_rvc <= in_uops_0_is_rvc;
      deq_vec_7_3_is_sfb <= io_enq_bits_shadowed_mask_0;
      deq_vec_7_3_pc_lob <= in_uops_0_pc_lob;
      deq_vec_7_3_taken <= in_uops_0_taken;
      deq_vec_7_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;
      deq_vec_7_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;
    end
    deq_vec_7_3_ctrl_is_load <= ~_GEN_304 & deq_vec_7_3_ctrl_is_load;
    deq_vec_7_3_ctrl_is_sta <= ~_GEN_304 & deq_vec_7_3_ctrl_is_sta;
    if (_GEN_304) begin
      deq_vec_7_3_ftq_idx <= io_enq_bits_ftq_idx;
      deq_vec_7_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;
      deq_vec_7_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;
    end
    deq_vec_7_3_edge_inst <= ~(_GEN_303 | _GEN_239 | _GEN_206) & (_GEN_173 ? io_enq_bits_edge_inst_1 : ~(_GEN_140 | _GEN_107 | _GEN_74) & (_GEN_41 ? io_enq_bits_edge_inst_0 : deq_vec_7_3_edge_inst));
    if (reset) begin
      head <= 8'h1;
      tail <= 32'h1;
      maybe_full <= 1'h0;
    end
    else begin
      if (io_clear) begin
        head <= 8'h1;
        tail <= 32'h1;
      end
      else begin
        if (do_deq)
          head <= {head[6:0], head[7]};
        if (~_do_enq_T_1) begin
          if (in_mask_7)
            tail <= {enq_idxs_7[30:0], enq_idxs_7[31]};
          else if (in_mask_6)
            tail <= _GEN_8;
          else if (in_mask_5)
            tail <= _GEN_7;
          else if (in_mask_4)
            tail <= _GEN_6;
          else if (in_mask_3)
            tail <= _GEN_5;
          else if (in_mask_2)
            tail <= _GEN_3;
          else if (in_mask_1)
            tail <= _GEN_2;
          else if (in_mask_0)
            tail <= _GEN_1;
        end
      end
      maybe_full <= ~(io_clear | do_deq) & (~_do_enq_T_1 & (in_mask_0 | in_mask_1 | in_mask_2 | in_mask_3 | in_mask_4 | in_mask_5 | in_mask_6 | in_mask_7) | maybe_full);
    end
  end // always @(posedge)
  assign io_enq_ready = ~_do_enq_T_1;
  assign io_deq_valid = _deq_valids_T_10 != 4'hF;
  assign io_deq_bits_uops_0_valid = ~reset & _deq_valids_T_11[0];
  assign io_deq_bits_uops_0_bits_inst = (head[0] ? deq_vec_0_0_inst : 32'h0) | (head[1] ? deq_vec_1_0_inst : 32'h0) | (head[2] ? deq_vec_2_0_inst : 32'h0) | (head[3] ? deq_vec_3_0_inst : 32'h0) | (head[4] ? deq_vec_4_0_inst : 32'h0) | (head[5] ? deq_vec_5_0_inst : 32'h0) | (head[6] ? deq_vec_6_0_inst : 32'h0) | (head[7] ? deq_vec_7_0_inst : 32'h0);
  assign io_deq_bits_uops_0_bits_is_rvc = head[0] & deq_vec_0_0_is_rvc | head[1] & deq_vec_1_0_is_rvc | head[2] & deq_vec_2_0_is_rvc | head[3] & deq_vec_3_0_is_rvc | head[4] & deq_vec_4_0_is_rvc | head[5] & deq_vec_5_0_is_rvc | head[6] & deq_vec_6_0_is_rvc | head[7] & deq_vec_7_0_is_rvc;
  assign io_deq_bits_uops_0_bits_ctrl_is_load = head[0] & deq_vec_0_0_ctrl_is_load | head[1] & deq_vec_1_0_ctrl_is_load | head[2] & deq_vec_2_0_ctrl_is_load | head[3] & deq_vec_3_0_ctrl_is_load | head[4] & deq_vec_4_0_ctrl_is_load | head[5] & deq_vec_5_0_ctrl_is_load | head[6] & deq_vec_6_0_ctrl_is_load | head[7] & deq_vec_7_0_ctrl_is_load;
  assign io_deq_bits_uops_0_bits_ctrl_is_sta = head[0] & deq_vec_0_0_ctrl_is_sta | head[1] & deq_vec_1_0_ctrl_is_sta | head[2] & deq_vec_2_0_ctrl_is_sta | head[3] & deq_vec_3_0_ctrl_is_sta | head[4] & deq_vec_4_0_ctrl_is_sta | head[5] & deq_vec_5_0_ctrl_is_sta | head[6] & deq_vec_6_0_ctrl_is_sta | head[7] & deq_vec_7_0_ctrl_is_sta;
  assign io_deq_bits_uops_0_bits_is_sfb = head[0] & deq_vec_0_0_is_sfb | head[1] & deq_vec_1_0_is_sfb | head[2] & deq_vec_2_0_is_sfb | head[3] & deq_vec_3_0_is_sfb | head[4] & deq_vec_4_0_is_sfb | head[5] & deq_vec_5_0_is_sfb | head[6] & deq_vec_6_0_is_sfb | head[7] & deq_vec_7_0_is_sfb;
  assign io_deq_bits_uops_0_bits_ftq_idx = (head[0] ? deq_vec_0_0_ftq_idx : 6'h0) | (head[1] ? deq_vec_1_0_ftq_idx : 6'h0) | (head[2] ? deq_vec_2_0_ftq_idx : 6'h0) | (head[3] ? deq_vec_3_0_ftq_idx : 6'h0) | (head[4] ? deq_vec_4_0_ftq_idx : 6'h0) | (head[5] ? deq_vec_5_0_ftq_idx : 6'h0) | (head[6] ? deq_vec_6_0_ftq_idx : 6'h0) | (head[7] ? deq_vec_7_0_ftq_idx : 6'h0);
  assign io_deq_bits_uops_0_bits_edge_inst = head[0] & deq_vec_0_0_edge_inst | head[1] & deq_vec_1_0_edge_inst | head[2] & deq_vec_2_0_edge_inst | head[3] & deq_vec_3_0_edge_inst | head[4] & deq_vec_4_0_edge_inst | head[5] & deq_vec_5_0_edge_inst | head[6] & deq_vec_6_0_edge_inst | head[7] & deq_vec_7_0_edge_inst;
  assign io_deq_bits_uops_0_bits_pc_lob = (head[0] ? deq_vec_0_0_pc_lob : 6'h0) | (head[1] ? deq_vec_1_0_pc_lob : 6'h0) | (head[2] ? deq_vec_2_0_pc_lob : 6'h0) | (head[3] ? deq_vec_3_0_pc_lob : 6'h0) | (head[4] ? deq_vec_4_0_pc_lob : 6'h0) | (head[5] ? deq_vec_5_0_pc_lob : 6'h0) | (head[6] ? deq_vec_6_0_pc_lob : 6'h0) | (head[7] ? deq_vec_7_0_pc_lob : 6'h0);
  assign io_deq_bits_uops_0_bits_taken = head[0] & deq_vec_0_0_taken | head[1] & deq_vec_1_0_taken | head[2] & deq_vec_2_0_taken | head[3] & deq_vec_3_0_taken | head[4] & deq_vec_4_0_taken | head[5] & deq_vec_5_0_taken | head[6] & deq_vec_6_0_taken | head[7] & deq_vec_7_0_taken;
  assign io_deq_bits_uops_0_bits_xcpt_pf_if = head[0] & deq_vec_0_0_xcpt_pf_if | head[1] & deq_vec_1_0_xcpt_pf_if | head[2] & deq_vec_2_0_xcpt_pf_if | head[3] & deq_vec_3_0_xcpt_pf_if | head[4] & deq_vec_4_0_xcpt_pf_if | head[5] & deq_vec_5_0_xcpt_pf_if | head[6] & deq_vec_6_0_xcpt_pf_if | head[7] & deq_vec_7_0_xcpt_pf_if;
  assign io_deq_bits_uops_0_bits_xcpt_ae_if = head[0] & deq_vec_0_0_xcpt_ae_if | head[1] & deq_vec_1_0_xcpt_ae_if | head[2] & deq_vec_2_0_xcpt_ae_if | head[3] & deq_vec_3_0_xcpt_ae_if | head[4] & deq_vec_4_0_xcpt_ae_if | head[5] & deq_vec_5_0_xcpt_ae_if | head[6] & deq_vec_6_0_xcpt_ae_if | head[7] & deq_vec_7_0_xcpt_ae_if;
  assign io_deq_bits_uops_0_bits_bp_debug_if = head[0] & deq_vec_0_0_bp_debug_if | head[1] & deq_vec_1_0_bp_debug_if | head[2] & deq_vec_2_0_bp_debug_if | head[3] & deq_vec_3_0_bp_debug_if | head[4] & deq_vec_4_0_bp_debug_if | head[5] & deq_vec_5_0_bp_debug_if | head[6] & deq_vec_6_0_bp_debug_if | head[7] & deq_vec_7_0_bp_debug_if;
  assign io_deq_bits_uops_0_bits_bp_xcpt_if = head[0] & deq_vec_0_0_bp_xcpt_if | head[1] & deq_vec_1_0_bp_xcpt_if | head[2] & deq_vec_2_0_bp_xcpt_if | head[3] & deq_vec_3_0_bp_xcpt_if | head[4] & deq_vec_4_0_bp_xcpt_if | head[5] & deq_vec_5_0_bp_xcpt_if | head[6] & deq_vec_6_0_bp_xcpt_if | head[7] & deq_vec_7_0_bp_xcpt_if;
  assign io_deq_bits_uops_1_valid = ~reset & _deq_valids_T_11[1];
  assign io_deq_bits_uops_1_bits_inst = (head[0] ? deq_vec_0_1_inst : 32'h0) | (head[1] ? deq_vec_1_1_inst : 32'h0) | (head[2] ? deq_vec_2_1_inst : 32'h0) | (head[3] ? deq_vec_3_1_inst : 32'h0) | (head[4] ? deq_vec_4_1_inst : 32'h0) | (head[5] ? deq_vec_5_1_inst : 32'h0) | (head[6] ? deq_vec_6_1_inst : 32'h0) | (head[7] ? deq_vec_7_1_inst : 32'h0);
  assign io_deq_bits_uops_1_bits_is_rvc = head[0] & deq_vec_0_1_is_rvc | head[1] & deq_vec_1_1_is_rvc | head[2] & deq_vec_2_1_is_rvc | head[3] & deq_vec_3_1_is_rvc | head[4] & deq_vec_4_1_is_rvc | head[5] & deq_vec_5_1_is_rvc | head[6] & deq_vec_6_1_is_rvc | head[7] & deq_vec_7_1_is_rvc;
  assign io_deq_bits_uops_1_bits_ctrl_is_load = head[0] & deq_vec_0_1_ctrl_is_load | head[1] & deq_vec_1_1_ctrl_is_load | head[2] & deq_vec_2_1_ctrl_is_load | head[3] & deq_vec_3_1_ctrl_is_load | head[4] & deq_vec_4_1_ctrl_is_load | head[5] & deq_vec_5_1_ctrl_is_load | head[6] & deq_vec_6_1_ctrl_is_load | head[7] & deq_vec_7_1_ctrl_is_load;
  assign io_deq_bits_uops_1_bits_ctrl_is_sta = head[0] & deq_vec_0_1_ctrl_is_sta | head[1] & deq_vec_1_1_ctrl_is_sta | head[2] & deq_vec_2_1_ctrl_is_sta | head[3] & deq_vec_3_1_ctrl_is_sta | head[4] & deq_vec_4_1_ctrl_is_sta | head[5] & deq_vec_5_1_ctrl_is_sta | head[6] & deq_vec_6_1_ctrl_is_sta | head[7] & deq_vec_7_1_ctrl_is_sta;
  assign io_deq_bits_uops_1_bits_is_sfb = head[0] & deq_vec_0_1_is_sfb | head[1] & deq_vec_1_1_is_sfb | head[2] & deq_vec_2_1_is_sfb | head[3] & deq_vec_3_1_is_sfb | head[4] & deq_vec_4_1_is_sfb | head[5] & deq_vec_5_1_is_sfb | head[6] & deq_vec_6_1_is_sfb | head[7] & deq_vec_7_1_is_sfb;
  assign io_deq_bits_uops_1_bits_ftq_idx = (head[0] ? deq_vec_0_1_ftq_idx : 6'h0) | (head[1] ? deq_vec_1_1_ftq_idx : 6'h0) | (head[2] ? deq_vec_2_1_ftq_idx : 6'h0) | (head[3] ? deq_vec_3_1_ftq_idx : 6'h0) | (head[4] ? deq_vec_4_1_ftq_idx : 6'h0) | (head[5] ? deq_vec_5_1_ftq_idx : 6'h0) | (head[6] ? deq_vec_6_1_ftq_idx : 6'h0) | (head[7] ? deq_vec_7_1_ftq_idx : 6'h0);
  assign io_deq_bits_uops_1_bits_edge_inst = head[0] & deq_vec_0_1_edge_inst | head[1] & deq_vec_1_1_edge_inst | head[2] & deq_vec_2_1_edge_inst | head[3] & deq_vec_3_1_edge_inst | head[4] & deq_vec_4_1_edge_inst | head[5] & deq_vec_5_1_edge_inst | head[6] & deq_vec_6_1_edge_inst | head[7] & deq_vec_7_1_edge_inst;
  assign io_deq_bits_uops_1_bits_pc_lob = (head[0] ? deq_vec_0_1_pc_lob : 6'h0) | (head[1] ? deq_vec_1_1_pc_lob : 6'h0) | (head[2] ? deq_vec_2_1_pc_lob : 6'h0) | (head[3] ? deq_vec_3_1_pc_lob : 6'h0) | (head[4] ? deq_vec_4_1_pc_lob : 6'h0) | (head[5] ? deq_vec_5_1_pc_lob : 6'h0) | (head[6] ? deq_vec_6_1_pc_lob : 6'h0) | (head[7] ? deq_vec_7_1_pc_lob : 6'h0);
  assign io_deq_bits_uops_1_bits_taken = head[0] & deq_vec_0_1_taken | head[1] & deq_vec_1_1_taken | head[2] & deq_vec_2_1_taken | head[3] & deq_vec_3_1_taken | head[4] & deq_vec_4_1_taken | head[5] & deq_vec_5_1_taken | head[6] & deq_vec_6_1_taken | head[7] & deq_vec_7_1_taken;
  assign io_deq_bits_uops_1_bits_xcpt_pf_if = head[0] & deq_vec_0_1_xcpt_pf_if | head[1] & deq_vec_1_1_xcpt_pf_if | head[2] & deq_vec_2_1_xcpt_pf_if | head[3] & deq_vec_3_1_xcpt_pf_if | head[4] & deq_vec_4_1_xcpt_pf_if | head[5] & deq_vec_5_1_xcpt_pf_if | head[6] & deq_vec_6_1_xcpt_pf_if | head[7] & deq_vec_7_1_xcpt_pf_if;
  assign io_deq_bits_uops_1_bits_xcpt_ae_if = head[0] & deq_vec_0_1_xcpt_ae_if | head[1] & deq_vec_1_1_xcpt_ae_if | head[2] & deq_vec_2_1_xcpt_ae_if | head[3] & deq_vec_3_1_xcpt_ae_if | head[4] & deq_vec_4_1_xcpt_ae_if | head[5] & deq_vec_5_1_xcpt_ae_if | head[6] & deq_vec_6_1_xcpt_ae_if | head[7] & deq_vec_7_1_xcpt_ae_if;
  assign io_deq_bits_uops_1_bits_bp_debug_if = head[0] & deq_vec_0_1_bp_debug_if | head[1] & deq_vec_1_1_bp_debug_if | head[2] & deq_vec_2_1_bp_debug_if | head[3] & deq_vec_3_1_bp_debug_if | head[4] & deq_vec_4_1_bp_debug_if | head[5] & deq_vec_5_1_bp_debug_if | head[6] & deq_vec_6_1_bp_debug_if | head[7] & deq_vec_7_1_bp_debug_if;
  assign io_deq_bits_uops_1_bits_bp_xcpt_if = head[0] & deq_vec_0_1_bp_xcpt_if | head[1] & deq_vec_1_1_bp_xcpt_if | head[2] & deq_vec_2_1_bp_xcpt_if | head[3] & deq_vec_3_1_bp_xcpt_if | head[4] & deq_vec_4_1_bp_xcpt_if | head[5] & deq_vec_5_1_bp_xcpt_if | head[6] & deq_vec_6_1_bp_xcpt_if | head[7] & deq_vec_7_1_bp_xcpt_if;
  assign io_deq_bits_uops_2_valid = ~reset & _deq_valids_T_11[2];
  assign io_deq_bits_uops_2_bits_inst = (head[0] ? deq_vec_0_2_inst : 32'h0) | (head[1] ? deq_vec_1_2_inst : 32'h0) | (head[2] ? deq_vec_2_2_inst : 32'h0) | (head[3] ? deq_vec_3_2_inst : 32'h0) | (head[4] ? deq_vec_4_2_inst : 32'h0) | (head[5] ? deq_vec_5_2_inst : 32'h0) | (head[6] ? deq_vec_6_2_inst : 32'h0) | (head[7] ? deq_vec_7_2_inst : 32'h0);
  assign io_deq_bits_uops_2_bits_is_rvc = head[0] & deq_vec_0_2_is_rvc | head[1] & deq_vec_1_2_is_rvc | head[2] & deq_vec_2_2_is_rvc | head[3] & deq_vec_3_2_is_rvc | head[4] & deq_vec_4_2_is_rvc | head[5] & deq_vec_5_2_is_rvc | head[6] & deq_vec_6_2_is_rvc | head[7] & deq_vec_7_2_is_rvc;
  assign io_deq_bits_uops_2_bits_ctrl_is_load = head[0] & deq_vec_0_2_ctrl_is_load | head[1] & deq_vec_1_2_ctrl_is_load | head[2] & deq_vec_2_2_ctrl_is_load | head[3] & deq_vec_3_2_ctrl_is_load | head[4] & deq_vec_4_2_ctrl_is_load | head[5] & deq_vec_5_2_ctrl_is_load | head[6] & deq_vec_6_2_ctrl_is_load | head[7] & deq_vec_7_2_ctrl_is_load;
  assign io_deq_bits_uops_2_bits_ctrl_is_sta = head[0] & deq_vec_0_2_ctrl_is_sta | head[1] & deq_vec_1_2_ctrl_is_sta | head[2] & deq_vec_2_2_ctrl_is_sta | head[3] & deq_vec_3_2_ctrl_is_sta | head[4] & deq_vec_4_2_ctrl_is_sta | head[5] & deq_vec_5_2_ctrl_is_sta | head[6] & deq_vec_6_2_ctrl_is_sta | head[7] & deq_vec_7_2_ctrl_is_sta;
  assign io_deq_bits_uops_2_bits_is_sfb = head[0] & deq_vec_0_2_is_sfb | head[1] & deq_vec_1_2_is_sfb | head[2] & deq_vec_2_2_is_sfb | head[3] & deq_vec_3_2_is_sfb | head[4] & deq_vec_4_2_is_sfb | head[5] & deq_vec_5_2_is_sfb | head[6] & deq_vec_6_2_is_sfb | head[7] & deq_vec_7_2_is_sfb;
  assign io_deq_bits_uops_2_bits_ftq_idx = (head[0] ? deq_vec_0_2_ftq_idx : 6'h0) | (head[1] ? deq_vec_1_2_ftq_idx : 6'h0) | (head[2] ? deq_vec_2_2_ftq_idx : 6'h0) | (head[3] ? deq_vec_3_2_ftq_idx : 6'h0) | (head[4] ? deq_vec_4_2_ftq_idx : 6'h0) | (head[5] ? deq_vec_5_2_ftq_idx : 6'h0) | (head[6] ? deq_vec_6_2_ftq_idx : 6'h0) | (head[7] ? deq_vec_7_2_ftq_idx : 6'h0);
  assign io_deq_bits_uops_2_bits_edge_inst = head[0] & deq_vec_0_2_edge_inst | head[1] & deq_vec_1_2_edge_inst | head[2] & deq_vec_2_2_edge_inst | head[3] & deq_vec_3_2_edge_inst | head[4] & deq_vec_4_2_edge_inst | head[5] & deq_vec_5_2_edge_inst | head[6] & deq_vec_6_2_edge_inst | head[7] & deq_vec_7_2_edge_inst;
  assign io_deq_bits_uops_2_bits_pc_lob = (head[0] ? deq_vec_0_2_pc_lob : 6'h0) | (head[1] ? deq_vec_1_2_pc_lob : 6'h0) | (head[2] ? deq_vec_2_2_pc_lob : 6'h0) | (head[3] ? deq_vec_3_2_pc_lob : 6'h0) | (head[4] ? deq_vec_4_2_pc_lob : 6'h0) | (head[5] ? deq_vec_5_2_pc_lob : 6'h0) | (head[6] ? deq_vec_6_2_pc_lob : 6'h0) | (head[7] ? deq_vec_7_2_pc_lob : 6'h0);
  assign io_deq_bits_uops_2_bits_taken = head[0] & deq_vec_0_2_taken | head[1] & deq_vec_1_2_taken | head[2] & deq_vec_2_2_taken | head[3] & deq_vec_3_2_taken | head[4] & deq_vec_4_2_taken | head[5] & deq_vec_5_2_taken | head[6] & deq_vec_6_2_taken | head[7] & deq_vec_7_2_taken;
  assign io_deq_bits_uops_2_bits_xcpt_pf_if = head[0] & deq_vec_0_2_xcpt_pf_if | head[1] & deq_vec_1_2_xcpt_pf_if | head[2] & deq_vec_2_2_xcpt_pf_if | head[3] & deq_vec_3_2_xcpt_pf_if | head[4] & deq_vec_4_2_xcpt_pf_if | head[5] & deq_vec_5_2_xcpt_pf_if | head[6] & deq_vec_6_2_xcpt_pf_if | head[7] & deq_vec_7_2_xcpt_pf_if;
  assign io_deq_bits_uops_2_bits_xcpt_ae_if = head[0] & deq_vec_0_2_xcpt_ae_if | head[1] & deq_vec_1_2_xcpt_ae_if | head[2] & deq_vec_2_2_xcpt_ae_if | head[3] & deq_vec_3_2_xcpt_ae_if | head[4] & deq_vec_4_2_xcpt_ae_if | head[5] & deq_vec_5_2_xcpt_ae_if | head[6] & deq_vec_6_2_xcpt_ae_if | head[7] & deq_vec_7_2_xcpt_ae_if;
  assign io_deq_bits_uops_2_bits_bp_debug_if = head[0] & deq_vec_0_2_bp_debug_if | head[1] & deq_vec_1_2_bp_debug_if | head[2] & deq_vec_2_2_bp_debug_if | head[3] & deq_vec_3_2_bp_debug_if | head[4] & deq_vec_4_2_bp_debug_if | head[5] & deq_vec_5_2_bp_debug_if | head[6] & deq_vec_6_2_bp_debug_if | head[7] & deq_vec_7_2_bp_debug_if;
  assign io_deq_bits_uops_2_bits_bp_xcpt_if = head[0] & deq_vec_0_2_bp_xcpt_if | head[1] & deq_vec_1_2_bp_xcpt_if | head[2] & deq_vec_2_2_bp_xcpt_if | head[3] & deq_vec_3_2_bp_xcpt_if | head[4] & deq_vec_4_2_bp_xcpt_if | head[5] & deq_vec_5_2_bp_xcpt_if | head[6] & deq_vec_6_2_bp_xcpt_if | head[7] & deq_vec_7_2_bp_xcpt_if;
  assign io_deq_bits_uops_3_valid = ~reset & _deq_valids_T_11[3];
  assign io_deq_bits_uops_3_bits_inst = (head[0] ? deq_vec_0_3_inst : 32'h0) | (head[1] ? deq_vec_1_3_inst : 32'h0) | (head[2] ? deq_vec_2_3_inst : 32'h0) | (head[3] ? deq_vec_3_3_inst : 32'h0) | (head[4] ? deq_vec_4_3_inst : 32'h0) | (head[5] ? deq_vec_5_3_inst : 32'h0) | (head[6] ? deq_vec_6_3_inst : 32'h0) | (head[7] ? deq_vec_7_3_inst : 32'h0);
  assign io_deq_bits_uops_3_bits_is_rvc = head[0] & deq_vec_0_3_is_rvc | head[1] & deq_vec_1_3_is_rvc | head[2] & deq_vec_2_3_is_rvc | head[3] & deq_vec_3_3_is_rvc | head[4] & deq_vec_4_3_is_rvc | head[5] & deq_vec_5_3_is_rvc | head[6] & deq_vec_6_3_is_rvc | head[7] & deq_vec_7_3_is_rvc;
  assign io_deq_bits_uops_3_bits_ctrl_is_load = head[0] & deq_vec_0_3_ctrl_is_load | head[1] & deq_vec_1_3_ctrl_is_load | head[2] & deq_vec_2_3_ctrl_is_load | head[3] & deq_vec_3_3_ctrl_is_load | head[4] & deq_vec_4_3_ctrl_is_load | head[5] & deq_vec_5_3_ctrl_is_load | head[6] & deq_vec_6_3_ctrl_is_load | head[7] & deq_vec_7_3_ctrl_is_load;
  assign io_deq_bits_uops_3_bits_ctrl_is_sta = head[0] & deq_vec_0_3_ctrl_is_sta | head[1] & deq_vec_1_3_ctrl_is_sta | head[2] & deq_vec_2_3_ctrl_is_sta | head[3] & deq_vec_3_3_ctrl_is_sta | head[4] & deq_vec_4_3_ctrl_is_sta | head[5] & deq_vec_5_3_ctrl_is_sta | head[6] & deq_vec_6_3_ctrl_is_sta | head[7] & deq_vec_7_3_ctrl_is_sta;
  assign io_deq_bits_uops_3_bits_is_sfb = head[0] & deq_vec_0_3_is_sfb | head[1] & deq_vec_1_3_is_sfb | head[2] & deq_vec_2_3_is_sfb | head[3] & deq_vec_3_3_is_sfb | head[4] & deq_vec_4_3_is_sfb | head[5] & deq_vec_5_3_is_sfb | head[6] & deq_vec_6_3_is_sfb | head[7] & deq_vec_7_3_is_sfb;
  assign io_deq_bits_uops_3_bits_ftq_idx = (head[0] ? deq_vec_0_3_ftq_idx : 6'h0) | (head[1] ? deq_vec_1_3_ftq_idx : 6'h0) | (head[2] ? deq_vec_2_3_ftq_idx : 6'h0) | (head[3] ? deq_vec_3_3_ftq_idx : 6'h0) | (head[4] ? deq_vec_4_3_ftq_idx : 6'h0) | (head[5] ? deq_vec_5_3_ftq_idx : 6'h0) | (head[6] ? deq_vec_6_3_ftq_idx : 6'h0) | (head[7] ? deq_vec_7_3_ftq_idx : 6'h0);
  assign io_deq_bits_uops_3_bits_edge_inst = head[0] & deq_vec_0_3_edge_inst | head[1] & deq_vec_1_3_edge_inst | head[2] & deq_vec_2_3_edge_inst | head[3] & deq_vec_3_3_edge_inst | head[4] & deq_vec_4_3_edge_inst | head[5] & deq_vec_5_3_edge_inst | head[6] & deq_vec_6_3_edge_inst | head[7] & deq_vec_7_3_edge_inst;
  assign io_deq_bits_uops_3_bits_pc_lob = (head[0] ? deq_vec_0_3_pc_lob : 6'h0) | (head[1] ? deq_vec_1_3_pc_lob : 6'h0) | (head[2] ? deq_vec_2_3_pc_lob : 6'h0) | (head[3] ? deq_vec_3_3_pc_lob : 6'h0) | (head[4] ? deq_vec_4_3_pc_lob : 6'h0) | (head[5] ? deq_vec_5_3_pc_lob : 6'h0) | (head[6] ? deq_vec_6_3_pc_lob : 6'h0) | (head[7] ? deq_vec_7_3_pc_lob : 6'h0);
  assign io_deq_bits_uops_3_bits_taken = head[0] & deq_vec_0_3_taken | head[1] & deq_vec_1_3_taken | head[2] & deq_vec_2_3_taken | head[3] & deq_vec_3_3_taken | head[4] & deq_vec_4_3_taken | head[5] & deq_vec_5_3_taken | head[6] & deq_vec_6_3_taken | head[7] & deq_vec_7_3_taken;
  assign io_deq_bits_uops_3_bits_xcpt_pf_if = head[0] & deq_vec_0_3_xcpt_pf_if | head[1] & deq_vec_1_3_xcpt_pf_if | head[2] & deq_vec_2_3_xcpt_pf_if | head[3] & deq_vec_3_3_xcpt_pf_if | head[4] & deq_vec_4_3_xcpt_pf_if | head[5] & deq_vec_5_3_xcpt_pf_if | head[6] & deq_vec_6_3_xcpt_pf_if | head[7] & deq_vec_7_3_xcpt_pf_if;
  assign io_deq_bits_uops_3_bits_xcpt_ae_if = head[0] & deq_vec_0_3_xcpt_ae_if | head[1] & deq_vec_1_3_xcpt_ae_if | head[2] & deq_vec_2_3_xcpt_ae_if | head[3] & deq_vec_3_3_xcpt_ae_if | head[4] & deq_vec_4_3_xcpt_ae_if | head[5] & deq_vec_5_3_xcpt_ae_if | head[6] & deq_vec_6_3_xcpt_ae_if | head[7] & deq_vec_7_3_xcpt_ae_if;
  assign io_deq_bits_uops_3_bits_bp_debug_if = head[0] & deq_vec_0_3_bp_debug_if | head[1] & deq_vec_1_3_bp_debug_if | head[2] & deq_vec_2_3_bp_debug_if | head[3] & deq_vec_3_3_bp_debug_if | head[4] & deq_vec_4_3_bp_debug_if | head[5] & deq_vec_5_3_bp_debug_if | head[6] & deq_vec_6_3_bp_debug_if | head[7] & deq_vec_7_3_bp_debug_if;
  assign io_deq_bits_uops_3_bits_bp_xcpt_if = head[0] & deq_vec_0_3_bp_xcpt_if | head[1] & deq_vec_1_3_bp_xcpt_if | head[2] & deq_vec_2_3_bp_xcpt_if | head[3] & deq_vec_3_3_bp_xcpt_if | head[4] & deq_vec_4_3_bp_xcpt_if | head[5] & deq_vec_5_3_bp_xcpt_if | head[6] & deq_vec_6_3_bp_xcpt_if | head[7] & deq_vec_7_3_bp_xcpt_if;
endmodule

