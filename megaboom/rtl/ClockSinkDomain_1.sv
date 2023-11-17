// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module ClockSinkDomain_1(
  input         auto_bootrom_in_a_valid,
  input  [2:0]  auto_bootrom_in_a_bits_opcode,
                auto_bootrom_in_a_bits_param,
  input  [1:0]  auto_bootrom_in_a_bits_size,
  input  [10:0] auto_bootrom_in_a_bits_source,
  input  [16:0] auto_bootrom_in_a_bits_address,
  input  [7:0]  auto_bootrom_in_a_bits_mask,
  input         auto_bootrom_in_a_bits_corrupt,
                auto_bootrom_in_d_ready,
                auto_clock_in_clock,
                auto_clock_in_reset,
  output        auto_bootrom_in_a_ready,
                auto_bootrom_in_d_valid,
  output [1:0]  auto_bootrom_in_d_bits_size,
  output [10:0] auto_bootrom_in_d_bits_source,
  output [63:0] auto_bootrom_in_d_bits_data
);

  TLROM bootrom (
    .clock                  (auto_clock_in_clock),
    .reset                  (auto_clock_in_reset),
    .auto_in_a_valid        (auto_bootrom_in_a_valid),
    .auto_in_a_bits_opcode  (auto_bootrom_in_a_bits_opcode),
    .auto_in_a_bits_param   (auto_bootrom_in_a_bits_param),
    .auto_in_a_bits_size    (auto_bootrom_in_a_bits_size),
    .auto_in_a_bits_source  (auto_bootrom_in_a_bits_source),
    .auto_in_a_bits_address (auto_bootrom_in_a_bits_address),
    .auto_in_a_bits_mask    (auto_bootrom_in_a_bits_mask),
    .auto_in_a_bits_corrupt (auto_bootrom_in_a_bits_corrupt),
    .auto_in_d_ready        (auto_bootrom_in_d_ready),
    .auto_in_a_ready        (auto_bootrom_in_a_ready),
    .auto_in_d_valid        (auto_bootrom_in_d_valid),
    .auto_in_d_bits_size    (auto_bootrom_in_d_bits_size),
    .auto_in_d_bits_source  (auto_bootrom_in_d_bits_source),
    .auto_in_d_bits_data    (auto_bootrom_in_d_bits_data)
  );
endmodule

