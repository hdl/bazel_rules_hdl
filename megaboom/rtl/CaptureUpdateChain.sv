// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module CaptureUpdateChain(
  input        clock,
               reset,
               io_chainIn_shift,
               io_chainIn_data,
               io_chainIn_capture,
               io_chainIn_update,
  input  [1:0] io_capture_bits_dmiStatus,
  output       io_chainOut_data,
               io_update_valid,
               io_update_bits_dmireset
);

  reg  regs_0;
  reg  regs_1;
  reg  regs_2;
  reg  regs_3;
  reg  regs_4;
  reg  regs_5;
  reg  regs_6;
  reg  regs_7;
  reg  regs_8;
  reg  regs_9;
  reg  regs_10;
  reg  regs_11;
  reg  regs_12;
  reg  regs_13;
  reg  regs_14;
  reg  regs_15;
  reg  regs_16;
  reg  regs_17;
  reg  regs_18;
  reg  regs_19;
  reg  regs_20;
  reg  regs_21;
  reg  regs_22;
  reg  regs_23;
  reg  regs_24;
  reg  regs_25;
  reg  regs_26;
  reg  regs_27;
  reg  regs_28;
  reg  regs_29;
  reg  regs_30;
  reg  regs_31;
  wire _GEN = io_chainIn_update | ~io_chainIn_shift;
  always @(posedge clock) begin
    regs_0 <= io_chainIn_capture | (_GEN ? regs_0 : regs_1);
    regs_1 <= ~io_chainIn_capture & (_GEN ? regs_1 : regs_2);
    regs_2 <= ~io_chainIn_capture & (_GEN ? regs_2 : regs_3);
    regs_3 <= ~io_chainIn_capture & (_GEN ? regs_3 : regs_4);
    regs_4 <= io_chainIn_capture | (_GEN ? regs_4 : regs_5);
    regs_5 <= io_chainIn_capture | (_GEN ? regs_5 : regs_6);
    regs_6 <= io_chainIn_capture | (_GEN ? regs_6 : regs_7);
    regs_7 <= ~io_chainIn_capture & (_GEN ? regs_7 : regs_8);
    regs_8 <= ~io_chainIn_capture & (_GEN ? regs_8 : regs_9);
    regs_9 <= ~io_chainIn_capture & (_GEN ? regs_9 : regs_10);
    if (io_chainIn_capture) begin
      regs_10 <= io_capture_bits_dmiStatus[0];
      regs_11 <= io_capture_bits_dmiStatus[1];
    end
    else if (_GEN) begin
    end
    else begin
      regs_10 <= regs_11;
      regs_11 <= regs_12;
    end
    regs_12 <= io_chainIn_capture | (_GEN ? regs_12 : regs_13);
    regs_13 <= ~io_chainIn_capture & (_GEN ? regs_13 : regs_14);
    regs_14 <= io_chainIn_capture | (_GEN ? regs_14 : regs_15);
    regs_15 <= ~io_chainIn_capture & (_GEN ? regs_15 : regs_16);
    regs_16 <= ~io_chainIn_capture & (_GEN ? regs_16 : regs_17);
    regs_17 <= ~io_chainIn_capture & (_GEN ? regs_17 : regs_18);
    regs_18 <= ~io_chainIn_capture & (_GEN ? regs_18 : regs_19);
    regs_19 <= ~io_chainIn_capture & (_GEN ? regs_19 : regs_20);
    regs_20 <= ~io_chainIn_capture & (_GEN ? regs_20 : regs_21);
    regs_21 <= ~io_chainIn_capture & (_GEN ? regs_21 : regs_22);
    regs_22 <= ~io_chainIn_capture & (_GEN ? regs_22 : regs_23);
    regs_23 <= ~io_chainIn_capture & (_GEN ? regs_23 : regs_24);
    regs_24 <= ~io_chainIn_capture & (_GEN ? regs_24 : regs_25);
    regs_25 <= ~io_chainIn_capture & (_GEN ? regs_25 : regs_26);
    regs_26 <= ~io_chainIn_capture & (_GEN ? regs_26 : regs_27);
    regs_27 <= ~io_chainIn_capture & (_GEN ? regs_27 : regs_28);
    regs_28 <= ~io_chainIn_capture & (_GEN ? regs_28 : regs_29);
    regs_29 <= ~io_chainIn_capture & (_GEN ? regs_29 : regs_30);
    regs_30 <= ~io_chainIn_capture & (_GEN ? regs_30 : regs_31);
    regs_31 <= ~io_chainIn_capture & (_GEN ? regs_31 : io_chainIn_data);
  end // always @(posedge)
  assign io_chainOut_data = regs_0;
  assign io_update_valid = ~io_chainIn_capture & io_chainIn_update;
  assign io_update_bits_dmireset = regs_16;
endmodule

