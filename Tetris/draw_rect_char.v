`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2017 10:01:53
// Design Name: 
// Module Name: draw_rect_char
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


module draw_rect_char(
    input wire          clk,
    input wire [10:0]   hcount_in,
    input wire          hsync_in,
    input wire          hblnk_in,
    input wire [10:0]   vcount_in,
    input wire          vsync_in,
    input wire          vblnk_in,
    input wire [11:0]   rgb_in,
    input wire [7:0]    char_pixels,
    
    output reg [10:0]   hcount_out,
    output reg          hsync_out,
    output reg          hblnk_out,
    output reg [10:0]   vcount_out,
    output reg          vsync_out,
    output reg          vblnk_out,
    output reg [11:0]   rgb_out,
    output reg [7:0]    char_xy,
    output reg [3:0]    char_line
    );
    
    reg [11:0]  rgb_nxt = 0;
    reg [7:0]   char_xy_nxt = 0;
    reg [3:0]   char_line_nxt = 0;
    reg [10:0]  hcount_del, vcount_del;
    reg [11:0]  rgb_del;
    reg         hsync_del, hblnk_del, vsync_del, vblnk_del;
    
    
    always @ (posedge clk)
        begin
            hcount_del <= hcount_in;
            hsync_del  <= hsync_in;
            hblnk_del  <= hblnk_in;
            vcount_del <= vcount_in;
            vsync_del  <= vsync_in;
            vblnk_del  <= vblnk_in;
            rgb_del    <= rgb_in;
            
        end
    
    always @ (posedge clk)
        begin
            hcount_out <= hcount_del;
            hsync_out  <= hsync_del;
            hblnk_out  <= hblnk_del;
            vcount_out <= vcount_del;
            vsync_out  <= vsync_del;
            vblnk_out  <= vblnk_del;
            rgb_out    <= rgb_nxt;
        end
        
        
        

    always @ *
        begin
            char_xy_nxt   = {vcount_del[7:4], hcount_del[6:3]};
            char_line_nxt = vcount_del[3:0];
            if ( ( (hcount_del > 'd0) && (hcount_del <= ( 'd799) ) ) && ( ( vcount_del  > 'd575 ) && (vcount_del <= ( 'd799 ) ) ) )
                begin
                    char_xy = char_xy_nxt;
                    char_line = char_line_nxt;
                    if (char_pixels[4'b1000-hcount_del[2:0]]) 
                            rgb_nxt = 12'h0_0_0;
                    else
                            rgb_nxt = 12'h0_0_f;
                end
            else
                begin
                    char_xy = 'b0;
                    char_line = 'b0;
                    rgb_nxt = rgb_del;  
                end
        end
    
endmodule
