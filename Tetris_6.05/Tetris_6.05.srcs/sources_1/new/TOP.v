`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:11:50
// Design Name: 
// Module Name: TOP
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


module TOP(
    input wire          clk,
    input wire          Keyboard_data,
    input wire          Keyboard_clk,
    output reg          h_sync,
    output reg          v_sync,
    output reg  [3:0]   Red,
    output reg  [3:0]   Blue,
    output reg  [3:0]   Green,
    output reg          h_blnk,
    output reg          v_blnk
    );
    
    wire        clk_down, clk_10kHz, clk_40MHz;
    wire        Key_pressed;
    wire [7:0]  Key_code;
    wire [8:0]  Old_brick_tab, New_brick_tab;
    wire        h_sync_nxt, v_sync_nxt;
    wire [3:0]  Red_nxt, Blue_nxt, Green_nxt;
    wire        h_blnk_nxt, v_blnk_nxt;
    
    clk_wiz_0 my_clk_wiz (
        .clk(clk),
        .clk100MHz(clk_100MHz),
        .clk40MHz(clk_40MHz),
        .reset('b0),
        .locked()
    );
    
    clk_divider my_clk_divider_10kHz(
        .clk100MHz(clk_100MHz),
        .clk_div(clk_10kHz)
    );
    
    clk_divider
    #(   
        .divider(1) 
    )
     my_clk_divider_2Hz (
        .clk100MHz(clk_100MHz),
        .clk_div(clk_down)
     );

    
    PS2 my_PS2(
        .clk_10kHz(clk_10kHz),
        .Keyboard_data(Keyboard_data),
        .Keyboard_clk(Keyboard_clk),
        .Key_pressed(Key_pressed),
        .Key_code(Key_code)
    );
    
    CORE my_CORE(
        .clk_down(clk_down),
        .Key_pressed(Key_pressed),
        .Key_code(Key_code),
        .Old_brick_tab(Old_brick_tab),
        .New_brick_tab(New_brick_tab)
    );
    
    VGA my_VGA(
        .clk_40MHz(clk_40MHz),
        .Old_brick_tab(Old_brick_tab),
        .New_brick_tab(New_brick_tab),
        .h_sync(h_sync_nxt),
        .v_sync(v_sync_nxt),
        .Red(Red_nxt),
        .Blue(Blue_nxt),
        .Green(Green_nxt),
        .h_blnk(h_blnk_nxt),
        .v_blnk(v_blnk_nxt)
    );
    
    always @ (clk_40MHz)
        begin
            h_sync <=  h_sync_nxt;
            v_sync <=  v_sync_nxt;
            Red    <=  Red_nxt;
            Blue   <=  Blue_nxt;
            Green  <=  Green_nxt;
            h_blnk <=   h_blnk_nxt;
            v_blnk <=   v_blnk_nxt;
        end
    
endmodule
