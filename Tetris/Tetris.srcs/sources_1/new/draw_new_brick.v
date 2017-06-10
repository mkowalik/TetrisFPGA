`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2017 14:44:36
// Design Name: 
// Module Name: draw_new_brick
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


module draw_new_brick(
    input wire [449:0]  New_brick_tab,
    input wire [11:0] rgb_in,
    input wire [10:0] hcount_in,
    input wire        hsync_in,
    input wire        hblnk_in,
    input wire [10:0] vcount_in,
    input wire        vsync_in,
    input wire        vblnk_in,
    input wire        pclk_in,
    
    output reg [10:0] hcount_out,
    output reg        hsync_out,
    output reg        hblnk_out,
    output reg [10:0] vcount_out,
    output reg        vsync_out,
    output reg        vblnk_out,
    output reg [11:0] rgb_out
    );
    
    reg [11:0] rgb_nxt;
    reg [449:0]  New_brick_tab_del, New_brick_tab_del2;
    
    always @ (posedge pclk_in)
        begin
            New_brick_tab_del   <= New_brick_tab;
            New_brick_tab_del2  <= New_brick_tab_del;
            hcount_out <= hcount_in;
            hsync_out  <= hsync_in;
            hblnk_out  <= hblnk_in;
            vcount_out <= vcount_in;
            vsync_out  <= vsync_in;
            vblnk_out  <= vblnk_in;
            rgb_out    <= rgb_nxt;
        end
        
            
    always @ *
        begin
            if (New_brick_tab_del2[((vcount_in/32)*25)+(hcount_in/32)])
                rgb_nxt = 12'h7_8_9;
            else
                rgb_nxt = rgb_in;
        end
    
    
    
endmodule
