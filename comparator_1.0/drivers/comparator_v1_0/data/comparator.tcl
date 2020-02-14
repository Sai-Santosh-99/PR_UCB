

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "comparator" "NUM_INSTANCES" "DEVICE_ID"  "C_S_select_machine_BASEADDR" "C_S_select_machine_HIGHADDR"
}
