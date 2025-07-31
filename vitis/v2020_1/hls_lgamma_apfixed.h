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
#include "hls_exp_apfixed.h"
#include "hls_log_apfixed.h"
#include "hls_hotbm_apfixed.h"
#include "utils/x_hls_defines.h"
#include "utils/x_hls_utils.h"
#include "utils/x_hls_traits.h"

    double lgamma_neg_apfixed (double x, int *signgamp);

namespace lgamma_fixed{

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
    ap_fixed<W,I> lgamma_r_generic (ap_fixed<W,I> x_fixed, int *signgamp)
    {
    #pragma HLS pipeline

      double x = x_fixed.to_double();
      fp_struct<double> xs(x);
      fp_struct<double> out;
      fp_struct<double> fp_abs(x);
      fp_abs.sign=0;
      out.sign[0] = 0;
      out.sig = 0;
      out.exp = fp_struct<double>::EXP_INFNAN;

//      *signgamp = 1;//to improve accuracy
      //double ix = fabs(x);
      if ( generic_isinf(x) )// to improve accuracy
        return ap_fixed<W,I>( out.to_ieee());
      if ( generic_isnan(x) ) {
        out.sig = -1;
        return ap_fixed<W,I>( out.to_ieee());
      }
      if ( xs.exp==0 ) {
        if ( xs.sign[0] )
          *signgamp = -1;
        out.sig = -1;
        return ap_fixed<W,I>( out.to_ieee());
      }
      if ( xs.exp<953 ) {
        if ( xs.sign[0] )
          *signgamp = -1;
        return -log_apfixed_reduce::log<W,I>(ap_fixed<W,I>(fp_abs.to_ieee()));
      }
      double nadj = 0;
      if ( xs.sign[0] ) {
        if ( xs.exp>=1075 ) {
          out.sig = -1;
          return ap_fixed<W,I>( out.to_ieee());
        }
        if ( (xs.exp>1 && xs.exp<4) || (xs.exp==1 && (xs.sig!=0)) || (xs.exp==4 && !(xs.sig[51] && xs.sig[50])) )//if ( (x<-2)&&(x>-28) )
          return ap_fixed<W,I>( lgamma_neg_apfixed(x,signgamp));
        const double pi = 3.14159265358979311600e+00;
        //double t = hotbm_::sin(pi*x);
        ap_fixed<1 - 1 + 52, 1 - 1> pix=(pi*x);
        ap_fixed<1 - 1 + 52, 2> t_fixed = hotbm_apfixed::sinf_or_cosf<52,0>(pix, 0, 0);
         double t = t_fixed.to_double();
        fp_struct<double> ts(t);
        fp_struct<double> tabs(t);
        if ( ts.exp==0 ) {
          out.sig = -1;
          return ap_fixed<W,I>( out.to_ieee());
        }
        ap_fixed<W,I> nadj_fixed = pi/(tabs.to_ieee()*fp_abs.to_ieee());
        nadj = log_apfixed_reduce::log<W,I>(nadj_fixed);
        if ( ts.sign[0] )
          *signgamp = -1;
        x = -x;
        xs.sign[0] = 0;
      }
      double r;
      if ( (xs.sig==0) && ((xs.exp==1023)||(xs.exp==1024)) ) {
        r = 0;
      } else if ( xs.exp<1024 ) {//x<2
        double y,z,p,p1,p2,p3;
        int i;
        const double tc = 1.46163214496836224576e+00;
        const double tc_m1 = 0.46163214496836224576e+00;
        ap_uint<20> x_sig_hi = (xs.sig>>32);
        if ( (xs.exp<1022) || ((xs.exp==1022)&&(x_sig_hi<=838860)) ) {
          //r = -log_apfixed_reduce::log(x);
          r = -log_apfixed_reduce::log<W,I>(x_fixed);
          if ( (xs.exp>1022) || ((xs.exp==1022)&&(x_sig_hi>=485700)) ) {
            y = 1-x;
            i = 0;
          } else if ( (xs.exp>1020) || ((xs.exp==1020)&&(x_sig_hi>=894561)) ) {
            y = x-tc_m1;
            i = 1;
          } else {
            y = x;
            i = 2;
          }
        } else {
          r = 0;
          if ( (xs.exp>1023) || ((xs.exp==1023)&&(x_sig_hi>=767171)) ) {
            y = 2-x;
            i = 0;
          } else if ( (xs.exp>1023) || ((xs.exp==1023)&&(x_sig_hi>=242884)) ) {
            y = x-tc;
            i = 1;
          } else {
            y = x-1;
            i = 2;
          }
        }
        switch(i) {

        case 0:
          {
            const double a0  =  7.72156649015328655494e-02; /* 0x3FB3C467, 0xE37DB0C8 */
            const double a1  =  3.22467033424113591611e-01; /* 0x3FD4A34C, 0xC4A60FAD */
            const double a2  =  6.73523010531292681824e-02; /* 0x3FB13E00, 0x1A5562A7 */
            const double a3  =  2.05808084325167332806e-02; /* 0x3F951322, 0xAC92547B */
            const double a4  =  7.38555086081402883957e-03; /* 0x3F7E404F, 0xB68FEFE8 */
            const double a5  =  2.89051383673415629091e-03; /* 0x3F67ADD8, 0xCCB7926B */
            const double a6  =  1.19270763183362067845e-03; /* 0x3F538A94, 0x116F3F5D */
            const double a7  =  5.10069792153511336608e-04; /* 0x3F40B6C6, 0x89B99C00 */
            const double a8  =  2.20862790713908385557e-04; /* 0x3F2CF2EC, 0xED10E54D */
            const double a9  =  1.08011567247583939954e-04; /* 0x3F1C5088, 0x987DFB07 */
            const double a10 =  2.52144565451257326939e-05; /* 0x3EFA7074, 0x428CFA52 */
            const double a11 =  4.48640949618915160150e-05; /* 0x3F07858E, 0x90A45837 */

            z = y*y;
            p1 = a0+z*(a2+z*(a4+z*(a6+z*(a8+z*a10))));
            p2 = z*(a1+z*(a3+z*(a5+z*(a7+z*(a9+z*a11)))));
            p  = y*p1+p2;
            r  += (p-0.5*y); break;
          }
        case 1:
          {
            const double tf  = -1.21486290535849611461e-01; /* 0xBFBF19B9, 0xBCC38A42 */
            const double tt  = -3.63867699703950536541e-18; /* 0xBC50C7CA, 0xA48A971F */
            const double t0  =  4.83836122723810047042e-01; /* 0x3FDEF72B, 0xC8EE38A2 */
            const double t1  = -1.47587722994593911752e-01; /* 0xBFC2E427, 0x8DC6C509 */
            const double t2  =  6.46249402391333854778e-02; /* 0x3FB08B42, 0x94D5419B */
            const double t3  = -3.27885410759859649565e-02; /* 0xBFA0C9A8, 0xDF35B713 */
            const double t4  =  1.79706750811820387126e-02; /* 0x3F9266E7, 0x970AF9EC */
            const double t5  = -1.03142241298341437450e-02; /* 0xBF851F9F, 0xBA91EC6A */
            const double t6  =  6.10053870246291332635e-03; /* 0x3F78FCE0, 0xE370E344 */
            const double t7  = -3.68452016781138256760e-03; /* 0xBF6E2EFF, 0xB3E914D7 */
            const double t8  =  2.25964780900612472250e-03; /* 0x3F6282D3, 0x2E15C915 */
            const double t9  = -1.40346469989232843813e-03; /* 0xBF56FE8E, 0xBF2D1AF1 */
            const double t10 =  8.81081882437654011382e-04; /* 0x3F4CDF0C, 0xEF61A8E9 */
            const double t11 = -5.38595305356740546715e-04; /* 0xBF41A610, 0x9C73E0EC */
            const double t12 =  3.15632070903625950361e-04; /* 0x3F34AF6D, 0x6C0EBBF7 */
            const double t13 = -3.12754168375120860518e-04; /* 0xBF347F24, 0xECC38C38 */
            const double t14 =  3.35529192635519073543e-04; /* 0x3F35FD3E, 0xE8C2D3F4 */

            z = y*y;
            double w = z*y;
            p1 = t0+w*(t3+w*(t6+w*(t9 +w*t12)));
            p2 = t1+w*(t4+w*(t7+w*(t10+w*t13)));
            p3 = t2+w*(t5+w*(t8+w*(t11+w*t14)));
            p  = z*p1-(tt-w*(p2+y*p3));
            r += (tf + p); break;
          }
        case 2:
          {
            const double u0  = -7.72156649015328655494e-02; /* 0xBFB3C467, 0xE37DB0C8 */
            const double u1  =  6.32827064025093366517e-01; /* 0x3FE4401E, 0x8B005DFF */
            const double u2  =  1.45492250137234768737e+00; /* 0x3FF7475C, 0xD119BD6F */
            const double u3  =  9.77717527963372745603e-01; /* 0x3FEF4976, 0x44EA8450 */
            const double u4  =  2.28963728064692451092e-01; /* 0x3FCD4EAE, 0xF6010924 */
            const double u5  =  1.33810918536787660377e-02; /* 0x3F8B678B, 0xBF2BAB09 */
            const double v1  =  2.45597793713041134822e+00; /* 0x4003A5D7, 0xC2BD619C */
            const double v2  =  2.12848976379893395361e+00; /* 0x40010725, 0xA42B18F5 */
            const double v3  =  7.69285150456672783825e-01; /* 0x3FE89DFB, 0xE45050AF */
            const double v4  =  1.04222645593369134254e-01; /* 0x3FBAAE55, 0xD6537C88 */
            const double v5  =  3.21709242282423911810e-03; /* 0x3F6A5ABB, 0x57D0CF61 */

            p1 = y*(u0+y*(u1+y*(u2+y*(u3+y*(u4+y*u5)))));
            p2 = 1+y*(v1+y*(v2+y*(v3+y*(v4+y*v5))));
            r += (-0.5*y + p1/p2);
          }
        }
      }
      else if ( xs.exp<1026 ) {// x<8

        const double s0  = -7.72156649015328655494e-02; /* 0xBFB3C467, 0xE37DB0C8 */
        const double s1  =  2.14982415960608852501e-01; /* 0x3FCB848B, 0x36E20878 */
        const double s2  =  3.25778796408930981787e-01; /* 0x3FD4D98F, 0x4F139F59 */
        const double s3  =  1.46350472652464452805e-01; /* 0x3FC2BB9C, 0xBEE5F2F7 */
        const double s4  =  2.66422703033638609560e-02; /* 0x3F9B481C, 0x7E939961 */
        const double s5  =  1.84028451407337715652e-03; /* 0x3F5E26B6, 0x7368F239 */
        const double s6  =  3.19475326584100867617e-05; /* 0x3F00BFEC, 0xDD17E945 */
        const double r1  =  1.39200533467621045958e+00; /* 0x3FF645A7, 0x62C4AB74 */
        const double r2  =  7.21935547567138069525e-01; /* 0x3FE71A18, 0x93D3DCDC */
        const double r3  =  1.71933865632803078993e-01; /* 0x3FC601ED, 0xCCFBDF27 */
        const double r4  =  1.86459191715652901344e-02; /* 0x3F9317EA, 0x742ED475 */
        const double r5  =  7.77942496381893596434e-04; /* 0x3F497DDA, 0xCA41A95B */
        const double r6  =  7.32668430744625636189e-06; /* 0x3EDEBAF7, 0xA5B38140 */

        ap_uint<3> i;
        ap_uint<51> x_frac = 0;
        if (~xs.exp[0]) {
          i[2] = 0;
          i[1] = 1;
          i[0] = xs.sig[51];
          x_frac(50,0) = xs.sig(50,0);
        } else {
          i[2] = 1;
          i[1] = xs.sig[51];
          i[0] = xs.sig[50];
          x_frac(50,1) = xs.sig(49,0);
        }
        fp_struct<double> ys(double(0));
    #pragma unroll
        for ( ap_uint<6> pos = 50; pos >=0; pos-- ) {
          if ( x_frac[pos] ) {
            ys.exp = pos - 51;
            ys.sig(51,51-pos) = x_frac(pos,0);
            break;
          }
        }
        double y = ys.to_ieee();
        //int i = (int)x;
        //double t = 0;
        //double y = x-(double)i;
        double p = y*(s0+y*(s1+y*(s2+y*(s3+y*(s4+y*(s5+y*s6))))));
        double q = 1+y*(r1+y*(r2+y*(r3+y*(r4+y*(r5+y*r6)))));
        r = 0.5*y+p/q;
        double z = 1;
        switch(i) {
        case 7: z *= (y+6.0);	/* FALLTHRU */
        case 6: z *= (y+5.0);	/* FALLTHRU */
        case 5: z *= (y+4.0);	/* FALLTHRU */
        case 4: z *= (y+3.0);	/* FALLTHRU */
        case 3: z *= (y+2.0);	/* FALLTHRU */
          r =r + log_apfixed_reduce::log<W,I>(ap_fixed<W,I>(z)).to_double(); break;
        }

      } else if ( xs.exp<1081 ) {

        const double w0  =  4.18938533204672725052e-01; /* 0x3FDACFE3, 0x90C97D69 */
        const double w1  =  8.33333333333329678849e-02; /* 0x3FB55555, 0x5555553B */
        const double w2  = -2.77777777728775536470e-03; /* 0xBF66C16C, 0x16B02E5C */
        const double w3  =  7.93650558643019558500e-04; /* 0x3F4A019F, 0x98CF38B6 */
        const double w4  = -5.95187557450339963135e-04; /* 0xBF4380CB, 0x8C0FE741 */
        const double w5  =  8.36339918996282139126e-04; /* 0x3F4B67BA, 0x4CDAD5D1 */
        const double w6  = -1.63092934096575273989e-03; /* 0xBF5AB89D, 0x0B9E43E4 */

        double t = log_apfixed_reduce::log<W,I>(x_fixed);
        double z = 1/x;
        double y = z*z;
        double w = w0+z*(w1+y*(w2+y*(w3+y*(w4+y*(w5+y*w6)))));
        r = (x-0.5)*(t-1)+w;

      } else{
    	 ap_fixed<W,I> logx = log_apfixed_reduce::log<W,I>(x_fixed);
        r = x*((double)logx-1);
      }
      if ( x<0 )
        r = nadj-r;
      return ap_fixed<W,I>( r);
    }
    
    template<int W, int I>
    ap_fixed<W,I> lgamma_generic (ap_fixed<W,I> x) {
      int *signgamp = 0;
      return lgamma_r_generic(x,signgamp);
    }

    template<int W, int I>
    ap_ufixed<W,I> lgamma_generic (ap_ufixed<W,I> x) {
      ap_fixed<W+1,I+1> xf = x;
      return lgamma_generic(xf);
    }
    template<int I_>
    ap_int<I_> lgamma_generic(ap_int<I_> x) {
        ap_fixed<I_,I_> xf = x;
        return lgamma_generic(xf);
    }
    template<int I_>
    ap_uint<I_> lgamma_generic(ap_uint<I_> x) {
        ap_fixed<I_+1,I_+1> xf = x;
        return lgamma_generic(xf);
    }

    template<int W, int I>
        ap_ufixed<W,I> lgamma_r_generic (ap_ufixed<W,I> x, int *signgamp) {
	      ap_fixed<W+1,I+1> xf = x;
	      return lgamma_r_generic(xf, signgamp);
	    }
	    template<int I_>
	    ap_int<I_> lgamma_r_generic(ap_int<I_> x, int *signgamp) {
	        ap_fixed<I_,I_> xf = x;
	        return lgamma_r_generic(xf, signgamp);
	    }
	    template<int I_>
	    ap_uint<I_> lgamma_r_generic(ap_uint<I_> x, int *signgamp) {
	        ap_fixed<I_+1,I_+1> xf = x;
	        return lgamma_r_generic(xf, signgamp);
	    }
}//lgamma_fixed


#if 0
namespace hls{
  template<int W, int I>
  ap_fixed<W,I> lgamma_r(ap_fixed<W,I> x, int *signgamp){
    return lgamma_fixed::lgamma_r_generic(x, signgamp);
  }
  template<int W, int I>
  ap_ufixed<W,I> lgamma_r(ap_ufixed<W,I> x, int *signgamp){
    return lgamma_fixed::lgamma_r_generic(x, signgamp);
  }
  template<int I>
  ap_int<I> lgamma_r(ap_int<I> x, int *signgamp){
    return lgamma_fixed::lgamma_r_generic(x, signgamp);
  }
  template<int I>
  ap_uint<I> lgamma_r(ap_uint<I> x, int *signgamp){
    return lgamma_fixed::lgamma_r_generic(x, signgamp);
  }
    //lgamma(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> lgamma(ap_fixed<W,I> x){
    return lgamma_fixed::lgamma_generic(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> lgamma(ap_ufixed<W,I> x){
    return lgamma_fixed::lgamma_generic(x);
  }
  template<int I>
  ap_int<I> lgamma(ap_int<I> x){
    return lgamma_fixed::lgamma_generic(x);
  }
  template<int I>
  ap_uint<I> lgamma(ap_uint<I> x){
    return lgamma_fixed::lgamma_generic(x);
  }
}
#endif

#endif

