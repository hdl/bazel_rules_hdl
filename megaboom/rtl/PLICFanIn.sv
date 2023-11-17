// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module PLICFanIn(
  input  io_prio_0,
         io_ip,
  output io_dev,
         io_max
);

  wire _GEN = {io_ip, io_prio_0} != 2'h3;
  assign io_dev = ~_GEN;
  assign io_max = ~_GEN & io_prio_0;
endmodule

