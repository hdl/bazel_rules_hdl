// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_75(
  input         clock,
                reset,
                io_enq_valid,
                io_enq_bits_read,
  input  [22:0] io_enq_bits_index,
  input  [63:0] io_enq_bits_data,
  input  [7:0]  io_enq_bits_mask,
  input  [10:0] io_enq_bits_extra_tlrr_extra_source,
  input  [1:0]  io_enq_bits_extra_tlrr_extra_size,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
                io_deq_bits_read,
  output [22:0] io_deq_bits_index,
  output [63:0] io_deq_bits_data,
  output [7:0]  io_deq_bits_mask,
  output [10:0] io_deq_bits_extra_tlrr_extra_source,
  output [1:0]  io_deq_bits_extra_tlrr_extra_size
);

  reg         full;
  reg  [1:0]  ram_extra_tlrr_extra_size;
  reg  [10:0] ram_extra_tlrr_extra_source;
  reg  [7:0]  ram_mask;
  reg  [63:0] ram_data;
  reg  [22:0] ram_index;
  reg         ram_read;
  wire        do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_extra_tlrr_extra_size <= io_enq_bits_extra_tlrr_extra_size;
      ram_extra_tlrr_extra_source <= io_enq_bits_extra_tlrr_extra_source;
      ram_mask <= io_enq_bits_mask;
      ram_data <= io_enq_bits_data;
      ram_index <= io_enq_bits_index;
      ram_read <= io_enq_bits_read;
    end
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = full;
  assign io_deq_bits_read = ram_read;
  assign io_deq_bits_index = ram_index;
  assign io_deq_bits_data = ram_data;
  assign io_deq_bits_mask = ram_mask;
  assign io_deq_bits_extra_tlrr_extra_source = ram_extra_tlrr_extra_source;
  assign io_deq_bits_extra_tlrr_extra_size = ram_extra_tlrr_extra_size;
endmodule

