// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RoundAnyRawFNToRecFN_5(
  input         io_invalidExc,
                io_in_isNaN,
                io_in_isInf,
                io_in_isZero,
                io_in_sign,
  input  [9:0]  io_in_sExp,
  input  [24:0] io_in_sig,
  output [64:0] io_out
);

  wire isNaNOut = io_invalidExc | io_in_isNaN;
  assign io_out = {~isNaNOut & io_in_sign, {{2{io_in_sExp[9]}}, io_in_sExp} + 12'h700 & ~(io_in_isZero ? 12'hE00 : 12'h0) & {2'h3, ~io_in_isInf, 9'h1FF} | (io_in_isInf ? 12'hC00 : 12'h0) | (isNaNOut ? 12'hE00 : 12'h0), isNaNOut | io_in_isZero ? {isNaNOut, 51'h0} : {io_in_sig[22:0], 29'h0}};
endmodule

