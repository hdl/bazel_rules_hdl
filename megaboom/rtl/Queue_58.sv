// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_58(
  input        clock,
               reset,
               io_enq_valid,
               io_enq_bits_noop,
  input  [2:0] io_enq_bits_way,
  input  [9:0] io_enq_bits_set,
  input  [1:0] io_enq_bits_beat,
  input        io_deq_ready,
  output       io_enq_ready,
               io_deq_valid,
               io_deq_bits_noop,
  output [2:0] io_deq_bits_way,
  output [9:0] io_deq_bits_set,
  output [1:0] io_deq_bits_beat,
               io_deq_bits_mask
);

  reg        full;
  reg  [1:0] ram_mask;
  reg  [1:0] ram_beat;
  reg  [9:0] ram_set;
  reg  [2:0] ram_way;
  reg        ram_noop;
  wire       _io_enq_ready_output = io_deq_ready | ~full;
  wire       do_enq = _io_enq_ready_output & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_mask <= 2'h3;
      ram_beat <= io_enq_bits_beat;
      ram_set <= io_enq_bits_set;
      ram_way <= io_enq_bits_way;
      ram_noop <= io_enq_bits_noop;
    end
  end // always @(posedge)
  assign io_enq_ready = _io_enq_ready_output;
  assign io_deq_valid = full;
  assign io_deq_bits_noop = ram_noop;
  assign io_deq_bits_way = ram_way;
  assign io_deq_bits_set = ram_set;
  assign io_deq_bits_beat = ram_beat;
  assign io_deq_bits_mask = ram_mask;
endmodule

