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
#ifndef _X_HLS_DIFF_APFIXED_H_
#define _X_HLS_DIFF_APFIXED_H_
#include "ap_fixed.h"
#include "ap_int.h"

//1. fdim_fixed
 /*
  * ============================================
  * ||     x     y            ||      fdim_fixed(x,y)
  * ||     (x-y) Normally     ||      (x  -  y)
  * ||     (x-y) overflow     ||         max
  * ||     x  <  y            ||          0
  * ============================================
  */
template <int W_, int I_>
ap_fixed<W_,I_> fdim_fixed(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y )
{
    #pragma HLS PIPELINE II=1
    ap_fixed<W_+1,I_+1>  x_overf = 0;
    ap_fixed<W_ ,I_ >         xs = 0;   
        bool               overf = 0;
    
    if(x > y)
    {
        x_overf = x - y;
        overf =  x_overf[W_-1];
        if(overf) { 
            #pragma UNROLL        
            for (int i = 0; i < W_-1; i++){            
                xs[i] = 1;
            }
            xs[W_-1] = 0;
        }
        else{
            x_overf[W_] = 0;            
            xs = x_overf;           
        }
    }   
    return xs;
}
template <int W_, int I_>
ap_ufixed<W_,I_> fdim_fixed(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y)
{
    ap_ufixed<W_ ,I_ > xs = 0;  
    if(x > y){ xs = x - y; }       
    return xs;
}
template <int I_>
ap_int<I_> fdim_fixed(ap_int<I_> x, ap_int<I_> y)
{
    ap_fixed<I_,I_> xs = x;
    ap_fixed<I_,I_> ys = y; 
    return fdim_fixed(xs, ys);
}
template <int I_>
ap_uint<I_> fdim_fixed(ap_uint<I_> x, ap_uint<I_> y)
{
    ap_uint<I_ >       xs = 0;  
    if(x > y) { xs = x - y; }       
    return xs;
}

//2. fmax_fixed
 /*
  * ============================================
  * ||     x        y         ||      fmax_fixed(x,y)
  * ||     x    >=  y         ||             x  
  * ||     x    <   y         ||             y
  * ============================================
  */
template <int W_, int I_>
ap_fixed<W_,I_> fmax_fixed(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y )
{
    ap_fixed<W_ ,I_ > xs = 0;   
    if(x >= y) xs = x ;
        else   xs = y ;
    return xs;
}
template <int W_, int I_>
ap_ufixed<W_,I_> fmax_fixed(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y)
{
    ap_ufixed<W_ ,I_ > xs = 0;  
    if(x >= y) xs = x;
        else   xs = y ; 
    return xs;
}
template <int I_>
ap_int<I_> fmax_fixed(ap_int<I_> x, ap_int<I_> y)
{
    ap_int<I_ >        xs = 0;  
    if(x >= y) xs = x;
        else   xs = y ; 
    return xs;
}
template <int I_>
ap_uint<I_> fmax_fixed(ap_uint<I_> x, ap_uint<I_> y)
{
    ap_uint<I_ >       xs = 0;  
    if(x >= y) xs = x;
        else   xs = y ; 
    return xs;
}

//3. fmin_fixed
 /*
  * ============================================
  * ||     x        y         ||      fmin_fixed(x,y)
  * ||     x    >   y         ||             y  
  * ||     x    <=  y         ||             x
  * ============================================
  */
template <int W_, int I_>
ap_fixed<W_,I_> fmin_fixed(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y )
{
    ap_fixed<W_ ,I_ > xs = 0;   
    if(x <= y) xs = x ;
        else   xs = y ;
    return xs;
}
template <int W_, int I_>
ap_ufixed<W_,I_> fmin_fixed(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y)
{
    ap_ufixed<W_ ,I_ > xs = 0;  
    if(x <= y) xs = x;
        else   xs = y ; 
    return xs;
}
template <int I_>
ap_int<I_> fmin_fixed(ap_int<I_> x, ap_int<I_> y)
{
    ap_int<I_ >        xs = 0;  
    if(x <= y) xs = x;
        else   xs = y ; 
    return xs;
}
template <int I_>
ap_uint<I_> fmin_fixed(ap_uint<I_> x, ap_uint<I_> y)
{
    ap_uint<I_ >       xs = 0;  
    if(x <= y) xs = x;
        else   xs = y ; 
    return xs;
}

// TODO DEBUG
//4. maxmag_fixed
 /*
  * ============================================
  * ||     x        y         ||      maxmag_fixed(x,y)
  * || max{|x|,|y|} overflow  ||            max  
  * ||    |x|   >=  |y|       ||             x  
  * ||    |x|   <   |y|       ||             y
  * ============================================
  */
template <int W_, int I_>
ap_fixed<W_,I_> maxmag_fixed(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y )
{
    #pragma HLS PIPELINE II=1
    ap_fixed<W_+1,I_+1> xm = -x;    
    ap_fixed<W_+1,I_+1> ym = -y;
    ap_fixed<W_+1,I_+1> x_fabs = ( x[W_-1] ) ? xm : ap_fixed<W_+1,I_+1>(x);
    ap_fixed<W_+1,I_+1> y_fabs = ( y[W_-1] ) ? ym : ap_fixed<W_+1,I_+1>(y);
    
    ap_fixed<W_+1,I_+1>   xs_t = 0;
    ap_fixed<W_,I_>         xs = 0;
    if(x_fabs >= y_fabs)
    {
    	xs_t = x_fabs ;
    	xs   = x;
    }
    else{
    	xs_t = y_fabs ;
    	xs   = y;
    }
    //case overflow
    if(xs_t[W_-1])
    {
            #pragma UNROLL        
            for (int i = 0; i < W_-1; i++){
                xs[i] = 1;
            }
            xs[W_-1] = 0;
    }

    return xs;
}
template <int W_, int I_>
ap_ufixed<W_,I_> maxmag_fixed(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y)
{
    ap_ufixed<W_ ,I_ > xs = 0;  
    if(x >= y) xs = x;
        else   xs = y ; 
    return xs;
}
template <int I_>
ap_int<I_> maxmag_fixed(ap_int<I_> x, ap_int<I_> y)
{
    ap_fixed<I_,I_> xs = x;
    ap_fixed<I_,I_> ys = y; 
    return maxmag_fixed(xs, ys);
}
template <int I_>
ap_uint<I_> maxmag_fixed(ap_uint<I_> x, ap_uint<I_> y)
{
    ap_uint<I_ >       xs = 0;  
    if(x >= y) xs = x;
        else   xs = y ; 
    return xs;
}


//5. minmag_fixed
 /*
  * ============================================
  * ||     x        y         ||      minmag_fixed(x,y)
  * || min{|x|,|y|} overflow  ||            max 
  * ||    |x|   >  |y|        ||             y  
  * ||    |x|  <=  |y|        ||             x
  * ============================================
  */
template <int W_, int I_>
ap_fixed<W_,I_> minmag_fixed(ap_fixed<W_,I_> x, ap_fixed<W_,I_> y )
{
    #pragma HLS PIPELINE II=1
    ap_fixed<W_+1,I_+1> xm = -x;    
    ap_fixed<W_+1,I_+1> ym = -y;
    ap_fixed<W_+1,I_+1> x_fabs = ( x[W_-1] ) ? xm : ap_fixed<W_+1,I_+1>(x);
    ap_fixed<W_+1,I_+1> y_fabs = ( y[W_-1] ) ? ym : ap_fixed<W_+1,I_+1>(y);
    
    ap_fixed<W_+1,I_+1>   xs_t = 0;
    ap_fixed<W_,I_>         xs = 0;
    if(x_fabs <= y_fabs)
    {
    	xs_t = x_fabs ;
    	xs   = x;
    }
    else{
    	xs_t = y_fabs ;
    	xs   = y;
    }
    if(xs_t[W_-1])
    {
            #pragma UNROLL        
            for (int i = 0; i < W_-1; i++){           
                xs[i] = 1;
            }
            xs[W_-1] = 0;
    }

    return xs;
}
template <int W_, int I_>
ap_ufixed<W_,I_> minmag_fixed(ap_ufixed<W_,I_> x, ap_ufixed<W_,I_> y)
{
    ap_ufixed<W_ ,I_ > xs = 0;  
    if(x <= y) xs = x;
        else   xs = y ; 
    return xs;
}
template <int I_>
ap_int<I_> minmag_fixed(ap_int<I_> x, ap_int<I_> y)
{
    ap_fixed<I_,I_> xs = x;
    ap_fixed<I_,I_> ys = y; 
    return minmag_fixed(xs, ys);
}
template <int I_>
ap_uint<I_> minmag_fixed(ap_uint<I_> x, ap_uint<I_> y)
{
    ap_uint<I_ >      xs = 0;  
    if(x <= y) xs = x;
        else   xs = y ; 
    return xs;
}
#endif


