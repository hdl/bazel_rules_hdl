// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLPLIC(
  input         clock,
                reset,
                auto_int_in_0,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [1:0]  auto_in_a_bits_size,
  input  [10:0] auto_in_a_bits_source,
  input  [27:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
  output        auto_int_out_1_0,
                auto_int_out_0_0,
                auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_size,
  output [10:0] auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data
);

  wire        _out_back_q_io_enq_ready;
  wire        _out_back_q_io_deq_valid;
  wire        _out_back_q_io_deq_bits_read;
  wire [22:0] _out_back_q_io_deq_bits_index;
  wire [63:0] _out_back_q_io_deq_bits_data;
  wire [7:0]  _out_back_q_io_deq_bits_mask;
  wire [10:0] _out_back_q_io_deq_bits_extra_tlrr_extra_source;
  wire [1:0]  _out_back_q_io_deq_bits_extra_tlrr_extra_size;
  wire        _fanin_1_io_dev;
  wire        _fanin_1_io_max;
  wire        _fanin_io_dev;
  wire        _fanin_io_max;
  wire        _gateways_gateway_io_plic_valid;
  reg         priority_0;
  reg         threshold_0;
  reg         threshold_1;
  reg         pending_0;
  reg         enableVec_0;
  reg         enableVec_1;
  reg         maxDevs_0;
  reg         maxDevs_1;
  reg         intnodeOut_0_REG;
  reg         intnodeOut_0_REG_1;
  wire        _out_wofireMux_T = _out_back_q_io_deq_valid & auto_in_d_ready;
  wire        _out_rofireMux_T_1 = _out_wofireMux_T & _out_back_q_io_deq_bits_read;
  wire [3:0]  out_oindex = {_out_back_q_io_deq_bits_index[18], _out_back_q_io_deq_bits_index[10:9], _out_back_q_io_deq_bits_index[4]};
  wire [3:0]  _GEN = {_out_back_q_io_deq_bits_index[18], _out_back_q_io_deq_bits_index[10:9], _out_back_q_io_deq_bits_index[4]};
  wire        out_backSel_10 = _GEN == 4'hA;
  wire        _out_T_11 = {_out_back_q_io_deq_bits_index[22:19], _out_back_q_io_deq_bits_index[17:11], _out_back_q_io_deq_bits_index[8:5], _out_back_q_io_deq_bits_index[3:0]} == 19'h0;
  wire [31:0] _out_womask_T_9 = {{8{_out_back_q_io_deq_bits_mask[7]}}, {8{_out_back_q_io_deq_bits_mask[6]}}, {8{_out_back_q_io_deq_bits_mask[5]}}, {8{_out_back_q_io_deq_bits_mask[4]}}};
  wire        claimer_1 = _out_rofireMux_T_1 & out_backSel_10 & _out_T_11 & (|_out_womask_T_9);
  wire        out_backSel_8 = _GEN == 4'h8;
  wire        claimer_0 = _out_rofireMux_T_1 & out_backSel_8 & _out_T_11 & (|_out_womask_T_9);
  wire        _out_wofireMux_T_2 = _out_wofireMux_T & ~_out_back_q_io_deq_bits_read;
  wire        out_woready_6 = _out_wofireMux_T_2 & out_backSel_10 & _out_T_11;
  wire [1:0]  _GEN_0 = {1'h0, _out_back_q_io_deq_bits_data[32]};
  wire [1:0]  _out_completer_1_T = {enableVec_1, 1'h0} >> _GEN_0;
  wire        completer_1 = out_woready_6 & (&_out_womask_T_9) & _out_completer_1_T[0];
  wire        out_woready_9 = _out_wofireMux_T_2 & out_backSel_8 & _out_T_11;
  wire [1:0]  _out_completer_0_T = {enableVec_0, 1'h0} >> _GEN_0;
  wire        completer_0 = out_woready_9 & (&_out_womask_T_9) & _out_completer_0_T[0];
  wire        _out_out_bits_data_T_7 = out_oindex == 4'h2;
  wire        _out_out_bits_data_T_8 = out_oindex == 4'h4;
  wire        _out_out_bits_data_T_9 = out_oindex == 4'h5;
  wire        _out_out_bits_data_T_10 = out_oindex == 4'h8;
  wire        _out_out_bits_data_T_11 = out_oindex == 4'hA;
  wire        _out_out_bits_data_T_6 = out_oindex == 4'h0;
  wire [2:0]  _GEN_1 = {2'h0, _out_back_q_io_deq_bits_read};
  wire        claiming = claimer_0 & maxDevs_0 | claimer_1 & maxDevs_1;
  always @(posedge clock) begin
    if (_out_wofireMux_T_2 & _GEN == 4'h0 & _out_T_11 & _out_back_q_io_deq_bits_mask[4])
      priority_0 <= _out_back_q_io_deq_bits_data[32];
    if (out_woready_9 & _out_back_q_io_deq_bits_mask[0])
      threshold_0 <= _out_back_q_io_deq_bits_data[0];
    if (out_woready_6 & _out_back_q_io_deq_bits_mask[0])
      threshold_1 <= _out_back_q_io_deq_bits_data[0];
    if (_out_wofireMux_T_2 & _GEN == 4'h4 & _out_T_11 & _out_back_q_io_deq_bits_mask[0])
      enableVec_0 <= _out_back_q_io_deq_bits_data[1];
    if (_out_wofireMux_T_2 & _GEN == 4'h5 & _out_T_11 & _out_back_q_io_deq_bits_mask[0])
      enableVec_1 <= _out_back_q_io_deq_bits_data[1];
    maxDevs_0 <= _fanin_io_dev;
    maxDevs_1 <= _fanin_1_io_dev;
    intnodeOut_0_REG <= _fanin_io_max;
    intnodeOut_0_REG_1 <= _fanin_1_io_max;
    if (reset)
      pending_0 <= 1'h0;
    else if (claiming | _gateways_gateway_io_plic_valid)
      pending_0 <= ~claiming;
  end // always @(posedge)
  LevelGateway gateways_gateway (
    .clock            (clock),
    .reset            (reset),
    .io_interrupt     (auto_int_in_0),
    .io_plic_ready    (~pending_0),
    .io_plic_complete ((completer_0 | completer_1) & _out_back_q_io_deq_bits_data[32]),
    .io_plic_valid    (_gateways_gateway_io_plic_valid)
  );
  PLICFanIn fanin (
    .io_prio_0 (priority_0),
    .io_ip     (enableVec_0 & pending_0),
    .io_dev    (_fanin_io_dev),
    .io_max    (_fanin_io_max)
  );
  PLICFanIn fanin_1 (
    .io_prio_0 (priority_0),
    .io_ip     (enableVec_1 & pending_0),
    .io_dev    (_fanin_1_io_dev),
    .io_max    (_fanin_1_io_max)
  );
  Queue_75 out_back_q (
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_valid                        (auto_in_a_valid),
    .io_enq_bits_read                    (auto_in_a_bits_opcode == 3'h4),
    .io_enq_bits_index                   (auto_in_a_bits_address[25:3]),
    .io_enq_bits_data                    (auto_in_a_bits_data),
    .io_enq_bits_mask                    (auto_in_a_bits_mask),
    .io_enq_bits_extra_tlrr_extra_source (auto_in_a_bits_source),
    .io_enq_bits_extra_tlrr_extra_size   (auto_in_a_bits_size),
    .io_deq_ready                        (auto_in_d_ready),
    .io_enq_ready                        (_out_back_q_io_enq_ready),
    .io_deq_valid                        (_out_back_q_io_deq_valid),
    .io_deq_bits_read                    (_out_back_q_io_deq_bits_read),
    .io_deq_bits_index                   (_out_back_q_io_deq_bits_index),
    .io_deq_bits_data                    (_out_back_q_io_deq_bits_data),
    .io_deq_bits_mask                    (_out_back_q_io_deq_bits_mask),
    .io_deq_bits_extra_tlrr_extra_source (_out_back_q_io_deq_bits_extra_tlrr_extra_source),
    .io_deq_bits_extra_tlrr_extra_size   (_out_back_q_io_deq_bits_extra_tlrr_extra_size)
  );
  assign auto_int_out_1_0 = intnodeOut_0_REG_1 > threshold_1;
  assign auto_int_out_0_0 = intnodeOut_0_REG > threshold_0;
  assign auto_in_a_ready = _out_back_q_io_enq_ready;
  assign auto_in_d_valid = _out_back_q_io_deq_valid;
  assign auto_in_d_bits_opcode = _GEN_1;
  assign auto_in_d_bits_size = _out_back_q_io_deq_bits_extra_tlrr_extra_size;
  assign auto_in_d_bits_source = _out_back_q_io_deq_bits_extra_tlrr_extra_source;
  assign auto_in_d_bits_data = ~(_out_out_bits_data_T_6 | _out_out_bits_data_T_7 | _out_out_bits_data_T_8 | _out_out_bits_data_T_9 | _out_out_bits_data_T_10 | _out_out_bits_data_T_11) | _out_T_11 ? (_out_out_bits_data_T_6 ? {31'h0, priority_0, 32'h0} : _out_out_bits_data_T_7 ? {62'h0, pending_0, 1'h0} : _out_out_bits_data_T_8 ? {62'h0, enableVec_0, 1'h0} : _out_out_bits_data_T_9 ? {62'h0, enableVec_1, 1'h0} : _out_out_bits_data_T_10 ? {31'h0, maxDevs_0, 31'h0, threshold_0} : _out_out_bits_data_T_11 ? {31'h0, maxDevs_1, 31'h0, threshold_1} : 64'h0) : 64'h0;
endmodule

