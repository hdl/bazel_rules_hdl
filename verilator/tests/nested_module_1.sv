
module nested_module_1 (
    input logic clk,
    input logic [2:0] input_val,
    output logic [2:0] output_val
);

logic [2:0] mod_val;

always_ff @(posedge clk) begin
    mod_val <= input_val ^ 2;
end

nested_module_0 nested_module_0 (
    .clk,
    .input_val(mod_val),
    .output_val
);

endmodule
