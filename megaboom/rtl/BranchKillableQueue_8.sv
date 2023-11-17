// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BranchKillableQueue_8(
  input         clock,
                reset,
                io_enq_valid,
  input  [19:0] io_enq_bits_uop_br_mask,
  input  [4:0]  io_enq_bits_uop_ldq_idx,
                io_enq_bits_uop_stq_idx,
  input         io_enq_bits_uop_is_amo,
                io_enq_bits_uop_uses_ldq,
                io_enq_bits_uop_uses_stq,
  input  [63:0] io_enq_bits_data,
  input         io_enq_bits_is_hella,
                io_deq_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush,
  output        io_enq_ready,
                io_deq_valid,
  output [19:0] io_deq_bits_uop_br_mask,
  output [4:0]  io_deq_bits_uop_ldq_idx,
                io_deq_bits_uop_stq_idx,
  output        io_deq_bits_uop_is_amo,
                io_deq_bits_uop_uses_ldq,
                io_deq_bits_uop_uses_stq,
  output [63:0] io_deq_bits_data,
  output        io_deq_bits_is_hella
);

  reg         casez_tmp;
  reg  [19:0] casez_tmp_0;
  reg  [4:0]  casez_tmp_1;
  reg  [4:0]  casez_tmp_2;
  reg         casez_tmp_3;
  reg         casez_tmp_4;
  reg         casez_tmp_5;
  reg         valids_0;
  reg         valids_1;
  reg         valids_2;
  reg         valids_3;
  reg  [19:0] uops_0_br_mask;
  reg  [4:0]  uops_0_ldq_idx;
  reg  [4:0]  uops_0_stq_idx;
  reg         uops_0_is_amo;
  reg         uops_0_uses_ldq;
  reg         uops_0_uses_stq;
  reg  [19:0] uops_1_br_mask;
  reg  [4:0]  uops_1_ldq_idx;
  reg  [4:0]  uops_1_stq_idx;
  reg         uops_1_is_amo;
  reg         uops_1_uses_ldq;
  reg         uops_1_uses_stq;
  reg  [19:0] uops_2_br_mask;
  reg  [4:0]  uops_2_ldq_idx;
  reg  [4:0]  uops_2_stq_idx;
  reg         uops_2_is_amo;
  reg         uops_2_uses_ldq;
  reg         uops_2_uses_stq;
  reg  [19:0] uops_3_br_mask;
  reg  [4:0]  uops_3_ldq_idx;
  reg  [4:0]  uops_3_stq_idx;
  reg         uops_3_is_amo;
  reg         uops_3_uses_ldq;
  reg         uops_3_uses_stq;
  reg  [1:0]  enq_ptr_value;
  reg  [1:0]  deq_ptr_value;
  reg         maybe_full;
  wire        ptr_match = enq_ptr_value == deq_ptr_value;
  wire        _io_empty_T_1 = ptr_match & ~maybe_full;
  wire        full = ptr_match & maybe_full;
  wire        do_enq = ~full & io_enq_valid;
  always @(*) begin
    casez (deq_ptr_value)
      2'b00:
        casez_tmp = valids_0;
      2'b01:
        casez_tmp = valids_1;
      2'b10:
        casez_tmp = valids_2;
      default:
        casez_tmp = valids_3;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      2'b00:
        casez_tmp_0 = uops_0_br_mask;
      2'b01:
        casez_tmp_0 = uops_1_br_mask;
      2'b10:
        casez_tmp_0 = uops_2_br_mask;
      default:
        casez_tmp_0 = uops_3_br_mask;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      2'b00:
        casez_tmp_1 = uops_0_ldq_idx;
      2'b01:
        casez_tmp_1 = uops_1_ldq_idx;
      2'b10:
        casez_tmp_1 = uops_2_ldq_idx;
      default:
        casez_tmp_1 = uops_3_ldq_idx;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      2'b00:
        casez_tmp_2 = uops_0_stq_idx;
      2'b01:
        casez_tmp_2 = uops_1_stq_idx;
      2'b10:
        casez_tmp_2 = uops_2_stq_idx;
      default:
        casez_tmp_2 = uops_3_stq_idx;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      2'b00:
        casez_tmp_3 = uops_0_is_amo;
      2'b01:
        casez_tmp_3 = uops_1_is_amo;
      2'b10:
        casez_tmp_3 = uops_2_is_amo;
      default:
        casez_tmp_3 = uops_3_is_amo;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      2'b00:
        casez_tmp_4 = uops_0_uses_ldq;
      2'b01:
        casez_tmp_4 = uops_1_uses_ldq;
      2'b10:
        casez_tmp_4 = uops_2_uses_ldq;
      default:
        casez_tmp_4 = uops_3_uses_ldq;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      2'b00:
        casez_tmp_5 = uops_0_uses_stq;
      2'b01:
        casez_tmp_5 = uops_1_uses_stq;
      2'b10:
        casez_tmp_5 = uops_2_uses_stq;
      default:
        casez_tmp_5 = uops_3_uses_stq;
    endcase
  end // always @(*)
  wire        do_deq = (io_deq_ready | ~casez_tmp) & ~_io_empty_T_1;
  wire [19:0] _uops_enq_ptr_value_br_mask_0 = io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  wire        _GEN = do_enq & enq_ptr_value == 2'h0;
  wire        _GEN_0 = do_enq & enq_ptr_value == 2'h1;
  wire        _GEN_1 = do_enq & enq_ptr_value == 2'h2;
  wire        _GEN_2 = do_enq & (&enq_ptr_value);
  always @(posedge clock) begin
    valids_0 <= ~(reset | do_deq & deq_ptr_value == 2'h0) & (_GEN | valids_0 & (io_brupdate_b1_mispredict_mask & uops_0_br_mask) == 20'h0 & ~(io_flush & uops_0_uses_ldq));
    valids_1 <= ~(reset | do_deq & deq_ptr_value == 2'h1) & (_GEN_0 | valids_1 & (io_brupdate_b1_mispredict_mask & uops_1_br_mask) == 20'h0 & ~(io_flush & uops_1_uses_ldq));
    valids_2 <= ~(reset | do_deq & deq_ptr_value == 2'h2) & (_GEN_1 | valids_2 & (io_brupdate_b1_mispredict_mask & uops_2_br_mask) == 20'h0 & ~(io_flush & uops_2_uses_ldq));
    valids_3 <= ~(reset | do_deq & (&deq_ptr_value)) & (_GEN_2 | valids_3 & (io_brupdate_b1_mispredict_mask & uops_3_br_mask) == 20'h0 & ~(io_flush & uops_3_uses_ldq));
    if (_GEN) begin
      uops_0_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_0_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_0_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_0_is_amo <= io_enq_bits_uop_is_amo;
      uops_0_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_0_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_0_br_mask <= ({20{~valids_0}} | ~io_brupdate_b1_resolve_mask) & uops_0_br_mask;
    if (_GEN_0) begin
      uops_1_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_1_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_1_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_1_is_amo <= io_enq_bits_uop_is_amo;
      uops_1_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_1_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_1_br_mask <= ({20{~valids_1}} | ~io_brupdate_b1_resolve_mask) & uops_1_br_mask;
    if (_GEN_1) begin
      uops_2_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_2_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_2_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_2_is_amo <= io_enq_bits_uop_is_amo;
      uops_2_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_2_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_2_br_mask <= ({20{~valids_2}} | ~io_brupdate_b1_resolve_mask) & uops_2_br_mask;
    if (_GEN_2) begin
      uops_3_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_3_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_3_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_3_is_amo <= io_enq_bits_uop_is_amo;
      uops_3_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_3_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_3_br_mask <= ({20{~valids_3}} | ~io_brupdate_b1_resolve_mask) & uops_3_br_mask;
    if (reset) begin
      enq_ptr_value <= 2'h0;
      deq_ptr_value <= 2'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        enq_ptr_value <= enq_ptr_value + 2'h1;
      if (do_deq)
        deq_ptr_value <= deq_ptr_value + 2'h1;
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_data_4x64 ram_data_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_data),
    .R0_data (io_deq_bits_data)
  );
  ram_is_hella_4x1 ram_is_hella_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_is_hella),
    .R0_data (io_deq_bits_is_hella)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~_io_empty_T_1 & casez_tmp & (io_brupdate_b1_mispredict_mask & casez_tmp_0) == 20'h0 & ~(io_flush & casez_tmp_4);
  assign io_deq_bits_uop_br_mask = casez_tmp_0 & ~io_brupdate_b1_resolve_mask;
  assign io_deq_bits_uop_ldq_idx = casez_tmp_1;
  assign io_deq_bits_uop_stq_idx = casez_tmp_2;
  assign io_deq_bits_uop_is_amo = casez_tmp_3;
  assign io_deq_bits_uop_uses_ldq = casez_tmp_4;
  assign io_deq_bits_uop_uses_stq = casez_tmp_5;
endmodule

