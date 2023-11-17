// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MulAddRecFNToRaw_postMul(
  input          io_fromPreMul_isSigNaNAny,
                 io_fromPreMul_isNaNAOrB,
                 io_fromPreMul_isInfA,
                 io_fromPreMul_isZeroA,
                 io_fromPreMul_isInfB,
                 io_fromPreMul_isZeroB,
                 io_fromPreMul_signProd,
                 io_fromPreMul_isNaNC,
                 io_fromPreMul_isInfC,
                 io_fromPreMul_isZeroC,
  input  [12:0]  io_fromPreMul_sExpSum,
  input          io_fromPreMul_doSubMags,
                 io_fromPreMul_CIsDominant,
  input  [5:0]   io_fromPreMul_CDom_CAlignDist,
  input  [54:0]  io_fromPreMul_highAlignedSigC,
  input          io_fromPreMul_bit0AlignedSigC,
  input  [106:0] io_mulAddResult,
  input  [2:0]   io_roundingMode,
  output         io_invalidExc,
                 io_rawOut_isNaN,
                 io_rawOut_isInf,
                 io_rawOut_isZero,
                 io_rawOut_sign,
  output [12:0]  io_rawOut_sExp,
  output [55:0]  io_rawOut_sig
);

  wire         roundingMode_min = io_roundingMode == 3'h2;
  wire         opSignC = io_fromPreMul_signProd ^ io_fromPreMul_doSubMags;
  wire [54:0]  _sigSum_T_3 = io_mulAddResult[106] ? io_fromPreMul_highAlignedSigC + 55'h1 : io_fromPreMul_highAlignedSigC;
  wire [107:0] CDom_absSigSum = io_fromPreMul_doSubMags ? ~{_sigSum_T_3, io_mulAddResult[105:53]} : {1'h0, io_fromPreMul_highAlignedSigC[54:53], _sigSum_T_3[52:0], io_mulAddResult[105:54]};
  wire [170:0] _CDom_mainSig_T = {63'h0, CDom_absSigSum} << io_fromPreMul_CDom_CAlignDist;
  wire [16:0]  CDom_reduced4SigExtra_shift = $signed(17'sh10000 >>> ~(io_fromPreMul_CDom_CAlignDist[5:2]));
  wire [108:0] notCDom_absSigSum = _sigSum_T_3[2] ? ~{_sigSum_T_3[1:0], io_mulAddResult[105:0], io_fromPreMul_bit0AlignedSigC} : {_sigSum_T_3[1:0], io_mulAddResult[105:0], io_fromPreMul_bit0AlignedSigC} + {108'h0, io_fromPreMul_doSubMags};
  wire [5:0]   notCDom_normDistReduced2 =
    notCDom_absSigSum[108]
      ? 6'h0
      : (|(notCDom_absSigSum[107:106]))
          ? 6'h1
          : (|(notCDom_absSigSum[105:104]))
              ? 6'h2
              : (|(notCDom_absSigSum[103:102])) ? 6'h3 : (|(notCDom_absSigSum[101:100])) ? 6'h4 : (|(notCDom_absSigSum[99:98])) ? 6'h5 : (|(notCDom_absSigSum[97:96])) ? 6'h6 : (|(notCDom_absSigSum[95:94])) ? 6'h7 : (|(notCDom_absSigSum[93:92])) ? 6'h8 : (|(notCDom_absSigSum[91:90])) ? 6'h9 : (|(notCDom_absSigSum[89:88])) ? 6'hA : (|(notCDom_absSigSum[87:86])) ? 6'hB : (|(notCDom_absSigSum[85:84])) ? 6'hC : (|(notCDom_absSigSum[83:82])) ? 6'hD : (|(notCDom_absSigSum[81:80])) ? 6'hE : (|(notCDom_absSigSum[79:78])) ? 6'hF : (|(notCDom_absSigSum[77:76])) ? 6'h10 : (|(notCDom_absSigSum[75:74])) ? 6'h11 : (|(notCDom_absSigSum[73:72])) ? 6'h12 : (|(notCDom_absSigSum[71:70])) ? 6'h13 : (|(notCDom_absSigSum[69:68])) ? 6'h14 : (|(notCDom_absSigSum[67:66])) ? 6'h15 : (|(notCDom_absSigSum[65:64])) ? 6'h16 : (|(notCDom_absSigSum[63:62])) ? 6'h17 : (|(notCDom_absSigSum[61:60])) ? 6'h18 : (|(notCDom_absSigSum[59:58])) ? 6'h19 : (|(notCDom_absSigSum[57:56])) ? 6'h1A : (|(notCDom_absSigSum[55:54])) ? 6'h1B : (|(notCDom_absSigSum[53:52])) ? 6'h1C : (|(notCDom_absSigSum[51:50])) ? 6'h1D : (|(notCDom_absSigSum[49:48])) ? 6'h1E : (|(notCDom_absSigSum[47:46])) ? 6'h1F : (|(notCDom_absSigSum[45:44])) ? 6'h20 : (|(notCDom_absSigSum[43:42])) ? 6'h21 : (|(notCDom_absSigSum[41:40])) ? 6'h22 : (|(notCDom_absSigSum[39:38])) ? 6'h23 : (|(notCDom_absSigSum[37:36])) ? 6'h24 : (|(notCDom_absSigSum[35:34])) ? 6'h25 : (|(notCDom_absSigSum[33:32])) ? 6'h26 : (|(notCDom_absSigSum[31:30])) ? 6'h27 : (|(notCDom_absSigSum[29:28])) ? 6'h28 : (|(notCDom_absSigSum[27:26])) ? 6'h29 : (|(notCDom_absSigSum[25:24])) ? 6'h2A : (|(notCDom_absSigSum[23:22])) ? 6'h2B : (|(notCDom_absSigSum[21:20])) ? 6'h2C : (|(notCDom_absSigSum[19:18])) ? 6'h2D : (|(notCDom_absSigSum[17:16])) ? 6'h2E : (|(notCDom_absSigSum[15:14])) ? 6'h2F : (|(notCDom_absSigSum[13:12])) ? 6'h30 : (|(notCDom_absSigSum[11:10])) ? 6'h31 : (|(notCDom_absSigSum[9:8])) ? 6'h32 : (|(notCDom_absSigSum[7:6])) ? 6'h33 : (|(notCDom_absSigSum[5:4])) ? 6'h34 : (|(notCDom_absSigSum[3:2])) ? 6'h35 : 6'h36;
  wire [235:0] _notCDom_mainSig_T = {127'h0, notCDom_absSigSum} << {229'h0, notCDom_normDistReduced2, 1'h0};
  wire [32:0]  notCDom_reduced4SigExtra_shift = $signed(33'sh100000000 >>> ~(notCDom_normDistReduced2[5:1]));
  wire         notCDom_completeCancellation = _notCDom_mainSig_T[109:108] == 2'h0;
  wire         notNaN_isInfProd = io_fromPreMul_isInfA | io_fromPreMul_isInfB;
  wire         notNaN_isInfOut = notNaN_isInfProd | io_fromPreMul_isInfC;
  wire         notNaN_addZeros = (io_fromPreMul_isZeroA | io_fromPreMul_isZeroB) & io_fromPreMul_isZeroC;
  assign io_invalidExc = io_fromPreMul_isSigNaNAny | io_fromPreMul_isInfA & io_fromPreMul_isZeroB | io_fromPreMul_isZeroA & io_fromPreMul_isInfB | ~io_fromPreMul_isNaNAOrB & notNaN_isInfProd & io_fromPreMul_isInfC & io_fromPreMul_doSubMags;
  assign io_rawOut_isNaN = io_fromPreMul_isNaNAOrB | io_fromPreMul_isNaNC;
  assign io_rawOut_isInf = notNaN_isInfOut;
  assign io_rawOut_isZero = notNaN_addZeros | ~io_fromPreMul_CIsDominant & notCDom_completeCancellation;
  assign io_rawOut_sign = notNaN_isInfProd & io_fromPreMul_signProd | io_fromPreMul_isInfC & opSignC | notNaN_addZeros & ~roundingMode_min & io_fromPreMul_signProd & opSignC | notNaN_addZeros & roundingMode_min & (io_fromPreMul_signProd | opSignC) | ~notNaN_isInfOut & ~notNaN_addZeros & (io_fromPreMul_CIsDominant ? opSignC : notCDom_completeCancellation ? roundingMode_min : io_fromPreMul_signProd ^ _sigSum_T_3[2]);
  assign io_rawOut_sExp = io_fromPreMul_CIsDominant ? io_fromPreMul_sExpSum - {12'h0, io_fromPreMul_doSubMags} : io_fromPreMul_sExpSum - {6'h0, notCDom_normDistReduced2, 1'h0};
  assign io_rawOut_sig =
    io_fromPreMul_CIsDominant
      ? {_CDom_mainSig_T[107:53], (|(_CDom_mainSig_T[52:50])) | (|({|(CDom_absSigSum[49:46]), |(CDom_absSigSum[45:42]), |(CDom_absSigSum[41:38]), |(CDom_absSigSum[37:34]), |(CDom_absSigSum[33:30]), |(CDom_absSigSum[29:26]), |(CDom_absSigSum[25:22]), |(CDom_absSigSum[21:18]), |(CDom_absSigSum[17:14]), |(CDom_absSigSum[13:10]), |(CDom_absSigSum[9:6]), |(CDom_absSigSum[5:2]), |(CDom_absSigSum[1:0])} & {CDom_reduced4SigExtra_shift[1], CDom_reduced4SigExtra_shift[2], CDom_reduced4SigExtra_shift[3], CDom_reduced4SigExtra_shift[4], CDom_reduced4SigExtra_shift[5], CDom_reduced4SigExtra_shift[6], CDom_reduced4SigExtra_shift[7], CDom_reduced4SigExtra_shift[8], CDom_reduced4SigExtra_shift[9], CDom_reduced4SigExtra_shift[10], CDom_reduced4SigExtra_shift[11], CDom_reduced4SigExtra_shift[12], CDom_reduced4SigExtra_shift[13]})) | (io_fromPreMul_doSubMags ? io_mulAddResult[52:0] != 53'h1FFFFFFFFFFFFF : (|(io_mulAddResult[53:0])))}
      : {_notCDom_mainSig_T[109:55], (|(_notCDom_mainSig_T[54:52])) | (|({|{|(notCDom_absSigSum[51:50]), |(notCDom_absSigSum[49:48])}, |{|(notCDom_absSigSum[47:46]), |(notCDom_absSigSum[45:44])}, |{|(notCDom_absSigSum[43:42]), |(notCDom_absSigSum[41:40])}, |{|(notCDom_absSigSum[39:38]), |(notCDom_absSigSum[37:36])}, |{|(notCDom_absSigSum[35:34]), |(notCDom_absSigSum[33:32])}, |{|(notCDom_absSigSum[31:30]), |(notCDom_absSigSum[29:28])}, |{|(notCDom_absSigSum[27:26]), |(notCDom_absSigSum[25:24])}, |{|(notCDom_absSigSum[23:22]), |(notCDom_absSigSum[21:20])}, |{|(notCDom_absSigSum[19:18]), |(notCDom_absSigSum[17:16])}, |{|(notCDom_absSigSum[15:14]), |(notCDom_absSigSum[13:12])}, |{|(notCDom_absSigSum[11:10]), |(notCDom_absSigSum[9:8])}, |{|(notCDom_absSigSum[7:6]), |(notCDom_absSigSum[5:4])}, |{|(notCDom_absSigSum[3:2]), |(notCDom_absSigSum[1:0])}} & {notCDom_reduced4SigExtra_shift[1], notCDom_reduced4SigExtra_shift[2], notCDom_reduced4SigExtra_shift[3], notCDom_reduced4SigExtra_shift[4], notCDom_reduced4SigExtra_shift[5], notCDom_reduced4SigExtra_shift[6], notCDom_reduced4SigExtra_shift[7], notCDom_reduced4SigExtra_shift[8], notCDom_reduced4SigExtra_shift[9], notCDom_reduced4SigExtra_shift[10], notCDom_reduced4SigExtra_shift[11], notCDom_reduced4SigExtra_shift[12], notCDom_reduced4SigExtra_shift[13]}))};
endmodule

