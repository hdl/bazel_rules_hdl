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
"""Parse Liberty files into an AST like object."""

import dataclasses
import enum
from typing import List, Optional

# TODO(b/212634043): support comments in liberty parser.


class _CellParseState(enum.Enum):
  NONE = 1
  DETECTED = 2
  CONFIRMED = 3
  OPENED = 4
  CLOSED = 5


@dataclasses.dataclass
class _CellParser:
  cell_start_index: Optional[int] = None
  cell_end_index: Optional[int] = None
  curly_brace_count: int = 0
  current_state: _CellParseState = _CellParseState.NONE


@dataclasses.dataclass
class _CellExtractorInternalState:
  liberty_contents: bytes
  cell_parser_state: _CellParser
  byte_index: int = 0


def _handle_none_state(state: _CellExtractorInternalState) -> None:
  """Handles the base state of the parser looking for cell definitions.

  Args:
    state: Internal parser state object
  """

  cell_length = len(b'cell')

  cell_parser_state = state.cell_parser_state
  current_index = state.byte_index

  if state.liberty_contents[current_index:current_index +
                            cell_length] == b'cell':
    # Found the word cell. Put the parser in cell collection mode. We still
    # need to look ahead for an open paren.
    cell_parser_state.cell_start_index = state.byte_index
    cell_parser_state.current_state = _CellParseState.DETECTED
    state.byte_index += cell_length
    return

  state.byte_index += 1


def _handle_cell_detected_state(state: _CellExtractorInternalState) -> None:
  """Handles the cell detected state of the parser, captures cells.

  Args:
    state: Internal paser state object
  """
  current_index = state.byte_index
  current_character = state.liberty_contents[current_index:current_index + 1]

  cell_parser_state = state.cell_parser_state

  if current_character == b'(':
    # We have seen the word cell and some or no white space followed by
    # a open paren which means we have now found a real cell definition.
    cell_parser_state.current_state = _CellParseState.CONFIRMED
  elif current_character != b' ':
    # In this case we found a non-whitespace character after the word cell.
    # This indicates that this is not the start of cell definition so we
    # start over and drop our state.
    cell_parser_state.current_state = _CellParseState.NONE
    cell_parser_state.cell_start_index = None

  state.byte_index += 1


def _handle_cell_confirmed_state(state: _CellExtractorInternalState) -> None:
  """Creates cell AST node after finding a cell.

  Args:
    state: Internal paser state object
  """
  current_index = state.byte_index
  current_character = state.liberty_contents[current_index:current_index + 1]
  cell_parser_state = state.cell_parser_state

  if current_character == b'{':
    cell_parser_state.current_state = _CellParseState.OPENED
    cell_parser_state.curly_brace_count = 1

  state.byte_index += 1


def _handle_cell_opened_state(state: _CellExtractorInternalState) -> None:
  """Detects cells and creates book keeping materials for the cell.

  Args:
    state: Internal paser state object
  """
  current_index = state.byte_index
  current_character = state.liberty_contents[current_index:current_index + 1]
  cell_parser_state = state.cell_parser_state

  if current_character == b'{':
    cell_parser_state.curly_brace_count += 1
  elif current_character == b'}':
    cell_parser_state.curly_brace_count -= 1

  if cell_parser_state.curly_brace_count == 0:
    cell_parser_state.current_state = _CellParseState.CLOSED
    cell_parser_state.cell_end_index = current_index + 1

  state.byte_index += 1


def extract_cells(liberty_contents: bytes) -> List[bytes]:
  """Extracts a list of cells from a liberty file byte string.

  Args:
    liberty_contents: a byte string liberty file

  Returns:
     List of liberty cells

  Raises:
     RuntimeError: if parser cannot find a valid handler function.

  """
  cells = []
  state = _CellExtractorInternalState(liberty_contents, _CellParser())

  parser_state_table = {
      _CellParseState.NONE: _handle_none_state,
      _CellParseState.DETECTED: _handle_cell_detected_state,
      _CellParseState.CONFIRMED: _handle_cell_confirmed_state,
      _CellParseState.OPENED: _handle_cell_opened_state,
  }

  while state.byte_index < len(state.liberty_contents):
    current_state = state.cell_parser_state.current_state

    handler = parser_state_table[current_state]
    # Make sure that new states are aded to the state table.
    handler(state)

    current_state = state.cell_parser_state.current_state
    if current_state == _CellParseState.CLOSED:
      start_index = state.cell_parser_state.cell_start_index
      end_index = state.cell_parser_state.cell_end_index
      cells.append(liberty_contents[start_index:end_index])
      state.cell_parser_state = _CellParser()

  return cells
