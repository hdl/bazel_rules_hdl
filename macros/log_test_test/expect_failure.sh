#!/usr/bin/env bash
set -euo pipefail

if "$1"; then
  echo "log checker unexpectedly passed" >&2
  exit 1
fi
