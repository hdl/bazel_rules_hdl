// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLWidthWidget_9(
  input          auto_in_a_valid,
  input  [31:0]  auto_in_a_bits_address,
  input          auto_out_a_ready,
                 auto_out_d_valid,
  input  [2:0]   auto_out_d_bits_opcode,
  input  [3:0]   auto_out_d_bits_size,
  input  [127:0] auto_out_d_bits_data,
  output         auto_in_a_ready,
                 auto_in_d_valid,
  output [2:0]   auto_in_d_bits_opcode,
  output [3:0]   auto_in_d_bits_size,
  output [127:0] auto_in_d_bits_data,
  output         auto_out_a_valid,
  output [31:0]  auto_out_a_bits_address
);

  assign auto_in_a_ready = auto_out_a_ready;
  assign auto_in_d_valid = auto_out_d_valid;
  assign auto_in_d_bits_opcode = auto_out_d_bits_opcode;
  assign auto_in_d_bits_size = auto_out_d_bits_size;
  assign auto_in_d_bits_data = auto_out_d_bits_data;
  assign auto_out_a_valid = auto_in_a_valid;
  assign auto_out_a_bits_address = auto_in_a_bits_address;
endmodule

