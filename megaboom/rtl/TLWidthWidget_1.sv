// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLWidthWidget_1(
  input          clock,
                 reset,
                 auto_in_a_valid,
  input  [2:0]   auto_in_a_bits_opcode,
                 auto_in_a_bits_param,
  input  [3:0]   auto_in_a_bits_size,
                 auto_in_a_bits_source,
  input  [31:0]  auto_in_a_bits_address,
  input  [7:0]   auto_in_a_bits_mask,
  input  [63:0]  auto_in_a_bits_data,
  input          auto_in_a_bits_corrupt,
                 auto_in_d_ready,
                 auto_out_a_ready,
                 auto_out_d_valid,
  input  [2:0]   auto_out_d_bits_opcode,
  input  [1:0]   auto_out_d_bits_param,
  input  [3:0]   auto_out_d_bits_size,
                 auto_out_d_bits_source,
                 auto_out_d_bits_sink,
  input          auto_out_d_bits_denied,
  input  [127:0] auto_out_d_bits_data,
  input          auto_out_d_bits_corrupt,
  output         auto_in_a_ready,
                 auto_in_d_valid,
  output [2:0]   auto_in_d_bits_opcode,
  output [1:0]   auto_in_d_bits_param,
  output [3:0]   auto_in_d_bits_size,
                 auto_in_d_bits_source,
                 auto_in_d_bits_sink,
  output         auto_in_d_bits_denied,
  output [63:0]  auto_in_d_bits_data,
  output         auto_in_d_bits_corrupt,
                 auto_out_a_valid,
  output [2:0]   auto_out_a_bits_opcode,
                 auto_out_a_bits_param,
  output [3:0]   auto_out_a_bits_size,
                 auto_out_a_bits_source,
  output [31:0]  auto_out_a_bits_address,
  output [15:0]  auto_out_a_bits_mask,
  output [127:0] auto_out_a_bits_data,
  output         auto_out_a_bits_corrupt,
                 auto_out_d_ready
);

  wire         _repeated_repeater_io_deq_valid;
  wire [2:0]   _repeated_repeater_io_deq_bits_opcode;
  wire [1:0]   _repeated_repeater_io_deq_bits_param;
  wire [3:0]   _repeated_repeater_io_deq_bits_size;
  wire [3:0]   _repeated_repeater_io_deq_bits_source;
  wire [3:0]   _repeated_repeater_io_deq_bits_sink;
  wire         _repeated_repeater_io_deq_bits_denied;
  wire [127:0] _repeated_repeater_io_deq_bits_data;
  wire         _repeated_repeater_io_deq_bits_corrupt;
  reg          casez_tmp;
  wire [18:0]  _limit_T_1 = 19'hF << auto_in_a_bits_size;
  reg          count;
  wire         last = count == ~(_limit_T_1[3]) | auto_in_a_bits_opcode[2];
  wire         _enable_T_2 = count & ~(_limit_T_1[3]);
  reg          corrupt_reg;
  wire         corrupt_out = auto_in_a_bits_corrupt | corrupt_reg;
  wire         nodeIn_a_ready = auto_out_a_ready | ~last;
  reg          nodeOut_a_bits_data_rdata_written_once;
  wire         nodeOut_a_bits_data_masked_enable_0 = ~_enable_T_2 | ~nodeOut_a_bits_data_rdata_written_once;
  reg  [63:0]  nodeOut_a_bits_data_rdata_0;
  wire         nodeOut_a_bits_mask_acc = (|(auto_in_a_bits_size[3:2])) | (&(auto_in_a_bits_size[1:0])) & ~(auto_in_a_bits_address[3]);
  wire         nodeOut_a_bits_mask_acc_1 = (|(auto_in_a_bits_size[3:2])) | (&(auto_in_a_bits_size[1:0])) & auto_in_a_bits_address[3];
  wire         nodeOut_a_bits_mask_size_1 = auto_in_a_bits_size[1:0] == 2'h2;
  wire         nodeOut_a_bits_mask_eq_2 = ~(auto_in_a_bits_address[3]) & ~(auto_in_a_bits_address[2]);
  wire         nodeOut_a_bits_mask_acc_2 = nodeOut_a_bits_mask_acc | nodeOut_a_bits_mask_size_1 & nodeOut_a_bits_mask_eq_2;
  wire         nodeOut_a_bits_mask_eq_3 = ~(auto_in_a_bits_address[3]) & auto_in_a_bits_address[2];
  wire         nodeOut_a_bits_mask_acc_3 = nodeOut_a_bits_mask_acc | nodeOut_a_bits_mask_size_1 & nodeOut_a_bits_mask_eq_3;
  wire         nodeOut_a_bits_mask_eq_4 = auto_in_a_bits_address[3] & ~(auto_in_a_bits_address[2]);
  wire         nodeOut_a_bits_mask_acc_4 = nodeOut_a_bits_mask_acc_1 | nodeOut_a_bits_mask_size_1 & nodeOut_a_bits_mask_eq_4;
  wire         nodeOut_a_bits_mask_eq_5 = auto_in_a_bits_address[3] & auto_in_a_bits_address[2];
  wire         nodeOut_a_bits_mask_acc_5 = nodeOut_a_bits_mask_acc_1 | nodeOut_a_bits_mask_size_1 & nodeOut_a_bits_mask_eq_5;
  wire         nodeOut_a_bits_mask_size_2 = auto_in_a_bits_size[1:0] == 2'h1;
  wire         nodeOut_a_bits_mask_eq_6 = nodeOut_a_bits_mask_eq_2 & ~(auto_in_a_bits_address[1]);
  wire         nodeOut_a_bits_mask_acc_6 = nodeOut_a_bits_mask_acc_2 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_6;
  wire         nodeOut_a_bits_mask_eq_7 = nodeOut_a_bits_mask_eq_2 & auto_in_a_bits_address[1];
  wire         nodeOut_a_bits_mask_acc_7 = nodeOut_a_bits_mask_acc_2 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_7;
  wire         nodeOut_a_bits_mask_eq_8 = nodeOut_a_bits_mask_eq_3 & ~(auto_in_a_bits_address[1]);
  wire         nodeOut_a_bits_mask_acc_8 = nodeOut_a_bits_mask_acc_3 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_8;
  wire         nodeOut_a_bits_mask_eq_9 = nodeOut_a_bits_mask_eq_3 & auto_in_a_bits_address[1];
  wire         nodeOut_a_bits_mask_acc_9 = nodeOut_a_bits_mask_acc_3 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_9;
  wire         nodeOut_a_bits_mask_eq_10 = nodeOut_a_bits_mask_eq_4 & ~(auto_in_a_bits_address[1]);
  wire         nodeOut_a_bits_mask_acc_10 = nodeOut_a_bits_mask_acc_4 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_10;
  wire         nodeOut_a_bits_mask_eq_11 = nodeOut_a_bits_mask_eq_4 & auto_in_a_bits_address[1];
  wire         nodeOut_a_bits_mask_acc_11 = nodeOut_a_bits_mask_acc_4 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_11;
  wire         nodeOut_a_bits_mask_eq_12 = nodeOut_a_bits_mask_eq_5 & ~(auto_in_a_bits_address[1]);
  wire         nodeOut_a_bits_mask_acc_12 = nodeOut_a_bits_mask_acc_5 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_12;
  wire         nodeOut_a_bits_mask_eq_13 = nodeOut_a_bits_mask_eq_5 & auto_in_a_bits_address[1];
  wire         nodeOut_a_bits_mask_acc_13 = nodeOut_a_bits_mask_acc_5 | nodeOut_a_bits_mask_size_2 & nodeOut_a_bits_mask_eq_13;
  reg          nodeOut_a_bits_mask_rdata_written_once;
  wire         nodeOut_a_bits_mask_masked_enable_0 = ~_enable_T_2 | ~nodeOut_a_bits_mask_rdata_written_once;
  reg  [7:0]   nodeOut_a_bits_mask_rdata_0;
  wire [18:0]  _repeat_limit_T_1 = 19'hF << _repeated_repeater_io_deq_bits_size;
  reg          repeat_count;
  wire         repeat_last = repeat_count == ~(_repeat_limit_T_1[3]) | ~(_repeated_repeater_io_deq_bits_opcode[0]);
  reg          repeat_sel_sel_sources_0;
  reg          repeat_sel_sel_sources_1;
  reg          repeat_sel_sel_sources_2;
  reg          repeat_sel_sel_sources_3;
  reg          repeat_sel_sel_sources_4;
  reg          repeat_sel_sel_sources_5;
  reg          repeat_sel_sel_sources_6;
  reg          repeat_sel_sel_sources_7;
  reg          repeat_sel_sel_sources_8;
  reg          repeat_sel_sel_sources_9;
  reg          repeat_sel_sel_sources_10;
  reg          repeat_sel_sel_sources_11;
  reg          repeat_sel_sel_sources_12;
  reg          repeat_sel_sel_sources_13;
  reg          repeat_sel_sel_sources_14;
  reg          repeat_sel_sel_sources_15;
  reg          repeat_sel_hold_r;
  always @(*) begin
    casez (_repeated_repeater_io_deq_bits_source)
      4'b0000:
        casez_tmp = repeat_sel_sel_sources_0;
      4'b0001:
        casez_tmp = repeat_sel_sel_sources_1;
      4'b0010:
        casez_tmp = repeat_sel_sel_sources_2;
      4'b0011:
        casez_tmp = repeat_sel_sel_sources_3;
      4'b0100:
        casez_tmp = repeat_sel_sel_sources_4;
      4'b0101:
        casez_tmp = repeat_sel_sel_sources_5;
      4'b0110:
        casez_tmp = repeat_sel_sel_sources_6;
      4'b0111:
        casez_tmp = repeat_sel_sel_sources_7;
      4'b1000:
        casez_tmp = repeat_sel_sel_sources_8;
      4'b1001:
        casez_tmp = repeat_sel_sel_sources_9;
      4'b1010:
        casez_tmp = repeat_sel_sel_sources_10;
      4'b1011:
        casez_tmp = repeat_sel_sel_sources_11;
      4'b1100:
        casez_tmp = repeat_sel_sel_sources_12;
      4'b1101:
        casez_tmp = repeat_sel_sel_sources_13;
      4'b1110:
        casez_tmp = repeat_sel_sel_sources_14;
      default:
        casez_tmp = repeat_sel_sel_sources_15;
    endcase
  end // always @(*)
  wire         _repeat_sel_sel_T = nodeIn_a_ready & auto_in_a_valid;
  wire         _nodeOut_a_bits_data_T_2 = _repeat_sel_sel_T & ~last;
  wire         _nodeOut_a_bits_mask_T_4 = _repeat_sel_sel_T & ~last;
  always @(posedge clock) begin
    if (reset) begin
      count <= 1'h0;
      corrupt_reg <= 1'h0;
      nodeOut_a_bits_data_rdata_written_once <= 1'h0;
      nodeOut_a_bits_mask_rdata_written_once <= 1'h0;
      repeat_count <= 1'h0;
    end
    else begin
      if (_repeat_sel_sel_T) begin
        count <= ~last & count - 1'h1;
        corrupt_reg <= ~last & corrupt_out;
      end
      nodeOut_a_bits_data_rdata_written_once <= _nodeOut_a_bits_data_T_2 | nodeOut_a_bits_data_rdata_written_once;
      nodeOut_a_bits_mask_rdata_written_once <= _nodeOut_a_bits_mask_T_4 | nodeOut_a_bits_mask_rdata_written_once;
      if (auto_in_d_ready & _repeated_repeater_io_deq_valid)
        repeat_count <= ~repeat_last & repeat_count - 1'h1;
    end
    if (_nodeOut_a_bits_data_T_2 & nodeOut_a_bits_data_masked_enable_0)
      nodeOut_a_bits_data_rdata_0 <= auto_in_a_bits_data;
    if (_nodeOut_a_bits_mask_T_4 & nodeOut_a_bits_mask_masked_enable_0)
      nodeOut_a_bits_mask_rdata_0 <= auto_in_a_bits_mask;
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h0)
      repeat_sel_sel_sources_0 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h1)
      repeat_sel_sel_sources_1 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h2)
      repeat_sel_sel_sources_2 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h3)
      repeat_sel_sel_sources_3 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h4)
      repeat_sel_sel_sources_4 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h5)
      repeat_sel_sel_sources_5 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h6)
      repeat_sel_sel_sources_6 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h7)
      repeat_sel_sel_sources_7 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h8)
      repeat_sel_sel_sources_8 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'h9)
      repeat_sel_sel_sources_9 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'hA)
      repeat_sel_sel_sources_10 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'hB)
      repeat_sel_sel_sources_11 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'hC)
      repeat_sel_sel_sources_12 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'hD)
      repeat_sel_sel_sources_13 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & auto_in_a_bits_source == 4'hE)
      repeat_sel_sel_sources_14 <= auto_in_a_bits_address[3];
    if (_repeat_sel_sel_T & (&auto_in_a_bits_source))
      repeat_sel_sel_sources_15 <= auto_in_a_bits_address[3];
    if (repeat_count) begin
    end
    else
      repeat_sel_hold_r <= casez_tmp;
  end // always @(posedge)
  Repeater_1 repeated_repeater (
    .clock               (clock),
    .reset               (reset),
    .io_repeat           (~repeat_last),
    .io_enq_valid        (auto_out_d_valid),
    .io_enq_bits_opcode  (auto_out_d_bits_opcode),
    .io_enq_bits_param   (auto_out_d_bits_param),
    .io_enq_bits_size    (auto_out_d_bits_size),
    .io_enq_bits_source  (auto_out_d_bits_source),
    .io_enq_bits_sink    (auto_out_d_bits_sink),
    .io_enq_bits_denied  (auto_out_d_bits_denied),
    .io_enq_bits_data    (auto_out_d_bits_data),
    .io_enq_bits_corrupt (auto_out_d_bits_corrupt),
    .io_deq_ready        (auto_in_d_ready),
    .io_enq_ready        (auto_out_d_ready),
    .io_deq_valid        (_repeated_repeater_io_deq_valid),
    .io_deq_bits_opcode  (_repeated_repeater_io_deq_bits_opcode),
    .io_deq_bits_param   (_repeated_repeater_io_deq_bits_param),
    .io_deq_bits_size    (_repeated_repeater_io_deq_bits_size),
    .io_deq_bits_source  (_repeated_repeater_io_deq_bits_source),
    .io_deq_bits_sink    (_repeated_repeater_io_deq_bits_sink),
    .io_deq_bits_denied  (_repeated_repeater_io_deq_bits_denied),
    .io_deq_bits_data    (_repeated_repeater_io_deq_bits_data),
    .io_deq_bits_corrupt (_repeated_repeater_io_deq_bits_corrupt)
  );
  assign auto_in_a_ready = nodeIn_a_ready;
  assign auto_in_d_valid = _repeated_repeater_io_deq_valid;
  assign auto_in_d_bits_opcode = _repeated_repeater_io_deq_bits_opcode;
  assign auto_in_d_bits_param = _repeated_repeater_io_deq_bits_param;
  assign auto_in_d_bits_size = _repeated_repeater_io_deq_bits_size;
  assign auto_in_d_bits_source = _repeated_repeater_io_deq_bits_source;
  assign auto_in_d_bits_sink = _repeated_repeater_io_deq_bits_sink;
  assign auto_in_d_bits_denied = _repeated_repeater_io_deq_bits_denied;
  assign auto_in_d_bits_data = (repeat_count ? repeat_sel_hold_r : casez_tmp) & _repeat_limit_T_1[3] | repeat_count ? _repeated_repeater_io_deq_bits_data[127:64] : auto_out_d_bits_data[63:0];
  assign auto_in_d_bits_corrupt = _repeated_repeater_io_deq_bits_corrupt;
  assign auto_out_a_valid = auto_in_a_valid & last;
  assign auto_out_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_a_bits_param = auto_in_a_bits_param;
  assign auto_out_a_bits_size = auto_in_a_bits_size;
  assign auto_out_a_bits_source = auto_in_a_bits_source;
  assign auto_out_a_bits_address = auto_in_a_bits_address;
  assign auto_out_a_bits_mask = {nodeOut_a_bits_mask_acc_13 | nodeOut_a_bits_mask_eq_13 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_13 | nodeOut_a_bits_mask_eq_13 & ~(auto_in_a_bits_address[0]), nodeOut_a_bits_mask_acc_12 | nodeOut_a_bits_mask_eq_12 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_12 | nodeOut_a_bits_mask_eq_12 & ~(auto_in_a_bits_address[0]), nodeOut_a_bits_mask_acc_11 | nodeOut_a_bits_mask_eq_11 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_11 | nodeOut_a_bits_mask_eq_11 & ~(auto_in_a_bits_address[0]), nodeOut_a_bits_mask_acc_10 | nodeOut_a_bits_mask_eq_10 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_10 | nodeOut_a_bits_mask_eq_10 & ~(auto_in_a_bits_address[0]), nodeOut_a_bits_mask_acc_9 | nodeOut_a_bits_mask_eq_9 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_9 | nodeOut_a_bits_mask_eq_9 & ~(auto_in_a_bits_address[0]), nodeOut_a_bits_mask_acc_8 | nodeOut_a_bits_mask_eq_8 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_8 | nodeOut_a_bits_mask_eq_8 & ~(auto_in_a_bits_address[0]), nodeOut_a_bits_mask_acc_7 | nodeOut_a_bits_mask_eq_7 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_7 | nodeOut_a_bits_mask_eq_7 & ~(auto_in_a_bits_address[0]), nodeOut_a_bits_mask_acc_6 | nodeOut_a_bits_mask_eq_6 & auto_in_a_bits_address[0], nodeOut_a_bits_mask_acc_6 | nodeOut_a_bits_mask_eq_6 & ~(auto_in_a_bits_address[0])} & (auto_in_a_bits_opcode[2] ? 16'hFFFF : {auto_in_a_bits_mask, nodeOut_a_bits_mask_masked_enable_0 ? auto_in_a_bits_mask : nodeOut_a_bits_mask_rdata_0});
  assign auto_out_a_bits_data = {auto_in_a_bits_data, nodeOut_a_bits_data_masked_enable_0 ? auto_in_a_bits_data : nodeOut_a_bits_data_rdata_0};
  assign auto_out_a_bits_corrupt = corrupt_out;
endmodule

