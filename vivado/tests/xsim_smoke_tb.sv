
module xsim_smoke_tb ();

  logic clk = 0;
  always #5ns clk = !clk;

  initial begin
    repeat (100) @(posedge clk);
    assert (1)
    else $error("A message about failed assertion");
    repeat (100) @(posedge clk);
    $finish();
  end

endmodule
