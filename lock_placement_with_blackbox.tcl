
update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1 -black_box
update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 -black_box
update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3 -black_box
update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4 -black_box

lock_design -level routing

write_checkpoint -force Checkpoint/static_route_design.dcp
close_project