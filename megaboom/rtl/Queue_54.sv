// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Queue_54(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [127:0] io_enq_bits_data,
  input          io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [127:0] io_deq_bits_data
);

  wire [127:0] _ram_data_ext_R0_data;
  reg  [1:0]   enq_ptr_value;
  reg  [1:0]   deq_ptr_value;
  reg          maybe_full;
  wire         ptr_match = enq_ptr_value == deq_ptr_value;
  wire         empty = ptr_match & ~maybe_full;
  wire         full = ptr_match & maybe_full;
  wire         do_enq = ~(empty & io_deq_ready) & ~full & io_enq_valid;
  wire         _io_deq_valid_output = io_enq_valid | ~empty;
  wire         do_deq = ~empty & io_deq_ready & _io_deq_valid_output;
  always @(posedge clock) begin
    if (reset) begin
      enq_ptr_value <= 2'h0;
      deq_ptr_value <= 2'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq) begin
        if (enq_ptr_value == 2'h2)
          enq_ptr_value <= 2'h0;
        else
          enq_ptr_value <= enq_ptr_value + 2'h1;
      end
      if (do_deq) begin
        if (deq_ptr_value == 2'h2)
          deq_ptr_value <= 2'h0;
        else
          deq_ptr_value <= deq_ptr_value + 2'h1;
      end
      if (do_enq != do_deq)
        maybe_full <= do_enq;
    end
  end // always @(posedge)
  ram_data_3x128 ram_data_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data (io_enq_bits_data),
    .R0_data (_ram_data_ext_R0_data)
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = _io_deq_valid_output;
  assign io_deq_bits_data = empty ? io_enq_bits_data : _ram_data_ext_R0_data;
endmodule

