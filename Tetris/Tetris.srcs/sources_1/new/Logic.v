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
    input wire            clk_down,
    input wire  [449:0]   New_brick_tab,
    input wire  [449:0]   Old_brick_tab,
    output reg  [449:0]   Tab_save,
    output reg            New_brick
    );
    
    reg [449:0] or_tab, and_tab;
    reg New_brick_nxt;
    
    /*assign New_brick = 1;
    assign Tab_save  = New_brick_tab; */
 
    always @ *
        begin
            and_tab = New_brick_tab & Old_brick_tab;
            New_brick_nxt = 1'b1;
            or_tab = New_brick_tab | Old_brick_tab;
        end
        
    always @ (posedge clk_down)
        begin
            if (and_tab == 449'b0)
                New_brick <= 1'b1;
            else
                New_brick <= 1'b0;
                
            Tab_save  <= or_tab;
        end
        
        
endmodule
