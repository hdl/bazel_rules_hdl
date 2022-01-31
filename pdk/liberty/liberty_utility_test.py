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

"""Tests for liberty_utility."""

import unittest

from pdk.liberty import liberty_utility


class LibertyUtilityTest(unittest.TestCase):

  def test_correctly_mergers_two_liberty_files(self):
    cell_and = """cell (AND_X1) {
        cell_fall (delay_template) {
        }
        fall_transition(delay_template) {
        }
      }"""

    cell_or = """cell (OR_X1) {
        cell_fall (delay_template) {
        }
        fall_transition(delay_template) {
        }
      }"""

    liberty = """
    library(test_library_name){{
      /*This is a comment*/
      delay_model : table_lookup;
      capacitive_load_unit (1,ff);
      current_unit : "1mA";
      leakage_power_unit : "1pW";
      default_cell_leakage_power : 0;
      {cell}
    }}
    """

    liberty_or = liberty.format(cell=cell_or)
    liberty_and = liberty.format(cell=cell_and)

    io_vector = liberty_utility.generate_merged_liberty_io_vector(
        [liberty_or.encode('utf-8'),
         liberty_and.encode('utf-8')])

    merged_liberty = b''.join(io_vector)
    expected_liberty = liberty.format(cell=cell_and + cell_or)
    self.assertEqual(expected_liberty.encode('utf-8'), merged_liberty)


if __name__ == '__main__':
  unittest.main()
