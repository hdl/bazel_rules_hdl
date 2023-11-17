// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module InclusiveCacheControl(
  input         clock,
                reset,
                auto_ctrl_in_a_valid,
  input  [2:0]  auto_ctrl_in_a_bits_opcode,
                auto_ctrl_in_a_bits_param,
  input  [1:0]  auto_ctrl_in_a_bits_size,
  input  [10:0] auto_ctrl_in_a_bits_source,
  input  [25:0] auto_ctrl_in_a_bits_address,
  input  [7:0]  auto_ctrl_in_a_bits_mask,
  input  [63:0] auto_ctrl_in_a_bits_data,
  input         auto_ctrl_in_a_bits_corrupt,
                auto_ctrl_in_d_ready,
                io_flush_match,
                io_flush_req_ready,
                io_flush_resp,
  output        auto_ctrl_in_a_ready,
                auto_ctrl_in_d_valid,
  output [2:0]  auto_ctrl_in_d_bits_opcode,
  output [1:0]  auto_ctrl_in_d_bits_size,
  output [10:0] auto_ctrl_in_d_bits_source,
  output [63:0] auto_ctrl_in_d_bits_data,
  output        io_flush_req_valid,
  output [63:0] io_flush_req_bits
);

  wire        _out_back_q_io_enq_ready;
  wire        _out_back_q_io_deq_valid;
  wire        _out_back_q_io_deq_bits_read;
  wire [8:0]  _out_back_q_io_deq_bits_index;
  wire [7:0]  _out_back_q_io_deq_bits_mask;
  wire [10:0] _out_back_q_io_deq_bits_extra_tlrr_extra_source;
  wire [1:0]  _out_back_q_io_deq_bits_extra_tlrr_extra_size;
  reg         flushInValid;
  reg  [63:0] flushInAddress;
  reg         flushOutValid;
  wire [1:0]  out_oindex = {_out_back_q_io_deq_bits_index[6], _out_back_q_io_deq_bits_index[3]};
  wire [6:0]  _GEN = {_out_back_q_io_deq_bits_index[8:7], _out_back_q_io_deq_bits_index[5:4], _out_back_q_io_deq_bits_index[2:0]};
  wire [7:0]  _out_backMask_T_15 = {8{_out_back_q_io_deq_bits_mask[3]}};
  wire [7:0]  _out_backMask_T_13 = {8{_out_back_q_io_deq_bits_mask[2]}};
  wire [7:0]  _out_backMask_T_11 = {8{_out_back_q_io_deq_bits_mask[1]}};
  wire [7:0]  _out_backMask_T_9 = {8{_out_back_q_io_deq_bits_mask[0]}};
  wire [63:0] out_backMask = {{8{_out_back_q_io_deq_bits_mask[7]}}, {8{_out_back_q_io_deq_bits_mask[6]}}, {8{_out_back_q_io_deq_bits_mask[5]}}, {8{_out_back_q_io_deq_bits_mask[4]}}, _out_backMask_T_15, _out_backMask_T_13, _out_backMask_T_11, _out_backMask_T_9};
  wire [31:0] _out_romask_T_5 = {_out_backMask_T_15, _out_backMask_T_13, _out_backMask_T_11, _out_backMask_T_9};
  wire        in_bits_read = auto_ctrl_in_a_bits_opcode == 3'h4;
  wire [6:0]  _GEN_0 = {auto_ctrl_in_a_bits_address[11:10], auto_ctrl_in_a_bits_address[8:7], auto_ctrl_in_a_bits_address[5:3]};
  wire [7:0]  _out_frontMask_T_9 = {8{auto_ctrl_in_a_bits_mask[0]}};
  wire [7:0]  _out_frontMask_T_11 = {8{auto_ctrl_in_a_bits_mask[1]}};
  wire [7:0]  _out_frontMask_T_13 = {8{auto_ctrl_in_a_bits_mask[2]}};
  wire [7:0]  _out_frontMask_T_15 = {8{auto_ctrl_in_a_bits_mask[3]}};
  wire [63:0] out_frontMask = {{8{auto_ctrl_in_a_bits_mask[7]}}, {8{auto_ctrl_in_a_bits_mask[6]}}, {8{auto_ctrl_in_a_bits_mask[5]}}, {8{auto_ctrl_in_a_bits_mask[4]}}, _out_frontMask_T_15, _out_frontMask_T_13, _out_frontMask_T_11, _out_frontMask_T_9};
  wire [1:0]  out_iindex = {auto_ctrl_in_a_bits_address[9], auto_ctrl_in_a_bits_address[6]};
  wire [31:0] _out_wimask_T_5 = {_out_frontMask_T_15, _out_frontMask_T_13, _out_frontMask_T_11, _out_frontMask_T_9};
  wire        _GEN_1 = out_oindex == 2'h1;
  wire        _GEN_2 = out_oindex == 2'h2;
  wire        out_iready = in_bits_read | ((&out_iindex) ? ~flushInValid | ~(&_out_wimask_T_5) | (|_GEN_0) : out_iindex != 2'h2 | ~flushInValid | ~(&out_frontMask) | (|_GEN_0));
  wire        out_oready = _out_back_q_io_deq_bits_read | ((&out_oindex) ? flushOutValid | ~(&_out_romask_T_5) | (|_GEN) : ~_GEN_2 | flushOutValid | ~(&out_backMask) | (|_GEN));
  wire        in_ready = _out_back_q_io_enq_ready & out_iready;
  wire        out_valid = _out_back_q_io_deq_valid & out_oready;
  wire [2:0]  _GEN_3 = {2'h0, _out_back_q_io_deq_bits_read};
  wire        _out_wofireMux_T_2 = _out_back_q_io_deq_valid & auto_ctrl_in_d_ready & ~_out_back_q_io_deq_bits_read;
  wire [1:0]  _GEN_4 = {_out_back_q_io_deq_bits_index[6], _out_back_q_io_deq_bits_index[3]};
  wire        _GEN_5 = ~io_flush_match & flushInValid;
  wire        _out_wifireMux_T_2 = auto_ctrl_in_a_valid & _out_back_q_io_enq_ready & ~in_bits_read;
  wire [1:0]  _GEN_6 = {auto_ctrl_in_a_bits_address[9], auto_ctrl_in_a_bits_address[6]};
  wire        out_f_wivalid_4 = _out_wifireMux_T_2 & _GEN_6 == 2'h2 & ~(|_GEN_0) & (&out_frontMask);
  wire        out_f_wivalid_5 = _out_wifireMux_T_2 & (&_GEN_6) & ~(|_GEN_0) & (&_out_wimask_T_5);
  always @(posedge clock) begin
    if (reset) begin
      flushInValid <= 1'h0;
      flushOutValid <= 1'h0;
    end
    else begin
      flushInValid <= out_f_wivalid_5 | out_f_wivalid_4 | ~(_GEN_5 | io_flush_req_ready) & flushInValid;
      flushOutValid <= _GEN_5 | io_flush_resp | ~(_out_wofireMux_T_2 & (&_GEN_4) & ~(|_GEN) & (&_out_romask_T_5) | _out_wofireMux_T_2 & _GEN_4 == 2'h2 & ~(|_GEN) & (&out_backMask)) & flushOutValid;
    end
    if (out_f_wivalid_5 & ~flushInValid)
      flushInAddress <= {28'h0, auto_ctrl_in_a_bits_data[31:0], 4'h0};
    else if (out_f_wivalid_4 & ~flushInValid)
      flushInAddress <= auto_ctrl_in_a_bits_data;
  end // always @(posedge)
  Queue_51 out_back_q (
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_valid                        (auto_ctrl_in_a_valid & out_iready),
    .io_enq_bits_read                    (in_bits_read),
    .io_enq_bits_index                   (auto_ctrl_in_a_bits_address[11:3]),
    .io_enq_bits_mask                    (auto_ctrl_in_a_bits_mask),
    .io_enq_bits_extra_tlrr_extra_source (auto_ctrl_in_a_bits_source),
    .io_enq_bits_extra_tlrr_extra_size   (auto_ctrl_in_a_bits_size),
    .io_deq_ready                        (auto_ctrl_in_d_ready & out_oready),
    .io_enq_ready                        (_out_back_q_io_enq_ready),
    .io_deq_valid                        (_out_back_q_io_deq_valid),
    .io_deq_bits_read                    (_out_back_q_io_deq_bits_read),
    .io_deq_bits_index                   (_out_back_q_io_deq_bits_index),
    .io_deq_bits_mask                    (_out_back_q_io_deq_bits_mask),
    .io_deq_bits_extra_tlrr_extra_source (_out_back_q_io_deq_bits_extra_tlrr_extra_source),
    .io_deq_bits_extra_tlrr_extra_size   (_out_back_q_io_deq_bits_extra_tlrr_extra_size)
  );
  assign auto_ctrl_in_a_ready = in_ready;
  assign auto_ctrl_in_d_valid = out_valid;
  assign auto_ctrl_in_d_bits_opcode = _GEN_3;
  assign auto_ctrl_in_d_bits_size = _out_back_q_io_deq_bits_extra_tlrr_extra_size;
  assign auto_ctrl_in_d_bits_source = _out_back_q_io_deq_bits_extra_tlrr_extra_source;
  assign auto_ctrl_in_d_bits_data = ~(~((&out_oindex) | _GEN_2) & _GEN_1 | ~(|_GEN)) | (&out_oindex) | _GEN_2 | _GEN_1 ? 64'h0 : 64'h60A0801;
  assign io_flush_req_valid = flushInValid;
  assign io_flush_req_bits = flushInAddress;
endmodule

