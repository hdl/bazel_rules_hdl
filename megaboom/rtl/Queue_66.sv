// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_66(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
  input  [127:0] io_enq_bits_data,
  input  [7:0]   io_enq_bits_mask,
  input          io_enq_bits_xcpt_pf_inst,
                 io_enq_bits_xcpt_ae_inst,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input          io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [39:0]  io_deq_bits_pc,
  output [127:0] io_deq_bits_data,
  output [7:0]   io_deq_bits_mask,
  output         io_deq_bits_xcpt_pf_inst,
                 io_deq_bits_xcpt_ae_inst,
  output [63:0]  io_deq_bits_ghist_old_history,
  output         io_deq_bits_ghist_current_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_taken,
  output [4:0]   io_deq_bits_ghist_ras_idx
);

  reg          full;
  reg  [4:0]   ram_ghist_ras_idx;
  reg          ram_ghist_new_saw_branch_taken;
  reg          ram_ghist_new_saw_branch_not_taken;
  reg          ram_ghist_current_saw_branch_not_taken;
  reg  [63:0]  ram_ghist_old_history;
  reg          ram_xcpt_ae_inst;
  reg          ram_xcpt_pf_inst;
  reg  [7:0]   ram_mask;
  reg  [127:0] ram_data;
  reg  [39:0]  ram_pc;
  wire         _io_enq_ready_output = io_deq_ready | ~full;
  wire         do_enq = _io_enq_ready_output & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_ghist_ras_idx <= io_enq_bits_ghist_ras_idx;
      ram_ghist_new_saw_branch_taken <= io_enq_bits_ghist_new_saw_branch_taken;
      ram_ghist_new_saw_branch_not_taken <= io_enq_bits_ghist_new_saw_branch_not_taken;
      ram_ghist_current_saw_branch_not_taken <= io_enq_bits_ghist_current_saw_branch_not_taken;
      ram_ghist_old_history <= io_enq_bits_ghist_old_history;
      ram_xcpt_ae_inst <= io_enq_bits_xcpt_ae_inst;
      ram_xcpt_pf_inst <= io_enq_bits_xcpt_pf_inst;
      ram_mask <= io_enq_bits_mask;
      ram_data <= io_enq_bits_data;
      ram_pc <= io_enq_bits_pc;
    end
  end // always @(posedge)
  assign io_enq_ready = _io_enq_ready_output;
  assign io_deq_valid = full;
  assign io_deq_bits_pc = ram_pc;
  assign io_deq_bits_data = ram_data;
  assign io_deq_bits_mask = ram_mask;
  assign io_deq_bits_xcpt_pf_inst = ram_xcpt_pf_inst;
  assign io_deq_bits_xcpt_ae_inst = ram_xcpt_ae_inst;
  assign io_deq_bits_ghist_old_history = ram_ghist_old_history;
  assign io_deq_bits_ghist_current_saw_branch_not_taken = ram_ghist_current_saw_branch_not_taken;
  assign io_deq_bits_ghist_new_saw_branch_not_taken = ram_ghist_new_saw_branch_not_taken;
  assign io_deq_bits_ghist_new_saw_branch_taken = ram_ghist_new_saw_branch_taken;
  assign io_deq_bits_ghist_ras_idx = ram_ghist_ras_idx;
endmodule

