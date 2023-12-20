// $RCSfile: xfft_v9_0_bitacc_cmodel.h,v $ $Revision: 1.2 $ $Date: 2010/09/08 12:33:19 $
//
//  (c) Copyright 2008-2009 Xilinx, Inc. All rights reserved.
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
//-------------------------------------------------------------------

#ifndef xfft_v9_0_bitacc_cmodel_h
#define xfft_v9_0_bitacc_cmodel_h

#ifdef NT
#define DLLIMPORT __declspec(dllimport)
#else
#define DLLIMPORT
#endif

#ifndef Ip_xilinx_ip_xfft_v9_0_DLL
#define Ip_xilinx_ip_xfft_v9_0_DLL DLLIMPORT
#endif

#ifdef  __cplusplus
extern "C" {
#endif

struct xilinx_ip_xfft_v9_0_generics
{
  /**
   * XFFT v7.1 Core Generics
   *
   * These are the only generics that influence the operation of this bit-accurate model.
   * Note: C_CHANNELS is not part of the generics structure - this is an error in the datasheet.
   *       To model a multichannel FFT, run this single channel model on each channel in turn.
   */
  int C_NFFT_MAX;            //@- log2(maximum transform length): 3-16
  int C_ARCH;                //@- Architecture: 1=radix-4, 2=radix-2, 3=pipelined, 4=radix-2 Lite
  int C_HAS_NFFT;            //@- Run-time configurable transform length: 0=no, 1=yes
  int C_USE_FLT_PT;          //@- Input and output data format: 0=fixed-point, 1=single-precision floating point
  int C_INPUT_WIDTH;         //@- Input data width: 8-34 bits (32 if C_USE_FLT_PT = 1)
  int C_TWIDDLE_WIDTH;       //@- Twiddle factor width: 8-34 bits (24-25 if C_USE_FLT_PT = 1)
  int C_HAS_SCALING;         //@- Data is scaled after the butterfly: 0=no, 1=yes
  int C_HAS_BFP;             //@- Type of scaling if C_HAS_SCALING=1: 0=fixed scaling, 1=block floating point
  int C_HAS_ROUNDING;        //@- Type of data rounding: 0=truncation, 1=convergent rounding
}; // xilinx_ip_xfft_v9_0_generics


/**
 * Get list of default generics.
 *
 * @returns xilinx_ip_xfft_v9_0_generics  Default generics.
 */
Ip_xilinx_ip_xfft_v9_0_DLL 
struct xilinx_ip_xfft_v9_0_generics
xilinx_ip_xfft_v9_0_get_default_generics();


/**
 * Structure containing the state of this C-Model.
 *
 * NOTE:  State may persist between simulations.
 */
struct xilinx_ip_xfft_v9_0_state;


/**
 * Create a new state structure for this C-Model.
 *
 * IMPORTANT: Client is responsible for calling xilinx_ip_xfft_v9_0_destroy_state()
 *            to free state memory.
 *
 * @param generics    Generics to be used to configure C-Model state.
 *
 * @returns xilinx_ip_xfft_v9_0_state*  Pointer to the internal state.
 */
Ip_xilinx_ip_xfft_v9_0_DLL
struct xilinx_ip_xfft_v9_0_state*
xilinx_ip_xfft_v9_0_create_state(struct xilinx_ip_xfft_v9_0_generics generics);


/**
 * Destroy a state structure.
 *
 * @param state    State structure to be destroyed (freed in memory).
 */
Ip_xilinx_ip_xfft_v9_0_DLL
void xilinx_ip_xfft_v9_0_destroy_state(struct xilinx_ip_xfft_v9_0_state* state);


/**
 * Structure to capture all inputs to the XFFT v7.1 C-Model.
 *
 * @param nfft              log2(transform length) for this transform. Maximum value is
 *                          C_NFFT_MAX. Minimum value is 6 for Radix-4 architecture
 *                          or 3 for other architectures. Only used for run-time
 *                          configurable transform length (C_HAS_NFFT=1).
 * @param xn_re             Input data (real component). If C_USE_FLT_PT = 0, all 
 *                          components must be -1.0 <= data < +1.0. To ensure identical 
 *                          numerical behavior to the hardware, pre-quantize the data values
 *                          to have precision determined by C_INPUT_WIDTH.  If C_USE_FLT_PT = 1,
 *                          all components must be representable in the C++ float datatype
 *                          as single-precision, 32-bit values.
 * @param xn_re_size        Size of xn_re array. Must be 2^nfft.
 * @param xn_im             Input data (imaginary component). If C_USE_FLT_PT = 0, all 
 *                          components must be -1.0 <= data < +1.0. To ensure identical 
 *                          numerical behavior to the hardware, pre-quantize the data values
 *                          to have precision determined by C_INPUT_WIDTH.  If C_USE_FLT_PT = 1,
 *                          all components must be representable in the C++ float datatype
 *                          as single-precision, 32-bit values.
 * @param xn_im_size        Size of xn_im array. Must be 2^nfft.
 * @param scaling_sch       Array of integer values size S = number of stages.
 *                          For Radix-4 and Streaming architectures, S = nfft/2,
 *                          rounded up to the next integer.  For Radix-2 and Radix-2
 *                          Lite architectures, S = nfft. Each value corresponds to
 *                          scaling to be performed by the corresponding stage (so
 *                          scaling in stage 0 is in scaling_sch[0]), and must be
 *                          in the range 0 to 3. Only used for fixed scaling (if
 *                          C_HAS_SCALING=1 and C_HAS_BFP=0).
 * @param scaling_sch_size  Size of scaling_sch array. Must be S.
 * @param direction         Transform direction: 1=forward FFT, 0=inverse FFT (IFFT).
 */
struct xilinx_ip_xfft_v9_0_inputs
{
  int      nfft;              //@- log2(point size)

  double*  xn_re;             //@- Input data (real)
  int      xn_re_size;

  double*  xn_im;             //@- Input data (imaginary)
  int      xn_im_size;

  int*     scaling_sch;       //@- Scaling schedule
  int      scaling_sch_size;

  int      direction;         //@- Transform direction
}; // end xilinx_ip_xfft_v9_0_inputs


/**
 * Structure to capture all outputs from the XFFT v7.1 C-Model.
 *
 * Before using this structure the user is responsible for allocating enough memory
 * for each output array, and specifying the number of array elements allocated in
 * the _size parameters. If the _size values are too small, the model will fail with
 * an error. It is OK to allocate more memory than is required and specify a larger
 * number of array elements than required in the _size parameters. The model will set
 * the _size parameters to indicate the number of array elements that contain valid
 * output data.
 *
 * @param xk_re          Output data (real component).
 * @param xk_re_size     Size of xk_re array. Must be at least 2^nfft.
 * @param xk_im          Output data (imaginary component).
 * @param xk_im_size     Size of xk_im array. Must be at least 2^nfft.
 * @param blk_exp        Block exponent. Only valid if using block floating point (if
 *                       C_HAS_SCALING=1 and C_HAS_BFP=1).
 * @param overflow       Overflow: 1 indicates overflow occurred, 0 indicates no overflow
 *                       occurred. Only valid if using fixed scaling (if C_HAS_SCALING=1
 *                       and C_HAS_BFP=0).
 */
struct xilinx_ip_xfft_v9_0_outputs
{
  double*  xk_re;          //@- Output data (real)
  int      xk_re_size;

  double*  xk_im;          //@- Output data (imaginary)
  int      xk_im_size;

  int      blk_exp;        //@- Block exponent

  int      overflow;       //@- Overflow occurred
}; // xilinx_ip_xfft_v9_0_outputs


/**
 * Simulate this bit-accurate C-Model.
 *
 * @param     state      Internal state of this C-Model. State
 *                       may span multiple simulations.
 * @param     inputs     Inputs to this C-Model.
 * @param     outputs    Outputs from this C-Model.
 *
 * @returns   Exit code   Zero for SUCCESS, Non-zero otherwise.
 */
Ip_xilinx_ip_xfft_v9_0_DLL
int xilinx_ip_xfft_v9_0_bitacc_simulate
(
 struct xilinx_ip_xfft_v9_0_state*   state,
 struct xilinx_ip_xfft_v9_0_inputs   inputs,
 struct xilinx_ip_xfft_v9_0_outputs* outputs
 );


#ifdef  __cplusplus
}
#endif


#endif // xfft_v9_0_bitacc_cmodel_h

