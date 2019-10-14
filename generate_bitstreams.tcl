
open_checkpoint Implement/UCB/top_route_design.dcp
write_bitstream -file Bitstreams/UCB.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine1_partial.bit" Bitstreams/UCB_1.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine2_partial.bit" Bitstreams/UCB_2.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine3_partial.bit" Bitstreams/UCB_3.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCB_pblock_machine4_partial.bit" Bitstreams/UCB_4.bin
close_project 


open_checkpoint Implement/BLANK/top_route_design.dcp 
write_bitstream -file Bitstreams/BLANK.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine1_partial.bit" Bitstreams/BLANK_1.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine2_partial.bit" Bitstreams/BLANK_2.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine3_partial.bit" Bitstreams/BLANK_3.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/BLANK_pblock_machine4_partial.bit" Bitstreams/BLANK_4.bin
close_project 


open_checkpoint Implement/UCBV/top_route_design.dcp
write_bitstream -file Bitstreams/UCBV.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine1_partial.bit" Bitstreams/UCBV_1.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine2_partial.bit" Bitstreams/UCBV_2.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine3_partial.bit" Bitstreams/UCBV_3.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/UCBV_pblock_machine4_partial.bit" Bitstreams/UCBV_4.bin
close_project 

open_checkpoint Implement/TUNED/top_route_design.dcp
write_bitstream -file Bitstreams/TUNED.bit 
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine1_partial.bit" Bitstreams/TUNED_1.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine2_partial.bit" Bitstreams/TUNED_2.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine3_partial.bit" Bitstreams/TUNED_3.bin
write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 Bitstreams/TUNED_pblock_machine4_partial.bit" Bitstreams/TUNED_4.bin
close_project 