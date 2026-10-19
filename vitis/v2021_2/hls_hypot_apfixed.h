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
 *     (c) Copyright 2008-2017 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
/**
  * @file hls_hypot_apfixed.h"
  * @brief Implemenation of hypot for ap_fixed data type. 
  */ 
#ifndef _X_HLS_HYPOT_FIXED_H_
#define _X_HLS_HYPOT_FIXED_H_
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_round_copysign_apfixed.h"
namespace hypot_internal {
template<int W, int I>
ap_fixed<W, I> hypot_fixed(ap_fixed<W, I> x, ap_fixed<W, I> y) {
    const static int F = W - I;
    if(I > 33) return 0;
    else if(F > 32) return 0;

#ifndef __SYNTHESIS__
#ifdef HLS_DEBUG
    std::cout<<"W="<<W<<", I="<<I<<std::endl;
    std::cout<<"(x)="<<x.to_string()<<std::endl;
    std::cout<<"(y)="<<y.to_string()<<std::endl;
#endif
#endif
    if(x==0) return fabs_fixed(y); 
    if(y==0) return fabs_fixed(x); 

    ap_ufixed<2*W, I*2> x_sq = x * x;//square of x
    ap_ufixed<2*W, I*2> y_sq = y * y;// square of y
    ap_ufixed<2*W, I*2> xy_sq = x_sq + y_sq;
#ifndef __SYNTHESIS__
#ifdef HLS_DEBUG
    std::cout<<"square(x)="<<x_sq.to_string()<<std::endl;
    std::cout<<"square(y)="<<y_sq.to_string()<<std::endl;
    std::cout<<"square(x) + square(y) ="<<xy_sq.to_string()<<std::endl;
#endif
#endif
    //the following is optimized sqrt function.
    const static int prcs = (F+1)*2;
    const static int msbr = I > 0? I : 1;
    ap_ufixed<msbr, msbr> res_I = 0;
    ap_ufixed<2*msbr+1,2*msbr+1> x_l_I = 0;
    if(I>0) {
        x_l_I = xy_sq(2*W-1, 2*W-2*I);
        for(int pos = msbr - 1; pos >= 0; pos--) {
            ap_ufixed<2*msbr,2*msbr> mul_I = 0;
#ifndef __SYNTHESIS__
            assert(res_I(pos, 0)==0);
#endif
            mul_I(msbr+pos, 2*pos+1) = res_I(msbr-1, pos);
            mul_I[2*pos] = 1;
            if(x_l_I(msbr+pos+1, 2*pos) >= mul_I(msbr+pos, 2*pos)){
#ifndef __SYNTHESIS__
                assert(x_l_I >= mul_I);
#endif
                ap_ufixed<2*msbr+1, 2*msbr+1> x_l_I_ = x_l_I;
                x_l_I(msbr+pos+1, 2*pos) = x_l_I(msbr+pos+1,2*pos) - mul_I(msbr+pos, 2*pos);
#ifndef __SYNTHESIS__
                assert(x_l_I == x_l_I_ - mul_I);
#endif
                res_I[pos] = 1;
           }
       } 
    }
    ap_ufixed<msbr+1, msbr+1> x_l_I_s = x_l_I;
#ifndef __SYNTHESIS__
    assert(x_l_I_s == x_l_I);
#ifdef HLS_DEBUG
    std::cout<<"res_I="<<res_I.to_string()<<std::endl;
    std::cout<<"x_l_I  ="<<x_l_I.to_string()<<std::endl;
    std::cout<<"x_l_I_s="<<x_l_I_s.to_string()<<std::endl;
#endif
#endif
    ap_ufixed<prcs/2,0> res_F = 0; 
    ap_ufixed<prcs/2,0>        x_l_FH = xy_sq;
    ap_ufixed<prcs/2, -prcs/2> x_l_FL = xy_sq;
    for(int pos = -1; pos >= -F-1; pos--) {
        ap_ufixed<msbr+prcs, msbr> mul = 0;
#ifndef __SYNTHESIS__
        assert(res_F(pos+prcs/2,0)==0);
#endif
        mul(msbr+pos+prcs, pos+1+prcs)     = res_I(msbr-1, 0);
        mul(pos+prcs,      2*pos+1+prcs)   = res_F(prcs/2-1,pos+prcs/2);
        mul[2*pos+prcs] = 1;

        ap_ufixed<msbr,      msbr>      mul_I  = 0;
        mul_I = mul;
        ap_ufixed<prcs/2,       0>      mul_FH = mul;
        ap_ufixed<prcs/2, -prcs/2>      mul_FL = mul;

#ifndef __SYNTHESIS__
#ifdef HLS_DEGUG
           std::cout<<"res_I="<<res_I.to_string()<<std::endl;
           std::cout<<"res_F="<<res_F.to_string()<<std::endl;
           std::cout<<"mul="<<mul.to_string()<<std::endl;
           std::cout<<"pos="<<pos<<std::endl;
           std::cout<<"x_l_I_s="<<x_l_I_s.to_string()<<std::endl;
           std::cout<<"x_l_FH="<<x_l_FH.to_string()<<std::endl;
           std::cout<<"x_l_FL="<<x_l_FL.to_string()<<std::endl;
           std::cout<<"mul_I="<<mul_I.to_string()<<std::endl;
           std::cout<<"mul_FH="<<mul_FH.to_string()<<std::endl;
           std::cout<<"mul_FL="<<mul_FL.to_string()<<std::endl;
#endif
        ap_ufixed<msbr+prcs+1, msbr+1> x_l_1 = 0;
        x_l_1(prcs+msbr,   prcs)   = x_l_I_s (msbr,        0);
        x_l_1(prcs-1,      prcs/2) = x_l_FH(prcs/2-1,      0);
        x_l_1(prcs/2-1,    0     ) = x_l_FL(prcs/2-1,      0);
#endif
        if((x_l_I_s > mul_I) || ((x_l_I_s == mul_I) && (x_l_FH > mul_FH)) || ((x_l_I_s == mul_I) && (x_l_FH == mul_FH) && (x_l_FL >= mul_FL))) {
#ifndef __SYNTHESIS__
#ifdef HLS_DEGUG
           std::cout<<"x_l_1="<<x_l_1.to_string()<<std::endl;
           std::cout<<"mul="<<mul.to_string()<<std::endl;
#endif
           assert(x_l_1 >= mul);
#endif
           ap_ufixed<prcs/2+1, -prcs/2+1> x_l_FL_1 = x_l_FL;
           //carry bit 
           if(x_l_FL < mul_FL)            x_l_FL_1[prcs/2] = 1;
           x_l_FL_1 -= mul_FL;
#ifndef __SYNTHESIS__
           assert(!x_l_FL_1[prcs/2]);
#endif
           ap_ufixed<prcs/2+1,1> x_l_FH_1 = x_l_FH;
           //carry bit
           if((x_l_FH < mul_FH) || ((x_l_FH == mul_FH) && (x_l_FL < mul_FL))) x_l_FH_1[prcs/2] = 1;
           ap_ufixed<1, -prcs/2+1>   delta = 0;
           if(x_l_FL < mul_FL)       delta[0] = 1;
           //subtract carry bit
           x_l_FH_1 -= delta;
           x_l_FH_1 -= mul_FH;
           //subtract carry bit 
           if((x_l_FH < mul_FH) || ((x_l_FH == mul_FH) && (x_l_FL < mul_FL))) x_l_I_s--;
           x_l_I_s -= mul_I;
           x_l_FH = x_l_FH_1;
           x_l_FL = x_l_FL_1;
#ifndef __SYNTHESIS__
           ap_ufixed<msbr+prcs+1, msbr+1> x_l_2 = 0;
           x_l_2(msbr+prcs,   prcs)  = x_l_I_s(msbr,    0);
           x_l_2(prcs-1,      prcs/2)= x_l_FH(prcs/2-1, 0);
           x_l_2(prcs/2-1,    0)     = x_l_FL(prcs/2-1, 0);
           assert(x_l_2 == x_l_1 - mul);
#endif
           res_F[pos+prcs/2] = 1;
       }
    }
    ap_ufixed<prcs/2+1, 1> res_F_1 = res_F;
    //rounding the result
    ap_ufixed<1,  -prcs/2+1> delta = 0;
    delta[0] = 1;
    res_F_1  += delta;
    if(res_F_1[prcs/2]) res_I++;
    ap_ufixed<msbr+prcs/2, msbr> res = 0;
    res(msbr+prcs/2-1, prcs/2) = res_I(msbr-1,0);   
    res(prcs/2-1,      0)      = res_F(prcs/2-1, 0);
#ifndef __SYNTHESIS__
#ifdef HLS_DEBUG
    std::cout<<"res="<<res.to_string()<<std::endl;
#endif
#endif
    //overflow
    ap_fixed<W,I> r = 0;
    if(res[msbr+prcs/2-1]) {
       //return max 
       for(int i = 0; i < W - 1; ++i) {
       #pragma HLS unroll
            r[i] = 1;
       } 
    } else {
       r  = res;
    }
#ifndef __SYNTHESIS__
#ifdef HLS_DEBUG
    std::cout<<"r="<<r.to_string()<<std::endl;
#endif
#endif
    return r;
}
template<int W, int I>
ap_ufixed<W, I> hypot_fixed(ap_ufixed<W, I> x, ap_fixed<W, I> y) {
   ap_fixed<W+1, I+1> xi = x;
   ap_fixed<W+1, I+1> yi = y;
   return hypot_fixed(xi, yi);
}
template<int I>
ap_int<I> hypot_fixed(ap_int<I> x, ap_int<I> y) {
   ap_fixed<I, I> xi = x;
   ap_fixed<I, I> yi = y;
   return hypot_fixed(xi, yi);
}
template<int I>
ap_uint<I> hypot_fixed(ap_uint<I> x, ap_uint<I> y) {
   ap_fixed<I+1, I+1> xi = x;
   ap_fixed<I+1, I+1> yi = y;
   return hypot_fixed(xi, yi);
}
}
#endif




