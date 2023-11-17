// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_60(
  input         clock,
                reset,
                io_enq_valid,
  input  [31:0] io_enq_bits_address,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [31:0] io_deq_bits_address
);

  reg         full;
  reg  [31:0] ram_address;
  wire        do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq)
      ram_address <= io_enq_bits_address;
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = full;
  assign io_deq_bits_address = ram_address;
endmodule

