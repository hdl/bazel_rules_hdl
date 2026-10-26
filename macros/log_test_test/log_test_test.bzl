"""Test-only helpers for log_test."""

load("@rules_hdl//common:providers.bzl", "LogInfo")
load("@rules_shell//shell:sh_test.bzl", "sh_test")
load("//macros:log_test.bzl", "log_test")

def _log_fixture_impl(ctx):
    return [
        DefaultInfo(files = depset(ctx.files.srcs)),
        LogInfo(files = ctx.files.srcs),
    ]

_log_fixture = rule(
    implementation = _log_fixture_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True, mandatory = True),
    },
)

def log_test_case(name, log, expect_rejection):
    """Checks whether log_test accepts or rejects a static log fixture.

    Args:
        name: Base name used for the generated fixture and test targets.
        log: Label of the static simulation log to check.
        expect_rejection: Whether log_test is expected to reject the log.
    """
    fixture = name + "_log"
    _log_fixture(
        name = fixture,
        srcs = [log],
    )

    if not expect_rejection:
        log_test(
            name = name + "_test",
            log = ":" + fixture,
        )
        return

    checker = name + "_checker"
    log_test(
        name = checker,
        log = ":" + fixture,
        tags = ["manual"],
    )
    sh_test(
        name = name + "_test",
        srcs = ["expect_failure.sh"],
        args = ["$(location :{})".format(checker)],
        data = [":" + checker],
    )
