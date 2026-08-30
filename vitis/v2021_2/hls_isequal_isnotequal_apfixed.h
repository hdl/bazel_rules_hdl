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
#ifndef _X_HLS_isequal_isnotequal_APFIXED_H_
#define _X_HLS_isequal_isnotequal_APFIXED_H_
#include "ap_fixed.h"
#include "stdint.h"
//#include "hls_fpo.h"
//#include "hls_half.h"

///isequal  apfixed a & apfixed b
template <int W_, int I_>
bool generic_isequal(ap_fixed<W_,I_> x,ap_fixed<W_,I_> y)
{
#pragma HLS pipeline
    return (x==y);
}

///isnotequal  apfixed a & apfixed b
template <int W_, int I_>
bool generic_isnotequal(ap_fixed<W_,I_> x,ap_fixed<W_,I_> y)
{
#pragma HLS pipeline
    return (!(x==y));
}

///isequal  ap_ufixed a & ap_fixed b
template <int W_, int I_>
bool generic_isequal(ap_ufixed<W_,I_> x,ap_fixed<W_,I_> y)
{
#pragma HLS pipeline
	return (x==y);
}

///isnotequal  ap_ufixed a & ap_fixed b
template <int W_, int I_>
bool generic_isnotequal(ap_ufixed<W_,I_> x,ap_fixed<W_,I_> y)
{
#pragma HLS pipeline
	return (!(x==y));
}

///isequal  ap_fixed a & ap_ufixed b
template <int W_, int I_>
bool generic_isequal(ap_fixed<W_,I_> x,ap_ufixed<W_,I_> y)
{
#pragma HLS pipeline
	return (x==y);
}

///isnotequal  ap_fixed a & ap_ufixed b
template <int W_, int I_>
bool generic_isnotequal(ap_fixed<W_,I_> x,ap_ufixed<W_,I_> y)
{
#pragma HLS pipeline
	return (!(x==y));
}

///isequal  ap_ufixed a & ap_ufixed b
template <int W_, int I_>
bool generic_isequal(ap_ufixed<W_,I_> x,ap_ufixed<W_,I_> y)
{
#pragma HLS pipeline
	return (x==y);
}

///isnotequal  ap_ufixed a & ap_ufixed b
template <int W_, int I_>
bool generic_isnotequal(ap_ufixed<W_,I_> x,ap_ufixed<W_,I_> y)
{
#pragma HLS pipeline
	return (!(x==y));
}


///isequal  apint a & apint b
template <int I_>
bool generic_isequal(ap_int<I_> x,ap_int<I_> y)
{
#pragma HLS pipeline
    return (x==y);
}

///isnotequal  apint a & apint b
template <int I_>
bool generic_isnotequal(ap_int<I_> x,ap_int<I_> y)
{
#pragma HLS pipeline
    return (!(x==y));
}

///isequal  ap_uint a & ap_int b
template <int I_>
bool generic_isequal(ap_uint<I_> x,ap_int<I_> y)
{
#pragma HLS pipeline
	return (x==y);
}

///isnotequal  ap_uint a & ap_int b
template <int I_>
bool generic_isnotequal(ap_uint<I_> x,ap_int<I_> y)
{
#pragma HLS pipeline
	return (!(x==y));
}

///isequal  ap_int a & ap_uint b
template <int I_>
bool generic_isequal(ap_int<I_> x,ap_uint<I_> y)
{
#pragma HLS pipeline
	return (x==y);
}

///isnotequal  ap_int a & ap_uint b
template <int I_>
bool generic_isnotequal(ap_int<I_> x,ap_uint<I_> y)
{
#pragma HLS pipeline
	return (!(x==y));
}

///isequal  ap_uint a & ap_uint b
template <int I_>
bool generic_isequal(ap_uint<I_> x,ap_uint<I_> y)
{
#pragma HLS pipeline
	return (x==y);
}

///isnotequal  ap_uint a & ap_uint b
template <int I_>
bool generic_isnotequal(ap_uint<I_> x,ap_uint<I_> y)
{
#pragma HLS pipeline
	return (!(x==y));
}

#endif



