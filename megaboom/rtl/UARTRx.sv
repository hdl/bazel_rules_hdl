// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module UARTRx(
  input         clock,
                reset,
                io_en,
                io_in,
  input  [15:0] io_div,
  output        io_out_valid,
  output [7:0]  io_out_bits
);

  reg  [1:0]  debounce;
  reg  [12:0] prescaler;
  reg  [3:0]  data_count;
  reg  [3:0]  sample_count;
  reg         state;
  reg  [2:0]  sample;
  reg  [7:0]  shifter;
  reg         valid;
  wire [7:0]  _countdown_T_1 = {data_count, sample_count} - 8'h1;
  wire        pulse = prescaler == 13'h0;
  wire        data_last = data_count == 4'h0;
  wire        sample_mid = sample_count == 4'h7;
  wire        _GEN = ~io_in & (&debounce);
  wire        _GEN_0 = state & pulse & sample_mid;
  wire        restore = ~state & ~io_in & (&debounce) | pulse;
  always @(posedge clock) begin
    if (reset) begin
      debounce <= 2'h0;
      state <= 1'h0;
      valid <= 1'h0;
    end
    else begin
      if (io_en) begin
        if (state) begin
        end
        else if (io_in) begin
          if (io_in & (|debounce))
            debounce <= debounce - 2'h1;
        end
        else
          debounce <= debounce + 2'h1;
      end
      else
        debounce <= 2'h0;
      if (state)
        state <= ~(state & pulse & sample_mid & data_last) & state;
      else
        state <= _GEN | state;
      valid <= state & _GEN_0 & data_last;
    end
    if (state | _GEN)
      prescaler <= (restore ? {1'h0, io_div[15:4]} : prescaler) - {12'h0, ~(restore & sample_count < io_div[3:0])};
    if (state) begin
      if (state & pulse) begin
        data_count <= _countdown_T_1[7:4];
        sample_count <= _countdown_T_1[3:0];
      end
    end
    else if (_GEN) begin
      data_count <= 4'h9;
      sample_count <= 4'hF;
    end
    sample <= state & pulse ? {sample[1:0], io_in} : sample;
    if (~state | ~_GEN_0 | data_last) begin
    end
    else
      shifter <= {sample[0] & sample[1] | sample[0] & sample[2] | sample[1] & sample[2], shifter[7:1]};
  end // always @(posedge)
  assign io_out_valid = valid;
  assign io_out_bits = shifter;
endmodule

