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
    input   wire          New_brick_signal,
    input   wire [449:0]    Tab_save,
    output  wire [449:0]    Old_brick_tab
    );
    
    reg [449:0] Old_brick_tab_nxt;
    
    always @ *
        if(New_brick_signal)
            Old_brick_tab_nxt = Tab_save;
        else    
            Old_brick_tab_nxt = Old_brick_tab;
            
    assign  Old_brick_tab = Old_brick_tab_nxt;  
    
    
endmodule