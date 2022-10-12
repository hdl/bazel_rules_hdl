
module nested_module_0 (
    input logic clk,
    input logic [2:0] input_val,
    output logic [2:0] output_val
);

always_ff @(posedge clk) begin
    output_val <= input_val ^ 1;
end

endmodule
