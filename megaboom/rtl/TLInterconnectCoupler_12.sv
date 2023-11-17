// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLInterconnectCoupler_12(
  input         clock,
                reset,
                auto_fragmenter_out_a_ready,
                auto_fragmenter_out_d_valid,
  input  [2:0]  auto_fragmenter_out_d_bits_opcode,
  input  [1:0]  auto_fragmenter_out_d_bits_size,
  input  [10:0] auto_fragmenter_out_d_bits_source,
  input  [63:0] auto_fragmenter_out_d_bits_data,
  input         auto_tl_in_a_valid,
  input  [2:0]  auto_tl_in_a_bits_opcode,
                auto_tl_in_a_bits_param,
                auto_tl_in_a_bits_size,
  input  [6:0]  auto_tl_in_a_bits_source,
  input  [11:0] auto_tl_in_a_bits_address,
  input  [7:0]  auto_tl_in_a_bits_mask,
  input  [63:0] auto_tl_in_a_bits_data,
  input         auto_tl_in_a_bits_corrupt,
                auto_tl_in_d_ready,
  output        auto_fragmenter_out_a_valid,
  output [2:0]  auto_fragmenter_out_a_bits_opcode,
                auto_fragmenter_out_a_bits_param,
  output [1:0]  auto_fragmenter_out_a_bits_size,
  output [10:0] auto_fragmenter_out_a_bits_source,
  output [11:0] auto_fragmenter_out_a_bits_address,
  output [7:0]  auto_fragmenter_out_a_bits_mask,
  output [63:0] auto_fragmenter_out_a_bits_data,
  output        auto_fragmenter_out_a_bits_corrupt,
                auto_fragmenter_out_d_ready,
                auto_tl_in_a_ready,
                auto_tl_in_d_valid,
  output [2:0]  auto_tl_in_d_bits_opcode,
                auto_tl_in_d_bits_size,
  output [6:0]  auto_tl_in_d_bits_source,
  output [63:0] auto_tl_in_d_bits_data
);

  TLFragmenter_5 fragmenter (
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (auto_tl_in_a_valid),
    .auto_in_a_bits_opcode   (auto_tl_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_tl_in_a_bits_param),
    .auto_in_a_bits_size     (auto_tl_in_a_bits_size),
    .auto_in_a_bits_source   (auto_tl_in_a_bits_source),
    .auto_in_a_bits_address  (auto_tl_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_tl_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_tl_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_tl_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_tl_in_d_ready),
    .auto_out_a_ready        (auto_fragmenter_out_a_ready),
    .auto_out_d_valid        (auto_fragmenter_out_d_valid),
    .auto_out_d_bits_opcode  (auto_fragmenter_out_d_bits_opcode),
    .auto_out_d_bits_size    (auto_fragmenter_out_d_bits_size),
    .auto_out_d_bits_source  (auto_fragmenter_out_d_bits_source),
    .auto_out_d_bits_data    (auto_fragmenter_out_d_bits_data),
    .auto_in_a_ready         (auto_tl_in_a_ready),
    .auto_in_d_valid         (auto_tl_in_d_valid),
    .auto_in_d_bits_opcode   (auto_tl_in_d_bits_opcode),
    .auto_in_d_bits_size     (auto_tl_in_d_bits_size),
    .auto_in_d_bits_source   (auto_tl_in_d_bits_source),
    .auto_in_d_bits_data     (auto_tl_in_d_bits_data),
    .auto_out_a_valid        (auto_fragmenter_out_a_valid),
    .auto_out_a_bits_opcode  (auto_fragmenter_out_a_bits_opcode),
    .auto_out_a_bits_param   (auto_fragmenter_out_a_bits_param),
    .auto_out_a_bits_size    (auto_fragmenter_out_a_bits_size),
    .auto_out_a_bits_source  (auto_fragmenter_out_a_bits_source),
    .auto_out_a_bits_address (auto_fragmenter_out_a_bits_address),
    .auto_out_a_bits_mask    (auto_fragmenter_out_a_bits_mask),
    .auto_out_a_bits_data    (auto_fragmenter_out_a_bits_data),
    .auto_out_a_bits_corrupt (auto_fragmenter_out_a_bits_corrupt),
    .auto_out_d_ready        (auto_fragmenter_out_d_ready)
  );
endmodule

