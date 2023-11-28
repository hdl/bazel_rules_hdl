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
        url = ["https://github.com/verilator/verilator/archive/refs/tags/v{}.tar.gz".format(ctx.attr.version)],
        sha256 = ctx.attr.sha256,
        stripPrefix = "verilator-{}".format(ctx.attr.version),
    )

    ctx.file("WORKSPACE", "workspace(name = {name})\n".format(name = repr(ctx.name)))
    ctx.symlink(ctx.attr._buildfile, "BUILD")

    # Generate files usually produced / modified by autotools.
    replace = {
        "#define PACKAGE_STRING \"\"": "#define PACKAGE_STRING \"Verilator v{}\"".format(ctx.attr.version),
    }
    ctx.template("src/config_package.h", "src/config_package.h.in", replace, executable = False)

    ctx.file(
        "src/config_rev.h",
        "static const char* const DTVERSION_rev = \"v{}\";\n".format(ctx.attr.version),
    )

    replace = {
        "@PACKAGE_NAME@": "Verilator",
        "@PACKAGE_VERSION@": ctx.attr.version,
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
        "version": attr.string(
            doc = "The version of verilator to use.",
            default = "5.018",
        ),
        "sha256": attr.string(
            doc = "The sha256 hash for this version of verilator",
            default = "8b544273eedee379e3c1a3bb849e14c754c9b5035d61ad03acdf3963092ba6c0",
        ),
    },
)

def verilator():
    maybe(verilator_repository, name = "verilator")
