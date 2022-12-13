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
 * @file hls_frexp_ap_fixed.h
 * @brief implement frexp function for ap_fixed data type.
 */
#ifndef _X_HLS_FREXP_APFIXED_H_
#define _X_HLS_FREXP_APFIXED_H_
#include "ap_fixed.h"
#include "hls_round_copysign_apfixed.h" 
namespace frexp_internal {

template<int W, int I> 
ap_fixed<W,I> frexp(ap_fixed<W,I>   x,
                    ap_fixed<W,I>*  exp){
    if(I<0) {
           *exp = 0;
           return x;
    } 
    static const int F = W - I;
    static const int we = W > 5 ? W/2 : 3;//width of exp, should be log2(W) + 1;

    ap_int<we> e = 0;
    ap_ufixed<W, I> r_p = 0;

    ap_fixed<W+1, I+1> xi = x;
    ap_ufixed<W, I> x_p = fabs_fixed(xi);

    static const ap_uint<3> clz_table_6bit[64] = {7, 6, 5, 5, 4, 4, 4, 4,
                                                  3, 3, 3, 3, 3, 3, 3, 3,
                                                  2, 2, 2, 2, 2, 2, 2, 2,
                                                  2, 2, 2, 2, 2, 2, 2, 2,
                                                  1, 1, 1, 1, 1, 1, 1, 1,
                                                  1, 1, 1, 1, 1, 1, 1, 1,
                                                  1, 1, 1, 1, 1, 1, 1, 1,
                                                  1, 1, 1, 1, 1, 1, 1, 1};
    int  pos = 0;//should be log(mqx(I,F));
    //use clz_table to reduce the loop_tripcount
    static const int loop_nm = W > 6 ? (W + 5)/6 : 1;
    CLZ_LOOP:
    for(int l = loop_nm; l > 0; --l){
    #pragma HLS pipeline II=1
       ap_uint<6> t = 0;
       if(l*6 > W) t = x_p(W - 1, (l - 1) * 6);
       else t = x_p(l * 6 - 1, (l - 1) * 6);
       if((t & 0x3f) != 0) {
          pos = l * 6 - clz_table_6bit[t];
          break;
       }
    }
    if(pos >= 0) {
        e = pos + 1 - F;
        if(F > 0) {
           ap_uint<we> w_f = (pos + 1) < F ? (pos + 1) : F; 
           r_p(F - 1,F - w_f) = x_p(pos, pos + 1 - w_f);
        }
    } else {
        e = 0;
        r_p = 0;
    }
    ap_fixed<W, I> r = 0;
    if(xi[W-1]) r = -r_p; 
    else r = r_p;
    #ifndef __SYNTHESIS__
    assert(r > -1 && r < 1);
    #endif
    *exp = e;
    return r;
}
template<int W, int I>
ap_ufixed<W,I> frexp(ap_ufixed<W,I>  x,
                     ap_ufixed<W,I>* exp){
    ap_fixed<W+1, I+1> xe = x;
    ap_fixed<W+1, I+1> ee = 0;
    ap_fixed<W+1, I+1> r = frexp(xe,&ee);
    *exp = ee;
    return r;
}
template<int I>
ap_uint<I> frexp(ap_uint<I>  x,
                 ap_uint<I>* exp) {
   ap_fixed<I, I> xe = x;
   ap_fixed<I, I> ee = 0;
   ap_fixed<I, I> r = frexp(xe,&ee);
   *exp = ee;
   return r;
}
template<int I>
ap_int<I> frexp(ap_int<I>   x,
                ap_int<I>* exp) {
   ap_fixed<I+1, I+1> xe = x;
   ap_fixed<I+1, I+1> ee = 0;
   ap_fixed<I+1, I+1> r = frexp(xe,&ee);
   *exp = ee;
   return r;
}
}
#endif//define _X_HLS_FREXP_APFIXED_H_


