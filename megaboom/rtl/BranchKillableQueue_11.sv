// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BranchKillableQueue_11(
  input         clock,
                reset,
                io_enq_valid,
  input  [6:0]  io_enq_bits_uop_uopc,
  input  [19:0] io_enq_bits_uop_br_mask,
  input  [6:0]  io_enq_bits_uop_rob_idx,
  input  [4:0]  io_enq_bits_uop_stq_idx,
  input  [6:0]  io_enq_bits_uop_pdst,
  input         io_enq_bits_uop_is_amo,
                io_enq_bits_uop_uses_stq,
  input  [1:0]  io_enq_bits_uop_dst_rtype,
  input         io_enq_bits_uop_fp_val,
  input  [64:0] io_enq_bits_data,
  input         io_deq_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush,
  output        io_enq_ready,
                io_deq_valid,
  output [6:0]  io_deq_bits_uop_uopc,
  output [19:0] io_deq_bits_uop_br_mask,
  output [6:0]  io_deq_bits_uop_rob_idx,
  output [4:0]  io_deq_bits_uop_stq_idx,
  output [6:0]  io_deq_bits_uop_pdst,
  output        io_deq_bits_uop_is_amo,
                io_deq_bits_uop_uses_stq,
  output [1:0]  io_deq_bits_uop_dst_rtype,
  output        io_deq_bits_uop_fp_val,
  output [64:0] io_deq_bits_data,
  output        io_deq_bits_predicated,
                io_deq_bits_fflags_valid,
  output [6:0]  io_deq_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_deq_bits_fflags_bits_flags,
  output        io_empty
);

  wire [4:0]  _ram_fflags_bits_flags_ext_R0_data;
  wire [6:0]  _ram_fflags_bits_uop_rob_idx_ext_R0_data;
  wire        _ram_fflags_valid_ext_R0_data;
  wire        _ram_predicated_ext_R0_data;
  wire [64:0] _ram_data_ext_R0_data;
  reg         valids_0;
  reg         valids_1;
  reg         valids_2;
  reg  [6:0]  uops_0_uopc;
  reg  [19:0] uops_0_br_mask;
  reg  [6:0]  uops_0_rob_idx;
  reg  [4:0]  uops_0_stq_idx;
  reg  [6:0]  uops_0_pdst;
  reg         uops_0_is_amo;
  reg         uops_0_uses_stq;
  reg  [1:0]  uops_0_dst_rtype;
  reg         uops_0_fp_val;
  reg  [6:0]  uops_1_uopc;
  reg  [19:0] uops_1_br_mask;
  reg  [6:0]  uops_1_rob_idx;
  reg  [4:0]  uops_1_stq_idx;
  reg  [6:0]  uops_1_pdst;
  reg         uops_1_is_amo;
  reg         uops_1_uses_stq;
  reg  [1:0]  uops_1_dst_rtype;
  reg         uops_1_fp_val;
  reg  [6:0]  uops_2_uopc;
  reg  [19:0] uops_2_br_mask;
  reg  [6:0]  uops_2_rob_idx;
  reg  [4:0]  uops_2_stq_idx;
  reg  [6:0]  uops_2_pdst;
  reg         uops_2_is_amo;
  reg         uops_2_uses_stq;
  reg  [1:0]  uops_2_dst_rtype;
  reg         uops_2_fp_val;
  reg  [1:0]  enq_ptr_value;
  reg  [1:0]  deq_ptr_value;
  reg         maybe_full;
  wire        ptr_match = enq_ptr_value == deq_ptr_value;
  wire        _io_empty_output = ptr_match & ~maybe_full;
  wire        full = ptr_match & maybe_full;
  wire        _GEN = deq_ptr_value == 2'h1;
  wire        _GEN_0 = deq_ptr_value == 2'h2;
  wire        _valids_deq_ptr_value_1 = _GEN_0 ? valids_2 : _GEN ? valids_1 : valids_0;
  wire        do_enq = ~(_io_empty_output & io_deq_ready) & ~full & io_enq_valid;
  wire [19:0] out_uop_br_mask = _GEN_0 ? uops_2_br_mask : _GEN ? uops_1_br_mask : uops_0_br_mask;
  wire [19:0] _uops_enq_ptr_value_br_mask_0 = io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  wire        _GEN_1 = do_enq & enq_ptr_value == 2'h0;
  wire        _GEN_2 = do_enq & enq_ptr_value == 2'h1;
  wire        _GEN_3 = do_enq & enq_ptr_value == 2'h2;
  wire        do_deq = ~_io_empty_output & (io_deq_ready | ~_valids_deq_ptr_value_1) & ~_io_empty_output;
  always @(posedge clock) begin
    valids_0 <= ~(reset | do_deq & deq_ptr_value == 2'h0) & (_GEN_1 | valids_0 & (io_brupdate_b1_mispredict_mask & uops_0_br_mask) == 20'h0 & ~io_flush);
    valids_1 <= ~(reset | do_deq & _GEN) & (_GEN_2 | valids_1 & (io_brupdate_b1_mispredict_mask & uops_1_br_mask) == 20'h0 & ~io_flush);
    valids_2 <= ~(reset | do_deq & _GEN_0) & (_GEN_3 | valids_2 & (io_brupdate_b1_mispredict_mask & uops_2_br_mask) == 20'h0 & ~io_flush);
    if (_GEN_1) begin
      uops_0_uopc <= io_enq_bits_uop_uopc;
      uops_0_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_0_rob_idx <= io_enq_bits_uop_rob_idx;
      uops_0_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_0_pdst <= io_enq_bits_uop_pdst;
      uops_0_is_amo <= io_enq_bits_uop_is_amo;
      uops_0_uses_stq <= io_enq_bits_uop_uses_stq;
      uops_0_dst_rtype <= io_enq_bits_uop_dst_rtype;
      uops_0_fp_val <= io_enq_bits_uop_fp_val;
    end
    else
      uops_0_br_mask <= ({20{~valids_0}} | ~io_brupdate_b1_resolve_mask) & uops_0_br_mask;
    if (_GEN_2) begin
      uops_1_uopc <= io_enq_bits_uop_uopc;
      uops_1_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_1_rob_idx <= io_enq_bits_uop_rob_idx;
      uops_1_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_1_pdst <= io_enq_bits_uop_pdst;
      uops_1_is_amo <= io_enq_bits_uop_is_amo;
      uops_1_uses_stq <= io_enq_bits_uop_uses_stq;
      uops_1_dst_rtype <= io_enq_bits_uop_dst_rtype;
      uops_1_fp_val <= io_enq_bits_uop_fp_val;
    end
    else
      uops_1_br_mask <= ({20{~valids_1}} | ~io_brupdate_b1_resolve_mask) & uops_1_br_mask;
    if (_GEN_3) begin
      uops_2_uopc <= io_enq_bits_uop_uopc;
      uops_2_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_2_rob_idx <= io_enq_bits_uop_rob_idx;
      uops_2_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_2_pdst <= io_enq_bits_uop_pdst;
      uops_2_is_amo <= io_enq_bits_uop_is_amo;
      uops_2_uses_stq <= io_enq_bits_uop_uses_stq;
      uops_2_dst_rtype <= io_enq_bits_uop_dst_rtype;
      uops_2_fp_val <= io_enq_bits_uop_fp_val;
    end
    else
      uops_2_br_mask <= ({20{~valids_2}} | ~io_brupdate_b1_resolve_mask) & uops_2_br_mask;
    if (reset) begin
      enq_ptr_value <= 2'h0;
      deq_ptr_value <= 2'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq) begin
        if (enq_ptr_value == 2'h2)
          enq_ptr_value <= 2'h0;
        else
          enq_ptr_value <= enq_ptr_value + 2'h1;
      end
      if (do_deq) begin
        if (deq_ptr_value == 2'h2)
          deq_ptr_value <= 2'h0;
        else
          deq_ptr_value <= deq_ptr_value + 2'h1;
      end
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_data_3x65 ram_data_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_data),
    .R0_data (_ram_data_ext_R0_data)
  );
  ram_3x1 ram_predicated_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (_ram_predicated_ext_R0_data)
  );
  ram_3x1 ram_fflags_valid_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (_ram_fflags_valid_ext_R0_data)
  );
  ram_fflags_bits_uop_rob_idx_3x7 ram_fflags_bits_uop_rob_idx_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (7'h0),
    .R0_data (_ram_fflags_bits_uop_rob_idx_ext_R0_data)
  );
  ram_fflags_bits_flags_3x5 ram_fflags_bits_flags_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (5'h0),
    .R0_data (_ram_fflags_bits_flags_ext_R0_data)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = _io_empty_output ? io_enq_valid : ~_io_empty_output & _valids_deq_ptr_value_1 & (io_brupdate_b1_mispredict_mask & out_uop_br_mask) == 20'h0 & ~io_flush;
  assign io_deq_bits_uop_uopc = _io_empty_output ? io_enq_bits_uop_uopc : _GEN_0 ? uops_2_uopc : _GEN ? uops_1_uopc : uops_0_uopc;
  assign io_deq_bits_uop_br_mask = _io_empty_output ? io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask : out_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  assign io_deq_bits_uop_rob_idx = _io_empty_output ? io_enq_bits_uop_rob_idx : _GEN_0 ? uops_2_rob_idx : _GEN ? uops_1_rob_idx : uops_0_rob_idx;
  assign io_deq_bits_uop_stq_idx = _io_empty_output ? io_enq_bits_uop_stq_idx : _GEN_0 ? uops_2_stq_idx : _GEN ? uops_1_stq_idx : uops_0_stq_idx;
  assign io_deq_bits_uop_pdst = _io_empty_output ? io_enq_bits_uop_pdst : _GEN_0 ? uops_2_pdst : _GEN ? uops_1_pdst : uops_0_pdst;
  assign io_deq_bits_uop_is_amo = _io_empty_output ? io_enq_bits_uop_is_amo : _GEN_0 ? uops_2_is_amo : _GEN ? uops_1_is_amo : uops_0_is_amo;
  assign io_deq_bits_uop_uses_stq = _io_empty_output ? io_enq_bits_uop_uses_stq : _GEN_0 ? uops_2_uses_stq : _GEN ? uops_1_uses_stq : uops_0_uses_stq;
  assign io_deq_bits_uop_dst_rtype = _io_empty_output ? io_enq_bits_uop_dst_rtype : _GEN_0 ? uops_2_dst_rtype : _GEN ? uops_1_dst_rtype : uops_0_dst_rtype;
  assign io_deq_bits_uop_fp_val = _io_empty_output ? io_enq_bits_uop_fp_val : _GEN_0 ? uops_2_fp_val : _GEN ? uops_1_fp_val : uops_0_fp_val;
  assign io_deq_bits_data = _io_empty_output ? io_enq_bits_data : _ram_data_ext_R0_data;
  assign io_deq_bits_predicated = ~_io_empty_output & _ram_predicated_ext_R0_data;
  assign io_deq_bits_fflags_valid = ~_io_empty_output & _ram_fflags_valid_ext_R0_data;
  assign io_deq_bits_fflags_bits_uop_rob_idx = _io_empty_output ? 7'h0 : _ram_fflags_bits_uop_rob_idx_ext_R0_data;
  assign io_deq_bits_fflags_bits_flags = _io_empty_output ? 5'h0 : _ram_fflags_bits_flags_ext_R0_data;
  assign io_empty = _io_empty_output;
endmodule

