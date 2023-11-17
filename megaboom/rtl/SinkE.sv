// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SinkE(
  input        io_e_valid,
  input  [3:0] io_e_bits_sink,
  output       io_resp_valid,
  output [3:0] io_resp_bits_sink
);

  assign io_resp_valid = io_e_valid;
  assign io_resp_bits_sink = io_e_bits_sink;
endmodule

