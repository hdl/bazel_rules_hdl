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

/**
 * @file hls_hotbm_apfixed.h
 * An implementation of sin/cos, based on the HOTBM method published by
 * Detrey and deDinechin, "Floating-point Trigonometric Functions for FPGAs"
 */

#ifndef _X_HLS_HOTBM_APFIXED_H_
#define _X_HLS_HOTBM_APFIXED_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "utils/x_hls_defines.h"
#include "utils/x_hls_utils.h"

#ifndef M_PI
// Some compilers are stingy about giving us all these constants that are usually in the C library.
#define M_PI 3.14159265358979323846
#endif

namespace hotbm_apfixed
{

  namespace first_order_fixed_16{
	extern const ap_fixed<19,2> sin_cos_K0[256];
	extern const ap_fixed<11,2> sin_cos_K1[256];
  };

  namespace second_order_float{
	extern const ap_fixed<29,0> cos_K0[128];
	extern const ap_fixed<23,1> cos_K1[128];
	extern const ap_fixed<15,0> cos_K2[128];
	extern const ap_fixed<30,1> sin_K0[128];
	extern const ap_fixed<21,-1> sin_K1[128];
	extern const ap_fixed<13,-2> sin_K2[128];
	extern const ap_ufixed<30,1> sin_cos_K0[256];
	extern const ap_fixed<23,1> sin_cos_K1[256];
	extern const ap_fixed<15,0> sin_cos_K2[256];
  };

  namespace fourth_order_double{
	extern const ap_fixed<59,0> cos_K0[128];
	extern const ap_fixed<53,1> cos_K1[128];
	extern const ap_fixed<45,0> cos_K2[128];
	extern const ap_fixed<35,-3> cos_K3[128];
	extern const ap_fixed<27,-4> cos_K4[128];
	extern const ap_fixed<60,1> sin_K0[128];
	extern const ap_fixed<51,-1> sin_K1[128];
	extern const ap_fixed<43,-2> sin_K2[128];
	extern const ap_fixed<33,-5> sin_K3[128];
	extern const ap_fixed<24,-7> sin_K4[128];
	extern const ap_fixed<59,1> sin_cos_K0[256];
	extern const ap_fixed<52,1> sin_cos_K1[256];
	extern const ap_fixed<44,0> sin_cos_K2[256];
	extern const ap_fixed<34,-3> sin_cos_K3[256];
	extern const ap_fixed<26,-4> sin_cos_K4[256];
  };

  template<class T>
  struct value_list{
  };

  template<>
  struct value_list<double>{
    typedef double T;
	static const int g = 10;  // guard bits during core approx
	static const int p1 = 61; // padding bits during range reduction
	static const int alpha = 7;
    // The number of bits of B that are not used in the K1 computation
	static const int beta1 = 0;
    // The number of bits of B that are not used in the K2 computation
	static const int beta2 = alpha;

    static const int W_dout = fp_struct<T>::SIG_BITS+1+g;
    static const int W_Mx = fp_struct<T>::SIG_BITS+1+g;

    template <int Wx, int Wr>
    static ap_ufixed<Wx, 1> sin_or_cos_approximation(bool do_cos,
													 ap_uint<3> &k,
													 ap_ufixed<Wx, 0> &x,
													 ap_ufixed<Wr, 0> &Mx,
													 ap_int<fp_struct<double>::EXP_BITS> &Ex){

	  const bool swap_table[8] = {0,1,1,0,0,1,1,0};
#pragma HLS array_partition variable=swap_table complete
#pragma HLS RESOURCE variable=fourth_order_double::sin_cos_K0 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_cos_K1 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_cos_K2 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_cos_K3 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_cos_K4 core=ROM_1P_LUTRAM

	  ap_uint<alpha+1> A = x(x.wl()-x.iwl()-1,x.wl()-x.iwl()-alpha);
	  ap_ufixed<Wx-alpha-beta1, -alpha> B = x;
	  ap_ufixed<Wx-alpha-beta2, -alpha> B_trunc = B;
	  ap_ufixed<Wx-2*alpha, -2*alpha> B_squared = B_trunc*B_trunc;
	  ap_ufixed<Wx-3*alpha, -3*alpha> B_third_power = B_trunc*B_squared;
	  ap_ufixed<Wx-4*alpha, -4*alpha> B_fourth_power = B_squared*B_squared;

	  bool sin_basis = do_cos? swap_table[k]:!swap_table[k];
	  A[alpha] = sin_basis; // cos and sin are concatentated.

	  ap_fixed<Wx, 1> t1 = fourth_order_double::sin_cos_K0[A];
	  ap_fixed<Wx, 1> t2 = B*fourth_order_double::sin_cos_K1[A];
	  ap_fixed<Wx, 1> t3 = B_squared*fourth_order_double::sin_cos_K2[A];
	  ap_fixed<Wx, 1> t4 = B_third_power*fourth_order_double::sin_cos_K3[A];
	  ap_fixed<Wx, 1> t5 = B_fourth_power*fourth_order_double::sin_cos_K4[A];
	  ap_ufixed<Wx, 1> result = Mx*(t1+t2+t3+t4+t5);
	  return result;
    }

    template <int Wx, int Wr>
    static void sincos_approximation(ap_uint<3> &k,
									 ap_ufixed<Wx, 0> &x,
									 ap_ufixed<Wr, 0> Mx,
									 ap_int<fp_struct<double>::EXP_BITS> Ex,
									 ap_ufixed<Wr, 1> &sin_result,
									 ap_ufixed<Wr, 1> &cos_result
									 ) {
#pragma HLS RESOURCE variable=fourth_order_double::cos_K0 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::cos_K1 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::cos_K2 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::cos_K3 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::cos_K4 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_K0 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_K1 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_K2 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_K3 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=fourth_order_double::sin_K4 core=ROM_1P_LUTRAM

	  ap_uint<alpha> A = x(x.wl()-x.iwl()-1,
						   x.wl()-x.iwl()-alpha);
	  ap_ufixed<Wx-alpha-beta1, -alpha> B = x;
	  ap_ufixed<Wx-alpha-beta2, -alpha> B_trunc = B;
	  ap_ufixed<Wx-2*alpha, -2*alpha> B_squared = B_trunc*B_trunc;
	  ap_ufixed<Wx-3*alpha, -3*alpha> B_third_power = B_trunc*B_squared;
	  ap_ufixed<Wx-4*alpha, -4*alpha> B_fourth_power = B_squared*B_squared;

	  ap_fixed<Wx, 1> cos_t1 = fourth_order_double::cos_K0[A];
	  ap_fixed<Wx, 1> cos_t2 = B*fourth_order_double::cos_K1[A];
	  ap_fixed<Wx, 1> cos_t3 = B_squared*fourth_order_double::cos_K2[A];
	  ap_fixed<Wx, 1> cos_t4 = B_third_power*fourth_order_double::cos_K3[A];
	  ap_fixed<Wx, 1> cos_t5 = B_fourth_power*fourth_order_double::cos_K4[A];
	  cos_result = 1 - (cos_t1 + cos_t2 + cos_t3 + cos_t4 + cos_t5);

	  ap_fixed<Wx, 1> sin_t1 = fourth_order_double::sin_K0[A];
	  ap_fixed<Wx, 1> sin_t2 = B*fourth_order_double::sin_K1[A];
	  ap_fixed<Wx, 1> sin_t3 = B_squared*fourth_order_double::sin_K2[A];
	  ap_fixed<Wx, 1> sin_t4 = B_third_power*fourth_order_double::sin_K3[A];
	  ap_fixed<Wx, 1> sin_t5 = B_fourth_power*fourth_order_double::sin_K4[A];
	  sin_result = Mx * (sin_t1 + sin_t2 + sin_t3 + sin_t4 + sin_t5);
    }
  };

  template<>
  struct value_list<float> {
	typedef float T;
	static const int g = 5;
	static const int p1 = 29;
	static const int alpha = 7;
	static const int beta1 = 0;
	static const int beta2 = 7; 

	static const int W_dout = fp_struct<T>::SIG_BITS+1+g;
	static const int W_Mx = fp_struct<T>::SIG_BITS+1+g;

	template <int Wx, int Wr>
	static ap_ufixed<Wx, 1> sin_or_cos_approximation(bool do_cos,
													 ap_uint<3> &k,
													 ap_ufixed<Wx, 0> &x,
													 ap_ufixed<Wr, 0> &Mx,
													 ap_int<fp_struct<float>::EXP_BITS> &Ex){

	  const bool swap_table[8] = {0,1,1,0,0,1,1,0};

#pragma HLS array_partition variable=swap_table complete
#pragma HLS RESOURCE variable=second_order_float::sin_cos_K0 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=second_order_float::sin_cos_K1 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=second_order_float::sin_cos_K2 core=ROM_1P_LUTRAM

	  ap_uint<alpha+1> A = x(x.wl()-x.iwl()-1,x.wl()-x.iwl()-alpha);
	  ap_ufixed<Wx-alpha-beta1, -alpha> B = x;
	  ap_ufixed<Wx-alpha-beta2, -alpha> B_trunc = B;
	  ap_ufixed<Wx-2*alpha, -2*alpha> B_squared = B_trunc*B_trunc;

	  bool sin_basis = do_cos? swap_table[k]:!swap_table[k];
	  A[alpha] = sin_basis; // cos and sin are concatentated.

	  ap_fixed<Wx, 1> t1 = second_order_float::sin_cos_K0[A];
	  ap_fixed<Wx, 1> t2 = B*second_order_float::sin_cos_K1[A];
	  ap_fixed<Wx, 1> t3 = B_squared*second_order_float::sin_cos_K2[A];
	  ap_ufixed<Wx, 1> result = (t1+t2+t3) * Mx;

	  return result;
	}

	template <int Wx, int Wr>
	static void sincos_approximation(ap_uint<3> &k,
									 ap_ufixed<Wx, 0> &x,
									 ap_ufixed<Wr, 0> &Mx,
									 ap_int<fp_struct<float>::EXP_BITS> &Ex,
									 ap_ufixed<Wr, 1> &sin_result,
									 ap_ufixed<Wr, 1> &cos_result
									 ) {
#pragma HLS RESOURCE variable=second_order_float::cos_K0 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=second_order_float::cos_K1 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=second_order_float::cos_K2 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=second_order_float::sin_K0 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=second_order_float::sin_K1 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=second_order_float::sin_K2 core=ROM_1P_LUTRAM

	  ap_uint<alpha> A = x(x.wl()-x.iwl()-1,
						   x.wl()-x.iwl()-alpha);
	  ap_ufixed<Wx-alpha-beta1, -alpha> B = x;
	  ap_ufixed<Wx-alpha-beta2, -alpha> B_trunc = B;
	  ap_ufixed<Wx-2*alpha, -2*alpha> B_squared = B_trunc*B_trunc;

	  //   TABLES tables;
	  ap_ufixed<Wx, 1> cos_t1 = second_order_float::cos_K0[A];
	  ap_ufixed<Wx, 1> cos_t2 = B*second_order_float::cos_K1[A];
	  ap_ufixed<Wx, 1> cos_t3 = B_squared*second_order_float::cos_K2[A];
	  cos_result = 1 - (cos_t1 + cos_t2 + cos_t3);

	  ap_fixed<Wx, 1> sin_t1 = second_order_float::sin_K0[A];
	  ap_fixed<Wx, 1> sin_t2 = B*second_order_float::sin_K1[A];
	  ap_fixed<Wx, 1> sin_t3 = B_squared*second_order_float::sin_K2[A];
	  sin_result = Mx * (sin_t1 + sin_t2 + sin_t3);
	}
  };

  struct sin_cos_fixed_16 {

	typedef half T;
	static const int g = 3;
	static const int p1 = 12;
	static const int alpha = 8;
	static const int beta1 = 4;

	template <int W_dout>
	static ap_ufixed<W_dout, 1> sin_or_cos_approximation(bool do_cos,
														 ap_uint<2> &k,
														 ap_ufixed<W_dout, 0> &x){

#pragma HLS RESOURCE variable=first_order_fixed_16::sin_cos_K0 core=ROM_1P_LUTRAM
#pragma HLS RESOURCE variable=first_order_fixed_16::sin_cos_K1 core=ROM_1P_LUTRAM

	  ap_uint<alpha> A = x(x.wl()-x.iwl()-1,x.wl()-x.iwl()-alpha);

	  const int BW = (W_dout-alpha-beta1)>1 ? W_dout-alpha-beta1 : 2;
	  ap_ufixed<BW, -alpha> B = x;

	  ap_fixed<W_dout, 1> t1 = first_order_fixed_16::sin_cos_K0[A];
	  ap_fixed<W_dout, 1> t2 = B*first_order_fixed_16::sin_cos_K1[A];
	  ap_ufixed<W_dout, 1> result = (t1+t2);

	  return result;
	};
  };

  template<int W, int I>
  ap_fixed<W,2> 
  sinf_or_cosf(ap_fixed<W,I> t_in, bool do_cos, bool do_pi, 
			   typename hls::enable_if<(W > 16) && (W <= 32), bool>::type dummy = true)
  {
	const int WO = W;
	const int g = 3;

	const bool swap_table[8] = {0,1,1,0,0,1,1,0};
	const bool neg_sin_table[16] = {0,0,1,0,1,1,0,1, 1,0,1,1,0,1,0,0};
	const bool neg_cos_table[16] = {0,0,0,1,1,1,1,0, 0,1,1,1,1,0,0,0};

#pragma HLS array_partition variable=swap_table complete
#pragma HLS array_partition variable=neg_sin_table complete
#pragma HLS array_partition variable=neg_cos_table complete

	ap_uint<3> k;
	ap_ufixed<WO+1+g, 0> x;
	ap_ufixed<WO+1+g, 0> Mx;
	ap_int<fp_struct<float>::EXP_BITS> Ex = 0;

	int exactly_pi_over_4 = 0;
	bool is_negative = t_in[t_in.wl()-1];
	ap_ufixed<W, I> din = is_negative ? ap_fixed<W, I>(-t_in) : t_in;

	if(do_pi) {
	  k = din*4;
	  x = din*4;
	  ap_ufixed<W, 1> Mx_bits_extended = din*4;
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
	  std::cout << "sin_cos: Mx_bits_extended = " << Mx_bits_extended.to_string(2) << "\n";
#endif
	  exactly_pi_over_4 = (Mx_bits_extended == 1);
	} else {
	  ap_ufixed<WO+1+g+3, 3> Wx = din * ap_ufixed<W+1+g,2>(4/M_PI);
	  k = Wx;
	  x = Wx;
	}
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
	std::cout << "sin_cos: k = " << k.to_string(2) << "\n";
#endif
	// If we're in an odd quadrant, then the base functions need to be flipped.
	if(k[0] == 1) {
	  x = 1-x;
	}
	Mx = x;

	bool cos_basis = do_cos?!swap_table[k]: swap_table[k];
	if(cos_basis) {
	  // In this case, we are using cos() as the basis, so we don't
	  // multiply by Mx*2^Ex.
	  Mx = ap_ufixed<value_list<float>::W_dout, 0, AP_RND, AP_SAT>(1);
	  Ex = 0;
	}

	ap_ufixed<WO+1+g, 1> result = value_list<float>::sin_or_cos_approximation(do_cos,k,x,Mx,Ex);

	if(exactly_pi_over_4) {
	  result = 0.7071067811865475244008443;
	}

	ap_uint<4> index = k;
	index[3] = is_negative;

	if(cos_basis ? neg_cos_table[index] : neg_sin_table[index]) {
	  return -result;
	} else {
	  return result;
	}
  }


  template<int W, int I>
  ap_fixed<W,2> 
  sinf_or_cosf(ap_fixed<W,I> t_in, bool do_cos, bool do_pi, 
			   typename hls::enable_if<(W > 32) && (W <= 64), bool>::type dummy = true)
  {
	const int WO = W;
	const int g = 3;

	const bool swap_table[8] = {0,1,1,0,0,1,1,0};
	const bool neg_sin_table[16] = {0,0,1,0,1,1,0,1, 1,0,1,1,0,1,0,0};
	const bool neg_cos_table[16] = {0,0,0,1,1,1,1,0, 0,1,1,1,1,0,0,0};
#pragma HLS array_partition variable=swap_table complete
#pragma HLS array_partition variable=neg_sin_table complete
#pragma HLS array_partition variable=neg_cos_table complete

	ap_uint<3> k;
	ap_ufixed<WO+1+g, 0> x;
	ap_ufixed<WO+1+g, 0> Mx;
	ap_int<fp_struct<double>::EXP_BITS> Ex = 0;

	int exactly_pi_over_4 = 0;
	bool is_negative = t_in[t_in.wl()-1];
	ap_ufixed<W, I> din = is_negative ? ap_fixed<W, I>(-t_in) : t_in;

	if(do_pi) {
	  k = din*4;
	  x = din*4;
	  ap_ufixed<W, 1> Mx_bits_extended = din*4;
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
	  std::cout << "sin_cos: Mx_bits_extended = " << Mx_bits_extended.to_string(2) << "\n";
#endif
	  exactly_pi_over_4 = (Mx_bits_extended == 1);
	} else {
	  ap_ufixed<WO+1+g+3, 3> Wx = din * ap_ufixed<W+1+g,2>(4/M_PI);
	  k = Wx;
	  x = Wx;
	}
#if !defined(__SYNTHESIS__) && defined(_HLSCLIB_DEBUG_)
	std::cout << "sin_cos: k = " << k.to_string(2) << "\n";
#endif
	// If we're in an odd quadrant, then the base functions need to be flipped.
	if(k[0] == 1) {
	  x = 1-x;
	}
	Mx = x;

	bool cos_basis = do_cos?!swap_table[k]: swap_table[k];
	if(cos_basis) {
	  // In this case, we are using cos() as the basis, so we don't
	  // multiply by Mx*2^Ex.
	  Mx = ap_ufixed<value_list<double>::W_dout, 0, AP_RND, AP_SAT>(1);
	  Ex = 0;
	}

	ap_ufixed<WO+1+g, 1> result = value_list<double>::sin_or_cos_approximation(do_cos,k,x,Mx,Ex);

	if(exactly_pi_over_4) {
	  result = 0.7071067811865475244008443;
	}

	ap_uint<4> index = k;
	index[3] = is_negative;

	if(cos_basis ? neg_cos_table[index] : neg_sin_table[index]) {
	  return -result;
	} else {
	  return result;
	}
  };


  template<int W, int I>
  ap_fixed<W,2> // Result has same number of fractional bits as the input.
  sinf_or_cosf(ap_fixed<W,I> t_in, bool do_cos, bool do_pi, 
			   typename hls::enable_if<W <= 16, bool>::type dummy = true)
  {
	const int WO = W;
	const int g = 4;

	const bool neg_sin_table[8] = {0,0,1,1, 1,1,0,0};
	const bool neg_cos_table[8] = {0,1,1,0, 0,1,1,0};
#pragma HLS array_partition variable=neg_sin_table complete
#pragma HLS array_partition variable=neg_cos_table complete

	ap_uint<2> k;
	ap_ufixed<WO+1+g, 0> x;

	bool is_negative = t_in[t_in.wl()-1];
	ap_ufixed<W, I> din = is_negative ? ap_fixed<W, I>(-t_in) : t_in;

	if(do_pi) {
	  k = din*2;
	  x = din*2;
	  ap_ufixed<W, 1> Mx_bits_extended = din*2;
	} 
	else {
	  ap_ufixed<WO+1+g+2, 2> Wx = din * ap_ufixed<W+1+g,2>(2/M_PI);
	  k = Wx;
	  x = Wx;
	}

	bool is_special_case = false;

	if((k[0] == 1) ^ !do_cos) {
	  ap_ufixed<WO+1+g+1, 1> Wx = 1-x;
	  x = Wx;
	  is_special_case = (Wx[Wx.wl()-1] == 1);
	}

	ap_ufixed<WO+1+g, 1> result = sin_cos_fixed_16::sin_or_cos_approximation(do_cos,k,x);

	if(is_special_case) {
	  ap_uint<3> index = k;
	  index[2] = do_cos;
	  const bool special_case_table[8] = {0,1,0,1,1,0,1,0};
	  result(result.wl()-2,0) = 0;
	  result[result.wl()-1] = special_case_table[index];
	}

	{
	  ap_uint<3> index = k;
	  index[2] = is_negative;

	  if(do_cos ? neg_cos_table[index] : neg_sin_table[index]) {
		return -result;
	  } else {
		return result;
	  }
	}
  };

};

#endif


