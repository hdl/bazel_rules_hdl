// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomMSHR(
  input          clock,
                 reset,
  input  [2:0]   io_id,
  input          io_req_pri_val,
                 io_req_sec_val,
                 io_clear_prefetch,
  input  [19:0]  io_brupdate_b1_resolve_mask,
                 io_brupdate_b1_mispredict_mask,
  input          io_exception,
  input  [19:0]  io_req_uop_br_mask,
  input  [4:0]   io_req_uop_ldq_idx,
                 io_req_uop_stq_idx,
                 io_req_uop_mem_cmd,
  input  [1:0]   io_req_uop_mem_size,
  input          io_req_uop_mem_signed,
                 io_req_uop_is_amo,
                 io_req_uop_uses_ldq,
                 io_req_uop_uses_stq,
  input  [39:0]  io_req_addr,
  input          io_req_is_hella,
                 io_req_tag_match,
  input  [1:0]   io_req_old_meta_coh_state,
  input  [19:0]  io_req_old_meta_tag,
  input  [7:0]   io_req_way_en,
  input  [4:0]   io_req_sdq_id,
  input          io_req_is_probe,
                 io_mem_acquire_ready,
                 io_mem_grant_valid,
  input  [2:0]   io_mem_grant_bits_opcode,
  input  [1:0]   io_mem_grant_bits_param,
  input  [3:0]   io_mem_grant_bits_size,
                 io_mem_grant_bits_sink,
  input  [127:0] io_mem_grant_bits_data,
  input          io_mem_finish_ready,
                 io_prober_state_valid,
  input  [39:0]  io_prober_state_bits,
  input          io_refill_ready,
                 io_meta_write_ready,
                 io_meta_read_ready,
                 io_meta_resp_valid,
  input  [1:0]   io_meta_resp_bits_coh_state,
  input          io_wb_req_ready,
                 io_lb_read_ready,
  input  [127:0] io_lb_resp,
  input          io_lb_write_ready,
                 io_replay_ready,
                 io_resp_ready,
                 io_wb_resp,
  output         io_req_pri_rdy,
                 io_req_sec_rdy,
                 io_idx_valid,
  output [5:0]   io_idx_bits,
  output         io_way_valid,
  output [7:0]   io_way_bits,
  output         io_tag_valid,
  output [27:0]  io_tag_bits,
  output         io_mem_acquire_valid,
  output [2:0]   io_mem_acquire_bits_param,
  output [3:0]   io_mem_acquire_bits_source,
  output [31:0]  io_mem_acquire_bits_address,
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
  output         io_wb_req_valid,
  output [19:0]  io_wb_req_bits_tag,
  output [5:0]   io_wb_req_bits_idx,
  output [2:0]   io_wb_req_bits_param,
  output [7:0]   io_wb_req_bits_way_en,
  output         io_commit_val,
  output [39:0]  io_commit_addr,
  output [1:0]   io_commit_coh_state,
  output         io_lb_read_valid,
  output [2:0]   io_lb_read_bits_id,
  output [1:0]   io_lb_read_bits_offset,
  output         io_lb_write_valid,
  output [2:0]   io_lb_write_bits_id,
  output [1:0]   io_lb_write_bits_offset,
  output [127:0] io_lb_write_bits_data,
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
  output         io_replay_bits_is_hella,
  output [7:0]   io_replay_bits_way_en,
  output [4:0]   io_replay_bits_sdq_id,
  output         io_resp_valid,
  output [19:0]  io_resp_bits_uop_br_mask,
  output [4:0]   io_resp_bits_uop_ldq_idx,
                 io_resp_bits_uop_stq_idx,
  output         io_resp_bits_uop_is_amo,
                 io_resp_bits_uop_uses_ldq,
                 io_resp_bits_uop_uses_stq,
  output [63:0]  io_resp_bits_data,
  output         io_resp_bits_is_hella,
                 io_probe_rdy
);

  wire         _io_replay_valid_output;
  wire         _io_lb_read_valid_output;
  wire         _GEN_3445;
  wire         _io_mem_grant_ready_output;
  wire         _io_req_pri_rdy_output;
  wire         _io_req_sec_rdy_output;
  wire         _rpq_io_enq_ready;
  wire         _rpq_io_deq_valid;
  wire [19:0]  _rpq_io_deq_bits_uop_br_mask;
  wire [4:0]   _rpq_io_deq_bits_uop_ldq_idx;
  wire [4:0]   _rpq_io_deq_bits_uop_stq_idx;
  wire [4:0]   _rpq_io_deq_bits_uop_mem_cmd;
  wire [1:0]   _rpq_io_deq_bits_uop_mem_size;
  wire         _rpq_io_deq_bits_uop_mem_signed;
  wire         _rpq_io_deq_bits_uop_is_amo;
  wire         _rpq_io_deq_bits_uop_uses_ldq;
  wire         _rpq_io_deq_bits_uop_uses_stq;
  wire [39:0]  _rpq_io_deq_bits_addr;
  wire         _rpq_io_deq_bits_is_hella;
  wire         _rpq_io_empty;
  reg  [1:0]   casez_tmp;
  reg  [1:0]   casez_tmp_0;
  reg  [1:0]   casez_tmp_1;
  reg  [1:0]   casez_tmp_2;
  reg  [1:0]   casez_tmp_3;
  reg  [1:0]   casez_tmp_4;
  reg  [1:0]   casez_tmp_5;
  reg  [4:0]   state;
  reg  [4:0]   req_uop_mem_cmd;
  reg  [39:0]  req_addr;
  reg  [1:0]   req_old_meta_coh_state;
  reg  [19:0]  req_old_meta_tag;
  reg  [7:0]   req_way_en;
  reg  [1:0]   new_coh_state;
  wire         _needs_second_acq_T_27 = req_uop_mem_cmd == 5'h1;
  wire         _needs_second_acq_T_28 = req_uop_mem_cmd == 5'h11;
  wire         _needs_second_acq_T_30 = req_uop_mem_cmd == 5'h7;
  wire         _needs_second_acq_T_32 = req_uop_mem_cmd == 5'h4;
  wire         _needs_second_acq_T_33 = req_uop_mem_cmd == 5'h9;
  wire         _needs_second_acq_T_34 = req_uop_mem_cmd == 5'hA;
  wire         _needs_second_acq_T_35 = req_uop_mem_cmd == 5'hB;
  wire         _needs_second_acq_T_39 = req_uop_mem_cmd == 5'h8;
  wire         _needs_second_acq_T_40 = req_uop_mem_cmd == 5'hC;
  wire         _needs_second_acq_T_41 = req_uop_mem_cmd == 5'hD;
  wire         _needs_second_acq_T_42 = req_uop_mem_cmd == 5'hE;
  wire         _needs_second_acq_T_43 = req_uop_mem_cmd == 5'hF;
  wire         _needs_second_acq_T_50 = req_uop_mem_cmd == 5'h3;
  wire         _needs_second_acq_T_52 = req_uop_mem_cmd == 5'h6;
  wire [3:0]   _grow_param_T = {_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30 | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34 | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40 | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43, _needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30 | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34 | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40 | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43 | _needs_second_acq_T_50 | _needs_second_acq_T_52, new_coh_state};
  wire [1:0]   _grow_param_T_27 = {1'h0, _grow_param_T == 4'hC};
  always @(*) begin
    casez (_grow_param_T)
      4'b0000:
        casez_tmp = 2'h0;
      4'b0001:
        casez_tmp = 2'h1;
      4'b0010:
        casez_tmp = 2'h2;
      4'b0011:
        casez_tmp = 2'h3;
      4'b0100:
        casez_tmp = 2'h1;
      4'b0101:
        casez_tmp = 2'h2;
      4'b0110:
        casez_tmp = 2'h2;
      4'b0111:
        casez_tmp = 2'h3;
      4'b1000:
        casez_tmp = _grow_param_T_27;
      4'b1001:
        casez_tmp = _grow_param_T_27;
      4'b1010:
        casez_tmp = _grow_param_T_27;
      4'b1011:
        casez_tmp = _grow_param_T_27;
      4'b1100:
        casez_tmp = _grow_param_T_27;
      4'b1101:
        casez_tmp = 2'h2;
      4'b1110:
        casez_tmp = 2'h3;
      default:
        casez_tmp = 2'h3;
    endcase
  end // always @(*)
  wire [3:0]   _coh_on_grant_T = {_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30 | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34 | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40 | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43, _needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30 | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34 | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40 | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43 | _needs_second_acq_T_50 | _needs_second_acq_T_52, io_mem_grant_bits_param};
  wire [1:0]   _coh_on_grant_T_10 = {1'h0, _coh_on_grant_T == 4'h1};
  wire         _GEN = _coh_on_grant_T == 4'h4 | _coh_on_grant_T == 4'h0;
  wire         _coh_on_grant_T_15 = _coh_on_grant_T == 4'hC;
  wire [3:0]   _GEN_0 = {_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30 | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34 | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40 | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43, _needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30 | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34 | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40 | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43 | _needs_second_acq_T_50 | _needs_second_acq_T_52, new_coh_state};
  wire [1:0]   _GEN_1 = {1'h0, _GEN_0 == 4'hC};
  always @(*) begin
    casez (_GEN_0)
      4'b0000:
        casez_tmp_0 = 2'h0;
      4'b0001:
        casez_tmp_0 = 2'h1;
      4'b0010:
        casez_tmp_0 = 2'h2;
      4'b0011:
        casez_tmp_0 = 2'h3;
      4'b0100:
        casez_tmp_0 = 2'h1;
      4'b0101:
        casez_tmp_0 = 2'h2;
      4'b0110:
        casez_tmp_0 = 2'h2;
      4'b0111:
        casez_tmp_0 = 2'h3;
      4'b1000:
        casez_tmp_0 = _GEN_1;
      4'b1001:
        casez_tmp_0 = _GEN_1;
      4'b1010:
        casez_tmp_0 = _GEN_1;
      4'b1011:
        casez_tmp_0 = _GEN_1;
      4'b1100:
        casez_tmp_0 = _GEN_1;
      4'b1101:
        casez_tmp_0 = 2'h2;
      4'b1110:
        casez_tmp_0 = 2'h3;
      default:
        casez_tmp_0 = 2'h3;
    endcase
  end // always @(*)
  wire         _state_T_157 = io_req_uop_mem_cmd == 5'h1;
  wire         _state_T_158 = io_req_uop_mem_cmd == 5'h11;
  wire         _state_T_160 = io_req_uop_mem_cmd == 5'h7;
  wire         _state_T_162 = io_req_uop_mem_cmd == 5'h4;
  wire         _state_T_163 = io_req_uop_mem_cmd == 5'h9;
  wire         _state_T_164 = io_req_uop_mem_cmd == 5'hA;
  wire         _state_T_165 = io_req_uop_mem_cmd == 5'hB;
  wire         _state_T_169 = io_req_uop_mem_cmd == 5'h8;
  wire         _state_T_170 = io_req_uop_mem_cmd == 5'hC;
  wire         _state_T_171 = io_req_uop_mem_cmd == 5'hD;
  wire         _state_T_172 = io_req_uop_mem_cmd == 5'hE;
  wire         _state_T_173 = io_req_uop_mem_cmd == 5'hF;
  wire         _state_c_cat_T_96 = io_req_uop_mem_cmd == 5'h3;
  wire         _state_c_cat_T_98 = io_req_uop_mem_cmd == 5'h6;
  wire [3:0]   _GEN_2 = {_state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173, _state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173 | _state_c_cat_T_96 | _state_c_cat_T_98, new_coh_state};
  wire [1:0]   _GEN_3 = {1'h0, _GEN_2 == 4'hC};
  always @(*) begin
    casez (_GEN_2)
      4'b0000:
        casez_tmp_1 = 2'h0;
      4'b0001:
        casez_tmp_1 = 2'h1;
      4'b0010:
        casez_tmp_1 = 2'h2;
      4'b0011:
        casez_tmp_1 = 2'h3;
      4'b0100:
        casez_tmp_1 = 2'h1;
      4'b0101:
        casez_tmp_1 = 2'h2;
      4'b0110:
        casez_tmp_1 = 2'h2;
      4'b0111:
        casez_tmp_1 = 2'h3;
      4'b1000:
        casez_tmp_1 = _GEN_3;
      4'b1001:
        casez_tmp_1 = _GEN_3;
      4'b1010:
        casez_tmp_1 = _GEN_3;
      4'b1011:
        casez_tmp_1 = _GEN_3;
      4'b1100:
        casez_tmp_1 = _GEN_3;
      4'b1101:
        casez_tmp_1 = 2'h2;
      4'b1110:
        casez_tmp_1 = 2'h3;
      default:
        casez_tmp_1 = 2'h3;
    endcase
  end // always @(*)
  wire         _GEN_4 = _io_mem_grant_ready_output & io_mem_grant_valid;
  wire [26:0]  _beats1_decode_T_1 = 27'hFFF << io_mem_grant_bits_size;
  wire [7:0]   beats1 = io_mem_grant_bits_opcode[0] ? ~(_beats1_decode_T_1[11:4]) : 8'h0;
  reg  [7:0]   counter;
  wire [7:0]   _counter1_T = counter - 8'h1;
  wire         refill_done = (counter == 8'h1 | beats1 == 8'h0) & _GEN_4;
  wire         _GEN_707 = state == 5'hD;
  wire         _sec_rdy_T_5 = state == 5'hE;
  wire         _sec_rdy_T_6 = state == 5'hF;
  wire         _rpq_io_enq_valid_T = io_req_pri_val & _io_req_pri_rdy_output;
  wire         _rpq_io_enq_valid_T_1 = io_req_sec_val & _io_req_sec_rdy_output;
  wire         _rpq_io_enq_valid_T_7 = (_rpq_io_enq_valid_T | _rpq_io_enq_valid_T_1) & ~(io_req_uop_mem_cmd == 5'h2 | _state_c_cat_T_96);
  reg          grantack_valid;
  reg  [3:0]   grantack_bits_sink;
  reg  [1:0]   refill_ctr;
  reg          commit_line;
  reg          grant_had_data;
  reg          finish_to_prefetch;
  reg  [1:0]   meta_hazard;
  wire         _GEN_3026 = state == 5'h1;
  wire         _io_probe_rdy_T_3 = state == 5'h2;
  wire         _io_probe_rdy_T_4 = state == 5'h3;
  wire         _io_probe_rdy_T_8 = state == 5'h4;
  wire         _GEN_423 = state == 5'h11;
  assign _io_req_sec_rdy_output = ~((_state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173 | _state_c_cat_T_96 | _state_c_cat_T_98) & ~(_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30 | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34 | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40 | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43 | _needs_second_acq_T_50 | _needs_second_acq_T_52)) & ~io_req_is_probe & ~(~(|state) | _GEN_707 | _sec_rdy_T_5 | _sec_rdy_T_6) & _rpq_io_enq_ready;
  wire [3:0]   _state_T_3 = {_state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173, _state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173 | _state_c_cat_T_96 | _state_c_cat_T_98, io_req_old_meta_coh_state};
  wire         state_is_hit = _state_T_3 == 4'h3 | _state_T_3 == 4'h2 | _state_T_3 == 4'h1 | _state_T_3 == 4'h7 | _state_T_3 == 4'h6 | (&_state_T_3) | _state_T_3 == 4'hE;
  wire [1:0]   _state_T_30 = {1'h0, _state_T_3 == 4'hC};
  always @(*) begin
    casez (_state_T_3)
      4'b0000:
        casez_tmp_2 = 2'h0;
      4'b0001:
        casez_tmp_2 = 2'h1;
      4'b0010:
        casez_tmp_2 = 2'h2;
      4'b0011:
        casez_tmp_2 = 2'h3;
      4'b0100:
        casez_tmp_2 = 2'h1;
      4'b0101:
        casez_tmp_2 = 2'h2;
      4'b0110:
        casez_tmp_2 = 2'h2;
      4'b0111:
        casez_tmp_2 = 2'h3;
      4'b1000:
        casez_tmp_2 = _state_T_30;
      4'b1001:
        casez_tmp_2 = _state_T_30;
      4'b1010:
        casez_tmp_2 = _state_T_30;
      4'b1011:
        casez_tmp_2 = _state_T_30;
      4'b1100:
        casez_tmp_2 = _state_T_30;
      4'b1101:
        casez_tmp_2 = 2'h2;
      4'b1110:
        casez_tmp_2 = 2'h3;
      default:
        casez_tmp_2 = 2'h3;
    endcase
  end // always @(*)
  wire         _c_cat_T_148 = _rpq_io_deq_bits_uop_mem_cmd == 5'h6;
  wire         _c_cat_T_126 = _rpq_io_deq_bits_uop_mem_cmd == 5'h7;
  wire         _c_cat_T_128 = _rpq_io_deq_bits_uop_mem_cmd == 5'h4;
  wire         _c_cat_T_129 = _rpq_io_deq_bits_uop_mem_cmd == 5'h9;
  wire         _c_cat_T_130 = _rpq_io_deq_bits_uop_mem_cmd == 5'hA;
  wire         _c_cat_T_131 = _rpq_io_deq_bits_uop_mem_cmd == 5'hB;
  wire         _c_cat_T_135 = _rpq_io_deq_bits_uop_mem_cmd == 5'h8;
  wire         _c_cat_T_136 = _rpq_io_deq_bits_uop_mem_cmd == 5'hC;
  wire         _c_cat_T_137 = _rpq_io_deq_bits_uop_mem_cmd == 5'hD;
  wire         _c_cat_T_138 = _rpq_io_deq_bits_uop_mem_cmd == 5'hE;
  wire         _c_cat_T_139 = _rpq_io_deq_bits_uop_mem_cmd == 5'hF;
  wire         _c_cat_T_123 = _rpq_io_deq_bits_uop_mem_cmd == 5'h1;
  wire         _c_cat_T_124 = _rpq_io_deq_bits_uop_mem_cmd == 5'h11;
  wire         drain_load = (_rpq_io_deq_bits_uop_mem_cmd == 5'h0 | _rpq_io_deq_bits_uop_mem_cmd == 5'h10 | _c_cat_T_148 | _c_cat_T_126 | _c_cat_T_128 | _c_cat_T_129 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_135 | _c_cat_T_136 | _c_cat_T_137 | _c_cat_T_138 | _c_cat_T_139) & ~(_c_cat_T_123 | _c_cat_T_124 | _c_cat_T_126 | _c_cat_T_128 | _c_cat_T_129 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_135 | _c_cat_T_136 | _c_cat_T_137 | _c_cat_T_138 | _c_cat_T_139) & _rpq_io_deq_bits_uop_mem_cmd != 5'h6;
  wire [127:0] data_word = io_lb_resp >> {121'h0, _rpq_io_deq_bits_addr[3], 6'h0};
  wire         _io_refill_valid_T = io_lb_read_ready & _io_lb_read_valid_output;
  wire [31:0]  io_resp_bits_data_zeroed = _rpq_io_deq_bits_addr[2] ? data_word[63:32] : data_word[31:0];
  wire [15:0]  io_resp_bits_data_zeroed_1 = _rpq_io_deq_bits_addr[1] ? io_resp_bits_data_zeroed[31:16] : io_resp_bits_data_zeroed[15:0];
  wire [7:0]   io_resp_bits_data_zeroed_2 = _rpq_io_deq_bits_addr[0] ? io_resp_bits_data_zeroed_1[15:8] : io_resp_bits_data_zeroed_1[7:0];
  wire         _GEN_5 = _GEN_3445 & _rpq_io_deq_valid;
  wire         _GEN_6 = _rpq_io_empty & ~commit_line;
  wire         _GEN_116 = _rpq_io_empty | _rpq_io_deq_valid & ~drain_load;
  wire         _GEN_7 = state == 5'h5;
  wire         _GEN_8 = state == 5'h6;
  wire         _GEN_9 = state == 5'h7;
  wire         _GEN_1398 = state == 5'h9;
  wire         _GEN_10 = state == 5'hA;
  wire         _GEN_1000 = state == 5'hB;
  wire         _GEN_11 = state == 5'hC;
  wire         _GEN_12 = io_replay_ready & _io_replay_valid_output & (_c_cat_T_123 | _c_cat_T_124 | _c_cat_T_126 | _c_cat_T_128 | _c_cat_T_129 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_135 | _c_cat_T_136 | _c_cat_T_137 | _c_cat_T_138 | _c_cat_T_139);
  wire [3:0]   _GEN_13 = {_c_cat_T_123 | _c_cat_T_124 | _c_cat_T_126 | _c_cat_T_128 | _c_cat_T_129 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_135 | _c_cat_T_136 | _c_cat_T_137 | _c_cat_T_138 | _c_cat_T_139, _c_cat_T_123 | _c_cat_T_124 | _c_cat_T_126 | _c_cat_T_128 | _c_cat_T_129 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_135 | _c_cat_T_136 | _c_cat_T_137 | _c_cat_T_138 | _c_cat_T_139 | _rpq_io_deq_bits_uop_mem_cmd == 5'h3 | _c_cat_T_148, new_coh_state};
  wire [1:0]   _GEN_14 = {1'h0, _GEN_13 == 4'hC};
  always @(*) begin
    casez (_GEN_13)
      4'b0000:
        casez_tmp_3 = 2'h0;
      4'b0001:
        casez_tmp_3 = 2'h1;
      4'b0010:
        casez_tmp_3 = 2'h2;
      4'b0011:
        casez_tmp_3 = 2'h3;
      4'b0100:
        casez_tmp_3 = 2'h1;
      4'b0101:
        casez_tmp_3 = 2'h2;
      4'b0110:
        casez_tmp_3 = 2'h2;
      4'b0111:
        casez_tmp_3 = 2'h3;
      4'b1000:
        casez_tmp_3 = _GEN_14;
      4'b1001:
        casez_tmp_3 = _GEN_14;
      4'b1010:
        casez_tmp_3 = _GEN_14;
      4'b1011:
        casez_tmp_3 = _GEN_14;
      4'b1100:
        casez_tmp_3 = _GEN_14;
      4'b1101:
        casez_tmp_3 = 2'h2;
      4'b1110:
        casez_tmp_3 = 2'h3;
      default:
        casez_tmp_3 = 2'h3;
    endcase
  end // always @(*)
  wire         _GEN_15 = io_req_sec_val & ~_io_req_sec_rdy_output | io_clear_prefetch;
  wire [3:0]   _GEN_16 = {_state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173, _state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173 | _state_c_cat_T_96 | _state_c_cat_T_98, new_coh_state};
  wire [1:0]   _GEN_17 = {1'h0, _GEN_16 == 4'hC};
  always @(*) begin
    casez (_GEN_16)
      4'b0000:
        casez_tmp_4 = 2'h0;
      4'b0001:
        casez_tmp_4 = 2'h1;
      4'b0010:
        casez_tmp_4 = 2'h2;
      4'b0011:
        casez_tmp_4 = 2'h3;
      4'b0100:
        casez_tmp_4 = 2'h1;
      4'b0101:
        casez_tmp_4 = 2'h2;
      4'b0110:
        casez_tmp_4 = 2'h2;
      4'b0111:
        casez_tmp_4 = 2'h3;
      4'b1000:
        casez_tmp_4 = _GEN_17;
      4'b1001:
        casez_tmp_4 = _GEN_17;
      4'b1010:
        casez_tmp_4 = _GEN_17;
      4'b1011:
        casez_tmp_4 = _GEN_17;
      4'b1100:
        casez_tmp_4 = _GEN_17;
      4'b1101:
        casez_tmp_4 = 2'h2;
      4'b1110:
        casez_tmp_4 = 2'h3;
      default:
        casez_tmp_4 = 2'h3;
    endcase
  end // always @(*)
  wire [3:0]   _state_T_97 = {_state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173, _state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173 | _state_c_cat_T_96 | _state_c_cat_T_98, io_req_old_meta_coh_state};
  wire         state_is_hit_1 = _state_T_97 == 4'h3 | _state_T_97 == 4'h2 | _state_T_97 == 4'h1 | _state_T_97 == 4'h7 | _state_T_97 == 4'h6 | (&_state_T_97) | _state_T_97 == 4'hE;
  wire [1:0]   _state_T_124 = {1'h0, _state_T_97 == 4'hC};
  always @(*) begin
    casez (_state_T_97)
      4'b0000:
        casez_tmp_5 = 2'h0;
      4'b0001:
        casez_tmp_5 = 2'h1;
      4'b0010:
        casez_tmp_5 = 2'h2;
      4'b0011:
        casez_tmp_5 = 2'h3;
      4'b0100:
        casez_tmp_5 = 2'h1;
      4'b0101:
        casez_tmp_5 = 2'h2;
      4'b0110:
        casez_tmp_5 = 2'h2;
      4'b0111:
        casez_tmp_5 = 2'h3;
      4'b1000:
        casez_tmp_5 = _state_T_124;
      4'b1001:
        casez_tmp_5 = _state_T_124;
      4'b1010:
        casez_tmp_5 = _state_T_124;
      4'b1011:
        casez_tmp_5 = _state_T_124;
      4'b1100:
        casez_tmp_5 = _state_T_124;
      4'b1101:
        casez_tmp_5 = 2'h2;
      4'b1110:
        casez_tmp_5 = 2'h3;
      default:
        casez_tmp_5 = 2'h3;
    endcase
  end // always @(*)
  wire         _GEN_18 = _GEN_15 | _rpq_io_enq_valid_T_1;
  wire         _GEN_19 = _GEN_707 | _sec_rdy_T_5 | _sec_rdy_T_6;
  wire         _GEN_20 = _GEN_11 | _GEN_19;
  wire         _GEN_21 = _GEN_1398 | _GEN_10 | _GEN_1000 | _GEN_11;
  wire         _GEN_22 = _io_probe_rdy_T_8 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_1398 | _GEN_10;
  wire         _GEN_23 = _io_probe_rdy_T_8 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_1398 | _GEN_10 | _GEN_1000;
  wire         _GEN_24 = _io_probe_rdy_T_4 | _GEN_23;
  wire         _GEN_25 = _io_probe_rdy_T_4 | _io_probe_rdy_T_8 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_1398 | _GEN_10 | _GEN_1000 | _GEN_11 | _GEN_707;
  wire         _GEN_26 = _io_probe_rdy_T_4 | _io_probe_rdy_T_8 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_1398 | _GEN_10 | _GEN_1000 | _GEN_20;
  wire         _GEN_27 = _GEN_3026 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4 | _GEN_22;
  wire         _GEN_28 = _GEN_3026 | _io_probe_rdy_T_3 | _GEN_26;
  assign _io_req_pri_rdy_output = ~(|state) | ~_GEN_28 & _GEN_423;
  wire         _io_mem_acquire_valid_output = (|state) & _GEN_3026;
  wire         _GEN_29 = ~(|state) | _GEN_3026;
  assign _io_mem_grant_ready_output = ~_GEN_29 & _io_probe_rdy_T_3 & (~(io_mem_grant_bits_opcode[0]) | io_lb_write_ready);
  wire         _GEN_30 = ~(|state) | _GEN_3026 | _io_probe_rdy_T_3;
  assign _GEN_3445 = ~_GEN_30 & (_io_probe_rdy_T_4 ? io_resp_ready & io_lb_read_ready & drain_load : ~_GEN_23 & _GEN_11 & io_replay_ready);
  assign _io_lb_read_valid_output = ~_GEN_30 & (_io_probe_rdy_T_4 ? _rpq_io_deq_valid & drain_load : ~_GEN_22 & _GEN_1000);
  wire         _io_meta_read_valid_output = ~(~(|state) | _GEN_3026 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4) & _io_probe_rdy_T_8 & (~io_prober_state_valid | ~grantack_valid | io_prober_state_bits[11:6] != req_addr[11:6]);
  wire         _io_meta_write_valid_output = ~(~(|state) | _GEN_3026 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4 | _io_probe_rdy_T_8 | _GEN_7 | _GEN_8) & (_GEN_9 | ~_GEN_21 & _GEN_707);
  wire         _io_wb_req_valid_output = ~(~(|state) | _GEN_3026 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4 | _io_probe_rdy_T_8 | _GEN_7 | _GEN_8 | _GEN_9) & _GEN_1398;
  wire         _io_refill_valid_output = ~(~(|state) | _GEN_27) & _GEN_1000 & _io_refill_valid_T;
  assign _io_replay_valid_output = ~(~(|state) | _GEN_3026 | _io_probe_rdy_T_3 | _GEN_24) & _GEN_11 & _rpq_io_deq_valid;
  wire         _io_mem_finish_valid_output = ~(~(|state) | _GEN_3026 | _io_probe_rdy_T_3 | _GEN_25) & _sec_rdy_T_5 & grantack_valid;
  wire         is_hit_1 = _GEN_16 == 4'h3 | _GEN_16 == 4'h2 | _GEN_16 == 4'h1 | _GEN_16 == 4'h7 | _GEN_16 == 4'h6 | (&_GEN_16) | _GEN_16 == 4'hE;
  wire         _GEN_31 = _rpq_io_enq_valid_T_1 & (_GEN_0 == 4'h3 | _GEN_0 == 4'h2 | _GEN_0 == 4'h1 | _GEN_0 == 4'h7 | _GEN_0 == 4'h6 | (&_GEN_0) | _GEN_0 == 4'hE) & (_GEN_2 == 4'h3 | _GEN_2 == 4'h2 | _GEN_2 == 4'h1 | _GEN_2 == 4'h7 | _GEN_2 == 4'h6 | (&_GEN_2) | _GEN_2 == 4'hE);
  wire [1:0]   dirties_cat = {_state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173, _state_T_157 | _state_T_158 | _state_T_160 | _state_T_162 | _state_T_163 | _state_T_164 | _state_T_165 | _state_T_169 | _state_T_170 | _state_T_171 | _state_T_172 | _state_T_173 | _state_c_cat_T_96 | _state_c_cat_T_98};
  wire         _GEN_32 = io_meta_write_ready & _io_meta_write_valid_output;
  wire         _GEN_33 = _rpq_io_enq_valid_T_1 & (&dirties_cat);
  wire         _GEN_34 = _rpq_io_enq_ready & _rpq_io_enq_valid_T_7;
  wire         _GEN_35 = io_refill_ready & _io_refill_valid_output;
  wire         _GEN_36 = io_mem_finish_ready & _io_mem_finish_valid_output | ~grantack_valid;
  always @(posedge clock) begin
    if (reset) begin
      state <= 5'h0;
      new_coh_state <= 2'h0;
      counter <= 8'h0;
      meta_hazard <= 2'h0;
    end
    else begin
      if (|state) begin
        if (_GEN_3026) begin
          if (io_mem_acquire_ready & _io_mem_acquire_valid_output)
            state <= 5'h2;
          if (_GEN_31) begin
            if (&dirties_cat)
              new_coh_state <= casez_tmp_1;
            else
              new_coh_state <= casez_tmp_0;
          end
        end
        else if (_io_probe_rdy_T_3) begin
          if (refill_done) begin
            if (grant_had_data)
              state <= 5'h3;
            else
              state <= 5'hC;
            if (_coh_on_grant_T_15)
              new_coh_state <= 2'h3;
            else if (_GEN)
              new_coh_state <= 2'h2;
            else
              new_coh_state <= _coh_on_grant_T_10;
          end
          else if (_GEN_31) begin
            if (&dirties_cat)
              new_coh_state <= casez_tmp_1;
            else
              new_coh_state <= casez_tmp_0;
          end
        end
        else begin
          if (_io_probe_rdy_T_4) begin
            if (~_GEN_5) begin
              if (_GEN_6) begin
                if (~_GEN_34)
                  state <= 5'hE;
              end
              else if (_GEN_116)
                state <= 5'h4;
            end
          end
          else if (_io_probe_rdy_T_8) begin
            if (io_meta_read_ready & _io_meta_read_valid_output)
              state <= 5'h5;
          end
          else if (_GEN_7)
            state <= 5'h6;
          else if (_GEN_8) begin
            if (io_meta_resp_valid) begin
              if (&io_meta_resp_bits_coh_state)
                state <= 5'h7;
              else
                state <= 5'hB;
            end
            else
              state <= 5'h4;
          end
          else if (_GEN_9) begin
            if (_GEN_32)
              state <= 5'h9;
          end
          else if (_GEN_1398) begin
            if (io_wb_req_ready & _io_wb_req_valid_output)
              state <= 5'hA;
          end
          else if (_GEN_10) begin
            if (io_wb_resp)
              state <= 5'hB;
          end
          else if (_GEN_1000) begin
            if (_GEN_35 & (&refill_ctr))
              state <= 5'hC;
          end
          else if (_GEN_11) begin
            if (_rpq_io_empty & ~_rpq_io_enq_valid_T_7)
              state <= 5'hD;
          end
          else if (_GEN_707) begin
            if (_GEN_32)
              state <= 5'hE;
          end
          else if (_sec_rdy_T_5) begin
            if (_GEN_36)
              state <= 5'hF;
          end
          else if (_sec_rdy_T_6) begin
            if (finish_to_prefetch)
              state <= 5'h11;
            else
              state <= 5'h0;
          end
          else if (_GEN_423) begin
            if (_GEN_15)
              state <= 5'h0;
            else if (_rpq_io_enq_valid_T_1) begin
              if (is_hit_1)
                state <= 5'h4;
              else
                state <= 5'h1;
            end
            else if (_rpq_io_enq_valid_T) begin
              if (io_req_tag_match & state_is_hit_1)
                state <= 5'hC;
              else
                state <= 5'h1;
            end
          end
          if (_GEN_24) begin
            if (_GEN_31) begin
              if (&dirties_cat)
                new_coh_state <= casez_tmp_1;
              else
                new_coh_state <= casez_tmp_0;
            end
          end
          else if (_GEN_11) begin
            if (_GEN_12)
              new_coh_state <= casez_tmp_3;
            else if (_GEN_31) begin
              if (&dirties_cat)
                new_coh_state <= casez_tmp_1;
              else
                new_coh_state <= casez_tmp_0;
            end
          end
          else if (_GEN_19 | ~_GEN_423 | _GEN_15) begin
            if (_GEN_31) begin
              if (&dirties_cat)
                new_coh_state <= casez_tmp_1;
              else
                new_coh_state <= casez_tmp_0;
            end
          end
          else if (_rpq_io_enq_valid_T_1) begin
            if (is_hit_1)
              new_coh_state <= casez_tmp_4;
            else
              new_coh_state <= 2'h0;
          end
          else if (_rpq_io_enq_valid_T) begin
            if (io_req_tag_match) begin
              if (state_is_hit_1)
                new_coh_state <= casez_tmp_5;
              else
                new_coh_state <= io_req_old_meta_coh_state;
            end
            else
              new_coh_state <= 2'h0;
          end
          else if (_GEN_31) begin
            if (&dirties_cat)
              new_coh_state <= casez_tmp_1;
            else
              new_coh_state <= casez_tmp_0;
          end
        end
      end
      else if (_rpq_io_enq_valid_T) begin
        if (io_req_tag_match & state_is_hit)
          state <= 5'hC;
        else
          state <= 5'h1;
        if (io_req_tag_match) begin
          if (state_is_hit)
            new_coh_state <= casez_tmp_2;
          else
            new_coh_state <= io_req_old_meta_coh_state;
        end
        else
          new_coh_state <= 2'h0;
      end
      else if (_GEN_31) begin
        if (&dirties_cat)
          new_coh_state <= casez_tmp_1;
        else
          new_coh_state <= casez_tmp_0;
      end
      if (_GEN_4) begin
        if (counter == 8'h0) begin
          if (io_mem_grant_bits_opcode[0])
            counter <= ~(_beats1_decode_T_1[11:4]);
          else
            counter <= 8'h0;
        end
        else
          counter <= _counter1_T;
      end
      if (_GEN_32)
        meta_hazard <= 2'h1;
      else if (|meta_hazard)
        meta_hazard <= meta_hazard + 2'h1;
    end
    if ((|state) ? ~_GEN_28 & _GEN_423 & ~_GEN_18 & _rpq_io_enq_valid_T | _GEN_33 : _rpq_io_enq_valid_T | _GEN_33)
      req_uop_mem_cmd <= io_req_uop_mem_cmd;
    if (|state) begin
      if (_GEN_28 | ~_GEN_423 | _GEN_18 | ~_rpq_io_enq_valid_T) begin
      end
      else begin
        req_addr <= io_req_addr;
        req_old_meta_coh_state <= io_req_old_meta_coh_state;
        req_old_meta_tag <= io_req_old_meta_tag;
        req_way_en <= io_req_way_en;
      end
      if (~_GEN_3026) begin
        if (_io_probe_rdy_T_3) begin
          if (refill_done)
            grantack_valid <= io_mem_grant_bits_opcode[2] & ~(io_mem_grant_bits_opcode[1]);
        end
        else if (~_GEN_25) begin
          if (_sec_rdy_T_5)
            grantack_valid <= ~_GEN_36 & grantack_valid;
          else
            grantack_valid <= (_sec_rdy_T_6 | ~_GEN_423 | _GEN_18 | ~_rpq_io_enq_valid_T) & grantack_valid;
        end
      end
      if (~_GEN_27) begin
        if (_GEN_1000) begin
          if (_GEN_35)
            refill_ctr <= refill_ctr + 2'h1;
        end
        else if (_GEN_20 | ~_GEN_423 | _GEN_18 | ~_rpq_io_enq_valid_T) begin
        end
        else
          refill_ctr <= 2'h0;
      end
    end
    else begin
      if (_rpq_io_enq_valid_T) begin
        req_addr <= io_req_addr;
        req_old_meta_coh_state <= io_req_old_meta_coh_state;
        req_old_meta_tag <= io_req_old_meta_tag;
        req_way_en <= io_req_way_en;
        refill_ctr <= 2'h0;
      end
      grantack_valid <= ~_rpq_io_enq_valid_T & grantack_valid;
    end
    if (_GEN_29 | ~(_io_probe_rdy_T_3 & refill_done)) begin
    end
    else
      grantack_bits_sink <= io_mem_grant_bits_sink;
    if (~_GEN_29) begin
      if (_io_probe_rdy_T_3)
        commit_line <= ~refill_done & commit_line;
      else
        commit_line <= _io_probe_rdy_T_4 & _GEN_5 | commit_line;
    end
    grant_had_data <= (|state) & (_GEN_3026 ? grant_had_data : _io_probe_rdy_T_3 ? (_GEN_4 ? io_mem_grant_bits_opcode[0] : grant_had_data) : (_GEN_26 | ~_GEN_423 | _GEN_18 | ~_rpq_io_enq_valid_T) & grant_had_data);
    if (~_GEN_30) begin
      if (_io_probe_rdy_T_4)
        finish_to_prefetch <= ~_GEN_5 & _GEN_6 & ~_GEN_34 | finish_to_prefetch;
      else
        finish_to_prefetch <= (_io_probe_rdy_T_8 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_21 | ~(_GEN_707 & _GEN_32)) & finish_to_prefetch;
    end
  end // always @(posedge)
  BranchKillableQueue rpq (
    .clock                          (clock),
    .reset                          (reset),
    .io_enq_valid                   (_rpq_io_enq_valid_T_7),
    .io_enq_bits_uop_br_mask        (io_req_uop_br_mask),
    .io_enq_bits_uop_ldq_idx        (io_req_uop_ldq_idx),
    .io_enq_bits_uop_stq_idx        (io_req_uop_stq_idx),
    .io_enq_bits_uop_mem_cmd        (io_req_uop_mem_cmd),
    .io_enq_bits_uop_mem_size       (io_req_uop_mem_size),
    .io_enq_bits_uop_mem_signed     (io_req_uop_mem_signed),
    .io_enq_bits_uop_is_amo         (io_req_uop_is_amo),
    .io_enq_bits_uop_uses_ldq       (io_req_uop_uses_ldq),
    .io_enq_bits_uop_uses_stq       (io_req_uop_uses_stq),
    .io_enq_bits_addr               (io_req_addr),
    .io_enq_bits_is_hella           (io_req_is_hella),
    .io_enq_bits_sdq_id             (io_req_sdq_id),
    .io_deq_ready                   (_GEN_3445),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_flush                       (io_exception),
    .io_enq_ready                   (_rpq_io_enq_ready),
    .io_deq_valid                   (_rpq_io_deq_valid),
    .io_deq_bits_uop_br_mask        (_rpq_io_deq_bits_uop_br_mask),
    .io_deq_bits_uop_ldq_idx        (_rpq_io_deq_bits_uop_ldq_idx),
    .io_deq_bits_uop_stq_idx        (_rpq_io_deq_bits_uop_stq_idx),
    .io_deq_bits_uop_mem_cmd        (_rpq_io_deq_bits_uop_mem_cmd),
    .io_deq_bits_uop_mem_size       (_rpq_io_deq_bits_uop_mem_size),
    .io_deq_bits_uop_mem_signed     (_rpq_io_deq_bits_uop_mem_signed),
    .io_deq_bits_uop_is_amo         (_rpq_io_deq_bits_uop_is_amo),
    .io_deq_bits_uop_uses_ldq       (_rpq_io_deq_bits_uop_uses_ldq),
    .io_deq_bits_uop_uses_stq       (_rpq_io_deq_bits_uop_uses_stq),
    .io_deq_bits_addr               (_rpq_io_deq_bits_addr),
    .io_deq_bits_is_hella           (_rpq_io_deq_bits_is_hella),
    .io_deq_bits_sdq_id             (io_replay_bits_sdq_id),
    .io_empty                       (_rpq_io_empty)
  );
  assign io_req_pri_rdy = _io_req_pri_rdy_output;
  assign io_req_sec_rdy = _io_req_sec_rdy_output;
  assign io_idx_valid = |state;
  assign io_idx_bits = req_addr[11:6];
  assign io_way_valid = ~(~(|state) | _GEN_423);
  assign io_way_bits = req_way_en;
  assign io_tag_valid = |state;
  assign io_tag_bits = req_addr[39:12];
  assign io_mem_acquire_valid = _io_mem_acquire_valid_output;
  assign io_mem_acquire_bits_param = {1'h0, casez_tmp};
  assign io_mem_acquire_bits_source = {1'h0, io_id};
  assign io_mem_acquire_bits_address = {req_addr[31:6], 6'h0};
  assign io_mem_grant_ready = _io_mem_grant_ready_output;
  assign io_mem_finish_valid = _io_mem_finish_valid_output;
  assign io_mem_finish_bits_sink = grantack_bits_sink;
  assign io_refill_valid = _io_refill_valid_output;
  assign io_refill_bits_way_en = req_way_en;
  assign io_refill_bits_addr = {req_addr[11:6], refill_ctr, 4'h0};
  assign io_refill_bits_data = io_lb_resp;
  assign io_meta_write_valid = _io_meta_write_valid_output;
  assign io_meta_write_bits_idx = req_addr[11:6];
  assign io_meta_write_bits_way_en = req_way_en;
  assign io_meta_write_bits_data_coh_state = _GEN_9 ? 2'h0 : new_coh_state;
  assign io_meta_write_bits_data_tag = req_addr[31:12];
  assign io_meta_read_valid = _io_meta_read_valid_output;
  assign io_meta_read_bits_idx = req_addr[11:6];
  assign io_meta_read_bits_way_en = req_way_en;
  assign io_meta_read_bits_tag = req_addr[31:12];
  assign io_wb_req_valid = _io_wb_req_valid_output;
  assign io_wb_req_bits_tag = req_old_meta_tag;
  assign io_wb_req_bits_idx = req_addr[11:6];
  assign io_wb_req_bits_param = (&req_old_meta_coh_state) | req_old_meta_coh_state == 2'h2 ? 3'h1 : req_old_meta_coh_state == 2'h1 ? 3'h2 : req_old_meta_coh_state == 2'h0 ? 3'h5 : 3'h0;
  assign io_wb_req_bits_way_en = req_way_en;
  assign io_commit_val = ~_GEN_30 & _io_probe_rdy_T_4 & ~(_GEN_5 | _GEN_6) & _GEN_116;
  assign io_commit_addr = req_addr;
  assign io_commit_coh_state = _coh_on_grant_T_15 ? 2'h3 : _GEN ? 2'h2 : _coh_on_grant_T_10;
  assign io_lb_read_valid = _io_lb_read_valid_output;
  assign io_lb_read_bits_id = io_id;
  assign io_lb_read_bits_offset = _io_probe_rdy_T_4 ? _rpq_io_deq_bits_addr[5:4] : refill_ctr;
  assign io_lb_write_valid = ~_GEN_29 & _io_probe_rdy_T_3 & io_mem_grant_bits_opcode[0] & io_mem_grant_valid;
  assign io_lb_write_bits_id = io_id;
  assign io_lb_write_bits_offset = beats1[1:0] & ~(_counter1_T[1:0]);
  assign io_lb_write_bits_data = io_mem_grant_bits_data;
  assign io_replay_valid = _io_replay_valid_output;
  assign io_replay_bits_uop_br_mask = _rpq_io_deq_bits_uop_br_mask;
  assign io_replay_bits_uop_ldq_idx = _rpq_io_deq_bits_uop_ldq_idx;
  assign io_replay_bits_uop_stq_idx = _rpq_io_deq_bits_uop_stq_idx;
  assign io_replay_bits_uop_mem_cmd = _rpq_io_deq_bits_uop_mem_cmd;
  assign io_replay_bits_uop_mem_size = _rpq_io_deq_bits_uop_mem_size;
  assign io_replay_bits_uop_mem_signed = _rpq_io_deq_bits_uop_mem_signed;
  assign io_replay_bits_uop_is_amo = _rpq_io_deq_bits_uop_is_amo;
  assign io_replay_bits_uop_uses_ldq = _rpq_io_deq_bits_uop_uses_ldq;
  assign io_replay_bits_uop_uses_stq = _rpq_io_deq_bits_uop_uses_stq;
  assign io_replay_bits_addr = {req_addr[39:6], _rpq_io_deq_bits_addr[5:0]};
  assign io_replay_bits_is_hella = _rpq_io_deq_bits_is_hella;
  assign io_replay_bits_way_en = req_way_en;
  assign io_resp_valid = ~_GEN_30 & _io_probe_rdy_T_4 & _rpq_io_deq_valid & _io_refill_valid_T & drain_load;
  assign io_resp_bits_uop_br_mask = _rpq_io_deq_bits_uop_br_mask;
  assign io_resp_bits_uop_ldq_idx = _rpq_io_deq_bits_uop_ldq_idx;
  assign io_resp_bits_uop_stq_idx = _rpq_io_deq_bits_uop_stq_idx;
  assign io_resp_bits_uop_is_amo = _rpq_io_deq_bits_uop_is_amo;
  assign io_resp_bits_uop_uses_ldq = _rpq_io_deq_bits_uop_uses_ldq;
  assign io_resp_bits_uop_uses_stq = _rpq_io_deq_bits_uop_uses_stq;
  assign io_resp_bits_data = {_rpq_io_deq_bits_uop_mem_size == 2'h0 ? {56{_rpq_io_deq_bits_uop_mem_signed & io_resp_bits_data_zeroed_2[7]}} : {_rpq_io_deq_bits_uop_mem_size == 2'h1 ? {48{_rpq_io_deq_bits_uop_mem_signed & io_resp_bits_data_zeroed_1[15]}} : {_rpq_io_deq_bits_uop_mem_size == 2'h2 ? {32{_rpq_io_deq_bits_uop_mem_signed & io_resp_bits_data_zeroed[31]}} : data_word[63:32], io_resp_bits_data_zeroed[31:16]}, io_resp_bits_data_zeroed_1[15:8]}, io_resp_bits_data_zeroed_2};
  assign io_resp_bits_is_hella = _rpq_io_deq_bits_is_hella;
  assign io_probe_rdy = ~(|meta_hazard) & (~(|state) | _GEN_3026 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4 | _io_probe_rdy_T_8 & grantack_valid);
endmodule

