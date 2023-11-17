// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_56(
  input  clock,
         reset,
         io_enq_valid,
  output io_enq_ready,
         io_deq_valid
);

  reg  full;
  wire do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != full)
      full <= do_enq;
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = full;
endmodule

