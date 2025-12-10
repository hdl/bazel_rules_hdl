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
#ifndef _X_HLS_POW_APFIXED_H_
#define _X_HLS_POW_APFIXED_H_
#include "ap_fixed.h"
#include "hls_log_apfixed.h"
#include "hls_exp_apfixed.h"
#include "hls_round_copysign_apfixed.h"
namespace pow_apfixed_reduce{
/*
 * Normally, pow(x,y) = exp(ylog(|x|))*sig(x)^y. 
 * To make sure the result has 1ulp relative error, the relative error of log(|x|) is 2^(-W-I-2) and the relative error of ylog(|x|) is 2^(-W-2).
 * Exception handling. (Note: if 1 > Max, then return Max)
 * ============================================
 * ||     x     ||     y     ||    pow(x,y)
 * ||     0     ||     0     ||       1
 * ||     0     ||     <0    ||      Max
 * ||     0     ||     >0    ||       0
 * ||     1     ||   Random  ||       1
 * ||   Random  ||     0     ||       1
 * ||     <0    ||Not Integer||       0
 * ============================================
 */
template<int W_,int I_>
ap_fixed<W_,I_> pow(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y) {
    const static int F_ = W_ - I_;
    //only support ap_fixed with I < 34 and F < 33
    if (I_>34) return 0;
    else if (F_>33) return 0;
    ap_fixed<W_,I_> r = 0;
    
    bool r_is_neg = 0;
    bool y_is_frac = 0;
    //y is fraction or not
    if (F_>0&&y(F_-1,0)>0) 
        y_is_frac =1;
    if (x==0) {
        //x==0, y==0, return 0
        if (y==0&&I_>1) {
            return 1;
        //x==0, y==0, return 0
        } else if (y>0) {
            return 0;
        } else {
        //x==0, y<0, return the Max
            #pragma unroll
            for (int j = 0; j < W_-1; j++) r[j] = 1;
               r[W_-1] = 0;
            return r;
        }
    } else if (x<0) {
        //x<0 and y is fractoin, return 0(NaN)
        if (y_is_frac) return 0;
        //x<0 and y is integer, if y is odd, r is positive otherwise r is negative.
        else {
            if (y==0||(I_>1&&y[F_]==0))
                r_is_neg = 0;  
            else 
                r_is_neg = 1; 
        }
    }
    //|x|
    ap_fixed<W_+1,I_+1> x_e_1 = x;
    //avoid overflow after abs
    ap_fixed<W_+1,I_+1> x_p = 0;
    x_p = fabs_fixed(x_e_1);
    //ln(|x|)
    //extend width of fraction
    const static int E_l = I_+2;
    const static int F_l = W_+E_l;
    //The output of log shouble be less then 2^5
    const static int I_l = I_+1>6?I_+1:6;
    const static int W_l = F_l + I_l;
    //std::cout<<"[POW]x_p="<<x_p.to_string()<<std::endl;
    ap_fixed<W_l,I_l> x_l = x_p;
    //-------------------------------------------------------
    //std::cout<<"[POW]x_l="<<x_l.to_string()<<std::endl;
    ap_fixed<W_l,I_l> ln_x = log_apfixed_reduce::log(x_l);
    //std::cout<<"[POW]ln_x="<<ln_x.to_string()<<std::endl;
    //range of log is less 2^5
    ap_fixed<F_l+6,6> ln_x_s = ln_x;
    //---------------------------------------------------------
    //y*ln(|x|)--Maxprecision=2^(-W-2) 
    const static int FI_m = W_+2; 
    //The input of exp should be less then 2^5. If it > 2^5, i will definitely overflow. 
    const static int I_m = I_>6 ? I_ : 6;//add 1 due to min value is -2^I;
    const static int WI_m = FI_m + I_m; 
    const static int WO_m = F_ + I_m;
    ap_fixed<F_l+W_+6,6+I_> mul_y_ln = ln_x_s * y;
    //std::cout<<"[POW]mul_y_ln="<<mul_y_ln.to_string()<<std::endl;
    //Rounding 
    //ap_fixed<1+, 1> delta = 0;
    //delta[delta.wl()-1] = mul_e[mul_e.wl()-1];
    //delta[delta.wl()-delta.iwl()-1] = 1;
    //mul_e = mul_e + ( delta >> wf_m );
    //std::cout<<"mul_e="<<mul_e.to_string()<<std::endl;
    
    //check overflow before truncate
    ap_fixed<WO_m,I_m> exp_r = 0;
    ap_fixed<W_,I_> r_1 = 0;
    bool m_overf = 0;
    bool e_overf = 0;
    bool overf   = 0;
    //check overflow or underflow after multiply
    #pragma unroll
    for (int j = F_l+F_+I_m-1; j < F_l+W_+5; j++)
        if (mul_y_ln[F_l+W_+5]!=mul_y_ln[j])
            m_overf = 1;

    if (!m_overf) {
        //truncate multiply result
        ap_fixed<WI_m,I_m> mul_y_ln_s = mul_y_ln;
        //std::cout<<"[POW]mul_y_ln_s="<<mul_y_ln_s.to_string()<<std::endl;
        exp_r = exp_reduce::exp_core<WO_m,I_m,WI_m>(mul_y_ln_s);// 
        //std::cout<<"[POW]exp_r="<<exp_r.to_string()<<std::endl;
        //check overflow after exp
        if (I_<I_m) {
            #pragma unroll
            for (int j = WO_m-1; j >= W_-1; j--) {
                if (exp_r[j])
                    e_overf=1;
            }
        }
        r_1 = exp_r;
    }
    //overflow when exp reulst overflow or multiply result is positive and oveflow
    if (e_overf||(m_overf&&!mul_y_ln[F_l+W_+5])) {
        overf = 1;
    } 
    //sig(x)^y = -1
    if (r_is_neg) {
        //overflow, return MIN
        if (overf) {
            r=0;
            r[W_-1]=1;
        //return -exp(y*log(|x|))
        } else {
            if (r_1!=0) {
                r = -r_1;
                r[W_-1] = 1;
            }
        }
    //sig(x)^y =1
    } else {
        // return MAX
        if(overf) {
            r[W_-1] = 0;
            #pragma unroll
            for (int j = W_-2; j >= 0; j--)
               r[j] = 1;
        //return exp(y*log(|x|)
        } else {
            r = r_1;
        }
    }
    //std::cout<<"[OWW]r="<<r.to_double()<<std::endl;
    return r;
}
/*
 * Normally, pown(x,n) = exp(log(|x|)*n)*sig(x)^n. 
 * To make sure the result has 1ulp relative error,
 * the relative error of log(|x|) is 2^(-F-I/2+1) and the relative error of log(|x|)/n is 2^(-F-I/2).
 * Exception handling. (Note: if output > Max, then return Max)
 * ============================================
 * ||     x     ||     n     ||    pown(x,n)
 * ||     0     ||     0     ||       1
 * ||     0     ||    any    ||       0
 * ||     1     ||    any    ||       1
 * ||    -1     ||    any    ||       +1/-1
 * ||    any    ||     0     ||       1
 * ||    any    ||     1     ||       x
 * ||    any    ||    -1     ||      1/x
 * ||    x!=0   || n!=0,1,-1 ||    exp(log|x|*n)*sig(x)^n
 * ============================================
 *
 * optimization: implement the exp for input <W,I> I<5, W<32+5 and output<W,I> W<65, I<32
 */
template<int W_, int I_>
ap_fixed<W_,I_> pown(ap_fixed<W_,I_> x, int n) {
    #ifndef __SYNTHESIS__
    #ifdef HLS_DEBUG
    std::cout<<"[POWN]x="<<x.to_string()<<std::endl;
    std::cout<<"[POWN]n="<<n<<std::endl;
    #endif
    #endif
    const static int F_ = W_ - I_;
    //only support ap_fixed with I < 34 and F < 33
    if (I_>34)      return 0;
    else if (F_>33) return 0;

    ap_fixed<W_,I_> r = 0;
    ap_fixed<32,32> n_fix = n; 

    bool x_sig = x[W_-1];
    bool n_sig = n_fix[31];
    bool n_is_odd = n_fix[0]; 
    bool x_gt_0 = 0;

    if (x == 0 && n_fix != 0) r = 0;
    else if(n_fix == 0)  r = 1;
    else if(n_fix == 1)  r = x;
    //else if(n_fix == -1) r = 1/x;
    else if(x == 1)      r = 1;
    else if(x == -1) {
        if(n_is_odd) r = -1;
        else         r = 1;
    }else {
//if x in [2, Max], and (0, 0.5] 
//-------then n must be less than 32 to avoid overflow
//-------calculat the width of log
//-----------the extra width is 5 for 1ulp precision after mul;
//-----------the extra extern width is I+1 for 1ulp precision after exp; 
//x in [] for n >= 2, it will overflow;
//x in (0.5, 2) it will be difficult;
//==============================================================================
//||  I     ||  F  ||  x  || precision of log     ||  max(n)          || Note     ||
//|| any    ||  0  ||     ||   5 + I              ||  <32             || overflow ||
//||  0     || any ||     ||   5 + F                ||   >0             || overflow ||
//|| any    || <27 ||     || F + I + log2(max(n)) ||  Iln2/ln(1+1/2^F)||
//|| any    ||>=27 ||     ||  31 + F + I          ||  2^31            || 
//==============================================================================
//|| >18 i  || <27 ||     ||  5 + F + F + I       ||  Iln2/ln(1+1/2^F)|| 
//|| >9,<=18|| <27 ||     ||  4 + F + F + I       ||  Iln2/ln(1+1/2^F)||
//|| >4,<=9 || <27 ||     ||  3 + F + F + I       ||  Iln2/ln(1+1/2^F)||
//|| >2,<=4 || <27 ||     ||  2 + F + F + I       ||  Iln2/ln(1+1/2^F)||
//|| 2      || <27 ||     ||  1 + F + F + I       ||  Iln2/ln(1+1/2^F)|| maybe optimize further
//|| 1      || <27 ||     ||  0 + F + F + I       ||  Iln2/ln(1+1/2^F)||
//worse scenario
//x = 1 + 1/2^F, n = max
//x = 1 - 1/2^F, n = max
//x = 1 + 1/2^F, n = min
//x = 1 - 1/2^F, n = min
       
       const static int we_n = F_ > 26? 32 : 6 + F_;//F_+(I_+32)/(20+32) + (I_+32)/(11+32) + (I_+32)/(6+32) + (I_+32)/(4+32)+ (I_+32)/(3+32) + (I_+32)/(1+32);
       //const static ap_ufixed<32,32> max_n = we_n > 31? 2147483648:(1 << (we_n-1)) - 1;
       const static int wf_log = I_ == F_>26 ? (31+F_+I_) : (we_n-1+F_+I_);
       const static int I_e = I_>6 ? I_ : 6;//add 1 due to min value is -2^I;
       const static int WI_e = I_e + wf_log - we_n; 
       const static int WO_e = F_ + I_e;
       ap_fixed<33,33> max_n = 0;
       max_n[we_n-1] = 1;
       ap_ufixed<32,32> n_pos = fabs_fixed(ap_fixed<33,33>(n));
       ap_ufixed<WO_e,I_e> exp_r=0;
       bool ovf = 0;
       ap_ufixed<W_,I_> x_pos = fabs_fixed((ap_fixed<W_+1,I_+1>)x);
       if(x_pos>1) x_gt_0 = 1;
       ap_fixed<32,32> min_n = -max_n;
       if(n_fix != -1 && ((n >= max_n) || (n < min_n))){
           //overflow or underflow
           ovf = 1;
       }else {
           ap_fixed<we_n, we_n> n_s = n;
           #ifndef __SYNTHESIS__
           assert(n_s == n);
           #endif

           //extend the width of x to MaxPrecision
           const static int I_l = I_+1 < 6? 6 : I_+1;
           ap_fixed<wf_log+I_l,I_l> x_e = x_pos;
           const static int we_log = 6;//I_+1>6? I_+1:6;
           ap_fixed<wf_log+we_log,we_log> x_log = log_apfixed_reduce::log(x_e); 
           #ifndef __SYNTHESIS__
           #ifdef HLS_DEBUG
           std::cout<<"[POWN]x_log="<<x_log.to_string()<<std::endl;
           #endif
           #endif
           //the absolute of mul will enlagre
           ap_fixed<wf_log+we_log, we_log+we_n> x_log_mul_n = n_s * x_log;
           #ifndef __SYNTHESIS__
           #ifdef HLS_DEBUG
           std::cout<<"[POWN]x_log_mul_n="<<x_log_mul_n.to_string()<<std::endl;
           #endif
           #endif

           for(int i = wf_log+we_log-2; i > WI_e - 2; --i) {
           #pragma HLS unroll
                if(x_log_mul_n[i] != x_log_mul_n[wf_log+we_log-1]){
                //underflow or overflow
                    ovf = 1;
                }
           }
           ap_fixed<WI_e, I_e> x_log_mul_n_1 = x_log_mul_n ;
           #ifndef __SYNTHESIS__
           #ifdef HLS_DEBUG
           std::cout<<"x_log_mul_n_1="<<x_log_mul_n.to_string()<<std::endl;
           #endif
           #endif
           exp_r = exp_reduce::exp_core<WO_e,I_e,WI_e>(x_log_mul_n_1); 
           #ifndef __SYNTHESIS__
           #ifdef HLS_DEBUG
           std::cout<<"[POWN]exp_r="<<exp_r.to_string()<<std::endl;
           #endif
           #endif
           if (I_<I_e) {
               for (int j = WO_e-1; j >= W_-1; j--) {
               #pragma hls unroll
               //overflow 
                   if (exp_r[j])
                       ovf=1;
               }
           }
       } 
       if(ovf) {
           if(x_gt_0 ^ n_sig) {
           //overflow
               if(x_sig && !n_is_odd) {
                   r[W_-1] = 1;
               } else {
                   for(int i = 0; i < W_-1; ++i) {
                   #pragma HLS unroll
                      r[W_-1] = 1;
                   }
               }
           }
       } else {
           if(x_sig && n_is_odd) r = -exp_r;
           else                   r = exp_r;
       }
   }
   return r;
}

/*
 * Normally, rootn(x,n) = exp(log(|x|)/n)*sig(x)^(1/n). 
 * To make sure the result has 1ulp relative error,
 * the relative error of log(|x|) is 2^(-F-I/2+1) and the relative error of log(|x|)/n is 2^(-F-I/2).
 * Exception handling. (Note: if output > Max, then return Max)
 * ============================================
 * ||     x     ||     n     ||    rootn(x,n)
 * ||    any    ||     0     ||       0
 * ||    any    ||     1     ||       x
 * ||    any    ||    -1     ||      1/x
 * ||    x<0    || n is even ||       0
 * ||    x<0    || n is odd  ||  -exp(log(|x|)/n)
 * ||     0     ||    any    ||       0
 * ||     1     ||    !=0    ||       1
 * ||    -1     || n is odd  ||       -1
 * ||    x>0    ||    !=0    ||   exp(log(|x|)/n)
 * ============================================
 * optimization: implement the exp for input <W,I> W<65+32/2 and output<W,I> W<65, I<32
 */
//worst scenario
//x = 2^I, n = 2, r ~ 2^(I/2)
//x = 2^I, n = -2, r ~ 1/2^(I/2)
//x = 1/2^F, n = -2, r ~ 2^(F/2)
//x = 1/2^F, n = 2, r ~ 1/2^(F/2)
//extend width = min(I, max(F/2,I/2))
template<int W_,int I_>
ap_fixed<W_,I_> rootn(ap_fixed<W_,I_> x, int n) {
    #ifndef __SYNTHESIS__
    #ifdef HLS_DEBUG
    std::cout<<"x="<<x.to_string()<<std::endl;
    std::cout<<"n="<<n<<std::endl;
    #endif
    #endif
    const static int F_ = W_ - I_;
    //only support ap_fixed with I < 34 and F < 33
    if (I_ > 34)      return 0;
    else if (F_ > 33) return 0;

    ap_fixed<W_,I_> r = 0;
    ap_fixed<32,32> n_fix = n; 
    bool n_is_odd = 0;
    if(n_fix[0]) n_is_odd = 1;

    if (x == 0)         r = 0;
    else if(n_fix == 0) r = 0;
    else if(n_fix == 1) r = x;
    else if(n_fix == -1) r = ap_fixed<W_, I_>(1)/x;
    else if(x<0 && !n_is_odd) r = 0;
    else if(x==1)             r = 1;
    else if(x==-1 && n_is_odd) r = -1;
    else {
        //|x|
        ap_ufixed<W_,I_> x_p = fabs_fixed((ap_fixed<W_+1,I_+1>)x);
        //ln(|x|)
        //extend width of fraction
        const static int m_we = (F_+1)/2 > (I_+1)/2? (F_+1)/2:(I_+1)/2;
        const static int we = I_ > m_we ? m_we : I_; 
        const static int E_l = we - 1;
        const static int F_l = F_ + E_l;
        //The output of log shouble be less then 2^5
        const static int I_l = I_ + 1 > 6 ? I_ + 1 : 6;
        const static int W_l = F_l + I_l;
        //std::cout<<"[POW]x_p="<<x_p.to_string()<<std::endl;
        ap_fixed<W_l,I_l> x_l = x_p;
        //-------------------------------------------------------
        //std::cout<<"[POW]x_l="<<x_l.to_string()<<std::endl;
        ap_fixed<W_l,I_l> ln_x = log_apfixed_reduce::log(x_l);
        #ifndef __SYNTHESIS__
        #ifdef HLS_DEBUG
        std::cout<<"[ROOTN]ln_x="<<ln_x.to_string()<<std::endl;
        #endif
        #endif
        //range of log is less 2^5
        ap_fixed<F_l+6,6> ln_x_s = ln_x;
        //---------------------------------------------------------
        //ln(|x|)/n--Maxprecision=2^(-F-I/2) 
        const static int FI_d = F_l + 1; 
        //The input of exp should be less then 2^5. If it > 2^5, i will definitely overflow. 
        const static int I_d = we+1 > 5? we+1 : 5; 
        const static int WI_d = FI_d + I_d; 
        const static int WO_d = F_ + I_d;
        ap_fixed<F_l+6,5> divd_n_ln = ln_x_s / n_fix;
        #ifndef __SYNTHESIS__
        #ifdef HLS_DEBUG
        std::cout<<"[ROOTN]divd_yn_ln="<<divd_n_ln.to_string()<<std::endl;
        #endif
        #endif
    
        //truncate divide result
        ap_fixed<WI_d,I_d> divd_n_ln_s = divd_n_ln;
        #ifndef __SYNTHESIS__
        #ifdef HLS_DEBUG
        std::cout<<"[ROOTN]divd_n_ln_s="<<divd_n_ln_s.to_string()<<std::endl;
        #endif
        #endif
        ap_ufixed<WO_d, I_d> exp_r = exp_reduce::exp_core<WO_d,I_d,WI_d>(divd_n_ln_s);// 
        #ifndef __SYNTHESIS___
        #ifdef HLS_DEBUG
        std::cout<<"[ROOTN]exp_r="<<exp_r.to_string()<<std::endl;
        #endif
        #endif
        bool ovf = 0;
        //check overflow after exp
        if(I_ < I_d) {
           for (int j =WO_d-1; j >= W_-1; j--) {
           #pragma hls unroll
           //overflow 
               if (exp_r[j])
                   ovf=1;
           }
        }
        if(!ovf) {
           if(x[W_-1]&&n_is_odd) r = -exp_r; 
           else r = exp_r;
        }else {
           if(x[W_-1]&&n_is_odd) {
              r[W_-1] = 1;
           } else {
              for(int i = 0; i < W_-1; ++i) {
              #pragma HLS unroll
                  r[i] = 1;
              }
           }
        }
   }
   return r;
}


template<int W_, int I_>
ap_ufixed<W_,I_> pow(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y) {
    ap_fixed<W_+1,I_+1> xf = x;
    ap_fixed<W_+1,I_+1> yf = y;
    return pow(xf,yf);
}

template<int I_>
ap_int<I_> pow(ap_int<I_> x, ap_int<I_> y) {
    ap_fixed<I_,I_> xf = x;
    ap_fixed<I_,I_> yf = y;
    return pow(xf,yf);
}

template<int I_>
ap_uint<I_> pow(ap_uint<I_> x,ap_uint<I_> y) {
    ap_fixed<I_+1,I_+1> xf = x;
    ap_fixed<I_+1,I_+1> yf = y;
    return pow(xf,yf);
}
//powr is same with pown except for NaN, infinite. 
//for ap_fixed, no need consider the NaN, infinite.
template<int W_, int I_>
ap_fixed<W_,I_> powr(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y) {
    return pow(x,y); 
}

template<int W_, int I_>
ap_ufixed<W_,I_> powr(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y) {
    ap_fixed<W_+1,I_+1> xf = x;
    ap_fixed<W_+1,I_+1> yf = y;
    return pow(xf,yf);
}

template<int I_>
ap_int<I_> powr(ap_int<I_> x, ap_int<I_> y) {
    ap_fixed<I_,I_> xf = x;
    ap_fixed<I_,I_> yf = y;
    return pow(xf,yf);
}

template<int I_>
ap_uint<I_> powr(ap_uint<I_> x,ap_uint<I_> y) {
    ap_fixed<I_+1,I_+1> xf = x;
    ap_fixed<I_+1,I_+1> yf = y;
    return pow(xf,yf);
}

template<int W_, int I_>
ap_ufixed<W_,I_> pown(ap_ufixed<W_, I_> x, int n) {
    ap_fixed<W_+1,I_+1> xi = x;
    return pown(xi, n);
}

template<int I_>
ap_int<I_> pown(ap_int<I_> x, int n) {
   ap_fixed<I_, I_> xi = x;
   return pown(xi, n);
}

template<int I_>
ap_uint<I_> pown(ap_uint<I_> x, int n) {
   ap_fixed<I_+1, I_+1> xi = x;
   return pown(xi, n);
}
template<int W_, int I_>
ap_ufixed<W_,I_> rootn(ap_ufixed<W_, I_> x, int n) {
    ap_fixed<W_+1,I_+1> xi = x;
    return rootn(xi, n);
}

template<int I_>
ap_int<I_> rootn(ap_int<I_> x, int n) {
   ap_fixed<I_, I_> xi = x;
   return rootn(xi, n);
}

template<int I_>
ap_uint<I_> rootn(ap_uint<I_> x, int n) {
   ap_fixed<I_+1, I_+1> xi = x;
   return rootn(xi, n);
}
}
#endif

// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
