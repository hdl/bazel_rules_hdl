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
 *     (c) Copyright 2008-2012 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
#ifndef _X_HLS_SELECT_BITSELECT_APFIXED_H_
#define _X_HLS_SELECT_BITSELECT_APFIXED_H_
#include "ap_fixed.h"
#include "ap_int.h"
//#include <stdio.h>

/*
///select ap_fixed
template <int W_, int I_>
ap_fixed<W_,I_> generic_select(ap_fixed<W_,I_> x,ap_fixed<W_,I_> y, ap_fixed<W_,I_> z)
{
#pragma HLS pipeline
	ap_fixed<W_,I_> result;
    //for (int i=0; i<J_;i++)
    	result=(z & y)|(~z & x);//meaning(z?y:x) or (x^(z&(y^x)))
    return result;
}

///select ap_ufixed
template <int W_, int I_>
ap_ufixed<W_,I_> generic_select(ap_ufixed<W_,I_> x,ap_ufixed<W_,I_> y, ap_ufixed<W_,I_> z)
{
#pragma HLS pipeline
	ap_ufixed<W_,I_> result;
    //for (int i=0; i<J_;i++)
    	result=(z & y)|(~z & x);//meaning(z?y:x) or (x^(z&(y^x)))
    return result;
}
*/
///bitselect ap_fixed
template <int W_, int I_>
ap_fixed<W_,I_> generic_bitselect(ap_fixed<W_,I_> x,ap_fixed<W_,I_> y, ap_fixed<W_,I_> z)
{
#pragma HLS pipeline
    return (z & y)|(~z & x);//meaning(z?y:x) or (x^(z&(y^x)))
}

///bitselect ap_ufixed
template <int W_, int I_>
ap_ufixed<W_,I_> generic_bitselect(ap_ufixed<W_,I_> x,ap_ufixed<W_,I_> y, ap_ufixed<W_,I_> z)
{
#pragma HLS pipeline
    return (z & y)|(~z & x);//meaning(z?y:x) or (x^(z&(y^x)))
}

///bitselect ap_int
template <int I_>
ap_int<I_> generic_bitselect(ap_int<I_> x,ap_int<I_> y, ap_int<I_> z)
{
#pragma HLS pipeline
    return (z & y)|(~z & x);//meaning(z?y:x) or (x^(z&(y^x)))
}
///bitselect ap_uint
template <int I_>
ap_uint<I_> generic_bitselect(ap_uint<I_> x,ap_uint<I_> y, ap_uint<I_> z)
{
#pragma HLS pipeline
    return (z & y)|(~z & x);//meaning(z?y:x) or (x^(z&(y^x)))
}

/*
///select ap_ufixed
template <int W_, int I_, int J_>
void hls_select(ap_ufixed<W_,I_> x[J_],ap_ufixed<W_,I_> y[J_], ap_ufixed<W_,I_> z[J_],ap_ufixed<W_,I_> result[J_])
{
	//ap_ufixed<W_,I_> result[J_];
    for (int i=0; i<J_;i++)
    	result[i]=(z[i] & y[i])|(~z[i] & x[i]);//meaning(z?y:x) or (x^(z&(y^x)))
    return;
}
*/
#endif


