//  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
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
//-----------------------------------------------------------------------------

// Common typedefs, constants and functions for use across Xilinx bit-accurate C models
// which use the Multiple Integer Precision types from GMP / MPIR library.
// #include this file inside each C model's exported header file

#ifndef XIP_MPZ_BITACC_CMODEL_H
#define XIP_MPZ_BITACC_CMODEL_H

#include "xip_common_bitacc_cmodel.h"
#include "gmp.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Multiple Integer Precision (MPZ) type
 */
typedef mpz_t xip_mpz;
#define xip_type_trait_mpz 1

/**
 * Multiple Integer Precision (MPZ) complex type
 */
typedef struct { xip_mpz re, im; } xip_mpz_complex;
#define xip_type_trait_mpz_complex 2

/**
 * Declare and export the mpz array types
 */
DECLARE_XIP_ARRAY(mpz        ); EXPORT_XIP_ARRAY(mpz        ,XIP_XILINX_XIP_TARGET);
DECLARE_XIP_ARRAY(mpz_complex); EXPORT_XIP_ARRAY(mpz_complex,XIP_XILINX_XIP_TARGET);

//Exposed interfaces for each xip_array_* type only if a previous Xilinx C model has not already done so
#ifndef XIP_ARRAY_MPZ_API
DECLARE_XIP_ARRAY_INTERFACE(mpz        ,XIP_XILINX_XIP_TARGET);
#define XIP_ARRAY_MPZ_API
#endif

#ifndef XIP_ARRAY_MPZ_COMPLEX_API
DECLARE_XIP_ARRAY_INTERFACE(mpz_complex,XIP_XILINX_XIP_TARGET);
#define XIP_ARRAY_MPZ_COMPLEX_API
#endif

#ifdef __cplusplus
} /* End of "C" linkage block */
#endif

#endif // XIP_MPZ_BITACC_CMODEL_H

