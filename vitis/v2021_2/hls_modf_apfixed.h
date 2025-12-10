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
 * @file hls_modf_ap_fixed.h
 * @brief implement modf function for ap_fixed data type.
 */
#ifndef _X_HLS_MODF_APFIXED_H_
#define _X_HLS_MODF_APFIXED_H_
#include "hls_round_copysign_apfixed.h"
namespace modf_internal {
template<int W, int I>
ap_fixed<W,I> modf(ap_fixed<W, I>  x,
                   ap_fixed<W, I>* int_part){
    ap_fixed<W, I> frac_part = 0;
    if(W == I) {
        *int_part = x;
        frac_part = 0;
    } else if(I > 0) {
        ap_fixed<W+1, I+1> xi = x;
        ap_ufixed<W, I> x_p = fabs_fixed(xi);
        frac_part(W - I - 1,0) = x_p(W - I - 1,0);
        if(xi[W-1]) frac_part = - frac_part;
        *int_part = x_p(W-1, W-I);
        if(xi[W-1]) *int_part = -*int_part;
    } else {
       *int_part = 0;
       frac_part = x;
    }
    return frac_part;
}
template<int W, int I>
ap_ufixed<W,I> modf(ap_ufixed<W, I>  x,
                    ap_ufixed<W, I>* int_part){
    ap_fixed<W+1, I+1> xi = x;
    ap_fixed<W+1, I+1> ii = 0; 
    ap_fixed<W+1, I+1> r = modf(xi, &ii);
    *int_part = ii;
    return r;
} 
template<int I>
ap_int<I> modf(ap_int<I>  x,
               ap_int<I>* int_part){
    *int_part = x;
    return 0;
} 
template<int I>
ap_uint<I> modf(ap_uint<I>  x,
                ap_uint<I>* int_part){
    *int_part = x;
    return 0;
} 
}
#endif//ifndef _X_HLS_MODF_APFIXED_H_


