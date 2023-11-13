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

"""Utility functions to prepare the comibined liberty file."""

import itertools
import mmap
from typing import List, Union

from pdk.liberty import cell_parser


def generate_merged_liberty_io_vector(
    liberty_files: List[Union[bytes, mmap.mmap]]) -> List[bytes]:
  """Generates a merged io vector representing a combined liberty file.

  Args:
    liberty_files: byte sequences with each index representing a liberty file.

  Returns:
    IO Vector representing a combined liberty file.

  """
  first_file, *cell_extraction_targets = liberty_files

  extracted_cells = [
      cell_parser.extract_cells(liberty_file)
      for liberty_file in cell_extraction_targets
  ]
  # We want a list of cells. The statement above is a list of lists.
  # This operation will flatten our list.
  extracted_cells = list(itertools.chain(*extracted_cells))

  cell_insertion_point = first_file.find(b'cell (')

  assert cell_insertion_point != -1

  io_vector = []
  io_vector.append(liberty_files[0][0:cell_insertion_point])
  io_vector.extend(extracted_cells)
  io_vector.append(liberty_files[0][cell_insertion_point:])
  return io_vector
