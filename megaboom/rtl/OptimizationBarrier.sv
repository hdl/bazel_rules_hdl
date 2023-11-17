// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module OptimizationBarrier(
  input  [19:0] io_x_ppn,
  input         io_x_u,
                io_x_ae_ptw,
                io_x_ae_final,
                io_x_pf,
                io_x_gf,
                io_x_sx,
                io_x_px,
  output [19:0] io_y_ppn,
  output        io_y_u,
                io_y_ae_ptw,
                io_y_ae_final,
                io_y_pf,
                io_y_gf,
                io_y_sx,
                io_y_px
);

  assign io_y_ppn = io_x_ppn;
  assign io_y_u = io_x_u;
  assign io_y_ae_ptw = io_x_ae_ptw;
  assign io_y_ae_final = io_x_ae_final;
  assign io_y_pf = io_x_pf;
  assign io_y_gf = io_x_gf;
  assign io_y_sx = io_x_sx;
  assign io_y_px = io_x_px;
endmodule

