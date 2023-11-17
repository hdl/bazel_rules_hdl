// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RecFNToRecFN(
  input  [64:0] io_in,
  input  [2:0]  io_roundingMode,
  input         io_detectTininess,
  output [32:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire rawIn__isNaN = (&(io_in[63:62])) & io_in[61];
  RoundAnyRawFNToRecFN_4 roundAnyRawFNToRecFN (
    .io_invalidExc     (rawIn__isNaN & ~(io_in[51])),
    .io_in_isNaN       (rawIn__isNaN),
    .io_in_isInf       ((&(io_in[63:62])) & ~(io_in[61])),
    .io_in_isZero      (~(|(io_in[63:61]))),
    .io_in_sign        (io_in[64]),
    .io_in_sExp        ({1'h0, io_in[63:52]}),
    .io_in_sig         ({1'h0, |(io_in[63:61]), io_in[51:0]}),
    .io_roundingMode   (io_roundingMode),
    .io_detectTininess (io_detectTininess),
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
endmodule

