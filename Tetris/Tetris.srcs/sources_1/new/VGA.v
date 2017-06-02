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
    input wire  [449:0] Old_brick_tab,
    input wire  [449:0] New_brick_tab,
    output reg          hsync_out,
    output reg          vsync_out,
    output reg  [3:0]   Red,
    output reg  [3:0]   Blue,
    output reg  [3:0]   Green,
    output reg          hblnk_out,
    output reg          vblnk_out
    );
    
    wire [10:0] vcount, hcount, vcount_bckg, hcount_bckg;
    wire        vsync, hsync, vblnk, hblnk, v_sync, h_sync, vsync_bckg, hsync_bckg, vblnk_bckg, hblnk_bckg;
    wire [11:0] rgb_out, rgb_bckg;
    
    vga_timing my_vga_timing(
        .vcount(vcount),
        .vsync(vsync),
        .vblnk(vblnk),
        .hcount(hcount),
        .hsync(hsync),
        .hblnk(hblnk),
        .pclk(clk_40MHz)
    );
    
    draw_background my_draw_background(
    
        .Old_brick_tab(Old_brick_tab),
        .hcount_in(hcount),
        .hsync_in(hsync),
        .hblnk_in(hblnk),
        .vcount_in(vcount),
        .vsync_in(vsync),
        .vblnk_in(vblnk),
        .pclk_in(clk_40MHz),
    
        .hcount_out(hcount_bckg),
        .hsync_out(hsync_bckg),
        .hblnk_out(hblnk_bckg),
        .vcount_out(vcount_bckg),
        .vsync_out(vsync_bckg),
        .vblnk_out(vblnk_bckg),
        .rgb_out(rgb_bckg)
    
    );
    
    draw_new_brick(
        .New_brick_tab(New_brick_tab),
        .rgb_in(rgb_bckg),
        .hcount_in(hcount_bckg),
        .hsync_in(hsync_bckg),
        .hblnk_in(hblnk_bckg),
        .vcount_in(vcount_bckg),
        .vsync_in(vsync_bckg),
        .vblnk_in(vblnk_bckg),
        .pclk_in(clk_40MHz),
        
        .hcount_out(),
        .hsync_out(h_sync),
        .hblnk_out(),
        .vcount_out(),
        .vsync_out(v_sync),
        .vblnk_out(),
        .rgb_out(rgb_out)
    );
    
      always @(posedge clk_40MHz)
      begin
        // Just pass these through.
        hsync_out   <= h_sync;
        vsync_out   <= v_sync;
        Red         <= rgb_out[11:8];
        Green       <= rgb_out[7:4];
        Blue        <= rgb_out[3:0];
      end
    
endmodule
