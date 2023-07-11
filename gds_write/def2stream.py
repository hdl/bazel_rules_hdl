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
"""

import klayout.db as db
import re
import argparse

class GDSWriter():
    """
    GDSWrite allows writing GDS layout files.
    It uses KLayout Python Module. The required inputs are:
    * DEF file of the implemented design
    * Set of LEF files
    * KLayout technology file
    """
    def __init__(self):
        self.parser = self.__setup_argparse()
        self.args = self.parser.parse_args()

    def __setup_argparse(self):
        parser = argparse.ArgumentParser(description="GDS writer script")
        parser.add_argument("-n", "--design-name",    required=True,  help="Name of the top module in the design")
        parser.add_argument("-d", "--input-def",      required=True,  help="Path to def file of the implemented design after detailed routing step")
        parser.add_argument("-l", "--input-lef",      required=True,  help="Path to lef file, specify one argument for each input LEF file", action="append")
        parser.add_argument("-t", "--tech-file",      required=True,  help="Path to KLayout technology file, a mapping from LEF/DEF to GDS. Specify one argument for each input GDS file")
        parser.add_argument("-o", "--out",            required=True,  help="Path to output GDS file")
        parser.add_argument("-g", "--input-gds",      required=False, help="Paths to additional input GDS files", action="append")
        parser.add_argument("-m", "--layer-map",      required=False, help="Path to layer map file", default="")
        parser.add_argument("-e", "--gds-allow-empty",required=False, help="regex to allow empty GDS for matched cells")
        return parser

    def __load_layout_options(self):
        """
        Load KLayout technology file with default layout options.
        Override some of the options to ensure that correct LEF files
        will be read while creating layout
        """
        # Load technology file
        tech = db.Technology()
        tech.load(self.args.tech_file)
        self.layout_options = tech.load_layout_options
        # Don't read all LEF files stored in the same directory as input DEF file
        self.layout_options.lefdef_config.read_lef_with_def = False
        # Read only those from `layoutOptions.lefdef_config.lef_files`
        # and overwrite ones specified under <lef-files></lef-files> in KLayout LYT file
        self.layout_options.lefdef_config.lef_files = self.args.input_lef
        # Ensure correct paths
        self.layout_options.lefdef_config.paths_relative_to_cwd = True
        if len(self.args.layer_map) > 0:
            self.layout_options.lefdef_config.map_file = self.args.layer_map

    def __read_def(self, layout, layout_options, input_def):
        """
        Load input DEF file with implemented design to the layout,
        use previously loaded and modified layout options
        """
        print("[INFO] Reading DEF ...")
        layout.read(input_def, layout_options)

    def __read_gds(self, layout, input_gds):
        """
        Provide cell definitions in GDS format to the layout
        """
        print("[INFO] Merging GDS/OAS files...")
        for fil in input_gds:
          print("\t{0}".format(fil))
          layout.read(fil)

    def __prepare_layout(self):
        """
        Load main layout for the implemented design
        """
        self.main_layout = db.Layout()

        print("[INFO] Reporting cells prior to loading DEF ...")
        for i in self.main_layout.each_cell():
          print("[INFO] '{0}'".format(i.name))

        self.__read_def(self.main_layout, self.layout_options, self.args.input_def)
        self.__read_gds(self.main_layout, self.args.input_gds)


    def __prepare_top_layout(self):
        """
        Create new layout based on main layout. Copy only the top cell tree.
        """
        design_name = self.args.design_name
        print("[INFO] Copying toplevel cell '{0}'".format(design_name))
        self.top_only_layout = db.Layout()
        self.top_only_layout.dbu = self.main_layout.dbu
        top = self.top_only_layout.create_cell(design_name)
        top.copy_tree(self.main_layout.cell(design_name))

    def __check_cell_definitions(self):
        """
        Verify if there is any LEF cell in top layout that does not have
        a matching definition in GDS files.
        """
        errors = 0
        missing_cell = False
        regex = None
        print("[INFO] Checking for missing cell from GDS/OAS...")
        if self.args.gds_allow_empty:
            print("[INFO] Found gds_allow_empty")
            regex = self.args.gds_allow_empty
        for i in self.top_only_layout.each_cell():
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

        if (errors > 0):
          raise LookupError("{} LEF {} no matching GDS/OAS cell".format(errors, "cells have" if (errors > 1) else "cell has"))

    def __finish_gds(self):
        """
        Write prepared top layout to GDS file
        """
        gds_output = self.args.out
        print("[INFO] Writing out GDS/OAS '{0}'".format(gds_output))
        self.top_only_layout.write(gds_output)

    def write_gds(self):
        """
        Perform full GDS write flow:
            * Load layout configuration
            * Read input DEF, LEF and GDS files to create design layout
            * Copy top cell of the layout to new layout
            * Verify LEF cells mapping into GDS cells
            * Write GDS file with implemented design layout
        """
        self.__load_layout_options()
        self.__prepare_layout()
        self.__prepare_top_layout()
        self.__check_cell_definitions()
        self.__finish_gds()

def main():
    writer = GDSWriter()
    writer.write_gds()

if __name__ == '__main__':
    main()
