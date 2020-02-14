`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2019 19:20:33
// Design Name: 
// Module Name: Q_function_imp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

    
    	module userlogic_variance #
    (
        // Users to add parameters here

        // User parameters ends
        // Do not modify the parameters beyond this line

        // AXI4Stream sink: Data Width
        parameter integer C_S_AXIS_X_TDATA_WIDTH    = 32,
        parameter integer C_S_AXIS_T_TDATA_WIDTH    = 32,
        parameter integer C_S_AXIS_N_TDATA_WIDTH    = 32
    )
    (
        // Users to add ports here
        
        output  wire final_q_valid,
        output wire [31:0] final_q,  
          
        // User ports ends
        // Do not modify the ports beyond this line

        // AXI4Stream sink: Clock
        input wire  s_aclk,
        // AXI4Stream sink: Reset
        input wire  s_aresetn,
        // Ready to accept data in
        output wire  s_x_tready,
        // Data in
        input wire [C_S_AXIS_X_TDATA_WIDTH-1 : 0] s_x_tdata,
        // Data is in valid
        input wire  s_x_tvalid,
        
                // Ready to accept data in
        output wire  s_t_tready,
        // Data in
        input wire [C_S_AXIS_T_TDATA_WIDTH-1 : 0] s_t_tdata,
        // Data is in valid
        input wire  s_t_tvalid,
        
                // Ready to accept data in
        output wire  s_n_tready,
        // Data in
        input wire [C_S_AXIS_N_TDATA_WIDTH-1 : 0] s_n_tdata,
        // Data is in valid
        input wire  s_n_tvalid
    );
    
    wire float_x_valid, float_x_ready;
    wire [31:0] float_x;
    
    fix_float fx (
      .aclk(s_aclk),                                  // input wire aclk
      .aresetn(s_aresetn),                            // input wire aresetn
      .s_axis_a_tvalid(s_x_tvalid),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(s_x_tready),            // output wire s_axis_a_tready
      .s_axis_a_tdata(s_x_tdata),              // input wire [31 : 0] s_axis_a_tdata
      .m_axis_result_tvalid(float_x_valid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(float_x_ready),  // input wire m_axis_result_tready
      .m_axis_result_tdata(float_x)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    // This function is used to conver input T to floating point format
    wire [31:0] float_t;
    wire float_t_valid, float_t_ready;
    fix_float ft(
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(s_t_tvalid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(s_t_tready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(s_t_tdata),              // input wire [31 : 0] s_axis_a_tdata
        .m_axis_result_tvalid(float_t_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(float_t_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(float_t)    // output wire [31 : 0] m_axis_result_tdata
    );
       
       
    // This function is used to conver input N to floating point format   
    wire float_n_valid, float_n_ready;
    wire [31:0] float_n;
    fix_float fn(
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(s_n_tvalid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(s_n_tready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(s_n_tdata),              // input wire [31 : 0] s_axis_a_tdata
        .m_axis_result_tvalid(float_n_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(float_n_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(float_n)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] xdivt;
    wire xdivt_valid, xdivt_ready;
    
    floating_point_div xdivt_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(float_x_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(float_x_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(float_x),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(float_t_valid),            // input wire s_axis_b_tvalid
          .s_axis_b_tready(float_t_ready),            // output wire s_axis_b_tready
        .s_axis_b_tdata(float_t),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(xdivt_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(xdivt_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(xdivt)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] xdivt_sq;
    wire xdivt_sq_valid, xdivt_sq_ready;
    
    floating_point_mul xdivt_sq_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(xdivt_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(xdivt_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(xdivt),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(xdivt_valid),            // input wire s_axis_b_tvalid
//          .s_axis_b_tready(float_t_ready),            // output wire s_axis_b_tready
        .s_axis_b_tdata(xdivt),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(xdivt_sq_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(xdivt_sq_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(xdivt_sq)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] variance;
    wire variance_valid, variance_ready;
    
    floating_point_sub variance_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(xdivt_valid),            // input wire s_axis_a_tvalid
//        .s_axis_a_tready(xdivt_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(xdivt),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(xdivt_sq_valid),            // input wire s_axis_b_tvalid
          .s_axis_b_tready(xdivt_sq_ready),            // output wire s_axis_b_tready
        .s_axis_b_tdata(xdivt_sq),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(variance_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(variance_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(variance)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] log_n;
    wire log_n_valid, log_n_ready;
    
    floating_point_ln log_n_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(float_n_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(float_n_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(float_n),              // input wire [31 : 0] s_axis_a_tdata
        .m_axis_result_tvalid(log_n_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(log_n_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(log_n)    // output wire [31 : 0] m_axis_result_tdata
    );   
    
    wire [31:0] logn_byt;
    wire logn_byt_valid, logn_byt_ready;
    
    floating_point_div logn_byt_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(log_n_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(log_n_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(log_n),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(float_t_valid),            // input wire s_axis_b_tvalid
//        .s_axis_b_tready(),            // output wire s_axis_b_tready
        .s_axis_b_tdata(float_t),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(logn_byt_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(logn_byt_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(logn_byt)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] logn_byt_3;
    wire logn_byt_3_valid, logn_byt_3_ready;
    
    floating_point_mul logn_byt_3_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(logn_byt_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(logn_byt_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(logn_byt),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(logn_byt_valid),            // input wire s_axis_b_tvalid
//        .s_axis_b_tready(),            // output wire s_axis_b_tready
        .s_axis_b_tdata(32'b01000000010000000000000000000000),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(logn_byt_3_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(logn_byt_3_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(logn_byt_3)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] logn_byt_v;
    wire logn_byt_v_valid, logn_byt_v_ready;
    
    floating_point_mul logn_byt_v_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(logn_byt_valid),            // input wire s_axis_a_tvalid
//        .s_axis_a_tready(logn_byt_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(logn_byt),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(variance_valid),            // input wire s_axis_b_tvalid
        .s_axis_b_tready(variance_ready),            // output wire s_axis_b_tready
        .s_axis_b_tdata(variance),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(logn_byt_v_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(logn_byt_v_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(logn_byt_v)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] logn_byt_v_2;
    wire logn_byt_v_2_valid, logn_byt_v_2_ready;
    
    floating_point_mul logn_byt_v_2_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(logn_byt_v_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(logn_byt_v_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(logn_byt_v),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(logn_byt_v_valid),            // input wire s_axis_b_tvalid
//        .s_axis_b_tready(),            // output wire s_axis_b_tready
        .s_axis_b_tdata(32'b01000000000000000000000000000000),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(logn_byt_v_2_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(logn_byt_v_2_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(logn_byt_v_2)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] root_2;
    wire root_2_valid, root_2_ready;
    
    floating_point_sq root_2_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(logn_byt_v_2_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(logn_byt_v_2_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(logn_byt_v_2),              // input wire [31 : 0] s_axis_a_tdata
        .m_axis_result_tvalid(root_2_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(root_2_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(root_2)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] inter_q;
    wire inter_q_valid, inter_q_ready;
    
    floating_point_add inter_q_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(root_2_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(root_2_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(root_2),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(xdivt_valid),            // input wire s_axis_b_tvalid
//        .s_axis_b_tready(),            // output wire s_axis_b_tready
        .s_axis_b_tdata(xdivt),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(inter_q_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(inter_q_ready),  // input wire m_axis_result_tready
        .m_axis_result_tdata(inter_q)    // output wire [31 : 0] m_axis_result_tdata
    ); 
   
    floating_point_add final_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(inter_q_valid),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(inter_q_ready),            // output wire s_axis_a_tready
        .s_axis_a_tdata(inter_q),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(logn_byt_3_valid),            // input wire s_axis_b_tvalid
        .s_axis_b_tready(logn_byt_3_ready),            // output wire s_axis_b_tready
        .s_axis_b_tdata(logn_byt_3),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(final_q_valid),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(1'b1),  // input wire m_axis_result_tready
        .m_axis_result_tdata(final_q)    // output wire [31 : 0] m_axis_result_tdata
    ); 

endmodule
