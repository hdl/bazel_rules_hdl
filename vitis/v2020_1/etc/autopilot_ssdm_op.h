/* autopilot_ssdm_op.h*/
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
 * $Id$
 */

#ifndef _AUTOPILOT_SSDM_OP_H_
#define _AUTOPILOT_SSDM_OP_H_
#if !defined(__OPENCL_C_VERSION__) || ((__clang_major__ == 3) && (__clang_minor__ == 1))

#ifdef AESL_SYN
#define ap_wait() _ssdm_op_Wait(1)
#define ap_wait_n(X) { \
    for(unsigned __i__=0; __i__<X; ++__i__) { \
        _ssdm_Unroll(0,0,0, ""); \
        _ssdm_op_Wait(1); \
    } \
}
#define ap_wait_until(X) { _ssdm_op_Wait(1); int __t = X; _ssdm_op_Poll(__t); }

#define SSDM_SPEC_FIFO(M, TY, DT, C, D)    \
    _ssdm_op_SpecChannel(#M, _ssdm_sc_fifo, #DT, #C, D, D, &C, &C);   \
    _ssdm_op_SpecInterface(&C, "ap_fifo", 0, 0, "", 0, 0, "", "", "", 0, 0, 0, 0, "", "")

#ifndef SSDM_KEEP_NAME
#define SSDM_KEEP_NAME(__name__) _ssdm_op_SpecExt("member_name", #__name__, &__name__);
#define SSDM_KEEP_name(__name__, __reference__) _ssdm_op_SpecExt("member_name", #__name__, __reference__);
#define SSDM_RENAME(__name__, __newname__) _ssdm_op_SpecExt("member_name", #__newname__, &__name__);
#endif

#else

#define ap_wait() 
#define ap_wait_n(X) 
#define ap_wait_until(X) do { ap_wait(); } while (!(X));

#ifndef SSDM_KEEP_NAME
#define SSDM_KEEP_NAME(__name__) 
#endif

#endif

#ifdef AUTOPILOT_SCPP_SYSC_SIM

/**************************************************************
** SystemC simulation constructs.
***************************************************************/
#include "systemc"
using namespace sc_dt;

#define _ssdm_op_GetRange(V, u, l) (V.range(u, l))
#define _ssdm_op_SetRange(V, u, l, x)  (V.range(u, l) = x)
#define _ssdm_op_GetBit(V, pos) (V[pos])
#define _ssdm_op_SetBit(V, pos, x)  (V[pos] = x)

#define _ssdm_op_BuffRead(buff) (*(buff))
#define _ssdm_op_BuffWrite(buff, data) ((*(buff)) = data)
#define _ssdm_op_FifoRead(f) (*(f))
#define _ssdm_op_FifoWrite(f, data) ((*(f)) = data)
#define _ssdm_op_WireRead(f) (*(f))
#define _ssdm_op_WireWrite(f, data) ((*(f)) = data)

#define _ssdm_FifoRead(f) _ssdm_op_FifoRead(f)
#define _ssdm_FifoWrite(fifo, data) _ssdm_op_FifoWrite(fifo, data)
#define _ssdm_op_read(f, x) (*(f));  _ssdm_op_Wait(1)
#define _ssdm_op_write(f, x) ((*(f)) = data); _ssdm_op_Wait(1)


#define _ssdm_WaitEvent(e)  _ssdm_op_Wait(e)

#define _ssdm_op_SpecPipeline(x) 
#define _ssdm_op_SpecDataflowPipeline(x) 
#define _ssdm_op_Wait(x) 
#define _ssdm_op_Poll(x) 

#define SSDM_SPEC_MODULE(X) 
#define SSDM_SPEC_PROCESS(M, TY, X) 
#define SSDM_SPEC_PORT(M, TY, DT, P) 
#define SSDM_SPEC_CONNECTION(M, X, P) 
#define SSDM_SPEC_CHANNEL(M, TY, DT, C) 
#define SSDM_SPEC_SENSITIVE(M, S, TY)


#else


#ifdef AUTOPILOT_BC_SIM

/**************************************************************
** BC simulation constructs.
***************************************************************/

#define _ssdm_WaitEvent(e)  _ssdm_op_Wait(e)

#else

#if defined(__cplusplus) || defined(__openclc)

/*#define AP_SPEC_ATTR __attribute__ ((pure))*/
//adu: patched
#if (__clang_major__ == 3) && (__clang_minor__ == 1)
#define SSDM_SPEC_ATTR __attribute__ ((nothrow))
#define SSDM_OP_ATTR __attribute__ ((nothrow))
#else
#define SSDM_SPEC_ATTR __attribute__ ((nothrow)) __attribute__((overloadable))
#define SSDM_OP_ATTR __attribute__ ((nothrow)) __attribute__((overloadable))
#endif

#ifdef __cplusplus
extern "C" {
#endif
    /****** SSDM Intrinsics: OPERATIONS ***/

#define _uint1_  unsigned int __attribute__ ((bitwidth(1)))

    // Interface operations
    void _ssdm_op_IfRead(...) SSDM_OP_ATTR;
    void _ssdm_op_IfWrite(...) SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfNbRead(...) SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfNbWrite(...) SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfCanRead(...) SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfCanWrite(...) SSDM_OP_ATTR;

    // Stream Intrinsics
    void _ssdm_StreamRead(...) SSDM_OP_ATTR;
    void _ssdm_StreamWrite(...) SSDM_OP_ATTR;
    void _ssdm_SetStreamDepth(...) SSDM_OP_ATTR;
   
    _uint1_  _ssdm_StreamNbRead(...) SSDM_OP_ATTR;
    _uint1_  _ssdm_StreamNbWrite(...) SSDM_OP_ATTR;
    _uint1_  _ssdm_StreamCanRead(...) SSDM_OP_ATTR;
    _uint1_  _ssdm_StreamCanWrite(...) SSDM_OP_ATTR;
    unsigned _ssdm_StreamSize(...) SSDM_OP_ATTR;

#undef _uint1_

    // Misc
    void _ssdm_op_MemShiftRead(...) SSDM_OP_ATTR;

    void _ssdm_op_Wait(...) SSDM_OP_ATTR;
    void _ssdm_op_Poll(...) SSDM_OP_ATTR;

    void _ssdm_op_Return(...) SSDM_OP_ATTR;

    /* SSDM Intrinsics: SPECIFICATIONS */
    void _ssdm_op_SpecSynModule(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecTopModule(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecProcessDecl(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecProcessDef(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecPort(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecConnection(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecChannel(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecSensitive(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecModuleInst(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecPortMap(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecReset(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecPlatform(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecClockDomain(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecPowerDomain(...) SSDM_SPEC_ATTR;
                                   
    int _ssdm_op_SpecRegionBegin(...) SSDM_SPEC_ATTR;    
    int _ssdm_op_SpecRegionEnd(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecLoopName(...) SSDM_SPEC_ATTR;    
    
    void _ssdm_op_SpecLoopTripCount(...) SSDM_SPEC_ATTR;

    int _ssdm_op_SpecStateBegin(...) SSDM_SPEC_ATTR;
    int _ssdm_op_SpecStateEnd(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecInterface(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecPipeline(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecDataflowPipeline(...) SSDM_SPEC_ATTR;


    void _ssdm_op_SpecLatency(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecParallel(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecProtocol(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecOccurrence(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecResource(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecResourceLimit(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecCHCore(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecFUCore(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecIFCore(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecIPCore(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecKeepValue(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecMemCore(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecExt(...) SSDM_SPEC_ATTR;
    /*void* _ssdm_op_SpecProcess(...) SSDM_SPEC_ATTR;
    void* _ssdm_op_SpecEdge(...) SSDM_SPEC_ATTR; */
   
    /* Presynthesis directive functions */
    void _ssdm_SpecArrayDimSize(...) SSDM_SPEC_ATTR;

    void _ssdm_RegionBegin(...) SSDM_SPEC_ATTR;
    void _ssdm_RegionEnd(...) SSDM_SPEC_ATTR;

    void _ssdm_Unroll(...) SSDM_SPEC_ATTR;
    void _ssdm_UnrollRegion(...) SSDM_SPEC_ATTR;

    void _ssdm_InlineAll(...) SSDM_SPEC_ATTR;
    void _ssdm_InlineLoop(...) SSDM_SPEC_ATTR;
    void _ssdm_Inline(...) SSDM_SPEC_ATTR;
    void _ssdm_InlineSelf(...) SSDM_SPEC_ATTR;
    void _ssdm_InlineRegion(...) SSDM_SPEC_ATTR;

    void _ssdm_SpecArrayMap(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecArrayPartition(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecArrayReshape(...) SSDM_SPEC_ATTR;

    void _ssdm_SpecStream(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecStable(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecStableContent(...) SSDM_SPEC_ATTR;
    
    void _ssdm_op_SpecPipoDepth(...) SSDM_SPEC_ATTR;

    void _ssdm_SpecExpr(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecExprBalance(...) SSDM_SPEC_ATTR;

    void _ssdm_SpecDependence(...) SSDM_SPEC_ATTR;
                                    
    void _ssdm_SpecLoopMerge(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecLoopFlatten(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecLoopRewind(...) SSDM_SPEC_ATTR;                                

    void _ssdm_SpecFuncInstantiation(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecFuncBuffer(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecFuncExtract(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecConstant(...) SSDM_SPEC_ATTR;
    
    void _ssdm_DataPack(...) SSDM_SPEC_ATTR;
    void _ssdm_SpecDataPack(...) SSDM_SPEC_ATTR;

    void _ssdm_op_SpecBitsMap(...) SSDM_SPEC_ATTR;
    void _ssdm_op_SpecLicense(...) SSDM_SPEC_ATTR;
#ifndef AESL_TB
    void __xilinx_ip_top(...) SSDM_SPEC_ATTR;
#endif
#ifdef __cplusplus
}
#endif

#else // defined(__cplusplus) || defined(__openclc)

/*#define AP_SPEC_ATTR __attribute__ ((pure))*/
#define SSDM_SPEC_ATTR __attribute__ ((nothrow))
#define SSDM_OP_ATTR __attribute__ ((nothrow))

    /****** SSDM Intrinsics: OPERATIONS ***/

#define _uint1_  unsigned int __attribute__ ((bitwidth(1)))

    // Interface operations
    void _ssdm_op_IfRead() SSDM_OP_ATTR;
    void _ssdm_op_IfWrite() SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfNbRead() SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfNbWrite() SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfCanRead() SSDM_OP_ATTR;
    _uint1_ _ssdm_op_IfCanWrite() SSDM_OP_ATTR;

    // Stream Intrinsics
    void _ssdm_StreamRead() SSDM_OP_ATTR;
    void _ssdm_StreamWrite() SSDM_OP_ATTR;
    void _ssdm_SetStreamDepth() SSDM_OP_ATTR;

    _uint1_ _ssdm_StreamNbRead() SSDM_OP_ATTR;
    _uint1_ _ssdm_StreamNbWrite() SSDM_OP_ATTR;
    _uint1_ _ssdm_StreamCanRead() SSDM_OP_ATTR;
    _uint1_ _ssdm_StreamCanWrite() SSDM_OP_ATTR;

#undef _uint1_

    // Misc
    void _ssdm_op_MemShiftRead() SSDM_OP_ATTR;

    void _ssdm_op_Wait() SSDM_OP_ATTR;
    void _ssdm_op_Poll() SSDM_OP_ATTR;

    void _ssdm_op_Return() SSDM_OP_ATTR;

    /* SSDM Intrinsics: SPECIFICATIONS */
    void _ssdm_op_SpecSynModule() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecTopModule() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecProcessDecl() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecProcessDef() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecPort() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecConnection() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecChannel() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecSensitive() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecModuleInst() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecPortMap() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecReset() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecPlatform() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecClockDomain() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecPowerDomain() SSDM_SPEC_ATTR;
                                   
    int _ssdm_op_SpecRegionBegin() SSDM_SPEC_ATTR;    
    int _ssdm_op_SpecRegionEnd() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecLoopName() SSDM_SPEC_ATTR;    
    
    void _ssdm_op_SpecLoopTripCount() SSDM_SPEC_ATTR;

    int _ssdm_op_SpecStateBegin() SSDM_SPEC_ATTR;
    int _ssdm_op_SpecStateEnd() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecInterface() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecPipeline() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecDataflowPipeline() SSDM_SPEC_ATTR;


    void _ssdm_op_SpecLatency() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecParallel() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecProtocol() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecOccurrence() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecResource() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecResourceLimit() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecCHCore() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecFUCore() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecIFCore() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecIPCore() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecKeepValue() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecMemCore() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecExt() SSDM_SPEC_ATTR;
    /*void* _ssdm_op_SpecProcess() SSDM_SPEC_ATTR;
    void* _ssdm_op_SpecEdge() SSDM_SPEC_ATTR; */
   
    /* Presynthesis directive functions */
    void _ssdm_SpecArrayDimSize() SSDM_SPEC_ATTR;

    void _ssdm_RegionBegin() SSDM_SPEC_ATTR;
    void _ssdm_RegionEnd() SSDM_SPEC_ATTR;

    void _ssdm_Unroll() SSDM_SPEC_ATTR;
    void _ssdm_UnrollRegion() SSDM_SPEC_ATTR;

    void _ssdm_InlineAll() SSDM_SPEC_ATTR;
    void _ssdm_InlineLoop() SSDM_SPEC_ATTR;
    void _ssdm_Inline() SSDM_SPEC_ATTR;
    void _ssdm_InlineSelf() SSDM_SPEC_ATTR;
    void _ssdm_InlineRegion() SSDM_SPEC_ATTR;

    void _ssdm_SpecArrayMap() SSDM_SPEC_ATTR;
    void _ssdm_SpecArrayPartition() SSDM_SPEC_ATTR;
    void _ssdm_SpecArrayReshape() SSDM_SPEC_ATTR;

    void _ssdm_SpecStream() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecStable() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecStableContent() SSDM_SPEC_ATTR;
    
    void _ssdm_op_SpecPipoDepth() SSDM_SPEC_ATTR;

    void _ssdm_SpecExpr() SSDM_SPEC_ATTR;
    void _ssdm_SpecExprBalance() SSDM_SPEC_ATTR;

    void _ssdm_SpecDependence() SSDM_SPEC_ATTR;
                                    
    void _ssdm_SpecLoopMerge() SSDM_SPEC_ATTR;
    void _ssdm_SpecLoopFlatten() SSDM_SPEC_ATTR;
    void _ssdm_SpecLoopRewind() SSDM_SPEC_ATTR;                                

    void _ssdm_SpecFuncInstantiation() SSDM_SPEC_ATTR;
    void _ssdm_SpecFuncBuffer() SSDM_SPEC_ATTR;
    void _ssdm_SpecFuncExtract() SSDM_SPEC_ATTR;
    void _ssdm_SpecConstant() SSDM_SPEC_ATTR;
    
    void _ssdm_DataPack() SSDM_SPEC_ATTR;
    void _ssdm_SpecDataPack() SSDM_SPEC_ATTR;

    void _ssdm_op_SpecBitsMap() SSDM_SPEC_ATTR;
    void _ssdm_op_SpecLicense() SSDM_SPEC_ATTR;
#endif

/*#define _ssdm_op_WaitUntil(X) while (!(X)) _ssdm_op_Wait(1);
#define _ssdm_op_Delayed(X) X */

#define _ssdm_op_BuffRead(buff) (*(buff))
#define _ssdm_op_BuffWrite(buff, data) (*(buff) = data)
#define _ssdm_op_WireRead(buff) (*(buff))
#define _ssdm_op_WireWrite(buff, data) (*(buff) = data)

#endif

#endif

#endif

#endif
