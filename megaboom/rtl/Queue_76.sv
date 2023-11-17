// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_76(
  input        clock,
               reset,
               io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_enq_ready,
               io_deq_valid,
  output [7:0] io_deq_bits,
  output [8:0] io_count
);

  reg  [7:0] enq_ptr_value;
  reg  [7:0] deq_ptr_value;
  reg        maybe_full;
  wire       ptr_match = enq_ptr_value == deq_ptr_value;
  wire       empty = ptr_match & ~maybe_full;
  wire       full = ptr_match & maybe_full;
  wire       do_enq = ~full & io_enq_valid;
  wire       do_deq = io_deq_ready & ~empty;
  always @(posedge clock) begin
    if (reset) begin
      enq_ptr_value <= 8'h0;
      deq_ptr_value <= 8'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        enq_ptr_value <= enq_ptr_value + 8'h1;
      if (do_deq)
        deq_ptr_value <= deq_ptr_value + 8'h1;
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_256x8 ram_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits),
    .R0_data (io_deq_bits)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~empty;
  assign io_count = {maybe_full & ptr_match, enq_ptr_value - deq_ptr_value};
endmodule

