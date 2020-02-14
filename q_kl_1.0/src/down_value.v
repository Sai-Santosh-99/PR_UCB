`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2019 15:47:28
// Design Name: 
// Module Name: down_value
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


module down_value(
    
    input s_aclk, s_aresetn,
    
    input [31:0] p, q, d, um_old, lm_old,
    
    input valid_q,
    
    output valid_down,
    
    output reg [31:0] um_new,
    output reg [31:0] lm_new

    );
    
       wire s_axis_a_tready_q;
        
                          
       reg [5:0] count_q_next= 0;
       reg [5:0] count_q_reg= 0;
       reg s00_axis_tvalid_q= 0;
        
       reg float_q_valid_prev= 0;

                
        always@(posedge s_aclk) begin
            float_q_valid_prev <= valid_q; 
        end   

           
                 always@(posedge s_aclk) 
                 begin
                       count_q_reg <= count_q_next;
                 end   
                 
                 
               always@(*)
               begin 
                   if (s_axis_a_tready_q == 1'b1 && s00_axis_tvalid_q==1'b1)
                       count_q_next = 6;  
                   else
                        count_q_next = 20;
               end                            
                                 
                              // Valid signal for T input of Q1-function IP
               always@(*)
               begin
                   if (float_q_valid_prev == 0 && valid_q == 1'b1) 
                       s00_axis_tvalid_q = 1;
                   else if (count_q_reg == 6) begin
                       s00_axis_tvalid_q = 0;
                   end                                      
               end
               
        
        wire eps_ready;
        
        wire gte_p_eps_valid, gte_p_eps_ready;
        wire eps_p;
        
        floating_point_gte max_p_eps_ip (
          .aclk(s_aclk),                                  // input wire aclk
          .aresetn(s_aresetn),                            // input wire aresetn
          .s_axis_a_tvalid(s00_axis_tvalid_q),            // input wire s_axis_a_tvalid
          .s_axis_a_tready(s_axis_a_tready_q),            // output wire s_axis_a_tready
          .s_axis_a_tdata(p),              // input wire [31 : 0] s_axis_a_tdata
          .s_axis_b_tvalid(s00_axis_tvalid_q),            // input wire s_axis_b_tvalid
          .s_axis_b_tready(eps_ready),            // output wire s_axis_b_tready
          .s_axis_b_tdata(32'b00100101011111111111001011010110),              // input wire [31 : 0] s_axis_b_tdata
          .m_axis_result_tvalid(gte_p_eps_valid),  // output wire m_axis_result_tvalid
          .m_axis_result_tready(gte_p_eps_ready),  // input wire m_axis_result_tready
          .m_axis_result_tdata(eps_p)    // output wire [7 : 0] m_axis_result_tdata
        );
        
        
        reg [31:0] max_p_eps= 0;
        always@(*)
        begin
            if(gte_p_eps_valid==1'b1)
                max_p_eps = (eps_p?p:32'b00100101011111111111001011010110);
        end
        
        wire ready_oneminuseps;
        
        wire min_oneminuseps;
        wire ready_min_oneminuseps, valid_min_oneminuseps;
        
        floating_point_gte min_p_oneminuseps_ip (
          .aclk(s_aclk),                                  // input wire aclk
          .aresetn(s_aresetn),                            // input wire aresetn
          .s_axis_a_tvalid(gte_p_eps_valid),            // input wire s_axis_a_tvalid
          .s_axis_a_tready(gte_p_eps_ready),            // output wire s_axis_a_tready
          .s_axis_a_tdata(max_p_eps),              // input wire [31 : 0] s_axis_a_tdata
          .s_axis_b_tvalid(gte_p_eps_valid),            // input wire s_axis_b_tvalid
          .s_axis_b_tready(ready_oneminuseps),            // output wire s_axis_b_tready
          .s_axis_b_tdata(32'b00111111011111111111111111111100),              // input wire [31 : 0] s_axis_b_tdata
          .m_axis_result_tvalid(valid_min_oneminuseps),  // output wire m_axis_result_tvalid
          .m_axis_result_tready(ready_min_oneminuseps),  // input wire m_axis_result_tready
          .m_axis_result_tdata(min_oneminuseps)   // output wire [7 : 0] m_axis_result_tdata
        );
     
         
        reg [31:0] min_p_oneminuseps= 0;
        always@(*)
        begin
            if(valid_min_oneminuseps==1'b1)
                min_p_oneminuseps = (min_oneminuseps?32'b00111111011111111111111111111100:max_p_eps);
        end
        
       
        // p.*log(p./q) + (1-p).*log((1-p)./(1-q));    
        
        // 1 - P

        wire [31:0] oneminusp;
        wire ready_oneminusp, valid_oneminusp;
        
        wire one_ready;
        
        floating_point_sub oneminusp_ip (
            .aclk(s_aclk),                                  // input wire aclk
            .aresetn(s_aresetn),                            // input wire aresetn
            .s_axis_a_tvalid(valid_min_oneminuseps),            // input wire s_axis_a_tvalid
            .s_axis_a_tready(one_ready),            // output wire s_axis_a_tready
            .s_axis_a_tdata(32'b00111111100000000000000000000000),              // input wire [31 : 0] s_axis_a_tdata
            .s_axis_b_tvalid(valid_min_oneminuseps),            // input wire s_axis_b_tvalid
            .s_axis_b_tready(ready_min_oneminuseps),            // output wire s_axis_b_tready
            .s_axis_b_tdata(min_p_oneminuseps),              // input wire [31 : 0] s_axis_b_tdata
            .m_axis_result_tvalid(valid_oneminusp),  // output wire m_axis_result_tvalid
            .m_axis_result_tready(ready_oneminusp),  // input wire m_axis_result_tready
            .m_axis_result_tdata(oneminusp)    // output wire [31 : 0] m_axis_result_tdata
        ); 
        
         wire eps_ready_2;
               
               wire gte_q_eps_valid, gte_q_eps_ready;
               wire eps_q;
               
               floating_point_gte max_q_eps_ip (
                 .aclk(s_aclk),                                  // input wire aclk
                 .aresetn(s_aresetn),                            // input wire aresetn
                 .s_axis_a_tvalid(s00_axis_tvalid_q),            // input wire s_axis_a_tvalid
//                 .s_axis_a_tready(s_axis_a_tready_gte122),            // output wire s_axis_a_tready
                 .s_axis_a_tdata(q),              // input wire [31 : 0] s_axis_a_tdata
                 .s_axis_b_tvalid(s00_axis_tvalid_q),            // input wire s_axis_b_tvalid
                 .s_axis_b_tready(eps_ready_2),            // output wire s_axis_b_tready
                 .s_axis_b_tdata(32'b00100101011111111111001011010110),              // input wire [31 : 0] s_axis_b_tdata
                 .m_axis_result_tvalid(gte_q_eps_valid),  // output wire m_axis_result_tvalid
                 .m_axis_result_tready(gte_q_eps_ready),  // input wire m_axis_result_tready
                 .m_axis_result_tdata(eps_q)    // output wire [7 : 0] m_axis_result_tdata
               );
               
               
               reg [31:0] max_q_eps= 0;
               always@(*)
               begin
                   if(gte_q_eps_valid==1'b1)
                       max_q_eps = (eps_q?q:32'b00100101011111111111001011010110);

               end
               
               wire ready_oneminuseps_2;
               
               wire min_oneminuseps_q;
               wire ready_min_oneminuseps_q, valid_min_oneminuseps_q;
               
               floating_point_gte min_q_oneminuseps_ip (
                 .aclk(s_aclk),                                  // input wire aclk
                 .aresetn(s_aresetn),                            // input wire aresetn
                 .s_axis_a_tvalid(gte_q_eps_valid),            // input wire s_axis_a_tvalid
                 .s_axis_a_tready(gte_q_eps_ready),            // output wire s_axis_a_tready
                 .s_axis_a_tdata(max_q_eps),              // input wire [31 : 0] s_axis_a_tdata
                 .s_axis_b_tvalid(gte_q_eps_valid),            // input wire s_axis_b_tvalid
                 .s_axis_b_tready(ready_oneminuseps_2),            // output wire s_axis_b_tready
                 .s_axis_b_tdata(32'b00111111011111111111111111111100),              // input wire [31 : 0] s_axis_b_tdata
                 .m_axis_result_tvalid(valid_min_oneminuseps_q),  // output wire m_axis_result_tvalid
                 .m_axis_result_tready(ready_min_oneminuseps_q),  // input wire m_axis_result_tready
                 .m_axis_result_tdata(min_oneminuseps_q)   // output wire [7 : 0] m_axis_result_tdata
               );
            
                
               reg [31:0] min_q_oneminuseps= 0;
               always@(*)
               begin
                   if(valid_min_oneminuseps_q==1'b1)
                       min_q_oneminuseps = (min_oneminuseps_q?32'b00111111011111111111111111111100:max_q_eps);

               end
                       
        
        // 1-Q
        
        wire [31:0] oneminusq;
        wire ready_oneminusq, valid_oneminusq;
        
        wire one_ready_2;
        
        floating_point_sub oneminusq_ip (
            .aclk(s_aclk),                                  // input wire aclk
            .aresetn(s_aresetn),                            // input wire aresetn
            .s_axis_a_tvalid(valid_min_oneminuseps_q),            // input wire s_axis_a_tvalid
            .s_axis_a_tready(one_ready_2),            // output wire s_axis_a_tready
            .s_axis_a_tdata(32'b00111111100000000000000000000000),              // input wire [31 : 0] s_axis_a_tdata
            .s_axis_b_tvalid(valid_min_oneminuseps_q),            // input wire s_axis_b_tvalid
            .s_axis_b_tready(ready_min_oneminuseps_q),            // output wire s_axis_b_tready
            .s_axis_b_tdata(min_q_oneminuseps),              // input wire [31 : 0] s_axis_b_tdata
            .m_axis_result_tvalid(valid_oneminusq),  // output wire m_axis_result_tvalid
            .m_axis_result_tready(ready_oneminusq),  // input wire m_axis_result_tready
            .m_axis_result_tdata(oneminusq)    // output wire [31 : 0] m_axis_result_tdata
        );
        
        // P / Q
        
        wire [31:0] pdivq;
        wire ready_pdivq, valid_pdivq;
                
        floating_point_div pdivq_ip (
            .aclk(s_aclk),                                  // input wire aclk
            .aresetn(s_aresetn),                            // input wire aresetn
            .s_axis_a_tvalid(valid_min_oneminuseps),            // input wire s_axis_a_tvalid
//            .s_axis_a_tready(ready_min_oneminuseps),            // output wire s_axis_a_tready
            .s_axis_a_tdata(min_p_oneminuseps),              // input wire [31 : 0] s_axis_a_tdata
            .s_axis_b_tvalid(valid_min_oneminuseps_q),            // input wire s_axis_b_tvalid
//            .s_axis_b_tready(ready_min_oneminuseps_q),            // output wire s_axis_b_tready
            .s_axis_b_tdata(min_q_oneminuseps),              // input wire [31 : 0] s_axis_b_tdata
            .m_axis_result_tvalid(valid_pdivq),  // output wire m_axis_result_tvalid
            .m_axis_result_tready(ready_pdivq),  // input wire m_axis_result_tready
            .m_axis_result_tdata(pdivq)    // output wire [31 : 0] m_axis_result_tdata
        );
        
        // LOG P/Q
        
        wire [31:0] log_pdivq;
        wire valid_log_pdivq, ready_log_pdivq;
        
        floating_point_ln lnlnt (
            .aclk(s_aclk),                                  // input wire aclk
            .aresetn(s_aresetn),                            // input wire aresetn
            .s_axis_a_tvalid(valid_pdivq),            // input wire s_axis_a_tvalid
            .s_axis_a_tready(ready_pdivq),            // output wire s_axis_a_tready
            .s_axis_a_tdata(pdivq),              // input wire [31 : 0] s_axis_a_tdata
            .m_axis_result_tvalid(valid_log_pdivq),  // output wire m_axis_result_tvalid
            .m_axis_result_tready(ready_log_pdivq),  // input wire m_axis_result_tready
            .m_axis_result_tdata(log_pdivq)    // output wire [31 : 0] m_axis_result_tdata
        );
        
        // 1-P / 1-Q 
        
        wire [31:0] oneminuspdiv_oneminusq;
        wire ready_oneminuspdiv_oneminusq, valid_oneminuspdiv_oneminusq;
        
        floating_point_div oneminuspdiv_oneminusq_ip (
            .aclk(s_aclk),                                  // input wire aclk
            .aresetn(s_aresetn),                            // input wire aresetn
            .s_axis_a_tvalid(valid_oneminusp),            // input wire s_axis_a_tvalid
            .s_axis_a_tready(ready_oneminusp),            // output wire s_axis_a_tready
            .s_axis_a_tdata(oneminusp),              // input wire [31 : 0] s_axis_a_tdata
            .s_axis_b_tvalid(valid_oneminusq),            // input wire s_axis_b_tvalid
            .s_axis_b_tready(ready_oneminusq),            // output wire s_axis_b_tready
            .s_axis_b_tdata(oneminusq),              // input wire [31 : 0] s_axis_b_tdata
            .m_axis_result_tvalid(valid_oneminuspdiv_oneminusq),  // output wire m_axis_result_tvalid
            .m_axis_result_tready(ready_oneminuspdiv_oneminusq),  // input wire m_axis_result_tready
            .m_axis_result_tdata(oneminuspdiv_oneminusq)    // output wire [31 : 0] m_axis_result_tdata
        );
        
        // LOG 1-P / 1-Q 
        
        wire [31:0] log_onep_oneq;
        wire ready_log_onep_oneq, valid_log_onep_oneq;
        
        floating_point_ln log_onep_oneq_ip (
            .aclk(s_aclk),                                  // input wire aclk
            .aresetn(s_aresetn),                            // input wire aresetn
            .s_axis_a_tvalid(valid_oneminuspdiv_oneminusq),            // input wire s_axis_a_tvalid
            .s_axis_a_tready(ready_oneminuspdiv_oneminusq),            // output wire s_axis_a_tready
            .s_axis_a_tdata(oneminuspdiv_oneminusq),              // input wire [31 : 0] s_axis_a_tdata
            .m_axis_result_tvalid(valid_log_onep_oneq),  // output wire m_axis_result_tvalid
            .m_axis_result_tready(ready_log_onep_oneq),  // input wire m_axis_result_tready
            .m_axis_result_tdata(log_onep_oneq)    // output wire [31 : 0] m_axis_result_tdata
        );
        
        // P LOG P/Q
                // min_q_oneminuseps min_p_oneminuseps

        wire [31:0] p_logpbyq;
        wire ready_p_logpbyq, valid_p_logpbyq;
        
        floating_point_mul p_logpbyq_ip (
          .aclk(s_aclk),                                  // input wire aclk
          .aresetn(s_aresetn),                            // input wire aresetn
          .s_axis_a_tvalid(valid_min_oneminuseps),            // input wire s_axis_a_tvalid
    //      .s_axis_a_tready(),            // output wire s_axis_a_tready
          .s_axis_a_tdata(min_p_oneminuseps),              // input wire [31 : 0] s_axis_a_tdata
          .s_axis_b_tvalid(valid_log_pdivq),            // input wire s_axis_b_tvalid
          .s_axis_b_tready(ready_log_pdivq),            // output wire s_axis_b_tready
          .s_axis_b_tdata(log_pdivq),              // input wire [31 : 0] s_axis_b_tdata
          .m_axis_result_tvalid(valid_p_logpbyq),  // output wire m_axis_result_tvalid
          .m_axis_result_tready(ready_p_logpbyq),  // input wire m_axis_result_tready
          .m_axis_result_tdata(p_logpbyq)    // output wire [31 : 0] m_axis_result_tdata
        );
        
        // (1-P) LOG 1-P/1-Q
        wire [31:0] oneminusp_log;
        wire ready_oneminusp_log, valid_oneminusp_log;
        
        floating_point_mul oneminusp_log_ip (
          .aclk(s_aclk),                                  // input wire aclk
          .aresetn(s_aresetn),                            // input wire aresetn
          .s_axis_a_tvalid(valid_oneminusp),            // input wire s_axis_a_tvalid
    //      .s_axis_a_tready(),            // output wire s_axis_a_tready
          .s_axis_a_tdata(oneminusp),              // input wire [31 : 0] s_axis_a_tdata
          .s_axis_b_tvalid(valid_log_onep_oneq),            // input wire s_axis_b_tvalid
          .s_axis_b_tready(ready_log_onep_oneq),            // output wire s_axis_b_tready
          .s_axis_b_tdata(log_onep_oneq),              // input wire [31 : 0] s_axis_b_tdata
          .m_axis_result_tvalid(valid_oneminusp_log),  // output wire m_axis_result_tvalid
          .m_axis_result_tready(ready_oneminusp_log),  // input wire m_axis_result_tready
          .m_axis_result_tdata(oneminusp_log)    // output wire [31 : 0] m_axis_result_tdata
        );
        
        // FINAL OUT -------------------------------------------
        
        wire [31:0] final_out;
        wire valid_final_out, ready_final_out;
        
        floating_point_add final_out_ip (
            .aclk(s_aclk),                                  // input wire aclk
            .aresetn(s_aresetn),                            // input wire aresetn
            .s_axis_a_tvalid(valid_p_logpbyq),            // input wire s_axis_a_tvalid
            .s_axis_a_tready(ready_p_logpbyq),            // output wire s_axis_a_tready
            .s_axis_a_tdata(p_logpbyq),              // input wire [31 : 0] s_axis_a_tdata
            .s_axis_b_tvalid(valid_oneminusp_log),            // input wire s_axis_b_tvalid
            .s_axis_b_tready(ready_oneminusp_log),            // output wire s_axis_b_tready
            .s_axis_b_tdata(oneminusp_log),              // input wire [31 : 0] s_axis_b_tdata
            .m_axis_result_tvalid(valid_final_out),  // output wire m_axis_result_tvalid
            .m_axis_result_tready(ready_final_out),  // input wire m_axis_result_tready
            .m_axis_result_tdata(final_out)    // output wire [31 : 0] m_axis_result_tdata
        ); 
        
        // -----------------------------------------------------
        
        wire down;
       
        
        floating_point_gt down_ip (
          .aclk(s_aclk),                                  // input wire aclk
          .aresetn(s_aresetn),                            // input wire aresetn
          .s_axis_a_tvalid(valid_final_out),            // input wire s_axis_a_tvalid
          .s_axis_a_tready(ready_final_out),            // output wire s_axis_a_tready
          .s_axis_a_tdata(final_out),              // input wire [31 : 0] s_axis_a_tdata
          .s_axis_b_tvalid(valid_final_out),            // input wire s_axis_b_tvalid
//          .s_axis_b_tready(s_axis_a_tready_gte122),            // output wire s_axis_b_tready
          .s_axis_b_tdata(d),              // input wire [31 : 0] s_axis_b_tdata
          .m_axis_result_tvalid(valid_down),  // output wire m_axis_result_tvalid
          .m_axis_result_tready(1'b1),  // input wire m_axis_result_tready  ====================================================================
          .m_axis_result_tdata(down)    // output wire [7 : 0] m_axis_result_tdata
        );

        always@(posedge s_aclk)
        begin

            if(valid_down == 1'b1)
            begin
                if(down)
                begin
                um_new <= q;
                lm_new <= lm_old;
                end
                    
                else
                begin
                lm_new <= q;
                um_new <= um_old;
                end
            end

        end    

endmodule
