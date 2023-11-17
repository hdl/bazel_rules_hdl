// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RecFNToIN_1(
  input  [64:0] io_in,
  input  [2:0]  io_roundingMode,
  input         io_signedOut,
  output [2:0]  io_intExceptionFlags
);

  wire        magJustBelowOne = ~(io_in[63]) & (&(io_in[62:52]));
  wire [83:0] shiftedSig = {31'h0, io_in[63], io_in[51:0]} << (io_in[63] ? io_in[56:52] : 5'h0);
  wire [1:0]  _roundIncr_near_even_T_6 = {shiftedSig[51], |(shiftedSig[50:0])};
  wire        common_inexact = io_in[63] ? (|_roundIncr_near_even_T_6) : (|(io_in[63:61]));
  wire        roundIncr = io_roundingMode == 3'h0 & (io_in[63] & ((&(shiftedSig[52:51])) | (&_roundIncr_near_even_T_6)) | magJustBelowOne & (|_roundIncr_near_even_T_6)) | io_roundingMode == 3'h4 & (io_in[63] & shiftedSig[51] | magJustBelowOne) | (io_roundingMode == 3'h2 | io_roundingMode == 3'h6) & io_in[64] & common_inexact | io_roundingMode == 3'h3 & ~(io_in[64]) & common_inexact;
  wire        magGeOne_atOverflowEdge = io_in[62:52] == 11'h1F;
  wire        roundCarryBut2 = (&(shiftedSig[81:52])) & roundIncr;
  wire        common_overflow = io_in[63] ? (|(io_in[62:57])) | (io_signedOut ? (io_in[64] ? magGeOne_atOverflowEdge & ((|(shiftedSig[82:52])) | roundIncr) : magGeOne_atOverflowEdge | io_in[62:52] == 11'h1E & roundCarryBut2) : io_in[64] | magGeOne_atOverflowEdge & shiftedSig[82] & roundCarryBut2) : ~io_signedOut & io_in[64] & roundIncr;
  wire        invalidExc = (&(io_in[63:62])) & io_in[61] | (&(io_in[63:62])) & ~(io_in[61]);
  assign io_intExceptionFlags = {invalidExc, ~invalidExc & common_overflow, ~invalidExc & ~common_overflow & common_inexact};
endmodule

