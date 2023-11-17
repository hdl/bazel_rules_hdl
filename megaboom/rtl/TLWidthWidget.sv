// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLWidthWidget(
  input          clock,
                 reset,
                 auto_in_a_valid,
  input  [2:0]   auto_in_a_bits_opcode,
                 auto_in_a_bits_param,
  input  [3:0]   auto_in_a_bits_size,
  input  [5:0]   auto_in_a_bits_source,
  input  [28:0]  auto_in_a_bits_address,
  input  [15:0]  auto_in_a_bits_mask,
  input  [127:0] auto_in_a_bits_data,
  input          auto_in_a_bits_corrupt,
                 auto_in_d_ready,
                 auto_out_a_ready,
                 auto_out_d_valid,
  input  [2:0]   auto_out_d_bits_opcode,
  input  [1:0]   auto_out_d_bits_param,
  input  [3:0]   auto_out_d_bits_size,
  input  [5:0]   auto_out_d_bits_source,
  input          auto_out_d_bits_sink,
                 auto_out_d_bits_denied,
  input  [63:0]  auto_out_d_bits_data,
  input          auto_out_d_bits_corrupt,
  output         auto_in_a_ready,
                 auto_in_d_valid,
  output [2:0]   auto_in_d_bits_opcode,
  output [1:0]   auto_in_d_bits_param,
  output [3:0]   auto_in_d_bits_size,
  output [5:0]   auto_in_d_bits_source,
  output         auto_in_d_bits_sink,
                 auto_in_d_bits_denied,
  output [127:0] auto_in_d_bits_data,
  output         auto_in_d_bits_corrupt,
                 auto_out_a_valid,
  output [2:0]   auto_out_a_bits_opcode,
                 auto_out_a_bits_param,
  output [3:0]   auto_out_a_bits_size,
  output [5:0]   auto_out_a_bits_source,
  output [28:0]  auto_out_a_bits_address,
  output [7:0]   auto_out_a_bits_mask,
  output [63:0]  auto_out_a_bits_data,
  output         auto_out_a_bits_corrupt,
                 auto_out_d_ready
);

  wire         _repeated_repeater_io_enq_ready;
  wire         _repeated_repeater_io_deq_valid;
  wire [2:0]   _repeated_repeater_io_deq_bits_opcode;
  wire [3:0]   _repeated_repeater_io_deq_bits_size;
  wire [28:0]  _repeated_repeater_io_deq_bits_address;
  wire [15:0]  _repeated_repeater_io_deq_bits_mask;
  wire [127:0] _repeated_repeater_io_deq_bits_data;
  wire [18:0]  _repeat_limit_T_1 = 19'hF << _repeated_repeater_io_deq_bits_size;
  reg          repeat_count;
  wire         repeat_last = repeat_count == ~(_repeat_limit_T_1[3]) | _repeated_repeater_io_deq_bits_opcode[2];
  wire         repeat_index = _repeated_repeater_io_deq_bits_address[3] | repeat_count;
  wire [18:0]  _limit_T_1 = 19'hF << auto_out_d_bits_size;
  reg          count;
  wire         last = count == ~(_limit_T_1[3]) | ~(auto_out_d_bits_opcode[0]);
  reg          corrupt_reg;
  wire         corrupt_out = auto_out_d_bits_corrupt | corrupt_reg;
  wire         nodeOut_d_ready = auto_in_d_ready | ~last;
  wire         nodeIn_d_valid = auto_out_d_valid & last;
  reg          nodeIn_d_bits_data_rdata_written_once;
  wire         nodeIn_d_bits_data_masked_enable_0 = ~(count & ~(_limit_T_1[3])) | ~nodeIn_d_bits_data_rdata_written_once;
  reg  [63:0]  nodeIn_d_bits_data_rdata_0;
  wire         _nodeIn_d_bits_data_T = nodeOut_d_ready & auto_out_d_valid;
  wire         _nodeIn_d_bits_data_T_2 = _nodeIn_d_bits_data_T & ~last;
  always @(posedge clock) begin
    if (reset) begin
      repeat_count <= 1'h0;
      count <= 1'h0;
      corrupt_reg <= 1'h0;
      nodeIn_d_bits_data_rdata_written_once <= 1'h0;
    end
    else begin
      if (auto_out_a_ready & _repeated_repeater_io_deq_valid)
        repeat_count <= ~repeat_last & repeat_count - 1'h1;
      if (_nodeIn_d_bits_data_T) begin
        count <= ~last & count - 1'h1;
        corrupt_reg <= ~last & corrupt_out;
      end
      nodeIn_d_bits_data_rdata_written_once <= _nodeIn_d_bits_data_T_2 | nodeIn_d_bits_data_rdata_written_once;
    end
    if (_nodeIn_d_bits_data_T_2 & nodeIn_d_bits_data_masked_enable_0)
      nodeIn_d_bits_data_rdata_0 <= auto_out_d_bits_data;
  end // always @(posedge)
  Repeater repeated_repeater (
    .clock               (clock),
    .reset               (reset),
    .io_repeat           (~repeat_last),
    .io_enq_valid        (auto_in_a_valid),
    .io_enq_bits_opcode  (auto_in_a_bits_opcode),
    .io_enq_bits_param   (auto_in_a_bits_param),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_address (auto_in_a_bits_address),
    .io_enq_bits_mask    (auto_in_a_bits_mask),
    .io_enq_bits_data    (auto_in_a_bits_data),
    .io_enq_bits_corrupt (auto_in_a_bits_corrupt),
    .io_deq_ready        (auto_out_a_ready),
    .io_enq_ready        (_repeated_repeater_io_enq_ready),
    .io_deq_valid        (_repeated_repeater_io_deq_valid),
    .io_deq_bits_opcode  (_repeated_repeater_io_deq_bits_opcode),
    .io_deq_bits_param   (auto_out_a_bits_param),
    .io_deq_bits_size    (_repeated_repeater_io_deq_bits_size),
    .io_deq_bits_source  (auto_out_a_bits_source),
    .io_deq_bits_address (_repeated_repeater_io_deq_bits_address),
    .io_deq_bits_mask    (_repeated_repeater_io_deq_bits_mask),
    .io_deq_bits_data    (_repeated_repeater_io_deq_bits_data),
    .io_deq_bits_corrupt (auto_out_a_bits_corrupt)
  );
  assign auto_in_a_ready = _repeated_repeater_io_enq_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_opcode = auto_out_d_bits_opcode;
  assign auto_in_d_bits_param = auto_out_d_bits_param;
  assign auto_in_d_bits_size = auto_out_d_bits_size;
  assign auto_in_d_bits_source = auto_out_d_bits_source;
  assign auto_in_d_bits_sink = auto_out_d_bits_sink;
  assign auto_in_d_bits_denied = auto_out_d_bits_denied;
  assign auto_in_d_bits_data = {auto_out_d_bits_data, nodeIn_d_bits_data_masked_enable_0 ? auto_out_d_bits_data : nodeIn_d_bits_data_rdata_0};
  assign auto_in_d_bits_corrupt = corrupt_out;
  assign auto_out_a_valid = _repeated_repeater_io_deq_valid;
  assign auto_out_a_bits_opcode = _repeated_repeater_io_deq_bits_opcode;
  assign auto_out_a_bits_size = _repeated_repeater_io_deq_bits_size;
  assign auto_out_a_bits_address = _repeated_repeater_io_deq_bits_address;
  assign auto_out_a_bits_mask = repeat_index ? _repeated_repeater_io_deq_bits_mask[15:8] : _repeated_repeater_io_deq_bits_mask[7:0];
  assign auto_out_a_bits_data = repeat_index ? _repeated_repeater_io_deq_bits_data[127:64] : auto_in_a_bits_data[63:0];
  assign auto_out_d_ready = nodeOut_d_ready;
endmodule

