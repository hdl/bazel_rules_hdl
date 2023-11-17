// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RoundAnyRawFNToRecFN_4(
  input         io_invalidExc,
                io_in_isNaN,
                io_in_isInf,
                io_in_isZero,
                io_in_sign,
  input  [12:0] io_in_sExp,
  input  [53:0] io_in_sig,
  input  [2:0]  io_roundingMode,
  input         io_detectTininess,
  output [32:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire        roundingMode_near_even = io_roundingMode == 3'h0;
  wire        roundingMode_odd = io_roundingMode == 3'h6;
  wire        roundMagUp = io_roundingMode == 3'h2 & io_in_sign | io_roundingMode == 3'h3 & ~io_in_sign;
  wire [13:0] sAdjustedExp = {io_in_sExp[12], io_in_sExp} - 14'h700;
  wire [8:0]  _roundMask_T_1 = ~(sAdjustedExp[8:0]);
  wire [64:0] _GEN = {59'h0, _roundMask_T_1[5:0]};
  wire [64:0] roundMask_shift = $signed(65'sh10000000000000000 >>> _GEN);
  wire [64:0] roundMask_shift_1 = $signed(65'sh10000000000000000 >>> _GEN);
  wire [24:0] _roundMask_T_74 = _roundMask_T_1[8] ? (_roundMask_T_1[7] ? {~(_roundMask_T_1[6] ? 22'h0 : ~{roundMask_shift[42], roundMask_shift[43], roundMask_shift[44], roundMask_shift[45], roundMask_shift[46], {{roundMask_shift[47:46], roundMask_shift[49]} & 3'h5, 1'h0} | {roundMask_shift[49:48], roundMask_shift[51:50]} & 4'h5, roundMask_shift[51], roundMask_shift[52], roundMask_shift[53], roundMask_shift[54], roundMask_shift[55], roundMask_shift[56], roundMask_shift[57], roundMask_shift[58], roundMask_shift[59], roundMask_shift[60], roundMask_shift[61], roundMask_shift[62], roundMask_shift[63]}), 3'h7} : {22'h0, _roundMask_T_1[6] ? {roundMask_shift_1[0], roundMask_shift_1[1], roundMask_shift_1[2]} : 3'h0}) : 25'h0;
  wire [25:0] _GEN_0 = {1'h1, ~_roundMask_T_74};
  wire [25:0] _GEN_1 = {_roundMask_T_74, 1'h1};
  wire [25:0] _roundPosBit_T = io_in_sig[53:28] & _GEN_0 & _GEN_1;
  wire [25:0] _anyRoundExtra_T = {io_in_sig[52:28], |(io_in_sig[27:0])} & _GEN_1;
  wire        anyRound = (|_roundPosBit_T) | (|_anyRoundExtra_T);
  wire        _overflow_roundMagUp_T = roundingMode_near_even | io_roundingMode == 3'h4;
  wire [25:0] roundedSig = _overflow_roundMagUp_T & (|_roundPosBit_T) | roundMagUp & anyRound ? {1'h0, io_in_sig[53:29] | _roundMask_T_74} + 26'h1 & ~(roundingMode_near_even & (|_roundPosBit_T) & ~(|_anyRoundExtra_T) ? {_roundMask_T_74, 1'h1} : 26'h0) : {1'h0, io_in_sig[53:29] & ~_roundMask_T_74} | (roundingMode_odd & anyRound ? _GEN_0 & _GEN_1 : 26'h0);
  wire [14:0] sRoundedExp = {sAdjustedExp[13], sAdjustedExp} + {13'h0, roundedSig[25:24]};
  wire        common_totalUnderflow = $signed(sRoundedExp) < 15'sh6B;
  wire        isNaNOut = io_invalidExc | io_in_isNaN;
  wire        commonCase = ~isNaNOut & ~io_in_isInf & ~io_in_isZero;
  wire        overflow = commonCase & $signed(sRoundedExp[14:7]) > 8'sh2;
  wire        overflow_roundMagUp = _overflow_roundMagUp_T | roundMagUp;
  wire        pegMinNonzeroMagOut = commonCase & common_totalUnderflow & (roundMagUp | roundingMode_odd);
  wire        pegMaxFiniteMagOut = overflow & ~overflow_roundMagUp;
  wire        notNaN_isInfOut = io_in_isInf | overflow & overflow_roundMagUp;
  assign io_out = {~isNaNOut & io_in_sign, sRoundedExp[8:0] & ~(io_in_isZero | common_totalUnderflow ? 9'h1C0 : 9'h0) & ~(pegMinNonzeroMagOut ? 9'h194 : 9'h0) & {1'h1, ~pegMaxFiniteMagOut, 7'h7F} & {2'h3, ~notNaN_isInfOut, 6'h3F} | (pegMinNonzeroMagOut ? 9'h6B : 9'h0) | (pegMaxFiniteMagOut ? 9'h17F : 9'h0) | (notNaN_isInfOut ? 9'h180 : 9'h0) | (isNaNOut ? 9'h1C0 : 9'h0), (isNaNOut | io_in_isZero | common_totalUnderflow ? {isNaNOut, 22'h0} : roundedSig[22:0]) | {23{pegMaxFiniteMagOut}}};
  assign io_exceptionFlags = {io_invalidExc, 1'h0, overflow, commonCase & (common_totalUnderflow | anyRound & $signed(sAdjustedExp[13:8]) < 6'sh1 & _roundMask_T_74[0] & ~(io_detectTininess & ~(_roundMask_T_74[1]) & roundedSig[24] & (|_roundPosBit_T) & (_overflow_roundMagUp_T & io_in_sig[28] | roundMagUp & (|{io_in_sig[28], |(io_in_sig[27:0])})))), overflow | commonCase & (common_totalUnderflow | anyRound)};
endmodule

