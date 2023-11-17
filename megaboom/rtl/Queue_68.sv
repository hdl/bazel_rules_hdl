// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_68(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [7:0]   io_enq_bits_btb_mispredicts,
  input  [39:0]  io_enq_bits_pc,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [119:0] io_enq_bits_meta_0,
                 io_enq_bits_meta_1,
  input          io_deq_ready,
  output         io_deq_valid,
                 io_deq_bits_is_mispredict_update,
                 io_deq_bits_is_repair_update,
  output [7:0]   io_deq_bits_btb_mispredicts,
  output [39:0]  io_deq_bits_pc,
  output [7:0]   io_deq_bits_br_mask,
  output         io_deq_bits_cfi_idx_valid,
  output [2:0]   io_deq_bits_cfi_idx_bits,
  output         io_deq_bits_cfi_taken,
                 io_deq_bits_cfi_mispredicted,
                 io_deq_bits_cfi_is_br,
                 io_deq_bits_cfi_is_jal,
  output [63:0]  io_deq_bits_ghist_old_history,
  output         io_deq_bits_ghist_new_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_taken,
  output [39:0]  io_deq_bits_target,
  output [119:0] io_deq_bits_meta_0,
                 io_deq_bits_meta_1
);

  wire _io_enq_ready_T;
  reg  wrap;
  reg  wrap_1;
  reg  maybe_full;
  wire ptr_match = wrap == wrap_1;
  wire empty = ptr_match & ~maybe_full;
  wire do_enq = _io_enq_ready_T & io_enq_valid;
  assign _io_enq_ready_T = ~(ptr_match & maybe_full);
  wire do_deq = io_deq_ready & ~empty;
  always @(posedge clock) begin
    if (reset) begin
      wrap <= 1'h0;
      wrap_1 <= 1'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        wrap <= wrap - 1'h1;
      if (do_deq)
        wrap_1 <= wrap_1 - 1'h1;
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_2x1 ram_is_mispredict_update_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_is_mispredict_update)
  );
  ram_2x1 ram_is_repair_update_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_is_repair_update)
  );
  ram_2x8 ram_btb_mispredicts_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_btb_mispredicts),
    .R0_data (io_deq_bits_btb_mispredicts)
  );
  ram_2x40 ram_pc_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_pc),
    .R0_data (io_deq_bits_pc)
  );
  ram_2x8 ram_br_mask_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (8'h0),
    .R0_data (io_deq_bits_br_mask)
  );
  ram_2x1 ram_cfi_idx_valid_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_cfi_idx_valid)
  );
  ram_2x3 ram_cfi_idx_bits_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (3'h0),
    .R0_data (io_deq_bits_cfi_idx_bits)
  );
  ram_2x1 ram_cfi_taken_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_cfi_taken)
  );
  ram_2x1 ram_cfi_mispredicted_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_cfi_mispredicted)
  );
  ram_2x1 ram_cfi_is_br_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_cfi_is_br)
  );
  ram_2x1 ram_cfi_is_jal_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_deq_bits_cfi_is_jal)
  );
  ram_2x64 ram_ghist_old_history_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_ghist_old_history),
    .R0_data (io_deq_bits_ghist_old_history)
  );
  ram_2x1 ram_ghist_new_saw_branch_not_taken_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_ghist_new_saw_branch_not_taken),
    .R0_data (io_deq_bits_ghist_new_saw_branch_not_taken)
  );
  ram_2x1 ram_ghist_new_saw_branch_taken_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_ghist_new_saw_branch_taken),
    .R0_data (io_deq_bits_ghist_new_saw_branch_taken)
  );
  ram_2x40 ram_target_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (40'h0),
    .R0_data (io_deq_bits_target)
  );
  ram_meta_2x120 ram_meta_0_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_meta_0),
    .R0_data (io_deq_bits_meta_0)
  );
  ram_meta_2x120 ram_meta_1_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_meta_1),
    .R0_data (io_deq_bits_meta_1)
  );
  assign io_deq_valid = ~empty;
endmodule

