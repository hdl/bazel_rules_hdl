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
  * @file hls_cbrt_apfixed.h"
  * @brief Implemenation of cube root for ap_fixed data type. 
  */ 
#ifndef _X_HLS_CBRT_FIXED_H_
#define _X_HLS_CBRT_FIXED_H_
#include "ap_fixed.h"
#include "hls_round_copysign_apfixed.h" 
namespace cbrt_internal{
template <int W, int I>
ap_fixed<W, I> cbrt_fixed(ap_fixed<W,I> x) {
#ifndef __SYNTHESIS__
   #ifdef HLS_DEBUG
   std::cout<<"W="<<W<<", I="<<I<<std::endl;
   std::cout<<"x="<<x<<std::endl;
   #endif
#endif
   const int F = W - I;
   if(I > 33) return 0;
   else if(F > 32) return 0;

   ap_fixed<W+1, I+1> xi = x;
   ap_ufixed<W, I> x_p = fabs_fixed(xi);
#ifndef __SYNTHESIS__ 
   #ifdef HLS_DEBUG
   std::cout<<"x_p="<<x_p<<std::endl;
   #endif
#endif
   ap_ufixed<F +(I+2)/3, (I+2)/3> r = 0;; 
      const static int prcs = (F+1)*3;
      const static int msbr = (I>0)? (I+2)/3 : 1;//width of result
      ap_ufixed<2*msbr+prcs+2,2*msbr+2> resq = 0;//square of result;
      ap_ufixed<msbr+prcs+1,  msbr+1>   res  = 0;//result
      ap_ufixed<3*msbr+prcs+4, 3*msbr+4> x_rem = x_p;
      for(int pos = msbr - 1 ; pos >= -F-1; pos--) {
          ap_ufixed<3*msbr+prcs+2,   3*msbr+2> mul1a = 0;
          ap_ufixed<3*msbr+prcs+1,   3*msbr+1> mul1b = 0;
#ifndef __SYNTHESIS__
          assert(resq(prcs+2*pos+1,0)==0);
#endif
          //2*resq*bit
          mul1a(pos+2*msbr+prcs+2,   prcs+3*pos+3) = resq(prcs+2*msbr+1, prcs+2*pos+2); 
          //resq*bit
          mul1b(pos+2*msbr+prcs+1,   prcs+3*pos+2) = resq(prcs+2*msbr+1, prcs+2*pos+2);
#ifndef __SYNTHESIS__
          assert(res(prcs+pos,0)==0);
#endif
          ap_ufixed<3*msbr+prcs,   3*msbr>   mul2a = 0;
          ap_ufixed<3*msbr+prcs-1, 3*msbr-1> mul2b = 0;
          //2*res*bit^2;
          mul2a(pos*2+msbr+prcs+1,   pos*3+2+prcs) = res(msbr+prcs, pos+1+prcs);
          //res*bit^2
          mul2b(pos*2+msbr+prcs,     pos*3+1+prcs) = res(msbr+prcs, pos+1+prcs);
           
          ap_ufixed<3*msbr+prcs+3,   3*msbr+3>   mulL = 0;
          ap_ufixed<3*msbr+prcs+3,   3*msbr+3>   mulH = 0;
          //four adder -> 2 bit carry
          //only keep(pos*2+msbr+prcs-1, pos*3+1+prcs)
          mulL(pos*2+msbr+prcs+3, pos*3+1+prcs) = mul2b(pos*2+msbr+prcs, pos*3+1+prcs) + mul2a(pos*2+msbr+prcs+1, pos*3+1+prcs) + mul1a(pos*2+msbr+prcs+1, pos*3+1+prcs) + mul1b(pos*2+msbr+prcs+1,pos*3+1+prcs); 
           //only keep(pos+2*msbr+prcs+2, pos*2+msbr+prcs)
          mulH(pos+2*msbr+prcs+3, pos*2+msbr+prcs+2) = mulL(pos*2+msbr+prcs+3, pos*2+msbr+prcs+2) + mul1a(pos+2*msbr+prcs+2,pos*2+msbr+prcs+2) + mul1b(pos+2*msbr+prcs+1,pos*2+msbr+prcs+2);
          mulL[3*pos+prcs] = 1;          

#ifndef __SYNTHESIS__
          #ifdef HLS_DEBUG
          std::cout<<"mulH="<<mulH<<std::endl;
          std::cout<<"mulL="<<mulL<<std::endl;
          #endif
#endif
          bool cond1 = (x_rem(pos+2*msbr+prcs+4,pos*2+msbr+prcs+2) >  mulH(pos+2*msbr+prcs+3,pos*2+msbr+prcs+2));
          bool cond2 = (x_rem(pos+2*msbr+prcs+4,pos*2+msbr+prcs+2) == mulH(pos+2*msbr+prcs+3,pos*2+msbr+prcs+2));
          bool cond3 = (x_rem(pos*2+msbr+prcs+1,pos*3+prcs) >= mulL(pos*2+msbr+prcs+1,pos*3+prcs));
          if(cond1 | (cond2 & cond3)) {
             ap_ufixed<3*msbr+prcs+3,3*msbr+3> x_rem_L = 0;
             x_rem_L(pos*2+msbr+prcs+1, pos*3+prcs) = x_rem(pos*2+msbr+prcs+1, pos*3+prcs);
             //carry
             x_rem_L[pos*2+msbr+prcs+2] = cond3? 0 : 1;
             x_rem(pos+2*msbr+prcs+4,pos*2+msbr+prcs+2) = x_rem(pos+2*msbr+prcs+4, pos*2+msbr+prcs+2) - mulH(pos+2*msbr+prcs+3,pos*2+msbr+prcs+2) - x_rem_L(pos*2+msbr+prcs+2,pos*2+msbr+prcs+2);
             x_rem(pos*2+msbr+prcs+1,pos*3+prcs) = x_rem_L(pos*2+msbr+prcs+2, pos*3+prcs) - mulL(pos*2+msbr+prcs+1,pos*3+prcs);
             
#ifndef __SYNTHESIS__
             assert(res(pos+prcs,0)==0);
             assert(resq(pos*2+1+prcs,0)==0);
#endif
             ap_ufixed<2*msbr+prcs+1,2*msbr+1> mul1 = 0;
             mul1(pos+msbr+prcs+1, 2*pos+2+prcs) = res(msbr+prcs, pos+1+prcs);
             ap_ufixed<2*msbr+prcs+2,2*msbr+2> resq_L = 0;
             resq_L(pos+msbr+prcs+2,2*pos+2+prcs) = resq(pos+msbr+prcs+1,2*pos+2+prcs) + mul1(pos+msbr+prcs+1,2*pos+2+prcs);
             resq(pos+msbr+prcs+1,2*pos+2+prcs) = resq_L(pos+msbr+prcs+1,2*pos+2+prcs);
             resq(2*msbr+prcs+1,pos+msbr+2+prcs) = resq(2*msbr+prcs+1,pos+msbr+2+prcs) + resq_L(pos+msbr+2+prcs,pos+msbr+2+prcs);
             resq[2*pos+prcs] = 1;
             res[pos+prcs] = 1;
         }
#ifndef __SYNTHESIS__
         #ifdef HLS_DEBUG
         std::cout<<"pos="<<pos<<std::endl;
         std::cout<<"res="<<res.to_string()<<std::endl;
         std::cout<<"resq="<<resq<<std::endl;
         std::cout<<"x_rem="<<x_rem<<std::endl;
         #endif
#endif
      }
#ifndef __SYNTHESIS__
      #ifdef HLS_DEBUG
        std::cout<<"res="<<res<<std::endl;
      #endif
#endif
      ap_ufixed<1,-F-1> delta;
      delta[0] = 1;
      ap_ufixed<msbr+F+1,msbr> res_s = res;
      res_s += delta;
      r = res_s;
      if(x[W-1]) return -r;
      else       return r;
}

template<int W, int I>
ap_ufixed<W, I> cbrt_fixed(ap_ufixed<W, I> x) {  
   ap_fixed<W+1,I+1> xi = x;
   return cbrt_fixed(xi);
}
template<int I>
ap_int<I> cbrt_fixed(ap_int<I> x) {
   ap_fixed<I,I> xi = x;
   return cbrt_fixed(xi);
}
template<int I>
ap_uint<I> cbrt_fixed(ap_uint<I> x) {
   ap_fixed<I+1,I+1> xi = x;
   return cbrt_fixed(xi);
}
}
#endif



