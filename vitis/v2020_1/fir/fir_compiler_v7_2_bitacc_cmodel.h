//-----------------------------------------------------------------------------
//  (c) Copyright 2011 Xilinx, Inc. All rights reserved.
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
// Purpose : Header file for bit accurate C model

#ifndef XIP_FIR_COMPILER_v7_2_BITACC_CMODEL_H
#define XIP_FIR_COMPILER_v7_2_BITACC_CMODEL_H

// Common typedefs, constants and functions for use across Xilinx bit-accurate C models
#undef XIP_XILINX_XIP_TARGET
#define XIP_XILINX_XIP_TARGET fir_v7_2
#include "xip_common_bitacc_cmodel.h"
#include "xip_mpz_bitacc_cmodel.h"

#ifdef __cplusplus
extern "C" {
#endif

//Depreciated; these functions now defined within model
#define DEFINE_FIR_XIP_ARRAY(TYPE)

/**
 * Filter Types
 */
#define XIP_FIR_SINGLE_RATE   0
#define XIP_FIR_INTERPOLATION 1
#define XIP_FIR_DECIMATION    2
#define XIP_FIR_HILBERT       3
#define XIP_FIR_INTERPOLATED  4

/**
 * Rate Change Type
 */
#define XIP_FIR_INTEGER_RATE    0
#define XIP_FIR_FRACTIONAL_RATE 1

/**
 * Channel Sequence Type
 */
#define XIP_FIR_BASIC_CHAN_SEQ    0
#define XIP_FIR_ADVANCED_CHAN_SEQ 1

/**
 * Quantization
 */
#define XIP_FIR_INTEGER_COEFF                   0
#define XIP_FIR_QUANTIZED_ONLY                  1
#define XIP_FIR_MAXIMIZE_DYNAMIC_RANGE          2
#define XIP_FIR_NORMALIZE_TO_CENTRE_COEFFICIENT 3

/**
 * Output Rounding
 */
#define XIP_FIR_FULL_PRECISION      0
#define XIP_FIR_TRUNCATE_LSBS       1
#define XIP_FIR_SYMMETRIC_ZERO      2
#define XIP_FIR_SYMMETRIC_INF       3
#define XIP_FIR_CONVERGENT_EVEN     4
#define XIP_FIR_CONVERGENT_ODD      5
#define XIP_FIR_NON_SYMMETRIC_DOWN  6
#define XIP_FIR_NON_SYMMETRIC_UP    7

/**
 * Configuration Method
 */
#define XIP_FIR_CONFIG_SINGLE     0
#define XIP_FIR_CONFIG_BY_CHANNEL 1

/**
 * Advance channel pattern ID
 */
typedef enum
{
  P4_0 = 0,  P4_1 = 1,  P4_2 = 2,  P4_3 = 3,  P4_4 = 4,
  P6_0 = 5,  P6_1 = 6,  P6_2 = 7,  P6_3 = 8,  P6_4 = 9,  P6_5 = 10,  P6_6 = 11,  P6_7 = 12,  P6_8 = 13,
  P8_0 = 14,  P8_1 = 15,  P8_2 = 16,  P8_3 = 17,  P8_4 = 18,  P8_5 = 19,  P8_6 = 20,  P8_7 = 21,  P8_8 = 22,  P8_9 = 23,  P8_10 = 24,  P8_11 = 25,  P8_12 = 26,
  P12_0 = 27,  P12_1 = 28,  P12_2 = 29,  P12_3 = 30,  P12_4 = 31,  P12_5 = 32,  P12_6 = 33,  P12_7 = 34,  P12_8 = 35,  P12_9 = 36,  P12_10 = 37,  P12_11 = 38,  P12_12 = 39,  P12_13 = 40,  P12_14 = 41,  P12_15 = 42,  P12_16 = 43,  P12_17 = 44,  P12_18 = 45,  P12_19 = 46,  P12_20 = 47,  P12_21 = 48,  P12_22 = 49,  P12_23 = 50,  P12_24 = 51,  P12_25 = 52,  P12_26 = 53,
  P16_0 = 54,  P16_1 = 55,  P16_2 = 56,  P16_3 = 57,  P16_4 = 58,  P16_5 = 59,  P16_6 = 60,  P16_7 = 61,  P16_8 = 62,  P16_9 = 63,  P16_10 = 64,  P16_11 = 65,  P16_12 = 66,  P16_13 = 67,  P16_14 = 68,  P16_15 = 69,  P16_16 = 70,  P16_17 = 71,  P16_18 = 72,  P16_19 = 73,  P16_20 = 74,  P16_21 = 75,
  P24_0 = 76,  P24_1 = 77,  P24_2 = 78,  P24_3 = 79,  P24_4 = 80,  P24_5 = 81,  P24_6 = 82,  P24_7 = 83,  P24_8 = 84,  P24_9 = 85,  P24_10 = 86,  P24_11 = 87,  P24_12 = 88,  P24_13 = 89,  P24_14 = 90,  P24_15 = 91,  P24_16 = 92,  P24_17 = 93,  P24_18 = 94,  P24_19 = 95,  P24_20 = 96,  P24_21 = 97,  P24_22 = 98,  P24_23 = 99,  P24_24 = 100,  P24_25 = 101,  P24_26 = 102,  P24_27 = 103,
  P32_0 = 104,  P32_1 = 105,  P32_2 = 106,  P32_3 = 107,  P32_4 = 108,  P32_5 = 109,  P32_6 = 110,  P32_7 = 111,  P32_8 = 112,  P32_9 = 113,  P32_10 = 114,  P32_11 = 115,  P32_12 = 116,  P32_13 = 117,  P32_14 = 118,  P32_15 = 119,  P32_16 = 120,  P32_17 = 121,  P32_18 = 122,  P32_19 = 123,  P32_20 = 124,  P32_21 = 125,
  P48_0 = 126,  P48_1 = 127,  P48_2 = 128,  P48_3 = 129,  P48_4 = 130,  P48_5 = 131,  P48_6 = 132,  P48_7 = 133,  P48_8 = 134,  P48_9 = 135,  P48_10 = 136,  P48_11 = 137,  P48_12 = 138,  P48_13 = 139,  P48_14 = 140,  P48_15 = 141,  P48_16 = 142,  P48_17 = 143,  P48_18 = 144,  P48_19 = 145,  P48_20 = 146,  P48_21 = 147,  P48_22 = 148,  P48_23 = 149,  P48_24 = 150,  P48_25 = 151,  P48_26 = 152,
  P64_0 = 153,  P64_1 = 154,  P64_2 = 155,  P64_3 = 156,  P64_4 = 157,  P64_5 = 158,  P64_6 = 159,  P64_7 = 160,  P64_8 = 161,  P64_9 = 162,  P64_10 = 163,  P64_11 = 164,  P64_12 = 165,  P64_13 = 166,  P64_14 = 167,  P64_15 = 168,  P64_16 = 169,  P64_17 = 170,  P64_18 = 171,  P64_19 = 172,  P64_20 = 173,  P64_21 = 174,
  P_MAX = 175,  // Dummy max size entry
  P_BASIC = 176 // Indicates Basic interleaved channels
} xip_fir_v7_2_pattern;

#define XIP_FIR_MAX_ADV_CHAN 64
#define XIP_FIR_MAX_ADV_CHAN_INDEX 24

XIP_XILINX_XIP_IMPEXP extern const int xip_fir_v7_2_pattern_map[P_MAX][XIP_FIR_MAX_ADV_CHAN][XIP_FIR_MAX_ADV_CHAN_INDEX+1];
XIP_XILINX_XIP_IMPEXP extern const int xip_fir_v7_2_pattern_seq[P_MAX][XIP_FIR_MAX_ADV_CHAN];

/**
 * Core configuration structure.
 *
 * Must be created and populated in order to instantiate the model.
 */
typedef struct
{
  const char*          name;                 //@- Instance name to use in error/warning reporting

  unsigned int         filter_type;          //@- Select from: XIP_FIR_SINGLE_RATE, XIP_FIR_INTERPOLATION, XIP_FIR_DECIMATION, XIP_FIR_HILBERT, XIP_FIR_INTERPOLATED
  unsigned int         rate_change;          //@- Select from: XIP_FIR_INTEGER_RATE, XIP_FIR_FRACTIONAL_RATE
  unsigned int         interp_rate;          //@- Specifies the interpolation (or up-sampling) factor
  unsigned int         decim_rate;           //@- Specifies the decimation (or down-sampling) factor
  unsigned int         zero_pack_factor;     //@- Specifies the zero packing factor for Interpolated filters

  const double*        coeff;                //@- Pointer to coefficient array
  unsigned int         coeff_padding;        //@- Specifies the amount zero padding added to the front of the filter
  unsigned int         num_coeffs;           //@- Specifies the number of coefficients in one filter
  unsigned int         coeff_sets;           //@- Specifies the number of coefficient sets in the coeff array
  unsigned int         reloadable;           //@- Specifies if the coefficients are reloadable; 0 = No, 1 = Yes
  unsigned int         is_halfband;          //@- Specifies if halfband coefficients have been used; 0 = No, 1 = Yes
  unsigned int         quantization;         //@- Specifies how the coeff array should quantized, select from: XIP_FIR_INTEGER_COEFF, XIP_FIR_QUANTIZED_ONLY, XIP_FIR_MAXIMIZE_DYNAMIC_RANGE
  unsigned int         coeff_width;          //@- Used to quantize the supplied coefficients.
  unsigned int         coeff_fract_width;    //@- Used to quantize the supplied coefficients.

  unsigned int         chan_seq;             //@- Specifies the channel sequence type, select from: XIP_FIR_BASIC_CHAN_SEQ, XIP_FIR_ADVANCED_CHAN_SEQ
  unsigned int         num_channels;         //@- Specifies the number of data channels supported
  xip_fir_v7_2_pattern init_pattern;          //@- Specifies the initial channel pattern used by the core
  unsigned int         num_paths;            //@- Specifies the number of data paths supported

  unsigned int         data_width;           //@- Used to quantize the input data
  unsigned int         data_fract_width;     //@- Used to quantize the input data
  unsigned int         output_rounding_mode; //@- Select from: XIP_FIR_FULL_PRECISION, XIP_FIR_TRUNCATE_LSBS, XIP_FIR_SYMMETRIC_ZERO, XIP_FIR_SYMMETRIC_INF, XIP_FIR_CONVERGENT_EVEN, XIP_FIR_CONVERGENT_ODD, XIP_FIR_NON_SYMMETRIC_DOWN, XIP_FIR_NON_SYMMETRIC_UP
  unsigned int         output_width;         //@- Ignored when XIP_FIR_FULL_PRECISION
  unsigned int         output_fract_width;   //@- READ ONLY: Provides the number of fractional bits present in output word
  unsigned int         config_method;        //@- Specifies the form of the configuration packets, select from: XIP_FIR_CONFIG_SINGLE, XIP_FIR_CONFIG_BY_CHANNEL
} xip_fir_v7_2_config;

/**
 * FIR Configuration packet
 */
typedef struct
{
  xip_fir_v7_2_pattern chanpat; //@- Specifies the Advanced channel pattern to use
  xip_array_uint*      fsel;    //@- Specifies which coefficient set to use for each channel
} xip_fir_v7_2_cnfg_packet;

/**
 * FIR Reload packet
 */
typedef struct
{
  xip_uint            fsel;   //@- Specifies which coefficient set is to be reloaded
  xip_array_real*     coeff;  //@- Specifies the coefficients to load
} xip_fir_v7_2_rld_packet;

/**
 * FIR handle type (opaque to user).
 */
struct _xip_fir_v7_2;
typedef struct _xip_fir_v7_2 xip_fir_v7_2;

/**
 * Define additional FIR specific xip_array_<type> helper functions:
 * o xip_array_<type>_set_chan
 *   @param    p         Pointer to xip_array_<type> to be modified
 *   @param    value     xip_<type> scalar value to assigned to specified channel
 *   @param    path      Parallel data path of channel to set
 *   @param    chan      Channel to set
 *   @param    index     Array index of channel to set, consider each channel as a seperate 1-D array indexed from 0
 *   @param    pattern   Specifies the advanced interleaved pattern to be used, for basic interleaved channels use P_BASIC
 *   @returns  Exit code XIP_STATUS_*
 * o xip_array_<type>_get_chan
 *   @param    p         Pointer to xip_array_<type> to be modified
 *   @param    value     Pointer to xip_<type> scalar to write to specified channel
 *   @param    path      Parallel data path of channel to set
 *   @param    chan      Channel to set
 *   @param    index     Array index of channel to set, consider each channel as a seperate 1-D array indexed from 0
 *   @param    pattern   Specifies the advanced interleaved pattern to be used, for basic interleaved channels use P_BASIC
 *   @returns  Exit code XIP_STATUS_*
 */

#define DECLARE_FIR_XIP_ARRAY(TYPE) \
XIP_XILINX_XIP_IMPEXP const xip_status xip_fir_v7_2_xip_array_##TYPE##_set_chan(xip_array_##TYPE* p, const xip_##TYPE value, size_t path, size_t chan, size_t index, xip_fir_v7_2_pattern pattern); \
XIP_XILINX_XIP_IMPEXP const xip_status xip_fir_v7_2_xip_array_##TYPE##_get_chan(const xip_array_##TYPE* p, xip_##TYPE* value, size_t path, size_t chan, size_t index, xip_fir_v7_2_pattern pattern); \

/**
 * Declare FIR specific array helper functions for the fundamental types used by the FIR data channels
 */
DECLARE_FIR_XIP_ARRAY(real);
DECLARE_FIR_XIP_ARRAY(complex);
DECLARE_FIR_XIP_ARRAY(mpz);
DECLARE_FIR_XIP_ARRAY(mpz_complex);

/**
 * Get version of model.
 *
 * @returns   String  Textual representation of model version
 */
XIP_XILINX_XIP_IMPEXP
const char* xip_fir_v7_2_get_version(void);

/**
 * Fill in a configuration structure with the core's default values.
 *
 * @param     config      The configuration structure to be populated
 * @returns   Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_default_config(
  xip_fir_v7_2_config*  config
);

/**
 * Create a new instance of the core based on some configuration values.
 *
 * @param     config      Pointer to a xip_fir_v7_2_config structure
 * @param     msg_handler Callback function for errors and warnings (providing a null
 *                        pointer means no messages are output)
 * @param     msg_handle  Optional argument to be passed back to callback function
 *
 * @returns   model       Pointer to xip_fir_v7_2 state structure
 */
XIP_XILINX_XIP_IMPEXP
xip_fir_v7_2* xip_fir_v7_2_create(
  const xip_fir_v7_2_config*  config,
  xip_msg_handler             msg_handler,
  void*                       msg_handle
);

/**
 * Fill a configuration structure with the core's current state
 *
 *  @param    model       Pointer to xip_fir_v7_2 state structure
 *  @returns  Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_get_config(
  xip_fir_v7_2*        model,
  xip_fir_v7_2_config* config
);

/**
 * Reset an instance of the core
 *
 * @param     model       Pointer to xip_fir_v7_2 state structure
 * @returns   Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_reset(xip_fir_v7_2* model);

/**
 * Destroy an instance of the core and free any resources allocated.
 *
 * @param     model       Pointer to xip_fir_v7_2 state structure
 * @returns   Exit code   XIP_STATUS_*
 *
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_destroy(xip_fir_v7_2* model);

/**
 * Register an output structure to write model output
 *
 * @param    model        Pointer to xip_fir_v7_2 state structure
 * @param    data         Pointer to an xip_array_<real|mpz> structure
 * @param    cmplx_data   Pointer to an xip_array_<complex|mpz_complex> structure, if data is set this argument will be
 *                        ignored.
 * @returns  Exit code    XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_set_data_sink(
  xip_fir_v7_2*       model,
  xip_array_real*     data,
  xip_array_complex*  cmplx_data
);
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_set_data_sink_mpz(
  xip_fir_v7_2*          model,
  xip_array_mpz*         data,
  xip_array_mpz_complex* cmplx_data
);

/**
 * Register a callback function to process the registered output structure
 *  Called when the output structure has been filled
 *
 * @param    model        Pointer to xip_fir_v7_2 state structure
 * @param    data_handler Callback function to process output array
 * @param    handle       Optional argument to be passed back to callback function
 * @param    opt_arg      Optional argument to be passed back to callback function
 * @returns  Exit code    XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_set_data_handler(
  xip_fir_v7_2*           model,
  xip_array_real_handler  data_handler,
  void*                   handle,
  void*                   opt_arg
);

/**
 * Calculate size of output in response to transaction.
 *
 * The number of input samples is examined and used to compute the number of
 * output samples that would be produced if this structure was presented to the
 * xip_fir_v7_2_data_send. The dim,dim_size and data_size fields of the output
 * data structure are populated
 *
 * @param     model          Pointer to xip_fir_v7_2 state structure
 * @param     data_in        Pointer to an xip_array_<real|mpz> structure
 * @param     data_out       Pointer to an xip_array_<real|mpz> structure
 * @param     cmplx_data_out Pointer to an xip_array_<complex|mpz_complex> structure, if data_out is set this argument
 *                           will be ignored.
 * @returns   Exit code      XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_calc_size(
  xip_fir_v7_2*         model,
  const xip_array_real* data_in,
  xip_array_real*       data_out,
  xip_array_complex*    cmplx_data_out
);
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_calc_size_mpz(
  xip_fir_v7_2*          model,
  const xip_array_real*  data_in,
  xip_array_mpz*         data_out,
  xip_array_mpz_complex* cmplx_data_out
);

/**
 * Pass a configuration packet to the model
 *
 * @param    model       Pointer to xip_fir_v7_2 state structure
 * @param    cng_packet  Pointer to an xip_fir_v7_2_cnfg_packet structure
 * @returns  Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_config_send(
  xip_fir_v7_2*                   model,
  const xip_fir_v7_2_cnfg_packet* cnfg_packet
);

/**
 * Pass a reload packet to the model
 *
 * @param    model       Pointer to xip_fir_v7_2 state structure
 * @param    cng_packet  Pointer to an xip_fir_v7_2_rld_packet structure
 * @returns  Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_reload_send(
  xip_fir_v7_2*                   model,
  const xip_fir_v7_2_rld_packet*  rld_packet
);

/**
 * Pass a data packet to the model for processing
 *
 * @param    model       Pointer to xip_fir_v7_2 state structure
 * @param    data        Pointer to an xip_array_real structure
 * @returns  Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_data_send(
  xip_fir_v7_2*           model,
  const xip_array_real*   data
);

/**
 * Callback function used to pass a data packet to the model for processing
 *
 * @param    data        Pointer to an xip_array_real structure
 * @param    model       Pointer to xip_fir_v7_2 state structure, cast to void
 * @param    dummy       Pointer for optional callback argument, redundant for fir model.
 * @returns  Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
int xip_fir_v7_2_data_send_handler(
  const xip_array_real* data,
  void*                 model,
  void*                 dummy
);

/**
 * Extract a data packet from the model
 *
 * @param    model       Pointer to xip_fir_v7_2 state structure
 * @param    data        Pointer to an xip_array_<real|mpz> structure
 * @param    cmplx_data  Pointer to an xip_array_<complex|mpz_complex> structure, if data is set this argument will be
 *                       ignored.
 * @returns  Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_data_get(
  xip_fir_v7_2*       model,
  xip_array_real*     data,
  xip_array_complex*  cmplx_data
);
XIP_XILINX_XIP_IMPEXP
xip_status xip_fir_v7_2_data_get_mpz(
  xip_fir_v7_2*           model,
  xip_array_mpz*          data,
  xip_array_mpz_complex*  cmplx_data
);

#ifdef __cplusplus
} /* End of "C" linkage block */
#endif

#endif // XIP_FIR_COMPILER_v7_2_BITACC_CMODEL_H
