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
 *     (c) Copyright 2008-2017 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef _X_HLSTMP_MATH__
#define _X_HLSTMP_MATH__

#ifndef __cplusplus
#error "hls_math.h requires C++ and is not support in C compilation."
#endif

#include <cmath>
#include "hls_half.h"
#include "hls_fpo.h"
#include <stdint.h>

namespace hls {

  // signbit
  int signbit(double);
  int signbit(float);
  int signbit(half);
  int signbitf(float);
  int half_signbit(half);

  // nan
  double nan(const char*);
  float  nanf(const char*);
  half   half_nan(const char *);

  // isfinite
  int isfinite(double);
  int isfinite(float);
  int isfinite(half);
  int isfinitef(float);
  int half_isfinite(half);

  // __isfinite
  int __isfinite(double);
  int __isfinite(float);
  int __isfinite(half);
  int __isfinitef(float);

  // isinf
  int isinf(double);
  int isinf(float);
  int isinf(half);
  int isinff(float);
  int half_isinf(half);

  // __isinf
  int __isinf(double);
  int __isinf(float);
  int __isinf(half);
  int __isinff(float);

  // isnan
  int isnan(double);
  int isnan(float);
  int isnan(half);
  int isnanf(float);
  int half_isnan(half);

  // __isnan
  int __isnan(double);
  int __isnan(float);
  int __isnan(half);
  int __isnanf(float);

  // isnormal
  int isnormal(double);
  int isnormal(float);
  int isnormal(half);
  int isnormalf(float);
  int half_isnormal(half);

  // __isnormal
  int __isnormal(double);
  int __isnormal(float);
  int __isnormal(half);
  int __isnormalf(float);

  // fpclassify
  int fpclassify(double);
  int fpclassify(float);
  int fpclassify(half);
  int fpclassifyf(float);
  int half_fpclassify(half);

  // __fpclassify
  int __fpclassify(double);
  int __fpclassify(float);
  int __fpclassify(half);
  int __fpclassifyf(float);

  // copysign
  double copysign(double, double);
  float  copysign(float, float);
  half   copysign(half, half);
  float  copysignf(float, float);
  half   half_copysign(half, half);
  int8_t copysign(int8_t, int8_t);
  uint8_t copysign(uint8_t, uint8_t);
  int16_t copysign(int16_t, int16_t);
  uint16_t copysign(uint16_t, uint16_t);
  int32_t copysign(int32_t, int32_t);
  uint32_t copysign(uint32_t, uint32_t);

  // fabs
  double fabs(double);
  float  fabs(float);
  half   fabs(half);
  float  fabsf(float);
  half   half_fabs(half);
  int8_t fabs(int8_t);
  uint8_t fabs(uint8_t);
  int16_t fabs(int16_t);
  uint16_t fabs(uint16_t);
  int32_t fabs(int32_t);
  uint32_t fabs(uint32_t);

  // abs
  double abs(double);
  float  abs(float);
  half   abs(half);
  float  absf(float);
  half   half_abs(half);
  int8_t abs(int8_t);
  uint8_t abs(uint8_t);
  int16_t abs(int16_t);
  uint16_t abs(uint16_t);
  int32_t abs(int32_t);
  uint32_t abs(uint32_t);

  // fma
  double fma(double, double, double);
  float  fma(float, float, float);
  half   fma(half, half, half);
  float  fmaf(float, float, float);
  half   half_fma(half, half, half);

  // mad
  double mad(double, double, double);
  float  mad(float, float, float);
  half   mad(half, half, half);
  float  madf(float, float, float);
  half   half_mad(half, half, half);

  // isequal
  int isequal(double, double);
  int isequal(float, float);
  int isequal(half, half);
  int isequalf(float, float);
  int half_isequal(half, half);

  // isgreater
  int isgreater(double, double);
  int isgreater(float, float);
  int isgreater(half, half);
  int isgreaterf(float, float);
  int half_isgreater(half, half);

  // isgreaterequal
  int isgreaterequal(double, double);
  int isgreaterequal(float, float);
  int isgreaterequal(half, half);
  int isgreaterequalf(float, float);
  int half_isgreaterequal(half, half);

  // isless
  int isless(double, double);
  int isless(float, float);
  int isless(half, half);
  int islessf(float, float);
  int half_isless(half, half);

  // islessequal
  int islessequal(double, double);
  int islessequal(float, float);
  int islessequal(half, half);
  int islessequalf(float, float);
  int half_islessequal(half, half);

  // islessgreater
  int islessgreater(double, double);
  int islessgreater(float, float);
  int islessgreater(half, half);
  int islessgreaterf(float, float);
  int half_islessgreater(half, half);

  // isnotequal
  int isnotequal(double, double);
  int isnotequal(float, float);
  int isnotequal(half, half);
  int isnotequalf(float, float);
  int half_isnotequal(half, half);

  // fmax
  double 	fmax(double, double);
  float  	fmax(float, float);
  half   	fmax(half, half);
  float  	fmaxf(float, float);
  half   	half_fmax(half, half);
  int8_t 	fmax(int8_t,int8_t);
  uint8_t 	fmax(uint8_t, uint8_t);
  int16_t 	fmax(int16_t, int16_t);
  uint16_t 	fmax(uint16_t, uint16_t);
  int32_t 	fmax(int32_t, int32_t);
  uint32_t 	fmax(uint32_t, uint32_t);

  // fmin
  double 	fmin(double, double);
  float  	fmin(float, float);
  half   	fmin(half, half);
  float  	fminf(float, float);
  half   	half_fmin(half, half);
  int8_t 	fmin(int8_t,int8_t);
  uint8_t 	fmin(uint8_t, uint8_t);
  int16_t 	fmin(int16_t, int16_t);
  uint16_t 	fmin(uint16_t, uint16_t);
  int32_t 	fmin(int32_t, int32_t);
  uint32_t 	fmin(uint32_t, uint32_t);

  // max
  template <class T>
  T max(T x, T y){
	return (x > y) ? x : y;
  }

  // min
  template <class T>
  T min(T x, T y){
	return (x < y) ? x : y;
  }

  // fdim
  double 	fdim(double, double);
  float  	fdim(float, float);
  half   	fdim(half, half);
  float  	fdimf(float, float);
  half   	half_fdim(half, half);
  int8_t 	fdim(int8_t,int8_t);
  uint8_t   fdim(uint8_t, uint8_t);
  int16_t   fdim(int16_t, int16_t);
  uint16_t  fdim(uint16_t, uint16_t);
  int32_t   fdim(int32_t, int32_t);
  uint32_t  fdim(uint32_t, uint32_t);

  // maxmag
  double 	maxmag(double, double);
  float  	maxmag(float, float);
  half   	maxmag(half, half);
  float  	maxmagf(float, float);
  half   	half_maxmag(half, half);
  int8_t 	maxmag(int8_t,int8_t);
  uint8_t 	maxmag(uint8_t, uint8_t);
  int16_t 	maxmag(int16_t, int16_t);
  uint16_t 	maxmag(uint16_t, uint16_t);
  int32_t 	maxmag(int32_t, int32_t);
  uint32_t 	maxmag(uint32_t, uint32_t);

  // minmag
  double 	minmag(double, double);
  float  	minmag(float, float);
  half   	minmag(half, half);
  float  	minmagf(float, float);
  half   	half_minmag(half, half);
  int8_t 	minmag(int8_t,int8_t);
  uint8_t 	minmag(uint8_t, uint8_t);
  int16_t 	minmag(int16_t, int16_t);
  uint16_t	minmag(uint16_t, uint16_t);
  int32_t 	minmag(int32_t, int32_t);
  uint32_t 	minmag(uint32_t, uint32_t);
 

  // frexp
  double frexp(double, int*);
  float  frexp(float, int*);
  half   frexp(half, int*);
  float  frexpf(float, int*);
  half   half_frexp(half, int*);

  // ldexp
  double ldexp(double, int);
  float  ldexp(float, int);
  half   ldexp(half, int);
  float  ldexpf(float, int);
  half   half_ldexp(half, int);

  // ilogb
  int ilogb(double);
  int ilogb(float);
  int ilogb(half);
  int ilogbf(float);
  int half_ilogb(half);

  // scalbn
  double scalbn(double, int);
  float  scalbn(float, int);
  half   scalbn(half, int);
  float  scalbnf(float, int);
  half   half_scalbn(half, int);

  // scalbln
  double scalbln(double, long int);
  float  scalbln(float, long int);
  half   scalbln(half, long int);
  float  scalblnf(float, long int);
  half   half_scalbln(half, long int);

  // ceil
  double ceil(double);
  float  ceil(float);
  half   ceil(half);
  float  ceilf(float);
  half   half_ceil(half);
  
  // floor
  double floor(double);
  float  floor(float);
  half   floor(half);
  float  floorf(float);
  half   half_floor(half);

  // trunc
  double trunc(double);
  float  trunc(float);
  half   trunc(half);
  float  truncf(float);
  half   half_trunc(half);

  // round
  double round(double);
  float  round(float);
  half   round(half);
  float  roundf(float);
  half   half_round(half);

  // rint
  double rint(double);
  float  rint(float);
  half   rint(half);
  float  rintf(float);
  half   half_rint(half);

  // lround
  long int lround(double);
  long int lround(float);
  long int lround(half);
  long int lroundf(float);
  long int half_lround(half);

  // llround
  long long int llround(double);
  long long int llround(float);
  long long int llround(half);
  long long int llroundf(float);
  long long int half_llround(half);

  // lrint
  long int lrint(double);
  long int lrint(float);
  long int lrint(half);
  long int lrintf(float);
  long int half_lrint(half);

  // llrint
  long long int llrint(double);
  long long int llrint(float);
  long long int llrint(half);
  long long int llrintf(float);
  long long int half_llrint(half);

  // cast_IEEE754
  template<class T>
  T cast_IEEE754(double, bool);
  template<class T>
  T cast_IEEE754(float, bool);
  template<class T>
  T cast_IEEE754(half, bool);

  template<class T>
  T cast_IEEE754(double);
  template<class T>
  T cast_IEEE754(float);
  template<class T>
  T cast_IEEE754(half);


  // cast_IEEE754<char>
  template<>
  char cast_IEEE754<char>(double, bool);
  template<>
  char cast_IEEE754<char>(float, bool);
  template<>
  char cast_IEEE754<char>(half, bool);
  template<>
  char cast_IEEE754<char>(double);
  template<>
  char cast_IEEE754<char>(float);
  template<>
  char cast_IEEE754<char>(half);

  // cast_IEEE754<int8_t>
  template<>
  int8_t cast_IEEE754<int8_t>(double, bool);
  template<>
  int8_t cast_IEEE754<int8_t>(float, bool);
  template<>
  int8_t cast_IEEE754<int8_t>(half, bool);
  template<>
  int8_t cast_IEEE754<int8_t>(double);
  template<>
  int8_t cast_IEEE754<int8_t>(float);
  template<>
  int8_t cast_IEEE754<int8_t>(half);

  // cast_IEEE754<uint8_t>
  template<>
  uint8_t cast_IEEE754<uint8_t>(double, bool);
  template<>
  uint8_t cast_IEEE754<uint8_t>(float, bool);
  template<>
  uint8_t cast_IEEE754<uint8_t>(half, bool);
  template<>
  uint8_t cast_IEEE754<uint8_t>(double);
  template<>
  uint8_t cast_IEEE754<uint8_t>(float);
  template<>
  uint8_t cast_IEEE754<uint8_t>(half);

  // cast_IEEE754<int16_t>
  template<>
  int16_t cast_IEEE754<int16_t>(double, bool);
  template<>
  int16_t cast_IEEE754<int16_t>(float, bool);
  template<>
  int16_t cast_IEEE754<int16_t>(half, bool);
  template<>
  int16_t cast_IEEE754<int16_t>(double);
  template<>
  int16_t cast_IEEE754<int16_t>(float);
  template<>
  int16_t cast_IEEE754<int16_t>(half);

  // cast_IEEE754<uint16_t>
  template<>
  uint16_t cast_IEEE754<uint16_t>(double, bool);
  template<>
  uint16_t cast_IEEE754<uint16_t>(float, bool);
  template<>
  uint16_t cast_IEEE754<uint16_t>(half, bool);
  template<>
  uint16_t cast_IEEE754<uint16_t>(double);
  template<>
  uint16_t cast_IEEE754<uint16_t>(float);
  template<>
  uint16_t cast_IEEE754<uint16_t>(half);

  // cast_IEEE754<int32_t>
  template<>
  int32_t cast_IEEE754<int32_t>(double, bool);
  template<>
  int32_t cast_IEEE754<int32_t>(float, bool);
  template<>
  int32_t cast_IEEE754<int32_t>(half, bool);
  template<>
  int32_t cast_IEEE754<int32_t>(double);
  template<>
  int32_t cast_IEEE754<int32_t>(float);
  template<>
  int32_t cast_IEEE754<int32_t>(half);

  // cast_IEEE754<uint32_t>
  template<>
  uint32_t cast_IEEE754<uint32_t>(double, bool);
  template<>
  uint32_t cast_IEEE754<uint32_t>(float, bool);
  template<>
  uint32_t cast_IEEE754<uint32_t>(half, bool);
  template<>
  uint32_t cast_IEEE754<uint32_t>(double);
  template<>
  uint32_t cast_IEEE754<uint32_t>(float);
  template<>
  uint32_t cast_IEEE754<uint32_t>(half);

  // cast_IEEE754<int64_t>
  template<>
  int64_t cast_IEEE754<int64_t>(double, bool);
  template<>
  int64_t cast_IEEE754<int64_t>(float, bool);
  template<>
  int64_t cast_IEEE754<int64_t>(half, bool);
  template<>
  int64_t cast_IEEE754<int64_t>(double);
  template<>
  int64_t cast_IEEE754<int64_t>(float);
  template<>
  int64_t cast_IEEE754<int64_t>(half);

  // cast_IEEE754<uint64_t>
  template<>
  uint64_t cast_IEEE754<uint64_t>(double, bool);
  template<>
  uint64_t cast_IEEE754<uint64_t>(float, bool);
  template<>
  uint64_t cast_IEEE754<uint64_t>(half, bool);
  template<>
  uint64_t cast_IEEE754<uint64_t>(double);
  template<>
  uint64_t cast_IEEE754<uint64_t>(float);
  template<>
  uint64_t cast_IEEE754<uint64_t>(half);


  // nearbyint
  double nearbyint(double);
  float  nearbyint(float);
  half   nearbyint(half);
  float  nearbyintf(float);
  half   half_nearbyint(half);

  // modf
  double modf(double, double*);
  float  modf(float, float*);
  half   modf(half, half*);
  float  modff(float, float*);
  half   half_modf(half, half*);

  // fract
  double fract(double, double*);
  float  fract(float, float*);
  half   fract(half, half*);
  float  fractf(float, float*);
  half   half_fract(half, half*);

  // isordered
  int isordered(double, double);
  int isordered(float, float);
  int isordered(half, half);
  int isorderedf(float, float);
  int half_isordered(half, half);

  // isunordered
  int isunordered(double, double);
  int isunordered(float, float);
  int isunordered(half, half);
  int isunorderedf(float, float);
  int half_isunordered(half, half);

  // bitselect
  double   bitselect(double, double, double);
  float    bitselect(float, float, float);
  int      bitselect(int, int, int);
  uint32_t bitselect(uint32_t, uint32_t, uint32_t);
  half     bitselect(half, half, half);
  float    bitselectf(float, float, float);
  half     half_bitselect(half, half, half);

  // sin cos implemented with hotbm method
  namespace hotbm {
	double sin(double);
	float  sin(float);
	half   sin(half);
	float  sinf(float);
	half   half_sin(half);

	double cos(double);
	float  cos(float);
	half   cos(half);
	float  cosf(float);
	half   half_cos(half);

	void sincos(double, double*, double*);
	void sincos(float, float*, float*);
	void sincos(half, half*, half*);
	void sincosf(float, float*, float*);
	void half_sincos(half, half*, half*);
  }

  // sin cos implemented with cordic method
  namespace cordic {
	double sin(double);
	float  sin(float);
	half   sin(half);
	float  sinf(float);
	half   half_sin(half);

	double cos(double);
	float  cos(float);
	half   cos(half);
	float  cosf(float);
	half   half_cos(half);

	void sincos(double, double*, double*);
	void sincos(float, float*, float*);
	void sincos(half, half*, half*);
	void sincosf(float, float*, float*);
	void half_sincos(half, half*, half*);
  }
  
  // sin cos implemented with hotbm method
  double sin(double);
  float  sin(float);
  half   sin(half);
  float  sinf(float);
  half   half_sin(half);

  double cos(double);
  float  cos(float);
  half   cos(half);
  float  cosf(float);
  half   half_cos(half);

  // sincos
  void sincos(double, double*, double*);
  void sincos(float, float*, float*);
  void sincos(half, half*, half*);
  void sincosf(float, float*, float*);
  void half_sincos(half, half*, half*);

  // sinpi
  double sinpi(double);
  float  sinpi(float);
  half   sinpi(half);
  float  sinpif(float);
  half   half_sinpi(half);

  // cospi
  double cospi(double);
  float  cospi(float);
  half   cospi(half);
  float  cospif(float);
  half   half_cospi(half);
  
  // tanpi
  double tanpi(double);
  float  tanpi(float);
  half   tanpi(half);
  float  tanpif(float);
  half   half_tanpi(half);

  // atan
  double atan(double);
  float  atan(float);
  half   atan(half);
  float  atanf(float);
  half   half_atan(half);

  // atan2
  double atan2(double, double);
  float  atan2(float, float);
  half   atan2(half, half);
  float  atan2f(float, float);
  half   half_atan2(half, half);

  // tan
  double tan(double);
  float  tan(float);
  half   tan(half);
  float  tanf(float);
  half   half_tan(half);

  // sinh
  double sinh(double);
  float  sinh(float);
  half   sinh(half);
  float  sinhf(float);
  half   half_sinh(half);

  // cosh
  double cosh(double);
  float  cosh(float);
  half   cosh(half);
  float  coshf(float);
  half   half_cosh(half);

  // exp
  double exp(double);
  float  exp(float);
  half   exp(half);
  float  expf(float);
  half   half_exp(half);
  int8_t exp(int8_t);
  uint8_t exp(uint8_t);
  int16_t exp(int16_t);
  uint16_t exp(uint16_t);
  int32_t exp(int32_t);
  uint32_t exp(uint32_t);

  // exp2
  double exp2(double);
  float  exp2(float);
  half   exp2(half);
  float  exp2f(float);
  half   half_exp2(half);

  // exp10
  double exp10(double);
  float  exp10(float);
  half   exp10(half);
  float  exp10f(float);
  half   half_exp10(half);

  // expm1
  double expm1(double);
  float  expm1(float);
  half   expm1(half);
  float  expm1f(float);
  half   half_expm1(half);

  // log
  double log(double);
  float  log(float);
  half   log(half);
  float  logf(float);
  half   half_log(half);
  int8_t log(int8_t);
  uint8_t log(uint8_t);
  int16_t log(int16_t);
  uint16_t log(uint16_t);
  int32_t log(int32_t);
  uint32_t log(uint32_t);

  // log2
  double log2(double);
  float  log2(float);
  half   log2(half);
  float  log2f(float);
  half   half_log2(half);

  // log10
  double log10(double);
  float  log10(float);
  half   log10(half);
  float  log10f(float);
  half   half_log10(half);
  int8_t log10(int8_t);
  uint8_t log10(uint8_t);
  int16_t log10(int16_t);
  uint16_t log10(uint16_t);
  int32_t log10(int32_t);
  uint32_t log10(uint32_t);

  // logb
  double logb(double);
  float  logb(float);
  half   logb(half);
  float  logbf(float);
  half   half_logb(half);
  // log1p
  double log1p(double);
  float  log1p(float);
  half   log1p(half);
  float  log1pf(float);
  half   half_log1p(half);

  // pow
  half   pow(half, half);
  float  pow(float, float);
  double pow(double, double);
  float  powf(float, float);
  half   half_pow(half, half);
  int8_t pow(int8_t, int8_t);
  uint8_t pow(uint8_t, uint8_t);
  int16_t pow(int16_t, int16_t);
  uint16_t pow(uint16_t, uint16_t);
  int32_t pow(int32_t, int32_t);
  uint32_t pow(uint32_t, uint32_t);
  int8_t powr(int8_t, int8_t);
  uint8_t powr(uint8_t, uint8_t);
  int16_t powr(int16_t, int16_t);
  uint16_t powr(uint16_t, uint16_t);
  int32_t powr(int32_t, int32_t);
  uint32_t powr(uint32_t, uint32_t);

  // powr
  half   powr(half, half);
  float  powr(float, float);
  double powr(double, double);
  float  powrf(float, float);
  half   half_powr(half, half);

  // pown
  half   pown(half, int);
  float  pown(float, int);
  double pown(double, int);
  float  pownf(float, int);
  half   half_pown(half, int);

  // rootn
  half   rootn(half, int);
  float  rootn(float, int);
  double rootn(double, int);
  float  rootnf(float, int);
  half   half_rootn(half, int);

  // sqrt
  double sqrt(double);
  float  sqrt(float);
  half   sqrt(half);
  float  sqrtf(float);
  half   half_sqrt(half);
  int8_t sqrt(int8_t);
  uint8_t sqrt(uint8_t);
  int16_t sqrt(int16_t);
  uint16_t sqrt(uint16_t);
  int32_t sqrt(int32_t);
  uint32_t sqrt(uint32_t);

  // template<int W, int I>
  // ap_fixed<W,I> sqrt(ap_fixed<W,I> x){
  // 	return sqrt_fixed(x);
  // };
  // template<int W, int I>
  // ap_ufixed<W,I> sqrt(ap_ufixed<W,I> x){
  //   return sqrt_fixed(x);
  // }
  // template<int I>
  // ap_int<I> sqrt(ap_int<I> x){
  //   return sqrt_fixed(x);
  // }
  // template<int I>
  // ap_uint<I> sqrt(ap_uint<I> x){
  //   return sqrt_fixed(x);
  // }

  // recip
  double recip(double);
  float  recip(float);
  half   recip(half);
  float  recipf(float);
  half   half_recip(half);
  int8_t recip(int8_t);
  uint8_t recip(uint8_t);
  int16_t recip(int16_t);
  uint16_t recip(uint16_t);
  int32_t recip(int32_t);
  uint32_t recip(uint32_t);

  // rsqrt
  double rsqrt(double);
  float  rsqrt(float);
  half   rsqrt(half);
  float  rsqrtf(float);
  half   half_rsqrt(half);
  int8_t rsqrt(int8_t);
  uint8_t rsqrt(uint8_t);
  int16_t rsqrt(int16_t);
  uint16_t rsqrt(uint16_t);
  int32_t rsqrt(int32_t);
  uint32_t rsqrt(uint32_t);

  // cbrt
  double cbrt(double);
  float  cbrt(float);
  half   cbrt(half);
  float  cbrtf(float);
  half   half_cbrt(half);

  // hypot
  double hypot(double, double);
  float  hypot(float, float);
  half   hypot(half, half);
  float  hypotf(float, float);
  half   half_hypot(half, half);

  // erf
  double erf(double);
  float  erf(float);
  half   erf(half);
  float  erff(float);
  half   half_erf(half);
  int8_t   erf(int8_t);
  uint8_t  erf(uint8_t);
  int16_t  erf(int16_t);
  uint16_t erf(uint16_t);
  int32_t  erf(int32_t);
  uint32_t erf(uint32_t);

  // erfc
  double erfc(double);
  float  erfc(float);
  half   erfc(half);
  float  erfcf(float);
  half   half_erfc(half);
  int8_t   erfc(int8_t);
  uint8_t  erfc(uint8_t);
  int16_t  erfc(int16_t);
  uint16_t erfc(uint16_t);
  int32_t  erfc(int32_t);
  uint32_t erfc(uint32_t);

  // lgamma
  double lgamma(double);
  float  lgamma(float);
  half   lgamma(half);
  float  lgammaf(float);
  half   half_lgamma(half);
  int8_t   lgamma(int8_t);
  uint8_t  lgamma(uint8_t);
  int16_t  lgamma(int16_t);
  uint16_t lgamma(uint16_t);
  int32_t  lgamma(int32_t);
  uint32_t lgamma(uint32_t);

  // lgamma_r
  double lgamma_r(double, int*);
  float  lgamma_r(float, int*);
  half   lgamma_r(half, int*);
  float  lgamma_rf(float, int*);
  half   half_lgamma_r(half, int*);
  int8_t   lgamma_r(int8_t);
  uint8_t  lgamma_r(uint8_t);
  int16_t  lgamma_r(int16_t);
  uint16_t lgamma_r(uint16_t);
  int32_t  lgamma_r(int32_t);
  uint32_t lgamma_r(uint32_t);

  // cbrt
  double tgamma(double);
  float  tgamma(float);
  half   tgamma(half);
  float  tgammaf(float);
  half   half_tgamma(half);
  int8_t   tgamma(int8_t);
  uint8_t  tgamma(uint8_t);
  int16_t  tgamma(int16_t);
  uint16_t tgamma(uint16_t);
  int32_t  tgamma(int32_t);
  uint32_t tgamma(uint32_t);

  double tgamma_p_reduce(double);
  float  tgamma_p_reduce(float);
  float  tgammaf_p_reduce(float);

  // fmod
  double fmod(double, double);
  float  fmod(float, float);
  half   fmod(half, half);
  float  fmodf(float, float);
  half   half_fmod(half, half);

  // remainder
  double remainder(double, double);
  float  remainder(float, float);
  half   remainder(half, half);
  float  remainderf(float, float);
  half   half_remainder(half, half);

  // remquo
  double remquo(double, double, int*);
  float  remquo(float, float, int*);
  half   remquo(half, half, int*);
  float  remquof(float, float, int*);
  half   half_remquo(half, half, int*);

  // divide
  double divide(double, double);
  float  divide(float, float);
  half   divide(half, half);
  float  dividef(float, float);
  half   half_divide(half, half);

  // nextafter
  double nextafter(double, double);
  float  nextafter(float, float);
  half   nextafter(half, half);
  float  nextafterf(float, float);
  half   half_nextafter(half, half);

  // tanh
  double tanh(double);
  float  tanh(float);
  half   tanh(half);
  float  tanhf(float);
  half   half_tanh(half);

  // atanh
  double atanh(double);
  float  atanh(float);
  half   atanh(half);
  float  atanhf(float);
  half   half_atanh(half);

  // asinh
  double asinh(double);
  float  asinh(float);
  half   asinh(half);
  float  asinhf(float);
  half   half_asinh(half);

  // acosh
  double acosh(double);
  float  acosh(float);
  half   acosh(half);
  float  acoshf(float);
  half   half_acosh(half);

  // asin
  double asin(double);
  float  asin(float);
  half   asin(half);
  float  asinf(float);
  half   half_asin(half);

  // acos
  double acos(double);
  float  acos(float);
  half   acos(half);
  float  acosf(float);
  half   half_acos(half);

  // asinpi
  double asinpi(double);
  float  asinpi(float);
  half   asinpi(half);
  float  asinpif(float);
  half   half_asinpi(half);
  
  // acospi
  double acospi(double);
  float  acospi(float);
  half   acospi(half);
  float  acospif(float);
  half   half_acospi(half);

  // tanpi
  double atanpi(double);
  float  atanpi(float);
  half   atanpi(half);
  float  atanpif(float);
  half   half_atanpi(half);
}

#include "hls_hotbm_apfixed.h"
#include "hls_cordic_apfixed.h"
#include "hls_exp_apfixed.h"
#include "hls_log_apfixed.h"
#include "hls_sqrt_apfixed.h"
#include "hls_round_copysign_apfixed.h"
#include "hls_pow_apfixed.h"
#include "hls_diff_apfixed.h"
#include "hls_comparison_apfixed.h"
#include "hls_frexp_apfixed.h"
#include "hls_modf_apfixed.h"
#include "hls_isequal_isnotequal_apfixed.h"
#include "hls_all_any_apfixed.h"
#include "hls_select_bitselect_apfixed.h"
#include "hls_erf_apfixed.h"
#include "hls_fmod_rem_quo_remainder_divide_apfixed.h"
#include "hls_lgamma_apfixed.h"
#include "hls_tgamma_apfixed.h"
#include "hls_fract_apfixed.h"
#include "hls_mad_apfixed.h"
#include "hls_cbrt_apfixed.h"
#include "hls_hypot_apfixed.h"
#include "hls_ldexp_apfixed.h"

namespace hls {

  // // sin(ap_fixed)
  // template<int W, int I>
  // ap_fixed<W, 2> sin(ap_fixed<W,I> x){
  // 	return hotbm_apfixed::sinf_or_cosf<W,I>(x, 0, 0);
  // }
  // template<int W, int I>
  // ap_fixed<W, 2> sinf(ap_fixed<W,I> x){
  // 	return hotbm_apfixed::sinf_or_cosf<W,I>(x, 0, 0);
  // }

  // // cos(ap_fixed)
  // template<int W, int I>
  // ap_fixed<W, 2> cos(ap_fixed<W,I> x){
  // 	return hotbm_apfixed::sinf_or_cosf<W,I>(x, 1, 0);
  // }
  // template<int W, int I>
  // ap_fixed<W, 2> cosf(ap_fixed<W,I> x){
  // 	return hotbm_apfixed::sinf_or_cosf<W,I>(x, 1, 0);
  // }

  // sinpi(ap_fixed), cospi(ap_fixed)
  template<int W, int I>
  ap_fixed<W, 2> sinpi(ap_fixed<W,I> x){
    return hotbm_apfixed::sinf_or_cosf<W,I>(x, 0, 1);
  }
/*  template<int W, int I>
  ap_fixed<W, 2> sinpif(ap_fixed<W,I> x){
    return hotbm_apfixed::sinf_or_cosf<W,I>(x, 0, 1);
    }*/
  template<int W, int I>
  ap_ufixed<W, 2> sinpi(ap_ufixed<W,I> x){
      ap_fixed<W+1, I+1> xin = x;
      ap_fixed<W+1, 3> xout = hls::sinpi<W+1, I+1>(x);
	  ap_ufixed<W, 2> out = 0;
	  if(xout[W]==0){
		  out = xout;
	  }
	  return out;
  }

  template<int W, int I>
  ap_fixed<W, 2> cospi(ap_fixed<W,I> x){
    return hotbm_apfixed::sinf_or_cosf<W,I>(x, 1, 1);
  }
  template<int W, int I>
  ap_ufixed<W, 2> cospi(ap_ufixed<W,I> x){
	  ap_fixed<W+1, I+1> xin = x;
	  ap_fixed<W+1, 3> xout = hls::cospi<W+1, I+1>(x);
	  ap_ufixed<W, 2> out = 0;
	  if(xout[W]==0){
		  out = xout;
	  }
	  return out;
  }
 /* template<int W, int I>
  ap_fixed<W, 2> cospif(ap_fixed<W,I> x){
    return hotbm_apfixed::sinf_or_cosf<W,I>(x, 1, 1);
  }*/  
  //ap_int sinpi
  template<int I>
  ap_int<I> sinpi(ap_int<I> in){
        _AP_UNUSED_PARAM(in);
	return ap_int<I>(0);
  }
  //ap_int cospi
  template<int I>
  ap_int<I> cospi(ap_int<I> in){
        _AP_UNUSED_PARAM(in);
	return ap_int<I>(0);
  }
  //ap_uint sinpi
  template<int I>
  ap_uint<I> sinpi(ap_uint<I> in){
        _AP_UNUSED_PARAM(in);
	return ap_uint<I>(0);
  }
  //ap_uint cospi
  template<int I>
  ap_uint<I> cospi(ap_uint<I> in){
        _AP_UNUSED_PARAM(in);
	return ap_uint<I>(0);
  }
  int8_t   sinpi(int8_t);
  uint8_t  sinpi(uint8_t);
  int16_t  sinpi(int16_t);
  uint16_t sinpi(uint16_t);
  int32_t  sinpi(int32_t);
  uint32_t sinpi(uint32_t);

  int8_t   cospi(int8_t);
  uint8_t  cospi(uint8_t);
  int16_t  cospi(int16_t);
  uint16_t cospi(uint16_t);
  int32_t  cospi(int32_t);
  uint32_t cospi(uint32_t);

  // exp(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> exp(ap_fixed<W,I> x){
    return exp_reduce::exp(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> exp(ap_ufixed<W,I> x){
    return exp_reduce::exp(x);
  }
  template<int I>
  ap_int<I> exp(ap_int<I> x){
    return exp_reduce::exp(x);
  }
  template<int I>
  ap_uint<I> exp(ap_uint<I> x){
    return exp_reduce::exp(x);
  }

  // log(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> log(ap_fixed<W,I> x){
    return log_apfixed_reduce::log(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> log(ap_ufixed<W,I> x){
    return log_apfixed_reduce::log(x);
  }
  template<int I>
  ap_int<I> log(ap_int<I> x){
    return log_apfixed_reduce::log(x);
  }
  template<int I>
  ap_uint<I> log(ap_uint<I> x){
    return log_apfixed_reduce::log(x);
  }

  // log10(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> log10(ap_fixed<W,I> x){
    return log_apfixed_reduce::log10(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> log10(ap_ufixed<W,I> x){
    return log_apfixed_reduce::log10(x);
  }
  template<int I>
  ap_int<I> log10(ap_int<I> x){
    return log_apfixed_reduce::log10(x);
  }
  template<int I>
  ap_uint<I> log10(ap_uint<I> x){
	return log_apfixed_reduce::log10(x);
  }

  // log2(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> log2(ap_fixed<W,I> x){
    return log_apfixed_reduce::log2(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> log2(ap_ufixed<W,I> x){
    return log_apfixed_reduce::log2(x);
  }
  template<int I>
  ap_int<I> log2(ap_int<I> x){
    return log_apfixed_reduce::log2(x);
  }
  template<int I>
  ap_uint<I> log2(ap_uint<I> x){
	return log_apfixed_reduce::log2(x);
  }

  // logb(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> logb(ap_fixed<W,I> x){
    return log_apfixed_reduce::logb(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> logb(ap_ufixed<W,I> x){
    return log_apfixed_reduce::logb(x);
  }
  template<int I>
  ap_int<I> logb(ap_int<I> x){
    return log_apfixed_reduce::logb(x);
  }
  template<int I>
  ap_uint<I> logb(ap_uint<I> x){
	return log_apfixed_reduce::logb(x);
  }

  // sqrt(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> sqrt(ap_fixed<W,I> x){
    return sqrt_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> sqrt(ap_ufixed<W,I> x){
    return sqrt_fixed(x);
  }
  template<int I>
  ap_int<I> sqrt(ap_int<I> x){
    return sqrt_fixed(x);
  }
  template<int I>
  ap_uint<I> sqrt(ap_uint<I> x){
    return sqrt_fixed(x);
  }
  
  // rsqrt(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> rsqrt(ap_fixed<W,I> x){
    return rsqrt_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> rsqrt(ap_ufixed<W,I> x){
    return rsqrt_fixed(x);
  }
  template<int I>
  ap_int<I> rsqrt(ap_int<I> x){
    return rsqrt_fixed(x);
  }
  template<int I>
  ap_uint<I> rsqrt(ap_uint<I> x){
    return rsqrt_fixed(x);
  }
  
  // recip(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> recip(ap_fixed<W,I> x){
    return recip_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> recip(ap_ufixed<W,I> x){
    return recip_fixed(x);
  }
  template<int I>
  ap_int<I> recip(ap_int<I> x){
    return recip_fixed(x);
  }
  template<int I>
  ap_uint<I> recip(ap_uint<I> x){
    return recip_fixed(x);
  }

  // ceil(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> ceil(ap_fixed<W,I> x){
    return ceil_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> ceil(ap_ufixed<W,I> x){
    return ceil_fixed(x);
  }
  template<int I>
  ap_int<I> ceil(ap_int<I> x){
    return ceil_fixed(x);
  }
  template<int I>
  ap_uint<I> ceil(ap_uint<I> x){
    return ceil_fixed(x);
  }

  // floor(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> floor(ap_fixed<W,I> x){
    return floor_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> floor(ap_ufixed<W,I> x){
    return floor_fixed(x);
  }
  template<int I>
  ap_int<I> floor(ap_int<I> x){
    return floor_fixed(x);
  }
  template<int I>
  ap_uint<I> floor(ap_uint<I> x){
    return floor_fixed(x);
  }

  template<int W, int I>
  ap_fixed<W,I> trunc(ap_fixed<W,I> x){
    return trunc_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> trunc(ap_ufixed<W,I> x){
    return trunc_fixed(x);
  }
  template<int I>
  ap_int<I> trunc(ap_int<I> x){
    return trunc_fixed(x);
  }
  template<int I>
  ap_uint<I> trunc(ap_uint<I> x){
    return trunc_fixed(x);
  }

  // copysign(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> copysign(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return copysign_fixed(x,y);
  }
  template<int W, int I>
  ap_ufixed<W,I> copysign(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return copysign_fixed(x,y);
  }
  template<int I>
  ap_int<I> copysign(ap_int<I> x, ap_int<I> y){
    return copysign_fixed(x,y);
  }
  template<int I>
  ap_uint<I> copysign(ap_uint<I> x, ap_uint<I> y){
    return copysign_fixed(x,y);
  }

  // fabs(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> fabs(ap_fixed<W,I> x){
    return fabs_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> fabs(ap_ufixed<W,I> x){
    return fabs_fixed(x);
  }
  template<int I>
  ap_int<I> fabs(ap_int<I> x){
    return fabs_fixed(x);
  }
  template<int I>
  ap_uint<I> fabs(ap_uint<I> x){
    return fabs_fixed(x);
  }
  // abs(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> abs(ap_fixed<W,I> x){
    return fabs_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> abs(ap_ufixed<W,I> x){
    return fabs_fixed(x);
  }
  template<int I>
  ap_int<I> abs(ap_int<I> x){
    return fabs_fixed(x);
  }
  template<int I>
  ap_uint<I> abs(ap_uint<I> x){
    return fabs_fixed(x);
  }

  // fdim(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> fdim(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return fdim_fixed(x,y);
  }
  template<int W, int I>
  ap_ufixed<W,I> fdim(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return fdim_fixed(x,y);
  }
  template<int I>
  ap_int<I> fdim(ap_int<I> x, ap_int<I> y){
    return fdim_fixed(x,y);
  }
  template<int I>
  ap_uint<I> fdim(ap_uint<I> x, ap_uint<I> y){
    return fdim_fixed(x,y);
  }
  // fmax(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> fmax(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return fmax_fixed(x,y);
  }
  template<int W, int I>
  ap_ufixed<W,I> fmax(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return fmax_fixed(x,y);
  }
  template<int I>
  ap_int<I> fmax(ap_int<I> x, ap_int<I> y){
    return fmax_fixed(x,y);
  }
  template<int I>
  ap_uint<I> fmax(ap_uint<I> x, ap_uint<I> y){
    return fmax_fixed(x,y);
  }
  // fmin(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> fmin(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return fmin_fixed(x,y);
  }
  template<int W, int I>
  ap_ufixed<W,I> fmin(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return fmin_fixed(x,y);
  }
  template<int I>
  ap_int<I> fmin(ap_int<I> x, ap_int<I> y){
    return fmin_fixed(x,y);
  }
  template<int I>
  ap_uint<I> fmin(ap_uint<I> x, ap_uint<I> y){
    return fmin_fixed(x,y);
  }
  // maxmag(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> maxmag(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return maxmag_fixed(x,y);
  }
  template<int W, int I>
  ap_ufixed<W,I> maxmag(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return maxmag_fixed(x,y);
  }
  template<int I>
  ap_int<I> maxmag(ap_int<I> x, ap_int<I> y){
    return maxmag_fixed(x,y);
  }
  template<int I>
  ap_uint<I> maxmag(ap_uint<I> x, ap_uint<I> y){
    return maxmag_fixed(x,y);
  }
    // minmag(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> minmag(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return minmag_fixed(x,y);
  }
  template<int W, int I>
  ap_ufixed<W,I> minmag(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return minmag_fixed(x,y);
  }
  template<int I>
  ap_int<I> minmag(ap_int<I> x, ap_int<I> y){
    return minmag_fixed(x,y);
  }
  template<int I>
  ap_uint<I> minmag(ap_uint<I> x, ap_uint<I> y){
    return minmag_fixed(x,y);
  }
  
  
  // sinh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> sinh(ap_fixed<W,I> x){
	return cordic_apfixed::generic_sinh(x);
  }

  // sinh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> sinh(ap_ufixed<W,I> x){
	return cordic_apfixed::generic_sinh(x);
  }

  // sinh(ap_int)
  template<int I>
  ap_int<I> sinh(ap_int<I> x){
	return cordic_apfixed::generic_sinh(x);
  }

  // sinh(ap_uint)
  template<int I>
  ap_uint<I> sinh(ap_uint<I> x){
	return cordic_apfixed::generic_sinh(x);
  }

  // cosh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> cosh(ap_fixed<W,I> x){
	return cordic_apfixed::generic_cosh(x);
  }

  // cosh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> cosh(ap_ufixed<W,I> x){
	return cordic_apfixed::generic_cosh(x);
  }

  // cosh(ap_int)
  template<int I>
  ap_int<I> cosh(ap_int<I> x){
	return cordic_apfixed::generic_cosh(x);
  }

  // cosh(ap_uint)
  template<int I>
  ap_uint<I> cosh(ap_uint<I> x){
	return cordic_apfixed::generic_cosh(x);
  }

  // tanh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> tanh(ap_fixed<W,I> x){
    return cordic_apfixed::generic_tanh(x);
  }

  // tanh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> tanh(ap_ufixed<W,I> x){
    return cordic_apfixed::generic_tanh(x);
  }

  // tanh(ap_int)
  template<int I>
  ap_int<I> tanh(ap_int<I> x){
    return cordic_apfixed::generic_tanh(x);
  }

  // tanh(ap_uint)
  template<int I>
  ap_uint<I> tanh(ap_uint<I> x){
    return cordic_apfixed::generic_tanh(x);
  }

  // atanh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> atanh(ap_fixed<W,I> x){
    ap_fixed<W,I> one_plus_x = 1 + x;
    ap_fixed<W,I> one_minus_x = 1 - x;
    ap_fixed<W,I> input = one_plus_x / one_minus_x ;
    ap_fixed<W,I> result = log_apfixed_reduce::log(input);
    result >>= 1;
    return result;
  }

  // atanh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> atanh(ap_ufixed<W,I> x){
  ap_fixed<W+1,I+1> input = x;
    ap_fixed<W+1,I+1> result = hls::atanh(input);
    return result;
  }

  // atanh(ap_int)
  template<int I>
  ap_int<I> atanh(ap_int<I> x){
    ap_fixed<I,I> input = x;
    ap_fixed<I,I> result = hls::atanh(input);
    return result;
  }

  // atanh(ap_uint)
  template<int I>
  ap_uint<I> atanh(ap_uint<I> x){
    ap_fixed<I+1,I+1> input = x;
    ap_fixed<I+1,I+1> result = hls::atanh(input);
    return result;
  }

  // asinh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> asinh(ap_fixed<W,I> x){
    return cordic_apfixed::generic_asinh(x);
  }

  // asinh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> asinh(ap_ufixed<W,I> x){
    return cordic_apfixed::generic_asinh(x);
  }

  // asinh(ap_int)
  template<int I>
  ap_int<I> asinh(ap_int<I> x){
    return cordic_apfixed::generic_asinh(x);
  }

  // asinh(ap_uint)
  template<int I>
  ap_uint<I> asinh(ap_uint<I> x){
    return cordic_apfixed::generic_asinh(x);
  }

  // acosh(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> acosh(ap_fixed<W,I> x){
    return cordic_apfixed::generic_acosh(x);
  }

  // acosh(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> acosh(ap_ufixed<W,I> x){
    return cordic_apfixed::generic_acosh(x);
  }

  // acosh(ap_int)
  template<int I>
  ap_int<I> acosh(ap_int<I> x){
    return cordic_apfixed::generic_acosh(x);
  }

  // acosh(ap_uint)
  template<int I>
  ap_uint<I> acosh(ap_uint<I> x){
    return cordic_apfixed::generic_acosh(x);
  }

  int8_t   sinh(int8_t);
  uint8_t  sinh(uint8_t);
  int16_t  sinh(int16_t);
  uint16_t sinh(uint16_t);
  int32_t  sinh(int32_t);
  uint32_t sinh(uint32_t);

  int8_t   cosh(int8_t);
  uint8_t  cosh(uint8_t);
  int16_t  cosh(int16_t);
  uint16_t cosh(uint16_t);
  int32_t  cosh(int32_t);
  uint32_t cosh(uint32_t);

  int8_t   tanh(int8_t);
  uint8_t  tanh(uint8_t);
  int16_t  tanh(int16_t);
  uint16_t tanh(uint16_t);
  int32_t  tanh(int32_t);
  uint32_t tanh(uint32_t);

  int8_t   atanh(int8_t);
  uint8_t  atanh(uint8_t);
  int16_t  atanh(int16_t);
  uint16_t atanh(uint16_t);
  int32_t  atanh(int32_t);
  uint32_t atanh(uint32_t);

  int8_t   asinh(int8_t);
  uint8_t  asinh(uint8_t);
  int16_t  asinh(int16_t);
  uint16_t asinh(uint16_t);
  int32_t  asinh(int32_t);
  uint32_t asinh(uint32_t);
  
  int8_t   acosh(int8_t);
  uint8_t  acosh(uint8_t);
  int16_t  acosh(int16_t);
  uint16_t acosh(uint16_t);
  int32_t  acosh(int32_t);
  uint32_t acosh(uint32_t);

  // asin(ap_fixed)
  template<int W, int I>
  ap_fixed<W-I+3,3> asin(ap_fixed<W,I> x){
	return cordic_apfixed::generic_asin(x);
  } 

  // acos(ap_fixed)
  template<int W, int I>
  ap_fixed<W-I+3,3> acos(ap_fixed<W,I> x){
	return cordic_apfixed::generic_acos(x);
  } 

  // atan(ap_fixed)
  template<int W, int I>
  ap_fixed<W,2> atan(ap_fixed<W,I> x){
	return cordic_apfixed::generic_atan(x);
  } 

  // atan(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,2> atan(ap_ufixed<W,I> x){
	return cordic_apfixed::generic_atan(x);
  } 

  // atan(ap_int)
  template<int I>
  ap_int<2> atan(ap_int<I> x){
  	return cordic_apfixed::generic_atan(x);
  } 

  // atan(ap_uint)
  template<int I>
  ap_uint<1> atan(ap_uint<I> x){
  	return cordic_apfixed::generic_atan(x);
  } 

  int8_t   asin(int8_t);
  uint8_t  asin(uint8_t);
  int16_t  asin(int16_t);
  uint16_t asin(uint16_t);
  int32_t  asin(int32_t);
  uint32_t asin(uint32_t);

  int8_t   acos(int8_t);
  uint8_t  acos(uint8_t);
  int16_t  acos(int16_t);
  uint16_t acos(uint16_t);
  int32_t  acos(int32_t);
  uint32_t acos(uint32_t);

  int8_t   atan(int8_t);
  uint8_t  atan(uint8_t);
  int16_t  atan(int16_t);
  uint16_t atan(uint16_t);
  int32_t  atan(int32_t);
  uint32_t atan(uint32_t);

  // asinpi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> asinpi(ap_fixed<W,I> x){
      return cordic_apfixed::generic_asinpi(x);
  } 
  // asinpi(ap_fixed)
  template<int W, int I>
  ap_ufixed<W,I> asinpi(ap_ufixed<W,I> x){
      return cordic_apfixed::generic_asinpi(x);
  } 
  // asinpi(ap_fixed)
  template<int I>
  ap_int<I> asinpi(ap_int<I> x){
     return cordic_apfixed::generic_asinpi(x);
  } 
  // asinpi(ap_fixed)
  template<int I>
  ap_uint<I> asinpi(ap_uint<I> x){
     return cordic_apfixed::generic_asinpi(x);
  } 
  

  int8_t   asinpi(int8_t);
  uint8_t  asinpi(uint8_t);
  int16_t  asinpi(int16_t);
  uint16_t asinpi(uint16_t);
  int32_t  asinpi(int32_t);
  uint32_t asinpi(uint32_t);

  // acospi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> acospi(ap_fixed<W,I> x){
      return cordic_apfixed::generic_acospi(x);
  } 
  // acospi(ap_fixed)
  template<int W, int I>
  ap_ufixed<W,I> acospi(ap_ufixed<W,I> x){
      return cordic_apfixed::generic_acospi(x);
  } 
  // acospi(ap_fixed)
  template<int I>
  ap_int<I> acospi(ap_int<I> x){
     return cordic_apfixed::generic_acospi(x);
  } 
  // acospi(ap_fixed)
  template<int I>
  ap_uint<I> acospi(ap_uint<I> x){
     return cordic_apfixed::generic_acospi(x);
  } 

  int8_t   acospi(int8_t);
  uint8_t  acospi(uint8_t);
  int16_t  acospi(int16_t);
  uint16_t acospi(uint16_t);
  int32_t  acospi(int32_t);
  uint32_t acospi(uint32_t);

  // atanpi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> atanpi(ap_fixed<W,I> x){
	return cordic_apfixed::generic_atanpi(x);
  } 

  // atanpi(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> atanpi(ap_ufixed<W,I> x){
	return cordic_apfixed::generic_atanpi(x);
  } 

  // atanpi(ap_int)
  template<int I>
  ap_int<2> atanpi(ap_int<I> x){
  	return cordic_apfixed::generic_atanpi(x);
  } 

  // atanpi(ap_uint)
  template<int I>
  ap_uint<1> atanpi(ap_uint<I> x){
  	return cordic_apfixed::generic_atanpi(x);
  } 

  int8_t   atanpi(int8_t);
  uint8_t  atanpi(uint8_t);
  int16_t  atanpi(int16_t);
  uint16_t atanpi(uint16_t);
  int32_t  atanpi(int32_t);
  uint32_t atanpi(uint32_t);

  // atan2(ap_fixed)
  template<int W, int I>
  ap_fixed<W,3> atan2(ap_fixed<W,I> x, ap_fixed<W,I> y){
	return cordic_apfixed::generic_atan2(x,y);
  } 

  // atan2(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,3> atan2(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
	return cordic_apfixed::generic_atan2(x,y);
  } 

  // atan2(ap_int)
  template<int I>
  ap_int<3> atan2(ap_int<I> x, ap_int<I> y){
  	return cordic_apfixed::generic_atan2(x,y);
  } 

  // atan2(ap_uint)
  template<int I>
  ap_uint<2> atan2(ap_uint<I> x, ap_uint<I> y){
  	return cordic_apfixed::generic_atan2(x,y);
  } 

  int8_t   atan2(int8_t, int8_t);
  uint8_t  atan2(uint8_t, uint8_t);
  int16_t  atan2(int16_t, int16_t);
  uint16_t atan2(uint16_t, uint16_t);
  int32_t  atan2(int32_t, int32_t);
  uint32_t atan2(uint32_t, uint32_t);

  // atan2pi(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> atan2pi(ap_fixed<W,I> x, ap_fixed<W,I> y){
	return cordic_apfixed::generic_atan2pi(x,y);
  } 

  // atan2pi(ap_ufixed)
  template<int W, int I>
  ap_ufixed<W,I> atan2pi(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
	return cordic_apfixed::generic_atan2pi(x,y);
  } 

  // atanpi(ap_int)
  template<int I>
  ap_int<I> atan2pi(ap_int<I> x, ap_int<I> y){
  	return cordic_apfixed::generic_atan2pi(x,y);
  } 

  // atan2(ap_uint)
  template<int I>
  ap_uint<I> atan2pi(ap_uint<I> x, ap_uint<I> y){
  	return cordic_apfixed::generic_atan2pi(x,y);
  } 

  int8_t   atan2pi(int8_t, int8_t);
  uint8_t  atan2pi(uint8_t, uint8_t);
  int16_t  atan2pi(int16_t, int16_t);
  uint16_t atan2pi(uint16_t, uint16_t);
  int32_t  atan2pi(int32_t, int32_t);
  uint32_t atan2pi(uint32_t, uint32_t);
  template<int W, int I>
  void sincos(ap_fixed<W,I> in, 
  			  ap_fixed<W-I+2,2>* outsin, ap_fixed<W-I+2,2>* outcos){
  	cordic_apfixed::generic_sincos(in, *outsin, *outcos);
  }

  template<int W, int I>
  ap_fixed<W-I+2,2> sin(ap_fixed<W,I> x){
        ap_fixed<W-I+2,2> outsin;
        ap_fixed<W-I+2,2> outcos;
        cordic_apfixed::generic_sincos(x, outsin, outcos);
        return outsin;
  }

  template<int W, int I>
  ap_ufixed<W-I+2,2> sin(ap_ufixed<W,I> x){
		ap_fixed<W+1, I+1> xin = x;
		ap_fixed<W-I+3, 3> xout = hls::sin(x);
		ap_fixed<W-I+2, 2> out = 0;
		if(xout[W-I+2]==0){
			out=xout;
		}
		return out;
  }

  template<int W, int I>
  ap_fixed<W-I+2,2> cos(ap_fixed<W,I> x){
        ap_fixed<W-I+2,2> outsin;
        ap_fixed<W-I+2,2> outcos;
        cordic_apfixed::generic_sincos(x, outsin, outcos);
        return outcos;
  }

  template<int W, int I>
  ap_ufixed<W-I+2,2> cos(ap_ufixed<W,I> x){
		ap_fixed<W+1, I+1> xin = x;
		ap_fixed<W-I+3, 3> xout = hls::cos(x);
		ap_fixed<W-I+2, 2> out = 0;
		if(xout[W-I+2]==0){
			out=xout;
		}
		return out;
  }

/*  template<int W, int I>
  ap_fixed<W-I+2,2> sinf(ap_fixed<W,I> x){
        ap_fixed<W-I+2,2> outsin;
        ap_fixed<W-I+2,2> outcos;
        cordic_apfixed::generic_sincos(x, outsin, outcos);
        return outsin;
  }

  template<int W, int I>
  ap_fixed<W-I+2,2> cosf(ap_fixed<W,I> x){
	ap_fixed<W-I+2,2> outsin;
	ap_fixed<W-I+2,2> outcos;
        cordic_apfixed::generic_sincos(x, outsin, outcos);
        return outcos;
  }
*/
  // sin cos(ap_int)
  template<int I>
  ap_int<I> sin(ap_int<I> in) {
        _AP_UNUSED_PARAM(in);
	return ap_int<I>(0);
  };  
  template<int I>
  ap_int<I> cos(ap_int<I> in) {
        _AP_UNUSED_PARAM(in);
	return ap_int<I>(0);
  };  

  // sin cos(ap_uint)
  template<int I>
  ap_uint<I> sin(ap_uint<I> in) {
        _AP_UNUSED_PARAM(in);
	return ap_uint<I>(0);
  };  
  template<int I>
  ap_uint<I> cos(ap_uint<I> in) {
        _AP_UNUSED_PARAM(in);
	return ap_uint<I>(0);
  };  

  void sincos(int8_t, int8_t*, int8_t*);
  void sincos(uint8_t, uint8_t*, uint8_t*);
  void sincos(int16_t, int16_t*, int16_t*);
  void sincos(uint16_t, uint16_t*, uint16_t*);
  void sincos(int32_t, int32_t*, int32_t*);
  void sincos(uint32_t, uint32_t*, uint32_t*);

  int8_t   sin(int8_t);
  uint8_t  sin(uint8_t);
  int16_t  sin(int16_t);
  uint16_t sin(uint16_t);
  int32_t  sin(int32_t);
  uint32_t sin(uint32_t);

  int8_t   cos(int8_t);
  uint8_t  cos(uint8_t);
  int16_t  cos(int16_t);
  uint16_t cos(uint16_t);
  int32_t  cos(int32_t);
  uint32_t cos(uint32_t);

  // tan
  template<int W, int I>
  ap_fixed<W,I> tan(ap_fixed<W,I> x){
	return cordic_apfixed::generic_tan(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> tan(ap_ufixed<W,I> x){
	return cordic_apfixed::generic_tan(x);
  }
  template<int I>
  ap_int<I> tan(ap_int<I> x){
  	return cordic_apfixed::generic_tan(x);
  } 
  template<int I>
  ap_uint<I> tan(ap_uint<I> x){
  	return cordic_apfixed::generic_tan(x);
  } 

  int8_t   tan(int8_t);
  uint8_t  tan(uint8_t);
  int16_t  tan(int16_t);
  uint16_t tan(uint16_t);
  int32_t  tan(int32_t);
  uint32_t tan(uint32_t);
  
  // tanpi
  template<int W, int I>
  ap_fixed<W,I> tanpi(ap_fixed<W,I> x){
	return cordic_apfixed::generic_tanpi(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> tanpi(ap_ufixed<W,I> x){
	return cordic_apfixed::generic_tanpi(x);
  }
  template<int I>
  ap_int<I> tanpi(ap_int<I> x){
  	return cordic_apfixed::generic_tanpi(x);
  } 
  template<int I>
  ap_uint<I> tanpi(ap_uint<I> x){
  	return cordic_apfixed::generic_tanpi(x);
  } 

  int8_t   tanpi(int8_t);
  uint8_t  tanpi(uint8_t);
  int16_t  tanpi(int16_t);
  uint16_t tanpi(uint16_t);
  int32_t  tanpi(int32_t);
  uint32_t tanpi(uint32_t);
  
  //pow(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> pow(ap_fixed<W,I> x, ap_fixed<W,I> y) {
    return pow_apfixed_reduce::pow(x,y);
  }

  template<int W, int I>
  ap_ufixed<W,I> pow(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return pow_apfixed_reduce::pow(x,y);
  }
  template<int I>
  ap_int<I> pow(ap_int<I> x, ap_int<I> y){
    return pow_apfixed_reduce::pow(x,y);
  }
  template<int I>
  ap_uint<I> pow(ap_uint<I> x,ap_uint<I> y){
    return pow_apfixed_reduce::pow(x,y);
  }
  //pown(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> pown(ap_fixed<W,I> x, int n) {
    return pow_apfixed_reduce::pown(x,n);
  }

  template<int W, int I>
  ap_ufixed<W,I> pown(ap_ufixed<W,I> x, int n){
    return pow_apfixed_reduce::pown(x,n);
  }
  template<int I>
  ap_int<I> pown(ap_int<I> x, int n){
    return pow_apfixed_reduce::pown(x,n);
  }
  template<int I>
  ap_uint<I> pown(ap_uint<I> x, int n){
    return pow_apfixed_reduce::pown(x,n);
  }
  int8_t   pown(int8_t, int n);
  uint8_t  pown(uint8_t, int n);
  int16_t  pown(int16_t, int n);
  uint16_t pown(uint16_t, int n);
  int32_t  pown(int32_t, int n);
  uint32_t pown(uint32_t, int n);
  //rootn(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> rootn(ap_fixed<W,I> x, int n) {
    return pow_apfixed_reduce::rootn(x,n);
  }

  template<int W, int I>
  ap_ufixed<W,I> rootn(ap_ufixed<W,I> x, int n){
    return pow_apfixed_reduce::rootn(x,n);
  }
  template<int I>
  ap_int<I> rootn(ap_int<I> x, int n){
    return pow_apfixed_reduce::rootn(x,n);
  }
  template<int I>
  ap_uint<I> rootn(ap_uint<I> x, int n){
    return pow_apfixed_reduce::rootn(x,n);
  }
  int8_t   rootn(int8_t, int n);
  uint8_t  rootn(uint8_t, int n);
  int16_t  rootn(int16_t, int n);
  uint16_t rootn(uint16_t, int n);
  int32_t  rootn(int32_t, int n);
  uint32_t rootn(uint32_t, int n); 
  //powr(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> powr(ap_fixed<W,I> x, ap_fixed<W,I> y) {
    return pow_apfixed_reduce::powr(x,y);
  }

  template<int W, int I>
  ap_ufixed<W,I> powr(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return pow_apfixed_reduce::powr(x,y);
  }
  template<int I>
  ap_int<I> powr(ap_int<I> x, ap_int<I> y){
    return pow_apfixed_reduce::powr(x,y);
  }
  template<int I>
  ap_uint<I> powr(ap_uint<I> x,ap_uint<I> y){
    return pow_apfixed_reduce::powr(x,y);
  }


  // round(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> round(ap_fixed<W,I> x){
    return round_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> round(ap_ufixed<W,I> x){
    return round_fixed(x);
  }
  template<int I>
  ap_int<I> round(ap_int<I> x){
    return round_fixed(x);
  }
  template<int I>
  ap_uint<I> round(ap_uint<I> x){
    return round_fixed(x);
  }
  int8_t   round(int8_t);
  uint8_t  round(uint8_t);
  int16_t  round(int16_t);
  uint16_t round(uint16_t);
  int32_t  round(int32_t);
  uint32_t round(uint32_t);

  // rint(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> rint(ap_fixed<W,I> x){
    return rint_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> rint(ap_ufixed<W,I> x){
    return rint_fixed(x);
  }
  template<int I>
  ap_int<I> rint(ap_int<I> x){
    return rint_fixed(x);
  }
  template<int I>
  ap_uint<I> rint(ap_uint<I> x){
    return rint_fixed(x);
  }
  int8_t   rint(int8_t);
  uint8_t  rint(uint8_t);
  int16_t  rint(int16_t);
  uint16_t rint(uint16_t);
  int32_t  rint(int32_t);
  uint32_t rint(uint32_t);

  // nearbyint(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> nearbyint(ap_fixed<W,I> x){
    return nearbyint_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> nearbyint(ap_ufixed<W,I> x){
    return nearbyint_fixed(x);
  }
  template<int I>
  ap_int<I> nearbyint(ap_int<I> x){
    return nearbyint_fixed(x);
  }
  template<int I>
  ap_uint<I> nearbyint(ap_uint<I> x){
    return nearbyint_fixed(x);
  }
  int8_t   nearbyint(int8_t);
  uint8_t  nearbyint(uint8_t);
  int16_t  nearbyint(int16_t);
  uint16_t nearbyint(uint16_t);
  int32_t  nearbyint(int32_t);
  uint32_t nearbyint(uint32_t);

  //llround(ap_fixed)
  template<int W, int I>
  long long int llround(ap_fixed<W,I> x){
    return llround_fixed(x);
  }
  template<int W, int I>
  long long int llround(ap_ufixed<W,I> x){
    return llround_fixed(x);
  }
  template<int I>
  long long int llround(ap_int<I> x){
    return llround_fixed(x);
  }
  template<int I>
  long long int llround(ap_uint<I> x){
    return llround_fixed(x);
  }

  //llround(int)
  long long int  llround(int8_t);
  long long int  llround(uint8_t);
  long long int  llround(int16_t);
  long long int  llround(uint16_t);
  long long int  llround(int32_t);
  long long int  llround(uint32_t);

  // lround(ap_fixed)
  template<int W, int I>
  long int lround(ap_fixed<W,I> x){
    return lround_fixed(x);
  }
  template<int W, int I>
  long int lround(ap_ufixed<W,I> x){
    return lround_fixed(x);
  }
  template<int I>
  long int lround(ap_int<I> x){
    return lround_fixed(x);
  }
  template<int I>
  long int lround(ap_uint<I> x){
    return lround_fixed(x);
  }

  //lround(int)
  long int  lround(int8_t);
  long int  lround(uint8_t);
  long int  lround(int16_t);
  long int  lround(uint16_t);
  long int  lround(int32_t);
  long int  lround(uint32_t);

  // llrint(ap_fixed)
  template<int W, int I>
  long long int llrint(ap_fixed<W,I> x){
    return llrint_fixed(x);
  }
  template<int W, int I>
  long long int llrint(ap_ufixed<W,I> x){
    return llrint_fixed(x);
  }
  template<int I>
  long long int llrint(ap_int<I> x){
    return llrint_fixed(x);
  }
  template<int I>
  long long int llrint(ap_uint<I> x){
    return llrint_fixed(x);
  }

  //llrint(int)
  long long int  llrint(int8_t);
  long long int  llrint(uint8_t);
  long long int  llrint(int16_t);
  long long int  llrint(uint16_t);
  long long int  llrint(int32_t);
  long long int  llrint(uint32_t);

  // lrint(ap_fixed)
  template<int W, int I>
  long int lrint(ap_fixed<W,I> x){
    return lrint_fixed(x);
  }
  template<int W, int I>
  long int lrint(ap_ufixed<W,I> x){
    return lrint_fixed(x);
  }
  template<int I>
  long int lrint(ap_int<I> x){
    return lrint_fixed(x);
  }
  template<int I>
  long int lrint(ap_uint<I> x){
    return lrint_fixed(x);
  }

  //lrint(int)
  long int  lrint(int8_t);
  long int  lrint(uint8_t);
  long int  lrint(int16_t);
  long int  lrint(uint16_t);
  long int  lrint(int32_t);
  long int  lrint(uint32_t);

  //isgreater(ap_fixed)
  template<int W, int I>
  bool  isgreater(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    return isgreater_fixed(x1, x2);
  }
  template<int W, int I>
  bool  isgreater(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    return isgreater_fixed(x1, x2);
  }
  template<int I>
  bool  isgreater(ap_int<I> x1, ap_int<I> x2){
    return isgreater_fixed(x1, x2);
  }
  template<int I>
  bool  isgreater(ap_uint<I> x1, ap_uint<I> x2){
    return isgreater_fixed(x1, x2);
  }
  bool  isgreater(int8_t, int8_t);
  bool  isgreater(uint8_t, uint8_t);
  bool  isgreater(int16_t, int16_t);
  bool  isgreater(uint16_t, uint16_t);
  bool  isgreater(int32_t, int32_t);
  bool  isgreater(uint32_t, uint32_t);

  //isgreaterequal(ap_fixed)
  template<int W, int I>
  bool  isgreaterequal(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    return isgreaterequal_fixed(x1, x2);
  }
  template<int W, int I>
  bool  isgreaterequal(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    return isgreaterequal_fixed(x1, x2);
  }
  template<int I>
  bool  isgreaterequal(ap_int<I> x1, ap_int<I> x2){
    return isgreaterequal_int(x1, x2);
  }
  template<int I>
  bool  isgreaterequal(ap_uint<I> x1, ap_uint<I> x2){
    return isgreaterequal_fixed(x1, x2);
  }
  bool  isgreaterequal(int8_t, int8_t);
  bool  isgreaterequal(uint8_t, uint8_t);
  bool  isgreaterequal(int16_t, int16_t);
  bool  isgreaterequal(uint16_t, uint16_t);
  bool  isgreaterequal(int32_t, int32_t);
  bool  isgreaterequal(uint32_t, uint32_t);
  
  //isless(ap_fixed)
  template<int W, int I>
  bool  isless(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    return isless_fixed(x1, x2);
  }
  template<int W, int I>
  bool  isless(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    return isless_fixed(x1, x2);
  }
  template<int I>
  bool  isless(ap_int<I> x1, ap_int<I> x2){
    return isless_fixed(x1, x2);
  }
  template<int I>
  bool  isless(ap_uint<I> x1, ap_uint<I> x2){
    return isless_fixed(x1, x2);
  }
  bool  isless(int8_t, int8_t);
  bool  isless(uint8_t, uint8_t);
  bool  isless(int16_t, int16_t);
  bool  isless(uint16_t, uint16_t);
  bool  isless(int32_t, int32_t);
  bool  isless(uint32_t, uint32_t);
  
  //islessequal(ap_fixed)
  template<int W, int I>
  bool  islessequal(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    return islessequal_fixed(x1, x2);
  }
  template<int W, int I>
  bool  islessequal(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    return islessequal_fixed(x1, x2);
  }
  template<int I>
  bool  islessequal(ap_int<I> x1, ap_int<I> x2){
    return islessequal_fixed(x1, x2);
  }
  template<int I>
  bool  islessequal(ap_uint<I> x1, ap_uint<I> x2){
    return islessequal_fixed(x1, x2);
  }
  bool  islessequal(int8_t, int8_t);
  bool  islessequal(uint8_t, uint8_t);
  bool  islessequal(int16_t, int16_t);
  bool  islessequal(uint16_t, uint16_t);
  bool  islessequal(int32_t, int32_t);
  bool  islessequal(uint32_t, uint32_t);

  //islessgreater(ap_fixed)
  template<int W, int I>
  bool  islessgreater(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    return islessgreater_fixed(x1, x2);
  }
  template<int W, int I>
  bool  islessgreater(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    return islessgreater_fixed(x1, x2);
  }
  template<int I>
  bool  islessgreater(ap_int<I> x1, ap_int<I> x2){
    return islessgreater_fixed(x1, x2);
  }
  template<int I>
  bool  islessgreater(ap_uint<I> x1, ap_uint<I> x2){
    return islessgreater_fixed(x1, x2);
  }

  bool  islessgreater(int8_t, int8_t);
  bool  islessgreater(uint8_t, uint8_t);
  bool  islessgreater(int16_t, int16_t);
  bool  islessgreater(uint16_t, uint16_t);
  bool  islessgreater(int32_t, int32_t);
  bool  islessgreater(uint32_t, uint32_t);

  int8_t frexp(int8_t,int8_t*);
  uint8_t frexp(uint8_t, uint8_t*);
  int16_t frexp(int16_t, int16_t*);
  uint16_t frexp(uint16_t, uint16_t*);
  int32_t frexp(int32_t, int32_t*);
  uint32_t frexp(uint32_t, uint32_t*);
  //frexp(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> frexp(ap_fixed<W,I> x, ap_fixed<W,I>* exp) {
    return frexp_internal::frexp(x,exp);
  }

  template<int W, int I>
  ap_ufixed<W,I> frexp(ap_ufixed<W,I> x, ap_ufixed<W,I>* exp){
    return frexp_internal::frexp(x,exp);
  }
  template<int I>
  ap_int<I> frexp(ap_int<I> x, ap_int<I>* exp){
    return frexp_internal::frexp(x,exp);
  }
  template<int I>
  ap_uint<I> frexp(ap_uint<I> x,ap_uint<I>* exp){
    return frexp_internal::frexp(x,exp);
  }

  int8_t modf(int8_t, int8_t*);
  uint8_t modf(uint8_t, uint8_t*);
  int16_t modf(int16_t, int16_t*);
  uint16_t modf(uint16_t, uint16_t*);
  int32_t modf(int32_t, int32_t*);
  uint32_t modf(uint32_t, uint32_t*);
  //modf(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> modf(ap_fixed<W,I> x, ap_fixed<W,I>* intpart) {
    return modf_internal::modf(x,intpart);
  }

  template<int W, int I>
  ap_ufixed<W,I> modf(ap_ufixed<W,I> x, ap_ufixed<W,I>* intpart){
    return modf_internal::modf(x,intpart);
  }
  template<int I>
  ap_int<I> modf(ap_int<I> x, ap_int<I>* intpart){
    return modf_internal::modf(x,intpart);
  }
  template<int I>
  ap_uint<I> modf(ap_uint<I> x,ap_uint<I>* intpart){
    return modf_internal::modf(x,intpart);
  }

  // isequal(int)
  bool isequal(int8_t,int8_t);
  bool isequal(uint8_t,uint8_t);
  bool isequal(int16_t,int16_t);
  bool isequal(uint16_t,uint16_t);
  bool isequal(int32_t,int32_t);
  bool isequal(uint32_t,uint32_t);
  ////////////////////////////////////
  bool isnotequal(int8_t,int8_t);
  bool isnotequal(uint8_t,uint8_t);
  bool isnotequal(int16_t,int16_t);
  bool isnotequal(uint16_t,uint16_t);
  bool isnotequal(int32_t,int32_t);
  bool isnotequal(uint32_t,uint32_t);
  // isequal(ap_fixed)
  template<int W,int I>
  bool isequal(ap_fixed<W,I> x,ap_fixed<W,I> y){
    return generic_isequal(x,y);
  };
  template<int W,int I>
  bool isequal(ap_ufixed<W,I> x,ap_ufixed<W,I> y){
    return generic_isequal(x,y);
  };
  template<int I>
  bool isequal(ap_int<I> x,ap_int<I> y){
    return generic_isequal(x,y);
  };
  template<int I>
  bool isequal(ap_uint<I> x,ap_uint<I> y){
    return generic_isequal(x,y);
  };
  // isnotequal(ap_fixed)
  template<int W,int I>
  bool isnotequal(ap_fixed<W,I> x,ap_fixed<W,I> y){
    return generic_isnotequal(x,y);
  };
  template<int W,int I>
  bool isnotequal(ap_ufixed<W,I> x,ap_ufixed<W,I> y){
    return generic_isnotequal(x,y);
  };
  template<int I>
  bool isnotequal(ap_int<I> x,ap_int<I> y){
    return generic_isnotequal(x,y);
  };
  template<int I>
  bool isnotequal(ap_uint<I> x,ap_uint<I> y){
    return generic_isnotequal(x,y);
  };
  // any(ap_fixed)
  template<int W,int I>
  bool any(ap_fixed<W,I> x){
    return generic_any(x);
  };
  template<int W,int I>
  bool any(ap_ufixed<W,I> x){
    return generic_any(x);
  };
  template<int I>
  bool any(ap_int<I> x){
    return generic_any(x);
  };
  template<int I>
  bool any(ap_uint<I> x){
    return generic_any(x);
  };
  // all(ap_fixed)
  template<int W,int I>
  bool all(ap_fixed<W,I> x){
    return generic_all(x);
  };
  template<int W,int I>
  bool all(ap_ufixed<W,I> x){
    return generic_all(x);
  };
  template<int I>
  bool all(ap_int<I> x){
    return generic_all(x);
  };
  template<int I>
  bool all(ap_uint<I> x){
    return generic_all(x);
  };
  //bitselect(ap_fixed)
  template<int W,int I>
  ap_fixed<W,I> bitselect(ap_fixed<W,I> x,ap_fixed<W,I> y, ap_fixed<W,I> z){
    return generic_bitselect(x,y,z);
  };
  template<int W,int I>
  ap_ufixed<W,I> bitselect(ap_ufixed<W,I> x,ap_ufixed<W,I> y,ap_ufixed<W,I> z){
    return generic_bitselect(x,y,z);
  };
  template<int I>
  ap_int<I> bitselect(ap_int<I> x,ap_int<I> y,ap_int<I> z){
    return generic_bitselect(x,y,z);
  };
  template<int I>
  ap_uint<I> bitselect(ap_uint<I> x,ap_uint<I> y,ap_uint<I> z){
    return generic_bitselect(x,y,z);
  };
  //erf(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> erf(ap_fixed<W,I> x){
    return erf_erfc_fixed::erf(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> erf(ap_ufixed<W,I> x){
    return erf_erfc_fixed::erf(x);
  }
  template<int I>
  ap_int<I> erf(ap_int<I> x){
    return erf_erfc_fixed::erf(x);
  }
  template<int I>
  ap_uint<I> erf(ap_uint<I> x){
    return erf_erfc_fixed::erf(x);
  }
  //erfc(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> erfc(ap_fixed<W,I> x){
    return erf_erfc_fixed::erfc(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> erfc(ap_ufixed<W,I> x){
    return erf_erfc_fixed::erfc(x);
  }
  template<int I>
  ap_int<I> erfc(ap_int<I> x){
    return erf_erfc_fixed::erfc(x);
  }
  template<int I>
  ap_uint<I> erfc(ap_uint<I> x){
    return erf_erfc_fixed::erfc(x);
  }
   // divide (int)
  int8_t divide(int8_t,int8_t);
  int16_t divide(int16_t,int16_t);
  int32_t divide(int32_t,int32_t);
  uint8_t divide(uint8_t,uint8_t);
  uint16_t divide(uint16_t,uint16_t);
  uint32_t divide(uint32_t,uint32_t);
   //divide(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> divide(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return hls_internal::generic_divide(x, y);
  }
  template<int W, int I>
  ap_ufixed<W,I> divide(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return hls_internal::generic_divide(x, y);
  }
  template<int I>
  ap_int<I> divide(ap_int<I> x, ap_int<I> y){
    return hls_internal::generic_divide(x, y);
  }
  template<int I>
  ap_uint<I> divide(ap_uint<I> x, ap_uint<I> y){
    return hls_internal::generic_divide(x, y);
  }
  //fmod(int)
  int8_t fmod(int8_t,int8_t);
  int16_t fmod(int16_t,int16_t);
  int32_t fmod(int32_t,int32_t);
  uint8_t fmod(uint8_t,uint8_t);
  uint16_t fmod(uint16_t,uint16_t);
  uint32_t fmod(uint32_t,uint32_t);
   //fmod(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> fmod(ap_fixed<W,I> x, ap_fixed<W,I> y){
    return hls_internal::generic_fmod(x, y);
  }
  template<int W, int I>
  ap_ufixed<W,I> fmod(ap_ufixed<W,I> x, ap_ufixed<W,I> y){
    return hls_internal::generic_fmod(x, y);
  }
  template<int I>
  ap_int<I> fmod(ap_int<I> x, ap_int<I> y){
    return hls_internal::generic_fmod(x, y);
  }
  template<int I>
  ap_uint<I> fmod(ap_uint<I> x, ap_uint<I> y){
    return hls_internal::generic_fmod(x, y);
  }
  //remainder (int)
  int8_t remainder(int8_t,int8_t);
  int16_t remainder(int16_t,int16_t);
  int32_t remainder(int32_t,int32_t);
  uint8_t remainder(uint8_t,uint8_t);
  uint16_t remainder(uint16_t,uint16_t);
  uint32_t remainder(uint32_t,uint32_t);
  //remainder(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> remainder(ap_fixed<W,I> x, ap_fixed<W, I> y){
    return hls_internal::generic_remainder(x, y);
  }
  template<int W, int I>
  ap_ufixed<W,I> remainder(ap_ufixed<W,I> x, ap_ufixed<W, I> y){
    return hls_internal::generic_remainder(x, y);
  }
  template<int I>
  ap_int<I> remainder(ap_int<I> x, ap_int<I> y){
    return hls_internal::generic_remainder(x, y);
  }
  template<int I>
  ap_uint<I> remainder(ap_uint<I> x, ap_uint<I> y){
    return hls_internal::generic_remainder(x, y);
  }   
  //remquo (int)
  int8_t remquo(int8_t,int8_t,int*);
  int16_t remquo(int16_t,int16_t,int*);
  int32_t remquo(int32_t,int32_t,int*);
  uint8_t remquo(uint8_t,uint8_t,int*);
  uint16_t remquo(uint16_t,uint16_t,int*);
  uint32_t remquo(uint32_t,uint32_t,int*);
  //remquo(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> remquo(ap_fixed<W,I> x, ap_fixed<W,I> y, int* quo){
    return hls_internal::generic_remquo(x, y, quo);
  }
  template<int W, int I>
  ap_ufixed<W,I> remquo(ap_ufixed<W,I> x, ap_ufixed<W, I> y, int* quo){
    return hls_internal::generic_remquo(x, y, quo);
  }
  template<int I>
  ap_int<I> remquo(ap_int<I> x, ap_int<I> y, int* quo){
    return hls_internal::generic_remquo(x, y, quo);
  }
  template<int I>
  ap_uint<I> remquo(ap_uint<I> x, ap_uint<I> y, int* quo){
    return hls_internal::generic_remquo(x, y, quo);
  }   
  //signbit(ap_fixed)
  template<int W, int I>
  bool signbit(ap_fixed<W, I> x) {
    return signbit_fixed(x);
  }
  template<int W, int I>
  bool signbit(ap_ufixed<W, I> x) {
    return signbit_fixed(x);
  }
  template<int I>
  bool signbit(ap_int<I> x) {
    return signbit_fixed(x);
  }
  template<int I>
  bool signbit(ap_uint<I> x) {
    return signbit_fixed(x);
  }
  bool signbit(int8_t);
  bool signbit(uint8_t);
  bool signbit(int16_t);
  bool signbit(uint16_t);
  bool signbit(int32_t);
  bool signbit(uint32_t);
  
  //lgamma_r(ap_fixed)
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
  //mad (int)
  int8_t mad(int8_t,int8_t,int8_t);
  int16_t mad(int16_t,int16_t,int16_t);
  int32_t mad(int32_t,int32_t,int32_t);
  uint8_t mad(uint8_t,uint8_t,uint8_t);
  uint16_t mad(uint16_t,uint16_t,uint16_t);
  uint32_t mad(uint32_t,uint32_t,uint32_t);
  //mad (ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> mad(ap_fixed<W,I> x,ap_fixed<W,I> y,ap_fixed<W,I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  template<int W, int I>
  ap_ufixed<W,I> mad(ap_ufixed<W,I> x,ap_ufixed<W,I> y,ap_ufixed<W,I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  template<int I>
  ap_int<I> mad(ap_int<I> x,ap_int<I> y,ap_int<I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  template<int I>
  ap_uint<I> mad(ap_uint<I> x,ap_uint<I> y,ap_uint<I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  //fma (int)
  int8_t fma(int8_t,int8_t,int8_t);
  int16_t fma(int16_t,int16_t,int16_t);
  int32_t fma(int32_t,int32_t,int32_t);
  uint8_t fma(uint8_t,uint8_t,uint8_t);
  uint16_t fma(uint16_t,uint16_t,uint16_t);
  uint32_t fma(uint32_t,uint32_t,uint32_t);
  //fma (ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> fma(ap_fixed<W,I> x,ap_fixed<W,I> y,ap_fixed<W,I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  template<int W, int I>
  ap_ufixed<W,I> fma(ap_ufixed<W,I> x,ap_ufixed<W,I> y,ap_ufixed<W,I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  template<int I>
  ap_int<I> fma(ap_int<I> x,ap_int<I> y,ap_int<I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  template<int I>
  ap_uint<I> fma(ap_uint<I> x,ap_uint<I> y,ap_uint<I> z){
    return hls_mad::generic_mad(x,y,z);
  }
  //fract (int)
  int8_t fract(int8_t);
  int16_t fract(int16_t);
  int32_t fract(int32_t);
  uint8_t fract(uint8_t);
  uint16_t fract(uint16_t);
  uint32_t fract(uint32_t);
  //fract(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> fract(ap_fixed<W,I> x){
    return hls_fract::generic_fract(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> fract(ap_ufixed<W,I> x){
    return hls_fract::generic_fract(x);
  }
  template<int I>
  ap_int<I> fract(ap_int<I> x){
    return hls_fract::generic_fract(x);
  }
  template<int I>
  ap_uint<I> fract(ap_uint<I> x){
    return hls_fract::generic_fract(x);
  } 
  //cbrt for fixed data type
  template<int W, int I>
  ap_fixed<W,I> cbrt(ap_fixed<W,I> x) {
    return cbrt_internal::cbrt_fixed(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> cbrt(ap_ufixed<W,I> x) {
    return cbrt_internal::cbrt_fixed(x);
  } 
  template<int I>
  ap_int<I> cbrt(ap_int<I> x) {
    return cbrt_internal::cbrt_fixed(x);
  }
  template<int I>
  ap_uint<I> cbrt(ap_uint<I> x) {
    return cbrt_internal::cbrt_fixed(x);
  }
  int8_t cbrt(int8_t);
  uint8_t cbrt(uint8_t);
  int16_t cbrt(int16_t);
  uint16_t cbrt(uint16_t);
  int32_t cbrt(int32_t);
  uint32_t cbrt(uint32_t); 
  
  //tgamma(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> tgamma(ap_fixed<W,I> x){
    return tgamma_fixed::tgamma_generic(x);
  }
  template<int W, int I>
  ap_ufixed<W,I> tgamma(ap_ufixed<W,I> x){
    return tgamma_fixed::tgamma_generic(x);
  }
  template<int I>
  ap_int<I> tgamma(ap_int<I> x){
    return tgamma_fixed::tgamma_generic(x);
  }
  template<int I>
  ap_uint<I> tgamma(ap_uint<I> x){
    return tgamma_fixed::tgamma_generic(x);
  }
  
  //nextafter(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> nextafter(ap_fixed<W, I> x, ap_fixed<W, I> y) {
    return fp_internal::nextafter(x, y);
  }
  template<int W, int I>
  ap_ufixed<W,I> nextafter(ap_ufixed<W, I> x, ap_ufixed<W, I> y) {
    return fp_internal::nextafter(x, y);
  }
  template<int I>
  ap_int<I> nextafter(ap_int<I> x, ap_int<I> y) {
    return fp_internal::nextafter(x, y);
  }
  template<int I>
  ap_uint<I> nextafter(ap_uint<I> x, ap_uint<I> y) {
    return fp_internal::nextafter(x, y);
  }
  int8_t nextafter(int8_t, int8_t);
  uint8_t nextafter(uint8_t, uint8_t);
  int16_t nextafter(int16_t, int16_t);
  uint16_t nextafter(uint16_t, uint16_t);
  int32_t nextafter(int32_t, int32_t);
  uint32_t nextafter(uint32_t, uint32_t);

  //nexttoward(ap_fixed)
  template<int W, int I>
  ap_fixed<W,I> nexttoward(ap_fixed<W, I> x, ap_fixed<W, I> y) {
    return fp_internal::nexttoward(x, y);
  }
  template<int W, int I>
  ap_ufixed<W,I> nexttoward(ap_ufixed<W, I> x, ap_ufixed<W, I> y) {
    return fp_internal::nexttoward(x, y);
  }
  template<int I>
  ap_int<I> nexttoward(ap_int<I> x, ap_int<I> y) {
    return fp_internal::nexttoward(x, y);
  }
  template<int I>
  ap_uint<I> nexttoward(ap_uint<I> x, ap_uint<I> y) {
    return fp_internal::nexttoward(x, y);
  }
  int8_t nexttoward(int8_t, int8_t);
  uint8_t nexttoward(uint8_t, uint8_t);
  int16_t nexttoward(int16_t, int16_t);
  uint16_t nexttoward(uint16_t, uint16_t);
  int32_t nexttoward(int32_t, int32_t);
  uint32_t nexttoward(uint32_t, uint32_t);

  //hypot for fixed data type
  template<int W, int I>
  ap_fixed<W,I> hypot(ap_fixed<W,I> x, ap_fixed<W,I> y) {
    return hypot_internal::hypot_fixed(x,y);
  }
  template<int W, int I>
  ap_ufixed<W,I> hypot(ap_ufixed<W,I> x, ap_ufixed<W,I> y) {
    return hypot_internal::hypot_fixed(x,y);
  }
  template<int I>
  ap_int<I> hypot(ap_int<I> x, ap_int<I> y) {
    return hypot_internal::hypot_fixed(x,y);
  }
  template<int I>
  ap_uint<I> hypot(ap_uint<I> x, ap_uint<I> y) {
    return hypot_internal::hypot_fixed(x,y);
  }
  int8_t hypot(int8_t, int8_t);
  uint8_t hypot(uint8_t, uint8_t);
  int16_t hypot(int16_t, int16_t);
  uint16_t hypot(uint16_t, uint16_t);
  int32_t hypot(int32_t, int32_t);
  uint32_t hypot(uint32_t, uint32_t);

  template<int W, int I>
  ap_fixed<W,I> exp2(ap_fixed<W,I> x) {
    return exp_reduce::exp2(x);
  }

  template<int W, int I>
  ap_ufixed<W,I> exp2(ap_ufixed<W,I> x) {
    return exp_reduce::exp2(x);
  }

  template<int I>
  ap_int<I> exp2(ap_int<I> x) {
    return exp_reduce::exp2(x);
  }
  
  template<int I>
  ap_uint<I> exp2(ap_uint<I> x) {
    return exp_reduce::exp2(x);
  }

  template<int W, int I>
  ap_fixed<W,I> exp10(ap_fixed<W,I> x) {
    return exp_reduce::exp10(x);
  }

  template<int W, int I>
  ap_ufixed<W,I> exp10(ap_ufixed<W,I> x) {
    return exp_reduce::exp10(x);
  }

  template<int I>
  ap_int<I> exp10(ap_int<I> x) {
    return exp_reduce::exp10(x);
  }
  
  template<int I>
  ap_uint<I> exp10(ap_uint<I> x) {
    return exp_reduce::exp10(x);
  }

  template<int W, int I>
  ap_fixed<W,I> expm1(ap_fixed<W,I> x) {
    return exp_reduce::expm1(x);
  }
  
  template<int W, int I>
  ap_ufixed<W,I> expm1(ap_ufixed<W,I> x) {
    return exp_reduce::expm1(x);
  }
  
  template<int I>
  ap_int<I> expm1(ap_int<I> x) {
    return exp_reduce::expm1(x);
  }
  
  template<int I>
  ap_uint<I> expm1(ap_uint<I> x) {
    return exp_reduce::expm1(x);
  }

  template<int W, int I>
  ap_fixed<W,I> log1p(ap_fixed<W,I> x) {
    return log_apfixed_reduce::log1p(x);
  }
  
  template<int W, int I>
  ap_ufixed<W,I> log1p(ap_ufixed<W,I> x) {
    return log_apfixed_reduce::log1p(x);
  }

  template<int I>
  ap_int<I> log1p(ap_int<I> x) {
    return log_apfixed_reduce::log1p(x);
  }
  
  template<int I>
  ap_uint<I> log1p(ap_uint<I> x) {
    return log_apfixed_reduce::log1p(x);
  }

  template<int W, int I>
  ap_fixed<W,I> ilogb(ap_fixed<W,I> x) {
    return log_apfixed_reduce::ilogb(x);
  }

  template<int W, int I>
  ap_ufixed<W,I> ilogb(ap_ufixed<W,I> x) {
    return log_apfixed_reduce::ilogb(x);
  }

  template<int I>
  ap_int<I> ilogb(ap_int<I> x) {
    return log_apfixed_reduce::ilogb(x);
  }

  template<int I>
  ap_uint<I> ilogb(ap_uint<I> x) {
    return log_apfixed_reduce::ilogb(x);
  }

  template<int W, int I>
  ap_fixed<W,I> ldexp(ap_fixed<W,I> x, int exp) {
    return hls_ldexp::ldexp(x, exp);
  }

  template<int W, int I>
  ap_ufixed<W,I> ldexp(ap_ufixed<W,I> x, int exp) {
    return hls_ldexp::ldexp(x, exp);
  }

  template<int I>
  ap_int<I> ldexp(ap_int<I> x, int exp) {
    return hls_ldexp::ldexp(x, exp);
  }

  template<int I>
  ap_uint<I> ldexp(ap_uint<I> x, int exp) {
    return hls_ldexp::ldexp(x, exp);
  }

  template<int W, int I>
  ap_fixed<W,I> scalbn(ap_fixed<W,I> x, int n) {
    return hls_ldexp::scalbn(x, n);
  }

  template<int W, int I>
  ap_ufixed<W,I> scalbn(ap_ufixed<W,I> x, int n) {
    return hls_ldexp::scalbn(x, n);
  }

  template<int I>
  ap_int<I> scalbn(ap_int<I> x, int n) {
    return hls_ldexp::scalbn(x, n);
  }

  template<int I>
  ap_uint<I> scalbn(ap_uint<I> x, int n) {
    return hls_ldexp::scalbn(x, n);
  }

  template<int W, int I>
  ap_fixed<W,I> scalbln(ap_fixed<W,I> x, long int n) {
    return hls_ldexp::scalbln(x, n);
  }

  template<int W, int I>
  ap_ufixed<W,I> scalbln(ap_ufixed<W,I> x, long int n) {
    return hls_ldexp::scalbln(x, n);
  }

  template<int I>
  ap_int<I> scalbln(ap_int<I> x, long int n) {
    return hls_ldexp::scalbln(x, n);
  }

  template<int I>
  ap_uint<I> scalbln(ap_uint<I> x, long int n) {
    return hls_ldexp::scalbln(x, n);
  }

    int8_t ldexp(int8_t x, int exp);
    int16_t ldexp(int16_t x, int exp);
    int32_t ldexp(int32_t x, int exp);
    uint8_t ldexp(uint8_t x, int exp);
    uint16_t ldexp(uint16_t x, int exp);
    uint32_t ldexp(uint32_t x, int exp);

    int8_t scalbn(int8_t x, int n);
    int16_t scalbn(int16_t x, int n);
    int32_t scalbn(int32_t x, int n);
    uint8_t scalbn(uint8_t x, int n);
    uint16_t scalbn(uint16_t x, int n);
    uint32_t scalbn(uint32_t x, int n);

    int8_t scalbln(int8_t x, int n);
    int16_t scalbln(int16_t x, int n);
    int32_t scalbln(int32_t x, int n);
    uint8_t scalbln(uint8_t x, int n);
    uint16_t scalbln(uint16_t x, int n);
    uint32_t scalbln(uint32_t x, int n);

    int8_t exp2(int8_t x);
    int16_t exp2(int16_t x);
    int32_t exp2(int32_t x);
    uint8_t exp2(uint8_t x);
    uint16_t exp2(uint16_t x);
    uint32_t exp2(uint32_t x);

    int8_t exp10(int8_t x);
    int16_t exp10(int16_t x);
    int32_t exp10(int32_t x);
    uint8_t exp10(uint8_t x);
    uint16_t exp10(uint16_t x);
    uint32_t exp10(uint32_t x);

    int8_t expm1(int8_t x);
    int16_t expm1(int16_t x);
    int32_t expm1(int32_t x);
    uint8_t expm1(uint8_t x);
    uint16_t expm1(uint16_t x);
    uint32_t expm1(uint32_t x);

    int8_t ilogb(int8_t x);
    int16_t ilogb(int16_t x);
    int32_t ilogb(int32_t x);
    uint8_t ilogb(uint8_t x);
    uint16_t ilogb(uint16_t x);
    uint32_t ilogb(uint32_t x);

    int8_t log1p(int8_t x);
    int16_t log1p(int16_t x);
    int32_t log1p(int32_t x);
    uint8_t log1p(uint8_t x);
    uint16_t log1p(uint16_t x);
    uint32_t log1p(uint32_t x);

    int8_t log2(int8_t);
    uint8_t log2(uint8_t);
    int16_t log2(int16_t);
    uint16_t log2(uint16_t);
    int32_t log2(int32_t);
    uint32_t log2(uint32_t);

    int8_t logb(int8_t);
    uint8_t logb(uint8_t);
    int16_t logb(int16_t);
    uint16_t logb(uint16_t);
    int32_t logb(int32_t);
    uint32_t logb(uint32_t);

};
#endif


