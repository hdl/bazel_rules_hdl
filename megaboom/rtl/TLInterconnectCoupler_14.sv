// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module TLInterconnectCoupler_14(
  input         auto_tl_in_a_valid,
  input  [28:0] auto_tl_in_a_bits_address,
  input  [63:0] auto_tl_in_a_bits_data,
  input         auto_tl_out_a_ready,
                auto_tl_out_d_valid,
  output        auto_tl_in_a_ready,
                auto_tl_in_d_valid,
                auto_tl_out_a_valid,
  output [28:0] auto_tl_out_a_bits_address,
  output [63:0] auto_tl_out_a_bits_data
);

  assign auto_tl_in_a_ready = auto_tl_out_a_ready;
  assign auto_tl_in_d_valid = auto_tl_out_d_valid;
  assign auto_tl_out_a_valid = auto_tl_in_a_valid;
  assign auto_tl_out_a_bits_address = auto_tl_in_a_bits_address;
  assign auto_tl_out_a_bits_data = auto_tl_in_a_bits_data;
endmodule

