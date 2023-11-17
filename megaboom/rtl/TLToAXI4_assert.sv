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
module TLToAXI4_assert(
  input count_1,
        dec,
        inc,
        count_2,
        dec_1,
        inc_1,
        count_3,
        dec_2,
        inc_2,
        count_4,
        dec_3,
        inc_3,
        count_5,
        dec_4,
        inc_4,
        count_6,
        dec_5,
        inc_5,
        count_7,
        dec_6,
        inc_6,
        count_8,
        dec_7,
        inc_7,
        count_9,
        dec_8,
        inc_8,
        count_10,
        dec_9,
        inc_9,
        count_11,
        dec_10,
        inc_10,
        count_12,
        dec_11,
        inc_11,
        count_13,
        dec_12,
        inc_12,
        count_14,
        dec_13,
        inc_13,
        count_15,
        dec_14,
        inc_14,
        count_16,
        dec_15,
        inc_15,
        count_17,
        dec_16,
        inc_16,
        count_18,
        dec_17,
        inc_17,
        count_19,
        dec_18,
        inc_18,
        count_20,
        dec_19,
        inc_19,
        reset,
        clock
);

  wire _GEN = ~dec | count_1;
  wire _GEN_0 = ~inc | ~count_1;
  wire _GEN_1 = ~dec_1 | count_2;
  wire _GEN_2 = ~inc_1 | ~count_2;
  wire _GEN_3 = ~dec_2 | count_3;
  wire _GEN_4 = ~inc_2 | ~count_3;
  wire _GEN_5 = ~dec_3 | count_4;
  wire _GEN_6 = ~inc_3 | ~count_4;
  wire _GEN_7 = ~dec_4 | count_5;
  wire _GEN_8 = ~inc_4 | ~count_5;
  wire _GEN_9 = ~dec_5 | count_6;
  wire _GEN_10 = ~inc_5 | ~count_6;
  wire _GEN_11 = ~dec_6 | count_7;
  wire _GEN_12 = ~inc_6 | ~count_7;
  wire _GEN_13 = ~dec_7 | count_8;
  wire _GEN_14 = ~inc_7 | ~count_8;
  wire _GEN_15 = ~dec_8 | count_9;
  wire _GEN_16 = ~inc_8 | ~count_9;
  wire _GEN_17 = ~dec_9 | count_10;
  wire _GEN_18 = ~inc_9 | ~count_10;
  wire _GEN_19 = ~dec_10 | count_11;
  wire _GEN_20 = ~inc_10 | ~count_11;
  wire _GEN_21 = ~dec_11 | count_12;
  wire _GEN_22 = ~inc_11 | ~count_12;
  wire _GEN_23 = ~dec_12 | count_13;
  wire _GEN_24 = ~inc_12 | ~count_13;
  wire _GEN_25 = ~dec_13 | count_14;
  wire _GEN_26 = ~inc_13 | ~count_14;
  wire _GEN_27 = ~dec_14 | count_15;
  wire _GEN_28 = ~inc_14 | ~count_15;
  wire _GEN_29 = ~dec_15 | count_16;
  wire _GEN_30 = ~inc_15 | ~count_16;
  wire _GEN_31 = ~dec_16 | count_17;
  wire _GEN_32 = ~inc_16 | ~count_17;
  wire _GEN_33 = ~dec_17 | count_18;
  wire _GEN_34 = ~inc_17 | ~count_18;
  wire _GEN_35 = ~dec_18 | count_19;
  wire _GEN_36 = ~inc_18 | ~count_19;
  wire _GEN_37 = ~dec_19 | count_20;
  wire _GEN_38 = ~inc_19 | ~count_20;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_6)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_7)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_8)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_9)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_10)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_11)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_12)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_13)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_14)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_15)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_16)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_17)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_18)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_19)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_20)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_21)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_22)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_23)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_24)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_25)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_26)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_27)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_28)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_29)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_30)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_31)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_32)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_33)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_34)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_35)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_36)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_37)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:273 assert (!dec || count =/= 0.U)        // underflow\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_38)
        $fwrite(32'h80000002, "Assertion failed\n    at ToAXI4.scala:274 assert (!inc || count =/= maxCount.U) // overflow\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
      assert__assert_2: assert(_GEN_1);
      assert__assert_3: assert(_GEN_2);
      assert__assert_4: assert(_GEN_3);
      assert__assert_5: assert(_GEN_4);
      assert__assert_6: assert(_GEN_5);
      assert__assert_7: assert(_GEN_6);
      assert__assert_8: assert(_GEN_7);
      assert__assert_9: assert(_GEN_8);
      assert__assert_10: assert(_GEN_9);
      assert__assert_11: assert(_GEN_10);
      assert__assert_12: assert(_GEN_11);
      assert__assert_13: assert(_GEN_12);
      assert__assert_14: assert(_GEN_13);
      assert__assert_15: assert(_GEN_14);
      assert__assert_16: assert(_GEN_15);
      assert__assert_17: assert(_GEN_16);
      assert__assert_18: assert(_GEN_17);
      assert__assert_19: assert(_GEN_18);
      assert__assert_20: assert(_GEN_19);
      assert__assert_21: assert(_GEN_20);
      assert__assert_22: assert(_GEN_21);
      assert__assert_23: assert(_GEN_22);
      assert__assert_24: assert(_GEN_23);
      assert__assert_25: assert(_GEN_24);
      assert__assert_26: assert(_GEN_25);
      assert__assert_27: assert(_GEN_26);
      assert__assert_28: assert(_GEN_27);
      assert__assert_29: assert(_GEN_28);
      assert__assert_30: assert(_GEN_29);
      assert__assert_31: assert(_GEN_30);
      assert__assert_32: assert(_GEN_31);
      assert__assert_33: assert(_GEN_32);
      assert__assert_34: assert(_GEN_33);
      assert__assert_35: assert(_GEN_34);
      assert__assert_36: assert(_GEN_35);
      assert__assert_37: assert(_GEN_36);
      assert__assert_38: assert(_GEN_37);
      assert__assert_39: assert(_GEN_38);
    end
  end // always @(posedge)
endmodule

