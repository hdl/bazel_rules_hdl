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
#ifndef _X_HLS_TGAMMA_APFIXED_H_
#define _X_HLS_TGAMMA_APFIXED_H_
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_sqrt_apfixed.h"
#include "hls_pow_apfixed.h"
#include "hls_log_apfixed.h"
#include "hls_hotbm_apfixed.h"
#include "hls_lgamma_apfixed.h"
#include "utils/x_hls_defines.h"
#include "utils/x_hls_utils.h"
#include "utils/x_hls_traits.h"

ap_fixed<20 + 52, 20> gamma_product_fixed (ap_ufixed<4 + 52, 4> x/*, double x_eps*/, ap_uint<3> n/*, double *eps*/);

namespace tgamma_fixed {
template <typename T>
int generic_isinf(T x) {
  fp_struct<T> fs = x;
  int ret = ((fs.exp == fp_struct<T>::EXP_INFNAN) && (fs.sig == 0x0)) ? 1 : 0;
  return ret;
}

template <typename T>
int generic_isnan(T x) {
  fp_struct<T> fs = x;
  int ret = ((fs.exp == fp_struct<T>::EXP_INFNAN) && (fs.sig != 0x0)) ? 1 : 0;
  return ret;
}

template<int W, int I>
double gamma_positive_fixed (ap_fixed<W,I> x_fixed, int *exp2_adj)
{
#pragma HLS pipeline

  double x = x_fixed.to_double();
  fp_struct<double> xs(x);
  ap_ufixed<8 + 52, 8> x_fix = 1;
  x_fix(51,0) = xs.sig(51,0);
  ap_uint<3> shl;
  shl(2,0) = xs.exp(2,0);
  shl++;
  x_fix <<= shl;

  if ( xs.exp<126 )
    {
      *exp2_adj = 0;
      //return exp_reduce::exp(lgamma_fixed::lgamma_generic(x+1))/x;
      ap_fixed<W+1,I+1> x_1 = x_fixed+1;
      double logx1 = exp_reduce::exp(lgamma_fixed::lgamma_generic(x_1));
      return logx1/x;
    }
  else if ( (xs.exp<127)||((xs.exp==127)&&(xs.sig[51]==0)) )
    {
      *exp2_adj = 0;
      //return exp_reduce::exp(lgamma_fixed::lgamma_generic(x));
      return exp_reduce::exp(lgamma_fixed::lgamma_generic(x_fixed));
    }
  else if ( (xs.exp<129)||((xs.exp==129)&&(xs.sig(51,49)<5)) )
    {
      *exp2_adj = 0;
      ap_uint<4> nl;
      nl(3,0) = x_fix(54,51);
      nl -= 3;
      ap_uint<3> n;
      n(2,0) = nl(3,1);
      ap_ufixed<2 + 52, 2> x_adj;
      x_adj(51,0) = x_fix(51,0);
      x_adj[52] = x_fix[51];
      x_adj[53] = ~x_fix[51];
      //double n = ceil(x-1.5);
      //double x_adj = x-n;
      //double eps;
      double prod = gamma_product_fixed(x_adj/*,0*/,n/*,&eps*/);
      //return (exp_reduce::exp(lgamma_fixed::lgamma_generic(double(x_adj)))*prod/**(1+eps)*/);
      double rt = exp_reduce::exp(lgamma_fixed::lgamma_generic(x_adj));
      return (rt)*prod/**(1+eps)*/;
    }
  else
    {
      ap_ufixed<8 + 52, 8> x_adj = x_fix;
      //double eps = 0;
      //double x_eps = 0;
      //double x_adj = x;
      double prod = 1;
      if ( (xs.exp<130)||((xs.exp==130)&&(xs.sig(51,50)<3)) )
        {
          ap_uint<4> xi = x_fix(55,52);
          ap_uint<3> n = 11-xi;
          x_adj[52] = 1;
          x_adj[53] = 1;
          x_adj[54] = 0;
          x_adj[55] = 1;
          if (x_fix(51,0)==0) {
            n++;
            x_adj[52] = 0;
            x_adj[53] = 0;
            x_adj[54] = 1;
          }
          //double n = ceil(12-x);
          //x_adj = x+n;
          //x_eps = (x-(x_adj-n));
          prod = gamma_product_fixed(x_fix,n);
          //prod = gamma_product(x_adj-n,x_eps,n,&eps);
        }
      ap_uint<8> x_adj_int;
      x_adj_int(7,0) = x_adj(59,52) + x_adj[51];
      ap_fixed<1 - 1 + 52, 1 - 1> x_adj_frac;
      x_adj_frac(51,0) = x_adj(51,0);
      //double exp_adj = -eps;
      //double x_adj_int = round(x_adj);
      //double x_adj_frac = x_adj-x_adj_int;
      ap_uint<3> x_adj_log2;
      ap_ufixed<1 + 52, 1> x_adj_mant;
#pragma unroll
      for ( ap_uint<3> pos = 6; pos >= 2; pos-- ) {
        ap_uint<9> x_adj_hi;
        x_adj_hi(8,0) = x_adj(53+pos,45+pos);
        if ( x_adj_hi > 181 ) {
          x_adj_log2 = pos;
          x_adj_mant(52,0) = x_adj(53+pos,1+pos);
        }
      }
      //int x_adj_log2;
      //double x_adj_mant = frexp(x_adj,&x_adj_log2);
      //if ( x_adj_mant<M_SQRT1_2 )
      //{
      //	x_adj_log2--;
      //	x_adj_mant *= 2;
      //}
      *exp2_adj = x_adj_log2*x_adj_int;
      ap_ufixed<65, 11> x_sq =((ap_fixed<3 + 52, 3>(M_PI)<<1)/x_adj);
      ap_ufixed<8 + 52, 8> x_adjn = -x_adj;
      ///To improve accuracy exp2
      double ret_1 = (	  pow_apfixed_reduce::pow(ap_ufixed<8 + 52, 8>(x_adj_mant),(x_adj)) \
                          * exp_reduce::exp(ap_ufixed<65,33>(double(x_adj_log2*x_adj_frac))) \
                          * exp_reduce::exp((x_adjn))            \
                          * sqrt_fixed(x_sq) \
                         				\
                          );
      double ret = ret_1 / prod;
      //exp_adj += x_eps*log(x_adj);
      const ap_fixed<1 - 3 + 52, 1 - 3> gamma_coeff[6] = {    "0x1.5555555555555p-4",    "-0xb.60b60b60b60b8p-12",    "0x3.4034034034034p-12",
                                                              "-0x2.7027027027028p-12",    "0x3.72a3c5631fe46p-12",    "-0x7.daac36664f1f4p-12",
      };
      ap_fixed<1 - 3 + 52, 1 - 3> bsum = gamma_coeff[5];
      ap_fixed<16 + 52, 16> x_adj2 = x_adj*x_adj;
      for ( ap_uint<3> i = 1; i <= 5; i++ )
        bsum = bsum/x_adj2+gamma_coeff[5-i];
      ap_fixed<1 - 3 + 52, 1 - 3> exp_adj = bsum/x_adj;
      //return ret+ret*exp_reduce_::expm1(double(exp_adj));
      double rout = exp_reduce::exp(exp_adj);
      return ret*rout;
    }
}

template<int W, int I>
ap_fixed<W,I> tgamma_generic (ap_fixed<W,I> x_fixed)
{
#pragma HLS pipeline

  double x = x_fixed.to_double();
  fp_struct<double> xs(x);
  fp_struct<double> out;
  out.sign[0] = 0;
  out.sig = 0;
  out.exp = fp_struct<double>::EXP_INFNAN;

  ap_ufixed<1 + 52, 1> x_sig = 1;
  x_sig(51,0) = xs.sig(51,0);
  int x_exp = xs.expv();
  if ( x_exp>0 )  x_sig <<= x_exp;

  if ( (xs.exp==0) || ((xs.sign[0])&(generic_isinf(x))) || (generic_isnan(x)) || ((xs.sign[0]==1)&&(x_exp>=0)&&(x_sig==0)) )
    {
      out.sig = -1;
      return out.to_ieee();
    }
  if ( (generic_isinf(x)) || ((xs.sign[0]==0)&&((xs.exp>7)||((xs.exp==7)&&(xs.sig(51,47)>=11)))) )
    {
      return out.to_ieee();
    }
  else
    {
      double ret;
      double rt;
      if ( ~xs.sign[0] )
        {
          int exp2_adj;
          double tret = gamma_positive_fixed(x_fixed,&exp2_adj);
          //ret = generic_scalbn(tret,exp2_adj);//To improve accuracy exp2
           rt = exp_reduce::exp(ap_fixed<65,0>(exp2_adj));
          ret = rt*tret;
        }
      //		else if ( x>=-DBL_EPSILON/4 )
      //		{
      //			out.sig = -1;
      //			return out.to_ieee();
      //		}
      else
        {
          fp_struct<double> xs(x);
          ap_ufixed<8 + 52, 8> x_fix = 1;
          x_fix(51,0) = xs.sig(51,0);
          ap_uint<3> shl;
          shl(2,0) = xs.exp(2,0);
          shl++;
          x_fix <<= shl;
			
          //double tx = trunc(x);
          if ( (xs.sign[0]==1)&&((xs.exp>7)||((xs.exp==7)&&(xs.sig(51,48)>=7))) )
            ret = 0;
          else
            {
              ap_ufixed<0 + 52, 0> frac;
              frac(51,0) = x_fix(51,0);
              //double frac = tx-x;
              if ( frac[51] )
                frac = 1-frac;
              ap_fixed<64,32> hot1 = ((ap_fixed<2 + 52, 2>)M_PI*frac);
              ap_fixed<64,32> hot2 = ((ap_fixed<2 + 52, 2>)M_PI*((ap_ufixed<0 + 52, 0>)0.5-frac));
              ap_fixed<64,4> sin1 = hotbm_apfixed::sinf_or_cosf(hot1,0,0);
              ap_fixed<64,4> sin2 = hotbm_apfixed::sinf_or_cosf(hot2,1,0);
              double sinpix = ((~frac[51])&(~frac[50])) ?  sin1 : sin2;
              int exp2_adj;
              ap_fixed<W,I> x_fixedn = -x_fixed;
              double tret = M_PI/(-x*sinpix*gamma_positive_fixed(x_fixedn,&exp2_adj));
              //ret = generic_scalbn(tret,-exp2_adj);////To improve accuracy exp2
              rt = exp_reduce::exp(ap_fixed<65,0>(-exp2_adj));
              ret = rt*tret;

            }
        }
      return ap_fixed<W,I>(ret);
    }
}

    template<int W, int I>
    ap_ufixed<W,I> tgamma_generic (ap_ufixed<W,I> x) {
      ap_fixed<W+1,I+1> xf = x;
      return tgamma_generic(xf);
    }
    template<int I_>
    ap_int<I_> tgamma_generic(ap_int<I_> x) {
        ap_fixed<I_,I_> xf = x;
        return tgamma_generic(xf);
    }
    template<int I_>
    ap_uint<I_> tgamma_generic(ap_uint<I_> x) {
        ap_fixed<I_+1,I_+1> xf = x;
        return tgamma_generic(xf);
    }
    
  
}//tgamma_fixed

#endif


