// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module GenericSerializer(
  input         clock,
                reset,
                io_in_valid,
  input  [2:0]  io_in_bits_chanId,
                io_in_bits_opcode,
                io_in_bits_param,
  input  [7:0]  io_in_bits_size,
                io_in_bits_source,
  input  [63:0] io_in_bits_address,
                io_in_bits_data,
  input         io_in_bits_corrupt,
  input  [8:0]  io_in_bits_union,
  input         io_in_bits_last,
                io_out_ready,
  output        io_in_ready,
                io_out_valid,
  output [31:0] io_out_bits
);

  reg  [163:0] data;
  reg          sending;
  reg  [2:0]   sendCount;
  wire         wrap_wrap = sendCount == 3'h5;
  wire         _GEN = io_out_ready & sending;
  wire         _GEN_0 = ~sending & io_in_valid;
  always @(posedge clock) begin
    if (_GEN)
      data <= {32'h0, data[163:32]};
    else if (_GEN_0)
      data <= {io_in_bits_chanId, io_in_bits_opcode, io_in_bits_param, io_in_bits_size, io_in_bits_source, io_in_bits_address, io_in_bits_data, io_in_bits_corrupt, io_in_bits_union, io_in_bits_last};
    if (reset) begin
      sending <= 1'h0;
      sendCount <= 3'h0;
    end
    else begin
      sending <= ~(_GEN & wrap_wrap) & (_GEN_0 | sending);
      if (_GEN) begin
        if (wrap_wrap)
          sendCount <= 3'h0;
        else
          sendCount <= sendCount + 3'h1;
      end
    end
  end // always @(posedge)
  assign io_in_ready = ~sending;
  assign io_out_valid = sending;
  assign io_out_bits = data[31:0];
endmodule

