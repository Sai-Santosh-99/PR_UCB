
open_checkpoint Checkpoint/static_route_design.dcp


read_checkpoint -cell system_i/machine1/inst/machine1_blank_v1_0_S00_AXI_inst/u1 Synth/UCBV_1/ucb_synth.dcp
read_checkpoint -cell system_i/machine2/inst/machine2_blank_v1_0_S00_AXI_inst/u1 Synth/UCBV_2/ucb_synth.dcp
read_checkpoint -cell system_i/machine3/inst/machine3_blank_v1_0_S00_AXI_inst/u1 Synth/UCBV_3/ucb_synth.dcp
read_checkpoint -cell system_i/machine4/inst/machine4_blank_v1_0_S00_AXI_inst/u1 Synth/UCBV_4/ucb_synth.dcp

opt_design
place_design
route_design

write_checkpoint -force Implement/UCBV/top_route_design.dcp
close_project