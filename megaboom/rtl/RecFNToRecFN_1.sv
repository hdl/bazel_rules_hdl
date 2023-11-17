// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RecFNToRecFN_1(
  input  [32:0] io_in,
  output [64:0] io_out
);

  wire rawIn__isNaN = (&(io_in[31:30])) & io_in[29];
  RoundAnyRawFNToRecFN_5 roundAnyRawFNToRecFN (
    .io_invalidExc (rawIn__isNaN & ~(io_in[22])),
    .io_in_isNaN   (rawIn__isNaN),
    .io_in_isInf   ((&(io_in[31:30])) & ~(io_in[29])),
    .io_in_isZero  (~(|(io_in[31:29]))),
    .io_in_sign    (io_in[32]),
    .io_in_sExp    ({1'h0, io_in[31:23]}),
    .io_in_sig     ({1'h0, |(io_in[31:29]), io_in[22:0]}),
    .io_out        (io_out)
  );
endmodule

