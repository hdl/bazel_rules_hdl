// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module PipelinedMultiplier(
  input         clock,
                reset,
                io_req_valid,
  input  [3:0]  io_req_bits_fn,
  input         io_req_bits_dw,
  input  [63:0] io_req_bits_in1,
                io_req_bits_in2,
  output [63:0] io_resp_bits_data
);

  reg          in_valid;
  reg  [3:0]   in_bits_fn;
  reg          in_bits_dw;
  reg  [63:0]  in_bits_in1;
  reg  [63:0]  in_bits_in2;
  reg          io_resp_bits_data_pipe_v;
  reg  [63:0]  io_resp_bits_data_pipe_b;
  reg  [63:0]  io_resp_bits_data_pipe_pipe_b;
  wire [1:0]   decoded_invInputs = ~(in_bits_fn[1:0]);
  wire [127:0] prod = {{64{(|{decoded_invInputs[1], &{decoded_invInputs[0], in_bits_fn[1]}}) & in_bits_in1[63]}}, in_bits_in1} * {{64{decoded_invInputs[1] & in_bits_in2[63]}}, in_bits_in2};
  always @(posedge clock) begin
    if (reset) begin
      in_valid <= 1'h0;
      io_resp_bits_data_pipe_v <= 1'h0;
    end
    else begin
      in_valid <= io_req_valid;
      io_resp_bits_data_pipe_v <= in_valid;
    end
    if (io_req_valid) begin
      in_bits_fn <= io_req_bits_fn;
      in_bits_dw <= io_req_bits_dw;
      in_bits_in1 <= io_req_bits_in1;
      in_bits_in2 <= io_req_bits_in2;
    end
    if (in_valid) begin
      if (|{in_bits_fn[0], in_bits_fn[1]})
        io_resp_bits_data_pipe_b <= prod[127:64];
      else if (in_bits_dw)
        io_resp_bits_data_pipe_b <= prod[63:0];
      else
        io_resp_bits_data_pipe_b <= {{32{prod[31]}}, prod[31:0]};
    end
    if (io_resp_bits_data_pipe_v)
      io_resp_bits_data_pipe_pipe_b <= io_resp_bits_data_pipe_b;
  end // always @(posedge)
  assign io_resp_bits_data = io_resp_bits_data_pipe_pipe_b;
endmodule

