// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ListBuffer_2(
  input         clock,
                reset,
                io_push_valid,
  input  [5:0]  io_push_bits_index,
  input         io_push_bits_data_prio_0,
                io_push_bits_data_prio_2,
                io_push_bits_data_control,
  input  [2:0]  io_push_bits_data_opcode,
                io_push_bits_data_param,
                io_push_bits_data_size,
  input  [5:0]  io_push_bits_data_source,
  input  [11:0] io_push_bits_data_tag,
  input  [5:0]  io_push_bits_data_offset,
                io_push_bits_data_put,
  input         io_pop_valid,
  input  [5:0]  io_pop_bits,
  output        io_push_ready,
  output [35:0] io_valid,
  output        io_data_prio_0,
                io_data_prio_1,
                io_data_prio_2,
                io_data_control,
  output [2:0]  io_data_opcode,
                io_data_param,
                io_data_size,
  output [5:0]  io_data_source,
  output [11:0] io_data_tag,
  output [5:0]  io_data_offset,
                io_data_put
);

  wire [4:0]  _next_ext_R0_data;
  wire [4:0]  _tail_ext_R0_data;
  wire [4:0]  _tail_ext_R1_data;
  wire [4:0]  _head_ext_R0_data;
  reg  [35:0] valid;
  reg  [27:0] used;
  wire [27:0] _freeOH_T_19 = ~used;
  wire [26:0] _freeOH_T_3 = _freeOH_T_19[26:0] | {_freeOH_T_19[25:0], 1'h0};
  wire [26:0] _freeOH_T_6 = _freeOH_T_3 | {_freeOH_T_3[24:0], 2'h0};
  wire [26:0] _freeOH_T_9 = _freeOH_T_6 | {_freeOH_T_6[22:0], 4'h0};
  wire [26:0] _freeOH_T_12 = _freeOH_T_9 | {_freeOH_T_9[18:0], 8'h0};
  wire [27:0] _GEN = {~(_freeOH_T_12 | {_freeOH_T_12[10:0], 16'h0}), 1'h1} & _freeOH_T_19;
  wire [14:0] _freeIdx_T_1 = {4'h0, _GEN[27:17]} | _GEN[15:1];
  wire [6:0]  _freeIdx_T_3 = _freeIdx_T_1[14:8] | _freeIdx_T_1[6:0];
  wire [2:0]  _freeIdx_T_5 = _freeIdx_T_3[6:4] | _freeIdx_T_3[2:0];
  wire [4:0]  freeIdx = {|(_GEN[27:16]), |(_freeIdx_T_1[14:7]), |(_freeIdx_T_3[6:3]), |(_freeIdx_T_5[2:1]), _freeIdx_T_5[2] | _freeIdx_T_5[0]};
  wire [35:0] _push_valid_T = valid >> io_push_bits_index;
  wire        _io_push_ready_output = used != 28'hFFFFFFF;
  wire        _GEN_14 = _io_push_ready_output & io_push_valid;
  wire [63:0] _valid_clr_T = 64'h1 << io_pop_bits;
  wire [63:0] _valid_set_T = 64'h1 << io_push_bits_index;
  wire [31:0] _used_clr_T = 32'h1 << _head_ext_R0_data;
  always @(posedge clock) begin
    if (reset) begin
      valid <= 36'h0;
      used <= 28'h0;
    end
    else begin
      valid <= valid & ~(io_pop_valid & _head_ext_R0_data == _tail_ext_R1_data ? _valid_clr_T[35:0] : 36'h0) | (_GEN_14 ? _valid_set_T[35:0] : 36'h0);
      used <= used & ~(io_pop_valid ? _used_clr_T[27:0] : 28'h0) | (_GEN_14 ? _GEN : 28'h0);
    end
  end // always @(posedge)
  head_36x5 head_ext (
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
  tail_36x5 tail_ext (
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
  next_28x5 next_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (io_pop_valid),
    .R0_clk  (clock),
    .W0_addr (_tail_ext_R0_data),
    .W0_en   (_GEN_14 & _push_valid_T[0]),
    .W0_clk  (clock),
    .W0_data (freeIdx),
    .R0_data (_next_ext_R0_data)
  );
  data_28x1 data_prio_0_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_prio_0),
    .R0_data (io_data_prio_0)
  );
  data_28x1 data_prio_1_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (1'h0),
    .R0_data (io_data_prio_1)
  );
  data_28x1 data_prio_2_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_prio_2),
    .R0_data (io_data_prio_2)
  );
  data_28x1 data_control_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_control),
    .R0_data (io_data_control)
  );
  data_28x3 data_opcode_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_opcode),
    .R0_data (io_data_opcode)
  );
  data_28x3 data_param_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_param),
    .R0_data (io_data_param)
  );
  data_28x3 data_size_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_size),
    .R0_data (io_data_size)
  );
  data_28x6 data_source_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_source),
    .R0_data (io_data_source)
  );
  data_tag_28x12 data_tag_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_tag),
    .R0_data (io_data_tag)
  );
  data_28x6 data_offset_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_offset),
    .R0_data (io_data_offset)
  );
  data_28x6 data_put_ext (
    .R0_addr (_head_ext_R0_data),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (freeIdx),
    .W0_en   (_GEN_14),
    .W0_clk  (clock),
    .W0_data (io_push_bits_data_put),
    .R0_data (io_data_put)
  );
  assign io_push_ready = _io_push_ready_output;
  assign io_valid = valid;
endmodule

