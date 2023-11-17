// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Repeater(
  input          clock,
                 reset,
                 io_repeat,
                 io_enq_valid,
  input  [2:0]   io_enq_bits_opcode,
                 io_enq_bits_param,
  input  [3:0]   io_enq_bits_size,
  input  [5:0]   io_enq_bits_source,
  input  [28:0]  io_enq_bits_address,
  input  [15:0]  io_enq_bits_mask,
  input  [127:0] io_enq_bits_data,
  input          io_enq_bits_corrupt,
                 io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [2:0]   io_deq_bits_opcode,
                 io_deq_bits_param,
  output [3:0]   io_deq_bits_size,
  output [5:0]   io_deq_bits_source,
  output [28:0]  io_deq_bits_address,
  output [15:0]  io_deq_bits_mask,
  output [127:0] io_deq_bits_data,
  output         io_deq_bits_corrupt
);

  reg          full;
  reg  [2:0]   saved_opcode;
  reg  [2:0]   saved_param;
  reg  [3:0]   saved_size;
  reg  [5:0]   saved_source;
  reg  [28:0]  saved_address;
  reg  [15:0]  saved_mask;
  reg  [127:0] saved_data;
  reg          saved_corrupt;
  wire         _io_deq_valid_output = io_enq_valid | full;
  wire         _io_enq_ready_output = io_deq_ready & ~full;
  wire         _GEN = _io_enq_ready_output & io_enq_valid & io_repeat;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else
      full <= ~(io_deq_ready & _io_deq_valid_output & ~io_repeat) & (_GEN | full);
    if (_GEN) begin
      saved_opcode <= io_enq_bits_opcode;
      saved_param <= io_enq_bits_param;
      saved_size <= io_enq_bits_size;
      saved_source <= io_enq_bits_source;
      saved_address <= io_enq_bits_address;
      saved_mask <= io_enq_bits_mask;
      saved_data <= io_enq_bits_data;
      saved_corrupt <= io_enq_bits_corrupt;
    end
  end // always @(posedge)
  assign io_enq_ready = _io_enq_ready_output;
  assign io_deq_valid = _io_deq_valid_output;
  assign io_deq_bits_opcode = full ? saved_opcode : io_enq_bits_opcode;
  assign io_deq_bits_param = full ? saved_param : io_enq_bits_param;
  assign io_deq_bits_size = full ? saved_size : io_enq_bits_size;
  assign io_deq_bits_source = full ? saved_source : io_enq_bits_source;
  assign io_deq_bits_address = full ? saved_address : io_enq_bits_address;
  assign io_deq_bits_mask = full ? saved_mask : io_enq_bits_mask;
  assign io_deq_bits_data = full ? saved_data : io_enq_bits_data;
  assign io_deq_bits_corrupt = full ? saved_corrupt : io_enq_bits_corrupt;
endmodule

