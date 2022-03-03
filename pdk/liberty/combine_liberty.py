# Copyright 2022 Google LLC
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
"""Combine multiple liberty files into a single liberty file."""

import mmap
from typing import Sequence

from absl import app
from absl import flags

from pdk.liberty import liberty_utility

_LIBERTY_FILES = flags.DEFINE_multi_string(
    'liberty_files',
    None,
    help="""Set of liberty files to merge into a single output.
    Needs least two files.""",
    required=True)

_OUTPUT = flags.DEFINE_string('output', None, 'output directory', required=True)


def open_memory_mapped_file(file_location: str) -> mmap.mmap:
  """Opens a file as a memory mapped object.

  Args:
    file_location: location of file to be read.

  Returns:
    The memory mapped file.
  """
  try:
    fd = open(file_location, 'r')
    return mmap.mmap(fd.fileno(), 0, access=mmap.ACCESS_READ)
  except EnvironmentError as e:
    raise app.UsageError(f'Failed to read file {e}')


def main(argv: Sequence[str]) -> None:
  if len(argv) > 1:
    raise app.UsageError('Too many command-line arguments.')

  if len(_LIBERTY_FILES.value) < 2:
    raise app.UsageError('Must provide at least two liberty files: --liberty')

  liberty_files_mmap = [
      open_memory_mapped_file(file) for file in _LIBERTY_FILES.value
  ]

  final_liberty = liberty_utility.generate_merged_liberty_io_vector(
      liberty_files_mmap)
  final_liberty = b''.join(final_liberty)
  final_liberty = final_liberty.replace(b'_x1)', b')')

  with open(_OUTPUT.value, 'wb') as f:
    f.write(final_liberty)


if __name__ == '__main__':
  app.run(main)
