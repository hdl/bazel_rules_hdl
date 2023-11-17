// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLXbar_4(
  input         clock,
                reset,
                auto_in_1_a_valid,
  input  [28:0] auto_in_1_a_bits_address,
  input  [63:0] auto_in_1_a_bits_data,
  input         auto_in_0_a_valid,
  input  [2:0]  auto_in_0_a_bits_opcode,
                auto_in_0_a_bits_param,
  input  [3:0]  auto_in_0_a_bits_size,
  input  [5:0]  auto_in_0_a_bits_source,
  input  [28:0] auto_in_0_a_bits_address,
  input  [7:0]  auto_in_0_a_bits_mask,
  input  [63:0] auto_in_0_a_bits_data,
  input         auto_in_0_a_bits_corrupt,
                auto_in_0_d_ready,
                auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [3:0]  auto_out_d_bits_size,
  input  [6:0]  auto_out_d_bits_source,
  input         auto_out_d_bits_sink,
                auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
  output        auto_in_1_a_ready,
                auto_in_1_d_valid,
                auto_in_0_a_ready,
                auto_in_0_d_valid,
  output [2:0]  auto_in_0_d_bits_opcode,
  output [1:0]  auto_in_0_d_bits_param,
  output [3:0]  auto_in_0_d_bits_size,
  output [5:0]  auto_in_0_d_bits_source,
  output        auto_in_0_d_bits_sink,
                auto_in_0_d_bits_denied,
  output [63:0] auto_in_0_d_bits_data,
  output        auto_in_0_d_bits_corrupt,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [3:0]  auto_out_a_bits_size,
  output [6:0]  auto_out_a_bits_source,
  output [28:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire        requestDOI_0_1 = auto_out_d_bits_source == 7'h40;
  wire        nodeIn_d_valid = auto_out_d_valid & ~(auto_out_d_bits_source[6]);
  wire        in_1_d_valid = auto_out_d_valid & requestDOI_0_1;
  reg  [8:0]  beatsLeft;
  wire        idle = beatsLeft == 9'h0;
  wire [1:0]  readys_valid = {auto_in_1_a_valid, auto_in_0_a_valid};
  reg  [1:0]  readys_mask;
  wire [1:0]  _readys_filter_T_1 = readys_valid & ~readys_mask;
  wire [1:0]  readys_readys = ~({readys_mask[1], _readys_filter_T_1[1] | readys_mask[0]} & ({_readys_filter_T_1[0], auto_in_1_a_valid} | _readys_filter_T_1));
  wire        winner_0 = readys_readys[0] & auto_in_0_a_valid;
  wire        winner_1 = readys_readys[1] & auto_in_1_a_valid;
  wire        _out_0_a_valid_T = auto_in_0_a_valid | auto_in_1_a_valid;
  reg         state_0;
  reg         state_1;
  wire        nodeOut_a_valid = idle ? _out_0_a_valid_T : state_0 & auto_in_0_a_valid | state_1 & auto_in_1_a_valid;
  wire        muxState_0 = idle ? winner_0 : state_0;
  wire        muxState_1 = idle ? winner_1 : state_1;
  wire        nodeIn_a_ready = auto_out_a_ready & (idle ? readys_readys[0] : state_0);
  wire        in_1_a_ready = auto_out_a_ready & (idle ? readys_readys[1] : state_1);
  wire [26:0] _beatsAI_decode_T_1 = 27'hFFF << auto_in_0_a_bits_size;
  wire [1:0]  _readys_mask_T = readys_readys & readys_valid;
  wire        latch = idle & auto_out_a_ready;
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 9'h0;
      readys_mask <= 2'h3;
      state_0 <= 1'h0;
      state_1 <= 1'h0;
    end
    else begin
      if (latch) begin
        if (winner_0 & ~(auto_in_0_a_bits_opcode[2]))
          beatsLeft <= ~(_beatsAI_decode_T_1[11:3]);
        else
          beatsLeft <= 9'h0;
      end
      else
        beatsLeft <= beatsLeft - {8'h0, auto_out_a_ready & nodeOut_a_valid};
      if (latch & (|readys_valid))
        readys_mask <= _readys_mask_T | {_readys_mask_T[0], 1'h0};
      if (idle) begin
        state_0 <= winner_0;
        state_1 <= winner_1;
      end
    end
  end // always @(posedge)
  assign auto_in_1_a_ready = in_1_a_ready;
  assign auto_in_1_d_valid = in_1_d_valid;
  assign auto_in_0_a_ready = nodeIn_a_ready;
  assign auto_in_0_d_valid = nodeIn_d_valid;
  assign auto_in_0_d_bits_opcode = auto_out_d_bits_opcode;
  assign auto_in_0_d_bits_param = auto_out_d_bits_param;
  assign auto_in_0_d_bits_size = auto_out_d_bits_size;
  assign auto_in_0_d_bits_source = auto_out_d_bits_source[5:0];
  assign auto_in_0_d_bits_sink = auto_out_d_bits_sink;
  assign auto_in_0_d_bits_denied = auto_out_d_bits_denied;
  assign auto_in_0_d_bits_data = auto_out_d_bits_data;
  assign auto_in_0_d_bits_corrupt = auto_out_d_bits_corrupt;
  assign auto_out_a_valid = nodeOut_a_valid;
  assign auto_out_a_bits_opcode = muxState_0 ? auto_in_0_a_bits_opcode : 3'h0;
  assign auto_out_a_bits_param = muxState_0 ? auto_in_0_a_bits_param : 3'h0;
  assign auto_out_a_bits_size = (muxState_0 ? auto_in_0_a_bits_size : 4'h0) | {2'h0, muxState_1, 1'h0};
  assign auto_out_a_bits_source = (muxState_0 ? {1'h0, auto_in_0_a_bits_source} : 7'h0) | {muxState_1, 6'h0};
  assign auto_out_a_bits_address = (muxState_0 ? auto_in_0_a_bits_address : 29'h0) | (muxState_1 ? auto_in_1_a_bits_address : 29'h0);
  assign auto_out_a_bits_mask = (muxState_0 ? auto_in_0_a_bits_mask : 8'h0) | (muxState_1 ? 8'hF : 8'h0);
  assign auto_out_a_bits_data = (muxState_0 ? auto_in_0_a_bits_data : 64'h0) | (muxState_1 ? auto_in_1_a_bits_data : 64'h0);
  assign auto_out_a_bits_corrupt = muxState_0 & auto_in_0_a_bits_corrupt;
  assign auto_out_d_ready = ~(auto_out_d_bits_source[6]) & auto_in_0_d_ready | requestDOI_0_1;
endmodule

