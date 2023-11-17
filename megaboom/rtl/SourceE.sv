// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SourceE(
  input        clock,
               reset,
               io_req_valid,
  input  [2:0] io_req_bits_sink,
  output       io_req_ready,
               io_e_valid,
  output [2:0] io_e_bits_sink
);

  Queue_55 io_e_q (
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (io_req_valid),
    .io_enq_bits_sink (io_req_bits_sink),
    .io_enq_ready     (io_req_ready),
    .io_deq_valid     (io_e_valid),
    .io_deq_bits_sink (io_e_bits_sink)
  );
endmodule

