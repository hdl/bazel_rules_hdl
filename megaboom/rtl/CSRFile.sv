// Standard header to adapt well known macros to our needs.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module CSRFile(
  input         clock,
                reset,
                io_ungated_clock,
                io_interrupts_debug,
                io_interrupts_mtip,
                io_interrupts_msip,
                io_interrupts_meip,
                io_interrupts_seip,
                io_hartid,
  input  [11:0] io_rw_addr,
  input  [2:0]  io_rw_cmd,
  input  [63:0] io_rw_wdata,
  input  [31:0] io_decode_0_inst,
                io_decode_1_inst,
                io_decode_2_inst,
                io_decode_3_inst,
  input         io_exception,
  input  [2:0]  io_retire,
  input  [63:0] io_cause,
  input  [39:0] io_pc,
                io_tval,
  input         io_fcsr_flags_valid,
  input  [4:0]  io_fcsr_flags_bits,
  input         io_set_fs_dirty,
  output [63:0] io_rw_rdata,
  output        io_decode_0_fp_illegal,
                io_decode_0_read_illegal,
                io_decode_0_write_illegal,
                io_decode_0_write_flush,
                io_decode_0_system_illegal,
                io_decode_1_fp_illegal,
                io_decode_1_read_illegal,
                io_decode_1_write_illegal,
                io_decode_1_write_flush,
                io_decode_1_system_illegal,
                io_decode_2_fp_illegal,
                io_decode_2_read_illegal,
                io_decode_2_write_illegal,
                io_decode_2_write_flush,
                io_decode_2_system_illegal,
                io_decode_3_fp_illegal,
                io_decode_3_read_illegal,
                io_decode_3_write_illegal,
                io_decode_3_write_flush,
                io_decode_3_system_illegal,
                io_csr_stall,
                io_singleStep,
                io_status_debug,
  output [1:0]  io_status_dprv,
                io_status_prv,
  output        io_status_mxr,
                io_status_sum,
  output [3:0]  io_ptbr_mode,
  output [43:0] io_ptbr_ppn,
  output [39:0] io_evec,
  output [2:0]  io_fcsr_rm,
  output        io_interrupt,
  output [63:0] io_interrupt_cause,
  output        io_pmp_0_cfg_l,
  output [1:0]  io_pmp_0_cfg_a,
  output        io_pmp_0_cfg_x,
                io_pmp_0_cfg_w,
                io_pmp_0_cfg_r,
  output [29:0] io_pmp_0_addr,
  output [31:0] io_pmp_0_mask,
  output        io_pmp_1_cfg_l,
  output [1:0]  io_pmp_1_cfg_a,
  output        io_pmp_1_cfg_x,
                io_pmp_1_cfg_w,
                io_pmp_1_cfg_r,
  output [29:0] io_pmp_1_addr,
  output [31:0] io_pmp_1_mask,
  output        io_pmp_2_cfg_l,
  output [1:0]  io_pmp_2_cfg_a,
  output        io_pmp_2_cfg_x,
                io_pmp_2_cfg_w,
                io_pmp_2_cfg_r,
  output [29:0] io_pmp_2_addr,
  output [31:0] io_pmp_2_mask,
  output        io_pmp_3_cfg_l,
  output [1:0]  io_pmp_3_cfg_a,
  output        io_pmp_3_cfg_x,
                io_pmp_3_cfg_w,
                io_pmp_3_cfg_r,
  output [29:0] io_pmp_3_addr,
  output [31:0] io_pmp_3_mask,
  output        io_pmp_4_cfg_l,
  output [1:0]  io_pmp_4_cfg_a,
  output        io_pmp_4_cfg_x,
                io_pmp_4_cfg_w,
                io_pmp_4_cfg_r,
  output [29:0] io_pmp_4_addr,
  output [31:0] io_pmp_4_mask,
  output        io_pmp_5_cfg_l,
  output [1:0]  io_pmp_5_cfg_a,
  output        io_pmp_5_cfg_x,
                io_pmp_5_cfg_w,
                io_pmp_5_cfg_r,
  output [29:0] io_pmp_5_addr,
  output [31:0] io_pmp_5_mask,
  output        io_pmp_6_cfg_l,
  output [1:0]  io_pmp_6_cfg_a,
  output        io_pmp_6_cfg_x,
                io_pmp_6_cfg_w,
                io_pmp_6_cfg_r,
  output [29:0] io_pmp_6_addr,
  output [31:0] io_pmp_6_mask,
  output        io_pmp_7_cfg_l,
  output [1:0]  io_pmp_7_cfg_a,
  output        io_pmp_7_cfg_x,
                io_pmp_7_cfg_w,
                io_pmp_7_cfg_r,
  output [29:0] io_pmp_7_addr,
  output [31:0] io_pmp_7_mask,
  output [63:0] io_customCSRs_0_value
);

  wire [63:0] _io_rw_rdata_output;
  reg         io_status_cease_r;
  wire        _io_status_sd_T_4;
  wire        _io_singleStep_output;
  reg  [1:0]  reg_mstatus_prv;
  reg         reg_mstatus_v;
  reg         reg_mstatus_mpv;
  reg         reg_mstatus_gva;
  reg         reg_mstatus_tsr;
  reg         reg_mstatus_tw;
  reg         reg_mstatus_tvm;
  reg         reg_mstatus_mxr;
  reg         reg_mstatus_sum;
  reg         reg_mstatus_mprv;
  reg  [1:0]  reg_mstatus_fs;
  reg  [1:0]  reg_mstatus_mpp;
  reg  [1:0]  reg_mstatus_vs;
  reg         reg_mstatus_spp;
  reg         reg_mstatus_mpie;
  reg         reg_mstatus_spie;
  reg         reg_mstatus_mie;
  reg         reg_mstatus_sie;
  wire        system_insn = io_rw_cmd == 3'h4;
  wire [11:0] _GEN = ~io_rw_addr;
  wire        insn_ret = system_insn & (|{&{_GEN[2], _GEN[3], _GEN[4], _GEN[5], _GEN[6], _GEN[7], io_rw_addr[8], _GEN[10], _GEN[11]}, &{io_rw_addr[10], _GEN[11]}});
  reg         reg_vsstatus_spp;
  wire        _GEN_0 = io_rw_addr[10] & io_rw_addr[7];
  reg  [1:0]  reg_dcsr_prv;
  wire        insn_call = system_insn & (&{_GEN[0], _GEN[1], _GEN[2], _GEN[3], _GEN[4], _GEN[5], _GEN[6], _GEN[7], _GEN[8], _GEN[9], _GEN[10], _GEN[11]});
  wire        insn_break = system_insn & (&{io_rw_addr[0], _GEN[1], _GEN[2], _GEN[3], _GEN[4], _GEN[5], _GEN[6], _GEN[7], _GEN[8], _GEN[9], _GEN[10], _GEN[11]});
  wire        exception = insn_call | insn_break | io_exception;
  reg         reg_singleStepped;
  wire [63:0] _GEN_1 = {60'h0, {2'h0, reg_mstatus_prv[0] & reg_mstatus_v ? 2'h2 : reg_mstatus_prv} - 4'h8};
  wire [63:0] cause = insn_call ? _GEN_1 : insn_break ? 64'h3 : io_cause;
  wire        _causeIsDebugTrigger_T_2 = cause[7:0] == 8'hE;
  wire        causeIsDebugInt = cause[63] & _causeIsDebugTrigger_T_2;
  wire        causeIsDebugTrigger = ~(cause[63]) & _causeIsDebugTrigger_T_2;
  reg         reg_dcsr_ebreakm;
  reg         reg_dcsr_ebreaks;
  reg         reg_dcsr_ebreaku;
  wire [3:0]  _causeIsDebugBreak_T_4 = {reg_dcsr_ebreakm, 1'h0, reg_dcsr_ebreaks, reg_dcsr_ebreaku} >> reg_mstatus_prv;
  reg         reg_debug;
  wire        trapToDebug = reg_singleStepped | causeIsDebugInt | causeIsDebugTrigger | ~(cause[63]) & insn_break & _causeIsDebugBreak_T_4[0] | reg_debug;
  reg  [63:0] reg_mideleg;
  wire [8:0]  _GEN_2 = reg_mideleg[9:1] & 9'h111;
  wire [15:0] _GEN_3 = {6'h0, _GEN_2, 1'h0};
  wire [63:0] _GEN_4 = {54'h0, _GEN_2, 1'h0};
  wire [63:0] _GEN_5 = {56'h0, cause[7:0]};
  wire [63:0] _delegate_T_3 = _GEN_4 >> _GEN_5;
  reg  [63:0] reg_medeleg;
  wire [63:0] _GEN_6 = {48'h0, reg_medeleg[15:0] & 16'hB15D};
  wire [63:0] _delegate_T_5 = _GEN_6 >> _GEN_5;
  wire        delegate = ~(reg_mstatus_prv[1]) & (cause[63] ? _delegate_T_3[0] : _delegate_T_5[0]);
  wire [63:0] _delegateVS_T_2 = 64'h0 >> _GEN_5;
  wire [63:0] _delegateVS_T_4 = 64'h0 >> _GEN_5;
  wire        delegateVS = reg_mstatus_v & delegate & (cause[63] ? _delegateVS_T_2[0] : _delegateVS_T_4[0]);
  reg  [2:0]  reg_dcsr_cause;
  reg         reg_dcsr_v;
  reg         reg_dcsr_step;
  reg  [39:0] reg_dpc;
  reg  [63:0] reg_dscratch0;
  reg         pmp_cfg_l;
  reg  [1:0]  pmp_cfg_a;
  reg         pmp_cfg_x;
  reg         pmp_cfg_w;
  reg         pmp_cfg_r;
  reg  [29:0] pmp_addr;
  reg         pmp_1_cfg_l;
  reg  [1:0]  pmp_1_cfg_a;
  reg         pmp_1_cfg_x;
  reg         pmp_1_cfg_w;
  reg         pmp_1_cfg_r;
  reg  [29:0] pmp_1_addr;
  reg         pmp_2_cfg_l;
  reg  [1:0]  pmp_2_cfg_a;
  reg         pmp_2_cfg_x;
  reg         pmp_2_cfg_w;
  reg         pmp_2_cfg_r;
  reg  [29:0] pmp_2_addr;
  reg         pmp_3_cfg_l;
  reg  [1:0]  pmp_3_cfg_a;
  reg         pmp_3_cfg_x;
  reg         pmp_3_cfg_w;
  reg         pmp_3_cfg_r;
  reg  [29:0] pmp_3_addr;
  reg         pmp_4_cfg_l;
  reg  [1:0]  pmp_4_cfg_a;
  reg         pmp_4_cfg_x;
  reg         pmp_4_cfg_w;
  reg         pmp_4_cfg_r;
  reg  [29:0] pmp_4_addr;
  reg         pmp_5_cfg_l;
  reg  [1:0]  pmp_5_cfg_a;
  reg         pmp_5_cfg_x;
  reg         pmp_5_cfg_w;
  reg         pmp_5_cfg_r;
  reg  [29:0] pmp_5_addr;
  reg         pmp_6_cfg_l;
  reg  [1:0]  pmp_6_cfg_a;
  reg         pmp_6_cfg_x;
  reg         pmp_6_cfg_w;
  reg         pmp_6_cfg_r;
  reg  [29:0] pmp_6_addr;
  reg         pmp_7_cfg_l;
  reg  [1:0]  pmp_7_cfg_a;
  reg         pmp_7_cfg_x;
  reg         pmp_7_cfg_w;
  reg         pmp_7_cfg_r;
  reg  [29:0] pmp_7_addr;
  reg  [63:0] reg_mie;
  reg         reg_mip_seip;
  reg         mip_stip;
  reg         mip_ssip;
  reg  [39:0] reg_mepc;
  reg  [63:0] reg_mcause;
  reg  [39:0] reg_mtval;
  reg  [63:0] reg_mscratch;
  reg  [31:0] reg_mtvec;
  reg         reg_menvcfg_fiom;
  reg         reg_senvcfg_fiom;
  reg  [31:0] reg_mcounteren;
  wire [31:0] _GEN_7 = {29'h0, reg_mcounteren[2:0]};
  reg  [31:0] reg_scounteren;
  wire [31:0] _GEN_8 = {29'h0, reg_scounteren[2:0]};
  reg  [1:0]  reg_vsstatus_fs;
  reg  [39:0] reg_vsepc;
  reg  [39:0] reg_sepc;
  reg  [63:0] reg_scause;
  reg  [39:0] reg_stval;
  reg  [63:0] reg_sscratch;
  reg  [38:0] reg_stvec;
  reg  [3:0]  reg_satp_mode;
  reg  [43:0] reg_satp_ppn;
  reg         reg_wfi;
  reg  [4:0]  reg_fflags;
  reg  [2:0]  reg_frm;
  reg  [2:0]  reg_mcountinhibit;
  reg  [5:0]  small_0;
  reg  [57:0] large_0;
  wire [63:0] value = {large_0, small_0};
  reg  [5:0]  small_1;
  reg  [57:0] large_1;
  wire [63:0] value_1 = {large_1, small_1};
  wire [15:0] read_mip = {4'h0, io_interrupts_meip, 1'h0, reg_mip_seip | io_interrupts_seip, 1'h0, io_interrupts_mtip, 1'h0, mip_stip, 1'h0, io_interrupts_msip, 1'h0, mip_ssip, 1'h0};
  wire [15:0] _GEN_9 = reg_mie[15:0] & read_mip;
  wire [15:0] m_interrupts = ~(reg_mstatus_prv[1]) | reg_mstatus_mie ? ~(~_GEN_9 | _GEN_3) : 16'h0;
  wire [15:0] s_interrupts = reg_mstatus_v | reg_mstatus_prv == 2'h0 | reg_mstatus_prv == 2'h1 & reg_mstatus_sie ? _GEN_9 & _GEN_3 : 16'h0;
  wire [29:0] _GEN_10 = {pmp_addr[28:0], pmp_cfg_a[0]};
  wire [29:0] _GEN_11 = {pmp_1_addr[28:0], pmp_1_cfg_a[0]};
  wire [29:0] _GEN_12 = {pmp_2_addr[28:0], pmp_2_cfg_a[0]};
  wire [29:0] _GEN_13 = {pmp_3_addr[28:0], pmp_3_cfg_a[0]};
  wire [29:0] _GEN_14 = {pmp_4_addr[28:0], pmp_4_cfg_a[0]};
  wire [29:0] _GEN_15 = {pmp_5_addr[28:0], pmp_5_cfg_a[0]};
  wire [29:0] _GEN_16 = {pmp_6_addr[28:0], pmp_6_cfg_a[0]};
  wire [29:0] _GEN_17 = {pmp_7_addr[28:0], pmp_7_cfg_a[0]};
  wire [31:0] _read_mtvec_T_5 = reg_mtvec & {24'hFFFFFF, ~(reg_mtvec[0] ? 8'hFE : 8'h2)};
  wire [38:0] _read_stvec_T_5 = reg_stvec & {31'h7FFFFFFF, ~(reg_stvec[0] ? 8'hFE : 8'h2)};
  wire [39:0] _io_evec_T_20 = ~reg_mepc;
  wire [1:0]  _GEN_18 = _io_evec_T_20[1:0] | 2'h1;
  wire [39:0] _GEN_19 = ~{_io_evec_T_20[39:2], _GEN_18};
  wire [39:0] _io_evec_T_10 = ~reg_dpc;
  wire [1:0]  _GEN_20 = _io_evec_T_10[1:0] | 2'h1;
  wire [39:0] _GEN_21 = ~{_io_evec_T_10[39:2], _GEN_20};
  wire [39:0] _io_evec_T = ~reg_sepc;
  wire [1:0]  _GEN_22 = _io_evec_T[1:0] | 2'h1;
  wire [39:0] _GEN_23 = ~{_io_evec_T[39:2], _GEN_22};
  reg  [63:0] reg_custom_0;
  wire [11:0] decoded_decoded_invInputs = ~io_rw_addr;
  wire [10:0] _decoded_decoded_T = {decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], decoded_decoded_invInputs[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_2 = {decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], decoded_decoded_invInputs[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_4 = {io_rw_addr[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], decoded_decoded_invInputs[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [9:0]  _decoded_decoded_T_6 = {decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_8 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_10 = {io_rw_addr[0], decoded_decoded_invInputs[1], io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [10:0] _decoded_decoded_T_12 = {io_rw_addr[1], io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [8:0]  _decoded_decoded_T_14 = {io_rw_addr[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_16 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_18 = {io_rw_addr[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_20 = {decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_22 = {io_rw_addr[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [9:0]  _decoded_decoded_T_24 = {io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [4:0]  _decoded_decoded_T_26 = {io_rw_addr[7], io_rw_addr[8], decoded_decoded_invInputs[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_28 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_32 = {decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_34 = {io_rw_addr[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_36 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_38 = {io_rw_addr[0], decoded_decoded_invInputs[1], io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [10:0] _decoded_decoded_T_40 = {io_rw_addr[1], io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [8:0]  _decoded_decoded_T_42 = {io_rw_addr[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [10:0] _decoded_decoded_T_44 = {decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], io_rw_addr[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_104 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_106 = {io_rw_addr[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_108 = {decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_110 = {io_rw_addr[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [9:0]  _decoded_decoded_T_112 = {io_rw_addr[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], io_rw_addr[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [10:0] _decoded_decoded_T_114 = {decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_118 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_120 = {io_rw_addr[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_122 = {decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_124 = {io_rw_addr[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_126 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], io_rw_addr[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_128 = {io_rw_addr[0], decoded_decoded_invInputs[1], io_rw_addr[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_130 = {decoded_decoded_invInputs[0], io_rw_addr[1], io_rw_addr[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_132 = {io_rw_addr[0], io_rw_addr[1], io_rw_addr[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_158 = {decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], io_rw_addr[10], decoded_decoded_invInputs[11]};
  wire [11:0] _decoded_decoded_T_160 = {io_rw_addr[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], io_rw_addr[10], decoded_decoded_invInputs[11]};
  wire [10:0] _decoded_decoded_T_162 = {io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], io_rw_addr[5], decoded_decoded_invInputs[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], io_rw_addr[10], decoded_decoded_invInputs[11]};
  wire [5:0]  _decoded_decoded_T_164 = {io_rw_addr[6], io_rw_addr[7], io_rw_addr[8], io_rw_addr[9], io_rw_addr[10], decoded_decoded_invInputs[11]};
  wire [10:0] _decoded_decoded_T_166 = {decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], io_rw_addr[11]};
  wire [11:0] _decoded_decoded_T_168 = {decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], io_rw_addr[11]};
  wire [63:0] _wdata_T_2 = (io_rw_cmd[1] ? _io_rw_rdata_output : 64'h0) | io_rw_wdata;
  wire [63:0] _wdata_T_6 = ~((&(io_rw_cmd[1:0])) ? io_rw_wdata : 64'h0);
  wire [63:0] wdata = _wdata_T_2 & _wdata_T_6;
  wire [29:0] decoded_invInputs_1 = ~(io_decode_0_inst[31:2]);
  wire [1:0]  _decoded_orMatrixOutputs_T_10 = {&{io_decode_0_inst[0], decoded_invInputs_1[20], decoded_invInputs_1[21], decoded_invInputs_1[22], decoded_invInputs_1[23], decoded_invInputs_1[24], decoded_invInputs_1[25], io_decode_0_inst[28], decoded_invInputs_1[28], decoded_invInputs_1[29]}, &{io_decode_0_inst[30], decoded_invInputs_1[29]}};
  wire        _allow_sfence_vma_T_14 = ~reg_mstatus_v & reg_mstatus_tvm;
  wire        allow_sfence_vma = reg_mstatus_prv[1] | ~_allow_sfence_vma_T_14;
  wire        _allow_sret_T_14 = ~reg_mstatus_v & reg_mstatus_tsr;
  wire [31:0] _GEN_24 = {27'h0, io_decode_0_inst[24:20]};
  wire [31:0] _io_decode_0_virtual_access_illegal_T_3 = _GEN_7 >> _GEN_24;
  wire [31:0] _io_decode_0_virtual_access_illegal_T_11 = _GEN_8 >> _GEN_24;
  wire        _io_decode_3_fp_illegal_T = reg_mstatus_fs == 2'h0;
  wire        _io_decode_3_fp_illegal_T_1 = reg_vsstatus_fs == 2'h0;
  wire        _io_decode_0_fp_illegal_output = _io_decode_3_fp_illegal_T | reg_mstatus_v & _io_decode_3_fp_illegal_T_1;
  wire [3:0]  io_decode_0_fp_csr_invInputs = ~(io_decode_0_inst[31:28]);
  wire        _io_decode_0_virtual_access_illegal_T_24 = io_decode_0_inst[31:20] == 12'h180;
  wire        csr_exists =
    io_decode_0_inst[31:20] == 12'h7A0 | io_decode_0_inst[31:20] == 12'h7A1 | io_decode_0_inst[31:20] == 12'h7A2 | io_decode_0_inst[31:20] == 12'h7A3 | io_decode_0_inst[31:20] == 12'h301 | io_decode_0_inst[31:20] == 12'h300 | io_decode_0_inst[31:20] == 12'h305 | io_decode_0_inst[31:20] == 12'h344 | io_decode_0_inst[31:20] == 12'h304 | io_decode_0_inst[31:20] == 12'h340 | io_decode_0_inst[31:20] == 12'h341 | io_decode_0_inst[31:20] == 12'h343 | io_decode_0_inst[31:20] == 12'h342 | io_decode_0_inst[31:20] == 12'hF14 | io_decode_0_inst[31:20] == 12'h7B0 | io_decode_0_inst[31:20] == 12'h7B1 | io_decode_0_inst[31:20] == 12'h7B2 | io_decode_0_inst[31:20] == 12'h1 | io_decode_0_inst[31:20] == 12'h2 | io_decode_0_inst[31:20] == 12'h3 | io_decode_0_inst[31:20] == 12'h320 | io_decode_0_inst[31:20] == 12'hB00 | io_decode_0_inst[31:20] == 12'hB02 | io_decode_0_inst[31:20] == 12'h323 | io_decode_0_inst[31:20] == 12'hB03 | io_decode_0_inst[31:20] == 12'hC03 | io_decode_0_inst[31:20] == 12'h324 | io_decode_0_inst[31:20] == 12'hB04 | io_decode_0_inst[31:20] == 12'hC04 | io_decode_0_inst[31:20] == 12'h325 | io_decode_0_inst[31:20] == 12'hB05 | io_decode_0_inst[31:20] == 12'hC05 | io_decode_0_inst[31:20] == 12'h326 | io_decode_0_inst[31:20] == 12'hB06 | io_decode_0_inst[31:20] == 12'hC06 | io_decode_0_inst[31:20] == 12'h327 | io_decode_0_inst[31:20] == 12'hB07 | io_decode_0_inst[31:20] == 12'hC07 | io_decode_0_inst[31:20] == 12'h328 | io_decode_0_inst[31:20] == 12'hB08 | io_decode_0_inst[31:20] == 12'hC08 | io_decode_0_inst[31:20] == 12'h329 | io_decode_0_inst[31:20] == 12'hB09 | io_decode_0_inst[31:20] == 12'hC09 | io_decode_0_inst[31:20] == 12'h32A | io_decode_0_inst[31:20] == 12'hB0A | io_decode_0_inst[31:20] == 12'hC0A | io_decode_0_inst[31:20] == 12'h32B | io_decode_0_inst[31:20] == 12'hB0B | io_decode_0_inst[31:20] == 12'hC0B | io_decode_0_inst[31:20] == 12'h32C | io_decode_0_inst[31:20] == 12'hB0C | io_decode_0_inst[31:20] == 12'hC0C | io_decode_0_inst[31:20] == 12'h32D | io_decode_0_inst[31:20] == 12'hB0D
    | io_decode_0_inst[31:20] == 12'hC0D | io_decode_0_inst[31:20] == 12'h32E | io_decode_0_inst[31:20] == 12'hB0E | io_decode_0_inst[31:20] == 12'hC0E | io_decode_0_inst[31:20] == 12'h32F | io_decode_0_inst[31:20] == 12'hB0F | io_decode_0_inst[31:20] == 12'hC0F | io_decode_0_inst[31:20] == 12'h330 | io_decode_0_inst[31:20] == 12'hB10 | io_decode_0_inst[31:20] == 12'hC10 | io_decode_0_inst[31:20] == 12'h331 | io_decode_0_inst[31:20] == 12'hB11 | io_decode_0_inst[31:20] == 12'hC11 | io_decode_0_inst[31:20] == 12'h332 | io_decode_0_inst[31:20] == 12'hB12 | io_decode_0_inst[31:20] == 12'hC12 | io_decode_0_inst[31:20] == 12'h333 | io_decode_0_inst[31:20] == 12'hB13 | io_decode_0_inst[31:20] == 12'hC13 | io_decode_0_inst[31:20] == 12'h334 | io_decode_0_inst[31:20] == 12'hB14 | io_decode_0_inst[31:20] == 12'hC14 | io_decode_0_inst[31:20] == 12'h335 | io_decode_0_inst[31:20] == 12'hB15 | io_decode_0_inst[31:20] == 12'hC15 | io_decode_0_inst[31:20] == 12'h336 | io_decode_0_inst[31:20] == 12'hB16 | io_decode_0_inst[31:20] == 12'hC16 | io_decode_0_inst[31:20] == 12'h337 | io_decode_0_inst[31:20] == 12'hB17 | io_decode_0_inst[31:20] == 12'hC17 | io_decode_0_inst[31:20] == 12'h338 | io_decode_0_inst[31:20] == 12'hB18 | io_decode_0_inst[31:20] == 12'hC18 | io_decode_0_inst[31:20] == 12'h339 | io_decode_0_inst[31:20] == 12'hB19 | io_decode_0_inst[31:20] == 12'hC19 | io_decode_0_inst[31:20] == 12'h33A | io_decode_0_inst[31:20] == 12'hB1A | io_decode_0_inst[31:20] == 12'hC1A | io_decode_0_inst[31:20] == 12'h33B | io_decode_0_inst[31:20] == 12'hB1B | io_decode_0_inst[31:20] == 12'hC1B | io_decode_0_inst[31:20] == 12'h33C | io_decode_0_inst[31:20] == 12'hB1C | io_decode_0_inst[31:20] == 12'hC1C | io_decode_0_inst[31:20] == 12'h33D | io_decode_0_inst[31:20] == 12'hB1D | io_decode_0_inst[31:20] == 12'hC1D | io_decode_0_inst[31:20] == 12'h33E | io_decode_0_inst[31:20] == 12'hB1E | io_decode_0_inst[31:20] == 12'hC1E | io_decode_0_inst[31:20] == 12'h33F | io_decode_0_inst[31:20] == 12'hB1F | io_decode_0_inst[31:20] == 12'hC1F
    | io_decode_0_inst[31:20] == 12'h306 | io_decode_0_inst[31:20] == 12'hC00 | io_decode_0_inst[31:20] == 12'hC02 | io_decode_0_inst[31:20] == 12'h30A | io_decode_0_inst[31:20] == 12'h100 | io_decode_0_inst[31:20] == 12'h144 | io_decode_0_inst[31:20] == 12'h104 | io_decode_0_inst[31:20] == 12'h140 | io_decode_0_inst[31:20] == 12'h142 | io_decode_0_inst[31:20] == 12'h143 | _io_decode_0_virtual_access_illegal_T_24 | io_decode_0_inst[31:20] == 12'h141 | io_decode_0_inst[31:20] == 12'h105 | io_decode_0_inst[31:20] == 12'h106 | io_decode_0_inst[31:20] == 12'h303 | io_decode_0_inst[31:20] == 12'h302 | io_decode_0_inst[31:20] == 12'h10A | io_decode_0_inst[31:20] == 12'h3A0 | io_decode_0_inst[31:20] == 12'h3A2 | io_decode_0_inst[31:20] == 12'h3B0 | io_decode_0_inst[31:20] == 12'h3B1 | io_decode_0_inst[31:20] == 12'h3B2 | io_decode_0_inst[31:20] == 12'h3B3 | io_decode_0_inst[31:20] == 12'h3B4 | io_decode_0_inst[31:20] == 12'h3B5 | io_decode_0_inst[31:20] == 12'h3B6 | io_decode_0_inst[31:20] == 12'h3B7 | io_decode_0_inst[31:20] == 12'h3B8 | io_decode_0_inst[31:20] == 12'h3B9 | io_decode_0_inst[31:20] == 12'h3BA | io_decode_0_inst[31:20] == 12'h3BB | io_decode_0_inst[31:20] == 12'h3BC | io_decode_0_inst[31:20] == 12'h3BD | io_decode_0_inst[31:20] == 12'h3BE | io_decode_0_inst[31:20] == 12'h3BF | io_decode_0_inst[31:20] == 12'h7C1 | io_decode_0_inst[31:20] == 12'hF12 | io_decode_0_inst[31:20] == 12'hF13 | io_decode_0_inst[31:20] == 12'hF11 | io_decode_0_inst[31:20] == 12'hF15;
  wire        _io_decode_0_system_illegal_T = reg_mstatus_prv < io_decode_0_inst[29:28];
  wire [5:0]  io_decode_0_read_illegal_invInputs = ~(io_decode_0_inst[31:26]);
  wire [11:0] io_decode_0_write_flush_addr_m = {io_decode_0_inst[31:30], io_decode_0_inst[29:20] | 10'h300};
  wire [29:0] decoded_invInputs_2 = ~(io_decode_1_inst[31:2]);
  wire [1:0]  _decoded_orMatrixOutputs_T_17 = {&{io_decode_1_inst[0], decoded_invInputs_2[20], decoded_invInputs_2[21], decoded_invInputs_2[22], decoded_invInputs_2[23], decoded_invInputs_2[24], decoded_invInputs_2[25], io_decode_1_inst[28], decoded_invInputs_2[28], decoded_invInputs_2[29]}, &{io_decode_1_inst[30], decoded_invInputs_2[29]}};
  wire        allow_sfence_vma_1 = reg_mstatus_prv[1] | ~_allow_sfence_vma_T_14;
  wire [31:0] _GEN_25 = {27'h0, io_decode_1_inst[24:20]};
  wire [31:0] _io_decode_1_virtual_access_illegal_T_3 = _GEN_7 >> _GEN_25;
  wire [31:0] _io_decode_1_virtual_access_illegal_T_11 = _GEN_8 >> _GEN_25;
  wire        _io_decode_1_fp_illegal_output = _io_decode_3_fp_illegal_T | reg_mstatus_v & _io_decode_3_fp_illegal_T_1;
  wire [3:0]  io_decode_1_fp_csr_invInputs = ~(io_decode_1_inst[31:28]);
  wire        _io_decode_1_virtual_access_illegal_T_24 = io_decode_1_inst[31:20] == 12'h180;
  wire        csr_exists_1 =
    io_decode_1_inst[31:20] == 12'h7A0 | io_decode_1_inst[31:20] == 12'h7A1 | io_decode_1_inst[31:20] == 12'h7A2 | io_decode_1_inst[31:20] == 12'h7A3 | io_decode_1_inst[31:20] == 12'h301 | io_decode_1_inst[31:20] == 12'h300 | io_decode_1_inst[31:20] == 12'h305 | io_decode_1_inst[31:20] == 12'h344 | io_decode_1_inst[31:20] == 12'h304 | io_decode_1_inst[31:20] == 12'h340 | io_decode_1_inst[31:20] == 12'h341 | io_decode_1_inst[31:20] == 12'h343 | io_decode_1_inst[31:20] == 12'h342 | io_decode_1_inst[31:20] == 12'hF14 | io_decode_1_inst[31:20] == 12'h7B0 | io_decode_1_inst[31:20] == 12'h7B1 | io_decode_1_inst[31:20] == 12'h7B2 | io_decode_1_inst[31:20] == 12'h1 | io_decode_1_inst[31:20] == 12'h2 | io_decode_1_inst[31:20] == 12'h3 | io_decode_1_inst[31:20] == 12'h320 | io_decode_1_inst[31:20] == 12'hB00 | io_decode_1_inst[31:20] == 12'hB02 | io_decode_1_inst[31:20] == 12'h323 | io_decode_1_inst[31:20] == 12'hB03 | io_decode_1_inst[31:20] == 12'hC03 | io_decode_1_inst[31:20] == 12'h324 | io_decode_1_inst[31:20] == 12'hB04 | io_decode_1_inst[31:20] == 12'hC04 | io_decode_1_inst[31:20] == 12'h325 | io_decode_1_inst[31:20] == 12'hB05 | io_decode_1_inst[31:20] == 12'hC05 | io_decode_1_inst[31:20] == 12'h326 | io_decode_1_inst[31:20] == 12'hB06 | io_decode_1_inst[31:20] == 12'hC06 | io_decode_1_inst[31:20] == 12'h327 | io_decode_1_inst[31:20] == 12'hB07 | io_decode_1_inst[31:20] == 12'hC07 | io_decode_1_inst[31:20] == 12'h328 | io_decode_1_inst[31:20] == 12'hB08 | io_decode_1_inst[31:20] == 12'hC08 | io_decode_1_inst[31:20] == 12'h329 | io_decode_1_inst[31:20] == 12'hB09 | io_decode_1_inst[31:20] == 12'hC09 | io_decode_1_inst[31:20] == 12'h32A | io_decode_1_inst[31:20] == 12'hB0A | io_decode_1_inst[31:20] == 12'hC0A | io_decode_1_inst[31:20] == 12'h32B | io_decode_1_inst[31:20] == 12'hB0B | io_decode_1_inst[31:20] == 12'hC0B | io_decode_1_inst[31:20] == 12'h32C | io_decode_1_inst[31:20] == 12'hB0C | io_decode_1_inst[31:20] == 12'hC0C | io_decode_1_inst[31:20] == 12'h32D | io_decode_1_inst[31:20] == 12'hB0D
    | io_decode_1_inst[31:20] == 12'hC0D | io_decode_1_inst[31:20] == 12'h32E | io_decode_1_inst[31:20] == 12'hB0E | io_decode_1_inst[31:20] == 12'hC0E | io_decode_1_inst[31:20] == 12'h32F | io_decode_1_inst[31:20] == 12'hB0F | io_decode_1_inst[31:20] == 12'hC0F | io_decode_1_inst[31:20] == 12'h330 | io_decode_1_inst[31:20] == 12'hB10 | io_decode_1_inst[31:20] == 12'hC10 | io_decode_1_inst[31:20] == 12'h331 | io_decode_1_inst[31:20] == 12'hB11 | io_decode_1_inst[31:20] == 12'hC11 | io_decode_1_inst[31:20] == 12'h332 | io_decode_1_inst[31:20] == 12'hB12 | io_decode_1_inst[31:20] == 12'hC12 | io_decode_1_inst[31:20] == 12'h333 | io_decode_1_inst[31:20] == 12'hB13 | io_decode_1_inst[31:20] == 12'hC13 | io_decode_1_inst[31:20] == 12'h334 | io_decode_1_inst[31:20] == 12'hB14 | io_decode_1_inst[31:20] == 12'hC14 | io_decode_1_inst[31:20] == 12'h335 | io_decode_1_inst[31:20] == 12'hB15 | io_decode_1_inst[31:20] == 12'hC15 | io_decode_1_inst[31:20] == 12'h336 | io_decode_1_inst[31:20] == 12'hB16 | io_decode_1_inst[31:20] == 12'hC16 | io_decode_1_inst[31:20] == 12'h337 | io_decode_1_inst[31:20] == 12'hB17 | io_decode_1_inst[31:20] == 12'hC17 | io_decode_1_inst[31:20] == 12'h338 | io_decode_1_inst[31:20] == 12'hB18 | io_decode_1_inst[31:20] == 12'hC18 | io_decode_1_inst[31:20] == 12'h339 | io_decode_1_inst[31:20] == 12'hB19 | io_decode_1_inst[31:20] == 12'hC19 | io_decode_1_inst[31:20] == 12'h33A | io_decode_1_inst[31:20] == 12'hB1A | io_decode_1_inst[31:20] == 12'hC1A | io_decode_1_inst[31:20] == 12'h33B | io_decode_1_inst[31:20] == 12'hB1B | io_decode_1_inst[31:20] == 12'hC1B | io_decode_1_inst[31:20] == 12'h33C | io_decode_1_inst[31:20] == 12'hB1C | io_decode_1_inst[31:20] == 12'hC1C | io_decode_1_inst[31:20] == 12'h33D | io_decode_1_inst[31:20] == 12'hB1D | io_decode_1_inst[31:20] == 12'hC1D | io_decode_1_inst[31:20] == 12'h33E | io_decode_1_inst[31:20] == 12'hB1E | io_decode_1_inst[31:20] == 12'hC1E | io_decode_1_inst[31:20] == 12'h33F | io_decode_1_inst[31:20] == 12'hB1F | io_decode_1_inst[31:20] == 12'hC1F
    | io_decode_1_inst[31:20] == 12'h306 | io_decode_1_inst[31:20] == 12'hC00 | io_decode_1_inst[31:20] == 12'hC02 | io_decode_1_inst[31:20] == 12'h30A | io_decode_1_inst[31:20] == 12'h100 | io_decode_1_inst[31:20] == 12'h144 | io_decode_1_inst[31:20] == 12'h104 | io_decode_1_inst[31:20] == 12'h140 | io_decode_1_inst[31:20] == 12'h142 | io_decode_1_inst[31:20] == 12'h143 | _io_decode_1_virtual_access_illegal_T_24 | io_decode_1_inst[31:20] == 12'h141 | io_decode_1_inst[31:20] == 12'h105 | io_decode_1_inst[31:20] == 12'h106 | io_decode_1_inst[31:20] == 12'h303 | io_decode_1_inst[31:20] == 12'h302 | io_decode_1_inst[31:20] == 12'h10A | io_decode_1_inst[31:20] == 12'h3A0 | io_decode_1_inst[31:20] == 12'h3A2 | io_decode_1_inst[31:20] == 12'h3B0 | io_decode_1_inst[31:20] == 12'h3B1 | io_decode_1_inst[31:20] == 12'h3B2 | io_decode_1_inst[31:20] == 12'h3B3 | io_decode_1_inst[31:20] == 12'h3B4 | io_decode_1_inst[31:20] == 12'h3B5 | io_decode_1_inst[31:20] == 12'h3B6 | io_decode_1_inst[31:20] == 12'h3B7 | io_decode_1_inst[31:20] == 12'h3B8 | io_decode_1_inst[31:20] == 12'h3B9 | io_decode_1_inst[31:20] == 12'h3BA | io_decode_1_inst[31:20] == 12'h3BB | io_decode_1_inst[31:20] == 12'h3BC | io_decode_1_inst[31:20] == 12'h3BD | io_decode_1_inst[31:20] == 12'h3BE | io_decode_1_inst[31:20] == 12'h3BF | io_decode_1_inst[31:20] == 12'h7C1 | io_decode_1_inst[31:20] == 12'hF12 | io_decode_1_inst[31:20] == 12'hF13 | io_decode_1_inst[31:20] == 12'hF11 | io_decode_1_inst[31:20] == 12'hF15;
  wire        _io_decode_1_system_illegal_T = reg_mstatus_prv < io_decode_1_inst[29:28];
  wire [5:0]  io_decode_1_read_illegal_invInputs = ~(io_decode_1_inst[31:26]);
  wire [11:0] io_decode_1_write_flush_addr_m = {io_decode_1_inst[31:30], io_decode_1_inst[29:20] | 10'h300};
  wire [29:0] decoded_invInputs_3 = ~(io_decode_2_inst[31:2]);
  wire [1:0]  _decoded_orMatrixOutputs_T_24 = {&{io_decode_2_inst[0], decoded_invInputs_3[20], decoded_invInputs_3[21], decoded_invInputs_3[22], decoded_invInputs_3[23], decoded_invInputs_3[24], decoded_invInputs_3[25], io_decode_2_inst[28], decoded_invInputs_3[28], decoded_invInputs_3[29]}, &{io_decode_2_inst[30], decoded_invInputs_3[29]}};
  wire        allow_sfence_vma_2 = reg_mstatus_prv[1] | ~_allow_sfence_vma_T_14;
  wire [31:0] _GEN_26 = {27'h0, io_decode_2_inst[24:20]};
  wire [31:0] _io_decode_2_virtual_access_illegal_T_3 = _GEN_7 >> _GEN_26;
  wire [31:0] _io_decode_2_virtual_access_illegal_T_11 = _GEN_8 >> _GEN_26;
  wire        _io_decode_2_fp_illegal_output = _io_decode_3_fp_illegal_T | reg_mstatus_v & _io_decode_3_fp_illegal_T_1;
  wire [3:0]  io_decode_2_fp_csr_invInputs = ~(io_decode_2_inst[31:28]);
  wire        _io_decode_2_virtual_access_illegal_T_24 = io_decode_2_inst[31:20] == 12'h180;
  wire        csr_exists_2 =
    io_decode_2_inst[31:20] == 12'h7A0 | io_decode_2_inst[31:20] == 12'h7A1 | io_decode_2_inst[31:20] == 12'h7A2 | io_decode_2_inst[31:20] == 12'h7A3 | io_decode_2_inst[31:20] == 12'h301 | io_decode_2_inst[31:20] == 12'h300 | io_decode_2_inst[31:20] == 12'h305 | io_decode_2_inst[31:20] == 12'h344 | io_decode_2_inst[31:20] == 12'h304 | io_decode_2_inst[31:20] == 12'h340 | io_decode_2_inst[31:20] == 12'h341 | io_decode_2_inst[31:20] == 12'h343 | io_decode_2_inst[31:20] == 12'h342 | io_decode_2_inst[31:20] == 12'hF14 | io_decode_2_inst[31:20] == 12'h7B0 | io_decode_2_inst[31:20] == 12'h7B1 | io_decode_2_inst[31:20] == 12'h7B2 | io_decode_2_inst[31:20] == 12'h1 | io_decode_2_inst[31:20] == 12'h2 | io_decode_2_inst[31:20] == 12'h3 | io_decode_2_inst[31:20] == 12'h320 | io_decode_2_inst[31:20] == 12'hB00 | io_decode_2_inst[31:20] == 12'hB02 | io_decode_2_inst[31:20] == 12'h323 | io_decode_2_inst[31:20] == 12'hB03 | io_decode_2_inst[31:20] == 12'hC03 | io_decode_2_inst[31:20] == 12'h324 | io_decode_2_inst[31:20] == 12'hB04 | io_decode_2_inst[31:20] == 12'hC04 | io_decode_2_inst[31:20] == 12'h325 | io_decode_2_inst[31:20] == 12'hB05 | io_decode_2_inst[31:20] == 12'hC05 | io_decode_2_inst[31:20] == 12'h326 | io_decode_2_inst[31:20] == 12'hB06 | io_decode_2_inst[31:20] == 12'hC06 | io_decode_2_inst[31:20] == 12'h327 | io_decode_2_inst[31:20] == 12'hB07 | io_decode_2_inst[31:20] == 12'hC07 | io_decode_2_inst[31:20] == 12'h328 | io_decode_2_inst[31:20] == 12'hB08 | io_decode_2_inst[31:20] == 12'hC08 | io_decode_2_inst[31:20] == 12'h329 | io_decode_2_inst[31:20] == 12'hB09 | io_decode_2_inst[31:20] == 12'hC09 | io_decode_2_inst[31:20] == 12'h32A | io_decode_2_inst[31:20] == 12'hB0A | io_decode_2_inst[31:20] == 12'hC0A | io_decode_2_inst[31:20] == 12'h32B | io_decode_2_inst[31:20] == 12'hB0B | io_decode_2_inst[31:20] == 12'hC0B | io_decode_2_inst[31:20] == 12'h32C | io_decode_2_inst[31:20] == 12'hB0C | io_decode_2_inst[31:20] == 12'hC0C | io_decode_2_inst[31:20] == 12'h32D | io_decode_2_inst[31:20] == 12'hB0D
    | io_decode_2_inst[31:20] == 12'hC0D | io_decode_2_inst[31:20] == 12'h32E | io_decode_2_inst[31:20] == 12'hB0E | io_decode_2_inst[31:20] == 12'hC0E | io_decode_2_inst[31:20] == 12'h32F | io_decode_2_inst[31:20] == 12'hB0F | io_decode_2_inst[31:20] == 12'hC0F | io_decode_2_inst[31:20] == 12'h330 | io_decode_2_inst[31:20] == 12'hB10 | io_decode_2_inst[31:20] == 12'hC10 | io_decode_2_inst[31:20] == 12'h331 | io_decode_2_inst[31:20] == 12'hB11 | io_decode_2_inst[31:20] == 12'hC11 | io_decode_2_inst[31:20] == 12'h332 | io_decode_2_inst[31:20] == 12'hB12 | io_decode_2_inst[31:20] == 12'hC12 | io_decode_2_inst[31:20] == 12'h333 | io_decode_2_inst[31:20] == 12'hB13 | io_decode_2_inst[31:20] == 12'hC13 | io_decode_2_inst[31:20] == 12'h334 | io_decode_2_inst[31:20] == 12'hB14 | io_decode_2_inst[31:20] == 12'hC14 | io_decode_2_inst[31:20] == 12'h335 | io_decode_2_inst[31:20] == 12'hB15 | io_decode_2_inst[31:20] == 12'hC15 | io_decode_2_inst[31:20] == 12'h336 | io_decode_2_inst[31:20] == 12'hB16 | io_decode_2_inst[31:20] == 12'hC16 | io_decode_2_inst[31:20] == 12'h337 | io_decode_2_inst[31:20] == 12'hB17 | io_decode_2_inst[31:20] == 12'hC17 | io_decode_2_inst[31:20] == 12'h338 | io_decode_2_inst[31:20] == 12'hB18 | io_decode_2_inst[31:20] == 12'hC18 | io_decode_2_inst[31:20] == 12'h339 | io_decode_2_inst[31:20] == 12'hB19 | io_decode_2_inst[31:20] == 12'hC19 | io_decode_2_inst[31:20] == 12'h33A | io_decode_2_inst[31:20] == 12'hB1A | io_decode_2_inst[31:20] == 12'hC1A | io_decode_2_inst[31:20] == 12'h33B | io_decode_2_inst[31:20] == 12'hB1B | io_decode_2_inst[31:20] == 12'hC1B | io_decode_2_inst[31:20] == 12'h33C | io_decode_2_inst[31:20] == 12'hB1C | io_decode_2_inst[31:20] == 12'hC1C | io_decode_2_inst[31:20] == 12'h33D | io_decode_2_inst[31:20] == 12'hB1D | io_decode_2_inst[31:20] == 12'hC1D | io_decode_2_inst[31:20] == 12'h33E | io_decode_2_inst[31:20] == 12'hB1E | io_decode_2_inst[31:20] == 12'hC1E | io_decode_2_inst[31:20] == 12'h33F | io_decode_2_inst[31:20] == 12'hB1F | io_decode_2_inst[31:20] == 12'hC1F
    | io_decode_2_inst[31:20] == 12'h306 | io_decode_2_inst[31:20] == 12'hC00 | io_decode_2_inst[31:20] == 12'hC02 | io_decode_2_inst[31:20] == 12'h30A | io_decode_2_inst[31:20] == 12'h100 | io_decode_2_inst[31:20] == 12'h144 | io_decode_2_inst[31:20] == 12'h104 | io_decode_2_inst[31:20] == 12'h140 | io_decode_2_inst[31:20] == 12'h142 | io_decode_2_inst[31:20] == 12'h143 | _io_decode_2_virtual_access_illegal_T_24 | io_decode_2_inst[31:20] == 12'h141 | io_decode_2_inst[31:20] == 12'h105 | io_decode_2_inst[31:20] == 12'h106 | io_decode_2_inst[31:20] == 12'h303 | io_decode_2_inst[31:20] == 12'h302 | io_decode_2_inst[31:20] == 12'h10A | io_decode_2_inst[31:20] == 12'h3A0 | io_decode_2_inst[31:20] == 12'h3A2 | io_decode_2_inst[31:20] == 12'h3B0 | io_decode_2_inst[31:20] == 12'h3B1 | io_decode_2_inst[31:20] == 12'h3B2 | io_decode_2_inst[31:20] == 12'h3B3 | io_decode_2_inst[31:20] == 12'h3B4 | io_decode_2_inst[31:20] == 12'h3B5 | io_decode_2_inst[31:20] == 12'h3B6 | io_decode_2_inst[31:20] == 12'h3B7 | io_decode_2_inst[31:20] == 12'h3B8 | io_decode_2_inst[31:20] == 12'h3B9 | io_decode_2_inst[31:20] == 12'h3BA | io_decode_2_inst[31:20] == 12'h3BB | io_decode_2_inst[31:20] == 12'h3BC | io_decode_2_inst[31:20] == 12'h3BD | io_decode_2_inst[31:20] == 12'h3BE | io_decode_2_inst[31:20] == 12'h3BF | io_decode_2_inst[31:20] == 12'h7C1 | io_decode_2_inst[31:20] == 12'hF12 | io_decode_2_inst[31:20] == 12'hF13 | io_decode_2_inst[31:20] == 12'hF11 | io_decode_2_inst[31:20] == 12'hF15;
  wire        _io_decode_2_system_illegal_T = reg_mstatus_prv < io_decode_2_inst[29:28];
  wire [5:0]  io_decode_2_read_illegal_invInputs = ~(io_decode_2_inst[31:26]);
  wire [11:0] io_decode_2_write_flush_addr_m = {io_decode_2_inst[31:30], io_decode_2_inst[29:20] | 10'h300};
  wire [29:0] decoded_invInputs_4 = ~(io_decode_3_inst[31:2]);
  wire [1:0]  _decoded_orMatrixOutputs_T_31 = {&{io_decode_3_inst[0], decoded_invInputs_4[20], decoded_invInputs_4[21], decoded_invInputs_4[22], decoded_invInputs_4[23], decoded_invInputs_4[24], decoded_invInputs_4[25], io_decode_3_inst[28], decoded_invInputs_4[28], decoded_invInputs_4[29]}, &{io_decode_3_inst[30], decoded_invInputs_4[29]}};
  wire        allow_sfence_vma_3 = reg_mstatus_prv[1] | ~_allow_sfence_vma_T_14;
  wire [31:0] _GEN_27 = {27'h0, io_decode_3_inst[24:20]};
  wire [31:0] _io_decode_3_virtual_access_illegal_T_3 = _GEN_7 >> _GEN_27;
  wire [31:0] _io_decode_3_virtual_access_illegal_T_11 = _GEN_8 >> _GEN_27;
  wire        _io_decode_3_fp_illegal_output = _io_decode_3_fp_illegal_T | reg_mstatus_v & _io_decode_3_fp_illegal_T_1;
  wire [3:0]  io_decode_3_fp_csr_invInputs = ~(io_decode_3_inst[31:28]);
  wire        _io_decode_3_virtual_access_illegal_T_24 = io_decode_3_inst[31:20] == 12'h180;
  wire        csr_exists_3 =
    io_decode_3_inst[31:20] == 12'h7A0 | io_decode_3_inst[31:20] == 12'h7A1 | io_decode_3_inst[31:20] == 12'h7A2 | io_decode_3_inst[31:20] == 12'h7A3 | io_decode_3_inst[31:20] == 12'h301 | io_decode_3_inst[31:20] == 12'h300 | io_decode_3_inst[31:20] == 12'h305 | io_decode_3_inst[31:20] == 12'h344 | io_decode_3_inst[31:20] == 12'h304 | io_decode_3_inst[31:20] == 12'h340 | io_decode_3_inst[31:20] == 12'h341 | io_decode_3_inst[31:20] == 12'h343 | io_decode_3_inst[31:20] == 12'h342 | io_decode_3_inst[31:20] == 12'hF14 | io_decode_3_inst[31:20] == 12'h7B0 | io_decode_3_inst[31:20] == 12'h7B1 | io_decode_3_inst[31:20] == 12'h7B2 | io_decode_3_inst[31:20] == 12'h1 | io_decode_3_inst[31:20] == 12'h2 | io_decode_3_inst[31:20] == 12'h3 | io_decode_3_inst[31:20] == 12'h320 | io_decode_3_inst[31:20] == 12'hB00 | io_decode_3_inst[31:20] == 12'hB02 | io_decode_3_inst[31:20] == 12'h323 | io_decode_3_inst[31:20] == 12'hB03 | io_decode_3_inst[31:20] == 12'hC03 | io_decode_3_inst[31:20] == 12'h324 | io_decode_3_inst[31:20] == 12'hB04 | io_decode_3_inst[31:20] == 12'hC04 | io_decode_3_inst[31:20] == 12'h325 | io_decode_3_inst[31:20] == 12'hB05 | io_decode_3_inst[31:20] == 12'hC05 | io_decode_3_inst[31:20] == 12'h326 | io_decode_3_inst[31:20] == 12'hB06 | io_decode_3_inst[31:20] == 12'hC06 | io_decode_3_inst[31:20] == 12'h327 | io_decode_3_inst[31:20] == 12'hB07 | io_decode_3_inst[31:20] == 12'hC07 | io_decode_3_inst[31:20] == 12'h328 | io_decode_3_inst[31:20] == 12'hB08 | io_decode_3_inst[31:20] == 12'hC08 | io_decode_3_inst[31:20] == 12'h329 | io_decode_3_inst[31:20] == 12'hB09 | io_decode_3_inst[31:20] == 12'hC09 | io_decode_3_inst[31:20] == 12'h32A | io_decode_3_inst[31:20] == 12'hB0A | io_decode_3_inst[31:20] == 12'hC0A | io_decode_3_inst[31:20] == 12'h32B | io_decode_3_inst[31:20] == 12'hB0B | io_decode_3_inst[31:20] == 12'hC0B | io_decode_3_inst[31:20] == 12'h32C | io_decode_3_inst[31:20] == 12'hB0C | io_decode_3_inst[31:20] == 12'hC0C | io_decode_3_inst[31:20] == 12'h32D | io_decode_3_inst[31:20] == 12'hB0D
    | io_decode_3_inst[31:20] == 12'hC0D | io_decode_3_inst[31:20] == 12'h32E | io_decode_3_inst[31:20] == 12'hB0E | io_decode_3_inst[31:20] == 12'hC0E | io_decode_3_inst[31:20] == 12'h32F | io_decode_3_inst[31:20] == 12'hB0F | io_decode_3_inst[31:20] == 12'hC0F | io_decode_3_inst[31:20] == 12'h330 | io_decode_3_inst[31:20] == 12'hB10 | io_decode_3_inst[31:20] == 12'hC10 | io_decode_3_inst[31:20] == 12'h331 | io_decode_3_inst[31:20] == 12'hB11 | io_decode_3_inst[31:20] == 12'hC11 | io_decode_3_inst[31:20] == 12'h332 | io_decode_3_inst[31:20] == 12'hB12 | io_decode_3_inst[31:20] == 12'hC12 | io_decode_3_inst[31:20] == 12'h333 | io_decode_3_inst[31:20] == 12'hB13 | io_decode_3_inst[31:20] == 12'hC13 | io_decode_3_inst[31:20] == 12'h334 | io_decode_3_inst[31:20] == 12'hB14 | io_decode_3_inst[31:20] == 12'hC14 | io_decode_3_inst[31:20] == 12'h335 | io_decode_3_inst[31:20] == 12'hB15 | io_decode_3_inst[31:20] == 12'hC15 | io_decode_3_inst[31:20] == 12'h336 | io_decode_3_inst[31:20] == 12'hB16 | io_decode_3_inst[31:20] == 12'hC16 | io_decode_3_inst[31:20] == 12'h337 | io_decode_3_inst[31:20] == 12'hB17 | io_decode_3_inst[31:20] == 12'hC17 | io_decode_3_inst[31:20] == 12'h338 | io_decode_3_inst[31:20] == 12'hB18 | io_decode_3_inst[31:20] == 12'hC18 | io_decode_3_inst[31:20] == 12'h339 | io_decode_3_inst[31:20] == 12'hB19 | io_decode_3_inst[31:20] == 12'hC19 | io_decode_3_inst[31:20] == 12'h33A | io_decode_3_inst[31:20] == 12'hB1A | io_decode_3_inst[31:20] == 12'hC1A | io_decode_3_inst[31:20] == 12'h33B | io_decode_3_inst[31:20] == 12'hB1B | io_decode_3_inst[31:20] == 12'hC1B | io_decode_3_inst[31:20] == 12'h33C | io_decode_3_inst[31:20] == 12'hB1C | io_decode_3_inst[31:20] == 12'hC1C | io_decode_3_inst[31:20] == 12'h33D | io_decode_3_inst[31:20] == 12'hB1D | io_decode_3_inst[31:20] == 12'hC1D | io_decode_3_inst[31:20] == 12'h33E | io_decode_3_inst[31:20] == 12'hB1E | io_decode_3_inst[31:20] == 12'hC1E | io_decode_3_inst[31:20] == 12'h33F | io_decode_3_inst[31:20] == 12'hB1F | io_decode_3_inst[31:20] == 12'hC1F
    | io_decode_3_inst[31:20] == 12'h306 | io_decode_3_inst[31:20] == 12'hC00 | io_decode_3_inst[31:20] == 12'hC02 | io_decode_3_inst[31:20] == 12'h30A | io_decode_3_inst[31:20] == 12'h100 | io_decode_3_inst[31:20] == 12'h144 | io_decode_3_inst[31:20] == 12'h104 | io_decode_3_inst[31:20] == 12'h140 | io_decode_3_inst[31:20] == 12'h142 | io_decode_3_inst[31:20] == 12'h143 | _io_decode_3_virtual_access_illegal_T_24 | io_decode_3_inst[31:20] == 12'h141 | io_decode_3_inst[31:20] == 12'h105 | io_decode_3_inst[31:20] == 12'h106 | io_decode_3_inst[31:20] == 12'h303 | io_decode_3_inst[31:20] == 12'h302 | io_decode_3_inst[31:20] == 12'h10A | io_decode_3_inst[31:20] == 12'h3A0 | io_decode_3_inst[31:20] == 12'h3A2 | io_decode_3_inst[31:20] == 12'h3B0 | io_decode_3_inst[31:20] == 12'h3B1 | io_decode_3_inst[31:20] == 12'h3B2 | io_decode_3_inst[31:20] == 12'h3B3 | io_decode_3_inst[31:20] == 12'h3B4 | io_decode_3_inst[31:20] == 12'h3B5 | io_decode_3_inst[31:20] == 12'h3B6 | io_decode_3_inst[31:20] == 12'h3B7 | io_decode_3_inst[31:20] == 12'h3B8 | io_decode_3_inst[31:20] == 12'h3B9 | io_decode_3_inst[31:20] == 12'h3BA | io_decode_3_inst[31:20] == 12'h3BB | io_decode_3_inst[31:20] == 12'h3BC | io_decode_3_inst[31:20] == 12'h3BD | io_decode_3_inst[31:20] == 12'h3BE | io_decode_3_inst[31:20] == 12'h3BF | io_decode_3_inst[31:20] == 12'h7C1 | io_decode_3_inst[31:20] == 12'hF12 | io_decode_3_inst[31:20] == 12'hF13 | io_decode_3_inst[31:20] == 12'hF11 | io_decode_3_inst[31:20] == 12'hF15;
  wire        _io_decode_3_system_illegal_T = reg_mstatus_prv < io_decode_3_inst[29:28];
  wire [5:0]  io_decode_3_read_illegal_invInputs = ~(io_decode_3_inst[31:26]);
  wire [11:0] io_decode_3_write_flush_addr_m = {io_decode_3_inst[31:30], io_decode_3_inst[29:20] | 10'h300};
  wire [39:0] notDebugTVec_base = delegate ? (delegateVS ? 40'h0 : {reg_stvec[38], _read_stvec_T_5}) : {8'h0, _read_mtvec_T_5};
  assign _io_singleStep_output = reg_dcsr_step & ~reg_debug;
  assign _io_status_sd_T_4 = (&reg_mstatus_fs) | (&reg_mstatus_vs);
  wire [39:0] _io_evec_T_5 = ~reg_vsepc;
  wire        _io_csr_stall_output = reg_wfi | io_status_cease_r;
  wire [63:0] _io_rw_rdata_T_155 = ((&{io_rw_addr[0], decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], decoded_decoded_invInputs[10], decoded_decoded_invInputs[11]}) ? 64'h800000000014112D : 64'h0) | ((&_decoded_decoded_T_28) ? {_io_status_sd_T_4, 23'h0, reg_mstatus_mpv, reg_mstatus_gva, 15'h1400, reg_mstatus_tsr, reg_mstatus_tw, reg_mstatus_tvm, reg_mstatus_mxr, reg_mstatus_sum, reg_mstatus_mprv, 2'h0, reg_mstatus_fs, reg_mstatus_mpp, reg_mstatus_vs, reg_mstatus_spp, reg_mstatus_mpie, 1'h0, reg_mstatus_spie, 1'h0, reg_mstatus_mie, 1'h0, reg_mstatus_sie, 1'h0} : 64'h0) | ((&_decoded_decoded_T_38) ? {32'h0, _read_mtvec_T_5} : 64'h0);
  wire [63:0] _io_rw_rdata_T_161 = {_io_rw_rdata_T_155[63:16], _io_rw_rdata_T_155[15:0] | ((&_decoded_decoded_T_112) ? read_mip : 16'h0)} | ((&_decoded_decoded_T_36) ? reg_mie : 64'h0) | ((&_decoded_decoded_T_104) ? reg_mscratch : 64'h0) | ((&_decoded_decoded_T_106) ? {{24{_GEN_19[39]}}, _GEN_19} : 64'h0) | ((&_decoded_decoded_T_110) ? {{24{reg_mtval[39]}}, reg_mtval} : 64'h0) | ((&_decoded_decoded_T_108) ? reg_mcause : 64'h0);
  wire [63:0] _io_rw_rdata_T_165 = {_io_rw_rdata_T_161[63:32], {_io_rw_rdata_T_161[31:1], _io_rw_rdata_T_161[0] | (&{decoded_decoded_invInputs[0], decoded_decoded_invInputs[1], io_rw_addr[2], decoded_decoded_invInputs[3], io_rw_addr[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], io_rw_addr[10], io_rw_addr[11]}) & io_hartid} | ((&_decoded_decoded_T_158) ? {16'h4000, reg_dcsr_ebreakm, 1'h0, reg_dcsr_ebreaks, reg_dcsr_ebreaku, 3'h0, reg_dcsr_cause, reg_dcsr_v, 2'h0, reg_dcsr_step, reg_dcsr_prv} : 32'h0)} | ((&_decoded_decoded_T_160) ? {{24{_GEN_21[39]}}, _GEN_21} : 64'h0) | ((&_decoded_decoded_T_162) ? reg_dscratch0 : 64'h0);
  wire [4:0]  _GEN_28 = _io_rw_rdata_T_165[4:0] | ((&_decoded_decoded_T) ? reg_fflags : 5'h0);
  wire [7:0]  _GEN_29 = {_io_rw_rdata_T_165[7:5], _GEN_28[4:3], _GEN_28[2:0] | ((&_decoded_decoded_T_2) ? reg_frm : 3'h0)} | ((&_decoded_decoded_T_4) ? {reg_frm, reg_fflags} : 8'h0);
  wire [63:0] _io_rw_rdata_T_258 = {_io_rw_rdata_T_165[63:8], _GEN_29[7:3], _GEN_29[2:0] | ((&_decoded_decoded_T_44) ? reg_mcountinhibit : 3'h0)} | ((&_decoded_decoded_T_166) ? value_1 : 64'h0) | ((&_decoded_decoded_T_168) ? value : 64'h0);
  wire [63:0] _io_rw_rdata_T_271 = {_io_rw_rdata_T_258[63:32], _io_rw_rdata_T_258[31:0] | ((&_decoded_decoded_T_40) ? _GEN_7 : 32'h0)} | ((&{decoded_decoded_invInputs[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], decoded_decoded_invInputs[8], decoded_decoded_invInputs[9], io_rw_addr[10], io_rw_addr[11]}) ? value_1 : 64'h0) | ((&{decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], decoded_decoded_invInputs[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], decoded_decoded_invInputs[8], decoded_decoded_invInputs[9], io_rw_addr[10], io_rw_addr[11]}) ? value : 64'h0) | ((&_decoded_decoded_T_42) ? {63'h0, reg_menvcfg_fiom} : 64'h0) | ((&_decoded_decoded_T_6) ? {_io_status_sd_T_4, 43'h2000, reg_mstatus_mxr, reg_mstatus_sum, 3'h0, reg_mstatus_fs, 2'h0, reg_mstatus_vs, reg_mstatus_spp, 2'h0, reg_mstatus_spie, 3'h0, reg_mstatus_sie, 1'h0} : 64'h0) | ((&_decoded_decoded_T_24) ? {48'h0, read_mip & _GEN_3} : 64'h0) | ((&_decoded_decoded_T_8) ? {48'h0, reg_mie[15:0] & _GEN_3} : 64'h0) | ((&_decoded_decoded_T_16) ? reg_sscratch : 64'h0) | ((&_decoded_decoded_T_20) ? reg_scause : 64'h0) | ((&_decoded_decoded_T_22) ? {{24{reg_stval[39]}}, reg_stval} : 64'h0) | ((&_decoded_decoded_T_26) ? {reg_satp_mode, 16'h0, reg_satp_ppn} : 64'h0) | ((&_decoded_decoded_T_18) ? {{24{_GEN_23[39]}}, _GEN_23} : 64'h0) | ((&_decoded_decoded_T_10) ? {{25{reg_stvec[38]}}, _read_stvec_T_5} : 64'h0);
  wire [63:0] _io_rw_rdata_T_277 = {_io_rw_rdata_T_271[63:32], _io_rw_rdata_T_271[31:0] | ((&_decoded_decoded_T_12) ? _GEN_8 : 32'h0)} | ((&_decoded_decoded_T_34) ? _GEN_4 : 64'h0) | ((&_decoded_decoded_T_32) ? _GEN_6 : 64'h0) | ((&_decoded_decoded_T_14) ? {63'h0, reg_senvcfg_fiom} : 64'h0) | ((&_decoded_decoded_T_114) ? {pmp_7_cfg_l, 2'h0, pmp_7_cfg_a, pmp_7_cfg_x, pmp_7_cfg_w, pmp_7_cfg_r, pmp_6_cfg_l, 2'h0, pmp_6_cfg_a, pmp_6_cfg_x, pmp_6_cfg_w, pmp_6_cfg_r, pmp_5_cfg_l, 2'h0, pmp_5_cfg_a, pmp_5_cfg_x, pmp_5_cfg_w, pmp_5_cfg_r, pmp_4_cfg_l, 2'h0, pmp_4_cfg_a, pmp_4_cfg_x, pmp_4_cfg_w, pmp_4_cfg_r, pmp_3_cfg_l, 2'h0, pmp_3_cfg_a, pmp_3_cfg_x, pmp_3_cfg_w, pmp_3_cfg_r, pmp_2_cfg_l, 2'h0, pmp_2_cfg_a, pmp_2_cfg_x, pmp_2_cfg_w, pmp_2_cfg_r, pmp_1_cfg_l, 2'h0, pmp_1_cfg_a, pmp_1_cfg_x, pmp_1_cfg_w, pmp_1_cfg_r, pmp_cfg_l, 2'h0, pmp_cfg_a, pmp_cfg_x, pmp_cfg_w, pmp_cfg_r} : 64'h0);
  wire [29:0] _GEN_30 = _io_rw_rdata_T_277[29:0] | ((&_decoded_decoded_T_118) ? pmp_addr : 30'h0) | ((&_decoded_decoded_T_120) ? pmp_1_addr : 30'h0) | ((&_decoded_decoded_T_122) ? pmp_2_addr : 30'h0) | ((&_decoded_decoded_T_124) ? pmp_3_addr : 30'h0) | ((&_decoded_decoded_T_126) ? pmp_4_addr : 30'h0) | ((&_decoded_decoded_T_128) ? pmp_5_addr : 30'h0) | ((&_decoded_decoded_T_130) ? pmp_6_addr : 30'h0) | ((&_decoded_decoded_T_132) ? pmp_7_addr : 30'h0);
  assign _io_rw_rdata_output = ((&_decoded_decoded_T_164) ? reg_custom_0 : 64'h0) | {_io_rw_rdata_T_277[63:30], _GEN_30[29:2], _GEN_30[1] | (&{decoded_decoded_invInputs[0], io_rw_addr[1], decoded_decoded_invInputs[2], decoded_decoded_invInputs[3], io_rw_addr[4], decoded_decoded_invInputs[5], decoded_decoded_invInputs[6], decoded_decoded_invInputs[7], io_rw_addr[8], io_rw_addr[9], io_rw_addr[10], io_rw_addr[11]}), _GEN_30[0]};
  wire        _csr_wen_T_4 = io_rw_cmd == 3'h6 | (&io_rw_cmd) | io_rw_cmd == 3'h5;
  wire        set_fs_dirty = _csr_wen_T_4 ? (&_decoded_decoded_T_4) | (&_decoded_decoded_T_2) | (&_decoded_decoded_T) | io_fcsr_flags_valid | io_set_fs_dirty : io_fcsr_flags_valid | io_set_fs_dirty;
  wire [1:0]  new_dcsr_prv = _wdata_T_2[1:0] & _wdata_T_6[1:0];
  wire [1:0]  _GEN_31 = {1'h0, reg_mstatus_v ? reg_vsstatus_spp : reg_mstatus_spp};
  wire [1:0]  ret_prv = io_rw_addr[9] ? (_GEN_0 ? reg_dcsr_prv : reg_mstatus_mpp) : _GEN_31;
  wire        _GEN_32 = ~(io_rw_addr[9]) | _GEN_0;
  wire        _GEN_33 = ~insn_ret | _GEN_32;
  wire        newCfg_1_r = _wdata_T_2[8] & _wdata_T_6[8];
  wire        newCfg_2_r = _wdata_T_2[16] & _wdata_T_6[16];
  wire        newCfg_3_r = _wdata_T_2[24] & _wdata_T_6[24];
  wire        newCfg_4_r = _wdata_T_2[32] & _wdata_T_6[32];
  wire        newCfg_5_r = _wdata_T_2[40] & _wdata_T_6[40];
  wire        newCfg_6_r = _wdata_T_2[48] & _wdata_T_6[48];
  wire        newCfg_7_r = _wdata_T_2[56] & _wdata_T_6[56];
  wire [15:0] _GEN_34 = _wdata_T_2[15:0] & _wdata_T_6[15:0];
  wire        _GEN_35 = delegateVS | delegate;
  wire [6:0]  nextSmall = {1'h0, small_0} + {4'h0, io_retire};
  wire [39:0] epc = {io_pc[39:1], 1'h0};
  wire [39:0] tval = insn_break ? epc : io_tval;
  wire        _GEN_36 = exception & trapToDebug & ~reg_debug;
  wire        _GEN_37 = ~exception | trapToDebug | ~delegateVS;
  wire        _GEN_38 = ~exception | trapToDebug | delegateVS | ~delegate;
  wire        _GEN_39 = ~exception | trapToDebug | _GEN_35;
  wire        _GEN_40 = insn_ret & ~(io_rw_addr[9]) & ~reg_mstatus_v;
  wire        _GEN_268 = ~_GEN_40 & (_GEN_38 ? reg_mstatus_spp : reg_mstatus_prv[0]);
  wire [8:0]  _new_mip_T_3 = (io_rw_cmd[1] ? {reg_mip_seip, 3'h0, mip_stip, 3'h0, mip_ssip} : 9'h0) | io_rw_wdata[9:1];
  wire [8:0]  _new_mip_T_7 = ~((&(io_rw_cmd[1:0])) ? io_rw_wdata[9:1] : 9'h0);
  wire [3:0]  new_satp_mode = _wdata_T_2[63:60] & _wdata_T_6[63:60];
  wire        _GEN_41 = pmp_7_cfg_l & ~(pmp_7_cfg_a[1]) & pmp_7_cfg_a[0];
  wire [39:0] _GEN_42 = {wdata[39:1], 1'h0};
  wire        _GEN_43 = _csr_wen_T_4 & (&_decoded_decoded_T_26) & (new_satp_mode == 4'h0 | new_satp_mode == 4'h8);
  wire        _GEN_44 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_cfg_l;
  wire        _GEN_45 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_1_cfg_l;
  wire        _GEN_46 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_2_cfg_l;
  wire        _GEN_47 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_3_cfg_l;
  wire        _GEN_48 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_4_cfg_l;
  wire        _GEN_49 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_5_cfg_l;
  wire        _GEN_50 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_6_cfg_l;
  wire        _GEN_51 = _csr_wen_T_4 & (&_decoded_decoded_T_114) & ~pmp_7_cfg_l;
  wire [1:0]  _GEN_122 = {~_GEN_35, 1'h1};
  wire        _GEN_212 = _GEN_38 & reg_mstatus_sie;
  wire        _GEN_267 = _GEN_40 | (_GEN_38 ? reg_mstatus_spie : reg_mstatus_sie);
  wire        newCfg_r = _wdata_T_2[0] & _wdata_T_6[0];
  always @(posedge clock) begin
    if (reset) begin
      reg_mstatus_prv <= 2'h3;
      reg_mstatus_mpv <= 1'h0;
      reg_mstatus_gva <= 1'h0;
      reg_mstatus_tsr <= 1'h0;
      reg_mstatus_tw <= 1'h0;
      reg_mstatus_tvm <= 1'h0;
      reg_mstatus_mxr <= 1'h0;
      reg_mstatus_sum <= 1'h0;
      reg_mstatus_mprv <= 1'h0;
      reg_mstatus_fs <= 2'h0;
      reg_mstatus_mpp <= 2'h3;
      reg_mstatus_mpie <= 1'h0;
      reg_mstatus_spie <= 1'h0;
      reg_mstatus_mie <= 1'h0;
      reg_mstatus_sie <= 1'h0;
      reg_dcsr_prv <= 2'h3;
      reg_dcsr_ebreakm <= 1'h0;
      reg_dcsr_ebreaks <= 1'h0;
      reg_dcsr_ebreaku <= 1'h0;
      reg_debug <= 1'h0;
      reg_dcsr_cause <= 3'h0;
      reg_dcsr_v <= 1'h0;
      reg_dcsr_step <= 1'h0;
      pmp_cfg_l <= 1'h0;
      pmp_cfg_a <= 2'h0;
      pmp_1_cfg_l <= 1'h0;
      pmp_1_cfg_a <= 2'h0;
      pmp_2_cfg_l <= 1'h0;
      pmp_2_cfg_a <= 2'h0;
      pmp_3_cfg_l <= 1'h0;
      pmp_3_cfg_a <= 2'h0;
      pmp_4_cfg_l <= 1'h0;
      pmp_4_cfg_a <= 2'h0;
      pmp_5_cfg_l <= 1'h0;
      pmp_5_cfg_a <= 2'h0;
      pmp_6_cfg_l <= 1'h0;
      pmp_6_cfg_a <= 2'h0;
      pmp_7_cfg_l <= 1'h0;
      pmp_7_cfg_a <= 2'h0;
      reg_mcause <= 64'h0;
      reg_menvcfg_fiom <= 1'h0;
      reg_senvcfg_fiom <= 1'h0;
      reg_satp_mode <= 4'h0;
      large_0 <= 58'h0;
      reg_custom_0 <= 64'h0;
      io_status_cease_r <= 1'h0;
    end
    else begin
      if ((insn_ret ? ret_prv : exception ? (trapToDebug ? (reg_debug ? reg_mstatus_prv : 2'h3) : _GEN_122) : reg_mstatus_prv) == 2'h2)
        reg_mstatus_prv <= 2'h0;
      else if (insn_ret) begin
        if (io_rw_addr[9]) begin
          if (_GEN_0)
            reg_mstatus_prv <= reg_dcsr_prv;
          else
            reg_mstatus_prv <= reg_mstatus_mpp;
        end
        else
          reg_mstatus_prv <= _GEN_31;
      end
      else if (exception) begin
        if (trapToDebug) begin
          if (reg_debug) begin
          end
          else
            reg_mstatus_prv <= 2'h3;
        end
        else
          reg_mstatus_prv <= _GEN_122;
      end
      reg_mstatus_mpv <= _GEN_33 & (_GEN_39 ? reg_mstatus_mpv : reg_mstatus_v);
      reg_mstatus_gva <= _GEN_39 & reg_mstatus_gva;
      if (_csr_wen_T_4 & (&_decoded_decoded_T_28)) begin
        reg_mstatus_tsr <= wdata[22];
        reg_mstatus_tw <= wdata[21];
        reg_mstatus_tvm <= wdata[20];
        reg_mstatus_mprv <= wdata[17];
        if (wdata[12:11] == 2'h2)
          reg_mstatus_mpp <= 2'h0;
        else
          reg_mstatus_mpp <= wdata[12:11];
        reg_mstatus_mpie <= wdata[7];
        reg_mstatus_mie <= wdata[3];
      end
      else begin
        reg_mstatus_mprv <= ~(insn_ret & ~(ret_prv[1])) & reg_mstatus_mprv;
        if (_GEN_33) begin
          if (_GEN_39) begin
          end
          else
            reg_mstatus_mpp <= reg_mstatus_prv;
        end
        else
          reg_mstatus_mpp <= 2'h0;
        reg_mstatus_mpie <= insn_ret & ~_GEN_32 | (_GEN_39 ? reg_mstatus_mpie : reg_mstatus_mie);
        if (_GEN_33)
          reg_mstatus_mie <= _GEN_39 & reg_mstatus_mie;
        else
          reg_mstatus_mie <= reg_mstatus_mpie;
      end
      if (_csr_wen_T_4) begin
        if (&_decoded_decoded_T_6) begin
          reg_mstatus_mxr <= wdata[19];
          reg_mstatus_sum <= wdata[18];
          reg_mstatus_fs <= wdata[14:13];
          reg_mstatus_spie <= wdata[5];
          reg_mstatus_sie <= wdata[1];
        end
        else if (&_decoded_decoded_T_28) begin
          reg_mstatus_mxr <= wdata[19];
          reg_mstatus_sum <= wdata[18];
          reg_mstatus_fs <= wdata[14:13];
          reg_mstatus_spie <= wdata[5];
          reg_mstatus_sie <= wdata[1];
        end
        else begin
          if (set_fs_dirty)
            reg_mstatus_fs <= 2'h3;
          reg_mstatus_spie <= _GEN_267;
          if (_GEN_40)
            reg_mstatus_sie <= reg_mstatus_spie;
          else
            reg_mstatus_sie <= _GEN_212;
        end
      end
      else begin
        if (set_fs_dirty)
          reg_mstatus_fs <= 2'h3;
        reg_mstatus_spie <= _GEN_267;
        if (_GEN_40)
          reg_mstatus_sie <= reg_mstatus_spie;
        else
          reg_mstatus_sie <= _GEN_212;
      end
      if (_csr_wen_T_4 & (&_decoded_decoded_T_158)) begin
        if (new_dcsr_prv == 2'h2)
          reg_dcsr_prv <= 2'h0;
        else
          reg_dcsr_prv <= new_dcsr_prv;
        reg_dcsr_ebreakm <= _wdata_T_2[15] & _wdata_T_6[15];
        reg_dcsr_ebreaks <= _wdata_T_2[13] & _wdata_T_6[13];
        reg_dcsr_ebreaku <= _wdata_T_2[12] & _wdata_T_6[12];
        reg_dcsr_step <= _wdata_T_2[2] & _wdata_T_6[2];
      end
      else if (_GEN_36)
        reg_dcsr_prv <= reg_mstatus_prv;
      reg_debug <= (~insn_ret | ~(io_rw_addr[9]) | ~_GEN_0) & (_GEN_36 | reg_debug);
      if (_GEN_36) begin
        if (reg_singleStepped)
          reg_dcsr_cause <= 3'h4;
        else
          reg_dcsr_cause <= {1'h0, causeIsDebugInt ? 2'h3 : causeIsDebugTrigger ? 2'h2 : 2'h1};
        reg_dcsr_v <= reg_mstatus_v;
      end
      if (_GEN_44) begin
        pmp_cfg_l <= _wdata_T_2[7] & _wdata_T_6[7];
        pmp_cfg_a <= _wdata_T_2[4:3] & _wdata_T_6[4:3];
      end
      if (_GEN_45) begin
        pmp_1_cfg_l <= _wdata_T_2[15] & _wdata_T_6[15];
        pmp_1_cfg_a <= _wdata_T_2[12:11] & _wdata_T_6[12:11];
      end
      if (_GEN_46) begin
        pmp_2_cfg_l <= _wdata_T_2[23] & _wdata_T_6[23];
        pmp_2_cfg_a <= _wdata_T_2[20:19] & _wdata_T_6[20:19];
      end
      if (_GEN_47) begin
        pmp_3_cfg_l <= _wdata_T_2[31] & _wdata_T_6[31];
        pmp_3_cfg_a <= _wdata_T_2[28:27] & _wdata_T_6[28:27];
      end
      if (_GEN_48) begin
        pmp_4_cfg_l <= _wdata_T_2[39] & _wdata_T_6[39];
        pmp_4_cfg_a <= _wdata_T_2[36:35] & _wdata_T_6[36:35];
      end
      if (_GEN_49) begin
        pmp_5_cfg_l <= _wdata_T_2[47] & _wdata_T_6[47];
        pmp_5_cfg_a <= _wdata_T_2[44:43] & _wdata_T_6[44:43];
      end
      if (_GEN_50) begin
        pmp_6_cfg_l <= _wdata_T_2[55] & _wdata_T_6[55];
        pmp_6_cfg_a <= _wdata_T_2[52:51] & _wdata_T_6[52:51];
      end
      if (_GEN_51) begin
        pmp_7_cfg_l <= _wdata_T_2[63] & _wdata_T_6[63];
        pmp_7_cfg_a <= _wdata_T_2[60:59] & _wdata_T_6[60:59];
      end
      if (_csr_wen_T_4 & (&_decoded_decoded_T_108))
        reg_mcause <= wdata & 64'h800000000000000F;
      else if (_GEN_39) begin
      end
      else if (insn_call)
        reg_mcause <= _GEN_1;
      else if (insn_break)
        reg_mcause <= 64'h3;
      else
        reg_mcause <= io_cause;
      if (_csr_wen_T_4 & (&_decoded_decoded_T_42))
        reg_menvcfg_fiom <= _wdata_T_2[0] & _wdata_T_6[0];
      if (_csr_wen_T_4 & (&_decoded_decoded_T_14))
        reg_senvcfg_fiom <= _wdata_T_2[0] & _wdata_T_6[0];
      if (_GEN_43)
        reg_satp_mode <= new_satp_mode & 4'h8;
      if (_csr_wen_T_4 & (&_decoded_decoded_T_168))
        large_0 <= _wdata_T_2[63:6] & _wdata_T_6[63:6];
      else if (nextSmall[6] & ~(reg_mcountinhibit[2]))
        large_0 <= large_0 + 58'h1;
      if (_csr_wen_T_4 & (&_decoded_decoded_T_164))
        reg_custom_0 <= wdata & 64'h8 | reg_custom_0 & 64'hFFFFFFFFFFFFFFF7;
      io_status_cease_r <= system_insn & (&{io_rw_addr[2], _GEN[3], _GEN[4], _GEN[5], _GEN[6], _GEN[7], io_rw_addr[8], io_rw_addr[9], _GEN[10], _GEN[11]}) | io_status_cease_r;
    end
    reg_mstatus_v <= ~(reset | insn_ret) & (exception ? (trapToDebug ? reg_debug & reg_mstatus_v : delegateVS) : reg_mstatus_v);
    if (reset | _csr_wen_T_4 & ((&_decoded_decoded_T_6) | (&_decoded_decoded_T_28)))
      reg_mstatus_vs <= 2'h0;
    reg_mstatus_spp <= ~reset & (_csr_wen_T_4 ? ((&_decoded_decoded_T_6) ? wdata[8] : (&_decoded_decoded_T_28) ? wdata[8] : _GEN_268) : _GEN_268);
    reg_vsstatus_spp <= ~(insn_ret & ~(io_rw_addr[9]) & reg_mstatus_v) & (_GEN_37 ? reg_vsstatus_spp : reg_mstatus_prv[0]);
    reg_singleStepped <= _io_singleStep_output & (io_retire[0] | exception | reg_singleStepped);
    if (_csr_wen_T_4 & (&_decoded_decoded_T_34))
      reg_mideleg <= wdata;
    if (_csr_wen_T_4 & (&_decoded_decoded_T_32))
      reg_medeleg <= wdata;
    reg_dpc <= _csr_wen_T_4 & (&_decoded_decoded_T_160) ? _GEN_42 : _GEN_36 ? epc : reg_dpc;
    if (_csr_wen_T_4 & (&_decoded_decoded_T_162))
      reg_dscratch0 <= wdata;
    if (_GEN_44) begin
      pmp_cfg_x <= _wdata_T_2[2] & _wdata_T_6[2];
      pmp_cfg_w <= _wdata_T_2[1] & _wdata_T_6[1] & newCfg_r;
      pmp_cfg_r <= newCfg_r;
    end
    pmp_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_118) & ~(pmp_cfg_l | pmp_1_cfg_l & ~(pmp_1_cfg_a[1]) & pmp_1_cfg_a[0]) ? wdata[29:0] : pmp_addr;
    if (_GEN_45) begin
      pmp_1_cfg_x <= _wdata_T_2[10] & _wdata_T_6[10];
      pmp_1_cfg_w <= _wdata_T_2[9] & _wdata_T_6[9] & newCfg_1_r;
      pmp_1_cfg_r <= newCfg_1_r;
    end
    pmp_1_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_120) & ~(pmp_1_cfg_l | pmp_2_cfg_l & ~(pmp_2_cfg_a[1]) & pmp_2_cfg_a[0]) ? wdata[29:0] : pmp_1_addr;
    if (_GEN_46) begin
      pmp_2_cfg_x <= _wdata_T_2[18] & _wdata_T_6[18];
      pmp_2_cfg_w <= _wdata_T_2[17] & _wdata_T_6[17] & newCfg_2_r;
      pmp_2_cfg_r <= newCfg_2_r;
    end
    pmp_2_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_122) & ~(pmp_2_cfg_l | pmp_3_cfg_l & ~(pmp_3_cfg_a[1]) & pmp_3_cfg_a[0]) ? wdata[29:0] : pmp_2_addr;
    if (_GEN_47) begin
      pmp_3_cfg_x <= _wdata_T_2[26] & _wdata_T_6[26];
      pmp_3_cfg_w <= _wdata_T_2[25] & _wdata_T_6[25] & newCfg_3_r;
      pmp_3_cfg_r <= newCfg_3_r;
    end
    pmp_3_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_124) & ~(pmp_3_cfg_l | pmp_4_cfg_l & ~(pmp_4_cfg_a[1]) & pmp_4_cfg_a[0]) ? wdata[29:0] : pmp_3_addr;
    if (_GEN_48) begin
      pmp_4_cfg_x <= _wdata_T_2[34] & _wdata_T_6[34];
      pmp_4_cfg_w <= _wdata_T_2[33] & _wdata_T_6[33] & newCfg_4_r;
      pmp_4_cfg_r <= newCfg_4_r;
    end
    pmp_4_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_126) & ~(pmp_4_cfg_l | pmp_5_cfg_l & ~(pmp_5_cfg_a[1]) & pmp_5_cfg_a[0]) ? wdata[29:0] : pmp_4_addr;
    if (_GEN_49) begin
      pmp_5_cfg_x <= _wdata_T_2[42] & _wdata_T_6[42];
      pmp_5_cfg_w <= _wdata_T_2[41] & _wdata_T_6[41] & newCfg_5_r;
      pmp_5_cfg_r <= newCfg_5_r;
    end
    pmp_5_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_128) & ~(pmp_5_cfg_l | pmp_6_cfg_l & ~(pmp_6_cfg_a[1]) & pmp_6_cfg_a[0]) ? wdata[29:0] : pmp_5_addr;
    if (_GEN_50) begin
      pmp_6_cfg_x <= _wdata_T_2[50] & _wdata_T_6[50];
      pmp_6_cfg_w <= _wdata_T_2[49] & _wdata_T_6[49] & newCfg_6_r;
      pmp_6_cfg_r <= newCfg_6_r;
    end
    pmp_6_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_130) & ~(pmp_6_cfg_l | _GEN_41) ? wdata[29:0] : pmp_6_addr;
    if (_GEN_51) begin
      pmp_7_cfg_x <= _wdata_T_2[58] & _wdata_T_6[58];
      pmp_7_cfg_w <= _wdata_T_2[57] & _wdata_T_6[57] & newCfg_7_r;
      pmp_7_cfg_r <= newCfg_7_r;
    end
    pmp_7_addr <= _csr_wen_T_4 & (&_decoded_decoded_T_132) & ~(pmp_7_cfg_l | _GEN_41) ? wdata[29:0] : pmp_7_addr;
    if (_csr_wen_T_4) begin
      if (&_decoded_decoded_T_8)
        reg_mie <= {reg_mie[63:16], reg_mie[15:0] & {6'h3F, ~_GEN_2, 1'h1} | _GEN_34 & _GEN_3};
      else if (&_decoded_decoded_T_36)
        reg_mie <= {48'h0, _GEN_34 & 16'hAAA};
      if (&_decoded_decoded_T_24)
        mip_ssip <= ~(reg_mideleg[1]) & mip_ssip | _GEN_34[1] & reg_mideleg[1];
      else if (&_decoded_decoded_T_112)
        mip_ssip <= _new_mip_T_3[0] & _new_mip_T_7[0];
    end
    if (_csr_wen_T_4 & (&_decoded_decoded_T_112)) begin
      reg_mip_seip <= _new_mip_T_3[8] & _new_mip_T_7[8];
      mip_stip <= _new_mip_T_3[4] & _new_mip_T_7[4];
    end
    reg_mepc <= _csr_wen_T_4 & (&_decoded_decoded_T_106) ? _GEN_42 : _GEN_39 ? reg_mepc : epc;
    reg_mtval <= _csr_wen_T_4 & (&_decoded_decoded_T_110) ? wdata[39:0] : _GEN_39 ? reg_mtval : tval;
    if (_csr_wen_T_4 & (&_decoded_decoded_T_104))
      reg_mscratch <= wdata;
    reg_mtvec <= reset ? 32'h0 : _csr_wen_T_4 & (&_decoded_decoded_T_38) ? wdata[31:0] : reg_mtvec;
    reg_mcounteren <= _csr_wen_T_4 & (&_decoded_decoded_T_40) ? wdata[31:0] : reg_mcounteren;
    reg_scounteren <= _csr_wen_T_4 & (&_decoded_decoded_T_12) ? wdata[31:0] : reg_scounteren;
    if (set_fs_dirty & reg_mstatus_v)
      reg_vsstatus_fs <= 2'h3;
    if (_GEN_37) begin
    end
    else
      reg_vsepc <= epc;
    reg_sepc <= _csr_wen_T_4 & (&_decoded_decoded_T_18) ? _GEN_42 : _GEN_38 ? reg_sepc : epc;
    if (_csr_wen_T_4 & (&_decoded_decoded_T_20))
      reg_scause <= wdata & 64'h800000000000001F;
    else if (_GEN_38) begin
    end
    else if (insn_call)
      reg_scause <= _GEN_1;
    else if (insn_break)
      reg_scause <= 64'h3;
    else
      reg_scause <= io_cause;
    reg_stval <= _csr_wen_T_4 & (&_decoded_decoded_T_22) ? wdata[39:0] : _GEN_38 ? reg_stval : tval;
    if (_csr_wen_T_4 & (&_decoded_decoded_T_16))
      reg_sscratch <= wdata;
    reg_stvec <= _csr_wen_T_4 & (&_decoded_decoded_T_10) ? wdata[38:0] : reg_stvec;
    if (_GEN_43)
      reg_satp_ppn <= {24'h0, _wdata_T_2[19:0] & _wdata_T_6[19:0]};
    reg_fflags <= _csr_wen_T_4 & ((&_decoded_decoded_T_4) | (&_decoded_decoded_T)) ? wdata[4:0] : {5{io_fcsr_flags_valid}} & io_fcsr_flags_bits | reg_fflags;
    reg_frm <= _csr_wen_T_4 ? ((&_decoded_decoded_T_4) ? _wdata_T_2[7:5] & _wdata_T_6[7:5] : (&_decoded_decoded_T_2) ? wdata[2:0] : reg_frm) : reg_frm;
    reg_mcountinhibit <= reset ? 3'h0 : _csr_wen_T_4 & (&_decoded_decoded_T_44) ? wdata[2:0] & 3'h5 : reg_mcountinhibit;
    small_0 <= reset ? 6'h0 : _csr_wen_T_4 & (&_decoded_decoded_T_168) ? wdata[5:0] : reg_mcountinhibit[2] ? small_0 : nextSmall[5:0];
  end // always @(posedge)
  wire [6:0]  nextSmall_1 = {1'h0, small_1} + {6'h0, ~_io_csr_stall_output};
  always @(posedge io_ungated_clock) begin
    if (reset) begin
      reg_wfi <= 1'h0;
      large_1 <= 58'h0;
    end
    else begin
      reg_wfi <= ~((|{_GEN_9[11], _GEN_9[9], _GEN_9[7], _GEN_9[5], _GEN_9[3], _GEN_9[1]}) | io_interrupts_debug | exception) & (system_insn & (&{io_rw_addr[2], _GEN[3], _GEN[4], _GEN[5], _GEN[6], _GEN[7], io_rw_addr[8], _GEN[9], _GEN[10], _GEN[11]}) & ~_io_singleStep_output & ~reg_debug | reg_wfi);
      if (_csr_wen_T_4 & (&_decoded_decoded_T_166))
        large_1 <= _wdata_T_2[63:6] & _wdata_T_6[63:6];
      else if (nextSmall_1[6] & ~(reg_mcountinhibit[0]))
        large_1 <= large_1 + 58'h1;
    end
    small_1 <= reset ? 6'h0 : _csr_wen_T_4 & (&_decoded_decoded_T_166) ? wdata[5:0] : reg_mcountinhibit[0] ? small_1 : nextSmall_1[5:0];
  end // always @(posedge)
  assign io_rw_rdata = _io_rw_rdata_output;
  assign io_decode_0_fp_illegal = _io_decode_0_fp_illegal_output;
  assign io_decode_0_read_illegal = _io_decode_0_system_illegal_T | ~csr_exists | (_io_decode_0_virtual_access_illegal_T_24 | io_decode_0_inst[31:20] == 12'h680) & ~allow_sfence_vma | (io_decode_0_inst[31:20] > 12'hBFF & io_decode_0_inst[31:20] < 12'hC20 | io_decode_0_inst[31:20] > 12'hC7F & io_decode_0_inst[31:20] < 12'hCA0) & ~((reg_mstatus_prv[1] | _io_decode_0_virtual_access_illegal_T_3[0]) & ((|reg_mstatus_prv) | _io_decode_0_virtual_access_illegal_T_11[0])) | (&{io_decode_0_inst[24], io_decode_0_inst[25], io_decode_0_read_illegal_invInputs[0], io_decode_0_inst[27], io_decode_0_inst[28], io_decode_0_inst[29], io_decode_0_inst[30], io_decode_0_read_illegal_invInputs[5]}) & ~reg_debug | (&{io_decode_0_fp_csr_invInputs[0], io_decode_0_fp_csr_invInputs[1], io_decode_0_fp_csr_invInputs[2], io_decode_0_fp_csr_invInputs[3]}) & _io_decode_0_fp_illegal_output;
  assign io_decode_0_write_illegal = &(io_decode_0_inst[31:30]);
  assign io_decode_0_write_flush = ~(io_decode_0_write_flush_addr_m > 12'h33F & io_decode_0_write_flush_addr_m < 12'h344);
  assign io_decode_0_system_illegal = _io_decode_0_system_illegal_T | (&{io_decode_0_inst[22], decoded_invInputs_1[21], decoded_invInputs_1[22], decoded_invInputs_1[23], decoded_invInputs_1[24], decoded_invInputs_1[25], io_decode_0_inst[28], decoded_invInputs_1[27], decoded_invInputs_1[28], decoded_invInputs_1[29]}) & ~(reg_mstatus_prv[1] | ~reg_mstatus_tw) | (|_decoded_orMatrixOutputs_T_10) & ~(reg_mstatus_prv[1] | ~_allow_sret_T_14) | (|_decoded_orMatrixOutputs_T_10) & io_decode_0_inst[30] & io_decode_0_inst[27] & ~reg_debug | (&{io_decode_0_inst[0], io_decode_0_inst[1], decoded_invInputs_1[0], decoded_invInputs_1[1], io_decode_0_inst[4], io_decode_0_inst[5], io_decode_0_inst[6], decoded_invInputs_1[5], decoded_invInputs_1[6], decoded_invInputs_1[7], io_decode_0_inst[25], decoded_invInputs_1[24], decoded_invInputs_1[25], io_decode_0_inst[28], decoded_invInputs_1[27], decoded_invInputs_1[28], decoded_invInputs_1[29]}) & ~allow_sfence_vma;
  assign io_decode_1_fp_illegal = _io_decode_1_fp_illegal_output;
  assign io_decode_1_read_illegal = _io_decode_1_system_illegal_T | ~csr_exists_1 | (_io_decode_1_virtual_access_illegal_T_24 | io_decode_1_inst[31:20] == 12'h680) & ~allow_sfence_vma_1 | (io_decode_1_inst[31:20] > 12'hBFF & io_decode_1_inst[31:20] < 12'hC20 | io_decode_1_inst[31:20] > 12'hC7F & io_decode_1_inst[31:20] < 12'hCA0) & ~((reg_mstatus_prv[1] | _io_decode_1_virtual_access_illegal_T_3[0]) & ((|reg_mstatus_prv) | _io_decode_1_virtual_access_illegal_T_11[0])) | (&{io_decode_1_inst[24], io_decode_1_inst[25], io_decode_1_read_illegal_invInputs[0], io_decode_1_inst[27], io_decode_1_inst[28], io_decode_1_inst[29], io_decode_1_inst[30], io_decode_1_read_illegal_invInputs[5]}) & ~reg_debug | (&{io_decode_1_fp_csr_invInputs[0], io_decode_1_fp_csr_invInputs[1], io_decode_1_fp_csr_invInputs[2], io_decode_1_fp_csr_invInputs[3]}) & _io_decode_1_fp_illegal_output;
  assign io_decode_1_write_illegal = &(io_decode_1_inst[31:30]);
  assign io_decode_1_write_flush = ~(io_decode_1_write_flush_addr_m > 12'h33F & io_decode_1_write_flush_addr_m < 12'h344);
  assign io_decode_1_system_illegal = _io_decode_1_system_illegal_T | (&{io_decode_1_inst[22], decoded_invInputs_2[21], decoded_invInputs_2[22], decoded_invInputs_2[23], decoded_invInputs_2[24], decoded_invInputs_2[25], io_decode_1_inst[28], decoded_invInputs_2[27], decoded_invInputs_2[28], decoded_invInputs_2[29]}) & ~(reg_mstatus_prv[1] | ~reg_mstatus_tw) | (|_decoded_orMatrixOutputs_T_17) & ~(reg_mstatus_prv[1] | ~_allow_sret_T_14) | (|_decoded_orMatrixOutputs_T_17) & io_decode_1_inst[30] & io_decode_1_inst[27] & ~reg_debug | (&{io_decode_1_inst[0], io_decode_1_inst[1], decoded_invInputs_2[0], decoded_invInputs_2[1], io_decode_1_inst[4], io_decode_1_inst[5], io_decode_1_inst[6], decoded_invInputs_2[5], decoded_invInputs_2[6], decoded_invInputs_2[7], io_decode_1_inst[25], decoded_invInputs_2[24], decoded_invInputs_2[25], io_decode_1_inst[28], decoded_invInputs_2[27], decoded_invInputs_2[28], decoded_invInputs_2[29]}) & ~allow_sfence_vma_1;
  assign io_decode_2_fp_illegal = _io_decode_2_fp_illegal_output;
  assign io_decode_2_read_illegal = _io_decode_2_system_illegal_T | ~csr_exists_2 | (_io_decode_2_virtual_access_illegal_T_24 | io_decode_2_inst[31:20] == 12'h680) & ~allow_sfence_vma_2 | (io_decode_2_inst[31:20] > 12'hBFF & io_decode_2_inst[31:20] < 12'hC20 | io_decode_2_inst[31:20] > 12'hC7F & io_decode_2_inst[31:20] < 12'hCA0) & ~((reg_mstatus_prv[1] | _io_decode_2_virtual_access_illegal_T_3[0]) & ((|reg_mstatus_prv) | _io_decode_2_virtual_access_illegal_T_11[0])) | (&{io_decode_2_inst[24], io_decode_2_inst[25], io_decode_2_read_illegal_invInputs[0], io_decode_2_inst[27], io_decode_2_inst[28], io_decode_2_inst[29], io_decode_2_inst[30], io_decode_2_read_illegal_invInputs[5]}) & ~reg_debug | (&{io_decode_2_fp_csr_invInputs[0], io_decode_2_fp_csr_invInputs[1], io_decode_2_fp_csr_invInputs[2], io_decode_2_fp_csr_invInputs[3]}) & _io_decode_2_fp_illegal_output;
  assign io_decode_2_write_illegal = &(io_decode_2_inst[31:30]);
  assign io_decode_2_write_flush = ~(io_decode_2_write_flush_addr_m > 12'h33F & io_decode_2_write_flush_addr_m < 12'h344);
  assign io_decode_2_system_illegal = _io_decode_2_system_illegal_T | (&{io_decode_2_inst[22], decoded_invInputs_3[21], decoded_invInputs_3[22], decoded_invInputs_3[23], decoded_invInputs_3[24], decoded_invInputs_3[25], io_decode_2_inst[28], decoded_invInputs_3[27], decoded_invInputs_3[28], decoded_invInputs_3[29]}) & ~(reg_mstatus_prv[1] | ~reg_mstatus_tw) | (|_decoded_orMatrixOutputs_T_24) & ~(reg_mstatus_prv[1] | ~_allow_sret_T_14) | (|_decoded_orMatrixOutputs_T_24) & io_decode_2_inst[30] & io_decode_2_inst[27] & ~reg_debug | (&{io_decode_2_inst[0], io_decode_2_inst[1], decoded_invInputs_3[0], decoded_invInputs_3[1], io_decode_2_inst[4], io_decode_2_inst[5], io_decode_2_inst[6], decoded_invInputs_3[5], decoded_invInputs_3[6], decoded_invInputs_3[7], io_decode_2_inst[25], decoded_invInputs_3[24], decoded_invInputs_3[25], io_decode_2_inst[28], decoded_invInputs_3[27], decoded_invInputs_3[28], decoded_invInputs_3[29]}) & ~allow_sfence_vma_2;
  assign io_decode_3_fp_illegal = _io_decode_3_fp_illegal_output;
  assign io_decode_3_read_illegal = _io_decode_3_system_illegal_T | ~csr_exists_3 | (_io_decode_3_virtual_access_illegal_T_24 | io_decode_3_inst[31:20] == 12'h680) & ~allow_sfence_vma_3 | (io_decode_3_inst[31:20] > 12'hBFF & io_decode_3_inst[31:20] < 12'hC20 | io_decode_3_inst[31:20] > 12'hC7F & io_decode_3_inst[31:20] < 12'hCA0) & ~((reg_mstatus_prv[1] | _io_decode_3_virtual_access_illegal_T_3[0]) & ((|reg_mstatus_prv) | _io_decode_3_virtual_access_illegal_T_11[0])) | (&{io_decode_3_inst[24], io_decode_3_inst[25], io_decode_3_read_illegal_invInputs[0], io_decode_3_inst[27], io_decode_3_inst[28], io_decode_3_inst[29], io_decode_3_inst[30], io_decode_3_read_illegal_invInputs[5]}) & ~reg_debug | (&{io_decode_3_fp_csr_invInputs[0], io_decode_3_fp_csr_invInputs[1], io_decode_3_fp_csr_invInputs[2], io_decode_3_fp_csr_invInputs[3]}) & _io_decode_3_fp_illegal_output;
  assign io_decode_3_write_illegal = &(io_decode_3_inst[31:30]);
  assign io_decode_3_write_flush = ~(io_decode_3_write_flush_addr_m > 12'h33F & io_decode_3_write_flush_addr_m < 12'h344);
  assign io_decode_3_system_illegal = _io_decode_3_system_illegal_T | (&{io_decode_3_inst[22], decoded_invInputs_4[21], decoded_invInputs_4[22], decoded_invInputs_4[23], decoded_invInputs_4[24], decoded_invInputs_4[25], io_decode_3_inst[28], decoded_invInputs_4[27], decoded_invInputs_4[28], decoded_invInputs_4[29]}) & ~(reg_mstatus_prv[1] | ~reg_mstatus_tw) | (|_decoded_orMatrixOutputs_T_31) & ~(reg_mstatus_prv[1] | ~_allow_sret_T_14) | (|_decoded_orMatrixOutputs_T_31) & io_decode_3_inst[30] & io_decode_3_inst[27] & ~reg_debug | (&{io_decode_3_inst[0], io_decode_3_inst[1], decoded_invInputs_4[0], decoded_invInputs_4[1], io_decode_3_inst[4], io_decode_3_inst[5], io_decode_3_inst[6], decoded_invInputs_4[5], decoded_invInputs_4[6], decoded_invInputs_4[7], io_decode_3_inst[25], decoded_invInputs_4[24], decoded_invInputs_4[25], io_decode_3_inst[28], decoded_invInputs_4[27], decoded_invInputs_4[28], decoded_invInputs_4[29]}) & ~allow_sfence_vma_3;
  assign io_csr_stall = _io_csr_stall_output;
  assign io_singleStep = _io_singleStep_output;
  assign io_status_debug = reg_debug;
  assign io_status_dprv = reg_mstatus_mprv & ~reg_debug ? reg_mstatus_mpp : reg_mstatus_prv;
  assign io_status_prv = reg_mstatus_prv;
  assign io_status_mxr = reg_mstatus_mxr;
  assign io_status_sum = reg_mstatus_sum;
  assign io_ptbr_mode = reg_satp_mode;
  assign io_ptbr_ppn = reg_satp_ppn;
  assign io_evec = insn_ret ? (io_rw_addr[9] ? (_GEN_0 ? ~{_io_evec_T_10[39:2], _GEN_20} : ~{_io_evec_T_20[39:2], _GEN_18}) : reg_mstatus_v ? ~{_io_evec_T_5[39:2], _io_evec_T_5[1:0] | 2'h1} : ~{_io_evec_T[39:2], _GEN_22}) : trapToDebug ? {28'h0, reg_debug ? {8'h80, ~insn_break, 3'h0} : 12'h800} : {notDebugTVec_base[0] & cause[63] & cause[7:6] == 2'h0 ? {notDebugTVec_base[39:8], cause[5:0]} : notDebugTVec_base[39:2], 2'h0};
  assign io_fcsr_rm = reg_frm;
  assign io_interrupt = ((io_interrupts_debug | m_interrupts[15] | m_interrupts[14] | m_interrupts[13] | m_interrupts[12] | m_interrupts[11] | m_interrupts[3] | m_interrupts[7] | m_interrupts[9] | m_interrupts[1] | m_interrupts[5] | m_interrupts[10] | m_interrupts[2] | m_interrupts[6] | m_interrupts[8] | m_interrupts[0] | m_interrupts[4] | s_interrupts[15] | s_interrupts[14] | s_interrupts[13] | s_interrupts[12] | s_interrupts[11] | s_interrupts[3] | s_interrupts[7] | s_interrupts[9] | s_interrupts[1] | s_interrupts[5] | s_interrupts[10] | s_interrupts[2] | s_interrupts[6] | s_interrupts[8] | s_interrupts[0] | s_interrupts[4]) & ~_io_singleStep_output | reg_singleStepped) & ~(reg_debug | io_status_cease_r);
  assign io_interrupt_cause = {60'h0, io_interrupts_debug ? 4'hE : m_interrupts[15] ? 4'hF : m_interrupts[14] ? 4'hE : m_interrupts[13] ? 4'hD : m_interrupts[12] ? 4'hC : m_interrupts[11] ? 4'hB : m_interrupts[3] ? 4'h3 : m_interrupts[7] ? 4'h7 : m_interrupts[9] ? 4'h9 : m_interrupts[1] ? 4'h1 : m_interrupts[5] ? 4'h5 : m_interrupts[10] ? 4'hA : m_interrupts[2] ? 4'h2 : m_interrupts[6] ? 4'h6 : m_interrupts[8] ? 4'h8 : m_interrupts[0] ? 4'h0 : m_interrupts[4] ? 4'h4 : s_interrupts[15] ? 4'hF : s_interrupts[14] ? 4'hE : s_interrupts[13] ? 4'hD : s_interrupts[12] ? 4'hC : s_interrupts[11] ? 4'hB : s_interrupts[3] ? 4'h3 : s_interrupts[7] ? 4'h7 : s_interrupts[9] ? 4'h9 : s_interrupts[1] ? 4'h1 : s_interrupts[5] ? 4'h5 : s_interrupts[10] ? 4'hA : s_interrupts[2] ? 4'h2 : s_interrupts[6] ? 4'h6 : s_interrupts[8] ? 4'h8 : {1'h0, ~(s_interrupts[0]), 2'h0}} - 64'h8000000000000000;
  assign io_pmp_0_cfg_l = pmp_cfg_l;
  assign io_pmp_0_cfg_a = pmp_cfg_a;
  assign io_pmp_0_cfg_x = pmp_cfg_x;
  assign io_pmp_0_cfg_w = pmp_cfg_w;
  assign io_pmp_0_cfg_r = pmp_cfg_r;
  assign io_pmp_0_addr = pmp_addr;
  assign io_pmp_0_mask = {_GEN_10 & ~(_GEN_10 + 30'h1), 2'h3};
  assign io_pmp_1_cfg_l = pmp_1_cfg_l;
  assign io_pmp_1_cfg_a = pmp_1_cfg_a;
  assign io_pmp_1_cfg_x = pmp_1_cfg_x;
  assign io_pmp_1_cfg_w = pmp_1_cfg_w;
  assign io_pmp_1_cfg_r = pmp_1_cfg_r;
  assign io_pmp_1_addr = pmp_1_addr;
  assign io_pmp_1_mask = {_GEN_11 & ~(_GEN_11 + 30'h1), 2'h3};
  assign io_pmp_2_cfg_l = pmp_2_cfg_l;
  assign io_pmp_2_cfg_a = pmp_2_cfg_a;
  assign io_pmp_2_cfg_x = pmp_2_cfg_x;
  assign io_pmp_2_cfg_w = pmp_2_cfg_w;
  assign io_pmp_2_cfg_r = pmp_2_cfg_r;
  assign io_pmp_2_addr = pmp_2_addr;
  assign io_pmp_2_mask = {_GEN_12 & ~(_GEN_12 + 30'h1), 2'h3};
  assign io_pmp_3_cfg_l = pmp_3_cfg_l;
  assign io_pmp_3_cfg_a = pmp_3_cfg_a;
  assign io_pmp_3_cfg_x = pmp_3_cfg_x;
  assign io_pmp_3_cfg_w = pmp_3_cfg_w;
  assign io_pmp_3_cfg_r = pmp_3_cfg_r;
  assign io_pmp_3_addr = pmp_3_addr;
  assign io_pmp_3_mask = {_GEN_13 & ~(_GEN_13 + 30'h1), 2'h3};
  assign io_pmp_4_cfg_l = pmp_4_cfg_l;
  assign io_pmp_4_cfg_a = pmp_4_cfg_a;
  assign io_pmp_4_cfg_x = pmp_4_cfg_x;
  assign io_pmp_4_cfg_w = pmp_4_cfg_w;
  assign io_pmp_4_cfg_r = pmp_4_cfg_r;
  assign io_pmp_4_addr = pmp_4_addr;
  assign io_pmp_4_mask = {_GEN_14 & ~(_GEN_14 + 30'h1), 2'h3};
  assign io_pmp_5_cfg_l = pmp_5_cfg_l;
  assign io_pmp_5_cfg_a = pmp_5_cfg_a;
  assign io_pmp_5_cfg_x = pmp_5_cfg_x;
  assign io_pmp_5_cfg_w = pmp_5_cfg_w;
  assign io_pmp_5_cfg_r = pmp_5_cfg_r;
  assign io_pmp_5_addr = pmp_5_addr;
  assign io_pmp_5_mask = {_GEN_15 & ~(_GEN_15 + 30'h1), 2'h3};
  assign io_pmp_6_cfg_l = pmp_6_cfg_l;
  assign io_pmp_6_cfg_a = pmp_6_cfg_a;
  assign io_pmp_6_cfg_x = pmp_6_cfg_x;
  assign io_pmp_6_cfg_w = pmp_6_cfg_w;
  assign io_pmp_6_cfg_r = pmp_6_cfg_r;
  assign io_pmp_6_addr = pmp_6_addr;
  assign io_pmp_6_mask = {_GEN_16 & ~(_GEN_16 + 30'h1), 2'h3};
  assign io_pmp_7_cfg_l = pmp_7_cfg_l;
  assign io_pmp_7_cfg_a = pmp_7_cfg_a;
  assign io_pmp_7_cfg_x = pmp_7_cfg_x;
  assign io_pmp_7_cfg_w = pmp_7_cfg_w;
  assign io_pmp_7_cfg_r = pmp_7_cfg_r;
  assign io_pmp_7_addr = pmp_7_addr;
  assign io_pmp_7_mask = {_GEN_17 & ~(_GEN_17 + 30'h1), 2'h3};
  assign io_customCSRs_0_value = reg_custom_0;
endmodule

