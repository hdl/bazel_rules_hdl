// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BranchKillableQueue(
  input         clock,
                reset,
                io_enq_valid,
  input  [19:0] io_enq_bits_uop_br_mask,
  input  [4:0]  io_enq_bits_uop_ldq_idx,
                io_enq_bits_uop_stq_idx,
                io_enq_bits_uop_mem_cmd,
  input  [1:0]  io_enq_bits_uop_mem_size,
  input         io_enq_bits_uop_mem_signed,
                io_enq_bits_uop_is_amo,
                io_enq_bits_uop_uses_ldq,
                io_enq_bits_uop_uses_stq,
  input  [39:0] io_enq_bits_addr,
  input         io_enq_bits_is_hella,
  input  [4:0]  io_enq_bits_sdq_id,
  input         io_deq_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush,
  output        io_enq_ready,
                io_deq_valid,
  output [19:0] io_deq_bits_uop_br_mask,
  output [4:0]  io_deq_bits_uop_ldq_idx,
                io_deq_bits_uop_stq_idx,
                io_deq_bits_uop_mem_cmd,
  output [1:0]  io_deq_bits_uop_mem_size,
  output        io_deq_bits_uop_mem_signed,
                io_deq_bits_uop_is_amo,
                io_deq_bits_uop_uses_ldq,
                io_deq_bits_uop_uses_stq,
  output [39:0] io_deq_bits_addr,
  output        io_deq_bits_is_hella,
  output [4:0]  io_deq_bits_sdq_id,
  output        io_empty
);

  reg         casez_tmp;
  reg  [19:0] casez_tmp_0;
  reg  [4:0]  casez_tmp_1;
  reg  [4:0]  casez_tmp_2;
  reg  [4:0]  casez_tmp_3;
  reg  [1:0]  casez_tmp_4;
  reg         casez_tmp_5;
  reg         casez_tmp_6;
  reg         casez_tmp_7;
  reg         casez_tmp_8;
  reg         valids_0;
  reg         valids_1;
  reg         valids_2;
  reg         valids_3;
  reg         valids_4;
  reg         valids_5;
  reg         valids_6;
  reg         valids_7;
  reg         valids_8;
  reg         valids_9;
  reg         valids_10;
  reg         valids_11;
  reg         valids_12;
  reg         valids_13;
  reg         valids_14;
  reg         valids_15;
  reg  [19:0] uops_0_br_mask;
  reg  [4:0]  uops_0_ldq_idx;
  reg  [4:0]  uops_0_stq_idx;
  reg  [4:0]  uops_0_mem_cmd;
  reg  [1:0]  uops_0_mem_size;
  reg         uops_0_mem_signed;
  reg         uops_0_is_amo;
  reg         uops_0_uses_ldq;
  reg         uops_0_uses_stq;
  reg  [19:0] uops_1_br_mask;
  reg  [4:0]  uops_1_ldq_idx;
  reg  [4:0]  uops_1_stq_idx;
  reg  [4:0]  uops_1_mem_cmd;
  reg  [1:0]  uops_1_mem_size;
  reg         uops_1_mem_signed;
  reg         uops_1_is_amo;
  reg         uops_1_uses_ldq;
  reg         uops_1_uses_stq;
  reg  [19:0] uops_2_br_mask;
  reg  [4:0]  uops_2_ldq_idx;
  reg  [4:0]  uops_2_stq_idx;
  reg  [4:0]  uops_2_mem_cmd;
  reg  [1:0]  uops_2_mem_size;
  reg         uops_2_mem_signed;
  reg         uops_2_is_amo;
  reg         uops_2_uses_ldq;
  reg         uops_2_uses_stq;
  reg  [19:0] uops_3_br_mask;
  reg  [4:0]  uops_3_ldq_idx;
  reg  [4:0]  uops_3_stq_idx;
  reg  [4:0]  uops_3_mem_cmd;
  reg  [1:0]  uops_3_mem_size;
  reg         uops_3_mem_signed;
  reg         uops_3_is_amo;
  reg         uops_3_uses_ldq;
  reg         uops_3_uses_stq;
  reg  [19:0] uops_4_br_mask;
  reg  [4:0]  uops_4_ldq_idx;
  reg  [4:0]  uops_4_stq_idx;
  reg  [4:0]  uops_4_mem_cmd;
  reg  [1:0]  uops_4_mem_size;
  reg         uops_4_mem_signed;
  reg         uops_4_is_amo;
  reg         uops_4_uses_ldq;
  reg         uops_4_uses_stq;
  reg  [19:0] uops_5_br_mask;
  reg  [4:0]  uops_5_ldq_idx;
  reg  [4:0]  uops_5_stq_idx;
  reg  [4:0]  uops_5_mem_cmd;
  reg  [1:0]  uops_5_mem_size;
  reg         uops_5_mem_signed;
  reg         uops_5_is_amo;
  reg         uops_5_uses_ldq;
  reg         uops_5_uses_stq;
  reg  [19:0] uops_6_br_mask;
  reg  [4:0]  uops_6_ldq_idx;
  reg  [4:0]  uops_6_stq_idx;
  reg  [4:0]  uops_6_mem_cmd;
  reg  [1:0]  uops_6_mem_size;
  reg         uops_6_mem_signed;
  reg         uops_6_is_amo;
  reg         uops_6_uses_ldq;
  reg         uops_6_uses_stq;
  reg  [19:0] uops_7_br_mask;
  reg  [4:0]  uops_7_ldq_idx;
  reg  [4:0]  uops_7_stq_idx;
  reg  [4:0]  uops_7_mem_cmd;
  reg  [1:0]  uops_7_mem_size;
  reg         uops_7_mem_signed;
  reg         uops_7_is_amo;
  reg         uops_7_uses_ldq;
  reg         uops_7_uses_stq;
  reg  [19:0] uops_8_br_mask;
  reg  [4:0]  uops_8_ldq_idx;
  reg  [4:0]  uops_8_stq_idx;
  reg  [4:0]  uops_8_mem_cmd;
  reg  [1:0]  uops_8_mem_size;
  reg         uops_8_mem_signed;
  reg         uops_8_is_amo;
  reg         uops_8_uses_ldq;
  reg         uops_8_uses_stq;
  reg  [19:0] uops_9_br_mask;
  reg  [4:0]  uops_9_ldq_idx;
  reg  [4:0]  uops_9_stq_idx;
  reg  [4:0]  uops_9_mem_cmd;
  reg  [1:0]  uops_9_mem_size;
  reg         uops_9_mem_signed;
  reg         uops_9_is_amo;
  reg         uops_9_uses_ldq;
  reg         uops_9_uses_stq;
  reg  [19:0] uops_10_br_mask;
  reg  [4:0]  uops_10_ldq_idx;
  reg  [4:0]  uops_10_stq_idx;
  reg  [4:0]  uops_10_mem_cmd;
  reg  [1:0]  uops_10_mem_size;
  reg         uops_10_mem_signed;
  reg         uops_10_is_amo;
  reg         uops_10_uses_ldq;
  reg         uops_10_uses_stq;
  reg  [19:0] uops_11_br_mask;
  reg  [4:0]  uops_11_ldq_idx;
  reg  [4:0]  uops_11_stq_idx;
  reg  [4:0]  uops_11_mem_cmd;
  reg  [1:0]  uops_11_mem_size;
  reg         uops_11_mem_signed;
  reg         uops_11_is_amo;
  reg         uops_11_uses_ldq;
  reg         uops_11_uses_stq;
  reg  [19:0] uops_12_br_mask;
  reg  [4:0]  uops_12_ldq_idx;
  reg  [4:0]  uops_12_stq_idx;
  reg  [4:0]  uops_12_mem_cmd;
  reg  [1:0]  uops_12_mem_size;
  reg         uops_12_mem_signed;
  reg         uops_12_is_amo;
  reg         uops_12_uses_ldq;
  reg         uops_12_uses_stq;
  reg  [19:0] uops_13_br_mask;
  reg  [4:0]  uops_13_ldq_idx;
  reg  [4:0]  uops_13_stq_idx;
  reg  [4:0]  uops_13_mem_cmd;
  reg  [1:0]  uops_13_mem_size;
  reg         uops_13_mem_signed;
  reg         uops_13_is_amo;
  reg         uops_13_uses_ldq;
  reg         uops_13_uses_stq;
  reg  [19:0] uops_14_br_mask;
  reg  [4:0]  uops_14_ldq_idx;
  reg  [4:0]  uops_14_stq_idx;
  reg  [4:0]  uops_14_mem_cmd;
  reg  [1:0]  uops_14_mem_size;
  reg         uops_14_mem_signed;
  reg         uops_14_is_amo;
  reg         uops_14_uses_ldq;
  reg         uops_14_uses_stq;
  reg  [19:0] uops_15_br_mask;
  reg  [4:0]  uops_15_ldq_idx;
  reg  [4:0]  uops_15_stq_idx;
  reg  [4:0]  uops_15_mem_cmd;
  reg  [1:0]  uops_15_mem_size;
  reg         uops_15_mem_signed;
  reg         uops_15_is_amo;
  reg         uops_15_uses_ldq;
  reg         uops_15_uses_stq;
  reg  [3:0]  enq_ptr_value;
  reg  [3:0]  deq_ptr_value;
  reg         maybe_full;
  wire        ptr_match = enq_ptr_value == deq_ptr_value;
  wire        _io_empty_output = ptr_match & ~maybe_full;
  wire        full = ptr_match & maybe_full;
  wire        do_enq = ~full & io_enq_valid;
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp = valids_0;
      4'b0001:
        casez_tmp = valids_1;
      4'b0010:
        casez_tmp = valids_2;
      4'b0011:
        casez_tmp = valids_3;
      4'b0100:
        casez_tmp = valids_4;
      4'b0101:
        casez_tmp = valids_5;
      4'b0110:
        casez_tmp = valids_6;
      4'b0111:
        casez_tmp = valids_7;
      4'b1000:
        casez_tmp = valids_8;
      4'b1001:
        casez_tmp = valids_9;
      4'b1010:
        casez_tmp = valids_10;
      4'b1011:
        casez_tmp = valids_11;
      4'b1100:
        casez_tmp = valids_12;
      4'b1101:
        casez_tmp = valids_13;
      4'b1110:
        casez_tmp = valids_14;
      default:
        casez_tmp = valids_15;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_0 = uops_0_br_mask;
      4'b0001:
        casez_tmp_0 = uops_1_br_mask;
      4'b0010:
        casez_tmp_0 = uops_2_br_mask;
      4'b0011:
        casez_tmp_0 = uops_3_br_mask;
      4'b0100:
        casez_tmp_0 = uops_4_br_mask;
      4'b0101:
        casez_tmp_0 = uops_5_br_mask;
      4'b0110:
        casez_tmp_0 = uops_6_br_mask;
      4'b0111:
        casez_tmp_0 = uops_7_br_mask;
      4'b1000:
        casez_tmp_0 = uops_8_br_mask;
      4'b1001:
        casez_tmp_0 = uops_9_br_mask;
      4'b1010:
        casez_tmp_0 = uops_10_br_mask;
      4'b1011:
        casez_tmp_0 = uops_11_br_mask;
      4'b1100:
        casez_tmp_0 = uops_12_br_mask;
      4'b1101:
        casez_tmp_0 = uops_13_br_mask;
      4'b1110:
        casez_tmp_0 = uops_14_br_mask;
      default:
        casez_tmp_0 = uops_15_br_mask;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_1 = uops_0_ldq_idx;
      4'b0001:
        casez_tmp_1 = uops_1_ldq_idx;
      4'b0010:
        casez_tmp_1 = uops_2_ldq_idx;
      4'b0011:
        casez_tmp_1 = uops_3_ldq_idx;
      4'b0100:
        casez_tmp_1 = uops_4_ldq_idx;
      4'b0101:
        casez_tmp_1 = uops_5_ldq_idx;
      4'b0110:
        casez_tmp_1 = uops_6_ldq_idx;
      4'b0111:
        casez_tmp_1 = uops_7_ldq_idx;
      4'b1000:
        casez_tmp_1 = uops_8_ldq_idx;
      4'b1001:
        casez_tmp_1 = uops_9_ldq_idx;
      4'b1010:
        casez_tmp_1 = uops_10_ldq_idx;
      4'b1011:
        casez_tmp_1 = uops_11_ldq_idx;
      4'b1100:
        casez_tmp_1 = uops_12_ldq_idx;
      4'b1101:
        casez_tmp_1 = uops_13_ldq_idx;
      4'b1110:
        casez_tmp_1 = uops_14_ldq_idx;
      default:
        casez_tmp_1 = uops_15_ldq_idx;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_2 = uops_0_stq_idx;
      4'b0001:
        casez_tmp_2 = uops_1_stq_idx;
      4'b0010:
        casez_tmp_2 = uops_2_stq_idx;
      4'b0011:
        casez_tmp_2 = uops_3_stq_idx;
      4'b0100:
        casez_tmp_2 = uops_4_stq_idx;
      4'b0101:
        casez_tmp_2 = uops_5_stq_idx;
      4'b0110:
        casez_tmp_2 = uops_6_stq_idx;
      4'b0111:
        casez_tmp_2 = uops_7_stq_idx;
      4'b1000:
        casez_tmp_2 = uops_8_stq_idx;
      4'b1001:
        casez_tmp_2 = uops_9_stq_idx;
      4'b1010:
        casez_tmp_2 = uops_10_stq_idx;
      4'b1011:
        casez_tmp_2 = uops_11_stq_idx;
      4'b1100:
        casez_tmp_2 = uops_12_stq_idx;
      4'b1101:
        casez_tmp_2 = uops_13_stq_idx;
      4'b1110:
        casez_tmp_2 = uops_14_stq_idx;
      default:
        casez_tmp_2 = uops_15_stq_idx;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_3 = uops_0_mem_cmd;
      4'b0001:
        casez_tmp_3 = uops_1_mem_cmd;
      4'b0010:
        casez_tmp_3 = uops_2_mem_cmd;
      4'b0011:
        casez_tmp_3 = uops_3_mem_cmd;
      4'b0100:
        casez_tmp_3 = uops_4_mem_cmd;
      4'b0101:
        casez_tmp_3 = uops_5_mem_cmd;
      4'b0110:
        casez_tmp_3 = uops_6_mem_cmd;
      4'b0111:
        casez_tmp_3 = uops_7_mem_cmd;
      4'b1000:
        casez_tmp_3 = uops_8_mem_cmd;
      4'b1001:
        casez_tmp_3 = uops_9_mem_cmd;
      4'b1010:
        casez_tmp_3 = uops_10_mem_cmd;
      4'b1011:
        casez_tmp_3 = uops_11_mem_cmd;
      4'b1100:
        casez_tmp_3 = uops_12_mem_cmd;
      4'b1101:
        casez_tmp_3 = uops_13_mem_cmd;
      4'b1110:
        casez_tmp_3 = uops_14_mem_cmd;
      default:
        casez_tmp_3 = uops_15_mem_cmd;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_4 = uops_0_mem_size;
      4'b0001:
        casez_tmp_4 = uops_1_mem_size;
      4'b0010:
        casez_tmp_4 = uops_2_mem_size;
      4'b0011:
        casez_tmp_4 = uops_3_mem_size;
      4'b0100:
        casez_tmp_4 = uops_4_mem_size;
      4'b0101:
        casez_tmp_4 = uops_5_mem_size;
      4'b0110:
        casez_tmp_4 = uops_6_mem_size;
      4'b0111:
        casez_tmp_4 = uops_7_mem_size;
      4'b1000:
        casez_tmp_4 = uops_8_mem_size;
      4'b1001:
        casez_tmp_4 = uops_9_mem_size;
      4'b1010:
        casez_tmp_4 = uops_10_mem_size;
      4'b1011:
        casez_tmp_4 = uops_11_mem_size;
      4'b1100:
        casez_tmp_4 = uops_12_mem_size;
      4'b1101:
        casez_tmp_4 = uops_13_mem_size;
      4'b1110:
        casez_tmp_4 = uops_14_mem_size;
      default:
        casez_tmp_4 = uops_15_mem_size;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_5 = uops_0_mem_signed;
      4'b0001:
        casez_tmp_5 = uops_1_mem_signed;
      4'b0010:
        casez_tmp_5 = uops_2_mem_signed;
      4'b0011:
        casez_tmp_5 = uops_3_mem_signed;
      4'b0100:
        casez_tmp_5 = uops_4_mem_signed;
      4'b0101:
        casez_tmp_5 = uops_5_mem_signed;
      4'b0110:
        casez_tmp_5 = uops_6_mem_signed;
      4'b0111:
        casez_tmp_5 = uops_7_mem_signed;
      4'b1000:
        casez_tmp_5 = uops_8_mem_signed;
      4'b1001:
        casez_tmp_5 = uops_9_mem_signed;
      4'b1010:
        casez_tmp_5 = uops_10_mem_signed;
      4'b1011:
        casez_tmp_5 = uops_11_mem_signed;
      4'b1100:
        casez_tmp_5 = uops_12_mem_signed;
      4'b1101:
        casez_tmp_5 = uops_13_mem_signed;
      4'b1110:
        casez_tmp_5 = uops_14_mem_signed;
      default:
        casez_tmp_5 = uops_15_mem_signed;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_6 = uops_0_is_amo;
      4'b0001:
        casez_tmp_6 = uops_1_is_amo;
      4'b0010:
        casez_tmp_6 = uops_2_is_amo;
      4'b0011:
        casez_tmp_6 = uops_3_is_amo;
      4'b0100:
        casez_tmp_6 = uops_4_is_amo;
      4'b0101:
        casez_tmp_6 = uops_5_is_amo;
      4'b0110:
        casez_tmp_6 = uops_6_is_amo;
      4'b0111:
        casez_tmp_6 = uops_7_is_amo;
      4'b1000:
        casez_tmp_6 = uops_8_is_amo;
      4'b1001:
        casez_tmp_6 = uops_9_is_amo;
      4'b1010:
        casez_tmp_6 = uops_10_is_amo;
      4'b1011:
        casez_tmp_6 = uops_11_is_amo;
      4'b1100:
        casez_tmp_6 = uops_12_is_amo;
      4'b1101:
        casez_tmp_6 = uops_13_is_amo;
      4'b1110:
        casez_tmp_6 = uops_14_is_amo;
      default:
        casez_tmp_6 = uops_15_is_amo;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_7 = uops_0_uses_ldq;
      4'b0001:
        casez_tmp_7 = uops_1_uses_ldq;
      4'b0010:
        casez_tmp_7 = uops_2_uses_ldq;
      4'b0011:
        casez_tmp_7 = uops_3_uses_ldq;
      4'b0100:
        casez_tmp_7 = uops_4_uses_ldq;
      4'b0101:
        casez_tmp_7 = uops_5_uses_ldq;
      4'b0110:
        casez_tmp_7 = uops_6_uses_ldq;
      4'b0111:
        casez_tmp_7 = uops_7_uses_ldq;
      4'b1000:
        casez_tmp_7 = uops_8_uses_ldq;
      4'b1001:
        casez_tmp_7 = uops_9_uses_ldq;
      4'b1010:
        casez_tmp_7 = uops_10_uses_ldq;
      4'b1011:
        casez_tmp_7 = uops_11_uses_ldq;
      4'b1100:
        casez_tmp_7 = uops_12_uses_ldq;
      4'b1101:
        casez_tmp_7 = uops_13_uses_ldq;
      4'b1110:
        casez_tmp_7 = uops_14_uses_ldq;
      default:
        casez_tmp_7 = uops_15_uses_ldq;
    endcase
  end // always @(*)
  always @(*) begin
    casez (deq_ptr_value)
      4'b0000:
        casez_tmp_8 = uops_0_uses_stq;
      4'b0001:
        casez_tmp_8 = uops_1_uses_stq;
      4'b0010:
        casez_tmp_8 = uops_2_uses_stq;
      4'b0011:
        casez_tmp_8 = uops_3_uses_stq;
      4'b0100:
        casez_tmp_8 = uops_4_uses_stq;
      4'b0101:
        casez_tmp_8 = uops_5_uses_stq;
      4'b0110:
        casez_tmp_8 = uops_6_uses_stq;
      4'b0111:
        casez_tmp_8 = uops_7_uses_stq;
      4'b1000:
        casez_tmp_8 = uops_8_uses_stq;
      4'b1001:
        casez_tmp_8 = uops_9_uses_stq;
      4'b1010:
        casez_tmp_8 = uops_10_uses_stq;
      4'b1011:
        casez_tmp_8 = uops_11_uses_stq;
      4'b1100:
        casez_tmp_8 = uops_12_uses_stq;
      4'b1101:
        casez_tmp_8 = uops_13_uses_stq;
      4'b1110:
        casez_tmp_8 = uops_14_uses_stq;
      default:
        casez_tmp_8 = uops_15_uses_stq;
    endcase
  end // always @(*)
  wire        do_deq = (io_deq_ready | ~casez_tmp) & ~_io_empty_output;
  wire [19:0] _uops_enq_ptr_value_br_mask_0 = io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;
  wire        _GEN = do_enq & enq_ptr_value == 4'h0;
  wire        _GEN_0 = do_enq & enq_ptr_value == 4'h1;
  wire        _GEN_1 = do_enq & enq_ptr_value == 4'h2;
  wire        _GEN_2 = do_enq & enq_ptr_value == 4'h3;
  wire        _GEN_3 = do_enq & enq_ptr_value == 4'h4;
  wire        _GEN_4 = do_enq & enq_ptr_value == 4'h5;
  wire        _GEN_5 = do_enq & enq_ptr_value == 4'h6;
  wire        _GEN_6 = do_enq & enq_ptr_value == 4'h7;
  wire        _GEN_7 = do_enq & enq_ptr_value == 4'h8;
  wire        _GEN_8 = do_enq & enq_ptr_value == 4'h9;
  wire        _GEN_9 = do_enq & enq_ptr_value == 4'hA;
  wire        _GEN_10 = do_enq & enq_ptr_value == 4'hB;
  wire        _GEN_11 = do_enq & enq_ptr_value == 4'hC;
  wire        _GEN_12 = do_enq & enq_ptr_value == 4'hD;
  wire        _GEN_13 = do_enq & enq_ptr_value == 4'hE;
  wire        _GEN_14 = do_enq & (&enq_ptr_value);
  always @(posedge clock) begin
    valids_0 <= ~(reset | do_deq & deq_ptr_value == 4'h0) & (_GEN | valids_0 & (io_brupdate_b1_mispredict_mask & uops_0_br_mask) == 20'h0 & ~(io_flush & uops_0_uses_ldq));
    valids_1 <= ~(reset | do_deq & deq_ptr_value == 4'h1) & (_GEN_0 | valids_1 & (io_brupdate_b1_mispredict_mask & uops_1_br_mask) == 20'h0 & ~(io_flush & uops_1_uses_ldq));
    valids_2 <= ~(reset | do_deq & deq_ptr_value == 4'h2) & (_GEN_1 | valids_2 & (io_brupdate_b1_mispredict_mask & uops_2_br_mask) == 20'h0 & ~(io_flush & uops_2_uses_ldq));
    valids_3 <= ~(reset | do_deq & deq_ptr_value == 4'h3) & (_GEN_2 | valids_3 & (io_brupdate_b1_mispredict_mask & uops_3_br_mask) == 20'h0 & ~(io_flush & uops_3_uses_ldq));
    valids_4 <= ~(reset | do_deq & deq_ptr_value == 4'h4) & (_GEN_3 | valids_4 & (io_brupdate_b1_mispredict_mask & uops_4_br_mask) == 20'h0 & ~(io_flush & uops_4_uses_ldq));
    valids_5 <= ~(reset | do_deq & deq_ptr_value == 4'h5) & (_GEN_4 | valids_5 & (io_brupdate_b1_mispredict_mask & uops_5_br_mask) == 20'h0 & ~(io_flush & uops_5_uses_ldq));
    valids_6 <= ~(reset | do_deq & deq_ptr_value == 4'h6) & (_GEN_5 | valids_6 & (io_brupdate_b1_mispredict_mask & uops_6_br_mask) == 20'h0 & ~(io_flush & uops_6_uses_ldq));
    valids_7 <= ~(reset | do_deq & deq_ptr_value == 4'h7) & (_GEN_6 | valids_7 & (io_brupdate_b1_mispredict_mask & uops_7_br_mask) == 20'h0 & ~(io_flush & uops_7_uses_ldq));
    valids_8 <= ~(reset | do_deq & deq_ptr_value == 4'h8) & (_GEN_7 | valids_8 & (io_brupdate_b1_mispredict_mask & uops_8_br_mask) == 20'h0 & ~(io_flush & uops_8_uses_ldq));
    valids_9 <= ~(reset | do_deq & deq_ptr_value == 4'h9) & (_GEN_8 | valids_9 & (io_brupdate_b1_mispredict_mask & uops_9_br_mask) == 20'h0 & ~(io_flush & uops_9_uses_ldq));
    valids_10 <= ~(reset | do_deq & deq_ptr_value == 4'hA) & (_GEN_9 | valids_10 & (io_brupdate_b1_mispredict_mask & uops_10_br_mask) == 20'h0 & ~(io_flush & uops_10_uses_ldq));
    valids_11 <= ~(reset | do_deq & deq_ptr_value == 4'hB) & (_GEN_10 | valids_11 & (io_brupdate_b1_mispredict_mask & uops_11_br_mask) == 20'h0 & ~(io_flush & uops_11_uses_ldq));
    valids_12 <= ~(reset | do_deq & deq_ptr_value == 4'hC) & (_GEN_11 | valids_12 & (io_brupdate_b1_mispredict_mask & uops_12_br_mask) == 20'h0 & ~(io_flush & uops_12_uses_ldq));
    valids_13 <= ~(reset | do_deq & deq_ptr_value == 4'hD) & (_GEN_12 | valids_13 & (io_brupdate_b1_mispredict_mask & uops_13_br_mask) == 20'h0 & ~(io_flush & uops_13_uses_ldq));
    valids_14 <= ~(reset | do_deq & deq_ptr_value == 4'hE) & (_GEN_13 | valids_14 & (io_brupdate_b1_mispredict_mask & uops_14_br_mask) == 20'h0 & ~(io_flush & uops_14_uses_ldq));
    valids_15 <= ~(reset | do_deq & (&deq_ptr_value)) & (_GEN_14 | valids_15 & (io_brupdate_b1_mispredict_mask & uops_15_br_mask) == 20'h0 & ~(io_flush & uops_15_uses_ldq));
    if (_GEN) begin
      uops_0_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_0_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_0_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_0_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_0_mem_size <= io_enq_bits_uop_mem_size;
      uops_0_mem_signed <= io_enq_bits_uop_mem_signed;
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
      uops_1_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_1_mem_size <= io_enq_bits_uop_mem_size;
      uops_1_mem_signed <= io_enq_bits_uop_mem_signed;
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
      uops_2_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_2_mem_size <= io_enq_bits_uop_mem_size;
      uops_2_mem_signed <= io_enq_bits_uop_mem_signed;
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
      uops_3_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_3_mem_size <= io_enq_bits_uop_mem_size;
      uops_3_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_3_is_amo <= io_enq_bits_uop_is_amo;
      uops_3_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_3_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_3_br_mask <= ({20{~valids_3}} | ~io_brupdate_b1_resolve_mask) & uops_3_br_mask;
    if (_GEN_3) begin
      uops_4_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_4_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_4_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_4_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_4_mem_size <= io_enq_bits_uop_mem_size;
      uops_4_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_4_is_amo <= io_enq_bits_uop_is_amo;
      uops_4_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_4_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_4_br_mask <= ({20{~valids_4}} | ~io_brupdate_b1_resolve_mask) & uops_4_br_mask;
    if (_GEN_4) begin
      uops_5_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_5_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_5_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_5_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_5_mem_size <= io_enq_bits_uop_mem_size;
      uops_5_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_5_is_amo <= io_enq_bits_uop_is_amo;
      uops_5_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_5_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_5_br_mask <= ({20{~valids_5}} | ~io_brupdate_b1_resolve_mask) & uops_5_br_mask;
    if (_GEN_5) begin
      uops_6_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_6_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_6_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_6_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_6_mem_size <= io_enq_bits_uop_mem_size;
      uops_6_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_6_is_amo <= io_enq_bits_uop_is_amo;
      uops_6_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_6_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_6_br_mask <= ({20{~valids_6}} | ~io_brupdate_b1_resolve_mask) & uops_6_br_mask;
    if (_GEN_6) begin
      uops_7_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_7_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_7_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_7_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_7_mem_size <= io_enq_bits_uop_mem_size;
      uops_7_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_7_is_amo <= io_enq_bits_uop_is_amo;
      uops_7_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_7_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_7_br_mask <= ({20{~valids_7}} | ~io_brupdate_b1_resolve_mask) & uops_7_br_mask;
    if (_GEN_7) begin
      uops_8_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_8_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_8_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_8_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_8_mem_size <= io_enq_bits_uop_mem_size;
      uops_8_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_8_is_amo <= io_enq_bits_uop_is_amo;
      uops_8_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_8_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_8_br_mask <= ({20{~valids_8}} | ~io_brupdate_b1_resolve_mask) & uops_8_br_mask;
    if (_GEN_8) begin
      uops_9_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_9_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_9_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_9_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_9_mem_size <= io_enq_bits_uop_mem_size;
      uops_9_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_9_is_amo <= io_enq_bits_uop_is_amo;
      uops_9_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_9_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_9_br_mask <= ({20{~valids_9}} | ~io_brupdate_b1_resolve_mask) & uops_9_br_mask;
    if (_GEN_9) begin
      uops_10_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_10_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_10_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_10_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_10_mem_size <= io_enq_bits_uop_mem_size;
      uops_10_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_10_is_amo <= io_enq_bits_uop_is_amo;
      uops_10_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_10_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_10_br_mask <= ({20{~valids_10}} | ~io_brupdate_b1_resolve_mask) & uops_10_br_mask;
    if (_GEN_10) begin
      uops_11_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_11_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_11_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_11_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_11_mem_size <= io_enq_bits_uop_mem_size;
      uops_11_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_11_is_amo <= io_enq_bits_uop_is_amo;
      uops_11_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_11_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_11_br_mask <= ({20{~valids_11}} | ~io_brupdate_b1_resolve_mask) & uops_11_br_mask;
    if (_GEN_11) begin
      uops_12_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_12_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_12_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_12_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_12_mem_size <= io_enq_bits_uop_mem_size;
      uops_12_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_12_is_amo <= io_enq_bits_uop_is_amo;
      uops_12_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_12_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_12_br_mask <= ({20{~valids_12}} | ~io_brupdate_b1_resolve_mask) & uops_12_br_mask;
    if (_GEN_12) begin
      uops_13_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_13_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_13_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_13_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_13_mem_size <= io_enq_bits_uop_mem_size;
      uops_13_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_13_is_amo <= io_enq_bits_uop_is_amo;
      uops_13_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_13_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_13_br_mask <= ({20{~valids_13}} | ~io_brupdate_b1_resolve_mask) & uops_13_br_mask;
    if (_GEN_13) begin
      uops_14_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_14_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_14_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_14_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_14_mem_size <= io_enq_bits_uop_mem_size;
      uops_14_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_14_is_amo <= io_enq_bits_uop_is_amo;
      uops_14_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_14_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_14_br_mask <= ({20{~valids_14}} | ~io_brupdate_b1_resolve_mask) & uops_14_br_mask;
    if (_GEN_14) begin
      uops_15_br_mask <= _uops_enq_ptr_value_br_mask_0;
      uops_15_ldq_idx <= io_enq_bits_uop_ldq_idx;
      uops_15_stq_idx <= io_enq_bits_uop_stq_idx;
      uops_15_mem_cmd <= io_enq_bits_uop_mem_cmd;
      uops_15_mem_size <= io_enq_bits_uop_mem_size;
      uops_15_mem_signed <= io_enq_bits_uop_mem_signed;
      uops_15_is_amo <= io_enq_bits_uop_is_amo;
      uops_15_uses_ldq <= io_enq_bits_uop_uses_ldq;
      uops_15_uses_stq <= io_enq_bits_uop_uses_stq;
    end
    else
      uops_15_br_mask <= ({20{~valids_15}} | ~io_brupdate_b1_resolve_mask) & uops_15_br_mask;
    if (reset) begin
      enq_ptr_value <= 4'h0;
      deq_ptr_value <= 4'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        enq_ptr_value <= enq_ptr_value + 4'h1;
      if (do_deq)
        deq_ptr_value <= deq_ptr_value + 4'h1;
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_addr_16x40 ram_addr_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_addr),
    .R0_data (io_deq_bits_addr)
  );
  ram_is_hella_16x1 ram_is_hella_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_is_hella),
    .R0_data (io_deq_bits_is_hella)
  );
  ram_sdq_id_16x5 ram_sdq_id_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_sdq_id),
    .R0_data (io_deq_bits_sdq_id)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~_io_empty_output & casez_tmp & (io_brupdate_b1_mispredict_mask & casez_tmp_0) == 20'h0 & ~(io_flush & casez_tmp_7);
  assign io_deq_bits_uop_br_mask = casez_tmp_0 & ~io_brupdate_b1_resolve_mask;
  assign io_deq_bits_uop_ldq_idx = casez_tmp_1;
  assign io_deq_bits_uop_stq_idx = casez_tmp_2;
  assign io_deq_bits_uop_mem_cmd = casez_tmp_3;
  assign io_deq_bits_uop_mem_size = casez_tmp_4;
  assign io_deq_bits_uop_mem_signed = casez_tmp_5;
  assign io_deq_bits_uop_is_amo = casez_tmp_6;
  assign io_deq_bits_uop_uses_ldq = casez_tmp_7;
  assign io_deq_bits_uop_uses_stq = casez_tmp_8;
  assign io_empty = _io_empty_output;
endmodule

