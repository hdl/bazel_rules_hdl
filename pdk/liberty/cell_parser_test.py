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

"""Tests for cell_parser."""

import unittest

from pdk.liberty import cell_parser


class CellParserTest(unittest.TestCase):

  def test_well_formatted_liberty_extracts_cells(self):
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

    liberty = f"""
    library(test_library_name){{
      /*This is a comment*/
      delay_model : table_lookup;
      capacitive_load_unit (1,ff);
      current_unit : "1mA";
      leakage_power_unit : "1pW";
      default_cell_leakage_power : 0;
      {cell_and}
      {cell_or}
    }}
    """

    cells = cell_parser.extract_cells(liberty.encode('utf-8'))

    self.assertEqual([cell_and.encode('utf-8'), cell_or.encode('utf-8')], cells)


if __name__ == '__main__':
  unittest.main()
