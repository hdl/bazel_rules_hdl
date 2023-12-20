/*
    This testbench tests if the IP blocks inside of IP blocks are properly imported.
*/
module weights_replay_and_save_tb;

  logic clk = 0;
  logic rst = 0;
  realtime ClkPeriod = 100;

  always #(ClkPeriod / 2) clk = ~clk;
  weights_replay_and_save_ip weights_replay_and_save_dut (
      .clk(clk),
      .rst(rst)
  );
  initial begin
    rst = 1;
    repeat (100) begin
      @(posedge clk);
    end
    rst = 0;
    repeat (100) begin
      @(posedge clk);
    end
    for (int i = 0; i < 8; i++) begin
      if(weights_replay_and_save_dut.inst.weights_ram_0.inst.weights[0][i]
      !==weights_replay_and_save_dut.inst.weights_replay_0.inst.weights[0][i]) begin
        $error("RAM value mismatched on index %d!",i);
        $finish;
      end
    end
    $display("Test passed!");
    $finish;
  end
endmodule
