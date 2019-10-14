
open_checkpoint Checkpoint/static_route_design.dcp


update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1
update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 
update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3
update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4

place_design
route_design

write_checkpoint -force Implement/BLANK/top_route_design.dcp
close_project