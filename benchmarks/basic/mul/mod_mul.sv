module mod_mul(
  input wire [7:0] a,
  input wire [7:0] b,
  output wire [7:0] x
);

  assign x = a * b;
endmodule