// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MulAddRecFNToRaw_postMul_1(
  input         io_fromPreMul_isSigNaNAny,
                io_fromPreMul_isNaNAOrB,
                io_fromPreMul_isInfA,
                io_fromPreMul_isZeroA,
                io_fromPreMul_isInfB,
                io_fromPreMul_isZeroB,
                io_fromPreMul_signProd,
                io_fromPreMul_isNaNC,
                io_fromPreMul_isInfC,
                io_fromPreMul_isZeroC,
  input  [9:0]  io_fromPreMul_sExpSum,
  input         io_fromPreMul_doSubMags,
                io_fromPreMul_CIsDominant,
  input  [4:0]  io_fromPreMul_CDom_CAlignDist,
  input  [25:0] io_fromPreMul_highAlignedSigC,
  input         io_fromPreMul_bit0AlignedSigC,
  input  [48:0] io_mulAddResult,
  input  [2:0]  io_roundingMode,
  output        io_invalidExc,
                io_rawOut_isNaN,
                io_rawOut_isInf,
                io_rawOut_isZero,
                io_rawOut_sign,
  output [9:0]  io_rawOut_sExp,
  output [26:0] io_rawOut_sig
);

  wire         roundingMode_min = io_roundingMode == 3'h2;
  wire         opSignC = io_fromPreMul_signProd ^ io_fromPreMul_doSubMags;
  wire [25:0]  _sigSum_T_3 = io_mulAddResult[48] ? io_fromPreMul_highAlignedSigC + 26'h1 : io_fromPreMul_highAlignedSigC;
  wire [49:0]  CDom_absSigSum = io_fromPreMul_doSubMags ? ~{_sigSum_T_3, io_mulAddResult[47:24]} : {1'h0, io_fromPreMul_highAlignedSigC[25:24], _sigSum_T_3[23:0], io_mulAddResult[47:25]};
  wire [80:0]  _CDom_mainSig_T = {31'h0, CDom_absSigSum} << io_fromPreMul_CDom_CAlignDist;
  wire [8:0]   CDom_reduced4SigExtra_shift = $signed(9'sh100 >>> ~(io_fromPreMul_CDom_CAlignDist[4:2]));
  wire [50:0]  notCDom_absSigSum = _sigSum_T_3[2] ? ~{_sigSum_T_3[1:0], io_mulAddResult[47:0], io_fromPreMul_bit0AlignedSigC} : {_sigSum_T_3[1:0], io_mulAddResult[47:0], io_fromPreMul_bit0AlignedSigC} + {50'h0, io_fromPreMul_doSubMags};
  wire [4:0]   notCDom_normDistReduced2 = notCDom_absSigSum[50] ? 5'h0 : (|(notCDom_absSigSum[49:48])) ? 5'h1 : (|(notCDom_absSigSum[47:46])) ? 5'h2 : (|(notCDom_absSigSum[45:44])) ? 5'h3 : (|(notCDom_absSigSum[43:42])) ? 5'h4 : (|(notCDom_absSigSum[41:40])) ? 5'h5 : (|(notCDom_absSigSum[39:38])) ? 5'h6 : (|(notCDom_absSigSum[37:36])) ? 5'h7 : (|(notCDom_absSigSum[35:34])) ? 5'h8 : (|(notCDom_absSigSum[33:32])) ? 5'h9 : (|(notCDom_absSigSum[31:30])) ? 5'hA : (|(notCDom_absSigSum[29:28])) ? 5'hB : (|(notCDom_absSigSum[27:26])) ? 5'hC : (|(notCDom_absSigSum[25:24])) ? 5'hD : (|(notCDom_absSigSum[23:22])) ? 5'hE : (|(notCDom_absSigSum[21:20])) ? 5'hF : (|(notCDom_absSigSum[19:18])) ? 5'h10 : (|(notCDom_absSigSum[17:16])) ? 5'h11 : (|(notCDom_absSigSum[15:14])) ? 5'h12 : (|(notCDom_absSigSum[13:12])) ? 5'h13 : (|(notCDom_absSigSum[11:10])) ? 5'h14 : (|(notCDom_absSigSum[9:8])) ? 5'h15 : (|(notCDom_absSigSum[7:6])) ? 5'h16 : (|(notCDom_absSigSum[5:4])) ? 5'h17 : {4'hC, ~(|(notCDom_absSigSum[3:2]))};
  wire [113:0] _notCDom_mainSig_T = {63'h0, notCDom_absSigSum} << {108'h0, notCDom_normDistReduced2, 1'h0};
  wire [16:0]  notCDom_reduced4SigExtra_shift = $signed(17'sh10000 >>> ~(notCDom_normDistReduced2[4:1]));
  wire         notCDom_completeCancellation = _notCDom_mainSig_T[51:50] == 2'h0;
  wire         notNaN_isInfProd = io_fromPreMul_isInfA | io_fromPreMul_isInfB;
  wire         notNaN_isInfOut = notNaN_isInfProd | io_fromPreMul_isInfC;
  wire         notNaN_addZeros = (io_fromPreMul_isZeroA | io_fromPreMul_isZeroB) & io_fromPreMul_isZeroC;
  assign io_invalidExc = io_fromPreMul_isSigNaNAny | io_fromPreMul_isInfA & io_fromPreMul_isZeroB | io_fromPreMul_isZeroA & io_fromPreMul_isInfB | ~io_fromPreMul_isNaNAOrB & notNaN_isInfProd & io_fromPreMul_isInfC & io_fromPreMul_doSubMags;
  assign io_rawOut_isNaN = io_fromPreMul_isNaNAOrB | io_fromPreMul_isNaNC;
  assign io_rawOut_isInf = notNaN_isInfOut;
  assign io_rawOut_isZero = notNaN_addZeros | ~io_fromPreMul_CIsDominant & notCDom_completeCancellation;
  assign io_rawOut_sign = notNaN_isInfProd & io_fromPreMul_signProd | io_fromPreMul_isInfC & opSignC | notNaN_addZeros & ~roundingMode_min & io_fromPreMul_signProd & opSignC | notNaN_addZeros & roundingMode_min & (io_fromPreMul_signProd | opSignC) | ~notNaN_isInfOut & ~notNaN_addZeros & (io_fromPreMul_CIsDominant ? opSignC : notCDom_completeCancellation ? roundingMode_min : io_fromPreMul_signProd ^ _sigSum_T_3[2]);
  assign io_rawOut_sExp = io_fromPreMul_CIsDominant ? io_fromPreMul_sExpSum - {9'h0, io_fromPreMul_doSubMags} : io_fromPreMul_sExpSum - {4'h0, notCDom_normDistReduced2, 1'h0};
  assign io_rawOut_sig = io_fromPreMul_CIsDominant ? {_CDom_mainSig_T[49:24], (|(_CDom_mainSig_T[23:21])) | (|({|(CDom_absSigSum[20:17]), |(CDom_absSigSum[16:13]), |(CDom_absSigSum[12:9]), |(CDom_absSigSum[8:5]), |(CDom_absSigSum[4:1]), CDom_absSigSum[0]} & {CDom_reduced4SigExtra_shift[1], CDom_reduced4SigExtra_shift[2], CDom_reduced4SigExtra_shift[3], CDom_reduced4SigExtra_shift[4], CDom_reduced4SigExtra_shift[5], CDom_reduced4SigExtra_shift[6]})) | (io_fromPreMul_doSubMags ? io_mulAddResult[23:0] != 24'hFFFFFF : (|(io_mulAddResult[24:0])))} : {_notCDom_mainSig_T[51:26], (|(_notCDom_mainSig_T[25:23])) | (|({|{|(notCDom_absSigSum[23:22]), |(notCDom_absSigSum[21:20])}, |{|(notCDom_absSigSum[19:18]), |(notCDom_absSigSum[17:16])}, |{|(notCDom_absSigSum[15:14]), |(notCDom_absSigSum[13:12])}, |{|(notCDom_absSigSum[11:10]), |(notCDom_absSigSum[9:8])}, |{|(notCDom_absSigSum[7:6]), |(notCDom_absSigSum[5:4])}, |{|(notCDom_absSigSum[3:2]), |(notCDom_absSigSum[1:0])}} & {notCDom_reduced4SigExtra_shift[1], notCDom_reduced4SigExtra_shift[2], notCDom_reduced4SigExtra_shift[3], notCDom_reduced4SigExtra_shift[4], notCDom_reduced4SigExtra_shift[5], notCDom_reduced4SigExtra_shift[6]}))};
endmodule

