// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#ifndef 	HLS_MAC_PACK_H_
#define	 	HLS_MAC_PACK_H_

#include "ap_int.h"
//#include "utils/hls_mac_pack_defines.h"


#define PORT_A_WIDTH 8 //8
#define PORT_B_WIDTH 8 //8

#define ACC_EXT 1
#define MARGIN 2
#define RSHFT PORT_A_WIDTH + PORT_B_WIDTH +  MARGIN
#define MASK18L 0x3FFFF
#define MASK18H 0xFFFFFFFC0000
#define MASKL MASK18L
#define MASKH MASK18H
#define RND 1<<RSHFT


// definition for DSP48E2
#define DSP48_2MUL 1
#define DSP48_AW 30
#define DSP48_BW 18
#define DSP48_DW 27
#define DSP48_MACW 48
#define DSP48_BW_SHIFT 26

typedef ap_int<DSP48_AW> typeDSPPortA;    /// A
typedef ap_int<DSP48_BW> typeDSPPortB;   /// W
typedef ap_int<DSP48_DW> typeDSPPortD;   /// B
typedef ap_int<DSP48_MACW> typeDSPPortC;
typedef ap_int<DSP48_MACW> typeDSPPortP;
typedef ap_uint<1> typeDSPOpMode_bit;

typedef ap_int<PORT_A_WIDTH> typeOpA;
typedef ap_int<PORT_B_WIDTH> typeOpB;
typedef ap_int<DSP48_BW_SHIFT> typeOpD;
typedef ap_int<DSP48_MACW> typeP;
typedef ap_int<24> typeAccL;
typedef ap_int<24> typeAccH;


template <int TP_A_BW,int TP_B_BW,int TP_W_BW,int TP_ACCUM_WB>
static void mac_pack(ap_int<TP_A_BW> A,ap_int<TP_B_BW> B, ap_int<TP_W_BW>  W,ap_int<TP_ACCUM_WB> &Accum_in, bool rst)
{

#pragma HLS INLINE
	typeDSPPortA Ap = A;
	typeDSPPortB Wp = W;
	typeDSPPortD Bp = B;
	typeDSPPortC Cmac;
	Cmac(RSHFT-1,0)= 0;
	if(rst)
		Cmac(DSP48_MACW-1,RSHFT)=0; //Cmac((TP_ACCUM_WB/2)+RSHFT-1,RSHFT)=0;
	else
		Cmac(DSP48_MACW-1,RSHFT)= Accum_in(TP_ACCUM_WB-1,TP_ACCUM_WB/2);
	Bp = Bp<<RSHFT;
	typeDSPPortD O_preAdd = Ap + Bp; // 27 bit value;
	if((Ap>0 && Wp<0) || (Ap<0 && Wp>0))
		Cmac = Cmac	+ typeDSPPortP (RND);
	Cmac = Cmac +W * O_preAdd; // W * O_preAdd;
	Accum_in(TP_ACCUM_WB/2 -1 ,0) = (ap_int<TP_ACCUM_WB/2>)Accum_in(TP_ACCUM_WB/2 -1 ,0) + (ap_int<TP_A_BW+TP_B_BW>)Cmac(TP_A_BW+TP_B_BW-1,0) ;// (ap_int<18>)(Cmac & MASKL);
	Accum_in(TP_ACCUM_WB-1,TP_ACCUM_WB/2)= (ap_int<TP_ACCUM_WB/2>)Cmac((TP_ACCUM_WB/2)+RSHFT-1,RSHFT);//(typeAccH)(Cmac>>18);
 }

template <int VECTOR_LENGTH,int TP_ACCUM_WB,int TP_A_BW,int TP_B_BW,int TP_W_BW>
static ap_int<TP_ACCUM_WB> dot2(ap_int<TP_A_BW>  A[VECTOR_LENGTH], ap_int<TP_B_BW> B[VECTOR_LENGTH],ap_int<TP_W_BW> W[VECTOR_LENGTH])
 {
#pragma HLS INLINE
	ap_int<TP_ACCUM_WB> Accum;
	vector_dot2_label0:for (int i = 0; i < VECTOR_LENGTH; ++i)
	{
#pragma HLS PIPELINE II=1
		mac_pack(A[i],B[i],W[i],Accum,i==0);
	}
 return Accum;
 }

#endif //HLS_MAC_PACK_H_


