// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module DivSqrtRecF64(
  input         clock,
                reset,
                io_inValid,
                io_sqrtOp,
  input  [64:0] io_a,
                io_b,
  input  [2:0]  io_roundingMode,
  output        io_inReady_div,
                io_inReady_sqrt,
                io_outValid_div,
                io_outValid_sqrt,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire [104:0] _mul_io_result_s3;
  wire [3:0]   _ds_io_usingMulAdd;
  wire         _ds_io_latchMulAddA_0;
  wire [53:0]  _ds_io_mulAddA_0;
  wire         _ds_io_latchMulAddB_0;
  wire [53:0]  _ds_io_mulAddB_0;
  wire [104:0] _ds_io_mulAddC_2;
  DivSqrtRecF64_mulAddZ31 ds (
    .clock             (clock),
    .reset             (reset),
    .io_inValid        (io_inValid),
    .io_sqrtOp         (io_sqrtOp),
    .io_a              (io_a),
    .io_b              (io_b),
    .io_roundingMode   (io_roundingMode),
    .io_mulAddResult_3 (_mul_io_result_s3),
    .io_inReady_div    (io_inReady_div),
    .io_inReady_sqrt   (io_inReady_sqrt),
    .io_usingMulAdd    (_ds_io_usingMulAdd),
    .io_latchMulAddA_0 (_ds_io_latchMulAddA_0),
    .io_mulAddA_0      (_ds_io_mulAddA_0),
    .io_latchMulAddB_0 (_ds_io_latchMulAddB_0),
    .io_mulAddB_0      (_ds_io_mulAddB_0),
    .io_mulAddC_2      (_ds_io_mulAddC_2),
    .io_outValid_div   (io_outValid_div),
    .io_outValid_sqrt  (io_outValid_sqrt),
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
  Mul54 mul (
    .clock         (clock),
    .io_val_s0     (_ds_io_usingMulAdd[0]),
    .io_latch_a_s0 (_ds_io_latchMulAddA_0),
    .io_a_s0       (_ds_io_mulAddA_0),
    .io_latch_b_s0 (_ds_io_latchMulAddB_0),
    .io_b_s0       (_ds_io_mulAddB_0),
    .io_c_s2       (_ds_io_mulAddC_2),
    .io_result_s3  (_mul_io_result_s3)
  );
endmodule

