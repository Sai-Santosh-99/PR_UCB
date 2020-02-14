`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2019 18:35:33
// Design Name: 
// Module Name: back_logic
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


module back_logic(
    
    input s_aclk,
    input s_aresetn,
    input [31:0] p,
    input [31:0] d,
    
    input valid_p, 
    input valid_d,
    
    output reg [31:0] q_final,
    output reg valid_q_final
    );

    wire s_axis_a_tready_p, s_axis_a_tready_d;
    reg s00_axis_tvalid_p = 0;
    reg s00_axis_tvalid_d = 0;

     reg [5:0] count_p_next = 0 ;
     reg [5:0] count_p_reg = 0;       
     reg [5:0] count_d_next = 0 ;
     reg [5:0] count_d_reg = 0;
    
    reg float_p_valid_prev = 0;
    reg float_d_valid_prev = 0;

    
    always@(posedge s_aclk) begin
         float_p_valid_prev <= valid_p;
         float_d_valid_prev <= valid_d;
    end    

          always@(posedge s_aclk) 
          begin
               count_p_reg <= count_p_next;
          end   
          
          
        always@(*)
        begin
            
            if (s_axis_a_tready_p == 1'b1 && s00_axis_tvalid_p==1'b1)
                   count_p_next = 6;  
            else
                   count_p_next = 20;

        end                            
                          
        always@(*)
        begin
            if (float_p_valid_prev == 0 && valid_p == 1'b1) 
                s00_axis_tvalid_p = 1;
            else if (count_p_reg == 6) begin
                s00_axis_tvalid_p = 0;
            end
                               
        end
            
                  always@(posedge s_aclk) 
                  begin
                        count_d_reg <= count_d_next;
                  end   
                  
                  
                always@(*)
                begin
                    if (s_axis_a_tready_d == 1'b1 && s00_axis_tvalid_d==1'b1)
                            count_d_next = 6;     
                    else
                            count_d_next = 20; 
 
                end                            
                                  
                always@(*)
                begin
                    if (float_d_valid_prev == 0 && valid_d == 1'b1) 
                        s00_axis_tvalid_d = 1;
                    if (count_d_reg == 6) 
                        s00_axis_tvalid_d = 0;
              
                end               

    wire [31:0] lm;
    wire valid_lm, ready_lm;
    
    wire one_ready;
    
    floating_point_mul lm_ip (
      .aclk(s_aclk),                                  // input wire aclk
      .aresetn(s_aresetn),                            // input wire aresetn
      .s_axis_a_tvalid(s00_axis_tvalid_p),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(s_axis_a_tready_p),            // output wire s_axis_a_tready
      .s_axis_a_tdata(p),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(s00_axis_tvalid_p),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(one_ready),            // output wire s_axis_b_tready
      .s_axis_b_tdata(32'b00111111100000000000000000000000),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(valid_lm),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1'b1),  // input wire m_axis_result_tready =============================================================================
      .m_axis_result_tdata(lm)    // output wire [31 : 0] m_axis_result_tdata
    );


    wire [31:0] d_div_2;
    wire ready_d_div_2, valid_d_div_2;
    
    wire two_ready;
    
    floating_point_div dby2_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(s00_axis_tvalid_d),            // input wire s_axis_a_tvalid
        .s_axis_a_tready(s_axis_a_tready_d),            // output wire s_axis_a_tready
        .s_axis_a_tdata(d),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(s00_axis_tvalid_d),            // input wire s_axis_b_tvalid
        .s_axis_b_tready(two_ready),            // output wire s_axis_b_tready
        .s_axis_b_tdata(32'b01000000000000000000000000000000),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(valid_d_div_2),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(ready_d_div_2),  // input wire m_axis_result_tready
        .m_axis_result_tdata(d_div_2)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire [31:0] sq_d_by2;
    wire ready_sq_d_by2, valid_sq_d_by2;
    
    
    floating_point_sq sq_d_by2_ip (
      .aclk(s_aclk),                                  // input wire aclk
      .aresetn(s_aresetn),                            // input wire aresetn
      .s_axis_a_tvalid(valid_d_div_2),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(ready_d_div_2),            // output wire s_axis_a_tready
      .s_axis_a_tdata(d_div_2),              // input wire [31 : 0] s_axis_a_tdata
      .m_axis_result_tvalid(valid_sq_d_by2),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(ready_sq_d_by2),  // input wire m_axis_result_tready
      .m_axis_result_tdata(sq_d_by2)    // output wire [31 : 0] m_axis_result_tdata
    );

    
    wire [31:0] p_plus_sq;
    wire valid_p_plus_sq, ready_p_plus_sq;
    
    floating_point_add p_plus_sq_ip (
        .aclk(s_aclk),                                  // input wire aclk
        .aresetn(s_aresetn),                            // input wire aresetn
        .s_axis_a_tvalid(s00_axis_tvalid_p),            // input wire s_axis_a_tvalid
//        .s_axis_a_tready(s_axis_a_tready_gte121),            // output wire s_axis_a_tready
        .s_axis_a_tdata(p),              // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(valid_sq_d_by2),            // input wire s_axis_b_tvalid
        .s_axis_b_tready(ready_sq_d_by2),            // output wire s_axis_b_tready
        .s_axis_b_tdata(sq_d_by2),              // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(valid_p_plus_sq),  // output wire m_axis_result_tvalid
        .m_axis_result_tready(ready_p_plus_sq),  // input wire m_axis_result_tready
        .m_axis_result_tdata(p_plus_sq)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    wire one_ready_2;    
    
    wire gt_um;
    wire ready_gt_um;
    
    reg [31:0] um = 0;
    wire valid_um;
  
    floating_point_gte gt_um_ip (
      .aclk(s_aclk),                                  // input wire aclk
      .aresetn(s_aresetn),                            // input wire aresetn
      .s_axis_a_tvalid(valid_p_plus_sq),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(ready_p_plus_sq),            // output wire s_axis_a_tready
      .s_axis_a_tdata(p_plus_sq),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(valid_p_plus_sq),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(one_ready_2),            // output wire s_axis_b_tready
      .s_axis_b_tdata(32'b00111111100000000000000000000000),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(valid_um),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(1'b1),  // input wire m_axis_result_tready ========================================================================
      .m_axis_result_tdata(gt_um)   // output wire [7 : 0] m_axis_result_tdata
    );
    
    
    always@(*)
    begin
        if(valid_um ==1'b1)
            um = (gt_um?32'b00111111100000000000000000000000:p_plus_sq);
    end

    wire [31:0] um_1, lm_1; 
    wire valid_um_1;
   
    reg [31:0] um_reg= 0; reg [31:0] lm_reg = 0;
    reg valid_um_reg= 0;
    
    reg um_valid_1_reg = 0; reg um_valid_2_reg = 0; reg um_valid_1_next= 0 ;reg um_valid_2_next= 0;

    reg [4:0] count_next= 0; 
    reg [4:0] count_reg= 0;
       
       always@( posedge s_aclk)
       begin
            um_valid_1_reg <= um_valid_1_next;
            um_valid_2_reg <= um_valid_2_next; 
            count_reg <= count_next;   
       end

       always@(*)
       begin
            um_valid_1_next = valid_um;  
       end
       
       always@(*)
       begin
            um_valid_2_next = valid_um_1;
       end
       
       always@(*)
       begin
            if(count_reg == 5'd16)
            begin
                count_next = 5'd0;
            end
            
            else
            begin
                if(um_valid_1_reg == 1'b0 && um_valid_1_next == 1'b1 && count_reg == 5'd0)
                begin
                   count_next = count_reg +5'd1;
                end
                
                else if(um_valid_2_reg ==1'b0 && um_valid_2_next == 1'b1 && count_reg != 5'd0)
                begin
                    count_next = count_reg +5'd1;    
                end
                
                else
                    count_next = count_reg ;
            end
    
       end
    
       always@(*)
       begin
            if(count_reg == 5'd1)
            begin
                    lm_reg = lm; um_reg = um;
                    valid_um_reg = um_valid_1_reg;
    
            end
            
            else if(count_reg == 5'd0)
            begin
                  um_reg = 0; lm_reg = 0;
                  valid_um_reg = 0;
            end
            
            else
            begin
                    um_reg = um_1; lm_reg = lm_1;
                    valid_um_reg = um_valid_2_reg;          
            end
       end   
       
       always@(*)
       begin
           if(count_reg == 5'd16 && um_valid_2_reg == 1'b1)
                valid_q_final = 1'b1;
           else
                valid_q_final = 1'b0;       
       end
       
       always@(*)
       begin
            if(valid_q_final)
                q_final = um_1;
       end
       
       iteration_without_ip u1
               (.s_aclk(s_aclk),
                .s_aresetn(s_aresetn),
                .p(p),
                .d(d),
                .s_um_tdata(um_reg),
                .s_lm_tdata(lm_reg),
                .valid_p(valid_p),
                .valid_d(valid_d),
                .valid_um(valid_um_reg),
                .um_new(um_1),
                .lm_new(lm_1),
                .valid_down(valid_um_1));

endmodule
