// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_61(
  input         clock,
                reset,
                io_enq_valid,
  input  [9:0]  io_enq_bits_set,
  input  [2:0]  io_enq_bits_way,
  input         io_enq_bits_data_dirty,
  input  [1:0]  io_enq_bits_data_state,
  input         io_enq_bits_data_clients,
  input  [11:0] io_enq_bits_data_tag,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [9:0]  io_deq_bits_set,
  output [2:0]  io_deq_bits_way,
  output        io_deq_bits_data_dirty,
  output [1:0]  io_deq_bits_data_state,
  output        io_deq_bits_data_clients,
  output [11:0] io_deq_bits_data_tag
);

  reg         full;
  reg  [11:0] ram_data_tag;
  reg         ram_data_clients;
  reg  [1:0]  ram_data_state;
  reg         ram_data_dirty;
  reg  [2:0]  ram_way;
  reg  [9:0]  ram_set;
  wire        do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_data_tag <= io_enq_bits_data_tag;
      ram_data_clients <= io_enq_bits_data_clients;
      ram_data_state <= io_enq_bits_data_state;
      ram_data_dirty <= io_enq_bits_data_dirty;
      ram_way <= io_enq_bits_way;
      ram_set <= io_enq_bits_set;
    end
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = full;
  assign io_deq_bits_set = ram_set;
  assign io_deq_bits_way = ram_way;
  assign io_deq_bits_data_dirty = ram_data_dirty;
  assign io_deq_bits_data_state = ram_data_state;
  assign io_deq_bits_data_clients = ram_data_clients;
  assign io_deq_bits_data_tag = ram_data_tag;
endmodule

