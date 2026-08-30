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
#ifndef _X_HLS_SQRT_APFIXED_H_
#define _X_HLS_SQRT_APFIXED_H_
#include "ap_int.h"
#include "ap_fixed.h"

#ifndef __SYNTHESIS__
#include "assert.h"
#endif

template <int W_, int I_>
ap_fixed<W_,I_> sqrt_fixed(ap_fixed<W_,I_> x)
{
#pragma HLS pipeline

    // bitwidth that currently not supported
    const int F_ = W_ - I_;
    if (I_>34) return 0;
    else if (F_>32) return 0;

    // return ap_fixed value
    ap_ufixed<F_+(I_+1)/2,(I_+1)/2> r;
    ap_ufixed<W_-1,I_-1> x_s = x;

    if ((F_==0)&&(I_==2)) {
            r = x_s;
    } else if ((F_==0)&&(I_<=13)) {
        ap_ufixed<W_,I_> x_s_l = x_s + 1;
        ap_ufixed<W_-1,I_-1> x_s_1;
        x_s_1(W_-2,0) = x_s_l(W_-1,1);
        if (I_<=8) {
            if      (x_s_1==ap_ufixed<W_-1,I_-1>("0x0p0"))  r = 0;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x1p0"))  r = 1;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x3p0"))  r = 2;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x6p0"))  r = 3;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xap0"))  r = 4;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xfp0"))  r = 5;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x15p0")) r = 6;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x1cp0")) r = 7;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x24p0")) r = 8;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x2dp0")) r = 9;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x37p0")) r = 10;
            else                      r = 11;
        } else if (I_<=9) {
            if      (x_s_1==ap_ufixed<W_-1,I_-1>("0x0p0"))  r = 0;
            else if (x_s_1==ap_ufixed<W_-1,I_-1>("0x1p0"))  r = 1;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x3p0"))  r = 2;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x6p0"))  r = 3;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xap0"))  r = 4;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xfp0"))  r = 5;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x15p0")) r = 6;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x1cp0")) r = 7;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x24p0")) r = 8;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x2dp0")) r = 9;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x37p0")) r = 10;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x42p0")) r = 11;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x4ep0")) r = 12;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x5bp0")) r = 13;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x69p0")) r = 14;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x78p0")) r = 15;
            else                      r = 16;
        } else {
            if      (x_s_1==ap_ufixed<W_-1,I_-1>("0x0p0"))   r = 0;
            else if (x_s_1==ap_ufixed<W_-1,I_-1>("0x1p0"))   r = 1;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x3p0"))   r = 2;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x6p0"))   r = 3;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xap0"))   r = 4;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xfp0"))   r = 5;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x15p0"))  r = 6;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x1cp0"))  r = 7;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x24p0"))  r = 8;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x2dp0"))  r = 9;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x37p0"))  r = 10;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x42p0"))  r = 11;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x4ep0"))  r = 12;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x5bp0"))  r = 13;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x69p0"))  r = 14;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x78p0"))  r = 15;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x88p0"))  r = 16;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x99p0"))  r = 17;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xabp0"))  r = 18;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xbep0"))  r = 19;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xd2p0"))  r = 20;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xe7p0"))  r = 21;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0xfdp0"))  r = 22;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x114p0")) r = 23;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x12cp0")) r = 24;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x145p0")) r = 25;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x15fp0")) r = 26;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x17ap0")) r = 27;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x196p0")) r = 28;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x1b3p0")) r = 29;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x1d1p0")) r = 30;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x1f0p0")) r = 31;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x210p0")) r = 32;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x231p0")) r = 33;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x253p0")) r = 34;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x276p0")) r = 35;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x29ap0")) r = 36;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x2bfp0")) r = 37;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x2e5p0")) r = 38;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x30cp0")) r = 39;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x334p0")) r = 40;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x35dp0")) r = 41;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x387p0")) r = 42;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x3b2p0")) r = 43;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x3dep0")) r = 44;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x40bp0")) r = 45;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x439p0")) r = 46;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x468p0")) r = 47;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x498p0")) r = 48;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x4c9p0")) r = 49;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x4fbp0")) r = 50;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x52ep0")) r = 51;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x562p0")) r = 52;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x597p0")) r = 53;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x5cdp0")) r = 54;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x604p0")) r = 55;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x63cp0")) r = 56;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x675p0")) r = 57;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x6afp0")) r = 58;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x6eap0")) r = 59;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x726p0")) r = 60;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x763p0")) r = 61;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x7a1p0")) r = 62;
            else if (x_s_1<=ap_ufixed<W_-1,I_-1>("0x7e0p0")) r = 63;
            else                       r = 64;
        }
    } else if (F_<=4 && I_<=5) {
            if      (x_s==ap_ufixed<W_-1,I_-1>("0x0.0p0"))   r = "0x0.0p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.1p0"))   r = "0x0.4p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.2p0"))   r = "0x0.6p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.3p0"))   r = "0x0.7p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.4p0"))   r = "0x0.8p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.5p0"))   r = "0x0.9p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.6p0"))   r = "0x0.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x0.8p0"))   r = "0x0.bp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.9p0"))   r = "0x0.cp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x0.bp0"))   r = "0x0.dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x0.dp0"))   r = "0x0.ep0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x0.fp0"))   r = "0x0.fp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.1p0"))   r = "0x1.0p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.3p0"))   r = "0x1.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.5p0"))   r = "0x1.2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.7p0"))   r = "0x1.3p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.ap0"))   r = "0x1.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.cp0"))   r = "0x1.5p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.fp0"))   r = "0x1.6p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.2p0"))   r = "0x1.7p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.5p0"))   r = "0x1.8p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.8p0"))   r = "0x1.9p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.bp0"))   r = "0x1.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.fp0"))   r = "0x1.bp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.2p0"))   r = "0x1.cp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.6p0"))   r = "0x1.dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.ap0"))   r = "0x1.ep0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.ep0"))   r = "0x1.fp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.2p0"))   r = "0x2.0p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.6p0"))   r = "0x2.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.ap0"))   r = "0x2.2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.ep0"))   r = "0x2.3p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.3p0"))   r = "0x2.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.7p0"))   r = "0x2.5p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.cp0"))   r = "0x2.6p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.1p0"))   r = "0x2.7p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.6p0"))   r = "0x2.8p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.bp0"))   r = "0x2.9p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.0p0"))   r = "0x2.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.6p0"))   r = "0x2.bp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.bp0"))   r = "0x2.cp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.1p0"))   r = "0x2.dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.7p0"))   r = "0x2.ep0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.dp0"))   r = "0x2.fp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.3p0"))   r = "0x3.0p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.9p0"))   r = "0x3.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.fp0"))   r = "0x3.2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xa.5p0"))   r = "0x3.3p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xa.cp0"))   r = "0x3.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xb.2p0"))   r = "0x3.5p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xb.9p0"))   r = "0x3.6p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc.0p0"))   r = "0x3.7p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc.7p0"))   r = "0x3.8p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc.ep0"))   r = "0x3.9p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xd.5p0"))   r = "0x3.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xd.dp0"))   r = "0x3.bp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xe.4p0"))   r = "0x3.cp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xe.cp0"))   r = "0x3.dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf.4p0"))   r = "0x3.ep0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf.cp0"))   r = "0x3.fp0";
            else                       r = "0x4.0p0";
    } else {

        if (x[W_-1]) return 0;
        if (I_<=0) {
            const static int lsbx = (-I_+2<=W_) ? (W_+I_-2) : 0;
            if ( x(W_-1,lsbx) != 0 ) return 0;
        }

        const static int prcs = (F_+1)*2; // max precision
        const static int msbr = (I_>0) ? (I_+1)/2 : 1; // msb of result
        const static int msbx = (I_>0) ?  I_+3    : 4;
        const static int msbm = (I_>0) ?  I_+1    : 2;

//        ap_ufixed<I_+3 + prcs  ,    I_+3> x_l    = x;
        ap_ufixed<msbx         ,    msbx> x_l_I  = x;
        ap_ufixed<       prcs/2,       0> x_l_FH = x;
        ap_ufixed<       prcs/2, -prcs/2> x_l_FL = 0;
        ap_ufixed<msbr + prcs  ,    msbr> res    = 0; // result to return
        ap_ufixed<msbr         ,    msbr> res_I  = 0;
        ap_ufixed<       prcs/2,       0> res_FH = 0;
        //ap_ufixed<       prcs/2, -prcs/2> res_FL = 0;

//        #pragma unroll
//        // each iteration calculate 1 bit of result, starting from MSB
//        // bit is used to store the current bit under calculation
//        // if accepted bit will be added to result
//        for ( int pos = msbr-1; pos >= -F_-1; pos-- ) {
//            ap_ufixed<I_+1 + prcs, I_+1> mul = 0; // 2 * res * bit + bit^2
//            assert ( res(pos+prcs,0)==0 );
//            mul ( msbr+pos + prcs , pos*2+1 + prcs ) = res ( msbr-1 + prcs , pos + prcs );
//            assert ( !mul[I_-1+prcs] );
//            mul [ pos*2 + prcs ] = 1;
//
//
//            assert ( x_l(I_+2+prcs,msbr+pos+2+prcs)==0 );
//            if ( x_l ( msbr+pos + prcs , pos*2 + prcs ) >= mul ( msbr+pos + prcs , pos*2 + prcs ) ) {
//                assert ( x_l >= mul );
//                ap_ufixed<I_ + prcs, I_> x_l_ = x_l; // just for assert
//                x_l ( msbr+pos + prcs , pos*2 + prcs ) = x_l ( msbr+pos + prcs , pos*2 + prcs ) - mul ( msbr+pos + prcs , pos*2 + prcs );
//                assert ( x_l == x_l_ - mul );
//
//                res [ pos + prcs ] = 1;
//            }
//        }
    if (I_>0)
        #pragma unroll
        for ( int pos = msbr-1; pos >= 0; pos-- ) {
            ap_ufixed<msbm         ,    msbm> mul_I  = 0;
#ifndef __SYNTHESIS__
            assert ( res_I(pos,0)==0 );
#endif
            mul_I ( msbr+pos , pos*2+1 ) = res_I ( msbr-1 , pos );
#ifndef __SYNTHESIS__
            assert ( !mul_I[I_-1] );
#endif
            mul_I [ pos*2 ] = 1;

#ifndef __SYNTHESIS__
            assert ( x_l_I(I_+2,msbr+pos+2)==0 );
#endif
            if ( x_l_I ( msbr+pos+1 , pos*2 ) >= mul_I ( msbr+pos , pos*2 ) ) {
#ifndef __SYNTHESIS__
                assert ( x_l_I >= mul_I );
#endif
                ap_ufixed<msbx,msbx> x_l_I_ = x_l_I;
                x_l_I ( msbr+pos+1 , pos*2 ) = x_l_I ( msbr+pos+1 , pos*2 ) - mul_I ( msbr+pos , pos*2 );
#ifndef __SYNTHESIS__
                assert ( x_l_I == x_l_I_ - mul_I );
#endif

                res_I [ pos ] = 1;
            }
        }
        #pragma unroll
        for ( int pos = -1; pos >= -F_-1; pos-- ) {
            ap_ufixed<msbm + prcs  ,    msbm> mul    = 0;
#ifndef __SYNTHESIS__
            assert ( res_FH(pos+prcs/2,0)==0 );
#endif
            //assert ( res_FL              ==0 );
            mul ( msbr+pos + prcs , pos  +1 + prcs ) = res_I  ( msbr-1    ,          0 );
            mul (      pos + prcs , pos*2+1 + prcs ) = res_FH ( -1+prcs/2 , pos+prcs/2 );
#ifndef __SYNTHESIS__
            assert ( !mul[I_-1+prcs] );
#endif
            mul [ pos*2 + prcs ] = 1;
            ap_ufixed<msbm         ,    msbm> mul_I  = mul;
            ap_ufixed<       prcs/2,       0> mul_FH = mul;
            ap_ufixed<       prcs/2, -prcs/2> mul_FL = mul;

            ap_ufixed<msbx + prcs  ,    msbx> x_l;
            x_l ( -1+msbx + prcs   , prcs   ) = x_l_I  ( -1+msbx   , 0 );
            x_l (      -1 + prcs   , prcs/2 ) = x_l_FH ( -1+prcs/2 , 0 );
            x_l (      -1 + prcs/2 , 0      ) = x_l_FL ( -1+prcs/2 , 0 );
#ifndef __SYNTHESIS__
            assert ( x_l(I_+2+prcs,msbr+pos+2+prcs)==0 );
#endif
            if ( (x_l_I>mul_I) || ((x_l_I==mul_I)&&(x_l_FH>mul_FH)) || ((x_l_I==mul_I)&&(x_l_FH==mul_FH)&&(x_l_FL>=mul_FL)) ) {
#ifndef __SYNTHESIS__
                assert ( x_l >= mul );
#endif

                ap_ufixed< prcs/2+1 , -prcs/2+1 > x_l_FL_l         = x_l_FL;
                if ( x_l_FL < mul_FL )            x_l_FL_l[prcs/2] = 1;
                                                  x_l_FL_l        -= mul_FL;
#ifndef __SYNTHESIS__
                assert ( !x_l_FL_l[prcs/2] );
#endif

                ap_ufixed< prcs/2+1 ,         1 >                            x_l_FH_l         = x_l_FH;
                if ( (x_l_FH<mul_FH)||((x_l_FH==mul_FH)&&(x_l_FL<mul_FL)) )  x_l_FH_l[prcs/2] = 1;
                ap_ufixed<        1 , -prcs/2+1 >                            delta            = 0;
                if ( x_l_FL < mul_FL )                                       delta[0]         = 1;
                                                                             x_l_FH_l        -= delta;
                                                                             x_l_FH_l        -= mul_FH;
#ifndef __SYNTHESIS__
                assert ( !x_l_FH_l[prcs/2] );
#endif
                if ( (x_l_FH<mul_FH)||((x_l_FH==mul_FH)&&(x_l_FL<mul_FL)) )  x_l_I           --;
                                                                             x_l_I           -= mul_I;

                                                                             x_l_FH           = x_l_FH_l;
                                                                             x_l_FL           = x_l_FL_l;

                ap_ufixed<msbx + prcs  ,    msbx> x_l_ = x_l;
                x_l ( -1+msbx + prcs   , prcs   ) = x_l_I  ( -1+msbx   , 0 );
                x_l (      -1 + prcs   , prcs/2 ) = x_l_FH ( -1+prcs/2 , 0 );
                x_l (      -1 + prcs/2 , 0      ) = x_l_FL ( -1+prcs/2 , 0 );
#ifndef __SYNTHESIS__
                assert ( x_l == x_l_ - mul );
#endif
                res_FH [ pos+prcs/2 ] = 1;
            }
        }

//        r = res + ( delta >> F_ );

        ap_ufixed< prcs/2+1 , 1 > res_FH_l            = res_FH;
        ap_ufixed< prcs/2   , 0 > delta;
                                  delta[delta.wl()-1] = 1;
                                  res_FH_l           += ( delta >> F_ );
                                  res_FH              = res_FH_l;
        if (res_FH_l[prcs/2])     res_I              ++;

        res ( msbr-1 + prcs , prcs   ) = res_I  (    msbr-1 , 0 );
        res (     -1 + prcs , prcs/2 ) = res_FH ( -1+prcs/2 , 0 );

        r = res;
    }

    return r;
}
template<int W_, int I_>
ap_ufixed<W_,I_> sqrt_fixed(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xf = x;
    return sqrt_fixed(xf);
}
template<int I_>
ap_int<I_> sqrt_fixed(ap_int<I_> x) {
    ap_fixed<I_,I_> xf = x;
    return sqrt_fixed(xf);
}
template<int I_>
ap_uint<I_> sqrt_fixed(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xf = x;
    return sqrt_fixed(xf);
}


template <int W_, int I_>
ap_fixed<W_,I_> rsqrt_fixed(ap_fixed<W_,I_> x)
{
#pragma HLS pipeline
    ap_ufixed<W_-1,I_-1> xs = x;
    const int Ix = ( I_ > 1 )?  I_-1 : 1;
    ap_ufixed<Ix,Ix> xs_I = xs;
    ap_ufixed<W_-1,I_-1> r;
    const int I = ( I_-1 > W_-I_+1 ) ? I_-1 : W_-I_+1;
    ap_ufixed<I+W_-I_,I> y1;
    ap_ufixed<I+W_-I_,I> y2;
    if ( xs == 0 ) {
        return 0;
    } else if ( xs_I != 0 ) {
        y1 = xs;
    } else {
        y1 = 1;
        y1 = y1/xs;
    }
    y2 = sqrt_fixed(y1);
    if ( y2 == 0 ) {
        return 0;
    } else if ( xs_I != 0 ) {
        r = 1;
        r = r/y2;
    } else {
        r = y2;
    }
    return r;
}
template<int W_, int I_>
ap_ufixed<W_,I_> rsqrt_fixed(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xf = x;
    return rsqrt_fixed(xf);
}
template<int I_>
ap_int<I_> rsqrt_fixed(ap_int<I_> x) {
    ap_fixed<I_,I_> xf = x;
    return rsqrt_fixed(xf);
}
template<int I_>
ap_uint<I_> rsqrt_fixed(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xf = x;
    return rsqrt_fixed(xf);
}


template<int W_, int I_>
ap_fixed<W_,I_> recip_fixed(ap_fixed<W_,I_> x)
{
#pragma HLS pipeline
    if ( x == 0 ) return 0;
    ap_fixed<W_,I_> r = 1;
    return r/x;
}
template<int W_, int I_>
ap_ufixed<W_,I_> recip_fixed(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xf = x;
    return recip_fixed(xf);
}
template<int I_>
ap_int<I_> recip_fixed(ap_int<I_> x) {
    ap_fixed<I_,I_> xf = x;
    return recip_fixed(xf);
}
template<int I_>
ap_uint<I_> recip_fixed(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xf = x;
    return recip_fixed(xf);
}

#endif
