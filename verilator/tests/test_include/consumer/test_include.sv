`include "bar/test_header.vh"

module test_include (
    output logic [7:0] value
);
  assign value = `VAL;
endmodule
