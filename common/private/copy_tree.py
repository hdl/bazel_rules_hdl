#!/usr/bin/env python3
"""A tool for copying files to output with additional path fragments appended"""

import argparse
import shutil
import sys
from pathlib import Path
from itertools import batched


def parse_args() -> argparse.Namespace:
    """Parse command line arguments."""
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "paths_pairs",
        type=Path,
        nargs="*",
        # Destination is first to make the script easy to use with ctx.actions.args().add_all()
        help="Pairs of paths, destination directory followed by source file",
    )

    return parser.parse_args()


def main() -> None:
    """The main entrypoint"""

    args = parse_args()
    paths_pairs = args.paths_pairs

    if len(paths_pairs) % 2:
        sys.exit("Count of paths must be even")

    for destination, source in batched(paths_pairs, n=2):
        destination.mkdir(exist_ok=True, parents=True)
        shutil.copyfile(source, destination / source.name, follow_symlinks=True)


if __name__ == "__main__":
    main()
