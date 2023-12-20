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
 *     (c) Copyright 2012-2013 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

/*
 * HLS AXI I/O Function Header File
 */

#ifndef ___HLS__AXI_IO__
#define ___HLS__AXI_IO__

#include "ap_axi_sdata.h"
#include "utils/x_hls_utils.h"
#include <assert.h>

namespace hls {

template<int W, typename T>
void AXIGetBitFields(ap_uint<W> pix, int start, int w, T& val) {
#pragma HLS inline
    assert(start >= 0 && start+w <= W);
    val = (T)pix(start+w-1, start);
}

template<int W>
void AXIGetBitFields(ap_uint<W> pix, int start, int w, float& val) {
#pragma HLS inline
    assert(w == 32 && start >= 0 && start+w <= W);
    fp_struct<float> temp((ap_uint<32>)pix(start+w-1, start));
    val =  temp.to_float();
}

template<int W>
void AXIGetBitFields(ap_uint<W> pix, int start, int w, double& val) {
#pragma HLS inline
    assert(w == 64 && start >= 0 && start+w <= W);
    fp_struct<double> temp((ap_uint<64>)pix(start+w-1, start));
    val = temp.to_double();
}

template<int W, typename T>
void AXIGetBitFields(ap_axiu<W,1,1,1> axi, int start, int w, T& val) {
#pragma HLS inline
    AXIGetBitFields(axi.data, start, w, val);
}

template<int W, typename T>
void AXISetBitFields(ap_uint<W>& pix, int start, int w, T val) {
#pragma HLS inline
    assert(start >= 0 && start+w <= W);
    pix(start+w-1, start) = val;
}

template<int W>
void AXISetBitFields(ap_uint<W>& pix, int start, int w, float val) {
#pragma HLS inline
    assert(w == 32 && start >= 0 && start+w <= W);
    fp_struct<float> temp(val);
    pix(start+w-1, start) = temp.data();
}

template<int W>
void AXISetBitFields(ap_uint<W>& pix, int start, int w, double val) {
#pragma HLS inline
    assert(w == 64 && start >= 0 && start+w <= W);
    fp_struct<double> temp(val);
    pix(start+w-1, start) = temp.data();
}

template<int W, typename T>
void AXISetBitFields(ap_axiu<W,1,1,1>& axi, int start, int w, T val) {
#pragma HLS inline
    AXISetBitFields(axi.data, start, w, val);
}

} // namespace hls

#endif


