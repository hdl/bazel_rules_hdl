// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ALU(
  input         io_dw,
  input  [3:0]  io_fn,
  input  [63:0] io_in2,
                io_in1,
  output [63:0] io_out
);

  wire [63:0] in2_inv = {64{io_fn[3]}} ^ io_in2;
  wire [63:0] _io_adder_out_T_3 = io_in1 + in2_inv + {63'h0, io_fn[3]};
  wire [31:0] shin_hi = io_dw ? io_in1[63:32] : {32{io_fn[3] & io_in1[31]}};
  wire        _shout_T = io_fn == 4'h5;
  wire        _shout_T_1 = io_fn == 4'hB;
  wire [31:0] _GEN = {io_in1[31:16], 16'h0} | shin_hi & 32'hFFFF;
  wire [31:0] _GEN_0 = {{io_in1[15:0], _GEN[31:24]} & 24'hFF00FF, 8'h0} | _GEN & 32'hFF00FF;
  wire [31:0] _GEN_1 = {{io_in1[7:0], _GEN_0[31:12]} & 28'hF0F0F0F, 4'h0} | _GEN_0 & 32'hF0F0F0F;
  wire [45:0] _GEN_2 = {io_in1[3:0], _GEN_1, _GEN_0[7:4], _GEN[11:8], _GEN[15:14]} & 46'h333333333333;
  wire [31:0] _GEN_3 = _GEN_2[45:14] | _GEN_1 & 32'h33333333;
  wire [1:0]  _GEN_4 = _GEN_2[11:10] | _GEN_0[5:4];
  wire [7:0]  _GEN_5 = {_GEN_2[5:0], 2'h0} | {_GEN[15:12], shin_hi[19:16]} & 8'h33;
  wire [54:0] _GEN_6 = {io_in1[1:0], _GEN_3, _GEN_1[3:2], _GEN_4, _GEN_0[7:6], _GEN[9:8], _GEN_5, shin_hi[19:18], shin_hi[21:20], shin_hi[23]} & 55'h55555555555555;
  wire [63:0] shin = _shout_T | _shout_T_1 ? {shin_hi, io_in1[31:0]} : {io_in1[0], _GEN_6[54:23] | _GEN_3 & 32'h55555555, _GEN_3[1], _GEN_6[21] | _GEN_1[2], {_GEN_1[3], 1'h0} | _GEN_4 & 2'h1, _GEN_6[18:15] | {_GEN_0[7:6], _GEN[9:8]} & 4'h5, _GEN_6[14:7] | _GEN_5 & 8'h55, _GEN_5[1], _GEN_6[5] | shin_hi[18], shin_hi[19], shin_hi[20], {_GEN_6[2:0], 1'h0} | {shin_hi[23:22], shin_hi[25:24]} & 4'h5, shin_hi[25], shin_hi[26], shin_hi[27], shin_hi[28], shin_hi[29], shin_hi[30], shin_hi[31]};
  wire [64:0] _shout_r_T_5 = $signed($signed({io_fn[3] & shin[63], shin}) >>> {59'h0, io_in2[5] & io_dw, io_in2[4:0]});
  wire [15:0] _GEN_7 = {{_shout_r_T_5[23:16], _shout_r_T_5[31:28]} & 12'hF0F, 4'h0} | {_shout_r_T_5[31:24], _shout_r_T_5[39:32]} & 16'hF0F;
  wire [37:0] _GEN_8 = {_shout_r_T_5[11:8], _shout_r_T_5[15:12], _shout_r_T_5[19:16], _GEN_7, _shout_r_T_5[39:36], _shout_r_T_5[43:40], _shout_r_T_5[47:46]} & 38'h3333333333;
  wire [7:0]  _GEN_9 = _GEN_8[37:30] | {_shout_r_T_5[15:12], _shout_r_T_5[19:16]} & 8'h33;
  wire [15:0] _GEN_10 = _GEN_8[29:14] | _GEN_7 & 16'h3333;
  wire [1:0]  _GEN_11 = _GEN_8[11:10] | _shout_r_T_5[37:36];
  wire [7:0]  _GEN_12 = {_GEN_8[5:0], 2'h0} | {_shout_r_T_5[47:44], _shout_r_T_5[51:48]} & 8'h33;
  wire [50:0] _GEN_13 = {_shout_r_T_5[5:4], _shout_r_T_5[7:6], _shout_r_T_5[9:8], _GEN_9, _GEN_10, _GEN_7[3:2], _GEN_11, _shout_r_T_5[39:38], _shout_r_T_5[41:40], _GEN_12, _shout_r_T_5[51:50], _shout_r_T_5[53:52], _shout_r_T_5[55]} & 51'h5555555555555;
  wire        _logic_T_4 = io_fn == 4'h6;
  wire [63:0] out = io_fn == 4'h0 | io_fn == 4'hA ? _io_adder_out_T_3 : {63'h0, io_fn > 4'hB & (io_in1[63] == io_in2[63] ? _io_adder_out_T_3[63] : io_fn[1] ? io_in2[63] : io_in1[63])} | (io_fn == 4'h4 | _logic_T_4 ? io_in1 ^ in2_inv : 64'h0) | (_logic_T_4 | io_fn == 4'h7 ? io_in1 & io_in2 : 64'h0) | (_shout_T | _shout_T_1 ? _shout_r_T_5[63:0] : 64'h0) | (io_fn == 4'h1 ? {_shout_r_T_5[0], _shout_r_T_5[1], _shout_r_T_5[2], _shout_r_T_5[3], _shout_r_T_5[4], _GEN_13[50:47] | {_shout_r_T_5[7:6], _shout_r_T_5[9:8]} & 4'h5, _GEN_13[46:39] | _GEN_9 & 8'h55, _GEN_13[38:23] | _GEN_10 & 16'h5555, _GEN_10[1], _GEN_13[21] | _GEN_7[2], {_GEN_7[3], 1'h0} | _GEN_11 & 2'h1, _GEN_13[18:15] | {_shout_r_T_5[39:38], _shout_r_T_5[41:40]} & 4'h5, _GEN_13[14:7] | _GEN_12 & 8'h55, _GEN_12[1], _GEN_13[5] | _shout_r_T_5[50], _shout_r_T_5[51], _shout_r_T_5[52], {_GEN_13[2:0], 1'h0} | {_shout_r_T_5[55:54], _shout_r_T_5[57:56]} & 4'h5, _shout_r_T_5[57], _shout_r_T_5[58], _shout_r_T_5[59], _shout_r_T_5[60], _shout_r_T_5[61], _shout_r_T_5[62], _shout_r_T_5[63]} : 64'h0);
  assign io_out = io_dw ? out : {{32{out[31]}}, out[31:0]};
endmodule

