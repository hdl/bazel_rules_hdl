#!/usr/bin/env python3
"""
A wrapper to run binaries.

A wrapper is needed for capturing stdout/stderr. Bazel can't do that on its
own yet. See https://github.com/bazelbuild/bazel/issues/5511
"""
import sys
import os
import shutil
import argparse
import subprocess


def main():

    # Parse args
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--workdir",
        default=None,
        help="Work directory for the binary to be run in",
    )
    parser.add_argument(
        "--stdout",
        type=str,
        default=None,
        help="Path to a file to redirect stdout to",
    )
    parser.add_argument(
        "--stderr",
        type=str,
        default=None,
        help="Path to a file to redirect stderr to",
    )
    parser.add_argument(
        "--coverage",
        type=str,
        default=None,
        help="File name to move 'coverage.dat' to",
    )

    ns, args = parser.parse_known_args()

    # The first argument is the binary name
    if not args:
        print("Name of the binary to run not provided")
        sys.exit(-1)

    binary, args = args[0], args[1:]

    print(f"Running '{binary}' with {args}")
    print(f" stdout  : {ns.stdout}")
    print(f" stderr  : {ns.stderr}")

    if ns.coverage:
        print(f" coverage: {ns.coverage}")

    # Run the process, capture output
    o = open(ns.stdout, "w") if ns.stdout else None
    e = open(ns.stderr, "w") if ns.stderr else None

    p = subprocess.run(
        [binary] + args,
        cwd=ns.workdir,
        stdout=o,
        stderr=e,
    )

    # Move the coverage file
    if ns.coverage:
        coverage = "coverage.dat"
        if os.path.isfile(coverage):
            shutil.move(coverage, ns.coverage)
        else:
            print("WARNING: 'coverage.dat' has not been written!")

    sys.exit(p.returncode)


if __name__ == "__main__":
    main()
