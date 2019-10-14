create_project tutorial C:/Summer/Tutorial/tutorial -part xc7z045ffg900-2
set_property board_part xilinx.com:zc706:part0:1.4 [current_project]
set_property  ip_repo_paths  C:/Summer/Tutorial/ip_repo [current_project]
update_ip_catalog

create_bd_design "system"

update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

startgroup
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {20}] [get_bd_cells processing_system7_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:user:machine_arms:1.0 machine_arms_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/machine_arms_0/S00_AXI} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins machine_arms_0/S00_AXI]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:user:comparator:1.0 comparator_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (20 MHz)} Clk_slave {Auto} Clk_xbar {/processing_system7_0/FCLK_CLK0 (20 MHz)} Master {/processing_system7_0/M_AXI_GP0} Slave {/comparator_0/S_select_machine} intc_ip {/ps7_0_axi_periph} master_apm {0}}  [get_bd_intf_pins comparator_0/S_select_machine]

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:pr_decoupler:1.0 pr_decoupler_0
endgroup

set_property -dict [list CONFIG.ALL_PARAMS {HAS_SIGNAL_STATUS 0 INTF {intf_0 {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1} ARREADY {PRESENT 1} AWVALID {PRESENT 1} AWREADY {PRESENT 1} BVALID {PRESENT 1} BREADY {PRESENT 1} RVALID {PRESENT 1} RREADY {PRESENT 1} WVALID {PRESENT 1} WREADY {PRESENT 1} AWADDR {PRESENT 1} AWLEN {PRESENT 0} AWSIZE {PRESENT 0} AWBURST {PRESENT 0} AWLOCK {PRESENT 0} AWCACHE {PRESENT 0} AWPROT {PRESENT 1} WDATA {PRESENT 1} WSTRB {PRESENT 1} WLAST {PRESENT 0} BRESP {PRESENT 1} ARADDR {PRESENT 1} ARLEN {PRESENT 0} ARSIZE {PRESENT 0} ARBURST {PRESENT 0} ARLOCK {PRESENT 0} ARCACHE {PRESENT 0} ARPROT {PRESENT 1} RDATA {PRESENT 1} RRESP {PRESENT 1} RLAST {PRESENT 0}} MODE slave} final_q_1 {ID 1 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave SIGNALS {DATA {MANAGEMENT manual WIDTH 32}}} final_q_2 {ID 2 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave SIGNALS {DATA {MANAGEMENT manual WIDTH 32}}} final_q_3 {ID 3 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave SIGNALS {DATA {MANAGEMENT manual WIDTH 32}}} final_q_4 {ID 4 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave SIGNALS {DATA {MANAGEMENT manual WIDTH 32}}} q_1_valid {ID 5 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave} q_2_valid {ID 6 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave} q_3_valid {ID 7 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave} q_4_valid {ID 8 VLNV xilinx.com:signal:data_rtl:1.0 MODE slave}}} CONFIG.GUI_HAS_SIGNAL_STATUS {0} CONFIG.GUI_SELECT_INTERFACE {8} CONFIG.GUI_INTERFACE_NAME {q_4_valid} CONFIG.GUI_SELECT_VLNV {xilinx.com:signal:data_rtl:1.0} CONFIG.GUI_INTERFACE_PROTOCOL {none} CONFIG.GUI_SELECT_MODE {slave} CONFIG.GUI_SIGNAL_SELECT_0 {DATA} CONFIG.GUI_SIGNAL_SELECT_1 {-1} CONFIG.GUI_SIGNAL_SELECT_2 {-1} CONFIG.GUI_SIGNAL_SELECT_3 {-1} CONFIG.GUI_SIGNAL_SELECT_4 {-1} CONFIG.GUI_SIGNAL_SELECT_5 {-1} CONFIG.GUI_SIGNAL_SELECT_6 {-1} CONFIG.GUI_SIGNAL_SELECT_7 {-1} CONFIG.GUI_SIGNAL_SELECT_8 {-1} CONFIG.GUI_SIGNAL_SELECT_9 {-1} CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} CONFIG.GUI_SIGNAL_DECOUPLED_1 {false} CONFIG.GUI_SIGNAL_DECOUPLED_2 {false} CONFIG.GUI_SIGNAL_DECOUPLED_3 {false} CONFIG.GUI_SIGNAL_DECOUPLED_4 {false} CONFIG.GUI_SIGNAL_DECOUPLED_5 {false} CONFIG.GUI_SIGNAL_DECOUPLED_6 {false} CONFIG.GUI_SIGNAL_DECOUPLED_7 {false} CONFIG.GUI_SIGNAL_DECOUPLED_8 {false} CONFIG.GUI_SIGNAL_DECOUPLED_9 {false} CONFIG.GUI_SIGNAL_PRESENT_0 {true} CONFIG.GUI_SIGNAL_PRESENT_1 {false} CONFIG.GUI_SIGNAL_PRESENT_2 {false} CONFIG.GUI_SIGNAL_PRESENT_3 {false} CONFIG.GUI_SIGNAL_PRESENT_4 {false} CONFIG.GUI_SIGNAL_PRESENT_5 {false} CONFIG.GUI_SIGNAL_PRESENT_6 {false} CONFIG.GUI_SIGNAL_PRESENT_7 {false} CONFIG.GUI_SIGNAL_PRESENT_8 {false} CONFIG.GUI_SIGNAL_PRESENT_9 {false} CONFIG.GUI_SIGNAL_WIDTH_0 {1} CONFIG.GUI_SIGNAL_MANAGEMENT_0 {auto}] [get_bd_cells pr_decoupler_0]

delete_bd_objs [get_bd_intf_nets ps7_0_axi_periph_M00_AXI]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ps7_0_axi_periph/M00_AXI] [get_bd_intf_pins pr_decoupler_0/s_intf_0]
connect_bd_intf_net [get_bd_intf_pins pr_decoupler_0/rp_intf_0] [get_bd_intf_pins machine_arms_0/S00_AXI]
connect_bd_net [get_bd_pins machine_arms_0/Q1_t] [get_bd_pins pr_decoupler_0/s_final_q_1_DATA]
connect_bd_net [get_bd_pins machine_arms_0/Q2_t] [get_bd_pins pr_decoupler_0/s_final_q_2_DATA]
connect_bd_net [get_bd_pins machine_arms_0/Q3_t] [get_bd_pins pr_decoupler_0/s_final_q_3_DATA]
connect_bd_net [get_bd_pins machine_arms_0/Q4_t] [get_bd_pins pr_decoupler_0/s_final_q_4_DATA]
connect_bd_net [get_bd_pins machine_arms_0/float_Q1_valid] [get_bd_pins pr_decoupler_0/s_q_1_valid_DATA]
connect_bd_net [get_bd_pins machine_arms_0/float_Q2_valid] [get_bd_pins pr_decoupler_0/s_q_2_valid_DATA]
connect_bd_net [get_bd_pins machine_arms_0/float_Q3_valid] [get_bd_pins pr_decoupler_0/s_q_3_valid_DATA]
connect_bd_net [get_bd_pins machine_arms_0/float_Q4_valid] [get_bd_pins pr_decoupler_0/s_q_4_valid_DATA]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_final_q_1_DATA] [get_bd_pins comparator_0/Q1_t]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_final_q_2_DATA] [get_bd_pins comparator_0/Q2_t]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_final_q_3_DATA] [get_bd_pins comparator_0/Q3_t]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_final_q_4_DATA] [get_bd_pins comparator_0/Q4_t]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_q_1_valid_DATA] [get_bd_pins comparator_0/float_Q1_valid]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_q_2_valid_DATA] [get_bd_pins comparator_0/float_Q2_valid]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_q_3_valid_DATA] [get_bd_pins comparator_0/float_Q3_valid]
connect_bd_net [get_bd_pins pr_decoupler_0/rp_q_4_valid_DATA] [get_bd_pins comparator_0/float_Q4_valid]

startgroup
set_property -dict [list CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {0} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {0}] [get_bd_cells processing_system7_0]
set_property -dict [list CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {0} CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} CONFIG.PCW_GPIO_EMIO_GPIO_IO {1}] [get_bd_cells processing_system7_0]
endgroup

connect_bd_net [get_bd_pins processing_system7_0/GPIO_O] [get_bd_pins pr_decoupler_0/decouple]

set_property name Compare [get_bd_cells comparator_0]
set_property name machine [get_bd_cells machine_arms_0]

validate_bd_design
save_bd_design
make_wrapper -files [get_files C:/Summer/Tutorial/tutorial/tutorial.srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse C:/Summer/Tutorial/tutorial/tutorial.srcs/sources_1/bd/system/hdl/system_wrapper.v
