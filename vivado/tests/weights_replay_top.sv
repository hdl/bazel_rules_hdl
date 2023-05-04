
module weights_replay_top #(
    parameter string POLARITY = "ACTIVE_HIGH",
    parameter int FREQ_HZ = 100000000
) (
  output logic [7:0] led
);

// The block design with Zynq MPSoc block.
zcu111_weights zcu111_weights (
  .led
);

endmodule
