`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:03:19
// Design Name: 
// Module Name: Logic
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
//Testowy komentarz

module Logic(
    input wire            clk_100MHz,
    input wire  [449:0]   New_brick_tab_in,
    input wire  [449:0]   Old_brick_tab_in,
    
    output reg  [449:0]   Tab_save_tab = 449'b0,
    output reg            Tab_save_signal,
    output reg [449:0]    New_brick_tab_out
    );
    
    reg             Tab_save_signal_nxt;
    reg [449:0]     Tab_save_tab_nxt;
    
    integer p, q;
    integer index_up, index_down;
        
    always @* begin
        
        Tab_save_signal_nxt = 1'b0;
        Tab_save_tab_nxt = Tab_save_tab;
    
        for (p=0; p<18; p = p+1) begin
            for (q=0; q<25; q = q+1) begin
                if (p<17) begin
                index_up = (p*25) + q;
                index_down = ((p+1)*25) + q;
                
                if ((New_brick_tab_in[index_up] == 1) && (Old_brick_tab_in[index_down] == 1)) begin 
                    Tab_save_signal_nxt = 1'b1;
                    Tab_save_tab_nxt = New_brick_tab_in | Old_brick_tab_in;
                end
                
                end else begin
                    // p == 17     
                    index_up = (p*25) + q;   
                    if ( (New_brick_tab_in[index_up] == 1)) begin 
                        Tab_save_signal_nxt = 1'b1;
                        Tab_save_tab_nxt = New_brick_tab_in | Old_brick_tab_in;
                    end
                end
            end 
        end
    end
    
    always @(posedge clk_100MHz) begin
        Tab_save_signal = Tab_save_signal_nxt;
        Tab_save_tab <= Tab_save_tab_nxt;
        New_brick_tab_out <= New_brick_tab_in;
    end
    
        
endmodule
