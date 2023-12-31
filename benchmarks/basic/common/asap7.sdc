set clk_port_name "clk"
set clk_period 10
set clk_half_period [format "%.5f" [expr {$clk_period / 2.0}]]

create_clock -name clk -period $clk_period -waveform "0 $clk_half_period" \
  [get_ports -quiet $clk_port_name]