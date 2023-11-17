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
module RenameFreeList_assert(
  input [127:0] dealloc_mask,
                free_list,
                allocs_3,
  input         r_valid_3,
  input [127:0] allocs_2,
  input         r_valid_2,
  input [127:0] allocs_1,
  input         r_valid_1,
  input [127:0] allocs_0,
  input         r_valid,
                io_debug_pipeline_empty,
                reset,
                clock
);

  wire [127:0] _io_debug_freelist_T_19 = free_list | allocs_0 & {128{r_valid}} | allocs_1 & {128{r_valid_1}} | allocs_2 & {128{r_valid_2}} | allocs_3 & {128{r_valid_3}};
  wire [127:0] _GEN = _io_debug_freelist_T_19 & dealloc_mask;
  wire [7:0]   _GEN_0 =
    {1'h0,
     {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[0]} + {1'h0, _io_debug_freelist_T_19[1]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[2]} + {1'h0, _io_debug_freelist_T_19[3]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[4]} + {1'h0, _io_debug_freelist_T_19[5]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[6]} + {1'h0, _io_debug_freelist_T_19[7]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[8]} + {1'h0, _io_debug_freelist_T_19[9]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[10]} + {1'h0, _io_debug_freelist_T_19[11]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[12]} + {1'h0, _io_debug_freelist_T_19[13]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[14]} + {1'h0, _io_debug_freelist_T_19[15]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[16]} + {1'h0, _io_debug_freelist_T_19[17]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[18]} + {1'h0, _io_debug_freelist_T_19[19]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[20]} + {1'h0, _io_debug_freelist_T_19[21]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[22]} + {1'h0, _io_debug_freelist_T_19[23]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[24]} + {1'h0, _io_debug_freelist_T_19[25]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[26]} + {1'h0, _io_debug_freelist_T_19[27]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[28]} + {1'h0, _io_debug_freelist_T_19[29]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[30]} + {1'h0, _io_debug_freelist_T_19[31]}}}}}}
       + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[32]} + {1'h0, _io_debug_freelist_T_19[33]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[34]} + {1'h0, _io_debug_freelist_T_19[35]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[36]} + {1'h0, _io_debug_freelist_T_19[37]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[38]} + {1'h0, _io_debug_freelist_T_19[39]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[40]} + {1'h0, _io_debug_freelist_T_19[41]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[42]} + {1'h0, _io_debug_freelist_T_19[43]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[44]} + {1'h0, _io_debug_freelist_T_19[45]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[46]} + {1'h0, _io_debug_freelist_T_19[47]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[48]} + {1'h0, _io_debug_freelist_T_19[49]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[50]} + {1'h0, _io_debug_freelist_T_19[51]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[52]} + {1'h0, _io_debug_freelist_T_19[53]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[54]} + {1'h0, _io_debug_freelist_T_19[55]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[56]} + {1'h0, _io_debug_freelist_T_19[57]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[58]} + {1'h0, _io_debug_freelist_T_19[59]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[60]} + {1'h0, _io_debug_freelist_T_19[61]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[62]} + {1'h0, _io_debug_freelist_T_19[63]}}}}}}}
    + {1'h0,
       {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[64]} + {1'h0, _io_debug_freelist_T_19[65]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[66]} + {1'h0, _io_debug_freelist_T_19[67]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[68]} + {1'h0, _io_debug_freelist_T_19[69]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[70]} + {1'h0, _io_debug_freelist_T_19[71]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[72]} + {1'h0, _io_debug_freelist_T_19[73]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[74]} + {1'h0, _io_debug_freelist_T_19[75]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[76]} + {1'h0, _io_debug_freelist_T_19[77]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[78]} + {1'h0, _io_debug_freelist_T_19[79]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[80]} + {1'h0, _io_debug_freelist_T_19[81]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[82]} + {1'h0, _io_debug_freelist_T_19[83]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[84]} + {1'h0, _io_debug_freelist_T_19[85]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[86]} + {1'h0, _io_debug_freelist_T_19[87]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[88]} + {1'h0, _io_debug_freelist_T_19[89]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[90]} + {1'h0, _io_debug_freelist_T_19[91]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[92]} + {1'h0, _io_debug_freelist_T_19[93]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[94]} + {1'h0, _io_debug_freelist_T_19[95]}}}}}}
         + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[96]} + {1'h0, _io_debug_freelist_T_19[97]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[98]} + {1'h0, _io_debug_freelist_T_19[99]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[100]} + {1'h0, _io_debug_freelist_T_19[101]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[102]} + {1'h0, _io_debug_freelist_T_19[103]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[104]} + {1'h0, _io_debug_freelist_T_19[105]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[106]} + {1'h0, _io_debug_freelist_T_19[107]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[108]} + {1'h0, _io_debug_freelist_T_19[109]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[110]} + {1'h0, _io_debug_freelist_T_19[111]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[112]} + {1'h0, _io_debug_freelist_T_19[113]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[114]} + {1'h0, _io_debug_freelist_T_19[115]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[116]} + {1'h0, _io_debug_freelist_T_19[117]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[118]} + {1'h0, _io_debug_freelist_T_19[119]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[120]} + {1'h0, _io_debug_freelist_T_19[121]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[122]} + {1'h0, _io_debug_freelist_T_19[123]}}} + {1'h0, {1'h0, {1'h0, _io_debug_freelist_T_19[124]} + {1'h0, _io_debug_freelist_T_19[125]}} + {1'h0, {1'h0, _io_debug_freelist_T_19[126]} + {1'h0, _io_debug_freelist_T_19[127]}}}}}}};
  wire         _GEN_1 = ~io_debug_pipeline_empty | _GEN_0 > 8'h5F;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & ~reset & (|_GEN))
        $fwrite(32'h80000002, "Assertion failed: [freelist] Returning a free physical register.\n    at rename-freelist.scala:94 assert (!(io.debug.freelist & dealloc_mask).orR, \"[freelist] Returning a free physical register.\")\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_1)
        $fwrite(32'h80000002, "Assertion failed: [freelist] Leaking physical registers.\n    at rename-freelist.scala:95 assert (!io.debug.pipeline_empty || PopCount(io.debug.freelist) >= (numPregs - numLregs - 1).U,\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (~reset) begin
      assert__assert: assert(~(|_GEN));
      assert__assert_1: assert(_GEN_1);
    end
  end // always @(posedge)
endmodule

