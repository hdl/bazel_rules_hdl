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
 *     (c) Copyright 2011-2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

/*
 * HLS Linear Algebra Library Header File
 */

#ifndef HLS_LINEAR_ALGEBRA_H
#define HLS_LINEAR_ALGEBRA_H

#ifndef __cplusplus
#error C++ is required to include this header file
#endif
// support std::complex 
#include "hls/linear_algebra/hls_matrix_multiply.h"
#include "hls/linear_algebra/hls_cholesky.h"
#include "hls/linear_algebra/hls_qrf.h"
#include "hls/linear_algebra/hls_back_substitute.h"
#include "hls/linear_algebra/hls_qr_inverse.h"
#include "hls/linear_algebra/hls_cholesky_inverse.h"
#include "hls/linear_algebra/hls_svd.h"

// support x_complex but will be derecated
#include "hls/linear_algebra/deprecated/x_complex_matrix_multiply.h"
#include "hls/linear_algebra/deprecated/x_complex_cholesky.h"
#include "hls/linear_algebra/deprecated/x_complex_qrf.h"
#include "hls/linear_algebra/deprecated/x_complex_back_substitute.h"
#include "hls/linear_algebra/deprecated/x_complex_qr_inverse.h"
#include "hls/linear_algebra/deprecated/x_complex_cholesky_inverse.h"
#include "hls/linear_algebra/deprecated/x_complex_svd.h"

#endif


