`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2017 18:46:36
// Design Name: 
// Module Name: draw_background
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


module draw_background(
    input wire [449:0]  Old_brick_tab_in,
    input wire [449:0]  New_brick_tab_in,
    input wire [10:0] hcount_in,
    input wire        hsync_in,
    input wire        hblnk_in,
    input wire [10:0] vcount_in,
    input wire        vsync_in,
    input wire        vblnk_in,
    input wire        pclk_in,
    
    output reg [449:0]  New_brick_tab_out,
    output reg [10:0] hcount_out,
    output reg        hsync_out,
    output reg        hblnk_out,
    output reg [10:0] vcount_out,
    output reg        vsync_out,
    output reg        vblnk_out,
    output reg [11:0] rgb_out
    );
    
    reg [3:0] r = 4'b0;
    reg [3:0] g = 4'b0;
    reg [3:0] b = 4'b0;
    
    always @(posedge pclk_in)
      begin
        hcount_out <= hcount_in;
        hsync_out  <= hsync_in;
        hblnk_out  <= hblnk_in;
        vcount_out <= vcount_in;
        vsync_out  <= vsync_in;
        vblnk_out  <= vblnk_out;
        New_brick_tab_out <= New_brick_tab_in;
        rgb_out    <= {r,g,b};
      end
        // During blanking, make it it black.
        
      always @ *
        begin
            {r,g,b} = 12'h0_0_0;
            if (vblnk_in || hblnk_in) {r,g,b} = 12'h0_0_0; 
            else
            begin
                  // Active display, top edge, make a yellow line.
                  if (vcount_in == 0) {r,g,b} = 12'hf_f_0;
                  // Active display, bottom edge, make a red line.
                  else if (vcount_in == 575) {r,g,b} = 12'hf_0_0;
                  // Active display, left edge, make a green line.
                  else if (hcount_in ==0 ) {r,g,b} = 12'h0_f_0;
                  // Active display, right edge, make a blue line.
                  else if (hcount_in == 799) {r,g,b} = 12'h0_0_f;
                  // Active display, interior, fill with gray.
                  // You will replace this with your own test.
                  else if (Old_brick_tab_in[((vcount_in/32)*25)+(hcount_in/32)])
                    {r,g,b} = 12'hf_0_f;
                  else if (vcount_in > 575) {r,b,g} = 12'h0_0_0;
              end
          end
endmodule
