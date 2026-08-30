//-----------------------------------------------------------------------------
// 
// 
//  Vendor: Xilinx
//  Version: 1.0
//  Filename: $RCSfile: example_bitacc_cmodel.h,v $
//  Date Last Modified: $Date: 2010/04/13 09:57:20 $
//  Date Created: 2012
// 
// 
//
// Device  : All
// Library : dds_compiler_v6_0
// Purpose : Header file for bit accurate C model
//-----------------------------------------------------------------------------
//  (c) Copyright 2012 Xilinx, Inc. All rights reserved.
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

#ifndef XIP_DDS_COMPILER_V6_0_BITACC_CMODEL_H
#define XIP_DDS_COMPILER_V6_0_BITACC_CMODEL_H

// Common typedefs, constants and functions for use across Xilinx bit-accurate C models
#undef XIP_XILINX_XIP_TARGET
#define XIP_XILINX_XIP_TARGET dds_v6_0
#include "xip_common_bitacc_cmodel.h"

#ifdef __cplusplus
extern "C" {
#endif

//Depreciated; these functions now defined within model
#define DEFINE_XIP_ARRAY(TYPE)

//Depreciated; use xip_status/XIP_STATUS_* instead
typedef xip_status xip_dds_compiler_v6_0_status;
#define XIP_DDS_COMPILER_V6_0_STATUS_OK    XIP_STATUS_OK
#define XIP_DDS_COMPILER_V6_0_STATUS_ERROR XIP_STATUS_ERROR

/**
 * Core Specific Constants
 */
/* PartsPresent values */
#define XIP_DDS_PHASE_GEN_AND_SIN_COS_LUT 0
#define XIP_DDS_PHASE_GEN_ONLY            1
#define XIP_DDS_SIN_COS_LUT_ONLY          2

  /* DDS_Clock_Rate limits */
#define XIP_DDS_CLOCK_RATE_MIN 0.01
#define XIP_DDS_CLOCK_RATE_MAX 1000

  /* Channels limits */
#define XIP_DDS_CHANNELS_MIN 1
#define XIP_DDS_CHANNELS_MAX 16

  /* Mode of Operation values */
#define XIP_DDS_MOO_CONVENTIONAL 0
#define XIP_DDS_MOO_RASTERIZED   1

  /* Modulus limits */
#define XIP_DDS_MODULUS_MIN 9
#define XIP_DDS_MODULUS_MAX 16384

  /* ParameterEntry values */
#define XIP_DDS_SYSTEM_PARAMS   0
#define XIP_DDS_HARDWARE_PARAMS 1

  /* Spurious Free Dynamic Range SFDR limits */
#define XIP_DDS_SFDR_MIN 18
#define XIP_DDS_SFDR_MAX 150

  /* Frequency_Resolution SFDR limits */
#define XIP_DDS_FREQ_RES_MIN 0.000000001
#define XIP_DDS_FREQ_RES_MAX 125000000

  /* Noise_Shaping values */
#define XIP_DDS_NS_NONE   0
#define XIP_DDS_NS_DITHER 1
#define XIP_DDS_NS_TAYLOR 2
#define XIP_DDS_NS_AUTO   3

  /* Phase_Increment and Phase_Offset values */
#define XIP_DDS_PINCPOFF_NONE   0
#define XIP_DDS_PINCPOFF_PROG   1
#define XIP_DDS_PINCPOFF_FIXED  2
#define XIP_DDS_PINCPOFF_STREAM 3

  /* Output_Selection values */
#define XIP_DDS_OUT_SIN_ONLY    0
#define XIP_DDS_OUT_COS_ONLY    1
#define XIP_DDS_OUT_SIN_AND_COS 2

  /* Present/absent values */
#define XIP_DDS_ABSENT 0
#define XIP_DDS_PRESENT 1

  /* Amplitude_Mode values */
#define XIP_DDS_FULL_RANGE  0
#define XIP_DDS_UNIT_CIRCLE 1

  /* Output_Form */
#define XIP_DDS_OUTPUT_TWOS     0
#define XIP_DDS_OUTPUT_SIGN_MAG 1

  /* Memory_Type values */
#define XIP_DDS_MEM_AUTO  0
#define XIP_DDS_MEM_BLOCK 1
#define XIP_DDS_MEM_DIST  2

  /* Optimization_Goal values */
#define XIP_DDS_OPTGOAL_AUTO  0
#define XIP_DDS_OPTGOAL_AREA  1
#define XIP_DDS_OPTGOAL_SPEED 2

  /* Resolved Optimization_Goal values */
#define XIP_DDS_RESOPTGOAL_AREA  0
#define XIP_DDS_RESOPTGOAL_SPEED 1

  /* DSP48_use values */
#define XIP_DDS_DSP_MIN 0
#define XIP_DDS_DSP_MAX 1

  /* Latency_configuration values */
#define XIP_DDS_LATENCY_AUTO   0
#define XIP_DDS_LATENCY_MANUAL 1

  /* S_CONFIG_Sync_Mode values */
#define XIP_DDS_CONFIG_SYNC_VECTOR 0
#define XIP_DDS_CONFIG_SYNC_PACKET 1

#define ci_max_pipe_stages 13
#define ci_quad_sym_thresh 2048

typedef double xip_dds_v6_0_data;

typedef struct
{
  /**
   * dds_compiler_v6_0 Core Generics
   *
   * These are the only generics that influence the operation of this bit-accurate model.
   */
  const char *name;                      //@- Instance name (arbitrary)
  unsigned int PartsPresent;
  double       DDS_Clock_Rate;
  unsigned int Channels;
  unsigned int Mode_of_Operation;
  unsigned int Modulus;
  unsigned int ParameterEntry;
  double       Spurious_Free_Dynamic_Range;
  double       Frequency_Resolution;
  unsigned int Noise_Shaping;
  unsigned int Phase_Increment;
  unsigned int Resync;
  unsigned int Phase_Offset;
  unsigned int Output_Selection;
  unsigned int Negative_Sine;
  unsigned int Negative_Cosine;
  unsigned int Amplitude_Mode;
  unsigned int Memory_Type;
  unsigned int Optimization_Goal;
  unsigned int DSP48_Use;
  unsigned int Has_TREADY;
  unsigned int S_CONFIG_Sync_Mode;
  unsigned int Output_Form;
  unsigned int Latency_Configuration;
  unsigned int Has_ARESETn;
  xip_dds_v6_0_data PINC[XIP_DDS_CHANNELS_MAX];
  xip_dds_v6_0_data POFF[XIP_DDS_CHANNELS_MAX];
  unsigned int Latency;
  unsigned int Phase_Width;
  unsigned int Output_Width;

  /* The following parameters are the results of resolution fns. They are included here so that they are in
     the return structure of get_config */

  double       resSFDR;
  double       resFrequency_Resolution;
  unsigned int resNoise_Shaping;
  unsigned int resMemory_Type;
  unsigned int resOptimization_Goal;
  signed   int resLatency;
  unsigned int resPhase_Width;
  unsigned int resOutput_Width;
  unsigned int resPhaseAngleWidth;
  unsigned int resPhaseErrWidth;
  xip_uint resLatencyPipe[ci_max_pipe_stages+1]; //100 is much bigger than max possible latency


  int debug;                             //@- Debug information
} xip_dds_v6_0_config;

typedef struct
{
  /**
   * Input data config channel structure. Contains pointers to vectors (arrays) of double parts
   * i.e. one array for PhaseINCrement values - one per channel and the other array for PhaseOFFset values.
   */

  xip_dds_v6_0_data *din_pinc;  //@- Phase Increment data
  xip_dds_v6_0_data *din_poff;  //@- Phase Offset data

} xip_dds_v6_0_config_pkt;


/**
 * dds_compiler_v6_0 handle type (opaque to user).
 */
struct _xip_dds_v6_0;
typedef struct _xip_dds_v6_0 xip_dds_v6_0;

//Helpers for accessing data
XIP_XILINX_XIP_IMPEXP const xip_status xip_dds_v6_0_xip_array_real_set_data(xip_array_real* p, const xip_real  value, size_t sample, size_t chan, size_t field);
XIP_XILINX_XIP_IMPEXP const xip_status xip_dds_v6_0_xip_array_real_get_data(const xip_array_real* p, xip_real* value, size_t sample, size_t chan, size_t field);

/**
 * Fill in a configuration structure with the core's default values.
 *
 * @param     config     The configuration structure to be populated
 * @returns   Exit code  XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_default_config(xip_dds_v6_0_config *config);


/**
 * Create a new instance of the core based on some configuration values.
 *
 * @param     config      Pointer to a xip_dds_v6_0_config structure
 * @param     handler     Callback function for errors and warnings (providing a null
 *                        pointer means no messages are output)
 * @param     handle      Optional argument to be passed back to callback function
 *
 * @returns   Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
xip_dds_v6_0 *xip_dds_v6_0_create(
  const xip_dds_v6_0_config   *config,
  xip_msg_handler             handler,
  void                        *handle
);

/**
 * Destroy an instance of the core and free any resources allocated.
 *
 * @param     s           Pointer to xip_dds_v6_0 state structure
 * @returns   Exit code   XIP_STATUS_*
 *
 */
XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_destroy(xip_dds_v6_0 *s);

/**
 * Get version of model.
 *
 * @returns   String  Textual representation of model version
 */
XIP_XILINX_XIP_IMPEXP
const char* xip_dds_v6_0_get_version(void);

/**
 * Reset an instance of the core.
 *
 * @param     s           Pointer to xip_dds_v6_0 state structure
 * @returns   Exit code   XIP_STATUS_*
 */

XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_reset(xip_dds_v6_0 *s);

/**
 * Fill a configuration structure with the core's current state
 */
XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_get_config(xip_dds_v6_0 *s,
                                         xip_dds_v6_0_config* config);

/**
 * Allocate appropriate buffers in a config pkt structure.
 *
 * @param     r               Address of a pointer to request structure to set up
 * @param     din_pinc_size   Number of channels to allocate space for
 * @param     din_poff_size   Number of channels to allocate space for
 * @returns   Exit code       XIP_STATUS_*
 *
 */
XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_alloc_config_pkt(xip_dds_v6_0_config_pkt **r,
                                               xip_uint                din_pinc_size,
                                               xip_uint                din_poff_size);

/**
 * Deallocate the buffers in a config pkt structure allocated by xip_dds_v6_0_alloc_config_pkt
 *
 * @param     s           Pointer to xip_dds_v6_0 state structure
 * @param     r           Pointer to config_pkt structure to free
 * @returns   Exit code   XIP_STATUS_*
 *
 */
XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_free_config_pkt(xip_dds_v6_0_config_pkt **r);

XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_config_do(xip_dds_v6_0             *s,
                                        xip_dds_v6_0_config_pkt  *req);


/**
 * Apply a transaction on the data port.
 *
 * @param     s           Pointer to xip_dds_v6_0 state structure
 * @param     req         Pointer to xip_array_real request array
 * @param     resp        Pointer to xip_array_real response array
 * @param     samples, channels, in_fields, out_fields Dimensions of input and output arrays (Sample and channel are common to both)
 * @returns   Exit code   XIP_STATUS_*
 */
XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_data_do(xip_dds_v6_0   *s,
                                      xip_array_real *req,
                                      xip_array_real *resp,
                                      size_t         samples,
                                      size_t         channels,
                                      size_t         in_fields,
                                      size_t         out_fields);

XIP_XILINX_XIP_IMPEXP
const xip_status xip_dds_v6_0_data_do_signed(xip_dds_v6_0   *s,
                                             xip_array_real *req,
                                             xip_array_real *resp,
                                             size_t         samples,
                                             size_t         channels,
                                             size_t         in_fields,
                                             size_t         out_fields,
                                             int            form);

#ifdef __cplusplus
}
#endif

#endif
