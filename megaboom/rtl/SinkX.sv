// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SinkX(
  input         clock,
                reset,
                io_req_ready,
                io_x_valid,
  input  [31:0] io_x_bits_address,
  output        io_req_valid,
  output [11:0] io_req_bits_tag,
  output [9:0]  io_req_bits_set,
  output        io_x_ready
);

  wire [31:0] _x_q_io_deq_bits_address;
  Queue_60 x_q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (io_x_valid),
    .io_enq_bits_address (io_x_bits_address),
    .io_deq_ready        (io_req_ready),
    .io_enq_ready        (io_x_ready),
    .io_deq_valid        (io_req_valid),
    .io_deq_bits_address (_x_q_io_deq_bits_address)
  );
  assign io_req_bits_tag = _x_q_io_deq_bits_address[27:16];
  assign io_req_bits_set = _x_q_io_deq_bits_address[15:6];
endmodule

