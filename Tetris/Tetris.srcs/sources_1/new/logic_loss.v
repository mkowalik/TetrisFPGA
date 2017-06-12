`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2017 12:12:30
// Design Name: 
// Module Name: logic_loss
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


module logic_loss(
    input wire            clk_100MHz,
    input wire  [449:0]   Tab_save_tab_in,
    input wire            Tab_save_signal_in,
    input wire  [449:0]   New_brick_tab_in,
    
    output reg [449:0]    Tab_save_tab_out,
    output reg            Tab_save_signal_out,
    output reg [449:0]    New_brick_tab_out
    );
endmodule