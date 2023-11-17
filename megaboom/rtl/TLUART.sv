// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLUART(
  input         clock,
                reset,
                auto_control_xing_in_a_valid,
  input  [2:0]  auto_control_xing_in_a_bits_opcode,
                auto_control_xing_in_a_bits_param,
  input  [1:0]  auto_control_xing_in_a_bits_size,
  input  [10:0] auto_control_xing_in_a_bits_source,
  input  [28:0] auto_control_xing_in_a_bits_address,
  input  [7:0]  auto_control_xing_in_a_bits_mask,
  input  [63:0] auto_control_xing_in_a_bits_data,
  input         auto_control_xing_in_a_bits_corrupt,
                auto_control_xing_in_d_ready,
                auto_io_out_rxd,
  output        auto_int_xing_out_sync_0,
                auto_control_xing_in_a_ready,
                auto_control_xing_in_d_valid,
  output [2:0]  auto_control_xing_in_d_bits_opcode,
  output [1:0]  auto_control_xing_in_d_bits_size,
  output [10:0] auto_control_xing_in_d_bits_source,
  output [63:0] auto_control_xing_in_d_bits_data,
  output        auto_io_out_txd
);

  wire        _rxq_io_deq_valid;
  wire [7:0]  _rxq_io_deq_bits;
  wire [8:0]  _rxq_io_count;
  wire        _rxm_io_out_valid;
  wire [7:0]  _rxm_io_out_bits;
  wire        _txq_io_enq_ready;
  wire        _txq_io_deq_valid;
  wire [7:0]  _txq_io_deq_bits;
  wire [8:0]  _txq_io_count;
  wire        _txm_io_in_ready;
  wire        _buffer_auto_out_a_valid;
  wire [2:0]  _buffer_auto_out_a_bits_opcode;
  wire [2:0]  _buffer_auto_out_a_bits_param;
  wire [1:0]  _buffer_auto_out_a_bits_size;
  wire [10:0] _buffer_auto_out_a_bits_source;
  wire [28:0] _buffer_auto_out_a_bits_address;
  wire [7:0]  _buffer_auto_out_a_bits_mask;
  wire [63:0] _buffer_auto_out_a_bits_data;
  wire        _buffer_auto_out_a_bits_corrupt;
  wire        _buffer_auto_out_d_ready;
  reg  [63:0] casez_tmp;
  reg  [15:0] div;
  reg         txen;
  reg         rxen;
  reg  [8:0]  txwm;
  reg  [8:0]  rxwm;
  reg         nstop;
  reg         ie_rxwm;
  reg         ie_txwm;
  wire        ip_txwm = _txq_io_count < txwm;
  wire        ip_rxwm = _rxq_io_count > rxwm;
  wire        in_bits_read = _buffer_auto_out_a_bits_opcode == 3'h4;
  wire        _out_out_bits_data_T_1 = _buffer_auto_out_a_bits_address[11:5] == 7'h0;
  wire        _out_wofireMux_T = _buffer_auto_out_a_valid & _buffer_auto_out_d_ready;
  wire        out_backSel_0 = _buffer_auto_out_a_bits_address[4:3] == 2'h0;
  wire        _out_wofireMux_T_2 = _out_wofireMux_T & ~in_bits_read;
  wire        out_woready_0 = _out_wofireMux_T_2 & out_backSel_0 & _out_out_bits_data_T_1;
  always @(*) begin
    casez (_buffer_auto_out_a_bits_address[4:3])
      2'b00:
        casez_tmp = {~_rxq_io_deq_valid, 23'h0, _rxq_io_deq_bits, ~_txq_io_enq_ready, 31'h0};
      2'b01:
        casez_tmp = {7'h0, rxwm, 15'h0, rxen, 7'h0, txwm, 14'h0, nstop, txen};
      2'b10:
        casez_tmp = {30'h0, ip_rxwm, ip_txwm, 30'h0, ie_rxwm, ie_txwm};
      default:
        casez_tmp = {48'h0, div};
    endcase
  end // always @(*)
  wire [2:0]  _GEN = {2'h0, in_bits_read};
  wire        out_woready_6 = _out_wofireMux_T_2 & _buffer_auto_out_a_bits_address[4:3] == 2'h1 & _out_out_bits_data_T_1;
  wire        out_woready_11 = _out_wofireMux_T_2 & _buffer_auto_out_a_bits_address[4:3] == 2'h2 & _out_out_bits_data_T_1;
  always @(posedge clock) begin
    if (reset) begin
      div <= 16'h10F4;
      txen <= 1'h0;
      rxen <= 1'h0;
      txwm <= 9'h0;
      rxwm <= 9'h0;
      nstop <= 1'h0;
      ie_rxwm <= 1'h0;
      ie_txwm <= 1'h0;
    end
    else begin
      if (_out_wofireMux_T_2 & (&(_buffer_auto_out_a_bits_address[4:3])) & _out_out_bits_data_T_1 & (&{{8{_buffer_auto_out_a_bits_mask[1]}}, {8{_buffer_auto_out_a_bits_mask[0]}}}))
        div <= _buffer_auto_out_a_bits_data[15:0];
      if (out_woready_6 & _buffer_auto_out_a_bits_mask[0])
        txen <= _buffer_auto_out_a_bits_data[0];
      if (out_woready_6 & _buffer_auto_out_a_bits_mask[4])
        rxen <= _buffer_auto_out_a_bits_data[32];
      if (out_woready_6 & (&{_buffer_auto_out_a_bits_mask[3], {8{_buffer_auto_out_a_bits_mask[2]}}}))
        txwm <= _buffer_auto_out_a_bits_data[24:16];
      if (out_woready_6 & (&{_buffer_auto_out_a_bits_mask[7], {8{_buffer_auto_out_a_bits_mask[6]}}}))
        rxwm <= _buffer_auto_out_a_bits_data[56:48];
      if (out_woready_6 & _buffer_auto_out_a_bits_mask[0])
        nstop <= _buffer_auto_out_a_bits_data[1];
      if (out_woready_11 & _buffer_auto_out_a_bits_mask[0])
        ie_rxwm <= _buffer_auto_out_a_bits_data[1];
      if (out_woready_11 & _buffer_auto_out_a_bits_mask[0])
        ie_txwm <= _buffer_auto_out_a_bits_data[0];
    end
  end // always @(posedge)
  TLBuffer_17 buffer (
    .auto_in_a_valid         (auto_control_xing_in_a_valid),
    .auto_in_a_bits_opcode   (auto_control_xing_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_control_xing_in_a_bits_param),
    .auto_in_a_bits_size     (auto_control_xing_in_a_bits_size),
    .auto_in_a_bits_source   (auto_control_xing_in_a_bits_source),
    .auto_in_a_bits_address  (auto_control_xing_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_control_xing_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_control_xing_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_control_xing_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_control_xing_in_d_ready),
    .auto_out_a_ready        (_buffer_auto_out_d_ready),
    .auto_out_d_valid        (_buffer_auto_out_a_valid),
    .auto_out_d_bits_opcode  (_GEN),
    .auto_out_d_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_out_d_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_out_d_bits_data    (_out_out_bits_data_T_1 ? casez_tmp : 64'h0),
    .auto_in_a_ready         (auto_control_xing_in_a_ready),
    .auto_in_d_valid         (auto_control_xing_in_d_valid),
    .auto_in_d_bits_opcode   (auto_control_xing_in_d_bits_opcode),
    .auto_in_d_bits_size     (auto_control_xing_in_d_bits_size),
    .auto_in_d_bits_source   (auto_control_xing_in_d_bits_source),
    .auto_in_d_bits_data     (auto_control_xing_in_d_bits_data),
    .auto_out_a_valid        (_buffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_auto_out_d_ready)
  );
  IntSyncCrossingSource_1 intsource (
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (ip_txwm & ie_txwm | ip_rxwm & ie_rxwm),
    .auto_out_sync_0 (auto_int_xing_out_sync_0)
  );
  UARTTx txm (
    .clock       (clock),
    .reset       (reset),
    .io_en       (txen),
    .io_in_valid (_txq_io_deq_valid),
    .io_in_bits  (_txq_io_deq_bits),
    .io_div      (div),
    .io_nstop    (nstop),
    .io_in_ready (_txm_io_in_ready),
    .io_out      (auto_io_out_txd)
  );
  Queue_76 txq (
    .clock        (clock),
    .reset        (reset),
    .io_enq_valid (out_woready_0 & _buffer_auto_out_a_bits_mask[0] & ~(out_woready_0 & _buffer_auto_out_a_bits_mask[3] & _buffer_auto_out_a_bits_data[31])),
    .io_enq_bits  (_buffer_auto_out_a_bits_data[7:0]),
    .io_deq_ready (_txm_io_in_ready),
    .io_enq_ready (_txq_io_enq_ready),
    .io_deq_valid (_txq_io_deq_valid),
    .io_deq_bits  (_txq_io_deq_bits),
    .io_count     (_txq_io_count)
  );
  UARTRx rxm (
    .clock        (clock),
    .reset        (reset),
    .io_en        (rxen),
    .io_in        (auto_io_out_rxd),
    .io_div       (div),
    .io_out_valid (_rxm_io_out_valid),
    .io_out_bits  (_rxm_io_out_bits)
  );
  Queue_76 rxq (
    .clock        (clock),
    .reset        (reset),
    .io_enq_valid (_rxm_io_out_valid),
    .io_enq_bits  (_rxm_io_out_bits),
    .io_deq_ready (_out_wofireMux_T & in_bits_read & out_backSel_0 & _out_out_bits_data_T_1 & _buffer_auto_out_a_bits_mask[4]),
    .io_enq_ready (/* unused */),
    .io_deq_valid (_rxq_io_deq_valid),
    .io_deq_bits  (_rxq_io_deq_bits),
    .io_count     (_rxq_io_count)
  );
endmodule

