# bazel_rules_hdl
Hardware Description Language (Verilog, VHDL, Chisel, nMigen, etc) with open tools (Yosys, Verilator, OpenROAD, etc) rules for Bazel (https://bazel.build)
 
# Project Vision
`hdl/bazel_rules_hdl` is a project that is designed to be a one stop shop for doing hardware dev with bazel. 

Through iteration we hope to eventually become an official bazel ruleset for doing HDL development.

So that includes;

  * Supporting designs targeting FPGAs and ASIC.
  * Supporting software targeted to run on this custom hardware.
  * Supporting testing via simulation, formal verification, emulation and others.

Having rules that can take RTL and be chained to emit GDSII (Sky130/FOSS-PDKs), but that can also be used to target FPGAs and soft CPUs. We want to take advantage of remote builders to accelerate verification with massively parallel clusters. Using the open source community's tools like Yosys, OpenROAD, Verilator, Surelog etc.

The vision of this is that this repository enables `bazel test //mychip/...` and `bazel build //mychip:gds` and in 10 minutes you have verified and emitted a fabricatable design even for the most complex designs.
