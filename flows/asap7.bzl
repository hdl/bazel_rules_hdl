# Copyright 2021-2022 Google LLC
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

""" Macro for quick ASAP7 basic flow. """

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("//gds_write:build_defs.bzl", "gds_write")
load("//place_and_route:build_defs.bzl", "place_and_route")
load("//static_timing:build_defs.bzl", "run_opensta")
load("//synthesis:build_defs.bzl", "synthesize_rtl")

def asap7_targets(name, target, rev, tracks, vt, has_gds = True, size = 20, corners = ("ccs_ss", "ccs_tt", "ccs_ff")):
    """Generate targets for a quick basic ASAP7 flow.

    Args:
      name: Name for the macro instance.
      target: Verilog library name.
      rev: ASAP7 revision (26 / 27 / 28).
      tracks: Number of tracks ("7p5t", "6t").
      vt: VT type ("rvt", "lvt", "slvt").
      has_gds: Cells have GDS layouts.
      size: Size of the die in microns.
      corners: List of corners to generate rules for (default is `ccs_ss`, `ccs_tt`, `ccs_ff`).
    """
    if rev not in [26, 27, 28]:
        fail("Invalid rev {}".format(repr(rev)))
    if tracks not in ["7p5t", "6t"]:
        fail("Invalid rev {}".format(repr(tracks)))

    # TODO: Add the NLDM support once it works with OpenROAD.
    for corner in corners:
        a = {
            "name": target,
            "tracks": tracks,
            "rev": rev,
            "vt": vt,
            "corn": corner,
        }

        synthesize_rtl(
            name = "{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth".format(**a),
            standard_cells = "@org_theopenroadproject_asap7sc{tracks}_{rev}//:asap7-sc{tracks}_rev{rev}_{vt}-{corn}".format(**a),
            target_clock_period_pico_seconds = 10000,
            top_module = "counter",
            deps = [
                ":{name}".format(**a),
            ],
        )
        build_test(
            name = "build-{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth".format(**a),
            targets = [
                ":{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth".format(**a),
            ],
        )

        run_opensta(
            name = "{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth_sta".format(**a),
            synth_target = ":{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth".format(**a),
        )
        build_test(
            name = "build-{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth_sta".format(**a),
            targets = [
                ":{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth".format(**a),
            ],
        )

        place_and_route(
            name = "{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-place_and_route".format(**a),
            core_padding_microns = 1,
            die_height_microns = size,
            die_width_microns = size,
            placement_density = "0.65",
            sdc = "constraint.sdc",
            synthesized_rtl = ":{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-synth".format(**a),
        )
        build_test(
            name = "build-{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-place_and_route".format(**a),
            targets = [
                ":{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-place_and_route".format(**a),
            ],
        )

        if has_gds:
            gds_write(
                name = "{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-gds".format(**a),
                implemented_rtl = ":{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-place_and_route".format(**a),
            )
            build_test(
                name = "build-{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-gds".format(**a),
                targets = [
                    ":{name}-asap7-sc{tracks}_rev{rev}_{vt}_{corn}-gds".format(**a),
                ],
            )
