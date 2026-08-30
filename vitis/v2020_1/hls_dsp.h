/*****************************************************************************
 *
 *     Author: Xilinx, Inc.
 *
 *     This text contains proprietary, confidential information of
 *     Xilinx, Inc. , is distributed by under license from Xilinx,
 *     Inc., and may be used, copied and/or disclosed only pursuant to
 *     the terms of a valid license agreement with Xilinx, Inc.
 *
 *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
 *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
 *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
 *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
 *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
 *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
 *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
 *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
 *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
 *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
 *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
 *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *     FOR A PARTICULAR PURPOSE.
 *
 *     Xilinx products are not intended for use in life support appliances,
 *     devices, or systems. Use in such applications is expressly prohibited.
 *
 *     (c) Copyright 2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

/*
 * HLS DSP Library Header File
 */

#ifndef HLS_DSP_H
#define HLS_DSP_H

#ifndef __cplusplus
#error C++ is required to include this header file
#endif

#include "hls/dsp/utils/hls_dsp_common_utils.h"
#include "hls/dsp/utils/hls_cordic_functions.h"
#include "hls/dsp/utils/hls_cordic.h"
#include "hls/dsp/hls_atan2_cordic.h"
#include "hls/dsp/hls_awgn.h"
#include "hls/dsp/hls_convolution_encoder.h"
#include "hls/dsp/hls_cmpy.h"
#include "hls/dsp/hls_nco.h"
#include "hls/dsp/hls_qam_demod.h"
#include "hls/dsp/hls_qam_mod.h"
#include "hls/dsp/hls_sqrt_cordic.h"
#include "hls/dsp/hls_viterbi_decoder.h"

#endif


