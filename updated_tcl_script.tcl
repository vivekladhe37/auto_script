proc compile {top} {
        puts "Closing any designs that are currently open..."
        puts ""
        close_project -quiet
        puts "Continuing..."
        link_design -part xc7a100t-csg324-3
        if {[glob -nocomplain *.v] != ""} {
                puts "Reading Verilog files..."
                read_verilog [glob *.v]
        }
        puts "Synthesizing design..."
        synth_design -top $top -flatten_hierarchy full

		
		set_property top uart [current_fileset]  
		set_property top_file {C:\Users\vivek\AppData\Roaming\Xilinx\Vivado\verilog-uart-master\rtl\uart.v} [current_fileset]
		
		
        set_property CFGBVS VCCO [current_design]
        set_property CONFIG_VOLTAGE 3.3 [current_design]
        set_property BITSTREAM.General.UnconstrainedPins {Allow} [current_design]

        puts "Placing Design..."
        place_design
        puts "Routing Design"
        route_design

        puts "Writing checkpoint"
        write_checkpoint -force $top.dcp
        puts "Creating bitstream"
        write_bitstream -force $top.bit
        puts "All done..."
 }