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
#ifndef _X_HLS_LGAMMA_APFIXED_H_
#define _X_HLS_LGAMMA_APFIXED_H_
#include "ap_fixed.h"
#include "ap_int.h"
#include "utils/x_hls_defines.h"
#include "utils/x_hls_traits.h"
#include "utils/x_hls_utils.h"

namespace lgamma_fixed {

template <int W, int I> ap_fixed<W, I> lgamma_generic(ap_fixed<W, I> x_fixed) {
#pragma HLS pipeline

  double x = x_fixed.to_double();
  double r = hls::lgamma(x);
  fp_struct<double> out(r);
  ap_ufixed<W+1, I+1> ret = 1;
  int F = W - I;
  if (F > 52) F = 52;
  if (W > I) ret(F - 1, 0) = out.sig(52 - 1, 52 - F);
  ret = (ret << (out.exp - fp_struct<double>::EXP_BIAS));
  return ap_fixed<W, I>(ret);
}

template <int W, int I> ap_ufixed<W, I> lgamma_generic(ap_ufixed<W, I> x) {
  ap_fixed<W + 1, I + 1> xf = x;
  return lgamma_generic(xf);
}
template <int I_> ap_int<I_> lgamma_generic(ap_int<I_> x) {
  ap_fixed<I_, I_> xf = x;
  return lgamma_generic(xf);
}
template <int I_> ap_uint<I_> lgamma_generic(ap_uint<I_> x) {
  ap_fixed<I_ + 1, I_ + 1> xf = x;
  return lgamma_generic(xf);
}

//lgamma_r
template <int W, int I> ap_fixed<W, I> lgamma_r_generic(ap_fixed<W, I> x, int *signgamp) {
  *signgamp = 1;
  return lgamma_generic(x);
}

template <int W, int I> ap_ufixed<W, I> lgamma_r_generic(ap_ufixed<W, I> x, int *signgamp) {
  ap_fixed<W + 1, I + 1> xf = x;
  return lgamma_r_generic(xf, signgamp);
}

template <int I_> ap_int<I_> lgamma_r_generic(ap_int<I_> x, int *signgamp) {
  ap_fixed<I_, I_> xf = x;
  return lgamma_r_generic(xf, signgamp);
}

template <int I_> ap_uint<I_> lgamma_r_generic(ap_uint<I_> x, int *signgamp) {
  ap_fixed<I_ + 1, I_ + 1> xf = x;
  return lgamma_r_generic(xf, signgamp);
}

} // lgamma_fixed

#endif
