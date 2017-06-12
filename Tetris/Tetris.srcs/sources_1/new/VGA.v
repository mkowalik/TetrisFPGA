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
    input wire          Game_over,
    output reg          hsync_out,
    output reg          vsync_out,
    output reg  [3:0]   Red,
    output reg  [3:0]   Blue,
    output reg  [3:0]   Green,
    output reg          hblnk_out,
    output reg          vblnk_out
    );
    
    wire [10:0] vcount, hcount, vcount_bckg, hcount_bckg, vcount_char, hcount_char, hcount_go, vcount_go;
    wire        vsync, hsync, vblnk, hblnk, v_sync, h_sync, vsync_bckg, hsync_bckg, vblnk_bckg, hblnk_bckg, hblnk_go, vblnk_go;
    wire        vsync_char, hsync_char, vblnk_char, hblnk_char, hsync_go, vsync_go; // v_blnk, h_blnk
    wire [11:0] rgb_out, rgb_bckg, rgb_char, rgb_go;
    wire [7:0]  char_pixels, char_pixels_go;
    wire [7:0]  char_xy, char_xy_go;
    wire [6:0]  char_code, char_code_go;
    wire [3:0]  char_line, char_line_go;
    wire [449:0]Old_brick_tab_tim, New_brick_tab_bckg, New_brick_tab_char, New_brick_tab_tim;
    
    vga_timing my_vga_timing(
        .vcount(vcount),
        .vsync(vsync),
        .vblnk(vblnk),
        .hcount(hcount),
        .hsync(hsync),
        .hblnk(hblnk),
        .Old_brick_tab_out(Old_brick_tab_tim),
        .New_brick_tab_out(New_brick_tab_tim),
        
        .pclk(clk_40MHz),
        .Old_brick_tab_in(Old_brick_tab),
        .New_brick_tab_in(New_brick_tab)
    );
    
    draw_background my_draw_background(
    
        .Old_brick_tab_in(Old_brick_tab_tim),
        .New_brick_tab_in(New_brick_tab_tim),
        .hcount_in(hcount),
        .hsync_in(hsync),
        .hblnk_in(hblnk),
        .vcount_in(vcount),
        .vsync_in(vsync),
        .vblnk_in(vblnk),
        .pclk_in(clk_40MHz),
    
        .New_brick_tab_out(New_brick_tab_bckg),
        .hcount_out(hcount_bckg),
        .hsync_out(hsync_bckg),
        .hblnk_out(hblnk_bckg),
        .vcount_out(vcount_bckg),
        .vsync_out(vsync_bckg),
        .vblnk_out(vblnk_bckg),
        .rgb_out(rgb_bckg)
    
    );
  
    draw_rect_char my_draw_new_char(
        .clk(clk_40MHz),
        .New_brick_tab_in(New_brick_tab_bckg),
        .hcount_in(hcount_bckg),
        .hsync_in(hsync_bckg),
        .hblnk_in(hblnk_bckg),
        .vcount_in(vcount_bckg),
        .vsync_in(vsync_bckg),
        .vblnk_in(vblnk_bckg),
        .rgb_in(rgb_bckg),
        .char_pixels(char_pixels),
       
        .New_brick_tab_out(New_brick_tab_char),
        .hcount_out(hcount_char),
        .hsync_out(hsync_char),
        .hblnk_out(hblnk_char),
        .vcount_out(vcount_char),
        .vsync_out(vsync_char),
        .vblnk_out(vblnk_char),
        .rgb_out(rgb_char),
        .char_xy(char_xy),
        .char_line(char_line)
    
    );
    
    char_rom_100x1 my_char_rom_100x1(
    
        .char_xy(char_xy),
        .char_code(char_code)
    
    );
    
    
    font_rom my_font_rom(
    
        .clk(clk_40MHz),
        .addr({char_code,char_line}),            
        .char_line_pixels(char_pixels) 
    
    );
 
    
    
    draw_new_brick my_draw_new_brick(
        .New_brick_tab(New_brick_tab_char),
        .rgb_in(rgb_char),
        .hcount_in(hcount_char),
        .hsync_in(hsync_char),
        .hblnk_in(hblnk_char),
        .vcount_in(vcount_char),
        .vsync_in(vsync_char),
        .vblnk_in(vblnk_char),
        .pclk_in(clk_40MHz),
        
        .hcount_out(hcount_go),
        .hsync_out(hsync_go),
        .hblnk_out(hblnk_go),
        .vcount_out(vcount_go),
        .vsync_out(vsync_go),
        .vblnk_out(vblnk_go),
        .rgb_out(rgb_go)
    );
    
    
    game_over my_game_over (
        .clk(clk_40MHz),
        .hcount_in(hcount_go),
        .hsync_in(hsync_go),
        .hblnk_in(hblnk_go),
        .vcount_in(vcount_go),
        .vsync_in(vsync_go),
        .vblnk_in(vblnk_go),
        .rgb_in(rgb_go),
        .Game_over(Game_over),
        .char_pixels(char_pixels_go),
    
        .hcount_out(),
        .hsync_out(h_sync),
        .hblnk_out(),
        .vcount_out(),
        .vsync_out(v_sync),
        .vblnk_out(),
        .rgb_out(rgb_out),
        .char_xy(char_xy_go),
        .char_line(char_line_go)
    
    );
    
        char_rom_100x1 my_char_rom_100x1_game_over(
    
        .char_xy(char_xy_go),
        .char_code(char_code_go)
    
    );
    
    
    font_rom my_font_rom_game_over(
    
        .clk(clk_40MHz),
        .addr({char_code_go,char_line_go}),            
        .char_line_pixels(char_pixels_go) 
    
    );
    
    
      always @(posedge clk_40MHz)
      begin
        // Just pass these through.
        hsync_out   <= h_sync;
        vsync_out   <= v_sync;
        Red         <= rgb_out[11:8];
        Green       <= rgb_out[7:4];
        Blue        <= rgb_out[3:0];
        //hblnk_out   <= h_blnk;
        //vblnk_out   <= v_blnk;
      end
    
endmodule
