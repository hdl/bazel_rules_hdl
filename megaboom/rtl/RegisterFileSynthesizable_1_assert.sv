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
module RegisterFileSynthesizable_1_assert(
  input [6:0] io_write_ports_0_bits_addr,
              io_write_ports_1_bits_addr,
  input       io_write_ports_1_valid,
              io_write_ports_0_valid,
  input [6:0] io_write_ports_2_bits_addr,
  input       io_write_ports_2_valid,
  input [6:0] io_write_ports_3_bits_addr,
  input       io_write_ports_3_valid,
  input [6:0] io_write_ports_4_bits_addr,
  input       io_write_ports_4_valid,
  input [6:0] io_write_ports_5_bits_addr,
  input       io_write_ports_5_valid,
              reset,
              clock
);

  wire _GEN = io_write_ports_0_bits_addr == 7'h0;
  wire _GEN_0 = ~io_write_ports_0_valid | ~io_write_ports_1_valid | io_write_ports_0_bits_addr != io_write_ports_1_bits_addr | _GEN;
  wire _GEN_1 = ~io_write_ports_0_valid | ~io_write_ports_2_valid | io_write_ports_0_bits_addr != io_write_ports_2_bits_addr | _GEN;
  wire _GEN_2 = ~io_write_ports_0_valid | ~io_write_ports_3_valid | io_write_ports_0_bits_addr != io_write_ports_3_bits_addr | _GEN;
  wire _GEN_3 = ~io_write_ports_0_valid | ~io_write_ports_4_valid | io_write_ports_0_bits_addr != io_write_ports_4_bits_addr | _GEN;
  wire _GEN_4 = ~io_write_ports_0_valid | ~io_write_ports_5_valid | io_write_ports_0_bits_addr != io_write_ports_5_bits_addr | _GEN;
  wire _GEN_5 = io_write_ports_1_bits_addr == 7'h0;
  wire _GEN_6 = ~io_write_ports_1_valid | ~io_write_ports_2_valid | io_write_ports_1_bits_addr != io_write_ports_2_bits_addr | _GEN_5;
  wire _GEN_7 = ~io_write_ports_1_valid | ~io_write_ports_3_valid | io_write_ports_1_bits_addr != io_write_ports_3_bits_addr | _GEN_5;
  wire _GEN_8 = ~io_write_ports_1_valid | ~io_write_ports_4_valid | io_write_ports_1_bits_addr != io_write_ports_4_bits_addr | _GEN_5;
  wire _GEN_9 = ~io_write_ports_1_valid | ~io_write_ports_5_valid | io_write_ports_1_bits_addr != io_write_ports_5_bits_addr | _GEN_5;
  wire _GEN_10 = io_write_ports_2_bits_addr == 7'h0;
  wire _GEN_11 = ~io_write_ports_2_valid | ~io_write_ports_3_valid | io_write_ports_2_bits_addr != io_write_ports_3_bits_addr | _GEN_10;
  wire _GEN_12 = ~io_write_ports_2_valid | ~io_write_ports_4_valid | io_write_ports_2_bits_addr != io_write_ports_4_bits_addr | _GEN_10;
  wire _GEN_13 = ~io_write_ports_2_valid | ~io_write_ports_5_valid | io_write_ports_2_bits_addr != io_write_ports_5_bits_addr | _GEN_10;
  wire _GEN_14 = io_write_ports_3_bits_addr == 7'h0;
  wire _GEN_15 = ~io_write_ports_3_valid | ~io_write_ports_4_valid | io_write_ports_3_bits_addr != io_write_ports_4_bits_addr | _GEN_14;
  wire _GEN_16 = ~io_write_ports_3_valid | ~io_write_ports_5_valid | io_write_ports_3_bits_addr != io_write_ports_5_bits_addr | _GEN_14;
  wire _GEN_17 = ~io_write_ports_4_valid | ~io_write_ports_5_valid | io_write_ports_4_bits_addr != io_write_ports_5_bits_addr | io_write_ports_4_bits_addr == 7'h0;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_11)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_12)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN_0);
      assert__assert_1: assert(_GEN_1);
      assert__assert_2: assert(_GEN_2);
      assert__assert_3: assert(_GEN_3);
      assert__assert_4: assert(_GEN_4);
      assert__assert_5: assert(_GEN_6);
      assert__assert_6: assert(_GEN_7);
      assert__assert_7: assert(_GEN_8);
      assert__assert_8: assert(_GEN_9);
      assert__assert_9: assert(_GEN_11);
      assert__assert_10: assert(_GEN_12);
      assert__assert_11: assert(_GEN_13);
      assert__assert_12: assert(_GEN_15);
      assert__assert_13: assert(_GEN_16);
      assert__assert_14: assert(_GEN_17);
    end
  end // always @(posedge)
endmodule

