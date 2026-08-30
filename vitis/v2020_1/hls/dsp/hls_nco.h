/*****************************************************************************
 *
 *     Author: Xilinx, Inc.
 *
 *     This text contains proprietary, confidential information of
 *     Xilinx, Inc. , is distributed by under license from Xilinx,
 *     Inc., and may be used, copied and/or disclosed only pursuant to
 *     the terms of a valid license agreement with Xilinx, Inc.
 *
 *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
 *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
 *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
 *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
 *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
 *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
 *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
 *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
 *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
 *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
 *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
 *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *     FOR A PARTICULAR PURPOSE.
 *
 *     Xilinx products are not intended for use in life support appliances,
 *     devices, or systems. Use in such applications is expressly prohibited.
 *
 *     (c) Copyright 2014 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

#ifndef HLS_NCO_H
#define HLS_NCO_H

#include "ap_fixed.h"
#include "ap_int.h"
//#include <math.h>
#include "hls_math.h"
#include <hls_stream.h>
#include <complex>

namespace hls {

#if (defined(AccumWidth) ||       \
     defined(PhaseAngleWidth) ||  \
     defined(SuperSampleRate) ||  \
     defined(OutputWidth))
#error One or more of the template parameters used by this function is already defined and will cause a conflict
#endif

  // NCO output data structure
  // Note that this cannot be included within the NCO class as co-simulation will not succeed
  template<int SuperSampleRate, int OutputWidth> struct t_nco_output_data {
    std::complex< ap_int<OutputWidth> > outputValue[SuperSampleRate];
  };

  // Classes used to select implementation architectures for complex multiplier structures
  struct NcoDualOutputCmpyFiveMult {
    const static int Impl = 5;
  };
  struct NcoDualOutputCmpyFourMult {
    const static int Impl = 4;
  };

  struct NcoSingleOutputCmpyThreeMult {
    const static int Impl = 3;
  };
  struct NcoSingleOutputCmpyFourMult {
    const static int Impl = 4;
  };

  // ===================================================================================================================
  // NCO: Class definition
  // o Template Parameters:
  //  - AccumWidth              : The number of bits in the phase accumulator. This determines the precision of the frequencies which can be synthesized
  //  - PhaseAngleWidth         : The number of bits from the phase accumulator which are used to access the lookup of sin and cos values.
  //  - SuperSampleRate         : The number of output samples per clock cycle. Here, it means the number of output samples per call.
  //  - OutputWidth             : The number of bits in the output samples.
  //  - DualOutputCmpyImpl      : Select whether to implement dual-output complex multipliers with 5-multiplier (5 DSP48) or 4-multiplier (6 DSP48) architecture
  //                              using classes NcoDualOutputCmpyFiveMult or NcoDualOutputCmpyFourMult
  //  - SingleOutputCmpyImpl    : Select whether to implement single-output complex multipliers with 3-multiplier (3 DSP48) or 4-multiplier (4 DSP48) architecture
  //                              using classes NcoSingleOutputCmpyThreeMult or NcoSingleOutputCmpyFourMult
  //  - SingleOutputNegCmpyImpl : Select whether to implement single-output negated complex multipliers with 3-multiplier (3 DSP48) or 4-multiplier (4 DSP48) architecture
  //                              using classes NcoSingleOutputCmpyThreeMult or NcoSingleOutputCmpyFourMult
  template<
    int AccumWidth,
    int PhaseAngleWidth,
    int SuperSampleRate,
    int OutputWidth,
    class DualOutputCmpyImpl,
    class SingleOutputCmpyImpl,
    class SingleOutputNegCmpyImpl
    > class nco {

  public:

      nco(const ap_uint<AccumWidth> InitPinc,
          const ap_uint<AccumWidth> InitPoff) {

        #pragma HLS reset variable=startInterrupt
        #pragma HLS reset variable=phaseAcc

        check_params();

        create_lut(sinLut);

        phaseAcc = 0;
        pincReg = 0;
        newPinc = InitPinc;
        pincSample = InitPinc;
        poffSample = InitPoff;
        bigTick = 0;
        poffReg = InitPoff;
        startInterrupt = 1; //effectively kickstarting with an interrupt
      }; // end constructor

      ~nco(){
      }; // end destructor

      // ===================================================================================================================
      // NCO: Overloaded entry point function for super sample rate NCO
      // o Arguments
      //  - pinc       : Phase Increment. This is the amount by which the phase accumulator will count per sample. In terms of degrees this is pinc/2^AccumWidth * 360
      //  - poff       : Phase Offset. The units of phase offset are the same as for phase increment.
      //  - outputData : Complex output data
      void operator()(stream< ap_uint<AccumWidth> > &pinc,
                      stream< ap_uint<AccumWidth> > &poff,
                      stream< t_nco_output_data<SuperSampleRate, OutputWidth> > &outputData) {

        Function_nco_operator:;

        t_nco_output_data<SuperSampleRate, OutputWidth> outputSample;

        if (SuperSampleRate == 1) {
          if (!pinc.empty()) {
            pincSample = pinc.read();
          }
          if (!poff.empty()) {
            poffSample = poff.read();
          }
          nco_singlesample(pincSample, poffSample, outputSample);
          outputData << outputSample;
        } else {
          nco_ssr(pinc, poff, outputData);
        }
      } //end operator()

  private:

      // Template range limits
      // These define the 'solution space'
      static const int MIN_PHASE_WIDTH = 4;
      static const int MAX_PHASE_WIDTH = 16;
      static const int MIN_ACCUM_WIDTH = 4;
      static const int MAX_ACCUM_WIDTH = 48;
      static const int MIN_SUPER_SAMPLE_RATE = 1;
      static const int MAX_SUPER_SAMPLE_RATE = 16; //arbitrary limit
      static const int MAX_LOG_SUPER_SAMPLE_RATE = 4;
      static const int MIN_OUTPUT_WIDTH = 4;
      static const int MAX_OUTPUT_WIDTH = 32;
      static const int DSP48_B_WIDTH = 18;
      static const int DSP48_P_WIDTH = 48;
      static const int MY_PI = 102944; //to fit a DSP48 B port (pi *2^15)
      static const int MY_PI_SCALE = 15; //the power of 2 to which my_pi is magnified
      static const int INTERRUPT_PERIOD = (SuperSampleRate >>1)+1; // 1 to primeChannel for lobes, 0 for proxy/
      static const int TAYLOR_SHIFT = MY_PI_SCALE-1+PhaseAngleWidth;

      // Variables holding state
      ap_uint<AccumWidth> pincSample, poffSample;
      //newPinc is register used to capture changed PINC value
      //pincReg holds the previous value of PINC, which is still used during transition period (interrupt) to new PINC value
      //poffReg holds POFF value - has no implications for interrupt
      //bigTick is value primary DDS increments each sample (SuperSampleRate * PINC).
      ap_uint<AccumWidth> newPinc, pincReg, poffReg, bigTick;
      //bigTickTemp is intended to be the output of a DSP48 which calculates bigTick during changes of PINC.
      ap_uint<MAX_LOG_SUPER_SAMPLE_RATE> interruptTimer, lastTime; //countdown to new PINC being adopted.
      ap_uint<1> startInterrupt;
      ap_uint<AccumWidth> phaseAcc; //register holding state value of current phase.
      ap_int<OutputWidth> sinLut[1<<(PhaseAngleWidth-2)]; //The sin/cos lookup array/RAM. No cast necessary on '1' because array size will never exceed 2^31!
      //Phi is the angle between adjacent channels (i.e. PINC). It is not the difference in angle between samples from a channel. That will be SSR*PINC.
      //Phi[0] is the value for the proxy cmpy, 1 thru SSR/2 are symmetrical pair lobes and phi[primeChannel] is the outlier, if there is one.
      ap_int<OutputWidth> sinPhi[SuperSampleRate], cosPhi[SuperSampleRate]; //the phi values in use
      ap_int<OutputWidth> sinPhiPre[SuperSampleRate], cosPhiPre[SuperSampleRate];//shadow phi values to be switch in to phi in an instant.
      //sinDel and cosDel are delay lines which hold estimates of the future values of the primevector in case an interrupt should occur. These values are switched in to replace the prime vector during an interrupt.
      ap_int<OutputWidth> sinDel[INTERRUPT_PERIOD+2], cosDel[INTERRUPT_PERIOD+2];

      void check_params() {
        // Verify that template parameters are correct in simulation
        #ifndef __SYNTHESIS__
        if (AccumWidth < MIN_ACCUM_WIDTH || AccumWidth > MAX_ACCUM_WIDTH ) {
          std::cout << "ERROR: " << __FILE__ << ": AccumWidth is out of range " << MIN_PHASE_WIDTH << " to " << MAX_PHASE_WIDTH << std::endl;
          exit(1);
        }
        if (PhaseAngleWidth < MIN_PHASE_WIDTH || PhaseAngleWidth > MAX_PHASE_WIDTH ) {
          std::cout << "ERROR: " << __FILE__ << ": PhaseAngleWidth is out of range " << MIN_PHASE_WIDTH << " to " << MAX_PHASE_WIDTH << std::endl;
          exit(1);
        }
        if (SuperSampleRate < MIN_SUPER_SAMPLE_RATE || SuperSampleRate > MAX_SUPER_SAMPLE_RATE ) {
          std::cout << "ERROR: " << __FILE__ << ": SuperSampleRate is out of range " << MIN_SUPER_SAMPLE_RATE << " to " << MAX_SUPER_SAMPLE_RATE << std::endl;
          exit(1);
        }
        if (OutputWidth < MIN_OUTPUT_WIDTH || OutputWidth > MAX_OUTPUT_WIDTH ) {
          std::cout << "ERROR: " << __FILE__ << ": OutputWidth is out of range " << MIN_OUTPUT_WIDTH << " to " << MAX_OUTPUT_WIDTH << std::endl;
          exit(1);
        }
        if (PhaseAngleWidth > OutputWidth) {
          std::cout << "ERROR: " << __FILE__ << ": OutputWidth must be greater than or equal to PhaseAngleWidth" << std::endl;
          exit(1);
        }
        if (PhaseAngleWidth > AccumWidth) {
          std::cout << "ERROR: " << __FILE__ << ": AccumWidth must be greater than or equal to PhaseAngleWidth" << std::endl;
          exit(1);
        }
        if (PhaseAngleWidth < 10 && AccumWidth > PhaseAngleWidth) {
          std::cout << "ERROR: " << __FILE__ << ": A small PhaseAngleWidth combined with Taylor Correction (AccumWidth > PhaseAngleWidth) can lead to sin/cos overflow" << std::endl;
          exit(1);
        }
        #endif
      } //end check_params

      //Function to perform quarter wave based sin/cos lookup
      void quarter_table(ap_uint<PhaseAngleWidth> &phaseAngle,
                         ap_int<OutputWidth> &sinVal,
                         ap_int<OutputWidth> &cosVal) {
        Function_nco_quarter_table:;
        const int ANGLE_MASK = (1<<(PhaseAngleWidth-2))-1; //no need for cast as PAW always < 32
        ap_uint<2> quadrant;
        ap_uint<PhaseAngleWidth-2> sinAddr;
        ap_uint<PhaseAngleWidth-2> cosAddr;

        quadrant = phaseAngle >> (PhaseAngleWidth-2);
        if (quadrant == 0 || quadrant == 2) {
          sinAddr = phaseAngle & ANGLE_MASK;
          cosAddr = (phaseAngle & ANGLE_MASK)^ANGLE_MASK;
        } else {
          sinAddr = (phaseAngle & ANGLE_MASK)^ANGLE_MASK;
          cosAddr = phaseAngle & ANGLE_MASK;
        }
        if (quadrant == 0 || quadrant == 1) {
          sinVal = sinLut[sinAddr];
        } else {
          sinVal = -sinLut[sinAddr];
        }
        if (quadrant == 0 or quadrant == 3) {
          cosVal = sinLut[cosAddr];
        } else {
          cosVal = -sinLut[cosAddr];
        }
      } //end of quarter_table


      //function to multiply a complex vector by a second vector and the conjugate of the second, giving both complex results.
      void dual_op_cmpy(ap_int<OutputWidth> &a,
                        ap_int<OutputWidth> &b,
                        ap_int<OutputWidth> &c,
                        ap_int<OutputWidth> &d,
                        ap_int<OutputWidth> &posresreal,
                        ap_int<OutputWidth> &posresimag,
                        ap_int<OutputWidth> &negresreal,
                        ap_int<OutputWidth> &negresimag) {
        Function_nco_dual_op_cmpy:;
        ap_int<DSP48_P_WIDTH> common_factor,fullPosReal, fullPosImag, fullNegReal, fullNegImag;
        const ap_uint<DSP48_P_WIDTH> rounding_const = ((ap_uint<DSP48_P_WIDTH>)1<<(OutputWidth-2));
        #pragma HLS PIPELINE
        if (DualOutputCmpyImpl::Impl == 5) {
          common_factor = c*(a+b) + rounding_const;
          fullPosReal = common_factor - b*(c+d);// ac + bc - bc - bd = ac - bd
          fullPosImag = common_factor - a*(c-d);// ac + bc - ac + ad = bc + ad
          fullNegReal = common_factor - b*(c-d);// ac + bc - bc + bd = ac + bd
          fullNegImag = common_factor - a*(c+d);// ac + bc - ac - ad = bc - ad
          posresreal = fullPosReal >> (OutputWidth-1);
          posresimag = fullPosImag >> (OutputWidth-1);
          negresreal = fullNegReal >> (OutputWidth-1);
          negresimag = fullNegImag >> (OutputWidth-1);
        } else {
          // 4-multiplier, 6 DSP48
          ap_int<DSP48_P_WIDTH> fullPosReal, fullPosImag, fullNegReal, fullNegImag;
          const ap_uint<DSP48_P_WIDTH> rounding_const = ((ap_uint<DSP48_P_WIDTH>)1<<(OutputWidth-2));
          fullPosReal =a*c - b*d + rounding_const;
          fullPosImag =a*d + b*c + rounding_const;
          fullNegReal =a*c + b*d + rounding_const;
          fullNegImag =b*c - a*d + rounding_const;
          posresreal = (fullPosReal ) >> (OutputWidth-1);
          posresimag = (fullPosImag ) >> (OutputWidth-1);
          negresreal = (fullNegReal ) >> (OutputWidth-1);
          negresimag = (fullNegImag ) >> (OutputWidth-1);
        }
      } //end of dual_op_cmpy

      void single_op_cmpy(ap_int<OutputWidth> &a,
                          ap_int<OutputWidth> &b,
                          ap_int<OutputWidth> &c,
                          ap_int<OutputWidth> &d,
                          ap_int<OutputWidth> &resreal,
                          ap_int<OutputWidth> &resimag) {
        Function_nco_single_op_cmpy:;
        ap_int<DSP48_P_WIDTH> common_factor,fullReal, fullImag;
        const ap_uint<DSP48_P_WIDTH> rounding_const = ((ap_uint<DSP48_P_WIDTH>)1<<(OutputWidth-2));

        if (SingleOutputCmpyImpl::Impl == 3) {
          common_factor = a*(c+d)+rounding_const;
          fullReal = common_factor - d*(a+b);// ac+ad-ad-bd=      ac-bd
          fullImag = common_factor + c*(b-a);
        } else {
          // 4-multiplier
          fullReal = a*c - b*d + rounding_const;
          fullImag = a*d + b*c + rounding_const;
        }
        resreal = fullReal >> (OutputWidth-1);
        resimag = fullImag >> (OutputWidth-1);
      } //end of single_op_cmpy

      void single_op_neg_cmpy(ap_int<OutputWidth> &a,
                              ap_int<OutputWidth> &b,
                              ap_int<OutputWidth> &c,
                              ap_int<OutputWidth> &d,
                              ap_int<OutputWidth> &resreal,
                              ap_int<OutputWidth> &resimag) {
        Function_nco_single_op_neg_cmpy:;
        ap_int<DSP48_P_WIDTH> common_factor,fullReal, fullImag;
        const ap_uint<DSP48_P_WIDTH> rounding_const = ((ap_uint<DSP48_P_WIDTH>)1<<(OutputWidth-2));

        if (SingleOutputNegCmpyImpl::Impl == 3) {
          common_factor = c*(a+b) + rounding_const;
          fullReal = common_factor - b*(c-d);
          fullImag = common_factor - a*(c+d);
        } else {
          // 4-multiplier
          fullReal = a*c + b*d + rounding_const;
          fullImag = b*c - a*d + rounding_const;
        }
        resreal = fullReal >> (OutputWidth-1);
        resimag = fullImag >> (OutputWidth-1);
      } //end of single_op_neg_cmpy

      void accum_phase(ap_uint<AccumWidth> &pinc,
                       ap_uint<AccumWidth> &poff,
                       ap_uint<AccumWidth> &phaseOutput) {
        Function_nco_accum_phase:;
        phaseAcc += pinc;
        phaseOutput = phaseAcc + poff;

      } // end of accum_phase

      void sin_cos_lookup(ap_uint<AccumWidth> &phaseOutput,
                          ap_int<OutputWidth> &sinVal,
                          ap_int<OutputWidth> &cosVal) {
        Function_nco_sin_cos_lookup:;
        ap_uint<PhaseAngleWidth> phaseAngle = phaseOutput >> (AccumWidth-PhaseAngleWidth);
        ap_int<DSP48_B_WIDTH> delta;
        ap_int<DSP48_B_WIDTH> deltak;
        ap_int<DSP48_P_WIDTH> offsetC, offsetS;
        ap_uint<PhaseAngleWidth-2> mask;
        ap_int<OutputWidth> coarseSinVal;
        ap_int<OutputWidth> coarseCosVal;
        ap_int<DSP48_P_WIDTH> precC, precS, shiftCoarseSin,shiftCoarseCos;
        const int ERR_BUS_WIDTH = AccumWidth > PhaseAngleWidth ? AccumWidth - PhaseAngleWidth : 1;

        quarter_table(phaseAngle, coarseSinVal, coarseCosVal);

        if (AccumWidth > PhaseAngleWidth) {//use Taylor correction
          if (ERR_BUS_WIDTH <= DSP48_B_WIDTH) {
            //Fit delta with MS bits of truncated splice

            delta = ((phaseOutput) & (((ap_uint<ERR_BUS_WIDTH>)1 << (ERR_BUS_WIDTH)) -1));
            delta = delta  << (DSP48_B_WIDTH - (ERR_BUS_WIDTH));
          } else {
            delta = (phaseOutput >> (ERR_BUS_WIDTH - DSP48_B_WIDTH)) & ((1<<(DSP48_B_WIDTH))-1);
          }
          delta = delta ^ (1 << (DSP48_B_WIDTH-1)); //invert top bit
          shiftCoarseCos = ((ap_int<DSP48_P_WIDTH>)coarseCosVal << TAYLOR_SHIFT);
          shiftCoarseSin = ((ap_int<DSP48_P_WIDTH>)coarseSinVal << TAYLOR_SHIFT);
          deltak = ((ap_int<DSP48_P_WIDTH>)delta * (ap_int<DSP48_P_WIDTH>)MY_PI) >> (DSP48_B_WIDTH);
          precC = shiftCoarseCos - deltak * coarseSinVal; //offsetC;
          precS = shiftCoarseSin + deltak * coarseCosVal; //offsetS;
          cosVal = precC >> TAYLOR_SHIFT;
          sinVal = precS >> TAYLOR_SHIFT;
        } else {
          // i.e. if not (AccumWidth > PhaseAngleWidth)
          cosVal = coarseCosVal;
          sinVal = coarseSinVal;
        } // end of if (AccumWidth > PhaseAngleWidth)
      } // end of sin_cos_lookup

      void create_lobes(ap_int<OutputWidth> &a,
                        ap_int<OutputWidth> &b,
                        t_nco_output_data<SuperSampleRate, OutputWidth> &outputSample) {
        Function_nco_create_lobes:;
        int lobe; //loop counter for side-lobes.
        ap_int<OutputWidth> c, d; //real and imag for prime, phi and results from dual output cmpy
        const int PRIME_CHANNEL = (SuperSampleRate >> 1);
        ap_int<OutputWidth> sinSample[SuperSampleRate], cosSample[SuperSampleRate];

        if (PRIME_CHANNEL > 1) {
          nco_ssr_label1 : for (lobe = 1; lobe < PRIME_CHANNEL; lobe ++) {
            c = cosPhi[lobe];
            d = sinPhi[lobe];
            dual_op_cmpy(a, b, //prime vector
                         c, d, //phi
                         cosSample[PRIME_CHANNEL+lobe], sinSample[PRIME_CHANNEL+lobe], //positively rotated result
                         cosSample[PRIME_CHANNEL-lobe], sinSample[PRIME_CHANNEL-lobe]); //negatively rotated result
            //complex multiplication grows bit width by 2* +1, but the binary point is the thing to follow here. For +0.XXXX * -0.XXXX the result is -000.XXXXXXXX
          }
        }
        if (SuperSampleRate % 2 == 0) {
          //if even , there will be an outlier lobe
          c = cosPhi[PRIME_CHANNEL];
          d = sinPhi[PRIME_CHANNEL];
          single_op_neg_cmpy(a, b, //prime vector
                             c, d, //phi
                             cosSample[0],sinSample[0]); //negatively rotated result
        } else {
          c = cosPhi[PRIME_CHANNEL];
          d = sinPhi[PRIME_CHANNEL];
          dual_op_cmpy(a, b, //prime vector
                       c, d, //phi
                       cosSample[PRIME_CHANNEL<<1], sinSample[PRIME_CHANNEL<<1], //positively rotated result
                       cosSample[0], sinSample[0]); //negatively rotated result
        }
        //Now bring the primary signal down a notch.
        //Why? Well, it isn't a unit vector, and it's been used to multiply all the others,
        //so it is a tad bigger than them and needs to be shaved.
        c = (((ap_uint<OutputWidth+1>)1<<(OutputWidth-1))-2);
        d = 0;
        single_op_cmpy(a, b, //prime vector
                       c, d, //phi
                       cosSample[PRIME_CHANNEL],sinSample[PRIME_CHANNEL]); //negatively rotated result
        nco_ssr_label2:for (int x = 0; x < SuperSampleRate; x++) {
          outputSample.outputValue[x].real(cosSample[x]);
          outputSample.outputValue[x].imag(sinSample[x]);
        }
      } // end of create_lobes

      //Function to choose whether the prime vector is to be taken from the sin/cos
      //output or from the proxy. Includes the code for the proxy itself.
      void get_prime(ap_int<OutputWidth> &sinPrime,
                        ap_int<OutputWidth> &cosPrime,
                        ap_int<OutputWidth> &sinTick,
                        ap_int<OutputWidth> &cosTick,
                        ap_uint<MAX_LOG_SUPER_SAMPLE_RATE>  &interruptTimer,
                        ap_int<OutputWidth> &a,
                        ap_int<OutputWidth> &b) {
        Function_nco_get_prime:;
        ap_int<OutputWidth*2+1> realResult, imagResult;

        delay_line_loop : for (int k = INTERRUPT_PERIOD+1; k > 0; k--) {
          cosDel[k] = cosDel[k-1];
          sinDel[k] = sinDel[k-1];
        }
        single_op_cmpy(cosPrime, sinPrime, //prime vector
                       cosTick, sinTick, //phi
                       cosDel[0],sinDel[0]);

        if (interruptTimer == 0) { // normal operation
          a = cosPrime;
          b = sinPrime;
        } else {
          a = cosDel[INTERRUPT_PERIOD];
          b = sinDel[INTERRUPT_PERIOD];
        } //end of if interruptTimer == 0
      } //end of get_prime

      //Function to create SIN values for table using a very small, very accurate starting angle, then
      //rotating this by complex multiplication. This avoids any compiler/library/language-specific values from sin().
      void create_lut(ap_int<OutputWidth> *rom_table) {
        Function_nco_create_lut:;
        const int ci_sin_address_width = 17;  // Starting angle size for sin-cos table construction

        const int p_addr_width = PhaseAngleWidth-2; //-2 because of quarter table required
        const int p_scaling_width = OutputWidth-2;
        enum {e_quarter, e_half, e_full, e_double};
        const int p_range = e_quarter;
        const int p_phase_offset_req = 1; //require 0.5 address offset in ram? 1 = yes.
        const int c_eff_bias = (AccumWidth > PhaseAngleWidth) ? 1:0;//get_eff_bias(configuration->resNoise_Shaping, configuration->resOutput_Width);
        const int p_eff_bias = c_eff_bias;

        const double delta = 4.7936899621426287e-5; //2.0*MATH_PI*2.0**(-CI_SIN_ADDRESS_WIDTH);
        double alpha = 1.1489731724373268e-9; //2.0*sin(delta/2.0)**2;
        double beta  = 4.7936899603068881e-5; //sin(delta);
        double sinda_1 = 0.0, cosda_1 = 0.0, sinda = 0.0, cosda = 0.0, sinda_2 = 0.0, cosda_2 = 0.0, beta_2 = 0.0, alpha_2 = 0.0, sin_r = 0.0, sin_s_r = 0.0, sin_m_r;
        double offset = 0;
        double beta_1  = beta;
        double alpha_1 = alpha;
        const int b = 0;  //b is the number of bits by which the RAM table exceeds one quadrant i.e. there are 2^B quadrants to fill.
        int idx_off = 0, start = 0;
        double sin_x = 0.0;
        double x1 = 0.0, x2 = 0.0, x3 = 0.0;

        // generate sin(delta) and cos(delta)
        sinda_1 = beta;
        cosda_1 = 1.0-alpha;

        // Grow rotation in powers of 2. Stop when we have half of table increments. This is because the raw alpha, beta and delta above
        // are for 2^17 addresses. For most cases we need fewer addresses, so larger alphas and betas are now calculated.

        alpha_beta_loop : for (int j = 1; j <=(ci_sin_address_width-p_addr_width-3+b); j++) {
          sinda   = sinda_1;
          cosda   = cosda_1;

          sinda_1 = sinda -alpha*sinda+beta*cosda;
          cosda_1 = cosda -alpha*cosda-beta*sinda;

          // keep beta and alpha for D/2
          beta_1  = sinda_1;
          alpha_1 = 2.0*sinda*sinda;

          beta    = sinda_1;
          alpha   = 2.0*sinda*sinda;
        }

        // Double angle to that we have an angle that takes
        // us from one table entry to the next (table phase increment)
        sinda_2   = sinda_1 -alpha_1*sinda_1+beta_1*cosda_1;
        cosda_2   = cosda_1 -alpha_1*cosda_1-beta_1*sinda_1;

        beta_2    = sinda_2;
        alpha_2   = 2.0*sinda_1*sinda_1;

        if (p_phase_offset_req) {
          // Start with half angle (of 0.5 ULP of phase)
          sinda   = sinda_1;
          cosda   = cosda_1;
          offset  = 0.5;
          idx_off = 1;
        } else {
          sinda   = 0.0;
          cosda   = 1.0;
          offset  = 0.0;
          idx_off = 0;
        }

        // we need a couple of extra iterations to prime the loop for taylor
        // For Taylor the raw values are modified such that when interpolation takes
        //place the error is biased around zero rather than always positive as would occur with
        //unmodified values.
        if (p_eff_bias == 1) {
          start = -1;
        } else {
          start = 0;
        }

        p_add_width_loop : for (int i = start; i < (1<<p_addr_width); i++) {
          if (i <= (1<<(p_addr_width-b)) - idx_off) {
            // in the first quadrant we calculate values from the recurrence equation
            // elsewhere we use these values. In this way a value is only calculated
            // one way, and it is the same way whether it is a quarter, half, full or
            // double table

            // For reference purposes, this is what we expect the sine to be
            // sinda = sin(2.0*MATH_PI*(real(i)+offset)*2.0**(-p_addr_width));

            //For NCO, keep quarter table, but also keep sign (simpler - not most efficient)
            //if (p_range==e_quarter) { //e_quarter
            //  // don't need to keep sign
            //  sin_x = 2.0*sinda;
            //} else {
            sin_x = sinda;
            //}

            //This whole function is taken from more parameterized code elsewhere.
            //While not every parameter is supported here, they may be in a future release
            //so the code holds some placeholder code for that eventuality.
            if (true) {//radio mode - where the amplitude of the output is just less than 2^N
              // create an integer by scaling (include 1-2^W to avoid 1)
              sin_r = sin_x*(1.0-1.0/(double)(1<<p_scaling_width));
            } else { //mathematical mode - exact unit circle amplitude
              sin_r = sin_x*0.5;
            }

            if (p_eff_bias) {
              // calculate a better point using values either side
              if (i==-1) {     // prime calculation
                x2 = -sin_r;  // we are assuming an offset sinewave
                x3 = sin_r;
              } else {
                x1 = x2;
                x2 = x3;
                x3 = sin_r;
                sin_r  = (x1 + 14.0*x2 + x3)/16.0;
              }
            }

            if (i >= 0) {
              double sin_s_r = hls::floor(sin_r * (double)(1<<(OutputWidth-1))+0.5);
              rom_table[i] = (ap_int<OutputWidth>)sin_s_r;
            }

            // Rotate by table phase increment
            sinda_1 = sinda-alpha_2*sinda+beta_2*cosda;
            cosda   = cosda-alpha_2*cosda-beta_2*sinda;
            sinda   = sinda_1;

          } else if (i < (1<<(p_addr_width+1-b))) {
            // second quadrant, so just flip first quadrant
            rom_table[i] = rom_table[((1<<(p_addr_width+1-b))) -i- idx_off];
          } else if (i < ((1<<(p_addr_width-b))*3)) {
            // Third quadrant
            // Is first but negated
            rom_table[i] = -(rom_table[i-(1<<(p_addr_width+1-b))]);
          } else if (i < ((1<<(p_addr_width+2-b)))) {
            // Fourth quadrant.
            // Is first but fipped and negated
            rom_table[i] = -(rom_table[(1<<(p_addr_width+2-b))-i-idx_off]);
          }
        }
      }

      // Simple sample variant
      void nco_singlesample(ap_uint<AccumWidth> &pinc,
                            ap_uint<AccumWidth> &poff,
                            t_nco_output_data<SuperSampleRate, OutputWidth> &outputSample) {
        Function_nco_singlesample:;
        ap_uint<AccumWidth> phaseOutput;
        ap_int<OutputWidth> sinSample, cosSample;

        accum_phase(pinc, poff, phaseOutput);
        sin_cos_lookup(phaseOutput, sinSample, cosSample);
        outputSample.outputValue[0].real(cosSample);
        outputSample.outputValue[0].imag(sinSample);
      } //end of nco_singlesample()


      //Super-sample rate variant. Streams are used because a write to PINC must be detected.
      void nco_ssr(stream< ap_uint<AccumWidth> > &pinc,
                   stream< ap_uint<AccumWidth> > &poff,
                   stream< t_nco_output_data<SuperSampleRate, OutputWidth> > &outputData) {
        Function_nco_ssr:;

        const int hybridFactor1 = (SuperSampleRate - ((SuperSampleRate >> 1)+1));
        const int hybridFactor2 = ((SuperSampleRate >> 1)+1);

        const int primeChannel = (SuperSampleRate >> 1);
        ap_uint<AccumWidth> lobeAngle, phaseOutput, sincosInput;
        ap_int<OutputWidth> a, b; //real and imag for prime, phi and results from dual output cmpy
        t_nco_output_data<SuperSampleRate, OutputWidth> outputSample;
        ap_int<OutputWidth> sinOp, cosOp; //the values output by the sin/cos LUT
        ap_int<OutputWidth> sinNorm, cosNorm; //the values of a single channel.

        //A change to poff does not force a recalculation of the lobe angles, since they are
        //derived from the primary output.
        if (!poff.empty()) {
          poffReg = poff.read();
        }

        lastTime = interruptTimer;
        if (!pinc.empty() ) {
          newPinc = pinc.read();
          startInterrupt = 1;
        }
        if (startInterrupt == 1) {
          interruptTimer = INTERRUPT_PERIOD;
          //Because PINC has changed, all the phi angles must be recalculated. They
          //use the sin/cos table to do this, so the sin/cos table isn't available
          //for normal output.
          startInterrupt = 0;
        } else if (interruptTimer != 0) {
          interruptTimer--;
        }//end of if PINC has changed.

        ap_uint<AccumWidth+1> x, y, z;
        if (lastTime == 1) { //switch over to new values
          //at the end of the interrupt period, PINC is set to a hybrid value of old and new
          //PINC values to avoid a phase discontinuity.
          bigTick = pincReg * hybridFactor1 + newPinc * hybridFactor2;
        } else {
          // Set up MADD values
          x = pincReg;
          y = SuperSampleRate ;
          z = 0;
          bigTick = x * y + z;
        }

        //keep on ticking, regardless of what sin/cos is being used for.
        //this keeps the phase accum in sync with the proxy to avoid discontinuities into
        //or out of the interrupt period
        accum_phase(bigTick, poffReg, phaseOutput);

        //Decide what the SIN/COS lookup table (sin_cos_lookup) is being used for.
        if (interruptTimer == 0 ) {
          sincosInput = phaseOutput;
        } else if (interruptTimer == INTERRUPT_PERIOD) {
          //First, read PINC * T * SuperSampleRate which is the phase rotation for the proxy cmpy
          sincosInput = newPinc * SuperSampleRate * INTERRUPT_PERIOD;
        } else {
          sincosInput = interruptTimer * newPinc;
        }
        sin_cos_lookup(sincosInput, sinOp, cosOp);
        sinNorm = sinOp; //always assign, but dont necessarily use.
        cosNorm = cosOp; //always assign, but dont necessarily use.

        // Ensure these variables are implemented as registers, not memory, to achieve II=1 when
        // the function is pipelined
        #pragma HLS ARRAY_PARTITION variable=sinPhiPre complete
        #pragma HLS ARRAY_PARTITION variable=cosPhiPre complete

        if (interruptTimer == 0) {
          pincReg = newPinc;
          for (int i = 0; i < INTERRUPT_PERIOD; i++){
            sinPhi[i] = sinPhiPre[i];
            cosPhi[i] = cosPhiPre[i];
          }
        } else {
          if (interruptTimer == INTERRUPT_PERIOD) {
            sinPhiPre[0] = sinOp;
            cosPhiPre[0] = cosOp;
          } else {
            sinPhiPre[interruptTimer] = sinOp;
            cosPhiPre[interruptTimer] = cosOp;
          }
        }

        //Decide whether to use the primary DDS output or the proxy cmpy
        get_prime(sinNorm, cosNorm,    //the primary DDS output
                     sinPhi[0],cosPhi[0], //the rotation step for the proxy
                     interruptTimer,
                     a, b); //the output vector to use.

        //create the multiple output vectors
        create_lobes(a, b, outputSample);
        outputData << outputSample;

      } // end of nco_ssr() - super-sample rate variant

  }; // end class nco

} //end namespace hls

#endif // HLS_NCO_H


