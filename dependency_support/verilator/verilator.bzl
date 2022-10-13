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
#
# Original implementation by Kevin Kiningham (@kkiningh) in kkiningh/rules_verilator.
# Ported to bazel_rules_hdl by Stephen Tridgell (@stridge-cruxml)
"""Download and build verilator"""

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def _verilator_repository_impl(ctx):
    ctx.download_and_extract(
        url = ["https://github.com/verilator/verilator/archive/refs/tags/v4.224.tar.gz"],
        sha256 = "010ff2b5c76d4dbc2ed4a3278a5599ba35c8ed4c05690e57296d6b281591367b",
        stripPrefix = "verilator-4.224",
    )

    ctx.file("WORKSPACE", "workspace(name = {name})\n".format(name = repr(ctx.name)))
    ctx.symlink(ctx.attr._buildfile, "BUILD")

    # Generate files usually produced / modified by autotools.
    replace = {
        "#define PACKAGE_STRING \"\"": "#define PACKAGE_STRING \"Verilator v4.224\"",
    }
    ctx.template("src/config_build.h", "src/config_build.h.in", replace, executable = False)

    ctx.file(
        "src/config_rev.h",
        "static const char* const DTVERSION_rev = \"v4.224\";\n",
    )

    replace = {
        "@PACKAGE_NAME@": "Verilator",
        "@PACKAGE_VERSION@": "4.224",
    }
    ctx.template(
        "include/verilated_config.h",
        "include/verilated_config.h.in",
        replace,
        executable = False,
    )

verilator_repository = repository_rule(
    _verilator_repository_impl,
    attrs = {
        "_buildfile": attr.label(
            default = Label("@rules_hdl//dependency_support/verilator:verilator.BUILD"),
        ),
    },
)

def verilator():
    maybe(verilator_repository, name = "verilator_v4.224")
