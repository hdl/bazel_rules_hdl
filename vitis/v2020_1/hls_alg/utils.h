// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
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
 *     (c) Copyright 2018 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

/**
 * @file utils.h
 * @brief This file is part of HLS Algorithm Library, contains utilities.
 */

#ifndef _X_HLS_ALG_UTILS_H_
#define _X_HLS_ALG_UTILS_H_

#if __cplusplus >= 201103L
#define HLS_ALG_STATIC_ASSERT(b, m) static_assert((b), m)
#else
#define HLS_ALG_STATIC_ASSERT(b, m) ((void)0)
#endif

#ifndef __SYNTHESIS__
// for assert function.
#include <cassert>
#define HLS_ALG_ASSERT(b) assert((b))
#else
#define HLS_ALG_ASSERT(b) ((void)0)
#endif

#endif // _X_HLS_ALG_UTILS_H_

#define HLS_ALG_MACRO_QUOTE(s) #s
#define HLS_ALG_MACRO_STR(s) HLS_ALG_MACRO_QUOTE(s)

// -*- cpp -*-
// vim: ts=8:sw=2:sts=2:ft=cpp


