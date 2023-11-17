// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_13(
  input         clock,
                reset,
                io_enq_valid,
  input  [2:0]  io_enq_bits_opcode,
                io_enq_bits_param,
  input  [1:0]  io_enq_bits_size,
  input  [10:0] io_enq_bits_source,
  input  [25:0] io_enq_bits_address,
  input  [7:0]  io_enq_bits_mask,
  input  [63:0] io_enq_bits_data,
  input         io_enq_bits_corrupt,
                io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
                io_deq_bits_param,
  output [1:0]  io_deq_bits_size,
  output [10:0] io_deq_bits_source,
  output [25:0] io_deq_bits_address,
  output [7:0]  io_deq_bits_mask,
  output [63:0] io_deq_bits_data,
  output        io_deq_bits_corrupt
);

  reg         full;
  reg         ram_corrupt;
  reg  [63:0] ram_data;
  reg  [7:0]  ram_mask;
  reg  [25:0] ram_address;
  reg  [10:0] ram_source;
  reg  [1:0]  ram_size;
  reg  [2:0]  ram_param;
  reg  [2:0]  ram_opcode;
  wire        do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
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
  assign io_deq_valid = full;
  assign io_deq_bits_opcode = ram_opcode;
  assign io_deq_bits_param = ram_param;
  assign io_deq_bits_size = ram_size;
  assign io_deq_bits_source = ram_source;
  assign io_deq_bits_address = ram_address;
  assign io_deq_bits_mask = ram_mask;
  assign io_deq_bits_data = ram_data;
  assign io_deq_bits_corrupt = ram_corrupt;
endmodule

