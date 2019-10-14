
open_checkpoint Synth/Static/system_wrapper.dcp

read_checkpoint -cell system_i/processing_system7_0 Synth/Static/system_processing_system7_0_0.dcp

read_checkpoint -cell system_i/machine Synth/Static/system_machine_arms_0_0.dcp

read_checkpoint -cell system_i/pr_decoupler_0 Synth/Static/system_pr_decoupler_0_0.dcp

read_checkpoint -cell system_i/rst_ps7_0_20M Synth/Static/system_rst_ps7_0_20M_0.dcp

read_checkpoint -cell system_i/ps7_0_axi_periph/s00_couplers/auto_pc Synth/Static/system_auto_pc_0.dcp

read_checkpoint -cell system_i/ps7_0_axi_periph/xbar Synth/Static/system_xbar_0.dcp

read_checkpoint -cell system_i/Compare Synth/Static/system_comparator_0_0.dcp


read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1 Synth/UCB_1/ucb_synth.dcp
read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 Synth/UCB_2/ucb_synth.dcp
read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3 Synth/UCB_3/ucb_synth.dcp
read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4 Synth/UCB_4/ucb_synth.dcp

# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1 Synth/KL_1/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2 Synth/KL_2/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3 Synth/KL_3/ucb_synth.dcp
# read_checkpoint -cell system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4 Synth/KL_4/ucb_synth.dcp

set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u1]
set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u2]
set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u3]
set_property HD.RECONFIGURABLE 1 [get_cells system_i/machine/inst/machine_arms_v1_0_S00_AXI_inst/u4]