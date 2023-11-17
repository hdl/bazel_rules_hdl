// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module OptimizationBarrier_14(
  input  [19:0] io_x_ppn,
  input         io_x_u,
                io_x_ae,
                io_x_sw,
                io_x_sx,
                io_x_sr,
                io_x_pw,
                io_x_pr,
                io_x_pal,
                io_x_paa,
                io_x_eff,
                io_x_c,
  output [19:0] io_y_ppn,
  output        io_y_u,
                io_y_ae,
                io_y_sw,
                io_y_sx,
                io_y_sr,
                io_y_pw,
                io_y_pr,
                io_y_pal,
                io_y_paa,
                io_y_eff,
                io_y_c
);

  assign io_y_ppn = io_x_ppn;
  assign io_y_u = io_x_u;
  assign io_y_ae = io_x_ae;
  assign io_y_sw = io_x_sw;
  assign io_y_sx = io_x_sx;
  assign io_y_sr = io_x_sr;
  assign io_y_pw = io_x_pw;
  assign io_y_pr = io_x_pr;
  assign io_y_pal = io_x_pal;
  assign io_y_paa = io_x_paa;
  assign io_y_eff = io_x_eff;
  assign io_y_c = io_x_c;
endmodule

