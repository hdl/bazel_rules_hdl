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

#ifndef HLS_CORDIC_H
#define HLS_CORDIC_H

#include "hls/dsp/utils/hls_cordic_functions.h"

namespace hls {

#if (defined(CordicFunction) ||                 \
     defined(CoarseRotate) ||                   \
     defined(DataFormat) ||                     \
     defined(PhaseFormat) ||                    \
     defined(InputWidth) ||                     \
     defined(OutputWidth) ||                    \
     defined(Iterations) ||                     \
     defined(Precision) ||                      \
     defined(RoundMode) ||                      \
     defined(ScaleComp))
#error One or more of the template parameters used by this function is already defined and will cause a conflict
#endif

  // ===================================================================================================================
  // CORDIC: Entry point function.
  // o Template parameters:
  //  - CordicFunction   : Selects the CORDIC function to implement
  //  - CoarseRotate     : When true, extends the input/output range from the first quadrant [-pi/4,+pi/4] to the full circle
  //  - DataFormat       : Selects between unsigned fraction (with integer width of 1 bit) and unsigned integer formats
  //  - PhaseFormat      : Selects whether the phase is expressed in radians or scaled radians (pi * 1 radian)
  //  - InputWidth       : Defines overall input data width
  //  - OutputWidth      : Defines overall output data width
  //  - Iterations       : Overrides automatic calculation of required number of iterations to meet precision requirements
  //  - Precision        : Overrides automatic calculation of internal precision requirements
  //  - RoundMode        : Selects the rounding mode to apply to the output data
  //  - ScaleComp        : Enables compensation of the CORDIC magnitude scale factor at the output, for rotation and translation only
  // o Arguments:
  //  - inputData        : Input with format dependent on CordicFunction.  See hls_cordic_functions.h for details
  //  - outputData       : Output with format dependent on CordicFunction.  See hls_cordic_functions.h for details
  // o The CORDIC function applies its own rounding, therefore the interface ap_fixed types need not specify rounding and saturation modes
  template <
    int CordicFunction,
    bool CoarseRotate,
    int DataFormat,
    int PhaseFormat,
    int InputWidth,
    int OutputWidth,
    int Iterations,
    int Precision,
    int RoundMode,
    int ScaleComp
    > void cordic_base(const cordic_inputs<InputWidth,CordicFunction,DataFormat> &inputData,
                       cordic_outputs<OutputWidth,CordicFunction,DataFormat> &outputData) {

      Function_cordic_base:;

      #ifndef __SYNTHESIS__
      // Verify template parameters are correct in simulation

      if ((CordicFunction < CORDIC_F_ROTATE) || (CordicFunction > CORDIC_F_SQRT)) {
        std::cout << "ERROR: " << __FILE__ << ": CordicFunction must be in range 0 (CORDIC_F_ROTATE) to 6 (CORDIC_F_SQRT)" << std::endl;
        exit(1);
      }

      if (CordicFunction != CORDIC_F_SQRT && DataFormat != CORDIC_FORMAT_SIG_FRAC) {
        std::cout << "ERROR: " << __FILE__ << ": DataFormat must be " << CORDIC_FORMAT_SIG_FRAC << " for this function" << std::endl;
        exit(1);
      }

      if (CordicFunction == CORDIC_F_SQRT && DataFormat == CORDIC_FORMAT_SIG_FRAC) {
        std::cout << "ERROR: " << __FILE__ << ": DataFormat must be " << CORDIC_FORMAT_USIG_INT << " or " << CORDIC_FORMAT_USIG_FRAC << " for square root" << std::endl;
        exit(1);
      }

      if((PhaseFormat != CORDIC_FORMAT_RAD) && (PhaseFormat != CORDIC_FORMAT_SCA)) {
        std::cout << "ERROR: " << __FILE__ << ": PhaseFormat must be " << CORDIC_FORMAT_RAD << " or " << CORDIC_FORMAT_SCA << std::endl;
        exit(1);
      }

      if((InputWidth < CORDIC_DATA_WIDTH_MIN) || (InputWidth > CORDIC_DATA_WIDTH_MAX)) {
        std::cout << "ERROR: " << __FILE__ << ": InputWidth must be " << CORDIC_DATA_WIDTH_MIN << " to " << CORDIC_DATA_WIDTH_MAX << std::endl;
        exit(1);
      }

      if ((CordicFunction != CORDIC_F_SQRT) || (DataFormat != CORDIC_FORMAT_USIG_INT)) {
        if ( (OutputWidth < CORDIC_DATA_WIDTH_MIN) || (OutputWidth > CORDIC_DATA_WIDTH_MAX)) {
          std::cout << "ERROR: " << __FILE__ << ": OutputWidth must be " << CORDIC_DATA_WIDTH_MIN << " to " << CORDIC_DATA_WIDTH_MAX << std::endl;
          exit(1);
        }
      } else {
        //Minimum value has to change as output width is fixed to int(input_width/2)+1 then unsigned integer format
        if ((InputWidth/2+1) != OutputWidth) {
          std::cout << "ERROR: " << __FILE__ << ": OutputWidth must be " << InputWidth/2+1 << " for integer square root with input width " << InputWidth << std::endl;
          exit(1);
        }
      }

      if (( (Precision != 0) && (Precision < OutputWidth) ) || (Precision > CORDIC_DATA_WIDTH_MAX ) || (Precision < 0)) {
        std::cout << "ERROR: " << __FILE__ << ": Precision must be >= OutputWidth, <= " << CORDIC_DATA_WIDTH_MAX << " and > 0" << std::endl;
        exit(1);
      }

      if ((RoundMode < CORDIC_ROUND_TRUNCATE) || (RoundMode > CORDIC_ROUND_NEAREST_EVEN)) {
        std::cout << "ERROR: " << __FILE__ << ": RoundMode must be " << CORDIC_ROUND_TRUNCATE << " to " << CORDIC_ROUND_NEAREST_EVEN << std::endl;
        exit(1);
      }

      if ((ScaleComp < CORDIC_SCALE_NONE) || (ScaleComp > CORDIC_SCALE_EMB_MULT)) {
        std::cout << "ERROR: " << __FILE__ << ": ScaleComp must be " << CORDIC_SCALE_NONE << " to " << CORDIC_SCALE_EMB_MULT << std::endl;
        exit(1);
      }

      #endif

      const int ITERATIONS_INT = c_iterations_int<CordicFunction,CoarseRotate,Iterations,OutputWidth,RoundMode,InputWidth,DataFormat>::prec;
      const int PRECISION_INT = c_precision_int<CordicFunction,CoarseRotate,DataFormat,InputWidth,Iterations,OutputWidth,Precision,RoundMode>::prec;

      const ap_int<PRECISION_INT> c_neg_pi_1_4_const = (PhaseFormat == CORDIC_FORMAT_RAD ?
                                                        c_neg_pi_1_4_rads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT) :
                                                        c_neg_pi_1_4_jrads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT)
                                                        );

      const ap_int<PRECISION_INT> c_neg_pi_2_4_const = (PhaseFormat == CORDIC_FORMAT_RAD ?
                                                        c_neg_pi_2_4_rads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT) :
                                                        c_neg_pi_2_4_jrads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT)
                                                        );

      const ap_int<PRECISION_INT> c_neg_pi_3_4_const = (PhaseFormat == CORDIC_FORMAT_RAD ?
                                                        c_neg_pi_3_4_rads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT) :
                                                        c_neg_pi_3_4_jrads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT)
                                                        );

      const ap_int<PRECISION_INT> c_neg_pi_const = (PhaseFormat == CORDIC_FORMAT_RAD ?
                                                    c_neg_pi_rads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT) :
                                                    c_neg_pi_jrads_const(CORDIC_MAX_ROM_WIDTH-1,CORDIC_MAX_ROM_WIDTH-PRECISION_INT)
                                                    );

      const ap_uint<1> ENG_MODE = CORDIC_get_eng_mode(CordicFunction);
      ap_uint<1> add_nsub_x_int_v, add_nsub_y_int_v, add_nsub_p_int_v;
      ap_uint<1> transform_type_v = CORDIC_get_transform_type(CordicFunction);

      const ap_int<PRECISION_INT> c_inv_scale = CORDIC_inv_cordic_scale_slv<CordicFunction,CoarseRotate,DataFormat,InputWidth,Iterations,OutputWidth,Precision,RoundMode>();

      const int CTRL_WIDTH = gen_ctrl_width<CoarseRotate>::width;

      ap_int<InputWidth> x_in, y_in, phase_in;

      ap_int<PRECISION_INT> data_x_int, data_x_int_v, data_x_hw_shift_v;
      ap_int<PRECISION_INT> data_y_int, data_y_int_v, data_y_hw_shift_v;
      ap_int<PRECISION_INT> phase_int, phase_int_v;
      ap_int<PRECISION_INT> data_x_init;
      ap_int<PRECISION_INT> data_y_init;
      ap_int<PRECISION_INT> phase_init;

      ap_uint<4> inp_data_sign_vect;

      ap_int<PRECISION_INT+1> data_x_init_ext;
      ap_int<PRECISION_INT+1> data_y_init_ext;
      ap_int<PRECISION_INT+1> inp_x_min_y_ext;
      ap_int<PRECISION_INT+1> inp_x_plus_y_ext;

      ap_int<PRECISION_INT> inp_data_x_cr_async;
      ap_int<PRECISION_INT> inp_data_y_cr_async;
      ap_int<PRECISION_INT> inp_phase_cr_async;
      ap_uint<2> inp_data_quad;
      ap_uint<3> inp_phase_sign_vect;
      ap_int<PRECISION_INT> inp_phase_pi_3_rot;
      ap_int<PRECISION_INT> inp_phase_pi_1_rot;
      ap_uint<2> inp_phase_quad;
      ap_uint<4> inp_phase_data_quad;
      ap_uint<CTRL_WIDTH> inp_ctrl_cr_async;

      ap_int<PRECISION_INT> inp_data_x_cr;
      ap_int<PRECISION_INT> inp_data_y_cr;
      ap_int<PRECISION_INT> inp_phase_cr ;
      ap_uint<CTRL_WIDTH> inp_ctrl_cr ;

      ap_int<PRECISION_INT> data_x_inp;
      ap_int<PRECISION_INT> data_y_inp;
      ap_int<PRECISION_INT> phase_inp ;
      ap_uint<CTRL_WIDTH> ctrl_inp ;

      ap_int<PRECISION_INT> data_x_eng;
      ap_int<PRECISION_INT> data_y_eng;
      ap_int<PRECISION_INT> phase_eng ;
      ap_uint<CTRL_WIDTH> ctrl_eng ;

      ap_int<PRECISION_INT> outp_data_x_cr;
      ap_int<PRECISION_INT> outp_data_y_cr;
      ap_int<PRECISION_INT> outp_phase_cr ;
      ap_uint<2> outp_cr_quad ;

      ap_int<PRECISION_INT> outp_data_x_sca;
      ap_int<PRECISION_INT> outp_data_y_sca;
      ap_int<PRECISION_INT> outp_phase_sca ;
      ap_int<2*PRECISION_INT> outp_data_x_sca_ext;
      ap_int<2*PRECISION_INT> outp_data_y_sca_ext;
      ap_int<2*PRECISION_INT> outp_phase_sca_ext ;

      ap_int<OutputWidth> outp_data_x_rnd;
      ap_int<OutputWidth> outp_data_y_rnd;
      ap_int<OutputWidth> outp_phase_rnd ;

      ap_int<OutputWidth> data_x_outp;
      ap_int<OutputWidth> data_y_outp;
      ap_int<OutputWidth> phase_outp;

      ap_int<PRECISION_INT> sqrt_data_trunc_async;
      ap_int<PRECISION_INT> sqrt_data_trunc_async_ext;
      ap_int<OutputWidth> sqrt_data_round_async;

      ap_int<PRECISION_INT> eng_rom_vect[ITERATIONS_INT];

      // Initialize ROM contents, if required
      fn_rom_data_int<CordicFunction,CoarseRotate,DataFormat,InputWidth,Iterations,OutputWidth,RoundMode,Precision,PhaseFormat,ITERATIONS_INT, PRECISION_INT>(eng_rom_vect);

      // Internal variables to hold FIFO read and write contents
      cordic_inputs<InputWidth,CordicFunction,DataFormat> din;
      cordic_outputs<OutputWidth,CordicFunction,DataFormat> dout;

      // Input read
      din = inputData;

      // Extract subfields, reformat to internal types
      get_inputs<InputWidth,CordicFunction,DataFormat>(din,x_in,y_in,phase_in);

      // Scale inputs to suit internal precision
      const int SCALE_UP = (PRECISION_INT - InputWidth);
      const int SCALE_DOWN = (InputWidth - PRECISION_INT);
      if (PRECISION_INT > InputWidth) {
        data_x_int = ap_int<PRECISION_INT>(x_in) << SCALE_UP;
        data_y_int = ap_int<PRECISION_INT>(y_in) << SCALE_UP;
        phase_int  = ap_int<PRECISION_INT>(phase_in) << SCALE_UP;
      } else if (PRECISION_INT < InputWidth) {
        data_x_int = x_in >> SCALE_DOWN;
        data_y_int = y_in >> SCALE_DOWN;
        phase_int  = phase_in >> SCALE_DOWN;
      } else {
        data_x_int = x_in;
        data_y_int = y_in;
        phase_int  = phase_in;
      }

      // Implicit sign-extension or truncation during assignment
      switch (CordicFunction) {
      case CORDIC_F_ROTATE:
        data_x_init = data_x_int;
        data_y_init = data_y_int;
        phase_init = phase_int;
        break;
      case CORDIC_F_TRANSLATE:
      case CORDIC_F_ATAN:
      case CORDIC_F_ATANH:
        data_x_init = data_x_int;
        data_y_init = data_y_int;
        phase_init = 0;
        break;
      case CORDIC_F_SIN_COS:
      case CORDIC_F_SINH_COSH:
        data_x_init = c_inv_scale;
        data_y_init = 0;
        phase_init = phase_int;
        break;
      default: // case CORDIC_F_SQRT
        data_x_init = data_x_int;
        data_y_init = 0;
        phase_init = 0;
      }

      if (CordicFunction != CORDIC_F_SQRT) {

        if (CoarseRotate) {

          // implicit sign-extend
          data_x_init_ext = data_x_init;
          data_y_init_ext = data_y_init;

          inp_x_plus_y_ext = data_x_init_ext + data_y_init;
          inp_x_min_y_ext = data_x_init_ext - data_y_init;

          inp_data_sign_vect[3] = inp_x_min_y_ext[PRECISION_INT];
          inp_data_sign_vect[2] = inp_x_plus_y_ext[PRECISION_INT];
          inp_data_sign_vect[1] = data_x_init_ext[PRECISION_INT];
          inp_data_sign_vect[0] = data_y_init_ext[PRECISION_INT];

          inp_data_quad[1] = ~inp_data_sign_vect[3];
          inp_data_quad[0] = ~inp_data_sign_vect[2];

          ap_int<PRECISION_INT+1> a, b, x, c, d, y;

          a(PRECISION_INT,1) = 0;
          a[0] = ap_uint<1>(1);
          inp_data_x_cr_async_loop : for (int i=1; i<PRECISION_INT+1; i++) {
            if (inp_data_sign_vect(3,2) == 0) {
              b[i] = data_x_init[i-1];
            } else if (inp_data_sign_vect(3,2) == 2) {
              b[i] = data_y_init[i-1];
            } else if (inp_data_sign_vect(3,2) == 3) {
              b[i] = ~data_x_init[i-1];
            } else {
              b[i] = ~data_y_init[i-1];
            }
          }
          b[0] = inp_data_sign_vect[2];
          x = a + b;
          inp_data_x_cr_async = x(PRECISION_INT,1);

          c(PRECISION_INT,1) = 0;
          c[0] = ap_uint<1>(1);
          inp_data_y_cr_async_loop : for (int i=1; i<PRECISION_INT+1; i++) {
            if (inp_data_sign_vect(3,2) == 0) {
              d[i] = data_y_init[i-1];
            } else if (inp_data_sign_vect(3,2) == 2) {
              d[i] = ~data_x_init[i-1];
            } else if (inp_data_sign_vect(3,2) == 3) {
              d[i] = ~data_y_init[i-1];
            } else {
              d[i] = data_x_init[i-1];
            }
          }
          d[0] = inp_data_sign_vect[3];
          y = c + d;
          inp_data_y_cr_async = y(PRECISION_INT,1);

          // No add/sub optimization required here
          if (phase_init < 0) {
            inp_phase_pi_3_rot = phase_init - c_neg_pi_3_4_const;
            inp_phase_pi_1_rot = phase_init - c_neg_pi_1_4_const;
          } else {
            inp_phase_pi_3_rot = phase_init + c_neg_pi_3_4_const;
            inp_phase_pi_1_rot = phase_init + c_neg_pi_1_4_const;
          }

          inp_phase_sign_vect[2] = phase_init[PRECISION_INT-1];
          inp_phase_sign_vect[1] = inp_phase_pi_3_rot[PRECISION_INT-1];
          inp_phase_sign_vect[0] = inp_phase_pi_1_rot[PRECISION_INT-1];

          switch (inp_phase_sign_vect) {
          case 3:
          case 4:
            inp_phase_cr_async = phase_init;
            inp_phase_quad = 3;
            break;
          case 2:
            inp_phase_cr_async = phase_init + c_neg_pi_2_4_const;
            inp_phase_quad = 1;
            break;
          case 0:
            inp_phase_cr_async = phase_init + c_neg_pi_const;
            inp_phase_quad = 0;
            break;
          case 5:
            inp_phase_cr_async = phase_init - c_neg_pi_2_4_const;
            inp_phase_quad = 2;
            break;
          default: // case 7
            inp_phase_cr_async = phase_init - c_neg_pi_const;
            inp_phase_quad = 0;
          }

          // Combine coarse rotation from phase and data inputs
          inp_phase_data_quad[3] = inp_phase_quad[1];
          inp_phase_data_quad[2] = inp_phase_quad[0];
          inp_phase_data_quad[1] = inp_data_quad[1];
          inp_phase_data_quad[0] = inp_data_quad[0];

          switch (inp_phase_data_quad) {
          case 0:
          case 6:
          case 9:
          case 15:
            inp_ctrl_cr_async = 6;
            break;
          case 1:
          case 4:
          case 11:
          case 14:
            inp_ctrl_cr_async = 4;
            break;
          case 3:
          case 5:
          case 10:
          case 12:
            inp_ctrl_cr_async = 0;
            break;
          default: // cases 2,7,8,13
            inp_ctrl_cr_async = 2;
          }

        } // end if CoarseRotate

        // Select between coarse rotate pass through input data
        if (!CoarseRotate) {
          inp_data_x_cr = data_x_init;
          inp_data_y_cr = data_y_init;
          inp_phase_cr = phase_init;
        } else {
          inp_data_x_cr = inp_data_x_cr_async;
          inp_data_y_cr = inp_data_y_cr_async;
          inp_phase_cr = inp_phase_cr_async;
        }

        inp_ctrl_cr = inp_ctrl_cr_async;

        data_x_inp = inp_data_x_cr;
        data_y_inp = inp_data_y_cr;
        phase_inp = inp_phase_cr;
        ctrl_inp = inp_ctrl_cr;

        //Implement CORDIC engine stage

        if ( ( ( ( (ENG_MODE == 1) && (data_y_inp<0) ) ||
                 ( (ENG_MODE == 0) && (phase_inp>=0) )
                 ) && (transform_type_v == 1) ) ||
             ( ( ( (ENG_MODE == 1) && (data_y_inp>=0) ) ||
                 ( (ENG_MODE == 0) && (phase_inp<0 ) )
                 ) && (transform_type_v == 0) )
             ) {
          add_nsub_x_int_v = 1;
        } else {
          add_nsub_x_int_v = 0;
        }


        if ( ( (ENG_MODE == 1) && (data_y_inp<0) ) ||
             ( (ENG_MODE == 0) && (phase_inp>=0) )
             ) {
          add_nsub_y_int_v = 1;
        } else {
          add_nsub_y_int_v = 0;
        }

        if ( ( (ENG_MODE == 1) && (data_y_inp>=0) ) ||
             ( (ENG_MODE == 0) && (phase_inp<0) )
             ) {
          add_nsub_p_int_v = 1;
        } else {
          add_nsub_p_int_v = 0;
        }

        data_x_int_v = data_x_inp;
        data_y_int_v = data_y_inp;
        phase_int_v = phase_inp;

        iteration_loop : for (int i=0; i < ITERATIONS_INT; i++) {
          int i_int_v = CORDIC_get_current_iteration(i,(int)transform_type_v);

          data_x_hw_shift_v = data_x_int_v >> (i_int_v + 1);
          data_y_hw_shift_v = data_y_int_v >> (i_int_v + 1);

          // Optimized add/sub
          ap_int<PRECISION_INT+1> a, b, x, c, d, y, e, f, z;

          a = (data_x_int_v,ap_uint<1>(1));
          data_x_int_v_loop : for (int i=1; i<PRECISION_INT+1; i++) {
            if (add_nsub_x_int_v == 1) {
              b[i] = data_y_hw_shift_v[i-1];
            } else {
              b[i] = ~data_y_hw_shift_v[i-1];
            }
          }
          b[0] = ~add_nsub_x_int_v[0];
          x = a + b;
          data_x_int_v = x(PRECISION_INT,1);

          c = (data_y_int_v,ap_uint<1>(1));
          data_y_int_v_loop : for (int i=1; i<PRECISION_INT+1; i++) {
            if (add_nsub_y_int_v == 1) {
              d[i] = data_x_hw_shift_v[i-1];
            } else {
              d[i] = ~data_x_hw_shift_v[i-1];
            }
          }
          d[0] = ~add_nsub_y_int_v[0];
          y = c + d;
          data_y_int_v = y(PRECISION_INT,1);


          e = (phase_int_v,ap_uint<1>(1));
          phase_int_v_loop : for (int i=1; i<PRECISION_INT+1; i++) {
            if (add_nsub_p_int_v == 1) {
              f[i] = eng_rom_vect[i_int_v][i-1];
            } else {
              f[i] = ~eng_rom_vect[i_int_v][i-1];
            }
          }
          f[0] = ~add_nsub_p_int_v[0];
          z = e + f;
          phase_int_v = z(PRECISION_INT,1);
          // End optimized add/sub

          if ( ( ( ( (ENG_MODE == 1) && (data_y_int_v<0) ) ||
                   ( (ENG_MODE == 0) && (phase_int_v>=0) )
                   ) && (transform_type_v == 1) ) ||
               ( ( ( (ENG_MODE == 1) && (data_y_int_v>=0) ) ||
                   ( (ENG_MODE == 0) && (phase_int_v<0 ) )
                   ) && (transform_type_v == 0) )
               ) {
            add_nsub_x_int_v = 1;
          } else {
            add_nsub_x_int_v = 0;
          }

          if ( ( (ENG_MODE == 1) && (data_y_int_v<0) ) ||
               ( (ENG_MODE == 0) && (phase_int_v>=0) )
               ) {
            add_nsub_y_int_v = 1;
          } else {
            add_nsub_y_int_v = 0;
          }

          if ( ( (ENG_MODE == 1) && (data_y_int_v>=0) ) ||
               ( (ENG_MODE == 0) && (phase_int_v<0) )
               )  {
            add_nsub_p_int_v = 1;
          } else {
            add_nsub_p_int_v = 0;
          }

        } // for i

        data_x_eng = data_x_int_v;
        data_y_eng = data_y_int_v;
        phase_eng = phase_int_v;
        ctrl_eng = ctrl_inp;

        // Apply coarse rotation correction
        if (!CoarseRotate) {
          outp_data_x_cr = data_x_eng;
          outp_data_y_cr = data_y_eng;
          outp_phase_cr =  phase_eng;
        } else {
          outp_cr_quad = ctrl_eng >> 1;
          if (ENG_MODE == 0){

            ap_int<PRECISION_INT+1> a, b, x, c, d, y;

            a(PRECISION_INT,1) = 0;
            a[0] = ap_uint<1>(1);
            outp_data_x_cr_loop : for (int i=1; i<PRECISION_INT+1; i++) {
              if (outp_cr_quad == 3) {
                b[i] = data_x_eng[i-1];
              } else if (outp_cr_quad == 2) {
                b[i] = data_y_eng[i-1];
              } else if (outp_cr_quad == 1) {
                b[i] = ~data_y_eng[i-1];
              } else {
                b[i] = ~data_x_eng[i-1];
              }
            }
            b[0] = ~outp_cr_quad[1];
            x = a + b;
            outp_data_x_cr = x(PRECISION_INT,1);

            c(PRECISION_INT,1) = 0;
            c[0] = ap_uint<1>(1);
            outp_data_y_cr_loop : for (int i=1; i<PRECISION_INT+1; i++) {
              if (outp_cr_quad == 3) {
                d[i] = data_y_eng[i-1];
              } else if (outp_cr_quad == 2) {
                d[i] = ~data_x_eng[i-1];
              } else if (outp_cr_quad == 1) {
                d[i] = data_x_eng[i-1];
              } else {
                d[i] = ~data_y_eng[i-1];
              }
            }
            d[0] = ~outp_cr_quad[0];
            y = c + d;
            outp_data_y_cr = y(PRECISION_INT,1);

            outp_phase_cr = phase_eng;
          } else {
            outp_data_x_cr = data_x_eng;
            outp_data_y_cr = data_y_eng;
            switch(outp_cr_quad) {
            case 3:
              outp_phase_cr = phase_eng;
              break;
            case 2:
              outp_phase_cr = phase_eng + c_neg_pi_2_4_const;
              break;
            case 0:
              if (phase_eng>=0) {
                outp_phase_cr = phase_eng + c_neg_pi_const;
              } else {
                outp_phase_cr = phase_eng - c_neg_pi_const;
              }
              break;
            default:
              //   case 1:
              outp_phase_cr = phase_eng - c_neg_pi_2_4_const;
            }
          }
        }

        // Apply Scaling Correction
        if (ScaleComp != CORDIC_SCALE_NONE ) {
          outp_data_x_sca_ext = c_inv_scale;
          outp_data_x_sca_ext = outp_data_x_sca_ext * outp_data_x_cr;
          outp_data_x_sca = outp_data_x_sca_ext(2*PRECISION_INT-3,PRECISION_INT-2);

          outp_data_y_sca_ext = c_inv_scale;
          outp_data_y_sca_ext = outp_data_y_sca_ext * outp_data_y_cr;
          outp_data_y_sca = outp_data_y_sca_ext(2*PRECISION_INT-3,PRECISION_INT-2);

          outp_phase_sca = outp_phase_cr;
        } else {
          outp_data_x_sca = outp_data_x_cr;
          outp_data_y_sca = outp_data_y_cr;
          outp_phase_sca = outp_phase_cr;
        }

        outp_data_x_rnd = CORDIC_rnd_slv<PRECISION_INT,OutputWidth>(outp_data_x_sca,
                                                                    PRECISION_INT,
                                                                    RoundMode,
                                                                    OutputWidth);
        outp_data_y_rnd = CORDIC_rnd_slv<PRECISION_INT,OutputWidth>(outp_data_y_sca,
                                                                    PRECISION_INT,
                                                                    RoundMode,
                                                                    OutputWidth);
        outp_phase_rnd = CORDIC_rnd_slv<PRECISION_INT,OutputWidth>(outp_phase_sca,
                                                                   PRECISION_INT,
                                                                   RoundMode,
                                                                   OutputWidth);

        data_x_outp = outp_data_x_rnd;
        data_y_outp = outp_data_y_rnd;
        phase_outp = outp_phase_rnd;

      } else { // CordicFunction == CORDIC_F_SQRT

        sqrt_data_trunc_async = sqrt_slv<InputWidth,DataFormat,PRECISION_INT>(x_in);

        sqrt_data_trunc_async_ext = sqrt_data_trunc_async;

        const int c_rnd_mode_int = rnd_mode_int_v<CordicFunction,RoundMode>::mode;

        sqrt_data_round_async = CORDIC_rnd_slv< PRECISION_INT , OutputWidth>(sqrt_data_trunc_async_ext,
                                                                             PRECISION_INT,
                                                                             c_rnd_mode_int,
                                                                             OutputWidth);

        data_x_outp = sqrt_data_round_async;
        data_y_outp = 0;
        phase_outp = 0;

      }  // end if (CordicFunction != CORDIC_F_SQRT)

      set_outputs<OutputWidth,CordicFunction,DataFormat>(data_x_outp, data_y_outp, phase_outp, dout);

      outputData = dout;

    }

} // end namespace hls

#endif // HLS_CORDIC_H


