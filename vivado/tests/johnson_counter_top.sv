module johnson_counter_top (
    output logic [7:0] led
);

  logic clk;
  logic reset;
  logic direction;

  // There is a 100MHz clock. Use 26 bits so its a nice visible speed.
  johnson_counter #(
      .COUNTER_BITS(26)
  ) johnson_counter (
      .clk(clk),
      .rst(reset),
      .direction(direction),
      .shift_reg(led)
  );

  // The block design with Zynq MPSoc block.
  zcu111_gpio zcu111_gpio (
      .clk(clk),
      .reset(reset),
      .direction(direction)
  );

endmodule
