// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module HellaPeekingArbiter(
  input         clock,
                reset,
                io_in_0_bits_last,
                io_in_1_valid,
  input  [2:0]  io_in_1_bits_opcode,
                io_in_1_bits_param,
  input  [7:0]  io_in_1_bits_size,
                io_in_1_bits_source,
  input  [63:0] io_in_1_bits_data,
  input         io_in_1_bits_corrupt,
  input  [8:0]  io_in_1_bits_union,
  input         io_in_1_bits_last,
                io_in_2_bits_last,
                io_in_3_bits_last,
                io_in_4_valid,
  input  [2:0]  io_in_4_bits_opcode,
                io_in_4_bits_param,
  input  [7:0]  io_in_4_bits_size,
                io_in_4_bits_source,
  input  [63:0] io_in_4_bits_address,
                io_in_4_bits_data,
  input         io_in_4_bits_corrupt,
  input  [8:0]  io_in_4_bits_union,
  input         io_in_4_bits_last,
                io_out_ready,
  output        io_in_1_ready,
                io_in_4_ready,
                io_out_valid,
  output [2:0]  io_out_bits_chanId,
                io_out_bits_opcode,
                io_out_bits_param,
  output [7:0]  io_out_bits_size,
                io_out_bits_source,
  output [63:0] io_out_bits_address,
                io_out_bits_data,
  output        io_out_bits_corrupt,
  output [8:0]  io_out_bits_union,
  output        io_out_bits_last
);

  reg  [2:0] lockIdx;
  reg        locked;
  wire [2:0] chosen = locked ? lockIdx : io_in_1_valid ? 3'h1 : 3'h4;
  wire       _GEN = chosen == 3'h1;
  wire       _GEN_0 = chosen == 3'h2;
  wire       _GEN_1 = chosen == 3'h3;
  wire       _GEN_2 = _GEN_1 | _GEN_0;
  wire       _GEN_3 = chosen == 3'h4;
  wire       _io_out_valid_output = _GEN_3 ? io_in_4_valid : ~_GEN_2 & _GEN & io_in_1_valid;
  wire       _GEN_4 = _GEN_2 | ~_GEN;
  wire       _io_out_bits_last_output = _GEN_3 ? io_in_4_bits_last : _GEN_1 ? io_in_3_bits_last : _GEN_0 ? io_in_2_bits_last : _GEN ? io_in_1_bits_last : io_in_0_bits_last;
  wire       _GEN_5 = io_out_ready & _io_out_valid_output;
  always @(posedge clock) begin
    if (reset) begin
      lockIdx <= 3'h0;
      locked <= 1'h0;
    end
    else begin
      if (_GEN_5 & ~locked) begin
        if (io_in_1_valid)
          lockIdx <= 3'h1;
        else
          lockIdx <= 3'h4;
      end
      if (_GEN_5)
        locked <= ~_io_out_bits_last_output;
    end
  end // always @(posedge)
  assign io_in_1_ready = io_out_ready & chosen == 3'h1;
  assign io_in_4_ready = io_out_ready & chosen == 3'h4;
  assign io_out_valid = _io_out_valid_output;
  assign io_out_bits_chanId = _GEN_3 ? 3'h0 : _GEN_1 ? 3'h1 : _GEN_0 ? 3'h2 : _GEN ? 3'h3 : 3'h4;
  assign io_out_bits_opcode = _GEN_3 ? io_in_4_bits_opcode : _GEN_4 ? 3'h0 : io_in_1_bits_opcode;
  assign io_out_bits_param = _GEN_3 ? io_in_4_bits_param : _GEN_4 ? 3'h0 : io_in_1_bits_param;
  assign io_out_bits_size = _GEN_3 ? io_in_4_bits_size : _GEN_4 ? 8'h0 : io_in_1_bits_size;
  assign io_out_bits_source = _GEN_3 ? io_in_4_bits_source : _GEN_4 ? 8'h0 : io_in_1_bits_source;
  assign io_out_bits_address = _GEN_3 ? io_in_4_bits_address : 64'h0;
  assign io_out_bits_data = _GEN_3 ? io_in_4_bits_data : _GEN_4 ? 64'h0 : io_in_1_bits_data;
  assign io_out_bits_corrupt = _GEN_3 ? io_in_4_bits_corrupt : ~_GEN_2 & _GEN & io_in_1_bits_corrupt;
  assign io_out_bits_union = _GEN_3 ? io_in_4_bits_union : _GEN_4 ? 9'h0 : io_in_1_bits_union;
  assign io_out_bits_last = _io_out_bits_last_output;
endmodule

