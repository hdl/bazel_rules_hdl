// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// VCS coverage exclude_file
module RegisterFileSynthesizable_assert(
  input [6:0] io_write_ports_0_bits_addr,
              io_write_ports_1_bits_addr,
  input       io_write_ports_1_valid,
              io_write_ports_0_valid,
  input [6:0] io_write_ports_2_bits_addr,
  input       io_write_ports_2_valid,
  input [6:0] io_write_ports_3_bits_addr,
  input       io_write_ports_3_valid,
              reset,
              clock
);

  wire _GEN = io_write_ports_0_bits_addr == 7'h0;
  wire _GEN_0 = ~io_write_ports_0_valid | ~io_write_ports_1_valid | io_write_ports_0_bits_addr != io_write_ports_1_bits_addr | _GEN;
  wire _GEN_1 = ~io_write_ports_0_valid | ~io_write_ports_2_valid | io_write_ports_0_bits_addr != io_write_ports_2_bits_addr | _GEN;
  wire _GEN_2 = ~io_write_ports_0_valid | ~io_write_ports_3_valid | io_write_ports_0_bits_addr != io_write_ports_3_bits_addr | _GEN;
  wire _GEN_3 = io_write_ports_1_bits_addr == 7'h0;
  wire _GEN_4 = ~io_write_ports_1_valid | ~io_write_ports_2_valid | io_write_ports_1_bits_addr != io_write_ports_2_bits_addr | _GEN_3;
  wire _GEN_5 = ~io_write_ports_1_valid | ~io_write_ports_3_valid | io_write_ports_1_bits_addr != io_write_ports_3_bits_addr | _GEN_3;
  wire _GEN_6 = ~io_write_ports_2_valid | ~io_write_ports_3_valid | io_write_ports_2_bits_addr != io_write_ports_3_bits_addr | io_write_ports_2_bits_addr == 7'h0;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN_0);
      assert__assert_1: assert(_GEN_1);
      assert__assert_2: assert(_GEN_2);
      assert__assert_3: assert(_GEN_4);
      assert__assert_4: assert(_GEN_5);
      assert__assert_5: assert(_GEN_6);
    end
  end // always @(posedge)
endmodule

