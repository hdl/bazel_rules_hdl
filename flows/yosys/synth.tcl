# Default Yosys synthesis tcl script for the yosys_synth_file_step rule.
# It can be replaced by a user-defined script by overriding the synth_tcl
# argument of that rule.

yosys -import

# read design
set input_rtl $::env(INPUT_RTL)
yosys read_verilog -sv -defer $input_rtl

# generic synthesis
set top $::env(CONSTANT_TOP)
yosys synth -top $top

# mapping to liberty
set liberty $::env(LIBERTY)
dfflibmap -liberty $liberty

#if { [info exists ::env(CLOCK_PERIOD) ] } {
#  abc -liberty $liberty -dff -g aig -D $::env(CLOCK_PERIOD)
#} else {
  abc -liberty $liberty -dff -g aig
#}

# write synthesized design
set output $::env(OUTPUT_NETLIST)
write_verilog $output

# print stats
stat
