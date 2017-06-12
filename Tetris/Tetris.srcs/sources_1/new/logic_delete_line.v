`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2017 09:31:10
// Design Name: 
// Module Name: logic_delete_line
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


module logic_delete_line(
    input wire            clk_100MHz,
    input wire  [449:0]   Tab_save_tab_in,
    input wire            Tab_save_signal_in,
    input wire  [449:0]   New_brick_tab_in,
    
    output reg [449:0]    Tab_save_tab_out,
    output reg            Tab_save_signal_out,
    output reg [449:0]    New_brick_tab_out
    );
    
    integer p, q;
    integer index;
    integer index_left, index_right;
    
    reg [449:0]     Tab_save_tab_out_nxt;
    reg             full_row = 1'b0;
    
    integer do_delete;
    integer row_to_delete;
    
    always@* begin
        
        do_delete = 0;
        row_to_delete = 0;
    
        for (p=0; p<18; p = p+1) begin
        
            full_row = 1'b1;
            
            for (q=0; q<25; q = q+1) begin
            
                index = (p*25) + q;
                if (Tab_save_tab_in[index] == 1'b0) begin
                    full_row = 1'b0;
                end
            end 
                                
            if (full_row == 1'b1) begin
            
                row_to_delete = p;
                do_delete = 1;
            
            end    
        end
        
        if (do_delete == 1) begin
            
             delete_row_task(p, Tab_save_tab_out_nxt);
            
        end else begin
        
            Tab_save_tab_out_nxt = Tab_save_tab_in;
        
        end
        
    end
    
    always @(posedge clk_100MHz) begin
        Tab_save_tab_out <= Tab_save_tab_out_nxt;
        Tab_save_signal_out <= Tab_save_signal_in;
        New_brick_tab_out <= New_brick_tab_in;
    end
    
    
    
    
    
    integer index_up, index_down;
    
    task delete_row_task;
    input [4:0] row_to_delete;
    output [449:0] output_tab;
    begin
                                    
    index_left = (row_to_delete*25);
    index_right = (row_to_delete*25)+24;
        
    for (p=0; p<18; p = p+1) begin
        
        if (p==0) begin
                
            for (q=0; q<25; q = q+1) begin
                index = (p*25) + q;
                output_tab [index] = 1'b0;
            end
        
        end else begin
            
            for (q=0; q<25; q = q+1) begin
            
                index_down = (p*25) + q;
                index_up = ((p-1)*25) + q;
                
                if (index_down <= index_right) 
                    output_tab[index_down] = Tab_save_tab_in[index_up];
                else
                    output_tab[index_down] = Tab_save_tab_in[index_down];
                
            end
        
        end
    end

    end
    endtask
    
endmodule
