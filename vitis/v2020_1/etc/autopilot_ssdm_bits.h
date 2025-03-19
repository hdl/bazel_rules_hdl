/* autopilot_ssdm_bits.h */
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
 * $Id$
 */


#ifndef _AUTOPILOT_SSDM_BITS_H_
#define _AUTOPILOT_SSDM_BITS_H_

#ifdef __STRICT_ANSI__
#define typeof __typeof__
#endif

#ifndef AP_ASSERT
#ifndef AESL_SYN
#  include<assert.h>
#  define AP_ASSERT(cond, msg) assert(cond && msg)
#else
#  define AP_ASSERT(cond, msg)
#endif
#endif

#ifndef AESL_SYN
#include<stdlib.h>
#endif

#ifdef __USE_AP_INT__
#  define _ssdm_op_SetBit(X, Bit, Repl) X[Bit] = Repl
#  define _ssdm_op_GetBit(X, Bit) X[Bit]
#  define _ssdm_op_GET_RANGE(V, u, l) (V.range(u, l))
#  define _ssdm_op_SET_RANGE(V, u, l, x)  (V.range(u, l) = x)

#else


#  define _ssdm_op_GET_RANGE(V, u, l) _ssdm_op_GetRange(V, u, l)
#  define _ssdm_op_SET_RANGE(V, u, l, x)  _ssdm_op_SetRange(V, u, l, x)


#ifdef USE_SSDM_BITOP
#  define __builtin_bit_concat _ssdm_op_bit_concat
#  define __builtin_bit_select _ssdm_op_bit_select
#  define __builtin_bit_set _ssdm_op_bit_set
#  define __builtin_bit_part_select _ssdm_op_bit_part_select
#  define __builtin_bit_part_set _ssdm_op_bit_part_set
#endif

#define _ssdm_op_bitwidthof(TORV) (__bitwidthof__(typeof(TORV)))

/* -- Concatination ----------------*/
#define _ssdm_op_Concat(X, Y) ({ \
  unsigned int __attribute__((bitwidth(__bitwidthof__(X)+__bitwidthof__(Y)))) __R__; \
  unsigned int __attribute__((bitwidth(__bitwidthof__(X)))) __X2__ = X; \
  unsigned int __attribute__((bitwidth(__bitwidthof__(Y)))) __Y2__ = Y; \
  __builtin_bit_concat((void*)(&__R__), (void*)(&__X2__), (void*)(&__Y2__)); \
  __R__; \
})


/* -- Bit get/set ----------------*/
#define _ssdm_op_GetBit(Val, Bit) ({ \
  AP_ASSERT((Bit >= 0 && Bit <(_ssdm_op_bitwidthof(Val))), \
  "Bit select out of range"); \
  typeof(Val) __Val2__ = Val; \
  typeof(Val) __Result__ = 0; \
  __builtin_bit_part_select((void*)(&__Result__), (void*)(&__Val2__), Bit, Bit); \
  !!__Result__; \
})

#define _ssdm_op_SetBit(Val, Bit, Repl) ({ \
  AP_ASSERT((Bit >= 0 && Bit < (_ssdm_op_bitwidthof(Val))),\
  "Bit select out of range"); \
  typeof(Val) __Result__ = 0; \
  typeof(Val) __Val2__ = Val; \
  typeof(Repl) __Repl2__ = !!Repl; \
  __builtin_bit_part_set((void*)(&__Result__), (void*)(&__Val2__), (void*)(&__Repl2__), Bit, Bit); \
  __Result__; \
})


/* -- Part get/set ----------------*/

/* GetRange: Notice that the order of the range indices comply with SystemC
 standards. */
#define _ssdm_op_GetRange(Val, Hi, Lo) ({ \
  AP_ASSERT((Hi >= 0 && Hi < _ssdm_op_bitwidthof(Val) && \
  Lo < _ssdm_op_bitwidthof(Val) && Lo >= 0), \
  "Part select out of range"); \
  unsigned int __attribute__((bitwidth(__bitwidthof__(Val)))) __Result__ = 0; \
  unsigned int __attribute__((bitwidth(__bitwidthof__(Val)))) __Val2__ = Val; \
  __builtin_bit_part_select((void*)(&__Result__), (void*)(&__Val2__), Lo, Hi); \
  __Result__; \
})

/* SetRange: Notice that the order of the range indices comply with SystemC
 standards. */
#define _ssdm_op_SetRange(Val, Hi, Lo, Repl) ({ \
  AP_ASSERT((Hi >= 0 && Hi < _ssdm_op_bitwidthof(Val) && \
  Lo < _ssdm_op_bitwidthof(Val) && Lo >= 0), \
  "Part select out of range"); \
  typeof(Val) __Result__ = 0; \
  typeof(Val) __Val2__ = Val; \
  typeof(Repl) __Repl2__ = Repl; \
  __builtin_bit_part_set((void*)(&__Result__), (void*)(&__Val2__), (void*)(&__Repl2__), Lo, Hi); \
  __Result__; \
})

/* -- Reduce operations ----------------*/
#ifndef USE_SSDM_BITOP

#  define _ssdm_op_reduce(how, what) ({ \
     typeof(what) __what2__ = what; \
     __builtin_bit_ ## how ## _reduce((void*)(&__what2__)); \
   })

#else

#  define _ssdm_op_reduce(how, what) ({ \
     typeof(what) __what2__ = what; \
     _ssdm_op_reduce_ ## how((void*)(&__what2__)); \
   })

#endif

#define _ssdm_op_AndReduce(X) _ssdm_op_reduce(and, X)

#define _ssdm_op_NAndReduce(X) _ssdm_op_reduce(nand, X)
#define _ssdm_op_NandReduce(X) _ssdm_op_reduce(nand, X)

#define _ssdm_op_OrReduce(X) _ssdm_op_reduce(or, X)

#define _ssdm_op_NOrReduce(X) _ssdm_op_reduce(nor, X)
#define _ssdm_op_NorReduce(X) _ssdm_op_reduce(nor, X)

#define _ssdm_op_XorReduce(X) _ssdm_op_reduce(xor, X)

#define _ssdm_op_NXorReduce(X) _ssdm_op_reduce(nxor, X)
#define _ssdm_op_NxorReduce(X) _ssdm_op_reduce(nxor, X)

#define _ssdm_op_XNorReduce(X) _ssdm_op_reduce(nxor, X)
#define _ssdm_op_XnorReduce(X) _ssdm_op_reduce(nxor, X)
    

/* -- String-Integer conversions ----------------*/
#define _ssdm_op_printBits(val) { \
  int __bit__ = _ssdm_op_bitwidthof(val); \
  for ( ; __bit__ > 0; --__bit__) { \
    if (_ssdm_op_GetBit(val, __bit__-1)) \
      printf("%c", '1'); \
    else \
      printf("%c", '0'); \
  } \
} 

#define _ssdm_op_print_apint(val, radix) { \
  int __bit__ = _ssdm_op_bitwidthof(val); \
  if (radix == 2) { \
    _ssdm_op_printBits(val); \
  } else if (radix != 10) { \
    unsigned char __radix_bit__ = (radix == 16) ? 4 : 3; \
    int __digits__ = __bit__ / __radix_bit__; \
    int __r_bit__ = __bit__ - __digits__ * __radix_bit__; \
    unsigned char  __mask__ = radix - 1; \
    unsigned char  __no_remainder__ = __r_bit__ == 0; \
    unsigned char  __r_mask__ = __mask__ >> (__radix_bit__ - __r_bit__); \
    if (__no_remainder__) __r_mask__ = __mask__; \
    __digits__ -= __no_remainder__; \
    printf("%X", (uint4) ((val >> (__digits__* __radix_bit__)) & __r_mask__)); \
    --__digits__; \
    while (__digits__ >= 0) { \
      printf("%X", (uint4) ((val >> (__digits__* __radix_bit__)) & __mask__)); \
      --__digits__; \
    } \
  } else { \
    char *__buf__ = (char*) malloc(sizeof(char) * __bit__); \
    int __i__ = 0; \
    typeof(val) __X__ = val; \
    if (__X__ < 0) { \
      printf("-"); \
      __X__ = -__X__; \
    } \
    if (__X__ == 0)  \
      printf("0"); \
    else { \
      while (__X__) { \
        __buf__[__i__] = __X__ % 10; \
        __X__ /= 10; \
        ++__i__; \
      } \
      while (--__i__ >= 0) { \
        printf("%d", __buf__[__i__]); \
      } \
    } \
    free(__buf__); \
  } \
}

#define _ssdm_op_fprintBits(fileout, val) { \
  int __bit__ = _ssdm_op_bitwidthof(val); \
  for ( ; __bit__ > 0; --__bit__) { \
    if (_ssdm_op_GetBit(val, __bit__-1)) \
      fprintf(fileout, "%c", (unsigned char)'1'); \
    else \
      fprintf(fileout, "%c", (unsigned char)'0'); \
  } \
} 

#define _ssdm_op_fprint_apint(fileout, val, radix) { \
  int __bit__ = _ssdm_op_bitwidthof(val); \
  if (radix == 2) { \
    _ssdm_op_fprintBits(fileout, val); \
  } else if (radix != 10) { \
    unsigned char __radix_bit__ = (radix == 16) ? 4 : 3; \
    int __digits__ = __bit__ / __radix_bit__; \
    int __r_bit__ = __bit__ - __digits__ * __radix_bit__; \
    unsigned char  __mask__ = radix - 1; \
    unsigned char  __no_remainder__ = __r_bit__ == 0; \
    unsigned char  __r_mask__ = __mask__ >> (__radix_bit__ - __r_bit__); \
    if (__no_remainder__) __r_mask__ = __mask__; \
    __digits__ -= __no_remainder__; \
    fprintf(fileout, "%X", (uint4) ((val  >> (__digits__ * __radix_bit__))& __r_mask__)); \
    --__digits__; \
    while (__digits__ >= 0) { \
      fprintf(fileout, "%X", (uint4) ((val >> (__digits__* __radix_bit__)) & __mask__)); \
      --__digits__; \
    } \
  } else { \
    char *__buf__ = (char*) malloc(sizeof(char) * __bit__); \
    int __i__ = 0; \
    typeof(val) __X__ = val; \
    if (__X__ < 0) { \
      __X__ = -__X__; \
      fprintf(fileout,"-"); \
    } \
    if (__X__ == 0) \
      fprintf(fileout, "0");\
    else { \
      while (__X__) { \
        __buf__[__i__] = __X__ % 10; \
        __X__ /= 10; \
        ++__i__; \
      } \
      while (--__i__ >= 0) { \
        fprintf(fileout, "%d", __buf__[__i__]); \
      } \
    } \
    free(__buf__); \
  } \
}

#define _ssdm_op_sscan_hex_apint(str, bits) ({ \
  int __attribute__((bitwidth(bits))) __Result__ = 0; \
  int __base__ = 0, __len__ = (bits + 3) / 4; \
  int __real_len__; \
  if (str[0] == '-') __base__ += 1; \
  if (str[__base__] == '0' &&  (str[__base__ + 1] == 'x' || str[__base__ + 1] == 'X')) __base__ += 2; \
  __real_len__ = __base__; \
  while (str[__real_len__] != '\0') ++__real_len__; \
  if (__real_len__ > __base__+__len__+1) { \
    __base__ = __real_len__ - __len__; \
  } \
  __len__ += __base__; \
  while (__base__ < __len__) { \
    int __num__ = 0; \
    if (str[__base__] == '\0') break;  \
    if (str[__base__] >= '0' && str[__base__] <= '9') \
      __num__ = str[__base__] - '0'; \
    else if (str[__base__] >= 'A' && str[__base__] <= 'Z') \
      __num__ = str[__base__] - 'A' + 10 ; \
    else if (str[__base__] >= 'a' && str[__base__] <= 'z') \
      __num__ = str[__base__] - 'a' + 10; \
    __Result__ += __num__; \
    if ((__base__ != __len__-1) && (str[__base__ + 1] != '\0')) \
      __Result__ <<= 4; \
    ++__base__; \
  } \
  if (str[0] == '-') __Result__ = -__Result__; \
  __Result__; \
})


#define _ssdm_op_bitsFromString(str,bits) ({ \
  int __attribute__((bitwidth(bits))) __Result__; \
  __builtin_bit_from_string((void*)(&__Result__), str, 10); \
  __Result__; \
})

#define _ssdm_op_bitsFromHexString(str,bits) ({ \
  int __attribute__((bitwidth(bits))) __Result__; \
  __builtin_bit_from_string((void*)(&__Result__), str, 16); \
  __Result__; \
})

#define _ssdm_op_bitsFromOctalString(str,bits) ({ \
  int __attribute__((bitwidth(bits))) __Result__; \
  __builtin_bit_from_string((void*)(&__Result__), str, 8); \
  __Result__; \
})

#define _ssdm_op_bitsFromBinaryString(str,bits) ({ \
  int __attribute__((bitwidth(bits))) __Result__; \
  __builtin_bit_from_string((void*)(&__Result__), str, 2); \
  __Result__; \
})

#endif

#endif


