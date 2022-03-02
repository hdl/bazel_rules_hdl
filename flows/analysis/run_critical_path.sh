#!/bin/bash
time CONSTANT_CLOCK_PORT=clk CONSTANT_TOP=$3 OUTPUT_NETLIST=`mktemp -p /tmp XXXXXXXX.v`  INPUT_RTL=$2 bazel run //flows/analysis:critical_path_$1
