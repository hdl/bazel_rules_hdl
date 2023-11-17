// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BoomRAS(
  input         clock,
  input  [4:0]  io_read_idx,
  input         io_write_valid,
  input  [4:0]  io_write_idx,
  input  [39:0] io_write_addr,
  output [39:0] io_read_addr
);

  reg [39:0] casez_tmp;
  reg [39:0] ras_0;
  reg [39:0] ras_1;
  reg [39:0] ras_2;
  reg [39:0] ras_3;
  reg [39:0] ras_4;
  reg [39:0] ras_5;
  reg [39:0] ras_6;
  reg [39:0] ras_7;
  reg [39:0] ras_8;
  reg [39:0] ras_9;
  reg [39:0] ras_10;
  reg [39:0] ras_11;
  reg [39:0] ras_12;
  reg [39:0] ras_13;
  reg [39:0] ras_14;
  reg [39:0] ras_15;
  reg [39:0] ras_16;
  reg [39:0] ras_17;
  reg [39:0] ras_18;
  reg [39:0] ras_19;
  reg [39:0] ras_20;
  reg [39:0] ras_21;
  reg [39:0] ras_22;
  reg [39:0] ras_23;
  reg [39:0] ras_24;
  reg [39:0] ras_25;
  reg [39:0] ras_26;
  reg [39:0] ras_27;
  reg [39:0] ras_28;
  reg [39:0] ras_29;
  reg [39:0] ras_30;
  reg [39:0] ras_31;
  reg        io_read_addr_REG;
  reg [39:0] io_read_addr_REG_1;
  reg [39:0] io_read_addr_REG_2;
  always @(*) begin
    casez (io_read_idx)
      5'b00000:
        casez_tmp = ras_0;
      5'b00001:
        casez_tmp = ras_1;
      5'b00010:
        casez_tmp = ras_2;
      5'b00011:
        casez_tmp = ras_3;
      5'b00100:
        casez_tmp = ras_4;
      5'b00101:
        casez_tmp = ras_5;
      5'b00110:
        casez_tmp = ras_6;
      5'b00111:
        casez_tmp = ras_7;
      5'b01000:
        casez_tmp = ras_8;
      5'b01001:
        casez_tmp = ras_9;
      5'b01010:
        casez_tmp = ras_10;
      5'b01011:
        casez_tmp = ras_11;
      5'b01100:
        casez_tmp = ras_12;
      5'b01101:
        casez_tmp = ras_13;
      5'b01110:
        casez_tmp = ras_14;
      5'b01111:
        casez_tmp = ras_15;
      5'b10000:
        casez_tmp = ras_16;
      5'b10001:
        casez_tmp = ras_17;
      5'b10010:
        casez_tmp = ras_18;
      5'b10011:
        casez_tmp = ras_19;
      5'b10100:
        casez_tmp = ras_20;
      5'b10101:
        casez_tmp = ras_21;
      5'b10110:
        casez_tmp = ras_22;
      5'b10111:
        casez_tmp = ras_23;
      5'b11000:
        casez_tmp = ras_24;
      5'b11001:
        casez_tmp = ras_25;
      5'b11010:
        casez_tmp = ras_26;
      5'b11011:
        casez_tmp = ras_27;
      5'b11100:
        casez_tmp = ras_28;
      5'b11101:
        casez_tmp = ras_29;
      5'b11110:
        casez_tmp = ras_30;
      default:
        casez_tmp = ras_31;
    endcase
  end // always @(*)
  always @(posedge clock) begin
    if (io_write_valid & io_write_idx == 5'h0)
      ras_0 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h1)
      ras_1 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h2)
      ras_2 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h3)
      ras_3 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h4)
      ras_4 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h5)
      ras_5 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h6)
      ras_6 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h7)
      ras_7 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h8)
      ras_8 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h9)
      ras_9 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'hA)
      ras_10 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'hB)
      ras_11 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'hC)
      ras_12 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'hD)
      ras_13 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'hE)
      ras_14 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'hF)
      ras_15 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h10)
      ras_16 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h11)
      ras_17 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h12)
      ras_18 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h13)
      ras_19 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h14)
      ras_20 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h15)
      ras_21 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h16)
      ras_22 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h17)
      ras_23 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h18)
      ras_24 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h19)
      ras_25 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h1A)
      ras_26 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h1B)
      ras_27 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h1C)
      ras_28 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h1D)
      ras_29 <= io_write_addr;
    if (io_write_valid & io_write_idx == 5'h1E)
      ras_30 <= io_write_addr;
    if (io_write_valid & (&io_write_idx))
      ras_31 <= io_write_addr;
    io_read_addr_REG <= io_write_valid & io_write_idx == io_read_idx;
    io_read_addr_REG_1 <= io_write_addr;
    io_read_addr_REG_2 <= casez_tmp;
  end // always @(posedge)
  assign io_read_addr = io_read_addr_REG ? io_read_addr_REG_1 : io_read_addr_REG_2;
endmodule

