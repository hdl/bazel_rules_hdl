#!/bin/bash
export CONSTANT_CLOCK_PORT=clk
export CONSTANT_TOP=$3
export OUTPUT_NETLIST=`mktemp -p /tmp XXXXXXXX.v`
export INPUT_RTL=$2
time bazel run //flows/analysis:pipeline_balance_$1

