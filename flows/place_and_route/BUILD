# Copyright 2021 Google LLC
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

# Place and Route tool package.

load("//flows:flows.bzl", "flow_binary", "run_flow")
load("//flows/place_and_route:build_defs.bzl", "openroad_step")

openroad_step(
    name = "hello_openroad",
    outputs = ["hello"],
    script = "hello.tcl",
)

openroad_step(
    name = "goodbye_openroad",
    inputs = ["hello"],
    outputs = ["goodbye"],
    script = "goodbye.tcl",
)

run_flow(
    name = "hello_goodbye",
    flow = [
        "hello_openroad",
        "goodbye_openroad",
    ],
    output_files = ["goodbye.txt"],
    output_names = ["goodbye"],
)

flow_binary(
    name = "hello_goodbye_bin",
    flow = [
        "hello_openroad",
        "goodbye_openroad",
    ],
)
