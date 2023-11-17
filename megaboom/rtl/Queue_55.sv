// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_55(
  input        clock,
               reset,
               io_enq_valid,
  input  [2:0] io_enq_bits_sink,
  output       io_enq_ready,
               io_deq_valid,
  output [2:0] io_deq_bits_sink
);

  reg  wrap;
  reg  wrap_1;
  reg  maybe_full;
  wire ptr_match = wrap == wrap_1;
  wire empty = ptr_match & ~maybe_full;
  wire full = ptr_match & maybe_full;
  wire do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset) begin
      wrap <= 1'h0;
      wrap_1 <= 1'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        wrap <= wrap - 1'h1;
      if (~empty)
        wrap_1 <= wrap_1 - 1'h1;
      if (do_enq != ~empty)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_2x3 ram_sink_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_sink),
    .R0_data (io_deq_bits_sink)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~empty;
endmodule

