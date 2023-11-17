// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RoundAnyRawFNToRecFN_1(
  input         io_in_isZero,
                io_in_sign,
  input  [8:0]  io_in_sExp,
  input  [64:0] io_in_sig,
  input  [2:0]  io_roundingMode,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire        roundingMode_near_even = io_roundingMode == 3'h0;
  wire        anyRound = io_in_sig[10] | (|(io_in_sig[9:0]));
  wire [54:0] roundedSig = (roundingMode_near_even | io_roundingMode == 3'h4) & io_in_sig[10] | (io_roundingMode == 3'h2 & io_in_sign | io_roundingMode == 3'h3 & ~io_in_sign) & anyRound ? {1'h0, io_in_sig[64:11]} + 55'h1 & {54'h3FFFFFFFFFFFFF, ~(roundingMode_near_even & io_in_sig[10] & ~(|(io_in_sig[9:0])))} : {1'h0, io_in_sig[64:12], io_in_sig[11] | io_roundingMode == 3'h6 & anyRound};
  assign io_out = {io_in_sign, {{3{io_in_sExp[8]}}, io_in_sExp} + {10'h0, roundedSig[54:53]} + 12'h780 & ~(io_in_isZero ? 12'hE00 : 12'h0), io_in_isZero ? 52'h0 : roundedSig[51:0]};
  assign io_exceptionFlags = {4'h0, ~io_in_isZero & anyRound};
endmodule

