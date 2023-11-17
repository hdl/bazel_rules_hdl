// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module DMIToTL(
  input         auto_out_a_ready,
                auto_out_d_valid,
                auto_out_d_bits_denied,
  input  [31:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
                io_dmi_req_valid,
  input  [6:0]  io_dmi_req_bits_addr,
  input  [31:0] io_dmi_req_bits_data,
  input  [1:0]  io_dmi_req_bits_op,
  input         io_dmi_resp_ready,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
  output [8:0]  auto_out_a_bits_address,
  output [31:0] auto_out_a_bits_data,
  output        auto_out_d_ready,
                io_dmi_req_ready,
                io_dmi_resp_valid,
  output [31:0] io_dmi_resp_bits_data,
  output [1:0]  io_dmi_resp_bits_resp
);

  wire _GEN = io_dmi_req_bits_op == 2'h2;
  wire _GEN_0 = io_dmi_req_bits_op == 2'h1;
  assign auto_out_a_valid = io_dmi_req_valid;
  assign auto_out_a_bits_opcode = _GEN ? 3'h0 : {_GEN_0, 2'h0};
  assign auto_out_a_bits_address = _GEN | _GEN_0 ? {io_dmi_req_bits_addr, 2'h0} : 9'h48;
  assign auto_out_a_bits_data = _GEN ? io_dmi_req_bits_data : 32'h0;
  assign auto_out_d_ready = io_dmi_resp_ready;
  assign io_dmi_req_ready = auto_out_a_ready;
  assign io_dmi_resp_valid = auto_out_d_valid;
  assign io_dmi_resp_bits_data = auto_out_d_bits_data;
  assign io_dmi_resp_bits_resp = {1'h0, auto_out_d_bits_corrupt | auto_out_d_bits_denied};
endmodule

