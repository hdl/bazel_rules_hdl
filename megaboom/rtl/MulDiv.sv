// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module MulDiv(
  input         clock,
                reset,
                io_req_valid,
  input  [3:0]  io_req_bits_fn,
  input         io_req_bits_dw,
  input  [63:0] io_req_bits_in1,
                io_req_bits_in2,
  input         io_kill,
                io_resp_ready,
  output        io_req_ready,
                io_resp_valid,
  output [63:0] io_resp_bits_data
);

  reg  [2:0]   state;
  reg          req_dw;
  reg  [6:0]   count;
  reg          neg_out;
  reg          isHi;
  reg          resHi;
  reg  [64:0]  divisor;
  reg  [129:0] remainder;
  wire [63:0]  result = resHi ? remainder[128:65] : remainder[63:0];
  wire [31:0]  loOut = req_dw | state[0] ? result[31:0] : result[63:32];
  wire         _io_resp_valid_output = state == 3'h6 | (&state);
  wire         _io_req_ready_output = state == 3'h0;
  wire [5:0]   _eOutPos_T =
    {|(remainder[63:32]), (|(remainder[63:32])) ? {|(remainder[63:48]), (|(remainder[63:48])) ? {|(remainder[63:56]), (|(remainder[63:56])) ? {|(remainder[63:60]), (|(remainder[63:60])) ? (remainder[63] ? 2'h3 : remainder[62] ? 2'h2 : {1'h0, remainder[61]}) : remainder[59] ? 2'h3 : remainder[58] ? 2'h2 : {1'h0, remainder[57]}} : {|(remainder[55:52]), (|(remainder[55:52])) ? (remainder[55] ? 2'h3 : remainder[54] ? 2'h2 : {1'h0, remainder[53]}) : remainder[51] ? 2'h3 : remainder[50] ? 2'h2 : {1'h0, remainder[49]}}} : {|(remainder[47:40]), (|(remainder[47:40])) ? {|(remainder[47:44]), (|(remainder[47:44])) ? (remainder[47] ? 2'h3 : remainder[46] ? 2'h2 : {1'h0, remainder[45]}) : remainder[43] ? 2'h3 : remainder[42] ? 2'h2 : {1'h0, remainder[41]}} : {|(remainder[39:36]), (|(remainder[39:36])) ? (remainder[39] ? 2'h3 : remainder[38] ? 2'h2 : {1'h0, remainder[37]}) : remainder[35] ? 2'h3 : remainder[34] ? 2'h2 : {1'h0, remainder[33]}}}} : {|(remainder[31:16]), (|(remainder[31:16])) ? {|(remainder[31:24]), (|(remainder[31:24])) ? {|(remainder[31:28]), (|(remainder[31:28])) ? (remainder[31] ? 2'h3 : remainder[30] ? 2'h2 : {1'h0, remainder[29]}) : remainder[27] ? 2'h3 : remainder[26] ? 2'h2 : {1'h0, remainder[25]}} : {|(remainder[23:20]), (|(remainder[23:20])) ? (remainder[23] ? 2'h3 : remainder[22] ? 2'h2 : {1'h0, remainder[21]}) : remainder[19] ? 2'h3 : remainder[18] ? 2'h2 : {1'h0, remainder[17]}}} : {|(remainder[15:8]), (|(remainder[15:8])) ? {|(remainder[15:12]), (|(remainder[15:12])) ? (remainder[15] ? 2'h3 : remainder[14] ? 2'h2 : {1'h0, remainder[13]}) : remainder[11] ? 2'h3 : remainder[10] ? 2'h2 : {1'h0, remainder[9]}} : {|(remainder[7:4]), (|(remainder[7:4])) ? (remainder[7] ? 2'h3 : remainder[6] ? 2'h2 : {1'h0, remainder[5]}) : remainder[3] ? 2'h3 : remainder[2] ? 2'h2 : {1'h0, remainder[1]}}}}}
    - {|(divisor[63:32]), (|(divisor[63:32])) ? {|(divisor[63:48]), (|(divisor[63:48])) ? {|(divisor[63:56]), (|(divisor[63:56])) ? {|(divisor[63:60]), (|(divisor[63:60])) ? (divisor[63] ? 2'h3 : divisor[62] ? 2'h2 : {1'h0, divisor[61]}) : divisor[59] ? 2'h3 : divisor[58] ? 2'h2 : {1'h0, divisor[57]}} : {|(divisor[55:52]), (|(divisor[55:52])) ? (divisor[55] ? 2'h3 : divisor[54] ? 2'h2 : {1'h0, divisor[53]}) : divisor[51] ? 2'h3 : divisor[50] ? 2'h2 : {1'h0, divisor[49]}}} : {|(divisor[47:40]), (|(divisor[47:40])) ? {|(divisor[47:44]), (|(divisor[47:44])) ? (divisor[47] ? 2'h3 : divisor[46] ? 2'h2 : {1'h0, divisor[45]}) : divisor[43] ? 2'h3 : divisor[42] ? 2'h2 : {1'h0, divisor[41]}} : {|(divisor[39:36]), (|(divisor[39:36])) ? (divisor[39] ? 2'h3 : divisor[38] ? 2'h2 : {1'h0, divisor[37]}) : divisor[35] ? 2'h3 : divisor[34] ? 2'h2 : {1'h0, divisor[33]}}}} : {|(divisor[31:16]), (|(divisor[31:16])) ? {|(divisor[31:24]), (|(divisor[31:24])) ? {|(divisor[31:28]), (|(divisor[31:28])) ? (divisor[31] ? 2'h3 : divisor[30] ? 2'h2 : {1'h0, divisor[29]}) : divisor[27] ? 2'h3 : divisor[26] ? 2'h2 : {1'h0, divisor[25]}} : {|(divisor[23:20]), (|(divisor[23:20])) ? (divisor[23] ? 2'h3 : divisor[22] ? 2'h2 : {1'h0, divisor[21]}) : divisor[19] ? 2'h3 : divisor[18] ? 2'h2 : {1'h0, divisor[17]}}} : {|(divisor[15:8]), (|(divisor[15:8])) ? {|(divisor[15:12]), (|(divisor[15:12])) ? (divisor[15] ? 2'h3 : divisor[14] ? 2'h2 : {1'h0, divisor[13]}) : divisor[11] ? 2'h3 : divisor[10] ? 2'h2 : {1'h0, divisor[9]}} : {|(divisor[7:4]), (|(divisor[7:4])) ? (divisor[7] ? 2'h3 : divisor[6] ? 2'h2 : {1'h0, divisor[5]}) : divisor[3] ? 2'h3 : divisor[2] ? 2'h2 : {1'h0, divisor[1]}}}}};
  wire [65:0]  _prod_T_4 = {{65{remainder[64]}}, remainder[0]} * {divisor[64], divisor} + {remainder[129], remainder[129:65]};
  wire [64:0]  _subtractor_T_1 = remainder[128:64] - divisor;
  wire [6:0]   _count_T_2 = count + 7'h1;
  wire         _eOut_T_9 = count == 7'h0;
  wire         divby0 = _eOut_T_9 & ~(_subtractor_T_1[64]);
  wire         eOut_1 = _eOut_T_9 & ~divby0 & _eOutPos_T != 6'h3F;
  wire [2:0]   decoded_invInputs = ~(io_req_bits_fn[2:0]);
  wire [1:0]   _decoded_T_2 = {decoded_invInputs[1], decoded_invInputs[2]};
  wire         lhs_sign = (|{decoded_invInputs[0], &_decoded_T_2}) & (io_req_bits_dw ? io_req_bits_in1[63] : io_req_bits_in1[31]);
  wire         rhs_sign = (|{&_decoded_T_2, &{decoded_invInputs[0], io_req_bits_fn[2]}}) & (io_req_bits_dw ? io_req_bits_in2[63] : io_req_bits_in2[31]);
  wire         _GEN = state == 3'h1;
  wire         _GEN_0 = state == 3'h5;
  wire         _GEN_1 = state == 3'h2;
  wire         _GEN_2 = _GEN_1 & count == 7'h3F;
  wire         _GEN_3 = state == 3'h3;
  wire         _GEN_4 = count == 7'h40;
  wire         _GEN_5 = _io_req_ready_output & io_req_valid;
  wire [1:0]   _decoded_orMatrixOutputs_T_4 = {&{io_req_bits_fn[0], decoded_invInputs[2]}, io_req_bits_fn[1]};
  always @(posedge clock) begin
    if (reset)
      state <= 3'h0;
    else if (_GEN_5) begin
      if (decoded_invInputs[2])
        state <= 3'h2;
      else
        state <= {1'h0, ~(lhs_sign | rhs_sign), 1'h1};
    end
    else if (io_resp_ready & _io_resp_valid_output | io_kill)
      state <= 3'h0;
    else if (_GEN_3 & _GEN_4)
      state <= {1'h1, ~neg_out, 1'h1};
    else if (_GEN_2)
      state <= 3'h6;
    else if (_GEN_0)
      state <= 3'h7;
    else if (_GEN)
      state <= 3'h3;
    if (_GEN_5) begin
      req_dw <= io_req_bits_dw;
      count <= {1'h0, decoded_invInputs[2] & ~io_req_bits_dw, 5'h0};
      if (|_decoded_orMatrixOutputs_T_4)
        neg_out <= lhs_sign;
      else
        neg_out <= lhs_sign != rhs_sign;
      isHi <= |_decoded_orMatrixOutputs_T_4;
      divisor <= {rhs_sign, io_req_bits_dw ? io_req_bits_in2[63:32] : {32{rhs_sign}}, io_req_bits_in2[31:0]};
      remainder <= {66'h0, io_req_bits_dw ? io_req_bits_in1[63:32] : {32{lhs_sign}}, io_req_bits_in1[31:0]};
    end
    else begin
      if (_GEN_3) begin
        if (eOut_1)
          count <= {1'h0, ~_eOutPos_T};
        else
          count <= _count_T_2;
        remainder <= {1'h0, eOut_1 ? {2'h0, {63'h0, remainder[63:0]} << ~_eOutPos_T} : {_subtractor_T_1[64] ? remainder[127:64] : _subtractor_T_1[63:0], remainder[63:0], ~(_subtractor_T_1[64])}};
      end
      else if (_GEN_1) begin
        count <= _count_T_2;
        remainder <= {_prod_T_4[65:1], count == 7'h3E & neg_out, _prod_T_4[0], remainder[63:1]};
      end
      else if (_GEN_0 | _GEN & remainder[63])
        remainder <= {66'h0, 64'h0 - result};
      neg_out <= ~(_GEN_3 & divby0 & ~isHi) & neg_out;
      if (_GEN & divisor[63])
        divisor <= _subtractor_T_1;
    end
    resHi <= ~_GEN_5 & (_GEN_3 & _GEN_4 | _GEN_2 ? isHi : ~_GEN_0 & resHi);
  end // always @(posedge)
  assign io_req_ready = _io_req_ready_output;
  assign io_resp_valid = _io_resp_valid_output;
  assign io_resp_bits_data = {req_dw ? result[63:32] : {32{loOut[31]}}, loOut};
endmodule

