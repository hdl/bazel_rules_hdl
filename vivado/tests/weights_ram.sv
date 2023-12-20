module weights_ram #(
    parameter int RAM_DEPTH = 8,
    parameter int COUNTER_BITS = 3
) (
    input logic clk,
    input logic rst,
    input logic [7:0] shift_reg
);

  logic [COUNTER_BITS - 1:0] counter;
  logic [2:0] weights_address;
  logic [7:0] weights[1][RAM_DEPTH];

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
    weights[0][weights_address] <= shift_reg;
  end
endmodule
