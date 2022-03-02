#!/bin/bash
export CONSTANT_CLOCK_PORT=clk
export CONSTANT_TOP=$3
export OUTPUT_NETLIST=`mktemp -p /tmp XXXXXXXX.v`
export INPUT_RTL=$2
export CONSTANT_REG_START=$4
export CONSTANT_REG_END=$5
time bazel run //flows/analysis:reg2reg_path_$1

