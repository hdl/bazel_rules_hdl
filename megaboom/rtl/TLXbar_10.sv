// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLXbar_10(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
  input  [8:0]  auto_in_a_bits_address,
  input  [31:0] auto_in_a_bits_data,
  input         auto_in_d_ready,
                auto_out_1_a_ready,
                auto_out_1_d_valid,
  input  [2:0]  auto_out_1_d_bits_opcode,
  input  [31:0] auto_out_1_d_bits_data,
  input         auto_out_0_a_ready,
                auto_out_0_d_valid,
  input  [2:0]  auto_out_0_d_bits_opcode,
  input  [1:0]  auto_out_0_d_bits_param,
                auto_out_0_d_bits_size,
  input         auto_out_0_d_bits_sink,
                auto_out_0_d_bits_denied,
  input  [31:0] auto_out_0_d_bits_data,
  input         auto_out_0_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_d_valid,
                auto_in_d_bits_denied,
  output [31:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_1_a_valid,
  output [2:0]  auto_out_1_a_bits_opcode,
  output [6:0]  auto_out_1_a_bits_address,
  output [31:0] auto_out_1_a_bits_data,
  output        auto_out_1_d_ready,
                auto_out_0_a_valid,
  output [2:0]  auto_out_0_a_bits_opcode,
  output [8:0]  auto_out_0_a_bits_address,
  output [31:0] auto_out_0_a_bits_data,
  output        auto_out_0_d_ready
);

  wire [4:0] _GEN = auto_in_a_bits_address[6:2] ^ 5'h11;
  wire       requestAIO_0_0 = auto_in_a_bits_address[8:6] == 3'h0 | {auto_in_a_bits_address[8:7], _GEN[4:2], _GEN[0]} == 6'h0 | {auto_in_a_bits_address[8:7], auto_in_a_bits_address[6:3] ^ 4'hB} == 6'h0 | {auto_in_a_bits_address[8:7], ~(auto_in_a_bits_address[6:5])} == 4'h0 | {auto_in_a_bits_address[8], ~(auto_in_a_bits_address[7])} == 2'h0 | auto_in_a_bits_address[8];
  wire       requestAIO_0_1 = {auto_in_a_bits_address[8:7], auto_in_a_bits_address[6:4] ^ 3'h4, auto_in_a_bits_address[2]} == 6'h0 | {auto_in_a_bits_address[8:7], auto_in_a_bits_address[6:3] ^ 4'hA} == 6'h0;
  wire       nodeIn_a_ready = requestAIO_0_0 & auto_out_0_a_ready | requestAIO_0_1 & auto_out_1_a_ready;
  reg        beatsLeft;
  wire [1:0] readys_valid = {auto_out_1_d_valid, auto_out_0_d_valid};
  reg  [1:0] readys_mask;
  wire [1:0] _readys_filter_T_1 = readys_valid & ~readys_mask;
  wire [1:0] readys_readys = ~({readys_mask[1], _readys_filter_T_1[1] | readys_mask[0]} & ({_readys_filter_T_1[0], auto_out_1_d_valid} | _readys_filter_T_1));
  wire       winner_0 = readys_readys[0] & auto_out_0_d_valid;
  wire       winner_1 = readys_readys[1] & auto_out_1_d_valid;
  wire       _in_0_d_valid_T = auto_out_0_d_valid | auto_out_1_d_valid;
  reg        state_0;
  reg        state_1;
  wire       nodeIn_d_valid = beatsLeft ? state_0 & auto_out_0_d_valid | state_1 & auto_out_1_d_valid : _in_0_d_valid_T;
  wire       muxState_0 = beatsLeft ? state_0 : winner_0;
  wire       muxState_1 = beatsLeft ? state_1 : winner_1;
  wire       _in_0_d_bits_T = muxState_0 & auto_out_0_d_bits_corrupt;
  wire       _in_0_d_bits_T_6 = muxState_0 & auto_out_0_d_bits_denied;
  wire [1:0] _readys_mask_T = readys_readys & readys_valid;
  wire       latch = ~beatsLeft & auto_in_d_ready;
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 1'h0;
      readys_mask <= 2'h3;
      state_0 <= 1'h0;
      state_1 <= 1'h0;
    end
    else begin
      beatsLeft <= ~latch & beatsLeft - (auto_in_d_ready & nodeIn_d_valid);
      if (latch & (|readys_valid))
        readys_mask <= _readys_mask_T | {_readys_mask_T[0], 1'h0};
      if (beatsLeft) begin
      end
      else begin
        state_0 <= winner_0;
        state_1 <= winner_1;
      end
    end
  end // always @(posedge)
  assign auto_in_a_ready = nodeIn_a_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_denied = _in_0_d_bits_T_6;
  assign auto_in_d_bits_data = (muxState_0 ? auto_out_0_d_bits_data : 32'h0) | (muxState_1 ? auto_out_1_d_bits_data : 32'h0);
  assign auto_in_d_bits_corrupt = _in_0_d_bits_T;
  assign auto_out_1_a_valid = auto_in_a_valid & requestAIO_0_1;
  assign auto_out_1_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_1_a_bits_address = auto_in_a_bits_address[6:0];
  assign auto_out_1_a_bits_data = auto_in_a_bits_data;
  assign auto_out_1_d_ready = auto_in_d_ready & (beatsLeft ? state_1 : readys_readys[1]);
  assign auto_out_0_a_valid = auto_in_a_valid & requestAIO_0_0;
  assign auto_out_0_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_0_a_bits_address = auto_in_a_bits_address;
  assign auto_out_0_a_bits_data = auto_in_a_bits_data;
  assign auto_out_0_d_ready = auto_in_d_ready & (beatsLeft ? state_0 : readys_readys[0]);
endmodule

