# Default openSTA timing tcl script for the run_opensta rule.
# It can be replaced by a user-defined script by overriding the sta_tcl
# argument of that rule.

# User-defined timing scripts need to consult the following environment
# variables for their parameters:
# NETLIST = synthesized netlist (Verilog)
# TOP = top module in NETLIST
# LIBERTY = liberty file for the target technology library
# LOGFILE = file for analysis output


set sta_log $::env(LOGFILE)
set netlist $::env(NETLIST)
set liberty $::env(LIBERTY)
set top $::env(TOP)

sta::redirect_file_begin $sta_log
read_verilog $netlist
read_liberty $liberty
link_design  $top
report_checks -unconstrained
sta::redirect_file_end

# also output to stdout
report_checks -unconstrained
