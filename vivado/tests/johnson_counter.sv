module johnson_counter #(
    parameter int COUNTER_BITS = 3
) (
    input logic clk,
    input logic rst,
    input logic direction,
    output logic [7:0] shift_reg
);

  logic [COUNTER_BITS - 1:0] counter;
  logic [7:0] shift_reg_next;

  always_comb begin
    if (direction) begin
      shift_reg_next = {shift_reg[6:0], !shift_reg[7]};
    end else begin
      shift_reg_next = {!shift_reg[0], shift_reg[7:1]};
    end
  end

  always @(posedge clk) begin
    if (rst) begin
      shift_reg <= 0;
      counter   <= 0;
    end else begin
      // When the top bit flips, shift the registers.
      if (counter == (1 << COUNTER_BITS) - 1) begin
        shift_reg <= shift_reg_next;
        counter   <= 0;
      end else begin
        counter <= counter + 1;
      end
    end
  end

endmodule
