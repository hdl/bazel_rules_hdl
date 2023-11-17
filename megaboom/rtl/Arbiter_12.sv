// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Arbiter_12(
  input         io_in_0_valid,
  input  [7:0]  io_in_0_bits_req_0_way_en,
  input  [11:0] io_in_0_bits_req_0_addr,
  input         io_in_1_valid,
  input  [7:0]  io_in_1_bits_req_0_way_en,
  input  [11:0] io_in_1_bits_req_0_addr,
  input         io_in_2_valid,
  input  [11:0] io_in_2_bits_req_0_addr,
                io_in_2_bits_req_1_addr,
  input         io_in_2_bits_valid_0,
                io_in_2_bits_valid_1,
  output        io_in_1_ready,
                io_in_2_ready,
                io_out_valid,
  output [7:0]  io_out_bits_req_0_way_en,
  output [11:0] io_out_bits_req_0_addr,
  output [7:0]  io_out_bits_req_1_way_en,
  output [11:0] io_out_bits_req_1_addr,
  output        io_out_bits_valid_0,
                io_out_bits_valid_1
);

  wire _GEN = io_in_0_valid | io_in_1_valid;
  wire _io_out_valid_T = io_in_0_valid | io_in_1_valid;
  assign io_in_1_ready = ~io_in_0_valid;
  assign io_in_2_ready = ~_io_out_valid_T;
  assign io_out_valid = _io_out_valid_T | io_in_2_valid;
  assign io_out_bits_req_0_way_en = io_in_0_valid ? io_in_0_bits_req_0_way_en : io_in_1_valid ? io_in_1_bits_req_0_way_en : 8'hFF;
  assign io_out_bits_req_0_addr = io_in_0_valid ? io_in_0_bits_req_0_addr : io_in_1_valid ? io_in_1_bits_req_0_addr : io_in_2_bits_req_0_addr;
  assign io_out_bits_req_1_way_en = _GEN ? 8'h0 : 8'hFF;
  assign io_out_bits_req_1_addr = _GEN ? 12'h0 : io_in_2_bits_req_1_addr;
  assign io_out_bits_valid_0 = _GEN | io_in_2_bits_valid_0;
  assign io_out_bits_valid_1 = ~_GEN & io_in_2_bits_valid_1;
endmodule

