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

'''This script is used by CI builds. It reports the Bazel build log link to
GitHub. This is done as a workaround for Cloud Build's lack of ability to share
build logs with the public.'''

import argparse
import json
from jwt import JWT, jwk_from_pem
import requests
import subprocess
import time

def parse_arguments():
  parser = argparse.ArgumentParser()
  parser.add_argument('--head_sha', help='The git hash of the current commit', required=True)
  parser.add_argument('--build_invocation_id', help='Bazel invocation id for building', required=True)
  parser.add_argument('--test_invocation_id', help='Bazel invocation id for testing', required=True)
  parser.add_argument('--github_app_key_file', help='Path to the private key for the GitHub App to use for status reporting', required=True)
  return parser.parse_args()

def read_key_file(path):
  with open(path, 'rb') as file:
    return jwk_from_pem(file.read())

def generate_jwt_token(private_key):
  current_time = int(time.time())
  return JWT().encode({
    # Issued at time
    'iat': current_time,
    # JWT expiration time (10 minute maximum)
    'exp': current_time + 10 * 60,
    # GitHub app identifier
    'iss': 94194,
  }, private_key, alg='RS256')

def find_installation_id(jwt_token):
  response = requests.get('https://api.github.com/app/installations', headers={
    'Authorization': 'Bearer %s' % jwt_token,
    'Accept': 'application/vnd.github.v3+json',
  })
  response.raise_for_status()
  return response.json()[0]['id']

def generate_installation_access_token(jwt_token, installation_id):
  response = requests.post('https://api.github.com/app/installations/%s/access_tokens' % installation_id, headers={
    'Authorization': 'Bearer %s' % jwt_token,
    'Accept': 'application/vnd.github.v3+json',
  })
  response.raise_for_status()
  return response.json()['token']

def report_build_status(installation_access_token, head_sha, invocation_id, invocation_name):
  log_url = "https://app.buildbuddy.io/invocation/%s" % invocation_id
  response = requests.post('https://api.github.com/repos/hdl/bazel_rules_hdl/check-runs', headers={
    'Authorization': 'token %s' % installation_access_token,
    'Accept': 'application/vnd.github.v3+json',
  }, data=json.dumps({
    'name': 'Bazel %s Log' % invocation_name,
    'head_sha': head_sha,
    'details_url': log_url,
    'status': 'completed',
    'conclusion': 'neutral',
    'output': {
      'title': 'Bazel %s Log' % invocation_name,
      'summary': '[Bazel %s Log](%s)' % (invocation_name, log_url),
    },
  }))
  response.raise_for_status()

args = parse_arguments()
private_github_app_key = read_key_file(args.github_app_key_file)

jwt_token = generate_jwt_token(private_github_app_key)
installation_id = find_installation_id(jwt_token)
installation_access_token = generate_installation_access_token(jwt_token, installation_id)
report_build_status(installation_access_token, args.head_sha, args.build_invocation_id, 'Build')
report_build_status(installation_access_token, args.head_sha, args.test_invocation_id, 'Test')
