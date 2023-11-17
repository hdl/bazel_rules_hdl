// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLCacheCork(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [3:0]  auto_in_a_bits_source,
  input  [31:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_c_valid,
  input  [2:0]  auto_in_c_bits_opcode,
                auto_in_c_bits_param,
                auto_in_c_bits_size,
  input  [3:0]  auto_in_c_bits_source,
  input  [31:0] auto_in_c_bits_address,
  input  [63:0] auto_in_c_bits_data,
  input         auto_in_c_bits_corrupt,
                auto_in_d_ready,
                auto_in_e_valid,
  input  [2:0]  auto_in_e_bits_sink,
  input         auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
                auto_out_d_bits_size,
  input  [4:0]  auto_out_d_bits_source,
  input         auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_c_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_param,
  output [2:0]  auto_in_d_bits_size,
  output [3:0]  auto_in_d_bits_source,
  output [2:0]  auto_in_d_bits_sink,
  output        auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
                auto_out_a_bits_size,
  output [4:0]  auto_out_a_bits_source,
  output [31:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire        _q_1_io_enq_ready;
  wire        _q_1_io_deq_valid;
  wire [2:0]  _q_1_io_deq_bits_opcode;
  wire [1:0]  _q_1_io_deq_bits_param;
  wire [2:0]  _q_1_io_deq_bits_size;
  wire [3:0]  _q_1_io_deq_bits_source;
  wire        _q_1_io_deq_bits_denied;
  wire [63:0] _q_1_io_deq_bits_data;
  wire        _q_1_io_deq_bits_corrupt;
  wire        _q_io_enq_ready;
  wire        _q_io_deq_valid;
  wire [2:0]  _q_io_deq_bits_opcode;
  wire [1:0]  _q_io_deq_bits_param;
  wire [2:0]  _q_io_deq_bits_size;
  wire [3:0]  _q_io_deq_bits_source;
  wire        _q_io_deq_bits_denied;
  wire [63:0] _q_io_deq_bits_data;
  wire        _q_io_deq_bits_corrupt;
  wire        _pool_io_alloc_valid;
  wire [2:0]  _pool_io_alloc_bits;
  wire        _toD_T = auto_in_a_bits_opcode == 3'h6;
  wire        toD = _toD_T & auto_in_a_bits_param == 3'h2 | (&auto_in_a_bits_opcode);
  reg  [2:0]  beatsLeft;
  wire        idle = beatsLeft == 3'h0;
  wire        a_a_valid = auto_in_a_valid & ~toD;
  wire        c_a_valid = auto_in_c_valid & (&auto_in_c_bits_opcode);
  reg         state__1;
  wire        nodeIn_a_ready = toD ? _q_1_io_enq_ready : auto_out_a_ready & (idle ? ~c_a_valid : state__1);
  wire        _GEN = _toD_T | (&auto_in_a_bits_opcode);
  wire [2:0]  a_a_bits_opcode = _GEN ? 3'h4 : auto_in_a_bits_opcode;
  wire        _c_a_bits_a_mask_T = auto_in_c_bits_size > 3'h2;
  wire        c_a_bits_a_mask_size = auto_in_c_bits_size[1:0] == 2'h2;
  wire        c_a_bits_a_mask_acc = _c_a_bits_a_mask_T | c_a_bits_a_mask_size & ~(auto_in_c_bits_address[2]);
  wire        c_a_bits_a_mask_acc_1 = _c_a_bits_a_mask_T | c_a_bits_a_mask_size & auto_in_c_bits_address[2];
  wire        c_a_bits_a_mask_size_1 = auto_in_c_bits_size[1:0] == 2'h1;
  wire        c_a_bits_a_mask_eq_2 = ~(auto_in_c_bits_address[2]) & ~(auto_in_c_bits_address[1]);
  wire        c_a_bits_a_mask_acc_2 = c_a_bits_a_mask_acc | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_2;
  wire        c_a_bits_a_mask_eq_3 = ~(auto_in_c_bits_address[2]) & auto_in_c_bits_address[1];
  wire        c_a_bits_a_mask_acc_3 = c_a_bits_a_mask_acc | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_3;
  wire        c_a_bits_a_mask_eq_4 = auto_in_c_bits_address[2] & ~(auto_in_c_bits_address[1]);
  wire        c_a_bits_a_mask_acc_4 = c_a_bits_a_mask_acc_1 | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_4;
  wire        c_a_bits_a_mask_eq_5 = auto_in_c_bits_address[2] & auto_in_c_bits_address[1];
  wire        c_a_bits_a_mask_acc_5 = c_a_bits_a_mask_acc_1 | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_5;
  wire        _nodeIn_c_ready_T = auto_in_c_bits_opcode == 3'h6;
  reg         state__0;
  wire        nodeIn_c_ready = _nodeIn_c_ready_T ? _q_io_enq_ready : auto_out_a_ready & (idle | state__0);
  reg  [2:0]  d_first_counter;
  reg  [2:0]  beatsLeft_1;
  wire        idle_1 = beatsLeft_1 == 3'h0;
  wire        _GEN_0 = _q_io_deq_valid | auto_out_d_valid;
  reg         state_1_0;
  wire        muxState_1_0 = idle_1 ? auto_out_d_valid : state_1_0;
  wire        _GEN_1 = auto_out_d_bits_opcode == 3'h1 & auto_out_d_bits_source[0];
  wire [2:0]  d_d_bits_opcode = auto_out_d_bits_opcode == 3'h0 & ~(auto_out_d_bits_source[0]) ? 3'h6 : _GEN_1 ? 3'h5 : auto_out_d_bits_opcode;
  wire        winner_1_1 = ~auto_out_d_valid & _q_io_deq_valid;
  reg         state_1_1;
  wire        muxState_1_1 = idle_1 ? winner_1_1 : state_1_1;
  wire        winner_1_2 = ~_GEN_0 & _q_1_io_deq_valid;
  reg         state_1_2;
  wire        muxState_1_2 = idle_1 ? winner_1_2 : state_1_2;
  wire [2:0]  in_d_bits_opcode = (muxState_1_0 ? d_d_bits_opcode : 3'h0) | (muxState_1_1 ? _q_io_deq_bits_opcode : 3'h0) | (muxState_1_2 ? _q_1_io_deq_bits_opcode : 3'h0);
  wire        d_grant = in_d_bits_opcode == 3'h5 | in_d_bits_opcode == 3'h4;
  wire        in_d_ready = auto_in_d_ready & (_pool_io_alloc_valid | (|d_first_counter) | ~d_grant);
  wire        _in_d_valid_T = auto_out_d_valid | _q_io_deq_valid;
  wire        in_d_valid = idle_1 ? _in_d_valid_T | _q_1_io_deq_valid : state_1_0 & auto_out_d_valid | state_1_1 & _q_io_deq_valid | state_1_2 & _q_1_io_deq_valid;
  wire [2:0]  in_d_bits_size = (muxState_1_0 ? auto_out_d_bits_size : 3'h0) | (muxState_1_1 ? _q_io_deq_bits_size : 3'h0) | (muxState_1_2 ? _q_1_io_deq_bits_size : 3'h0);
  wire        nodeIn_d_valid = in_d_valid & (_pool_io_alloc_valid | (|d_first_counter) | ~d_grant);
  reg  [2:0]  nodeIn_d_bits_sink_r;
  wire [2:0]  nodeIn_d_bits_sink = (|d_first_counter) ? nodeIn_d_bits_sink_r : _pool_io_alloc_bits;
  reg         wSourceVec_0;
  reg         wSourceVec_1;
  reg         wSourceVec_2;
  reg         wSourceVec_3;
  reg         wSourceVec_4;
  reg         wSourceVec_5;
  reg         wSourceVec_6;
  reg         wSourceVec_7;
  reg         wSourceVec_8;
  reg         wSourceVec_9;
  wire        _GEN_2 = auto_out_d_bits_source[4:1] == 4'h1;
  wire        _GEN_3 = auto_out_d_bits_source[4:1] == 4'h2;
  wire        _GEN_4 = auto_out_d_bits_source[4:1] == 4'h3;
  wire        _GEN_5 = auto_out_d_bits_source[4:1] == 4'h4;
  wire        _GEN_6 = auto_out_d_bits_source[4:1] == 4'h5;
  wire        _GEN_7 = auto_out_d_bits_source[4:1] == 4'h6;
  wire        _GEN_8 = auto_out_d_bits_source[4:1] == 4'h7;
  wire        _GEN_9 = auto_out_d_bits_source[4:1] == 4'h8;
  wire        _GEN_10 = auto_out_d_bits_source[4:1] == 4'h9;
  reg         dWHeld_r;
  wire        winner__1 = ~c_a_valid & a_a_valid;
  wire        _nodeOut_a_valid_T = c_a_valid | a_a_valid;
  wire        nodeOut_a_valid = idle ? _nodeOut_a_valid_T : state__0 & c_a_valid | state__1 & a_a_valid;
  wire        muxState__0 = idle ? c_a_valid : state__0;
  wire        muxState__1 = idle ? winner__1 : state__1;
  wire        in_d_bits_corrupt = muxState_1_0 & auto_out_d_bits_corrupt | muxState_1_1 & _q_io_deq_bits_corrupt | muxState_1_2 & _q_1_io_deq_bits_corrupt;
  wire        in_d_bits_denied = muxState_1_0 & auto_out_d_bits_denied | muxState_1_1 & _q_io_deq_bits_denied | muxState_1_2 & _q_1_io_deq_bits_denied;
  wire [3:0]  in_d_bits_source = (muxState_1_0 ? auto_out_d_bits_source[4:1] : 4'h0) | (muxState_1_1 ? _q_io_deq_bits_source : 4'h0) | (muxState_1_2 ? _q_1_io_deq_bits_source : 4'h0);
  wire [1:0]  in_d_bits_param = (muxState_1_0 & _GEN_1 ? {1'h0, ~((|d_first_counter) ? dWHeld_r : _GEN_10 ? wSourceVec_9 : _GEN_9 ? wSourceVec_8 : _GEN_8 ? wSourceVec_7 : _GEN_7 ? wSourceVec_6 : _GEN_6 ? wSourceVec_5 : _GEN_5 ? wSourceVec_4 : _GEN_4 ? wSourceVec_3 : _GEN_3 ? wSourceVec_2 : _GEN_2 ? wSourceVec_1 : wSourceVec_0)} : 2'h0) | (muxState_1_1 ? _q_io_deq_bits_param : 2'h0) | (muxState_1_2 ? _q_1_io_deq_bits_param : 2'h0);
  wire [12:0] _decode_T_5 = 13'h3F << auto_in_a_bits_size;
  wire [12:0] _decode_T_1 = 13'h3F << auto_in_c_bits_size;
  wire [12:0] _d_first_beats1_decode_T_1 = 13'h3F << in_d_bits_size;
  wire [12:0] _decode_T_9 = 13'h3F << auto_out_d_bits_size;
  wire        _beatsLeft_T_4 = in_d_ready & in_d_valid;
  wire        _GEN_11 = nodeIn_a_ready & auto_in_a_valid;
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 3'h0;
      state__1 <= 1'h0;
      state__0 <= 1'h0;
      d_first_counter <= 3'h0;
      beatsLeft_1 <= 3'h0;
      state_1_0 <= 1'h0;
      state_1_1 <= 1'h0;
      state_1_2 <= 1'h0;
    end
    else begin
      if (idle & auto_out_a_ready)
        beatsLeft <= (c_a_valid ? ~(_decode_T_1[5:3]) : 3'h0) | (winner__1 & ~(a_a_bits_opcode[2]) ? ~(_decode_T_5[5:3]) : 3'h0);
      else
        beatsLeft <= beatsLeft - {2'h0, auto_out_a_ready & nodeOut_a_valid};
      if (idle) begin
        state__1 <= winner__1;
        state__0 <= c_a_valid;
      end
      if (_beatsLeft_T_4) begin
        if (|d_first_counter)
          d_first_counter <= d_first_counter - 3'h1;
        else if (in_d_bits_opcode[0])
          d_first_counter <= ~(_d_first_beats1_decode_T_1[5:3]);
        else
          d_first_counter <= 3'h0;
      end
      if (idle_1 & in_d_ready) begin
        if (auto_out_d_valid & d_d_bits_opcode[0])
          beatsLeft_1 <= ~(_decode_T_9[5:3]);
        else
          beatsLeft_1 <= 3'h0;
      end
      else
        beatsLeft_1 <= beatsLeft_1 - {2'h0, _beatsLeft_T_4};
      if (idle_1) begin
        state_1_0 <= auto_out_d_valid;
        state_1_1 <= winner_1_1;
        state_1_2 <= winner_1_2;
      end
    end
    if (~(|d_first_counter)) begin
      nodeIn_d_bits_sink_r <= _pool_io_alloc_bits;
      if (_GEN_10)
        dWHeld_r <= wSourceVec_9;
      else if (_GEN_9)
        dWHeld_r <= wSourceVec_8;
      else if (_GEN_8)
        dWHeld_r <= wSourceVec_7;
      else if (_GEN_7)
        dWHeld_r <= wSourceVec_6;
      else if (_GEN_6)
        dWHeld_r <= wSourceVec_5;
      else if (_GEN_5)
        dWHeld_r <= wSourceVec_4;
      else if (_GEN_4)
        dWHeld_r <= wSourceVec_3;
      else if (_GEN_3)
        dWHeld_r <= wSourceVec_2;
      else if (_GEN_2)
        dWHeld_r <= wSourceVec_1;
      else
        dWHeld_r <= wSourceVec_0;
    end
    wSourceVec_0 <= _GEN_11 & auto_in_a_bits_source == 4'h0 | wSourceVec_0;
    wSourceVec_1 <= _GEN_11 & auto_in_a_bits_source == 4'h1 | wSourceVec_1;
    wSourceVec_2 <= _GEN_11 & auto_in_a_bits_source == 4'h2 | wSourceVec_2;
    wSourceVec_3 <= _GEN_11 & auto_in_a_bits_source == 4'h3 | wSourceVec_3;
    wSourceVec_4 <= _GEN_11 & auto_in_a_bits_source == 4'h4 | wSourceVec_4;
    wSourceVec_5 <= _GEN_11 & auto_in_a_bits_source == 4'h5 | wSourceVec_5;
    wSourceVec_6 <= _GEN_11 & auto_in_a_bits_source == 4'h6 | wSourceVec_6;
    wSourceVec_7 <= _GEN_11 & auto_in_a_bits_source == 4'h7 | wSourceVec_7;
    wSourceVec_8 <= _GEN_11 & auto_in_a_bits_source == 4'h8 | wSourceVec_8;
    wSourceVec_9 <= _GEN_11 & auto_in_a_bits_source == 4'h9 | wSourceVec_9;
  end // always @(posedge)
  IDPool pool (
    .clock          (clock),
    .reset          (reset),
    .io_free_valid  (auto_in_e_valid),
    .io_free_bits   (auto_in_e_bits_sink),
    .io_alloc_ready (auto_in_d_ready & nodeIn_d_valid & ~(|d_first_counter) & d_grant),
    .io_alloc_valid (_pool_io_alloc_valid),
    .io_alloc_bits  (_pool_io_alloc_bits)
  );
  Queue_59 q (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_c_valid & _nodeIn_c_ready_T),
    .io_enq_bits_opcode  (3'h6),
    .io_enq_bits_param   (2'h0),
    .io_enq_bits_size    (auto_in_c_bits_size),
    .io_enq_bits_source  (auto_in_c_bits_source),
    .io_enq_bits_sink    (3'h0),
    .io_enq_bits_denied  (1'h0),
    .io_enq_bits_data    (64'h0),
    .io_enq_bits_corrupt (1'h0),
    .io_deq_ready        (in_d_ready & (idle_1 ? ~auto_out_d_valid : state_1_1)),
    .io_enq_ready        (_q_io_enq_ready),
    .io_deq_valid        (_q_io_deq_valid),
    .io_deq_bits_opcode  (_q_io_deq_bits_opcode),
    .io_deq_bits_param   (_q_io_deq_bits_param),
    .io_deq_bits_size    (_q_io_deq_bits_size),
    .io_deq_bits_source  (_q_io_deq_bits_source),
    .io_deq_bits_sink    (/* unused */),
    .io_deq_bits_denied  (_q_io_deq_bits_denied),
    .io_deq_bits_data    (_q_io_deq_bits_data),
    .io_deq_bits_corrupt (_q_io_deq_bits_corrupt)
  );
  Queue_59 q_1 (
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_a_valid & toD),
    .io_enq_bits_opcode  (3'h4),
    .io_enq_bits_param   (2'h0),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_sink    (3'h0),
    .io_enq_bits_denied  (1'h0),
    .io_enq_bits_data    (64'h0),
    .io_enq_bits_corrupt (1'h0),
    .io_deq_ready        (in_d_ready & (idle_1 ? ~_GEN_0 : state_1_2)),
    .io_enq_ready        (_q_1_io_enq_ready),
    .io_deq_valid        (_q_1_io_deq_valid),
    .io_deq_bits_opcode  (_q_1_io_deq_bits_opcode),
    .io_deq_bits_param   (_q_1_io_deq_bits_param),
    .io_deq_bits_size    (_q_1_io_deq_bits_size),
    .io_deq_bits_source  (_q_1_io_deq_bits_source),
    .io_deq_bits_sink    (/* unused */),
    .io_deq_bits_denied  (_q_1_io_deq_bits_denied),
    .io_deq_bits_data    (_q_1_io_deq_bits_data),
    .io_deq_bits_corrupt (_q_1_io_deq_bits_corrupt)
  );
  assign auto_in_a_ready = nodeIn_a_ready;
  assign auto_in_c_ready = nodeIn_c_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_opcode = in_d_bits_opcode;
  assign auto_in_d_bits_param = in_d_bits_param;
  assign auto_in_d_bits_size = in_d_bits_size;
  assign auto_in_d_bits_source = in_d_bits_source;
  assign auto_in_d_bits_sink = nodeIn_d_bits_sink;
  assign auto_in_d_bits_denied = in_d_bits_denied;
  assign auto_in_d_bits_data = (muxState_1_0 ? auto_out_d_bits_data : 64'h0) | (muxState_1_1 ? _q_io_deq_bits_data : 64'h0) | (muxState_1_2 ? _q_1_io_deq_bits_data : 64'h0);
  assign auto_in_d_bits_corrupt = in_d_bits_corrupt;
  assign auto_out_a_valid = nodeOut_a_valid;
  assign auto_out_a_bits_opcode = muxState__1 ? a_a_bits_opcode : 3'h0;
  assign auto_out_a_bits_param = ~muxState__1 | _GEN ? 3'h0 : auto_in_a_bits_param;
  assign auto_out_a_bits_size = (muxState__0 ? auto_in_c_bits_size : 3'h0) | (muxState__1 ? auto_in_a_bits_size : 3'h0);
  assign auto_out_a_bits_source = (muxState__0 ? {auto_in_c_bits_source, 1'h0} : 5'h0) | (muxState__1 ? {auto_in_a_bits_source, _GEN | auto_in_a_bits_opcode == 3'h0 | auto_in_a_bits_opcode == 3'h1} : 5'h0);
  assign auto_out_a_bits_address = (muxState__0 ? auto_in_c_bits_address : 32'h0) | (muxState__1 ? auto_in_a_bits_address : 32'h0);
  assign auto_out_a_bits_mask = (muxState__0 ? {c_a_bits_a_mask_acc_5 | c_a_bits_a_mask_eq_5 & auto_in_c_bits_address[0], c_a_bits_a_mask_acc_5 | c_a_bits_a_mask_eq_5 & ~(auto_in_c_bits_address[0]), c_a_bits_a_mask_acc_4 | c_a_bits_a_mask_eq_4 & auto_in_c_bits_address[0], c_a_bits_a_mask_acc_4 | c_a_bits_a_mask_eq_4 & ~(auto_in_c_bits_address[0]), c_a_bits_a_mask_acc_3 | c_a_bits_a_mask_eq_3 & auto_in_c_bits_address[0], c_a_bits_a_mask_acc_3 | c_a_bits_a_mask_eq_3 & ~(auto_in_c_bits_address[0]), c_a_bits_a_mask_acc_2 | c_a_bits_a_mask_eq_2 & auto_in_c_bits_address[0], c_a_bits_a_mask_acc_2 | c_a_bits_a_mask_eq_2 & ~(auto_in_c_bits_address[0])} : 8'h0) | (muxState__1 ? auto_in_a_bits_mask : 8'h0);
  assign auto_out_a_bits_data = (muxState__0 ? auto_in_c_bits_data : 64'h0) | (muxState__1 ? auto_in_a_bits_data : 64'h0);
  assign auto_out_a_bits_corrupt = muxState__0 & auto_in_c_bits_corrupt | muxState__1 & auto_in_a_bits_corrupt;
  assign auto_out_d_ready = in_d_ready & (idle_1 | state_1_0);
endmodule

