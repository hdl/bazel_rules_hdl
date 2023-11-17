// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ListBuffer(
  input          clock,
                 reset,
                 io_push_valid,
  input  [5:0]   io_push_bits_index,
  input  [127:0] io_push_bits_data_data,
  input  [15:0]  io_push_bits_data_mask,
  input          io_push_bits_data_corrupt,
                 io_pop_valid,
  input  [5:0]   io_pop_bits,
  output         io_push_ready,
  output [39:0]  io_valid,
  output [127:0] io_data_data,
  output [15:0]  io_data_mask,
  output         io_data_corrupt
);

  wire [5:0]  _next_ext_R0_data;
  wire [5:0]  _tail_ext_R0_data;
  wire [5:0]  _tail_ext_R1_data;
  wire [5:0]  _head_ext_R0_data;
  reg  [39:0] valid;
  reg  [39:0] used;
  wire [39:0] _freeOH_T_22 = ~used;
  wire [38:0] _freeOH_T_3 = _freeOH_T_22[38:0] | {_freeOH_T_22[37:0], 1'h0};
  wire [38:0] _freeOH_T_6 = _freeOH_T_3 | {_freeOH_T_3[36:0], 2'h0};
  wire [38:0] _freeOH_T_9 = _freeOH_T_6 | {_freeOH_T_6[34:0], 4'h0};
  wire [38:0] _freeOH_T_12 = _freeOH_T_9 | {_freeOH_T_9[30:0], 8'h0};
  wire [38:0] _freeOH_T_15 = _freeOH_T_12 | {_freeOH_T_12[22:0], 16'h0};
  wire [39:0] _GEN = {~(_freeOH_T_15 | {_freeOH_T_15[6:0], 32'h0}), 1'h1} & _freeOH_T_22;
  wire [30:0] _freeIdx_T_1 = {24'h0, _GEN[39:33]} | _GEN[31:1];
  wire [14:0] _freeIdx_T_3 = _freeIdx_T_1[30:16] | _freeIdx_T_1[14:0];
  wire [6:0]  _freeIdx_T_5 = _freeIdx_T_3[14:8] | _freeIdx_T_3[6:0];
  wire [2:0]  _freeIdx_T_7 = _freeIdx_T_5[6:4] | _freeIdx_T_5[2:0];
  wire [5:0]  freeIdx = {|(_GEN[39:32]), |(_freeIdx_T_1[30:15]), |(_freeIdx_T_3[14:7]), |(_freeIdx_T_5[6:3]), |(_freeIdx_T_7[2:1]), _freeIdx_T_7[2] | _freeIdx_T_7[0]};
  wire [39:0] _push_valid_T = valid >> io_push_bits_index;
  wire        _io_push_ready_output = used != 40'hFFFFFFFFFF;
  wire        _GEN_14 = _io_push_ready_output & io_push_valid;
  wire [63:0] _valid_clr_T = 64'h1 << io_pop_bits;
  wire [63:0] _valid_set_T = 64'h1 << io_push_bits_index;
  wire [63:0] _used_clr_T = 64'h1 << _head_ext_R0_data;
  always @(posedge clock) begin
    if (reset) begin
      valid <= 40'h0;
      used <= 40'h0;
    end
    else begin
      valid <= valid & ~(io_pop_valid & _head_ext_R0_data == _tail_ext_R1_data ? _valid_clr_T[39:0] : 40'h0) | (_GEN_14 ? _valid_set_T[39:0] : 40'h0);
      used <= used & ~(io_pop_valid ? _used_clr_T[39:0] : 40'h0) | (_GEN_14 ? _GEN : 40'h0);
    end
  end // always @(posedge)
  head_40x6 head_ext (
    .R0_addr (io_pop_bits),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (io_pop_bits),
    .W0_en   (io_pop_valid),
    .W0_clk  (clock),
    .W0_data (_GEN_14 & _push_valid_T[0] & _tail_ext_R0_data == _head_ext_R0_data ? freeIdx : _next_ext_R0_data),
    .W1_addr (io_push_bits_index),
    .W1_en   (_GEN_14 & ~(_push_valid_T[0])),
    .W1_clk  (clock),
    .W1_data (freeIdx),
    .R0_data (_head_ext_R0_data)
  );
  tail_40x6 tail_ext (
    .R0_addr (io_push_bits_index),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R1_addr (io_pop_bits),
    .R1_en   (io_pop_valid),
    .R1_clk  (clock),
    .W0_addr (io_push_bits_index),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (freeIdx),
    .R0_data (_tail_ext_R0_data),
    .R1_data (_tail_ext_R1_data)
  );
  next_40x6 next_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (io_pop_valid),
    .R0_clk  (clock),
    .W0_addr (_tail_ext_R0_data),
    .W0_en   (_GEN_14 & _push_valid_T[0]),
    .W0_clk  (clock),
    .W0_data (freeIdx),
    .R0_data (_next_ext_R0_data)
  );
  data_data_40x128 data_data_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_data),
    .R0_data (io_data_data)
  );
  data_mask_40x16 data_mask_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_mask),
    .R0_data (io_data_mask)
  );
  data_corrupt_40x1 data_corrupt_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_corrupt),
    .R0_data (io_data_corrupt)
  );
  assign io_push_ready = _io_push_ready_output;
  assign io_valid = valid;
endmodule

