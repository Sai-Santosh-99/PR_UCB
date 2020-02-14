
`timescale 1 ns / 1 ps

	module q_variance_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S_X
		parameter integer C_S_X_TDATA_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S_T
		parameter integer C_S_T_TDATA_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S_N
		parameter integer C_S_N_TDATA_WIDTH	= 32
	)
	(
		// Users to add ports here
        output  wire final_q_valid,
        output wire [31:0] final_q,   
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S_X
		input wire  s_x_aclk,
		input wire  s_x_aresetn,
		output wire  s_x_tready,
		input wire [C_S_X_TDATA_WIDTH-1 : 0] s_x_tdata,
		input wire [(C_S_X_TDATA_WIDTH/8)-1 : 0] s_x_tstrb,
		input wire  s_x_tlast,
		input wire  s_x_tvalid,

		// Ports of Axi Slave Bus Interface S_T
		input wire  s_t_aclk,
		input wire  s_t_aresetn,
		output wire  s_t_tready,
		input wire [C_S_T_TDATA_WIDTH-1 : 0] s_t_tdata,
		input wire [(C_S_T_TDATA_WIDTH/8)-1 : 0] s_t_tstrb,
		input wire  s_t_tlast,
		input wire  s_t_tvalid,

		// Ports of Axi Slave Bus Interface S_N
		input wire  s_n_aclk,
		input wire  s_n_aresetn,
		output wire  s_n_tready,
		input wire [C_S_N_TDATA_WIDTH-1 : 0] s_n_tdata,
		input wire [(C_S_N_TDATA_WIDTH/8)-1 : 0] s_n_tstrb,
		input wire  s_n_tlast,
		input wire  s_n_tvalid
	);
// Instantiation of Axi Bus Interface S_X
	userlogic_variance # ( 
		.C_S_AXIS_X_TDATA_WIDTH(C_S_X_TDATA_WIDTH),
		.C_S_AXIS_T_TDATA_WIDTH(C_S_T_TDATA_WIDTH),
		.C_S_AXIS_N_TDATA_WIDTH(C_S_N_TDATA_WIDTH)
	) q1 (
		.s_aclk(s_x_aclk),
		.s_aresetn(s_x_aresetn),
		
		.s_x_tready(s_x_tready),
		.s_x_tdata(s_x_tdata),
		.s_x_tvalid(s_x_tvalid),
		
		.s_t_tready(s_t_tready),
        .s_t_tdata(s_t_tdata),
        .s_t_tvalid(s_t_tvalid),
        
        .s_n_tready(s_n_tready),
        .s_n_tdata(s_n_tdata),
        .s_n_tvalid(s_n_tvalid),
        
        .final_q_valid(final_q_valid),
        .final_q(final_q)
	);


	// Add user logic here

	// User logic ends

	endmodule
