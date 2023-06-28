#!/usr/bin/env python3

# BSD 3-Clause License
#
# Copyright (c) 2018-2023, The Regents of the University of California
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

"""
This script was imported from OpenROAD-flow-scripts project: https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
The import took place:
    * at 04.07.2023,
    * at git hash: 99e8d3e9b399c7703fab26bef2b5770d39a2f724
    * from https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts/blob/99e8d3e9b399c7703fab26bef2b5770d39a2f724/flow/util/def2stream.py

The script allows writing GDS layout files. The required inputs are:
    * DEF file of the implemented design
    * Set of LEF files
    * KLayout technology file
"""

import klayout.db as db
import re
import json
import copy
import sys
import os
import argparse

parser = argparse.ArgumentParser(description="GDS writer script")
parser.add_argument("-n", "--design-name",    required=True,  help="Name of the top module in the design")
parser.add_argument("-d", "--input-def",      required=True,  help="Path to def file of the implemented design after detailed routing step")
parser.add_argument("-l", "--input-lef",      required=True,  help="Path to lef file, specify one argument for each input LEF file", action="append")
parser.add_argument("-t", "--tech-file",      required=True,  help="Path to KLayout technology file, a mapping from LEF/DEF to GDS. Specify one argument for each input GDS file")
parser.add_argument("-o", "--out",            required=True,  help="Path to output GDS file")
parser.add_argument("-g", "--input-gds",      required=False, help="Paths to additional input GDS files", action="append")
parser.add_argument("-m", "--layer-map",      required=False, help="Path to layer map file", default="")
parser.add_argument("-e", "--gds-allow-empty",required=False, help="regex to allow empty GDS for matched cells")

args = parser.parse_args()

errors = 0

# Load technology file
tech = db.Technology()
tech.load(args.tech_file)
layoutOptions = tech.load_layout_options
# Don't read all LEF files stored in the same directory as input DEF file
layoutOptions.lefdef_config.read_lef_with_def = False
# Read only those from `layoutOptions.lefdef_config.lef_files`
# and overwrite ones specified under <lef-files></lef-files> in KLayout LYT file
layoutOptions.lefdef_config.lef_files = args.input_lef
# Ensure correct paths
layoutOptions.lefdef_config.paths_relative_to_cwd = True
if len(args.layer_map) > 0:
  layoutOptions.lefdef_config.map_file = args.layer_map

# Load def file
main_layout = db.Layout()
print("[INFO] Reporting cells prior to loading DEF ...")
for i in main_layout.each_cell():
  print("[INFO] '{0}'".format(i.name))

print("[INFO] Reading DEF ...")
main_layout.read(args.input_def, layoutOptions)

# Load in the gds to merge
print("[INFO] Merging GDS/OAS files...")
for fil in args.input_gds:
  print("\t{0}".format(fil))
  main_layout.read(fil)

# Copy the top level only to a new layout
print("[INFO] Copying toplevel cell '{0}'".format(args.design_name))
top_only_layout = db.Layout()
top_only_layout.dbu = main_layout.dbu
top = top_only_layout.create_cell(args.design_name)
top.copy_tree(main_layout.cell(args.design_name))

print("[INFO] Checking for missing cell from GDS/OAS...")
missing_cell = False
regex = None
if args.gds_allow_empty:
    print("[INFO] Found gds_allow_empty")
    regex = args.gds_allow_empty
for i in top_only_layout.each_cell():
  if i.is_empty():
    missing_cell = True
    if regex is not None and re.match(regex, i.name):
        print("[WARNING] LEF Cell '{0}' ignored. Matches gds_allow_empty.".format(i.name))
    else:
        print("[ERROR] LEF Cell '{0}' has no matching GDS/OAS cell."
              " Cell will be empty.".format(i.name))
        errors += 1

if not missing_cell:
  print("[INFO] All LEF cells have matching GDS/OAS cells")

print("[INFO] Checking for orphan cell in the final layout...")
orphan_cell = False
for i in top_only_layout.each_cell():
  if i.name != args.design_name and i.parent_cells() == 0:
    orphan_cell = True
    print("[ERROR] Found orphan cell '{0}'".format(i.name))
    errors += 1

if not orphan_cell:
  print("[INFO] No orphan cells")

# Write out the GDS
print("[INFO] Writing out GDS/OAS '{0}'".format(args.out))
top_only_layout.write(args.out)

sys.exit(errors)
