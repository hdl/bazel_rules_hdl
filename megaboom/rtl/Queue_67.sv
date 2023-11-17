// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_67(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
  input          io_enq_bits_preds_0_taken,
                 io_enq_bits_preds_0_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_0_predicted_pc_bits,
  input          io_enq_bits_preds_1_taken,
                 io_enq_bits_preds_1_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_1_predicted_pc_bits,
  input          io_enq_bits_preds_2_taken,
                 io_enq_bits_preds_2_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_2_predicted_pc_bits,
  input          io_enq_bits_preds_3_taken,
                 io_enq_bits_preds_3_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_3_predicted_pc_bits,
  input          io_enq_bits_preds_4_taken,
                 io_enq_bits_preds_4_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_4_predicted_pc_bits,
  input          io_enq_bits_preds_5_taken,
                 io_enq_bits_preds_5_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_5_predicted_pc_bits,
  input          io_enq_bits_preds_6_taken,
                 io_enq_bits_preds_6_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_6_predicted_pc_bits,
  input          io_enq_bits_preds_7_taken,
                 io_enq_bits_preds_7_predicted_pc_valid,
  input  [39:0]  io_enq_bits_preds_7_predicted_pc_bits,
  input  [119:0] io_enq_bits_meta_0,
                 io_enq_bits_meta_1,
  input          io_deq_ready,
  output         io_enq_ready,
  output [39:0]  io_deq_bits_pc,
  output         io_deq_bits_preds_0_taken,
                 io_deq_bits_preds_0_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_0_predicted_pc_bits,
  output         io_deq_bits_preds_1_taken,
                 io_deq_bits_preds_1_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_1_predicted_pc_bits,
  output         io_deq_bits_preds_2_taken,
                 io_deq_bits_preds_2_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_2_predicted_pc_bits,
  output         io_deq_bits_preds_3_taken,
                 io_deq_bits_preds_3_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_3_predicted_pc_bits,
  output         io_deq_bits_preds_4_taken,
                 io_deq_bits_preds_4_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_4_predicted_pc_bits,
  output         io_deq_bits_preds_5_taken,
                 io_deq_bits_preds_5_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_5_predicted_pc_bits,
  output         io_deq_bits_preds_6_taken,
                 io_deq_bits_preds_6_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_6_predicted_pc_bits,
  output         io_deq_bits_preds_7_taken,
                 io_deq_bits_preds_7_predicted_pc_valid,
  output [39:0]  io_deq_bits_preds_7_predicted_pc_bits,
  output [119:0] io_deq_bits_meta_0,
                 io_deq_bits_meta_1
);

  reg          full;
  reg  [119:0] ram_meta_1;
  reg  [119:0] ram_meta_0;
  reg  [39:0]  ram_preds_7_predicted_pc_bits;
  reg          ram_preds_7_predicted_pc_valid;
  reg          ram_preds_7_taken;
  reg  [39:0]  ram_preds_6_predicted_pc_bits;
  reg          ram_preds_6_predicted_pc_valid;
  reg          ram_preds_6_taken;
  reg  [39:0]  ram_preds_5_predicted_pc_bits;
  reg          ram_preds_5_predicted_pc_valid;
  reg          ram_preds_5_taken;
  reg  [39:0]  ram_preds_4_predicted_pc_bits;
  reg          ram_preds_4_predicted_pc_valid;
  reg          ram_preds_4_taken;
  reg  [39:0]  ram_preds_3_predicted_pc_bits;
  reg          ram_preds_3_predicted_pc_valid;
  reg          ram_preds_3_taken;
  reg  [39:0]  ram_preds_2_predicted_pc_bits;
  reg          ram_preds_2_predicted_pc_valid;
  reg          ram_preds_2_taken;
  reg  [39:0]  ram_preds_1_predicted_pc_bits;
  reg          ram_preds_1_predicted_pc_valid;
  reg          ram_preds_1_taken;
  reg  [39:0]  ram_preds_0_predicted_pc_bits;
  reg          ram_preds_0_predicted_pc_valid;
  reg          ram_preds_0_taken;
  reg  [39:0]  ram_pc;
  wire         _io_enq_ready_output = io_deq_ready | ~full;
  wire         do_enq = ~(~full & io_deq_ready) & _io_enq_ready_output & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (full & io_deq_ready & (io_enq_valid | full)))
      full <= do_enq;
    if (do_enq) begin
      ram_meta_1 <= io_enq_bits_meta_1;
      ram_meta_0 <= io_enq_bits_meta_0;
      ram_preds_7_predicted_pc_bits <= io_enq_bits_preds_7_predicted_pc_bits;
      ram_preds_7_predicted_pc_valid <= io_enq_bits_preds_7_predicted_pc_valid;
      ram_preds_7_taken <= io_enq_bits_preds_7_taken;
      ram_preds_6_predicted_pc_bits <= io_enq_bits_preds_6_predicted_pc_bits;
      ram_preds_6_predicted_pc_valid <= io_enq_bits_preds_6_predicted_pc_valid;
      ram_preds_6_taken <= io_enq_bits_preds_6_taken;
      ram_preds_5_predicted_pc_bits <= io_enq_bits_preds_5_predicted_pc_bits;
      ram_preds_5_predicted_pc_valid <= io_enq_bits_preds_5_predicted_pc_valid;
      ram_preds_5_taken <= io_enq_bits_preds_5_taken;
      ram_preds_4_predicted_pc_bits <= io_enq_bits_preds_4_predicted_pc_bits;
      ram_preds_4_predicted_pc_valid <= io_enq_bits_preds_4_predicted_pc_valid;
      ram_preds_4_taken <= io_enq_bits_preds_4_taken;
      ram_preds_3_predicted_pc_bits <= io_enq_bits_preds_3_predicted_pc_bits;
      ram_preds_3_predicted_pc_valid <= io_enq_bits_preds_3_predicted_pc_valid;
      ram_preds_3_taken <= io_enq_bits_preds_3_taken;
      ram_preds_2_predicted_pc_bits <= io_enq_bits_preds_2_predicted_pc_bits;
      ram_preds_2_predicted_pc_valid <= io_enq_bits_preds_2_predicted_pc_valid;
      ram_preds_2_taken <= io_enq_bits_preds_2_taken;
      ram_preds_1_predicted_pc_bits <= io_enq_bits_preds_1_predicted_pc_bits;
      ram_preds_1_predicted_pc_valid <= io_enq_bits_preds_1_predicted_pc_valid;
      ram_preds_1_taken <= io_enq_bits_preds_1_taken;
      ram_preds_0_predicted_pc_bits <= io_enq_bits_preds_0_predicted_pc_bits;
      ram_preds_0_predicted_pc_valid <= io_enq_bits_preds_0_predicted_pc_valid;
      ram_preds_0_taken <= io_enq_bits_preds_0_taken;
      ram_pc <= io_enq_bits_pc;
    end
  end // always @(posedge)
  assign io_enq_ready = _io_enq_ready_output;
  assign io_deq_bits_pc = full ? ram_pc : io_enq_bits_pc;
  assign io_deq_bits_preds_0_taken = full ? ram_preds_0_taken : io_enq_bits_preds_0_taken;
  assign io_deq_bits_preds_0_predicted_pc_valid = full ? ram_preds_0_predicted_pc_valid : io_enq_bits_preds_0_predicted_pc_valid;
  assign io_deq_bits_preds_0_predicted_pc_bits = full ? ram_preds_0_predicted_pc_bits : io_enq_bits_preds_0_predicted_pc_bits;
  assign io_deq_bits_preds_1_taken = full ? ram_preds_1_taken : io_enq_bits_preds_1_taken;
  assign io_deq_bits_preds_1_predicted_pc_valid = full ? ram_preds_1_predicted_pc_valid : io_enq_bits_preds_1_predicted_pc_valid;
  assign io_deq_bits_preds_1_predicted_pc_bits = full ? ram_preds_1_predicted_pc_bits : io_enq_bits_preds_1_predicted_pc_bits;
  assign io_deq_bits_preds_2_taken = full ? ram_preds_2_taken : io_enq_bits_preds_2_taken;
  assign io_deq_bits_preds_2_predicted_pc_valid = full ? ram_preds_2_predicted_pc_valid : io_enq_bits_preds_2_predicted_pc_valid;
  assign io_deq_bits_preds_2_predicted_pc_bits = full ? ram_preds_2_predicted_pc_bits : io_enq_bits_preds_2_predicted_pc_bits;
  assign io_deq_bits_preds_3_taken = full ? ram_preds_3_taken : io_enq_bits_preds_3_taken;
  assign io_deq_bits_preds_3_predicted_pc_valid = full ? ram_preds_3_predicted_pc_valid : io_enq_bits_preds_3_predicted_pc_valid;
  assign io_deq_bits_preds_3_predicted_pc_bits = full ? ram_preds_3_predicted_pc_bits : io_enq_bits_preds_3_predicted_pc_bits;
  assign io_deq_bits_preds_4_taken = full ? ram_preds_4_taken : io_enq_bits_preds_4_taken;
  assign io_deq_bits_preds_4_predicted_pc_valid = full ? ram_preds_4_predicted_pc_valid : io_enq_bits_preds_4_predicted_pc_valid;
  assign io_deq_bits_preds_4_predicted_pc_bits = full ? ram_preds_4_predicted_pc_bits : io_enq_bits_preds_4_predicted_pc_bits;
  assign io_deq_bits_preds_5_taken = full ? ram_preds_5_taken : io_enq_bits_preds_5_taken;
  assign io_deq_bits_preds_5_predicted_pc_valid = full ? ram_preds_5_predicted_pc_valid : io_enq_bits_preds_5_predicted_pc_valid;
  assign io_deq_bits_preds_5_predicted_pc_bits = full ? ram_preds_5_predicted_pc_bits : io_enq_bits_preds_5_predicted_pc_bits;
  assign io_deq_bits_preds_6_taken = full ? ram_preds_6_taken : io_enq_bits_preds_6_taken;
  assign io_deq_bits_preds_6_predicted_pc_valid = full ? ram_preds_6_predicted_pc_valid : io_enq_bits_preds_6_predicted_pc_valid;
  assign io_deq_bits_preds_6_predicted_pc_bits = full ? ram_preds_6_predicted_pc_bits : io_enq_bits_preds_6_predicted_pc_bits;
  assign io_deq_bits_preds_7_taken = full ? ram_preds_7_taken : io_enq_bits_preds_7_taken;
  assign io_deq_bits_preds_7_predicted_pc_valid = full ? ram_preds_7_predicted_pc_valid : io_enq_bits_preds_7_predicted_pc_valid;
  assign io_deq_bits_preds_7_predicted_pc_bits = full ? ram_preds_7_predicted_pc_bits : io_enq_bits_preds_7_predicted_pc_bits;
  assign io_deq_bits_meta_0 = full ? ram_meta_0 : io_enq_bits_meta_0;
  assign io_deq_bits_meta_1 = full ? ram_meta_1 : io_enq_bits_meta_1;
endmodule

