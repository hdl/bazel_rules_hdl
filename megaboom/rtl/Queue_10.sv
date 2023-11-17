// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_10(
  input        clock,
               reset,
               io_enq_valid,
  input  [2:0] io_enq_bits_opcode,
  input  [3:0] io_enq_bits_size,
  input  [6:0] io_enq_bits_source,
  input        io_deq_ready,
  output       io_enq_ready,
               io_deq_valid,
  output [2:0] io_deq_bits_opcode,
  output [3:0] io_deq_bits_size,
  output [6:0] io_deq_bits_source
);

  reg        full;
  reg  [6:0] ram_source;
  reg  [3:0] ram_size;
  reg  [2:0] ram_opcode;
  wire       do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_source <= io_enq_bits_source;
      ram_size <= io_enq_bits_size;
      ram_opcode <= io_enq_bits_opcode;
    end
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = full;
  assign io_deq_bits_opcode = ram_opcode;
  assign io_deq_bits_size = ram_size;
  assign io_deq_bits_source = ram_source;
endmodule

