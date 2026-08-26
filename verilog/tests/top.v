`include "defs.vh"

module top(
    input  wire A,
    output wire Y
);

    wire [`COUNT:0] y;

    genvar i;
    generate for (i = 0; i < `COUNT; i = i + 1) begin
        not_gate xnot_gate (
            .A (y[i]),
            .Y (y[i+1])
        );
    end endgenerate

    assign y[0] = A;
    assign Y    = y[`COUNT];

endmodule
