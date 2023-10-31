#!/usr/bin/env bash
# Copyright 2020 Google LLC
#
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

# Wrapper around iverilog binary. Adds the path to the dependencies to
# the command line of iverilog.

set -eu

dir="$0.runfiles/com_icarus_iverilog"
vvp_dir="${0/%iverilog/vvp}.runfiles/com_icarus_iverilog"

if [[ ! -d "$dir" ]]; then
  dir=$(dirname $0)  # use current directory it not launched directly from the :iverilog target.
fi
if [[ ! -d "$vvp_dir" ]]; then
  vvp_dir=$(dirname $0)  # use current directory it not launched directly from the :iverilog target.
fi

exec "$dir/iverilog-bin" -B"$dir" -BM"$vvp_dir" -DIVERILOG "$@"
