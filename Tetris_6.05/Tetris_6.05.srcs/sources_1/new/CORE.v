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


module CORE(
    input wire          clk_down,
    input wire          Key_pressed,
    input wire [7:0]    Key_code,
    output reg [8:0]    Old_brick_tab,
    output reg [8:0]    New_brick_tab
    );
    
    wire            Left, Right; 
    wire            New_brick;
    wire    [8:0]   Tab_save, Old_brick_tab_nxt, New_brick_tab_nxt;
    
    
    Left_Right  my_Left_Right(
        .Key_pressed(Key_pressed),
        .Key_code(Key_code),
        .Left(Left),
        .Right(Right)
    );
    
    New_Brick my_New_Brick(
        .clk_down(clk_down),
        .Left(Left),
        .Right(Right),
        .New_brick(New_brick),
        .New_brick_tab(New_brick_tab_nxt)
    );
    
    Logic my_Logic(
        .New_brick_tab(New_brick_tab_nxt),
        .Old_brick_tab(Old_brick_tab_nxt),
        .Tab_save(Tab_save),
        .New_brick(New_brick)
    );
    
    Memory my_Memory(
        .Tab_save(Tab_save),
        .Old_brick_tab(Old_brick_tab_nxt)
    );
    
    always @ (clk_down)
        begin
            Old_brick_tab   <=  Old_brick_tab_nxt;
            New_brick_tab   <=  New_brick_tab_nxt;
        end
    
endmodule
