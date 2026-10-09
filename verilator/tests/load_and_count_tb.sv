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
    logic        clk;
    logic [15:0] cnt;

    load_and_count dut (
        .clk            (clk),
        .counter_value  (cnt)
    );

    // Test procedure
    initial begin : proc_test
        $display("Testing counter preloaded with data from a file");

        #0
            clk = 1'b0;
            $display("initial: ", cnt);
            assert(cnt == 16'hA5B6);

        for (integer i=0; i<10; i=i+1) begin
            #10
                clk = 1'b1;
            #1  clk = 1'b0;
                $display("count: ", cnt);
                assert(cnt == (16'hA5B6 + 16'(i+1)));
        end

        #10
            $display("Testing done.");
            $finish();
    end

endmodule
