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
 *     (c) Copyright 2008-2012 Xilinx Inc.
 *     All rights reserved.
 *
 *****************************************************************************/
#ifndef _X_HLS_COMPARISON_APFIXED_H_
#define _X_HLS_COMPARISON_APFIXED_H_
#include "ap_fixed.h"
#include "ap_int.h"


//isgreater(ap_fixed)
template<int W, int I>
bool  isgreater_fixed(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    if(x1 > x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int W, int I>
bool  isgreater_fixed(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    if(x1 > x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  isgreater_fixed(ap_int<I> x1, ap_int<I> x2){
    if(x1 > x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  isgreater_fixed(ap_uint<I> x1, ap_uint<I> x2){
    if(x1 > x2) {
        return true;
    }
    else {
        return false;
    }
}

//isgreaterequal(ap_fixed)
template<int W, int I>
bool  isgreaterequal_fixed(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    if(x1 >= x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int W, int I>
bool  isgreaterequal_fixed(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    if(x1 >= x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  isgreaterequal_fixed(ap_int<I> x1, ap_int<I> x2){
    if(x1 >= x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  isgreaterequal_fixed(ap_uint<I> x1, ap_uint<I> x2){
    if(x1 >= x2) {
        return true;
    }
    else {
        return false;
    }
}

//isless(ap_fixed)
template<int W, int I>
bool  isless_fixed(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    if(x1 < x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int W, int I>
bool  isless_fixed(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    if(x1 < x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  isless_fixed(ap_int<I> x1, ap_int<I> x2){
    if(x1 < x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  isless_fixed(ap_uint<I> x1, ap_uint<I> x2){
    if(x1 < x2) {
        return true;
    }
    else {
        return false;
    }
}

//islessequal(ap_fixed)
template<int W, int I>
bool  islessequal_fixed(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    if(x1 <= x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int W, int I>
bool  islessequal_fixed(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    if(x1 <= x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  islessequal_fixed(ap_int<I> x1, ap_int<I> x2){
    if(x1 <= x2) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  islessequal_fixed(ap_uint<I> x1, ap_uint<I> x2){
    if(x1 <= x2) {
        return true;
    }
    else {
        return false;
    }
}

//islessgreater(ap_fixed)
template<int W, int I>
bool  islessgreater_fixed(ap_fixed<W,I> x1, ap_fixed<W,I> x2){
    if((x1 < x2) || (x1 > x2)) {
        return true;
    }
    else {
        return false;
    }
}
template<int W, int I>
bool  islessgreater_fixed(ap_ufixed<W,I> x1, ap_ufixed<W,I> x2){
    if((x1 < x2) || (x1 > x2)) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  islessgreater_fixed(ap_int<I> x1, ap_int<I> x2){
    if((x1 < x2) || (x1 > x2)) {
        return true;
    }
    else {
        return false;
    }
}
template<int I>
bool  islessgreater_fixed(ap_uint<I> x1, ap_uint<I> x2){
    if((x1 < x2) || (x1 > x2)) {
        return true;
    }
    else {
        return false;
    }
}




#endif


