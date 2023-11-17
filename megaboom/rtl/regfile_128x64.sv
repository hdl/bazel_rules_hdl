// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// VCS coverage exclude_file
module regfile_128x64(
  input  [6:0]  R0_addr,
  input         R0_en,
                R0_clk,
  input  [6:0]  R1_addr,
  input         R1_en,
                R1_clk,
  input  [6:0]  R2_addr,
  input         R2_en,
                R2_clk,
  input  [6:0]  R3_addr,
  input         R3_en,
                R3_clk,
  input  [6:0]  R4_addr,
  input         R4_en,
                R4_clk,
  input  [6:0]  R5_addr,
  input         R5_en,
                R5_clk,
  input  [6:0]  R6_addr,
  input         R6_en,
                R6_clk,
  input  [6:0]  R7_addr,
  input         R7_en,
                R7_clk,
  input  [6:0]  R8_addr,
  input         R8_en,
                R8_clk,
  input  [6:0]  R9_addr,
  input         R9_en,
                R9_clk,
  input  [6:0]  R10_addr,
  input         R10_en,
                R10_clk,
  input  [6:0]  R11_addr,
  input         R11_en,
                R11_clk,
  input  [6:0]  W0_addr,
  input         W0_en,
                W0_clk,
  input  [63:0] W0_data,
  input  [6:0]  W1_addr,
  input         W1_en,
                W1_clk,
  input  [63:0] W1_data,
  input  [6:0]  W2_addr,
  input         W2_en,
                W2_clk,
  input  [63:0] W2_data,
  input  [6:0]  W3_addr,
  input         W3_en,
                W3_clk,
  input  [63:0] W3_data,
  input  [6:0]  W4_addr,
  input         W4_en,
                W4_clk,
  input  [63:0] W4_data,
  input  [6:0]  W5_addr,
  input         W5_en,
                W5_clk,
  input  [63:0] W5_data,
  output [63:0] R0_data,
                R1_data,
                R2_data,
                R3_data,
                R4_data,
                R5_data,
                R6_data,
                R7_data,
                R8_data,
                R9_data,
                R10_data,
                R11_data
);

  reg [63:0] Memory[0:127];
  always @(posedge W0_clk) begin
    if (W0_en)
      Memory[W0_addr] <= W0_data;
    if (W1_en)
      Memory[W1_addr] <= W1_data;
    if (W2_en)
      Memory[W2_addr] <= W2_data;
    if (W3_en)
      Memory[W3_addr] <= W3_data;
    if (W4_en)
      Memory[W4_addr] <= W4_data;
    if (W5_en)
      Memory[W5_addr] <= W5_data;
  end // always @(posedge)
  assign R0_data = R0_en ? Memory[R0_addr] : 64'bx;
  assign R1_data = R1_en ? Memory[R1_addr] : 64'bx;
  assign R2_data = R2_en ? Memory[R2_addr] : 64'bx;
  assign R3_data = R3_en ? Memory[R3_addr] : 64'bx;
  assign R4_data = R4_en ? Memory[R4_addr] : 64'bx;
  assign R5_data = R5_en ? Memory[R5_addr] : 64'bx;
  assign R6_data = R6_en ? Memory[R6_addr] : 64'bx;
  assign R7_data = R7_en ? Memory[R7_addr] : 64'bx;
  assign R8_data = R8_en ? Memory[R8_addr] : 64'bx;
  assign R9_data = R9_en ? Memory[R9_addr] : 64'bx;
  assign R10_data = R10_en ? Memory[R10_addr] : 64'bx;
  assign R11_data = R11_en ? Memory[R11_addr] : 64'bx;
endmodule

