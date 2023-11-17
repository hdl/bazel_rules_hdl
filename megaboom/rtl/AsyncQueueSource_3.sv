// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncQueueSource_3(
  input        clock,
               reset,
               io_enq_valid,
               io_enq_bits_resumereq,
               io_enq_bits_ackhavereset,
               io_enq_bits_hrmask_0,
               io_async_ridx,
               io_async_safe_ridx_valid,
               io_async_safe_sink_reset_n,
  output       io_enq_ready,
               io_async_mem_0_resumereq,
  output [9:0] io_async_mem_0_hartsel,
  output       io_async_mem_0_ackhavereset,
               io_async_mem_0_hasel,
               io_async_mem_0_hamask_0,
               io_async_mem_0_hrmask_0,
               io_async_widx,
               io_async_safe_widx_valid,
               io_async_safe_source_reset_n
);

  wire       _io_enq_ready_output;
  wire       _sink_valid_io_out;
  wire       _sink_extend_io_out;
  wire       _source_valid_0_io_out;
  wire       _ridx_ridx_gray_io_q;
  reg        mem_0_resumereq;
  reg  [9:0] mem_0_hartsel;
  reg        mem_0_ackhavereset;
  reg        mem_0_hasel;
  reg        mem_0_hamask_0;
  reg        mem_0_hrmask_0;
  wire       _widx_T_1 = _io_enq_ready_output & io_enq_valid;
  reg        widx_widx_bin;
  reg        ready_reg;
  assign _io_enq_ready_output = ready_reg & _sink_valid_io_out;
  reg        widx_gray;
  always @(posedge clock) begin
    if (_widx_T_1) begin
      mem_0_resumereq <= io_enq_bits_resumereq;
      mem_0_hartsel <= 10'h0;
      mem_0_ackhavereset <= io_enq_bits_ackhavereset;
      mem_0_hrmask_0 <= io_enq_bits_hrmask_0;
    end
    mem_0_hasel <= ~_widx_T_1 & mem_0_hasel;
    mem_0_hamask_0 <= ~_widx_T_1 & mem_0_hamask_0;
  end // always @(posedge)
  wire       widx = _sink_valid_io_out & widx_widx_bin + _widx_T_1;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      widx_widx_bin <= 1'h0;
      ready_reg <= 1'h0;
      widx_gray <= 1'h0;
    end
    else begin
      widx_widx_bin <= widx;
      ready_reg <= _sink_valid_io_out & widx != ~_ridx_ridx_gray_io_q;
      widx_gray <= widx;
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      if (reset) begin
        widx_widx_bin = 1'h0;
        ready_reg = 1'h0;
        widx_gray = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  AsyncResetSynchronizerShiftReg_w1_d3_i0 ridx_ridx_gray (
    .clock (clock),
    .reset (reset),
    .io_d  (io_async_ridx),
    .io_q  (_ridx_ridx_gray_io_q)
  );
  AsyncValidSync source_valid_0 (
    .io_in  (1'h1),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_sink_reset_n),
    .io_out (_source_valid_0_io_out)
  );
  AsyncValidSync source_valid_1 (
    .io_in  (_source_valid_0_io_out),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_sink_reset_n),
    .io_out (io_async_safe_widx_valid)
  );
  AsyncValidSync sink_extend (
    .io_in  (io_async_safe_ridx_valid),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_sink_reset_n),
    .io_out (_sink_extend_io_out)
  );
  AsyncValidSync sink_valid (
    .io_in  (_sink_extend_io_out),
    .clock  (clock),
    .reset  (reset),
    .io_out (_sink_valid_io_out)
  );
  assign io_enq_ready = _io_enq_ready_output;
  assign io_async_mem_0_resumereq = mem_0_resumereq;
  assign io_async_mem_0_hartsel = mem_0_hartsel;
  assign io_async_mem_0_ackhavereset = mem_0_ackhavereset;
  assign io_async_mem_0_hasel = mem_0_hasel;
  assign io_async_mem_0_hamask_0 = mem_0_hamask_0;
  assign io_async_mem_0_hrmask_0 = mem_0_hrmask_0;
  assign io_async_widx = widx_gray;
  assign io_async_safe_source_reset_n = ~reset;
endmodule

