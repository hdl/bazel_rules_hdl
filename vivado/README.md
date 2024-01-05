# Vivado rules

The following are defined in `//vivado:defs.bzl`:

* `vivado_create_project`
* `vivado_synthesize`
* `vivado_synthesis_optimize`
* `vivado_placement`
* `vivado_place_optimize`
* `vivado_routing`
* `vivado_write_bitstream`
* `vivado_flow`

## Quickstart

`vivado_flow` macro creates a bitstream by running the following steps:

* `vivado_synthesize`
* `vivado_synthesis_optimize`
* `vivado_placement`
* `vivado_place_optimize`
* `vivado_routing`
* `vivado_write_bitstream`

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
vivado_create_project(
    name = "johnson_counter_project",
    module = ":johnson_counter_top",
    module_top = "johnson_counter_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `create_project_tcl_template` which by default loads [create_project.tcl.template](create_project.tcl.template). This can be modified.

## synthesize

Creates a synthesized checkpoint.

Example from `vivado/tests`:
```
vivado_synthesize(
    name = "johnson_counter_synth",
    module = ":johnson_counter_top",
    module_top = "johnson_counter_top",
    part_number = "xczu28dr-ffvg1517-2-e",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `create_project_tcl_template` which by default loads [create_project.tcl.template](create_project.tcl.template). This can be modified.

There is another optional argument `synth_strategy` which defaults to `Vivado Synthesis Defaults`. Look at synthesis strategies in vivado to see different options.

## synthesis_optimize

Runs `opt_design` on the synthesis checkpoint. Outputs a new synthesis checkpoint.

Example from `vivado/tests`:
```
vivado_synthesis_optimize(
    name = "johnson_counter_synth_opt",
    checkpoint = ":johnson_counter_synth",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `synth_optimize_tcl_template` which by default loads [synth_optimize.tcl.template](synth_optimize.tcl.template). This can be modified.

There is an optional argument `opt_directive` which defaults to `Explore`.

## placement

Place the design. Accepts a synthesis checkpoint and generates a placement checkpoint.

Example from `vivado/tests`:
```
vivado_placement(
    name = "johnson_counter_placement",
    checkpoint = ":johnson_counter_synth_opt",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `placement_tcl_template` which by default loads [placement.tcl.template](placement.tcl.template). This can be modified.

## place_optimize

Runs `phys_opt_design`. Accepts a placement checkpoint and generates a placement checkpoint.

Example from `vivado/tests`:
```
vivado_place_optimize(
    name = "johnson_counter_place_opt",
    checkpoint = ":johnson_counter_placement",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `place_optimize_tcl_template` which by default loads [place_optimize.tcl.template](place_optimize.tcl.template). This can be modified.

## routing

Routes the design. Accepts a placement checkpoint and generates a routed checkpoint.

Example from `vivado/tests`:
```
vivado_routing(
    name = "johnson_counter_route",
    checkpoint = ":johnson_counter_place_opt",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `route_tcl_template` which by default loads [route.tcl.template](route.tcl.template). This can be modified.

There is an optional argument `route_directive` which defaults to `Explore`.

## write_bitstream

Writes a bitstream. Accepts a routed checkpoint and generates a bitstream.

Example from `vivado/tests`:
```
vivado_write_bitstream(
    name = "johnson_counter_bit",
    checkpoint = ":johnson_counter_route",
    xilinx_env = ":xilinx_env.sh",
)
```

It has the optional argument `write_bitstream_tcl_template` which by default loads [write_bitstream.tcl.template](write_bitstream.tcl.template). This can be modified.

Optionally set `with_xsa = True` to generate the `.xsa` file.

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

It has the optional argument `xsim_test_template` which by default loads [xsim_test_template.tcl.template](xsim_test_template.tcl.template). This can be modified.

It is tagged as `manual` so it is not run by CI tools. They do not have vivado installed.

To get a waveform, do not use `bazel test`, use `bazel run` instead. For example
`bazel run //vivado/tests:xsim_smoke_test` will then generate something like `bazel-out/k8-fastbuild/bin/vivado/tests/xsim_smoke_test.wdb`.

To open this waveform in vivado:

```
current_fileset
open_wave_database bazel-out/k8-fastbuild/bin/vivado/tests/xsim_smoke_test.wdb
```

To test a module that depends on ip blocks, the ip vlocks need to be added in `ip_blocks` field.
```
xsim_test(
    name = "weights_replay_and_save_xsim",
    ip_blocks = [
        ":weights_replay_and_save_ip",
    ],
    module = ":weights_replay_and_save_tb",
    module_top = "weights_replay_and_save_tb",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)
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

If an ip block relies on other ip blocks, the `ip_blocks` field needs to be updated.
```
vivado_create_ip(
    name = "weights_replay_and_save_ip",
    ip_blocks = [
        ":weights_replay_ip",
        ":weights_ram_ip",
    ],
    ip_library = "test",
    ip_vendor = "test_vendor",
    ip_version = "0.1",
    module = ":weights_replay_and_save_bd",
    module_top = "weights_replay_and_save",
    part_number = "xczu28dr-ffvg1517-2-e",
    tags = ["manual"],
    xilinx_env = ":xilinx_env.sh",
)
```
