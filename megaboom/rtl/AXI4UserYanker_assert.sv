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
module AXI4UserYanker_assert(
  input [3:0] auto_out_r_bits_id,
  input       Queue_15_io_deq_valid,
              Queue_14_io_deq_valid,
              Queue_13_io_deq_valid,
              Queue_12_io_deq_valid,
              Queue_11_io_deq_valid,
              Queue_10_io_deq_valid,
              Queue_9_io_deq_valid,
              Queue_8_io_deq_valid,
              Queue_7_io_deq_valid,
              Queue_6_io_deq_valid,
              Queue_5_io_deq_valid,
              Queue_4_io_deq_valid,
              Queue_3_io_deq_valid,
              Queue_2_io_deq_valid,
              Queue_1_io_deq_valid,
              Queue_io_deq_valid,
              auto_out_r_valid,
  input [3:0] auto_out_b_bits_id,
  input       Queue_31_io_deq_valid,
              Queue_30_io_deq_valid,
              Queue_29_io_deq_valid,
              Queue_28_io_deq_valid,
              Queue_27_io_deq_valid,
              Queue_26_io_deq_valid,
              Queue_25_io_deq_valid,
              Queue_24_io_deq_valid,
              Queue_23_io_deq_valid,
              Queue_22_io_deq_valid,
              Queue_21_io_deq_valid,
              Queue_20_io_deq_valid,
              Queue_19_io_deq_valid,
              Queue_18_io_deq_valid,
              Queue_17_io_deq_valid,
              Queue_16_io_deq_valid,
              auto_out_b_valid,
              reset,
              clock
);

  reg  casez_tmp;
  reg  casez_tmp_0;
  always @(*) begin
    casez (auto_out_r_bits_id)
      4'b0000:
        casez_tmp = Queue_io_deq_valid;
      4'b0001:
        casez_tmp = Queue_1_io_deq_valid;
      4'b0010:
        casez_tmp = Queue_2_io_deq_valid;
      4'b0011:
        casez_tmp = Queue_3_io_deq_valid;
      4'b0100:
        casez_tmp = Queue_4_io_deq_valid;
      4'b0101:
        casez_tmp = Queue_5_io_deq_valid;
      4'b0110:
        casez_tmp = Queue_6_io_deq_valid;
      4'b0111:
        casez_tmp = Queue_7_io_deq_valid;
      4'b1000:
        casez_tmp = Queue_8_io_deq_valid;
      4'b1001:
        casez_tmp = Queue_9_io_deq_valid;
      4'b1010:
        casez_tmp = Queue_10_io_deq_valid;
      4'b1011:
        casez_tmp = Queue_11_io_deq_valid;
      4'b1100:
        casez_tmp = Queue_12_io_deq_valid;
      4'b1101:
        casez_tmp = Queue_13_io_deq_valid;
      4'b1110:
        casez_tmp = Queue_14_io_deq_valid;
      default:
        casez_tmp = Queue_15_io_deq_valid;
    endcase
  end // always @(*)
  wire _GEN = ~auto_out_r_valid | casez_tmp;
  always @(*) begin
    casez (auto_out_b_bits_id)
      4'b0000:
        casez_tmp_0 = Queue_16_io_deq_valid;
      4'b0001:
        casez_tmp_0 = Queue_17_io_deq_valid;
      4'b0010:
        casez_tmp_0 = Queue_18_io_deq_valid;
      4'b0011:
        casez_tmp_0 = Queue_19_io_deq_valid;
      4'b0100:
        casez_tmp_0 = Queue_20_io_deq_valid;
      4'b0101:
        casez_tmp_0 = Queue_21_io_deq_valid;
      4'b0110:
        casez_tmp_0 = Queue_22_io_deq_valid;
      4'b0111:
        casez_tmp_0 = Queue_23_io_deq_valid;
      4'b1000:
        casez_tmp_0 = Queue_24_io_deq_valid;
      4'b1001:
        casez_tmp_0 = Queue_25_io_deq_valid;
      4'b1010:
        casez_tmp_0 = Queue_26_io_deq_valid;
      4'b1011:
        casez_tmp_0 = Queue_27_io_deq_valid;
      4'b1100:
        casez_tmp_0 = Queue_28_io_deq_valid;
      4'b1101:
        casez_tmp_0 = Queue_29_io_deq_valid;
      4'b1110:
        casez_tmp_0 = Queue_30_io_deq_valid;
      default:
        casez_tmp_0 = Queue_31_io_deq_valid;
    endcase
  end // always @(*)
  wire _GEN_0 = ~auto_out_b_valid | casez_tmp_0;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & ~_GEN)
        $fwrite(32'h80000002, "Assertion failed\n    at UserYanker.scala:66 assert (!out.r.valid || r_valid) // Q must be ready faster than the response\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at UserYanker.scala:95 assert (!out.b.valid || b_valid) // Q must be ready faster than the response\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(_GEN);
      assert__assert_1: assert(_GEN_0);
    end
  end // always @(posedge)
endmodule

