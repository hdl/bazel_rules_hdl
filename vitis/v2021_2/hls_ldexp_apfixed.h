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
 *     (c) Copyright 2012-2017 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
#ifndef _X_HLS_LDEXP_APFIXED_H_
#define _X_HLS_LDEXP_APFIXED_H_
#include "ap_fixed.h"

namespace hls_ldexp {

template<int W, int I>
ap_fixed<W,I> ldexp(ap_fixed<W,I> x, int exp) {
    ap_fixed<W,I> result;
    if(exp >= W || exp <= -W) {
        result = 0;
    } else {
        result = x << exp;
    }
    return result;
}

template<int W, int I>
ap_ufixed<W,I> ldexp(ap_ufixed<W,I> x, int exp) {
    ap_fixed<W+1,I+1> xf = x;
    return ldexp(xf, exp);
}

template<int I>
ap_int<I> ldexp(ap_int<I> x, int exp) {
    ap_fixed<I,I> xf = x;
    return ldexp(xf, exp);
}

template<int I>
ap_uint<I> ldexp(ap_uint<I> x, int exp) {
    ap_fixed<I+1,I+1> xf = x;
    return ldexp(xf, exp);
}

template<int W, int I>
ap_fixed<W,I> scalbn(ap_fixed<W,I> x, int n) {
    ap_fixed<W,I> result;
    if(n >= W || n <= -W) {
        result = 0;
    } else {
        result = x << n;
    }
    return result;
}

template<int W, int I>
ap_ufixed<W,I> scalbn(ap_ufixed<W,I> x, int n) {
    ap_fixed<W+1,I+1> xf = x;
    return scalbn(xf, n);
}

template<int I>
ap_int<I> scalbn(ap_int<I> x, int n) {
    ap_fixed<I,I> xf = x;
    return scalbn(xf, n);
}

template<int I>
ap_uint<I> scalbn(ap_uint<I> x, int n) {
    ap_fixed<I+1,I+1> xf = x;
    return scalbn(xf, n);
}

template<int W, int I>
ap_fixed<W,I> scalbln(ap_fixed<W,I> x, long int n) {
    ap_fixed<W,I> result;
    if(n >= W || n <= -W) {
        result = 0;
    } else {
        result = x << n;
    }
    return result;
}

template<int W, int I>
ap_ufixed<W,I> scalbln(ap_ufixed<W,I> x, long int n) {
    ap_fixed<W+1,I+1> xf = x;
    return scalbln(xf, n);
}

template<int I>
ap_int<I> scalbln(ap_int<I> x, long int n) {
    ap_fixed<I,I> xf = x;
    return scalbln(xf, n);
}

template<int I>
ap_uint<I> scalbln(ap_uint<I> x, long int n) {
    ap_fixed<I+1,I+1> xf = x;
    return scalbln(xf, n);
}

}

#endif
