# Vivado rules

The following are defined in `//vivado:defs.bzl`:

* `create_project`
* `synthesize`
* `synthesis_optimize`
* `placement`
* `place_optimize`
* `routing`
* `write_bitstream`
* `vivado_flow`

## Quickstart

`vivado_flow` macro creates a bitstream by running the following steps:

* `synthesize`
* `synthesis_optimize`
* `placement`
* `place_optimize`
* `routing`
* `write_bitstream`

Example from `vivado/tests`:
```
load("//vivado:defs.bzl", "vivado_flow")

vivado_flow(
    name = "johnson_counter_vivado",
    module = ":johnson_counter_top",
    module_top = "johnson_counter_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    xilinx_env = ":xilinx_env.sh",
)
```

Portions of the flow can be run such as:
* `bazel build //vivado/tests:johnson_counter_vivado_synth`
* `bazel build //vivado/tests:johnson_counter_vivado_synth_opt`
* `bazel build //vivado/tests:johnson_counter_vivado_placement`
* `bazel build //vivado/tests:johnson_counter_vivado_place_opt`
* `bazel build //vivado/tests:johnson_counter_vivado_route`

Or everything with: `bazel build //vivado/tests:johnson_counter_vivado`

## create_project

Creates a vivado project from the sources. This is useful to experiment or check things.

Example from `vivado/tests`:
```
create_project(
    name = "johnson_counter_project",
    module = ":johnson_counter_top",
    module_top = "johnson_counter_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `_create_project_tcl_template` which by default loads [create_project.tcl.template](create_project.tcl.template). This can be modified.

## synthesize

Creates a synthesized checkpoint.

Example from `vivado/tests`:
```
synthesize(
    name = "johnson_counter_synth",
    module = ":johnson_counter_top",
    module_top = "johnson_counter_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `_create_project_tcl_template` which by default loads [create_project.tcl.template](create_project.tcl.template). This can be modified.

There is another optional argument `synth_strategy` which defaults to `Vivado Synthesis Defaults`. Look at synthesis strategies in vivado to see different options.

## synthesis_optimize

Runs `opt_design` on the synthesis checkpoint. Outputs a new synthesis checkpoint.

Example from `vivado/tests`:
```
synthesis_optimize(
    name = "johnson_counter_synth_opt",
    checkpoint = ":johnson_counter_synth",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `_synth_optimize_tcl_template` which by default loads [synth_optimize.tcl.template](synth_optimize.tcl.template). This can be modified.

There is an optional argument `opt_directive` which defaults to `Explore`.

## placement

Place the design. Accepts a synthesis checkpoint and generates a placement checkpoint.

Example from `vivado/tests`:
```
placement(
    name = "johnson_counter_placement",
    checkpoint = ":johnson_counter_synth_opt",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `_placement_tcl_template` which by default loads [placement.tcl.template](placement.tcl.template). This can be modified.

## place_optimize

Runs `phys_opt_design`. Accepts a placement checkpoint and generates a placement checkpoint.

Example from `vivado/tests`:
```
place_optimize(
    name = "johnson_counter_place_opt",
    checkpoint = ":johnson_counter_placement",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `_place_optimize_tcl_template` which by default loads [place_optimize.tcl.template](place_optimize.tcl.template). This can be modified.

## routing

Routes the design. Accepts a placement checkpoint and generates a routed checkpoint.

Example from `vivado/tests`:
```
routing(
    name = "johnson_counter_route",
    checkpoint = ":johnson_counter_place_opt",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `_route_tcl_template` which by default loads [route.tcl.template](route.tcl.template). This can be modified.

There is an optional argument `route_directive` which defaults to `Explore`.

## write_bitstream

Writes a bitstream. Accepts a routed checkpoint and generates a bitstream.

Example from `vivado/tests`:
```
write_bitstream(
    name = "johnson_counter_bit",
    checkpoint = ":johnson_counter_route",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `_write_bitstream_tcl_template` which by default loads [write_bitstream.tcl.template](write_bitstream.tcl.template). This can be modified.

## xsim_test

Executes a test bench using the vivado simulator, xsim.

Example from `vivado/tests`:
```
xsim_test(
    name = "xsim_smoke_test",
    module = ":xsim_smoke_tb",
    module_top = "xsim_smoke_tb",
    part_number = "xczu28dr-ffvg1517-2-e",
    xilinx_env = ":xilinx_env.sh",
    with_waveform = True,
    tags = ["manual"],
)
```

It has the optional argument `_xsim_test_template` which by default loads [_xsim_test_template.tcl.template](_xsim_test_template.tcl.template). This can be modified.

It is tagged as `manual` so it is not run by CI tools. They do not have vivado installed.

To get a waveform, do not use `bazel test`, use `bazel run` instead. For example
`bazel run //vivado/tests:xsim_smoke_test` will then generate something like `bazel-out/k8-fastbuild/bin/vivado/tests/xsim_smoke_test.wdb`.

To open this waveform in vivado:

```
current_fileset
open_wave_database bazel-out/k8-fastbuild/bin/vivado/tests/xsim_smoke_test.wdb
```

## vivado_create_ip

Creates and IP block from a module for vivado.

Example from `vivado/tests`:
```
vivado_create_ip(
    name = "weights_replay_ip",
    module = ":weights_replay",
    module_top = "weights_replay",
    part_number = "xczu28dr-ffvg1517-2-e",
    ip_version = "0.1",
    ip_library = "test",
    ip_vendor = "test_vendor",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)
```

This will generate an ip repository directory that can be included in vivado projects.
