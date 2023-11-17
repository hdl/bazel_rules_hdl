// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module GenericDeserializer(
  input         clock,
                reset,
                io_in_valid,
  input  [31:0] io_in_bits,
  input         io_out_ready,
  output        io_in_ready,
                io_out_valid,
  output [2:0]  io_out_bits_chanId,
                io_out_bits_opcode,
                io_out_bits_param,
  output [7:0]  io_out_bits_size,
                io_out_bits_source,
  output [63:0] io_out_bits_address,
                io_out_bits_data,
  output        io_out_bits_corrupt,
  output [8:0]  io_out_bits_union
);

  reg  [31:0] data_0;
  reg  [31:0] data_1;
  reg  [31:0] data_2;
  reg  [31:0] data_3;
  reg  [31:0] data_4;
  reg  [31:0] data_5;
  reg         receiving;
  reg  [2:0]  recvCount;
  wire        wrap_wrap = recvCount == 3'h5;
  wire        _GEN = receiving & io_in_valid;
  always @(posedge clock) begin
    if (_GEN & recvCount == 3'h0)
      data_0 <= io_in_bits;
    if (_GEN & recvCount == 3'h1)
      data_1 <= io_in_bits;
    if (_GEN & recvCount == 3'h2)
      data_2 <= io_in_bits;
    if (_GEN & recvCount == 3'h3)
      data_3 <= io_in_bits;
    if (_GEN & recvCount == 3'h4)
      data_4 <= io_in_bits;
    if (_GEN & recvCount == 3'h5)
      data_5 <= io_in_bits;
    if (reset) begin
      receiving <= 1'h1;
      recvCount <= 3'h0;
    end
    else begin
      receiving <= io_out_ready & ~receiving | ~(_GEN & wrap_wrap) & receiving;
      if (_GEN) begin
        if (wrap_wrap)
          recvCount <= 3'h0;
        else
          recvCount <= recvCount + 3'h1;
      end
    end
  end // always @(posedge)
  assign io_in_ready = receiving;
  assign io_out_valid = ~receiving;
  assign io_out_bits_chanId = data_5[3:1];
  assign io_out_bits_opcode = {data_5[0], data_4[31:30]};
  assign io_out_bits_param = data_4[29:27];
  assign io_out_bits_size = data_4[26:19];
  assign io_out_bits_source = data_4[18:11];
  assign io_out_bits_address = {data_4[10:0], data_3, data_2[31:11]};
  assign io_out_bits_data = {data_2[10:0], data_1, data_0[31:11]};
  assign io_out_bits_corrupt = data_0[10];
  assign io_out_bits_union = data_0[9:1];
endmodule

