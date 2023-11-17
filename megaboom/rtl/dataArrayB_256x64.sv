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
module dataArrayB_256x64(
  input  [7:0]  RW0_addr,
  input         RW0_en,
                RW0_clk,
                RW0_wmode,
  input  [63:0] RW0_wdata,
  output [63:0] RW0_rdata
);

  reg [63:0] Memory[0:255];
  reg [7:0]  _RW0_raddr_d0;
  reg        _RW0_ren_d0;
  reg        _RW0_rmode_d0;
  always @(posedge RW0_clk) begin
    _RW0_raddr_d0 <= RW0_addr;
    _RW0_ren_d0 <= RW0_en;
    _RW0_rmode_d0 <= RW0_wmode;
    if (RW0_en & RW0_wmode)
      Memory[RW0_addr] <= RW0_wdata;
  end // always @(posedge)
  assign RW0_rdata = _RW0_ren_d0 & ~_RW0_rmode_d0 ? Memory[_RW0_raddr_d0] : 64'bx;
endmodule

