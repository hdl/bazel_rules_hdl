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

    # TODO(stridge-crumxl) Find a better solution for this.
    # For some reason the version is showing up as "redacted" in bison --version.
    # Very hacky way to correct it where it will read hardcoded 3.5 instead.
    replace = {
        "out = str(sp.stdout.read())": "out = \"3.5\"",
    }
    ctx.template("src/bisonpremod", "src/bisonpre", replace, executable = True)

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
