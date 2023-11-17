// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module PMPChecker(
  input  [1:0]  io_prv,
  input         io_pmp_0_cfg_l,
  input  [1:0]  io_pmp_0_cfg_a,
  input         io_pmp_0_cfg_x,
                io_pmp_0_cfg_w,
                io_pmp_0_cfg_r,
  input  [29:0] io_pmp_0_addr,
  input  [31:0] io_pmp_0_mask,
  input         io_pmp_1_cfg_l,
  input  [1:0]  io_pmp_1_cfg_a,
  input         io_pmp_1_cfg_x,
                io_pmp_1_cfg_w,
                io_pmp_1_cfg_r,
  input  [29:0] io_pmp_1_addr,
  input  [31:0] io_pmp_1_mask,
  input         io_pmp_2_cfg_l,
  input  [1:0]  io_pmp_2_cfg_a,
  input         io_pmp_2_cfg_x,
                io_pmp_2_cfg_w,
                io_pmp_2_cfg_r,
  input  [29:0] io_pmp_2_addr,
  input  [31:0] io_pmp_2_mask,
  input         io_pmp_3_cfg_l,
  input  [1:0]  io_pmp_3_cfg_a,
  input         io_pmp_3_cfg_x,
                io_pmp_3_cfg_w,
                io_pmp_3_cfg_r,
  input  [29:0] io_pmp_3_addr,
  input  [31:0] io_pmp_3_mask,
  input         io_pmp_4_cfg_l,
  input  [1:0]  io_pmp_4_cfg_a,
  input         io_pmp_4_cfg_x,
                io_pmp_4_cfg_w,
                io_pmp_4_cfg_r,
  input  [29:0] io_pmp_4_addr,
  input  [31:0] io_pmp_4_mask,
  input         io_pmp_5_cfg_l,
  input  [1:0]  io_pmp_5_cfg_a,
  input         io_pmp_5_cfg_x,
                io_pmp_5_cfg_w,
                io_pmp_5_cfg_r,
  input  [29:0] io_pmp_5_addr,
  input  [31:0] io_pmp_5_mask,
  input         io_pmp_6_cfg_l,
  input  [1:0]  io_pmp_6_cfg_a,
  input         io_pmp_6_cfg_x,
                io_pmp_6_cfg_w,
                io_pmp_6_cfg_r,
  input  [29:0] io_pmp_6_addr,
  input  [31:0] io_pmp_6_mask,
  input         io_pmp_7_cfg_l,
  input  [1:0]  io_pmp_7_cfg_a,
  input         io_pmp_7_cfg_x,
                io_pmp_7_cfg_w,
                io_pmp_7_cfg_r,
  input  [29:0] io_pmp_7_addr,
  input  [31:0] io_pmp_7_mask,
                io_addr,
  output        io_r,
                io_w,
                io_x
);

  wire res_hit = io_pmp_7_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_7_addr[29:2]) & ~(io_pmp_7_mask[31:4])) == 28'h0 : io_pmp_7_cfg_a[0] & io_addr[31:4] >= io_pmp_6_addr[29:2] & (io_addr[31:4] < io_pmp_7_addr[29:2] | (io_addr[31:4] ^ io_pmp_7_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_7_addr[1:0], 2'h0});
  wire res_ignore = io_prv[1] & ~io_pmp_7_cfg_l;
  wire res_aligned = io_pmp_7_cfg_a[1] ? (&(io_pmp_7_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_6_addr[29:2]) == 28'h0 & (|(io_pmp_6_addr[1:0] & ~(io_addr[3:2]))) | (io_addr[31:4] ^ io_pmp_7_addr[29:2]) == 28'h0 & (|(io_pmp_7_addr[1:0])));
  wire res_hit_1 = io_pmp_6_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_6_addr[29:2]) & ~(io_pmp_6_mask[31:4])) == 28'h0 : io_pmp_6_cfg_a[0] & io_addr[31:4] >= io_pmp_5_addr[29:2] & (io_addr[31:4] < io_pmp_6_addr[29:2] | (io_addr[31:4] ^ io_pmp_6_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_6_addr[1:0], 2'h0});
  wire res_ignore_1 = io_prv[1] & ~io_pmp_6_cfg_l;
  wire res_aligned_1 = io_pmp_6_cfg_a[1] ? (&(io_pmp_6_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_5_addr[29:2]) == 28'h0 & (|(io_pmp_5_addr[1:0] & ~(io_addr[3:2]))) | (io_addr[31:4] ^ io_pmp_6_addr[29:2]) == 28'h0 & (|(io_pmp_6_addr[1:0])));
  wire res_hit_2 = io_pmp_5_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_5_addr[29:2]) & ~(io_pmp_5_mask[31:4])) == 28'h0 : io_pmp_5_cfg_a[0] & io_addr[31:4] >= io_pmp_4_addr[29:2] & (io_addr[31:4] < io_pmp_5_addr[29:2] | (io_addr[31:4] ^ io_pmp_5_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_5_addr[1:0], 2'h0});
  wire res_ignore_2 = io_prv[1] & ~io_pmp_5_cfg_l;
  wire res_aligned_2 = io_pmp_5_cfg_a[1] ? (&(io_pmp_5_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_4_addr[29:2]) == 28'h0 & (|(io_pmp_4_addr[1:0] & ~(io_addr[3:2]))) | (io_addr[31:4] ^ io_pmp_5_addr[29:2]) == 28'h0 & (|(io_pmp_5_addr[1:0])));
  wire res_hit_3 = io_pmp_4_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_4_addr[29:2]) & ~(io_pmp_4_mask[31:4])) == 28'h0 : io_pmp_4_cfg_a[0] & io_addr[31:4] >= io_pmp_3_addr[29:2] & (io_addr[31:4] < io_pmp_4_addr[29:2] | (io_addr[31:4] ^ io_pmp_4_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_4_addr[1:0], 2'h0});
  wire res_ignore_3 = io_prv[1] & ~io_pmp_4_cfg_l;
  wire res_aligned_3 = io_pmp_4_cfg_a[1] ? (&(io_pmp_4_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_3_addr[29:2]) == 28'h0 & (|(io_pmp_3_addr[1:0] & ~(io_addr[3:2]))) | (io_addr[31:4] ^ io_pmp_4_addr[29:2]) == 28'h0 & (|(io_pmp_4_addr[1:0])));
  wire res_hit_4 = io_pmp_3_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_3_addr[29:2]) & ~(io_pmp_3_mask[31:4])) == 28'h0 : io_pmp_3_cfg_a[0] & io_addr[31:4] >= io_pmp_2_addr[29:2] & (io_addr[31:4] < io_pmp_3_addr[29:2] | (io_addr[31:4] ^ io_pmp_3_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_3_addr[1:0], 2'h0});
  wire res_ignore_4 = io_prv[1] & ~io_pmp_3_cfg_l;
  wire res_aligned_4 = io_pmp_3_cfg_a[1] ? (&(io_pmp_3_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_2_addr[29:2]) == 28'h0 & (|(io_pmp_2_addr[1:0] & ~(io_addr[3:2]))) | (io_addr[31:4] ^ io_pmp_3_addr[29:2]) == 28'h0 & (|(io_pmp_3_addr[1:0])));
  wire res_hit_5 = io_pmp_2_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_2_addr[29:2]) & ~(io_pmp_2_mask[31:4])) == 28'h0 : io_pmp_2_cfg_a[0] & io_addr[31:4] >= io_pmp_1_addr[29:2] & (io_addr[31:4] < io_pmp_2_addr[29:2] | (io_addr[31:4] ^ io_pmp_2_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_2_addr[1:0], 2'h0});
  wire res_ignore_5 = io_prv[1] & ~io_pmp_2_cfg_l;
  wire res_aligned_5 = io_pmp_2_cfg_a[1] ? (&(io_pmp_2_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_1_addr[29:2]) == 28'h0 & (|(io_pmp_1_addr[1:0] & ~(io_addr[3:2]))) | (io_addr[31:4] ^ io_pmp_2_addr[29:2]) == 28'h0 & (|(io_pmp_2_addr[1:0])));
  wire res_hit_6 = io_pmp_1_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_1_addr[29:2]) & ~(io_pmp_1_mask[31:4])) == 28'h0 : io_pmp_1_cfg_a[0] & io_addr[31:4] >= io_pmp_0_addr[29:2] & (io_addr[31:4] < io_pmp_1_addr[29:2] | (io_addr[31:4] ^ io_pmp_1_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_1_addr[1:0], 2'h0});
  wire res_ignore_6 = io_prv[1] & ~io_pmp_1_cfg_l;
  wire res_aligned_6 = io_pmp_1_cfg_a[1] ? (&(io_pmp_1_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_0_addr[29:2]) == 28'h0 & (|(io_pmp_0_addr[1:0] & ~(io_addr[3:2]))) | (io_addr[31:4] ^ io_pmp_1_addr[29:2]) == 28'h0 & (|(io_pmp_1_addr[1:0])));
  wire res_hit_7 = io_pmp_0_cfg_a[1] ? ((io_addr[31:4] ^ io_pmp_0_addr[29:2]) & ~(io_pmp_0_mask[31:4])) == 28'h0 : io_pmp_0_cfg_a[0] & (io_addr[31:4] < io_pmp_0_addr[29:2] | (io_addr[31:4] ^ io_pmp_0_addr[29:2]) == 28'h0 & io_addr[3:0] < {io_pmp_0_addr[1:0], 2'h0});
  wire res_ignore_7 = io_prv[1] & ~io_pmp_0_cfg_l;
  wire res_aligned_7 = io_pmp_0_cfg_a[1] ? (&(io_pmp_0_mask[3:0])) : ~((io_addr[31:4] ^ io_pmp_0_addr[29:2]) == 28'h0 & (|(io_pmp_0_addr[1:0])));
  assign io_r = res_hit_7 ? res_aligned_7 & (io_pmp_0_cfg_r | res_ignore_7) : res_hit_6 ? res_aligned_6 & (io_pmp_1_cfg_r | res_ignore_6) : res_hit_5 ? res_aligned_5 & (io_pmp_2_cfg_r | res_ignore_5) : res_hit_4 ? res_aligned_4 & (io_pmp_3_cfg_r | res_ignore_4) : res_hit_3 ? res_aligned_3 & (io_pmp_4_cfg_r | res_ignore_3) : res_hit_2 ? res_aligned_2 & (io_pmp_5_cfg_r | res_ignore_2) : res_hit_1 ? res_aligned_1 & (io_pmp_6_cfg_r | res_ignore_1) : res_hit ? res_aligned & (io_pmp_7_cfg_r | res_ignore) : io_prv[1];
  assign io_w = res_hit_7 ? res_aligned_7 & (io_pmp_0_cfg_w | res_ignore_7) : res_hit_6 ? res_aligned_6 & (io_pmp_1_cfg_w | res_ignore_6) : res_hit_5 ? res_aligned_5 & (io_pmp_2_cfg_w | res_ignore_5) : res_hit_4 ? res_aligned_4 & (io_pmp_3_cfg_w | res_ignore_4) : res_hit_3 ? res_aligned_3 & (io_pmp_4_cfg_w | res_ignore_3) : res_hit_2 ? res_aligned_2 & (io_pmp_5_cfg_w | res_ignore_2) : res_hit_1 ? res_aligned_1 & (io_pmp_6_cfg_w | res_ignore_1) : res_hit ? res_aligned & (io_pmp_7_cfg_w | res_ignore) : io_prv[1];
  assign io_x = res_hit_7 ? res_aligned_7 & (io_pmp_0_cfg_x | res_ignore_7) : res_hit_6 ? res_aligned_6 & (io_pmp_1_cfg_x | res_ignore_6) : res_hit_5 ? res_aligned_5 & (io_pmp_2_cfg_x | res_ignore_5) : res_hit_4 ? res_aligned_4 & (io_pmp_3_cfg_x | res_ignore_4) : res_hit_3 ? res_aligned_3 & (io_pmp_4_cfg_x | res_ignore_3) : res_hit_2 ? res_aligned_2 & (io_pmp_5_cfg_x | res_ignore_2) : res_hit_1 ? res_aligned_1 & (io_pmp_6_cfg_x | res_ignore_1) : res_hit ? res_aligned & (io_pmp_7_cfg_x | res_ignore) : io_prv[1];
endmodule

