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

// Common typedefs, constants and functions for use across Xilinx bit-accurate C models.
// #include this file inside each C model's exported header file.

#ifndef XIP_COMMON_BITACC_CMODEL_H
#define XIP_COMMON_BITACC_CMODEL_H

//Determine shared library import attributes
#ifndef XIP_XILINX_XIP_IMPEXP
#if defined(NT) || defined(NT64)
#define XIP_XILINX_XIP_IMPEXP __declspec(dllimport)
#elif defined(LIN) || defined(LIN64)
#define XIP_XILINX_XIP_IMPEXP
#else
#define XIP_XILINX_XIP_IMPEXP
#endif
#endif

//Determine best way to approximate inline functions
#ifndef XIP_XILINX_XIP_INLINE
#ifdef __cplusplus
#define XIP_XILINX_XIP_INLINE inline
#elif (__STDC_VERSION__ >= 199901L)
#define XIP_XILINX_XIP_INLINE static inline
#else
#define XIP_XILINX_XIP_INLINE static
#endif
#endif

//Check we know which model we are being included for
#ifndef XIP_XILINX_XIP_TARGET
#error "XIP_XILINX_XIP_TARGET undefined; must give interface name of model being compiled"
#endif

#ifdef __cplusplus
#include <cstddef>
using std::size_t;
extern "C" {
#else
#include <stddef.h>
#endif


/**
 * Result code from DLL functions
 */
typedef int xip_status;

/**
 * Error codes
 */
#define XIP_STATUS_OK     0
#define XIP_STATUS_ERROR  1

/**
 * Bit type
 */
typedef unsigned char xip_bit;
#define xip_type_trait_bit 0

/**
 * Real scalar type
 */
typedef double xip_real;
#define xip_type_trait_real 0

/**
 * Complex scalar type
 */
typedef struct { xip_real re, im; } xip_complex;
#define xip_type_trait_complex 0

/**
 * Integer type
 */
typedef unsigned int xip_uint;
#define xip_type_trait_uint 0

/**
 * 32 bit integer type
 */
typedef unsigned int xip_uint32;
#define xip_type_trait_uint32 0


/**
 * Declare a xip_array_<type> structure for holding multi-dimensional arrays of xip_<type> instances
 * Use xip_array_<type>_create() to create an array instance
 * Use xip_array_<type>_create_ex(xip_array_<type>_operations* ops) to create an array instance using a given xip_array_<type>_operations object
 * Use xip_array_<type>_reserve_data(xip_array_<type>* array, size_t n) to reserve data elements
 * Use xip_array_<type>_reserve_dim(xip_array_<type>* array, size_t n) to reserve dimension elements
 * Use xip_array_<type>_destroy(xip_array_<type>*) to destroy an array instance
 * Use xip_array_<type>_sub2ind_*(const xip_array_<type>* p, size_t s0...) to obtain an index from a list of subscripts
 * Use xip_array_<type>_set_element(xip_array_<type>* p, const xip_<type> value, size_t index) to set a value
 * Use xip_array_<type>_get_element(const xip_array_<type>* p, xip_<type>* value, size_t index) to get a value
 *
 * e.g.
 *    xip_array_real* array = xip_array_real_create();  //Create an empty array
 *    xip_array_real_reserve_data(array,1000);          //Reserve space for 1000 elements
 *    xip_array_real_reserve_dim(array,10);             //Reserve space for 10 dimensions
 *    array = xip_array_real_destroy(array);            //Destroy array
 *
 */
#define DECLARE_XIP_ARRAY(TYPE)  \
typedef struct xip_array_##TYPE##_struct xip_array_##TYPE;                          \
typedef struct xip_array_##TYPE##_operations_struct xip_array_##TYPE##_operations;  \
struct xip_array_##TYPE##_struct {             \
	xip_##TYPE* data;                          \
	size_t data_size;                          \
	size_t data_capacity;                      \
	size_t* dim;                               \
	size_t dim_size;                           \
	size_t dim_capacity;                       \
	unsigned int owner;                        \
	const xip_array_##TYPE##_operations* ops;  \
};                                             \
struct xip_array_##TYPE##_operations_struct {                                                                           \
	void* const (*ops_realloc     )(const xip_array_##TYPE##_operations* ops, void* p, size_t size);                    \
	void        (*ops_free        )(const xip_array_##TYPE##_operations* ops, void* p);                                 \
	void        (*ops_elem_create )(const xip_array_##TYPE##_operations* ops, xip_##TYPE* e);                           \
	void        (*ops_elem_copy   )(const xip_array_##TYPE##_operations* ops, xip_##TYPE* dst, const xip_##TYPE* src);  \
	void        (*ops_elem_swap   )(const xip_array_##TYPE##_operations* ops, xip_##TYPE* e1, xip_##TYPE* e2);          \
	void        (*ops_elem_destroy)(const xip_array_##TYPE##_operations* ops, xip_##TYPE* e);                           \
	void* ops_private;                                                                                                  \
}

/**
 * Export xip_array_<type> functions
 */
#define EXPORT_XIP_ARRAY(TYPE,TARGET)  EXPORT_XIP_ARRAY_RAW(TYPE,TARGET)
#define EXPORT_XIP_ARRAY_RAW(TYPE,TARGET)                                                                                                                \
XIP_XILINX_XIP_IMPEXP const xip_array_##TYPE##_operations* const xip_##TARGET##_xip_array_##TYPE##_get_default_ops();                                    \
XIP_XILINX_XIP_IMPEXP xip_array_##TYPE* const xip_##TARGET##_xip_array_##TYPE##_create();                                                                \
XIP_XILINX_XIP_IMPEXP xip_array_##TYPE* const xip_##TARGET##_xip_array_##TYPE##_create_ex(const xip_array_##TYPE##_operations* ops);                     \
XIP_XILINX_XIP_IMPEXP const xip_status xip_##TARGET##_xip_array_##TYPE##_reserve_data(xip_array_##TYPE* p, size_t max_nels);                             \
XIP_XILINX_XIP_IMPEXP const xip_status xip_##TARGET##_xip_array_##TYPE##_reserve_dim(xip_array_##TYPE* p, size_t max_ndim);                              \
XIP_XILINX_XIP_IMPEXP xip_array_##TYPE* const xip_##TARGET##_xip_array_##TYPE##_destroy(xip_array_##TYPE* p);                                            \
XIP_XILINX_XIP_IMPEXP const size_t xip_##TARGET##_xip_array_##TYPE##_sub2ind_1d(const xip_array_##TYPE* p, size_t s0);                                   \
XIP_XILINX_XIP_IMPEXP const size_t xip_##TARGET##_xip_array_##TYPE##_sub2ind_2d(const xip_array_##TYPE* p, size_t s0, size_t s1);                        \
XIP_XILINX_XIP_IMPEXP const size_t xip_##TARGET##_xip_array_##TYPE##_sub2ind_3d(const xip_array_##TYPE* p, size_t s0, size_t s1, size_t s2);             \
XIP_XILINX_XIP_IMPEXP const size_t xip_##TARGET##_xip_array_##TYPE##_sub2ind_4d(const xip_array_##TYPE* p, size_t s0, size_t s1, size_t s2, size_t s3);  \
XIP_XILINX_XIP_IMPEXP const xip_status xip_##TARGET##_xip_array_##TYPE##_set_element(xip_array_##TYPE* p, const xip_##TYPE* value, size_t index);        \
XIP_XILINX_XIP_IMPEXP const xip_status xip_##TARGET##_xip_array_##TYPE##_get_element(const xip_array_##TYPE* p, xip_##TYPE* value, size_t index)

/**
 * Declare the array type interfaces
 *  Note: for any given xip_array_* there should be only one DECLARE_XIP_ARRAY_INTERFACE to expose the interface
 */
#define DECLARE_XIP_ARRAY_INTERFACE(TYPE,TARGET)  DECLARE_XIP_ARRAY_INTERFACE_RAW(TYPE,TARGET)
#define DECLARE_XIP_ARRAY_INTERFACE_RAW(TYPE,TARGET)  \
XIP_XILINX_XIP_INLINE const xip_array_##TYPE##_operations* const xip_array_##TYPE##_get_default_ops()                                    { return xip_##TARGET##_xip_array_##TYPE##_get_default_ops();           }  \
XIP_XILINX_XIP_INLINE xip_array_##TYPE* const xip_array_##TYPE##_create()                                                                { return xip_##TARGET##_xip_array_##TYPE##_create();                    }  \
XIP_XILINX_XIP_INLINE xip_array_##TYPE* const xip_array_##TYPE##_create_ex(const xip_array_##TYPE##_operations* ops)                     { return xip_##TARGET##_xip_array_##TYPE##_create_ex(ops);              }  \
XIP_XILINX_XIP_INLINE const xip_status  xip_array_##TYPE##_reserve_data(xip_array_##TYPE* p, size_t max_nels)                            { return xip_##TARGET##_xip_array_##TYPE##_reserve_data(p,max_nels);    }  \
XIP_XILINX_XIP_INLINE const xip_status  xip_array_##TYPE##_reserve_dim(xip_array_##TYPE* p, size_t max_ndim)                             { return xip_##TARGET##_xip_array_##TYPE##_reserve_dim(p,max_ndim);     }  \
XIP_XILINX_XIP_INLINE xip_array_##TYPE* const xip_array_##TYPE##_destroy(xip_array_##TYPE* p)                                            { return xip_##TARGET##_xip_array_##TYPE##_destroy(p);                  }  \
XIP_XILINX_XIP_INLINE const size_t xip_array_##TYPE##_sub2ind_1d(const xip_array_##TYPE* p, size_t s0)                                   { return xip_##TARGET##_xip_array_##TYPE##_sub2ind_1d(p,s0);            }  \
XIP_XILINX_XIP_INLINE const size_t xip_array_##TYPE##_sub2ind_2d(const xip_array_##TYPE* p, size_t s0, size_t s1)                        { return xip_##TARGET##_xip_array_##TYPE##_sub2ind_2d(p,s0,s1);         }  \
XIP_XILINX_XIP_INLINE const size_t xip_array_##TYPE##_sub2ind_3d(const xip_array_##TYPE* p, size_t s0, size_t s1, size_t s2)             { return xip_##TARGET##_xip_array_##TYPE##_sub2ind_3d(p,s0,s1,s2);      }  \
XIP_XILINX_XIP_INLINE const size_t xip_array_##TYPE##_sub2ind_4d(const xip_array_##TYPE* p, size_t s0, size_t s1, size_t s2, size_t s3)  { return xip_##TARGET##_xip_array_##TYPE##_sub2ind_4d(p,s0,s1,s2,s3);   }  \
XIP_XILINX_XIP_INLINE const xip_status  xip_array_##TYPE##_set_element(xip_array_##TYPE* p, const xip_##TYPE* value, size_t index)       { return xip_##TARGET##_xip_array_##TYPE##_set_element(p,value,index);  }  \
XIP_XILINX_XIP_INLINE const xip_status  xip_array_##TYPE##_get_element(const xip_array_##TYPE* p, xip_##TYPE* value, size_t index)       { return xip_##TARGET##_xip_array_##TYPE##_get_element(p,value,index);  }

/**
 * Declare and export the fundamental array types
 */
DECLARE_XIP_ARRAY(bit    ); EXPORT_XIP_ARRAY(bit    ,XIP_XILINX_XIP_TARGET);
DECLARE_XIP_ARRAY(real   ); EXPORT_XIP_ARRAY(real   ,XIP_XILINX_XIP_TARGET);
DECLARE_XIP_ARRAY(complex); EXPORT_XIP_ARRAY(complex,XIP_XILINX_XIP_TARGET);
DECLARE_XIP_ARRAY(uint   ); EXPORT_XIP_ARRAY(uint   ,XIP_XILINX_XIP_TARGET);
DECLARE_XIP_ARRAY(uint32 ); EXPORT_XIP_ARRAY(uint32 ,XIP_XILINX_XIP_TARGET);


//Exposed interfaces for each xip_array_* type only if a previous Xilinx C model has not already done so
#ifndef XIP_ARRAY_BIT_API
DECLARE_XIP_ARRAY_INTERFACE(bit    ,XIP_XILINX_XIP_TARGET);
#define XIP_ARRAY_BIT_API
#endif

#ifndef XIP_ARRAY_REAL_API
DECLARE_XIP_ARRAY_INTERFACE(real   ,XIP_XILINX_XIP_TARGET);
#define XIP_ARRAY_REAL_API
#endif

#ifndef XIP_ARRAY_COMPLEX_API
DECLARE_XIP_ARRAY_INTERFACE(complex,XIP_XILINX_XIP_TARGET);
#define XIP_ARRAY_COMPLEX_API
#endif

#ifndef XIP_ARRAY_UINT_API
DECLARE_XIP_ARRAY_INTERFACE(uint   ,XIP_XILINX_XIP_TARGET);
#define XIP_ARRAY_UINT_API
#endif

#ifndef XIP_ARRAY_UINT32_API
DECLARE_XIP_ARRAY_INTERFACE(uint32 ,XIP_XILINX_XIP_TARGET);
#define XIP_ARRAY_UINT32_API
#endif

/**
 * Error-handling callback type
 */
typedef void (*xip_msg_handler)(void* handle, int error, const char* msg);

/**
 * Data-handling callback type
 *  Specific to xip_array_real type
 */
typedef int (*xip_array_real_handler)(const xip_array_real* data, void* handle, void* opt_arg);

#ifdef __cplusplus
} /* End of "C" linkage block */
#endif

#endif // XIP_COMMON_BITACC_CMODEL_H
