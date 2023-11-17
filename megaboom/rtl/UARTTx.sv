// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module UARTTx(
  input         clock,
                reset,
                io_en,
                io_in_valid,
  input  [7:0]  io_in_bits,
  input  [15:0] io_div,
  input         io_nstop,
  output        io_in_ready,
                io_out
);

  wire [31:0] _plusarg_reader_out;
  reg  [15:0] prescaler;
  reg  [3:0]  counter;
  reg  [8:0]  shifter;
  reg         out;
  wire        _io_in_ready_output = io_en & ~(|counter);
  wire        _GEN = _io_in_ready_output & io_in_valid;
  wire        pulse = prescaler == 16'h0;
  wire        _GEN_0 = _GEN & (|_plusarg_reader_out);
  wire        _GEN_1 = pulse & (|counter);
  always @(posedge clock) begin
    if (reset) begin
      prescaler <= 16'h0;
      counter <= 4'h0;
      out <= 1'h1;
    end
    else begin
      if (|counter) begin
        if (pulse)
          prescaler <= io_div;
        else
          prescaler <= prescaler - 16'h1;
      end
      if (_GEN_1) begin
        counter <= counter - 4'h1;
        out <= shifter[0];
      end
      else if (_GEN_0)
        counter <= (io_nstop ? 4'hB : 4'h0) | (io_nstop ? 4'h0 : 4'hA);
    end
    shifter <= _GEN_1 ? {1'h1, shifter[8:1]} : _GEN_0 ? {io_in_bits, 1'h0} : shifter;
  end // always @(posedge)
  plusarg_reader #(
    .DEFAULT(1),
    .FORMAT("uart_tx=%d"),
    .WIDTH(32)
  ) plusarg_reader (
    .out (_plusarg_reader_out)
  );
  assign io_in_ready = _io_in_ready_output;
  assign io_out = out;
endmodule

