// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MulAddRecFNPipe_1(
  input         clock,
                reset,
                io_validin,
  input  [1:0]  io_op,
  input  [32:0] io_a,
                io_b,
                io_c,
  input  [2:0]  io_roundingMode,
  output [32:0] io_out,
  output [4:0]  io_exceptionFlags,
  output        io_validout
);

  wire        _mulAddRecFNToRaw_postMul_io_invalidExc;
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_isNaN;
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_isInf;
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_isZero;
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_sign;
  wire [9:0]  _mulAddRecFNToRaw_postMul_io_rawOut_sExp;
  wire [26:0] _mulAddRecFNToRaw_postMul_io_rawOut_sig;
  wire [23:0] _mulAddRecFNToRaw_preMul_io_mulAddA;
  wire [23:0] _mulAddRecFNToRaw_preMul_io_mulAddB;
  wire [47:0] _mulAddRecFNToRaw_preMul_io_mulAddC;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isSigNaNAny;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNAOrB;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfA;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroA;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfB;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroB;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_signProd;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNC;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfC;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroC;
  wire [9:0]  _mulAddRecFNToRaw_preMul_io_toPostMul_sExpSum;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_doSubMags;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_CIsDominant;
  wire [4:0]  _mulAddRecFNToRaw_preMul_io_toPostMul_CDom_CAlignDist;
  wire [25:0] _mulAddRecFNToRaw_preMul_io_toPostMul_highAlignedSigC;
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_bit0AlignedSigC;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isSigNaNAny;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isNaNAOrB;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfA;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroA;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfB;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroB;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_signProd;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isNaNC;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfC;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroC;
  reg  [9:0]  mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_sExpSum;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_doSubMags;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_CIsDominant;
  reg  [4:0]  mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_CDom_CAlignDist;
  reg  [25:0] mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_highAlignedSigC;
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_bit0AlignedSigC;
  reg  [48:0] mulAddRecFNToRaw_postMul_io_mulAddResult_pipe_b;
  reg  [2:0]  mulAddRecFNToRaw_postMul_io_roundingMode_pipe_b;
  reg  [2:0]  roundingMode_stage0;
  reg         valid_stage0;
  reg         roundRawFNToRecFN_io_invalidExc_pipe_b;
  reg         roundRawFNToRecFN_io_in_pipe_b_isNaN;
  reg         roundRawFNToRecFN_io_in_pipe_b_isInf;
  reg         roundRawFNToRecFN_io_in_pipe_b_isZero;
  reg         roundRawFNToRecFN_io_in_pipe_b_sign;
  reg  [9:0]  roundRawFNToRecFN_io_in_pipe_b_sExp;
  reg  [26:0] roundRawFNToRecFN_io_in_pipe_b_sig;
  reg  [2:0]  roundRawFNToRecFN_io_roundingMode_pipe_b;
  reg         roundRawFNToRecFN_io_detectTininess_pipe_b;
  reg         io_validout_pipe_v;
  always @(posedge clock) begin
    if (io_validin) begin
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isSigNaNAny <= _mulAddRecFNToRaw_preMul_io_toPostMul_isSigNaNAny;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isNaNAOrB <= _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNAOrB;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfA <= _mulAddRecFNToRaw_preMul_io_toPostMul_isInfA;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroA <= _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroA;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfB <= _mulAddRecFNToRaw_preMul_io_toPostMul_isInfB;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroB <= _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroB;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_signProd <= _mulAddRecFNToRaw_preMul_io_toPostMul_signProd;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isNaNC <= _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNC;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfC <= _mulAddRecFNToRaw_preMul_io_toPostMul_isInfC;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroC <= _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroC;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_sExpSum <= _mulAddRecFNToRaw_preMul_io_toPostMul_sExpSum;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_doSubMags <= _mulAddRecFNToRaw_preMul_io_toPostMul_doSubMags;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_CIsDominant <= _mulAddRecFNToRaw_preMul_io_toPostMul_CIsDominant;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_CDom_CAlignDist <= _mulAddRecFNToRaw_preMul_io_toPostMul_CDom_CAlignDist;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_highAlignedSigC <= _mulAddRecFNToRaw_preMul_io_toPostMul_highAlignedSigC;
      mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_bit0AlignedSigC <= _mulAddRecFNToRaw_preMul_io_toPostMul_bit0AlignedSigC;
      mulAddRecFNToRaw_postMul_io_mulAddResult_pipe_b <= {1'h0, {24'h0, _mulAddRecFNToRaw_preMul_io_mulAddA} * {24'h0, _mulAddRecFNToRaw_preMul_io_mulAddB}} + {1'h0, _mulAddRecFNToRaw_preMul_io_mulAddC};
      mulAddRecFNToRaw_postMul_io_roundingMode_pipe_b <= io_roundingMode;
      roundingMode_stage0 <= io_roundingMode;
    end
    if (valid_stage0) begin
      roundRawFNToRecFN_io_invalidExc_pipe_b <= _mulAddRecFNToRaw_postMul_io_invalidExc;
      roundRawFNToRecFN_io_in_pipe_b_isNaN <= _mulAddRecFNToRaw_postMul_io_rawOut_isNaN;
      roundRawFNToRecFN_io_in_pipe_b_isInf <= _mulAddRecFNToRaw_postMul_io_rawOut_isInf;
      roundRawFNToRecFN_io_in_pipe_b_isZero <= _mulAddRecFNToRaw_postMul_io_rawOut_isZero;
      roundRawFNToRecFN_io_in_pipe_b_sign <= _mulAddRecFNToRaw_postMul_io_rawOut_sign;
      roundRawFNToRecFN_io_in_pipe_b_sExp <= _mulAddRecFNToRaw_postMul_io_rawOut_sExp;
      roundRawFNToRecFN_io_in_pipe_b_sig <= _mulAddRecFNToRaw_postMul_io_rawOut_sig;
      roundRawFNToRecFN_io_roundingMode_pipe_b <= roundingMode_stage0;
    end
    roundRawFNToRecFN_io_detectTininess_pipe_b <= valid_stage0 | roundRawFNToRecFN_io_detectTininess_pipe_b;
    if (reset) begin
      valid_stage0 <= 1'h0;
      io_validout_pipe_v <= 1'h0;
    end
    else begin
      valid_stage0 <= io_validin;
      io_validout_pipe_v <= valid_stage0;
    end
  end // always @(posedge)
  MulAddRecFNToRaw_preMul_1 mulAddRecFNToRaw_preMul (
    .io_op                        (io_op),
    .io_a                         (io_a),
    .io_b                         (io_b),
    .io_c                         (io_c),
    .io_mulAddA                   (_mulAddRecFNToRaw_preMul_io_mulAddA),
    .io_mulAddB                   (_mulAddRecFNToRaw_preMul_io_mulAddB),
    .io_mulAddC                   (_mulAddRecFNToRaw_preMul_io_mulAddC),
    .io_toPostMul_isSigNaNAny     (_mulAddRecFNToRaw_preMul_io_toPostMul_isSigNaNAny),
    .io_toPostMul_isNaNAOrB       (_mulAddRecFNToRaw_preMul_io_toPostMul_isNaNAOrB),
    .io_toPostMul_isInfA          (_mulAddRecFNToRaw_preMul_io_toPostMul_isInfA),
    .io_toPostMul_isZeroA         (_mulAddRecFNToRaw_preMul_io_toPostMul_isZeroA),
    .io_toPostMul_isInfB          (_mulAddRecFNToRaw_preMul_io_toPostMul_isInfB),
    .io_toPostMul_isZeroB         (_mulAddRecFNToRaw_preMul_io_toPostMul_isZeroB),
    .io_toPostMul_signProd        (_mulAddRecFNToRaw_preMul_io_toPostMul_signProd),
    .io_toPostMul_isNaNC          (_mulAddRecFNToRaw_preMul_io_toPostMul_isNaNC),
    .io_toPostMul_isInfC          (_mulAddRecFNToRaw_preMul_io_toPostMul_isInfC),
    .io_toPostMul_isZeroC         (_mulAddRecFNToRaw_preMul_io_toPostMul_isZeroC),
    .io_toPostMul_sExpSum         (_mulAddRecFNToRaw_preMul_io_toPostMul_sExpSum),
    .io_toPostMul_doSubMags       (_mulAddRecFNToRaw_preMul_io_toPostMul_doSubMags),
    .io_toPostMul_CIsDominant     (_mulAddRecFNToRaw_preMul_io_toPostMul_CIsDominant),
    .io_toPostMul_CDom_CAlignDist (_mulAddRecFNToRaw_preMul_io_toPostMul_CDom_CAlignDist),
    .io_toPostMul_highAlignedSigC (_mulAddRecFNToRaw_preMul_io_toPostMul_highAlignedSigC),
    .io_toPostMul_bit0AlignedSigC (_mulAddRecFNToRaw_preMul_io_toPostMul_bit0AlignedSigC)
  );
  MulAddRecFNToRaw_postMul_1 mulAddRecFNToRaw_postMul (
    .io_fromPreMul_isSigNaNAny     (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isSigNaNAny),
    .io_fromPreMul_isNaNAOrB       (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isNaNAOrB),
    .io_fromPreMul_isInfA          (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfA),
    .io_fromPreMul_isZeroA         (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroA),
    .io_fromPreMul_isInfB          (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfB),
    .io_fromPreMul_isZeroB         (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroB),
    .io_fromPreMul_signProd        (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_signProd),
    .io_fromPreMul_isNaNC          (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isNaNC),
    .io_fromPreMul_isInfC          (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isInfC),
    .io_fromPreMul_isZeroC         (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_isZeroC),
    .io_fromPreMul_sExpSum         (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_sExpSum),
    .io_fromPreMul_doSubMags       (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_doSubMags),
    .io_fromPreMul_CIsDominant     (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_CIsDominant),
    .io_fromPreMul_CDom_CAlignDist (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_CDom_CAlignDist),
    .io_fromPreMul_highAlignedSigC (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_highAlignedSigC),
    .io_fromPreMul_bit0AlignedSigC (mulAddRecFNToRaw_postMul_io_fromPreMul_pipe_b_bit0AlignedSigC),
    .io_mulAddResult               (mulAddRecFNToRaw_postMul_io_mulAddResult_pipe_b),
    .io_roundingMode               (mulAddRecFNToRaw_postMul_io_roundingMode_pipe_b),
    .io_invalidExc                 (_mulAddRecFNToRaw_postMul_io_invalidExc),
    .io_rawOut_isNaN               (_mulAddRecFNToRaw_postMul_io_rawOut_isNaN),
    .io_rawOut_isInf               (_mulAddRecFNToRaw_postMul_io_rawOut_isInf),
    .io_rawOut_isZero              (_mulAddRecFNToRaw_postMul_io_rawOut_isZero),
    .io_rawOut_sign                (_mulAddRecFNToRaw_postMul_io_rawOut_sign),
    .io_rawOut_sExp                (_mulAddRecFNToRaw_postMul_io_rawOut_sExp),
    .io_rawOut_sig                 (_mulAddRecFNToRaw_postMul_io_rawOut_sig)
  );
  RoundRawFNToRecFN_1 roundRawFNToRecFN (
    .io_invalidExc     (roundRawFNToRecFN_io_invalidExc_pipe_b),
    .io_in_isNaN       (roundRawFNToRecFN_io_in_pipe_b_isNaN),
    .io_in_isInf       (roundRawFNToRecFN_io_in_pipe_b_isInf),
    .io_in_isZero      (roundRawFNToRecFN_io_in_pipe_b_isZero),
    .io_in_sign        (roundRawFNToRecFN_io_in_pipe_b_sign),
    .io_in_sExp        (roundRawFNToRecFN_io_in_pipe_b_sExp),
    .io_in_sig         (roundRawFNToRecFN_io_in_pipe_b_sig),
    .io_roundingMode   (roundRawFNToRecFN_io_roundingMode_pipe_b),
    .io_detectTininess (roundRawFNToRecFN_io_detectTininess_pipe_b),
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
  assign io_validout = io_validout_pipe_v;
endmodule

