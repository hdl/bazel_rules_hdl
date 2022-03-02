puts stderr "OpenROAD analysis started\n"
read_verilog $::env(INPUT_NETLIST)
link_design $::env(CONSTANT_TOP)

set clock_port $::env(CONSTANT_CLOCK_PORT)

set_cmd_units -time ps

create_clock -name $clock_port [get_ports $clock_port] -period $::env(CONSTANT_CLOCK_PERIOD_PS)

set timing_paths [find_timing_paths -sort_by_slack]

set critical_path [lindex $timing_paths 0]

utl::metric "slack_ps" [get_property $critical_path slack]

puts stderr "OpenROAD analysis done\n"
