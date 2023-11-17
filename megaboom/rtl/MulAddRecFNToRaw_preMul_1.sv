// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MulAddRecFNToRaw_preMul_1(
  input  [1:0]  io_op,
  input  [32:0] io_a,
                io_b,
                io_c,
  output [23:0] io_mulAddA,
                io_mulAddB,
  output [47:0] io_mulAddC,
  output        io_toPostMul_isSigNaNAny,
                io_toPostMul_isNaNAOrB,
                io_toPostMul_isInfA,
                io_toPostMul_isZeroA,
                io_toPostMul_isInfB,
                io_toPostMul_isZeroB,
                io_toPostMul_signProd,
                io_toPostMul_isNaNC,
                io_toPostMul_isInfC,
                io_toPostMul_isZeroC,
  output [9:0]  io_toPostMul_sExpSum,
  output        io_toPostMul_doSubMags,
                io_toPostMul_CIsDominant,
  output [4:0]  io_toPostMul_CDom_CAlignDist,
  output [25:0] io_toPostMul_highAlignedSigC,
  output        io_toPostMul_bit0AlignedSigC
);

  wire        rawA__isNaN = (&(io_a[31:30])) & io_a[29];
  wire        rawB__isNaN = (&(io_b[31:30])) & io_b[29];
  wire        rawC__isNaN = (&(io_c[31:30])) & io_c[29];
  wire        signProd = io_a[32] ^ io_b[32] ^ io_op[1];
  wire [10:0] _sExpAlignedProd_T_1 = {2'h0, io_a[31:23]} + {2'h0, io_b[31:23]} - 11'hE5;
  wire        doSubMags = signProd ^ io_c[32] ^ io_op[0];
  wire [10:0] _sNatCAlignDist_T = _sExpAlignedProd_T_1 - {2'h0, io_c[31:23]};
  wire        isMinCAlign = ~(|(io_a[31:29])) | ~(|(io_b[31:29])) | $signed(_sNatCAlignDist_T) < 11'sh0;
  wire        CIsDominant = (|(io_c[31:29])) & (isMinCAlign | _sNatCAlignDist_T[9:0] < 10'h19);
  wire [6:0]  CAlignDist = isMinCAlign ? 7'h0 : _sNatCAlignDist_T[9:0] < 10'h4A ? _sNatCAlignDist_T[6:0] : 7'h4A;
  wire [77:0] mainAlignedSigC = $signed($signed({doSubMags ? {1'h1, ~(|(io_c[31:29])), ~(io_c[22:0])} : {1'h0, |(io_c[31:29]), io_c[22:0]}, {53{doSubMags}}}) >>> CAlignDist);
  wire [32:0] reduced4CExtra_shift = $signed(33'sh100000000 >>> CAlignDist[6:2]);
  wire [5:0]  _GEN = {|(io_c[21:18]), |(io_c[17:14]), |(io_c[13:10]), |(io_c[9:6]), |(io_c[5:2]), |(io_c[1:0])} & {reduced4CExtra_shift[14], reduced4CExtra_shift[15], reduced4CExtra_shift[16], reduced4CExtra_shift[17], reduced4CExtra_shift[18], reduced4CExtra_shift[19]};
  assign io_mulAddA = {|(io_a[31:29]), io_a[22:0]};
  assign io_mulAddB = {|(io_b[31:29]), io_b[22:0]};
  assign io_mulAddC = mainAlignedSigC[50:3];
  assign io_toPostMul_isSigNaNAny = rawA__isNaN & ~(io_a[22]) | rawB__isNaN & ~(io_b[22]) | rawC__isNaN & ~(io_c[22]);
  assign io_toPostMul_isNaNAOrB = rawA__isNaN | rawB__isNaN;
  assign io_toPostMul_isInfA = (&(io_a[31:30])) & ~(io_a[29]);
  assign io_toPostMul_isZeroA = ~(|(io_a[31:29]));
  assign io_toPostMul_isInfB = (&(io_b[31:30])) & ~(io_b[29]);
  assign io_toPostMul_isZeroB = ~(|(io_b[31:29]));
  assign io_toPostMul_signProd = signProd;
  assign io_toPostMul_isNaNC = rawC__isNaN;
  assign io_toPostMul_isInfC = (&(io_c[31:30])) & ~(io_c[29]);
  assign io_toPostMul_isZeroC = ~(|(io_c[31:29]));
  assign io_toPostMul_sExpSum = CIsDominant ? {1'h0, io_c[31:23]} : _sExpAlignedProd_T_1[9:0] - 10'h18;
  assign io_toPostMul_doSubMags = doSubMags;
  assign io_toPostMul_CIsDominant = CIsDominant;
  assign io_toPostMul_CDom_CAlignDist = CAlignDist[4:0];
  assign io_toPostMul_highAlignedSigC = mainAlignedSigC[76:51];
  assign io_toPostMul_bit0AlignedSigC = doSubMags ? (&(mainAlignedSigC[2:0])) & ~(|_GEN) : (|(mainAlignedSigC[2:0])) | (|_GEN);
endmodule

