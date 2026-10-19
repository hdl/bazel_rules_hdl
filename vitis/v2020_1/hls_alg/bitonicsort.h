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
 *     (c) Copyright 2018 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/

/**
 * @file bitonicsort.h
 * @brief bitonic sort template function implementation.
 *
 * This file is part of HLS Algorithm Library.
 */

#ifndef _X_HLS_ALG_SORT_H_
#error \
    "hls_alg/sort.h should not be inlcuded directly, use top-level hls_alg.h instead!"
#endif

#ifndef _X_HLS_ALG_SORT_BITONIC_H_
#define _X_HLS_ALG_SORT_BITONIC_H_

#ifndef __cplusplus
#error "hls_alg::sort uses hls::stream<> interface, and thus requires C++"
#endif

#ifndef __SYNTHESIS__
#include <stdio.h>
#endif

namespace hls_alg_internal {

  template<class T, int updown>
  inline void swap(T& in1, T& in2, T& out1, T& out2){

    if(updown==0){
      if(in1 > in2){
        out1 = in2;
        out2 = in1;
      }
      else{
        out1 = in1;
        out2 = in2;
      }
    }
    else{
      if(in1 < in2){
        out1 = in2;
        out2 = in1;
      }
      else{
        out1 = in1;
        out2 = in2;
      }
    };
  };

  template<class T>
  inline void swap(T& in1, T& in2, T& out1, T& out2){
  
    if(in1 > in2){
      out1 = in2;
      out2 = in1;
    }
    else{
      out1 = in1;
      out2 = in2;
    }
  };

  template<class T, bool updown>
  inline void swap(T& in1, T& in2){

    if(updown==0){
      if(in1 > in2){
        T tmp = in1;
        in1 = in2;
        in2 = tmp;
      };
    }
    else{
      if(in1 < in2){
        T tmp = in1;
        in1 = in2;
        in2 = tmp;
      };
    };
  };


  template<class T, int N, int Stage, int SubStage>
  void BitonicSortStage(T in[N], T out[N]){
    
// #pragma HLS array_partition variable=in complete
// #pragma HLS array_partition variable=out complete
    
    for(int s=0;s<(N>>1);s++){
      const int S = 1 << (Stage+1);
      const int M = S >> SubStage;
      const int idxtmp1 = int(2*s/M) * M + s%(M/2);
      const int idxtmp2 = idxtmp1 + (M/2);
      const int updown = int((s%S)/(S>>1)); // up or down
      const int idx1 = (updown==0) ? idxtmp1: idxtmp2;
      const int idx2 = (updown==0) ? idxtmp2: idxtmp1;
      
      swap<T>(in[idx1],in[idx2],out[idx1],out[idx2]);
    };
  };


  template<class T, int NS>
  void BitonicSortSlave(T in[NS], T out[NS]){

    T tmp1[NS], tmp2[NS];

// #pragma HLS array_partition variable=tmp1 complete
// #pragma HLS array_partition variable=tmp2 complete
// #pragma HLS array_partition variable=in complete
// #pragma HLS array_partition variable=out complete

    for(int i=0;i<NS;i++){
      tmp1[i] = in[i];
    }

    if(NS>=2){
      BitonicSortStage<T,NS,0,0>(tmp1,tmp2);
    }
    if(NS>=4){
      BitonicSortStage<T,NS,1,0>(tmp2,tmp1);
      BitonicSortStage<T,NS,1,1>(tmp1,tmp2);
    }
    if(NS>=8){
      BitonicSortStage<T,NS,2,0>(tmp2,tmp1);
      BitonicSortStage<T,NS,2,1>(tmp1,tmp2);
      BitonicSortStage<T,NS,2,2>(tmp2,tmp1);
    }
    if(NS>=16){
      BitonicSortStage<T,NS,3,0>(tmp1,tmp2);
      BitonicSortStage<T,NS,3,1>(tmp2,tmp1);
      BitonicSortStage<T,NS,3,2>(tmp1,tmp2);
      BitonicSortStage<T,NS,3,3>(tmp2,tmp1);
    }
    if(NS>=32){
      BitonicSortStage<T,NS,4,0>(tmp1,tmp2);
      BitonicSortStage<T,NS,4,1>(tmp2,tmp1);
      BitonicSortStage<T,NS,4,2>(tmp1,tmp2);
      BitonicSortStage<T,NS,4,3>(tmp2,tmp1);
      BitonicSortStage<T,NS,4,4>(tmp1,tmp2);
    }
    if(NS>=64){
      BitonicSortStage<T,NS,5,0>(tmp2,tmp1);
      BitonicSortStage<T,NS,5,1>(tmp1,tmp2);
      BitonicSortStage<T,NS,5,2>(tmp2,tmp1);
      BitonicSortStage<T,NS,5,3>(tmp1,tmp2);
      BitonicSortStage<T,NS,5,4>(tmp2,tmp1);
      BitonicSortStage<T,NS,5,5>(tmp1,tmp2);
    }

    if(NS==2 or NS==4 or NS==32 or NS==64){
      for(int i=0;i<NS;i++){
        out[i] = tmp2[i];
      }
    }
    else {
      for(int i=0;i<NS;i++){
        out[i] = tmp1[i];
      }
    };
  };


  template<class T, int N, bool updown>
  void BitonicMergeSlave(T in1[N],  T in2[N], 
                         T out1[N], T out2[N]){

    const int logN = 31 - __builtin_clz(N);
    const int N2 = 2*N;

    T inout[N2];

// #pragma HLS array_partition variable=inout complete
// #pragma HLS array_partition variable=in1 complete
// #pragma HLS array_partition variable=in2 complete
// #pragma HLS array_partition variable=out1 complete
// #pragma HLS array_partition variable=out2 complete

    for(int i=0;i<N;i++){
      inout[i] = in1[i];
    }
    for(int i=0;i<N;i++){
      inout[N2-i-1] = in2[i];
    }

    for(int i=0;i<(logN+1);i++){
      for(int s=0;s<N;s++){
        const int M = N2 >> i;
        const int idx1 = int(2*s/M) * M + s%(M/2);
        const int idx2 = idx1 + (M/2);
        swap<T,updown>(inout[idx1],inout[idx2]);
      };
    };

    for(int i=0;i<N;i++){
      out1[i] = inout[i];
    }
    for(int i=0;i<N;i++){
      out2[i] = inout[i+N];
    }
  };



  template<class T, int NG, int NS>
  void BitonicSortGlobal(T in[NG], T out[NG]){

    const int NP = NG / NS;
    const int logNP = 31 - __builtin_clz(NP);

    T tmp1[NG/NS][NS];
    T tmp2[NG/NS][NS];

    // slave step
    for(int i=0;i<NP;i++){
      BitonicSortSlave<T,NS>(in+i*NS,tmp1[i]);
    };

    // block merge step   
    for(int i=0;i<logNP;i++){
      for(int j=0;j<i+1;j++){

        for(int s=0;s<NP/2;s++){

          const int S = 1 << (i+1);
          const int M = S >> j;
          const int idxtmp1 = int(2*s/M) * M + s%(M/2);
          const int idxtmp2 = idxtmp1 + (M/2);
          const int updown = int((s%S)/(S>>1)); // up or down
          const int idx1 = (updown==0) ? idxtmp1: idxtmp2;
          const int idx2 = (updown==0) ? idxtmp2: idxtmp1;

          BitonicMergeSlave<T,NS,0>(tmp1[idx1],tmp1[idx2],
                                    tmp2[idx1],tmp2[idx2]);
        };

        for(int m=0;m<NG/NS;m++){
          for(int r=0;r<NS;r++){
            tmp1[m][r] = tmp2[m][r];
            tmp1[m][r] = tmp2[m][r];
          };
        };

      };
    };

    for(int m=0;m<NP;m++){
      for(int n=0;n<NS;n++){
        out[m*NS+n] = tmp1[m][n];
      }
    }
  }


  template<typename T, int len>
  void BitonicSort(hls::stream<T>& in_stm, hls::stream<T>& out_stm){

#pragma HLS stream variable=in_stm depth=len
#pragma HLS stream variable=out_stm depth=len

#ifdef __SYNTHESIS__
    T in[len];
    T out[len];
#else
    T* in = new T[len];
    T* out = new T[len];
#endif


#ifndef __SYNTHESIS__
    if(len<=2){
      fprintf(stderr, "Error: size of array to sort should not be less than 2.\n");
      exit (EXIT_FAILURE);
    }
    else if((len & (len-1)) != 0){
      fprintf(stderr, "Error: size of array to sort should be power of 2.\n");
      exit (EXIT_FAILURE);
    };
#endif

    for(int i=0;i<len;i++){
      in[i] = in_stm.read();
    };

    BitonicSortGlobal<T,len,4>(in, out);

    for(int i=0;i<len;i++){
      out_stm.write(out[i]);
    };

#ifndef __SYNTHESIS__
    delete[] in;
    delete[] out;
#endif
  };


} // end of namespace hls_alg_internal


#endif


