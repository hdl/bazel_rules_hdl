module mod_xand(
  input wire [7:0] a,
  input wire [7:0] b,
  output wire [7:0] x
);

  assign x[0] =        a[0] & b[0];
  assign x[1] = x[0] & a[1] & b[1];
  assign x[2] = x[1] & a[2] & b[2];
  assign x[3] = x[2] & a[3] & b[3];
  assign x[4] = x[3] & a[4] & b[4];
  assign x[5] = x[4] & a[5] & b[5];
  assign x[6] = x[5] & a[6] & b[6];
  assign x[7] = x[6] & a[7] & b[7];
endmodule