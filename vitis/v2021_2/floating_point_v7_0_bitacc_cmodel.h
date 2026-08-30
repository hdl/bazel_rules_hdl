// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
//----------------------------------------------------------------------------
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 6.0
//  \   \        Filename: $RCSfile: floating_point_v7_0_bitacc_cmodel.h,v $
//  /   /        Date Last Modified: $Date: 2011/06/15 13:06:43 $
// /___/   /\    Date Created: 2011
//
// Device  : All
// Library : floating_point_v7_0
// Purpose : Header file for bit accurate model of Floating Point Operator
// Revision: $Revision: 1.6.6.2 $
//
//------------------------------------------------------------------------------
//  (c) Copyright 2011-2012 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------

#ifndef __xip_fpo_bitacc_cmodel_h
#define __xip_fpo_bitacc_cmodel_h

#ifdef NT
#define __XIP_FPO_DLLIMPORT __declspec(dllimport)
#define __XIP_FPO_DLLEXPORT __declspec(dllexport)
#else
#define __XIP_FPO_DLLIMPORT
#define __XIP_FPO_DLLEXPORT
#endif

// Only define __XIP_FPO_BUILD_DLL when building the C model DLL; do not define it when using the C model
#ifdef __XIP_FPO_BUILD_DLL
#define __XIP_FPO_DLL __XIP_FPO_DLLEXPORT
#else
#define __XIP_FPO_DLL __XIP_FPO_DLLIMPORT
#endif

/* Extra define for functions with variable numbers of arguments */
#define __XIP_FPO_SENTINEL_ATTR
#if defined (__GNUC__)
# if __GNUC__ >= 4
#  undef __XIP_FPO_SENTINEL_ATTR
#  define __XIP_FPO_SENTINEL_ATTR __attribute__ ((sentinel))
# endif
#endif

/* Define Floating Point Operator core version number */
#define XIP_FPO_VERSION_MAJOR 6
#define XIP_FPO_VERSION_MINOR 2
#define XIP_FPO_REVISION      0
/* Version string does not include revision if revision is 0 (revision >0 reserved for future use) */
#define XIP_FPO_VERSION_STRING "6.2"

/* Use C99 exact width integer types for 64-bit integers and *_uj and *_sj functions */
// For Windows platforms, stdint.h and inttypes.h are not present in Visual Studio 2005/2008
// Therefore we define the required types ourselves
// For Linux platforms, we need to continue using stdint.h (and not re-define intmax_t, uintmax_t)
// because SysGen already uses this header.
#ifdef NT
typedef   signed char      xint8;
typedef   signed short     xint16;
typedef   signed int       xint32;
typedef   signed long long xint64;
typedef unsigned char      xuint8;
typedef unsigned short     xuint16;
typedef unsigned int       xuint32;
typedef unsigned long long xuint64;
typedef xint64  intmax_t;
typedef xuint64 uintmax_t;
#else
#include <stdint.h>
typedef int8_t   xint8;
typedef int16_t  xint16;
typedef int32_t  xint32;
typedef int64_t  xint64;
typedef uint8_t  xuint8;
typedef uint16_t xuint16;
typedef uint32_t xuint32;
typedef uint64_t xuint64;
#endif

#include <stdbool.h>

// REVISIT: included before mpfr.h to permit definition of prototypes for mpfr_printf
#include <stdio.h>

// Force MPFR to use intmax_t and uintmax_t types (the compiled libraries have the functions that use these)
#define MPFR_USE_INTMAX_T

// Tell MPIR on Windows platforms that it is compiled into a DLL
#ifdef NT
#define __GMP_LIBGMP_DLL 1
#endif

/* Check if GMP is included, and try to include it (Works with local GMP)
   Note that where MPIR is provided as a compatible alternative to GMP,
   it also provides a gmp.h header file to allow MPIR and GMP to be easily interchanged.
   Select the correct gmp.h by setting the -I option (includes path) for your compiler. */
#ifndef __GMP_H__
#include "gmp.h"
#endif

/* Check if MPFR is included, and try to include it (Works with local MPFR) */
#ifndef __MPFR_H
#include "mpfr.h"
#endif

/* Precision of mantissa or exponent (bits) */
typedef long xip_fpo_prec_t;

/* Definition of sign */
typedef int xip_fpo_sign_t;

/* Definition of exponent */
typedef long xip_fpo_exp_t;

/* The main floating point number structure */
typedef struct {
  xip_fpo_prec_t  _xip_fpo_exp_prec;
  xip_fpo_prec_t  _xip_fpo_mant_prec;
  xip_fpo_sign_t  _xip_fpo_sign;
  xip_fpo_exp_t   _xip_fpo_exp;
  mp_limb_t      *_xip_fpo_d;
} __xip_fpo_struct;

/* The main fixed point number structure */
typedef struct {
  xip_fpo_prec_t  _xip_fpo_i_prec;
  xip_fpo_prec_t  _xip_fpo_frac_prec;
  xint64         _xip_fpo_i;
  xint64         _xip_fpo_frac;
} __xip_fpo_fix_struct;

/* User-visible types for floating point and fixed point numbers */
typedef       __xip_fpo_struct      xip_fpo_t[1];
typedef       __xip_fpo_fix_struct  xip_fpo_fix_t[1];

/* Pointers to floating point and fixed point numbers, for function prototypes */
typedef       __xip_fpo_struct     *xip_fpo_ptr;
typedef const __xip_fpo_struct     *xip_fpo_srcptr;
typedef       __xip_fpo_fix_struct *xip_fpo_fix_ptr;
typedef const __xip_fpo_fix_struct *xip_fpo_fix_srcptr;

/* Definition of exception flags - return type of most functions
   Flags are as follows:
   bit 0 : underflow
   bit 1 : overflow
   bit 2 : invalid operation
   bit 3 : divide by zero
   bit 4 : operation not supported
   bit 5 : Accumulator Input Overflow
   bit 6 : Accumulator Overflow
   */
typedef int xip_fpo_exc_t;

#ifdef  __cplusplus
extern "C" {
#endif

typedef struct xil_fpo_accum_state xil_fpo_accum_state;

/* Information functions */
__XIP_FPO_DLL const char * xip_fpo_get_version (void);

/* Initialization functions */
__XIP_FPO_DLL void xip_fpo_init2        (xip_fpo_ptr, xip_fpo_prec_t, xip_fpo_prec_t);
__XIP_FPO_DLL void xip_fpo_fix_init2    (xip_fpo_fix_ptr, xip_fpo_prec_t, xip_fpo_prec_t);
__XIP_FPO_DLL void xip_fpo_inits2       (xip_fpo_prec_t, xip_fpo_prec_t, xip_fpo_ptr, ...) __XIP_FPO_SENTINEL_ATTR;
__XIP_FPO_DLL void xip_fpo_fix_inits2   (xip_fpo_prec_t, xip_fpo_prec_t, xip_fpo_fix_ptr, ...) __XIP_FPO_SENTINEL_ATTR;
__XIP_FPO_DLL void xip_fpo_clear        (xip_fpo_ptr);
__XIP_FPO_DLL void xip_fpo_fix_clear    (xip_fpo_fix_ptr);
__XIP_FPO_DLL void xip_fpo_clears       (xip_fpo_ptr, ...) __XIP_FPO_SENTINEL_ATTR;
__XIP_FPO_DLL void xip_fpo_fix_clears   (xip_fpo_fix_ptr, ...) __XIP_FPO_SENTINEL_ATTR;
__XIP_FPO_DLL void xip_fpo_set_prec     (xip_fpo_ptr, xip_fpo_prec_t, xip_fpo_prec_t);
__XIP_FPO_DLL void xip_fpo_fix_set_prec (xip_fpo_fix_ptr, xip_fpo_prec_t, xip_fpo_prec_t);
__XIP_FPO_DLL xip_fpo_prec_t xip_fpo_get_prec_mant     (xip_fpo_ptr);
__XIP_FPO_DLL xip_fpo_prec_t xip_fpo_get_prec_exp      (xip_fpo_ptr);
__XIP_FPO_DLL xip_fpo_prec_t xip_fpo_fix_get_prec_frac (xip_fpo_fix_ptr);
__XIP_FPO_DLL xip_fpo_prec_t xip_fpo_fix_get_prec_int  (xip_fpo_fix_ptr);

/* Assignment functions */
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set         (xip_fpo_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set     (xip_fpo_fix_ptr, xip_fpo_fix_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_ui      (xip_fpo_ptr, unsigned long);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_ui  (xip_fpo_fix_ptr, unsigned long);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_si      (xip_fpo_ptr, long);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_si  (xip_fpo_fix_ptr, long);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_uj      (xip_fpo_ptr, uintmax_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_uj  (xip_fpo_fix_ptr, uintmax_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_sj      (xip_fpo_ptr, intmax_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_sj  (xip_fpo_fix_ptr, intmax_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_flt     (xip_fpo_ptr, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_flt (xip_fpo_fix_ptr, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_d       (xip_fpo_ptr, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_d   (xip_fpo_fix_ptr, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_z       (xip_fpo_ptr, mpz_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_z   (xip_fpo_fix_ptr, mpz_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_q       (xip_fpo_ptr, mpq_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_q   (xip_fpo_fix_ptr, mpq_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_f       (xip_fpo_ptr, mpf_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_f   (xip_fpo_fix_ptr, mpf_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_fr      (xip_fpo_ptr, mpfr_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_fr  (xip_fpo_fix_ptr, mpfr_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_ui_2exp (xip_fpo_ptr, unsigned long, xip_fpo_exp_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_si_2exp (xip_fpo_ptr, long, xip_fpo_exp_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_uj_2exp (xip_fpo_ptr, uintmax_t, intmax_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_sj_2exp (xip_fpo_ptr, intmax_t, intmax_t);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_set_str     (xip_fpo_ptr, const char *, int);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_set_str (xip_fpo_fix_ptr, const char *, int);
__XIP_FPO_DLL void          xip_fpo_set_nan     (xip_fpo_ptr);
__XIP_FPO_DLL void          xip_fpo_set_inf     (xip_fpo_ptr, int);
__XIP_FPO_DLL void          xip_fpo_set_zero    (xip_fpo_ptr, int);

/* Conversion functions */
__XIP_FPO_DLL unsigned long xip_fpo_get_ui         (xip_fpo_srcptr);
__XIP_FPO_DLL unsigned long xip_fpo_fix_get_ui     (xip_fpo_fix_srcptr);
__XIP_FPO_DLL long          xip_fpo_get_si         (xip_fpo_srcptr);
__XIP_FPO_DLL long          xip_fpo_fix_get_si     (xip_fpo_fix_srcptr);
__XIP_FPO_DLL uintmax_t     xip_fpo_get_uj         (xip_fpo_srcptr);
__XIP_FPO_DLL uintmax_t     xip_fpo_fix_get_uj     (xip_fpo_fix_srcptr);
__XIP_FPO_DLL intmax_t      xip_fpo_get_sj         (xip_fpo_srcptr);
__XIP_FPO_DLL intmax_t      xip_fpo_fix_get_sj     (xip_fpo_fix_srcptr);
__XIP_FPO_DLL float         xip_fpo_get_flt        (xip_fpo_srcptr);
__XIP_FPO_DLL float         xip_fpo_fix_get_flt    (xip_fpo_fix_srcptr);
__XIP_FPO_DLL double        xip_fpo_get_d          (xip_fpo_srcptr);
__XIP_FPO_DLL double        xip_fpo_fix_get_d      (xip_fpo_fix_srcptr);
__XIP_FPO_DLL double        xip_fpo_get_d_2exp     (long *, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_get_z          (mpz_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_get_z      (mpz_ptr, xip_fpo_fix_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_get_f          (mpf_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_get_f      (mpf_ptr, xip_fpo_fix_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_get_fr         (mpfr_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fix_get_fr     (mpfr_ptr, xip_fpo_fix_srcptr);
__XIP_FPO_DLL char *        xip_fpo_get_str        (char *, xip_fpo_exp_t *, int, int, xip_fpo_srcptr);
__XIP_FPO_DLL char *        xip_fpo_fix_get_str    (char *, int, xip_fpo_fix_srcptr);
__XIP_FPO_DLL void          xip_fpo_free_str       (char *);
__XIP_FPO_DLL void          xip_fpo_fix_free_str   (char *);
__XIP_FPO_DLL int           xip_fpo_sizeinbase     (xip_fpo_srcptr, int);
__XIP_FPO_DLL int           xip_fpo_fix_sizeinbase (xip_fpo_fix_srcptr, int);

/* Operation functions */
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_add                        (xip_fpo_ptr, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_add_flt                    (float *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_add_d                      (double *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_sub                        (xip_fpo_ptr, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_sub_flt                    (float *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_sub_d                      (double *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_mul                        (xip_fpo_ptr, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_mul_flt                    (float *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_mul_d                      (double *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fma                        (xip_fpo_ptr, xip_fpo_srcptr, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fma_flt                    (float *, float, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fma_d                      (double *, double, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fms                        (xip_fpo_ptr, xip_fpo_srcptr, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fms_flt                    (float *, float, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fms_d                      (double *, double, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_div                        (xip_fpo_ptr, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_div_flt                    (float *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_div_d                      (double *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_rec                        (xip_fpo_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_rec_flt                    (float *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_rec_d                      (double *, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_abs                        (xip_fpo_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_abs_flt                    (float *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_abs_d                      (double *, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_log                        (xip_fpo_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_log_flt                    (float *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_log_d                      (double *, double);
__XIP_FPO_DLL int           xip_fpo_exp_array                  (xip_fpo_t * , xip_fpo_t * , xip_fpo_exc_t *, unsigned long long);
__XIP_FPO_DLL void          xip_fpo_exp_flt_array              (float  *    , float     * , xip_fpo_exc_t *, unsigned long long);
__XIP_FPO_DLL void          xip_fpo_exp_d_array                (double *    , double    * , xip_fpo_exc_t *, unsigned long long);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_exp                        (xip_fpo_ptr , xip_fpo_srcptr                    );
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_exp_flt                    (float  *    , float                             );
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_exp_d                      (double *    , double                            );
__XIP_FPO_DLL struct xil_fpo_accum_state * xip_fpo_accum_create_state (int , int , int , int , int);
__XIP_FPO_DLL void xip_fpo_accum_reset_state                   (struct xil_fpo_accum_state *);
__XIP_FPO_DLL void xip_fpo_accum_destroy_state                 (struct xil_fpo_accum_state *);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_accum_sample               (xip_fpo_t, xip_fpo_t, bool, struct xil_fpo_accum_state *);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_accum_sample_flt           (float   *, float    , bool, struct xil_fpo_accum_state *);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_accum_sample_d             (double  *, double   , bool, struct xil_fpo_accum_state *);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_sqrt                       (xip_fpo_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_sqrt_flt                   (float *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_sqrt_d                     (double *, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_recsqrt                    (xip_fpo_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_recsqrt_flt                (float *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_recsqrt_d                  (double *, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_unordered                  (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_unordered_flt              (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_unordered_d                (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_equal                      (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_equal_flt                  (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_equal_d                    (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_less                       (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_less_flt                   (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_less_d                     (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_lessequal                  (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_lessequal_flt              (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_lessequal_d                (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_greater                    (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_greater_flt                (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_greater_d                  (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_greaterequal               (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_greaterequal_flt           (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_greaterequal_d             (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_notequal                   (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_notequal_flt               (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_notequal_d                 (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_condcode                   (int *, xip_fpo_srcptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_condcode_flt               (int *, float, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_condcode_d                 (int *, double, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttofix                   (xip_fpo_fix_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttofix_int_flt           (int *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttofix_int_d             (int *, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fixtoflt                   (xip_fpo_ptr, xip_fpo_fix_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fixtoflt_flt_int           (float *, int);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_fixtoflt_d_int             (double *, int);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttoflt                   (xip_fpo_ptr, xip_fpo_srcptr);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttoflt_flt_flt           (float *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttoflt_flt_d             (float *, double);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttoflt_d_flt             (double *, float);
__XIP_FPO_DLL xip_fpo_exc_t xip_fpo_flttoflt_d_d               (double *, double);

#ifdef  __cplusplus
} /* End of "C" linkage block */
#endif

#endif // __xip_fpo_bitacc_cmodel_h

