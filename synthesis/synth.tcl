# Default Yosys synthesis tcl script for the synthesize_rtl rule.
# It can be replaced by a user-defined script by overriding the synth_tcl
# argument of that rule.

# User-defined synthesis scripts need to consult the following environment
# variables for their parameters:
# FLIST = a file that lists verilog sources (one file per line)
# TOP = top module for synthesis
# LIBERTY = liberty file for the target technology library
# OUTPUT = verilog file for synthesis output

yosys -import

# read design
set srcs_flist_path $::env(FLIST)
set srcs_flist_file [open $srcs_flist_path "r"]
set srcs_flist_data [read $srcs_flist_file]
set srcs [split $srcs_flist_data "\n"]
puts $srcs
foreach src $srcs {
    # Skip empty lines, including the implict one after the last \n delimiter
    # for files that end with a newline.
    if {$src eq ""} continue
    yosys read_verilog -sv -defer $src
}

# generic synthesis
set top $::env(TOP)
yosys synth -top $top

# mapping to liberty
set liberty $::env(LIBERTY)
dfflibmap -liberty $liberty
abc -liberty $liberty

# write synthesized design
set output $::env(OUTPUT)
write_verilog $output
