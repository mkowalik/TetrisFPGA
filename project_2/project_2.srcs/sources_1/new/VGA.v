`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:03:19
// Design Name: 
// Module Name: VGA
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


module VGA(
    input wire          clk_40MHz,
    input wire  [8:0]   Old_brick_tab,
    input wire  [8:0]   New_brick_tab,
    output reg          h_sync,
    output reg          v_sync,
    output reg  [3:0]   Red,
    output reg  [3:0]   Blue,
    output reg  [3:0]   Green,
    output reg          h_blnk,
    output reg          v_blnk
    );
endmodule
