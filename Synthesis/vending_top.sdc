###################################################################

# Created by write_sdc on Wed Feb 25 18:49:21 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_driving_cell -lib_cell INVX1 [get_ports clk]
set_driving_cell -lib_cell INVX1 [get_ports rst_n]
set_driving_cell -lib_cell INVX1 [get_ports coin_valid]
set_driving_cell -lib_cell INVX1 [get_ports {coin_type[1]}]
set_driving_cell -lib_cell INVX1 [get_ports {coin_type[0]}]
set_driving_cell -lib_cell INVX1 [get_ports sel_valid]
set_driving_cell -lib_cell INVX1 [get_ports {sel_id[1]}]
set_driving_cell -lib_cell INVX1 [get_ports {sel_id[0]}]
set_driving_cell -lib_cell INVX1 [get_ports cancel]
create_clock -name vclk  -period 20  -waveform {0 10}
set_input_delay -clock vclk  1  [get_ports clk]
set_input_delay -clock vclk  1  [get_ports rst_n]
set_input_delay -clock vclk  1  [get_ports coin_valid]
set_input_delay -clock vclk  1  [get_ports {coin_type[1]}]
set_input_delay -clock vclk  1  [get_ports {coin_type[0]}]
set_input_delay -clock vclk  1  [get_ports sel_valid]
set_input_delay -clock vclk  1  [get_ports {sel_id[1]}]
set_input_delay -clock vclk  1  [get_ports {sel_id[0]}]
set_input_delay -clock vclk  1  [get_ports cancel]
set_output_delay -clock vclk  1  [get_ports dispense_valid]
set_output_delay -clock vclk  1  [get_ports {dispense_id[1]}]
set_output_delay -clock vclk  1  [get_ports {dispense_id[0]}]
set_output_delay -clock vclk  1  [get_ports change_pulse]
set_output_delay -clock vclk  1  [get_ports {change_type[1]}]
set_output_delay -clock vclk  1  [get_ports {change_type[0]}]
set_output_delay -clock vclk  1  [get_ports {status_code[1]}]
set_output_delay -clock vclk  1  [get_ports {status_code[0]}]
set_output_delay -clock vclk  1  [get_ports {err_code[1]}]
set_output_delay -clock vclk  1  [get_ports {err_code[0]}]
