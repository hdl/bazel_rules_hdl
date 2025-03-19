// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
/*
#-  (c) Copyright 2011-2021 Xilinx, Inc. All rights reserved.
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

*/
#ifndef __HLS_HALF_H__
#define __HLS_HALF_H__

#ifdef __SYNTHESIS__

#ifndef _HLS_HALF_DEFINED_
typedef __fp16 half;
#endif
#else // AESL_SYN

#ifndef __cplusplus
#error C++ is required to include this header file
#endif

#if defined __arm__ && !(defined HLS_NO_XIL_FPO_LIB)
#warning "Xilinx Floating Point Operator IP core does not provide simulation models for ARM architecture.  Automatically defining HLS_NO_XIL_FPO_LIB in order to avoid this library dependency, although bit-accurate simulation of some functions is no longer possible.  You can make this warning go away by adding this define yourself before including any other files." 
#define HLS_NO_XIL_FPO_LIB
#endif

#ifndef HLS_NO_XIL_FPO_LIB
#include "hls_half_fpo.h"
#else
#include "hls_half_sim.h"
#endif

#include <limits>
#include <climits>
/// Extensions to the C++ standard library.
//  It is used in hlsmath lib.
namespace std {
/// Numeric limits for half-precision floats.
/// Because of the underlying single-precision implementation of many operations, it inherits some properties from
/// `std::numeric_limits<float>`.
template <>
struct numeric_limits<half> : public numeric_limits<float> {
   public:
    /// Supports signed values.
    static const bool is_signed = true;

    /// Is not exact.
    static const bool is_exact = false;

    /// Doesn't provide modulo arithmetic.
    static const bool is_modulo = false;

    /// IEEE conformant.
    static const bool is_iec559 = true;

    /// Supports infinity.
    static const bool has_infinity = true;

    /// Supports quiet NaNs.
    static const bool has_quiet_NaN = true;

    /// Supports subnormal values.
    static const float_denorm_style has_denorm = denorm_present;

    /// Significant digits.
    static const int digits = 11;

    /// Significant decimal digits.
    static const int digits10 = 3;

    /// Required decimal digits to represent all possible values.
    static const int max_digits10 = 5;

    /// Number base.
    static const int radix = 2;

    /// One more than smallest exponent.
    static const int min_exponent = -13;

    /// Smallest normalized representable power of 10.
    static const int min_exponent10 = -4;

    /// One more than largest exponent
    static const int max_exponent = 16;

    /// Largest finitely representable power of 10.
    static const int max_exponent10 = 4;

    /// Smallest positive normal value.
    static half min() throw() {
        half t;
        t.set_bits(0x0400);
        return t;
    }

    /// Smallest finite value.
    static half lowest() throw() {
        half t;
        t.set_bits(0xFBFF);
        return t;
    }
    /// Largest finite value.
    static half max() throw() {
        half t;
        t.set_bits(0x7BFF);
        return t;
    }

    /// Difference between one and next representable value.
    static half epsilon() throw() {
        half t;
        t.set_bits(0x1400);
        return t;
    }

    /// Maximum rounding error.
    static half round_error() throw() {
        half t;
        t.set_bits(0x3800);
        return t;
    }

    /// Positive infinity.
    static half infinity() throw() {
        half t;
        t.set_bits(0x7C00);
        return t;
    }

    /// Quiet NaN.
    static half quiet_NaN() throw() {
        half t;
        t.set_bits(0x7FFF);
        return t;
    }

    /// Signalling NaN.
    static half signaling_NaN() throw() {
        half t;
        t.set_bits(0x7DFF);
        return t;
    }

    /// Smallest positive subnormal value.
    static half denorm_min() throw() {
        half t;
        t.set_bits(0x0001);
        return t;
    }
}; // numeric_limits<half>
} // namespace std

#include "hls_half_x_utils.h"

#endif // __SYNTHESIS__

#endif // __HLS_HALF__
