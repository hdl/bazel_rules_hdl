# Copyright 2023 Antmicro
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

import argparse
from cocotb.runner import get_runner, check_results_file


cocotb_build_flags = [
    "hdl_library",
    "verilog_sources",
    "vhdl_sources",
    "includes",
    "defines",
    "parameters",
    "build_args",
    "hdl_toplevel",
    "always",
    "build_dir",
    "verbose",
]


cocotb_test_flags = [
    "test_module",
    "hdl_toplevel",
    "hdl_toplevel_library",
    "hdl_toplevel_lang",
    "gpi_interfaces",
    "testcase",
    "seed",
    "test_args",
    "plusargs",
    "extra_env",
    "waves",
    "gui",
    "parameters",
    "build_dir",
    "test_dir",
    "results_xml",
    "verbose",
]


def filter_args(kwargs, keys):
    return {k: v for (k, v) in kwargs.items() if k in keys}


def cocotb_argument_parser():
    class ParseDict(argparse.Action):
        def __call__(self, parser, namespace, values, option_string=None):
            setattr(namespace, self.dest, dict())
            for value in values:
                key, value = value.split("=")
                getattr(namespace, self.dest)[key] = value

    parser = argparse.ArgumentParser(description="Runs the Cocotb framework from Bazel")

    parser.add_argument("--sim", default="icarus", help="Dafault simulator")
    parser.add_argument(
        "--hdl_library", default="top", help="The library name to compile into"
    )
    parser.add_argument(
        "--verilog_sources", nargs="*", default=[], help="Verilog source files to build"
    )
    parser.add_argument(
        "--vhdl_sources", nargs="*", default=[], help="VHDL source files to build"
    )
    parser.add_argument(
        "--includes", nargs="*", default=[], help="Verilog include directories"
    )
    parser.add_argument(
        "--defines", nargs="*", default={}, action=ParseDict, help="Defines to set"
    )
    parser.add_argument(
        "--parameters",
        nargs="*",
        default={},
        action=ParseDict,
        help="Verilog parameters or VHDL generics",
    )
    parser.add_argument(
        "--build_args",
        nargs="*",
        default=[],
        help="Extra build arguments for the simulator",
    )
    parser.add_argument(
        "--hdl_toplevel", default=None, help="Name of the HDL toplevel module"
    )
    parser.add_argument(
        "--always",
        default=False,
        action="store_true",
        help="Name of the HDL toplevel module",
    )
    parser.add_argument(
        "--build_dir", default="sim_build", help="Directory to run the build step in"
    )
    parser.add_argument(
        "--verbose", default=False, action="store_true", help="Enable verbose messages"
    )
    parser.add_argument(
        "--test_module",
        nargs="*",
        default=[],
        help="Name(s) of the Python module(s) containing the tests to run",
    )
    parser.add_argument(
        "--hdl_toplevel_library", help="The library name for HDL toplevel module"
    )
    parser.add_argument(
        "--hdl_toplevel_lang", default=None, help="Language of the HDL toplevel module"
    )
    parser.add_argument(
        "--gpi_interfaces",
        default=None,
        help="List of GPI interfaces to use, with the first one being the entry point",
    )
    parser.add_argument(
        "--testcase", default=None, help="Name(s) of a specific testcase(s) to run"
    )
    parser.add_argument("--seed", default=None, help="A specific random seed to use")
    parser.add_argument(
        "--plusargs", default=[], help="'plusargs' to set for the simulator"
    )
    parser.add_argument(
        "--extra_env",
        nargs="*",
        default={},
        action=ParseDict,
        help="Extra environment variables to set",
    )
    parser.add_argument(
        "--waves", action="store_true", default=None, help="Record signal traces"
    )
    parser.add_argument(
        "--gui", action="store_true", default=None, help="Record signal traces"
    )
    parser.add_argument(
        "--test_dir", default=None, help="Directory to run the build step in"
    )
    parser.add_argument(
        "--results_xml",
        default="results.xml",
        help="Name of xUnit XML file to store test results in",
    )

    return parser


if __name__ == "__main__":
    parser = cocotb_argument_parser()
    args = parser.parse_args()

    build_flags = filter_args(vars(args), cocotb_build_flags)
    test_flags = filter_args(vars(args), cocotb_test_flags)

    runner = get_runner(args.sim)
    runner.build(**build_flags)
    results_xml = runner.test(**test_flags)
    check_results_file(results_xml)
