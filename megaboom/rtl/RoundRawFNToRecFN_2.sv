// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RoundRawFNToRecFN_2(
  input         io_invalidExc,
                io_infiniteExc,
                io_in_isNaN,
                io_in_isInf,
                io_in_isZero,
                io_in_sign,
  input  [12:0] io_in_sExp,
  input  [55:0] io_in_sig,
  input  [2:0]  io_roundingMode,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);

  RoundAnyRawFNToRecFN_7 roundAnyRawFNToRecFN (
    .io_invalidExc     (io_invalidExc),
    .io_infiniteExc    (io_infiniteExc),
    .io_in_isNaN       (io_in_isNaN),
    .io_in_isInf       (io_in_isInf),
    .io_in_isZero      (io_in_isZero),
    .io_in_sign        (io_in_sign),
    .io_in_sExp        (io_in_sExp),
    .io_in_sig         (io_in_sig),
    .io_roundingMode   (io_roundingMode),
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
endmodule

