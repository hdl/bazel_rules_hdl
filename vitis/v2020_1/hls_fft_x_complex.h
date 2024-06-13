// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
/* -*- c++ -*-*/
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

#ifndef X_HLS_FFT_X_COMPLEX_H
#define X_HLS_FFT_X_COMPLEX_H

/*
 * This file contains a C++ model of hls::fft.
 * It defines Vivado_HLS synthesis model.
 */
#ifndef __cplusplus
#error C++ is required to include this header file
#else


#include "ap_int.h"
#include "hls_x_complex.h"
#ifndef __SYNTHESIS__
#include <math.h>
#endif

#ifndef AESL_SYN
#include <iostream>
#include "hls_stream.h"
#include "fft/xfft_v9_1_bitacc_cmodel.h"
#endif

namespace hls {


  template<
    typename CONFIG_T,
    char FFT_INPUT_WIDTH,
    char FFT_OUTPUT_WIDTH,
    typename FFT_INPUT_T,
    typename FFT_OUTPUT_T,
    int FFT_LENGTH,
    char FFT_CHANNELS,
    ip_fft::type FFT_DATA_FORMAT
    >
  INLINE void fft_core(
		       hls::x_complex<FFT_INPUT_T> xn[FFT_CHANNELS][FFT_LENGTH],
		       hls::x_complex<FFT_OUTPUT_T> xk[FFT_CHANNELS][FFT_LENGTH],
		       ip_fft::status_t<CONFIG_T>* status,
		       ip_fft::config_t<CONFIG_T>* config_ch)
  {
#ifdef AESL_SYN

    //////////////////////////////////////////////
    // C level synthesis models for hls::fft
    //////////////////////////////////////////////
#pragma HLS inline

    _ssdm_op_SpecKeepValue(
			   //"component_name", "xfft_0",
			   "channels", FFT_CHANNELS,
			   "transform_length", 1 << CONFIG_T::max_nfft,
			   "implementation_options", CONFIG_T::arch_opt-1,
			   "run_time_configurable_transform_length", CONFIG_T::has_nfft,
			   "data_format", ip_fft::fft_data_format_str[FFT_DATA_FORMAT],
			   "input_width", FFT_INPUT_WIDTH,
			   "output_width", FFT_OUTPUT_WIDTH,
			   "phase_factor_width", CONFIG_T::phase_factor_width,
			   "scaling_options", CONFIG_T::scaling_opt,
			   "rounding_modes", CONFIG_T::rounding_opt,
			   "aclken", "true",
			   "aresetn", "true",
			   "ovflo", CONFIG_T::ovflo,
			   "xk_index", CONFIG_T::xk_index,
			   "throttle_scheme", "nonrealtime",
			   "output_ordering", CONFIG_T::ordering_opt,
			   "cyclic_prefix_insertion", CONFIG_T::cyclic_prefix_insertion,
			   "memory_options_data", CONFIG_T::mem_data,
			   "memory_options_phase_factors", CONFIG_T::mem_phase_factors,
			   "memory_options_reorder", CONFIG_T::mem_reorder,
			   "number_of_stages_using_block_ram_for_data_and_phase_factors", CONFIG_T::stages_block_ram,
			   "memory_options_hybrid", CONFIG_T::mem_hybrid,
			   "complex_mult_type", CONFIG_T::complex_mult_type,
			   "butterfly_type", CONFIG_T::butterfly_type
			   );


    bool has_scaling_sch =  config_ch->getSch();
    bool has_direction = config_ch->getDir();

    if ( has_direction || has_scaling_sch )
      for (int i = 0; i < FFT_LENGTH; ++i)
        {
	  for (int c = 0; c < FFT_CHANNELS; ++c)
            {
#pragma HLS unroll complete
	      xk[c][i] = xn[c][i];
            }
        }

    status->data = config_ch->getDir();

#else

    //////////////////////////////////////////////
    // C level simulation models for hls::fft
    //////////////////////////////////////////////

    // Declare the C model IO structures
    xilinx_ip_xfft_v9_1_generics  generics;
    xilinx_ip_xfft_v9_1_state    *state;
    xilinx_ip_xfft_v9_1_inputs    inputs;
    xilinx_ip_xfft_v9_1_outputs   outputs;

    // Log2 of FFT length
    int fft_length = FFT_LENGTH;
    int NFFT = 0;
    if (CONFIG_T::has_nfft)
      NFFT = config_ch->getNfft();
    else
      NFFT = CONFIG_T::max_nfft;

    const int samples =  1 << NFFT;

    ///////////// IP parameters legality checking /////////////

    // Check CONFIG_T::config_width
    config_ch->checkBitWidth(FFT_DATA_FORMAT);

    // Check CONFIG_T::status_width
    status->checkBitWidth();

    // Check ip parameters
    if (CONFIG_T::channels < 1 || CONFIG_T::channels > 12)
      {
        std::cerr << ip_fft::fftErrChkHead << "Channels = " << (int)CONFIG_T::channels
                  << " is illegal. It should be from 1 to 12."
                  << std::endl;
        exit(1);
      }

    if (CONFIG_T::max_nfft < 3 || CONFIG_T::max_nfft > 16)
      {
        std::cerr << ip_fft::fftErrChkHead << "NFFT_MAX = " << (int)CONFIG_T::max_nfft 
                  << " is illegal. It should be from 3 to 16."
                  << std::endl;
        exit(1);
      }

    unsigned length = FFT_LENGTH;
    if (!CONFIG_T::has_nfft)
      {
        if (FFT_LENGTH != (1 << CONFIG_T::max_nfft))
	  {
            std::cerr << ip_fft::fftErrChkHead << "FFT_LENGTH = " << (int)FFT_LENGTH
                      << " is illegal. Log2(FFT_LENGTH) should equal to NFFT_MAX when run-time configurable length is disabled."
                      << std::endl;
            exit(1);
	  }
      }
    else if (length & (length - 1))
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_LENGTH = " << (int)FFT_LENGTH
                  << " is illegal. It should be the integer power of 2."
                  << std::endl;
        exit(1);
      }
    else if (NFFT < 3 || NFFT > 16)
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_LENGTH = " << (int)FFT_LENGTH
                  << " is illegal. Log2(FFT_LENGTH) should be from 3 to 16."
                  << std::endl;
        exit(1);
      }
    else if (NFFT > CONFIG_T::max_nfft)
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_LENGTH = " << (int)FFT_LENGTH
                  << " is illegal. Log2(FFT_LENGTH) should be less than or equal to NFFT_MAX."
                  << std::endl;
        exit(1);
      } 
#if 0
    else if (NFFT != config_ch->getNfft())
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_LENGTH = " << (int)FFT_LENGTH
                  << " is illegal. Log2(FFT_LENGTH) should equal to NFFT field of configure channel."
                  << std::endl;
        exit(1);
      }
#endif

    if ((FFT_INPUT_WIDTH < 8) || (FFT_INPUT_WIDTH > 40))
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_INPUT_WIDTH = " << (int)FFT_INPUT_WIDTH
                  << " is illegal. It should be 8,16,24,32,40."
                  << std::endl;
        exit(1);
      }

    if (CONFIG_T::scaling_opt == ip_fft::unscaled && FFT_DATA_FORMAT != ip_fft::floating_point)
      {
        unsigned golden = FFT_INPUT_WIDTH + CONFIG_T::max_nfft + 1;
        golden = ((golden + 7) >> 3) << 3;
        if (FFT_OUTPUT_WIDTH != golden)
	  {
            std::cerr << ip_fft::fftErrChkHead << "FFT_OUTPUT_WIDTH = " << (int)FFT_OUTPUT_WIDTH
                      << " is illegal with unscaled arithmetic. It should be input_width+nfft_max+1."
                      << std::endl;
            exit(1);
	  }
      }
    else if (FFT_OUTPUT_WIDTH != FFT_INPUT_WIDTH)
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_OUTPUT_WIDTH = " << (int)FFT_OUTPUT_WIDTH
                  << " is illegal. It should be the same as input_width."
                  << std::endl;
        exit(1);
      }

    if (CONFIG_T::channels > 1 && CONFIG_T::arch_opt == ip_fft::pipelined_streaming_io)
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_CHANNELS = " << (int)CONFIG_T::channels << " and FFT_ARCH = pipelined_streaming_io"
                  << " is illegal. pipelined_streaming_io architecture is not supported when channels is bigger than 1."
                  << std::endl;
        exit(1);
      }

    if (CONFIG_T::channels > 1 && FFT_DATA_FORMAT == ip_fft::floating_point)
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_CHANNELS = " << (int)CONFIG_T::channels
                  << " is illegal with floating point data format. Floating point data format only supports 1 channel."
                  << std::endl;
        exit(1);
      }

    if (FFT_DATA_FORMAT == ip_fft::floating_point)
      {
        if (CONFIG_T::phase_factor_width != 24 && CONFIG_T::phase_factor_width != 25)
	  {
            std::cerr << ip_fft::fftErrChkHead << "FFT_PHASE_FACTOR_WIDTH = " << (int)CONFIG_T::phase_factor_width
                      << " is illegal with floating point data format. It should be 24 or 25."
                      << std::endl;
            exit(1);
	  }
      } 
    else if (CONFIG_T::phase_factor_width < 8 || CONFIG_T::phase_factor_width > 34)
      {
        std::cerr << ip_fft::fftErrChkHead << "FFT_PHASE_FACTOR_WIDTH = " << (int)CONFIG_T::phase_factor_width
                  << " is illegal. It should be from 8 to 34."
                  << std::endl;
        exit(1);
      }

    //////////////////////////////////////////////////////////

    // Build up the C model generics structure
    generics.C_NFFT_MAX      = CONFIG_T::max_nfft;
    generics.C_ARCH          = CONFIG_T::arch_opt;
    generics.C_HAS_NFFT      = CONFIG_T::has_nfft;
    generics.C_INPUT_WIDTH   = FFT_INPUT_WIDTH;
    generics.C_TWIDDLE_WIDTH = CONFIG_T::phase_factor_width;
    generics.C_HAS_SCALING   = CONFIG_T::scaling_opt == ip_fft::unscaled ? 0 : 1; 
    generics.C_HAS_BFP       = CONFIG_T::scaling_opt == ip_fft::block_floating_point ? 1 : 0;
    generics.C_HAS_ROUNDING  = CONFIG_T::rounding_opt;
    generics.C_USE_FLT_PT    = FFT_DATA_FORMAT == ip_fft::floating_point ? 1 : 0;

    // Create an FFT state object
    state = xilinx_ip_xfft_v9_1_create_state(generics);

    int stages = 0;
    if ((generics.C_ARCH == 2) || (generics.C_ARCH == 4))  // radix-2
      stages = NFFT;
    else  // radix-4 or radix-22
      stages = (NFFT+1)/2;

    double* xn_re       = (double*) malloc(samples * sizeof(double));
    double* xn_im       = (double*) malloc(samples * sizeof(double));
    int*    scaling_sch = (int*)    malloc(stages  * sizeof(int));
    double* xk_re       = (double*) malloc(samples * sizeof(double));
    double* xk_im       = (double*) malloc(samples * sizeof(double));

    // Check the memory was allocated successfully for all arrays
    if (xn_re == NULL || xn_im == NULL || scaling_sch == NULL || xk_re == NULL || xk_im == NULL)
      {
	std::cerr << "Couldn't allocate memory for input and output data arrays - dying" << std::endl;
	exit(3);
      }

    ap_uint<CONFIG_T::status_width> overflow = 0;
    ap_uint<CONFIG_T::status_width> blkexp = 0;
    for (int c = 0; c < FFT_CHANNELS; ++c)
      {
        // Set pointers in input and output structures
        inputs.xn_re       = xn_re;
        inputs.xn_im       = xn_im;
        inputs.scaling_sch = scaling_sch;
        outputs.xk_re      = xk_re;
        outputs.xk_im      = xk_im;

        // Store in inputs structure
        inputs.nfft = NFFT;
        // config data
        inputs.direction = config_ch->getDir(c);
        unsigned scaling = 0;
        if (CONFIG_T::scaling_opt == ip_fft::scaled) 
	  scaling = config_ch->getSch(c);
        for (int i = 0; i < stages; i++)
	  {
            inputs.scaling_sch[i] = scaling & 0x3;
            scaling >>= 2;
	  }
        inputs.scaling_sch_size = stages;
        for (int i = 0; i < samples ; i++)
	  {
            hls::x_complex<FFT_INPUT_T> din = xn[c][i];
            inputs.xn_re[i] = (double)din.real();
            inputs.xn_im[i] = (double)din.imag();
#ifdef _HLSCLIB_DEBUG_
            std::cout << "xn[" << c "][" << i << ": xn_re = " << inputs .xn_re[i] << 
	      " xk_im = " <<  inputs.xn_im[i] << endl;
#endif
	  }
        inputs.xn_re_size = samples;
        inputs.xn_im_size = samples;

        // Set sizes of output structure arrays
        outputs.xk_re_size    = samples;
        outputs.xk_im_size    = samples;

        //#define DEBUG
#ifdef _HLSCLIB_DEBUG_
        ///////////////////////////////////////////////////////////////////////////////
        /// Debug
        std::cout << "About to call the C model with:" << std::endl;
        std::cout << "Generics:" << std::endl;
        std::cout << "  C_NFFT_MAX = "      << generics.C_NFFT_MAX << std::endl;
        std::cout << "  C_ARCH = "          << generics.C_ARCH << std::endl;
        std::cout << "  C_HAS_NFFT = "      << generics.C_HAS_NFFT << std::endl;
        std::cout << "  C_INPUT_WIDTH = "   << generics.C_INPUT_WIDTH << std::endl;
        std::cout << "  C_TWIDDLE_WIDTH = " << generics.C_TWIDDLE_WIDTH << std::endl;
        std::cout << "  C_HAS_SCALING = "   << generics.C_HAS_SCALING << std::endl;
        std::cout << "  C_HAS_BFP = "       << generics.C_HAS_BFP << std::endl;
        std::cout << "  C_HAS_ROUNDING = "  << generics.C_HAS_ROUNDING << std::endl;
        std::cout << "  C_USE_FLT_PT = "    << generics.C_USE_FLT_PT << std::endl;
        
        std::cout << "Inputs structure:" << std::endl;
        std::cout << "  nfft = " << inputs.nfft << std::endl;
        printf("  xn_re[0] = %e\n",inputs.xn_re[0]);
        std::cout << "  xn_re_size = " << inputs.xn_re_size << std::endl;
        printf("  xn_im[0] = %e\n",inputs.xn_im[0]);
        std::cout << "  xn_im_size = " << inputs.xn_im_size << std::endl;

        for (int i = stages - 1; i >= 0; --i)
	  std::cout << "  scaling_sch[" << i << "] = " << inputs.scaling_sch[i] << std::endl;

        std::cout << "  scaling_sch_size = " << inputs.scaling_sch_size << std::endl;
        std::cout << "  direction = " << inputs.direction << std::endl;
        
        std::cout << "Outputs structure:" << std::endl;
        std::cout << "  xk_re_size = " << outputs.xk_re_size << std::endl;
        std::cout << "  xk_im_size = " << outputs.xk_im_size << std::endl;
                
        // Run the C model to generate output data
        std::cout << "Running the C model..." << std::endl;
        ///////////////////////////////////////////////////////////////////////////////
#endif

        int result = 0;
        result = xilinx_ip_xfft_v9_1_bitacc_simulate(state, inputs, &outputs);
        if (result != 0)
	  {
	    std::cerr << "An error occurred when simulating the FFT core: return code " << result << std::endl;
	    exit(4);
	  }

        // Output data
        for (int i = 0; i < samples; i++)
	  {
            hls::x_complex<FFT_OUTPUT_T> dout;
            unsigned addr_reverse = 0;
            for (int k = 0; k < NFFT; ++k)
	      {
                addr_reverse <<= 1;
                addr_reverse |= (i >> k) & 0x1;
	      }
            unsigned addr = i;
            if (CONFIG_T::ordering_opt == ip_fft::bit_reversed_order)
	      addr = addr_reverse;
            dout = hls::x_complex<FFT_OUTPUT_T> (outputs.xk_re[addr], outputs.xk_im[addr]);
            xk[c][i] = dout;
#ifdef _HLSCLIB_DEBUG_
            cout << "xk[" << c "][" << i << ": xk_re = " << outputs.xk_re[addr] << 
	      " xk_im = " <<  outputs.xk_im[addr] << endl;
#endif
	  }
        
        // Status
        if (CONFIG_T::scaling_opt == ip_fft::block_floating_point)
	  blkexp.range(c*8+7, c*8) = outputs.blk_exp;
        else if (CONFIG_T::ovflo && (CONFIG_T::scaling_opt == ip_fft::scaled))
	  overflow.range(c, c) = outputs.overflow; 
      }

    // Status
    if (CONFIG_T::scaling_opt == ip_fft::block_floating_point)
      status->setBlkExp(blkexp);
    else if (CONFIG_T::ovflo && (CONFIG_T::scaling_opt == ip_fft::scaled))
      status->setOvflo(overflow);

    // Release memory used for input and output arrays
    free(xn_re);
    free(xn_im);
    free(scaling_sch);
    free(xk_re);
    free(xk_im);

    // Destroy FFT state to free up memory
    xilinx_ip_xfft_v9_1_destroy_state(state);
#endif

  } // End of fft_core


  template<
    typename CONFIG_T,
    char FFT_INPUT_WIDTH,
    char FFT_OUTPUT_WIDTH,
    typename FFT_INPUT_T,
    typename FFT_OUTPUT_T,
    int FFT_LENGTH,
    char FFT_CHANNELS,
    ip_fft::type FFT_DATA_FORMAT
    >
  INLINE void fft_core(
		       hls::x_complex<FFT_INPUT_T> xn[FFT_LENGTH],
		       hls::x_complex<FFT_OUTPUT_T> xk[FFT_LENGTH],
		       ip_fft::status_t<CONFIG_T>* status,
		       ip_fft::config_t<CONFIG_T>* config_ch)
  {
#ifdef AESL_SYN
#pragma HLS inline

    _ssdm_op_SpecKeepValue(
			   //"component_name", "xfft_0",
			   "channels", FFT_CHANNELS,
			   "transform_length", FFT_LENGTH,
			   "implementation_options", CONFIG_T::arch_opt-1,
			   "run_time_configurable_transform_length", CONFIG_T::has_nfft,
			   "data_format", ip_fft::fft_data_format_str[FFT_DATA_FORMAT],
			   "input_width", FFT_INPUT_WIDTH,
			   "output_width", FFT_OUTPUT_WIDTH,
			   "phase_factor_width", CONFIG_T::phase_factor_width,
			   "scaling_options", CONFIG_T::scaling_opt,
			   "rounding_modes", CONFIG_T::rounding_opt,
			   "aclken", "true",
			   "aresetn", "true",
			   "ovflo", CONFIG_T::ovflo,
			   "xk_index", CONFIG_T::xk_index,
			   "throttle_scheme", "nonrealtime",
			   "output_ordering", CONFIG_T::ordering_opt,
			   "cyclic_prefix_insertion", CONFIG_T::cyclic_prefix_insertion,
			   "memory_options_data", CONFIG_T::mem_data,
			   "memory_options_phase_factors", CONFIG_T::mem_phase_factors,
			   "memory_options_reorder", CONFIG_T::mem_reorder,
			   "number_of_stages_using_block_ram_for_data_and_phase_factors", CONFIG_T::stages_block_ram,
			   "memory_options_hybrid", CONFIG_T::mem_hybrid,
			   "complex_mult_type", CONFIG_T::complex_mult_type,
			   "butterfly_type", CONFIG_T::butterfly_type
			   );


    bool has_scaling_sch =  config_ch->getSch();
    bool has_direction = config_ch->getDir();

    if ( has_direction || has_scaling_sch )
      for (int i = 0; i < FFT_LENGTH; ++i)
        {
	  xk[i] = xn[i]; 
        }

    status->data = config_ch->getDir();

#else
    hls::x_complex<FFT_INPUT_T> xn_multi_chan [1][FFT_LENGTH];
    hls::x_complex<FFT_OUTPUT_T> xk_multi_chan [1][FFT_LENGTH];

    for(int i=0; i< FFT_LENGTH; i++)
      xn_multi_chan[0][i] = xn[i];

    fft_core<
      CONFIG_T,
      FFT_INPUT_WIDTH,
      FFT_OUTPUT_WIDTH,
      FFT_INPUT_T,
      FFT_OUTPUT_T,
      FFT_LENGTH,
      1,
      FFT_DATA_FORMAT
      >(xn_multi_chan, xk_multi_chan, status, config_ch);       

    for(int i=0; i< FFT_LENGTH; i++)
      xk[i] = xk_multi_chan[0][i];
#endif
  }

  // 1-channel, fixed-point
  template<
    typename CONFIG_T
    >
  void fft(
	   complex<ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1> > xn[1 << CONFIG_T::max_nfft],
	   complex<ap_fixed<((CONFIG_T::output_width+7)/8)*8, ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1> > xk[1 << CONFIG_T::max_nfft],
	   ip_fft::status_t<CONFIG_T>* status,
	   ip_fft::config_t<CONFIG_T>* config_ch)
  {
#pragma HLS inline off 
#pragma HLS resource core="Vivado_FFT" variable=return metadata="parameterizable"
    //#pragma HLS function instantiate variable=core_params
#pragma HLS interface ap_fifo port=config_ch
#pragma HLS interface ap_fifo port=status
#pragma HLS interface ap_fifo port=xn
#pragma HLS interface ap_fifo port=xk

#pragma HLS data_pack variable=xn
#pragma HLS data_pack variable=xk

    fft_core<
      CONFIG_T,
      CONFIG_T::input_width,
      CONFIG_T::output_width,
      ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1>,
      ap_fixed<((CONFIG_T::output_width+7)/8)*8, ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1>,
      1 << CONFIG_T::max_nfft,
      1,
      ip_fft::fixed_point
      >(xn, xk, status, config_ch);       

  } // End of 1-channel, fixed-point

  // Multi-channels, fixed-point
  template<
    typename CONFIG_T
    >
  void fft(
	   complex<ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1> > xn[CONFIG_T::channels][1 << CONFIG_T::max_nfft],
	   complex<ap_fixed<((CONFIG_T::output_width+7)/8)*8, 
	   ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1> > xk[CONFIG_T::channels][1 << CONFIG_T::max_nfft],
	   ip_fft::status_t<CONFIG_T>* status,
	   ip_fft::config_t<CONFIG_T>* config_ch)
  {
#pragma HLS inline off 
#pragma HLS resource core="Vivado_FFT" variable=return metadata="parameterizable"
    //#pragma HLS function instantiate variable=core_params
#pragma HLS interface ap_fifo port=config_ch
#pragma HLS interface ap_fifo port=status
#pragma HLS interface ap_fifo port=xn
#pragma HLS interface ap_fifo port=xk

#pragma HLS data_pack variable=xn
#pragma HLS data_pack variable=xk

    //#if (FFT_CHANNELS > 1)
#pragma HLS array_reshape dim=1 variable=xn
#pragma HLS array_reshape dim=1 variable=xk
    //#endif

    fft_core<
      CONFIG_T,
      CONFIG_T::input_width,
      CONFIG_T::output_width,
      ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1>,
      ap_fixed<((CONFIG_T::output_width+7)/8)*8, ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1>,
      1 << CONFIG_T::max_nfft,
      CONFIG_T::channels,
      ip_fft::fixed_point
      >(xn, xk, status, config_ch);       
  } // End of multi-channels, fixed-point

  // 1-channel, floating-point
  template<
    typename CONFIG_T
    >
  void fft(
	   complex<float> xn[1 << CONFIG_T::max_nfft],
	   complex<float> xk[1 << CONFIG_T::max_nfft],
	   ip_fft::status_t<CONFIG_T>* status,
	   ip_fft::config_t<CONFIG_T>* config_ch)
  {
#pragma HLS inline off 
#pragma HLS resource core="Vivado_FFT" variable=return metadata="parameterizable"
    //#pragma HLS function instantiate variable=core_params
#pragma HLS interface ap_fifo port=config_ch
#pragma HLS interface ap_fifo port=status
#pragma HLS interface ap_fifo port=xn
#pragma HLS interface ap_fifo port=xk
#pragma HLS data_pack variable=config_ch
#pragma HLS data_pack variable=xn
#pragma HLS data_pack variable=xk

    fft_core<
      CONFIG_T,
      32,
      32,
      float,
      float,
      1 << CONFIG_T::max_nfft,
      1,
      ip_fft::floating_point
      >(xn, xk, status, config_ch);       
  } // End of 1-channel, floating-point



  // 1-channel, fixed-point
  template<
    typename CONFIG_T
    >
  void fft(
	   hls::x_complex<ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1> > xn[1 << CONFIG_T::max_nfft],
	   hls::x_complex<ap_fixed<((CONFIG_T::output_width+7)/8)*8, ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1> > xk[1 << CONFIG_T::max_nfft],
	   ip_fft::status_t<CONFIG_T>* status,
	   ip_fft::config_t<CONFIG_T>* config_ch)
  {
#pragma HLS inline off 
#pragma HLS resource core="Vivado_FFT" variable=return metadata="parameterizable"
    //#pragma HLS function instantiate variable=core_params
#pragma HLS interface ap_fifo port=config_ch
#pragma HLS interface ap_fifo port=status
#pragma HLS interface ap_fifo port=xn
#pragma HLS interface ap_fifo port=xk

#pragma HLS data_pack variable=xn
#pragma HLS data_pack variable=xk

    fft_core<
      CONFIG_T,
      CONFIG_T::input_width,
      CONFIG_T::output_width,
      ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1>,
      ap_fixed<((CONFIG_T::output_width+7)/8)*8, ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1>,
      1 << CONFIG_T::max_nfft,
      1,
      ip_fft::fixed_point
      >(xn, xk, status, config_ch);       

  } // End of 1-channel, fixed-point

  // Multi-channels, fixed-point
  template<
    typename CONFIG_T
    >
  void fft(
	   hls::x_complex<ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1> > xn[CONFIG_T::channels][1 << CONFIG_T::max_nfft],
	   hls::x_complex<ap_fixed<((CONFIG_T::output_width+7)/8)*8, 
	   ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1> > xk[CONFIG_T::channels][1 << CONFIG_T::max_nfft],
	   ip_fft::status_t<CONFIG_T>* status,
	   ip_fft::config_t<CONFIG_T>* config_ch)
  {
#pragma HLS inline off 
#pragma HLS resource core="Vivado_FFT" variable=return metadata="parameterizable"
    //#pragma HLS function instantiate variable=core_params
#pragma HLS interface ap_fifo port=config_ch
#pragma HLS interface ap_fifo port=status
#pragma HLS interface ap_fifo port=xn
#pragma HLS interface ap_fifo port=xk

#pragma HLS data_pack variable=xn
#pragma HLS data_pack variable=xk

    //#if (FFT_CHANNELS > 1)
#pragma HLS array_reshape dim=1 variable=xn
#pragma HLS array_reshape dim=1 variable=xk
    //#endif

    fft_core<
      CONFIG_T,
      CONFIG_T::input_width,
      CONFIG_T::output_width,
      ap_fixed<((CONFIG_T::input_width+7)/8)*8, 1>,
      ap_fixed<((CONFIG_T::output_width+7)/8)*8, ((CONFIG_T::output_width+7)/8)*8-CONFIG_T::input_width+1>,
      1 << CONFIG_T::max_nfft,
      CONFIG_T::channels,
      ip_fft::fixed_point
      >(xn, xk, status, config_ch);       
  } // End of multi-channels, fixed-point

  // 1-channel, floating-point
  template<
    typename CONFIG_T
    >
  void fft(
	   hls::x_complex<float> xn[1 << CONFIG_T::max_nfft],
	   hls::x_complex<float> xk[1 << CONFIG_T::max_nfft],
	   ip_fft::status_t<CONFIG_T>* status,
	   ip_fft::config_t<CONFIG_T>* config_ch)
  {
#pragma HLS inline off 
#pragma HLS resource core="Vivado_FFT" variable=return metadata="parameterizable"
    //#pragma HLS function instantiate variable=core_params
#pragma HLS interface ap_fifo port=config_ch
#pragma HLS interface ap_fifo port=status
#pragma HLS interface ap_fifo port=xn
#pragma HLS interface ap_fifo port=xk
#pragma HLS data_pack variable=config_ch
#pragma HLS data_pack variable=xn
#pragma HLS data_pack variable=xk

    fft_core<
      CONFIG_T,
      32,
      32,
      float,
      float,
      1 << CONFIG_T::max_nfft,
      1,
      ip_fft::floating_point
      >(xn, xk, status, config_ch);       
  } // End of 1-channel, floating-point

} // namespace hls
#endif // __cplusplus
#endif // X_HLS_FFT_X_COMPLEX_H


