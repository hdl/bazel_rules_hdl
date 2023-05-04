
module weights_replay #(
    parameter int COUNTER_BITS = 3
) (
    input logic clk,
    input logic rst,
    output logic [7:0] shift_reg
);

  logic [COUNTER_BITS - 1:0] counter;
  logic [2:0] weights_address;
  logic [7:0] weights [1][8];

`ifdef __SYNTHESIS__
  initial begin
    $readmemh("./test.mem", weights);
  end
`else
  initial begin
    $readmemh("./vivado/tests/test.mem", weights);
  end
`endif

  always @(posedge clk) begin
    if (rst) begin
      weights_address <= 0;
      counter <= 0;
    end else begin
      // When the top bit flips, shift the registers.
      if (counter == (1 << COUNTER_BITS) - 1) begin
        counter <= 0;
        weights_address <= weights_address + 1;
      end else begin
        counter <= counter + 1;
      end
    end
    shift_reg <= weights[0][weights_address];
  end

endmodule
