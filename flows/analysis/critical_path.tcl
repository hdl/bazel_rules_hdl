puts stderr "OpenROAD analysis started\n"
read_verilog $::env(INPUT_NETLIST)
link_design $::env(CONSTANT_TOP)

set clock_port $::env(CONSTANT_CLOCK_PORT)
create_clock -name $clock_port [get_ports $clock_port] -period 0

set timing_paths [find_timing_paths -sort_by_slack]

set critical_path [lindex $timing_paths 0]

set critical_path_length [expr {- [get_property $critical_path slack]}]

puts stderr "Critical path length is $critical_path_length\n"

puts stderr "OpenROAD analysis done\n"
