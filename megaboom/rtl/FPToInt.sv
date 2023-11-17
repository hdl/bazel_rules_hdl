// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FPToInt(
  input         clock,
                io_in_valid,
                io_in_bits_ren2,
  input  [1:0]  io_in_bits_typeTagOut,
  input         io_in_bits_wflags,
  input  [2:0]  io_in_bits_rm,
  input  [1:0]  io_in_bits_typ,
                io_in_bits_fmt,
  input  [64:0] io_in_bits_in1,
                io_in_bits_in2,
  output        io_out_bits_lt,
  output [63:0] io_out_bits_toint,
  output [4:0]  io_out_bits_exc
);

  wire        _narrow_io_signedOut_T;
  wire [2:0]  _narrow_io_intExceptionFlags;
  wire [63:0] _conv_io_out;
  wire [2:0]  _conv_io_intExceptionFlags;
  wire        _dcmp_io_lt;
  wire        _dcmp_io_eq;
  wire [4:0]  _dcmp_io_exceptionFlags;
  reg         in_ren2;
  reg  [1:0]  in_typeTagOut;
  reg         in_wflags;
  reg  [2:0]  in_rm;
  reg  [1:0]  in_typ;
  reg  [1:0]  in_fmt;
  reg  [64:0] in_in1;
  reg  [64:0] in_in2;
  wire [12:0] _GEN = {1'h0, in_in1[63:52]};
  wire [52:0] _store_unrecoded_denormFract_T_1 = {1'h0, |(in_in1[63:61]), in_in1[51:1]} >> 6'h1 - in_in1[57:52];
  wire [1:0]  _store_prevUnrecoded_rawIn_isSpecial_T = {in_in1[52], in_in1[30]};
  wire        store_prevUnrecoded_rawIn__isInf = (&_store_prevUnrecoded_rawIn_isSpecial_T) & ~(in_in1[29]);
  wire        store_prevUnrecoded_isSubnormal = $signed({1'h0, in_in1[52], in_in1[30:23]}) < 10'sh82;
  wire [23:0] _store_prevUnrecoded_denormFract_T_1 = {1'h0, |{in_in1[52], in_in1[30:29]}, in_in1[22:1]} >> 5'h1 - in_in1[27:23];
  wire        store_unrecoded_rawIn_1_isInf = (&(in_in1[63:62])) & ~(in_in1[61]);
  wire        store_unrecoded_isSubnormal_1 = $signed(_GEN) < 13'sh402;
  wire [52:0] _store_unrecoded_denormFract_T_3 = {1'h0, |(in_in1[63:61]), in_in1[51:1]} >> 6'h1 - in_in1[57:52];
  wire [51:0] store_unrecoded_fractOut_1 = store_unrecoded_isSubnormal_1 ? _store_unrecoded_denormFract_T_3[51:0] : store_unrecoded_rawIn_1_isInf ? 52'h0 : in_in1[51:0];
  wire [1:0]  _store_prevUnrecoded_rawIn_isSpecial_T_1 = {in_in1[52], in_in1[30]};
  wire        store_prevUnrecoded_rawIn_1_isInf = (&_store_prevUnrecoded_rawIn_isSpecial_T_1) & ~(in_in1[29]);
  wire        store_prevUnrecoded_isSubnormal_1 = $signed({1'h0, in_in1[52], in_in1[30:23]}) < 10'sh82;
  wire [23:0] _store_prevUnrecoded_denormFract_T_3 = {1'h0, |{in_in1[52], in_in1[30:29]}, in_in1[22:1]} >> 5'h1 - in_in1[27:23];
  wire [63:0] store = in_typeTagOut[0] ? {in_in1[64], (store_unrecoded_isSubnormal_1 ? 11'h0 : in_in1[62:52] + 11'h3FF) | {11{(&(in_in1[63:62])) & in_in1[61] | store_unrecoded_rawIn_1_isInf}}, store_unrecoded_fractOut_1[51:32], (&(in_in1[63:61])) ? {in_in1[31], (store_prevUnrecoded_isSubnormal_1 ? 8'h0 : in_in1[30:23] + 8'h7F) | {8{(&_store_prevUnrecoded_rawIn_isSpecial_T_1) & in_in1[29] | store_prevUnrecoded_rawIn_1_isInf}}, store_prevUnrecoded_isSubnormal_1 ? _store_prevUnrecoded_denormFract_T_3[22:0] : store_prevUnrecoded_rawIn_1_isInf ? 23'h0 : in_in1[22:0]} : store_unrecoded_fractOut_1[31:0]} : {2{(&(in_in1[63:61])) ? {in_in1[31], (store_prevUnrecoded_isSubnormal ? 8'h0 : in_in1[30:23] + 8'h7F) | {8{(&_store_prevUnrecoded_rawIn_isSpecial_T) & in_in1[29] | store_prevUnrecoded_rawIn__isInf}}, store_prevUnrecoded_isSubnormal ? _store_prevUnrecoded_denormFract_T_1[22:0] : store_prevUnrecoded_rawIn__isInf ? 23'h0 : in_in1[22:0]} : $signed(_GEN) < 13'sh402 ? _store_unrecoded_denormFract_T_1[31:0] : (&(in_in1[63:62])) & ~(in_in1[61]) ? 32'h0 : in_in1[31:0]}};
  wire        invalid = _conv_io_intExceptionFlags[2] | _narrow_io_intExceptionFlags[1];
  wire        excSign = in_in1[64] & in_in1[63:61] != 3'h7;
  wire        classify_out_isInf_1 = (&(in_in1[63:62])) & ~(in_in1[61]);
  wire        _classify_out_isSubnormal_T_4 = in_in1[63:62] == 2'h1;
  wire        classify_out_isHighSubnormalIn_1 = in_in1[61:52] < 10'h2;
  wire        classify_out_isNormal_1 = _classify_out_isSubnormal_T_4 & ~classify_out_isHighSubnormalIn_1 | in_in1[63:62] == 2'h2;
  wire        classify_out_isSubnormal_1 = in_in1[63:61] == 3'h1 | _classify_out_isSubnormal_T_4 & classify_out_isHighSubnormalIn_1;
  wire        classify_out_isZero_1 = in_in1[63:61] == 3'h0;
  wire [8:0]  _classify_out_expOut_commonCase_T = in_in1[60:52] - 9'h100;
  wire [8:0]  classify_out_expOut = in_in1[63:61] == 3'h0 | in_in1[63:61] > 3'h5 ? {in_in1[63:61], _classify_out_expOut_commonCase_T[5:0]} : _classify_out_expOut_commonCase_T;
  wire        classify_out_isInf = (&(classify_out_expOut[8:7])) & ~(classify_out_expOut[6]);
  wire        _classify_out_isSubnormal_T_1 = classify_out_expOut[8:7] == 2'h1;
  wire        classify_out_isHighSubnormalIn = classify_out_expOut[6:0] < 7'h2;
  wire        classify_out_isNormal = _classify_out_isSubnormal_T_1 & ~classify_out_isHighSubnormalIn | classify_out_expOut[8:7] == 2'h2;
  wire        classify_out_isSubnormal = classify_out_expOut[8:6] == 3'h1 | _classify_out_isSubnormal_T_1 & classify_out_isHighSubnormalIn;
  wire        classify_out_isZero = classify_out_expOut[8:6] == 3'h0;
  wire [63:0] toint = in_wflags ? (in_ren2 ? {store[63:32], 31'h0, |(~(in_rm[1:0]) & {_dcmp_io_lt, _dcmp_io_eq})} : ~(in_typ[1]) & invalid ? {_conv_io_out[63:32], ~_narrow_io_signedOut_T == excSign, {31{~excSign}}} : _conv_io_out) : in_rm[0] ? {store[63:32], 22'h0, in_typeTagOut[0] ? {(&(in_in1[63:61])) & in_in1[51], (&(in_in1[63:61])) & ~(in_in1[51]), classify_out_isInf_1 & ~(in_in1[64]), classify_out_isNormal_1 & ~(in_in1[64]), classify_out_isSubnormal_1 & ~(in_in1[64]), classify_out_isZero_1 & ~(in_in1[64]), classify_out_isZero_1 & in_in1[64], classify_out_isSubnormal_1 & in_in1[64], classify_out_isNormal_1 & in_in1[64], classify_out_isInf_1 & in_in1[64]} : {(&(classify_out_expOut[8:6])) & in_in1[51], (&(classify_out_expOut[8:6])) & ~(in_in1[51]), classify_out_isInf & ~(in_in1[64]), classify_out_isNormal & ~(in_in1[64]), classify_out_isSubnormal & ~(in_in1[64]), classify_out_isZero & ~(in_in1[64]), classify_out_isZero & in_in1[64], classify_out_isSubnormal & in_in1[64], classify_out_isNormal & in_in1[64], classify_out_isInf & in_in1[64]}} : store;
  assign _narrow_io_signedOut_T = in_typ[0];
  always @(posedge clock) begin
    if (io_in_valid) begin
      in_ren2 <= io_in_bits_ren2;
      in_typeTagOut <= io_in_bits_typeTagOut;
      in_wflags <= io_in_bits_wflags;
      in_rm <= io_in_bits_rm;
      in_typ <= io_in_bits_typ;
      in_fmt <= io_in_bits_fmt;
      in_in1 <= io_in_bits_in1;
      in_in2 <= io_in_bits_in2;
    end
  end // always @(posedge)
  CompareRecFN dcmp (
    .io_a              (in_in1),
    .io_b              (in_in2),
    .io_signaling      (~(in_rm[1])),
    .io_lt             (_dcmp_io_lt),
    .io_eq             (_dcmp_io_eq),
    .io_exceptionFlags (_dcmp_io_exceptionFlags)
  );
  RecFNToIN conv (
    .io_in                (in_in1),
    .io_roundingMode      (in_rm),
    .io_signedOut         (~_narrow_io_signedOut_T),
    .io_out               (_conv_io_out),
    .io_intExceptionFlags (_conv_io_intExceptionFlags)
  );
  RecFNToIN_1 narrow (
    .io_in                (in_in1),
    .io_roundingMode      (in_rm),
    .io_signedOut         (~_narrow_io_signedOut_T),
    .io_intExceptionFlags (_narrow_io_intExceptionFlags)
  );
  assign io_out_bits_lt = _dcmp_io_lt | $signed(in_in1) < 65'sh0 & $signed(in_in2) > -65'sh1;
  assign io_out_bits_toint = (in_wflags ? ~in_ren2 & in_typ[1] : ~(in_rm[0]) & in_fmt[0]) ? toint : {{32{toint[31]}}, toint[31:0]};
  assign io_out_bits_exc = in_wflags ? (in_ren2 ? _dcmp_io_exceptionFlags : in_typ[1] ? {|(_conv_io_intExceptionFlags[2:1]), 3'h0, _conv_io_intExceptionFlags[0]} : {invalid, 3'h0, ~invalid & _conv_io_intExceptionFlags[0]}) : 5'h0;
endmodule

