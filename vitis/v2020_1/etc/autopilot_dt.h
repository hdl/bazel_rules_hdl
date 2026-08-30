/*-*-c++-*-*/
/* autopilot_dt.h: defines all bit-accurate data types.*/
/*
#-  (c) Copyright 2011-2019 Xilinx, Inc. All rights reserved.
#-
#-  This file contains confidential and proprietary information
#-  of Xilinx, Inc. and is protected under U.S. and
#-  international copyright and other intellectual property
#-  laws.
#-
#-  DISCLAIMER
#-  This disclaimer is not a license and does not grant any
#-  rights to the materials distributed herewith. Except as
#-  otherwise provided in a valid license issued to you by
#-  Xilinx, and to the maximum extent permitted by applicable
#-  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
#-  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
#-  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
#-  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
#-  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#-  (2) Xilinx shall not be liable (whether in contract or tort,
#-  including negligence, or under any other theory of
#-  liability) for any loss or damage of any kind or nature
#-  related to, arising under or in connection with these
#-  materials, including for any direct, or any indirect,
#-  special, incidental, or consequential loss or damage
#-  (including loss of data, profits, goodwill, or any type of
#-  loss or damage suffered as a result of any action brought
#-  by a third party) even if such damage or loss was
#-  reasonably foreseeable or Xilinx had been advised of the
#-  possibility of the same.
#-
#-  CRITICAL APPLICATIONS
#-  Xilinx products are not designed or intended to be fail-
#-  safe, or for use in any application requiring fail-safe
#-  performance, such as life-support or safety devices or
#-  systems, Class III medical devices, nuclear facilities,
#-  applications related to the deployment of airbags, or any
#-  other applications that could lead to death, personal
#-  injury, or severe property or environmental damage
#-  (individually and collectively, "Critical
#-  Applications"). Customer assumes the sole risk and
#-  liability of any use of Xilinx products in Critical
#-  Applications, subject only to applicable laws and
#-  regulations governing limitations on product liability.
#-
#-  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
#-  PART OF THIS FILE AT ALL TIMES. 
#- ************************************************************************

 *
 * $Id$
 */

#ifndef _AUTOPILOT_DT_H_
#define _AUTOPILOT_DT_H_
#ifndef AP_INT_MAX_W
#define AP_INT_MAX_W 1024
#endif
#if AP_INT_MAX_W > (1 << 15) 
#error "Bitwidth exceeds 32768 (1 << 15), the maximum allowed value"
#endif
#define AP_INT_MAX_UNIT ((AP_INT_MAX_W + 1023) / 1024)
#define _TY_CONCAT(P, T) P##T

#if defined(__cplusplus) & defined(C_TEST)
#  warning "Using SystemC data types"

#  include "systemc.h"
using namespace sc_dt;

#if defined(APINT_TYPE_PREFIX)
#  define HANDLE_BAT(T, N) typedef sc_dt::sc_int<N> _TY_CONCAT(T, int##N);
#else
#  define HANDLE_BAT(T, N) typedef sc_dt::sc_int<N> _TY_CONCAT(, int##N);
#endif
#  include "etc/autopilot_dt.def"

#if defined(APINT_TYPE_PREFIX)
#  define HANDLE_BAT(T, N) typedef sc_dt::sc_uint<N> _TY_CONCAT(T, uint##N);
#else
#  define HANDLE_BAT(T, N) typedef sc_dt::sc_uint<N> _TY_CONCAT(, uint##N);
#endif
#  include "etc/autopilot_dt.def"

/* No definition for SystemC sc_dt::int64 and uint64.*/

#else

#if defined(APINT_TYPE_PREFIX)
#  define HANDLE_BAT(T, N) \
    typedef int __attribute__ ((bitwidth(N))) _TY_CONCAT(T, int##N);
#else
#  define HANDLE_BAT(T, N) \
    typedef int __attribute__ ((bitwidth(N))) _TY_CONCAT(, int##N);
#endif
#  include "etc/autopilot_dt.def"
#  include "etc/autopilot_dt_ext.def"
#undef HANDLE_BAT

#if defined(APINT_TYPE_PREFIX)
#  define HANDLE_BAT(T, N) \
    typedef unsigned int __attribute__ ((bitwidth(N))) _TY_CONCAT(T, uint##N);
#else
#  define HANDLE_BAT(T, N) \
    typedef unsigned int __attribute__ ((bitwidth(N))) _TY_CONCAT(, uint##N);
#endif
#  include "etc/autopilot_dt.def"
#  include "etc/autopilot_dt_ext.def"
#undef HANDLE_BAT

#undef AP_INT_MAX_UNIT

#  if defined(__cplusplus)
/*#    warning "Incomplete C++ data types"
#    include "autopilot_dt.hpp" */
#    ifndef __SC_COMPATIBLE__
         typedef int __attribute__ ((bitwidth(64))) ap_int64;
         typedef unsigned int __attribute__ ((bitwidth(64))) ap_uint64;
#        define  int64  ap_int64
#        define uint64 ap_uint64
#    endif

#  else

#if defined(APINT_TYPE_PREFIX)
typedef int __attribute__ ((bitwidth(64))) APINT_TYPE_PREFIXint64;
typedef unsigned int __attribute__ ((bitwidth(64))) APINT_TYPE_PREFIXuint64;
#    define bool APINT_TYPE_PREFIXuint1
#else
typedef int __attribute__ ((bitwidth(64))) int64;
typedef unsigned int __attribute__ ((bitwidth(64))) uint64;
#    define bool uint1
#endif 
#    define true 1
#    define false 0

#  endif 


#endif /*#ifdef _cplusplus & C_TEST */

#undef _TY_CONCAT

#endif


