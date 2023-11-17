// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module IDPool(
  input        clock,
               reset,
               io_free_valid,
  input  [2:0] io_free_bits,
  input        io_alloc_ready,
  output       io_alloc_valid,
  output [2:0] io_alloc_bits
);

  reg  [7:0] bitmap;
  reg  [2:0] select;
  reg        valid;
  wire [7:0] taken = io_alloc_ready ? 8'h1 << select : 8'h0;
  wire [7:0] _GEN = {5'h0, io_free_bits};
  wire       _GEN_0 = io_alloc_ready | ~valid & io_free_valid;
  wire [7:0] bitmap1 = bitmap & ~taken | (io_free_valid ? 8'h1 << _GEN : 8'h0);
  always @(posedge clock) begin
    if (reset) begin
      bitmap <= 8'hFF;
      select <= 3'h0;
      valid <= 1'h1;
    end
    else begin
      if (io_alloc_ready | io_free_valid) begin
        bitmap <= bitmap1;
        valid <= (|bitmap) & ~({1'h0, {1'h0, {1'h0, bitmap[0]} + {1'h0, bitmap[1]}} + {1'h0, {1'h0, bitmap[2]} + {1'h0, bitmap[3]}}} + {1'h0, {1'h0, {1'h0, bitmap[4]} + {1'h0, bitmap[5]}} + {1'h0, {1'h0, bitmap[6]} + {1'h0, bitmap[7]}}} == 4'h1 & io_alloc_ready) | io_free_valid;
      end
      if (_GEN_0) begin
        if (bitmap1[0])
          select <= 3'h0;
        else if (bitmap1[1])
          select <= 3'h1;
        else if (bitmap1[2])
          select <= 3'h2;
        else if (bitmap1[3])
          select <= 3'h3;
        else if (bitmap1[4])
          select <= 3'h4;
        else if (bitmap1[5])
          select <= 3'h5;
        else
          select <= {2'h3, ~(bitmap1[6])};
      end
    end
  end // always @(posedge)
  assign io_alloc_valid = valid;
  assign io_alloc_bits = select;
endmodule

