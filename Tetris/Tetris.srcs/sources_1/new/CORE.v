`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:02:57
// Design Name: 
// Module Name: CORE
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

//width: 25, height: 18, brick: 32x32 pixels, 25*18 = 450

module CORE(
    input wire           clk_down,
    input wire           clk_100MHz,
    input wire           Key_pressed,
    input wire [15:0]    Key_code,  //TODO change for [15:0]
    output wire [449:0]  Old_brick_tab,
    output wire [449:0]  New_brick_tab,
    input wire           btnU
    );
    
    wire            left, right; 
    wire            Tab_save_signal;
    wire [449:0]    New_brick_tab_brick, New_brick_tab_logic, Tab_save_tab;
    
    
    Left_Right  my_Left_Right(
        .Key_pressed(Key_pressed),
        .Key_code(Key_code),
        .Left(left),
        .Right(right)
    );
    
    New_Brick my_New_Brick(
        .clk_down(clk_down),
        .clk_100MHz(clk_100MHz),
        .left(left),
        .right(right),
//        .new_brick_signal(new_brick_signal),
        .new_brick_signal(btnU),
        .brick_tab(New_brick_tab_brick)
    );
    
    Logic my_Logic(
        .clk_100MHz(clk_100MHz),
        .New_brick_tab_in(New_brick_tab_brick),
        .Old_brick_tab_in(Old_brick_tab),
        .Tab_save_signal(Tab_save_signal),
        .Tab_save_tab(Tab_save_tab),
        .New_brick_tab_out(New_brick_tab_logic)
    );
    
    
    Memory my_Memory(
        .clk_100MHz(clk_100MHz),
        .New_brick_signal(Tab_save_signal),
        .Tab_save(Tab_save_tab),
        .New_brick_tab_in(New_brick_tab_logic),
        .Old_brick_tab(Old_brick_tab),
        .New_brick_tab_out(New_brick_tab)
    );
    
    
endmodule
