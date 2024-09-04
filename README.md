# bazel_rules_hdl
Hardware Description Language (Verilog, VHDL, Chisel, nMigen, etc) with open tools (Yosys, Verilator, OpenROAD, etc) rules for Bazel (https://bazel.build)

**THIS REPO REQUIRES BAZEL 5.4.0 or greater**

## Installation

In your `WORKSPACE` file. Which is a file at the top directory of every bazel
repo:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# You don't need these variables, but are useful for configurability.
# Feel free to hardcode these values in the maybe http_archive below.
rules_hdl_git_hash = "{LATEST_HASH}"
rules_hdl_git_sha256 = "{LATEST_SHA}"

maybe(
    http_archive,
    name = "rules_hdl",
    sha256 = rules_hdl_git_sha256,
    strip_prefix = "bazel_rules_hdl-%s" % rules_hdl_git_hash,
    urls = [
        "https://github.com/hdl/bazel_rules_hdl/archive/%s.tar.gz" % rules_hdl_git_hash,
    ],
)

load("@rules_hdl//dependency_support:dependency_support.bzl", rules_hdl_dependency_support = "dependency_support")
rules_hdl_dependency_support()

load("@rules_hdl//:init.bzl", rules_hdl_init = "init")
rules_hdl_init()
```

## Usage

See the following build file to synthesize a final ASIC design for a given piece
of RTL written in verilog.

This file is called `counter.v`. It is a 128 bit counter incremented on every
positive edge of a clock signial.

```verilog
module counter(
  input wire clk,
  input wire reset,
  output [127:0] out,
);
  reg [127:0] counter_tmp;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      counter_tmp <= 0;
    end else begin
      counter_tmp <= counter_tmp + 1;
    end
  end

  assign out = counter_tmp;

endmodule

```

The default PDK used is the Sky130 High Density standard cells.

This is the `BUILD` file. Every thing in bazel needs a rule description of what
to build. The rules use yosys and OpenROAD to place and route your design.

```python
load("@rules_hdl//synthesis:defs.bzl", "synthesize_rtl")
load("@rules_hdl//place_and_route:build_defs.bzl", "place_and_route")
load("@rules_hdl//verilog:defs.bzl", "verilog_library")

place_and_route(
    name = "counter_place_and_route",
    clock_period = "10",
    core_padding_microns = 20,
    die_height_microns = 200,
    die_width_microns = 200,
    placement_density = "0.7",
    synthesized_rtl = ":verilog_counter_synth",
)

synthesize_rtl(
    name = "verilog_counter_synth",
    top_module = "counter",
    deps = [
        ":verilog_counter",
    ],
)

verilog_library(
    name = "verilog_counter",
    srcs = [
        "counter.v",
    ],
)
```

At this point you should have the following three files at the top of your bazel
workspace.

```
BUILD
counter.v
WORKSPACE
```

When you run `bazel build //:counter_place_and_route`. It will output log files
and a def file that represents the fully placed and routed design.

# Project Vision
`hdl/bazel_rules_hdl` is a project that is designed to be a one stop shop for doing hardware dev with bazel.

Through iteration we hope to eventually become an official bazel ruleset for doing HDL development.

So that includes;

  * Supporting designs targeting FPGAs and ASIC.
  * Supporting software targeted to run on this custom hardware.
  * Supporting testing via simulation, formal verification, emulation and others.

Having rules that can take RTL and be chained to emit GDSII (Sky130/FOSS-PDKs), but that can also be used to target FPGAs and soft CPUs. We want to take advantage of remote builders to accelerate verification with massively parallel clusters. Using the open source community's tools like Yosys, OpenROAD, Verilator, Surelog etc.

The vision of this is that this repository enables `bazel test //mychip/...` and `bazel build //mychip:gds` and in 10 minutes you have verified and emitted a fabricatable design even for the most complex designs.

# Contributing

## Testing

For testing pull requests please run:

```console
bazel_rules_hdl$ python tools/test_everything.py
```

Note: `bazel test ...` does not run the tests in Bazel "remote" repositories,
and `bazel_rules_hdl` bundles together support for several remote repositories
-- this script serves as a helper for testing them all explicitly.
