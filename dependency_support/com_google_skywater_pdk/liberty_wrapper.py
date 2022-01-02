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
"""Wrapper script for Python scripts in the Skywater PDK.

This is a workaround to allow running scripts that use relative imports even
though Bazel doesn't run Python binaries with the -m parameter that's required
to make relative imports work.
"""

from skywater_pdk.liberty import main
main()
