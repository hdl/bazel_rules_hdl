/* -*- c -*-*/
/*
#-  (c) Copyright 2011-2019 Xilinx, Inc. All rights reserved.
#-
#-  This file contains confidential and proprietary information
#-  of Xilinx, Inc. and is protected under U.S. and
#-  international copyright and other intellectual property
#-  laws.
#-
#-  DISCLAIMER
#-  This disclaimer is not a license and does not grant any
#-  rights to the materials distributed herewith. Except as
#-  otherwise provided in a valid license issued to you by
#-  Xilinx, and to the maximum extent permitted by applicable
#-  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
#-  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
#-  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
#-  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
#-  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#-  (2) Xilinx shall not be liable (whether in contract or tort,
#-  including negligence, or under any other theory of
#-  liability) for any loss or damage of any kind or nature
#-  related to, arising under or in connection with these
#-  materials, including for any direct, or any indirect,
#-  special, incidental, or consequential loss or damage
#-  (including loss of data, profits, goodwill, or any type of
#-  loss or damage suffered as a result of any action brought
#-  by a third party) even if such damage or loss was
#-  reasonably foreseeable or Xilinx had been advised of the
#-  possibility of the same.
#-
#-  CRITICAL APPLICATIONS
#-  Xilinx products are not designed or intended to be fail-
#-  safe, or for use in any application requiring fail-safe
#-  performance, such as life-support or safety devices or
#-  systems, Class III medical devices, nuclear facilities,
#-  applications related to the deployment of airbags, or any
#-  other applications that could lead to death, personal
#-  injury, or severe property or environmental damage
#-  (individually and collectively, "Critical
#-  Applications"). Customer assumes the sole risk and
#-  liability of any use of Xilinx products in Critical
#-  Applications, subject only to applicable laws and
#-  regulations governing limitations on product liability.
#-
#-  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
#-  PART OF THIS FILE AT ALL TIMES. 
#- ************************************************************************

 *
 *
 */


#ifndef __AESL_FPO_H__
#define __AESL_FPO_H__

#ifndef __SYNTHESIS__
#include <math.h>
#endif

#include <assert.h>

#if defined __arm__ && !(defined HLS_NO_XIL_FPO_LIB)
#warning "Xilinx Floating Point Operator IP core does not provide simulation models for ARM architecture.  Automatically defining HLS_NO_XIL_FPO_LIB in order to avoid this library dependency, although bit-accurate simulation of some functions is no longer possible.  You can make this warning go away by adding this define yourself before including any other files." 
#define HLS_NO_XIL_FPO_LIB
#endif

#ifdef __SYNTHESIS__
#define HLS_FPO_SQRTF(a)               __builtin_sqrtf(a) 
#define HLS_FPO_SQRT(a)                __builtin_sqrt(a)   
#define HLS_FPO_RECSQRTF(a)            (1.0f/__builtin_sqrtf(a))
#define HLS_FPO_RECSQRT(a)             (1.0/__builtin_sqrt(a))
#define HLS_FPO_ABSF(a)                __builtin_fabsf(a)
#define HLS_FPO_ABS(a)                 __builtin_fabs(a)
#define HLS_FPO_LOGF(a)                __builtin_logf(a)
#define HLS_FPO_LOG(a)                 __builtin_log(a)
#define HLS_FPO_EXPF(a)                __builtin_expf(a)
#define HLS_FPO_EXP(a)                 __builtin_exp(a)
#else// csim
#ifdef HLS_NO_XIL_FPO_LIB
#define HLS_FPO_SQRTF(a)               sqrtf(a) 
#define HLS_FPO_SQRT(a)                sqrt(a)   
#define HLS_FPO_RECSQRTF(a)            (1.0f/sqrtf(a))
#define HLS_FPO_RECSQRT(a)             (1.0/sqrt(a))
#define HLS_FPO_ABSF(a)                fabsf(a)
#define HLS_FPO_ABS(a)                 fabs(a)
#define HLS_FPO_LOGF(a)                logf(a)
#define HLS_FPO_LOG(a)                 log(a)
#define HLS_FPO_EXPF(a)                expf(a)
#define HLS_FPO_EXP(a)                 exp(a)
#else
#define HLS_FPO_SQRTF(a)               xil_fpo_sqrt_flt(a)
#define HLS_FPO_SQRT(a)                xil_fpo_sqrt_d(a) 
#define HLS_FPO_RECSQRTF(a)            xil_fpo_recsqrt_flt(a)      
#define HLS_FPO_RECSQRT(a)             xil_fpo_recsqrt_d(a)
#define HLS_FPO_ABSF(a)                xil_fpo_abs_flt(a)
#define HLS_FPO_ABS(a)                 xil_fpo_abs_d(a)
#define HLS_FPO_LOGF(a)                xil_fpo_log_flt(a)
#define HLS_FPO_LOG(a)                 xil_fpo_log_d(a)
#define HLS_FPO_EXPF(a)                xil_fpo_exp_flt(a)
#define HLS_FPO_EXP(a)                 xil_fpo_exp_d(a)
#endif //HLS_NO_XIL_FPO_LIB
#endif //__SYNTHESIS__

#if (defined __SYNTHESIS__ || defined HLS_NO_XIL_FPO_LIB)
#define HLS_FPO_ADDF(a,b)              ((a) + (b))
#define HLS_FPO_ADD(a,b)               ((a) + (b))
#define HLS_FPO_SUBF(a,b)              ((a) - (b))
#define HLS_FPO_SUB(a,b)               ((a) - (b))
#define HLS_FPO_MULF(a,b)              ((a) * (b))
#define HLS_FPO_MUL(a,b)               ((a) * (b))
#define HLS_FPO_DIVF(a,b)              ((a)/(b))
#define HLS_FPO_DIV(a,b)               ((a)/(b))
#define HLS_FPO_RECF(a)                (1.0f/(a))
#define HLS_FPO_RECIPF(a)              HLS_FPO_RECF(a)
#define HLS_FPO_REC(a)                 (1.0/(a))
#define HLS_FPO_RECIP(a)               HLS_FPO_REC(a)
#define HLS_FPO_RSQRTF(a)              HLS_FPO_RECSQRTF(a)
#define HLS_FPO_RSQRT(a)               HLS_FPO_RECSQRT(a)
//#define HLS_FPO_UNORDEREDF(a,b)
//#define HLS_FPO_UNORDERED(a,b)
#define HLS_FPO_EQUALF(a,b)            ((a) == (b))
#define HLS_FPO_EQUAL(a,b)             ((a) == (b))  
#define HLS_FPO_LESSF(a,b)             ((a) < (b))
#define HLS_FPO_LESS(a,b)              ((a) < (b))
#define HLS_FPO_LESSEQUALF(a,b)        ((a) <= (b)) 
#define HLS_FPO_LESSEQUAL(a,b)         ((a) <= (b))
#define HLS_FPO_GREATERF(a,b)          ((a) > (b))
#define HLS_FPO_GREATER(a,b)           ((a) > (b))  
#define HLS_FPO_GREATEREQUALF(a,b)     ((a) >= (b)) 
#define HLS_FPO_GREATEREQUAL(a,b)      ((a) >= (b))
#define HLS_FPO_NOTEQUALF(a,b)         ((a) != (b))
#define HLS_FPO_NOTEQUAL(a,b)          ((a) != (b))      
//#define HLS_FPO_CONDCODEF(a,b)
//#define HLS_FPO_CONDCODE(a,b)
#define HLS_FPO_FTOI(a)                ((int)(a))
#define HLS_FPO_DTOI(a)                ((int)(a))        
#define HLS_FPO_ITOF(a)                ((float)(a))      
#define HLS_FPO_ITOD(a)                ((double)(a))        
#define HLS_FPO_FTOF(a)                ((float)(a))      
#define HLS_FPO_DTOF(a)                ((float)(a))        
#define HLS_FPO_FTOD(a)                ((double)(a))        
#define HLS_FPO_DTOD(a)                ((double)(a))          
#else
#define HLS_FPO_ADDF(a,b)              xil_fpo_add_flt(a,b)        
#define HLS_FPO_ADD(a,b)               xil_fpo_add_d(a,b)
#define HLS_FPO_SUBF(a,b)              xil_fpo_sub_flt(a,b)
#define HLS_FPO_SUB(a,b)               xil_fpo_sub_d(a,b)
#define HLS_FPO_MULF(a,b)              xil_fpo_mul_flt(a,b)
#define HLS_FPO_MUL(a,b)               xil_fpo_mul_d(a,b)
#define HLS_FPO_DIVF(a,b)              xil_fpo_div_flt(a,b)
#define HLS_FPO_DIV(a,b)               xil_fpo_div_d(a,b)
#define HLS_FPO_RECF(a)                xil_fpo_rec_flt(a)
#define HLS_FPO_RECIPF(a)              HLS_FPO_RECF(a)
#define HLS_FPO_REC(a)                 xil_fpo_rec_d(a)
#define HLS_FPO_RECIP(a)               HLS_FPO_REC(a)
#define HLS_FPO_RSQRTF(a)              HLS_FPO_RECSQRTF(a)
#define HLS_FPO_RSQRT(a)               HLS_FPO_RECSQRT(a)
#define HLS_FPO_UNORDEREDF(a,b)        xil_fpo_unordered_flt(a,b)
#define HLS_FPO_UNORDERED(a,b)         xil_fpo_unordered_d(a,b)
#define HLS_FPO_EQUALF(a,b)            xil_fpo_equal_flt(a,b)
#define HLS_FPO_EQUAL(a,b)             xil_fpo_equal_d(a,b)
#define HLS_FPO_LESSF(a,b)             xil_fpo_less_flt(a,b)
#define HLS_FPO_LESS(a,b)              xil_fpo_less_d(a,b)
#define HLS_FPO_LESSEQUALF(a,b)        xil_fpo_lessequal_flt(a,b)
#define HLS_FPO_LESSEQUAL(a,b)         xil_fpo_lessequal_d(a,b)
#define HLS_FPO_GREATERF(a,b)          xil_fpo_greater_flt(a,b)
#define HLS_FPO_GREATER(a,b)           xil_fpo_greater_d(a,b)
#define HLS_FPO_GREATEREQUALF(a,b)     xil_fpo_greaterequal_flt(a,b)
#define HLS_FPO_GREATEREQUAL(a,b)      xil_fpo_greaterequal_d(a,b)
#define HLS_FPO_NOTEQUALF(a,b)         xil_fpo_notequal_flt(a,b)
#define HLS_FPO_NOTEQUAL(a,b)          xil_fpo_notequal_d(a,b)
#define HLS_FPO_CONDCODEF(a,b)         xil_fpo_condcode_flt(a,b)
#define HLS_FPO_CONDCODE(a,b)          xil_fpo_condcode_d(a,b)
#define HLS_FPO_FTOI(a)                xil_fpo_flttofix_int_flt(a)
#define HLS_FPO_DTOI(a)                xil_fpo_flttofix_int_d(a)        
#define HLS_FPO_ITOF(a)                xil_fpo_fixtoflt_flt_int(a)      
#define HLS_FPO_ITOD(a)                xil_fpo_fixtoflt_d_int(a)        
#define HLS_FPO_FTOF(a)                xil_fpo_flttoflt_flt_flt(a)      
#define HLS_FPO_DTOF(a)                xil_fpo_flttoflt_flt_d(a)        
#define HLS_FPO_FTOD(a)                xil_fpo_flttoflt_d_flt(a)        
#define HLS_FPO_DTOD(a)                xil_fpo_flttoflt_d_d(a)          


#include "floating_point_v7_0_bitacc_cmodel.h"  // Must include before GMP and MPFR
#include "gmp.h"
#include "mpfr.h"

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: add
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_add_flt(float a, float b)
{
  float res_flt = 0.0f;

  // xip_fpo_add_flt
  xip_fpo_add_flt(&res_flt, a, b);  // normal operation
  return res_flt;
}

inline double xil_fpo_add_d(double a, double b)
{
  double res_d = 0.0;

  // xip_fpo_add_d
  xip_fpo_add_d(&res_d, a, b);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: subtract
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_sub_flt(float a, float b)
{
  float res_flt = 0.0f;

  // xip_fpo_sub_flt
  xip_fpo_sub_flt(&res_flt, a, b);  // normal operation
  return res_flt;
}

inline double xil_fpo_sub_d(double a, double b)
{
  double res_d = 0.0;

  // xip_fpo_sub_d
  xip_fpo_sub_d(&res_d, a, b);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: multiply
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_mul_flt(float a, float b)
{
  float res_flt = 0.0f;
 
  // xip_fpo_mul_flt
  xip_fpo_mul_flt(&res_flt, a, b);  // normal operation
  return res_flt;
}

inline double xil_fpo_mul_d(double a, double b)
{
  double res_d = 0.0;

  // xip_fpo_mul_d
  xip_fpo_mul_d(&res_d, a, b);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: divide
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_div_flt(float a, float b)
{
  float res_flt = 0.0f;

  // xip_fpo_div_flt
  xip_fpo_div_flt(&res_flt, a, b);  // normal operation
  return res_flt;
}

inline double xil_fpo_div_d(double a, double b)
{
  double res_d = 0.0;

  // xip_fpo_div_d
  xip_fpo_div_d(&res_d, a, b);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: reciprocal
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_rec_flt(float a)
{
  float res_flt = 0.0f;

  // xip_fpo_rec_flt
  xip_fpo_rec_flt(&res_flt, a);  // normal operation
  return res_flt;
}

inline double xil_fpo_rec_d(double a)
{
  double res_d = 0.0;

  // xip_fpo_rec_d
  xip_fpo_rec_d(&res_d, a);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: square root
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_sqrt_flt(float a)
{
//  printf("Testing operation functions: square root\n");
  float res_flt = 0.0f;

  // xip_fpo_sqrt_flt
  xip_fpo_sqrt_flt(&res_flt, a);  // normal operation
//  printf("float = sqrtf(a), and got res_flt=%f\n", res_flt);
  return res_flt;
}

inline double xil_fpo_sqrt_d(double a)
{
  double res_d = 0.0;

  // xip_fpo_sqrt_d
  xip_fpo_sqrt_d(&res_d, a);  // normal operation
//  printf("double = sqrt(a), and got res_d=%f\n", res_d);
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: reciprocal square root
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_recsqrt_flt(float a)      
{
  float res_flt = 0.0f;

  // xip_fpo_recsqrt_flt
  xip_fpo_recsqrt_flt(&res_flt, a);  // normal operation
  return res_flt;
}

inline double xil_fpo_recsqrt_d(double a)
{
  double res_d = 0.0;

  // xip_fpo_recsqrt_d
  xip_fpo_recsqrt_d(&res_d, a);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: absolute value
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_abs_flt(float a)
{
  float res_flt = 0.0f;

  xip_fpo_abs_flt(&res_flt, a);
  return res_flt;
}

inline double xil_fpo_abs_d(double a)
{
  double res_d = 0.0;

  xip_fpo_abs_d(&res_d, a);
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: logarithm
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_log_flt(float a)
{
  float res_flt = 0.0f;

  // xip_fpo_log_flt
  xip_fpo_log_flt(&res_flt, a);  // normal operation
  return res_flt;
}

inline double xil_fpo_log_d(double a)
{
  double res_d = 0.0;

  // xip_fpo_log_d
  xip_fpo_log_d(&res_d, a);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: Exponential
  ////////////////////////////////////////////////////////////////////////

inline float xil_fpo_exp_flt(float a)
{
  float res_flt = 0.0f;

  // xip_fpo_exp_flt
  xip_fpo_exp_flt(&res_flt, a);  // normal operation
  return res_flt;
}

inline double xil_fpo_exp_d(double a)
{
  double res_d = 0.0;

  // xip_fpo_exp_d
  xip_fpo_exp_d(&res_d, a);  // normal operation
  return res_d;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare unordered
  ////////////////////////////////////////////////////////////////////////

inline int xil_fpo_unordered_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_unordered_flt
  xip_fpo_unordered_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_unordered_d(double a, double b)
{
  int res_int = 0;

  // xip_fpo_unordered_d
  xip_fpo_unordered_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare equal
  ////////////////////////////////////////////////////////////////////////


inline int xil_fpo_equal_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_equal_flt
  xip_fpo_equal_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_equal_d(double a, double b)
{
  int res_int = 0;

  // xip_fpo_equal_d
  xip_fpo_equal_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare less than
  ////////////////////////////////////////////////////////////////////////

inline int xil_fpo_less_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_less_flt
  xip_fpo_less_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_less_d(double a, double b)
{
  int res_int = 0;

  // xip_fpo_less_d
  xip_fpo_less_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare less than or equal
  ////////////////////////////////////////////////////////////////////////

inline int xil_fpo_lessequal_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_lessequal_flt
  xip_fpo_lessequal_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_lessequal_d(double a, double b)
{
  int res_int = 0;

  // xip_fpo_lessequal_d
  xip_fpo_lessequal_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare greater than
  ////////////////////////////////////////////////////////////////////////

inline int xil_fpo_greater_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_greater_flt
  xip_fpo_greater_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_greater_d(double a, double b)
{
  int res_int = 0;

  // xip_fpo_greater_d
  xip_fpo_greater_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare greater than or equal
  ////////////////////////////////////////////////////////////////////////

inline int xil_fpo_greaterequal_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_greaterequal_flt
  xip_fpo_greaterequal_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_greaterequal_d(double a, double b)
{
  int res_int = 0;

  // xip_fpo_greaterequal_d
  xip_fpo_greaterequal_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare not equal
  ////////////////////////////////////////////////////////////////////////

inline int xil_fpo_notequal_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_notequal_flt
  xip_fpo_notequal_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_notequal_d(double a, double b)
{
  int res_int = 0;

  xip_fpo_notequal_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Operation functions: compare condition code
  ////////////////////////////////////////////////////////////////////////

inline int xil_fpo_condcode_flt(float a, float b)
{
  int res_int = 0;

  // xip_fpo_condcode_flt
  xip_fpo_condcode_flt(&res_int, a, b);  // normal operation
  return res_int;
}

inline int xil_fpo_condcode_d(double a, double b)
{
  int res_int = 0;

  // xip_fpo_condcode_d
  xip_fpo_condcode_d(&res_int, a, b);  // normal operation
  return res_int;
}

  ////////////////////////////////////////////////////////////////////////
  // Conversion functions: conversion code
  ////////////////////////////////////////////////////////////////////////
inline int xil_fpo_flttofix_int_flt(float a)
{
  int res_int = 0;

  // xip_fpo_flttofix_int_flt
  xip_fpo_flttofix_int_flt(&res_int, a);  // normal operation
  return res_int;
}

inline int xil_fpo_flttofix_int_d(double a)        
{
  int res_int = 0;

  // xip_fpo_flttofix_int_d
  xip_fpo_flttofix_int_d(&res_int, a);  // normal operation
  return res_int;
}

inline float xil_fpo_fixtoflt_flt_int(int a)      
{
  float res_flt = 0.0f;
  
  // xip_fpo_fixtoflt_flt_int
  xip_fpo_fixtoflt_flt_int(&res_flt, a);  // normal operation
  return res_flt;
}

inline double xil_fpo_fixtoflt_d_int(int a)        
{
  double res_d = 0.0;

  // xip_fpo_fixtoflt_d_int
  xip_fpo_fixtoflt_d_int(&res_d, a);  // normal operation
  return res_d;
}

inline float xil_fpo_flttoflt_flt_flt(float a)      
{
  float res_flt = 0.0f;

  // xip_fpo_flttoflt_flt_flt
  xip_fpo_flttoflt_flt_flt(&res_flt, a);  // normal operation
  return res_flt;
}

inline float xil_fpo_flttoflt_flt_d(double a)        
{
  float res_flt = 0.0f;

  // xip_fpo_flttoflt_flt_d
  xip_fpo_flttoflt_flt_d(&res_flt, a);  // normal operation
  return res_flt;
}

inline double xil_fpo_flttoflt_d_flt(float a)        
{
  double res_d = 0.0;

  // xip_fpo_flttoflt_d_flt
  xip_fpo_flttoflt_d_flt(&res_d, a);  // normal operation
  return res_d;
}

inline double xil_fpo_flttoflt_d_d(double a)          
{
  double res_d = 0.0;

  // xip_fpo_flttoflt_d_d
  xip_fpo_flttoflt_d_d(&res_d, a);  // normal operation
  return res_d;
}

#endif
#endif /* #ifndef __AESL_FPO_H__*/


