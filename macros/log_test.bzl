"""Checks for errors in simulation logs."""

load("//common:providers.bzl", "LogInfo")

def _shell_quote(value):
    """Quotes one value so Bash treats it as literal text, including embedded apostrophes."""
    return "'" + value.replace("'", "'\"'\"'") + "'"

def _log_test(ctx):
    logs = ctx.attr.log[LogInfo].files
    on_error = "res=0" if "allowed_to_fail" in ctx.attr.tags else "res=1"
    lines = [
        "#!/usr/bin/env bash",
        "res=0",
    ]
    patterns = [
        "^Fatal:.+[[:space:]]at[[:space:]]time[[:space:]].+$",
        "^TEST[[:space:]]FAILED[[:space:]]CHECKS",
        "^Error:",
        "Offending",
        "[[:space:]]*%Fatal:.+Assertion failed in[[:space:]]",
        "^UVM TEST FAILED$",
        "^UVM_FATAL @",
        "^UVM_ERROR @",
    ]

    for log in logs:
        path = _shell_quote(log.short_path)
        for pattern in patterns:
            lines.append("grep -E -m 1 -- {} {} && {}".format(
                _shell_quote(pattern),
                path,
                on_error,
            ))

    lines.append("exit $res")
    executable = ctx.actions.declare_file(ctx.label.name + ".sh")
    ctx.actions.write(
        output = executable,
        content = "\n".join(lines) + "\n",
        is_executable = True,
    )

    runfiles = ctx.runfiles(files = logs + ctx.attr.log[DefaultInfo].files.to_list())
    return [DefaultInfo(executable = executable, runfiles = runfiles)]

log_test = rule(
    implementation = _log_test,
    attrs = {
        "log": attr.label(
            doc = "A target providing LogInfo.",
            mandatory = True,
            providers = [DefaultInfo, LogInfo],
        ),
    },
    test = True,
)
