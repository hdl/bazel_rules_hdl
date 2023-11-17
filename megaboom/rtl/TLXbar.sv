// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLXbar(
  input          clock,
                 reset,
                 auto_in_1_a_valid,
  input  [2:0]   auto_in_1_a_bits_opcode,
                 auto_in_1_a_bits_param,
  input  [3:0]   auto_in_1_a_bits_size,
  input  [4:0]   auto_in_1_a_bits_source,
  input  [31:0]  auto_in_1_a_bits_address,
  input  [15:0]  auto_in_1_a_bits_mask,
  input  [127:0] auto_in_1_a_bits_data,
  input          auto_in_1_a_bits_corrupt,
                 auto_in_1_b_ready,
                 auto_in_1_c_valid,
  input  [2:0]   auto_in_1_c_bits_opcode,
                 auto_in_1_c_bits_param,
  input  [3:0]   auto_in_1_c_bits_size,
  input  [4:0]   auto_in_1_c_bits_source,
  input  [31:0]  auto_in_1_c_bits_address,
  input  [127:0] auto_in_1_c_bits_data,
  input          auto_in_1_c_bits_corrupt,
                 auto_in_1_d_ready,
                 auto_in_1_e_valid,
  input  [3:0]   auto_in_1_e_bits_sink,
  input          auto_in_0_a_valid,
  input  [2:0]   auto_in_0_a_bits_opcode,
                 auto_in_0_a_bits_param,
  input  [3:0]   auto_in_0_a_bits_size,
                 auto_in_0_a_bits_source,
  input  [31:0]  auto_in_0_a_bits_address,
  input  [15:0]  auto_in_0_a_bits_mask,
  input  [127:0] auto_in_0_a_bits_data,
  input          auto_in_0_a_bits_corrupt,
                 auto_in_0_d_ready,
                 auto_out_1_a_ready,
                 auto_out_1_b_valid,
  input  [1:0]   auto_out_1_b_bits_param,
  input  [31:0]  auto_out_1_b_bits_address,
  input          auto_out_1_c_ready,
                 auto_out_1_d_valid,
  input  [2:0]   auto_out_1_d_bits_opcode,
  input  [1:0]   auto_out_1_d_bits_param,
  input  [2:0]   auto_out_1_d_bits_size,
  input  [5:0]   auto_out_1_d_bits_source,
  input  [3:0]   auto_out_1_d_bits_sink,
  input          auto_out_1_d_bits_denied,
  input  [127:0] auto_out_1_d_bits_data,
  input          auto_out_1_d_bits_corrupt,
                 auto_out_0_a_ready,
                 auto_out_0_d_valid,
  input  [2:0]   auto_out_0_d_bits_opcode,
  input  [1:0]   auto_out_0_d_bits_param,
  input  [3:0]   auto_out_0_d_bits_size,
  input  [5:0]   auto_out_0_d_bits_source,
  input          auto_out_0_d_bits_sink,
                 auto_out_0_d_bits_denied,
  input  [127:0] auto_out_0_d_bits_data,
  input          auto_out_0_d_bits_corrupt,
  output         auto_in_1_a_ready,
                 auto_in_1_b_valid,
  output [1:0]   auto_in_1_b_bits_param,
  output [31:0]  auto_in_1_b_bits_address,
  output         auto_in_1_c_ready,
                 auto_in_1_d_valid,
  output [2:0]   auto_in_1_d_bits_opcode,
  output [1:0]   auto_in_1_d_bits_param,
  output [3:0]   auto_in_1_d_bits_size,
  output [4:0]   auto_in_1_d_bits_source,
  output [3:0]   auto_in_1_d_bits_sink,
  output         auto_in_1_d_bits_denied,
  output [127:0] auto_in_1_d_bits_data,
  output         auto_in_1_d_bits_corrupt,
                 auto_in_0_a_ready,
                 auto_in_0_d_valid,
  output [2:0]   auto_in_0_d_bits_opcode,
  output [1:0]   auto_in_0_d_bits_param,
  output [3:0]   auto_in_0_d_bits_size,
                 auto_in_0_d_bits_source,
                 auto_in_0_d_bits_sink,
  output         auto_in_0_d_bits_denied,
  output [127:0] auto_in_0_d_bits_data,
  output         auto_in_0_d_bits_corrupt,
                 auto_out_1_a_valid,
  output [2:0]   auto_out_1_a_bits_opcode,
                 auto_out_1_a_bits_param,
                 auto_out_1_a_bits_size,
  output [5:0]   auto_out_1_a_bits_source,
  output [31:0]  auto_out_1_a_bits_address,
  output [15:0]  auto_out_1_a_bits_mask,
  output [127:0] auto_out_1_a_bits_data,
  output         auto_out_1_a_bits_corrupt,
                 auto_out_1_b_ready,
                 auto_out_1_c_valid,
  output [2:0]   auto_out_1_c_bits_opcode,
                 auto_out_1_c_bits_param,
                 auto_out_1_c_bits_size,
  output [5:0]   auto_out_1_c_bits_source,
  output [31:0]  auto_out_1_c_bits_address,
  output [127:0] auto_out_1_c_bits_data,
  output         auto_out_1_c_bits_corrupt,
                 auto_out_1_d_ready,
                 auto_out_1_e_valid,
  output [3:0]   auto_out_1_e_bits_sink,
  output         auto_out_0_a_valid,
  output [2:0]   auto_out_0_a_bits_opcode,
                 auto_out_0_a_bits_param,
  output [3:0]   auto_out_0_a_bits_size,
  output [5:0]   auto_out_0_a_bits_source,
  output [28:0]  auto_out_0_a_bits_address,
  output [15:0]  auto_out_0_a_bits_mask,
  output [127:0] auto_out_0_a_bits_data,
  output         auto_out_0_a_bits_corrupt,
                 auto_out_0_d_ready
);

  wire [5:0]  in_0_a_bits_source = {2'h2, auto_in_0_a_bits_source};
  reg  [7:0]  beatsLeft_2;
  wire        idle_2 = beatsLeft_2 == 8'h0;
  wire        requestDOI_1_0 = auto_out_1_d_bits_source[5:4] == 2'h2;
  wire        portsDIO_filtered_1_0_valid = auto_out_1_d_valid & requestDOI_1_0;
  wire        requestDOI_0_0 = auto_out_0_d_bits_source[5:4] == 2'h2;
  wire        portsDIO_filtered__0_valid = auto_out_0_d_valid & requestDOI_0_0;
  wire [1:0]  readys_valid_2 = {portsDIO_filtered_1_0_valid, portsDIO_filtered__0_valid};
  reg  [1:0]  readys_mask_2;
  wire [1:0]  _readys_filter_T_5 = readys_valid_2 & ~readys_mask_2;
  wire [1:0]  readys_readys_2 = ~({readys_mask_2[1], _readys_filter_T_5[1] | readys_mask_2[0]} & ({_readys_filter_T_5[0], portsDIO_filtered_1_0_valid} | _readys_filter_T_5));
  wire        winner_2_0 = readys_readys_2[0] & portsDIO_filtered__0_valid;
  reg         state_2_0;
  wire        muxState_2_0 = idle_2 ? winner_2_0 : state_2_0;
  wire        winner_2_1 = readys_readys_2[1] & portsDIO_filtered_1_0_valid;
  reg         state_2_1;
  wire        muxState_2_1 = idle_2 ? winner_2_1 : state_2_1;
  wire [3:0]  in_0_d_bits_source = (muxState_2_0 ? auto_out_0_d_bits_source[3:0] : 4'h0) | (muxState_2_1 ? auto_out_1_d_bits_source[3:0] : 4'h0);
  reg  [7:0]  beatsLeft_3;
  wire        idle_3 = beatsLeft_3 == 8'h0;
  wire        portsDIO_filtered_1_1_valid = auto_out_1_d_valid & ~(auto_out_1_d_bits_source[5]);
  wire        portsDIO_filtered__1_valid = auto_out_0_d_valid & ~(auto_out_0_d_bits_source[5]);
  wire [1:0]  readys_valid_3 = {portsDIO_filtered_1_1_valid, portsDIO_filtered__1_valid};
  reg  [1:0]  readys_mask_3;
  wire [1:0]  _readys_filter_T_7 = readys_valid_3 & ~readys_mask_3;
  wire [1:0]  readys_readys_3 = ~({readys_mask_3[1], _readys_filter_T_7[1] | readys_mask_3[0]} & ({_readys_filter_T_7[0], portsDIO_filtered_1_1_valid} | _readys_filter_T_7));
  wire        winner_3_0 = readys_readys_3[0] & portsDIO_filtered__1_valid;
  reg         state_3_0;
  wire        muxState_3_0 = idle_3 ? winner_3_0 : state_3_0;
  wire        winner_3_1 = readys_readys_3[1] & portsDIO_filtered_1_1_valid;
  reg         state_3_1;
  wire        muxState_3_1 = idle_3 ? winner_3_1 : state_3_1;
  wire [4:0]  in_1_d_bits_source = (muxState_3_0 ? auto_out_0_d_bits_source[4:0] : 5'h0) | (muxState_3_1 ? auto_out_1_d_bits_source[4:0] : 5'h0);
  wire [3:0]  _GEN = {1'h0, auto_out_1_d_bits_size};
  wire        portsAOI_filtered__0_valid = auto_in_0_a_valid & ~(auto_in_0_a_bits_address[31]);
  wire        portsAOI_filtered__1_valid = auto_in_0_a_valid & auto_in_0_a_bits_address[31];
  reg  [7:0]  beatsLeft;
  wire        idle = beatsLeft == 8'h0;
  wire        portsAOI_filtered_1_0_valid = auto_in_1_a_valid & ~(auto_in_1_a_bits_address[31]);
  wire [1:0]  readys_valid = {portsAOI_filtered_1_0_valid, portsAOI_filtered__0_valid};
  reg  [1:0]  readys_mask;
  wire [1:0]  _readys_filter_T_1 = readys_valid & ~readys_mask;
  wire [1:0]  readys_readys = ~({readys_mask[1], _readys_filter_T_1[1] | readys_mask[0]} & ({_readys_filter_T_1[0], portsAOI_filtered_1_0_valid} | _readys_filter_T_1));
  reg         state__0;
  reg  [7:0]  beatsLeft_1;
  wire        idle_1 = beatsLeft_1 == 8'h0;
  wire        portsAOI_filtered_1_1_valid = auto_in_1_a_valid & auto_in_1_a_bits_address[31];
  wire [1:0]  readys_valid_1 = {portsAOI_filtered_1_1_valid, portsAOI_filtered__1_valid};
  reg  [1:0]  readys_mask_1;
  wire [1:0]  _readys_filter_T_3 = readys_valid_1 & ~readys_mask_1;
  wire [1:0]  readys_readys_1 = ~({readys_mask_1[1], _readys_filter_T_3[1] | readys_mask_1[0]} & ({_readys_filter_T_3[0], portsAOI_filtered_1_1_valid} | _readys_filter_T_3));
  reg         state_1_0;
  wire        nodeIn_a_ready = ~(auto_in_0_a_bits_address[31]) & auto_out_0_a_ready & (idle ? readys_readys[0] : state__0) | auto_in_0_a_bits_address[31] & auto_out_1_a_ready & (idle_1 ? readys_readys_1[0] : state_1_0);
  reg         state__1;
  reg         state_1_1;
  wire        in_1_a_ready = ~(auto_in_1_a_bits_address[31]) & auto_out_0_a_ready & (idle ? readys_readys[1] : state__1) | auto_in_1_a_bits_address[31] & auto_out_1_a_ready & (idle_1 ? readys_readys_1[1] : state_1_1);
  wire        prefixOR_1 = readys_readys[0] & portsAOI_filtered__0_valid;
  wire        winner__1 = readys_readys[1] & portsAOI_filtered_1_0_valid;
  wire        _out_0_a_valid_T = portsAOI_filtered__0_valid | portsAOI_filtered_1_0_valid;
  wire        nodeOut_a_valid = idle ? _out_0_a_valid_T : state__0 & portsAOI_filtered__0_valid | state__1 & portsAOI_filtered_1_0_valid;
  wire        muxState__0 = idle ? prefixOR_1 : state__0;
  wire        muxState__1 = idle ? winner__1 : state__1;
  wire [5:0]  _GEN_0 = {1'h0, auto_in_1_a_bits_source};
  wire        winner_1_0 = readys_readys_1[0] & portsAOI_filtered__1_valid;
  wire        winner_1_1 = readys_readys_1[1] & portsAOI_filtered_1_1_valid;
  wire        _out_1_a_valid_T = portsAOI_filtered__1_valid | portsAOI_filtered_1_1_valid;
  wire        out_1_a_valid = idle_1 ? _out_1_a_valid_T : state_1_0 & portsAOI_filtered__1_valid | state_1_1 & portsAOI_filtered_1_1_valid;
  wire        muxState_1_0 = idle_1 ? winner_1_0 : state_1_0;
  wire        muxState_1_1 = idle_1 ? winner_1_1 : state_1_1;
  wire        _in_0_d_valid_T = portsDIO_filtered__0_valid | portsDIO_filtered_1_0_valid;
  wire        nodeIn_d_valid = idle_2 ? _in_0_d_valid_T : state_2_0 & portsDIO_filtered__0_valid | state_2_1 & portsDIO_filtered_1_0_valid;
  wire        nodeIn_d_bits_corrupt = muxState_2_0 & auto_out_0_d_bits_corrupt | muxState_2_1 & auto_out_1_d_bits_corrupt;
  wire        nodeIn_d_bits_denied = muxState_2_0 & auto_out_0_d_bits_denied | muxState_2_1 & auto_out_1_d_bits_denied;
  wire [3:0]  _GEN_1 = {3'h0, auto_out_0_d_bits_sink};
  wire [3:0]  nodeIn_d_bits_sink = (muxState_2_0 ? _GEN_1 : 4'h0) | (muxState_2_1 ? auto_out_1_d_bits_sink : 4'h0);
  wire [3:0]  nodeIn_d_bits_size = (muxState_2_0 ? auto_out_0_d_bits_size : 4'h0) | (muxState_2_1 ? _GEN : 4'h0);
  wire [1:0]  nodeIn_d_bits_param = (muxState_2_0 ? auto_out_0_d_bits_param : 2'h0) | (muxState_2_1 ? auto_out_1_d_bits_param : 2'h0);
  wire [2:0]  nodeIn_d_bits_opcode = (muxState_2_0 ? auto_out_0_d_bits_opcode : 3'h0) | (muxState_2_1 ? auto_out_1_d_bits_opcode : 3'h0);
  wire        _in_1_d_valid_T = portsDIO_filtered__1_valid | portsDIO_filtered_1_1_valid;
  wire        in_1_d_valid = idle_3 ? _in_1_d_valid_T : state_3_0 & portsDIO_filtered__1_valid | state_3_1 & portsDIO_filtered_1_1_valid;
  wire        in_1_d_bits_corrupt = muxState_3_0 & auto_out_0_d_bits_corrupt | muxState_3_1 & auto_out_1_d_bits_corrupt;
  wire        in_1_d_bits_denied = muxState_3_0 & auto_out_0_d_bits_denied | muxState_3_1 & auto_out_1_d_bits_denied;
  wire [3:0]  in_1_d_bits_sink = (muxState_3_0 ? _GEN_1 : 4'h0) | (muxState_3_1 ? auto_out_1_d_bits_sink : 4'h0);
  wire [3:0]  in_1_d_bits_size = (muxState_3_0 ? auto_out_0_d_bits_size : 4'h0) | (muxState_3_1 ? _GEN : 4'h0);
  wire [1:0]  in_1_d_bits_param = (muxState_3_0 ? auto_out_0_d_bits_param : 2'h0) | (muxState_3_1 ? auto_out_1_d_bits_param : 2'h0);
  wire [2:0]  in_1_d_bits_opcode = (muxState_3_0 ? auto_out_0_d_bits_opcode : 3'h0) | (muxState_3_1 ? auto_out_1_d_bits_opcode : 3'h0);
  wire [1:0]  _readys_mask_T_10 = readys_readys_2 & readys_valid_2;
  wire [1:0]  _readys_mask_T_15 = readys_readys_3 & readys_valid_3;
  wire [1:0]  _readys_mask_T = readys_readys & readys_valid;
  wire [1:0]  _readys_mask_T_5 = readys_readys_1 & readys_valid_1;
  wire [26:0] _beatsAI_decode_T_1 = 27'hFFF << auto_in_0_a_bits_size;
  wire [26:0] _beatsAI_decode_T_5 = 27'hFFF << auto_in_1_a_bits_size;
  wire [26:0] _beatsDO_decode_T_1 = 27'hFFF << auto_out_0_d_bits_size;
  wire [20:0] _beatsDO_decode_T_5 = 21'h3F << auto_out_1_d_bits_size;
  wire        latch = idle & auto_out_0_a_ready;
  wire        latch_1 = idle_1 & auto_out_1_a_ready;
  wire        latch_2 = idle_2 & auto_in_0_d_ready;
  wire        latch_3 = idle_3 & auto_in_1_d_ready;
  wire [7:0]  maskedBeats_0_2 = winner_2_0 & auto_out_0_d_bits_opcode[0] ? ~(_beatsDO_decode_T_1[11:4]) : 8'h0;
  wire [7:0]  maskedBeats_0_3 = winner_3_0 & auto_out_0_d_bits_opcode[0] ? ~(_beatsDO_decode_T_1[11:4]) : 8'h0;
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft_2 <= 8'h0;
      readys_mask_2 <= 2'h3;
      state_2_0 <= 1'h0;
      state_2_1 <= 1'h0;
      beatsLeft_3 <= 8'h0;
      readys_mask_3 <= 2'h3;
      state_3_0 <= 1'h0;
      state_3_1 <= 1'h0;
      beatsLeft <= 8'h0;
      readys_mask <= 2'h3;
      state__0 <= 1'h0;
      beatsLeft_1 <= 8'h0;
      readys_mask_1 <= 2'h3;
      state_1_0 <= 1'h0;
      state__1 <= 1'h0;
      state_1_1 <= 1'h0;
    end
    else begin
      if (latch_2)
        beatsLeft_2 <= {maskedBeats_0_2[7:2], maskedBeats_0_2[1:0] | (winner_2_1 & auto_out_1_d_bits_opcode[0] ? ~(_beatsDO_decode_T_5[5:4]) : 2'h0)};
      else
        beatsLeft_2 <= beatsLeft_2 - {7'h0, auto_in_0_d_ready & nodeIn_d_valid};
      if (latch_2 & (|readys_valid_2))
        readys_mask_2 <= _readys_mask_T_10 | {_readys_mask_T_10[0], 1'h0};
      if (idle_2) begin
        state_2_0 <= winner_2_0;
        state_2_1 <= winner_2_1;
      end
      if (latch_3)
        beatsLeft_3 <= {maskedBeats_0_3[7:2], maskedBeats_0_3[1:0] | (winner_3_1 & auto_out_1_d_bits_opcode[0] ? ~(_beatsDO_decode_T_5[5:4]) : 2'h0)};
      else
        beatsLeft_3 <= beatsLeft_3 - {7'h0, auto_in_1_d_ready & in_1_d_valid};
      if (latch_3 & (|readys_valid_3))
        readys_mask_3 <= _readys_mask_T_15 | {_readys_mask_T_15[0], 1'h0};
      if (idle_3) begin
        state_3_0 <= winner_3_0;
        state_3_1 <= winner_3_1;
      end
      if (latch)
        beatsLeft <= (prefixOR_1 & ~(auto_in_0_a_bits_opcode[2]) ? ~(_beatsAI_decode_T_1[11:4]) : 8'h0) | (winner__1 & ~(auto_in_1_a_bits_opcode[2]) ? ~(_beatsAI_decode_T_5[11:4]) : 8'h0);
      else
        beatsLeft <= beatsLeft - {7'h0, auto_out_0_a_ready & nodeOut_a_valid};
      if (latch & (|readys_valid))
        readys_mask <= _readys_mask_T | {_readys_mask_T[0], 1'h0};
      if (idle) begin
        state__0 <= prefixOR_1;
        state__1 <= winner__1;
      end
      if (latch_1)
        beatsLeft_1 <= (winner_1_0 & ~(auto_in_0_a_bits_opcode[2]) ? ~(_beatsAI_decode_T_1[11:4]) : 8'h0) | (winner_1_1 & ~(auto_in_1_a_bits_opcode[2]) ? ~(_beatsAI_decode_T_5[11:4]) : 8'h0);
      else
        beatsLeft_1 <= beatsLeft_1 - {7'h0, auto_out_1_a_ready & out_1_a_valid};
      if (latch_1 & (|readys_valid_1))
        readys_mask_1 <= _readys_mask_T_5 | {_readys_mask_T_5[0], 1'h0};
      if (idle_1) begin
        state_1_0 <= winner_1_0;
        state_1_1 <= winner_1_1;
      end
    end
  end // always @(posedge)
  assign auto_in_1_a_ready = in_1_a_ready;
  assign auto_in_1_b_valid = auto_out_1_b_valid;
  assign auto_in_1_b_bits_param = auto_out_1_b_bits_param;
  assign auto_in_1_b_bits_address = auto_out_1_b_bits_address;
  assign auto_in_1_c_ready = auto_out_1_c_ready;
  assign auto_in_1_d_valid = in_1_d_valid;
  assign auto_in_1_d_bits_opcode = in_1_d_bits_opcode;
  assign auto_in_1_d_bits_param = in_1_d_bits_param;
  assign auto_in_1_d_bits_size = in_1_d_bits_size;
  assign auto_in_1_d_bits_source = in_1_d_bits_source;
  assign auto_in_1_d_bits_sink = in_1_d_bits_sink;
  assign auto_in_1_d_bits_denied = in_1_d_bits_denied;
  assign auto_in_1_d_bits_data = (muxState_3_0 ? auto_out_0_d_bits_data : 128'h0) | (muxState_3_1 ? auto_out_1_d_bits_data : 128'h0);
  assign auto_in_1_d_bits_corrupt = in_1_d_bits_corrupt;
  assign auto_in_0_a_ready = nodeIn_a_ready;
  assign auto_in_0_d_valid = nodeIn_d_valid;
  assign auto_in_0_d_bits_opcode = nodeIn_d_bits_opcode;
  assign auto_in_0_d_bits_param = nodeIn_d_bits_param;
  assign auto_in_0_d_bits_size = nodeIn_d_bits_size;
  assign auto_in_0_d_bits_source = in_0_d_bits_source;
  assign auto_in_0_d_bits_sink = nodeIn_d_bits_sink;
  assign auto_in_0_d_bits_denied = nodeIn_d_bits_denied;
  assign auto_in_0_d_bits_data = (muxState_2_0 ? auto_out_0_d_bits_data : 128'h0) | (muxState_2_1 ? auto_out_1_d_bits_data : 128'h0);
  assign auto_in_0_d_bits_corrupt = nodeIn_d_bits_corrupt;
  assign auto_out_1_a_valid = out_1_a_valid;
  assign auto_out_1_a_bits_opcode = (muxState_1_0 ? auto_in_0_a_bits_opcode : 3'h0) | (muxState_1_1 ? auto_in_1_a_bits_opcode : 3'h0);
  assign auto_out_1_a_bits_param = (muxState_1_0 ? auto_in_0_a_bits_param : 3'h0) | (muxState_1_1 ? auto_in_1_a_bits_param : 3'h0);
  assign auto_out_1_a_bits_size = (muxState_1_0 ? auto_in_0_a_bits_size[2:0] : 3'h0) | (muxState_1_1 ? auto_in_1_a_bits_size[2:0] : 3'h0);
  assign auto_out_1_a_bits_source = (muxState_1_0 ? in_0_a_bits_source : 6'h0) | (muxState_1_1 ? _GEN_0 : 6'h0);
  assign auto_out_1_a_bits_address = (muxState_1_0 ? auto_in_0_a_bits_address : 32'h0) | (muxState_1_1 ? auto_in_1_a_bits_address : 32'h0);
  assign auto_out_1_a_bits_mask = (muxState_1_0 ? auto_in_0_a_bits_mask : 16'h0) | (muxState_1_1 ? auto_in_1_a_bits_mask : 16'h0);
  assign auto_out_1_a_bits_data = (muxState_1_0 ? auto_in_0_a_bits_data : 128'h0) | (muxState_1_1 ? auto_in_1_a_bits_data : 128'h0);
  assign auto_out_1_a_bits_corrupt = muxState_1_0 & auto_in_0_a_bits_corrupt | muxState_1_1 & auto_in_1_a_bits_corrupt;
  assign auto_out_1_b_ready = auto_in_1_b_ready;
  assign auto_out_1_c_valid = auto_in_1_c_valid;
  assign auto_out_1_c_bits_opcode = auto_in_1_c_bits_opcode;
  assign auto_out_1_c_bits_param = auto_in_1_c_bits_param;
  assign auto_out_1_c_bits_size = auto_in_1_c_bits_size[2:0];
  assign auto_out_1_c_bits_source = {1'h0, auto_in_1_c_bits_source};
  assign auto_out_1_c_bits_address = auto_in_1_c_bits_address;
  assign auto_out_1_c_bits_data = auto_in_1_c_bits_data;
  assign auto_out_1_c_bits_corrupt = auto_in_1_c_bits_corrupt;
  assign auto_out_1_d_ready = requestDOI_1_0 & auto_in_0_d_ready & (idle_2 ? readys_readys_2[1] : state_2_1) | ~(auto_out_1_d_bits_source[5]) & auto_in_1_d_ready & (idle_3 ? readys_readys_3[1] : state_3_1);
  assign auto_out_1_e_valid = auto_in_1_e_valid;
  assign auto_out_1_e_bits_sink = auto_in_1_e_bits_sink;
  assign auto_out_0_a_valid = nodeOut_a_valid;
  assign auto_out_0_a_bits_opcode = (muxState__0 ? auto_in_0_a_bits_opcode : 3'h0) | (muxState__1 ? auto_in_1_a_bits_opcode : 3'h0);
  assign auto_out_0_a_bits_param = (muxState__0 ? auto_in_0_a_bits_param : 3'h0) | (muxState__1 ? auto_in_1_a_bits_param : 3'h0);
  assign auto_out_0_a_bits_size = (muxState__0 ? auto_in_0_a_bits_size : 4'h0) | (muxState__1 ? auto_in_1_a_bits_size : 4'h0);
  assign auto_out_0_a_bits_source = (muxState__0 ? in_0_a_bits_source : 6'h0) | (muxState__1 ? _GEN_0 : 6'h0);
  assign auto_out_0_a_bits_address = (muxState__0 ? auto_in_0_a_bits_address[28:0] : 29'h0) | (muxState__1 ? auto_in_1_a_bits_address[28:0] : 29'h0);
  assign auto_out_0_a_bits_mask = (muxState__0 ? auto_in_0_a_bits_mask : 16'h0) | (muxState__1 ? auto_in_1_a_bits_mask : 16'h0);
  assign auto_out_0_a_bits_data = (muxState__0 ? auto_in_0_a_bits_data : 128'h0) | (muxState__1 ? auto_in_1_a_bits_data : 128'h0);
  assign auto_out_0_a_bits_corrupt = muxState__0 & auto_in_0_a_bits_corrupt | muxState__1 & auto_in_1_a_bits_corrupt;
  assign auto_out_0_d_ready = requestDOI_0_0 & auto_in_0_d_ready & (idle_2 ? readys_readys_2[0] : state_2_0) | ~(auto_out_0_d_bits_source[5]) & auto_in_1_d_ready & (idle_3 ? readys_readys_3[0] : state_3_0);
endmodule

