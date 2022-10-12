
module load_and_count (
    input logic clk,
    
    output logic [15:0] counter_value
);

logic [15:0] counter [1];

assign counter_value = counter[0];

initial begin
    $readmemh("verilator/tests/test_data.dat", counter);
end

always_ff @(posedge clk) begin
    counter[0] <= counter[0] + 1;
end

endmodule
