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
 * @file PageRank.h
 * @brief PageRank function implementation.
 *
 * This file is part of HLS graph library.
 */

#ifndef _X_HLSGRAPH_H_
#error \
    "hlsgraph/PageRank.h should not be inlcuded directly, use top-level hlsgraph.h instead!"
#endif

// PageRank.h
#ifndef _X_HLSGRAPH_PAGERANK_H_
#define _X_HLSGRAPH_PAGERANK_H_

#define ALPHA 0.85 // default alpha, the pagerank damping factor
#define CONVERGENCE 0.00001 // default convergence
#define MAX_ITERATIONS 10000 // default max iterations
#define SOURCE 0 // source vertex for a personalized PageRank

namespace hlsgraph {

void PageRank(
    edge_t edges[NUM_EDGES], // a set of directional edges from edges[e].src to edges[e].dst
    double pr_out[NUM_VERTICES] // pagerank output
);

} // namespace hlsgraph

#endif // ifndef _HLSGRAPH_PAGERANK_H_


