// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MulAddRecFNToRaw_preMul(
  input  [1:0]   io_op,
  input  [64:0]  io_a,
                 io_b,
                 io_c,
  output [52:0]  io_mulAddA,
                 io_mulAddB,
  output [105:0] io_mulAddC,
  output         io_toPostMul_isSigNaNAny,
                 io_toPostMul_isNaNAOrB,
                 io_toPostMul_isInfA,
                 io_toPostMul_isZeroA,
                 io_toPostMul_isInfB,
                 io_toPostMul_isZeroB,
                 io_toPostMul_signProd,
                 io_toPostMul_isNaNC,
                 io_toPostMul_isInfC,
                 io_toPostMul_isZeroC,
  output [12:0]  io_toPostMul_sExpSum,
  output         io_toPostMul_doSubMags,
                 io_toPostMul_CIsDominant,
  output [5:0]   io_toPostMul_CDom_CAlignDist,
  output [54:0]  io_toPostMul_highAlignedSigC,
  output         io_toPostMul_bit0AlignedSigC
);

  wire         rawA__isNaN = (&(io_a[63:62])) & io_a[61];
  wire         rawB__isNaN = (&(io_b[63:62])) & io_b[61];
  wire         rawC__isNaN = (&(io_c[63:62])) & io_c[61];
  wire         signProd = io_a[64] ^ io_b[64] ^ io_op[1];
  wire [13:0]  _sExpAlignedProd_T_1 = {2'h0, io_a[63:52]} + {2'h0, io_b[63:52]} - 14'h7C8;
  wire         doSubMags = signProd ^ io_c[64] ^ io_op[0];
  wire [13:0]  _sNatCAlignDist_T = _sExpAlignedProd_T_1 - {2'h0, io_c[63:52]};
  wire         isMinCAlign = ~(|(io_a[63:61])) | ~(|(io_b[63:61])) | $signed(_sNatCAlignDist_T) < 14'sh0;
  wire         CIsDominant = (|(io_c[63:61])) & (isMinCAlign | _sNatCAlignDist_T[12:0] < 13'h36);
  wire [7:0]   CAlignDist = isMinCAlign ? 8'h0 : _sNatCAlignDist_T[12:0] < 13'hA1 ? _sNatCAlignDist_T[7:0] : 8'hA1;
  wire [164:0] mainAlignedSigC = $signed($signed({doSubMags ? {1'h1, ~(|(io_c[63:61])), ~(io_c[51:0])} : {1'h0, |(io_c[63:61]), io_c[51:0]}, {111{doSubMags}}}) >>> CAlignDist);
  wire [64:0]  reduced4CExtra_shift = $signed(65'sh10000000000000000 >>> CAlignDist[7:2]);
  wire [12:0]  _GEN = {|(io_c[51:48]), |(io_c[47:44]), |(io_c[43:40]), |(io_c[39:36]), |(io_c[35:32]), |(io_c[31:28]), |(io_c[27:24]), |(io_c[23:20]), |(io_c[19:16]), |(io_c[15:12]), |(io_c[11:8]), |(io_c[7:4]), |(io_c[3:0])} & {reduced4CExtra_shift[24], reduced4CExtra_shift[25], reduced4CExtra_shift[26], reduced4CExtra_shift[27], reduced4CExtra_shift[28], reduced4CExtra_shift[29], reduced4CExtra_shift[30], reduced4CExtra_shift[31], reduced4CExtra_shift[32], reduced4CExtra_shift[33], reduced4CExtra_shift[34], reduced4CExtra_shift[35], reduced4CExtra_shift[36]};
  assign io_mulAddA = {|(io_a[63:61]), io_a[51:0]};
  assign io_mulAddB = {|(io_b[63:61]), io_b[51:0]};
  assign io_mulAddC = mainAlignedSigC[108:3];
  assign io_toPostMul_isSigNaNAny = rawA__isNaN & ~(io_a[51]) | rawB__isNaN & ~(io_b[51]) | rawC__isNaN & ~(io_c[51]);
  assign io_toPostMul_isNaNAOrB = rawA__isNaN | rawB__isNaN;
  assign io_toPostMul_isInfA = (&(io_a[63:62])) & ~(io_a[61]);
  assign io_toPostMul_isZeroA = ~(|(io_a[63:61]));
  assign io_toPostMul_isInfB = (&(io_b[63:62])) & ~(io_b[61]);
  assign io_toPostMul_isZeroB = ~(|(io_b[63:61]));
  assign io_toPostMul_signProd = signProd;
  assign io_toPostMul_isNaNC = rawC__isNaN;
  assign io_toPostMul_isInfC = (&(io_c[63:62])) & ~(io_c[61]);
  assign io_toPostMul_isZeroC = ~(|(io_c[63:61]));
  assign io_toPostMul_sExpSum = CIsDominant ? {1'h0, io_c[63:52]} : _sExpAlignedProd_T_1[12:0] - 13'h35;
  assign io_toPostMul_doSubMags = doSubMags;
  assign io_toPostMul_CIsDominant = CIsDominant;
  assign io_toPostMul_CDom_CAlignDist = CAlignDist[5:0];
  assign io_toPostMul_highAlignedSigC = mainAlignedSigC[163:109];
  assign io_toPostMul_bit0AlignedSigC = doSubMags ? (&(mainAlignedSigC[2:0])) & ~(|_GEN) : (|(mainAlignedSigC[2:0])) | (|_GEN);
endmodule

