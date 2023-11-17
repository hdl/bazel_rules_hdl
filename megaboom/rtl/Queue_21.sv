// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_21(
  input        clock,
               reset,
               io_enq_valid,
  input  [3:0] io_enq_bits_tl_state_size,
  input  [4:0] io_enq_bits_tl_state_source,
  input        io_enq_bits_extra_id,
               io_deq_ready,
  output       io_enq_ready,
               io_deq_valid,
  output [3:0] io_deq_bits_tl_state_size,
  output [4:0] io_deq_bits_tl_state_source,
  output       io_deq_bits_extra_id
);

  reg        full;
  reg        ram_extra_id;
  reg  [4:0] ram_tl_state_source;
  reg  [3:0] ram_tl_state_size;
  wire       do_enq = ~full & io_enq_valid;
  always @(posedge clock) begin
    if (reset)
      full <= 1'h0;
    else if (do_enq != (io_deq_ready & full))
      full <= do_enq;
    if (do_enq) begin
      ram_extra_id <= io_enq_bits_extra_id;
      ram_tl_state_source <= io_enq_bits_tl_state_source;
      ram_tl_state_size <= io_enq_bits_tl_state_size;
    end
  end // always @(posedge)
  assign io_enq_ready = ~full;
  assign io_deq_valid = full;
  assign io_deq_bits_tl_state_size = ram_tl_state_size;
  assign io_deq_bits_tl_state_source = ram_tl_state_source;
  assign io_deq_bits_extra_id = ram_extra_id;
endmodule

