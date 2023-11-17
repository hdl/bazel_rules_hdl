// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_14(
  input         clock,
                reset,
                io_enq_valid,
  input  [2:0]  io_enq_bits_opcode,
  input  [1:0]  io_enq_bits_size,
  input  [10:0] io_enq_bits_source,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
  output [1:0]  io_deq_bits_param,
                io_deq_bits_size,
  output [10:0] io_deq_bits_source,
  output        io_deq_bits_sink,
                io_deq_bits_denied,
  output [63:0] io_deq_bits_data,
  output        io_deq_bits_corrupt
);

  reg         full;
  reg         ram_corrupt;
  reg  [63:0] ram_data;
  reg         ram_denied;
  reg         ram_sink;
  reg  [10:0] ram_source;
  reg  [1:0]  ram_size;
  reg  [1:0]  ram_param;
  reg  [2:0]  ram_opcode;
  wire        do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    ram_corrupt <= ~do_enq & ram_corrupt;
    if (do_enq) begin
      ram_data <= io_enq_bits_data;
      ram_source <= io_enq_bits_source;
      ram_size <= io_enq_bits_size;
      ram_param <= 2'h0;
      ram_opcode <= io_enq_bits_opcode;
    end
    ram_denied <= ~do_enq & ram_denied;
    ram_sink <= ~do_enq & ram_sink;
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = full;
  assign io_deq_bits_opcode = ram_opcode;
  assign io_deq_bits_param = ram_param;
  assign io_deq_bits_size = ram_size;
  assign io_deq_bits_source = ram_source;
  assign io_deq_bits_sink = ram_sink;
  assign io_deq_bits_denied = ram_denied;
  assign io_deq_bits_data = ram_data;
  assign io_deq_bits_corrupt = ram_corrupt;
endmodule

