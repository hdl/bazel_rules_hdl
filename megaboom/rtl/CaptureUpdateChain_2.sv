// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module CaptureUpdateChain_2(
  input        clock,
               reset,
               io_chainIn_shift,
               io_chainIn_data,
               io_chainIn_capture,
               io_chainIn_update,
  output       io_chainOut_data,
  output [4:0] io_update_bits
);

  reg regs_0;
  reg regs_1;
  reg regs_2;
  reg regs_3;
  reg regs_4;
  always @(posedge clock) begin
    if (io_chainIn_capture) begin
      regs_0 <= 1'h1;
      regs_1 <= 1'h0;
      regs_2 <= 1'h0;
      regs_3 <= 1'h0;
      regs_4 <= 1'h0;
    end
    else if (io_chainIn_update | ~io_chainIn_shift) begin
    end
    else begin
      regs_0 <= regs_1;
      regs_1 <= regs_2;
      regs_2 <= regs_3;
      regs_3 <= regs_4;
      regs_4 <= io_chainIn_data;
    end
  end // always @(posedge)
  assign io_chainOut_data = regs_0;
  assign io_update_bits = {regs_4, regs_3, regs_2, regs_1, regs_0};
endmodule

