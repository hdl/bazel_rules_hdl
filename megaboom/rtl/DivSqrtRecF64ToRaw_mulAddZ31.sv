// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module DivSqrtRecF64ToRaw_mulAddZ31(
  input          clock,
                 reset,
                 io_inValid,
                 io_sqrtOp,
  input  [64:0]  io_a,
                 io_b,
  input  [2:0]   io_roundingMode,
  input  [104:0] io_mulAddResult_3,
  output         io_inReady_div,
                 io_inReady_sqrt,
  output [3:0]   io_usingMulAdd,
  output         io_latchMulAddA_0,
  output [53:0]  io_mulAddA_0,
  output         io_latchMulAddB_0,
  output [53:0]  io_mulAddB_0,
  output [104:0] io_mulAddC_2,
  output         io_rawOutValid_div,
                 io_rawOutValid_sqrt,
  output [2:0]   io_roundingModeOut,
  output         io_invalidExc,
                 io_infiniteExc,
                 io_rawOut_isNaN,
                 io_rawOut_isInf,
                 io_rawOut_isZero,
                 io_rawOut_sign,
  output [12:0]  io_rawOut_sExp,
  output [55:0]  io_rawOut_sig
);

  wire         _io_inReady_sqrt_output;
  wire         _io_inReady_div_output;
  reg  [2:0]   cycleNum_A;
  reg  [3:0]   cycleNum_B;
  reg  [2:0]   cycleNum_C;
  reg  [2:0]   cycleNum_E;
  reg          valid_PA;
  reg          sqrtOp_PA;
  reg          majorExc_PA;
  reg          isNaN_PA;
  reg          isInf_PA;
  reg          isZero_PA;
  reg          sign_PA;
  reg  [12:0]  sExp_PA;
  reg  [51:0]  fractB_PA;
  reg  [51:0]  fractA_PA;
  reg  [2:0]   roundingMode_PA;
  reg          valid_PB;
  reg          sqrtOp_PB;
  reg          majorExc_PB;
  reg          isNaN_PB;
  reg          isInf_PB;
  reg          isZero_PB;
  reg          sign_PB;
  reg  [12:0]  sExp_PB;
  reg          bit0FractA_PB;
  reg  [51:0]  fractB_PB;
  reg  [2:0]   roundingMode_PB;
  reg          valid_PC;
  reg          sqrtOp_PC;
  reg          majorExc_PC;
  reg          isNaN_PC;
  reg          isInf_PC;
  reg          isZero_PC;
  reg          sign_PC;
  reg  [12:0]  sExp_PC;
  reg          bit0FractA_PC;
  reg  [51:0]  fractB_PC;
  reg  [2:0]   roundingMode_PC;
  reg  [8:0]   fractR0_A;
  reg  [9:0]   hiSqrR0_A_sqrt;
  reg  [20:0]  partNegSigma0_A;
  reg  [8:0]   nextMulAdd9A_A;
  reg  [8:0]   nextMulAdd9B_A;
  reg  [16:0]  ER1_B_sqrt;
  reg  [31:0]  ESqrR1_B_sqrt;
  reg  [57:0]  sigX1_B;
  reg  [32:0]  sqrSigma1_C;
  reg  [57:0]  sigXN_C;
  reg  [30:0]  u_C_sqrt;
  reg          E_E_div;
  reg  [53:0]  sigT_E;
  reg          isNegRemT_E;
  reg          isZeroRemT_E;
  wire         cyc_S_div = _io_inReady_div_output & io_inValid & ~io_sqrtOp;
  wire         cyc_S_sqrt = _io_inReady_sqrt_output & io_inValid & io_sqrtOp;
  wire         cyc_S = cyc_S_div | cyc_S_sqrt;
  wire         rawA_S_isZero = io_a[63:61] == 3'h0;
  wire         rawA_S__isNaN = (&(io_a[63:62])) & io_a[61];
  wire         rawA_S__isInf = (&(io_a[63:62])) & ~(io_a[61]);
  wire         rawB_S__isNaN = (&(io_b[63:62])) & io_b[61];
  wire         rawB_S__isInf = (&(io_b[63:62])) & ~(io_b[61]);
  wire         specialCaseB_S = rawB_S__isNaN | rawB_S__isInf | ~(|(io_b[63:61]));
  wire         normalCase_S_div = ~(rawA_S__isNaN | rawA_S__isInf | rawA_S_isZero) & ~specialCaseB_S;
  wire         normalCase_S_sqrt = ~specialCaseB_S & ~(io_b[64]);
  wire         entering_PA_normalCase_div = cyc_S_div & normalCase_S_div;
  wire         entering_PA_normalCase_sqrt = cyc_S_sqrt & normalCase_S_sqrt;
  wire         cyc_A6_sqrt = cycleNum_A == 3'h6;
  wire         cyc_A5_sqrt = cycleNum_A == 3'h5;
  wire         cyc_A4_sqrt = cycleNum_A == 3'h4;
  wire         cyc_A4 = cyc_A4_sqrt | entering_PA_normalCase_div;
  wire         cyc_A3 = cycleNum_A == 3'h3;
  wire         cyc_A2 = cycleNum_A == 3'h2;
  wire         cyc_A1 = cycleNum_A == 3'h1;
  wire         cyc_A3_div = cyc_A3 & ~sqrtOp_PA;
  wire         cyc_A1_div = cyc_A1 & ~sqrtOp_PA;
  wire         cyc_A1_sqrt = cyc_A1 & sqrtOp_PA;
  wire         cyc_B9_sqrt = cycleNum_B == 4'h9;
  wire         cyc_B8_sqrt = cycleNum_B == 4'h8;
  wire         cyc_B7_sqrt = cycleNum_B == 4'h7;
  wire         cyc_B6 = cycleNum_B == 4'h6;
  wire         cyc_B5 = cycleNum_B == 4'h5;
  wire         cyc_B4 = cycleNum_B == 4'h4;
  wire         cyc_B3 = cycleNum_B == 4'h3;
  wire         cyc_B2 = cycleNum_B == 4'h2;
  wire         cyc_B1 = cycleNum_B == 4'h1;
  wire         cyc_B6_div = cyc_B6 & valid_PA & ~sqrtOp_PA;
  wire         cyc_B2_div = cyc_B2 & ~sqrtOp_PB;
  wire         cyc_B6_sqrt = cyc_B6 & valid_PB & sqrtOp_PB;
  wire         cyc_B5_sqrt = cyc_B5 & valid_PB & sqrtOp_PB;
  wire         cyc_B4_sqrt = cyc_B4 & valid_PB & sqrtOp_PB;
  wire         cyc_B3_sqrt = cyc_B3 & sqrtOp_PB;
  wire         cyc_B2_sqrt = cyc_B2 & sqrtOp_PB;
  wire         cyc_B1_sqrt = cyc_B1 & sqrtOp_PB;
  wire         cyc_C6_sqrt = cycleNum_C == 3'h6;
  wire         cyc_C5 = cycleNum_C == 3'h5;
  wire         cyc_C4 = cycleNum_C == 3'h4;
  wire         cyc_C3 = cycleNum_C == 3'h3;
  wire         cyc_C2 = cycleNum_C == 3'h2;
  wire         cyc_C1 = cycleNum_C == 3'h1;
  wire         cyc_C1_div = cyc_C1 & ~sqrtOp_PC;
  wire         cyc_C4_sqrt = cyc_C4 & sqrtOp_PB;
  wire         cyc_C1_sqrt = cyc_C1 & sqrtOp_PC;
  wire         cyc_E3 = cycleNum_E == 3'h3;
  wire         normalCase_PB = ~isNaN_PB & ~isInf_PB & ~isZero_PB;
  wire         valid_leaving_PC = ~(~isNaN_PC & ~isInf_PC & ~isZero_PC) | cycleNum_E == 3'h1;
  wire         ready_PC = ~valid_PC | valid_leaving_PC;
  wire         valid_leaving_PB = normalCase_PB ? cyc_C3 : ready_PC;
  wire         ready_PB = ~valid_PB | valid_leaving_PB;
  wire         normalCase_PA = ~isNaN_PA & ~isInf_PA & ~isZero_PA;
  wire         valid_normalCase_leaving_PA = cyc_B4 & valid_PA & ~sqrtOp_PA | cyc_B7_sqrt;
  wire         valid_leaving_PA = normalCase_PA ? valid_normalCase_leaving_PA : ready_PB;
  wire         ready_PA = ~valid_PA | valid_leaving_PA;
  wire         leaving_PC = valid_PC & valid_leaving_PC;
  assign _io_inReady_div_output = ready_PA & ~cyc_B7_sqrt & ~cyc_B6_sqrt & ~cyc_B5_sqrt & ~cyc_B4_sqrt & ~cyc_B3 & ~cyc_B2 & ~cyc_B1_sqrt & ~cyc_C5 & ~cyc_C4;
  assign _io_inReady_sqrt_output = ready_PA & ~cyc_B6_sqrt & ~cyc_B5_sqrt & ~cyc_B4_sqrt & ~cyc_B2_div & ~cyc_B1_sqrt;
  wire [13:0]  zFractB_A4_div = entering_PA_normalCase_div ? io_b[48:35] : 14'h0;
  wire         zLinPiece_0_A4_div = entering_PA_normalCase_div & io_b[51:49] == 3'h0;
  wire         zLinPiece_1_A4_div = entering_PA_normalCase_div & io_b[51:49] == 3'h1;
  wire         zLinPiece_2_A4_div = entering_PA_normalCase_div & io_b[51:49] == 3'h2;
  wire         zLinPiece_3_A4_div = entering_PA_normalCase_div & io_b[51:49] == 3'h3;
  wire         zLinPiece_4_A4_div = entering_PA_normalCase_div & io_b[51:49] == 3'h4;
  wire         zLinPiece_5_A4_div = entering_PA_normalCase_div & io_b[51:49] == 3'h5;
  wire         zLinPiece_6_A4_div = entering_PA_normalCase_div & io_b[51:49] == 3'h6;
  wire         zLinPiece_7_A4_div = entering_PA_normalCase_div & (&(io_b[51:49]));
  wire [8:0]   _zK1_A4_div_T_4 = (zLinPiece_0_A4_div ? 9'h1C7 : 9'h0) | (zLinPiece_1_A4_div ? 9'h16C : 9'h0) | (zLinPiece_2_A4_div ? 9'h12A : 9'h0);
  wire [8:0]   zFractB_A7_sqrt = entering_PA_normalCase_sqrt ? io_b[50:42] : 9'h0;
  wire         zQuadPiece_0_A7_sqrt = entering_PA_normalCase_sqrt & ~(io_b[52]) & ~(io_b[51]);
  wire         zQuadPiece_1_A7_sqrt = entering_PA_normalCase_sqrt & ~(io_b[52]) & io_b[51];
  wire         zQuadPiece_2_A7_sqrt = entering_PA_normalCase_sqrt & io_b[52] & ~(io_b[51]);
  wire         zQuadPiece_3_A7_sqrt = entering_PA_normalCase_sqrt & io_b[52] & io_b[51];
  wire [8:0]   _zK2_A7_sqrt_T_4 = {zQuadPiece_0_A7_sqrt, (zQuadPiece_0_A7_sqrt ? 8'hC8 : 8'h0) | (zQuadPiece_1_A7_sqrt ? 8'hC1 : 8'h0)} | (zQuadPiece_2_A7_sqrt ? 9'h143 : 9'h0);
  wire [19:0]  _mulAdd9C_A_T_6 = {(zQuadPiece_0_A7_sqrt ? 10'h2F : 10'h0) | (zQuadPiece_1_A7_sqrt ? 10'h1DF : 10'h0) | (zQuadPiece_2_A7_sqrt ? 10'h14D : 10'h0) | (zQuadPiece_3_A7_sqrt ? 10'h27E : 10'h0), {10{entering_PA_normalCase_sqrt}}} | {cyc_A6_sqrt, (cyc_A6_sqrt & ~(sExp_PA[0]) & ~(fractB_PA[51]) ? 13'h1A : 13'h0) | (cyc_A6_sqrt & ~(sExp_PA[0]) & fractB_PA[51] ? 13'hBCA : 13'h0) | (cyc_A6_sqrt & sExp_PA[0] & ~(fractB_PA[51]) ? 13'h12D3 : 13'h0) | (cyc_A6_sqrt & sExp_PA[0] & fractB_PA[51] ? 13'h1B17 : 13'h0), {6{cyc_A6_sqrt}}};
  wire [19:0]  _GEN = {_mulAdd9C_A_T_6[19:8] | (zLinPiece_0_A4_div ? 12'h1C : 12'h0) | (zLinPiece_1_A4_div ? 12'h3A2 : 12'h0) | (zLinPiece_2_A4_div ? 12'h675 : 12'h0) | (zLinPiece_3_A4_div ? 12'h8C6 : 12'h0) | (zLinPiece_4_A4_div ? 12'hAB4 : 12'h0) | (zLinPiece_5_A4_div ? 12'hC56 : 12'h0) | (zLinPiece_6_A4_div ? 12'hDBD : 12'h0) | (zLinPiece_7_A4_div ? 12'hEF4 : 12'h0), _mulAdd9C_A_T_6[7:0] | {8{entering_PA_normalCase_div}}} | (cyc_A5_sqrt ? {1'h0, fractR0_A, 10'h0} + 20'h40000 : 20'h0);
  wire [24:0]  _mulAdd9C_A_T_33 = {4'h0, {entering_PA_normalCase_div, _GEN[19:11], _GEN[10:0] | {cyc_A4_sqrt & ~(hiSqrR0_A_sqrt[9]), 10'h0}} | (cyc_A4_sqrt & hiSqrR0_A_sqrt[9] | cyc_A3_div ? fractB_PA[46:26] + 21'h400 : 21'h0) | (cyc_A3 & sqrtOp_PA | cyc_A2 ? partNegSigma0_A : 21'h0)} | (cyc_A1_sqrt ? {fractR0_A, 16'h0} : 25'h0);
  wire [23:0]  _GEN_0 = _mulAdd9C_A_T_33[23:0] | (cyc_A1_div ? {fractR0_A, 15'h0} : 24'h0);
  wire [18:0]  loMulAdd9Out_A = {1'h0, {9'h0, zFractB_A4_div[13:5] | {_zK2_A7_sqrt_T_4[8], _zK2_A7_sqrt_T_4[7:0] | (zQuadPiece_3_A7_sqrt ? 8'h89 : 8'h0)} | (cyc_S ? 9'h0 : nextMulAdd9A_A)} * {9'h0, {_zK1_A4_div_T_4[8], _zK1_A4_div_T_4[7:0] | (zLinPiece_3_A4_div ? 8'hF8 : 8'h0) | (zLinPiece_4_A4_div ? 8'hD2 : 8'h0) | (zLinPiece_5_A4_div ? 8'hB4 : 8'h0) | (zLinPiece_6_A4_div ? 8'h9C : 8'h0) | (zLinPiece_7_A4_div ? 8'h89 : 8'h0)} | zFractB_A7_sqrt | (cyc_S ? 9'h0 : nextMulAdd9B_A)}} + {1'h0, _GEN_0[17:0]};
  wire [6:0]   _mulAdd9Out_A_T_5 = loMulAdd9Out_A[18] ? {_mulAdd9C_A_T_33[24], _GEN_0[23:18]} + 7'h1 : {_mulAdd9C_A_T_33[24], _GEN_0[23:18]};
  wire [15:0]  r1_A1 = (sqrtOp_PA ? {1'h0, _mulAdd9Out_A_T_5, loMulAdd9Out_A[17:10]} : {_mulAdd9Out_A_T_5, loMulAdd9Out_A[17:9]}) | 16'h8000;
  wire [16:0]  _ER1_A1_sqrt_T_1 = {r1_A1, 1'h0};
  wire [16:0]  _GEN_1 = {1'h0, r1_A1};
  wire         _io_latchMulAddB_0_T = cyc_A1 | cyc_B7_sqrt;
  wire         _io_latchMulAddA_0_output = _io_latchMulAddB_0_T | cyc_B6_div | cyc_B4 | cyc_B3 | cyc_C6_sqrt | cyc_C4 | cyc_C1;
  wire [52:0]  _io_mulAddA_0_T_6 = (cyc_A1_sqrt ? {sExp_PA[0] ? _ER1_A1_sqrt_T_1 : _GEN_1, 36'h0} : 53'h0) | (cyc_B7_sqrt | cyc_A1_div ? {1'h1, fractB_PA} : 53'h0) | (cyc_B6_div ? {1'h1, fractA_PA} : 53'h0);
  wire [45:0]  zSigma1_B4 = cyc_B4 ? ~(io_mulAddResult_3[90:45]) : 46'h0;
  wire [51:0]  _io_mulAddB_0_T_1 = cyc_A1 ? {r1_A1, 36'h0} : 52'h0;
  wire [52:0]  _io_mulAddB_0_T_7 = {1'h0, _io_mulAddB_0_T_1[51], _io_mulAddB_0_T_1[50:0] | (cyc_B7_sqrt ? {ESqrR1_B_sqrt, 19'h0} : 51'h0)} | (cyc_B6_sqrt ? {ER1_B_sqrt, 36'h0} : 53'h0);
  wire [45:0]  _GEN_2 = _io_mulAddB_0_T_7[45:0] | zSigma1_B4;
  wire [53:0]  _zComplSigT_C1_T_5 = cyc_C1_div & io_mulAddResult_3[104] | cyc_C1_sqrt ? ~(io_mulAddResult_3[104:51]) : 54'h0;
  wire [52:0]  _GEN_3 = _zComplSigT_C1_T_5[52:0] | (cyc_C1_div & ~(io_mulAddResult_3[104]) ? ~(io_mulAddResult_3[102:50]) : 53'h0);
  wire [104:0] _io_mulAddC_2_T_1 = cyc_B1 ? {sigX1_B, 47'h0} : 105'h0;
  wire [104:0] _io_mulAddC_2_T_8 = {_io_mulAddC_2_T_1[104], _io_mulAddC_2_T_1[103:0] | (cyc_C6_sqrt ? {sigX1_B, 46'h0} : 104'h0)} | (cyc_C4_sqrt | cyc_C2 ? {sigXN_C, 47'h0} : 105'h0);
  wire [54:0]  _GEN_4 = {1'h0, sigT_E};
  wire [13:0]  sExpQuot_S_div = {2'h0, io_a[63:52]} + {{3{io_b[63]}}, ~(io_b[62:52])};
  wire         notSigNaNIn_invalidExc_S_div = rawA_S_isZero & ~(|(io_b[63:61])) | rawA_S__isInf & rawB_S__isInf;
  wire         notSigNaNIn_invalidExc_S_sqrt = ~rawB_S__isNaN & (|(io_b[63:61])) & io_b[64];
  wire         _majorExc_S_T_3 = rawB_S__isNaN & ~(io_b[51]) | notSigNaNIn_invalidExc_S_sqrt;
  wire         _majorExc_S_T_16 = rawA_S__isNaN & ~(io_a[51]) | rawB_S__isNaN & ~(io_b[51]) | notSigNaNIn_invalidExc_S_div | ~rawA_S__isNaN & ~rawA_S__isInf & ~(|(io_b[63:61]));
  wire         _isNaN_S_T = rawB_S__isNaN | notSigNaNIn_invalidExc_S_sqrt;
  wire         _isNaN_S_T_2 = rawA_S__isNaN | rawB_S__isNaN | notSigNaNIn_invalidExc_S_div;
  wire         _isInf_S_T = rawA_S__isInf | ~(|(io_b[63:61]));
  wire         _isZero_S_T = rawA_S_isZero | rawB_S__isInf;
  wire         sign_S = ~io_sqrtOp & io_a[64] ^ io_b[64];
  wire         normalCase_S = io_sqrtOp ? normalCase_S_sqrt : normalCase_S_div;
  wire         entering_PA_normalCase = entering_PA_normalCase_div | entering_PA_normalCase_sqrt;
  wire         entering_PA = entering_PA_normalCase | cyc_S & (valid_PA | ~ready_PB);
  wire         leaving_PA = valid_PA & valid_leaving_PA;
  wire         leaving_PB = valid_PB & valid_leaving_PB;
  wire         entering_PB = cyc_S & ~normalCase_S & ~valid_PA & (leaving_PB | ~valid_PB & ~ready_PC) | leaving_PA;
  wire         entering_PC = cyc_S & ~normalCase_S & ~valid_PA & ~valid_PB & ready_PC | leaving_PB;
  wire [8:0]   zFractR0_A6_sqrt = cyc_A6_sqrt & _mulAdd9Out_A_T_5[1] ? ~{_mulAdd9Out_A_T_5[0], loMulAdd9Out_A[17:10]} : 9'h0;
  wire [18:0]  sqrR0_A5_sqrt = sExp_PA[0] ? {_mulAdd9Out_A_T_5[0], loMulAdd9Out_A[17:0]} : {_mulAdd9Out_A_T_5[1:0], loMulAdd9Out_A[17:1]};
  wire [8:0]   _GEN_5 = {_mulAdd9Out_A_T_5[1:0], loMulAdd9Out_A[17:11]};
  wire [8:0]   zFractR0_A4_div = entering_PA_normalCase_div & _mulAdd9Out_A_T_5[2] ? ~_GEN_5 : 9'h0;
  wire         _GEN_6 = entering_PA_normalCase_sqrt | cyc_A6_sqrt | cyc_A5_sqrt | cyc_A4;
  always @(posedge clock) begin
    if (reset) begin
      cycleNum_A <= 3'h0;
      cycleNum_B <= 4'h0;
      cycleNum_C <= 3'h0;
      cycleNum_E <= 3'h0;
      valid_PA <= 1'h0;
      valid_PB <= 1'h0;
      valid_PC <= 1'h0;
    end
    else begin
      if (entering_PA_normalCase | (|cycleNum_A))
        cycleNum_A <= {1'h0, {2{entering_PA_normalCase_div}}} | (entering_PA_normalCase_sqrt ? 3'h6 : 3'h0) | (entering_PA_normalCase ? 3'h0 : cycleNum_A - 3'h1);
      if (cyc_A1 | (|cycleNum_B)) begin
        if (cyc_A1) begin
          if (sqrtOp_PA)
            cycleNum_B <= 4'hA;
          else
            cycleNum_B <= 4'h6;
        end
        else
          cycleNum_B <= cycleNum_B - 4'h1;
      end
      if (cyc_B1 | (|cycleNum_C)) begin
        if (cyc_B1) begin
          if (sqrtOp_PB)
            cycleNum_C <= 3'h6;
          else
            cycleNum_C <= 3'h5;
        end
        else
          cycleNum_C <= cycleNum_C - 3'h1;
      end
      if (cyc_C1 | (|cycleNum_E)) begin
        if (cyc_C1)
          cycleNum_E <= 3'h4;
        else
          cycleNum_E <= cycleNum_E - 3'h1;
      end
      if (entering_PA | leaving_PA)
        valid_PA <= entering_PA;
      if (entering_PB | leaving_PB)
        valid_PB <= entering_PB;
      if (entering_PC | leaving_PC)
        valid_PC <= entering_PC;
    end
    if (entering_PA) begin
      sqrtOp_PA <= io_sqrtOp;
      if (io_sqrtOp) begin
        majorExc_PA <= _majorExc_S_T_3;
        isNaN_PA <= _isNaN_S_T;
        isInf_PA <= rawB_S__isInf;
        isZero_PA <= ~(|(io_b[63:61]));
      end
      else begin
        majorExc_PA <= _majorExc_S_T_16;
        isNaN_PA <= _isNaN_S_T_2;
        isInf_PA <= _isInf_S_T;
        isZero_PA <= _isZero_S_T;
      end
      sign_PA <= sign_S;
    end
    if (entering_PA_normalCase) begin
      if (io_sqrtOp)
        sExp_PA <= {1'h0, io_b[63:52]};
      else
        sExp_PA <= {$signed(sExpQuot_S_div) > 14'shDFF ? 4'h6 : sExpQuot_S_div[12:9], sExpQuot_S_div[8:0]};
      fractB_PA <= io_b[51:0];
      roundingMode_PA <= io_roundingMode;
    end
    if (entering_PA_normalCase_div)
      fractA_PA <= io_a[51:0];
    if (entering_PB) begin
      if (valid_PA) begin
        sqrtOp_PB <= sqrtOp_PA;
        majorExc_PB <= majorExc_PA;
        isNaN_PB <= isNaN_PA;
        isInf_PB <= isInf_PA;
        isZero_PB <= isZero_PA;
        sign_PB <= sign_PA;
      end
      else begin
        sqrtOp_PB <= io_sqrtOp;
        if (io_sqrtOp) begin
          majorExc_PB <= _majorExc_S_T_3;
          isNaN_PB <= _isNaN_S_T;
          isInf_PB <= rawB_S__isInf;
          isZero_PB <= ~(|(io_b[63:61]));
        end
        else begin
          majorExc_PB <= _majorExc_S_T_16;
          isNaN_PB <= _isNaN_S_T_2;
          isInf_PB <= _isInf_S_T;
          isZero_PB <= _isZero_S_T;
        end
        sign_PB <= sign_S;
      end
    end
    if (valid_PA & normalCase_PA & valid_normalCase_leaving_PA) begin
      sExp_PB <= sExp_PA;
      bit0FractA_PB <= fractA_PA[0];
      fractB_PB <= fractB_PA;
      if (valid_PA)
        roundingMode_PB <= roundingMode_PA;
      else
        roundingMode_PB <= io_roundingMode;
    end
    if (entering_PC) begin
      if (valid_PB) begin
        sqrtOp_PC <= sqrtOp_PB;
        majorExc_PC <= majorExc_PB;
        isNaN_PC <= isNaN_PB;
        isInf_PC <= isInf_PB;
        isZero_PC <= isZero_PB;
        sign_PC <= sign_PB;
      end
      else begin
        sqrtOp_PC <= io_sqrtOp;
        if (io_sqrtOp) begin
          majorExc_PC <= _majorExc_S_T_3;
          isNaN_PC <= _isNaN_S_T;
          isInf_PC <= rawB_S__isInf;
          isZero_PC <= ~(|(io_b[63:61]));
        end
        else begin
          majorExc_PC <= _majorExc_S_T_16;
          isNaN_PC <= _isNaN_S_T_2;
          isInf_PC <= _isInf_S_T;
          isZero_PC <= _isZero_S_T;
        end
        sign_PC <= sign_S;
      end
    end
    if (valid_PB & normalCase_PB & cyc_C3) begin
      sExp_PC <= sExp_PB;
      bit0FractA_PC <= bit0FractA_PB;
      fractB_PC <= fractB_PB;
      if (valid_PB)
        roundingMode_PC <= roundingMode_PB;
      else
        roundingMode_PC <= io_roundingMode;
    end
    fractR0_A <= cyc_A6_sqrt | entering_PA_normalCase_div ? zFractR0_A6_sqrt | zFractR0_A4_div : fractR0_A;
    hiSqrR0_A_sqrt <= cyc_A5_sqrt ? sqrR0_A5_sqrt[18:9] : hiSqrR0_A_sqrt;
    partNegSigma0_A <= cyc_A4_sqrt | cyc_A3 ? (cyc_A4_sqrt ? {_mulAdd9Out_A_T_5[2:0], loMulAdd9Out_A[17:0]} : {5'h0, _mulAdd9Out_A_T_5, loMulAdd9Out_A[17:9]}) : partNegSigma0_A;
    nextMulAdd9A_A <= _GEN_6 | cyc_A3 | cyc_A2 ? (entering_PA_normalCase_sqrt ? ~_GEN_5 : 9'h0) | zFractR0_A6_sqrt | (cyc_A4_sqrt ? fractB_PA[43:35] : 9'h0) | zFractB_A4_div[8:0] | (cyc_A5_sqrt | cyc_A3 ? {1'h1, fractB_PA[51:44]} : 9'h0) | (cyc_A2 & loMulAdd9Out_A[11] ? ~(loMulAdd9Out_A[10:2]) : 9'h0) : nextMulAdd9A_A;
    nextMulAdd9B_A <= _GEN_6 | cyc_A2 ? zFractB_A7_sqrt | zFractR0_A6_sqrt | (cyc_A5_sqrt ? sqrR0_A5_sqrt[8:0] : 9'h0) | zFractR0_A4_div | (cyc_A4_sqrt ? hiSqrR0_A_sqrt[8:0] : 9'h0) | (cyc_A2 ? {1'h1, fractR0_A[8:1]} : 9'h0) : nextMulAdd9B_A;
    if (cyc_A1_sqrt) begin
      if (sExp_PA[0])
        ER1_B_sqrt <= _ER1_A1_sqrt_T_1;
      else
        ER1_B_sqrt <= _GEN_1;
    end
    if (cyc_B8_sqrt)
      ESqrR1_B_sqrt <= io_mulAddResult_3[103:72];
    if (cyc_B3)
      sigX1_B <= io_mulAddResult_3[104:47];
    if (cyc_B1)
      sqrSigma1_C <= io_mulAddResult_3[79:47];
    if (cyc_C6_sqrt | cyc_C5 & ~sqrtOp_PB | cyc_C3 & sqrtOp_PB)
      sigXN_C <= io_mulAddResult_3[104:47];
    if (cyc_C5 & sqrtOp_PB)
      u_C_sqrt <= io_mulAddResult_3[103:73];
    if (cyc_C1) begin
      E_E_div <= ~(io_mulAddResult_3[104]);
      sigT_E <= ~{_zComplSigT_C1_T_5[53], _GEN_3};
    end
    if (cycleNum_E == 3'h2) begin
      if (sqrtOp_PC)
        isNegRemT_E <= io_mulAddResult_3[55];
      else
        isNegRemT_E <= io_mulAddResult_3[53];
      isZeroRemT_E <= io_mulAddResult_3[53:0] == 54'h0 & (~sqrtOp_PC | io_mulAddResult_3[55:54] == 2'h0);
    end
  end // always @(posedge)
  assign io_inReady_div = _io_inReady_div_output;
  assign io_inReady_sqrt = _io_inReady_sqrt_output;
  assign io_usingMulAdd = {cyc_A4 | cyc_A3_div | cyc_A1_div | cycleNum_B == 4'hA | cyc_B9_sqrt | cyc_B7_sqrt | cyc_B6 | cyc_B5_sqrt | cyc_B3_sqrt | cyc_B2_div | cyc_B1_sqrt | cyc_C4, cyc_A3 | cyc_A2 & ~sqrtOp_PA | cyc_B9_sqrt | cyc_B8_sqrt | cyc_B6 | cyc_B5 | cyc_B4_sqrt | cyc_B2_sqrt | cyc_B1 & ~sqrtOp_PB | cyc_C6_sqrt | cyc_C3, cyc_A2 | cyc_A1_div | cyc_B8_sqrt | cyc_B7_sqrt | cyc_B5 | cyc_B4 | cyc_B3_sqrt | cyc_B1_sqrt | cyc_C5 | cyc_C2, _io_latchMulAddA_0_output | cyc_B6 | cyc_B2_sqrt};
  assign io_latchMulAddA_0 = _io_latchMulAddA_0_output;
  assign io_mulAddA_0 = {1'h0, {_io_mulAddA_0_T_6[52:46], {_io_mulAddA_0_T_6[45:34], _io_mulAddA_0_T_6[33:0] | zSigma1_B4[45:12]} | (cyc_B3 | cyc_C6_sqrt ? io_mulAddResult_3[104:59] : 46'h0) | (cyc_C4 & ~sqrtOp_PB ? {sigXN_C[57:25], 13'h0} : 46'h0) | (cyc_C4_sqrt ? {u_C_sqrt, 15'h0} : 46'h0)} | (cyc_C1_div ? {1'h1, fractB_PC} : 53'h0)} | (cyc_C1_sqrt ? ~(io_mulAddResult_3[104:51]) : 54'h0);
  assign io_latchMulAddB_0 = _io_latchMulAddB_0_T | cyc_B6_sqrt | cyc_B4 | cyc_C6_sqrt | cyc_C4 | cyc_C1;
  assign io_mulAddB_0 = {_zComplSigT_C1_T_5[53], _io_mulAddB_0_T_7[52:46] | _GEN_3[52:46], _GEN_2[45:33] | _GEN_3[45:33], {_GEN_2[32:30], _GEN_2[29:0] | (cyc_C6_sqrt ? sqrSigma1_C[30:1] : 30'h0)} | (cyc_C4 ? sqrSigma1_C : 33'h0) | _GEN_3[32:0]};
  assign io_mulAddC_2 = {_io_mulAddC_2_T_8[104:56], {_io_mulAddC_2_T_8[55:54], _io_mulAddC_2_T_8[53:0] | (cyc_E3 & ~sqrtOp_PC & ~E_E_div ? {bit0FractA_PC, 53'h0} : 54'h0)} | (cyc_E3 & sqrtOp_PC ? {(sExp_PC[0] ? {fractB_PC[0], 1'h0} : {fractB_PC[1] ^ fractB_PC[0], fractB_PC[0]}) ^ {~(sigT_E[0]), 1'h0}, 54'h0} : 56'h0)};
  assign io_rawOutValid_div = leaving_PC & ~sqrtOp_PC;
  assign io_rawOutValid_sqrt = leaving_PC & sqrtOp_PC;
  assign io_roundingModeOut = roundingMode_PC;
  assign io_invalidExc = majorExc_PC & isNaN_PC;
  assign io_infiniteExc = majorExc_PC & ~isNaN_PC;
  assign io_rawOut_isNaN = isNaN_PC;
  assign io_rawOut_isInf = isInf_PC;
  assign io_rawOut_isZero = isZero_PC;
  assign io_rawOut_sign = sign_PC;
  assign io_rawOut_sExp = (~sqrtOp_PC & E_E_div ? sExp_PC : 13'h0) | (sqrtOp_PC | E_E_div ? 13'h0 : sExp_PC + 13'h1) | (sqrtOp_PC ? {sExp_PC[12], sExp_PC[12:1]} + 13'h400 : 13'h0);
  assign io_rawOut_sig = {(sqrtOp_PC ? ~isNegRemT_E & ~isZeroRemT_E : isNegRemT_E) ? _GEN_4 : _GEN_4 + 55'h1, ~isZeroRemT_E};
endmodule

