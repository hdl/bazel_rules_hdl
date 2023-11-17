// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module INToRecFN_1(
  input         io_signedIn,
  input  [63:0] io_in,
  input  [2:0]  io_roundingMode,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire         intAsRawFloat_sign = io_signedIn & io_in[63];
  wire [63:0]  intAsRawFloat_absIn = intAsRawFloat_sign ? 64'h0 - io_in : io_in;
  wire [5:0]   intAsRawFloat_adjustedNormDist =
    intAsRawFloat_absIn[63]
      ? 6'h0
      : intAsRawFloat_absIn[62]
          ? 6'h1
          : intAsRawFloat_absIn[61]
              ? 6'h2
              : intAsRawFloat_absIn[60] ? 6'h3 : intAsRawFloat_absIn[59] ? 6'h4 : intAsRawFloat_absIn[58] ? 6'h5 : intAsRawFloat_absIn[57] ? 6'h6 : intAsRawFloat_absIn[56] ? 6'h7 : intAsRawFloat_absIn[55] ? 6'h8 : intAsRawFloat_absIn[54] ? 6'h9 : intAsRawFloat_absIn[53] ? 6'hA : intAsRawFloat_absIn[52] ? 6'hB : intAsRawFloat_absIn[51] ? 6'hC : intAsRawFloat_absIn[50] ? 6'hD : intAsRawFloat_absIn[49] ? 6'hE : intAsRawFloat_absIn[48] ? 6'hF : intAsRawFloat_absIn[47] ? 6'h10 : intAsRawFloat_absIn[46] ? 6'h11 : intAsRawFloat_absIn[45] ? 6'h12 : intAsRawFloat_absIn[44] ? 6'h13 : intAsRawFloat_absIn[43] ? 6'h14 : intAsRawFloat_absIn[42] ? 6'h15 : intAsRawFloat_absIn[41] ? 6'h16 : intAsRawFloat_absIn[40] ? 6'h17 : intAsRawFloat_absIn[39] ? 6'h18 : intAsRawFloat_absIn[38] ? 6'h19 : intAsRawFloat_absIn[37] ? 6'h1A : intAsRawFloat_absIn[36] ? 6'h1B : intAsRawFloat_absIn[35] ? 6'h1C : intAsRawFloat_absIn[34] ? 6'h1D : intAsRawFloat_absIn[33] ? 6'h1E : intAsRawFloat_absIn[32] ? 6'h1F : intAsRawFloat_absIn[31] ? 6'h20 : intAsRawFloat_absIn[30] ? 6'h21 : intAsRawFloat_absIn[29] ? 6'h22 : intAsRawFloat_absIn[28] ? 6'h23 : intAsRawFloat_absIn[27] ? 6'h24 : intAsRawFloat_absIn[26] ? 6'h25 : intAsRawFloat_absIn[25] ? 6'h26 : intAsRawFloat_absIn[24] ? 6'h27 : intAsRawFloat_absIn[23] ? 6'h28 : intAsRawFloat_absIn[22] ? 6'h29 : intAsRawFloat_absIn[21] ? 6'h2A : intAsRawFloat_absIn[20] ? 6'h2B : intAsRawFloat_absIn[19] ? 6'h2C : intAsRawFloat_absIn[18] ? 6'h2D : intAsRawFloat_absIn[17] ? 6'h2E : intAsRawFloat_absIn[16] ? 6'h2F : intAsRawFloat_absIn[15] ? 6'h30 : intAsRawFloat_absIn[14] ? 6'h31 : intAsRawFloat_absIn[13] ? 6'h32 : intAsRawFloat_absIn[12] ? 6'h33 : intAsRawFloat_absIn[11] ? 6'h34 : intAsRawFloat_absIn[10] ? 6'h35 : intAsRawFloat_absIn[9] ? 6'h36 : intAsRawFloat_absIn[8] ? 6'h37 : intAsRawFloat_absIn[7] ? 6'h38 : intAsRawFloat_absIn[6] ? 6'h39 : intAsRawFloat_absIn[5] ? 6'h3A : intAsRawFloat_absIn[4] ? 6'h3B : intAsRawFloat_absIn[3] ? 6'h3C : intAsRawFloat_absIn[2] ? 6'h3D : {5'h1F, ~(intAsRawFloat_absIn[1])};
  wire [126:0] _intAsRawFloat_sig_T = {63'h0, intAsRawFloat_absIn} << intAsRawFloat_adjustedNormDist;
  RoundAnyRawFNToRecFN_1 roundAnyRawFNToRecFN (
    .io_in_isZero      (~(_intAsRawFloat_sig_T[63])),
    .io_in_sign        (intAsRawFloat_sign),
    .io_in_sExp        ({3'h2, ~intAsRawFloat_adjustedNormDist}),
    .io_in_sig         ({1'h0, _intAsRawFloat_sig_T[63:0]}),
    .io_roundingMode   (io_roundingMode),
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
endmodule

