
# open_checkpoint Synth/Static/system_wrapper.dcp

# read_checkpoint -cell system_i/rst_ps7_0_20M Synth/Static/system_rst_ps7_0_20M_0.dcp

# read_checkpoint -cell system_i/ps7_0_axi_periph/xbar Synth/Static/system_xbar_0.dcp

# read_checkpoint -cell system_i/pr_decoupler_0 Synth/Static/system_pr_decoupler_0_0.dcp

# read_checkpoint -cell system_i/ps7_0_axi_periph/s00_couplers/auto_pc Synth/Static/system_auto_pc_0.dcp

# read_checkpoint -cell system_i/processing_system7_0 Synth/Static/system_processing_system7_0_0.dcp

# read_checkpoint -cell system_i/machine Synth/Static/system_machine_arms_0_0.dcp

# read_checkpoint -cell system_i/Compare Synth/Static/system_comparator_0_0.dcp


# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1 Synth/TUNED_1/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 Synth/TUNED_2/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3 Synth/TUNED_3/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4 Synth/TUNED_4/ucb_synth.dcp

# set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1]
# set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2]
# set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3]
# set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4]

# # read_xdc floorPlan.xdc

# opt_design
# place_design
# route_design

# write_checkpoint -force Implement/TUNED/top_route_design.dcp

# # #######################################################################################################3


# update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1 -black_box
# update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 -black_box
# update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3 -black_box
# update_design -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4 -black_box

# lock_design -level routing

# write_checkpoint -force Checkpoint/static_route_design.dcp
# close_project

# # #######################################################################################################3


# open_checkpoint Checkpoint/static_route_design.dcp


# update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1
# update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 
# update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3
# update_design -buffer_ports -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4

# place_design
# route_design

# write_checkpoint -force Implement/BLANK/top_route_design.dcp
# close_project

# #######################################################################################################3


# open_checkpoint Checkpoint/static_route_design.dcp


# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1 Synth/UCBV_1/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 Synth/UCBV_2/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3 Synth/UCBV_3/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4 Synth/UCBV_4/ucb_synth.dcp

# opt_design
# place_design
# route_design

# write_checkpoint -force Implement/UCBV/top_route_design.dcp
# close_project

# #######################################################################################################3


open_checkpoint Checkpoint/static_route_design.dcp

read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1 Synth/UCB_1/ucb_synth.dcp
read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 Synth/UCB_2/ucb_synth.dcp
read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3 Synth/UCB_3/ucb_synth.dcp
read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4 Synth/UCB_4/ucb_synth.dcp

opt_design
place_design
route_design

write_checkpoint -force Implement/UCB/top_route_design.dcp
close_project

# ###########################################################################################################


pr_verify -initial Implement/TUNED/top_route_design.dcp -additional {Implement/BLANK/top_route_design.dcp Implement/UCBV/top_route_design.dcp Implement/UCB/top_route_design.dcp}
close_project


open_checkpoint Implement/UCB/top_route_design.dcp
write_bitstream -file Bitstreams/UCB.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine1_partial.bit" Bitstreams/UCB_1.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine2_partial.bit" Bitstreams/UCB_2.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine3_partial.bit" Bitstreams/UCB_3.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine4_partial.bit" Bitstreams/UCB_4.bin
close_project 


# open_checkpoint Implement/BLANK/top_route_design.dcp 
# write_bitstream -file Bitstreams/BLANK.bit 
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine1_partial.bit" Bitstreams/BLANK_1.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine2_partial.bit" Bitstreams/BLANK_2.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine3_partial.bit" Bitstreams/BLANK_3.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine4_partial.bit" Bitstreams/BLANK_4.bin
# close_project 

# open_checkpoint Implement/UCBV/top_route_design.dcp
# write_bitstream -file Bitstreams/UCBV.bit 
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine1_partial.bit" Bitstreams/UCBV_1.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine2_partial.bit" Bitstreams/UCBV_2.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine3_partial.bit" Bitstreams/UCBV_3.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine4_partial.bit" Bitstreams/UCBV_4.bin
# close_project 

# open_checkpoint Implement/TUNED/top_route_design.dcp
# write_bitstream -file Bitstreams/TUNED.bit 
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine1_partial.bit" Bitstreams/TUNED_1.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine2_partial.bit" Bitstreams/TUNED_2.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine3_partial.bit" Bitstreams/TUNED_3.bin
# write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine4_partial.bit" Bitstreams/TUNED_4.bin
# close_project 
