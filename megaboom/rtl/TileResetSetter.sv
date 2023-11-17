// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TileResetSetter(
  input         clock,
                reset,
                auto_clock_in_member_allClocks_uncore_clock,
                auto_clock_in_member_allClocks_uncore_reset,
                auto_tl_in_a_valid,
  input  [2:0]  auto_tl_in_a_bits_opcode,
                auto_tl_in_a_bits_param,
  input  [1:0]  auto_tl_in_a_bits_size,
  input  [10:0] auto_tl_in_a_bits_source,
  input  [20:0] auto_tl_in_a_bits_address,
  input  [7:0]  auto_tl_in_a_bits_mask,
  input         auto_tl_in_a_bits_corrupt,
                auto_tl_in_d_ready,
  output        auto_clock_out_member_allClocks_uncore_clock,
                auto_clock_out_member_allClocks_uncore_reset,
                auto_tl_in_a_ready,
                auto_tl_in_d_valid,
  output [2:0]  auto_tl_in_d_bits_opcode,
  output [1:0]  auto_tl_in_d_bits_size,
  output [10:0] auto_tl_in_d_bits_source,
  output [63:0] auto_tl_in_d_bits_data
);

  wire [2:0] _GEN = {2'h0, auto_tl_in_a_bits_opcode == 3'h4};
  assign auto_clock_out_member_allClocks_uncore_clock = auto_clock_in_member_allClocks_uncore_clock;
  assign auto_clock_out_member_allClocks_uncore_reset = auto_clock_in_member_allClocks_uncore_reset;
  assign auto_tl_in_a_ready = auto_tl_in_d_ready;
  assign auto_tl_in_d_valid = auto_tl_in_a_valid;
  assign auto_tl_in_d_bits_opcode = _GEN;
  assign auto_tl_in_d_bits_size = auto_tl_in_a_bits_size;
  assign auto_tl_in_d_bits_source = auto_tl_in_a_bits_source;
  assign auto_tl_in_d_bits_data = 64'h0;
endmodule

