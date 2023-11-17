// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module AMOALU(
  input  [7:0]  io_mask,
  input  [4:0]  io_cmd,
  input  [63:0] io_lhs,
                io_rhs,
  output [63:0] io_out
);

  wire        _logic_xor_T_1 = io_cmd == 5'hA;
  wire        logic_and = _logic_xor_T_1 | io_cmd == 5'hB;
  wire        logic_xor = io_cmd == 5'h9 | _logic_xor_T_1;
  wire [63:0] adder_out_mask = {32'hFFFFFFFF, io_mask[3], 31'h7FFFFFFF};
  wire [63:0] wmask = {{8{io_mask[7]}}, {8{io_mask[6]}}, {8{io_mask[5]}}, {8{io_mask[4]}}, {8{io_mask[3]}}, {8{io_mask[2]}}, {8{io_mask[1]}}, {8{io_mask[0]}}};
  assign io_out = wmask & (io_cmd == 5'h8 ? (io_lhs & adder_out_mask) + (io_rhs & adder_out_mask) : logic_and | logic_xor ? (logic_and ? io_lhs & io_rhs : 64'h0) | (logic_xor ? io_lhs ^ io_rhs : 64'h0) : ((io_mask[4] ? (io_lhs[63] == io_rhs[63] ? io_lhs[63:32] < io_rhs[63:32] | io_lhs[63:32] == io_rhs[63:32] & io_lhs[31:0] < io_rhs[31:0] : io_cmd[1] ? io_rhs[63] : io_lhs[63]) : io_lhs[31] == io_rhs[31] ? io_lhs[31:0] < io_rhs[31:0] : io_cmd[1] ? io_rhs[31] : io_lhs[31]) ? io_cmd == 5'hC | io_cmd == 5'hE : io_cmd == 5'hD | io_cmd == 5'hF) ? io_lhs : io_rhs) | ~wmask & io_lhs;
endmodule

