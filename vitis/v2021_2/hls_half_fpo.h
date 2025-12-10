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
#ifndef __HLS_HALF_FPO_H__
#define __HLS_HALF_FPO_H__
// This is just for csim and cosim instead of synthesis.
// That is to say,  __SYNTHESIS__ and  HLS_NO_XIL_FPO_LIB are not defined.
#ifndef __cplusplus
#error C++ is required to include this header file
#endif

#include <iostream>
#include <limits>

// XXX work-around old version of GMP with C++11 <cstddef> used by fpo.
#include <cstddef>
#include "hls_fpo.h"

// Forward declaration of ap_fixed_base.
#include "ap_decl.h"

// Fiddle an MPFR variable to contain the same information as an xip_fpo_t variable without allocating memory
// m is the mpfr_t variable (destination), x is the xip_fpo_t variable (source)
// First variant: copy all information
#define XIP_FPO_2_MPFR(m, x)                   \
    (m)->_mpfr_prec = (x)->_xip_fpo_mant_prec; \
    (m)->_mpfr_sign = (x)->_xip_fpo_sign;      \
    (m)->_mpfr_exp = (x)->_xip_fpo_exp;        \
    (m)->_mpfr_d = (x)->_xip_fpo_d;

class half {
   public:
    typedef unsigned short uint16;
    template <typename T1, typename T2>
    struct half_traits;

    /* 16-bit float following IEEE 754
       16 bits inside             float value
    0 00000 0000000000 = 0x0000 = 0
    1 00000 0000000000 = 0x8000 = -0

    0 11111 0000000000 = 0x7c00 = infinity
    1 11111 0000000000 = 0xfc00 = -infinity
    0 11110 1111111111 = 0x7bff = max  = 65504
    x 11111 yyyyyyyyyy =        = nan,  in which yyyyyyyy !=0

    */
    half() : m_data() {}
    half(float rhs) {
        xip_fpo_half_set_flt(rhs);
    }

    /// Conversion constructor from AP types.
    template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
    half(const ap_fixed_base<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& rhs) {
        std::cout << "WARNING: explicit method ap_fixed::to_half() should be used to convert ap_fixed to half."
                  << std::endl;
        *this = rhs.to_half();
    }

    template <int _AP_W, bool _AP_S>
    half(const ap_int_base<_AP_W, _AP_S>& rhs) {
        *this = rhs.to_half();
    }

    template <int _AP_W, int _AP_I, bool _AP_S, ap_q_mode _AP_Q, ap_o_mode _AP_O, int _AP_N>
    half& operator =(const ap_fixed_base<_AP_W, _AP_I, _AP_S, _AP_Q, _AP_O, _AP_N>& rhs) {
       return *this = rhs.to_half();
     }
    template <int _AP_W, bool _AP_S>
    half& operator =(const ap_int_base<_AP_W, _AP_S>& rhs) {
      return  *this = rhs.to_half();
     }

    static bool half_isnan(half hf) { return (hf.m_data & 0x7FFF) > 0x7C00; }

    // half to float  implictly or explictly
    // for example,  static_cast<float> (half)
    operator float() const { return xip_fpo_half_get_flt(); }

    half& operator=(float rhs) { return *this = half(rhs); }

    //--------------- unary operation -----------/
    template <typename T>
    half& operator+=(const T& rhs) {
        return *this = half_axu_functions::half_plus(*this, rhs);
    }
     half& operator+=(const half& rhs) { return *this = *this + rhs; }

    template <typename T>
    half& operator-=(const T& rhs) {
        return *this = half_axu_functions::half_minus(*this, rhs);
    }

    half& operator-=(const half& rhs) { return *this = *this - rhs; }

    template <typename T>
    half& operator*=(const T& rhs) {
        return *this = half_axu_functions::half_multiplies(*this, rhs);
    }

    half& operator*=(const half& rhs) { return *this = *this * rhs; }

    template <typename T>
    half& operator/=(const T& rhs) {
        return *this = half_axu_functions::half_divides(*this, rhs);
    }

    half& operator/=(const half& rhs) { return *this = *this / rhs; }

    /// Prefix increment.
    half& operator++() { return *this += 1.0f; }

    /// Prefix decrement.
    half& operator--() { return *this -= 1.0f; }

    /// Postfix increment.
    half operator++(int) {
        half out(*this);
        ++*this;
        return out;
    }

    /// Postfix decrement.
    half operator--(int) {
        half out(*this);
        --*this;
        return out;
    }
    //--------------- unary operation -----------/

    //------------- native data -----------------/
    void set_bits(uint16 d) { m_data = d; }

    uint16 get_bits() { return m_data; }

   private:
    // Unsigned integer of (at least) 16 bits width.
    uint16 m_data;
    //------------- native data -----------------/

    friend std::ostream& operator<<(std::ostream& out, const half& hf) {
        float f = static_cast<float>(hf);
        return out << f;
    }

    friend std::istream& operator>>(std::istream& in, half& hf) {
        float f;
        if (in >> f) hf = static_cast<half>(f);
        return in;
    }

   public:
    //---------- arithemic operations------/

    // plus T + half
    template <typename T>
    friend typename half::half_traits<T, half>::rtvl_t operator+(const T& lhs, const half& rhs) {
        return half_axu_functions::half_plus(lhs, rhs);
    }

    // plus half + T
    template <typename T>
    typename half::half_traits<half, T>::rtvl_t operator+(const T& rhs) {
        return half_axu_functions::half_plus(*this, rhs);
    }

    // plus half + half
    half operator+(const half& rhs) { return half_axu_functions::half_plus(*this, rhs); }

    // sub  T - half
    template <typename T>
    friend typename half::half_traits<T, half>::rtvl_t operator-(const T& lhs, const half& rhs) {
        return half_axu_functions::half_minus(lhs, rhs);
    }

    // sub  half - T
    template <typename T>
    typename half::half_traits<half, T>::rtvl_t operator-(const T& rhs) {
        return half_axu_functions::half_minus(*this, rhs);
    }
    // sub  half - half
    half operator-(const half& rhs) { return half_axu_functions::half_minus(*this, rhs); }

    // mul T * half
    template <typename T>
    friend typename half::half_traits<T, half>::rtvl_t operator*(const T& lhs, const half& rhs) {
        return half_axu_functions::half_multiplies(lhs, rhs);
    }

    // mul half * T
    template <typename T>
    typename half::half_traits<half, T>::rtvl_t operator*(const T& rhs) {
        return half_axu_functions::half_multiplies(*this, rhs);
    }
    // mul half * half
    half operator*(const half& rhs) { return half_axu_functions::half_multiplies(*this, rhs); }

    // div  T / half
    template <typename T>
    friend typename half::half_traits<T, half>::rtvl_t operator/(const T& lhs, const half& rhs) {
        return half_axu_functions::half_divides(lhs, rhs);
    }

    // div half / T
    template <typename T>
    typename half::half_traits<half, T>::rtvl_t operator/(const T& rhs) {
        return half_axu_functions::half_divides(*this, rhs);
    }
    // div half/half
    half operator/(const half& rhs) { return half_axu_functions::half_divides(*this, rhs); }

    //-----------  comparison-----------------//
    /*
    // It seems to conflict with ap_private.
      template<typename T>
     friend  bool operator== (const T& lhs, const half& rhs) {
         return half_axu_functions::half_isequal(lhs, rhs);
      }

      template<typename T>
     friend bool operator!= (const T& lhs, const half& rhs) {
         return half_axu_functions::half_isnotequal(lhs, rhs);
      }
      template<typename T>
     friend bool operator> (const T& lhs, const half& rhs) {
         return half_axu_functions::half_isgreater(lhs, rhs);
      }

      template<typename T>
     friend bool operator>= (const T& lhs, const half& rhs) {
         return half_axu_functions::half_isgreaterequal(lhs, rhs);
      }

      template<typename T>
      friend bool operator< (const T& lhs, const half& rhs) {
         return half_axu_functions::half_isless(lhs, rhs);
      }


      template<typename T>
      friend bool operator<= (const T& lhs, const half& rhs) {
         return half_axu_functions::half_islessequal(lhs, rhs);
      }

    */
    template <typename T>
    bool operator==(const T& rhs) {
        return half_axu_functions::half_isequal(*this, rhs);
    }
    bool operator==(const half& rhs) { return half_axu_functions::half_isequal(*this, rhs); }

    template <typename T>
    bool operator!=(const T& rhs) {
        return half_axu_functions::half_isnotequal(*this, rhs);
    }
    bool operator!=(const half& rhs) { return half_axu_functions::half_isnotequal(*this, rhs); }

    template <typename T>
    bool operator>(const T& rhs) {
        return half_axu_functions::half_isgreater(*this, rhs);
    }
    bool operator>(const half& rhs) { return half_axu_functions::half_isgreater(*this, rhs); }
    template <typename T>

    bool operator>=(const T& rhs) {
        return half_axu_functions::half_isgreaterequal(*this, rhs);
    }
    bool operator>=(const half& rhs) { return half_axu_functions::half_isgreaterequal(*this, rhs); }

    template <typename T>
    bool operator<(const T& rhs) {
        return half_axu_functions::half_isless(*this, rhs);
    }
    bool operator<(const half& rhs) { return half_axu_functions::half_isless(*this, rhs); }

    template <typename T>
    bool operator<=(const T& rhs) {
        return half_axu_functions::half_islessequal(*this, rhs);
    }
    bool operator<=(const half& rhs) { return half_axu_functions::half_islessequal(*this, rhs); }
    //-----------  comparison-----------------//

    //----------------   xilinx float point ----------//
    // half simulation model with Xilinx Floating Point Operator IP core
    // bit-accurate simulation ref PG60, here provides some functions with one or two arguments which invoke inner
    // datatype and functions in lib. F is an operation function, such as xip_fpo_add_flt, xip_fpo_sub.
    template <typename F>
    static half math_function_1arg(F f, half x) {
        half res;
        xip_fpo_t rop, xop;
        xip_fpo_inits2(5, 11, rop, xop, (xip_fpo_ptr)0);
        x.xip_fpo_get_data(xop);
        f(rop, xop);
        res.xip_fpo_set_data(rop);
        xip_fpo_clears(rop, xop, (xip_fpo_ptr)0);
        return res;
    }

    template <typename F>
    static half binary_operator(F f, half x, half y) {
        half res;
        xip_fpo_t op, xop, yop;
        xip_fpo_inits2(5, 11, op, xop, yop, (xip_fpo_ptr)0);
        x.xip_fpo_get_data(xop);
        y.xip_fpo_get_data(yop);
        f(op, xop, yop);
        res.xip_fpo_set_data(op);
        xip_fpo_clears(op, xop, yop, (xip_fpo_ptr)0);
        return res;
    }
    // perform comparison
    template <typename F>
    static bool binary_operator_compare(F f, half x, half y) {
        int res;
        xip_fpo_t xop, yop;
        xip_fpo_inits2(5, 11, xop, yop, (xip_fpo_ptr)0);
        x.xip_fpo_get_data(xop);
        y.xip_fpo_get_data(yop);
        f(&res, xop, yop);
        xip_fpo_clears(xop, yop, (xip_fpo_ptr)0);
        return res;
    }

   private:
    /// Assign value from half data to xip_fpo struct
    /// \return xip_fpo exceptions
    xip_fpo_exc_t xip_fpo_get_data(xip_fpo_ptr op) const {
        int exc = 0;
        op->_xip_fpo_sign = ((m_data & 0x8000) ? -1 : 1);
        op->_xip_fpo_exp = ((m_data & 0x7C00) >> 10) - 14;
        *(op->_xip_fpo_d) = ((mp_limb_t)(m_data & 0x3FF) + (mp_limb_t)(0x400)) << (8 * sizeof(*(op->_xip_fpo_d)) - 11);
        if ((m_data & 0x7C00) == 0) { // subnormal
            exc |= 0x1;
            xip_fpo_set_zero(op, op->_xip_fpo_sign);
        } else if ((m_data & 0x7FFF) == 0x7C00) { // infinity
            exc |= 0x2;
            xip_fpo_set_inf(op, op->_xip_fpo_sign);
        } else if ((m_data & 0x7FFF) > 0x7C00) { // NaN
            exc |= 0x4;
            xip_fpo_set_nan(op);
        }
        return exc;
    }

    /// Convert
    float xip_fpo_half_get_flt() const {
        xip_fpo_t op;
        xip_fpo_init2(op, 5, 11);
        xip_fpo_exc_t exc = xip_fpo_get_data(op);
        float res;
        if (exc & 0x1) {
            res = (op->_xip_fpo_sign > 0 ? 0.0f : -0.0f);
        } else if (exc & 0x2) {
            res = (op->_xip_fpo_sign > 0 ? std::numeric_limits<float>::infinity()
                                         : -std::numeric_limits<float>::infinity());
        } else if (exc & 0x4) {
            res = std::numeric_limits<float>::quiet_NaN();
        } else {
            res = xip_fpo_get_flt(op);
        }
        xip_fpo_clear(op);
        return res;
    }

    /// Assign value from xip_fpo struct to half data
    /// \return void
    void xip_fpo_set_data(xip_fpo_ptr op) {
        mpfr_t fr;
        XIP_FPO_2_MPFR(fr, op);
        m_data = 0;
        m_data |= (op->_xip_fpo_sign == 1 ? 0 : 1) << 15;
        if (mpfr_zero_p(fr)) {
            m_data &= 0x8000;
        } else if (mpfr_inf_p(fr)) {
            m_data |= 0x7C00;
        } else if (mpfr_nan_p(fr)) {
            m_data |= 0x7E00;
        } else {
            m_data |= (op->_xip_fpo_exp + 14) << 10;
            m_data |= (*(op->_xip_fpo_d) << 1) >> (8 * sizeof(*(op->_xip_fpo_d)) - 10);
        }
    }

    /// Assignment
    void xip_fpo_half_set_flt(float rhs) {
        xip_fpo_t op;
        xip_fpo_init2(op, 5, 11);
        xip_fpo_set_flt(op, rhs);
        xip_fpo_set_data(op);
        xip_fpo_clear(op);
    }
    // --------  details on arithmetic and comparison operations ----/
    // pack them in an embedded struct for convenient managment.
    //
    struct half_axu_functions {
        // plus +
        template <typename T1, typename T2>
        static half half_plus(T1 x, T2 y) {
            return half::binary_operator(xip_fpo_add, x, y);
        }
        static float half_plus(float x, half y) { return HLS_FPO_ADDF(x, y); }
        static float half_plus(half x, float y) { return HLS_FPO_ADDF(x, y); }
        static double half_plus(double x, half y) { return HLS_FPO_ADD(x, y); }
        static double half_plus(half x, double y) { return HLS_FPO_ADD(x, y); }
        // sub -
        template <typename T1, typename T2>
        static half half_minus(T1 x, T2 y) {
            return half::binary_operator(xip_fpo_sub, x, y);
        }
        static float half_minus(float x, half y) { return HLS_FPO_SUBF(x, y); }
        static float half_minus(half x, float y) { return HLS_FPO_SUBF(x, y); }
        static double half_minus(double x, half y) { return HLS_FPO_SUB(x, y); }
        static double half_minus(half x, double y) { return HLS_FPO_SUB(x, y); }
        // mul  *
        template <typename T1, typename T2>
        static half half_multiplies(T1 x, T2 y) {
            return half::binary_operator(xip_fpo_mul, x, y);
        }
        static float half_multiplies(float x, half y) { return HLS_FPO_MULF(x, y); }
        static float half_multiplies(half x, float y) { return HLS_FPO_MULF(x, y); }
        static double half_multiplies(double x, half y) { return HLS_FPO_MUL(x, y); }
        static double half_multiplies(half x, double y) { return HLS_FPO_MUL(x, y); }
        // div /
        template <typename T1, typename T2>
        static half half_divides(T1 x, T2 y) {
            return half::binary_operator(xip_fpo_div, x, y);
        }
        static float half_divides(float x, half y) { return HLS_FPO_DIVF(x, y); }
        static float half_divides(half x, float y) { return HLS_FPO_DIVF(x, y); }
        static double half_divides(double x, half y) { return HLS_FPO_DIV(x, y); }
        static double half_divides(half x, double y) { return HLS_FPO_DIV(x, y); }
        // equeal ==
        template <typename T1, typename T2>
        static bool half_isequal(T1 x, T2 y) {
            return half::binary_operator_compare(xip_fpo_equal, x, y);
        }
        static bool half_isequal(float x, half y) { return HLS_FPO_EQUALF(x, y); }
        static bool half_isequal(half x, float y) { return HLS_FPO_EQUALF(x, y); }
        static bool half_isequal(double x, half y) { return HLS_FPO_EQUAL(x, y); }
        static bool half_isequal(half x, double y) { return HLS_FPO_EQUAL(x, y); }
        // not equal  !=
        template <typename T1, typename T2>
        static bool half_isnotequal(T1 x, T2 y) {
            return half::binary_operator_compare(xip_fpo_notequal, x, y);
        }
        static bool half_isnotequal(float x, half y) { return HLS_FPO_NOTEQUALF(x, y); }
        static bool half_isnotequal(half x, float y) { return HLS_FPO_NOTEQUALF(x, y); }
        static bool half_isnotequal(double x, half y) { return HLS_FPO_NOTEQUAL(x, y); }
        static bool half_isnotequal(half x, double y) { return HLS_FPO_NOTEQUAL(x, y); }
        // greater >
        template <typename T1, typename T2>
        static bool half_isgreater(T1 x, T2 y) {
            return half::binary_operator_compare(xip_fpo_greater, x, y);
        }
        static bool half_isgreater(float x, half y) { return HLS_FPO_GREATERF(x, y); }
        static bool half_isgreater(half x, float y) { return HLS_FPO_GREATERF(x, y); }
        static bool half_isgreater(double x, half y) { return HLS_FPO_GREATER(x, y); }
        static bool half_isgreater(half x, double y) { return HLS_FPO_GREATER(x, y); }
        // greaterequal  >=
        template <typename T1, typename T2>
        static bool half_isgreaterequal(T1 x, T2 y) {
            return half::binary_operator_compare(xip_fpo_greaterequal, x, y);
        }
        static bool half_isgreaterequal(float x, half y) { return HLS_FPO_GREATEREQUALF(x, y); }
        static bool half_isgreaterequal(half x, float y) { return HLS_FPO_GREATEREQUALF(x, y); }
        static bool half_isgreaterequal(double x, half y) { return HLS_FPO_GREATEREQUAL(x, y); }
        static bool half_isgreaterequal(half x, double y) { return HLS_FPO_GREATEREQUAL(x, y); }
        // less    <
        template <typename T1, typename T2>
        static bool half_isless(T1 x, T2 y) {
            return half::binary_operator_compare(xip_fpo_less, x, y);
        }
        static bool half_isless(float x, half y) { return HLS_FPO_LESSF(x, y); }
        static bool half_isless(half x, float y) { return HLS_FPO_LESSF(x, y); }
        static bool half_isless(double x, half y) { return HLS_FPO_LESS(x, y); }
        static bool half_isless(half x, double y) { return HLS_FPO_LESS(x, y); }
        // lessequal <=
        template <typename T1, typename T2>
        static bool half_islessequal(T1 x, T2 y) {
            return half::binary_operator_compare(xip_fpo_lessequal, x, y);
        }
        static bool half_islessequal(float x, half y) { return HLS_FPO_LESSEQUALF(x, y); }
        static bool half_islessequal(half x, float y) { return HLS_FPO_LESSEQUALF(x, y); }
        static bool half_islessequal(double x, half y) { return HLS_FPO_LESSEQUAL(x, y); }
        static bool half_islessequal(half x, double y) { return HLS_FPO_LESSEQUAL(x, y); }

    }; // struct half_axu_functions
    //----------------   xilinx float point ----------//
}; // class half

template <>
struct half::half_traits<char, half> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<signed char, half> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<unsigned char, half> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<short, half> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<unsigned short, half> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<int, half> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<unsigned int, half> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<float, half> {
    typedef float rtvl_t;
};

template <>
struct half::half_traits<double, half> {
    typedef double rtvl_t;
};

template <>
struct half::half_traits<long, half> {
    // typedef double rtvl_t;
    typedef half rtvl_t;
};

template <>
struct half::half_traits<unsigned long, half> {
    typedef half rtvl_t;
    // typedef double rtvl_t;
};

template <>
struct half::half_traits<half, char> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, signed char> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, unsigned char> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, short> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, unsigned short> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, int> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, unsigned int> {
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, float> {
    typedef float rtvl_t;
};

template <>
struct half::half_traits<half, double> {
    typedef double rtvl_t;
};

template <>
struct half::half_traits<half, long> {
    // typedef double rtvl_t;
    typedef half rtvl_t;
};

template <>
struct half::half_traits<half, unsigned long> {
    typedef half rtvl_t;
    // typedef double rtvl_t;
};


#endif // __HLS_HALF_FPO__
