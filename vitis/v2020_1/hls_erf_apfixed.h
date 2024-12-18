// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
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
 *     (c) Copyright 2012-2017 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
#ifndef _X_HLS_ERF_APFIXED_H_
#define _X_HLS_ERF_APFIXED_H_
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_exp_apfixed.h"
#include "utils/x_hls_utils.h"

namespace erf_erfc_fixed {
    
    namespace {
	template <typename T> class coeff { };

	template <> class coeff<double> {
    //class coeff<double> {
	public:
	  static const double tiny;
	  static const double one_over_two;
	  static const double one;
	  static const double two;
	  static const double erx;
	  static const double efx;
	  static const double efx8;
	  static const double pp[5];
	  static const double qq[6];
	  static const double pa[7];
	  static const double qa[7];
	  static const double ra[8];
	  static const double sa[9];
	  static const double rb[7];
	  static const double sb[8];
	};
	const double coeff<double>::tiny	    = 1e-300;
	const double coeff<double>::one_over_two=  5.00000000000000000000e-01; /* 0x3FE00000, 0x00000000 */
	const double coeff<double>::one =  1.00000000000000000000e+00; /* 0x3FF00000, 0x00000000 */
	const double coeff<double>::two =  2.00000000000000000000e+00; /* 0x40000000, 0x00000000 */
	/* c = (float)0.84506291151 */
	const double coeff<double>::erx =  8.45062911510467529297e-01; /* 0x3FEB0AC1, 0x60000000 */
	/*
	 * Coefficients for approximation to  erf on [0,0.84375]
	 */
	const double coeff<double>::efx =  1.28379167095512586316e-01; /* 0x3FC06EBA, 0x8214DB69 */
	const double coeff<double>::efx8=  1.02703333676410069053e+00; /* 0x3FF06EBA, 0x8214DB69 */
	const double coeff<double>::pp[]  =  
	  {1.28379167095512558561e-01, /* 0x3FC06EBA, 0x8214DB68 */
	   -3.25042107247001499370e-01, /* 0xBFD4CD7D, 0x691CB913 */
	   -2.84817495755985104766e-02, /* 0xBF9D2A51, 0xDBD7194F */
	   -5.77027029648944159157e-03, /* 0xBF77A291, 0x236668E4 */
	   -2.37630166566501626084e-05}; /* 0xBEF8EAD6, 0x120016AC */
	const double coeff<double>::qq[]  =  
	  {0.0, 3.97917223959155352819e-01, /* 0x3FD97779, 0xCDDADC09 */
	   6.50222499887672944485e-02, /* 0x3FB0A54C, 0x5536CEBA */
	   5.08130628187576562776e-03, /* 0x3F74D022, 0xC4D36B0F */
	   1.32494738004321644526e-04, /* 0x3F215DC9, 0x221C1A10 */
	   -3.96022827877536812320e-06}; /* 0xBED09C43, 0x42A26120 */
	/*
	 * Coefficients for approximation to  erf  in [0.84375,1.25]
	 */
	const double coeff<double>::pa[]  = 
	  {-2.36211856075265944077e-03, /* 0xBF6359B8, 0xBEF77538 */
	   4.14856118683748331666e-01, /* 0x3FDA8D00, 0xAD92B34D */
	   -3.72207876035701323847e-01, /* 0xBFD7D240, 0xFBB8C3F1 */
	   3.18346619901161753674e-01, /* 0x3FD45FCA, 0x805120E4 */
	   -1.10894694282396677476e-01, /* 0xBFBC6398, 0x3D3E28EC */
	   3.54783043256182359371e-02, /* 0x3FA22A36, 0x599795EB */
	   -2.16637559486879084300e-03}; /* 0xBF61BF38, 0x0A96073F */
	const double coeff<double>::qa[]  =  
	  {0.0, 1.06420880400844228286e-01, /* 0x3FBB3E66, 0x18EEE323 */
	   5.40397917702171048937e-01, /* 0x3FE14AF0, 0x92EB6F33 */
	   7.18286544141962662868e-02, /* 0x3FB2635C, 0xD99FE9A7 */
	   1.26171219808761642112e-01, /* 0x3FC02660, 0xE763351F */
	   1.36370839120290507362e-02, /* 0x3F8BEDC2, 0x6B51DD1C */
	   1.19844998467991074170e-02}; /* 0x3F888B54, 0x5735151D */
	/*
	 * Coefficients for approximation to  erfc in [1.25,1/0.35]
	 */
	const double coeff<double>::ra[]  = 
	  {-9.86494403484714822705e-03, /* 0xBF843412, 0x600D6435 */
	   -6.93858572707181764372e-01, /* 0xBFE63416, 0xE4BA7360 */
	   -1.05586262253232909814e+01, /* 0xC0251E04, 0x41B0E726 */
	   -6.23753324503260060396e+01, /* 0xC04F300A, 0xE4CBA38D */
	   -1.62396669462573470355e+02, /* 0xC0644CB1, 0x84282266 */
	   -1.84605092906711035994e+02, /* 0xC067135C, 0xEBCCABB2 */
	   -8.12874355063065934246e+01, /* 0xC0545265, 0x57E4D2F2 */
	   -9.81432934416914548592e+00}; /* 0xC023A0EF, 0xC69AC25C */
	const double coeff<double>::sa[]  =  
	  {0.0,1.96512716674392571292e+01, /* 0x4033A6B9, 0xBD707687 */
	   1.37657754143519042600e+02, /* 0x4061350C, 0x526AE721 */
	   4.34565877475229228821e+02, /* 0x407B290D, 0xD58A1A71 */
	   6.45387271733267880336e+02, /* 0x40842B19, 0x21EC2868 */
	   4.29008140027567833386e+02, /* 0x407AD021, 0x57700314 */
	   1.08635005541779435134e+02, /* 0x405B28A3, 0xEE48AE2C */
	   6.57024977031928170135e+00, /* 0x401A47EF, 0x8E484A93 */
	   -6.04244152148580987438e-02}; /* 0xBFAEEFF2, 0xEE749A62 */
	/*
	 * Coefficients for approximation to  erfc in [1/.35,28]
	 */
	const double coeff<double>::rb[]  = 
	  {-9.86494292470009928597e-03, /* 0xBF843412, 0x39E86F4A */
	   -7.99283237680523006574e-01, /* 0xBFE993BA, 0x70C285DE */
	   -1.77579549177547519889e+01, /* 0xC031C209, 0x555F995A */
	   -1.60636384855821916062e+02, /* 0xC064145D, 0x43C5ED98 */
	   -6.37566443368389627722e+02, /* 0xC083EC88, 0x1375F228 */
	   -1.02509513161107724954e+03, /* 0xC0900461, 0x6A2E5992 */
	   -4.83519191608651397019e+02}; /* 0xC07E384E, 0x9BDC383F */
	const double coeff<double>::sb[]  =  
	  {0.0,3.03380607434824582924e+01, /* 0x403E568B, 0x261D5190 */
	   3.25792512996573918826e+02, /* 0x40745CAE, 0x221B9F0A */
	   1.53672958608443695994e+03, /* 0x409802EB, 0x189D5118 */
	   3.19985821950859553908e+03, /* 0x40A8FFB7, 0x688C246A */
	   2.55305040643316442583e+03, /* 0x40A3F219, 0xCEDF3BE6 */
	   4.74528541206955367215e+02, /* 0x407DA874, 0xE79FE763 */
	   -2.24409524465858183362e+01}; /* 0xC03670E2, 0x42712D62 */
#if 0
	template <> class coeff<float> {
	public:
	  static const float tiny;
	  static const float one_over_two;
	  static const float one;
	  static const float two;
	  static const float erx;
	  static const float efx;
	  static const float efx8;
	  static const float pp[5];
	  static const float qq[6];
	  static const float pa[7];
	  static const float qa[7];
	  static const float ra[8];
	  static const float sa[9];
	  static const float rb[7];
	  static const float sb[8];
	};
	const float coeff<float>::tiny	    = 1e-30;
	const float coeff<float>::one_over_two=  5.0000000000e-01; /* 0x3F000000 */
	const float coeff<float>::one =  1.0000000000e+00; /* 0x3F800000 */
	const float coeff<float>::two =  2.0000000000e+00; /* 0x40000000 */
	/* c = (float)0.84506291151 */
	const float coeff<float>::erx = 8.4506291151e-01; /* 0x3f58560b */ 
	/*
	 * Coefficients for approximation to  erf on [0,0.84375]
	 */
	const float coeff<float>::efx = 1.2837916613e-01; /* 0x3e0375d4 */ 
	const float coeff<float>::efx8= 1.0270333290e+00; /* 0x3f8375d4 */ 
	const float coeff<float>::pp[]  = 
	  {1.2837916613e-01, /* 0x3e0375d4 */
	   -3.2504209876e-01, /* 0xbea66beb */
	   -2.8481749818e-02, /* 0xbce9528f */
	   -5.7702702470e-03, /* 0xbbbd1489 */
	   -2.3763017452e-05}; /* 0xb7c756b1 */
	const float coeff<float>::qq[]  =  
	  {0.0, 3.9791721106e-01, /* 0x3ecbbbce */
	   6.5022252500e-02, /* 0x3d852a63 */
	   5.0813062117e-03, /* 0x3ba68116 */
	   1.3249473704e-04, /* 0x390aee49 */
	   -3.9602282413e-06}; /* 0xb684e21a */
	/*
	 * Coefficients for approximation to  erf  in [0.84375,1.25]
	 */
	const float coeff<float>::pa[]  = 
	  {-2.3621185683e-03, /* 0xbb1acdc6 */
	   4.1485610604e-01, /* 0x3ed46805 */
	   -3.7220788002e-01, /* 0xbebe9208 */
	   3.1834661961e-01, /* 0x3ea2fe54 */
	   -1.1089469492e-01, /* 0xbde31cc2 */
	   3.5478305072e-02, /* 0x3d1151b3 */
	   -2.1663755178e-03}; /* 0xbb0df9c0 */
	const float coeff<float>::qa[]  =  
	  {0.0, 1.0642088205e-01, /* 0x3dd9f331 */
	   5.4039794207e-01, /* 0x3f0a5785 */
	   7.1828655899e-02, /* 0x3d931ae7 */
	   1.2617121637e-01, /* 0x3e013307 */
	   1.3637083583e-02, /* 0x3c5f6e13 */
	   1.1984500103e-02}; /* 0x3c445aa3 */
	/*
	 * Coefficients for approximation to  erfc in [1.25,1/0.35]
	 */
	const float coeff<float>::ra[]  = 
	  {-9.8649440333e-03, /* 0xbc21a093 */
	   -6.9385856390e-01, /* 0xbf31a0b7 */
	   -1.0558626175e+01, /* 0xc128f022 */
	   -6.2375331879e+01, /* 0xc2798057 */
	   -1.6239666748e+02, /* 0xc322658c */
	   -1.8460508728e+02, /* 0xc3389ae7 */
	   -8.1287437439e+01, /* 0xc2a2932b */
	   -9.8143291473e+00}; /* 0xc11d077e */
	const float coeff<float>::sa[]  =  
	  {0.0, 1.9651271820e+01, /* 0x419d35ce */
	   1.3765776062e+02, /* 0x4309a863 */
	   4.3456588745e+02, /* 0x43d9486f */
	   6.4538726807e+02, /* 0x442158c9 */
	   4.2900814819e+02, /* 0x43d6810b */
	   1.0863500214e+02, /* 0x42d9451f */
	   6.5702495575e+00, /* 0x40d23f7c */
	   -6.0424413532e-02}; /* 0xbd777f97 */
	/*
	 * Coefficients for approximation to  erfc in [1/.35,28]
	 */
	const float coeff<float>::rb[]  = 
	  {-9.8649431020e-03, /* 0xbc21a092 */
	   -7.9928326607e-01, /* 0xbf4c9dd4 */
	   -1.7757955551e+01, /* 0xc18e104b */
	   -1.6063638306e+02, /* 0xc320a2ea */
	   -6.3756646729e+02, /* 0xc41f6441 */
	   -1.0250950928e+03, /* 0xc480230b */
	   -4.8351919556e+02}; /* 0xc3f1c275 */
	const float coeff<float>::sb[]  =  
	  {0.0, 3.0338060379e+01, /* 0x41f2b459 */
	   3.2579251099e+02, /* 0x43a2e571 */
	   1.5367296143e+03, /* 0x44c01759 */
	   3.1998581543e+03, /* 0x4547fdbb */
	   2.5530502930e+03, /* 0x451f90ce */
	   4.7452853394e+02, /* 0x43ed43a7 */
	   -2.2440952301e+01}; /* 0xc1b38712 */
#endif
	template<typename T> class erf_traits{ };
#if 0    
	template<> class erf_traits<float> {
	public:
	  static const uint32_t mask;
	  static const uint32_t segment[10];
	};
	const uint32_t erf_traits<float>::mask  = 0xfffff000; 
	const uint32_t erf_traits<float>::segment[10]  =  
	  {
		0x7fffffff, 
		0x7f800000, 
		0x3f580000, 
		0x31800000, 
		0x04000000, 
		0x3fa00000, 
		0x40c00000, 
		0x4036DB6E, 
		31,
		0
	  };
#endif
	template<> class erf_traits<double> {
	public:
	  static const uint64_t mask;
	  static const uint32_t segment[10];
	};
	const uint64_t erf_traits<double>::mask  = 0xffffffff00000000; 
	const uint32_t erf_traits<double>::segment[10]  =  
	  {
		0x7fffffff, 
		0x7ff00000,
		0x3feb0000,
		0x3e300000,
		0x00800000,
		0x3ff40000,
		0x40180000,
		0x4006DB6E,
		63,
		32
	  };

	template<typename T> class erfc_traits{};
#if 0
	template<> class erfc_traits<float>{
	public:
	  static const uint32_t segment[11];
	};
	const uint32_t erfc_traits<float>::segment[11]  =  
	  {
		0x7fffffff,
		0x7f800000,
		0x3f580000,
		0x23800000,
		0x3e800000,
		0x3fa00000,
		0x41e00000,
		0x4036DB6D,
		0x40c00000,
		31,
		0
	  };
#endif
	template<> class erfc_traits<double>{
	public:
	  static const uint32_t segment[11];
	};
	const uint32_t erfc_traits<double>::segment[11]  =  
	  {
		0x7fffffff, 
		0x7ff00000, 
		0x3feb0000,
		0x3c700000,
		0x3fd00000,
		0x3ff40000,
		0x403c0000,
		0x4006DB6D,
		0x40180000,
		63,
		32
	  };
  } // anonymous namespace
//
    
/* erf_fixed(x) or erfc_fixed(x) :Input and Output is same width */
//1. erf_fixed
 /*
  *erf(0)          = 0
  *erf(2)          ~ 1
  *erf(-2)         ~ 1
  *erf(+infinity) = 1 but in std and hls =0
  */
 /*
  * ============================================
  *                             x
  *                   2       |\
  *     erf(x)  =  ---------  | exp(-t*t)dt
  *                sqrt(pi)  \|
  *                            0
  * ============================================
  */
template <int W_, int I_>
ap_fixed<W_,I_> erf(ap_fixed<W_,I_> x_fixed )
{
    int F_ = W_ - I_;

    if (I_>33) return 0;
    else if (F_>32) return 0;
    
    double x = x_fixed.to_double();
	int32_t hx;
    uint32_t ix;
	double R,S,P,Q,s,y,z,r;
	//GET_HIGH_WORD(hx,x);
    fp_struct<double> fp_abs(x);
      fp_abs.sign=0;
    fp_struct<double> fp_x(x);
    ap_uint<32> tmp = fp_x.data()(erf_traits<double>::segment[8],erf_traits<double>::segment[9]);
    hx = tmp.to_int();
	ix = hx & erf_traits<double>::segment[0];
    
    #if 0
    ///if(FP_SUBNORMAL == generic_fpclassify(x)) {
	///  return 0;
    ///}
    #endif
    if(fp_x.exp == 0x0 && fp_x.sign!= 0x0){
		 return 0;
	}

	if(ix>=erf_traits<double>::segment[1]) {		/* erf(nan)=nan */
	  //i = ((uint32_t)hx>>31)<<1;
	  if(hx>0)
		return ap_fixed<W_,I_>((double)1.0 +coeff<double>::one/x);	/* erf(+-inf)=+-1 */
	  else
		return ap_fixed<W_,I_>(coeff<double>::one/x-(double)1.0);	
	}

	if(ix < erf_traits<double>::segment[2]) {		/* |x|<0.84375 */
	  double r1,r2,s1,s2,s3,z2,z4;
	  if(ix < erf_traits<double>::segment[3]) { 	/* |x|<2**-28 */
		if (ix < erf_traits<double>::segment[2])
		  return ap_fixed<W_,I_>(((double)0.125)*((double)8.0*x+coeff<double>::efx8*x));  /*avoid underflow */
		return ap_fixed<W_,I_>(x + coeff<double>::efx*x);
	  }
	  z = x*x;
#ifdef DO_NOT_USE_THIS
	  r = pp0+z*(pp1+z*(pp2+z*(pp3+z*pp4)));
	  s = coeff<double>::one+z*(qq1+z*(qq2+z*(qq3+z*(qq4+z*qq5))));
#else
	  r1 = coeff<double>::pp[0]+z*coeff<double>::pp[1]; z2=z*z;
	  r2 = coeff<double>::pp[2]+z*coeff<double>::pp[3]; z4=z2*z2;
	  s1 = coeff<double>::one+z*  coeff<double>::qq[1];
	  s2 = coeff<double>::qq[2]+z*coeff<double>::qq[3];
	  s3 = coeff<double>::qq[4]+z*coeff<double>::qq[5];
	  r = r1 + z2*r2 + z4*coeff<double>::pp[4];
	  s  = s1 + z2*s2 + z4*s3;
#endif
	  y = r/s;
	  return ap_fixed<W_,I_>(x + x*y);
	}
	if(ix < erf_traits<double>::segment[5]) {		/* 0.84375 <= |x| < 1.25 */
	  double s2,s4,s6,P1,P2,P3,P4,Q1,Q2,Q3,Q4;
	  //s = generic_fabs_d(x)-coeff<double>::one;
      s = fp_abs.to_ieee()-coeff<double>::one;
#ifdef DO_NOT_USE_THIS
	  P = pa0+s*(pa1+s*(pa2+s*(pa3+s*(pa4+s*(pa5+s*pa6)))));
	  Q = coeff<double>::one+s*(qa1+s*(qa2+s*(qa3+s*(qa4+s*(qa5+s*qa6)))));
#else
	  P1 = coeff<double>::pa[0]+s*coeff<double>::pa[1]; s2=s*s;
	  Q1 = coeff<double>::one+s*coeff<double>::qa[1];   s4=s2*s2;
	  P2 = coeff<double>::pa[2]+s*coeff<double>::pa[3]; s6=s4*s2;
	  Q2 = coeff<double>::qa[2]+s*coeff<double>::qa[3];
	  P3 = coeff<double>::pa[4]+s*coeff<double>::pa[5];
	  Q3 = coeff<double>::qa[4]+s*coeff<double>::qa[5];
	  P4 = coeff<double>::pa[6];
	  Q4 = coeff<double>::qa[6];
	  P = P1 + s2*P2 + s4*P3 + s6*P4;
	  Q = Q1 + s2*Q2 + s4*Q3 + s6*Q4;
#endif
	  if(hx>=0) return ap_fixed<W_,I_>(coeff<double>::erx + P/Q); 
      else return ap_fixed<W_,I_>(-coeff<double>::erx - P/Q);
	}
	if (ix >= erf_traits<double>::segment[6]) {		/* inf>|x|>=6 */
	  if(hx>=0) return ap_fixed<W_,I_>(coeff<double>::one-coeff<double>::tiny); 
      else return ap_fixed<W_,I_>(coeff<double>::tiny-coeff<double>::one);
	}
	x = fp_abs.to_ieee();
 	s = coeff<double>::one/(x*x);
	if(ix< erf_traits<double>::segment[7]) {	/* |x| < 1/0.35 */
#ifdef DO_NOT_USE_THIS
	  R=ra0+s*(ra1+s*(ra2+s*(ra3+s*(ra4+s*(
										   ra5+s*(ra6+s*ra7))))));
	  S=coeff<double>::one+s*(sa1+s*(sa2+s*(sa3+s*(sa4+s*(
													 sa5+s*(sa6+s*(sa7+s*sa8)))))));
#else
	  double R1,R2,R3,R4,S1,S2,S3,S4,s2,s4,s6,s8;
	  R1 = coeff<double>::ra[0]+s*coeff<double>::ra[1];s2 = s*s;
	  S1 = coeff<double>::one+  s*coeff<double>::sa[1];  s4 = s2*s2;
	  R2 = coeff<double>::ra[2]+s*coeff<double>::ra[3];s6 = s4*s2;
	  S2 = coeff<double>::sa[2]+s*coeff<double>::sa[3];s8 = s4*s4;
	  R3 = coeff<double>::ra[4]+s*coeff<double>::ra[5];
	  S3 = coeff<double>::sa[4]+s*coeff<double>::sa[5];
	  R4 = coeff<double>::ra[6]+s*coeff<double>::ra[7];
	  S4 = coeff<double>::sa[6]+s*coeff<double>::sa[7];
	  R = R1 + s2*R2 + s4*R3 + s6*R4;
	  S = S1 + s2*S2 + s4*S3 + s6*S4 + s8*coeff<double>::sa[8];
#endif
	} else {	/* |x| >= 1/0.35 */
#ifdef DO_NOT_USE_THIS
	  R=rb0+s*(rb1+s*(rb2+s*(rb3+s*(rb4+s*(
										   rb5+s*rb6)))));
	  S=coeff<double>::one+s*(sb1+s*(sb2+s*(sb3+s*(sb4+s*(
													 sb5+s*(sb6+s*sb7))))));
#else
	  double R1,R2,R3,S1,S2,S3,S4,s2,s4,s6;
	  R1 = coeff<double>::rb[0]+s*coeff<double>::rb[1];s2 = s*s;
	  S1 = coeff<double>::one+  s*coeff<double>::sb[1];  s4 = s2*s2;
	  R2 = coeff<double>::rb[2]+s*coeff<double>::rb[3];s6 = s4*s2;
	  S2 = coeff<double>::sb[2]+s*coeff<double>::sb[3];
	  R3 = coeff<double>::rb[4]+s*coeff<double>::rb[5];
	  S3 = coeff<double>::sb[4]+s*coeff<double>::sb[5];
	  S4 = coeff<double>::sb[6]+s*coeff<double>::sb[7];
	  R = R1 + s2*R2 + s4*R3 + s6*coeff<double>::rb[6];
	  S = S1 + s2*S2 + s4*S3 + s6*S4;
#endif
	}
	z  = x;
	//SET_LOW_WORD(z,0);
    fp_struct<double> fp_z(z);
    ap_uint<Type_BitWidth<double>::Value> data = fp_z.data() & erf_traits<double>::mask;
    fp_struct<double> fp_z_new(data);
    z = fp_z_new.to_ieee();
	//r  =  __ieee754_exp(-z*z-0.5625)*__ieee754_exp((z-x)*(z+x)+R/S);
	//r  =  exp_reduce_::exp(-z*z-(double)0.5625)*exp_reduce_::exp((z-x)*(z+x)+R/S);
    ap_fixed<W_, I_> r_fixed  =  exp_reduce::exp(ap_fixed<W_, I_>(-z*z-(double)0.5625))*exp_reduce::exp(ap_fixed<W_, I_>((z-x)*(z+x)+R/S));
	r = r_fixed.to_double();
    //r  =  exp_reduce_::exp(-x*x-(T)0.5625+R/S); // also work 
	if(hx>=0) return ap_fixed<W_,I_>(coeff<double>::one-r/x); 
    else return  ap_fixed<W_,I_>(r/x-coeff<double>::one);
  }


template <int W_, int I_>
ap_ufixed<W_,I_> erf(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xs = x;
    return erf(xs);
}

template <int I_>
ap_int<I_> erf(ap_int<I_> x) {
    ap_fixed<I_,I_> xs = x;
    return erf(xs);
}

template <int I_>
ap_uint<I_> erf(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xs = x;
    return erf(xs);
}


//2. erfc_fixed
 /*
  * ============================================
  *    erfc(x)  = 1 - erf(x)
  * ============================================
  */
template <int W_, int I_>
ap_fixed<W_,I_> erfc(ap_fixed<W_,I_> x_fixed)
{
    #pragma HLS PIPELINE II=1
    int F_ = W_ - I_;
    
    if (I_>33) return 0;
    else if (F_>32) return 0;
    
    double x = x_fixed.to_double();
    int32_t hx;
    uint32_t ix;
	double R,S,P,Q,s,y,z,r;
	//GET_HIGH_WORD(hx,x);
    fp_struct<double> fp_abs(x);
    fp_abs.sign=0;
    fp_struct<double> fp_x(x);
    ap_uint<32> tmp = fp_x.data()(erfc_traits<double>::segment[9],erfc_traits<double>::segment[10]);
    hx = tmp.to_int();
	ix = hx & erfc_traits<double>::segment[0];
	if(ix>=erfc_traits<double>::segment[1]) {			/* erfc(nan)=nan */
	  /* erfc(+-inf)=0,2 */
	  if(hx>0)
		return ap_fixed<W_,I_>(coeff<double>::one/x);
	  else    
		return ap_fixed<W_,I_>(coeff<double>::two + coeff<double>::one/x);
	  //return (T)(((uint32_t)hx>>31)<<1)+coeff<T>::one/x;
	}

	if(ix < erfc_traits<double>::segment[2]) {		/* |x|<0.84375 */
	  double r1,r2,s1,s2,s3,z2,z4;
	  if(ix < erfc_traits<double>::segment[3])  	/* |x|<2**-56 */
		return ap_fixed<W_,I_>(coeff<double>::one-x);
	  z = x*x;
#ifdef DO_NOT_USE_THIS
	  r = pp0+z*(pp1+z*(pp2+z*(pp3+z*pp4)));
	  s = coeff<double>::one+z*(qq1+z*(qq2+z*(qq3+z*(qq4+z*qq5))));
#else
	  r1 = coeff<double>::pp[0]+z*coeff<double>::pp[1]; z2=z*z;
	  r2 = coeff<double>::pp[2]+z*coeff<double>::pp[3]; z4=z2*z2;
	  s1 = coeff<double>::one+z*coeff<double>::qq[1];
	  s2 = coeff<double>::qq[2]+z*coeff<double>::qq[3];
	  s3 = coeff<double>::qq[4]+z*coeff<double>::qq[5];
	  r = r1 + z2*r2 + z4*coeff<double>::pp[4];
	  s  = s1 + z2*s2 + z4*s3;
#endif
	  y = r/s;
	  if(ix < erfc_traits<double>::segment[4]) {  	/* x<1/4 */
		return ap_fixed<W_,I_>(coeff<double>::one-(x+x*y));
	  } else {
		r = x*y;
		r += (x-coeff<double>::one_over_two);
		return ap_fixed<W_,I_>(coeff<double>::one_over_two - r) ;
	  }
	}
	if(ix < erfc_traits<double>::segment[5]) {		/* 0.84375 <= |x| < 1.25 */
	  double s2,s4,s6,P1,P2,P3,P4,Q1,Q2,Q3,Q4;
	  s =fp_abs.to_ieee()-coeff<double>::one;
#ifdef DO_NOT_USE_THIS
	  P = pa0+s*(pa1+s*(pa2+s*(pa3+s*(pa4+s*(pa5+s*pa6)))));
	  Q = coeff<double>::one+s*(qa1+s*(qa2+s*(qa3+s*(qa4+s*(qa5+s*qa6)))));
#else
	  P1 = coeff<double>::pa[0]+s*coeff<double>::pa[1]; s2=s*s;
	  Q1 = coeff<double>::one+s*coeff<double>::qa[1];   s4=s2*s2;
	  P2 = coeff<double>::pa[2]+s*coeff<double>::pa[3]; s6=s4*s2;
	  Q2 = coeff<double>::qa[2]+s*coeff<double>::qa[3];
	  P3 = coeff<double>::pa[4]+s*coeff<double>::pa[5];
	  Q3 = coeff<double>::qa[4]+s*coeff<double>::qa[5];
	  P4 = coeff<double>::pa[6];
	  Q4 = coeff<double>::qa[6];
	  P = P1 + s2*P2 + s4*P3 + s6*P4;
	  Q = Q1 + s2*Q2 + s4*Q3 + s6*Q4;
#endif
	  if(hx>=0) {
		z  = coeff<double>::one-coeff<double>::erx; 
        return ap_fixed<W_,I_>(z - P/Q);
	  } else {
		z = coeff<double>::erx+P/Q; return ap_fixed<W_,I_>(coeff<double>::one+z);
	  }
	}
	if (ix < erfc_traits<double>::segment[6]) {		/* |x|<28 */
	  x = fp_abs.to_ieee();
	  s = coeff<double>::one/(x*x);
	  if(ix< erfc_traits<double>::segment[7]) {	/* |x| < 1/.35 ~ 2.857143*/
#ifdef DO_NOT_USE_THIS
		R=ra0+s*(ra1+s*(ra2+s*(ra3+s*(ra4+s*(
											 ra5+s*(ra6+s*ra7))))));
		S=coeff<double>::one+s*(sa1+s*(sa2+s*(sa3+s*(sa4+s*(
													   sa5+s*(sa6+s*(sa7+s*sa8)))))));
#else
		double R1,R2,R3,R4,S1,S2,S3,S4,s2,s4,s6,s8;
	    R1 = coeff<double>::ra[0]+s*coeff<double>::ra[1];s2 = s*s;
	    S1 = coeff<double>::one+s*coeff<double>::sa[1];  s4 = s2*s2;
	    R2 = coeff<double>::ra[2]+s*coeff<double>::ra[3];s6 = s4*s2;
	    S2 = coeff<double>::sa[2]+s*coeff<double>::sa[3];s8 = s4*s4;
	    R3 = coeff<double>::ra[4]+s*coeff<double>::ra[5];
	    S3 = coeff<double>::sa[4]+s*coeff<double>::sa[5];
	    R4 = coeff<double>::ra[6]+s*coeff<double>::ra[7];
	    S4 = coeff<double>::sa[6]+s*coeff<double>::sa[7];
	    R = R1 + s2*R2 + s4*R3 + s6*R4;
	    S = S1 + s2*S2 + s4*S3 + s6*S4 + s8*coeff<double>::sa[8];
#endif
	  } else {			/* |x| >= 1/.35 ~ 2.857143 */
		double R1,R2,R3,S1,S2,S3,S4,s2,s4,s6;
		if(hx<0&&ix>=erfc_traits<double>::segment[8]) return ap_fixed<W_,I_>(coeff<double>::two-coeff<double>::tiny);/* x < -6 */
#ifdef DO_NOT_USE_THIS
		R=rb0+s*(rb1+s*(rb2+s*(rb3+s*(rb4+s*(
											 rb5+s*rb6)))));
		S=coeff<double>::one+s*(sb1+s*(sb2+s*(sb3+s*(sb4+s*(
													   sb5+s*(sb6+s*sb7))))));
#else
		R1 = coeff<double>::rb[0]+s*coeff<double>::rb[1];s2 = s*s;
		S1 = coeff<double>::one+s*coeff<double>::sb[1];  s4 = s2*s2;
		R2 = coeff<double>::rb[2]+s*coeff<double>::rb[3];s6 = s4*s2;
		S2 = coeff<double>::sb[2]+s*coeff<double>::sb[3];
		R3 = coeff<double>::rb[4]+s*coeff<double>::rb[5];
		S3 = coeff<double>::sb[4]+s*coeff<double>::sb[5];
		S4 = coeff<double>::sb[6]+s*coeff<double>::sb[7];
		R = R1 + s2*R2 + s4*R3 + s6*coeff<double>::rb[6];
		S = S1 + s2*S2 + s4*S3 + s6*S4;
#endif
	  }
	  z  = x;
	  //SET_LOW_WORD(z,0);
	  fp_struct<double> fp_z(z);
	  ap_uint<Type_BitWidth<double>::Value> data = fp_z.data() & erf_traits<double>::mask;
	  fp_struct<double> fp_z_new(data);
	  z = fp_z_new.to_ieee();
	  //r  =  __ieee754_exp(-z*z-0.5625)*
	  //	__ieee754_exp((z-x)*(z+x)+R/S);
	  ap_fixed<W_, I_> r_fixed  =  exp_reduce::exp((ap_fixed<W_, I_>)(-z*z-(double)0.5625))*exp_reduce::exp((ap_fixed<W_, I_>)((z-x)*(z+x)+R/S));
	  double r = r_fixed.to_double();
	  double r_x = r/x;
	  if(hx>0) {
        #if 0
		if(FP_SUBNORMAL == generic_fpclassify(r_x)) {
		  return 0;
		}
        #endif
        if(fp_x.exp == 0x0 && fp_x.sign!= 0x0){
		 return 0;
        }
		return ap_fixed<W_,I_>(r_x); 
	  } else 
		return ap_fixed<W_,I_>(coeff<double>::two-r_x);
	} else {
	  if(hx>0) return ap_fixed<W_,I_>(coeff<double>::tiny*coeff<double>::tiny); 
      else return ap_fixed<W_,I_>(coeff<double>::two-coeff<double>::tiny);
	}

}
template <int W_, int I_>
ap_ufixed<W_,I_> erfc(ap_ufixed<W_,I_> x) {
    ap_fixed<W_+1,I_+1> xs = x;
    return erfc(xs);
}

template <int I_>
ap_int<I_> erfc(ap_int<I_> x) {
    ap_fixed<I_,I_> xs = x;
    return erfc(xs);
}

template <int I_>
ap_uint<I_> erfc(ap_uint<I_> x) {
    ap_fixed<I_+1,I_+1> xs = x;
    return erfc(xs);
}

}//erf_erfc_fixed

#endif


