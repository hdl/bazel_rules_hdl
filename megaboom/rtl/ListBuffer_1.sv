// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ListBuffer_1(
  input          clock,
                 reset,
                 io_push_valid,
                 io_push_bits_index,
  input  [127:0] io_push_bits_data_data,
  input          io_push_bits_data_corrupt,
                 io_pop_valid,
                 io_pop_bits,
  output         io_push_ready,
  output [1:0]   io_valid,
  output [127:0] io_data_data,
  output         io_data_corrupt
);

  wire [2:0] _next_ext_R0_data;
  wire [2:0] _tail_ext_R0_data;
  wire [2:0] _tail_ext_R1_data;
  wire [2:0] _head_ext_R0_data;
  reg  [1:0] valid;
  reg  [7:0] used;
  wire [7:0] _freeOH_T_13 = ~used;
  wire [6:0] _freeOH_T_3 = _freeOH_T_13[6:0] | {_freeOH_T_13[5:0], 1'h0};
  wire [6:0] _freeOH_T_6 = _freeOH_T_3 | {_freeOH_T_3[4:0], 2'h0};
  wire [7:0] freeIdx_lo = {~(_freeOH_T_6 | {_freeOH_T_6[2:0], 4'h0}), 1'h1} & _freeOH_T_13;
  wire [2:0] _freeIdx_T_3 = freeIdx_lo[7:5] | freeIdx_lo[3:1];
  wire       _freeIdx_T_5 = _freeIdx_T_3[2] | _freeIdx_T_3[0];
  wire [1:0] _GEN = {1'h0, io_push_bits_index};
  wire [1:0] _push_valid_T = valid >> _GEN;
  wire       _io_push_ready_output = used != 8'hFF;
  wire       _GEN_14 = _io_push_ready_output & io_push_valid;
  wire [2:0] _GEN_12 = {|(freeIdx_lo[7:4]), |(_freeIdx_T_3[2:1]), _freeIdx_T_5};
  wire [1:0] _GEN_0 = {1'h0, io_pop_bits};
  wire [2:0] _GEN_1 = {|(freeIdx_lo[7:4]), |(_freeIdx_T_3[2:1]), _freeIdx_T_5};
  always @(posedge clock) begin
    if (reset) begin
      valid <= 2'h0;
      used <= 8'h0;
    end
    else begin
      valid <= valid & ~(io_pop_valid & _head_ext_R0_data == _tail_ext_R1_data ? 2'h1 << _GEN_0 : 2'h0) | (_GEN_14 ? 2'h1 << _GEN : 2'h0);
      used <= used & ~(io_pop_valid ? 8'h1 << _head_ext_R0_data : 8'h0) | (_GEN_14 ? freeIdx_lo : 8'h0);
    end
  end // always @(posedge)
  head_2x3 head_ext (
    .R0_addr (io_pop_bits),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (io_pop_bits),
    .W0_en   (io_pop_valid),
    .W0_clk  (clock),
    .W0_data (_GEN_14 & _push_valid_T[0] & _tail_ext_R0_data == _head_ext_R0_data ? _GEN_1 : _next_ext_R0_data),
    .W1_addr (io_push_bits_index),
    .W1_en   (_GEN_14 & ~(_push_valid_T[0])),
    .W1_clk  (clock),
    .W1_data (_GEN_1),
    .R0_data (_head_ext_R0_data)
  );
  tail_2x3 tail_ext (
    .R0_addr (io_push_bits_index),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R1_addr (io_pop_bits),
    .R1_en   (io_pop_valid),
    .R1_clk  (clock),
    .W0_addr (io_push_bits_index),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (_GEN_1),
    .R0_data (_tail_ext_R0_data),
    .R1_data (_tail_ext_R1_data)
  );
  next_8x3 next_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (io_pop_valid),
    .R0_clk  (clock),
    .W0_addr (_tail_ext_R0_data),
    .W0_en   (_GEN_14 & _push_valid_T[0]),
    .W0_clk  (clock),
    .W0_data (_GEN_1),
    .R0_data (_next_ext_R0_data)
  );
  data_data_8x128 data_data_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (_GEN_12),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_data),
    .R0_data (io_data_data)
  );
  data_corrupt_8x1 data_corrupt_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (_GEN_12),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_corrupt),
    .R0_data (io_data_corrupt)
  );
  assign io_push_ready = _io_push_ready_output;
  assign io_valid = valid;
endmodule

