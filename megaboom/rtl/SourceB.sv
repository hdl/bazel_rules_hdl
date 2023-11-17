// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SourceB(
  input         clock,
                reset,
                io_req_valid,
  input  [2:0]  io_req_bits_param,
  input  [11:0] io_req_bits_tag,
  input  [9:0]  io_req_bits_set,
  input         io_req_bits_clients,
                io_b_ready,
  output        io_req_ready,
                io_b_valid,
  output [1:0]  io_b_bits_param,
  output [31:0] io_b_bits_address
);

  reg         busy;
  wire        b_valid = busy | io_req_valid;
  reg  [11:0] tag_r;
  reg  [9:0]  set_r;
  reg  [2:0]  param_r;
  wire        _param_T_1 = ~busy & io_req_valid;
  always @(posedge clock) begin
    if (reset)
      busy <= 1'h0;
    else
      busy <= (busy | _param_T_1 & io_req_bits_clients) & ~(io_b_ready & b_valid & (busy ? busy : io_req_bits_clients));
    if (_param_T_1) begin
      tag_r <= io_req_bits_tag;
      set_r <= io_req_bits_set;
      param_r <= io_req_bits_param;
    end
  end // always @(posedge)
  assign io_req_ready = ~busy;
  assign io_b_valid = b_valid;
  assign io_b_bits_param = busy ? param_r[1:0] : io_req_bits_param[1:0];
  assign io_b_bits_address = {4'h0, busy ? tag_r : io_req_bits_tag, busy ? set_r : io_req_bits_set, 6'h0};
endmodule

