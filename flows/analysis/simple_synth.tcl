# Minimal Yosys synthesis tcl script for the to support RTL analysis.
# It can be overriden for specific analyses.
set input_rtl $::env(INPUT_RTL)
set top $::env(CONSTANT_TOP)

puts stderr "Yosys synthesis started for module $top in $input_rtl."
yosys -import

# read design
yosys read_verilog -sv -defer $input_rtl

# generic synthesis
yosys synth -top $top
setundef -zero

# mapping to liberty
set liberty $::env(LIBERTY)
dfflibmap -liberty $liberty

# -keepff ensures that there will be nets for the source registers
# in the netlist output, supporting further analysis
abc -liberty $liberty -g aig -keepff

# write synthesized design
set output $::env(OUTPUT_NETLIST)
write_verilog $output

puts stderr "Output netlist generated in $output"
