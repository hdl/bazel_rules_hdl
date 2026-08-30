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
 *     (c) Copyright 2014-2015 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
 
// SVD functions
// ------------------
// SVD                 : Entry point function
// SVD_TOP             : Top level function that selects implementation architecture and internal types based on traits class
// SVD_BASIC           : Default architecture
// SVD_PAIRS           : Alternative architecture

// Change Log
// ----------
// 2015.3:
//  * Changed default architecture to SVD_PAIRS
//  * Added default diagonal and off-diagonal loop pipelining and unrolling factors set via configuration traits class
//  * Added additional overloaded forms of vm2x1 to simplify controlling resource utilization for complex data types implementations
// 
// 2015.1:
//  * Linear Algebra Library update.
//  * No changes
// 
// 2014.1:
//  * Initial release

#ifndef X_COMPLEX_SVD_H
#define X_COMPLEX_SVD_H

#include "ap_fixed.h"
#include "hls/linear_algebra/utils/x_hls_complex.h"
#include "hls/linear_algebra/hls_svd.h"
#include "hls/linear_algebra/deprecated/x_complex_matrix_utils.h"
#include "utils/x_hls_utils.h"

#ifndef __SYNTHESIS__
#include <assert.h>
#endif

namespace hls {
  
  #ifndef HLS_SVD_SKIP_COMMON_VM2X1
    template<typename T>
    void vm2x1(
      T a1, x_complex<T> b1,
      T a2, x_complex<T> b2,
      x_complex<T>& c)
    {
      x_complex<T> c_a1,c_a2;
      c_a1 = a1;
      c_a2 = a2;
      vm2x1_base(c_a1,b1,c_a2,b2,c);
    }
    template<typename T>
    void vm2x1(
      x_complex<T> a1, T b1,
      x_complex<T> a2, T b2,
      x_complex<T>& c)
    {
      x_complex<T> c_b1,c_b2;
      c_b1 = b1;
      c_b2 = b2;
      vm2x1_base(a1,c_b1,a2,c_b2,c);
    }
  #endif
  
  // Calculate the sin and cos of the complex input's phase angle and phase angle divided by 2
  template<
    typename InType,
    typename CSType>
  void calc_angle(
    x_complex<InType> A, 
    CSType &cosThetaA, CSType &sinThetaA,
    CSType &cosThetaAdiv2, CSType &sinThetaAdiv2,
    bool &is_pos_real, bool &is_imag)
  {
    const InType inZERO = 0;
    const CSType csZERO = 0;
    const CSType csONE  = 1;
    // NOTE: Hard single precision floating point value
    const float ONE_OVER_ROOT2 = 1.0f / sqrtf(2.0f);
    
    CSType tanThetaA, cosThetaA_int, sinThetaA_int, tanThetaAdiv2, cosThetaAdiv2_int; 
    
    InType re = A.real();
    InType im = A.imag();
    
    // Helpers to avoid testing the sin and cos outputs for particular characteristics.
    is_pos_real = false;
    is_imag     = false;
    
    // Check for when effectively real only or imag only
    if ( !within_precision(re,im) ) {
      if ( x_isneg(re) ) {
        // 180 degs (half is 90!)
        cosThetaA     = -csONE;
        sinThetaA     = csZERO;
        cosThetaAdiv2 = csZERO;
        sinThetaAdiv2 = csONE;
      } else {
        // 0 degs
        cosThetaA     = csONE;
        sinThetaA     = csZERO;
        cosThetaAdiv2 = csONE;
        sinThetaAdiv2 = csZERO;
        is_pos_real   = true;
      }
    } else if ( !within_precision(im,re) ) {
      is_imag = true;
      if ( x_isneg(im) ) {
        // 270 deg
        cosThetaA     = csZERO;
        sinThetaA     = -csONE;
        cosThetaAdiv2 = -ONE_OVER_ROOT2;
        sinThetaAdiv2 = ONE_OVER_ROOT2;
      } else {
        // 90 deg
        cosThetaA     = csZERO;
        sinThetaA     = csONE;
        cosThetaAdiv2 = ONE_OVER_ROOT2;
        sinThetaAdiv2 = ONE_OVER_ROOT2;
      }
    } else {
      // Basic
      // Full angle values
      tanThetaA = im/re;
      cosThetaA_int = x_copysign(csONE,re) * x_rsqrt(csONE + tanThetaA * tanThetaA);
      cosThetaA     = cosThetaA_int;
      sinThetaA_int = cosThetaA_int * tanThetaA;
      sinThetaA     = sinThetaA_int;
      
      // Half angle values
      // o Select the correct expression to minimize error in tan(thetaA/2)
      //   - Avoid creating near eps values 
      if ( x_isneg(cosThetaA_int) ) {
        tanThetaAdiv2 = (csONE - cosThetaA_int)/ sinThetaA_int;
      } else {
        tanThetaAdiv2 = sinThetaA_int / (csONE + cosThetaA_int);
      }
      cosThetaAdiv2_int = x_rsqrt(csONE + tanThetaAdiv2 * tanThetaAdiv2);
      
      cosThetaAdiv2     = cosThetaAdiv2_int;
      sinThetaAdiv2     = cosThetaAdiv2_int * tanThetaAdiv2;
    }
  }
  
  // ===================================================================================================================
  // Diagonal processing functions
  
  
// Real 2x2 SVD function
  template <
    typename AInType, 
    typename CSType,
    typename AOutType> 
  void svd2x2_x_complex(
    AInType  w_in,    AInType  x_in,    AInType  y_in,   AInType  z_in,
    CSType   &uw_out, CSType   &ux_out, CSType &uy_out,  CSType   &uz_out,
    CSType   &vw_out, CSType   &vx_out, CSType &vy_out,  CSType   &vz_out,
    AOutType &w_out,  AOutType &x_out,  AOutType &y_out, AOutType &z_out) 
  {
    Function_svd2x2_real:;
    // Inline to bring common lower level functions to this level of hierarchy to simplify the application
    // of resource sharing directives.
    #pragma HLS inline
    
    const AOutType     outZERO = 0;
    CSType             s1, c1, s2, c2;
    AInType            u1, u2;
    x_complex<AInType> A, B;
    CSType             cosA_full, sinA_full, cosA_half, sinA_half;
    CSType             cosB_full, sinB_full, cosB_half, sinB_half;
    bool               A_is_pos_real, A_is_imag;
    bool               B_is_pos_real, B_is_imag;
    CSType             uw_int, ux_int, uy_int, uz_int;
    CSType             vw_int, vx_int, vy_int, vz_int;
    AOutType           w_out1, w_out2, z_out1, z_out2,
                       w_out_int, z_out_int;
    
    // Determine first half angle required to zero off-diagonal values
    u1 = z_in - w_in;
    u2 = y_in + x_in;
    A.imag(u2);
    A.real(u1);
    calc_angle(A, cosA_full, sinA_full, cosA_half, sinA_half, A_is_pos_real, A_is_imag);
    
    // Determine second half angle
    u1 = z_in + w_in;
    u2 = y_in - x_in;
    B.imag(u2);
    B.real(u1);
    calc_angle(B,cosB_full, sinB_full, cosB_half, sinB_half, B_is_pos_real, B_is_imag);
    
    // Combine half angles to produce left and right rotations
    // IMPLEMENTATION TIP: There are common products in the following calculations. For parallel implementations these should be shared. 
    // Consider in-lining these function calls.
    vm2x1(cosA_half,cosB_half,sinA_half,sinB_half,c1);
    vm2x1(sinA_half,cosB_half,-cosA_half,sinB_half,s1);
    vm2x1(cosA_half,cosB_half,-sinA_half,sinB_half,c2);
    vm2x1(sinA_half,cosB_half,cosA_half,sinB_half,s2);
    
    // Build full U and V matrix
    uw_int = c1;
    ux_int = s1;
    uy_int = -s1;
    uz_int = c1;
    
    vw_int = c2;
    vx_int = s2;
    vy_int = -s2;
    vz_int = c2;
    
    // Apply rotation
    // - Uses the transpose version of U
    // w_out
    vm2x1(w_in,vw_int,x_in,vy_int,w_out1);
    vm2x1(y_in,vw_int,z_in,vy_int,w_out2);
    vm2x1(uw_int,w_out1,uy_int,w_out2,w_out_int);
    // z_out
    vm2x1(w_in,vx_int,x_in,vz_int,z_out1);
    vm2x1(y_in,vx_int,z_in,vz_int,z_out2);
    vm2x1(ux_int,z_out1,uz_int,z_out2,z_out_int);
    x_out = outZERO;
    y_out = outZERO;
    
    // Ensure singular values are positive
    if (x_isneg(w_out_int)) {
      w_out = -w_out_int;
      vw_int = -c2;
      vy_int = s2;
    } else {
      w_out = w_out_int;
    }
    if (x_isneg(z_out_int)) {
      z_out = -z_out_int;
      vx_int = -s2;
      vz_int = -c2;
    } else {
      z_out = z_out_int;
    }
    
    // Assign outputs
    uw_out = uw_int;
    ux_out = ux_int;
    uy_out = uy_int;
    uz_out = uz_int;
    vw_out = vw_int;
    vx_out = vx_int;
    vy_out = vy_int;
    vz_out = vz_int;
  }

  
  // Complex 2x2 SVD function
  // o Calculates several additional rotations to convert the w,x,y & z values to real only before calling the real 2x2 svd 
  //   function
  template <
    typename AInType, 
    typename CSType,
    typename AOutType> 
  void svd2x2(
    x_complex<AInType>  w_in,    x_complex<AInType>  x_in,    x_complex<AInType>  y_in,   x_complex<AInType>  z_in,
    x_complex<CSType>   &uw_out, x_complex<CSType>   &ux_out, x_complex<CSType> &uy_out,  x_complex<CSType>   &uz_out,
    x_complex<CSType>   &vw_out, x_complex<CSType>   &vx_out, x_complex<CSType> &vy_out,  x_complex<CSType>   &vz_out,
    x_complex<AOutType> &w_out,  x_complex<AOutType> &x_out,  x_complex<AOutType> &y_out, x_complex<AOutType> &z_out) 
  {
    Function_svd2x2_complex:;
    // Inline to bring common lower level functions to this level of hierarchy to simplify the application
    // of resource sharing directives.
    #pragma HLS inline
    
    const x_complex<AInType> CMPLX_ZERO = 0;
    const AInType            REAL_ZERO  = 0;
    const CSType             csZERO     = 0;
    
    AInType           wMag, xMag, yMag, zMag;
    CSType            cosThetaW, sinThetaW, cosThetaWdiv2, sinThetaWdiv2,
                      cosThetaX, sinThetaX, cosThetaXdiv2, sinThetaXdiv2,
                      cosThetaY, sinThetaY, cosThetaYdiv2, sinThetaYdiv2,
                      cosThetaZ, sinThetaZ, cosThetaZdiv2, sinThetaZdiv2,
                      RotL1_w_re, RotL1_w_im, RotR1_w_re, RotR1_w_im,
                      Rot2_C, Rot2_S, Rot2_Cdiv2, Rot2_Sdiv2,
                      RotL2_w, RotL2_x, RotL2_y, RotL2_z,
                      RotL3_w_re, RotL3_w_im, RotR3_w_im,
                      RotL4_w, RotL4_x, RotL4_y, RotL4_z,
                      RotR4_w, RotR4_x, RotR4_y, RotR4_z;
                      
    x_complex<CSType> RotL1_w, RotL1_x, RotL1_y, RotL1_z,
                      RotR1_w, RotR1_x, RotR1_y, RotR1_z,
                      RotL12_w, RotL12_x, RotL12_y, RotL12_z,
                      RotL3_w, RotL3_x, RotL3_y, RotL3_z,
                      RotR3_w, RotR3_x, RotR3_y, RotR3_z,
                      Rot2_cmplx,
                      RotL123_w, RotL123_x, RotL123_y, RotL123_z,
                      RotR13_w, RotR13_x, RotR13_y, RotR13_z,
                      uw_int, ux_int, uy_int, uz_int;
                      
    x_complex<AInType> w_int, x_int, x_int1, y_int, z_int, z_int1;
    AInType            w_out_re, x_out_re, y_out_re, z_out_re, w_int_re;
    
    bool               w_is_pos_real, w_is_imag,
                       x_is_pos_real, x_is_imag,
                       y_is_pos_real, y_is_imag,
                       z_is_pos_real, z_is_imag,
                       tmp_is_pos_real, tmp_is_imag;
                       
    // Determine sin and cos values of W and Y phase angles, ThetaW and ThetaY
    calc_angle(w_in, cosThetaW, sinThetaW, cosThetaWdiv2, sinThetaWdiv2, w_is_pos_real, w_is_imag);
    calc_angle(y_in, cosThetaY, sinThetaY, cosThetaYdiv2, sinThetaYdiv2, y_is_pos_real, y_is_imag);
    
    // Rotation 1
    // o 2-sided Unitary Complex rotation to make W and Y real
    //        RotL1 = | exp(j*(ThetaY-ThetaW)/2)  0                         | 
    //                | 0                         exp(-j*(ThetaY-ThetaW)/2) |
    //        RotR1 = | exp(-j*(ThetaY+ThetaW)/2) 0                         |
    //                |  0                        exp(-j*(ThetaY+ThetaW)/2) |
    // o So
    //   exp(j*(ThetaY-ThetaW)/2)  = cos((ThetaY-ThetaW)/2) + j sin((ThetaY-ThetaW)/2)
    //                             = cos(ThetaY/2)cos(ThetaW/2) + sin(ThetaY/2)*sin(ThetaW/2) + j ( sin(ThetaY/2)cos(ThetaW/2) - cos(ThetaY/2)sin(ThetaW/2) )
    //   exp(-j*(ThetaY+ThetaW)/2) = cos((ThetaY+ThetaW)/2) - j sin((ThetaY+ThetaW)/2)
    //                             = cos(ThetaY/2)cos(ThetaW/2) - sin(ThetaY/2)*sin(ThetaW/2) - j ( sin(ThetaY/2)cos(ThetaW/2) + cos(ThetaY/2)sin(ThetaW/2) )
    vm2x1(cosThetaYdiv2,cosThetaWdiv2,sinThetaYdiv2,sinThetaWdiv2,RotL1_w_re);
    vm2x1(sinThetaYdiv2,cosThetaWdiv2,-cosThetaYdiv2,sinThetaWdiv2,RotL1_w_im);
    RotL1_w.real(RotL1_w_re);
    RotL1_w.imag(RotL1_w_im);
    RotL1_x = 0;  // Unused
    RotL1_y = 0;  // Unused
    RotL1_z = x_conj(RotL1_w);
    
    // IMPLEMENTATION TIP: The following calls duplicate the multiplies also implemented above. For parallel implementations
    // these should be optimized/inlined.
    vm2x1(cosThetaYdiv2,cosThetaWdiv2,-sinThetaYdiv2,sinThetaWdiv2,RotR1_w_re);
    vm2x1(-sinThetaYdiv2,cosThetaWdiv2,-cosThetaYdiv2,sinThetaWdiv2,RotR1_w_im);
    RotR1_w.real(RotR1_w_re);
    RotR1_w.imag(RotR1_w_im);
    RotR1_x = 0;   // Unused
    RotR1_y = 0;   // Unused
    RotR1_z = RotR1_w;
    
    // Rotation 2
    // o 1-sided real Givens rotation to zero Y
    // o Use the magnitudes of W and Y and calculate the sin and the cos of the rotation required to zero Y
    vm2x1(w_in.real(),cosThetaW,w_in.imag(),sinThetaW,wMag);
    vm2x1(y_in.real(),cosThetaY,y_in.imag(),sinThetaY,yMag);
    
    Rot2_cmplx.real(wMag);
    Rot2_cmplx.imag(yMag);
    calc_angle(Rot2_cmplx, Rot2_C, Rot2_S, Rot2_Cdiv2, Rot2_Sdiv2, tmp_is_pos_real,tmp_is_imag);
    RotL2_w = Rot2_C;
    RotL2_x = Rot2_S;
    RotL2_y = -Rot2_S;
    RotL2_z = Rot2_C;
    
    // Combine left hand rotations 1 & 2
    // o Using the constant value CMPLX_ZERO to obtain some optimization when the implementation allows.
    // o Note that rotation 2 contains real only values
    mm2x2(RotL2_w, RotL2_x, RotL2_y, RotL2_z, RotL1_w, CMPLX_ZERO, CMPLX_ZERO, RotL1_z, RotL12_w, RotL12_x, RotL12_y, RotL12_z);
    
    // Update w,x,y & z values to reflect rotations
    w_int.imag(0);
    vm2x1(wMag, Rot2_C, yMag, Rot2_S, w_int_re);
    w_int.real(w_int_re);
    y_int = 0;
    vm2x1(x_in, RotL12_w, z_in, RotL12_x, x_int1);
    x_int = x_int1 * RotR1_z;
    vm2x1(x_in, RotL12_y, z_in, RotL12_z, z_int1);
    z_int = z_int1 * RotR1_z;
    
    // Determine sin and cos values of the updated X and Z phase angles, ThetaX and ThetaZ
    calc_angle(x_int, cosThetaX, sinThetaX, cosThetaXdiv2, sinThetaXdiv2, x_is_pos_real, x_is_imag);
    calc_angle(z_int, cosThetaZ, sinThetaZ, cosThetaZdiv2, sinThetaZdiv2, z_is_pos_real, z_is_imag);
    
    // Rotation 3
    // o 2 additional 2-sided complex rotations to turn the updated X and Z into real only values.
    // o The 2 rotations are combined into a single 2-sided complex rotation.
    // o The first rotation rotates W and X - Rotation 3a:
    //        RotL3a = | exp(-j*(ThetaX+ThetaW)/2)  0                         |
    //                 | 0                          exp(-j*(ThetaX+ThetaW)/2) |
    //        RotR3a = | exp(j*(ThetaX-ThetaW)/2)   0                         |
    //                 | 0                          exp(-j*(ThetaX-ThetaW)/2) |
    //   - Note ThetaW already equals 0 so the above simplifies to only use ThetaX
    // o The second rotation rotates X and Z - Rotation 3b:
    //        RotL3b = | exp(j*(ThetaZ-ThetaX)/2)   0                         |
    //                 | 0                          exp(-j*(ThetaZ-ThetaX)/2) |
    //        RotR3b = | exp(-j*(ThetaZ+ThetaX)/2)  0                         |
    //                 | 0                          exp(-j*(ThetaZ+ThetaX)/2) |
    //   - Note Following rotation 3a ThetaX equals 0 so this rotation simplifies to use only ThetaZ
    // o Finally we can then combine these 2 rotations into single left and right unitary matrix giving the final rotation we'll use:
    //        RotL3 =  | exp(j*(ThetaZ/2 - ThetaX))  0                  |
    //                 | 0                           exp(j*-(ThetaZ/2)) |
    //        RotR3 =  | exp(j*(ThetaX - ThetaZ/2))  0                  |
    //                 | 0                           exp(j*-(ThetaZ/2)) |
    // o So
    //   exp(j*(ThetaZ/2 - ThetaX)) = cos(ThetaZ/2 - ThetaX) + j sin(ThetaZ/2 - ThetaX)
    //                              = cos(ThetaZ/2)cos(ThetaX) + sin(ThetaZ/2)*sin(ThetaX) + j ( sin(ThetaZ/2)cos(ThetaX) - cos(ThetaZ/2)sin(ThetaX) )
    //   exp(j*-(ThetaZ/2))         = cos(ThetaZ/2) - j sin(ThetaZ/2)
    //   exp(j*(ThetaX - ThetaZ/2)) = cos(ThetaX - ThetaZ/2) + j sin(ThetaX - ThetaZ/2)
    //                              = cos(ThetaX)cos(ThetaZ/2) + sin(ThetaX)*sin(ThetaZ/2) + j ( sin(ThetaX)cos(ThetaZ/2) - cos(ThetaX)sin(ThetaZ/2) )
    vm2x1(cosThetaZdiv2,cosThetaX,sinThetaZdiv2,sinThetaX,RotL3_w_re);
    vm2x1(sinThetaZdiv2,cosThetaX,-cosThetaZdiv2,sinThetaX,RotL3_w_im);
    RotL3_w.real(RotL3_w_re);
    RotL3_w.imag(RotL3_w_im);
    RotL3_x = 0;  // Unused
    RotL3_y = 0;  // Unused
    RotL3_z.real(cosThetaZdiv2);
    RotL3_z.imag(-sinThetaZdiv2);
    
    RotR3_w.real( RotL3_w.real() );
    // IMPLEMENTATION TIP: Below duplicates the multiplies implemented above. For parallel implementations these should be inlined 
    vm2x1(cosThetaZdiv2,sinThetaX,-sinThetaZdiv2,cosThetaX,RotR3_w_im);
    RotR3_w.imag(RotR3_w_im);
    RotR3_x = 0;   // Unused
    RotR3_y = 0;   // Unused
    RotR3_z = RotL3_z;
    
    // Combine rotation 3 with 2 & 1
    mm2x2(RotL3_w, CMPLX_ZERO, CMPLX_ZERO, RotL3_z, RotL12_w, RotL12_x, RotL12_y, RotL12_z, RotL123_w, RotL123_x, RotL123_y, RotL123_z);
    mm2x2(RotR1_w, CMPLX_ZERO, CMPLX_ZERO, RotR1_z, RotR3_w, CMPLX_ZERO, CMPLX_ZERO, RotR3_z, RotR13_w, RotR13_x, RotR13_y, RotR13_z);
    
    // Calculate the magnitudes of X and Z for use in real SVD calculation
    vm2x1(x_int.real(),cosThetaX,x_int.imag(),sinThetaX,xMag);
    vm2x1(z_int.real(),cosThetaZ,z_int.imag(),sinThetaZ,zMag);
    
    // Call real SVD function
    svd2x2_x_complex(w_int.real(), xMag, REAL_ZERO, zMag, RotL4_w, RotL4_x, RotL4_y, RotL4_z, RotR4_w, RotR4_x, RotR4_y, RotR4_z, w_out_re, x_out_re, y_out_re, z_out_re);
    
    // Generate and assign outputs
    // o The combined U values (Left rotations) must be Hermitian Transposed.
    // o Note the rotation values output by the SVD function are real only
    w_out = w_out_re;
    x_out = x_out_re; // Zero'ed by the SVD function
    y_out = y_out_re; // Zero'ed by the SVD function
    z_out = z_out_re;
    
    mm2x2(RotL4_w, RotL4_y, RotL4_x, RotL4_z, RotL123_w, RotL123_x, RotL123_y, RotL123_z, uw_int, ux_int, uy_int, uz_int);
    uw_out = x_conj(uw_int);
    ux_out = x_conj(uy_int); // Transposed
    uy_out = x_conj(ux_int); // Transposed
    uz_out = x_conj(uz_int);
    
    mm2x2(RotR13_w, RotR13_x, RotR13_y, RotR13_z, RotR4_w, RotR4_x, RotR4_y, RotR4_z, vw_out, vx_out, vy_out, vz_out);
    
  }
  
}
#endif


