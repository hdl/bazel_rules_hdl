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
module MSHR_assert(
  input       evict_c,
              meta_dirty,
              _io_status_bits_blockC_output,
              _io_status_bits_nestC_T_3,
              w_pprobeacklast,
              w_rprobeacklast,
              w_releaseack,
              meta_valid,
              _io_status_bits_nestC_output,
              _io_schedule_bits_c_bits_param_T,
              meta_hit,
  input [1:0] meta_state,
  input       _GEN,
  input [1:0] final_meta_writeback_state,
  input       after_c,
              final_meta_writeback_dirty,
              no_wait,
              io_schedule_ready,
              _io_schedule_valid_output,
              request_valid,
              new_meta_hit,
              reset,
              clock,
              _final_meta_writeback_state_T_1,
              bad_grant,
              _io_schedule_bits_dir_bits_data_T,
              w_rprobeackfirst,
              _io_schedule_bits_dir_valid_T_2,
              _new_meta_T,
              io_allocate_valid,
              _GEN_0,
              _GEN_1,
              new_request_prio_2
);

  reg  [3:0] casez_tmp;
  reg  [3:0] casez_tmp_0;
  reg  [3:0] casez_tmp_1;
  reg  [3:0] casez_tmp_2;
  wire       _GEN_2 = evict_c & evict_c - 1'h1;
  wire       _GEN_3 = ~(meta_valid & w_releaseack & w_rprobeacklast & w_pprobeacklast & _io_status_bits_nestC_T_3) | ~(_io_status_bits_blockC_output | (~w_releaseack | ~w_rprobeacklast | ~w_pprobeacklast) & _io_status_bits_nestC_T_3);
  wire       _GEN_4 = ~_io_status_bits_nestC_output | meta_valid;
  wire       _GEN_5 = _io_status_bits_blockC_output | _io_schedule_bits_c_bits_param_T;
  wire [3:0] _GEN_6 = {2'h1, ~evict_c, ~meta_dirty};
  wire [3:0] _GEN_7 = {3'h1, ~meta_dirty};
  always @(*) begin
    casez (meta_state)
      2'b00:
        casez_tmp = {~_GEN, 3'h0};
      2'b01:
        casez_tmp = {3'h0, ~evict_c};
      2'b10:
        casez_tmp = _GEN_7;
      default:
        casez_tmp = _GEN_6;
    endcase
  end // always @(*)
  wire [3:0] evict = meta_hit ? 4'h8 : casez_tmp;
  always @(*) begin
    casez (meta_state)
      2'b00:
        casez_tmp_0 = {~_GEN, 3'h0};
      2'b01:
        casez_tmp_0 = {3'h0, ~evict_c};
      2'b10:
        casez_tmp_0 = _GEN_7;
      default:
        casez_tmp_0 = _GEN_6;
    endcase
  end // always @(*)
  wire [3:0] before_0 = meta_hit ? casez_tmp_0 : 4'h8;
  wire       _prior_T_3 = final_meta_writeback_state == 2'h0;
  wire [3:0] _GEN_8 = {2'h1, ~after_c, ~final_meta_writeback_dirty};
  wire [3:0] _GEN_9 = {3'h1, ~final_meta_writeback_dirty};
  always @(*) begin
    casez (final_meta_writeback_state)
      2'b00:
        casez_tmp_1 = {_prior_T_3, 3'h0};
      2'b01:
        casez_tmp_1 = {3'h0, ~after_c};
      2'b10:
        casez_tmp_1 = _GEN_9;
      default:
        casez_tmp_1 = _GEN_8;
    endcase
  end // always @(*)
  wire       _GEN_10 = evict == 4'h1;
  wire       _GEN_11 = before_0 == 4'h1;
  wire       _GEN_12 = before_0 == 4'h7;
  wire       _GEN_13 = before_0 == 4'h5;
  wire       _GEN_14 = before_0 == 4'h4;
  wire       _GEN_15 = before_0 == 4'h6;
  wire       _GEN_16 = before_0 == 4'h3;
  wire       _GEN_17 = before_0 == 4'h2;
  wire       _GEN_18 = before_0 == 4'h8;
  wire       _GEN_19 = casez_tmp_1 == 4'h1;
  wire       _GEN_20 = _GEN_18 & _GEN_19;
  wire       _GEN_21 = casez_tmp_1 == 4'h0;
  wire       _GEN_22 = _GEN_18 & _GEN_21;
  wire       _GEN_23 = casez_tmp_1 == 4'h7;
  wire       _GEN_24 = casez_tmp_1 == 4'h5;
  wire       _GEN_25 = _GEN_18 & _GEN_24;
  wire       _GEN_26 = casez_tmp_1 == 4'h4;
  wire       _GEN_27 = _GEN_18 & _GEN_26;
  wire       _GEN_28 = casez_tmp_1 == 4'h6;
  wire       _GEN_29 = casez_tmp_1 == 4'h3;
  wire       _GEN_30 = casez_tmp_1 == 4'h2;
  wire       _GEN_31 = _GEN_18 & _GEN_30;
  wire       _GEN_32 = casez_tmp_1 == 4'h8;
  wire       _GEN_33 = _GEN_11 & _GEN_32;
  wire       _GEN_34 = _GEN_11 & _GEN_21;
  wire       _GEN_35 = _GEN_11 & _GEN_23;
  wire       _GEN_36 = _GEN_11 & _GEN_24;
  wire       _GEN_37 = _GEN_11 & _GEN_26;
  wire       _GEN_38 = _GEN_11 & _GEN_28;
  wire       _GEN_39 = _GEN_11 & _GEN_29;
  wire       _GEN_40 = _GEN_11 & _GEN_30;
  wire       _GEN_41 = ~(|before_0) & _GEN_32;
  wire       _GEN_42 = ~(|before_0) & _GEN_19;
  wire       _GEN_43 = ~(|before_0) & _GEN_23;
  wire       _GEN_44 = ~(|before_0) & _GEN_24;
  wire       _GEN_45 = ~(|before_0) & _GEN_28;
  wire       _GEN_46 = ~(|before_0) & _GEN_26;
  wire       _GEN_47 = ~(|before_0) & _GEN_29;
  wire       _GEN_48 = ~(|before_0) & _GEN_30;
  wire       _GEN_49 = _GEN_12 & _GEN_32;
  wire       _GEN_50 = _GEN_12 & _GEN_19;
  wire       _GEN_51 = _GEN_12 & _GEN_21;
  wire       _GEN_52 = _GEN_12 & _GEN_24;
  wire       _GEN_53 = _GEN_12 & _GEN_26;
  wire       _GEN_54 = _GEN_12 & _GEN_30;
  wire       _GEN_55 = _GEN_13 & _GEN_32;
  wire       _GEN_56 = _GEN_13 & _GEN_19;
  wire       _GEN_57 = _GEN_13 & _GEN_21;
  wire       _GEN_58 = _GEN_13 & _GEN_26;
  wire       _GEN_59 = _GEN_13 & _GEN_30;
  wire       _GEN_60 = _GEN_15 & _GEN_32;
  wire       _GEN_61 = _GEN_15 & _GEN_19;
  wire       _GEN_62 = _GEN_15 & _GEN_21;
  wire       _GEN_63 = _GEN_15 & _GEN_23;
  wire       _GEN_64 = _GEN_15 & _GEN_24;
  wire       _GEN_65 = _GEN_15 & _GEN_26;
  wire       _GEN_66 = _GEN_15 & _GEN_29;
  wire       _GEN_67 = _GEN_14 & _GEN_32;
  wire       _GEN_68 = _GEN_14 & _GEN_19;
  wire       _GEN_69 = _GEN_14 & _GEN_21;
  wire       _GEN_70 = _GEN_14 & _GEN_23;
  wire       _GEN_71 = _GEN_14 & _GEN_24;
  wire       _GEN_72 = _GEN_14 & _GEN_29;
  wire       _GEN_73 = _GEN_16 & _GEN_32;
  wire       _GEN_74 = _GEN_16 & _GEN_19;
  wire       _GEN_75 = _GEN_16 & _GEN_21;
  wire       _GEN_76 = _GEN_17 & _GEN_32;
  wire       _GEN_77 = _GEN_17 & _GEN_19;
  wire       _GEN_78 = _GEN_17 & _GEN_21;
  wire       _GEN_79 = _GEN_17 & _GEN_23;
  wire       _GEN_80 = _GEN_17 & _GEN_24;
  wire       _GEN_81 = _GEN_17 & _GEN_29;
  always @(*) begin
    casez (final_meta_writeback_state)
      2'b00:
        casez_tmp_2 = {_prior_T_3, 3'h0};
      2'b01:
        casez_tmp_2 = {3'h0, ~after_c};
      2'b10:
        casez_tmp_2 = _GEN_9;
      default:
        casez_tmp_2 = _GEN_8;
    endcase
  end // always @(*)
  wire       _GEN_82 = casez_tmp_2 == 4'h1;
  wire       _GEN_83 = ~request_valid | no_wait & io_schedule_ready & _io_schedule_valid_output;
  wire       _GEN_84 = meta_valid & ~_GEN & ~reset;
  wire       _GEN_85 = meta_valid & _io_schedule_bits_c_bits_param_T & ~reset;
  wire       _GEN_86 = meta_valid & _final_meta_writeback_state_T_1 & ~reset;
  wire       _GEN_87 = bad_grant & meta_hit & ~reset;
  wire       _GEN_88 = _io_schedule_bits_dir_bits_data_T & w_rprobeackfirst & io_schedule_ready & ~reset;
  wire       _GEN_89 = _io_schedule_bits_dir_valid_T_2 & no_wait & io_schedule_ready & ~reset;
  wire       _GEN_90 = _new_meta_T & ~reset;
  wire       _GEN_91 = io_allocate_valid & ~reset;
  wire       _GEN_92 = _GEN_1 & new_request_prio_2 & ~reset;
  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if ((`PRINTF_COND_) & _GEN_84 & evict_c)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:105 assert (!meta.clients.orR)\n");
      if ((`PRINTF_COND_) & _GEN_84 & meta_dirty)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:106 assert (!meta.dirty)\n");
      if ((`PRINTF_COND_) & _GEN_85 & meta_dirty)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:109 assert (!meta.dirty)\n");
      if ((`PRINTF_COND_) & _GEN_86 & ~evict_c)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:112 assert (meta.clients.orR)\n");
      if ((`PRINTF_COND_) & _GEN_86 & _GEN_2)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:113 assert ((meta.clients & (meta.clients - 1.U)) === 0.U) // at most one\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_3)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:179 assert (!io.status.bits.nestB || !io.status.bits.blockB)\n");
      if ((`PRINTF_COND_) & ~reset & ~_GEN_4)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:180 assert (!io.status.bits.nestC || !io.status.bits.blockC)\n");
      if ((`PRINTF_COND_) & _GEN_87 & ~_GEN_5)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:254 assert (!meta_valid || meta.state === BRANCH)\n");
      if ((`PRINTF_COND_) & _GEN_88 & _GEN_10)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to evicted should be impossible (false,true,true,false,true)\n    at MSHR.scala:346 assert(!(evict === from.code), cf\"State transition from ${from} to evicted should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_88 & _GEN_11)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to flushed should be impossible (false,true,true,false,true)\n    at MSHR.scala:351 assert(!(before === from.code), cf\"State transition from ${from} to flushed should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_88 & ~(|evict))
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to evicted should be impossible (false,true,true,false,true)\n    at MSHR.scala:346 assert(!(evict === from.code), cf\"State transition from ${from} to evicted should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_88 & ~(|before_0))
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to flushed should be impossible (false,true,true,false,true)\n    at MSHR.scala:351 assert(!(before === from.code), cf\"State transition from ${from} to flushed should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_20)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_INVALID to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_22)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_INVALID to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_25)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_INVALID to S_TIP_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_27)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_INVALID to S_TIP_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_31)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_INVALID to S_TRUNK_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_33)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_34)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_35)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_TIP should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_36)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_TIP_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_37)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_TIP_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_38)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_TIP_D should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_39)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_TRUNK_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_40)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH to S_TRUNK_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_41)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_42)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_43)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_TIP should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_44)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_TIP_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_45)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_TIP_D should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_46)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_TIP_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_47)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_TRUNK_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_48)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_BRANCH_C to S_TRUNK_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_49)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_50)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_51)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_52)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP to S_TIP_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_53)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP to S_TIP_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_54)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP to S_TRUNK_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_55)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_C to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_56)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_C to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_57)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_C to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_58)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_C to S_TIP_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_59)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_C to S_TRUNK_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_60)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_D to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_61)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_D to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_62)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_D to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_63)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_D to S_TIP should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_64)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_D to S_TIP_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_65)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_D to S_TIP_CD should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_66)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_D to S_TRUNK_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_67)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_CD to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_68)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_CD to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_69)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_CD to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_70)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_CD to S_TIP should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_71)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_CD to S_TIP_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_72)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TIP_CD to S_TRUNK_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_73)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_C to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_74)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_C to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_75)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_C to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_76)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_CD to S_INVALID should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_77)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_CD to S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_78)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_CD to S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_79)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_CD to S_TIP should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_80)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_CD to S_TIP_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_89 & _GEN_81)
        $fwrite(32'h80000002, "Assertion failed: State transition from S_TRUNK_CD to S_TRUNK_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:359 assert(!(before === from.code && after === to.code), cf\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_90 & _GEN_82)
        $fwrite(32'h80000002, "Assertion failed: State bypass from S_BRANCH should be impossible (false,true,true,false,true)\n    at MSHR.scala:516 assert(!(prior === from.code), cf\"State bypass from ${from} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_90 & ~(|casez_tmp_2))
        $fwrite(32'h80000002, "Assertion failed: State bypass from S_BRANCH_C should be impossible (false,true,true,false,true)\n    at MSHR.scala:516 assert(!(prior === from.code), cf\"State bypass from ${from} should be impossible ${cfg}\")\n");
      if ((`PRINTF_COND_) & _GEN_91 & ~_GEN_83)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:533 assert (!request_valid || (no_wait && io.schedule.fire))\n");
      if ((`PRINTF_COND_) & _GEN_92 & _GEN_0)
        $fwrite(32'h80000002, "Assertion failed\n    at MSHR.scala:585 assert (new_meta.hit)\n");
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (_GEN_84) begin
      assert__assert: assert(~evict_c);
      assert__assert_1: assert(~meta_dirty);
    end
    if (_GEN_85)
      assert__assert_2: assert(~meta_dirty);
    if (_GEN_86) begin
      assert__assert_3: assert(evict_c);
      assert__assert_4: assert(~_GEN_2);
    end
    if (~reset) begin
      assert__assert_5: assert(_GEN_3);
      assert__assert_6: assert(_GEN_4);
    end
    if (_GEN_87)
      assert__assert_7: assert(_GEN_5);
    if (_GEN_88) begin
      assert__assert_8: assert(~_GEN_10);
      assert__assert_9: assert(~_GEN_11);
      assert__assert_10: assert(|evict);
      assert__assert_11: assert(|before_0);
    end
    if (_GEN_89) begin
      assert__assert_12: assert(~_GEN_20);
      assert__assert_13: assert(~_GEN_22);
      assert__assert_14: assert(~_GEN_25);
      assert__assert_15: assert(~_GEN_27);
      assert__assert_16: assert(~_GEN_31);
      assert__assert_17: assert(~_GEN_33);
      assert__assert_18: assert(~_GEN_34);
      assert__assert_19: assert(~_GEN_35);
      assert__assert_20: assert(~_GEN_36);
      assert__assert_21: assert(~_GEN_37);
      assert__assert_22: assert(~_GEN_38);
      assert__assert_23: assert(~_GEN_39);
      assert__assert_24: assert(~_GEN_40);
      assert__assert_25: assert(~_GEN_41);
      assert__assert_26: assert(~_GEN_42);
      assert__assert_27: assert(~_GEN_43);
      assert__assert_28: assert(~_GEN_44);
      assert__assert_29: assert(~_GEN_45);
      assert__assert_30: assert(~_GEN_46);
      assert__assert_31: assert(~_GEN_47);
      assert__assert_32: assert(~_GEN_48);
      assert__assert_33: assert(~_GEN_49);
      assert__assert_34: assert(~_GEN_50);
      assert__assert_35: assert(~_GEN_51);
      assert__assert_36: assert(~_GEN_52);
      assert__assert_37: assert(~_GEN_53);
      assert__assert_38: assert(~_GEN_54);
      assert__assert_39: assert(~_GEN_55);
      assert__assert_40: assert(~_GEN_56);
      assert__assert_41: assert(~_GEN_57);
      assert__assert_42: assert(~_GEN_58);
      assert__assert_43: assert(~_GEN_59);
      assert__assert_44: assert(~_GEN_60);
      assert__assert_45: assert(~_GEN_61);
      assert__assert_46: assert(~_GEN_62);
      assert__assert_47: assert(~_GEN_63);
      assert__assert_48: assert(~_GEN_64);
      assert__assert_49: assert(~_GEN_65);
      assert__assert_50: assert(~_GEN_66);
      assert__assert_51: assert(~_GEN_67);
      assert__assert_52: assert(~_GEN_68);
      assert__assert_53: assert(~_GEN_69);
      assert__assert_54: assert(~_GEN_70);
      assert__assert_55: assert(~_GEN_71);
      assert__assert_56: assert(~_GEN_72);
      assert__assert_57: assert(~_GEN_73);
      assert__assert_58: assert(~_GEN_74);
      assert__assert_59: assert(~_GEN_75);
      assert__assert_60: assert(~_GEN_76);
      assert__assert_61: assert(~_GEN_77);
      assert__assert_62: assert(~_GEN_78);
      assert__assert_63: assert(~_GEN_79);
      assert__assert_64: assert(~_GEN_80);
      assert__assert_65: assert(~_GEN_81);
    end
    if (_GEN_90) begin
      assert__assert_66: assert(~_GEN_82);
      assert__assert_67: assert(|casez_tmp_2);
    end
    if (_GEN_91)
      assert__assert_68: assert(_GEN_83);
    if (_GEN_92)
      assert__assert_69: assert(new_meta_hit);
  end // always @(posedge)
endmodule

