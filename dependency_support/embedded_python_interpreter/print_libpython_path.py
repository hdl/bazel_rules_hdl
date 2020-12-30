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

"""Prints the path to the libpython shared library."""

from distutils import sysconfig
import os

config_vars = sysconfig.get_config_vars()
file_paths = [
  os.path.join(config_vars[pv], config_vars['LDLIBRARY'])
  for pv in ('LIBDIR', 'LIBPL')
]

if 'rules_hdl_cpython' in config_vars['prefix']:
  # Hack: Work around broken library paths in the hermetic Python toolchain that
  # is used in rules_hdl CI runs (and can optionally be used by its users as
  # well). It reports that the library path is an absolute path like
  #
  #   /install/lib/libpython3.8.so
  #
  # but this path doesn't exist. So we'll fix it here.
  file_paths = [path.replace('/install', config_vars['prefix']) for path in file_paths]

print(list(filter(os.path.exists, file_paths))[0])
