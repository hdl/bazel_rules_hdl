// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomMSHRFile(
  input          clock,
                 reset,
                 io_req_0_valid,
  input  [19:0]  io_req_0_bits_uop_br_mask,
  input  [4:0]   io_req_0_bits_uop_ldq_idx,
                 io_req_0_bits_uop_stq_idx,
                 io_req_0_bits_uop_mem_cmd,
  input  [1:0]   io_req_0_bits_uop_mem_size,
  input          io_req_0_bits_uop_mem_signed,
                 io_req_0_bits_uop_is_amo,
                 io_req_0_bits_uop_uses_ldq,
                 io_req_0_bits_uop_uses_stq,
  input  [39:0]  io_req_0_bits_addr,
  input  [63:0]  io_req_0_bits_data,
  input          io_req_0_bits_is_hella,
                 io_req_0_bits_tag_match,
  input  [1:0]   io_req_0_bits_old_meta_coh_state,
  input  [19:0]  io_req_0_bits_old_meta_tag,
  input  [7:0]   io_req_0_bits_way_en,
  input          io_req_1_valid,
  input  [19:0]  io_req_1_bits_uop_br_mask,
  input  [4:0]   io_req_1_bits_uop_ldq_idx,
                 io_req_1_bits_uop_stq_idx,
                 io_req_1_bits_uop_mem_cmd,
  input  [1:0]   io_req_1_bits_uop_mem_size,
  input          io_req_1_bits_uop_mem_signed,
                 io_req_1_bits_uop_is_amo,
                 io_req_1_bits_uop_uses_ldq,
                 io_req_1_bits_uop_uses_stq,
  input  [39:0]  io_req_1_bits_addr,
  input  [63:0]  io_req_1_bits_data,
  input          io_req_1_bits_is_hella,
                 io_req_1_bits_tag_match,
  input  [1:0]   io_req_1_bits_old_meta_coh_state,
  input  [19:0]  io_req_1_bits_old_meta_tag,
  input  [7:0]   io_req_1_bits_way_en,
  input          io_req_is_probe_0,
                 io_req_is_probe_1,
                 io_resp_ready,
  input  [19:0]  io_brupdate_b1_resolve_mask,
                 io_brupdate_b1_mispredict_mask,
  input          io_exception,
                 io_mem_acquire_ready,
                 io_mem_grant_valid,
  input  [2:0]   io_mem_grant_bits_opcode,
  input  [1:0]   io_mem_grant_bits_param,
  input  [3:0]   io_mem_grant_bits_size,
                 io_mem_grant_bits_source,
                 io_mem_grant_bits_sink,
  input  [127:0] io_mem_grant_bits_data,
  input          io_mem_finish_ready,
                 io_refill_ready,
                 io_meta_write_ready,
                 io_meta_read_ready,
                 io_meta_resp_valid,
  input  [1:0]   io_meta_resp_bits_coh_state,
  input          io_replay_ready,
                 io_prefetch_ready,
                 io_wb_req_ready,
                 io_prober_state_valid,
  input  [39:0]  io_prober_state_bits,
  input          io_clear_all,
                 io_wb_resp,
  output         io_req_0_ready,
                 io_req_1_ready,
                 io_resp_valid,
  output [19:0]  io_resp_bits_uop_br_mask,
  output [4:0]   io_resp_bits_uop_ldq_idx,
                 io_resp_bits_uop_stq_idx,
  output         io_resp_bits_uop_is_amo,
                 io_resp_bits_uop_uses_ldq,
                 io_resp_bits_uop_uses_stq,
  output [63:0]  io_resp_bits_data,
  output         io_resp_bits_is_hella,
                 io_secondary_miss_0,
                 io_secondary_miss_1,
                 io_block_hit_0,
                 io_block_hit_1,
                 io_mem_acquire_valid,
  output [2:0]   io_mem_acquire_bits_opcode,
                 io_mem_acquire_bits_param,
  output [3:0]   io_mem_acquire_bits_size,
                 io_mem_acquire_bits_source,
  output [31:0]  io_mem_acquire_bits_address,
  output [15:0]  io_mem_acquire_bits_mask,
  output [127:0] io_mem_acquire_bits_data,
  output         io_mem_grant_ready,
                 io_mem_finish_valid,
  output [3:0]   io_mem_finish_bits_sink,
  output         io_refill_valid,
  output [7:0]   io_refill_bits_way_en,
  output [11:0]  io_refill_bits_addr,
  output [127:0] io_refill_bits_data,
  output         io_meta_write_valid,
  output [5:0]   io_meta_write_bits_idx,
  output [7:0]   io_meta_write_bits_way_en,
  output [1:0]   io_meta_write_bits_data_coh_state,
  output [19:0]  io_meta_write_bits_data_tag,
  output         io_meta_read_valid,
  output [5:0]   io_meta_read_bits_idx,
  output [7:0]   io_meta_read_bits_way_en,
  output [19:0]  io_meta_read_bits_tag,
  output         io_replay_valid,
  output [19:0]  io_replay_bits_uop_br_mask,
  output [4:0]   io_replay_bits_uop_ldq_idx,
                 io_replay_bits_uop_stq_idx,
                 io_replay_bits_uop_mem_cmd,
  output [1:0]   io_replay_bits_uop_mem_size,
  output         io_replay_bits_uop_mem_signed,
                 io_replay_bits_uop_is_amo,
                 io_replay_bits_uop_uses_ldq,
                 io_replay_bits_uop_uses_stq,
  output [39:0]  io_replay_bits_addr,
  output [63:0]  io_replay_bits_data,
  output         io_replay_bits_is_hella,
  output [7:0]   io_replay_bits_way_en,
  output         io_prefetch_valid,
  output [4:0]   io_prefetch_bits_uop_mem_cmd,
  output [39:0]  io_prefetch_bits_addr,
  output         io_wb_req_valid,
  output [19:0]  io_wb_req_bits_tag,
  output [5:0]   io_wb_req_bits_idx,
  output [2:0]   io_wb_req_bits_param,
  output [7:0]   io_wb_req_bits_way_en,
  output         io_fence_rdy,
                 io_probe_rdy
);

  wire         _io_req_1_ready_output;
  wire         _io_req_0_ready_output;
  wire         _respq_io_enq_ready;
  wire         _mmios_0_io_req_ready;
  wire         _mmios_0_io_resp_valid;
  wire [19:0]  _mmios_0_io_resp_bits_uop_br_mask;
  wire [4:0]   _mmios_0_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mmios_0_io_resp_bits_uop_stq_idx;
  wire         _mmios_0_io_resp_bits_uop_is_amo;
  wire         _mmios_0_io_resp_bits_uop_uses_ldq;
  wire         _mmios_0_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mmios_0_io_resp_bits_data;
  wire         _mmios_0_io_resp_bits_is_hella;
  wire         _mmios_0_io_mem_access_valid;
  wire [2:0]   _mmios_0_io_mem_access_bits_opcode;
  wire [2:0]   _mmios_0_io_mem_access_bits_param;
  wire [3:0]   _mmios_0_io_mem_access_bits_size;
  wire [3:0]   _mmios_0_io_mem_access_bits_source;
  wire [31:0]  _mmios_0_io_mem_access_bits_address;
  wire [15:0]  _mmios_0_io_mem_access_bits_mask;
  wire [127:0] _mmios_0_io_mem_access_bits_data;
  wire         _mmio_alloc_arb_io_in_0_ready;
  wire         _mshrs_7_io_req_pri_rdy;
  wire         _mshrs_7_io_req_sec_rdy;
  wire         _mshrs_7_io_idx_valid;
  wire [5:0]   _mshrs_7_io_idx_bits;
  wire         _mshrs_7_io_way_valid;
  wire [7:0]   _mshrs_7_io_way_bits;
  wire         _mshrs_7_io_tag_valid;
  wire [27:0]  _mshrs_7_io_tag_bits;
  wire         _mshrs_7_io_mem_acquire_valid;
  wire [2:0]   _mshrs_7_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_7_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_7_io_mem_acquire_bits_address;
  wire         _mshrs_7_io_mem_grant_ready;
  wire         _mshrs_7_io_mem_finish_valid;
  wire [3:0]   _mshrs_7_io_mem_finish_bits_sink;
  wire         _mshrs_7_io_refill_valid;
  wire [7:0]   _mshrs_7_io_refill_bits_way_en;
  wire [11:0]  _mshrs_7_io_refill_bits_addr;
  wire [127:0] _mshrs_7_io_refill_bits_data;
  wire         _mshrs_7_io_meta_write_valid;
  wire [5:0]   _mshrs_7_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_7_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_7_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_7_io_meta_write_bits_data_tag;
  wire         _mshrs_7_io_meta_read_valid;
  wire [5:0]   _mshrs_7_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_7_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_7_io_meta_read_bits_tag;
  wire         _mshrs_7_io_wb_req_valid;
  wire [19:0]  _mshrs_7_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_7_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_7_io_wb_req_bits_param;
  wire [7:0]   _mshrs_7_io_wb_req_bits_way_en;
  wire         _mshrs_7_io_commit_val;
  wire [39:0]  _mshrs_7_io_commit_addr;
  wire [1:0]   _mshrs_7_io_commit_coh_state;
  wire         _mshrs_7_io_lb_read_valid;
  wire [2:0]   _mshrs_7_io_lb_read_bits_id;
  wire [1:0]   _mshrs_7_io_lb_read_bits_offset;
  wire         _mshrs_7_io_lb_write_valid;
  wire [2:0]   _mshrs_7_io_lb_write_bits_id;
  wire [1:0]   _mshrs_7_io_lb_write_bits_offset;
  wire [127:0] _mshrs_7_io_lb_write_bits_data;
  wire         _mshrs_7_io_replay_valid;
  wire [19:0]  _mshrs_7_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_7_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_7_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_7_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_7_io_replay_bits_uop_mem_size;
  wire         _mshrs_7_io_replay_bits_uop_mem_signed;
  wire         _mshrs_7_io_replay_bits_uop_is_amo;
  wire         _mshrs_7_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_7_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_7_io_replay_bits_addr;
  wire         _mshrs_7_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_7_io_replay_bits_way_en;
  wire [4:0]   _mshrs_7_io_replay_bits_sdq_id;
  wire         _mshrs_7_io_resp_valid;
  wire [19:0]  _mshrs_7_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_7_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_7_io_resp_bits_uop_stq_idx;
  wire         _mshrs_7_io_resp_bits_uop_is_amo;
  wire         _mshrs_7_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_7_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_7_io_resp_bits_data;
  wire         _mshrs_7_io_resp_bits_is_hella;
  wire         _mshrs_7_io_probe_rdy;
  wire         _mshrs_6_io_req_pri_rdy;
  wire         _mshrs_6_io_req_sec_rdy;
  wire         _mshrs_6_io_idx_valid;
  wire [5:0]   _mshrs_6_io_idx_bits;
  wire         _mshrs_6_io_way_valid;
  wire [7:0]   _mshrs_6_io_way_bits;
  wire         _mshrs_6_io_tag_valid;
  wire [27:0]  _mshrs_6_io_tag_bits;
  wire         _mshrs_6_io_mem_acquire_valid;
  wire [2:0]   _mshrs_6_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_6_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_6_io_mem_acquire_bits_address;
  wire         _mshrs_6_io_mem_grant_ready;
  wire         _mshrs_6_io_mem_finish_valid;
  wire [3:0]   _mshrs_6_io_mem_finish_bits_sink;
  wire         _mshrs_6_io_refill_valid;
  wire [7:0]   _mshrs_6_io_refill_bits_way_en;
  wire [11:0]  _mshrs_6_io_refill_bits_addr;
  wire [127:0] _mshrs_6_io_refill_bits_data;
  wire         _mshrs_6_io_meta_write_valid;
  wire [5:0]   _mshrs_6_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_6_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_6_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_6_io_meta_write_bits_data_tag;
  wire         _mshrs_6_io_meta_read_valid;
  wire [5:0]   _mshrs_6_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_6_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_6_io_meta_read_bits_tag;
  wire         _mshrs_6_io_wb_req_valid;
  wire [19:0]  _mshrs_6_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_6_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_6_io_wb_req_bits_param;
  wire [7:0]   _mshrs_6_io_wb_req_bits_way_en;
  wire         _mshrs_6_io_commit_val;
  wire [39:0]  _mshrs_6_io_commit_addr;
  wire [1:0]   _mshrs_6_io_commit_coh_state;
  wire         _mshrs_6_io_lb_read_valid;
  wire [2:0]   _mshrs_6_io_lb_read_bits_id;
  wire [1:0]   _mshrs_6_io_lb_read_bits_offset;
  wire         _mshrs_6_io_lb_write_valid;
  wire [2:0]   _mshrs_6_io_lb_write_bits_id;
  wire [1:0]   _mshrs_6_io_lb_write_bits_offset;
  wire [127:0] _mshrs_6_io_lb_write_bits_data;
  wire         _mshrs_6_io_replay_valid;
  wire [19:0]  _mshrs_6_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_6_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_6_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_6_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_6_io_replay_bits_uop_mem_size;
  wire         _mshrs_6_io_replay_bits_uop_mem_signed;
  wire         _mshrs_6_io_replay_bits_uop_is_amo;
  wire         _mshrs_6_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_6_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_6_io_replay_bits_addr;
  wire         _mshrs_6_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_6_io_replay_bits_way_en;
  wire [4:0]   _mshrs_6_io_replay_bits_sdq_id;
  wire         _mshrs_6_io_resp_valid;
  wire [19:0]  _mshrs_6_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_6_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_6_io_resp_bits_uop_stq_idx;
  wire         _mshrs_6_io_resp_bits_uop_is_amo;
  wire         _mshrs_6_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_6_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_6_io_resp_bits_data;
  wire         _mshrs_6_io_resp_bits_is_hella;
  wire         _mshrs_6_io_probe_rdy;
  wire         _mshrs_5_io_req_pri_rdy;
  wire         _mshrs_5_io_req_sec_rdy;
  wire         _mshrs_5_io_idx_valid;
  wire [5:0]   _mshrs_5_io_idx_bits;
  wire         _mshrs_5_io_way_valid;
  wire [7:0]   _mshrs_5_io_way_bits;
  wire         _mshrs_5_io_tag_valid;
  wire [27:0]  _mshrs_5_io_tag_bits;
  wire         _mshrs_5_io_mem_acquire_valid;
  wire [2:0]   _mshrs_5_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_5_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_5_io_mem_acquire_bits_address;
  wire         _mshrs_5_io_mem_grant_ready;
  wire         _mshrs_5_io_mem_finish_valid;
  wire [3:0]   _mshrs_5_io_mem_finish_bits_sink;
  wire         _mshrs_5_io_refill_valid;
  wire [7:0]   _mshrs_5_io_refill_bits_way_en;
  wire [11:0]  _mshrs_5_io_refill_bits_addr;
  wire [127:0] _mshrs_5_io_refill_bits_data;
  wire         _mshrs_5_io_meta_write_valid;
  wire [5:0]   _mshrs_5_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_5_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_5_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_5_io_meta_write_bits_data_tag;
  wire         _mshrs_5_io_meta_read_valid;
  wire [5:0]   _mshrs_5_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_5_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_5_io_meta_read_bits_tag;
  wire         _mshrs_5_io_wb_req_valid;
  wire [19:0]  _mshrs_5_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_5_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_5_io_wb_req_bits_param;
  wire [7:0]   _mshrs_5_io_wb_req_bits_way_en;
  wire         _mshrs_5_io_commit_val;
  wire [39:0]  _mshrs_5_io_commit_addr;
  wire [1:0]   _mshrs_5_io_commit_coh_state;
  wire         _mshrs_5_io_lb_read_valid;
  wire [2:0]   _mshrs_5_io_lb_read_bits_id;
  wire [1:0]   _mshrs_5_io_lb_read_bits_offset;
  wire         _mshrs_5_io_lb_write_valid;
  wire [2:0]   _mshrs_5_io_lb_write_bits_id;
  wire [1:0]   _mshrs_5_io_lb_write_bits_offset;
  wire [127:0] _mshrs_5_io_lb_write_bits_data;
  wire         _mshrs_5_io_replay_valid;
  wire [19:0]  _mshrs_5_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_5_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_5_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_5_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_5_io_replay_bits_uop_mem_size;
  wire         _mshrs_5_io_replay_bits_uop_mem_signed;
  wire         _mshrs_5_io_replay_bits_uop_is_amo;
  wire         _mshrs_5_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_5_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_5_io_replay_bits_addr;
  wire         _mshrs_5_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_5_io_replay_bits_way_en;
  wire [4:0]   _mshrs_5_io_replay_bits_sdq_id;
  wire         _mshrs_5_io_resp_valid;
  wire [19:0]  _mshrs_5_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_5_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_5_io_resp_bits_uop_stq_idx;
  wire         _mshrs_5_io_resp_bits_uop_is_amo;
  wire         _mshrs_5_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_5_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_5_io_resp_bits_data;
  wire         _mshrs_5_io_resp_bits_is_hella;
  wire         _mshrs_5_io_probe_rdy;
  wire         _mshrs_4_io_req_pri_rdy;
  wire         _mshrs_4_io_req_sec_rdy;
  wire         _mshrs_4_io_idx_valid;
  wire [5:0]   _mshrs_4_io_idx_bits;
  wire         _mshrs_4_io_way_valid;
  wire [7:0]   _mshrs_4_io_way_bits;
  wire         _mshrs_4_io_tag_valid;
  wire [27:0]  _mshrs_4_io_tag_bits;
  wire         _mshrs_4_io_mem_acquire_valid;
  wire [2:0]   _mshrs_4_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_4_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_4_io_mem_acquire_bits_address;
  wire         _mshrs_4_io_mem_grant_ready;
  wire         _mshrs_4_io_mem_finish_valid;
  wire [3:0]   _mshrs_4_io_mem_finish_bits_sink;
  wire         _mshrs_4_io_refill_valid;
  wire [7:0]   _mshrs_4_io_refill_bits_way_en;
  wire [11:0]  _mshrs_4_io_refill_bits_addr;
  wire [127:0] _mshrs_4_io_refill_bits_data;
  wire         _mshrs_4_io_meta_write_valid;
  wire [5:0]   _mshrs_4_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_4_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_4_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_4_io_meta_write_bits_data_tag;
  wire         _mshrs_4_io_meta_read_valid;
  wire [5:0]   _mshrs_4_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_4_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_4_io_meta_read_bits_tag;
  wire         _mshrs_4_io_wb_req_valid;
  wire [19:0]  _mshrs_4_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_4_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_4_io_wb_req_bits_param;
  wire [7:0]   _mshrs_4_io_wb_req_bits_way_en;
  wire         _mshrs_4_io_commit_val;
  wire [39:0]  _mshrs_4_io_commit_addr;
  wire [1:0]   _mshrs_4_io_commit_coh_state;
  wire         _mshrs_4_io_lb_read_valid;
  wire [2:0]   _mshrs_4_io_lb_read_bits_id;
  wire [1:0]   _mshrs_4_io_lb_read_bits_offset;
  wire         _mshrs_4_io_lb_write_valid;
  wire [2:0]   _mshrs_4_io_lb_write_bits_id;
  wire [1:0]   _mshrs_4_io_lb_write_bits_offset;
  wire [127:0] _mshrs_4_io_lb_write_bits_data;
  wire         _mshrs_4_io_replay_valid;
  wire [19:0]  _mshrs_4_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_4_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_4_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_4_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_4_io_replay_bits_uop_mem_size;
  wire         _mshrs_4_io_replay_bits_uop_mem_signed;
  wire         _mshrs_4_io_replay_bits_uop_is_amo;
  wire         _mshrs_4_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_4_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_4_io_replay_bits_addr;
  wire         _mshrs_4_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_4_io_replay_bits_way_en;
  wire [4:0]   _mshrs_4_io_replay_bits_sdq_id;
  wire         _mshrs_4_io_resp_valid;
  wire [19:0]  _mshrs_4_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_4_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_4_io_resp_bits_uop_stq_idx;
  wire         _mshrs_4_io_resp_bits_uop_is_amo;
  wire         _mshrs_4_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_4_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_4_io_resp_bits_data;
  wire         _mshrs_4_io_resp_bits_is_hella;
  wire         _mshrs_4_io_probe_rdy;
  wire         _mshrs_3_io_req_pri_rdy;
  wire         _mshrs_3_io_req_sec_rdy;
  wire         _mshrs_3_io_idx_valid;
  wire [5:0]   _mshrs_3_io_idx_bits;
  wire         _mshrs_3_io_way_valid;
  wire [7:0]   _mshrs_3_io_way_bits;
  wire         _mshrs_3_io_tag_valid;
  wire [27:0]  _mshrs_3_io_tag_bits;
  wire         _mshrs_3_io_mem_acquire_valid;
  wire [2:0]   _mshrs_3_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_3_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_3_io_mem_acquire_bits_address;
  wire         _mshrs_3_io_mem_grant_ready;
  wire         _mshrs_3_io_mem_finish_valid;
  wire [3:0]   _mshrs_3_io_mem_finish_bits_sink;
  wire         _mshrs_3_io_refill_valid;
  wire [7:0]   _mshrs_3_io_refill_bits_way_en;
  wire [11:0]  _mshrs_3_io_refill_bits_addr;
  wire [127:0] _mshrs_3_io_refill_bits_data;
  wire         _mshrs_3_io_meta_write_valid;
  wire [5:0]   _mshrs_3_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_3_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_3_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_3_io_meta_write_bits_data_tag;
  wire         _mshrs_3_io_meta_read_valid;
  wire [5:0]   _mshrs_3_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_3_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_3_io_meta_read_bits_tag;
  wire         _mshrs_3_io_wb_req_valid;
  wire [19:0]  _mshrs_3_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_3_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_3_io_wb_req_bits_param;
  wire [7:0]   _mshrs_3_io_wb_req_bits_way_en;
  wire         _mshrs_3_io_commit_val;
  wire [39:0]  _mshrs_3_io_commit_addr;
  wire [1:0]   _mshrs_3_io_commit_coh_state;
  wire         _mshrs_3_io_lb_read_valid;
  wire [2:0]   _mshrs_3_io_lb_read_bits_id;
  wire [1:0]   _mshrs_3_io_lb_read_bits_offset;
  wire         _mshrs_3_io_lb_write_valid;
  wire [2:0]   _mshrs_3_io_lb_write_bits_id;
  wire [1:0]   _mshrs_3_io_lb_write_bits_offset;
  wire [127:0] _mshrs_3_io_lb_write_bits_data;
  wire         _mshrs_3_io_replay_valid;
  wire [19:0]  _mshrs_3_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_3_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_3_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_3_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_3_io_replay_bits_uop_mem_size;
  wire         _mshrs_3_io_replay_bits_uop_mem_signed;
  wire         _mshrs_3_io_replay_bits_uop_is_amo;
  wire         _mshrs_3_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_3_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_3_io_replay_bits_addr;
  wire         _mshrs_3_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_3_io_replay_bits_way_en;
  wire [4:0]   _mshrs_3_io_replay_bits_sdq_id;
  wire         _mshrs_3_io_resp_valid;
  wire [19:0]  _mshrs_3_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_3_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_3_io_resp_bits_uop_stq_idx;
  wire         _mshrs_3_io_resp_bits_uop_is_amo;
  wire         _mshrs_3_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_3_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_3_io_resp_bits_data;
  wire         _mshrs_3_io_resp_bits_is_hella;
  wire         _mshrs_3_io_probe_rdy;
  wire         _mshrs_2_io_req_pri_rdy;
  wire         _mshrs_2_io_req_sec_rdy;
  wire         _mshrs_2_io_idx_valid;
  wire [5:0]   _mshrs_2_io_idx_bits;
  wire         _mshrs_2_io_way_valid;
  wire [7:0]   _mshrs_2_io_way_bits;
  wire         _mshrs_2_io_tag_valid;
  wire [27:0]  _mshrs_2_io_tag_bits;
  wire         _mshrs_2_io_mem_acquire_valid;
  wire [2:0]   _mshrs_2_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_2_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_2_io_mem_acquire_bits_address;
  wire         _mshrs_2_io_mem_grant_ready;
  wire         _mshrs_2_io_mem_finish_valid;
  wire [3:0]   _mshrs_2_io_mem_finish_bits_sink;
  wire         _mshrs_2_io_refill_valid;
  wire [7:0]   _mshrs_2_io_refill_bits_way_en;
  wire [11:0]  _mshrs_2_io_refill_bits_addr;
  wire [127:0] _mshrs_2_io_refill_bits_data;
  wire         _mshrs_2_io_meta_write_valid;
  wire [5:0]   _mshrs_2_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_2_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_2_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_2_io_meta_write_bits_data_tag;
  wire         _mshrs_2_io_meta_read_valid;
  wire [5:0]   _mshrs_2_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_2_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_2_io_meta_read_bits_tag;
  wire         _mshrs_2_io_wb_req_valid;
  wire [19:0]  _mshrs_2_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_2_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_2_io_wb_req_bits_param;
  wire [7:0]   _mshrs_2_io_wb_req_bits_way_en;
  wire         _mshrs_2_io_commit_val;
  wire [39:0]  _mshrs_2_io_commit_addr;
  wire [1:0]   _mshrs_2_io_commit_coh_state;
  wire         _mshrs_2_io_lb_read_valid;
  wire [2:0]   _mshrs_2_io_lb_read_bits_id;
  wire [1:0]   _mshrs_2_io_lb_read_bits_offset;
  wire         _mshrs_2_io_lb_write_valid;
  wire [2:0]   _mshrs_2_io_lb_write_bits_id;
  wire [1:0]   _mshrs_2_io_lb_write_bits_offset;
  wire [127:0] _mshrs_2_io_lb_write_bits_data;
  wire         _mshrs_2_io_replay_valid;
  wire [19:0]  _mshrs_2_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_2_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_2_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_2_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_2_io_replay_bits_uop_mem_size;
  wire         _mshrs_2_io_replay_bits_uop_mem_signed;
  wire         _mshrs_2_io_replay_bits_uop_is_amo;
  wire         _mshrs_2_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_2_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_2_io_replay_bits_addr;
  wire         _mshrs_2_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_2_io_replay_bits_way_en;
  wire [4:0]   _mshrs_2_io_replay_bits_sdq_id;
  wire         _mshrs_2_io_resp_valid;
  wire [19:0]  _mshrs_2_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_2_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_2_io_resp_bits_uop_stq_idx;
  wire         _mshrs_2_io_resp_bits_uop_is_amo;
  wire         _mshrs_2_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_2_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_2_io_resp_bits_data;
  wire         _mshrs_2_io_resp_bits_is_hella;
  wire         _mshrs_2_io_probe_rdy;
  wire         _mshrs_1_io_req_pri_rdy;
  wire         _mshrs_1_io_req_sec_rdy;
  wire         _mshrs_1_io_idx_valid;
  wire [5:0]   _mshrs_1_io_idx_bits;
  wire         _mshrs_1_io_way_valid;
  wire [7:0]   _mshrs_1_io_way_bits;
  wire         _mshrs_1_io_tag_valid;
  wire [27:0]  _mshrs_1_io_tag_bits;
  wire         _mshrs_1_io_mem_acquire_valid;
  wire [2:0]   _mshrs_1_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_1_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_1_io_mem_acquire_bits_address;
  wire         _mshrs_1_io_mem_grant_ready;
  wire         _mshrs_1_io_mem_finish_valid;
  wire [3:0]   _mshrs_1_io_mem_finish_bits_sink;
  wire         _mshrs_1_io_refill_valid;
  wire [7:0]   _mshrs_1_io_refill_bits_way_en;
  wire [11:0]  _mshrs_1_io_refill_bits_addr;
  wire [127:0] _mshrs_1_io_refill_bits_data;
  wire         _mshrs_1_io_meta_write_valid;
  wire [5:0]   _mshrs_1_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_1_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_1_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_1_io_meta_write_bits_data_tag;
  wire         _mshrs_1_io_meta_read_valid;
  wire [5:0]   _mshrs_1_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_1_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_1_io_meta_read_bits_tag;
  wire         _mshrs_1_io_wb_req_valid;
  wire [19:0]  _mshrs_1_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_1_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_1_io_wb_req_bits_param;
  wire [7:0]   _mshrs_1_io_wb_req_bits_way_en;
  wire         _mshrs_1_io_commit_val;
  wire [39:0]  _mshrs_1_io_commit_addr;
  wire [1:0]   _mshrs_1_io_commit_coh_state;
  wire         _mshrs_1_io_lb_read_valid;
  wire [2:0]   _mshrs_1_io_lb_read_bits_id;
  wire [1:0]   _mshrs_1_io_lb_read_bits_offset;
  wire         _mshrs_1_io_lb_write_valid;
  wire [2:0]   _mshrs_1_io_lb_write_bits_id;
  wire [1:0]   _mshrs_1_io_lb_write_bits_offset;
  wire [127:0] _mshrs_1_io_lb_write_bits_data;
  wire         _mshrs_1_io_replay_valid;
  wire [19:0]  _mshrs_1_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_1_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_1_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_1_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_1_io_replay_bits_uop_mem_size;
  wire         _mshrs_1_io_replay_bits_uop_mem_signed;
  wire         _mshrs_1_io_replay_bits_uop_is_amo;
  wire         _mshrs_1_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_1_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_1_io_replay_bits_addr;
  wire         _mshrs_1_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_1_io_replay_bits_way_en;
  wire [4:0]   _mshrs_1_io_replay_bits_sdq_id;
  wire         _mshrs_1_io_resp_valid;
  wire [19:0]  _mshrs_1_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_1_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_1_io_resp_bits_uop_stq_idx;
  wire         _mshrs_1_io_resp_bits_uop_is_amo;
  wire         _mshrs_1_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_1_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_1_io_resp_bits_data;
  wire         _mshrs_1_io_resp_bits_is_hella;
  wire         _mshrs_1_io_probe_rdy;
  wire         _mshrs_0_io_req_pri_rdy;
  wire         _mshrs_0_io_req_sec_rdy;
  wire         _mshrs_0_io_idx_valid;
  wire [5:0]   _mshrs_0_io_idx_bits;
  wire         _mshrs_0_io_way_valid;
  wire [7:0]   _mshrs_0_io_way_bits;
  wire         _mshrs_0_io_tag_valid;
  wire [27:0]  _mshrs_0_io_tag_bits;
  wire         _mshrs_0_io_mem_acquire_valid;
  wire [2:0]   _mshrs_0_io_mem_acquire_bits_param;
  wire [3:0]   _mshrs_0_io_mem_acquire_bits_source;
  wire [31:0]  _mshrs_0_io_mem_acquire_bits_address;
  wire         _mshrs_0_io_mem_grant_ready;
  wire         _mshrs_0_io_mem_finish_valid;
  wire [3:0]   _mshrs_0_io_mem_finish_bits_sink;
  wire         _mshrs_0_io_refill_valid;
  wire [7:0]   _mshrs_0_io_refill_bits_way_en;
  wire [11:0]  _mshrs_0_io_refill_bits_addr;
  wire [127:0] _mshrs_0_io_refill_bits_data;
  wire         _mshrs_0_io_meta_write_valid;
  wire [5:0]   _mshrs_0_io_meta_write_bits_idx;
  wire [7:0]   _mshrs_0_io_meta_write_bits_way_en;
  wire [1:0]   _mshrs_0_io_meta_write_bits_data_coh_state;
  wire [19:0]  _mshrs_0_io_meta_write_bits_data_tag;
  wire         _mshrs_0_io_meta_read_valid;
  wire [5:0]   _mshrs_0_io_meta_read_bits_idx;
  wire [7:0]   _mshrs_0_io_meta_read_bits_way_en;
  wire [19:0]  _mshrs_0_io_meta_read_bits_tag;
  wire         _mshrs_0_io_wb_req_valid;
  wire [19:0]  _mshrs_0_io_wb_req_bits_tag;
  wire [5:0]   _mshrs_0_io_wb_req_bits_idx;
  wire [2:0]   _mshrs_0_io_wb_req_bits_param;
  wire [7:0]   _mshrs_0_io_wb_req_bits_way_en;
  wire         _mshrs_0_io_commit_val;
  wire [39:0]  _mshrs_0_io_commit_addr;
  wire [1:0]   _mshrs_0_io_commit_coh_state;
  wire         _mshrs_0_io_lb_read_valid;
  wire [2:0]   _mshrs_0_io_lb_read_bits_id;
  wire [1:0]   _mshrs_0_io_lb_read_bits_offset;
  wire         _mshrs_0_io_lb_write_valid;
  wire [2:0]   _mshrs_0_io_lb_write_bits_id;
  wire [1:0]   _mshrs_0_io_lb_write_bits_offset;
  wire [127:0] _mshrs_0_io_lb_write_bits_data;
  wire         _mshrs_0_io_replay_valid;
  wire [19:0]  _mshrs_0_io_replay_bits_uop_br_mask;
  wire [4:0]   _mshrs_0_io_replay_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_0_io_replay_bits_uop_stq_idx;
  wire [4:0]   _mshrs_0_io_replay_bits_uop_mem_cmd;
  wire [1:0]   _mshrs_0_io_replay_bits_uop_mem_size;
  wire         _mshrs_0_io_replay_bits_uop_mem_signed;
  wire         _mshrs_0_io_replay_bits_uop_is_amo;
  wire         _mshrs_0_io_replay_bits_uop_uses_ldq;
  wire         _mshrs_0_io_replay_bits_uop_uses_stq;
  wire [39:0]  _mshrs_0_io_replay_bits_addr;
  wire         _mshrs_0_io_replay_bits_is_hella;
  wire [7:0]   _mshrs_0_io_replay_bits_way_en;
  wire [4:0]   _mshrs_0_io_replay_bits_sdq_id;
  wire         _mshrs_0_io_resp_valid;
  wire [19:0]  _mshrs_0_io_resp_bits_uop_br_mask;
  wire [4:0]   _mshrs_0_io_resp_bits_uop_ldq_idx;
  wire [4:0]   _mshrs_0_io_resp_bits_uop_stq_idx;
  wire         _mshrs_0_io_resp_bits_uop_is_amo;
  wire         _mshrs_0_io_resp_bits_uop_uses_ldq;
  wire         _mshrs_0_io_resp_bits_uop_uses_stq;
  wire [63:0]  _mshrs_0_io_resp_bits_data;
  wire         _mshrs_0_io_resp_bits_is_hella;
  wire         _mshrs_0_io_probe_rdy;
  wire         _refill_arb_io_in_0_ready;
  wire         _refill_arb_io_in_1_ready;
  wire         _refill_arb_io_in_2_ready;
  wire         _refill_arb_io_in_3_ready;
  wire         _refill_arb_io_in_4_ready;
  wire         _refill_arb_io_in_5_ready;
  wire         _refill_arb_io_in_6_ready;
  wire         _refill_arb_io_in_7_ready;
  wire         _resp_arb_io_in_0_ready;
  wire         _resp_arb_io_in_1_ready;
  wire         _resp_arb_io_in_2_ready;
  wire         _resp_arb_io_in_3_ready;
  wire         _resp_arb_io_in_4_ready;
  wire         _resp_arb_io_in_5_ready;
  wire         _resp_arb_io_in_6_ready;
  wire         _resp_arb_io_in_7_ready;
  wire         _resp_arb_io_in_8_ready;
  wire         _resp_arb_io_out_valid;
  wire [19:0]  _resp_arb_io_out_bits_uop_br_mask;
  wire [4:0]   _resp_arb_io_out_bits_uop_ldq_idx;
  wire [4:0]   _resp_arb_io_out_bits_uop_stq_idx;
  wire         _resp_arb_io_out_bits_uop_is_amo;
  wire         _resp_arb_io_out_bits_uop_uses_ldq;
  wire         _resp_arb_io_out_bits_uop_uses_stq;
  wire [63:0]  _resp_arb_io_out_bits_data;
  wire         _resp_arb_io_out_bits_is_hella;
  wire         _replay_arb_io_in_0_ready;
  wire         _replay_arb_io_in_1_ready;
  wire         _replay_arb_io_in_2_ready;
  wire         _replay_arb_io_in_3_ready;
  wire         _replay_arb_io_in_4_ready;
  wire         _replay_arb_io_in_5_ready;
  wire         _replay_arb_io_in_6_ready;
  wire         _replay_arb_io_in_7_ready;
  wire         _replay_arb_io_out_valid;
  wire [4:0]   _replay_arb_io_out_bits_uop_mem_cmd;
  wire [4:0]   _replay_arb_io_out_bits_sdq_id;
  wire         _wb_req_arb_io_in_0_ready;
  wire         _wb_req_arb_io_in_1_ready;
  wire         _wb_req_arb_io_in_2_ready;
  wire         _wb_req_arb_io_in_3_ready;
  wire         _wb_req_arb_io_in_4_ready;
  wire         _wb_req_arb_io_in_5_ready;
  wire         _wb_req_arb_io_in_6_ready;
  wire         _wb_req_arb_io_in_7_ready;
  wire         _meta_read_arb_io_in_0_ready;
  wire         _meta_read_arb_io_in_1_ready;
  wire         _meta_read_arb_io_in_2_ready;
  wire         _meta_read_arb_io_in_3_ready;
  wire         _meta_read_arb_io_in_4_ready;
  wire         _meta_read_arb_io_in_5_ready;
  wire         _meta_read_arb_io_in_6_ready;
  wire         _meta_read_arb_io_in_7_ready;
  wire         _meta_write_arb_io_in_0_ready;
  wire         _meta_write_arb_io_in_1_ready;
  wire         _meta_write_arb_io_in_2_ready;
  wire         _meta_write_arb_io_in_3_ready;
  wire         _meta_write_arb_io_in_4_ready;
  wire         _meta_write_arb_io_in_5_ready;
  wire         _meta_write_arb_io_in_6_ready;
  wire         _meta_write_arb_io_in_7_ready;
  wire         _lb_write_arb_io_in_1_ready;
  wire         _lb_write_arb_io_in_2_ready;
  wire         _lb_write_arb_io_in_3_ready;
  wire         _lb_write_arb_io_in_4_ready;
  wire         _lb_write_arb_io_in_5_ready;
  wire         _lb_write_arb_io_in_6_ready;
  wire         _lb_write_arb_io_in_7_ready;
  wire         _lb_write_arb_io_out_valid;
  wire [2:0]   _lb_write_arb_io_out_bits_id;
  wire [1:0]   _lb_write_arb_io_out_bits_offset;
  wire [127:0] _lb_write_arb_io_out_bits_data;
  wire         _lb_read_arb_io_in_0_ready;
  wire         _lb_read_arb_io_in_1_ready;
  wire         _lb_read_arb_io_in_2_ready;
  wire         _lb_read_arb_io_in_3_ready;
  wire         _lb_read_arb_io_in_4_ready;
  wire         _lb_read_arb_io_in_5_ready;
  wire         _lb_read_arb_io_in_6_ready;
  wire         _lb_read_arb_io_in_7_ready;
  wire         _lb_read_arb_io_out_valid;
  wire [2:0]   _lb_read_arb_io_out_bits_id;
  wire [1:0]   _lb_read_arb_io_out_bits_offset;
  wire [127:0] _lb_ext_R0_data;
  reg          casez_tmp;
  wire [39:0]  _io_req_req_idx_bits_addr_9 = io_req_1_valid ? io_req_1_bits_addr : io_req_0_bits_addr;
  reg  [16:0]  sdq_val;
  wire [15:0]  _sdq_alloc_id_T_1 = ~(sdq_val[15:0]);
  wire [4:0]   sdq_alloc_id = _sdq_alloc_id_T_1[0] ? 5'h0 : _sdq_alloc_id_T_1[1] ? 5'h1 : _sdq_alloc_id_T_1[2] ? 5'h2 : _sdq_alloc_id_T_1[3] ? 5'h3 : _sdq_alloc_id_T_1[4] ? 5'h4 : _sdq_alloc_id_T_1[5] ? 5'h5 : _sdq_alloc_id_T_1[6] ? 5'h6 : _sdq_alloc_id_T_1[7] ? 5'h7 : _sdq_alloc_id_T_1[8] ? 5'h8 : _sdq_alloc_id_T_1[9] ? 5'h9 : _sdq_alloc_id_T_1[10] ? 5'hA : _sdq_alloc_id_T_1[11] ? 5'hB : _sdq_alloc_id_T_1[12] ? 5'hC : _sdq_alloc_id_T_1[13] ? 5'hD : _sdq_alloc_id_T_1[14] ? 5'hE : _sdq_alloc_id_T_1[15] ? 5'hF : 5'h10;
  wire         sdq_rdy = sdq_val != 17'h1FFFF;
  wire         _io_req_req_idx_valid_25 = io_req_1_valid ? io_req_1_valid : io_req_0_valid;
  wire [4:0]   _io_req_req_idx_bits_uop_mem_cmd_19 = io_req_1_valid ? io_req_1_bits_uop_mem_cmd : io_req_0_bits_uop_mem_cmd;
  wire         sdq_enq = (io_req_1_valid ? _io_req_1_ready_output : _io_req_0_ready_output) & _io_req_req_idx_valid_25 & _io_req_req_idx_bits_addr_9[31] & (_io_req_req_idx_bits_uop_mem_cmd_19 == 5'h1 | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'h11 | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'h7 | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'h4 | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'h9 | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'hA | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'hB | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'h8 | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'hC | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'hD | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'hE | _io_req_req_idx_bits_uop_mem_cmd_19 == 5'hF);
  wire [63:0]  _io_req_req_idx_bits_data_8 = io_req_1_valid ? io_req_1_bits_data : io_req_0_bits_data;
  wire         _GEN_17 = ~_lb_write_arb_io_out_valid & _lb_read_arb_io_out_valid;
  wire [127:0] lb_read_data = _lb_write_arb_io_out_valid | ~_GEN_17 ? 128'h0 : _lb_ext_R0_data;
  wire         idx_matches_0_0 = _mshrs_0_io_idx_valid & _mshrs_0_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         idx_matches_0_1 = _mshrs_1_io_idx_valid & _mshrs_1_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         idx_matches_0_2 = _mshrs_2_io_idx_valid & _mshrs_2_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         idx_matches_0_3 = _mshrs_3_io_idx_valid & _mshrs_3_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         idx_matches_0_4 = _mshrs_4_io_idx_valid & _mshrs_4_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         idx_matches_0_5 = _mshrs_5_io_idx_valid & _mshrs_5_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         idx_matches_0_6 = _mshrs_6_io_idx_valid & _mshrs_6_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         idx_matches_0_7 = _mshrs_7_io_idx_valid & _mshrs_7_io_idx_bits == io_req_0_bits_addr[11:6];
  wire         tag_match_0 = idx_matches_0_0 & _mshrs_0_io_tag_valid & _mshrs_0_io_tag_bits == io_req_0_bits_addr[39:12] | idx_matches_0_1 & _mshrs_1_io_tag_valid & _mshrs_1_io_tag_bits == io_req_0_bits_addr[39:12] | idx_matches_0_2 & _mshrs_2_io_tag_valid & _mshrs_2_io_tag_bits == io_req_0_bits_addr[39:12] | idx_matches_0_3 & _mshrs_3_io_tag_valid & _mshrs_3_io_tag_bits == io_req_0_bits_addr[39:12] | idx_matches_0_4 & _mshrs_4_io_tag_valid & _mshrs_4_io_tag_bits == io_req_0_bits_addr[39:12] | idx_matches_0_5 & _mshrs_5_io_tag_valid & _mshrs_5_io_tag_bits == io_req_0_bits_addr[39:12] | idx_matches_0_6 & _mshrs_6_io_tag_valid & _mshrs_6_io_tag_bits == io_req_0_bits_addr[39:12] | idx_matches_0_7 & _mshrs_7_io_tag_valid & _mshrs_7_io_tag_bits == io_req_0_bits_addr[39:12];
  wire         idx_matches_1_0 = _mshrs_0_io_idx_valid & _mshrs_0_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         idx_matches_1_1 = _mshrs_1_io_idx_valid & _mshrs_1_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         idx_matches_1_2 = _mshrs_2_io_idx_valid & _mshrs_2_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         idx_matches_1_3 = _mshrs_3_io_idx_valid & _mshrs_3_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         idx_matches_1_4 = _mshrs_4_io_idx_valid & _mshrs_4_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         idx_matches_1_5 = _mshrs_5_io_idx_valid & _mshrs_5_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         idx_matches_1_6 = _mshrs_6_io_idx_valid & _mshrs_6_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         idx_matches_1_7 = _mshrs_7_io_idx_valid & _mshrs_7_io_idx_bits == io_req_1_bits_addr[11:6];
  wire         tag_match_1 = idx_matches_1_0 & _mshrs_0_io_tag_valid & _mshrs_0_io_tag_bits == io_req_1_bits_addr[39:12] | idx_matches_1_1 & _mshrs_1_io_tag_valid & _mshrs_1_io_tag_bits == io_req_1_bits_addr[39:12] | idx_matches_1_2 & _mshrs_2_io_tag_valid & _mshrs_2_io_tag_bits == io_req_1_bits_addr[39:12] | idx_matches_1_3 & _mshrs_3_io_tag_valid & _mshrs_3_io_tag_bits == io_req_1_bits_addr[39:12] | idx_matches_1_4 & _mshrs_4_io_tag_valid & _mshrs_4_io_tag_bits == io_req_1_bits_addr[39:12] | idx_matches_1_5 & _mshrs_5_io_tag_valid & _mshrs_5_io_tag_bits == io_req_1_bits_addr[39:12] | idx_matches_1_6 & _mshrs_6_io_tag_valid & _mshrs_6_io_tag_bits == io_req_1_bits_addr[39:12] | idx_matches_1_7 & _mshrs_7_io_tag_valid & _mshrs_7_io_tag_bits == io_req_1_bits_addr[39:12];
  wire         idx_match_0 = idx_matches_0_0 | idx_matches_0_1 | idx_matches_0_2 | idx_matches_0_3 | idx_matches_0_4 | idx_matches_0_5 | idx_matches_0_6 | idx_matches_0_7;
  wire         idx_match_1 = idx_matches_1_0 | idx_matches_1_1 | idx_matches_1_2 | idx_matches_1_3 | idx_matches_1_4 | idx_matches_1_5 | idx_matches_1_6 | idx_matches_1_7;
  wire         pri_val = _io_req_req_idx_valid_25 & sdq_rdy & _io_req_req_idx_bits_addr_9[31] & ~(io_req_1_valid ? idx_match_1 : idx_match_0);
  reg  [2:0]   mshr_alloc_idx;
  wire         _mshr_io_req_pri_val_T = mshr_alloc_idx == 3'h0;
  wire         _tag_match_req_idx_14 = io_req_1_valid ? tag_match_1 : tag_match_0;
  wire         _idx_matches_req_idx_0_1 = io_req_1_valid ? idx_matches_1_0 : idx_matches_0_0;
  wire         _mshr_io_req_sec_val_T_3 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_0_1 & _io_req_req_idx_bits_addr_9[31];
  wire [7:0]   _io_req_req_idx_bits_way_en_6 = io_req_1_valid ? io_req_1_bits_way_en : io_req_0_bits_way_en;
  wire [19:0]  _io_req_req_idx_bits_old_meta_tag_6 = io_req_1_valid ? io_req_1_bits_old_meta_tag : io_req_0_bits_old_meta_tag;
  wire [1:0]   _io_req_req_idx_bits_old_meta_coh_state_6 = io_req_1_valid ? io_req_1_bits_old_meta_coh_state : io_req_0_bits_old_meta_coh_state;
  wire         _io_req_req_idx_bits_tag_match_6 = io_req_1_valid ? io_req_1_bits_tag_match : io_req_0_bits_tag_match;
  wire         _io_req_req_idx_bits_is_hella_7 = io_req_1_valid ? io_req_1_bits_is_hella : io_req_0_bits_is_hella;
  wire         _io_req_req_idx_bits_uop_uses_stq_7 = io_req_1_valid ? io_req_1_bits_uop_uses_stq : io_req_0_bits_uop_uses_stq;
  wire         _io_req_req_idx_bits_uop_uses_ldq_7 = io_req_1_valid ? io_req_1_bits_uop_uses_ldq : io_req_0_bits_uop_uses_ldq;
  wire         _io_req_req_idx_bits_uop_is_amo_7 = io_req_1_valid ? io_req_1_bits_uop_is_amo : io_req_0_bits_uop_is_amo;
  wire         _io_req_req_idx_bits_uop_mem_signed_7 = io_req_1_valid ? io_req_1_bits_uop_mem_signed : io_req_0_bits_uop_mem_signed;
  wire [1:0]   _io_req_req_idx_bits_uop_mem_size_7 = io_req_1_valid ? io_req_1_bits_uop_mem_size : io_req_0_bits_uop_mem_size;
  wire [4:0]   _io_req_req_idx_bits_uop_stq_idx_7 = io_req_1_valid ? io_req_1_bits_uop_stq_idx : io_req_0_bits_uop_stq_idx;
  wire [4:0]   _io_req_req_idx_bits_uop_ldq_idx_7 = io_req_1_valid ? io_req_1_bits_uop_ldq_idx : io_req_0_bits_uop_ldq_idx;
  wire [19:0]  _io_req_req_idx_bits_uop_br_mask_7 = io_req_1_valid ? io_req_1_bits_uop_br_mask : io_req_0_bits_uop_br_mask;
  wire         _GEN = io_mem_grant_bits_source == 4'h0;
  wire         _idx_matches_req_idx_1_1 = io_req_1_valid ? idx_matches_1_1 : idx_matches_0_1;
  wire         _mshr_io_req_sec_val_T_7 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_1_1 & _io_req_req_idx_bits_addr_9[31];
  wire         _GEN_0 = io_mem_grant_bits_source == 4'h1;
  wire         _idx_matches_req_idx_2_1 = io_req_1_valid ? idx_matches_1_2 : idx_matches_0_2;
  wire         _mshr_io_req_sec_val_T_11 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_2_1 & _io_req_req_idx_bits_addr_9[31];
  wire         _GEN_1 = io_mem_grant_bits_source == 4'h2;
  wire         _idx_matches_req_idx_3_1 = io_req_1_valid ? idx_matches_1_3 : idx_matches_0_3;
  wire         _mshr_io_req_sec_val_T_15 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_3_1 & _io_req_req_idx_bits_addr_9[31];
  wire         _GEN_2 = io_mem_grant_bits_source == 4'h3;
  wire         _idx_matches_req_idx_4_1 = io_req_1_valid ? idx_matches_1_4 : idx_matches_0_4;
  wire         _mshr_io_req_sec_val_T_19 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_4_1 & _io_req_req_idx_bits_addr_9[31];
  wire         _GEN_3 = io_mem_grant_bits_source == 4'h4;
  wire         _idx_matches_req_idx_5_1 = io_req_1_valid ? idx_matches_1_5 : idx_matches_0_5;
  wire         _mshr_io_req_sec_val_T_23 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_5_1 & _io_req_req_idx_bits_addr_9[31];
  wire         _GEN_4 = io_mem_grant_bits_source == 4'h5;
  wire         _idx_matches_req_idx_6_1 = io_req_1_valid ? idx_matches_1_6 : idx_matches_0_6;
  wire         _mshr_io_req_sec_val_T_27 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_6_1 & _io_req_req_idx_bits_addr_9[31];
  wire         _GEN_5 = io_mem_grant_bits_source == 4'h6;
  always @(*) begin
    casez (mshr_alloc_idx)
      3'b000:
        casez_tmp = _mshr_io_req_pri_val_T & _mshrs_0_io_req_pri_rdy;
      3'b001:
        casez_tmp = _mshrs_1_io_req_pri_rdy;
      3'b010:
        casez_tmp = _mshrs_2_io_req_pri_rdy;
      3'b011:
        casez_tmp = _mshrs_3_io_req_pri_rdy;
      3'b100:
        casez_tmp = _mshrs_4_io_req_pri_rdy;
      3'b101:
        casez_tmp = _mshrs_5_io_req_pri_rdy;
      3'b110:
        casez_tmp = _mshrs_6_io_req_pri_rdy;
      default:
        casez_tmp = _mshrs_7_io_req_pri_rdy;
    endcase
  end // always @(*)
  wire         _idx_matches_req_idx_7_1 = io_req_1_valid ? idx_matches_1_7 : idx_matches_0_7;
  wire         _mshr_io_req_sec_val_T_31 = _io_req_req_idx_valid_25 & sdq_rdy & _tag_match_req_idx_14 & _idx_matches_req_idx_7_1 & _io_req_req_idx_bits_addr_9[31];
  wire         _GEN_6 = io_mem_grant_bits_source == 4'h7;
  wire         _GEN_7 = _mshrs_0_io_req_sec_rdy & _mshr_io_req_sec_val_T_3 | _mshrs_1_io_req_sec_rdy & _mshr_io_req_sec_val_T_7 | _mshrs_2_io_req_sec_rdy & _mshr_io_req_sec_val_T_11 | _mshrs_3_io_req_sec_rdy & _mshr_io_req_sec_val_T_15 | _mshrs_4_io_req_sec_rdy & _mshr_io_req_sec_val_T_19 | _mshrs_5_io_req_sec_rdy & _mshr_io_req_sec_val_T_23 | _mshrs_6_io_req_sec_rdy & _mshr_io_req_sec_val_T_27 | _mshrs_7_io_req_sec_rdy & _mshr_io_req_sec_val_T_31;
  reg  [2:0]   mshr_head;
  wire         _mshr_io_mem_ack_valid_T = io_mem_grant_bits_source == 4'h9;
  reg  [7:0]   beatsLeft;
  wire         idle = beatsLeft == 8'h0;
  wire         _GEN_8 = _mshrs_5_io_mem_acquire_valid | _mshrs_4_io_mem_acquire_valid;
  wire         _GEN_9 = _mshrs_4_io_mem_acquire_valid | _mshrs_3_io_mem_acquire_valid;
  wire         _GEN_10 = _mshrs_3_io_mem_acquire_valid | _mshrs_2_io_mem_acquire_valid;
  wire         _GEN_11 = _mshrs_2_io_mem_acquire_valid | _mshrs_1_io_mem_acquire_valid;
  wire         _GEN_12 = _mshrs_1_io_mem_acquire_valid | _mshrs_0_io_mem_acquire_valid;
  wire         _GEN_13 = _GEN_10 | _GEN_12;
  wire         _GEN_14 = _GEN_11 | _mshrs_0_io_mem_acquire_valid;
  wire         _GEN_15 = _mshrs_7_io_mem_acquire_valid | _mshrs_6_io_mem_acquire_valid | _GEN_8 | _GEN_13;
  wire         _GEN_16 = _mshrs_6_io_mem_acquire_valid | _mshrs_5_io_mem_acquire_valid | _GEN_9 | _GEN_14;
  wire         _GEN_18 = _GEN_8 | _GEN_10 | _GEN_12;
  wire         _GEN_19 = _GEN_9 | _GEN_11 | _mshrs_0_io_mem_acquire_valid;
  wire         winner__1 = ~_mshrs_0_io_mem_acquire_valid & _mshrs_1_io_mem_acquire_valid;
  wire         winner__2 = ~_GEN_12 & _mshrs_2_io_mem_acquire_valid;
  wire         winner__3 = ~_GEN_14 & _mshrs_3_io_mem_acquire_valid;
  wire         winner__4 = ~_GEN_13 & _mshrs_4_io_mem_acquire_valid;
  wire         winner__5 = ~_GEN_19 & _mshrs_5_io_mem_acquire_valid;
  wire         winner__6 = ~_GEN_18 & _mshrs_6_io_mem_acquire_valid;
  wire         winner__7 = ~_GEN_16 & _mshrs_7_io_mem_acquire_valid;
  wire         winner__8 = ~_GEN_15 & _mmios_0_io_mem_access_valid;
  wire         _io_mem_acquire_valid_T = _mshrs_0_io_mem_acquire_valid | _mshrs_1_io_mem_acquire_valid;
  reg          state__0;
  reg          state__1;
  reg          state__2;
  reg          state__3;
  reg          state__4;
  reg          state__5;
  reg          state__6;
  reg          state__7;
  reg          state__8;
  wire         muxState__0 = idle ? _mshrs_0_io_mem_acquire_valid : state__0;
  wire         muxState__1 = idle ? winner__1 : state__1;
  wire         muxState__2 = idle ? winner__2 : state__2;
  wire         muxState__3 = idle ? winner__3 : state__3;
  wire         muxState__4 = idle ? winner__4 : state__4;
  wire         muxState__5 = idle ? winner__5 : state__5;
  wire         muxState__6 = idle ? winner__6 : state__6;
  wire         muxState__7 = idle ? winner__7 : state__7;
  wire         muxState__8 = idle ? winner__8 : state__8;
  wire         _io_mem_acquire_valid_output = idle ? _io_mem_acquire_valid_T | _mshrs_2_io_mem_acquire_valid | _mshrs_3_io_mem_acquire_valid | _mshrs_4_io_mem_acquire_valid | _mshrs_5_io_mem_acquire_valid | _mshrs_6_io_mem_acquire_valid | _mshrs_7_io_mem_acquire_valid | _mmios_0_io_mem_access_valid : state__0 & _mshrs_0_io_mem_acquire_valid | state__1 & _mshrs_1_io_mem_acquire_valid | state__2 & _mshrs_2_io_mem_acquire_valid | state__3 & _mshrs_3_io_mem_acquire_valid | state__4 & _mshrs_4_io_mem_acquire_valid | state__5 & _mshrs_5_io_mem_acquire_valid | state__6 & _mshrs_6_io_mem_acquire_valid | state__7 & _mshrs_7_io_mem_acquire_valid | state__8 & _mmios_0_io_mem_access_valid;
  wire         _GEN_20 = muxState__0 | muxState__1 | muxState__2 | muxState__3 | muxState__4 | muxState__5 | muxState__6 | muxState__7;
  reg          beatsLeft_1;
  wire         _GEN_21 = _mshrs_4_io_mem_finish_valid | _mshrs_3_io_mem_finish_valid;
  wire         _GEN_22 = _mshrs_3_io_mem_finish_valid | _mshrs_2_io_mem_finish_valid;
  wire         _GEN_23 = _mshrs_2_io_mem_finish_valid | _mshrs_1_io_mem_finish_valid;
  wire         _GEN_24 = _mshrs_1_io_mem_finish_valid | _mshrs_0_io_mem_finish_valid;
  wire         _GEN_25 = _GEN_22 | _GEN_24;
  wire         _GEN_26 = _GEN_23 | _mshrs_0_io_mem_finish_valid;
  wire         _GEN_27 = _mshrs_6_io_mem_finish_valid | _mshrs_5_io_mem_finish_valid | _GEN_21 | _GEN_26;
  wire         _GEN_28 = _mshrs_5_io_mem_finish_valid | _mshrs_4_io_mem_finish_valid | _GEN_22 | _GEN_24;
  wire         _GEN_29 = _GEN_21 | _GEN_23 | _mshrs_0_io_mem_finish_valid;
  wire         winner_1_1 = ~_mshrs_0_io_mem_finish_valid & _mshrs_1_io_mem_finish_valid;
  wire         winner_1_2 = ~_GEN_24 & _mshrs_2_io_mem_finish_valid;
  wire         winner_1_3 = ~_GEN_26 & _mshrs_3_io_mem_finish_valid;
  wire         winner_1_4 = ~_GEN_25 & _mshrs_4_io_mem_finish_valid;
  wire         winner_1_5 = ~_GEN_29 & _mshrs_5_io_mem_finish_valid;
  wire         winner_1_6 = ~_GEN_28 & _mshrs_6_io_mem_finish_valid;
  wire         winner_1_7 = ~_GEN_27 & _mshrs_7_io_mem_finish_valid;
  wire         _io_mem_finish_valid_T = _mshrs_0_io_mem_finish_valid | _mshrs_1_io_mem_finish_valid;
  reg          state_1_0;
  reg          state_1_1;
  reg          state_1_2;
  reg          state_1_3;
  reg          state_1_4;
  reg          state_1_5;
  reg          state_1_6;
  reg          state_1_7;
  wire         _io_mem_finish_valid_output = beatsLeft_1 ? state_1_0 & _mshrs_0_io_mem_finish_valid | state_1_1 & _mshrs_1_io_mem_finish_valid | state_1_2 & _mshrs_2_io_mem_finish_valid | state_1_3 & _mshrs_3_io_mem_finish_valid | state_1_4 & _mshrs_4_io_mem_finish_valid | state_1_5 & _mshrs_5_io_mem_finish_valid | state_1_6 & _mshrs_6_io_mem_finish_valid | state_1_7 & _mshrs_7_io_mem_finish_valid : _io_mem_finish_valid_T | _mshrs_2_io_mem_finish_valid | _mshrs_3_io_mem_finish_valid | _mshrs_4_io_mem_finish_valid | _mshrs_5_io_mem_finish_valid | _mshrs_6_io_mem_finish_valid | _mshrs_7_io_mem_finish_valid;
  assign _io_req_0_ready_output = ~io_req_1_valid & (_io_req_req_idx_bits_addr_9[31] ? sdq_rdy & (idx_match_0 ? tag_match_0 & _GEN_7 : casez_tmp) : _mmios_0_io_req_ready);
  assign _io_req_1_ready_output = io_req_1_valid & (_io_req_req_idx_bits_addr_9[31] ? sdq_rdy & (idx_match_1 ? tag_match_1 & _GEN_7 : casez_tmp) : _mmios_0_io_req_ready);
  reg          prefetcher_io_mshr_avail_REG;
  reg          prefetcher_io_req_val_REG;
  reg  [39:0]  prefetcher_io_req_addr_REG;
  reg  [1:0]   prefetcher_io_req_coh_REG_state;
  wire [26:0]  _decode_T_33 = 27'hFFF << _mmios_0_io_mem_access_bits_size;
  wire [16:0]  _sdq_val_T_7 = ~sdq_val;
  wire [31:0]  _sdq_val_T = 32'h1 << _replay_arb_io_out_bits_sdq_id;
  always @(posedge clock) begin
    sdq_val <= reset ? 17'h0 : _replay_arb_io_out_valid | sdq_enq ? ~(_sdq_val_T[16:0] & {17{io_replay_ready & _replay_arb_io_out_valid & (_replay_arb_io_out_bits_uop_mem_cmd == 5'h1 | _replay_arb_io_out_bits_uop_mem_cmd == 5'h11 | _replay_arb_io_out_bits_uop_mem_cmd == 5'h7 | _replay_arb_io_out_bits_uop_mem_cmd == 5'h4 | _replay_arb_io_out_bits_uop_mem_cmd == 5'h9 | _replay_arb_io_out_bits_uop_mem_cmd == 5'hA | _replay_arb_io_out_bits_uop_mem_cmd == 5'hB | _replay_arb_io_out_bits_uop_mem_cmd == 5'h8 | _replay_arb_io_out_bits_uop_mem_cmd == 5'hC | _replay_arb_io_out_bits_uop_mem_cmd == 5'hD | _replay_arb_io_out_bits_uop_mem_cmd == 5'hE | _replay_arb_io_out_bits_uop_mem_cmd == 5'hF)}}) & sdq_val | (_sdq_val_T_7[0] ? 17'h1 : _sdq_val_T_7[1] ? 17'h2 : _sdq_val_T_7[2] ? 17'h4 : _sdq_val_T_7[3] ? 17'h8 : _sdq_val_T_7[4] ? 17'h10 : _sdq_val_T_7[5] ? 17'h20 : _sdq_val_T_7[6] ? 17'h40 : _sdq_val_T_7[7] ? 17'h80 : _sdq_val_T_7[8] ? 17'h100 : _sdq_val_T_7[9] ? 17'h200 : _sdq_val_T_7[10] ? 17'h400 : _sdq_val_T_7[11] ? 17'h800 : _sdq_val_T_7[12] ? 17'h1000 : _sdq_val_T_7[13] ? 17'h2000 : _sdq_val_T_7[14] ? 17'h4000 : _sdq_val_T_7[15] ? 17'h8000 : {_sdq_val_T_7[16], 16'h0}) & {17{sdq_enq}} : sdq_val;
    mshr_alloc_idx <= _mshrs_0_io_req_pri_rdy & mshr_head == 3'h0 ? 3'h0 : _mshrs_1_io_req_pri_rdy & mshr_head < 3'h2 ? 3'h1 : _mshrs_2_io_req_pri_rdy & mshr_head < 3'h3 ? 3'h2 : _mshrs_3_io_req_pri_rdy & ~(mshr_head[2]) ? 3'h3 : _mshrs_4_io_req_pri_rdy & mshr_head < 3'h5 ? 3'h4 : _mshrs_5_io_req_pri_rdy & mshr_head[2:1] != 2'h3 ? 3'h5 : _mshrs_6_io_req_pri_rdy & mshr_head != 3'h7 ? 3'h6 : _mshrs_7_io_req_pri_rdy ? 3'h7 : _mshrs_0_io_req_pri_rdy ? 3'h0 : _mshrs_1_io_req_pri_rdy ? 3'h1 : _mshrs_2_io_req_pri_rdy ? 3'h2 : _mshrs_3_io_req_pri_rdy ? 3'h3 : _mshrs_4_io_req_pri_rdy ? 3'h4 : _mshrs_5_io_req_pri_rdy ? 3'h5 : {2'h3, ~_mshrs_6_io_req_pri_rdy};
    prefetcher_io_mshr_avail_REG <= casez_tmp;
    prefetcher_io_req_val_REG <= _mshrs_0_io_commit_val | _mshrs_1_io_commit_val | _mshrs_2_io_commit_val | _mshrs_3_io_commit_val | _mshrs_4_io_commit_val | _mshrs_5_io_commit_val | _mshrs_6_io_commit_val | _mshrs_7_io_commit_val;
    prefetcher_io_req_addr_REG <= (_mshrs_0_io_commit_val ? _mshrs_0_io_commit_addr : 40'h0) | (_mshrs_1_io_commit_val ? _mshrs_1_io_commit_addr : 40'h0) | (_mshrs_2_io_commit_val ? _mshrs_2_io_commit_addr : 40'h0) | (_mshrs_3_io_commit_val ? _mshrs_3_io_commit_addr : 40'h0) | (_mshrs_4_io_commit_val ? _mshrs_4_io_commit_addr : 40'h0) | (_mshrs_5_io_commit_val ? _mshrs_5_io_commit_addr : 40'h0) | (_mshrs_6_io_commit_val ? _mshrs_6_io_commit_addr : 40'h0) | (_mshrs_7_io_commit_val ? _mshrs_7_io_commit_addr : 40'h0);
    prefetcher_io_req_coh_REG_state <= (_mshrs_0_io_commit_val ? _mshrs_0_io_commit_coh_state : 2'h0) | (_mshrs_1_io_commit_val ? _mshrs_1_io_commit_coh_state : 2'h0) | (_mshrs_2_io_commit_val ? _mshrs_2_io_commit_coh_state : 2'h0) | (_mshrs_3_io_commit_val ? _mshrs_3_io_commit_coh_state : 2'h0) | (_mshrs_4_io_commit_val ? _mshrs_4_io_commit_coh_state : 2'h0) | (_mshrs_5_io_commit_val ? _mshrs_5_io_commit_coh_state : 2'h0) | (_mshrs_6_io_commit_val ? _mshrs_6_io_commit_coh_state : 2'h0) | (_mshrs_7_io_commit_val ? _mshrs_7_io_commit_coh_state : 2'h0);
    if (reset) begin
      mshr_head <= 3'h0;
      beatsLeft <= 8'h0;
      state__0 <= 1'h0;
      state__1 <= 1'h0;
      state__2 <= 1'h0;
      state__3 <= 1'h0;
      state__4 <= 1'h0;
      state__5 <= 1'h0;
      state__6 <= 1'h0;
      state__7 <= 1'h0;
      state__8 <= 1'h0;
      beatsLeft_1 <= 1'h0;
      state_1_0 <= 1'h0;
      state_1_1 <= 1'h0;
      state_1_2 <= 1'h0;
      state_1_3 <= 1'h0;
      state_1_4 <= 1'h0;
      state_1_5 <= 1'h0;
      state_1_6 <= 1'h0;
      state_1_7 <= 1'h0;
    end
    else begin
      if (casez_tmp & pri_val)
        mshr_head <= mshr_head + 3'h1;
      if (idle & io_mem_acquire_ready) begin
        if (winner__8 & ~(_mmios_0_io_mem_access_bits_opcode[2]))
          beatsLeft <= ~(_decode_T_33[11:4]);
        else
          beatsLeft <= 8'h0;
      end
      else
        beatsLeft <= beatsLeft - {7'h0, io_mem_acquire_ready & _io_mem_acquire_valid_output};
      if (idle) begin
        state__0 <= _mshrs_0_io_mem_acquire_valid;
        state__1 <= winner__1;
        state__2 <= winner__2;
        state__3 <= winner__3;
        state__4 <= winner__4;
        state__5 <= winner__5;
        state__6 <= winner__6;
        state__7 <= winner__7;
        state__8 <= winner__8;
      end
      beatsLeft_1 <= ~(~beatsLeft_1 & io_mem_finish_ready) & beatsLeft_1 - (io_mem_finish_ready & _io_mem_finish_valid_output);
      if (beatsLeft_1) begin
      end
      else begin
        state_1_0 <= _mshrs_0_io_mem_finish_valid;
        state_1_1 <= winner_1_1;
        state_1_2 <= winner_1_2;
        state_1_3 <= winner_1_3;
        state_1_4 <= winner_1_4;
        state_1_5 <= winner_1_5;
        state_1_6 <= winner_1_6;
        state_1_7 <= winner_1_7;
      end
    end
  end // always @(posedge)
  NLPrefetcher prefetcher (
    .clock                        (clock),
    .reset                        (reset),
    .io_mshr_avail                (prefetcher_io_mshr_avail_REG),
    .io_req_val                   (prefetcher_io_req_val_REG),
    .io_req_addr                  (prefetcher_io_req_addr_REG),
    .io_req_coh_state             (prefetcher_io_req_coh_REG_state),
    .io_prefetch_ready            (io_prefetch_ready),
    .io_prefetch_valid            (io_prefetch_valid),
    .io_prefetch_bits_uop_mem_cmd (io_prefetch_bits_uop_mem_cmd),
    .io_prefetch_bits_addr        (io_prefetch_bits_addr)
  );
  sdq_17x64 sdq_ext (
    .R0_addr (_replay_arb_io_out_bits_sdq_id),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (sdq_alloc_id),
    .W0_en   (sdq_enq),
    .W0_clk  (clock),
    .W0_data (_io_req_req_idx_bits_data_8),
    .R0_data (io_replay_bits_data)
  );
  lb_32x128 lb_ext (
    .R0_addr ({_lb_read_arb_io_out_bits_id, _lb_read_arb_io_out_bits_offset}),
    .R0_en   (~_lb_write_arb_io_out_valid & _GEN_17),
    .R0_clk  (clock),
    .W0_addr ({_lb_write_arb_io_out_bits_id, _lb_write_arb_io_out_bits_offset}),
    .W0_en   (_lb_write_arb_io_out_valid),
    .W0_clk  (clock),
    .W0_data (_lb_write_arb_io_out_bits_data),
    .R0_data (_lb_ext_R0_data)
  );
  Arbiter lb_read_arb (
    .io_in_0_valid       (_mshrs_0_io_lb_read_valid),
    .io_in_0_bits_id     (_mshrs_0_io_lb_read_bits_id),
    .io_in_0_bits_offset (_mshrs_0_io_lb_read_bits_offset),
    .io_in_1_valid       (_mshrs_1_io_lb_read_valid),
    .io_in_1_bits_id     (_mshrs_1_io_lb_read_bits_id),
    .io_in_1_bits_offset (_mshrs_1_io_lb_read_bits_offset),
    .io_in_2_valid       (_mshrs_2_io_lb_read_valid),
    .io_in_2_bits_id     (_mshrs_2_io_lb_read_bits_id),
    .io_in_2_bits_offset (_mshrs_2_io_lb_read_bits_offset),
    .io_in_3_valid       (_mshrs_3_io_lb_read_valid),
    .io_in_3_bits_id     (_mshrs_3_io_lb_read_bits_id),
    .io_in_3_bits_offset (_mshrs_3_io_lb_read_bits_offset),
    .io_in_4_valid       (_mshrs_4_io_lb_read_valid),
    .io_in_4_bits_id     (_mshrs_4_io_lb_read_bits_id),
    .io_in_4_bits_offset (_mshrs_4_io_lb_read_bits_offset),
    .io_in_5_valid       (_mshrs_5_io_lb_read_valid),
    .io_in_5_bits_id     (_mshrs_5_io_lb_read_bits_id),
    .io_in_5_bits_offset (_mshrs_5_io_lb_read_bits_offset),
    .io_in_6_valid       (_mshrs_6_io_lb_read_valid),
    .io_in_6_bits_id     (_mshrs_6_io_lb_read_bits_id),
    .io_in_6_bits_offset (_mshrs_6_io_lb_read_bits_offset),
    .io_in_7_valid       (_mshrs_7_io_lb_read_valid),
    .io_in_7_bits_id     (_mshrs_7_io_lb_read_bits_id),
    .io_in_7_bits_offset (_mshrs_7_io_lb_read_bits_offset),
    .io_out_ready        (~_lb_write_arb_io_out_valid),
    .io_in_0_ready       (_lb_read_arb_io_in_0_ready),
    .io_in_1_ready       (_lb_read_arb_io_in_1_ready),
    .io_in_2_ready       (_lb_read_arb_io_in_2_ready),
    .io_in_3_ready       (_lb_read_arb_io_in_3_ready),
    .io_in_4_ready       (_lb_read_arb_io_in_4_ready),
    .io_in_5_ready       (_lb_read_arb_io_in_5_ready),
    .io_in_6_ready       (_lb_read_arb_io_in_6_ready),
    .io_in_7_ready       (_lb_read_arb_io_in_7_ready),
    .io_out_valid        (_lb_read_arb_io_out_valid),
    .io_out_bits_id      (_lb_read_arb_io_out_bits_id),
    .io_out_bits_offset  (_lb_read_arb_io_out_bits_offset)
  );
  Arbiter_1 lb_write_arb (
    .io_in_0_valid       (_mshrs_0_io_lb_write_valid),
    .io_in_0_bits_id     (_mshrs_0_io_lb_write_bits_id),
    .io_in_0_bits_offset (_mshrs_0_io_lb_write_bits_offset),
    .io_in_0_bits_data   (_mshrs_0_io_lb_write_bits_data),
    .io_in_1_valid       (_mshrs_1_io_lb_write_valid),
    .io_in_1_bits_id     (_mshrs_1_io_lb_write_bits_id),
    .io_in_1_bits_offset (_mshrs_1_io_lb_write_bits_offset),
    .io_in_1_bits_data   (_mshrs_1_io_lb_write_bits_data),
    .io_in_2_valid       (_mshrs_2_io_lb_write_valid),
    .io_in_2_bits_id     (_mshrs_2_io_lb_write_bits_id),
    .io_in_2_bits_offset (_mshrs_2_io_lb_write_bits_offset),
    .io_in_2_bits_data   (_mshrs_2_io_lb_write_bits_data),
    .io_in_3_valid       (_mshrs_3_io_lb_write_valid),
    .io_in_3_bits_id     (_mshrs_3_io_lb_write_bits_id),
    .io_in_3_bits_offset (_mshrs_3_io_lb_write_bits_offset),
    .io_in_3_bits_data   (_mshrs_3_io_lb_write_bits_data),
    .io_in_4_valid       (_mshrs_4_io_lb_write_valid),
    .io_in_4_bits_id     (_mshrs_4_io_lb_write_bits_id),
    .io_in_4_bits_offset (_mshrs_4_io_lb_write_bits_offset),
    .io_in_4_bits_data   (_mshrs_4_io_lb_write_bits_data),
    .io_in_5_valid       (_mshrs_5_io_lb_write_valid),
    .io_in_5_bits_id     (_mshrs_5_io_lb_write_bits_id),
    .io_in_5_bits_offset (_mshrs_5_io_lb_write_bits_offset),
    .io_in_5_bits_data   (_mshrs_5_io_lb_write_bits_data),
    .io_in_6_valid       (_mshrs_6_io_lb_write_valid),
    .io_in_6_bits_id     (_mshrs_6_io_lb_write_bits_id),
    .io_in_6_bits_offset (_mshrs_6_io_lb_write_bits_offset),
    .io_in_6_bits_data   (_mshrs_6_io_lb_write_bits_data),
    .io_in_7_valid       (_mshrs_7_io_lb_write_valid),
    .io_in_7_bits_id     (_mshrs_7_io_lb_write_bits_id),
    .io_in_7_bits_offset (_mshrs_7_io_lb_write_bits_offset),
    .io_in_7_bits_data   (_mshrs_7_io_lb_write_bits_data),
    .io_in_1_ready       (_lb_write_arb_io_in_1_ready),
    .io_in_2_ready       (_lb_write_arb_io_in_2_ready),
    .io_in_3_ready       (_lb_write_arb_io_in_3_ready),
    .io_in_4_ready       (_lb_write_arb_io_in_4_ready),
    .io_in_5_ready       (_lb_write_arb_io_in_5_ready),
    .io_in_6_ready       (_lb_write_arb_io_in_6_ready),
    .io_in_7_ready       (_lb_write_arb_io_in_7_ready),
    .io_out_valid        (_lb_write_arb_io_out_valid),
    .io_out_bits_id      (_lb_write_arb_io_out_bits_id),
    .io_out_bits_offset  (_lb_write_arb_io_out_bits_offset),
    .io_out_bits_data    (_lb_write_arb_io_out_bits_data)
  );
  Arbiter_2 meta_write_arb (
    .io_in_0_valid               (_mshrs_0_io_meta_write_valid),
    .io_in_0_bits_idx            (_mshrs_0_io_meta_write_bits_idx),
    .io_in_0_bits_way_en         (_mshrs_0_io_meta_write_bits_way_en),
    .io_in_0_bits_data_coh_state (_mshrs_0_io_meta_write_bits_data_coh_state),
    .io_in_0_bits_data_tag       (_mshrs_0_io_meta_write_bits_data_tag),
    .io_in_1_valid               (_mshrs_1_io_meta_write_valid),
    .io_in_1_bits_idx            (_mshrs_1_io_meta_write_bits_idx),
    .io_in_1_bits_way_en         (_mshrs_1_io_meta_write_bits_way_en),
    .io_in_1_bits_data_coh_state (_mshrs_1_io_meta_write_bits_data_coh_state),
    .io_in_1_bits_data_tag       (_mshrs_1_io_meta_write_bits_data_tag),
    .io_in_2_valid               (_mshrs_2_io_meta_write_valid),
    .io_in_2_bits_idx            (_mshrs_2_io_meta_write_bits_idx),
    .io_in_2_bits_way_en         (_mshrs_2_io_meta_write_bits_way_en),
    .io_in_2_bits_data_coh_state (_mshrs_2_io_meta_write_bits_data_coh_state),
    .io_in_2_bits_data_tag       (_mshrs_2_io_meta_write_bits_data_tag),
    .io_in_3_valid               (_mshrs_3_io_meta_write_valid),
    .io_in_3_bits_idx            (_mshrs_3_io_meta_write_bits_idx),
    .io_in_3_bits_way_en         (_mshrs_3_io_meta_write_bits_way_en),
    .io_in_3_bits_data_coh_state (_mshrs_3_io_meta_write_bits_data_coh_state),
    .io_in_3_bits_data_tag       (_mshrs_3_io_meta_write_bits_data_tag),
    .io_in_4_valid               (_mshrs_4_io_meta_write_valid),
    .io_in_4_bits_idx            (_mshrs_4_io_meta_write_bits_idx),
    .io_in_4_bits_way_en         (_mshrs_4_io_meta_write_bits_way_en),
    .io_in_4_bits_data_coh_state (_mshrs_4_io_meta_write_bits_data_coh_state),
    .io_in_4_bits_data_tag       (_mshrs_4_io_meta_write_bits_data_tag),
    .io_in_5_valid               (_mshrs_5_io_meta_write_valid),
    .io_in_5_bits_idx            (_mshrs_5_io_meta_write_bits_idx),
    .io_in_5_bits_way_en         (_mshrs_5_io_meta_write_bits_way_en),
    .io_in_5_bits_data_coh_state (_mshrs_5_io_meta_write_bits_data_coh_state),
    .io_in_5_bits_data_tag       (_mshrs_5_io_meta_write_bits_data_tag),
    .io_in_6_valid               (_mshrs_6_io_meta_write_valid),
    .io_in_6_bits_idx            (_mshrs_6_io_meta_write_bits_idx),
    .io_in_6_bits_way_en         (_mshrs_6_io_meta_write_bits_way_en),
    .io_in_6_bits_data_coh_state (_mshrs_6_io_meta_write_bits_data_coh_state),
    .io_in_6_bits_data_tag       (_mshrs_6_io_meta_write_bits_data_tag),
    .io_in_7_valid               (_mshrs_7_io_meta_write_valid),
    .io_in_7_bits_idx            (_mshrs_7_io_meta_write_bits_idx),
    .io_in_7_bits_way_en         (_mshrs_7_io_meta_write_bits_way_en),
    .io_in_7_bits_data_coh_state (_mshrs_7_io_meta_write_bits_data_coh_state),
    .io_in_7_bits_data_tag       (_mshrs_7_io_meta_write_bits_data_tag),
    .io_out_ready                (io_meta_write_ready),
    .io_in_0_ready               (_meta_write_arb_io_in_0_ready),
    .io_in_1_ready               (_meta_write_arb_io_in_1_ready),
    .io_in_2_ready               (_meta_write_arb_io_in_2_ready),
    .io_in_3_ready               (_meta_write_arb_io_in_3_ready),
    .io_in_4_ready               (_meta_write_arb_io_in_4_ready),
    .io_in_5_ready               (_meta_write_arb_io_in_5_ready),
    .io_in_6_ready               (_meta_write_arb_io_in_6_ready),
    .io_in_7_ready               (_meta_write_arb_io_in_7_ready),
    .io_out_valid                (io_meta_write_valid),
    .io_out_bits_idx             (io_meta_write_bits_idx),
    .io_out_bits_way_en          (io_meta_write_bits_way_en),
    .io_out_bits_data_coh_state  (io_meta_write_bits_data_coh_state),
    .io_out_bits_data_tag        (io_meta_write_bits_data_tag)
  );
  Arbiter_3 meta_read_arb (
    .io_in_0_valid       (_mshrs_0_io_meta_read_valid),
    .io_in_0_bits_idx    (_mshrs_0_io_meta_read_bits_idx),
    .io_in_0_bits_way_en (_mshrs_0_io_meta_read_bits_way_en),
    .io_in_0_bits_tag    (_mshrs_0_io_meta_read_bits_tag),
    .io_in_1_valid       (_mshrs_1_io_meta_read_valid),
    .io_in_1_bits_idx    (_mshrs_1_io_meta_read_bits_idx),
    .io_in_1_bits_way_en (_mshrs_1_io_meta_read_bits_way_en),
    .io_in_1_bits_tag    (_mshrs_1_io_meta_read_bits_tag),
    .io_in_2_valid       (_mshrs_2_io_meta_read_valid),
    .io_in_2_bits_idx    (_mshrs_2_io_meta_read_bits_idx),
    .io_in_2_bits_way_en (_mshrs_2_io_meta_read_bits_way_en),
    .io_in_2_bits_tag    (_mshrs_2_io_meta_read_bits_tag),
    .io_in_3_valid       (_mshrs_3_io_meta_read_valid),
    .io_in_3_bits_idx    (_mshrs_3_io_meta_read_bits_idx),
    .io_in_3_bits_way_en (_mshrs_3_io_meta_read_bits_way_en),
    .io_in_3_bits_tag    (_mshrs_3_io_meta_read_bits_tag),
    .io_in_4_valid       (_mshrs_4_io_meta_read_valid),
    .io_in_4_bits_idx    (_mshrs_4_io_meta_read_bits_idx),
    .io_in_4_bits_way_en (_mshrs_4_io_meta_read_bits_way_en),
    .io_in_4_bits_tag    (_mshrs_4_io_meta_read_bits_tag),
    .io_in_5_valid       (_mshrs_5_io_meta_read_valid),
    .io_in_5_bits_idx    (_mshrs_5_io_meta_read_bits_idx),
    .io_in_5_bits_way_en (_mshrs_5_io_meta_read_bits_way_en),
    .io_in_5_bits_tag    (_mshrs_5_io_meta_read_bits_tag),
    .io_in_6_valid       (_mshrs_6_io_meta_read_valid),
    .io_in_6_bits_idx    (_mshrs_6_io_meta_read_bits_idx),
    .io_in_6_bits_way_en (_mshrs_6_io_meta_read_bits_way_en),
    .io_in_6_bits_tag    (_mshrs_6_io_meta_read_bits_tag),
    .io_in_7_valid       (_mshrs_7_io_meta_read_valid),
    .io_in_7_bits_idx    (_mshrs_7_io_meta_read_bits_idx),
    .io_in_7_bits_way_en (_mshrs_7_io_meta_read_bits_way_en),
    .io_in_7_bits_tag    (_mshrs_7_io_meta_read_bits_tag),
    .io_out_ready        (io_meta_read_ready),
    .io_in_0_ready       (_meta_read_arb_io_in_0_ready),
    .io_in_1_ready       (_meta_read_arb_io_in_1_ready),
    .io_in_2_ready       (_meta_read_arb_io_in_2_ready),
    .io_in_3_ready       (_meta_read_arb_io_in_3_ready),
    .io_in_4_ready       (_meta_read_arb_io_in_4_ready),
    .io_in_5_ready       (_meta_read_arb_io_in_5_ready),
    .io_in_6_ready       (_meta_read_arb_io_in_6_ready),
    .io_in_7_ready       (_meta_read_arb_io_in_7_ready),
    .io_out_valid        (io_meta_read_valid),
    .io_out_bits_idx     (io_meta_read_bits_idx),
    .io_out_bits_way_en  (io_meta_read_bits_way_en),
    .io_out_bits_tag     (io_meta_read_bits_tag)
  );
  Arbiter_4 wb_req_arb (
    .io_in_0_valid       (_mshrs_0_io_wb_req_valid),
    .io_in_0_bits_tag    (_mshrs_0_io_wb_req_bits_tag),
    .io_in_0_bits_idx    (_mshrs_0_io_wb_req_bits_idx),
    .io_in_0_bits_param  (_mshrs_0_io_wb_req_bits_param),
    .io_in_0_bits_way_en (_mshrs_0_io_wb_req_bits_way_en),
    .io_in_1_valid       (_mshrs_1_io_wb_req_valid),
    .io_in_1_bits_tag    (_mshrs_1_io_wb_req_bits_tag),
    .io_in_1_bits_idx    (_mshrs_1_io_wb_req_bits_idx),
    .io_in_1_bits_param  (_mshrs_1_io_wb_req_bits_param),
    .io_in_1_bits_way_en (_mshrs_1_io_wb_req_bits_way_en),
    .io_in_2_valid       (_mshrs_2_io_wb_req_valid),
    .io_in_2_bits_tag    (_mshrs_2_io_wb_req_bits_tag),
    .io_in_2_bits_idx    (_mshrs_2_io_wb_req_bits_idx),
    .io_in_2_bits_param  (_mshrs_2_io_wb_req_bits_param),
    .io_in_2_bits_way_en (_mshrs_2_io_wb_req_bits_way_en),
    .io_in_3_valid       (_mshrs_3_io_wb_req_valid),
    .io_in_3_bits_tag    (_mshrs_3_io_wb_req_bits_tag),
    .io_in_3_bits_idx    (_mshrs_3_io_wb_req_bits_idx),
    .io_in_3_bits_param  (_mshrs_3_io_wb_req_bits_param),
    .io_in_3_bits_way_en (_mshrs_3_io_wb_req_bits_way_en),
    .io_in_4_valid       (_mshrs_4_io_wb_req_valid),
    .io_in_4_bits_tag    (_mshrs_4_io_wb_req_bits_tag),
    .io_in_4_bits_idx    (_mshrs_4_io_wb_req_bits_idx),
    .io_in_4_bits_param  (_mshrs_4_io_wb_req_bits_param),
    .io_in_4_bits_way_en (_mshrs_4_io_wb_req_bits_way_en),
    .io_in_5_valid       (_mshrs_5_io_wb_req_valid),
    .io_in_5_bits_tag    (_mshrs_5_io_wb_req_bits_tag),
    .io_in_5_bits_idx    (_mshrs_5_io_wb_req_bits_idx),
    .io_in_5_bits_param  (_mshrs_5_io_wb_req_bits_param),
    .io_in_5_bits_way_en (_mshrs_5_io_wb_req_bits_way_en),
    .io_in_6_valid       (_mshrs_6_io_wb_req_valid),
    .io_in_6_bits_tag    (_mshrs_6_io_wb_req_bits_tag),
    .io_in_6_bits_idx    (_mshrs_6_io_wb_req_bits_idx),
    .io_in_6_bits_param  (_mshrs_6_io_wb_req_bits_param),
    .io_in_6_bits_way_en (_mshrs_6_io_wb_req_bits_way_en),
    .io_in_7_valid       (_mshrs_7_io_wb_req_valid),
    .io_in_7_bits_tag    (_mshrs_7_io_wb_req_bits_tag),
    .io_in_7_bits_idx    (_mshrs_7_io_wb_req_bits_idx),
    .io_in_7_bits_param  (_mshrs_7_io_wb_req_bits_param),
    .io_in_7_bits_way_en (_mshrs_7_io_wb_req_bits_way_en),
    .io_out_ready        (io_wb_req_ready),
    .io_in_0_ready       (_wb_req_arb_io_in_0_ready),
    .io_in_1_ready       (_wb_req_arb_io_in_1_ready),
    .io_in_2_ready       (_wb_req_arb_io_in_2_ready),
    .io_in_3_ready       (_wb_req_arb_io_in_3_ready),
    .io_in_4_ready       (_wb_req_arb_io_in_4_ready),
    .io_in_5_ready       (_wb_req_arb_io_in_5_ready),
    .io_in_6_ready       (_wb_req_arb_io_in_6_ready),
    .io_in_7_ready       (_wb_req_arb_io_in_7_ready),
    .io_out_valid        (io_wb_req_valid),
    .io_out_bits_tag     (io_wb_req_bits_tag),
    .io_out_bits_idx     (io_wb_req_bits_idx),
    .io_out_bits_param   (io_wb_req_bits_param),
    .io_out_bits_way_en  (io_wb_req_bits_way_en)
  );
  Arbiter_5 replay_arb (
    .io_in_0_valid               (_mshrs_0_io_replay_valid),
    .io_in_0_bits_uop_br_mask    (_mshrs_0_io_replay_bits_uop_br_mask),
    .io_in_0_bits_uop_ldq_idx    (_mshrs_0_io_replay_bits_uop_ldq_idx),
    .io_in_0_bits_uop_stq_idx    (_mshrs_0_io_replay_bits_uop_stq_idx),
    .io_in_0_bits_uop_mem_cmd    (_mshrs_0_io_replay_bits_uop_mem_cmd),
    .io_in_0_bits_uop_mem_size   (_mshrs_0_io_replay_bits_uop_mem_size),
    .io_in_0_bits_uop_mem_signed (_mshrs_0_io_replay_bits_uop_mem_signed),
    .io_in_0_bits_uop_is_amo     (_mshrs_0_io_replay_bits_uop_is_amo),
    .io_in_0_bits_uop_uses_ldq   (_mshrs_0_io_replay_bits_uop_uses_ldq),
    .io_in_0_bits_uop_uses_stq   (_mshrs_0_io_replay_bits_uop_uses_stq),
    .io_in_0_bits_addr           (_mshrs_0_io_replay_bits_addr),
    .io_in_0_bits_is_hella       (_mshrs_0_io_replay_bits_is_hella),
    .io_in_0_bits_way_en         (_mshrs_0_io_replay_bits_way_en),
    .io_in_0_bits_sdq_id         (_mshrs_0_io_replay_bits_sdq_id),
    .io_in_1_valid               (_mshrs_1_io_replay_valid),
    .io_in_1_bits_uop_br_mask    (_mshrs_1_io_replay_bits_uop_br_mask),
    .io_in_1_bits_uop_ldq_idx    (_mshrs_1_io_replay_bits_uop_ldq_idx),
    .io_in_1_bits_uop_stq_idx    (_mshrs_1_io_replay_bits_uop_stq_idx),
    .io_in_1_bits_uop_mem_cmd    (_mshrs_1_io_replay_bits_uop_mem_cmd),
    .io_in_1_bits_uop_mem_size   (_mshrs_1_io_replay_bits_uop_mem_size),
    .io_in_1_bits_uop_mem_signed (_mshrs_1_io_replay_bits_uop_mem_signed),
    .io_in_1_bits_uop_is_amo     (_mshrs_1_io_replay_bits_uop_is_amo),
    .io_in_1_bits_uop_uses_ldq   (_mshrs_1_io_replay_bits_uop_uses_ldq),
    .io_in_1_bits_uop_uses_stq   (_mshrs_1_io_replay_bits_uop_uses_stq),
    .io_in_1_bits_addr           (_mshrs_1_io_replay_bits_addr),
    .io_in_1_bits_is_hella       (_mshrs_1_io_replay_bits_is_hella),
    .io_in_1_bits_way_en         (_mshrs_1_io_replay_bits_way_en),
    .io_in_1_bits_sdq_id         (_mshrs_1_io_replay_bits_sdq_id),
    .io_in_2_valid               (_mshrs_2_io_replay_valid),
    .io_in_2_bits_uop_br_mask    (_mshrs_2_io_replay_bits_uop_br_mask),
    .io_in_2_bits_uop_ldq_idx    (_mshrs_2_io_replay_bits_uop_ldq_idx),
    .io_in_2_bits_uop_stq_idx    (_mshrs_2_io_replay_bits_uop_stq_idx),
    .io_in_2_bits_uop_mem_cmd    (_mshrs_2_io_replay_bits_uop_mem_cmd),
    .io_in_2_bits_uop_mem_size   (_mshrs_2_io_replay_bits_uop_mem_size),
    .io_in_2_bits_uop_mem_signed (_mshrs_2_io_replay_bits_uop_mem_signed),
    .io_in_2_bits_uop_is_amo     (_mshrs_2_io_replay_bits_uop_is_amo),
    .io_in_2_bits_uop_uses_ldq   (_mshrs_2_io_replay_bits_uop_uses_ldq),
    .io_in_2_bits_uop_uses_stq   (_mshrs_2_io_replay_bits_uop_uses_stq),
    .io_in_2_bits_addr           (_mshrs_2_io_replay_bits_addr),
    .io_in_2_bits_is_hella       (_mshrs_2_io_replay_bits_is_hella),
    .io_in_2_bits_way_en         (_mshrs_2_io_replay_bits_way_en),
    .io_in_2_bits_sdq_id         (_mshrs_2_io_replay_bits_sdq_id),
    .io_in_3_valid               (_mshrs_3_io_replay_valid),
    .io_in_3_bits_uop_br_mask    (_mshrs_3_io_replay_bits_uop_br_mask),
    .io_in_3_bits_uop_ldq_idx    (_mshrs_3_io_replay_bits_uop_ldq_idx),
    .io_in_3_bits_uop_stq_idx    (_mshrs_3_io_replay_bits_uop_stq_idx),
    .io_in_3_bits_uop_mem_cmd    (_mshrs_3_io_replay_bits_uop_mem_cmd),
    .io_in_3_bits_uop_mem_size   (_mshrs_3_io_replay_bits_uop_mem_size),
    .io_in_3_bits_uop_mem_signed (_mshrs_3_io_replay_bits_uop_mem_signed),
    .io_in_3_bits_uop_is_amo     (_mshrs_3_io_replay_bits_uop_is_amo),
    .io_in_3_bits_uop_uses_ldq   (_mshrs_3_io_replay_bits_uop_uses_ldq),
    .io_in_3_bits_uop_uses_stq   (_mshrs_3_io_replay_bits_uop_uses_stq),
    .io_in_3_bits_addr           (_mshrs_3_io_replay_bits_addr),
    .io_in_3_bits_is_hella       (_mshrs_3_io_replay_bits_is_hella),
    .io_in_3_bits_way_en         (_mshrs_3_io_replay_bits_way_en),
    .io_in_3_bits_sdq_id         (_mshrs_3_io_replay_bits_sdq_id),
    .io_in_4_valid               (_mshrs_4_io_replay_valid),
    .io_in_4_bits_uop_br_mask    (_mshrs_4_io_replay_bits_uop_br_mask),
    .io_in_4_bits_uop_ldq_idx    (_mshrs_4_io_replay_bits_uop_ldq_idx),
    .io_in_4_bits_uop_stq_idx    (_mshrs_4_io_replay_bits_uop_stq_idx),
    .io_in_4_bits_uop_mem_cmd    (_mshrs_4_io_replay_bits_uop_mem_cmd),
    .io_in_4_bits_uop_mem_size   (_mshrs_4_io_replay_bits_uop_mem_size),
    .io_in_4_bits_uop_mem_signed (_mshrs_4_io_replay_bits_uop_mem_signed),
    .io_in_4_bits_uop_is_amo     (_mshrs_4_io_replay_bits_uop_is_amo),
    .io_in_4_bits_uop_uses_ldq   (_mshrs_4_io_replay_bits_uop_uses_ldq),
    .io_in_4_bits_uop_uses_stq   (_mshrs_4_io_replay_bits_uop_uses_stq),
    .io_in_4_bits_addr           (_mshrs_4_io_replay_bits_addr),
    .io_in_4_bits_is_hella       (_mshrs_4_io_replay_bits_is_hella),
    .io_in_4_bits_way_en         (_mshrs_4_io_replay_bits_way_en),
    .io_in_4_bits_sdq_id         (_mshrs_4_io_replay_bits_sdq_id),
    .io_in_5_valid               (_mshrs_5_io_replay_valid),
    .io_in_5_bits_uop_br_mask    (_mshrs_5_io_replay_bits_uop_br_mask),
    .io_in_5_bits_uop_ldq_idx    (_mshrs_5_io_replay_bits_uop_ldq_idx),
    .io_in_5_bits_uop_stq_idx    (_mshrs_5_io_replay_bits_uop_stq_idx),
    .io_in_5_bits_uop_mem_cmd    (_mshrs_5_io_replay_bits_uop_mem_cmd),
    .io_in_5_bits_uop_mem_size   (_mshrs_5_io_replay_bits_uop_mem_size),
    .io_in_5_bits_uop_mem_signed (_mshrs_5_io_replay_bits_uop_mem_signed),
    .io_in_5_bits_uop_is_amo     (_mshrs_5_io_replay_bits_uop_is_amo),
    .io_in_5_bits_uop_uses_ldq   (_mshrs_5_io_replay_bits_uop_uses_ldq),
    .io_in_5_bits_uop_uses_stq   (_mshrs_5_io_replay_bits_uop_uses_stq),
    .io_in_5_bits_addr           (_mshrs_5_io_replay_bits_addr),
    .io_in_5_bits_is_hella       (_mshrs_5_io_replay_bits_is_hella),
    .io_in_5_bits_way_en         (_mshrs_5_io_replay_bits_way_en),
    .io_in_5_bits_sdq_id         (_mshrs_5_io_replay_bits_sdq_id),
    .io_in_6_valid               (_mshrs_6_io_replay_valid),
    .io_in_6_bits_uop_br_mask    (_mshrs_6_io_replay_bits_uop_br_mask),
    .io_in_6_bits_uop_ldq_idx    (_mshrs_6_io_replay_bits_uop_ldq_idx),
    .io_in_6_bits_uop_stq_idx    (_mshrs_6_io_replay_bits_uop_stq_idx),
    .io_in_6_bits_uop_mem_cmd    (_mshrs_6_io_replay_bits_uop_mem_cmd),
    .io_in_6_bits_uop_mem_size   (_mshrs_6_io_replay_bits_uop_mem_size),
    .io_in_6_bits_uop_mem_signed (_mshrs_6_io_replay_bits_uop_mem_signed),
    .io_in_6_bits_uop_is_amo     (_mshrs_6_io_replay_bits_uop_is_amo),
    .io_in_6_bits_uop_uses_ldq   (_mshrs_6_io_replay_bits_uop_uses_ldq),
    .io_in_6_bits_uop_uses_stq   (_mshrs_6_io_replay_bits_uop_uses_stq),
    .io_in_6_bits_addr           (_mshrs_6_io_replay_bits_addr),
    .io_in_6_bits_is_hella       (_mshrs_6_io_replay_bits_is_hella),
    .io_in_6_bits_way_en         (_mshrs_6_io_replay_bits_way_en),
    .io_in_6_bits_sdq_id         (_mshrs_6_io_replay_bits_sdq_id),
    .io_in_7_valid               (_mshrs_7_io_replay_valid),
    .io_in_7_bits_uop_br_mask    (_mshrs_7_io_replay_bits_uop_br_mask),
    .io_in_7_bits_uop_ldq_idx    (_mshrs_7_io_replay_bits_uop_ldq_idx),
    .io_in_7_bits_uop_stq_idx    (_mshrs_7_io_replay_bits_uop_stq_idx),
    .io_in_7_bits_uop_mem_cmd    (_mshrs_7_io_replay_bits_uop_mem_cmd),
    .io_in_7_bits_uop_mem_size   (_mshrs_7_io_replay_bits_uop_mem_size),
    .io_in_7_bits_uop_mem_signed (_mshrs_7_io_replay_bits_uop_mem_signed),
    .io_in_7_bits_uop_is_amo     (_mshrs_7_io_replay_bits_uop_is_amo),
    .io_in_7_bits_uop_uses_ldq   (_mshrs_7_io_replay_bits_uop_uses_ldq),
    .io_in_7_bits_uop_uses_stq   (_mshrs_7_io_replay_bits_uop_uses_stq),
    .io_in_7_bits_addr           (_mshrs_7_io_replay_bits_addr),
    .io_in_7_bits_is_hella       (_mshrs_7_io_replay_bits_is_hella),
    .io_in_7_bits_way_en         (_mshrs_7_io_replay_bits_way_en),
    .io_in_7_bits_sdq_id         (_mshrs_7_io_replay_bits_sdq_id),
    .io_out_ready                (io_replay_ready),
    .io_in_0_ready               (_replay_arb_io_in_0_ready),
    .io_in_1_ready               (_replay_arb_io_in_1_ready),
    .io_in_2_ready               (_replay_arb_io_in_2_ready),
    .io_in_3_ready               (_replay_arb_io_in_3_ready),
    .io_in_4_ready               (_replay_arb_io_in_4_ready),
    .io_in_5_ready               (_replay_arb_io_in_5_ready),
    .io_in_6_ready               (_replay_arb_io_in_6_ready),
    .io_in_7_ready               (_replay_arb_io_in_7_ready),
    .io_out_valid                (_replay_arb_io_out_valid),
    .io_out_bits_uop_br_mask     (io_replay_bits_uop_br_mask),
    .io_out_bits_uop_ldq_idx     (io_replay_bits_uop_ldq_idx),
    .io_out_bits_uop_stq_idx     (io_replay_bits_uop_stq_idx),
    .io_out_bits_uop_mem_cmd     (_replay_arb_io_out_bits_uop_mem_cmd),
    .io_out_bits_uop_mem_size    (io_replay_bits_uop_mem_size),
    .io_out_bits_uop_mem_signed  (io_replay_bits_uop_mem_signed),
    .io_out_bits_uop_is_amo      (io_replay_bits_uop_is_amo),
    .io_out_bits_uop_uses_ldq    (io_replay_bits_uop_uses_ldq),
    .io_out_bits_uop_uses_stq    (io_replay_bits_uop_uses_stq),
    .io_out_bits_addr            (io_replay_bits_addr),
    .io_out_bits_is_hella        (io_replay_bits_is_hella),
    .io_out_bits_way_en          (io_replay_bits_way_en),
    .io_out_bits_sdq_id          (_replay_arb_io_out_bits_sdq_id)
  );
  Arbiter_6 resp_arb (
    .io_in_0_valid             (_mshrs_0_io_resp_valid),
    .io_in_0_bits_uop_br_mask  (_mshrs_0_io_resp_bits_uop_br_mask),
    .io_in_0_bits_uop_ldq_idx  (_mshrs_0_io_resp_bits_uop_ldq_idx),
    .io_in_0_bits_uop_stq_idx  (_mshrs_0_io_resp_bits_uop_stq_idx),
    .io_in_0_bits_uop_is_amo   (_mshrs_0_io_resp_bits_uop_is_amo),
    .io_in_0_bits_uop_uses_ldq (_mshrs_0_io_resp_bits_uop_uses_ldq),
    .io_in_0_bits_uop_uses_stq (_mshrs_0_io_resp_bits_uop_uses_stq),
    .io_in_0_bits_data         (_mshrs_0_io_resp_bits_data),
    .io_in_0_bits_is_hella     (_mshrs_0_io_resp_bits_is_hella),
    .io_in_1_valid             (_mshrs_1_io_resp_valid),
    .io_in_1_bits_uop_br_mask  (_mshrs_1_io_resp_bits_uop_br_mask),
    .io_in_1_bits_uop_ldq_idx  (_mshrs_1_io_resp_bits_uop_ldq_idx),
    .io_in_1_bits_uop_stq_idx  (_mshrs_1_io_resp_bits_uop_stq_idx),
    .io_in_1_bits_uop_is_amo   (_mshrs_1_io_resp_bits_uop_is_amo),
    .io_in_1_bits_uop_uses_ldq (_mshrs_1_io_resp_bits_uop_uses_ldq),
    .io_in_1_bits_uop_uses_stq (_mshrs_1_io_resp_bits_uop_uses_stq),
    .io_in_1_bits_data         (_mshrs_1_io_resp_bits_data),
    .io_in_1_bits_is_hella     (_mshrs_1_io_resp_bits_is_hella),
    .io_in_2_valid             (_mshrs_2_io_resp_valid),
    .io_in_2_bits_uop_br_mask  (_mshrs_2_io_resp_bits_uop_br_mask),
    .io_in_2_bits_uop_ldq_idx  (_mshrs_2_io_resp_bits_uop_ldq_idx),
    .io_in_2_bits_uop_stq_idx  (_mshrs_2_io_resp_bits_uop_stq_idx),
    .io_in_2_bits_uop_is_amo   (_mshrs_2_io_resp_bits_uop_is_amo),
    .io_in_2_bits_uop_uses_ldq (_mshrs_2_io_resp_bits_uop_uses_ldq),
    .io_in_2_bits_uop_uses_stq (_mshrs_2_io_resp_bits_uop_uses_stq),
    .io_in_2_bits_data         (_mshrs_2_io_resp_bits_data),
    .io_in_2_bits_is_hella     (_mshrs_2_io_resp_bits_is_hella),
    .io_in_3_valid             (_mshrs_3_io_resp_valid),
    .io_in_3_bits_uop_br_mask  (_mshrs_3_io_resp_bits_uop_br_mask),
    .io_in_3_bits_uop_ldq_idx  (_mshrs_3_io_resp_bits_uop_ldq_idx),
    .io_in_3_bits_uop_stq_idx  (_mshrs_3_io_resp_bits_uop_stq_idx),
    .io_in_3_bits_uop_is_amo   (_mshrs_3_io_resp_bits_uop_is_amo),
    .io_in_3_bits_uop_uses_ldq (_mshrs_3_io_resp_bits_uop_uses_ldq),
    .io_in_3_bits_uop_uses_stq (_mshrs_3_io_resp_bits_uop_uses_stq),
    .io_in_3_bits_data         (_mshrs_3_io_resp_bits_data),
    .io_in_3_bits_is_hella     (_mshrs_3_io_resp_bits_is_hella),
    .io_in_4_valid             (_mshrs_4_io_resp_valid),
    .io_in_4_bits_uop_br_mask  (_mshrs_4_io_resp_bits_uop_br_mask),
    .io_in_4_bits_uop_ldq_idx  (_mshrs_4_io_resp_bits_uop_ldq_idx),
    .io_in_4_bits_uop_stq_idx  (_mshrs_4_io_resp_bits_uop_stq_idx),
    .io_in_4_bits_uop_is_amo   (_mshrs_4_io_resp_bits_uop_is_amo),
    .io_in_4_bits_uop_uses_ldq (_mshrs_4_io_resp_bits_uop_uses_ldq),
    .io_in_4_bits_uop_uses_stq (_mshrs_4_io_resp_bits_uop_uses_stq),
    .io_in_4_bits_data         (_mshrs_4_io_resp_bits_data),
    .io_in_4_bits_is_hella     (_mshrs_4_io_resp_bits_is_hella),
    .io_in_5_valid             (_mshrs_5_io_resp_valid),
    .io_in_5_bits_uop_br_mask  (_mshrs_5_io_resp_bits_uop_br_mask),
    .io_in_5_bits_uop_ldq_idx  (_mshrs_5_io_resp_bits_uop_ldq_idx),
    .io_in_5_bits_uop_stq_idx  (_mshrs_5_io_resp_bits_uop_stq_idx),
    .io_in_5_bits_uop_is_amo   (_mshrs_5_io_resp_bits_uop_is_amo),
    .io_in_5_bits_uop_uses_ldq (_mshrs_5_io_resp_bits_uop_uses_ldq),
    .io_in_5_bits_uop_uses_stq (_mshrs_5_io_resp_bits_uop_uses_stq),
    .io_in_5_bits_data         (_mshrs_5_io_resp_bits_data),
    .io_in_5_bits_is_hella     (_mshrs_5_io_resp_bits_is_hella),
    .io_in_6_valid             (_mshrs_6_io_resp_valid),
    .io_in_6_bits_uop_br_mask  (_mshrs_6_io_resp_bits_uop_br_mask),
    .io_in_6_bits_uop_ldq_idx  (_mshrs_6_io_resp_bits_uop_ldq_idx),
    .io_in_6_bits_uop_stq_idx  (_mshrs_6_io_resp_bits_uop_stq_idx),
    .io_in_6_bits_uop_is_amo   (_mshrs_6_io_resp_bits_uop_is_amo),
    .io_in_6_bits_uop_uses_ldq (_mshrs_6_io_resp_bits_uop_uses_ldq),
    .io_in_6_bits_uop_uses_stq (_mshrs_6_io_resp_bits_uop_uses_stq),
    .io_in_6_bits_data         (_mshrs_6_io_resp_bits_data),
    .io_in_6_bits_is_hella     (_mshrs_6_io_resp_bits_is_hella),
    .io_in_7_valid             (_mshrs_7_io_resp_valid),
    .io_in_7_bits_uop_br_mask  (_mshrs_7_io_resp_bits_uop_br_mask),
    .io_in_7_bits_uop_ldq_idx  (_mshrs_7_io_resp_bits_uop_ldq_idx),
    .io_in_7_bits_uop_stq_idx  (_mshrs_7_io_resp_bits_uop_stq_idx),
    .io_in_7_bits_uop_is_amo   (_mshrs_7_io_resp_bits_uop_is_amo),
    .io_in_7_bits_uop_uses_ldq (_mshrs_7_io_resp_bits_uop_uses_ldq),
    .io_in_7_bits_uop_uses_stq (_mshrs_7_io_resp_bits_uop_uses_stq),
    .io_in_7_bits_data         (_mshrs_7_io_resp_bits_data),
    .io_in_7_bits_is_hella     (_mshrs_7_io_resp_bits_is_hella),
    .io_in_8_valid             (_mmios_0_io_resp_valid),
    .io_in_8_bits_uop_br_mask  (_mmios_0_io_resp_bits_uop_br_mask),
    .io_in_8_bits_uop_ldq_idx  (_mmios_0_io_resp_bits_uop_ldq_idx),
    .io_in_8_bits_uop_stq_idx  (_mmios_0_io_resp_bits_uop_stq_idx),
    .io_in_8_bits_uop_is_amo   (_mmios_0_io_resp_bits_uop_is_amo),
    .io_in_8_bits_uop_uses_ldq (_mmios_0_io_resp_bits_uop_uses_ldq),
    .io_in_8_bits_uop_uses_stq (_mmios_0_io_resp_bits_uop_uses_stq),
    .io_in_8_bits_data         (_mmios_0_io_resp_bits_data),
    .io_in_8_bits_is_hella     (_mmios_0_io_resp_bits_is_hella),
    .io_out_ready              (_respq_io_enq_ready),
    .io_in_0_ready             (_resp_arb_io_in_0_ready),
    .io_in_1_ready             (_resp_arb_io_in_1_ready),
    .io_in_2_ready             (_resp_arb_io_in_2_ready),
    .io_in_3_ready             (_resp_arb_io_in_3_ready),
    .io_in_4_ready             (_resp_arb_io_in_4_ready),
    .io_in_5_ready             (_resp_arb_io_in_5_ready),
    .io_in_6_ready             (_resp_arb_io_in_6_ready),
    .io_in_7_ready             (_resp_arb_io_in_7_ready),
    .io_in_8_ready             (_resp_arb_io_in_8_ready),
    .io_out_valid              (_resp_arb_io_out_valid),
    .io_out_bits_uop_br_mask   (_resp_arb_io_out_bits_uop_br_mask),
    .io_out_bits_uop_ldq_idx   (_resp_arb_io_out_bits_uop_ldq_idx),
    .io_out_bits_uop_stq_idx   (_resp_arb_io_out_bits_uop_stq_idx),
    .io_out_bits_uop_is_amo    (_resp_arb_io_out_bits_uop_is_amo),
    .io_out_bits_uop_uses_ldq  (_resp_arb_io_out_bits_uop_uses_ldq),
    .io_out_bits_uop_uses_stq  (_resp_arb_io_out_bits_uop_uses_stq),
    .io_out_bits_data          (_resp_arb_io_out_bits_data),
    .io_out_bits_is_hella      (_resp_arb_io_out_bits_is_hella)
  );
  Arbiter_7 refill_arb (
    .io_in_0_valid       (_mshrs_0_io_refill_valid),
    .io_in_0_bits_way_en (_mshrs_0_io_refill_bits_way_en),
    .io_in_0_bits_addr   (_mshrs_0_io_refill_bits_addr),
    .io_in_0_bits_data   (_mshrs_0_io_refill_bits_data),
    .io_in_1_valid       (_mshrs_1_io_refill_valid),
    .io_in_1_bits_way_en (_mshrs_1_io_refill_bits_way_en),
    .io_in_1_bits_addr   (_mshrs_1_io_refill_bits_addr),
    .io_in_1_bits_data   (_mshrs_1_io_refill_bits_data),
    .io_in_2_valid       (_mshrs_2_io_refill_valid),
    .io_in_2_bits_way_en (_mshrs_2_io_refill_bits_way_en),
    .io_in_2_bits_addr   (_mshrs_2_io_refill_bits_addr),
    .io_in_2_bits_data   (_mshrs_2_io_refill_bits_data),
    .io_in_3_valid       (_mshrs_3_io_refill_valid),
    .io_in_3_bits_way_en (_mshrs_3_io_refill_bits_way_en),
    .io_in_3_bits_addr   (_mshrs_3_io_refill_bits_addr),
    .io_in_3_bits_data   (_mshrs_3_io_refill_bits_data),
    .io_in_4_valid       (_mshrs_4_io_refill_valid),
    .io_in_4_bits_way_en (_mshrs_4_io_refill_bits_way_en),
    .io_in_4_bits_addr   (_mshrs_4_io_refill_bits_addr),
    .io_in_4_bits_data   (_mshrs_4_io_refill_bits_data),
    .io_in_5_valid       (_mshrs_5_io_refill_valid),
    .io_in_5_bits_way_en (_mshrs_5_io_refill_bits_way_en),
    .io_in_5_bits_addr   (_mshrs_5_io_refill_bits_addr),
    .io_in_5_bits_data   (_mshrs_5_io_refill_bits_data),
    .io_in_6_valid       (_mshrs_6_io_refill_valid),
    .io_in_6_bits_way_en (_mshrs_6_io_refill_bits_way_en),
    .io_in_6_bits_addr   (_mshrs_6_io_refill_bits_addr),
    .io_in_6_bits_data   (_mshrs_6_io_refill_bits_data),
    .io_in_7_valid       (_mshrs_7_io_refill_valid),
    .io_in_7_bits_way_en (_mshrs_7_io_refill_bits_way_en),
    .io_in_7_bits_addr   (_mshrs_7_io_refill_bits_addr),
    .io_in_7_bits_data   (_mshrs_7_io_refill_bits_data),
    .io_out_ready        (io_refill_ready),
    .io_in_0_ready       (_refill_arb_io_in_0_ready),
    .io_in_1_ready       (_refill_arb_io_in_1_ready),
    .io_in_2_ready       (_refill_arb_io_in_2_ready),
    .io_in_3_ready       (_refill_arb_io_in_3_ready),
    .io_in_4_ready       (_refill_arb_io_in_4_ready),
    .io_in_5_ready       (_refill_arb_io_in_5_ready),
    .io_in_6_ready       (_refill_arb_io_in_6_ready),
    .io_in_7_ready       (_refill_arb_io_in_7_ready),
    .io_out_valid        (io_refill_valid),
    .io_out_bits_way_en  (io_refill_bits_way_en),
    .io_out_bits_addr    (io_refill_bits_addr),
    .io_out_bits_data    (io_refill_bits_data)
  );
  BoomMSHR mshrs_0 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h0),
    .io_req_pri_val                    (_mshr_io_req_pri_val_T & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_3),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_0_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_0_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle | state__0)),
    .io_mem_grant_valid                (_GEN & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (~beatsLeft_1 | state_1_0)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_0_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_0_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_0_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_0_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_0_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (1'h1),
    .io_replay_ready                   (_replay_arb_io_in_0_ready),
    .io_resp_ready                     (_resp_arb_io_in_0_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_0_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_0_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_0_io_idx_valid),
    .io_idx_bits                       (_mshrs_0_io_idx_bits),
    .io_way_valid                      (_mshrs_0_io_way_valid),
    .io_way_bits                       (_mshrs_0_io_way_bits),
    .io_tag_valid                      (_mshrs_0_io_tag_valid),
    .io_tag_bits                       (_mshrs_0_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_0_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_0_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_0_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_0_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_0_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_0_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_0_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_0_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_0_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_0_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_0_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_0_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_0_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_0_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_0_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_0_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_0_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_0_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_0_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_0_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_0_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_0_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_0_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_0_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_0_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_0_io_commit_val),
    .io_commit_addr                    (_mshrs_0_io_commit_addr),
    .io_commit_coh_state               (_mshrs_0_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_0_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_0_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_0_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_0_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_0_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_0_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_0_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_0_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_0_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_0_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_0_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_0_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_0_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_0_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_0_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_0_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_0_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_0_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_0_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_0_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_0_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_0_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_0_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_0_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_0_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_0_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_0_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_0_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_0_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_0_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_0_io_probe_rdy)
  );
  BoomMSHR mshrs_1 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h1),
    .io_req_pri_val                    (mshr_alloc_idx == 3'h1 & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_7),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_1_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_1_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle ? ~_mshrs_0_io_mem_acquire_valid : state__1)),
    .io_mem_grant_valid                (_GEN_0 & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (beatsLeft_1 ? state_1_1 : ~_mshrs_0_io_mem_finish_valid)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_1_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_1_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_1_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_1_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_1_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (_lb_write_arb_io_in_1_ready),
    .io_replay_ready                   (_replay_arb_io_in_1_ready),
    .io_resp_ready                     (_resp_arb_io_in_1_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_1_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_1_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_1_io_idx_valid),
    .io_idx_bits                       (_mshrs_1_io_idx_bits),
    .io_way_valid                      (_mshrs_1_io_way_valid),
    .io_way_bits                       (_mshrs_1_io_way_bits),
    .io_tag_valid                      (_mshrs_1_io_tag_valid),
    .io_tag_bits                       (_mshrs_1_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_1_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_1_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_1_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_1_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_1_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_1_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_1_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_1_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_1_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_1_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_1_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_1_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_1_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_1_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_1_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_1_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_1_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_1_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_1_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_1_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_1_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_1_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_1_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_1_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_1_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_1_io_commit_val),
    .io_commit_addr                    (_mshrs_1_io_commit_addr),
    .io_commit_coh_state               (_mshrs_1_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_1_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_1_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_1_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_1_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_1_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_1_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_1_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_1_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_1_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_1_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_1_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_1_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_1_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_1_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_1_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_1_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_1_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_1_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_1_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_1_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_1_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_1_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_1_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_1_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_1_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_1_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_1_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_1_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_1_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_1_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_1_io_probe_rdy)
  );
  BoomMSHR mshrs_2 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h2),
    .io_req_pri_val                    (mshr_alloc_idx == 3'h2 & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_11),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_2_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_2_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle ? ~_GEN_12 : state__2)),
    .io_mem_grant_valid                (_GEN_1 & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (beatsLeft_1 ? state_1_2 : ~_GEN_24)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_2_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_2_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_2_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_2_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_2_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (_lb_write_arb_io_in_2_ready),
    .io_replay_ready                   (_replay_arb_io_in_2_ready),
    .io_resp_ready                     (_resp_arb_io_in_2_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_2_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_2_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_2_io_idx_valid),
    .io_idx_bits                       (_mshrs_2_io_idx_bits),
    .io_way_valid                      (_mshrs_2_io_way_valid),
    .io_way_bits                       (_mshrs_2_io_way_bits),
    .io_tag_valid                      (_mshrs_2_io_tag_valid),
    .io_tag_bits                       (_mshrs_2_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_2_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_2_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_2_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_2_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_2_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_2_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_2_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_2_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_2_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_2_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_2_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_2_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_2_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_2_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_2_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_2_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_2_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_2_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_2_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_2_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_2_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_2_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_2_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_2_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_2_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_2_io_commit_val),
    .io_commit_addr                    (_mshrs_2_io_commit_addr),
    .io_commit_coh_state               (_mshrs_2_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_2_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_2_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_2_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_2_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_2_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_2_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_2_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_2_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_2_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_2_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_2_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_2_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_2_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_2_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_2_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_2_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_2_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_2_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_2_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_2_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_2_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_2_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_2_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_2_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_2_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_2_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_2_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_2_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_2_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_2_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_2_io_probe_rdy)
  );
  BoomMSHR mshrs_3 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h3),
    .io_req_pri_val                    (mshr_alloc_idx == 3'h3 & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_15),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_3_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_3_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle ? ~_GEN_14 : state__3)),
    .io_mem_grant_valid                (_GEN_2 & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (beatsLeft_1 ? state_1_3 : ~_GEN_26)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_3_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_3_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_3_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_3_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_3_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (_lb_write_arb_io_in_3_ready),
    .io_replay_ready                   (_replay_arb_io_in_3_ready),
    .io_resp_ready                     (_resp_arb_io_in_3_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_3_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_3_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_3_io_idx_valid),
    .io_idx_bits                       (_mshrs_3_io_idx_bits),
    .io_way_valid                      (_mshrs_3_io_way_valid),
    .io_way_bits                       (_mshrs_3_io_way_bits),
    .io_tag_valid                      (_mshrs_3_io_tag_valid),
    .io_tag_bits                       (_mshrs_3_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_3_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_3_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_3_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_3_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_3_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_3_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_3_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_3_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_3_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_3_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_3_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_3_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_3_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_3_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_3_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_3_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_3_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_3_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_3_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_3_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_3_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_3_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_3_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_3_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_3_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_3_io_commit_val),
    .io_commit_addr                    (_mshrs_3_io_commit_addr),
    .io_commit_coh_state               (_mshrs_3_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_3_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_3_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_3_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_3_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_3_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_3_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_3_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_3_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_3_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_3_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_3_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_3_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_3_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_3_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_3_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_3_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_3_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_3_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_3_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_3_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_3_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_3_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_3_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_3_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_3_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_3_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_3_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_3_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_3_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_3_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_3_io_probe_rdy)
  );
  BoomMSHR mshrs_4 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h4),
    .io_req_pri_val                    (mshr_alloc_idx == 3'h4 & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_19),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_4_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_4_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle ? ~_GEN_13 : state__4)),
    .io_mem_grant_valid                (_GEN_3 & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (beatsLeft_1 ? state_1_4 : ~_GEN_25)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_4_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_4_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_4_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_4_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_4_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (_lb_write_arb_io_in_4_ready),
    .io_replay_ready                   (_replay_arb_io_in_4_ready),
    .io_resp_ready                     (_resp_arb_io_in_4_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_4_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_4_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_4_io_idx_valid),
    .io_idx_bits                       (_mshrs_4_io_idx_bits),
    .io_way_valid                      (_mshrs_4_io_way_valid),
    .io_way_bits                       (_mshrs_4_io_way_bits),
    .io_tag_valid                      (_mshrs_4_io_tag_valid),
    .io_tag_bits                       (_mshrs_4_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_4_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_4_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_4_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_4_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_4_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_4_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_4_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_4_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_4_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_4_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_4_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_4_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_4_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_4_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_4_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_4_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_4_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_4_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_4_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_4_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_4_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_4_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_4_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_4_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_4_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_4_io_commit_val),
    .io_commit_addr                    (_mshrs_4_io_commit_addr),
    .io_commit_coh_state               (_mshrs_4_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_4_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_4_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_4_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_4_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_4_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_4_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_4_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_4_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_4_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_4_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_4_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_4_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_4_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_4_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_4_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_4_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_4_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_4_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_4_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_4_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_4_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_4_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_4_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_4_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_4_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_4_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_4_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_4_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_4_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_4_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_4_io_probe_rdy)
  );
  BoomMSHR mshrs_5 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h5),
    .io_req_pri_val                    (mshr_alloc_idx == 3'h5 & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_23),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_5_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_5_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle ? ~_GEN_19 : state__5)),
    .io_mem_grant_valid                (_GEN_4 & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (beatsLeft_1 ? state_1_5 : ~_GEN_29)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_5_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_5_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_5_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_5_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_5_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (_lb_write_arb_io_in_5_ready),
    .io_replay_ready                   (_replay_arb_io_in_5_ready),
    .io_resp_ready                     (_resp_arb_io_in_5_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_5_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_5_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_5_io_idx_valid),
    .io_idx_bits                       (_mshrs_5_io_idx_bits),
    .io_way_valid                      (_mshrs_5_io_way_valid),
    .io_way_bits                       (_mshrs_5_io_way_bits),
    .io_tag_valid                      (_mshrs_5_io_tag_valid),
    .io_tag_bits                       (_mshrs_5_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_5_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_5_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_5_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_5_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_5_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_5_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_5_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_5_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_5_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_5_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_5_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_5_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_5_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_5_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_5_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_5_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_5_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_5_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_5_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_5_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_5_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_5_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_5_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_5_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_5_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_5_io_commit_val),
    .io_commit_addr                    (_mshrs_5_io_commit_addr),
    .io_commit_coh_state               (_mshrs_5_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_5_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_5_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_5_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_5_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_5_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_5_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_5_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_5_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_5_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_5_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_5_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_5_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_5_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_5_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_5_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_5_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_5_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_5_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_5_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_5_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_5_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_5_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_5_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_5_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_5_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_5_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_5_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_5_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_5_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_5_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_5_io_probe_rdy)
  );
  BoomMSHR mshrs_6 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h6),
    .io_req_pri_val                    (mshr_alloc_idx == 3'h6 & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_27),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_6_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_6_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle ? ~_GEN_18 : state__6)),
    .io_mem_grant_valid                (_GEN_5 & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (beatsLeft_1 ? state_1_6 : ~_GEN_28)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_6_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_6_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_6_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_6_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_6_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (_lb_write_arb_io_in_6_ready),
    .io_replay_ready                   (_replay_arb_io_in_6_ready),
    .io_resp_ready                     (_resp_arb_io_in_6_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_6_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_6_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_6_io_idx_valid),
    .io_idx_bits                       (_mshrs_6_io_idx_bits),
    .io_way_valid                      (_mshrs_6_io_way_valid),
    .io_way_bits                       (_mshrs_6_io_way_bits),
    .io_tag_valid                      (_mshrs_6_io_tag_valid),
    .io_tag_bits                       (_mshrs_6_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_6_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_6_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_6_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_6_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_6_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_6_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_6_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_6_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_6_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_6_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_6_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_6_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_6_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_6_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_6_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_6_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_6_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_6_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_6_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_6_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_6_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_6_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_6_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_6_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_6_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_6_io_commit_val),
    .io_commit_addr                    (_mshrs_6_io_commit_addr),
    .io_commit_coh_state               (_mshrs_6_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_6_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_6_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_6_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_6_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_6_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_6_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_6_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_6_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_6_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_6_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_6_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_6_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_6_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_6_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_6_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_6_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_6_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_6_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_6_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_6_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_6_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_6_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_6_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_6_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_6_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_6_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_6_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_6_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_6_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_6_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_6_io_probe_rdy)
  );
  BoomMSHR mshrs_7 (
    .clock                             (clock),
    .reset                             (reset),
    .io_id                             (3'h7),
    .io_req_pri_val                    ((&mshr_alloc_idx) & pri_val),
    .io_req_sec_val                    (_mshr_io_req_sec_val_T_31),
    .io_clear_prefetch                 (io_clear_all & ~_io_req_req_idx_valid_25 | _io_req_req_idx_valid_25 & _idx_matches_req_idx_7_1 & _io_req_req_idx_bits_addr_9[31] & ~_tag_match_req_idx_14 | io_req_is_probe_0 & _idx_matches_req_idx_7_1),
    .io_brupdate_b1_resolve_mask       (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask    (io_brupdate_b1_mispredict_mask),
    .io_exception                      (io_exception),
    .io_req_uop_br_mask                (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_uop_ldq_idx                (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_uop_stq_idx                (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_uop_mem_cmd                (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_uop_mem_size               (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_uop_mem_signed             (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_uop_is_amo                 (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_uop_uses_ldq               (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_uop_uses_stq               (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_addr                       (_io_req_req_idx_bits_addr_9),
    .io_req_is_hella                   (_io_req_req_idx_bits_is_hella_7),
    .io_req_tag_match                  (_io_req_req_idx_bits_tag_match_6),
    .io_req_old_meta_coh_state         (_io_req_req_idx_bits_old_meta_coh_state_6),
    .io_req_old_meta_tag               (_io_req_req_idx_bits_old_meta_tag_6),
    .io_req_way_en                     (_io_req_req_idx_bits_way_en_6),
    .io_req_sdq_id                     (sdq_alloc_id),
    .io_req_is_probe                   (io_req_is_probe_0),
    .io_mem_acquire_ready              (io_mem_acquire_ready & (idle ? ~_GEN_16 : state__7)),
    .io_mem_grant_valid                (_GEN_6 & io_mem_grant_valid),
    .io_mem_grant_bits_opcode          (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param           (io_mem_grant_bits_param),
    .io_mem_grant_bits_size            (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink            (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data            (io_mem_grant_bits_data),
    .io_mem_finish_ready               (io_mem_finish_ready & (beatsLeft_1 ? state_1_7 : ~_GEN_27)),
    .io_prober_state_valid             (io_prober_state_valid),
    .io_prober_state_bits              (io_prober_state_bits),
    .io_refill_ready                   (_refill_arb_io_in_7_ready),
    .io_meta_write_ready               (_meta_write_arb_io_in_7_ready),
    .io_meta_read_ready                (_meta_read_arb_io_in_7_ready),
    .io_meta_resp_valid                (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state       (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                   (_wb_req_arb_io_in_7_ready),
    .io_lb_read_ready                  (_lb_read_arb_io_in_7_ready),
    .io_lb_resp                        (lb_read_data),
    .io_lb_write_ready                 (_lb_write_arb_io_in_7_ready),
    .io_replay_ready                   (_replay_arb_io_in_7_ready),
    .io_resp_ready                     (_resp_arb_io_in_7_ready),
    .io_wb_resp                        (io_wb_resp),
    .io_req_pri_rdy                    (_mshrs_7_io_req_pri_rdy),
    .io_req_sec_rdy                    (_mshrs_7_io_req_sec_rdy),
    .io_idx_valid                      (_mshrs_7_io_idx_valid),
    .io_idx_bits                       (_mshrs_7_io_idx_bits),
    .io_way_valid                      (_mshrs_7_io_way_valid),
    .io_way_bits                       (_mshrs_7_io_way_bits),
    .io_tag_valid                      (_mshrs_7_io_tag_valid),
    .io_tag_bits                       (_mshrs_7_io_tag_bits),
    .io_mem_acquire_valid              (_mshrs_7_io_mem_acquire_valid),
    .io_mem_acquire_bits_param         (_mshrs_7_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source        (_mshrs_7_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address       (_mshrs_7_io_mem_acquire_bits_address),
    .io_mem_grant_ready                (_mshrs_7_io_mem_grant_ready),
    .io_mem_finish_valid               (_mshrs_7_io_mem_finish_valid),
    .io_mem_finish_bits_sink           (_mshrs_7_io_mem_finish_bits_sink),
    .io_refill_valid                   (_mshrs_7_io_refill_valid),
    .io_refill_bits_way_en             (_mshrs_7_io_refill_bits_way_en),
    .io_refill_bits_addr               (_mshrs_7_io_refill_bits_addr),
    .io_refill_bits_data               (_mshrs_7_io_refill_bits_data),
    .io_meta_write_valid               (_mshrs_7_io_meta_write_valid),
    .io_meta_write_bits_idx            (_mshrs_7_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_mshrs_7_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_mshrs_7_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_mshrs_7_io_meta_write_bits_data_tag),
    .io_meta_read_valid                (_mshrs_7_io_meta_read_valid),
    .io_meta_read_bits_idx             (_mshrs_7_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en          (_mshrs_7_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag             (_mshrs_7_io_meta_read_bits_tag),
    .io_wb_req_valid                   (_mshrs_7_io_wb_req_valid),
    .io_wb_req_bits_tag                (_mshrs_7_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_mshrs_7_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_mshrs_7_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_mshrs_7_io_wb_req_bits_way_en),
    .io_commit_val                     (_mshrs_7_io_commit_val),
    .io_commit_addr                    (_mshrs_7_io_commit_addr),
    .io_commit_coh_state               (_mshrs_7_io_commit_coh_state),
    .io_lb_read_valid                  (_mshrs_7_io_lb_read_valid),
    .io_lb_read_bits_id                (_mshrs_7_io_lb_read_bits_id),
    .io_lb_read_bits_offset            (_mshrs_7_io_lb_read_bits_offset),
    .io_lb_write_valid                 (_mshrs_7_io_lb_write_valid),
    .io_lb_write_bits_id               (_mshrs_7_io_lb_write_bits_id),
    .io_lb_write_bits_offset           (_mshrs_7_io_lb_write_bits_offset),
    .io_lb_write_bits_data             (_mshrs_7_io_lb_write_bits_data),
    .io_replay_valid                   (_mshrs_7_io_replay_valid),
    .io_replay_bits_uop_br_mask        (_mshrs_7_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_ldq_idx        (_mshrs_7_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx        (_mshrs_7_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_mem_cmd        (_mshrs_7_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size       (_mshrs_7_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed     (_mshrs_7_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_amo         (_mshrs_7_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq       (_mshrs_7_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq       (_mshrs_7_io_replay_bits_uop_uses_stq),
    .io_replay_bits_addr               (_mshrs_7_io_replay_bits_addr),
    .io_replay_bits_is_hella           (_mshrs_7_io_replay_bits_is_hella),
    .io_replay_bits_way_en             (_mshrs_7_io_replay_bits_way_en),
    .io_replay_bits_sdq_id             (_mshrs_7_io_replay_bits_sdq_id),
    .io_resp_valid                     (_mshrs_7_io_resp_valid),
    .io_resp_bits_uop_br_mask          (_mshrs_7_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx          (_mshrs_7_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx          (_mshrs_7_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo           (_mshrs_7_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq         (_mshrs_7_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq         (_mshrs_7_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                 (_mshrs_7_io_resp_bits_data),
    .io_resp_bits_is_hella             (_mshrs_7_io_resp_bits_is_hella),
    .io_probe_rdy                      (_mshrs_7_io_probe_rdy)
  );
  Arbiter_8 mmio_alloc_arb (
    .io_out_ready  (_io_req_req_idx_valid_25 & ~(_io_req_req_idx_bits_addr_9[31])),
    .io_in_0_ready (_mmio_alloc_arb_io_in_0_ready)
  );
  BoomIOMSHR mmios_0 (
    .clock                      (clock),
    .reset                      (reset),
    .io_req_valid               (_mmio_alloc_arb_io_in_0_ready),
    .io_req_bits_uop_br_mask    (_io_req_req_idx_bits_uop_br_mask_7),
    .io_req_bits_uop_ldq_idx    (_io_req_req_idx_bits_uop_ldq_idx_7),
    .io_req_bits_uop_stq_idx    (_io_req_req_idx_bits_uop_stq_idx_7),
    .io_req_bits_uop_mem_cmd    (_io_req_req_idx_bits_uop_mem_cmd_19),
    .io_req_bits_uop_mem_size   (_io_req_req_idx_bits_uop_mem_size_7),
    .io_req_bits_uop_mem_signed (_io_req_req_idx_bits_uop_mem_signed_7),
    .io_req_bits_uop_is_amo     (_io_req_req_idx_bits_uop_is_amo_7),
    .io_req_bits_uop_uses_ldq   (_io_req_req_idx_bits_uop_uses_ldq_7),
    .io_req_bits_uop_uses_stq   (_io_req_req_idx_bits_uop_uses_stq_7),
    .io_req_bits_addr           (_io_req_req_idx_bits_addr_9),
    .io_req_bits_data           (_io_req_req_idx_bits_data_8),
    .io_req_bits_is_hella       (_io_req_req_idx_bits_is_hella_7),
    .io_resp_ready              (_resp_arb_io_in_8_ready),
    .io_mem_access_ready        (io_mem_acquire_ready & (idle ? ~_GEN_15 : state__8)),
    .io_mem_ack_valid           (io_mem_grant_valid & _mshr_io_mem_ack_valid_T),
    .io_mem_ack_bits_data       (io_mem_grant_bits_data),
    .io_req_ready               (_mmios_0_io_req_ready),
    .io_resp_valid              (_mmios_0_io_resp_valid),
    .io_resp_bits_uop_br_mask   (_mmios_0_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx   (_mmios_0_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx   (_mmios_0_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo    (_mmios_0_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq  (_mmios_0_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq  (_mmios_0_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data          (_mmios_0_io_resp_bits_data),
    .io_resp_bits_is_hella      (_mmios_0_io_resp_bits_is_hella),
    .io_mem_access_valid        (_mmios_0_io_mem_access_valid),
    .io_mem_access_bits_opcode  (_mmios_0_io_mem_access_bits_opcode),
    .io_mem_access_bits_param   (_mmios_0_io_mem_access_bits_param),
    .io_mem_access_bits_size    (_mmios_0_io_mem_access_bits_size),
    .io_mem_access_bits_source  (_mmios_0_io_mem_access_bits_source),
    .io_mem_access_bits_address (_mmios_0_io_mem_access_bits_address),
    .io_mem_access_bits_mask    (_mmios_0_io_mem_access_bits_mask),
    .io_mem_access_bits_data    (_mmios_0_io_mem_access_bits_data)
  );
  BranchKillableQueue_8 respq (
    .clock                          (clock),
    .reset                          (reset),
    .io_enq_valid                   (_resp_arb_io_out_valid),
    .io_enq_bits_uop_br_mask        (_resp_arb_io_out_bits_uop_br_mask),
    .io_enq_bits_uop_ldq_idx        (_resp_arb_io_out_bits_uop_ldq_idx),
    .io_enq_bits_uop_stq_idx        (_resp_arb_io_out_bits_uop_stq_idx),
    .io_enq_bits_uop_is_amo         (_resp_arb_io_out_bits_uop_is_amo),
    .io_enq_bits_uop_uses_ldq       (_resp_arb_io_out_bits_uop_uses_ldq),
    .io_enq_bits_uop_uses_stq       (_resp_arb_io_out_bits_uop_uses_stq),
    .io_enq_bits_data               (_resp_arb_io_out_bits_data),
    .io_enq_bits_is_hella           (_resp_arb_io_out_bits_is_hella),
    .io_deq_ready                   (io_resp_ready),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_flush                       (io_exception),
    .io_enq_ready                   (_respq_io_enq_ready),
    .io_deq_valid                   (io_resp_valid),
    .io_deq_bits_uop_br_mask        (io_resp_bits_uop_br_mask),
    .io_deq_bits_uop_ldq_idx        (io_resp_bits_uop_ldq_idx),
    .io_deq_bits_uop_stq_idx        (io_resp_bits_uop_stq_idx),
    .io_deq_bits_uop_is_amo         (io_resp_bits_uop_is_amo),
    .io_deq_bits_uop_uses_ldq       (io_resp_bits_uop_uses_ldq),
    .io_deq_bits_uop_uses_stq       (io_resp_bits_uop_uses_stq),
    .io_deq_bits_data               (io_resp_bits_data),
    .io_deq_bits_is_hella           (io_resp_bits_is_hella)
  );
  assign io_req_0_ready = _io_req_0_ready_output;
  assign io_req_1_ready = _io_req_1_ready_output;
  assign io_secondary_miss_0 = idx_match_0 & (idx_matches_0_0 & _mshrs_0_io_way_valid & _mshrs_0_io_way_bits == io_req_0_bits_way_en | idx_matches_0_1 & _mshrs_1_io_way_valid & _mshrs_1_io_way_bits == io_req_0_bits_way_en | idx_matches_0_2 & _mshrs_2_io_way_valid & _mshrs_2_io_way_bits == io_req_0_bits_way_en | idx_matches_0_3 & _mshrs_3_io_way_valid & _mshrs_3_io_way_bits == io_req_0_bits_way_en | idx_matches_0_4 & _mshrs_4_io_way_valid & _mshrs_4_io_way_bits == io_req_0_bits_way_en | idx_matches_0_5 & _mshrs_5_io_way_valid & _mshrs_5_io_way_bits == io_req_0_bits_way_en | idx_matches_0_6 & _mshrs_6_io_way_valid & _mshrs_6_io_way_bits == io_req_0_bits_way_en | idx_matches_0_7 & _mshrs_7_io_way_valid & _mshrs_7_io_way_bits == io_req_0_bits_way_en) & ~tag_match_0;
  assign io_secondary_miss_1 = idx_match_1 & (idx_matches_1_0 & _mshrs_0_io_way_valid & _mshrs_0_io_way_bits == io_req_1_bits_way_en | idx_matches_1_1 & _mshrs_1_io_way_valid & _mshrs_1_io_way_bits == io_req_1_bits_way_en | idx_matches_1_2 & _mshrs_2_io_way_valid & _mshrs_2_io_way_bits == io_req_1_bits_way_en | idx_matches_1_3 & _mshrs_3_io_way_valid & _mshrs_3_io_way_bits == io_req_1_bits_way_en | idx_matches_1_4 & _mshrs_4_io_way_valid & _mshrs_4_io_way_bits == io_req_1_bits_way_en | idx_matches_1_5 & _mshrs_5_io_way_valid & _mshrs_5_io_way_bits == io_req_1_bits_way_en | idx_matches_1_6 & _mshrs_6_io_way_valid & _mshrs_6_io_way_bits == io_req_1_bits_way_en | idx_matches_1_7 & _mshrs_7_io_way_valid & _mshrs_7_io_way_bits == io_req_1_bits_way_en) & ~tag_match_1;
  assign io_block_hit_0 = idx_match_0 & tag_match_0;
  assign io_block_hit_1 = idx_match_1 & tag_match_1;
  assign io_mem_acquire_valid = _io_mem_acquire_valid_output;
  assign io_mem_acquire_bits_opcode = (_GEN_20 ? 3'h6 : 3'h0) | (muxState__8 ? _mmios_0_io_mem_access_bits_opcode : 3'h0);
  assign io_mem_acquire_bits_param = (muxState__0 ? _mshrs_0_io_mem_acquire_bits_param : 3'h0) | (muxState__1 ? _mshrs_1_io_mem_acquire_bits_param : 3'h0) | (muxState__2 ? _mshrs_2_io_mem_acquire_bits_param : 3'h0) | (muxState__3 ? _mshrs_3_io_mem_acquire_bits_param : 3'h0) | (muxState__4 ? _mshrs_4_io_mem_acquire_bits_param : 3'h0) | (muxState__5 ? _mshrs_5_io_mem_acquire_bits_param : 3'h0) | (muxState__6 ? _mshrs_6_io_mem_acquire_bits_param : 3'h0) | (muxState__7 ? _mshrs_7_io_mem_acquire_bits_param : 3'h0) | (muxState__8 ? _mmios_0_io_mem_access_bits_param : 3'h0);
  assign io_mem_acquire_bits_size = (_GEN_20 ? 4'h6 : 4'h0) | (muxState__8 ? _mmios_0_io_mem_access_bits_size : 4'h0);
  assign io_mem_acquire_bits_source = (muxState__0 ? _mshrs_0_io_mem_acquire_bits_source : 4'h0) | (muxState__1 ? _mshrs_1_io_mem_acquire_bits_source : 4'h0) | (muxState__2 ? _mshrs_2_io_mem_acquire_bits_source : 4'h0) | (muxState__3 ? _mshrs_3_io_mem_acquire_bits_source : 4'h0) | (muxState__4 ? _mshrs_4_io_mem_acquire_bits_source : 4'h0) | (muxState__5 ? _mshrs_5_io_mem_acquire_bits_source : 4'h0) | (muxState__6 ? _mshrs_6_io_mem_acquire_bits_source : 4'h0) | (muxState__7 ? _mshrs_7_io_mem_acquire_bits_source : 4'h0) | (muxState__8 ? _mmios_0_io_mem_access_bits_source : 4'h0);
  assign io_mem_acquire_bits_address = (muxState__0 ? _mshrs_0_io_mem_acquire_bits_address : 32'h0) | (muxState__1 ? _mshrs_1_io_mem_acquire_bits_address : 32'h0) | (muxState__2 ? _mshrs_2_io_mem_acquire_bits_address : 32'h0) | (muxState__3 ? _mshrs_3_io_mem_acquire_bits_address : 32'h0) | (muxState__4 ? _mshrs_4_io_mem_acquire_bits_address : 32'h0) | (muxState__5 ? _mshrs_5_io_mem_acquire_bits_address : 32'h0) | (muxState__6 ? _mshrs_6_io_mem_acquire_bits_address : 32'h0) | (muxState__7 ? _mshrs_7_io_mem_acquire_bits_address : 32'h0) | (muxState__8 ? _mmios_0_io_mem_access_bits_address : 32'h0);
  assign io_mem_acquire_bits_mask = {16{muxState__0}} | {16{muxState__1}} | {16{muxState__2}} | {16{muxState__3}} | {16{muxState__4}} | {16{muxState__5}} | {16{muxState__6}} | {16{muxState__7}} | (muxState__8 ? _mmios_0_io_mem_access_bits_mask : 16'h0);
  assign io_mem_acquire_bits_data = muxState__8 ? _mmios_0_io_mem_access_bits_data : 128'h0;
  assign io_mem_grant_ready = _mshr_io_mem_ack_valid_T | (_GEN_6 ? _mshrs_7_io_mem_grant_ready : _GEN_5 ? _mshrs_6_io_mem_grant_ready : _GEN_4 ? _mshrs_5_io_mem_grant_ready : _GEN_3 ? _mshrs_4_io_mem_grant_ready : _GEN_2 ? _mshrs_3_io_mem_grant_ready : _GEN_1 ? _mshrs_2_io_mem_grant_ready : _GEN_0 ? _mshrs_1_io_mem_grant_ready : _GEN & _mshrs_0_io_mem_grant_ready);
  assign io_mem_finish_valid = _io_mem_finish_valid_output;
  assign io_mem_finish_bits_sink = ((beatsLeft_1 ? state_1_0 : _mshrs_0_io_mem_finish_valid) ? _mshrs_0_io_mem_finish_bits_sink : 4'h0) | ((beatsLeft_1 ? state_1_1 : winner_1_1) ? _mshrs_1_io_mem_finish_bits_sink : 4'h0) | ((beatsLeft_1 ? state_1_2 : winner_1_2) ? _mshrs_2_io_mem_finish_bits_sink : 4'h0) | ((beatsLeft_1 ? state_1_3 : winner_1_3) ? _mshrs_3_io_mem_finish_bits_sink : 4'h0) | ((beatsLeft_1 ? state_1_4 : winner_1_4) ? _mshrs_4_io_mem_finish_bits_sink : 4'h0) | ((beatsLeft_1 ? state_1_5 : winner_1_5) ? _mshrs_5_io_mem_finish_bits_sink : 4'h0) | ((beatsLeft_1 ? state_1_6 : winner_1_6) ? _mshrs_6_io_mem_finish_bits_sink : 4'h0) | ((beatsLeft_1 ? state_1_7 : winner_1_7) ? _mshrs_7_io_mem_finish_bits_sink : 4'h0);
  assign io_replay_valid = _replay_arb_io_out_valid;
  assign io_replay_bits_uop_mem_cmd = _replay_arb_io_out_bits_uop_mem_cmd;
  assign io_fence_rdy = ~(~_mmios_0_io_req_ready | ~_mshrs_7_io_req_pri_rdy | ~_mshrs_6_io_req_pri_rdy | ~_mshrs_5_io_req_pri_rdy | ~_mshrs_4_io_req_pri_rdy | ~_mshrs_3_io_req_pri_rdy | ~_mshrs_2_io_req_pri_rdy | ~_mshrs_1_io_req_pri_rdy) & _mshrs_0_io_req_pri_rdy;
  assign io_probe_rdy = ~(~_mshrs_7_io_probe_rdy & idx_matches_1_7 & io_req_is_probe_1 | ~_mshrs_7_io_probe_rdy & idx_matches_0_7 & io_req_is_probe_0 | ~_mshrs_6_io_probe_rdy & idx_matches_1_6 & io_req_is_probe_1 | ~_mshrs_6_io_probe_rdy & idx_matches_0_6 & io_req_is_probe_0 | ~_mshrs_5_io_probe_rdy & idx_matches_1_5 & io_req_is_probe_1 | ~_mshrs_5_io_probe_rdy & idx_matches_0_5 & io_req_is_probe_0 | ~_mshrs_4_io_probe_rdy & idx_matches_1_4 & io_req_is_probe_1 | ~_mshrs_4_io_probe_rdy & idx_matches_0_4 & io_req_is_probe_0 | ~_mshrs_3_io_probe_rdy & idx_matches_1_3 & io_req_is_probe_1 | ~_mshrs_3_io_probe_rdy & idx_matches_0_3 & io_req_is_probe_0 | ~_mshrs_2_io_probe_rdy & idx_matches_1_2 & io_req_is_probe_1 | ~_mshrs_2_io_probe_rdy & idx_matches_0_2 & io_req_is_probe_0 | ~_mshrs_1_io_probe_rdy & idx_matches_1_1 & io_req_is_probe_1 | ~_mshrs_1_io_probe_rdy & idx_matches_0_1 & io_req_is_probe_0 | ~_mshrs_0_io_probe_rdy & idx_matches_1_0 & io_req_is_probe_1) & ~(~_mshrs_0_io_probe_rdy & idx_matches_0_0 & io_req_is_probe_0);
endmodule

