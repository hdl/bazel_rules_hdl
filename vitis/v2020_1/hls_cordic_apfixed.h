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
 *     (c) Copyright 2008-2018 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef _X_HLS_CORDIC_APFIXED_H_
#define _X_HLS_CORDIC_APFIXED_H_

#if !defined(__SYNTHESIS__) && defined(_MSC_VER)
#include <iso646.h>
#endif

#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_fpo.h"
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
#include <iostream>
#endif

namespace cordic_apfixed {

  extern const ap_ufixed<128,2> circ_table_arctan_128[128];
  extern const int hyperb_table_tau_128[128];
  extern const ap_ufixed<128,4> hyperb_table_arctanh_128[128];

  /*
   * Range reduces input to between 0 and pi/2 by
   * solving for k and r in x = k*(pi/2) + r
   */
  template<int W, int I, int Wo>
  void circ_range_redux( ap_ufixed<W,I> x,
                         ap_uint<2> &k,
                         ap_ufixed<Wo,1> &r) {
    
    ap_ufixed<(Wo+I),0> inv_pi2("0x0.A2F9836E4E43FC715BBF"); // 2/pi
    ap_ufixed<Wo+1,1> pi2("1.5707963267948966192313216916397514420985846996876"); // pi/2
    ap_ufixed<Wo+I,I> prod = x * inv_pi2;
    ap_uint<I> kint = prod;

    k = kint;
    r = x - kint * pi2;
  };

  /*
   * Main CORDIC sub-function
   * MODE 0: 'Rotation' : rotate by angle z.  x' <- K*(x*cos(z) - y*sin(z)), y' <- K*(x*sin(z) + y*cos(z))
   * MODE 1: 'Vectoring': rotate y to zero.   x' <- sqrt(x^2 + y^2)  , z' <- atan(y/x)
   */
  template<int W, int I, int MODE>
  void cordic_circ_apfixed( ap_fixed<W,I> &x, 
                            ap_fixed<W,I> &y, 
                            ap_fixed<W,I> &z) {

    const int Nmax = W;

    ap_fixed<W,I> tx, ty, tz;
    ap_fixed<W,I> x_s, y_s, z_s;
    ap_uint<1> d;

    for (int n=0; n<Nmax; n++){
#pragma HLS pipeline      

      if(MODE == 1) { // Vectoring mode
        d = ~y[W-1];
      } 
      else {          // Rotation mode 
        d = z[W-1];
      }

      x_s = x >> n;
      y_s = y >> n;
      z_s = circ_table_arctan_128[n];
     
      if(d){          // y[n-1] is positive
        tx = x + y_s;
        ty = y - x_s;
        tz = z + z_s;
      }
      else{ 
        tx = x - y_s;
        ty = y + x_s;
        tz = z - z_s;
      }

      x = tx; 
      y = ty; 
      z = tz;

#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
      std::cout << "  x_s: " << x_s
                << "  y_s: " << y_s
                << "  z_s: " << z_s
                << "  x : " << x
                << "  y : " << y
                << "  z : " << z << std::endl;
#endif
#endif
    }
  };


  /*
   * Main double-CORDIC sub-function
   * MODE 0: asin
   * MODE 1: acos
   */
  template<int W, int I, int MODE, int INTYPE>
  void doublecordic_apfixed( ap_fixed<W,I> &x, 
                             ap_fixed<W,I> &y, 
                             ap_fixed<W,I> &z, 
                             ap_fixed<W,I> &t) {

    const int Nmax = W - I + 1;

    for (int n=0; n<Nmax; n++){

      if(INTYPE==64){
#pragma HLS pipeline II=5
      }
      else if(INTYPE==32){
#pragma HLS pipeline II=3
      }
      else if(INTYPE==16){
#pragma HLS pipeline II=1
      }
      else{
#pragma HLS pipeline II=4
      }

      ap_uint<1> d;
      if(MODE == 0) { // asin
        if(y<=t){
          d = x[W-1];
        }
        else{
          d = ~x[W-1];
        }
      } 
      else {          // acos
        if(x>=t){
          d = y[W-1];
        }
        else{
          d = ~y[W-1];
        }
      }

      ap_fixed<W,I> x_s = x >> (n-1);
      ap_fixed<W,I> y_s = y >> (n-1);
      ap_fixed<W,I> x_s2 = x_s >> (n+1);
      ap_fixed<W,I> y_s2 = y_s >> (n+1);

      x = x - x_s2;
      y = y - y_s2;
      if(d){ // d==1, negtive
        x = x + y_s;
        y = y - x_s;
      }
      else{  // d==0, positive
        x = x - y_s;
        y = y + x_s;
      }

      // t
      ap_fixed<W,I> t_s;
      int n2 = (n << 1); // 2*n
      if(n2<W){
        t_s = (t >> n2);
        t = t + t_s;
      }

      // z
      ap_fixed<W,I> ca = circ_table_arctan_128[n];
      ap_fixed<W,I> z_s = (ca << 1);
      ap_fixed<W,I> tz;
      if(d){ // d==1, negtive
        tz = z - z_s;
      }
      else{  // d==0, positive
        tz = z + z_s;
      }
      z = tz;

#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
      std::cout << "  x : " << x
                << "  y : " << y
                << "  z : " << z 
                << "  t : " << t 
                << std::endl;
#endif
#endif
    }
  };


  // sin cos
  template<int W, int I>
  void generic_sincos(ap_fixed<W,I> in, 
                      ap_fixed<W-I+2,2> & outsin, ap_fixed<W-I+2,2> & outcos){ 

    ap_uint<1> sign0 = (in > 0) ? 1: 0;

    // abs(in)
    ap_ufixed<W,I> inabs;
    if(sign0)
      inabs = in;
    else
      inabs = -in;

    // inabs = k * (pi/2) + r
    const int Fr = (W - I) + I + 1;
    ap_uint<2> k;
    ap_ufixed<Fr,1> r;
    circ_range_redux(inabs, k, r);

    ap_fixed<W+2,3> x, y, z;

    const ap_fixed<W+2,3> K1("0x0.9B74EDA8435E47F277F7");
    x = K1;
    y = 0;
    
    if(k==1 or k==3){
      ap_ufixed<Fr,1> pi2("0x1.921FB54442D1846");
      // ap_ufixed<Fr,1> pi2("1.5707963267948966192313216916397514420985846996876");
      z = pi2 - r;
    }
    else{
      z = r;
    }
    
#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
    std::cout << "xyz:  " << x << "  " << y << "  " << z << std::endl;
#endif
#endif
    
    cordic_circ_apfixed<W+2,3,0>(x,y,z);
    
#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
    std::cout << "xyz:  " << x << "  " << y << "  " << z << std::endl;
#endif  
#endif
    
    if(k==0){
      outsin = y;
      outcos = x;
    }
    else if(k==1){
      outsin = y;
      outcos = -x;
    }
    else if(k==2){
      outsin = -y;
      outcos = -x;
    }
    else{
      outsin = -y;
      outcos = x;
    }
    
    if(sign0==0)
      outsin = -outsin; 
  }; 
  
  // tan
  template<int W, int I>
  ap_fixed<W,I> generic_tan(ap_fixed<W,I> x){
    
    const int Ix = I;
    const int Fx = (((W-I)>(I-1)) ? (W-I): (I-1)) + I;
    const int Wx = I + Fx;

    ap_fixed<Wx,Ix> xs = x;

    ap_fixed<Wx-Ix+2,2> outsin;
    ap_fixed<Wx-Ix+2,2> outcos; 
    generic_sincos(xs, outsin, outcos);

    ap_fixed<W,I> out = outsin / outcos;

    // overflow tan
    if(I==1){
      if(out[W-1]==1){
        out[W-1] = 0;
        for(int i=0;i<W-1;i++){
#pragma HLS UNROLL
          out[i] = 1;
        }     
      }
    }

    return out;
  };

    // tan(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> generic_tan(ap_ufixed<W,I> in) {
    ap_fixed<W+1,I+1> fin = in;
    ap_fixed<W+1,I+1> fout = generic_tan(fin);
    ap_ufixed<W,I> out = 0;
    if(fout[W]==0){
        out = fout;
    }
    return out;
  };  

  // tan(ap_int)
  template<int I>
  ap_int<I> generic_tan(ap_int<I> in) {
    ap_fixed<I,I> fin = in;
    ap_fixed<I,I> fout = generic_tan(fin);
    ap_int<I> out = fout;
    return out;
  };  

  // tan(ap_uint)
  template<int I>
  ap_uint<I> generic_tan(ap_uint<I> in) {
    ap_fixed<I+1,I+1> fin = in;
    ap_fixed<I+1,I+1> fout = generic_tan(fin);
    ap_uint<I> out = 0;
    if(fout[I]==0){
        out = fout;
    }   
    return out;
  };  

  /*
   * for tanpi
   */
   
  /*
   * Range reduces input to between 0 and pi/2 by
   * solving for k and r in pi*x = k*(pi/2) + r
   */
  template<int W, int I, int Wo>
  void circ_range_redux_pi(  ap_ufixed<W,I> x,
                             ap_uint<2> &k,
                             ap_ufixed<Wo,1> &r) {
    //ap_ufixed<(Wo+I),2> v_2("2.000000000000000000");
    ap_ufixed<Wo+1,1> pi2("1.5707963267948966192313216916397514420985846996876");
    ap_ufixed<W+1,I+1> prod = x << 1;//mul_2;
    ap_uint<I+1> kint = prod;

    k = kint;
    r = (prod - kint) * pi2;
  };
  // sinpi cospi
  template<int W, int I>
  void generic_sincospi(ap_fixed<W,I> in,
                      ap_fixed<W-I+2,2> & outsin, ap_fixed<W-I+2,2> & outcos){

    ap_uint<1> sign0 = (in > 0) ? 1: 0;

    // abs(in)
    ap_ufixed<W,I> inabs;
    if(sign0)
      inabs = in;
    else
      inabs = -in;

    // inabs = k * (pi/2) + r
    const int Fr = (W - I) + I + 1;
    ap_uint<2> k;
    ap_ufixed<Fr,1> r;
    circ_range_redux_pi(inabs, k, r);

    ap_fixed<W+2,3> x, y, z;

    const ap_fixed<W+2,3> K1("0x0.9B74EDA8435E47F277F7");
    x = K1;
    y = 0;

    if(k==1 or k==3){
      ap_ufixed<Fr,1> pi2("0x1.921FB54442D1846");
      z = pi2 - r;
    }
    else{
      z = r;
    }

#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
    std::cout << "xyz:  " << x << "  " << y << "  " << z << std::endl;
#endif
#endif

    cordic_circ_apfixed<W+2,3,0>(x,y,z);

#ifdef _HLSCLIB_DEBUG_
#ifndef __SYNTHESIS__
    std::cout << "xyz:  " << x << "  " << y << "  " << z << std::endl;
#endif
#endif

    if(k==0){
      outsin = y;
      outcos = x;
    }
    else if(k==1){
      outsin = y;
      outcos = -x;
    }
    else if(k==2){
      outsin = -y;
      outcos = -x;
    }
    else{
      outsin = -y;
      outcos = x;
    }

    if(sign0==0)
      outsin = -outsin;
  };

  // tanpi
  template<int W, int I>
  ap_fixed<W,I> generic_tanpi(ap_fixed<W,I> x){

    const int Ix = I;
    const int Fx = (((W-I)>(I-1)) ? (W-I): (I-1)) + I;
    const int Wx = I + Fx;

    ap_fixed<Wx,Ix> xs = x;

    ap_fixed<Wx-Ix+2,2> outsin;
    ap_fixed<Wx-Ix+2,2> outcos;
    generic_sincospi(xs, outsin, outcos);

    ap_fixed<W,I> out;
    ap_int<1> bpoint=0;
    if(!outcos){
        bpoint = 1;
    }else{
        out = outsin / outcos;
    }
    //ap_fixed<W,I,AP_RND,AP_SAT_SYM> out = outsin / outcos;

    // overflow tan
    // overflow in I ==1 and value< 0
    if(I==1||bpoint){
      if( out[W-1]==1  ){//
        out[W-1] = 0;
        for(int i=0;i<W-1;i++){
#pragma HLS UNROLL
          out[i] = 1;
        }
      }
    }
//  double test_o = out.to_double();
    return out;
  };

  // tanpi(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> generic_tanpi(ap_ufixed<W,I> in) {
    ap_fixed<W+1,I+1> fin = in;
    ap_fixed<W+1,I+1> fout = generic_tanpi(fin);
    ap_ufixed<W,I> out = 0;
    if(fout[W]==0){
        out = fout;
    }
    return out;
  };

  // tanpi(ap_int)
  template<int I>
  ap_int<I> generic_tanpi(ap_int<I> in) {
    return ap_int<I>(0);
  };

  // tanpi(ap_uint)
  template<int I>
  ap_uint<I> generic_tanpi(ap_uint<I> in) {
    return ap_uint<I>(0);
  };

  // atan
  template<int W, int I>
  ap_fixed<W,2> generic_atan(ap_fixed<W,I> in){ 
    
    ap_uint<1> sign0 = (in > 0) ? 1: 0;

    // abs(in)
    ap_fixed<W+1,I+1> inabs;
    if(sign0)
      inabs = in;
    else
      inabs = -in;

    // sign1
    ap_uint<1> sign1 = (inabs > 1) ? 1: 0;

    ap_fixed<W+2,3> x, y, z;
    if(sign1){
      x = 1;
      // y = ap_fixed<W+2,3>("0x1.0") / inabs;
      y = 1.0 / inabs.to_double();
      z = 0;
    }
    else{
      x = 1;
      y = inabs;
      z = 0;
    }
    cordic_circ_apfixed<W+2,3,1>(x,y,z);

    ap_fixed<W,2> out;
    if(sign1){
      const ap_fixed<W,2> pi2("0x1.921FB54442D1846"); // pi/2
      out = pi2 - z;
    }
    else{
      out = z;
    }

    // return
    if(sign0){
      return out;
    }
    else{
      return -out;
    } 
  }; 

  // atan(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,2> generic_atan(ap_ufixed<W,I> in){ 
    ap_fixed<W+1,I+1> fin = in;
    ap_fixed<W+1,2> fout = generic_atan(fin);
    ap_ufixed<W,2> out = 0;
    if(fout[W]==0){
        out = fout;
    }   
    return out;
  };

  // atan(ap_int)
  template<int I>
  ap_int<2> generic_atan(ap_int<I> in){ 
    if(in<-1)
      return ap_int<2>(-1);
    else if(in>1)
      return ap_int<2>(1);
    else
      return ap_int<2>(0);
  };

  // atan(ap_uint)
  template<int I>
  ap_uint<1> generic_atan(ap_uint<I> in){ 
    if(in>1)
      return ap_uint<1>(1);
    else
      return ap_uint<1>(0);
  };

  // atan2
  template<int W, int I>
  ap_fixed<W,3> generic_atan2(ap_fixed<W,I> in1, 
                              ap_fixed<W,I> in2){ 

    const ap_fixed<W+1,3> pi("0x3.243F6A8885A308D3");  // pi
    const ap_fixed<W+2,3> pi2("0x1.921FB54442D1846");  // pi/2
    const ap_fixed<W+1,3> pi4("0x0.C90FDAA22168C23");  // pi/4
    const ap_fixed<W+1,3> pi3_("-0x2.5B2F8FE6643A469");// -pi*(3/4)

    ap_uint<2> signin1 = (in1 > 0) ? 2: (in1==0) ? 1: 0;
    ap_uint<2> signin2 = (in2 > 0) ? 2: (in2==0) ? 1: 0;

    ap_fixed<W,3> out; // output 
    
    // 1. corner cases

    if(signin1==1 and signin2==2){
      out = 0;
      return out;
    }
    else if(signin1==1 and signin2==0){
      out = pi;
      return out;
    }
    else if(signin1==2 and signin2==1){
      out = pi2;
      return out;
    }
    else if(signin1==0 and signin2==1){
      out = -pi2;
      return out;
    }
    else if(in1==in2){
      if(signin1==2){
        out = pi4;
        return out;
      }
      else if(signin1==1){
        out = 0;
        return out;
      }
      else{
        out = pi3_;
        return out;
      }
    }

    // 2. non-corner cases

    ap_fixed<W+1,I+1> in1abs; // abs(in1)
    if(signin1==0)
      in1abs = -in1;
    else
      in1abs = in1;

    ap_fixed<W+1,I+1> in2abs; // abs(in2)
    if(signin2==0)
      in2abs = -in2;
    else
      in2abs = in2;

    ap_fixed<W+1,2> in1abs_sft; // shift
    ap_fixed<W+1,2> in2abs_sft;
    for(int i=0;i<W+1;i++){
#pragma HLS UNROLL
      in1abs_sft[i] = in1abs[i];
    }
    for(int i=0;i<W+1;i++){
#pragma HLS UNROLL
      in2abs_sft[i] = in2abs[i];
    }
    
    ap_fixed<W+7,3> x, y, z;
    if(in1abs > in2abs){
      x = in1abs_sft;
      y = in2abs_sft;
      z = 0;
    }
    else{
      x = in2abs_sft;
      y = in1abs_sft;
      z = 0;
    }
    cordic_circ_apfixed<W+7,3,1>(x,y,z);

    if(in1abs > in2abs){
      z = pi2 - z;
    }

    if(signin2==0 and signin1==2){
      out = pi - z;
    }
    else if(signin2==0 and signin1==0){
      out = z - pi;
    }
    else if(signin2==2 and signin1==0){
      out = -z;
    }
    else{
      out = z;
    }

    return out;
  }; 

  // atan2(ap_fixed)
  template<int W, int I>
  ap_ufixed<W,3> generic_atan2(ap_ufixed<W,I> in1, 
                               ap_ufixed<W,I> in2){ 
    ap_fixed<W+1,I+1> fin1 = in1;
    ap_fixed<W+1,I+1> fin2 = in2;
    ap_fixed<W+1,3> fout = generic_atan2(fin1, fin2);
    ap_ufixed<W,3> out = 0;
    if(fout[W]==0){
        out = fout;
    }   
    return out;
  }

  // atan2(ap_int)
  template<int I>
  ap_int<3> generic_atan2(ap_int<I> in1, 
                          ap_int<I> in2){ 
    ap_fixed<I+1,I+1> fin1 = in1;
    ap_fixed<I+1,I+1> fin2 = in2;
    ap_fixed<I+1,3> fout = generic_atan2(fin1, fin2);
    ap_int<3> out = fout;
    return out;
  }

  // atan2(ap_uint)
  template<int I>
  ap_uint<2> generic_atan2(ap_uint<I> in1, 
                           ap_uint<I> in2){ 
    ap_fixed<I+1,I+1> fin1 = in1;
    ap_fixed<I+1,I+1> fin2 = in2;
    ap_fixed<I+1,3> fout = generic_atan2(fin1, fin2);
    ap_uint<2> out = 0;
    if(fout[I]==0){
        out = fout;
    }   
    return out;
  }

  /*
   * Range reduces input to between 0 and ln2 by
   * solving for k and r in x = k*ln2 + r
   */
  template<int W, int I, int Wo>
  void hyperb_range_redux( ap_ufixed<W,I> x,
                           ap_uint<I+1> &k,
                           ap_ufixed<Wo,0> &r) {
    
    ap_ufixed<(Wo+I)+1,1> inv_ln2("0x1.71547652b82fe1777d0ffda0d23a7d11d6aef551cp0"); // 1.0/log(2)
    ap_ufixed<Wo,0> ln2("0xb.17217f7d1cf79abc9e3b39803f2f6af40f343267p-4");           // log(2)
    ap_ufixed<Wo+(I+1),I+1> prod = x * inv_ln2;
    ap_ufixed<Wo,0> prod_dec = prod;
    k = prod;
    r = prod_dec * ln2;
  };

  /*
   * Main hyperbolic CORDIC sub-function
   * MODE 0: 'Rotation' : rotate by angle z.  x' = K*(x*cosh(z) + y*sinh(z)), y' = x*sinh(z) + y*cosh(z)
   * MODE 1: 'Vectoring': rotate y to zero.   x' = K*sqrt(x^2 - y^2)  , z' = z+atanh(y/x)
   */
  template<int W, int I, int MODE>
  void cordic_hyperb_apfixed( ap_fixed<W,I> &x, 
                              ap_fixed<W,I> &y, 
                              ap_fixed<W,I> &z) {

    const int Nmax = W + 1;

    ap_fixed<W,I> tx, ty, tz;
    ap_fixed<W,I> x_s, y_s, z_s;
    ap_uint<1> d;

    for (int n=0; n<Nmax; n++){
      
      int k = hyperb_table_tau_128[n];

      if(MODE == 1) { // Vectoring mode
        d = ~y[W-1];
      } 
      else {          // Rotation mode 
        d = z[W-1];
      }

      x_s = x >> k;
      y_s = y >> k;
      z_s = hyperb_table_arctanh_128[k-1];
     
      if(d){          // z[n-1] is negative
        tx = x - y_s;
        ty = y - x_s;
        tz = z + z_s;
      }
      else{ 
        tx = x + y_s;
        ty = y + x_s;
        tz = z - z_s;
      }

      x = tx; 
      y = ty; 
      z = tz;

      // std::cout << "  x_s: " << x_s
      //            << "  y_s: " << y_s
      //            << "  z_s: " << z_s
      //            << "  x : " << x
      //            << "  y : " << y
      //            << "  z : " << z << std::endl;

    }
  }

  // Cordic method with range reduce for sinh and cosh
  template <int W, int I>
  void sinh_cosh_range_redux_cordic( ap_fixed<W,I> in,
                                     ap_fixed<W,I> &s_out,
                                     ap_fixed<W,I> &c_out){

    ap_uint<1> sign0 = in[W-1];

    ap_ufixed<W,I> inabs;
    if(sign0 == 0)
      inabs = in;
    else
      inabs = -in;

    const int Fr = (W - I) + I;

    if(in==0){
      s_out = 0;
      c_out = 1;
      return;
    }

    // inabs = k * ln(2) + r
    ap_uint<I+1> k;
    ap_ufixed<Fr,0> r;
    hyperb_range_redux(inabs, k, r);
    
    ap_fixed<Fr+2,2> x("1.20749706776307212887772");
    ap_fixed<Fr+2,2> y(0);
    ap_fixed<Fr+2,2> z(r);
    
    //  std::cout << x << "  " << y << "  " << z << std::endl;

    // compute x = sinh(r) and y = cosh(r)
    cordic_hyperb_apfixed<Fr+2,2,0>(x,y,z);

    //  std::cout << x << "  " << y << "  " << z << std::endl;

    ap_fixed<Fr+(I+2),I+2> er, e_r;
    er  = x + y; // e^r
    e_r = x - y; // e^{-r}

    //  std::cout << er << "  " << e_r << std::endl;

    er <<= (k-1);  // (e^k * 2^k) / 2
    e_r >>= (k+1); // (e^{-k} * 2^{-k})/2
      
    //  std::cout << er << "  " << e_r << std::endl;

    ap_fixed<W+1,I+1> s_out_tmp = er - e_r;
    ap_fixed<W+1,I+1> c_out_tmp = er + e_r;

    //  std::cout << "out_tmp: "<< "  " << c_out_tmp << std::endl;

    // overflow sinh
    if(s_out_tmp[W-1]==1){
      s_out_tmp[W-1] = 0;
      for(int i=0;i<W-1;i++){
#pragma HLS UNROLL
        s_out_tmp[i] = 1;
      }   
    }

    // return sinh
    if(sign0 == 0){
      s_out = s_out_tmp; 
    }
    else{
      s_out = -s_out_tmp; 
    } 

    //  std::cout << c_out << "  " << c_out_tmp << std::endl;

    // overflow cosh and return
    if(c_out_tmp[W-1]==1){
      c_out[W-1] = 0;
      for(int i=0;i<W-1;i++){
#pragma HLS UNROLL
        c_out[i] = 1;
      }   
    }
    else{
      c_out = c_out_tmp;
    }
  };

    template<int W, int I>
    void tanh_range_redux_cordic(ap_fixed<W,I> in, ap_fixed<W,I> &tan_out) {
        //For detail comment, please take sinh_range_redux_cordix for example
        ap_uint<1> sign0 = in[W-1];
        
        ap_ufixed<W,I> inabs;
        if(sign0 == 0)
            inabs = in;
        else
            inabs = -in;

        const int Fr = (W - I) + I;

        if(in==0){
            tan_out = 0;
            return;
        }

        ap_uint<I+1> k;
        ap_ufixed<Fr,0> r;
        hyperb_range_redux(inabs, k, r);

        ap_fixed<Fr+2,2> x("1.20749706776307212887772");
        ap_fixed<Fr+2,2> y(0);
        ap_fixed<Fr+2,2> z(r);

        cordic_hyperb_apfixed<Fr+2,2,0>(x,y,z);
        ap_fixed<Fr+(I+2),I+2> er, e_r;
        er  = x + y;
        e_r = x - y;
        er  <<= k;
        e_r >>= k;
        tan_out = (er/(er+e_r))*2 - 1;
    }

    template<int W, int I>
    ap_fixed<W,I> generic_tanh(ap_fixed<W,I> in) {
        ap_fixed<W,I> tan_out;
        tanh_range_redux_cordic(in, tan_out);
        return tan_out;
    } 

    template<int W, int I>
    ap_ufixed<W,I> generic_tanh(ap_ufixed<W,I> in) {
        ap_fixed<W+1,I+1> fin = in;
        ap_fixed<W+1,I+1> fout = generic_tanh(fin);
        ap_ufixed<W,I> tan_out = fout;
        return tan_out;
    }

    template<int I>
    ap_int<I> generic_tanh(ap_int<I> in) {
        ap_fixed<I,I> fin = in;
        ap_fixed<I,I> fout = generic_tanh(fin);
        ap_int<I> tan_out = fout;
        return tan_out;
    }

    template<int I>
    ap_uint<I> generic_tanh(ap_uint<I> in) {
        ap_fixed<I+1,I+1> fin = in;
        ap_fixed<I+1,I+1> fout = generic_tanh(fin);
        ap_uint<I> tan_out = fout;
        return tan_out;
    }
  // sinh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> generic_sinh(ap_fixed<W,I> in) {
    ap_fixed<W,I> s_out, c_out;
    sinh_cosh_range_redux_cordic(in,s_out,c_out);
    return s_out;
  }
  
  // sinh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> generic_sinh(ap_ufixed<W,I> in) {
    ap_fixed<W+1,I+1> fin = in;
    ap_fixed<W+1,I+1> fout = generic_sinh(fin);
    ap_ufixed<W,I> out = 0;
    if(fout[W]==0){
        out = fout;
    }   
    return out;
  };  

  // sinh(ap_int)
  template<int I>
  ap_int<I> generic_sinh(ap_int<I> in) {
    ap_fixed<I,I> fin = in;
    ap_fixed<I,I> fout = generic_sinh(fin);
    ap_int<I> out = fout;
    return out;
  };  

  // sinh(ap_uint)
  template<int I>
  ap_uint<I> generic_sinh(ap_uint<I> in) {
    ap_fixed<I+1,I+1> fin = in;
    ap_fixed<I+1,I+1> fout = generic_sinh(fin);
    ap_uint<I> out = 0;
    if(fout[I]==0){
        out = fout;
    }   
    return out;
  };  

  // cosh(ap_fixed)
  template<int W, int I>
  ap_fixed<W, I> generic_cosh(ap_fixed<W,I> in) {
    ap_fixed<W,I> s_out, c_out;
    sinh_cosh_range_redux_cordic(in,s_out,c_out);
    return c_out;
  }

  // cosh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> generic_cosh(ap_ufixed<W,I> in) {
    ap_fixed<W+1,I+1> fin = in;
    ap_fixed<W+1,I+1> fout = generic_cosh(fin);
    ap_ufixed<W,I> out = 0;
    if(fout[W]==0){
        out = fout;
    }   
    return out;
  };  

  // cosh(ap_int)
  template<int I>
  ap_int<I> generic_cosh(ap_int<I> in) {
    ap_fixed<I,I> fin = in;
    ap_fixed<I,I> fout = generic_cosh(fin);
    ap_int<I> out = fout;
    return out;
  };  

  // cosh(ap_uint)
  template<int I>
  ap_uint<I> generic_cosh(ap_uint<I> in) {
    ap_fixed<I+1,I+1> fin = in;
    ap_fixed<I+1,I+1> fout = generic_cosh(fin);
    ap_uint<I> out = 0;
    if(fout[I]==0){
        out = fout;
    }   
    return out;
  };  


  // asin
  template<int W, int I>
  ap_fixed<W-I+3,3> generic_asin(ap_fixed<W,I> in){

    const int I0 = 3; 
    const int W0 = W - I + I0 + 6; 

    const ap_fixed<W+1,I+1> cst1("0x1");
    const ap_fixed<W,I> cst0("0x0");
    const ap_fixed<W,I> cst_1("-0x1");

    // input value should be between -1 and 1
#ifndef __SYNTHESIS__
    if(I>=2){
      if((in>cst1) or (in<cst_1)){
        printf("Error: input value %f (for asin) is not between -1 and 1.\n", in.to_double());
        assert(0);
      }
    }
#endif
    
    ap_fixed<W-I+3,3> out; // output

    // special case
    if(in==cst1){
      out = ap_fixed<W-I+3,3>("0x1.921FB54442D1846");
      return out;
    }
    else if(in==cst_1){
      out = ap_fixed<W-I+3,3>("-0x1.921FB54442D1846");
      return out;
    }
    else if(in==cst0){
      out = ap_fixed<W-I+3,3>("0x0");
      return out;
    }

    // sign
    ap_uint<1> sign0 = (in >= 0) ? 1: 0;

    // abs(in)
    ap_fixed<W,I> inabs;
    if(sign0)
      inabs = in;
    else
      inabs = -in;

    ap_fixed<W,I> absout;

    // double cordic algorithm
    if(inabs[W-I-1]==0){
      ap_fixed<W0,I0> x("0x1");
      ap_fixed<W0,I0> y("0x0");
      ap_fixed<W0,I0> z("0x0");
      ap_fixed<W0,I0> t = inabs;
      doublecordic_apfixed<W0,I0,0,0>(x,y,z,t);
      absout = z;
    }
    else{
      const int F1 = W - I;
      const int W1 = F1 + F1 + I;
      ap_fixed<W1,I> one("0x1");
      ap_fixed<W1,I> onex = one - inabs * inabs;
      ap_fixed<W1,I> sqrtonex = ::HLS_FPO_SQRT(onex.to_double());
      ap_fixed<W1,I> xsqrtonex = inabs / (one + sqrtonex);
      absout = generic_atan(xsqrtonex) << 1;
    }

    // return 
    if(sign0)
      out = absout;
    else
      out = -absout;

    return out;
  }


  // acos
  template<int W, int I>
  ap_fixed<W-I+3,3> generic_acos(ap_fixed<W,I> in){

    const int I0 = 3; 
    const int W0 = W - I + I0;

    // input value should be between -1 and 1
#ifndef __SYNTHESIS__
    if(I>=2){
      const ap_fixed<W+1,I+1> cst1("0x1");
      const ap_fixed<W,I> cst_1("-0x1");
    
      if((in>cst1) or (in<cst_1)){
        printf("Error: input value %f (for acos) is not between -1 and 1.\n", in.to_double());
        assert(0);
      }
    }
#endif

    // acos = pi/2 - asin
    const ap_fixed<W0,I0> pi2("0x1.921FB54442D1846"); // pi/2
    ap_fixed<W0,I0> out = pi2 - generic_asin(in);

    if(out[W0-1]==1){
      out = -out;
    }

    return out;
  }

  template<int W, int I>
  void cordic_semi_recovery_asinh(ap_fixed<W,I> in_top, ap_fixed<W,I>& out) {

    if(in_top == 0) {
      out = 0;
      return;
    }

    ap_fixed<W,I> in;
    if(in_top >= 0) {
      in = in_top;
    }
    else {
      in = -in_top;
    }

    int m = in.countLeadingZeros();
    int k = I-m;

    if(W-I-2 >= k) {

      ap_fixed<W,I> boundk = 1.0;
      ap_fixed<W,I> bound_k_2 = 1.0;
      boundk <<= k;
      bound_k_2 >>= k;
      bound_k_2 >>= 2;

      if(in >= (boundk - bound_k_2)) {
        k+=1;
      }

    }
   
    if(k < 0) {
      k = 0;
    }
    
    const int Nmax = W - I + 1;
    int tau;
    ap_fixed<W,I> x_r(1);
    ap_fixed<W,I> y_r(0);
    ap_fixed<W,I> z_r(0);
    ap_fixed<W,I> x1_tau, x_2tau, y1_tau, y_2tau, z_s;
    ap_fixed<W,I> xk, x_k, yk, y_k;
    ap_fixed<W,I> y_semi_recovery;
    ap_fixed<W,I> in_s;

    for(int i=0; i<Nmax; i++) {

      xk   = x_r << k;
      x_k  = x_r >> k;
      yk   = y_r << k;
      y_k  = y_r >> k;

      y_semi_recovery = (xk - x_k + yk + y_k) >> 1;

      tau = hyperb_table_tau_128[i+1];
      z_s = hyperb_table_arctanh_128[tau-1] << 1;

      x1_tau = ((x_r >> tau) << 1);
      x_2tau = (x_r >> (tau << 1));
      y1_tau = ((y_r >> tau) << 1);
      y_2tau = (y_r >> (tau << 1));

      if(y_semi_recovery <= in) {
        x_r += x_2tau + y1_tau;
        y_r += y_2tau + x1_tau;
        z_r += z_s;
      }
      else {
        x_r += x_2tau - y1_tau;
        y_r += y_2tau - x1_tau;
        z_r -= z_s;
      }

      in_s = in >> (tau << 1);
      in -= in_s;
    }

    ap_ufixed<W,0> ln2("0xb.17217f7d1cf79abc9e3b39803f2f6af40f343267p-4");
    if(in_top >= 0) {
      out = z_r + k*ln2;
    }
    else {
      out = -z_r - k*ln2;
    }
  }

  template<int W, int I>
  void cordic_semi_recovery_acosh(ap_fixed<W,I> in, ap_fixed<W,I>& out) {

#ifndef __SYNTHESIS__
    if(in < 1) {
      std::cout<<"Input should be equal or greater than 1.0."<<std::endl;
    }
#endif
    if(in == 1) {
      out = 0;
      return;
    }

    int m = in.countLeadingZeros();
    int k = I-m;


    ap_fixed<W,I> boundk = 1.0;
    ap_fixed<W,I> bound_k_1 = 1.0;
    boundk <<= k;
    boundk >>= 1;
    bound_k_1 >>= k;
    bound_k_1 >>= 1;

      if(in < (boundk - bound_k_1)) {
        k-=1;
      }

    if(k < 0) {
      k = 0;
    }
    
    const int Nmax = W - I + 1;
    int tau;
    ap_fixed<W,I> x_r(1);
    ap_fixed<W,I> y_r(0);
    ap_fixed<W,I> z_r(0);
    ap_fixed<W,I> x1_tau, x_2tau, y1_tau, y_2tau, z_s;
    ap_fixed<W,I> xk, x_k, yk, y_k;
    ap_fixed<W,I> x_semi_recovery;
    ap_fixed<W,I> in_s;

    for(int i=0; i<Nmax; i++) {

      xk   = x_r << k;
      x_k  = x_r >> k;
      yk   = y_r << k;
      y_k  = y_r >> k;

      x_semi_recovery = (xk + x_k + yk - y_k) >> 1;

      tau = hyperb_table_tau_128[i+1];
      z_s = hyperb_table_arctanh_128[tau-1] << 1;

      x1_tau = ((x_r >> tau) << 1);
      x_2tau = (x_r >> (tau << 1));
      y1_tau = ((y_r >> tau) << 1);
      y_2tau = (y_r >> (tau << 1));

      if(x_semi_recovery <= in) {
        x_r += x_2tau + y1_tau;
        y_r += y_2tau + x1_tau;
        z_r += z_s;
      }
      else {
        x_r += x_2tau - y1_tau;
        y_r += y_2tau - x1_tau;
        z_r -= z_s;
      }

      in_s = in >> (tau << 1);
      in -= in_s;
    }

    ap_ufixed<W,0> ln2("0xb.17217f7d1cf79abc9e3b39803f2f6af40f343267p-4");
    out = z_r + k*ln2;
  }

  // asinh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> generic_asinh(ap_fixed<W,I> in) {
    ap_fixed<W+1,I+1> input, output; input = in;
    cordic_semi_recovery_asinh(input, output); 
    return output;
  }

  // asinh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> generic_asinh(ap_ufixed<W,I> in) {
    ap_fixed<W+1,I+1> input, output; 
    input = in;
    cordic_semi_recovery_asinh(input, output); 
    return output;
  };

  // asinh(ap_int)
  template<int I>
  ap_int<I> generic_asinh(ap_int<I> in) {
    ap_fixed<I+1,I+1> input, output; 
    input = in;
    cordic_semi_recovery_asinh(input, output); 
    return output;
  };

  // asinh(ap_uint)
  template<int I>
  ap_uint<I> generic_asinh(ap_uint<I> in) {
    ap_fixed<I+1,I+1> input, output; 
    input = in;
    cordic_semi_recovery_asinh(input, output); 
    return output;
  };

    // acosh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> generic_acosh(ap_fixed<W,I> in) {
    ap_fixed<W+1,I+1> input, output; 
    input = in;
    cordic_semi_recovery_acosh(input, output); 
    return output;
  }

  // acosh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> generic_acosh(ap_ufixed<W,I> in) {
    ap_fixed<W+1,I+1> input, output; 
    input = in;
    cordic_semi_recovery_acosh(input, output); 
    return output;
  };

  // acosh(ap_int)
  template<int I>
  ap_int<I> generic_acosh(ap_int<I> in) {
    ap_fixed<I,I> input, output; 
    input = in;
    cordic_semi_recovery_acosh(input, output); 
    return output;
  };

  // acosh(ap_uint)
  template<int I>
  ap_uint<I> generic_acosh(ap_uint<I> in) {
    ap_fixed<I+1,I+1> input, output; 
    input = in;
    cordic_semi_recovery_acosh(input, output); 
    return output;
  };
  
  //asinpi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> generic_asinpi(ap_fixed<W,I> x) {
      const static int we = I < 3? 3: I;
      ap_fixed<W-I+we, we> xi = x;
      ap_fixed<W-I+3,3> asin_x = generic_asin(xi);
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"W="<<W<<", I="<<I<<", x="<<x.to_string()<<std::endl;
      std::cout<<"asin_x="<<asin_x.to_string()<<std::endl;
      #endif
      #endif
      static const int F = W - I;
  //asin inside [-pi/2, pi/2]
  //asinpi inside [-1/2, 1/2]
  //to make the precision is 1ulp
  //E-R=R*2^(-ulp)/Pi<1/2^F
  //ulp=F-1
      static const int wf = F < 1? 0: F - 1;
      ap_ufixed<2+wf,2> pi = 3.14159265358979323846;   
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"pi="<<pi.to_string()<<std::endl;
      #endif
      #endif
      ap_fixed<W,I> r = asin_x/pi;
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"r="<<r.to_string()<<std::endl;
      #endif
      #endif
      return r;
  }
  template<int W, int I>
  ap_ufixed<W,I> generic_asinpi(ap_ufixed<W,I> x) {
      ap_fixed<W+1,I+1> xi = x;
      return generic_asinpi(xi);
  }
  template<int I>
  ap_int<I> generic_asinpi(ap_int<I> x) {
  //asinpi(x) inside [-0.5, 0.5]
      if(x==-1){
        //rounding -0.5 to -1
        return -1;
      }else if(x==0){
        return 0;
      }else if(x==1){
       //rouding 0.5 to 1
        return 1;
      }else{
        #ifndef __SYNTHESIS__
        printf("Error: input value %d (for asinpi) is not between -1 and 1.\n", x.to_int());
        assert(0);
        #endif
        return 0;
      };
  }
  template<int I>
  ap_uint<I> generic_asinpi(ap_uint<I> x) {
  //asinpi(x) inside [0, 0.5]
      if(x==0){
        return 0;
      //rounding 0.5 to 1
      } else if(x==1){
        return 1;
      } else{
        #ifndef __SYNTHESIS__
        printf("Error: input value %d (for asinpi) is not between -1 and 1.\n", x.to_int());
        assert(0);
        #endif
        return 0;
      };
  }
  //acospi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> generic_acospi(ap_fixed<W,I> x) {
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"W="<<W<<", I="<<I<<", x="<<x.to_string()<<std::endl;
      #endif
      #endif
      const static int we = I < 3? 3 : I;  
      ap_fixed<W-I+we,we> xi = x;
      ap_fixed<W-I+3,3> acos_x = generic_acos(xi);
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"acos_x="<<acos_x.to_string()<<std::endl;
      #endif
      #endif
      static const int F = W - I;
  //acos inside [0,pi]
  //acospi inside [0,1]
  //to make the precision is 1ulp
  //E-R=R*2^(-ulp)/Pi<1/2^F
  //ulp=F
      static const int wf = F;
      ap_ufixed<2+wf,2> pi = 3.14159265358979323846;   
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"pi="<<pi.to_string()<<std::endl;
      #endif
      #endif
      ap_fixed<W,I> r = acos_x/pi;
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"r="<<r.to_string()<<std::endl;
      #endif
      #endif
      return r;
  }
  template<int W, int I>
  ap_ufixed<W,I> generic_acospi(ap_ufixed<W,I> x) {
      ap_fixed<W+1,I+1> xi = x;
      return generic_acospi(xi);
  }
  template<int I>
  ap_int<I> generic_acospi(ap_int<I> x) {
  //acospi(x) inside [0,1]
      if(x==-1){
        return 1;
      //rounding 0.5 to 1
      } else if(x==0){
        return 1;
      } else if(x==1){
        return 0;
      } else{
        #ifndef __SYNTHESIS__
        printf("Error: input value %d (for acospi) is not between -1 and 1.\n", x.to_int());
        assert(0);
        #endif
        return 0;
      };
  }
  template<int I>
  ap_uint<I> generic_acospi(ap_uint<I> x) {
  //acospi(x) inside [0,0.5]
      if(x==0){
        return 1;
      } else if(x==1){
        return 0;
      } else{
        #ifndef __SYNTHESIS__
        printf("Error: input value %d (for acospi) is not between -1 and 1.\n", x.to_int());
        assert(0);
        #endif
        return 0;
      };
  }
  //atanpi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> generic_atanpi(ap_fixed<W,I> x) {
      ap_fixed<W-I+3,3> atan_x = generic_atan(x);
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"atan_x="<<atan_x.to_string()<<std::endl;
      #endif
      #endif
      static const int F = W - I;
  //atan inside (-pi/2,pi/2)
  //atanpi inside (-1/2,1/2)
  //to make the precision is 1ulp
  //E-R=R*2^(-ulp)/Pi<1/2^F
  //ulp=F-1
      static const int wf = F < 1? 0: F - 1;
      ap_ufixed<2+wf,2> pi = 3.14159265358979323846;   
      ap_fixed<W,I> r = atan_x/pi;
      #ifndef __SYNTHESIS__
      #ifdef _HLSCLIB_DEBUG_
      std::cout<<"r="<<r.to_string()<<std::endl;
      #endif
      #endif
 
      return r;
  }
  template<int W, int I>
  ap_ufixed<W,I> generic_atanpi(ap_ufixed<W,I> x) {
      ap_fixed<W+1,I+1> xi = x;
      return generic_atanpi(xi);
  }
  template<int I>
  ap_int<I> generic_atanpi(ap_int<I> x) {
  //atanpi(x) inside (0.5,0.5)
      return 0;
  }
  template<int I>
  ap_uint<I> generic_atanpi(ap_uint<I> x) {
  //atanpi(x) inside [0,0.5)
      return  0;
  }
  //atan2pi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> generic_atan2pi(ap_fixed<W,I> y, ap_fixed<W, I> x) {
      ap_fixed<W-I+3,3> atan2_x = generic_atan2(y, x);
      static const int F = W - I;
  //atan2 inside (-pi,pi]
  //atan2pi inside (-1,1]
  //to make the precision is 1ulp
  //E-R=R*2^(-ulp)/Pi<1/2^F
  //ulp=F
      static const int wf = F;
      ap_ufixed<2+wf,2> pi = 3.14159265358979323846;   
      ap_fixed<W,I> r = atan2_x/pi;
      return r;
  }
  template<int W, int I>
  ap_ufixed<W,I> generic_atan2pi(ap_ufixed<W,I> y, ap_ufixed<W,I> x) {
      ap_fixed<W+1,I+1> xi = x;
      ap_fixed<W+1,I+1> yi = y;
      return generic_atan2pi(yi, xi);
  }
  template<int I>
  ap_int<I> generic_atan2pi(ap_int<I> y, ap_int<I> x) {
  //atan2pi inside (-1, 1]
      bool x_sig = x[I-1];
      bool y_sig = y[I-1];
      if(y==0 && x==0) return 0;
      //rounding -0.5 to 1
      //y<0, x ==0 
      else if(y_sig && x==0) return -1;
      //rounding 0.5 to 1, y >0, x == 0
      else if(!y_sig && x==0) return 1;
      //y>0 && x < 0
      else if(!y_sig && x_sig) return 1;
      //y<0, x < 0
      else if(y_sig && x_sig) return -1;
      else return 0;
  }
  template<int I>
  ap_uint<I> generic_atan2pi(ap_uint<I> y, ap_uint<I> x) {
  //atan2pi inside (0, 1]
      //rounding 0.5 to 1, y >0, x == 0
      if(y!=0 && x==0) return 1;
      else return 0;
  }
  
} // namespace

#endif


