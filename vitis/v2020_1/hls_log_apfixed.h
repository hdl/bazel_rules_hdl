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
#ifndef _X_HLS_LOG_APFIXED_H_
#define _X_HLS_LOG_APFIXED_H_
#include "ap_fixed.h"
#ifndef __SYNTHESIS__
#include <assert.h>
#endif

namespace log_apfixed_reduce {

//#include "hls_log_apfixed_tables.h"
template <typename T, int p, int alpha, int size> class log_lut_table { public:
log_lut_table<T,p,alpha,size>();
static const T array [size];};
template <> class log_lut_table<ap_fixed<29, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16> { public:
log_lut_table<ap_fixed<29, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16>();
static const ap_fixed<29, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [16];};
template <> class log_lut_table<ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16> { public:
log_lut_table<ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16>();
static const ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [16];};
template <> class log_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16> { public:
log_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16>();
static const ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [16];};
template <> class log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16> { public:
log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16>();
static const ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [16];};
template <> class log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16> { public:
log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16>();
static const ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [16];};
template <> class log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16> { public:
log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16>();
static const ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [16];};
template <> class log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16> { public:
log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,4,4,16>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [16];};

template <> class log_lut_table<ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64> { public:
log_lut_table<ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64>();
static const ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64> { public:
log_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64>();
static const ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64> { public:
log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64>();
static const ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64> { public:
log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64>();
static const ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64> { public:
log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64>();
static const ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64> { public:
log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,7,6,64>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64> { public:
log_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64>();
static const ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64> { public:
log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64>();
static const ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64> { public:
log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64>();
static const ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64> { public:
log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64>();
static const ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64> { public:
log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,12,6,64>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};

template <> class log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64> { public:
log_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64>();
static const ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64> { public:
log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64>();
static const ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64> { public:
log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64>();
static const ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64> { public:
log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,17,6,64>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};

template <> class log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,22,6,64> { public:
log_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,22,6,64>();
static const ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,22,6,64> { public:
log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,22,6,64>();
static const ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,22,6,64> { public:
log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,22,6,64>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};

template <> class log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,27,6,64> { public:
log_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,27,6,64>();
static const ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,27,6,64> { public:
log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,27,6,64>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};

template <> class log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,32,6,64> { public:
log_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,32,6,64>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};

template <typename T, int p, int alpha, int size> class log0_lut_table { public:
log0_lut_table<T,p,alpha,size>();
static const T array[size];};
template <> class log0_lut_table<ap_fixed<20, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<20, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();

static const ap_fixed<20, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log0_lut_table<ap_fixed<29, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<29, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();
static const ap_fixed<29, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log0_lut_table<ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();
static const ap_fixed<44, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log0_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();
static const ap_fixed<59, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log0_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();
static const ap_fixed<74, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log0_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();
static const ap_fixed<89, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log0_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();
static const ap_fixed<104, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};
template <> class log0_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64> { public:
log0_lut_table<ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0>,0,5,64>();
static const ap_fixed<119, 7, (ap_q_mode)5, (ap_o_mode)3, 0> array [64];};

class log_inverse_lut_table { public:
log_inverse_lut_table();
static const ap_ufixed<6, 1, (ap_q_mode)5, (ap_o_mode)3, 0> array[64];};


template <typename LOG_TYPE, int p, int alpha, int size, int sizeout>
void range_reduce(ap_ufixed<size, -p> zN, LOG_TYPE &log, ap_ufixed<sizeout, -(p+alpha-1)> &zN1)
{
    //#pragma HLS inline off
    const int T1size = 1 << alpha; // The size of the first table
#define log_lut log_lut_table<LOG_TYPE, p,alpha,T1size>::array

    //#pragma HLS RESOURCE variable=log_lut core=ROM_1P_LUTRAM

    ap_ufixed<alpha,            -p> a = zN; // Extract alpha MSBs from z1.
    ap_ufixed<size-alpha, -p-alpha> b = zN; // Extract the LSBs from z1.
    ap_ufixed<size+p+2*p+1, 1>      zNext = 1+zN; // Extend z1 for shift
    int e_shift = (p!=4 || a[a.wl()-1]==1) ? 2*p : 2*p+1; // Stage dependent?
    ap_ufixed<size+p+1, 1-2*p>         eZ = zNext >> e_shift;

    zN1 = ((b + eZ) - a*zN);
    ap_uint<alpha> index = a(alpha-1,0);
    log = log_lut[index];

#undef log_lut
}

//   i  0  1  2  3   4   5   6   7   8
// =====================================
//  pi  0  4  7  12  17  22  27  32  37
const int p0 = 0; // We start with zero zeroed bits
const int alpha0 = 5; // 1+alpha0 = number of bits considered by stage 0.
const int p1 = (alpha0 == 5) ? 4 : (alpha0-2); // The number of bits zeroed in y1.
const int alpha1 = 4;
const int p2 = p1 + alpha1 - 1;
const int alpha2 = 6;
const int p3 = p2 + alpha2 - 1;
const int alpha3 = 6;
const int p4 = p3 + alpha3 - 1;
const int alpha4 = 6;
const int p5 = p4 + alpha4 - 1;
const int alpha5 = 6;
const int p6 = p5 + alpha5 - 1;
const int alpha6 = 6;
const int p7 = p6 + alpha6 - 1;
const int alpha7 = 6;
const int p8 = p7 + alpha7 - 1;

template <int W_s_> class log_traits{};

template <>
class log_traits<1>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 11; // round to F_
    const static int org_wf = wf;

    const static int gbits = 1;
    const static int p_generic = p1;
    const static int MaxPrecision = wf+gbits+1;//11+1=12;
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<19,7>

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        return z1;
    }
};

template <>
class log_traits<2>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 19; // round to F_
    const static int org_wf = wf;

    const static int gbits = 2;
    const static int p_generic = p2;
    const static int MaxPrecision =wf+gbits+1;//19+2=21
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<28,7>

    const static int w1 = wf+1;
    const static int w2 = w1+2*p1+1-(alpha1-1); // MaxWidth of z2, needs to be truncted to MaxPrecision

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        ap_ufixed<(w2 < MaxPrecision-p2) ? w2  : (MaxPrecision-p2), -p2>        z2;
        LOG_TYPE logn;

        range_reduce<LOG_TYPE, p1, alpha1> (z1, logn, z2);
        log_sum += logn;
        return z2;
    }
};

template <>
class log_traits<3>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 33; // round to F_
    const static int org_wf = wf;

    const static int gbits = 3;
    const static int p_generic = p3;
    const static int MaxPrecision = wf+gbits+1;//33+3=36
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<43,7>

    const static int w1 = wf+1;
    const static int w2 = w1+2*p1+1-(alpha1-1); // MaxWidth of z2, needs to be truncted to MaxPrecision
    const static int w3 = w2+2*p2+1-(alpha2-1);

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        ap_ufixed<(w2 < MaxPrecision-p2) ? w2  : (MaxPrecision-p2), -p2>        z2;
        ap_ufixed<(w3 < MaxPrecision-p3) ? w3  : (MaxPrecision-p3), -p3>        z3;
        LOG_TYPE logn;

        range_reduce<LOG_TYPE, p1, alpha1> (z1, logn, z2);
        log_sum += logn;
        range_reduce<LOG_TYPE, p2, alpha2> (z2, logn, z3);
        log_sum += logn;
        return z3;
    }
};

template <>
class log_traits<4>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 48; // round to F_
    const static int org_wf = wf;

    const static int gbits = 3;
    const static int p_generic = p4;
    const static int MaxPrecision = wf+gbits+1;//3+48=51
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<58,7>

    const static int w1 = wf+1;
    const static int w2 = w1+2*p1+1-(alpha1-1); // MaxWidth of z2, needs to be truncted to MaxPrecision
    const static int w3 = w2+2*p2+1-(alpha2-1);
    const static int w4 = w3+2*p3+1-(alpha3-1);

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        ap_ufixed<(w2 < MaxPrecision-p2) ? w2  : (MaxPrecision-p2), -p2>        z2;
        ap_ufixed<(w3 < MaxPrecision-p3) ? w3  : (MaxPrecision-p3), -p3>        z3;
        ap_ufixed<(w4 < MaxPrecision-p4) ? w4  : (MaxPrecision-p4), -p4>        z4;
        LOG_TYPE logn;

        range_reduce<LOG_TYPE, p1, alpha1> (z1, logn, z2);
        log_sum += logn;
        range_reduce<LOG_TYPE, p2, alpha2> (z2, logn, z3);
        log_sum += logn;
        range_reduce<LOG_TYPE, p3, alpha3> (z3, logn, z4);
        log_sum += logn;
        return z4;
    }
};

template <>
class log_traits<5>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 63; // round to (W_-1)
    const static int org_wf = wf;

    const static int gbits = 3;
    const static int p_generic = p5;
    const static int MaxPrecision = wf+gbits+1;//3+63=66;
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<73,7>

    const static int w1 = wf+1;
    const static int w2 = w1+2*p1+1-(alpha1-1); // MaxWidth of z2, needs to be truncted to MaxPrecision
    const static int w3 = w2+2*p2+1-(alpha2-1);
    const static int w4 = w3+2*p3+1-(alpha3-1);
    const static int w5 = w4+2*p4+1-(alpha4-1);

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        ap_ufixed<(w2 < MaxPrecision-p2) ? w2  : (MaxPrecision-p2), -p2>        z2;
        ap_ufixed<(w3 < MaxPrecision-p3) ? w3  : (MaxPrecision-p3), -p3>        z3;
        ap_ufixed<(w4 < MaxPrecision-p4) ? w4  : (MaxPrecision-p4), -p4>        z4;
        ap_ufixed<(w5 < MaxPrecision-p5) ? w5  : (MaxPrecision-p5), -p5>        z5;
        LOG_TYPE logn;

        range_reduce<LOG_TYPE, p1, alpha1> (z1, logn, z2);
        log_sum += logn;
        range_reduce<LOG_TYPE, p2, alpha2> (z2, logn, z3);
        log_sum += logn;
        range_reduce<LOG_TYPE, p3, alpha3> (z3, logn, z4);
        log_sum += logn;
        range_reduce<LOG_TYPE, p4, alpha4> (z4, logn, z5);
        log_sum += logn;
        return z5;
    }
};

template <>
class log_traits<6>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 76; // round to F_
    const static int org_wf = wf;

    const static int gbits = 4;
    const static int p_generic = p6;
    const static int MaxPrecision = wf+gbits+2;//76+4=80
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<87,7>

    const static int w1 = wf+1;
    const static int w2 = w1+2*p1+1-(alpha1-1); // MaxWidth of z2, needs to be truncted to MaxPrecision
    const static int w3 = w2+2*p2+1-(alpha2-1);
    const static int w4 = w3+2*p3+1-(alpha3-1);
    const static int w5 = w4+2*p4+1-(alpha4-1);
    const static int w6 = w5+2*p5+1-(alpha5-1);

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        ap_ufixed<(w2 < MaxPrecision-p2) ? w2  : (MaxPrecision-p2), -p2>        z2;
        ap_ufixed<(w3 < MaxPrecision-p3) ? w3  : (MaxPrecision-p3), -p3>        z3;
        ap_ufixed<(w4 < MaxPrecision-p4) ? w4  : (MaxPrecision-p4), -p4>        z4;
        ap_ufixed<(w5 < MaxPrecision-p5) ? w5  : (MaxPrecision-p5), -p5>        z5;
        ap_ufixed<(w6 < MaxPrecision-p6) ? w6  : (MaxPrecision-p6), -p6>        z6;
        LOG_TYPE logn;

        range_reduce<LOG_TYPE, p1, alpha1> (z1, logn, z2);
        log_sum += logn;
        range_reduce<LOG_TYPE, p2, alpha2> (z2, logn, z3);
        log_sum += logn;
        range_reduce<LOG_TYPE, p3, alpha3> (z3, logn, z4);
        log_sum += logn;
        range_reduce<LOG_TYPE, p4, alpha4> (z4, logn, z5);
        log_sum += logn;
        range_reduce<LOG_TYPE, p5, alpha5> (z5, logn, z6);
        log_sum += logn;
        return z6;
    }
};

template <>
class log_traits<7>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 91; // round to (W_-1)
    const static int org_wf = wf;

    const static int gbits = 4;
    const static int p_generic = p7;
    const static int MaxPrecision = wf+gbits+2;//91+4=95
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<102,7>

    const static int w1 = wf+1;
    const static int w2 = w1+2*p1+1-(alpha1-1); // MaxWidth of z2, needs to be truncted to MaxPrecision
    const static int w3 = w2+2*p2+1-(alpha2-1);
    const static int w4 = w3+2*p3+1-(alpha3-1);
    const static int w5 = w4+2*p4+1-(alpha4-1);
    const static int w6 = w5+2*p5+1-(alpha5-1);
    const static int w7 = w6+2*p6+1-(alpha6-1);

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        ap_ufixed<(w2 < MaxPrecision-p2) ? w2  : (MaxPrecision-p2), -p2>        z2;
        ap_ufixed<(w3 < MaxPrecision-p3) ? w3  : (MaxPrecision-p3), -p3>        z3;
        ap_ufixed<(w4 < MaxPrecision-p4) ? w4  : (MaxPrecision-p4), -p4>        z4;
        ap_ufixed<(w5 < MaxPrecision-p5) ? w5  : (MaxPrecision-p5), -p5>        z5;
        ap_ufixed<(w6 < MaxPrecision-p6) ? w6  : (MaxPrecision-p6), -p6>        z6;
        ap_ufixed<(w7 < MaxPrecision-p7) ? w7  : (MaxPrecision-p7), -p7>        z7;
        LOG_TYPE logn;

        range_reduce<LOG_TYPE, p1, alpha1> (z1, logn, z2);
        log_sum += logn;
        range_reduce<LOG_TYPE, p2, alpha2> (z2, logn, z3);
        log_sum += logn;
        range_reduce<LOG_TYPE, p3, alpha3> (z3, logn, z4);
        log_sum += logn;
        range_reduce<LOG_TYPE, p4, alpha4> (z4, logn, z5);
        log_sum += logn;
        range_reduce<LOG_TYPE, p5, alpha5> (z5, logn, z6);
        log_sum += logn;
        range_reduce<LOG_TYPE, p6, alpha6> (z6, logn, z7);
        log_sum += logn;
        return z7;
    }
};

template <>
class log_traits<8>{
public:
    const static int we = 6; // ceil(log2(ln(2^(W_-1)))), <= ceil(log2(ln(2^32)))
    const static int wf = 106; // round to F_
    const static int org_wf = wf;

    const static int gbits = 4;
    const static int p_generic = p8;//37
    const static int MaxPrecision = wf+gbits+2;//106+4=110
    typedef ap_fixed<1 + we + MaxPrecision, 1 + we > LOG_TYPE;//<117,7>

    const static int w1 = wf+1;
    const static int w2 = w1+2*p1+1-(alpha1-1); // MaxWidth of z2, needs to be truncted to MaxPrecision
    const static int w3 = w2+2*p2+1-(alpha2-1);
    const static int w4 = w3+2*p3+1-(alpha3-1);
    const static int w5 = w4+2*p4+1-(alpha4-1);
    const static int w6 = w5+2*p5+1-(alpha5-1);
    const static int w7 = w6+2*p6+1-(alpha6-1);
    const static int w8 = w7+2*p7+1-(alpha7-1);

    template <int size>
    static ap_ufixed<MaxPrecision-p_generic, -p_generic> range_reduction(ap_ufixed<size, -p1> z1, LOG_TYPE &log_sum) {
        ap_ufixed<(w2 < MaxPrecision-p2) ? w2  : (MaxPrecision-p2), -p2>        z2;
        ap_ufixed<(w3 < MaxPrecision-p3) ? w3  : (MaxPrecision-p3), -p3>        z3;
        ap_ufixed<(w4 < MaxPrecision-p4) ? w4  : (MaxPrecision-p4), -p4>        z4;
        ap_ufixed<(w5 < MaxPrecision-p5) ? w5  : (MaxPrecision-p5), -p5>        z5;
        ap_ufixed<(w6 < MaxPrecision-p6) ? w6  : (MaxPrecision-p6), -p6>        z6;
        ap_ufixed<(w7 < MaxPrecision-p7) ? w7  : (MaxPrecision-p7), -p7>        z7;
        ap_ufixed<(w8 < MaxPrecision-p8) ? w8  : (MaxPrecision-p8), -p8>        z8;
        LOG_TYPE logn;

        range_reduce<LOG_TYPE, p1, alpha1> (z1, logn, z2);
        log_sum += logn;
        range_reduce<LOG_TYPE, p2, alpha2> (z2, logn, z3);
        log_sum += logn;
        range_reduce<LOG_TYPE, p3, alpha3> (z3, logn, z4);
        log_sum += logn;
        range_reduce<LOG_TYPE, p4, alpha4> (z4, logn, z5);
        log_sum += logn;
        range_reduce<LOG_TYPE, p5, alpha5> (z5, logn, z6);
        log_sum += logn;
        range_reduce<LOG_TYPE, p6, alpha6> (z6, logn, z7);
        log_sum += logn;
        range_reduce<LOG_TYPE, p7, alpha7> (z7, logn, z8);
        log_sum += logn;
        return z8;
    }
};
template<int W_, int I_>
ap_fixed<W_,I_> log(ap_fixed<W_,I_> x)
{
#pragma HLS pipeline

    // bitwidth that currently not supported
    const static int F_ = W_ - I_;
    if (I_>34) return 0;
    else if (F_>100) return 0;

    // return ap_fixed value
    ap_fixed<W_,I_> r = 0;
    ap_ufixed<W_-1,I_-1> x_s = x;

    if (F_==0) {
        if (I_<=7) {
            if (x<=0)         r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))  r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))  r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))  r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0")) r = 3;
            else                    r = 4;
        } else if (I_<=10) {
            if (x<=0)         r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))  r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))  r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))  r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0")) r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5ap0")) r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf4p0")) r = 5;
            else                    r = 6;
        } else if (I_<=13) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))   r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))   r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))   r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0"))  r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5ap0"))  r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf4p0"))  r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x299p0")) r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x710p0")) r = 7;
            else                     r = 8;
        } else if (I_<=17) {
            if (x<=0)            r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))     r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))     r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))     r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0"))    r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5ap0"))    r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf4p0"))    r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x299p0"))   r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x710p0"))   r = 7;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1332p0"))  r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x342fp0"))  r = 9;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8ddbp0"))  r = 10;
            else                       r = 11;
        } else if (I_<=19) {
            if (x<=0)            r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))     r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))     r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))     r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0"))    r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5ap0"))    r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf4p0"))    r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x299p0"))   r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x710p0"))   r = 7;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1332p0"))  r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x342fp0"))  r = 9;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8ddbp0"))  r = 10;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1819bp0")) r = 11;
            else                       r = 12;
        } else if (I_<=26) {
            if (x<=0)             r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))      r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))      r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))      r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0"))     r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5ap0"))     r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf4p0"))     r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x299p0"))    r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x710p0"))    r = 7;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1332p0"))   r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x342fp0"))   r = 9;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8ddbp0"))   r = 10;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1819bp0"))  r = 11;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x41831p0"))  r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xb2148p0"))  r = 13;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1e4127p0")) r = 14;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x523d82p0")) r = 15;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xdf8d5fp0")) r = 16;
            else                        r = 17;
        } else if (I_<=32) {
            if (x<=0)               r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))        r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))        r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))        r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0"))       r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5ap0"))       r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf4p0"))       r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x299p0"))      r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x710p0"))      r = 7;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1332p0"))     r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x342fp0"))     r = 9;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8ddbp0"))     r = 10;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1819bp0"))    r = 11;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x41831p0"))    r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xb2148p0"))    r = 13;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1e4127p0"))   r = 14;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x523d82p0"))   r = 15;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xdf8d5fp0"))   r = 16;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x25fad90p0"))  r = 17;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x673d70bp0"))  r = 18;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x118a2aaep0")) r = 19;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2fad89e1p0")) r = 20;
            else                          r = 21;
        } else {
            if (x<=0)               r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))        r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4p0"))        r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xcp0"))        r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x21p0"))       r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5ap0"))       r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf4p0"))       r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x299p0"))      r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x710p0"))      r = 7;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1332p0"))     r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x342fp0"))     r = 9;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8ddbp0"))     r = 10;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1819bp0"))    r = 11;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x41831p0"))    r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xb2148p0"))    r = 13;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1e4127p0"))   r = 14;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x523d82p0"))   r = 15;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xdf8d5fp0"))   r = 16;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x25fad90p0"))  r = 17;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x673d70bp0"))  r = 18;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x118a2aaep0")) r = 19;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2fad89e1p0")) r = 20;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x819a1801p0")) r = 21;
            else                          r = 22;
        }
    } else if (F_<=4 && I_<=5) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.1p0")) r = "-0x2.cp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.2p0")) r = "-0x2.1p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.3p0")) r = "-0x1.bp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.4p0")) r = "-0x1.6p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.5p0")) r = "-0x1.3p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.6p0")) r = "-0x1p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.7p0")) r = "-0x0.dp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.8p0")) r = "-0x0.bp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.9p0")) r = "-0x0.9p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.ap0")) r = "-0x0.8p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.bp0")) r = "-0x0.6p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.cp0")) r = "-0x0.5p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.dp0")) r = "-0x0.3p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.ep0")) r = "-0x0.2p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.fp0")) r = "-0x0.1p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x1p0"))   r = "0x0p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.1p0")) r = "0x0.1p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.2p0")) r = "0x0.2p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.3p0")) r = "0x0.3p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.5p0")) r = "0x0.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.6p0")) r = "0x0.5p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.8p0")) r = "0x0.6p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.9p0")) r = "0x0.7p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.bp0")) r = "0x0.8p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.cp0")) r = "0x0.9p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.ep0")) r = "0x0.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))   r = "0x0.bp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.2p0")) r = "0x0.cp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.5p0")) r = "0x0.dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.7p0")) r = "0x0.ep0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.ap0")) r = "0x0.fp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.cp0")) r = "0x1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.fp0")) r = "0x1.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.2p0")) r = "0x1.2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.6p0")) r = "0x1.3p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.9p0")) r = "0x1.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.dp0")) r = "0x1.5p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.1p0")) r = "0x1.6p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.5p0")) r = "0x1.7p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.9p0")) r = "0x1.8p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.ep0")) r = "0x1.9p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.3p0")) r = "0x1.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.9p0")) r = "0x1.bp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.ep0")) r = "0x1.cp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.5p0")) r = "0x1.dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.bp0")) r = "0x1.ep0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.2p0")) r = "0x1.fp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.9p0")) r = "0x2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.1p0")) r = "0x2.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.ap0")) r = "0x2.2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.3p0")) r = "0x2.3p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.cp0")) r = "0x2.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xa.6p0")) r = "0x2.5p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xb.1p0")) r = "0x2.6p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xb.cp0")) r = "0x2.7p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc.9p0")) r = "0x2.8p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xd.6p0")) r = "0x2.9p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xe.3p0")) r = "0x2.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xf.2p0")) r = "0x2.bp0";
            else                     r = "0x2.cp0";
    } else {

        if (x<=0) {r[W_-1] = 1;}
        else {

            //std::cout<<"[LOG]x="<<x.to_string()<<std::endl;
            const static int W_s_ = (F_+F_/77*2+12)/15-(100+F_)/133+(99+F_)/133-(100+F_)/118+(98+F_)/118+1;
            //if (W_<=11)       W_s_ = 1;
            //else if (W_<=19) W_s_ = 2;
            //else if (W_<=33) W_s_ = 3;
            //else if (W_<=48) W_s_ = 4;
            //else if (W_<=63) W_s_ = 5;
            //else if (W_<=76) W_s_ = 6;
            //else if (W_<=91) W_s_ = 7;
            //else             w_s_ = 8;

            const static int           wf = log_traits<W_s_>::wf;
            const static int           I_s= I_>0? I_:-I_; 
            const static int       org_wf = log_traits<W_s_>::org_wf+I_s;
            const static int MaxPrecision = log_traits<W_s_>::MaxPrecision;

            // x = b_frac * (2 ^ b_exp)
            // .75 <= b_frac < 1.5
            // -F_ <= b_exp <= I_-1
            ap_int<7> b_exp;
            ap_ufixed<1 + org_wf,1> b_frac=0;
            b_frac[org_wf] = 0;
            b_frac(org_wf-1,org_wf-W_+1) = x(W_-2,0);
            #pragma unroll
            for (b_exp = I_-1; b_exp >= -F_; b_exp--) {
                if ((!b_frac[org_wf]&b_frac[org_wf-1]&b_frac[org_wf-2])|(b_frac[org_wf]&!b_frac[org_wf-1]))
                    break;
                b_frac <<= 1;
            }
            //std::cout<<"[LOG]b_exp="<<b_exp<<std::endl;
            //std::cout<<"[LOG]b_frac="<<b_frac.to_string()<<std::endl;

            const ap_ufixed<MaxPrecision,0> LOG2 = "0x0.B17217F7D1CF79ABC9E3B39803p0";//0.69314718055989033018704503774643;
            ap_fixed<MaxPrecision,6> Elog2 = LOG2 * b_exp;
            //maybe need to extend ???? 


            typedef typename log_traits<W_s_>::LOG_TYPE LOG_TYPE;
            const static int bypass_threshold = log_traits<W_s_>::p_generic;

            //std::cout<<"[LOG]b_frac="<<b_frac.to_string()<<std::endl;
            ap_uint<1+alpha0> index0; // ap_uint<6>
            if (b_frac[org_wf]) index0 = b_frac(org_wf-1,org_wf-6);
            else                index0 = b_frac(org_wf-2,org_wf-7);

            const int T0size = 1 << (1+alpha0); // The size of the first table

#define inverse_lut log_inverse_lut_table::array
#define log_lut log0_lut_table<LOG_TYPE,p0,alpha0,T0size>::array

            ap_ufixed<1 + alpha0, 1> b_frac_tilde_inverse = inverse_lut[index0];

            //std::cout<<"[LOG]b_frac_tilde_inverse="<<b_frac_tilde_inverse.to_string()<<std::endl;
            LOG_TYPE log_sum = log_lut[index0];

            ap_ufixed<1 + org_wf+1+(1+alpha0), 1> b_frac1 = b_frac * b_frac_tilde_inverse;
            //std::cout<<"[LOG]b_frac1="<<b_frac1.to_string()<<std::endl;

#ifndef __SYNTHESIS__
            assert(b_frac1( b_frac1.wl()-b_frac1.iwl()-1, b_frac1.wl()-b_frac1.iwl()-p1) == 0);
#endif
            const int z1_width = 1+wf+1+(1+alpha0)-p1+1;
            ap_ufixed<z1_width,        -p1>        z1 = b_frac1; // Extract a1+b1 from y1.
            //std::cout<<"[LOG]z1="<<z1.to_string()<<std::endl;

            ap_fixed<1-bypass_threshold+1+MaxPrecision, -bypass_threshold+1> zk;
            zk = log_traits<W_s_>::range_reduction(z1,log_sum);
            //std::cout<<"[LOG]zk="<<zk.to_string()<<std::endl;

            ap_fixed<1-2*bypass_threshold+1+MaxPrecision, -bypass_threshold+1>   zk_trunc = zk;
            LOG_TYPE sum = zk-(zk_trunc*zk_trunc/2);

            LOG_TYPE log_base;
            log_base = Elog2 + log_sum + sum;
#undef log_lut
#undef inverse_lut

            ap_fixed<2 + F_, 1> delta = 0;
            delta[delta.wl()-1] = log_base[log_base.wl()-1];
            delta[delta.wl()-delta.iwl()-1] = 1;
            log_base = log_base + ( delta >> F_ );

            r = log_base;
        }

    }

    return r;
}

template<int W_, int I_>
ap_ufixed<W_,I_> log(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xf = x;
    return log(xf);
}

template<int I_>
ap_int<I_> log(ap_int<I_> x) {
    ap_fixed<I_,I_> xf = x;
    return log(xf);
}

template<int I_>
ap_uint<I_> log(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xf = x;
    return log(xf);
}


template<int W_, int I_>
ap_fixed<W_,I_> log10(ap_fixed<W_,I_> x)
{
#pragma HLS pipeline

    // bitwidth that currently not supported
    const static int F_ = W_ - I_;
    if (I_>33) return 0;
    else if (F_>32) return 0;

    // return ap_fixed value
    ap_fixed<W_,I_> r = 0;
    ap_ufixed<W_-1,I_-1> x_s = x;

    if (F_==0) {
        if (I_<=9) {
            if (x<=0)        {r[W_-1] = 1;}
            else {
                ap_ufixed<8,8> x_s_l = x_s;
                if (x_s_l(7,2)==0)      r = 0;
                else if (x_s_l(7,5)==0) r = 1;
                else                    r = 2;
            }
        } else if (I_<=15) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3p0"))   r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1fp0"))  r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x13cp0")) r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc5ap0")) r = 3;
            else                     r = 4;
        } else if (I_<=19) {
            if (x<=0)           r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3p0"))    r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1fp0"))   r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x13cp0"))  r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc5ap0"))  r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7b86p0")) r = 4;
            else                      r = 5;
        } else if (I_<=25) {
            if (x<=0)             r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3p0"))      r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1fp0"))     r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x13cp0"))    r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc5ap0"))    r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7b86p0"))   r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4d343p0"))  r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3040a5p0")) r = 6;
            else                        r = 7;
        } else if (I_<=32) {
            if (x<=0)               r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3p0"))        r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1fp0"))       r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x13cp0"))      r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc5ap0"))      r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7b86p0"))     r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4d343p0"))    r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3040a5p0"))   r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1e28678p0"))  r = 7;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x12d940b6p0")) r = 8;
            else                          r = 9;
        } else {
            if (x<=0)               r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3p0"))        r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1fp0"))       r = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x13cp0"))      r = 2;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc5ap0"))      r = 3;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7b86p0"))     r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4d343p0"))    r = 5;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3040a5p0"))   r = 6;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1e28678p0"))  r = 7;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x12d940b6p0")) r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xbc7c871cp0")) r = 9;
            else                          r = 10;
        }
    } else if (F_<=4 && I_<=5) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.1p0")) r = "-0x1.3p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.2p0")) r = "-0x0.ep0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.3p0")) r = "-0x0.cp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.4p0")) r = "-0x0.ap0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.5p0")) r = "-0x0.8p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.6p0")) r = "-0x0.7p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.7p0")) r = "-0x0.6p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.8p0")) r = "-0x0.5p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.9p0")) r = "-0x0.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x0.bp0")) r = "-0x0.3p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.cp0")) r = "-0x0.2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x0.ep0")) r = "-0x0.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.1p0")) r = "0x0p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.3p0")) r = "0x0.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.6p0")) r = "0x0.2p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.ap0")) r = "0x0.3p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.ep0")) r = "0x0.4p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.3p0")) r = "0x0.5p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.8p0")) r = "0x0.6p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.fp0")) r = "0x0.7p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.6p0")) r = "0x0.8p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.ep0")) r = "0x0.9p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.8p0")) r = "0x0.ap0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.3p0")) r = "0x0.bp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6p0"))   r = "0x0.cp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.fp0")) r = "0x0.dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8p0"))   r = "0x0.ep0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.4p0")) r = "0x0.fp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xa.bp0")) r = "0x1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xc.6p0")) r = "0x1.1p0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0xe.5p0")) r = "0x1.2p0";
            else                     r = "0x1.3p0";
    } else { // I was here!

        if (x<=0) {r[W_-1] = 1;}
        else {
            const static int W_s_= (F_+F_/77*2+12)/15-(100+F_)/133+(99+F_)/133-(100+F_)/118+(98+F_)/118+1;
            //if (W_<=11)       W_s_ = 1;
            //else if (W_<=19) W_s_ = 2;
            //else if (W_<=33) W_s_ = 3;
            //else if (W_<=48) W_s_ = 4;
            //else if (W_<=63) W_s_ = 5;
            //else if (W_<=76) W_s_ = 6;
            const static int           wf = log_traits<W_s_>::wf;
            const static int           I_s= I_>0? I_:-I_; 
            const static int       org_wf = log_traits<W_s_>::org_wf+I_s;
            const static int MaxPrecision = log_traits<W_s_>::MaxPrecision;

            // x = b_frac * (2 ^ b_exp)
            // .75 <= b_frac < 1.5
            // -F_ <= b_exp <= I_-1

            ap_int<7> b_exp=0;
            ap_ufixed<1 + org_wf,1> b_frac=0;
            b_frac[org_wf] = 0;
            b_frac(org_wf-1,org_wf-W_+1) = x(W_-2,0);
            #pragma unroll
            for (b_exp = I_-1; b_exp >= -F_; b_exp--) {
                if ((!b_frac[org_wf]&b_frac[org_wf-1]&b_frac[org_wf-2])|(b_frac[org_wf]&!b_frac[org_wf-1]))
                    break;
                b_frac <<= 1;
            }

            const ap_ufixed<25,0> LOG1_35_s = 0.3010300099849700927734375;//0.693147182464599609375;
            const ap_ufixed<43,0> LOG1_35_l = 0.30102999566395283181918784976006;//0.69314718055989033018704503774643;
            ap_fixed<30,5> Elog2_s = LOG1_35_s * b_exp;
            ap_fixed<48,5> Elog2_l = LOG1_35_l * b_exp;


            typedef typename log_traits<W_s_>::LOG_TYPE LOG_TYPE;
            const static int bypass_threshold = log_traits<W_s_>::p_generic;

            ap_uint<1+alpha0> index0; // ap_uint<6>
            if (b_frac[org_wf]) index0 = b_frac(org_wf-1,org_wf-6);
            else                index0 = b_frac(org_wf-2,org_wf-7);

            const int T0size = 1 << (1+alpha0); // The size of the first table

#define inverse_lut log_inverse_lut_table::array
#define log_lut log0_lut_table<LOG_TYPE,p0,alpha0,T0size>::array

            ap_ufixed<1 + alpha0, 1> b_frac_tilde_inverse = inverse_lut[index0];

            LOG_TYPE log_sum = log_lut[index0];

            ap_ufixed<1 + org_wf+1+(1+alpha0), 1> b_frac1 = b_frac * b_frac_tilde_inverse;

#ifndef __SYNTHESIS__
            assert(b_frac1( b_frac1.wl()-b_frac1.iwl()-1, b_frac1.wl()-b_frac1.iwl()-p1) == 0);
#endif
            const int z1_width = 1+wf+1+(1+alpha0)-p1+1;
            ap_ufixed<z1_width,        -p1>        z1 = b_frac1; // Extract a1+b1 from y1.

            ap_fixed<1-bypass_threshold+1+MaxPrecision, -bypass_threshold+1> zk;
            zk = log_traits<W_s_>::range_reduction(z1,log_sum);

            ap_fixed<1-2*bypass_threshold+1+MaxPrecision, -bypass_threshold+1>   zk_trunc = zk;
            LOG_TYPE sum = zk-(zk_trunc*zk_trunc/2);

            LOG_TYPE log_base = log_sum + sum;

            const ap_ufixed<25,0> LOG1_54_s = 0.4342944920063018798828125;//0.693147182464599609375;
            const ap_ufixed<43,0> LOG1_54_l = 0.43429448190329367207596078515053;//0.69314718055989033018704503774643;

            if (F_<=16) log_base = Elog2_s + log_base * LOG1_54_s;
            else        log_base = Elog2_l + log_base * LOG1_54_l;
#undef log_lut
#undef inverse_lut

//            ap_fixed<1 + 33, 1> delta = 0;
//            delta[delta.wl()-1] = log_base[log_base.wl()-1];
//            delta[delta.wl()-delta.iwl()-1] = 1;
//            log_base = log_base + ( delta >> F_ );

            r = log_base;
        }

    }

    return r;
}

template<int W_, int I_>
ap_ufixed<W_,I_> log10(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xf = x;
    return log10(xf);
}

template<int I_>
ap_int<I_> log10(ap_int<I_> x) {
    ap_fixed<I_,I_> xf = x;
    return log10(xf);
}

template<int I_>
ap_uint<I_> log10(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xf = x;
    return log10(xf);
}

template<int W, int I>
ap_fixed<W,I> log1p(ap_fixed<W,I> x) {
    ap_ufixed<1,1> inc = 1;
    ap_fixed<W+1,I+1> xp1 = x + inc;
    return log(xp1);
}

template<int W, int I>
ap_ufixed<W,I> log1p(ap_ufixed<W,I> x) {
    ap_fixed<W+1,I+1> xf = x;
    return log1p(xf);
}

template<int I>
ap_int<I> log1p(ap_int<I> x) {
    ap_fixed<I,I> xf = x;
    return log1p(xf);
}

template<int I>
ap_uint<I> log1p(ap_uint<I> x) {
    ap_fixed<I+1,I+1> xf = x;
    return log1p(xf);
}

template<int W,int I>
ap_fixed<W,I> ilogb(ap_fixed<W,I> x) {
    int F = W - I;
    if(F>32 || I>33) {
        return 0;
    }
    ap_fixed<W+1,I+1> xf;
    if(x>0) {
        xf = x;
    }
    else {
        xf = -x;
    }
    return I + 1 - xf.countLeadingZeros() - 1;
}

template<int W,int I>
ap_ufixed<W,I> ilogb(ap_ufixed<W,I> x) {
    ap_fixed<W+1,I+1> xf = x;
    return ilogb(xf);
}

template<int I>
ap_int<I> ilogb(ap_int<I> x) {
    ap_fixed<I,I> xf = x;
    return ilogb(xf);
}

template<int I>
ap_uint<I> ilogb(ap_uint<I> x) {
    ap_fixed<I+1,I+1> xf = x;
    return ilogb(xf);
}


template<int W_, int I_>
ap_fixed<W_,I_> log2(ap_fixed<W_,I_> x)
{
#pragma HLS pipeline

    // bitwidth that currently not supported
    const static int F_ = W_ - I_;
    if (I_>33) return 0;
    else if (F_>32) return 0;

    // return ap_fixed value
    ap_fixed<W_,I_> r = 0;
    ap_ufixed<W_-1,I_-1> x_s = x;

    if (F_==0) {
        if (I_<=5) {
            if (x<=0)         r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
            else                    r = 4;
		} else if (I_<=9) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16p0"))         r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2Dp0"))         r = 5;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5Ap0"))         r = 6;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB5p0"))         r = 7;
            else                     r = 8;
        } else if (I_<=13) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16p0"))         r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2Dp0"))         r = 5;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5Ap0"))         r = 6;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB5p0"))         r = 7;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16Ap0"))        r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D4p0"))        r = 9;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8p0"))        r = 10;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB50p0"))        r = 11;
            else                     r = 12;
		} else if (I_<=17) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16p0"))         r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2Dp0"))         r = 5;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5Ap0"))         r = 6;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB5p0"))         r = 7;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16Ap0"))        r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D4p0"))        r = 9;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8p0"))        r = 10;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB50p0"))        r = 11;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A0p0"))       r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D41p0"))       r = 13;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A82p0"))       r = 14;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504p0"))       r = 15;
            else                     r = 16;
        } else if (I_<=21) {
            if (x<=0)           r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16p0"))         r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2Dp0"))         r = 5;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5Ap0"))         r = 6;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB5p0"))         r = 7;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16Ap0"))        r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D4p0"))        r = 9;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8p0"))        r = 10;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB50p0"))        r = 11;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A0p0"))       r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D41p0"))       r = 13;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A82p0"))       r = 14;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504p0"))       r = 15;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09p0"))      r = 16;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413p0"))      r = 17;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A827p0"))      r = 18;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504Fp0"))      r = 19;
            else                      r = 20;
        } else if (I_<=25) {
            if (x<=0)             r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16p0"))         r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2Dp0"))         r = 5;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5Ap0"))         r = 6;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB5p0"))         r = 7;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16Ap0"))        r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D4p0"))        r = 9;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8p0"))        r = 10;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB50p0"))        r = 11;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A0p0"))       r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D41p0"))       r = 13;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A82p0"))       r = 14;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504p0"))       r = 15;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09p0"))      r = 16;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413p0"))      r = 17;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A827p0"))      r = 18;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504Fp0"))      r = 19;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09Ep0"))     r = 20;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413Cp0"))     r = 21;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8279p0"))     r = 22;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504F3p0"))     r = 23;
            else                        r = 24;
        } else if (I_<=29) {
            if (x<=0)               r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16p0"))         r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2Dp0"))         r = 5;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5Ap0"))         r = 6;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB5p0"))         r = 7;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16Ap0"))        r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D4p0"))        r = 9;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8p0"))        r = 10;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB50p0"))        r = 11;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A0p0"))       r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D41p0"))       r = 13;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A82p0"))       r = 14;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504p0"))       r = 15;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09p0"))      r = 16;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413p0"))      r = 17;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A827p0"))      r = 18;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504Fp0"))      r = 19;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09Ep0"))     r = 20;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413Cp0"))     r = 21;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8279p0"))     r = 22;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504F3p0"))     r = 23;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09E6p0"))    r = 24;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413CCp0"))    r = 25;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A82799p0"))    r = 26;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504F33p0"))    r = 27;
            else                          r = 28;
        } else {
            if (x<=0)               r[W_-1] = 1;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1p0"))          r = 0;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2p0"))          r = 1;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5p0"))          r = 2;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xBp0"))          r = 3;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16p0"))         r = 4;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2Dp0"))         r = 5;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5Ap0"))         r = 6;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB5p0"))         r = 7;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16Ap0"))        r = 8;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D4p0"))        r = 9;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8p0"))        r = 10;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB50p0"))        r = 11;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A0p0"))       r = 12;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D41p0"))       r = 13;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A82p0"))       r = 14;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504p0"))       r = 15;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09p0"))      r = 16;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413p0"))      r = 17;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A827p0"))      r = 18;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504Fp0"))      r = 19;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09Ep0"))     r = 20;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413Cp0"))     r = 21;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A8279p0"))     r = 22;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504F3p0"))     r = 23;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09E6p0"))    r = 24;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413CCp0"))    r = 25;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A82799p0"))    r = 26;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504F33p0"))    r = 27;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x16A09E66p0"))   r = 28;
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2D413CCCp0"))   r = 29;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5A827999p0"))   r = 30;
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB504F333p0"))   r = 31;
            else                          r = 32;
        }
    } else if (F_<=4 && I_<=5) {
            if (x<=0)          r[W_-1] = 1;
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.1p0")) r = "-0x4.0p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.2p0")) r = "-0x3.0p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.3p0")) r = "-0x2.7p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.4p0")) r = "-0x2.0p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.5p0")) r = "-0x1.Bp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.6p0")) r = "-0x1.7p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.7p0")) r = "-0x1.3p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.8p0")) r = "-0x1.0p0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.9p0")) r = "-0x0.Dp0";
            else if (x_s<=ap_ufixed<W_-1,I_-1>("0x0.Ap0")) r = "-0x0.Bp0";
            else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.Bp0")) r = "-0x0.9p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.Cp0")) r = "-0x0.7p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.Dp0")) r = "-0x0.5p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.Ep0")) r = "-0x0.3p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x0.Fp0")) r = "-0x0.1p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.0p0")) r = "0x0.0p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.1p0")) r = "0x0.1p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.2p0")) r = "0x0.3p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.3p0")) r = "0x0.4p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.4p0")) r = "0x0.5p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.5p0")) r = "0x0.6p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.6p0")) r = "0x0.7p0";
			else if (x_s==ap_ufixed<W_-1,I_-1>("0x1.7p0")) r = "0x0.8p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.8p0")) r = "0x0.9p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.9p0")) r = "0x0.Ap0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.Ap0")) r = "0x0.Bp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.Bp0")) r = "0x0.Cp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.Cp0")) r = "0x0.Dp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.Dp0")) r = "0x0.Ep0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x1.Fp0")) r = "0x0.Fp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.0p0")) r = "0x1.0p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.2p0")) r = "0x1.1p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.3p0")) r = "0x1.2p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.5p0")) r = "0x1.3p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.6p0")) r = "0x1.4p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.8p0")) r = "0x1.5p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.Ap0")) r = "0x1.6p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.Cp0")) r = "0x1.7p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x2.Ep0")) r = "0x1.8p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.0p0")) r = "0x1.9p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.2p0")) r = "0x1.Ap0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.4p0")) r = "0x1.Bp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.6p0")) r = "0x1.Cp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.9p0")) r = "0x1.Dp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.Bp0")) r = "0x1.Ep0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x3.Ep0")) r = "0x1.Fp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.1p0")) r = "0x2.0p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.4p0")) r = "0x2.1p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.7p0")) r = "0x2.2p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.Ap0")) r = "0x2.3p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x4.Dp0")) r = "0x2.4p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.1p0")) r = "0x2.5p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.4p0")) r = "0x2.6p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.8p0")) r = "0x2.7p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x5.Cp0")) r = "0x2.8p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.0p0")) r = "0x2.9p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.4p0")) r = "0x2.Ap0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.9p0")) r = "0x2.Bp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x6.Dp0")) r = "0x2.Cp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.2p0")) r = "0x2.Dp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.7p0")) r = "0x2.Ep0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x7.Dp0")) r = "0x2.Fp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.2p0")) r = "0x3.0p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.8p0")) r = "0x3.1p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x8.Ep0")) r = "0x3.2p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.4p0")) r = "0x3.3p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0x9.Bp0")) r = "0x3.4p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xA.2p0")) r = "0x3.5p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xA.9p0")) r = "0x3.6p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB.1p0")) r = "0x3.7p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xB.8p0")) r = "0x3.8p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xC.1p0")) r = "0x3.9p0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xC.9p0")) r = "0x3.Ap0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xD.2p0")) r = "0x3.Bp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xD.Bp0")) r = "0x3.Cp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xE.5p0")) r = "0x3.Dp0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xE.Fp0")) r = "0x3.Ep0";
			else if (x_s<=ap_ufixed<W_-1,I_-1>("0xF.Ap0")) r = "0x3.Fp0";
            else                     r = "0x4.0p0";
    } else {

        if (x<=0) {r[W_-1] = 1;}
        else {
            const static int W_s_= (F_+F_/77*2+12)/15-(100+F_)/133+(99+F_)/133-(100+F_)/118+(98+F_)/118+1;

            const static int           wf = log_traits<W_s_>::wf;
            const static int           I_s= I_>0? I_:-I_; 
            const static int       org_wf = log_traits<W_s_>::org_wf+I_s;
            const static int MaxPrecision = log_traits<W_s_>::MaxPrecision;

            ap_int<7> b_exp=0;
            ap_ufixed<1 + org_wf,1> b_frac=0;
            b_frac[org_wf] = 0;
            b_frac(org_wf-1,org_wf-W_+1) = x(W_-2,0);
            #pragma unroll
            for (b_exp = I_-1; b_exp >= -F_; b_exp--) {
                if ((!b_frac[org_wf]&b_frac[org_wf-1]&b_frac[org_wf-2])|(b_frac[org_wf]&!b_frac[org_wf-1]))
                    break;
                b_frac <<= 1;
            }

            ap_fixed<30,5> Elog2_s = b_exp;
            ap_fixed<48,5> Elog2_l = b_exp;


            typedef typename log_traits<W_s_>::LOG_TYPE LOG_TYPE;
            const static int bypass_threshold = log_traits<W_s_>::p_generic;

            ap_uint<1+alpha0> index0; // ap_uint<6>
            if (b_frac[org_wf]) index0 = b_frac(org_wf-1,org_wf-6);
            else                index0 = b_frac(org_wf-2,org_wf-7);

            const int T0size = 1 << (1+alpha0); 

#define inverse_lut log_inverse_lut_table::array
#define log_lut log0_lut_table<LOG_TYPE,p0,alpha0,T0size>::array

            ap_ufixed<1 + alpha0, 1> b_frac_tilde_inverse = inverse_lut[index0];

            LOG_TYPE log_sum = log_lut[index0];

            ap_ufixed<1 + org_wf+1+(1+alpha0), 1> b_frac1 = b_frac * b_frac_tilde_inverse;

#ifndef __SYNTHESIS__
            assert(b_frac1( b_frac1.wl()-b_frac1.iwl()-1, b_frac1.wl()-b_frac1.iwl()-p1) == 0);
#endif
            const int z1_width = 1+wf+1+(1+alpha0)-p1+1;
            ap_ufixed<z1_width,        -p1>        z1 = b_frac1; 

            ap_fixed<1-bypass_threshold+1+MaxPrecision, -bypass_threshold+1> zk;
            zk = log_traits<W_s_>::range_reduction(z1,log_sum);

            ap_fixed<1-2*bypass_threshold+1+MaxPrecision, -bypass_threshold+1>   zk_trunc = zk;
            LOG_TYPE sum = zk-(zk_trunc*zk_trunc/2);

            LOG_TYPE log_base = log_sum + sum;

            const ap_ufixed<26,1> LOG1_54_s = "0x1.7154765p0";
            const ap_ufixed<44,1> LOG1_54_l = "0x1.71547652B82Fp0";

            if (F_<=16) log_base = Elog2_s + log_base * LOG1_54_s;
            else        log_base = Elog2_l + log_base * LOG1_54_l;
#undef log_lut
#undef inverse_lut

            r = log_base;
        }

    }

    return r;
}

template<int W_, int I_>
ap_ufixed<W_,I_> log2(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xf = x;
    return log2(xf);
}

template<int I_>
ap_int<I_> log2(ap_int<I_> x) {
    ap_fixed<I_,I_> xf = x;
    return log2(xf);
}

template<int I_>
ap_uint<I_> log2(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xf = x;
    return log2(xf);
}

template<int W_, int I_>
ap_fixed<W_,I_> logb(ap_fixed<W_,I_> x) {
	return log2(x);
}

template<int W_, int I_>
ap_ufixed<W_,I_> logb(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xf = x;
    return logb(xf);
}

template<int I_>
ap_int<I_> logb(ap_int<I_> x) {
    ap_fixed<I_,I_> xf = x;
    return logb(xf);
}

template<int I_>
ap_uint<I_> logb(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xf = x;
    return logb(xf);
}

}
#endif


