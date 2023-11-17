// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncQueueSink_4(
  input        clock,
               reset,
               io_async_mem_0_resumereq,
  input  [9:0] io_async_mem_0_hartsel,
  input        io_async_mem_0_ackhavereset,
               io_async_mem_0_hasel,
               io_async_mem_0_hamask_0,
               io_async_mem_0_hrmask_0,
               io_async_widx,
               io_async_safe_widx_valid,
               io_async_safe_source_reset_n,
  output       io_deq_valid,
               io_deq_bits_resumereq,
  output [9:0] io_deq_bits_hartsel,
  output       io_deq_bits_ackhavereset,
               io_deq_bits_hrmask_0,
               io_async_ridx,
               io_async_safe_ridx_valid,
               io_async_safe_sink_reset_n
);

  wire        _io_deq_valid_output;
  wire        _source_valid_io_out;
  wire        _source_extend_io_out;
  wire        _sink_valid_0_io_out;
  wire [14:0] _io_deq_bits_deq_bits_reg_io_q;
  wire        _widx_widx_gray_io_q;
  reg         ridx_ridx_bin;
  wire        ridx = _source_valid_io_out & ridx_ridx_bin + _io_deq_valid_output;
  wire        valid = _source_valid_io_out & ridx != _widx_widx_gray_io_q;
  reg         valid_reg;
  assign _io_deq_valid_output = valid_reg & _source_valid_io_out;
  reg         ridx_gray;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      ridx_ridx_bin <= 1'h0;
      valid_reg <= 1'h0;
      ridx_gray <= 1'h0;
    end
    else begin
      ridx_ridx_bin <= ridx;
      valid_reg <= valid;
      ridx_gray <= ridx;
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (reset) begin
        ridx_ridx_bin = 1'h0;
        valid_reg = 1'h0;
        ridx_gray = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  AsyncResetSynchronizerShiftReg_w1_d3_i0 widx_widx_gray (
    .clock (clock),
    .reset (reset),
    .io_d  (io_async_widx),
    .io_q  (_widx_widx_gray_io_q)
  );
  ClockCrossingReg_w15 io_deq_bits_deq_bits_reg (
    .clock (clock),
    .io_d  ({io_async_mem_0_resumereq, io_async_mem_0_hartsel, io_async_mem_0_ackhavereset, io_async_mem_0_hasel, io_async_mem_0_hamask_0, io_async_mem_0_hrmask_0}),
    .io_en (valid),
    .io_q  (_io_deq_bits_deq_bits_reg_io_q)
  );
  AsyncValidSync sink_valid_0 (
    .io_in  (1'h1),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n),
    .io_out (_sink_valid_0_io_out)
  );
  AsyncValidSync sink_valid_1 (
    .io_in  (_sink_valid_0_io_out),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n),
    .io_out (io_async_safe_ridx_valid)
  );
  AsyncValidSync source_extend (
    .io_in  (io_async_safe_widx_valid),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n),
    .io_out (_source_extend_io_out)
  );
  AsyncValidSync source_valid (
    .io_in  (_source_extend_io_out),
    .clock  (clock),
    .reset  (reset),
    .io_out (_source_valid_io_out)
  );
  assign io_deq_valid = _io_deq_valid_output;
  assign io_deq_bits_resumereq = _io_deq_bits_deq_bits_reg_io_q[14];
  assign io_deq_bits_hartsel = _io_deq_bits_deq_bits_reg_io_q[13:4];
  assign io_deq_bits_ackhavereset = _io_deq_bits_deq_bits_reg_io_q[3];
  assign io_deq_bits_hrmask_0 = _io_deq_bits_deq_bits_reg_io_q[0];
  assign io_async_ridx = ridx_gray;
  assign io_async_safe_sink_reset_n = ~reset;
endmodule

