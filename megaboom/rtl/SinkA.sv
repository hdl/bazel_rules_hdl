// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module SinkA(
  input          clock,
                 reset,
                 io_req_ready,
                 io_a_valid,
  input  [2:0]   io_a_bits_opcode,
                 io_a_bits_param,
                 io_a_bits_size,
  input  [5:0]   io_a_bits_source,
  input  [31:0]  io_a_bits_address,
  input  [15:0]  io_a_bits_mask,
  input  [127:0] io_a_bits_data,
  input          io_a_bits_corrupt,
                 io_pb_pop_valid,
  input  [5:0]   io_pb_pop_bits_index,
  input          io_pb_pop_bits_last,
  output         io_req_valid,
  output [2:0]   io_req_bits_opcode,
                 io_req_bits_param,
                 io_req_bits_size,
  output [5:0]   io_req_bits_source,
  output [11:0]  io_req_bits_tag,
  output [5:0]   io_req_bits_offset,
                 io_req_bits_put,
  output [9:0]   io_req_bits_set,
  output         io_a_ready,
                 io_pb_pop_ready,
  output [127:0] io_pb_beat_data,
  output [15:0]  io_pb_beat_mask,
  output         io_pb_beat_corrupt
);

  wire        _io_pb_pop_ready_output;
  wire        _putbuffer_io_push_ready;
  wire [39:0] _putbuffer_io_valid;
  reg  [39:0] lists;
  reg  [1:0]  first_counter;
  wire        first = first_counter == 2'h0;
  wire        _io_req_valid_T = io_a_valid & first;
  wire        req_block = first & ~io_req_ready;
  wire        buf_block = ~(io_a_bits_opcode[2]) & ~_putbuffer_io_push_ready;
  wire [39:0] _freeOH_T_22 = ~lists;
  wire [38:0] _freeOH_T_3 = _freeOH_T_22[38:0] | {_freeOH_T_22[37:0], 1'h0};
  wire [38:0] _freeOH_T_6 = _freeOH_T_3 | {_freeOH_T_3[36:0], 2'h0};
  wire [38:0] _freeOH_T_9 = _freeOH_T_6 | {_freeOH_T_6[34:0], 4'h0};
  wire [38:0] _freeOH_T_12 = _freeOH_T_9 | {_freeOH_T_9[30:0], 8'h0};
  wire [38:0] _freeOH_T_15 = _freeOH_T_12 | {_freeOH_T_12[22:0], 16'h0};
  wire [39:0] _GEN = {~(_freeOH_T_15 | {_freeOH_T_15[6:0], 32'h0}), 1'h1} & _freeOH_T_22;
  wire        _putbuffer_io_pop_valid_T = _io_pb_pop_ready_output & io_pb_pop_valid;
  wire [30:0] _freeIdx_T_1 = {24'h0, _GEN[39:33]} | _GEN[31:1];
  wire [14:0] _freeIdx_T_3 = _freeIdx_T_1[30:16] | _freeIdx_T_1[14:0];
  wire [6:0]  _freeIdx_T_5 = _freeIdx_T_3[14:8] | _freeIdx_T_3[6:0];
  wire [2:0]  _freeIdx_T_7 = _freeIdx_T_5[6:4] | _freeIdx_T_5[2:0];
  wire [5:0]  freeIdx = {|(_GEN[39:32]), |(_freeIdx_T_1[30:15]), |(_freeIdx_T_3[14:7]), |(_freeIdx_T_5[6:3]), |(_freeIdx_T_7[2:1]), _freeIdx_T_7[2] | _freeIdx_T_7[0]};
  wire        set_block = ~(io_a_bits_opcode[2]) & first & (&lists);
  wire        _io_a_ready_output = ~req_block & ~buf_block & ~set_block;
  reg  [5:0]  put_r;
  wire [5:0]  put = first ? freeIdx : put_r;
  wire [39:0] _io_pb_pop_ready_T = _putbuffer_io_valid >> io_pb_pop_bits_index;
  assign _io_pb_pop_ready_output = _io_pb_pop_ready_T[0];
  wire [12:0] _first_beats1_decode_T_1 = 13'h3F << io_a_bits_size;
  wire [63:0] _lists_clr_T = 64'h1 << io_pb_pop_bits_index;
  always @(posedge clock) begin
    if (reset) begin
      lists <= 40'h0;
      first_counter <= 2'h0;
    end
    else begin
      lists <= (lists | (_io_req_valid_T & ~(io_a_bits_opcode[2]) & ~req_block & ~buf_block ? _GEN : 40'h0)) & ~(_putbuffer_io_pop_valid_T & io_pb_pop_bits_last ? _lists_clr_T[39:0] : 40'h0);
      if (_io_a_ready_output & io_a_valid) begin
        if (first) begin
          if (io_a_bits_opcode[2])
            first_counter <= 2'h0;
          else
            first_counter <= ~(_first_beats1_decode_T_1[5:4]);
        end
        else
          first_counter <= first_counter - 2'h1;
      end
    end
    if (first)
      put_r <= freeIdx;
  end // always @(posedge)
  ListBuffer putbuffer (
    .clock                     (clock),
    .reset                     (reset),
    .io_push_valid             (io_a_valid & ~(io_a_bits_opcode[2]) & ~req_block & ~set_block),
    .io_push_bits_index        (put),
    .io_push_bits_data_data    (io_a_bits_data),
    .io_push_bits_data_mask    (io_a_bits_mask),
    .io_push_bits_data_corrupt (io_a_bits_corrupt),
    .io_pop_valid              (_putbuffer_io_pop_valid_T),
    .io_pop_bits               (io_pb_pop_bits_index),
    .io_push_ready             (_putbuffer_io_push_ready),
    .io_valid                  (_putbuffer_io_valid),
    .io_data_data              (io_pb_beat_data),
    .io_data_mask              (io_pb_beat_mask),
    .io_data_corrupt           (io_pb_beat_corrupt)
  );
  assign io_req_valid = _io_req_valid_T & ~buf_block & ~set_block;
  assign io_req_bits_opcode = io_a_bits_opcode;
  assign io_req_bits_param = io_a_bits_param;
  assign io_req_bits_size = io_a_bits_size;
  assign io_req_bits_source = io_a_bits_source;
  assign io_req_bits_tag = io_a_bits_address[27:16];
  assign io_req_bits_offset = io_a_bits_address[5:0];
  assign io_req_bits_put = put;
  assign io_req_bits_set = io_a_bits_address[15:6];
  assign io_a_ready = _io_a_ready_output;
  assign io_pb_pop_ready = _io_pb_pop_ready_output;
endmodule

