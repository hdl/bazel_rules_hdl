// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IntToFP(
  input         clock,
                reset,
                io_in_valid,
  input  [1:0]  io_in_bits_typeTagIn,
  input         io_in_bits_wflags,
  input  [2:0]  io_in_bits_rm,
  input  [1:0]  io_in_bits_typ,
  input  [63:0] io_in_bits_in1,
  output        io_out_valid,
  output [64:0] io_out_bits_data,
  output [4:0]  io_out_bits_exc
);

  wire [64:0]  _i2f_1_io_out;
  wire [4:0]   _i2f_1_io_exceptionFlags;
  wire [32:0]  _i2f_io_out;
  wire [4:0]   _i2f_io_exceptionFlags;
  reg          in_valid;
  reg  [1:0]   in_bits_typeTagIn;
  reg          in_bits_wflags;
  reg  [2:0]   in_bits_rm;
  reg  [1:0]   in_bits_typ;
  reg  [63:0]  in_bits_in1;
  wire [63:0]  intValue_res = in_bits_typ[1] ? in_bits_in1 : {{32{~(in_bits_typ[0]) & in_bits_in1[31]}}, in_bits_in1[31:0]};
  reg          io_out_pipe_v;
  reg  [64:0]  io_out_pipe_b_data;
  reg  [4:0]   io_out_pipe_b_exc;
  wire [64:0]  _GEN = ({65{_i2f_1_io_out[63:61] != 3'h7}} | 65'h1EFEFFFFFFFFFFFFF) & _i2f_1_io_out;
  wire [63:0]  _mux_data_T_2 = (in_bits_typeTagIn[0] ? 64'h0 : 64'hFFFFFFFF00000000) | in_bits_in1;
  wire         mux_data_rawIn_isZeroExpIn = _mux_data_T_2[62:52] == 11'h0;
  wire [5:0]   mux_data_rawIn_normDist = _mux_data_T_2[51] ? 6'h0 : _mux_data_T_2[50] ? 6'h1 : _mux_data_T_2[49] ? 6'h2 : _mux_data_T_2[48] ? 6'h3 : _mux_data_T_2[47] ? 6'h4 : _mux_data_T_2[46] ? 6'h5 : _mux_data_T_2[45] ? 6'h6 : _mux_data_T_2[44] ? 6'h7 : _mux_data_T_2[43] ? 6'h8 : _mux_data_T_2[42] ? 6'h9 : _mux_data_T_2[41] ? 6'hA : _mux_data_T_2[40] ? 6'hB : _mux_data_T_2[39] ? 6'hC : _mux_data_T_2[38] ? 6'hD : _mux_data_T_2[37] ? 6'hE : _mux_data_T_2[36] ? 6'hF : _mux_data_T_2[35] ? 6'h10 : _mux_data_T_2[34] ? 6'h11 : _mux_data_T_2[33] ? 6'h12 : _mux_data_T_2[32] ? 6'h13 : _mux_data_T_2[31] ? 6'h14 : _mux_data_T_2[30] ? 6'h15 : _mux_data_T_2[29] ? 6'h16 : _mux_data_T_2[28] ? 6'h17 : _mux_data_T_2[27] ? 6'h18 : _mux_data_T_2[26] ? 6'h19 : _mux_data_T_2[25] ? 6'h1A : _mux_data_T_2[24] ? 6'h1B : _mux_data_T_2[23] ? 6'h1C : _mux_data_T_2[22] ? 6'h1D : _mux_data_T_2[21] ? 6'h1E : _mux_data_T_2[20] ? 6'h1F : _mux_data_T_2[19] ? 6'h20 : _mux_data_T_2[18] ? 6'h21 : _mux_data_T_2[17] ? 6'h22 : _mux_data_T_2[16] ? 6'h23 : _mux_data_T_2[15] ? 6'h24 : _mux_data_T_2[14] ? 6'h25 : _mux_data_T_2[13] ? 6'h26 : _mux_data_T_2[12] ? 6'h27 : _mux_data_T_2[11] ? 6'h28 : _mux_data_T_2[10] ? 6'h29 : _mux_data_T_2[9] ? 6'h2A : _mux_data_T_2[8] ? 6'h2B : _mux_data_T_2[7] ? 6'h2C : _mux_data_T_2[6] ? 6'h2D : _mux_data_T_2[5] ? 6'h2E : _mux_data_T_2[4] ? 6'h2F : _mux_data_T_2[3] ? 6'h30 : _mux_data_T_2[2] ? 6'h31 : {5'h19, ~(_mux_data_T_2[1])};
  wire [11:0]  _mux_data_rawIn_adjustedExp_T_4 = (mux_data_rawIn_isZeroExpIn ? {6'h3F, ~mux_data_rawIn_normDist} : {1'h0, _mux_data_T_2[62:52]}) + {10'h100, mux_data_rawIn_isZeroExpIn ? 2'h2 : 2'h1};
  wire [114:0] _mux_data_rawIn_subnormFract_T = {63'h0, _mux_data_T_2[51:0]} << mux_data_rawIn_normDist;
  wire [51:0]  _mux_data_rawIn_out_sig_T_2 = mux_data_rawIn_isZeroExpIn ? {_mux_data_rawIn_subnormFract_T[50:0], 1'h0} : _mux_data_T_2[51:0];
  wire [2:0]   _mux_data_T_4 = mux_data_rawIn_isZeroExpIn & ~(|(_mux_data_T_2[51:0])) ? 3'h0 : _mux_data_rawIn_adjustedExp_T_4[11:9];
  wire         _GEN_0 = _mux_data_T_4[0] | (&(_mux_data_rawIn_adjustedExp_T_4[11:10])) & (|(_mux_data_T_2[51:0]));
  wire         mux_data_rawIn_isZeroExpIn_1 = _mux_data_T_2[30:23] == 8'h0;
  wire [4:0]   mux_data_rawIn_normDist_1 = _mux_data_T_2[22] ? 5'h0 : _mux_data_T_2[21] ? 5'h1 : _mux_data_T_2[20] ? 5'h2 : _mux_data_T_2[19] ? 5'h3 : _mux_data_T_2[18] ? 5'h4 : _mux_data_T_2[17] ? 5'h5 : _mux_data_T_2[16] ? 5'h6 : _mux_data_T_2[15] ? 5'h7 : _mux_data_T_2[14] ? 5'h8 : _mux_data_T_2[13] ? 5'h9 : _mux_data_T_2[12] ? 5'hA : _mux_data_T_2[11] ? 5'hB : _mux_data_T_2[10] ? 5'hC : _mux_data_T_2[9] ? 5'hD : _mux_data_T_2[8] ? 5'hE : _mux_data_T_2[7] ? 5'hF : _mux_data_T_2[6] ? 5'h10 : _mux_data_T_2[5] ? 5'h11 : _mux_data_T_2[4] ? 5'h12 : _mux_data_T_2[3] ? 5'h13 : _mux_data_T_2[2] ? 5'h14 : _mux_data_T_2[1] ? 5'h15 : 5'h16;
  wire [8:0]   _mux_data_rawIn_adjustedExp_T_9 = (mux_data_rawIn_isZeroExpIn_1 ? {4'hF, ~mux_data_rawIn_normDist_1} : {1'h0, _mux_data_T_2[30:23]}) + {7'h20, mux_data_rawIn_isZeroExpIn_1 ? 2'h2 : 2'h1};
  wire [2:0]   _mux_data_T_13 = mux_data_rawIn_isZeroExpIn_1 & ~(|(_mux_data_T_2[22:0])) ? 3'h0 : _mux_data_rawIn_adjustedExp_T_9[8:6];
  wire [53:0]  _mux_data_rawIn_subnormFract_T_2 = {31'h0, _mux_data_T_2[22:0]} << mux_data_rawIn_normDist_1;
  always @(posedge clock) begin
    if (reset) begin
      in_valid <= 1'h0;
      io_out_pipe_v <= 1'h0;
    end
    else begin
      in_valid <= io_in_valid;
      io_out_pipe_v <= in_valid;
    end
    if (io_in_valid) begin
      in_bits_typeTagIn <= io_in_bits_typeTagIn;
      in_bits_wflags <= io_in_bits_wflags;
      in_bits_rm <= io_in_bits_rm;
      in_bits_typ <= io_in_bits_typ;
      in_bits_in1 <= io_in_bits_in1;
    end
    if (in_valid) begin
      if (in_bits_wflags) begin
        if (in_bits_typeTagIn[0])
          io_out_pipe_b_data <= _GEN;
        else
          io_out_pipe_b_data <= {_GEN[64:33], _i2f_io_out};
        if (in_bits_typeTagIn[0])
          io_out_pipe_b_exc <= _i2f_1_io_exceptionFlags;
        else
          io_out_pipe_b_exc <= _i2f_io_exceptionFlags;
      end
      else begin
        io_out_pipe_b_data <= {_mux_data_T_2[63], _mux_data_T_4[2:1], _GEN_0, (&{_mux_data_T_4[2:1], _GEN_0}) ? {&(_mux_data_rawIn_out_sig_T_2[51:32]), _mux_data_rawIn_adjustedExp_T_4[7:1], _mux_data_T_13[2], _mux_data_rawIn_out_sig_T_2[51:32], _mux_data_T_2[31], _mux_data_T_13[1], _mux_data_T_13[0] | (&(_mux_data_rawIn_adjustedExp_T_9[8:7])) & (|(_mux_data_T_2[22:0])), _mux_data_rawIn_adjustedExp_T_9[5:0], mux_data_rawIn_isZeroExpIn_1 ? {_mux_data_rawIn_subnormFract_T_2[21:0], 1'h0} : _mux_data_T_2[22:0]} : {_mux_data_rawIn_adjustedExp_T_4[8:0], _mux_data_rawIn_out_sig_T_2}};
        io_out_pipe_b_exc <= 5'h0;
      end
    end
  end // always @(posedge)
  INToRecFN i2f (
    .io_signedIn       (~(in_bits_typ[0])),
    .io_in             (intValue_res),
    .io_roundingMode   (in_bits_rm),
    .io_out            (_i2f_io_out),
    .io_exceptionFlags (_i2f_io_exceptionFlags)
  );
  INToRecFN_1 i2f_1 (
    .io_signedIn       (~(in_bits_typ[0])),
    .io_in             (intValue_res),
    .io_roundingMode   (in_bits_rm),
    .io_out            (_i2f_1_io_out),
    .io_exceptionFlags (_i2f_1_io_exceptionFlags)
  );
  assign io_out_valid = io_out_pipe_v;
  assign io_out_bits_data = io_out_pipe_b_data;
  assign io_out_bits_exc = io_out_pipe_b_exc;
endmodule

