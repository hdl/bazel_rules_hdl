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
module UARTTx_assert(
  input [7:0] io_in_bits,
  input       _GEN,
              reset,
              clock
);

  wire [31:0] _plusarg_reader_1_out;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN & (|_plusarg_reader_1_out) & ~reset)
        $fwrite(32'h80000002, "UART TX (%x): %c\n", io_in_bits, io_in_bits);
    end // always @(posedge)
  `endif // not def SYNTHESIS
  plusarg_reader #(
    .DEFAULT(0),
    .FORMAT("uart_tx_printf=%d"),
    .WIDTH(32)
  ) plusarg_reader_1 (
    .out (_plusarg_reader_1_out)
  );
endmodule

