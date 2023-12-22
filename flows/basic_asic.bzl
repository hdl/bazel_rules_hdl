# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Very basic ASIC flow, mainly used for testing and debugging."""

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("//gds_write:build_defs.bzl", "gds_write")
load("//place_and_route:build_defs.bzl", "place_and_route")
load("//static_timing:build_defs.bzl", "run_opensta")
load("//synthesis:build_defs.bzl", "synthesize_rtl")

def _get_with_defaults(target_name, extra_args, defaults):
    target_extra_args = dict(**extra_args.pop(target_name, {}))
    for k, v in defaults.items():
        if k not in target_extra_args:
            target_extra_args[k] = v
    return target_extra_args

def basic_asic_flow(name, target, cells, top = None, extra_args = {}, gds = True, size = 20):
    """Generate targets for a basic ASIC flow.

    Args:
        name: Name for the macro instance.
        target: Verilog library name.
        cells: Standard cells to use.
        top: Name of the top level module (defaults to name).
        gds: Run all the way to GDS output.
        extra_args: Extra arguments to provide the steps in the flow.
        size: Size of the die in microns.
    """
    if top == None:
        top = name
    extra_args = dict(**extra_args)

    # Synthesis
    synthesize_rtl(
        name = name + "-step1-synth",
        standard_cells = cells,
        top_module = top,
        deps = [
            target,
        ],
        **_get_with_defaults(
            "synthesize_rtl",
            extra_args,
            dict(
                target_clock_period_pico_seconds = 10000,
            ),
        )
    )
    build_test(
        name = "build-" + name + "-step1-synth",
        targets = [":" + name + "-step1-synth"],
    )

    # Static timing analysis of synthesis result
    run_opensta(
        name = name + "-step1-synth_sta",
        synth_target = ":" + name + "-step1-synth",
        **_get_with_defaults(
            "synth_run_opensta",
            extra_args,
            dict(
                # No defaults at the moment.
            ),
        )
    )
    build_test(
        name = "build-" + name + "-step1-synth_sta",
        targets = [":" + name + "-step1-synth_sta"],
    )

    # Place and Route
    place_and_route(
        name = name + "-step2-place_and_route",
        synthesized_rtl = ":" + name + "-step1-synth",
        **_get_with_defaults(
            "place_and_route",
            extra_args,
            dict(
                placement_density = "0.65",
                core_padding_microns = 1,
                die_height_microns = size,
                die_width_microns = size,
            ),
        )
    )
    build_test(
        name = "build-" + name + "-step2-place_and_route",
        targets = [
            ":" + name + "-step2-place_and_route",
        ],
    )

    # FIXME: Should add a post place and route run_opensta?

    # GDS Generation
    if gds:
        gds_write(
            name = name + "-step3-gds",
            implemented_rtl = ":" + name + "-step2-place_and_route",
            **_get_with_defaults(
                "gds_write",
                extra_args,
                dict(
                    # No defaults at the moment.
                ),
            )
        )
        build_test(
            name = "build-" + name + "-step3-gds",
            targets = [
                ":" + name + "-step3-gds",
            ],
        )

    # Make sure everything in the extra_args dictionary has been used.
    if extra_args:
        fail("{} provided in 'extra_args' was not used, please remove.".format("and ".join(extra_args.keys())))
