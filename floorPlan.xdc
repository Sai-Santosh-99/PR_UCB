
####################################################################################
# Generated by Vivado 2018.2 built on 'Thu Jun 14 20:03:12 MDT 2018' by 'xbuild'
# Command Used: write_xdc -force floorPlan.xdc
####################################################################################


# User Generated miscellaneous constraints 

set_property HD.RECONFIGURABLE true [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1]
set_property HD.RECONFIGURABLE true [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2]
set_property HD.RECONFIGURABLE true [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3]
set_property HD.RECONFIGURABLE true [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4]

# User Generated physical constraints 

create_pblock pblock_machine1
add_cells_to_pblock [get_pblocks pblock_machine1] [get_cells -quiet [list system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1]]
resize_pblock [get_pblocks pblock_machine1] -add {SLICE_X42Y204:SLICE_X71Y249}
resize_pblock [get_pblocks pblock_machine1] -add {DSP48_X3Y82:DSP48_X3Y99}
resize_pblock [get_pblocks pblock_machine1] -add {RAMB18_X3Y82:RAMB18_X3Y99}
resize_pblock [get_pblocks pblock_machine1] -add {RAMB36_X3Y41:RAMB36_X3Y49}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_machine1]
set_property SNAPPING_MODE ON [get_pblocks pblock_machine1]

# User Generated miscellaneous constraints 


# User Generated physical constraints 

create_pblock pblock_machine2
add_cells_to_pblock [get_pblocks pblock_machine2] [get_cells -quiet [list system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2]]
resize_pblock [get_pblocks pblock_machine2] -add {SLICE_X90Y202:SLICE_X119Y249}
resize_pblock [get_pblocks pblock_machine2] -add {DSP48_X4Y82:DSP48_X4Y99}
resize_pblock [get_pblocks pblock_machine2] -add {RAMB18_X4Y82:RAMB18_X4Y99}
resize_pblock [get_pblocks pblock_machine2] -add {RAMB36_X4Y41:RAMB36_X4Y49}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_machine2]
set_property SNAPPING_MODE ON [get_pblocks pblock_machine2]

# User Generated miscellaneous constraints 


# User Generated physical constraints 

create_pblock pblock_machine3
add_cells_to_pblock [get_pblocks pblock_machine3] [get_cells -quiet [list system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3]]
resize_pblock [get_pblocks pblock_machine3] -add {SLICE_X42Y152:SLICE_X71Y199}
resize_pblock [get_pblocks pblock_machine3] -add {DSP48_X3Y62:DSP48_X3Y79}
resize_pblock [get_pblocks pblock_machine3] -add {RAMB18_X3Y62:RAMB18_X3Y79}
resize_pblock [get_pblocks pblock_machine3] -add {RAMB36_X3Y31:RAMB36_X3Y39}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_machine3]
set_property SNAPPING_MODE ON [get_pblocks pblock_machine3]

# User Generated miscellaneous constraints 


# User Generated physical constraints 

create_pblock pblock_machine4
add_cells_to_pblock [get_pblocks pblock_machine4] [get_cells -quiet [list system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4]]
resize_pblock [get_pblocks pblock_machine4] -add {SLICE_X90Y152:SLICE_X119Y199}
resize_pblock [get_pblocks pblock_machine4] -add {DSP48_X4Y62:DSP48_X4Y79}
resize_pblock [get_pblocks pblock_machine4] -add {RAMB18_X4Y62:RAMB18_X4Y79}
resize_pblock [get_pblocks pblock_machine4] -add {RAMB36_X4Y31:RAMB36_X4Y39}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_machine4]
set_property SNAPPING_MODE ON [get_pblocks pblock_machine4]

# User Generated miscellaneous constraints 


# Vivado Generated miscellaneous constraints 

#revert back to original instance
current_instance -quiet