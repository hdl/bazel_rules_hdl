// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SourceX(
  input  clock,
         reset,
         io_req_valid,
  output io_req_ready,
         io_x_valid
);

  Queue_56 io_x_q (
    .clock        (clock),
    .reset        (reset),
    .io_enq_valid (io_req_valid),
    .io_enq_ready (io_req_ready),
    .io_deq_valid (io_x_valid)
  );
endmodule

