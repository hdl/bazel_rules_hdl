// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module FPUFMAPipe(
  input         clock,
                reset,
                io_in_valid,
                io_in_bits_ren3,
                io_in_bits_swap23,
  input  [2:0]  io_in_bits_rm,
  input  [1:0]  io_in_bits_fmaCmd,
  input  [64:0] io_in_bits_in1,
                io_in_bits_in2,
                io_in_bits_in3,
  output        io_out_valid,
  output [64:0] io_out_bits_data,
  output [4:0]  io_out_bits_exc
);

  wire [64:0] _fma_io_out;
  wire [4:0]  _fma_io_exceptionFlags;
  wire        _fma_io_validout;
  reg         valid;
  reg  [2:0]  in_rm;
  reg  [1:0]  in_fmaCmd;
  reg  [64:0] in_in1;
  reg  [64:0] in_in2;
  reg  [64:0] in_in3;
  reg         io_out_pipe_v;
  reg  [64:0] io_out_pipe_b_data;
  reg  [4:0]  io_out_pipe_b_exc;
  always @(posedge clock) begin
    valid <= io_in_valid;
    if (io_in_valid) begin
      in_rm <= io_in_bits_rm;
      in_fmaCmd <= io_in_bits_fmaCmd;
      in_in1 <= io_in_bits_in1;
      if (io_in_bits_swap23)
        in_in2 <= 65'h8000000000000000;
      else
        in_in2 <= io_in_bits_in2;
      if (io_in_bits_ren3 | io_in_bits_swap23)
        in_in3 <= io_in_bits_in3;
      else
        in_in3 <= (io_in_bits_in1 ^ io_in_bits_in2) & 65'h10000000000000000;
    end
    if (_fma_io_validout) begin
      io_out_pipe_b_data <= ({65{_fma_io_out[63:61] != 3'h7}} | 65'h1EFEFFFFFFFFFFFFF) & _fma_io_out;
      io_out_pipe_b_exc <= _fma_io_exceptionFlags;
    end
    if (reset)
      io_out_pipe_v <= 1'h0;
    else
      io_out_pipe_v <= _fma_io_validout;
  end // always @(posedge)
  MulAddRecFNPipe fma (
    .clock             (clock),
    .reset             (reset),
    .io_validin        (valid),
    .io_op             (in_fmaCmd),
    .io_a              (in_in1),
    .io_b              (in_in2),
    .io_c              (in_in3),
    .io_roundingMode   (in_rm),
    .io_out            (_fma_io_out),
    .io_exceptionFlags (_fma_io_exceptionFlags),
    .io_validout       (_fma_io_validout)
  );
  assign io_out_valid = io_out_pipe_v;
  assign io_out_bits_data = io_out_pipe_b_data;
  assign io_out_bits_exc = io_out_pipe_b_exc;
endmodule

