// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLXbar_11(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [6:0]  auto_in_a_bits_source,
  input  [20:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_1_a_ready,
                auto_out_1_d_valid,
  input  [2:0]  auto_out_1_d_bits_opcode,
                auto_out_1_d_bits_size,
  input  [6:0]  auto_out_1_d_bits_source,
  input  [63:0] auto_out_1_d_bits_data,
  input         auto_out_0_a_ready,
                auto_out_0_d_valid,
  input  [2:0]  auto_out_0_d_bits_opcode,
                auto_out_0_d_bits_size,
  input  [6:0]  auto_out_0_d_bits_source,
  input  [63:0] auto_out_0_d_bits_data,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
                auto_in_d_bits_size,
  output [6:0]  auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data,
  output        auto_out_1_a_valid,
  output [2:0]  auto_out_1_a_bits_opcode,
                auto_out_1_a_bits_param,
                auto_out_1_a_bits_size,
  output [6:0]  auto_out_1_a_bits_source,
  output [20:0] auto_out_1_a_bits_address,
  output [7:0]  auto_out_1_a_bits_mask,
  output        auto_out_1_a_bits_corrupt,
                auto_out_1_d_ready,
                auto_out_0_a_valid,
  output [2:0]  auto_out_0_a_bits_opcode,
                auto_out_0_a_bits_param,
                auto_out_0_a_bits_size,
  output [6:0]  auto_out_0_a_bits_source,
  output [20:0] auto_out_0_a_bits_address,
  output [7:0]  auto_out_0_a_bits_mask,
  output [63:0] auto_out_0_a_bits_data,
  output        auto_out_0_a_bits_corrupt,
                auto_out_0_d_ready
);

  reg  [2:0]  beatsLeft;
  wire        idle = beatsLeft == 3'h0;
  wire [1:0]  readys_valid = {auto_out_1_d_valid, auto_out_0_d_valid};
  reg  [1:0]  readys_mask;
  wire [1:0]  _readys_filter_T_1 = readys_valid & ~readys_mask;
  wire [1:0]  readys_readys = ~({readys_mask[1], _readys_filter_T_1[1] | readys_mask[0]} & ({_readys_filter_T_1[0], auto_out_1_d_valid} | _readys_filter_T_1));
  wire        winner_0 = readys_readys[0] & auto_out_0_d_valid;
  reg         state_0;
  wire        muxState_0 = idle ? winner_0 : state_0;
  wire        winner_1 = readys_readys[1] & auto_out_1_d_valid;
  reg         state_1;
  wire        muxState_1 = idle ? winner_1 : state_1;
  wire [6:0]  nodeIn_d_bits_source = (muxState_0 ? auto_out_0_d_bits_source : 7'h0) | (muxState_1 ? auto_out_1_d_bits_source : 7'h0);
  wire        nodeIn_a_ready = ~(auto_in_a_bits_address[16]) & auto_out_0_a_ready | auto_in_a_bits_address[16] & auto_out_1_a_ready;
  wire        _in_0_d_valid_T = auto_out_0_d_valid | auto_out_1_d_valid;
  wire        nodeIn_d_valid = idle ? _in_0_d_valid_T : state_0 & auto_out_0_d_valid | state_1 & auto_out_1_d_valid;
  wire [2:0]  nodeIn_d_bits_size = (muxState_0 ? auto_out_0_d_bits_size : 3'h0) | (muxState_1 ? auto_out_1_d_bits_size : 3'h0);
  wire [2:0]  nodeIn_d_bits_opcode = (muxState_0 ? auto_out_0_d_bits_opcode : 3'h0) | (muxState_1 ? auto_out_1_d_bits_opcode : 3'h0);
  wire [12:0] _beatsDO_decode_T_5 = 13'h3F << auto_out_1_d_bits_size;
  wire [12:0] _beatsDO_decode_T_1 = 13'h3F << auto_out_0_d_bits_size;
  wire [1:0]  _readys_mask_T = readys_readys & readys_valid;
  wire        latch = idle & auto_in_d_ready;
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 3'h0;
      readys_mask <= 2'h3;
      state_0 <= 1'h0;
      state_1 <= 1'h0;
    end
    else begin
      if (latch)
        beatsLeft <= (winner_0 & auto_out_0_d_bits_opcode[0] ? ~(_beatsDO_decode_T_1[5:3]) : 3'h0) | (winner_1 & auto_out_1_d_bits_opcode[0] ? ~(_beatsDO_decode_T_5[5:3]) : 3'h0);
      else
        beatsLeft <= beatsLeft - {2'h0, auto_in_d_ready & nodeIn_d_valid};
      if (latch & (|readys_valid))
        readys_mask <= _readys_mask_T | {_readys_mask_T[0], 1'h0};
      if (idle) begin
        state_0 <= winner_0;
        state_1 <= winner_1;
      end
    end
  end // always @(posedge)
  assign auto_in_a_ready = nodeIn_a_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_opcode = nodeIn_d_bits_opcode;
  assign auto_in_d_bits_size = nodeIn_d_bits_size;
  assign auto_in_d_bits_source = nodeIn_d_bits_source;
  assign auto_in_d_bits_data = (muxState_0 ? auto_out_0_d_bits_data : 64'h0) | (muxState_1 ? auto_out_1_d_bits_data : 64'h0);
  assign auto_out_1_a_valid = auto_in_a_valid & auto_in_a_bits_address[16];
  assign auto_out_1_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_1_a_bits_param = auto_in_a_bits_param;
  assign auto_out_1_a_bits_size = auto_in_a_bits_size;
  assign auto_out_1_a_bits_source = auto_in_a_bits_source;
  assign auto_out_1_a_bits_address = auto_in_a_bits_address;
  assign auto_out_1_a_bits_mask = auto_in_a_bits_mask;
  assign auto_out_1_a_bits_corrupt = auto_in_a_bits_corrupt;
  assign auto_out_1_d_ready = auto_in_d_ready & (idle ? readys_readys[1] : state_1);
  assign auto_out_0_a_valid = auto_in_a_valid & ~(auto_in_a_bits_address[16]);
  assign auto_out_0_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_0_a_bits_param = auto_in_a_bits_param;
  assign auto_out_0_a_bits_size = auto_in_a_bits_size;
  assign auto_out_0_a_bits_source = auto_in_a_bits_source;
  assign auto_out_0_a_bits_address = auto_in_a_bits_address;
  assign auto_out_0_a_bits_mask = auto_in_a_bits_mask;
  assign auto_out_0_a_bits_data = auto_in_a_bits_data;
  assign auto_out_0_a_bits_corrupt = auto_in_a_bits_corrupt;
  assign auto_out_0_d_ready = auto_in_d_ready & (idle ? readys_readys[0] : state_0);
endmodule

