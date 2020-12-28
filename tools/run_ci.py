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

import argparse
import os
import shlex
import uuid

def parse_arguments():
  parser = argparse.ArgumentParser()
  parser.add_argument('--user', help='Name of the user that initiated the build')
  return parser.parse_args()

args = parse_arguments()
invocation_id = str(uuid.uuid1())
results_url = "https://app.buildbuddy.io/invocation/%s" % invocation_id
os.system('bazel build' +
    ' --invocation_id=' + invocation_id +
    ' --build_metadata=USER=' + shlex.quote(args.user) +
    ' --config=ciremotebuild //...')
