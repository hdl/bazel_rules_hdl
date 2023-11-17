// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AsyncQueueSink(
  input         clock,
                reset,
                io_deq_ready,
  input  [31:0] io_async_mem_0,
                io_async_mem_1,
                io_async_mem_2,
                io_async_mem_3,
                io_async_mem_4,
                io_async_mem_5,
                io_async_mem_6,
                io_async_mem_7,
  input  [3:0]  io_async_widx,
  input         io_async_safe_widx_valid,
                io_async_safe_source_reset_n,
  output        io_deq_valid,
  output [31:0] io_deq_bits,
  output [3:0]  io_async_ridx,
  output        io_async_safe_ridx_valid,
                io_async_safe_sink_reset_n
);

  wire        _io_deq_valid_output;
  wire        _source_valid_io_out;
  wire        _source_extend_io_out;
  wire        _sink_valid_0_io_out;
  wire [3:0]  _widx_widx_gray_io_q;
  reg  [31:0] casez_tmp;
  reg  [3:0]  ridx_ridx_bin;
  wire [3:0]  _ridx_incremented_T = ridx_ridx_bin + {3'h0, io_deq_ready & _io_deq_valid_output};
  wire [3:0]  ridx_incremented = _source_valid_io_out ? _ridx_incremented_T : 4'h0;
  wire [2:0]  _index_T = ridx_incremented[2:0] ^ ridx_incremented[3:1];
  wire [3:0]  ridx = {ridx_incremented[3], _index_T};
  wire        valid = _source_valid_io_out & ridx != _widx_widx_gray_io_q;
  always @(*) begin
    casez (_index_T ^ {ridx_incremented[3], 2'h0})
      3'b000:
        casez_tmp = io_async_mem_0;
      3'b001:
        casez_tmp = io_async_mem_1;
      3'b010:
        casez_tmp = io_async_mem_2;
      3'b011:
        casez_tmp = io_async_mem_3;
      3'b100:
        casez_tmp = io_async_mem_4;
      3'b101:
        casez_tmp = io_async_mem_5;
      3'b110:
        casez_tmp = io_async_mem_6;
      default:
        casez_tmp = io_async_mem_7;
    endcase
  end // always @(*)
  reg         valid_reg;
  assign _io_deq_valid_output = valid_reg & _source_valid_io_out;
  reg  [3:0]  ridx_gray;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      ridx_ridx_bin <= 4'h0;
      valid_reg <= 1'h0;
      ridx_gray <= 4'h0;
    end
    else begin
      if (_source_valid_io_out)
        ridx_ridx_bin <= _ridx_incremented_T;
      else
        ridx_ridx_bin <= 4'h0;
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
        ridx_ridx_bin = 4'h0;
        valid_reg = 1'h0;
        ridx_gray = 4'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  AsyncResetSynchronizerShiftReg_w4_d3_i0 widx_widx_gray (
    .clock (clock),
    .reset (reset),
    .io_d  (io_async_widx),
    .io_q  (_widx_widx_gray_io_q)
  );
  ClockCrossingReg_w32 io_deq_bits_deq_bits_reg (
    .clock (clock),
    .io_d  (casez_tmp),
    .io_en (valid),
    .io_q  (io_deq_bits)
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
  assign io_async_ridx = ridx_gray;
  assign io_async_safe_sink_reset_n = ~reset;
endmodule

