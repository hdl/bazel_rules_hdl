// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module OptimizationBarrier_93(
  input  [43:0] io_x_ppn,
  input         io_x_d,
                io_x_a,
                io_x_g,
                io_x_u,
                io_x_x,
                io_x_w,
                io_x_r,
                io_x_v,
  output [43:0] io_y_ppn,
  output        io_y_d,
                io_y_a,
                io_y_g,
                io_y_u,
                io_y_x,
                io_y_w,
                io_y_r,
                io_y_v
);

  assign io_y_ppn = io_x_ppn;
  assign io_y_d = io_x_d;
  assign io_y_a = io_x_a;
  assign io_y_g = io_x_g;
  assign io_y_u = io_x_u;
  assign io_y_x = io_x_x;
  assign io_y_w = io_x_w;
  assign io_y_r = io_x_r;
  assign io_y_v = io_x_v;
endmodule

