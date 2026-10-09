module tb();

    // Waveform
    initial begin : proc_waveform
        static string vcd_file = "dump.vcd";
        if ($value$plusargs("trace=%s", vcd_file)) begin
            $display(vcd_file);
            $dumpfile(vcd_file);
            $dumpvars();
        end
    end

    // DUT
    logic [7:0] x;
    logic [7:0] y;
    logic carry_in;
    logic carry_output_bit;
    logic [7:0] sum;

    adder dut (
        .x(x),
        .y(y),
        .carry_in(carry_in),
        .carry_output_bit(carry_output_bit),
        .sum(sum)
    );

    // Test procedure
    initial begin : proc_test
        $display("Testing adder:");
        #10
            x = 1;
            y = 2;
        #10
            $display("x=%d, y=%d, x+y=%d",x,y,sum);
            assert(sum == 3);
        #10
            $display("Testing done.");
            $finish();
    end

endmodule
