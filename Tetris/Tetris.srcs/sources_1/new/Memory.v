`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:02:57
// Design Name: 
// Module Name: Memory
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


module Memory(

    input   wire            clk_100MHz,
    input   wire            New_brick_signal,
    input   wire [449:0]    Tab_save,
    input   wire [449:0]    New_brick_tab_in,
    output  reg  [449:0]    Old_brick_tab,
    output  reg  [449:0]    New_brick_tab_out
    );
    
    reg [449:0] Old_brick_tab_nxt;
    
    always @ *
        if(New_brick_signal)
            Old_brick_tab_nxt = Tab_save;
        else    
            Old_brick_tab_nxt = Old_brick_tab; 
            
    always @ (posedge clk_100MHz) begin
    
        Old_brick_tab <= Old_brick_tab_nxt;
        New_brick_tab_out <= New_brick_tab_in;
          
    end
    
    
endmodule