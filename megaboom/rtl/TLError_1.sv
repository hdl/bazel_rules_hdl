// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLError_1(
  input          clock,
                 reset,
                 auto_in_a_valid,
  input  [2:0]   auto_in_a_bits_opcode,
  input  [127:0] auto_in_a_bits_address,
  input          auto_in_d_ready,
  output         auto_in_a_ready,
                 auto_in_d_valid,
  output [2:0]   auto_in_d_bits_opcode,
  output [1:0]   auto_in_d_bits_param,
                 auto_in_d_bits_size,
  output         auto_in_d_bits_denied,
                 auto_in_d_bits_corrupt
);

  reg        idle;
  reg        beatsLeft;
  wire       da_valid = auto_in_a_valid & idle;
  reg        state_1;
  wire       da_ready = auto_in_d_ready & (~beatsLeft | state_1);
  wire [2:0] da_bits_opcode = (&auto_in_a_bits_opcode) | auto_in_a_bits_opcode == 3'h6 ? 3'h4 : auto_in_a_bits_opcode == 3'h5 ? 3'h2 : {2'h0, auto_in_a_bits_opcode == 3'h4 | auto_in_a_bits_opcode == 3'h3 | auto_in_a_bits_opcode == 3'h2};
  wire       nodeIn_a_ready = da_ready & idle;
  wire       done = da_ready & da_valid;
  reg        state_0;
  wire       nodeIn_d_valid = (~beatsLeft | state_1) & da_valid;
  wire       muxState_0 = beatsLeft & state_0;
  wire       muxState_1 = beatsLeft ? state_1 : da_valid;
  wire       nodeIn_d_bits_corrupt = muxState_1 & da_bits_opcode[0];
  wire [1:0] nodeIn_d_bits_size = {muxState_1, 1'h0};
  wire [1:0] nodeIn_d_bits_param = {1'h0, muxState_0};
  wire [2:0] nodeIn_d_bits_opcode = (muxState_0 ? 3'h6 : 3'h0) | (muxState_1 ? da_bits_opcode : 3'h0);
  always @(posedge clock) begin
    if (reset) begin
      idle <= 1'h1;
      beatsLeft <= 1'h0;
      state_1 <= 1'h0;
    end
    else begin
      idle <= ~(done & da_bits_opcode == 3'h4) & idle;
      beatsLeft <= ~(~beatsLeft & auto_in_d_ready) & beatsLeft - (auto_in_d_ready & nodeIn_d_valid);
      if (beatsLeft) begin
      end
      else
        state_1 <= da_valid;
    end
    state_0 <= ~(reset | ~beatsLeft) & state_0;
  end // always @(posedge)
  assign auto_in_a_ready = nodeIn_a_ready;
  assign auto_in_d_valid = nodeIn_d_valid;
  assign auto_in_d_bits_opcode = nodeIn_d_bits_opcode;
  assign auto_in_d_bits_param = nodeIn_d_bits_param;
  assign auto_in_d_bits_size = nodeIn_d_bits_size;
  assign auto_in_d_bits_denied = muxState_1;
  assign auto_in_d_bits_corrupt = nodeIn_d_bits_corrupt;
endmodule

