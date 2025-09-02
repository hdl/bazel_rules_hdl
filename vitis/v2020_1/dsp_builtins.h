// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
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
 *
 */

#ifndef X_DSP_BUILTINS_H
#define X_DSP_BUILTINS_H
#include <stdint.h>

#ifdef __cplusplus
#include "ap_int.h"
typedef ap_int<1> __dsp1_t;
typedef ap_int<6> __dsp6_t;
typedef ap_int<17> __dsp17_t;
typedef ap_int<18> __dsp18_t;
typedef ap_int<25> __dsp25_t;
typedef ap_int<27> __dsp27_t;
typedef ap_int<30> __dsp30_t;
typedef ap_int<48> __dsp48_t;
#else
#include "ap_cint.h"
typedef int1 __dsp1_t;
typedef int6 __dsp6_t;
typedef int17 __dsp17_t;
typedef int18 __dsp18_t;
typedef int25 __dsp25_t;
typedef int27 __dsp27_t;
typedef int30 __dsp30_t;
typedef int48 __dsp48_t;
#endif

#include "etc/dsp_dp_builtins.h"
#include "etc/dsp48_builtins.h"

#endif



