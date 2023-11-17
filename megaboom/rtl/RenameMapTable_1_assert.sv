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
module RenameMapTable_1_assert(
  input       io_rollback,
  input [6:0] io_remap_reqs_0_pdst,
              map_table_31,
              map_table_30,
              map_table_29,
              map_table_28,
              map_table_27,
              map_table_26,
              map_table_25,
              map_table_24,
              map_table_23,
              map_table_22,
              map_table_21,
              map_table_20,
              map_table_19,
              map_table_18,
              map_table_17,
              map_table_16,
              map_table_15,
              map_table_14,
              map_table_13,
              map_table_12,
              map_table_11,
              map_table_10,
              map_table_9,
              map_table_8,
              map_table_7,
              map_table_6,
              map_table_5,
              map_table_4,
              map_table_3,
              map_table_2,
              map_table_1,
              map_table_0,
  input       io_remap_reqs_0_valid,
  input [6:0] io_remap_reqs_1_pdst,
  input       io_remap_reqs_1_valid,
  input [6:0] io_remap_reqs_2_pdst,
  input       io_remap_reqs_2_valid,
  input [6:0] io_remap_reqs_3_pdst,
  input       io_remap_reqs_3_valid,
              reset,
              clock
);

  wire _GEN = ~io_remap_reqs_0_valid | ~(map_table_0 == io_remap_reqs_0_pdst | map_table_1 == io_remap_reqs_0_pdst | map_table_2 == io_remap_reqs_0_pdst | map_table_3 == io_remap_reqs_0_pdst | map_table_4 == io_remap_reqs_0_pdst | map_table_5 == io_remap_reqs_0_pdst | map_table_6 == io_remap_reqs_0_pdst | map_table_7 == io_remap_reqs_0_pdst | map_table_8 == io_remap_reqs_0_pdst | map_table_9 == io_remap_reqs_0_pdst | map_table_10 == io_remap_reqs_0_pdst | map_table_11 == io_remap_reqs_0_pdst | map_table_12 == io_remap_reqs_0_pdst | map_table_13 == io_remap_reqs_0_pdst | map_table_14 == io_remap_reqs_0_pdst | map_table_15 == io_remap_reqs_0_pdst | map_table_16 == io_remap_reqs_0_pdst | map_table_17 == io_remap_reqs_0_pdst | map_table_18 == io_remap_reqs_0_pdst | map_table_19 == io_remap_reqs_0_pdst | map_table_20 == io_remap_reqs_0_pdst | map_table_21 == io_remap_reqs_0_pdst | map_table_22 == io_remap_reqs_0_pdst | map_table_23 == io_remap_reqs_0_pdst | map_table_24 == io_remap_reqs_0_pdst | map_table_25 == io_remap_reqs_0_pdst | map_table_26 == io_remap_reqs_0_pdst | map_table_27 == io_remap_reqs_0_pdst | map_table_28 == io_remap_reqs_0_pdst | map_table_29 == io_remap_reqs_0_pdst | map_table_30 == io_remap_reqs_0_pdst | map_table_31 == io_remap_reqs_0_pdst) | io_remap_reqs_0_pdst == 7'h0 & io_rollback;
  wire _GEN_0 = ~io_remap_reqs_1_valid | ~(map_table_0 == io_remap_reqs_1_pdst | map_table_1 == io_remap_reqs_1_pdst | map_table_2 == io_remap_reqs_1_pdst | map_table_3 == io_remap_reqs_1_pdst | map_table_4 == io_remap_reqs_1_pdst | map_table_5 == io_remap_reqs_1_pdst | map_table_6 == io_remap_reqs_1_pdst | map_table_7 == io_remap_reqs_1_pdst | map_table_8 == io_remap_reqs_1_pdst | map_table_9 == io_remap_reqs_1_pdst | map_table_10 == io_remap_reqs_1_pdst | map_table_11 == io_remap_reqs_1_pdst | map_table_12 == io_remap_reqs_1_pdst | map_table_13 == io_remap_reqs_1_pdst | map_table_14 == io_remap_reqs_1_pdst | map_table_15 == io_remap_reqs_1_pdst | map_table_16 == io_remap_reqs_1_pdst | map_table_17 == io_remap_reqs_1_pdst | map_table_18 == io_remap_reqs_1_pdst | map_table_19 == io_remap_reqs_1_pdst | map_table_20 == io_remap_reqs_1_pdst | map_table_21 == io_remap_reqs_1_pdst | map_table_22 == io_remap_reqs_1_pdst | map_table_23 == io_remap_reqs_1_pdst | map_table_24 == io_remap_reqs_1_pdst | map_table_25 == io_remap_reqs_1_pdst | map_table_26 == io_remap_reqs_1_pdst | map_table_27 == io_remap_reqs_1_pdst | map_table_28 == io_remap_reqs_1_pdst | map_table_29 == io_remap_reqs_1_pdst | map_table_30 == io_remap_reqs_1_pdst | map_table_31 == io_remap_reqs_1_pdst) | io_remap_reqs_1_pdst == 7'h0 & io_rollback;
  wire _GEN_1 = ~io_remap_reqs_2_valid | ~(map_table_0 == io_remap_reqs_2_pdst | map_table_1 == io_remap_reqs_2_pdst | map_table_2 == io_remap_reqs_2_pdst | map_table_3 == io_remap_reqs_2_pdst | map_table_4 == io_remap_reqs_2_pdst | map_table_5 == io_remap_reqs_2_pdst | map_table_6 == io_remap_reqs_2_pdst | map_table_7 == io_remap_reqs_2_pdst | map_table_8 == io_remap_reqs_2_pdst | map_table_9 == io_remap_reqs_2_pdst | map_table_10 == io_remap_reqs_2_pdst | map_table_11 == io_remap_reqs_2_pdst | map_table_12 == io_remap_reqs_2_pdst | map_table_13 == io_remap_reqs_2_pdst | map_table_14 == io_remap_reqs_2_pdst | map_table_15 == io_remap_reqs_2_pdst | map_table_16 == io_remap_reqs_2_pdst | map_table_17 == io_remap_reqs_2_pdst | map_table_18 == io_remap_reqs_2_pdst | map_table_19 == io_remap_reqs_2_pdst | map_table_20 == io_remap_reqs_2_pdst | map_table_21 == io_remap_reqs_2_pdst | map_table_22 == io_remap_reqs_2_pdst | map_table_23 == io_remap_reqs_2_pdst | map_table_24 == io_remap_reqs_2_pdst | map_table_25 == io_remap_reqs_2_pdst | map_table_26 == io_remap_reqs_2_pdst | map_table_27 == io_remap_reqs_2_pdst | map_table_28 == io_remap_reqs_2_pdst | map_table_29 == io_remap_reqs_2_pdst | map_table_30 == io_remap_reqs_2_pdst | map_table_31 == io_remap_reqs_2_pdst) | io_remap_reqs_2_pdst == 7'h0 & io_rollback;
  wire _GEN_2 = ~io_remap_reqs_3_valid | ~(map_table_0 == io_remap_reqs_3_pdst | map_table_1 == io_remap_reqs_3_pdst | map_table_2 == io_remap_reqs_3_pdst | map_table_3 == io_remap_reqs_3_pdst | map_table_4 == io_remap_reqs_3_pdst | map_table_5 == io_remap_reqs_3_pdst | map_table_6 == io_remap_reqs_3_pdst | map_table_7 == io_remap_reqs_3_pdst | map_table_8 == io_remap_reqs_3_pdst | map_table_9 == io_remap_reqs_3_pdst | map_table_10 == io_remap_reqs_3_pdst | map_table_11 == io_remap_reqs_3_pdst | map_table_12 == io_remap_reqs_3_pdst | map_table_13 == io_remap_reqs_3_pdst | map_table_14 == io_remap_reqs_3_pdst | map_table_15 == io_remap_reqs_3_pdst | map_table_16 == io_remap_reqs_3_pdst | map_table_17 == io_remap_reqs_3_pdst | map_table_18 == io_remap_reqs_3_pdst | map_table_19 == io_remap_reqs_3_pdst | map_table_20 == io_remap_reqs_3_pdst | map_table_21 == io_remap_reqs_3_pdst | map_table_22 == io_remap_reqs_3_pdst | map_table_23 == io_remap_reqs_3_pdst | map_table_24 == io_remap_reqs_3_pdst | map_table_25 == io_remap_reqs_3_pdst | map_table_26 == io_remap_reqs_3_pdst | map_table_27 == io_remap_reqs_3_pdst | map_table_28 == io_remap_reqs_3_pdst | map_table_29 == io_remap_reqs_3_pdst | map_table_30 == io_remap_reqs_3_pdst | map_table_31 == io_remap_reqs_3_pdst) | io_remap_reqs_3_pdst == 7'h0 & io_rollback;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed: [maptable] Trying to write a duplicate mapping.\n    at rename-maptable.scala:128 assert (!r || !map_table.contains(p) || p === 0.U && io.rollback, \"[maptable] Trying to write a duplicate mapping.\")}\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed: [maptable] Trying to write a duplicate mapping.\n    at rename-maptable.scala:128 assert (!r || !map_table.contains(p) || p === 0.U && io.rollback, \"[maptable] Trying to write a duplicate mapping.\")}\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed: [maptable] Trying to write a duplicate mapping.\n    at rename-maptable.scala:128 assert (!r || !map_table.contains(p) || p === 0.U && io.rollback, \"[maptable] Trying to write a duplicate mapping.\")}\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_2)
        $fwrite(32'h80000002, "Assertion failed: [maptable] Trying to write a duplicate mapping.\n    at rename-maptable.scala:128 assert (!r || !map_table.contains(p) || p === 0.U && io.rollback, \"[maptable] Trying to write a duplicate mapping.\")}\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
      assert__assert_2: assert(_GEN_1);
      assert__assert_3: assert(_GEN_2);
    end
  end // always @(posedge)
endmodule

