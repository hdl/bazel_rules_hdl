#!/usr/bin/env python3
"""A tool for copying generated verilator outputs into unique source and header directories."""

import argparse
import shutil
from pathlib import Path


def parse_args() -> argparse.Namespace:
    """Parse command line arguments."""
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--src_output",
        type=Path,
        required=True,
        help="The output directory for source (cc/cpp) files.",
    )

    parser.add_argument(
        "--hdr_output",
        type=Path,
        required=True,
        help="The output directory for source (h/hpp) files.",
    )

    parser.add_argument(
        "--src",
        dest="srcs",
        type=Path,
        default=[],
        action="append",
        help="The path to an input source file.",
    )

    parser.add_argument(
        "--hdr",
        dest="hdrs",
        type=Path,
        default=[],
        action="append",
        help="The path to an input header file.",
    )

    return parser.parse_args()


def main() -> None:
    """The main entrypoint"""

    args = parse_args()

    for files, output in [(args.srcs, args.src_output), (args.hdrs, args.hdr_output)]:
        output.mkdir(exist_ok=True, parents=True)
        for file in files:
            dest = output / file.name
            shutil.copyfile(str(file), str(dest), follow_symlinks=True)


if __name__ == "__main__":
    main()
