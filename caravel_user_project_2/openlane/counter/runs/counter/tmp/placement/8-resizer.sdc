###############################################################################
# Created by write_sdc
# Wed Jun 15 10:47:43 2022
###############################################################################
current_design counter
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 100.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {data[0]}]
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {data[1]}]
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {data[2]}]
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {data[3]}]
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {dn}]
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {en}]
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {load}]
set_input_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rst_n}]
set_output_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {count[0]}]
set_output_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {count[1]}]
set_output_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {count[2]}]
set_output_delay 20.0000 -clock [get_clocks {clk}] -add_delay [get_ports {count[3]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {count[3]}]
set_load -pin_load 0.0334 [get_ports {count[2]}]
set_load -pin_load 0.0334 [get_ports {count[1]}]
set_load -pin_load 0.0334 [get_ports {count[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {dn}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {en}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {load}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst_n}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {data[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {data[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {data[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {data[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 5.0000 [current_design]
