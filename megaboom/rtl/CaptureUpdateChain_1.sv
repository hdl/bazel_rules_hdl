// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module CaptureUpdateChain_1(
  input         clock,
                reset,
                io_chainIn_shift,
                io_chainIn_data,
                io_chainIn_capture,
                io_chainIn_update,
  input  [6:0]  io_capture_bits_addr,
  input  [31:0] io_capture_bits_data,
  input  [1:0]  io_capture_bits_resp,
  output        io_chainOut_data,
                io_capture_capture,
                io_update_valid,
  output [6:0]  io_update_bits_addr,
  output [31:0] io_update_bits_data,
  output [1:0]  io_update_bits_op
);

  reg regs_0;
  reg regs_1;
  reg regs_2;
  reg regs_3;
  reg regs_4;
  reg regs_5;
  reg regs_6;
  reg regs_7;
  reg regs_8;
  reg regs_9;
  reg regs_10;
  reg regs_11;
  reg regs_12;
  reg regs_13;
  reg regs_14;
  reg regs_15;
  reg regs_16;
  reg regs_17;
  reg regs_18;
  reg regs_19;
  reg regs_20;
  reg regs_21;
  reg regs_22;
  reg regs_23;
  reg regs_24;
  reg regs_25;
  reg regs_26;
  reg regs_27;
  reg regs_28;
  reg regs_29;
  reg regs_30;
  reg regs_31;
  reg regs_32;
  reg regs_33;
  reg regs_34;
  reg regs_35;
  reg regs_36;
  reg regs_37;
  reg regs_38;
  reg regs_39;
  reg regs_40;
  always @(posedge clock) begin
    if (io_chainIn_capture) begin
      regs_0 <= io_capture_bits_resp[0];
      regs_1 <= io_capture_bits_resp[1];
      regs_2 <= io_capture_bits_data[0];
      regs_3 <= io_capture_bits_data[1];
      regs_4 <= io_capture_bits_data[2];
      regs_5 <= io_capture_bits_data[3];
      regs_6 <= io_capture_bits_data[4];
      regs_7 <= io_capture_bits_data[5];
      regs_8 <= io_capture_bits_data[6];
      regs_9 <= io_capture_bits_data[7];
      regs_10 <= io_capture_bits_data[8];
      regs_11 <= io_capture_bits_data[9];
      regs_12 <= io_capture_bits_data[10];
      regs_13 <= io_capture_bits_data[11];
      regs_14 <= io_capture_bits_data[12];
      regs_15 <= io_capture_bits_data[13];
      regs_16 <= io_capture_bits_data[14];
      regs_17 <= io_capture_bits_data[15];
      regs_18 <= io_capture_bits_data[16];
      regs_19 <= io_capture_bits_data[17];
      regs_20 <= io_capture_bits_data[18];
      regs_21 <= io_capture_bits_data[19];
      regs_22 <= io_capture_bits_data[20];
      regs_23 <= io_capture_bits_data[21];
      regs_24 <= io_capture_bits_data[22];
      regs_25 <= io_capture_bits_data[23];
      regs_26 <= io_capture_bits_data[24];
      regs_27 <= io_capture_bits_data[25];
      regs_28 <= io_capture_bits_data[26];
      regs_29 <= io_capture_bits_data[27];
      regs_30 <= io_capture_bits_data[28];
      regs_31 <= io_capture_bits_data[29];
      regs_32 <= io_capture_bits_data[30];
      regs_33 <= io_capture_bits_data[31];
      regs_34 <= io_capture_bits_addr[0];
      regs_35 <= io_capture_bits_addr[1];
      regs_36 <= io_capture_bits_addr[2];
      regs_37 <= io_capture_bits_addr[3];
      regs_38 <= io_capture_bits_addr[4];
      regs_39 <= io_capture_bits_addr[5];
      regs_40 <= io_capture_bits_addr[6];
    end
    else if (io_chainIn_update | ~io_chainIn_shift) begin
    end
    else begin
      regs_0 <= regs_1;
      regs_1 <= regs_2;
      regs_2 <= regs_3;
      regs_3 <= regs_4;
      regs_4 <= regs_5;
      regs_5 <= regs_6;
      regs_6 <= regs_7;
      regs_7 <= regs_8;
      regs_8 <= regs_9;
      regs_9 <= regs_10;
      regs_10 <= regs_11;
      regs_11 <= regs_12;
      regs_12 <= regs_13;
      regs_13 <= regs_14;
      regs_14 <= regs_15;
      regs_15 <= regs_16;
      regs_16 <= regs_17;
      regs_17 <= regs_18;
      regs_18 <= regs_19;
      regs_19 <= regs_20;
      regs_20 <= regs_21;
      regs_21 <= regs_22;
      regs_22 <= regs_23;
      regs_23 <= regs_24;
      regs_24 <= regs_25;
      regs_25 <= regs_26;
      regs_26 <= regs_27;
      regs_27 <= regs_28;
      regs_28 <= regs_29;
      regs_29 <= regs_30;
      regs_30 <= regs_31;
      regs_31 <= regs_32;
      regs_32 <= regs_33;
      regs_33 <= regs_34;
      regs_34 <= regs_35;
      regs_35 <= regs_36;
      regs_36 <= regs_37;
      regs_37 <= regs_38;
      regs_38 <= regs_39;
      regs_39 <= regs_40;
      regs_40 <= io_chainIn_data;
    end
  end // always @(posedge)
  assign io_chainOut_data = regs_0;
  assign io_capture_capture = io_chainIn_capture;
  assign io_update_valid = ~io_chainIn_capture & io_chainIn_update;
  assign io_update_bits_addr = {regs_40, regs_39, regs_38, regs_37, regs_36, regs_35, regs_34};
  assign io_update_bits_data = {regs_33, regs_32, regs_31, regs_30, regs_29, regs_28, regs_27, regs_26, regs_25, regs_24, regs_23, regs_22, regs_21, regs_20, regs_19, regs_18, regs_17, regs_16, regs_15, regs_14, regs_13, regs_12, regs_11, regs_10, regs_9, regs_8, regs_7, regs_6, regs_5, regs_4, regs_3, regs_2};
  assign io_update_bits_op = {regs_1, regs_0};
endmodule

