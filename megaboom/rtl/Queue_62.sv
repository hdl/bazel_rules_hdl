// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_62(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [2:0]   io_enq_bits_opcode,
                 io_enq_bits_param,
                 io_enq_bits_size,
  input  [5:0]   io_enq_bits_source,
  input  [31:0]  io_enq_bits_address,
  input  [15:0]  io_enq_bits_mask,
  input  [127:0] io_enq_bits_data,
  input          io_enq_bits_corrupt,
                 io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [2:0]   io_deq_bits_opcode,
                 io_deq_bits_param,
                 io_deq_bits_size,
  output [5:0]   io_deq_bits_source,
  output [31:0]  io_deq_bits_address,
  output [15:0]  io_deq_bits_mask,
  output [127:0] io_deq_bits_data,
  output         io_deq_bits_corrupt
);

  reg          full;
  reg          ram_corrupt;
  reg  [127:0] ram_data;
  reg  [15:0]  ram_mask;
  reg  [31:0]  ram_address;
  reg  [5:0]   ram_source;
  reg  [2:0]   ram_size;
  reg  [2:0]   ram_param;
  reg  [2:0]   ram_opcode;
  wire         _io_deq_valid_output = io_enq_valid | full;
  wire         do_enq = ~(~full & io_deq_ready) & ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (full & io_deq_ready & _io_deq_valid_output))
      full <= do_enq;
    if (do_enq) begin
      ram_corrupt <= io_enq_bits_corrupt;
      ram_data <= io_enq_bits_data;
      ram_mask <= io_enq_bits_mask;
      ram_address <= io_enq_bits_address;
      ram_source <= io_enq_bits_source;
      ram_size <= io_enq_bits_size;
      ram_param <= io_enq_bits_param;
      ram_opcode <= io_enq_bits_opcode;
    end
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = _io_deq_valid_output;
  assign io_deq_bits_opcode = full ? ram_opcode : io_enq_bits_opcode;
  assign io_deq_bits_param = full ? ram_param : io_enq_bits_param;
  assign io_deq_bits_size = full ? ram_size : io_enq_bits_size;
  assign io_deq_bits_source = full ? ram_source : io_enq_bits_source;
  assign io_deq_bits_address = full ? ram_address : io_enq_bits_address;
  assign io_deq_bits_mask = full ? ram_mask : io_enq_bits_mask;
  assign io_deq_bits_data = full ? ram_data : io_enq_bits_data;
  assign io_deq_bits_corrupt = full ? ram_corrupt : io_enq_bits_corrupt;
endmodule

