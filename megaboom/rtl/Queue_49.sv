// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_49(
  input         clock,
                reset,
                io_enq_valid,
  input  [63:0] io_enq_bits_data,
  input  [7:0]  io_enq_bits_strb,
  input         io_enq_bits_last,
                io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [63:0] io_deq_bits_data,
  output [7:0]  io_deq_bits_strb,
  output        io_deq_bits_last
);

  reg         full;
  reg         ram_last;
  reg  [7:0]  ram_strb;
  reg  [63:0] ram_data;
  wire        _io_enq_ready_output = io_deq_ready | ~full;
  wire        do_enq = _io_enq_ready_output & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_last <= io_enq_bits_last;
      ram_strb <= io_enq_bits_strb;
      ram_data <= io_enq_bits_data;
    end
  end // always @(posedge)
  assign io_enq_ready = _io_enq_ready_output;
  assign io_deq_valid = full;
  assign io_deq_bits_data = ram_data;
  assign io_deq_bits_strb = ram_strb;
  assign io_deq_bits_last = ram_last;
endmodule

