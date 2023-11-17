// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RoundAnyRawFNToRecFN(
  input         io_in_isZero,
                io_in_sign,
  input  [8:0]  io_in_sExp,
  input  [64:0] io_in_sig,
  input  [2:0]  io_roundingMode,
  output [32:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire        roundingMode_near_even = io_roundingMode == 3'h0;
  wire        anyRound = io_in_sig[39] | (|(io_in_sig[38:0]));
  wire [25:0] roundedSig = (roundingMode_near_even | io_roundingMode == 3'h4) & io_in_sig[39] | (io_roundingMode == 3'h2 & io_in_sign | io_roundingMode == 3'h3 & ~io_in_sign) & anyRound ? {1'h0, io_in_sig[64:40]} + 26'h1 & {25'h1FFFFFF, ~(roundingMode_near_even & io_in_sig[39] & ~(|(io_in_sig[38:0])))} : {1'h0, io_in_sig[64:41], io_in_sig[40] | io_roundingMode == 3'h6 & anyRound};
  assign io_out = {io_in_sign, io_in_sExp + {7'h0, roundedSig[25:24]} + 9'h80 & ~(io_in_isZero ? 9'h1C0 : 9'h0), io_in_isZero ? 23'h0 : roundedSig[22:0]};
  assign io_exceptionFlags = {4'h0, ~io_in_isZero & anyRound};
endmodule

