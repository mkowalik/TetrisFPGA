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


module TOP (
    input wire           clk,
    inout wire           ps2_data,
    inout wire           ps2_clk,
    output wire          hs,
    output wire          vs,
    output wire  [3:0]   r,
    output wire  [3:0]   b,
    output wire  [3:0]   g,
    output wire [6:0]    seg,    // segments (active LOW)
    output wire          dp,     // dot in segment display (active LOW)
    output wire [3:0]    an,      // anode enable (active LOW)
    input wire           btnU
    );
    
    wire        clk_down, clk_40MHz, clk_100MHz;
    wire        Key_pressed;
    wire [15:0] Key_code;
    wire [449:0]Old_brick_tab, New_brick_tab;
    wire        Game_over;
    
    clk_wiz_0 my_clk_wiz (
        .clk(clk),
        .clk_100MHz(clk_100MHz),
        .clk_40MHz(clk_40MHz)
    );
    
    clk_divider
    #(   
        .divider(1) 
    )
     my_clk_divider_2Hz (
        .rst(1'b0),
        .clk100MHz(clk_100MHz),
        .clk_div(clk_down)
     );

    
    PS2 my_PS2(
        .clk_100MHz(clk_100MHz),
        .Keyboard_data(ps2_data),
        .Keyboard_clk(ps2_clk),
        .Key_pressed(Key_pressed),
        .Key_code(Key_code)
    );
    
    CORE my_CORE(
        .clk_down(clk_down),
        .clk_100MHz(clk_100MHz),
        .Key_pressed(Key_pressed),
        .Key_code(Key_code),
        .Old_brick_tab(Old_brick_tab),
        .New_brick_tab(New_brick_tab),
        .Game_over(Game_over),
        .btnU(btnU)
    );
    
    VGA my_VGA(
        .clk_40MHz(clk_40MHz),
        .Old_brick_tab(Old_brick_tab),
        .New_brick_tab(New_brick_tab),
        .Game_over(Game_over),
        .hsync_out(hs),
        .vsync_out(vs),
        .Red(r),
        .Blue(b),
        .Green(g),
        .hblnk_out(h_blnk),
        .vblnk_out(v_blnk)
    );
          
    disp_hex_mux my_disp_hex_mux (
     .clk(clk_100MHz), 
     .reset(1'b0),
     .hex3(Key_code[15:12]), 
     .hex2(Key_code[11:8]), 
     .hex1(Key_code[7:4]),
     .hex0(Key_code[3:0]),
     .dp_in(4'b1011),
     .an(an),
     .sseg({dp, seg})
    );
    
endmodule
