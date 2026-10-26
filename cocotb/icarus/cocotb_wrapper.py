# Copyright 2026 bazel_rules_hdl Authors
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

from rules_hdl_cocotb_wrapper.common import (
    cocotb_argument_parser,
    get_build_flags,
    prepare_runner,
    run_tests,
)


if __name__ == "__main__":
    parser = cocotb_argument_parser()
    args = parser.parse_args()
    runner, test_flags = prepare_runner(args, "icarus")
    runner.build(**get_build_flags(args))
    run_tests(runner, test_flags)
