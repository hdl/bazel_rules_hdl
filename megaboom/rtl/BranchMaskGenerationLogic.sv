// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module BranchMaskGenerationLogic(
  input         clock,
                reset,
                io_is_branch_0,
                io_is_branch_1,
                io_is_branch_2,
                io_is_branch_3,
                io_will_fire_0,
                io_will_fire_1,
                io_will_fire_2,
                io_will_fire_3,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b2_uop_br_mask,
  input         io_brupdate_b2_mispredict,
                io_flush_pipeline,
  output [4:0]  io_br_tag_0,
                io_br_tag_1,
                io_br_tag_2,
                io_br_tag_3,
  output [19:0] io_br_mask_0,
                io_br_mask_1,
                io_br_mask_2,
                io_br_mask_3,
  output        io_is_full_0,
                io_is_full_1,
                io_is_full_2,
                io_is_full_3
);

  reg  [19:0] branch_mask;
  wire [19:0] _GEN_39 = branch_mask[0] ? (branch_mask[1] ? (branch_mask[2] ? (branch_mask[3] ? (branch_mask[4] ? (branch_mask[5] ? (branch_mask[6] ? (branch_mask[7] ? (branch_mask[8] ? (branch_mask[9] ? (branch_mask[10] ? (branch_mask[11] ? (branch_mask[12] ? (branch_mask[13] ? (branch_mask[14] ? (branch_mask[15] ? (branch_mask[16] ? (branch_mask[17] ? (branch_mask[18] ? {~(branch_mask[19]), 19'h0} : 20'h40000) : 20'h20000) : 20'h10000) : 20'h8000) : 20'h4000) : 20'h2000) : 20'h1000) : 20'h800) : 20'h400) : 20'h200) : 20'h100) : 20'h80) : 20'h40) : 20'h20) : 20'h10) : 20'h8) : 20'h4) : 20'h2) : 20'h1;
  wire [19:0] _GEN = {20{io_is_branch_0}} & _GEN_39 | branch_mask;
  wire [19:0] _GEN_79 = _GEN[0] ? (_GEN[1] ? (_GEN[2] ? (_GEN[3] ? (_GEN[4] ? (_GEN[5] ? (_GEN[6] ? (_GEN[7] ? (_GEN[8] ? (_GEN[9] ? (_GEN[10] ? (_GEN[11] ? (_GEN[12] ? (_GEN[13] ? (_GEN[14] ? (_GEN[15] ? (_GEN[16] ? (_GEN[17] ? (_GEN[18] ? {~(_GEN[19]), 19'h0} : 20'h40000) : 20'h20000) : 20'h10000) : 20'h8000) : 20'h4000) : 20'h2000) : 20'h1000) : 20'h800) : 20'h400) : 20'h200) : 20'h100) : 20'h80) : 20'h40) : 20'h20) : 20'h10) : 20'h8) : 20'h4) : 20'h2) : 20'h1;
  wire [19:0] _GEN_0 = {20{io_is_branch_1}} & _GEN_79 | _GEN;
  wire [19:0] _GEN_119 = _GEN_0[0] ? (_GEN_0[1] ? (_GEN_0[2] ? (_GEN_0[3] ? (_GEN_0[4] ? (_GEN_0[5] ? (_GEN_0[6] ? (_GEN_0[7] ? (_GEN_0[8] ? (_GEN_0[9] ? (_GEN_0[10] ? (_GEN_0[11] ? (_GEN_0[12] ? (_GEN_0[13] ? (_GEN_0[14] ? (_GEN_0[15] ? (_GEN_0[16] ? (_GEN_0[17] ? (_GEN_0[18] ? {~(_GEN_0[19]), 19'h0} : 20'h40000) : 20'h20000) : 20'h10000) : 20'h8000) : 20'h4000) : 20'h2000) : 20'h1000) : 20'h800) : 20'h400) : 20'h200) : 20'h100) : 20'h80) : 20'h40) : 20'h20) : 20'h10) : 20'h8) : 20'h4) : 20'h2) : 20'h1;
  wire [19:0] _GEN_1 = {20{io_is_branch_2}} & _GEN_119 | _GEN_0;
  wire [19:0] _GEN_2 = {20{io_will_fire_0}} & _GEN_39 | branch_mask;
  wire [19:0] _GEN_3 = {20{io_will_fire_1}} & _GEN_79 | _GEN_2;
  wire [19:0] _GEN_4 = {20{io_will_fire_2}} & _GEN_119 | _GEN_3;
  always @(posedge clock) begin
    if (reset)
      branch_mask <= 20'h0;
    else if (io_flush_pipeline)
      branch_mask <= 20'h0;
    else
      branch_mask <= ({20{io_will_fire_3}} & (_GEN_1[0] ? (_GEN_1[1] ? (_GEN_1[2] ? (_GEN_1[3] ? (_GEN_1[4] ? (_GEN_1[5] ? (_GEN_1[6] ? (_GEN_1[7] ? (_GEN_1[8] ? (_GEN_1[9] ? (_GEN_1[10] ? (_GEN_1[11] ? (_GEN_1[12] ? (_GEN_1[13] ? (_GEN_1[14] ? (_GEN_1[15] ? (_GEN_1[16] ? (_GEN_1[17] ? (_GEN_1[18] ? {~(_GEN_1[19]), 19'h0} : 20'h40000) : 20'h20000) : 20'h10000) : 20'h8000) : 20'h4000) : 20'h2000) : 20'h1000) : 20'h800) : 20'h400) : 20'h200) : 20'h100) : 20'h80) : 20'h40) : 20'h20) : 20'h10) : 20'h8) : 20'h4) : 20'h2) : 20'h1) | _GEN_4) & ~io_brupdate_b1_resolve_mask & (io_brupdate_b2_mispredict ? io_brupdate_b2_uop_br_mask : 20'hFFFFF);
  end // always @(posedge)
  assign io_br_tag_0 = branch_mask[0] ? (branch_mask[1] ? (branch_mask[2] ? (branch_mask[3] ? (branch_mask[4] ? (branch_mask[5] ? (branch_mask[6] ? (branch_mask[7] ? (branch_mask[8] ? (branch_mask[9] ? (branch_mask[10] ? (branch_mask[11] ? (branch_mask[12] ? (branch_mask[13] ? (branch_mask[14] ? (branch_mask[15] ? (branch_mask[16] ? (branch_mask[17] ? (branch_mask[18] ? (branch_mask[19] ? 5'h0 : 5'h13) : 5'h12) : 5'h11) : 5'h10) : 5'hF) : 5'hE) : 5'hD) : 5'hC) : 5'hB) : 5'hA) : 5'h9) : 5'h8) : 5'h7) : 5'h6) : 5'h5) : 5'h4) : 5'h3) : 5'h2) : 5'h1) : 5'h0;
  assign io_br_tag_1 = _GEN[0] ? (_GEN[1] ? (_GEN[2] ? (_GEN[3] ? (_GEN[4] ? (_GEN[5] ? (_GEN[6] ? (_GEN[7] ? (_GEN[8] ? (_GEN[9] ? (_GEN[10] ? (_GEN[11] ? (_GEN[12] ? (_GEN[13] ? (_GEN[14] ? (_GEN[15] ? (_GEN[16] ? (_GEN[17] ? (_GEN[18] ? (_GEN[19] ? 5'h0 : 5'h13) : 5'h12) : 5'h11) : 5'h10) : 5'hF) : 5'hE) : 5'hD) : 5'hC) : 5'hB) : 5'hA) : 5'h9) : 5'h8) : 5'h7) : 5'h6) : 5'h5) : 5'h4) : 5'h3) : 5'h2) : 5'h1) : 5'h0;
  assign io_br_tag_2 = _GEN_0[0] ? (_GEN_0[1] ? (_GEN_0[2] ? (_GEN_0[3] ? (_GEN_0[4] ? (_GEN_0[5] ? (_GEN_0[6] ? (_GEN_0[7] ? (_GEN_0[8] ? (_GEN_0[9] ? (_GEN_0[10] ? (_GEN_0[11] ? (_GEN_0[12] ? (_GEN_0[13] ? (_GEN_0[14] ? (_GEN_0[15] ? (_GEN_0[16] ? (_GEN_0[17] ? (_GEN_0[18] ? (_GEN_0[19] ? 5'h0 : 5'h13) : 5'h12) : 5'h11) : 5'h10) : 5'hF) : 5'hE) : 5'hD) : 5'hC) : 5'hB) : 5'hA) : 5'h9) : 5'h8) : 5'h7) : 5'h6) : 5'h5) : 5'h4) : 5'h3) : 5'h2) : 5'h1) : 5'h0;
  assign io_br_tag_3 = _GEN_1[0] ? (_GEN_1[1] ? (_GEN_1[2] ? (_GEN_1[3] ? (_GEN_1[4] ? (_GEN_1[5] ? (_GEN_1[6] ? (_GEN_1[7] ? (_GEN_1[8] ? (_GEN_1[9] ? (_GEN_1[10] ? (_GEN_1[11] ? (_GEN_1[12] ? (_GEN_1[13] ? (_GEN_1[14] ? (_GEN_1[15] ? (_GEN_1[16] ? (_GEN_1[17] ? (_GEN_1[18] ? (_GEN_1[19] ? 5'h0 : 5'h13) : 5'h12) : 5'h11) : 5'h10) : 5'hF) : 5'hE) : 5'hD) : 5'hC) : 5'hB) : 5'hA) : 5'h9) : 5'h8) : 5'h7) : 5'h6) : 5'h5) : 5'h4) : 5'h3) : 5'h2) : 5'h1) : 5'h0;
  assign io_br_mask_0 = branch_mask & ~io_brupdate_b1_resolve_mask;
  assign io_br_mask_1 = _GEN_2 & ~io_brupdate_b1_resolve_mask;
  assign io_br_mask_2 = _GEN_3 & ~io_brupdate_b1_resolve_mask;
  assign io_br_mask_3 = _GEN_4 & ~io_brupdate_b1_resolve_mask;
  assign io_is_full_0 = (&branch_mask) & io_is_branch_0;
  assign io_is_full_1 = (&_GEN) & io_is_branch_1;
  assign io_is_full_2 = (&_GEN_0) & io_is_branch_2;
  assign io_is_full_3 = (&_GEN_1) & io_is_branch_3;
endmodule

