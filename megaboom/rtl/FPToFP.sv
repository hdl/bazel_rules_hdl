// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FPToFP(
  input         clock,
                reset,
                io_in_valid,
                io_in_bits_ren2,
  input  [1:0]  io_in_bits_typeTagOut,
  input         io_in_bits_wflags,
  input  [2:0]  io_in_bits_rm,
  input  [64:0] io_in_bits_in1,
                io_in_bits_in2,
  input         io_lt,
  output        io_out_valid,
  output [64:0] io_out_bits_data,
  output [4:0]  io_out_bits_exc
);

  wire [32:0] _narrower_io_out;
  wire [4:0]  _narrower_io_exceptionFlags;
  reg         in_valid;
  reg         in_bits_ren2;
  reg  [1:0]  in_bits_typeTagOut;
  reg         in_bits_wflags;
  reg  [2:0]  in_bits_rm;
  reg  [64:0] in_bits_in1;
  reg  [64:0] in_bits_in2;
  reg         io_out_pipe_v;
  reg  [64:0] io_out_pipe_b_data;
  reg  [4:0]  io_out_pipe_b_exc;
  reg         io_out_pipe_pipe_v;
  reg  [64:0] io_out_pipe_pipe_b_data;
  reg  [4:0]  io_out_pipe_pipe_b_exc;
  reg         io_out_pipe_pipe_pipe_v;
  reg  [64:0] io_out_pipe_pipe_pipe_b_data;
  reg  [4:0]  io_out_pipe_pipe_pipe_b_exc;
  wire        signNum = in_bits_rm[1] ? in_bits_in1[64] ^ in_bits_in2[64] : in_bits_rm[0] ^ in_bits_in2[64];
  wire        isNaNOut = (&(in_bits_in1[63:61])) & (&(in_bits_in2[63:61]));
  wire        isLHS = (&(in_bits_in2[63:61])) | in_bits_rm[0] != io_lt & ~(&(in_bits_in1[63:61]));
  wire        _GEN = in_bits_typeTagOut == 2'h0;
  wire        _GEN_0 = in_bits_wflags & ~in_bits_ren2;
  wire [35:0] fsgnjMux_data = _GEN_0 ? ((&(in_bits_in1[63:61])) ? 36'h700400000 : in_bits_in1[64:29]) : in_bits_wflags ? (isNaNOut ? 36'h700400000 : isLHS ? in_bits_in1[64:29] : in_bits_in2[64:29]) : {signNum, in_bits_in1[63:29]};
  wire [8:0]  _mux_data_expOut_commonCase_T = fsgnjMux_data[31:23] - 9'h100;
  always @(posedge clock) begin
    if (reset) begin
      in_valid <= 1'h0;
      io_out_pipe_v <= 1'h0;
      io_out_pipe_pipe_v <= 1'h0;
      io_out_pipe_pipe_pipe_v <= 1'h0;
    end
    else begin
      in_valid <= io_in_valid;
      io_out_pipe_v <= in_valid;
      io_out_pipe_pipe_v <= io_out_pipe_v;
      io_out_pipe_pipe_pipe_v <= io_out_pipe_pipe_v;
    end
    if (io_in_valid) begin
      in_bits_ren2 <= io_in_bits_ren2;
      in_bits_typeTagOut <= io_in_bits_typeTagOut;
      in_bits_wflags <= io_in_bits_wflags;
      in_bits_rm <= io_in_bits_rm;
      in_bits_in1 <= io_in_bits_in1;
      in_bits_in2 <= io_in_bits_in2;
    end
    if (in_valid) begin
      if (_GEN_0) begin
        if (_GEN)
          io_out_pipe_b_data <= {fsgnjMux_data[35:4], _narrower_io_out};
        else if (&(in_bits_in1[63:61]))
          io_out_pipe_b_data <= 65'hE008000000000000;
        else
          io_out_pipe_b_data <= in_bits_in1;
      end
      else if (_GEN)
        io_out_pipe_b_data <= {fsgnjMux_data[35:4], fsgnjMux_data[35], fsgnjMux_data[34:32] == 3'h0 | fsgnjMux_data[34:32] > 3'h5 ? {fsgnjMux_data[34:32], _mux_data_expOut_commonCase_T[5:0]} : _mux_data_expOut_commonCase_T, fsgnjMux_data[22:0]};
      else if (in_bits_wflags) begin
        if (isNaNOut)
          io_out_pipe_b_data <= 65'hE008000000000000;
        else if (isLHS)
          io_out_pipe_b_data <= in_bits_in1;
        else
          io_out_pipe_b_data <= in_bits_in2;
      end
      else
        io_out_pipe_b_data <= {signNum, in_bits_in1[63:0]};
      if (_GEN_0 & _GEN)
        io_out_pipe_b_exc <= _narrower_io_exceptionFlags;
      else if (_GEN_0)
        io_out_pipe_b_exc <= {(&(in_bits_in1[63:61])) & ~(in_bits_in1[51]), 4'h0};
      else if (in_bits_wflags)
        io_out_pipe_b_exc <= {(&(in_bits_in1[63:61])) & ~(in_bits_in1[51]) | (&(in_bits_in2[63:61])) & ~(in_bits_in2[51]), 4'h0};
      else
        io_out_pipe_b_exc <= 5'h0;
    end
    if (io_out_pipe_v) begin
      io_out_pipe_pipe_b_data <= io_out_pipe_b_data;
      io_out_pipe_pipe_b_exc <= io_out_pipe_b_exc;
    end
    if (io_out_pipe_pipe_v) begin
      io_out_pipe_pipe_pipe_b_data <= io_out_pipe_pipe_b_data;
      io_out_pipe_pipe_pipe_b_exc <= io_out_pipe_pipe_b_exc;
    end
  end // always @(posedge)
  RecFNToRecFN narrower (
    .io_in             (in_bits_in1),
    .io_roundingMode   (in_bits_rm),
    .io_detectTininess (1'h1),
    .io_out            (_narrower_io_out),
    .io_exceptionFlags (_narrower_io_exceptionFlags)
  );
  assign io_out_valid = io_out_pipe_pipe_pipe_v;
  assign io_out_bits_data = io_out_pipe_pipe_pipe_b_data;
  assign io_out_bits_exc = io_out_pipe_pipe_pipe_b_exc;
endmodule

