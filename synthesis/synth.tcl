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

# read UHDM designs
set srcs_uhdm_flist_path $::env(UHDM_FLIST)
set srcs_uhdm_flist_file [open $srcs_uhdm_flist_path "r"]
set srcs_uhdm_flist_data [read $srcs_uhdm_flist_file]
set srcs [split $srcs_uhdm_flist_data "\n"]
puts $srcs
foreach src $srcs {
    # Skip empty lines, including the implict one after the last \n delimiter
    # for files that end with a newline.
    if {$src eq ""} continue
    read_uhdm $src
}

# generic synthesis
set top $::env(TOP)
hierarchy -check -top $top
# Move proc_mux at the end of `yosys proc` to avoid inferred latches.
# See https://github.com/YosysHQ/yosys/issues/3456
# Ideally the bug would be solved in UHDM/Yosys.
yosys proc -nomux
yosys proc_mux
yosys flatten
yosys synth -top $top

# mapping to liberty
set liberty $::env(LIBERTY)
dfflibmap -liberty $liberty

if { [info exists ::env(CLOCK_PERIOD) ] } {
  abc -liberty $liberty -dff -g aig -D $::env(CLOCK_PERIOD)
} else {
  abc -liberty $liberty -dff -g aig
}

# write synthesized design
set output $::env(OUTPUT)
write_verilog $output

# ====== print stats / info ======
stat -liberty $liberty
read_liberty -lib -ignore_miss_func $liberty
ltp -noff $top

yosys log -n Flop count:\ 
yosys select -count t:*__df* t:DFF* t:*_DFF* t:*_SDFF* t:*_ADFF* t:*dff

set base_liberty [file tail $liberty]
yosys log Liberty: $base_liberty
