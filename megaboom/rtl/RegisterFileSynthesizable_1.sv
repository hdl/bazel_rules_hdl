// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module RegisterFileSynthesizable_1(
  input         clock,
                reset,
  input  [6:0]  io_read_ports_0_addr,
                io_read_ports_1_addr,
                io_read_ports_2_addr,
                io_read_ports_3_addr,
                io_read_ports_4_addr,
                io_read_ports_5_addr,
                io_read_ports_6_addr,
                io_read_ports_7_addr,
                io_read_ports_8_addr,
                io_read_ports_9_addr,
                io_read_ports_10_addr,
                io_read_ports_11_addr,
  input         io_write_ports_0_valid,
  input  [6:0]  io_write_ports_0_bits_addr,
  input  [63:0] io_write_ports_0_bits_data,
  input         io_write_ports_1_valid,
  input  [6:0]  io_write_ports_1_bits_addr,
  input  [63:0] io_write_ports_1_bits_data,
  input         io_write_ports_2_valid,
  input  [6:0]  io_write_ports_2_bits_addr,
  input  [63:0] io_write_ports_2_bits_data,
  input         io_write_ports_3_valid,
  input  [6:0]  io_write_ports_3_bits_addr,
  input  [63:0] io_write_ports_3_bits_data,
  input         io_write_ports_4_valid,
  input  [6:0]  io_write_ports_4_bits_addr,
  input  [63:0] io_write_ports_4_bits_data,
  input         io_write_ports_5_valid,
  input  [6:0]  io_write_ports_5_bits_addr,
  input  [63:0] io_write_ports_5_bits_data,
  output [63:0] io_read_ports_0_data,
                io_read_ports_1_data,
                io_read_ports_2_data,
                io_read_ports_3_data,
                io_read_ports_4_data,
                io_read_ports_5_data,
                io_read_ports_6_data,
                io_read_ports_7_data,
                io_read_ports_8_data,
                io_read_ports_9_data,
                io_read_ports_10_data,
                io_read_ports_11_data
);

  wire [63:0] _regfile_ext_R0_data;
  wire [63:0] _regfile_ext_R1_data;
  wire [63:0] _regfile_ext_R2_data;
  wire [63:0] _regfile_ext_R3_data;
  wire [63:0] _regfile_ext_R4_data;
  wire [63:0] _regfile_ext_R5_data;
  wire [63:0] _regfile_ext_R6_data;
  wire [63:0] _regfile_ext_R7_data;
  wire [63:0] _regfile_ext_R8_data;
  wire [63:0] _regfile_ext_R9_data;
  wire [63:0] _regfile_ext_R10_data;
  wire [63:0] _regfile_ext_R11_data;
  reg  [6:0]  read_addrs_0;
  reg  [6:0]  read_addrs_1;
  reg  [6:0]  read_addrs_2;
  reg  [6:0]  read_addrs_3;
  reg  [6:0]  read_addrs_4;
  reg  [6:0]  read_addrs_5;
  reg  [6:0]  read_addrs_6;
  reg  [6:0]  read_addrs_7;
  reg  [6:0]  read_addrs_8;
  reg  [6:0]  read_addrs_9;
  reg  [6:0]  read_addrs_10;
  reg  [6:0]  read_addrs_11;
  wire        bypass_ens_0 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_0;
  wire        bypass_ens_1 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_0;
  wire        bypass_ens_2 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_0;
  wire        bypass_ens_3 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_0;
  wire        bypass_ens_4 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_0;
  wire        bypass_ens_5 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_0;
  wire        bypass_ens_0_1 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_1;
  wire        bypass_ens_1_1 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_1;
  wire        bypass_ens_2_1 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_1;
  wire        bypass_ens_3_1 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_1;
  wire        bypass_ens_4_1 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_1;
  wire        bypass_ens_5_1 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_1;
  wire        bypass_ens_0_2 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_2;
  wire        bypass_ens_1_2 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_2;
  wire        bypass_ens_2_2 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_2;
  wire        bypass_ens_3_2 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_2;
  wire        bypass_ens_4_2 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_2;
  wire        bypass_ens_5_2 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_2;
  wire        bypass_ens_0_3 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_3;
  wire        bypass_ens_1_3 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_3;
  wire        bypass_ens_2_3 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_3;
  wire        bypass_ens_3_3 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_3;
  wire        bypass_ens_4_3 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_3;
  wire        bypass_ens_5_3 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_3;
  wire        bypass_ens_0_4 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_4;
  wire        bypass_ens_1_4 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_4;
  wire        bypass_ens_2_4 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_4;
  wire        bypass_ens_3_4 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_4;
  wire        bypass_ens_4_4 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_4;
  wire        bypass_ens_5_4 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_4;
  wire        bypass_ens_0_5 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_5;
  wire        bypass_ens_1_5 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_5;
  wire        bypass_ens_2_5 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_5;
  wire        bypass_ens_3_5 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_5;
  wire        bypass_ens_4_5 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_5;
  wire        bypass_ens_5_5 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_5;
  wire        bypass_ens_0_6 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_6;
  wire        bypass_ens_1_6 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_6;
  wire        bypass_ens_2_6 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_6;
  wire        bypass_ens_3_6 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_6;
  wire        bypass_ens_4_6 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_6;
  wire        bypass_ens_5_6 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_6;
  wire        bypass_ens_0_7 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_7;
  wire        bypass_ens_1_7 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_7;
  wire        bypass_ens_2_7 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_7;
  wire        bypass_ens_3_7 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_7;
  wire        bypass_ens_4_7 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_7;
  wire        bypass_ens_5_7 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_7;
  wire        bypass_ens_0_8 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_8;
  wire        bypass_ens_1_8 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_8;
  wire        bypass_ens_2_8 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_8;
  wire        bypass_ens_3_8 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_8;
  wire        bypass_ens_4_8 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_8;
  wire        bypass_ens_5_8 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_8;
  wire        bypass_ens_0_9 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_9;
  wire        bypass_ens_1_9 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_9;
  wire        bypass_ens_2_9 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_9;
  wire        bypass_ens_3_9 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_9;
  wire        bypass_ens_4_9 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_9;
  wire        bypass_ens_5_9 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_9;
  wire        bypass_ens_0_10 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_10;
  wire        bypass_ens_1_10 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_10;
  wire        bypass_ens_2_10 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_10;
  wire        bypass_ens_3_10 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_10;
  wire        bypass_ens_4_10 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_10;
  wire        bypass_ens_5_10 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_10;
  wire        bypass_ens_0_11 = io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_11;
  wire        bypass_ens_1_11 = io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_11;
  wire        bypass_ens_2_11 = io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_11;
  wire        bypass_ens_3_11 = io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_11;
  wire        bypass_ens_4_11 = io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_11;
  wire        bypass_ens_5_11 = io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_11;
  always @(posedge clock) begin
    read_addrs_0 <= io_read_ports_0_addr;
    read_addrs_1 <= io_read_ports_1_addr;
    read_addrs_2 <= io_read_ports_2_addr;
    read_addrs_3 <= io_read_ports_3_addr;
    read_addrs_4 <= io_read_ports_4_addr;
    read_addrs_5 <= io_read_ports_5_addr;
    read_addrs_6 <= io_read_ports_6_addr;
    read_addrs_7 <= io_read_ports_7_addr;
    read_addrs_8 <= io_read_ports_8_addr;
    read_addrs_9 <= io_read_ports_9_addr;
    read_addrs_10 <= io_read_ports_10_addr;
    read_addrs_11 <= io_read_ports_11_addr;
  end // always @(posedge)
  regfile_128x64 regfile_ext (
    .R0_addr  (read_addrs_9),
    .R0_en    (1'h1),
    .R0_clk   (clock),
    .R1_addr  (read_addrs_8),
    .R1_en    (1'h1),
    .R1_clk   (clock),
    .R2_addr  (read_addrs_7),
    .R2_en    (1'h1),
    .R2_clk   (clock),
    .R3_addr  (read_addrs_6),
    .R3_en    (1'h1),
    .R3_clk   (clock),
    .R4_addr  (read_addrs_5),
    .R4_en    (1'h1),
    .R4_clk   (clock),
    .R5_addr  (read_addrs_4),
    .R5_en    (1'h1),
    .R5_clk   (clock),
    .R6_addr  (read_addrs_3),
    .R6_en    (1'h1),
    .R6_clk   (clock),
    .R7_addr  (read_addrs_2),
    .R7_en    (1'h1),
    .R7_clk   (clock),
    .R8_addr  (read_addrs_1),
    .R8_en    (1'h1),
    .R8_clk   (clock),
    .R9_addr  (read_addrs_11),
    .R9_en    (1'h1),
    .R9_clk   (clock),
    .R10_addr (read_addrs_10),
    .R10_en   (1'h1),
    .R10_clk  (clock),
    .R11_addr (read_addrs_0),
    .R11_en   (1'h1),
    .R11_clk  (clock),
    .W0_addr  (io_write_ports_5_bits_addr),
    .W0_en    (io_write_ports_5_valid),
    .W0_clk   (clock),
    .W0_data  (io_write_ports_5_bits_data),
    .W1_addr  (io_write_ports_4_bits_addr),
    .W1_en    (io_write_ports_4_valid),
    .W1_clk   (clock),
    .W1_data  (io_write_ports_4_bits_data),
    .W2_addr  (io_write_ports_3_bits_addr),
    .W2_en    (io_write_ports_3_valid),
    .W2_clk   (clock),
    .W2_data  (io_write_ports_3_bits_data),
    .W3_addr  (io_write_ports_2_bits_addr),
    .W3_en    (io_write_ports_2_valid),
    .W3_clk   (clock),
    .W3_data  (io_write_ports_2_bits_data),
    .W4_addr  (io_write_ports_1_bits_addr),
    .W4_en    (io_write_ports_1_valid),
    .W4_clk   (clock),
    .W4_data  (io_write_ports_1_bits_data),
    .W5_addr  (io_write_ports_0_bits_addr),
    .W5_en    (io_write_ports_0_valid),
    .W5_clk   (clock),
    .W5_data  (io_write_ports_0_bits_data),
    .R0_data  (_regfile_ext_R0_data),
    .R1_data  (_regfile_ext_R1_data),
    .R2_data  (_regfile_ext_R2_data),
    .R3_data  (_regfile_ext_R3_data),
    .R4_data  (_regfile_ext_R4_data),
    .R5_data  (_regfile_ext_R5_data),
    .R6_data  (_regfile_ext_R6_data),
    .R7_data  (_regfile_ext_R7_data),
    .R8_data  (_regfile_ext_R8_data),
    .R9_data  (_regfile_ext_R9_data),
    .R10_data (_regfile_ext_R10_data),
    .R11_data (_regfile_ext_R11_data)
  );
  assign io_read_ports_0_data = bypass_ens_0 | bypass_ens_1 | bypass_ens_2 | bypass_ens_3 | bypass_ens_4 | bypass_ens_5 ? (bypass_ens_0 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R11_data;
  assign io_read_ports_1_data = bypass_ens_0_1 | bypass_ens_1_1 | bypass_ens_2_1 | bypass_ens_3_1 | bypass_ens_4_1 | bypass_ens_5_1 ? (bypass_ens_0_1 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_1 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_1 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_1 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_1 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_1 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R8_data;
  assign io_read_ports_2_data = bypass_ens_0_2 | bypass_ens_1_2 | bypass_ens_2_2 | bypass_ens_3_2 | bypass_ens_4_2 | bypass_ens_5_2 ? (bypass_ens_0_2 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_2 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_2 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_2 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_2 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_2 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R7_data;
  assign io_read_ports_3_data = bypass_ens_0_3 | bypass_ens_1_3 | bypass_ens_2_3 | bypass_ens_3_3 | bypass_ens_4_3 | bypass_ens_5_3 ? (bypass_ens_0_3 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_3 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_3 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_3 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_3 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_3 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R6_data;
  assign io_read_ports_4_data = bypass_ens_0_4 | bypass_ens_1_4 | bypass_ens_2_4 | bypass_ens_3_4 | bypass_ens_4_4 | bypass_ens_5_4 ? (bypass_ens_0_4 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_4 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_4 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_4 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_4 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_4 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R5_data;
  assign io_read_ports_5_data = bypass_ens_0_5 | bypass_ens_1_5 | bypass_ens_2_5 | bypass_ens_3_5 | bypass_ens_4_5 | bypass_ens_5_5 ? (bypass_ens_0_5 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_5 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_5 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_5 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_5 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_5 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R4_data;
  assign io_read_ports_6_data = bypass_ens_0_6 | bypass_ens_1_6 | bypass_ens_2_6 | bypass_ens_3_6 | bypass_ens_4_6 | bypass_ens_5_6 ? (bypass_ens_0_6 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_6 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_6 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_6 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_6 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_6 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R3_data;
  assign io_read_ports_7_data = bypass_ens_0_7 | bypass_ens_1_7 | bypass_ens_2_7 | bypass_ens_3_7 | bypass_ens_4_7 | bypass_ens_5_7 ? (bypass_ens_0_7 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_7 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_7 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_7 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_7 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_7 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R2_data;
  assign io_read_ports_8_data = bypass_ens_0_8 | bypass_ens_1_8 | bypass_ens_2_8 | bypass_ens_3_8 | bypass_ens_4_8 | bypass_ens_5_8 ? (bypass_ens_0_8 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_8 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_8 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_8 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_8 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_8 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R1_data;
  assign io_read_ports_9_data = bypass_ens_0_9 | bypass_ens_1_9 | bypass_ens_2_9 | bypass_ens_3_9 | bypass_ens_4_9 | bypass_ens_5_9 ? (bypass_ens_0_9 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_9 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_9 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_9 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_9 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_9 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R0_data;
  assign io_read_ports_10_data = bypass_ens_0_10 | bypass_ens_1_10 | bypass_ens_2_10 | bypass_ens_3_10 | bypass_ens_4_10 | bypass_ens_5_10 ? (bypass_ens_0_10 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_10 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_10 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_10 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_10 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_10 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R10_data;
  assign io_read_ports_11_data = bypass_ens_0_11 | bypass_ens_1_11 | bypass_ens_2_11 | bypass_ens_3_11 | bypass_ens_4_11 | bypass_ens_5_11 ? (bypass_ens_0_11 ? io_write_ports_0_bits_data : 64'h0) | (bypass_ens_1_11 ? io_write_ports_1_bits_data : 64'h0) | (bypass_ens_2_11 ? io_write_ports_2_bits_data : 64'h0) | (bypass_ens_3_11 ? io_write_ports_3_bits_data : 64'h0) | (bypass_ens_4_11 ? io_write_ports_4_bits_data : 64'h0) | (bypass_ens_5_11 ? io_write_ports_5_bits_data : 64'h0) : _regfile_ext_R9_data;
endmodule

