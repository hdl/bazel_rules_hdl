#!/usr/bin/env python3
"""A tool for copying files to output with additional path fragments appended"""

import argparse
import shutil
from pathlib import Path


def parse_args() -> argparse.Namespace:
    """Parse command line arguments."""
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--append-destination",
        action="append",
        default=[],
        help="An additional directory appended to the destination"
    )

    parser.add_argument(
        "srcs",
        type=Path,
        nargs="*",
        help="Paths to source files",
    )

    parser.add_argument(
        "destination",
        type=Path,
        help="The destination directory"
    )

    return parser.parse_args()


def main() -> None:
    """The main entrypoint"""

    args = parse_args()
    dest = args.destination
    for dir in args.append_destination:
        dest /= dir

    dest.mkdir(exist_ok=True, parents=True)
    for file in args.srcs:
        shutil.copyfile(str(file), str(dest / file.name), follow_symlinks=True)


if __name__ == "__main__":
    main()
