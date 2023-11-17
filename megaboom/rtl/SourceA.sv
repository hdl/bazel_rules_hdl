// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SourceA(
  input         clock,
                reset,
                io_req_valid,
  input  [11:0] io_req_bits_tag,
  input  [9:0]  io_req_bits_set,
  input  [2:0]  io_req_bits_param,
  input  [3:0]  io_req_bits_source,
  input         io_req_bits_block,
                io_a_ready,
  output        io_req_ready,
                io_a_valid,
  output [2:0]  io_a_bits_opcode,
                io_a_bits_param,
                io_a_bits_size,
  output [3:0]  io_a_bits_source,
  output [31:0] io_a_bits_address,
  output [7:0]  io_a_bits_mask,
  output [63:0] io_a_bits_data,
  output        io_a_bits_corrupt
);

  Queue_52 io_a_q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (io_req_valid),
    .io_enq_bits_opcode  ({2'h3, ~io_req_bits_block}),
    .io_enq_bits_param   (io_req_bits_param),
    .io_enq_bits_source  (io_req_bits_source),
    .io_enq_bits_address ({4'h0, io_req_bits_tag, io_req_bits_set, 6'h0}),
    .io_deq_ready        (io_a_ready),
    .io_enq_ready        (io_req_ready),
    .io_deq_valid        (io_a_valid),
    .io_deq_bits_opcode  (io_a_bits_opcode),
    .io_deq_bits_param   (io_a_bits_param),
    .io_deq_bits_size    (io_a_bits_size),
    .io_deq_bits_source  (io_a_bits_source),
    .io_deq_bits_address (io_a_bits_address),
    .io_deq_bits_mask    (io_a_bits_mask),
    .io_deq_bits_data    (io_a_bits_data),
    .io_deq_bits_corrupt (io_a_bits_corrupt)
  );
endmodule

