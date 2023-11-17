// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncQueueSink_3(
  input         clock,
                reset,
                io_deq_ready,
  input  [2:0]  io_async_mem_0_opcode,
                io_async_mem_0_param,
  input  [1:0]  io_async_mem_0_size,
  input         io_async_mem_0_source,
  input  [8:0]  io_async_mem_0_address,
  input  [3:0]  io_async_mem_0_mask,
  input  [31:0] io_async_mem_0_data,
  input         io_async_mem_0_corrupt,
                io_async_widx,
                io_async_safe_widx_valid,
                io_async_safe_source_reset_n,
  output        io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
                io_deq_bits_param,
  output [1:0]  io_deq_bits_size,
  output        io_deq_bits_source,
  output [8:0]  io_deq_bits_address,
  output [3:0]  io_deq_bits_mask,
  output [31:0] io_deq_bits_data,
  output        io_deq_bits_corrupt,
                io_async_ridx,
                io_async_safe_ridx_valid,
                io_async_safe_sink_reset_n
);

  wire        _io_deq_valid_output;
  wire        _source_valid_io_out;
  wire        _source_extend_io_out;
  wire        _sink_valid_0_io_out;
  wire [54:0] _io_deq_bits_deq_bits_reg_io_q;
  wire        _widx_widx_gray_io_q;
  reg         ridx_ridx_bin;
  wire        ridx = _source_valid_io_out & ridx_ridx_bin + (io_deq_ready & _io_deq_valid_output);
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
  ClockCrossingReg_w55 io_deq_bits_deq_bits_reg (
    .clock (clock),
    .io_d  ({io_async_mem_0_opcode, io_async_mem_0_param, io_async_mem_0_size, io_async_mem_0_source, io_async_mem_0_address, io_async_mem_0_mask, io_async_mem_0_data, io_async_mem_0_corrupt}),
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
  assign io_deq_bits_opcode = _io_deq_bits_deq_bits_reg_io_q[54:52];
  assign io_deq_bits_param = _io_deq_bits_deq_bits_reg_io_q[51:49];
  assign io_deq_bits_size = _io_deq_bits_deq_bits_reg_io_q[48:47];
  assign io_deq_bits_source = _io_deq_bits_deq_bits_reg_io_q[46];
  assign io_deq_bits_address = _io_deq_bits_deq_bits_reg_io_q[45:37];
  assign io_deq_bits_mask = _io_deq_bits_deq_bits_reg_io_q[36:33];
  assign io_deq_bits_data = _io_deq_bits_deq_bits_reg_io_q[32:1];
  assign io_deq_bits_corrupt = _io_deq_bits_deq_bits_reg_io_q[0];
  assign io_async_ridx = ridx_gray;
  assign io_async_safe_sink_reset_n = ~reset;
endmodule

