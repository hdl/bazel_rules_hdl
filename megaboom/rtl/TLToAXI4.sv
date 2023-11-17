// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLToAXI4(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [4:0]  auto_in_a_bits_source,
  input  [31:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_aw_ready,
                auto_out_w_ready,
                auto_out_b_valid,
  input  [4:0]  auto_out_b_bits_id,
  input  [1:0]  auto_out_b_bits_resp,
  input  [3:0]  auto_out_b_bits_echo_tl_state_size,
  input  [4:0]  auto_out_b_bits_echo_tl_state_source,
  input         auto_out_ar_ready,
                auto_out_r_valid,
  input  [4:0]  auto_out_r_bits_id,
  input  [63:0] auto_out_r_bits_data,
  input  [1:0]  auto_out_r_bits_resp,
  input  [3:0]  auto_out_r_bits_echo_tl_state_size,
  input  [4:0]  auto_out_r_bits_echo_tl_state_source,
  input         auto_out_r_bits_last,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
                auto_in_d_bits_size,
  output [4:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_aw_valid,
  output [4:0]  auto_out_aw_bits_id,
  output [31:0] auto_out_aw_bits_addr,
  output [7:0]  auto_out_aw_bits_len,
  output [2:0]  auto_out_aw_bits_size,
  output [1:0]  auto_out_aw_bits_burst,
  output        auto_out_aw_bits_lock,
  output [3:0]  auto_out_aw_bits_cache,
  output [2:0]  auto_out_aw_bits_prot,
  output [3:0]  auto_out_aw_bits_qos,
                auto_out_aw_bits_echo_tl_state_size,
  output [4:0]  auto_out_aw_bits_echo_tl_state_source,
  output        auto_out_w_valid,
  output [63:0] auto_out_w_bits_data,
  output [7:0]  auto_out_w_bits_strb,
  output        auto_out_w_bits_last,
                auto_out_b_ready,
                auto_out_ar_valid,
  output [4:0]  auto_out_ar_bits_id,
  output [31:0] auto_out_ar_bits_addr,
  output [7:0]  auto_out_ar_bits_len,
  output [2:0]  auto_out_ar_bits_size,
  output [1:0]  auto_out_ar_bits_burst,
  output        auto_out_ar_bits_lock,
  output [3:0]  auto_out_ar_bits_cache,
  output [2:0]  auto_out_ar_bits_prot,
  output [3:0]  auto_out_ar_bits_qos,
                auto_out_ar_bits_echo_tl_state_size,
  output [4:0]  auto_out_ar_bits_echo_tl_state_source,
  output        auto_out_r_ready
);

  wire        _beats1_opdata_T;
  wire        _queue_arw_deq_q_io_enq_ready;
  wire        _queue_arw_deq_q_io_deq_valid;
  wire [4:0]  _queue_arw_deq_q_io_deq_bits_id;
  wire [31:0] _queue_arw_deq_q_io_deq_bits_addr;
  wire [7:0]  _queue_arw_deq_q_io_deq_bits_len;
  wire [2:0]  _queue_arw_deq_q_io_deq_bits_size;
  wire [1:0]  _queue_arw_deq_q_io_deq_bits_burst;
  wire        _queue_arw_deq_q_io_deq_bits_lock;
  wire [3:0]  _queue_arw_deq_q_io_deq_bits_cache;
  wire [2:0]  _queue_arw_deq_q_io_deq_bits_prot;
  wire [3:0]  _queue_arw_deq_q_io_deq_bits_qos;
  wire [3:0]  _queue_arw_deq_q_io_deq_bits_echo_tl_state_size;
  wire [4:0]  _queue_arw_deq_q_io_deq_bits_echo_tl_state_source;
  wire        _queue_arw_deq_q_io_deq_bits_wen;
  wire        _nodeOut_w_deq_q_io_enq_ready;
  assign _beats1_opdata_T = auto_in_a_bits_opcode[2];
  reg         count_20;
  reg         count_19;
  reg         count_18;
  reg         count_17;
  reg         count_16;
  reg         count_15;
  reg         count_14;
  reg         count_13;
  reg         count_12;
  reg         count_11;
  reg         count_10;
  reg         count_9;
  reg         count_8;
  reg         count_7;
  reg         count_6;
  reg         count_5;
  reg         count_4;
  reg         count_3;
  reg         count_2;
  reg         count_1;
  wire        _GEN = auto_in_a_bits_source == 5'h1;
  wire        _GEN_0 = auto_in_a_bits_source == 5'h2;
  wire        _GEN_1 = auto_in_a_bits_source == 5'h3;
  wire        _GEN_2 = auto_in_a_bits_source == 5'h4;
  wire        _GEN_3 = auto_in_a_bits_source == 5'h5;
  wire        _GEN_4 = auto_in_a_bits_source == 5'h6;
  wire        _GEN_5 = auto_in_a_bits_source == 5'h7;
  wire        _GEN_6 = auto_in_a_bits_source == 5'h8;
  wire        _GEN_7 = auto_in_a_bits_source == 5'h9;
  wire        _GEN_8 = auto_in_a_bits_source == 5'hA;
  wire        _GEN_9 = auto_in_a_bits_source == 5'hB;
  wire        _GEN_10 = auto_in_a_bits_source == 5'hC;
  wire        _GEN_11 = auto_in_a_bits_source == 5'hD;
  wire        _GEN_12 = auto_in_a_bits_source == 5'hE;
  wire        _GEN_13 = auto_in_a_bits_source == 5'hF;
  wire        _GEN_14 = auto_in_a_bits_source == 5'h10;
  wire        _GEN_15 = auto_in_a_bits_source == 5'h11;
  wire        _GEN_16 = auto_in_a_bits_source == 5'h12;
  wire        _GEN_17 = auto_in_a_bits_source == 5'h13;
  reg  [2:0]  counter;
  wire        a_first = counter == 3'h0;
  wire        stall = (_GEN_17 ? count_20 : _GEN_16 ? count_19 : _GEN_15 ? count_18 : _GEN_14 ? count_17 : _GEN_13 ? count_16 : _GEN_12 ? count_15 : _GEN_11 ? count_14 : _GEN_10 ? count_13 : _GEN_9 ? count_12 : _GEN_8 ? count_11 : _GEN_7 ? count_10 : _GEN_6 ? count_9 : _GEN_5 ? count_8 : _GEN_4 ? count_7 : _GEN_3 ? count_6 : _GEN_2 ? count_5 : _GEN_1 ? count_4 : _GEN_0 ? count_3 : _GEN ? count_2 : count_1) & a_first;
  reg         doneAW;
  wire        _out_w_valid_T_3 = doneAW | _queue_arw_deq_q_io_enq_ready;
  wire        nodeIn_a_ready = ~stall & (_beats1_opdata_T ? _queue_arw_deq_q_io_enq_ready : _out_w_valid_T_3 & _nodeOut_w_deq_q_io_enq_ready);
  wire [12:0] _beats1_decode_T_1 = 13'h3F << auto_in_a_bits_size;
  wire        a_last = counter == 3'h1 | (_beats1_opdata_T ? 3'h0 : ~(_beats1_decode_T_1[5:3])) == 3'h0;
  wire [4:0]  a_sel_shiftAmount = _GEN_17 ? 5'h13 : _GEN_16 ? 5'h12 : _GEN_15 ? 5'h11 : _GEN_14 ? 5'h10 : _GEN_13 ? 5'hF : _GEN_12 ? 5'hE : _GEN_11 ? 5'hD : _GEN_10 ? 5'hC : _GEN_9 ? 5'hB : _GEN_8 ? 5'hA : _GEN_7 ? 5'h9 : _GEN_6 ? 5'h8 : _GEN_5 ? 5'h7 : _GEN_4 ? 5'h6 : _GEN_3 ? 5'h5 : _GEN_2 ? 5'h4 : _GEN_1 ? 5'h3 : _GEN_0 ? 5'h2 : {4'h0, _GEN};
  wire [17:0] _out_arw_bits_len_T_1 = 18'h7FF << auto_in_a_bits_size;
  wire        out_arw_valid = ~stall & auto_in_a_valid & (_beats1_opdata_T | ~doneAW & _nodeOut_w_deq_q_io_enq_ready);
  reg         r_holds_d;
  reg  [2:0]  b_delay;
  wire        r_wins = auto_out_r_valid & b_delay != 3'h7 | r_holds_d;
  wire        nodeOut_r_ready = auto_in_d_ready & r_wins;
  wire        nodeOut_b_ready = auto_in_d_ready & ~r_wins;
  wire        nodeIn_d_valid = r_wins ? auto_out_r_valid : auto_out_b_valid;
  reg         r_first;
  reg         r_denied_r;
  wire        r_denied = r_first ? (&auto_out_r_bits_resp) : r_denied_r;
  wire [2:0]  nodeIn_d_bits_opcode = {2'h0, r_wins};
  wire [2:0]  nodeIn_d_bits_size = r_wins ? auto_out_r_bits_echo_tl_state_size[2:0] : auto_out_b_bits_echo_tl_state_size[2:0];
  wire [4:0]  nodeIn_d_bits_source = r_wins ? auto_out_r_bits_echo_tl_state_source : auto_out_b_bits_echo_tl_state_source;
  wire        nodeIn_d_bits_denied = r_wins ? r_denied : (|auto_out_b_bits_resp);
  wire        nodeIn_d_bits_corrupt = r_wins & ((|auto_out_r_bits_resp) | r_denied);
  wire [4:0]  d_sel_shiftAmount = r_wins ? auto_out_r_bits_id : auto_out_b_bits_id;
  wire        d_last = ~r_wins | auto_out_r_bits_last;
  wire        _inc_T_19 = _queue_arw_deq_q_io_enq_ready & out_arw_valid;
  wire        inc = a_sel_shiftAmount == 5'h0 & _inc_T_19;
  wire        _dec_T_39 = auto_in_d_ready & nodeIn_d_valid;
  wire        dec = d_sel_shiftAmount == 5'h0 & d_last & _dec_T_39;
  wire        inc_1 = a_sel_shiftAmount == 5'h1 & _inc_T_19;
  wire        dec_1 = d_sel_shiftAmount == 5'h1 & d_last & _dec_T_39;
  wire        inc_2 = a_sel_shiftAmount == 5'h2 & _inc_T_19;
  wire        dec_2 = d_sel_shiftAmount == 5'h2 & d_last & _dec_T_39;
  wire        inc_3 = a_sel_shiftAmount == 5'h3 & _inc_T_19;
  wire        dec_3 = d_sel_shiftAmount == 5'h3 & d_last & _dec_T_39;
  wire        inc_4 = a_sel_shiftAmount == 5'h4 & _inc_T_19;
  wire        dec_4 = d_sel_shiftAmount == 5'h4 & d_last & _dec_T_39;
  wire        inc_5 = a_sel_shiftAmount == 5'h5 & _inc_T_19;
  wire        dec_5 = d_sel_shiftAmount == 5'h5 & d_last & _dec_T_39;
  wire        inc_6 = a_sel_shiftAmount == 5'h6 & _inc_T_19;
  wire        dec_6 = d_sel_shiftAmount == 5'h6 & d_last & _dec_T_39;
  wire        inc_7 = a_sel_shiftAmount == 5'h7 & _inc_T_19;
  wire        dec_7 = d_sel_shiftAmount == 5'h7 & d_last & _dec_T_39;
  wire        inc_8 = a_sel_shiftAmount == 5'h8 & _inc_T_19;
  wire        dec_8 = d_sel_shiftAmount == 5'h8 & d_last & _dec_T_39;
  wire        inc_9 = a_sel_shiftAmount == 5'h9 & _inc_T_19;
  wire        dec_9 = d_sel_shiftAmount == 5'h9 & d_last & _dec_T_39;
  wire        inc_10 = a_sel_shiftAmount == 5'hA & _inc_T_19;
  wire        dec_10 = d_sel_shiftAmount == 5'hA & d_last & _dec_T_39;
  wire        inc_11 = a_sel_shiftAmount == 5'hB & _inc_T_19;
  wire        dec_11 = d_sel_shiftAmount == 5'hB & d_last & _dec_T_39;
  wire        inc_12 = a_sel_shiftAmount == 5'hC & _inc_T_19;
  wire        dec_12 = d_sel_shiftAmount == 5'hC & d_last & _dec_T_39;
  wire        inc_13 = a_sel_shiftAmount == 5'hD & _inc_T_19;
  wire        dec_13 = d_sel_shiftAmount == 5'hD & d_last & _dec_T_39;
  wire        inc_14 = a_sel_shiftAmount == 5'hE & _inc_T_19;
  wire        dec_14 = d_sel_shiftAmount == 5'hE & d_last & _dec_T_39;
  wire        inc_15 = a_sel_shiftAmount == 5'hF & _inc_T_19;
  wire        dec_15 = d_sel_shiftAmount == 5'hF & d_last & _dec_T_39;
  wire        inc_16 = a_sel_shiftAmount == 5'h10 & _inc_T_19;
  wire        dec_16 = d_sel_shiftAmount == 5'h10 & d_last & _dec_T_39;
  wire        inc_17 = a_sel_shiftAmount == 5'h11 & _inc_T_19;
  wire        dec_17 = d_sel_shiftAmount == 5'h11 & d_last & _dec_T_39;
  wire        inc_18 = a_sel_shiftAmount == 5'h12 & _inc_T_19;
  wire        dec_18 = d_sel_shiftAmount == 5'h12 & d_last & _dec_T_39;
  wire        inc_19 = a_sel_shiftAmount == 5'h13 & _inc_T_19;
  wire        dec_19 = d_sel_shiftAmount == 5'h13 & d_last & _dec_T_39;
  always @(posedge clock) begin
    if (reset) begin
      count_20 <= 1'h0;
      count_19 <= 1'h0;
      count_18 <= 1'h0;
      count_17 <= 1'h0;
      count_16 <= 1'h0;
      count_15 <= 1'h0;
      count_14 <= 1'h0;
      count_13 <= 1'h0;
      count_12 <= 1'h0;
      count_11 <= 1'h0;
      count_10 <= 1'h0;
      count_9 <= 1'h0;
      count_8 <= 1'h0;
      count_7 <= 1'h0;
      count_6 <= 1'h0;
      count_5 <= 1'h0;
      count_4 <= 1'h0;
      count_3 <= 1'h0;
      count_2 <= 1'h0;
      count_1 <= 1'h0;
      counter <= 3'h0;
      doneAW <= 1'h0;
      r_holds_d <= 1'h0;
      r_first <= 1'h1;
    end
    else begin
      count_20 <= count_20 + inc_19 - dec_19;
      count_19 <= count_19 + inc_18 - dec_18;
      count_18 <= count_18 + inc_17 - dec_17;
      count_17 <= count_17 + inc_16 - dec_16;
      count_16 <= count_16 + inc_15 - dec_15;
      count_15 <= count_15 + inc_14 - dec_14;
      count_14 <= count_14 + inc_13 - dec_13;
      count_13 <= count_13 + inc_12 - dec_12;
      count_12 <= count_12 + inc_11 - dec_11;
      count_11 <= count_11 + inc_10 - dec_10;
      count_10 <= count_10 + inc_9 - dec_9;
      count_9 <= count_9 + inc_8 - dec_8;
      count_8 <= count_8 + inc_7 - dec_7;
      count_7 <= count_7 + inc_6 - dec_6;
      count_6 <= count_6 + inc_5 - dec_5;
      count_5 <= count_5 + inc_4 - dec_4;
      count_4 <= count_4 + inc_3 - dec_3;
      count_3 <= count_3 + inc_2 - dec_2;
      count_2 <= count_2 + inc_1 - dec_1;
      count_1 <= count_1 + inc - dec;
      if (nodeIn_a_ready & auto_in_a_valid) begin
        if (a_first) begin
          if (_beats1_opdata_T)
            counter <= 3'h0;
          else
            counter <= ~(_beats1_decode_T_1[5:3]);
        end
        else
          counter <= counter - 3'h1;
        doneAW <= ~a_last;
      end
      if (nodeOut_r_ready & auto_out_r_valid) begin
        r_holds_d <= ~auto_out_r_bits_last;
        r_first <= auto_out_r_bits_last;
      end
    end
    if (auto_out_b_valid & ~nodeOut_b_ready)
      b_delay <= b_delay + 3'h1;
    else
      b_delay <= 3'h0;
    if (r_first)
      r_denied_r <= &auto_out_r_bits_resp;
  end // always @(posedge)
  Queue_49 nodeOut_w_deq_q (
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (~stall & auto_in_a_valid & ~_beats1_opdata_T & _out_w_valid_T_3),
    .io_enq_bits_data (auto_in_a_bits_data),
    .io_enq_bits_strb (auto_in_a_bits_mask),
    .io_enq_bits_last (a_last),
    .io_deq_ready     (auto_out_w_ready),
    .io_enq_ready     (_nodeOut_w_deq_q_io_enq_ready),
    .io_deq_valid     (auto_out_w_valid),
    .io_deq_bits_data (auto_out_w_bits_data),
    .io_deq_bits_strb (auto_out_w_bits_strb),
    .io_deq_bits_last (auto_out_w_bits_last)
  );
  Queue_50 queue_arw_deq_q (
    .clock                            (clock),
    .reset                            (reset),
    .io_enq_valid                     (out_arw_valid),
    .io_enq_bits_id                   (a_sel_shiftAmount),
    .io_enq_bits_addr                 (auto_in_a_bits_address),
    .io_enq_bits_len                  (~(_out_arw_bits_len_T_1[10:3])),
    .io_enq_bits_size                 (auto_in_a_bits_size > 3'h2 ? 3'h3 : auto_in_a_bits_size),
    .io_enq_bits_echo_tl_state_size   ({1'h0, auto_in_a_bits_size}),
    .io_enq_bits_echo_tl_state_source (auto_in_a_bits_source),
    .io_enq_bits_wen                  (~_beats1_opdata_T),
    .io_deq_ready                     (_queue_arw_deq_q_io_deq_bits_wen ? auto_out_aw_ready : auto_out_ar_ready),
    .io_enq_ready                     (_queue_arw_deq_q_io_enq_ready),
    .io_deq_valid                     (_queue_arw_deq_q_io_deq_valid),
    .io_deq_bits_id                   (_queue_arw_deq_q_io_deq_bits_id),
    .io_deq_bits_addr                 (_queue_arw_deq_q_io_deq_bits_addr),
    .io_deq_bits_len                  (_queue_arw_deq_q_io_deq_bits_len),
    .io_deq_bits_size                 (_queue_arw_deq_q_io_deq_bits_size),
    .io_deq_bits_burst                (_queue_arw_deq_q_io_deq_bits_burst),
    .io_deq_bits_lock                 (_queue_arw_deq_q_io_deq_bits_lock),
    .io_deq_bits_cache                (_queue_arw_deq_q_io_deq_bits_cache),
    .io_deq_bits_prot                 (_queue_arw_deq_q_io_deq_bits_prot),
    .io_deq_bits_qos                  (_queue_arw_deq_q_io_deq_bits_qos),
    .io_deq_bits_echo_tl_state_size   (_queue_arw_deq_q_io_deq_bits_echo_tl_state_size),
    .io_deq_bits_echo_tl_state_source (_queue_arw_deq_q_io_deq_bits_echo_tl_state_source),
    .io_deq_bits_wen                  (_queue_arw_deq_q_io_deq_bits_wen)
  );
  assign auto_in_a_ready = nodeIn_a_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_opcode = nodeIn_d_bits_opcode;
  assign auto_in_d_bits_size = nodeIn_d_bits_size;
  assign auto_in_d_bits_source = nodeIn_d_bits_source;
  assign auto_in_d_bits_denied = nodeIn_d_bits_denied;
  assign auto_in_d_bits_data = auto_out_r_bits_data;
  assign auto_in_d_bits_corrupt = nodeIn_d_bits_corrupt;
  assign auto_out_aw_valid = _queue_arw_deq_q_io_deq_valid & _queue_arw_deq_q_io_deq_bits_wen;
  assign auto_out_aw_bits_id = _queue_arw_deq_q_io_deq_bits_id;
  assign auto_out_aw_bits_addr = _queue_arw_deq_q_io_deq_bits_addr;
  assign auto_out_aw_bits_len = _queue_arw_deq_q_io_deq_bits_len;
  assign auto_out_aw_bits_size = _queue_arw_deq_q_io_deq_bits_size;
  assign auto_out_aw_bits_burst = _queue_arw_deq_q_io_deq_bits_burst;
  assign auto_out_aw_bits_lock = _queue_arw_deq_q_io_deq_bits_lock;
  assign auto_out_aw_bits_cache = _queue_arw_deq_q_io_deq_bits_cache;
  assign auto_out_aw_bits_prot = _queue_arw_deq_q_io_deq_bits_prot;
  assign auto_out_aw_bits_qos = _queue_arw_deq_q_io_deq_bits_qos;
  assign auto_out_aw_bits_echo_tl_state_size = _queue_arw_deq_q_io_deq_bits_echo_tl_state_size;
  assign auto_out_aw_bits_echo_tl_state_source = _queue_arw_deq_q_io_deq_bits_echo_tl_state_source;
  assign auto_out_b_ready = nodeOut_b_ready;
  assign auto_out_ar_valid = _queue_arw_deq_q_io_deq_valid & ~_queue_arw_deq_q_io_deq_bits_wen;
  assign auto_out_ar_bits_id = _queue_arw_deq_q_io_deq_bits_id;
  assign auto_out_ar_bits_addr = _queue_arw_deq_q_io_deq_bits_addr;
  assign auto_out_ar_bits_len = _queue_arw_deq_q_io_deq_bits_len;
  assign auto_out_ar_bits_size = _queue_arw_deq_q_io_deq_bits_size;
  assign auto_out_ar_bits_burst = _queue_arw_deq_q_io_deq_bits_burst;
  assign auto_out_ar_bits_lock = _queue_arw_deq_q_io_deq_bits_lock;
  assign auto_out_ar_bits_cache = _queue_arw_deq_q_io_deq_bits_cache;
  assign auto_out_ar_bits_prot = _queue_arw_deq_q_io_deq_bits_prot;
  assign auto_out_ar_bits_qos = _queue_arw_deq_q_io_deq_bits_qos;
  assign auto_out_ar_bits_echo_tl_state_size = _queue_arw_deq_q_io_deq_bits_echo_tl_state_size;
  assign auto_out_ar_bits_echo_tl_state_source = _queue_arw_deq_q_io_deq_bits_echo_tl_state_source;
  assign auto_out_r_ready = nodeOut_r_ready;
endmodule

