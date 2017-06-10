`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output reg [10:0] vcount =0,
  output reg vsync,
  output reg vblnk,
  output reg [10:0] hcount =0,
  output reg hsync,
  output reg hblnk,
  output reg [449:0]Old_brick_tab_out,
  output reg [449:0]New_brick_tab_out,
  
  input wire pclk,
  input wire [449:0]Old_brick_tab_in,
  input wire [449:0]New_brick_tab_in
  );

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.
    localparam  HORTOTAL        = 1056,
                HORBLANKSTART   = 800,
                HORSYNCSTART    = 840,
                HORSYNCSTOP     = 968,

                VERTOTAL        = 628,
                VERBLANKSTART   = 600,
                VERSYNCSTART    = 601,
                VERSYNCSTOP     = 605;

    reg [10:0]  vcount_nxt;
    reg         vblnk_nxt;
    reg         vsync_nxt;
    reg [10:0]  hcount_nxt;
    reg         hblnk_nxt;
    reg         hsync_nxt;
    
    always @ (posedge pclk)
    begin
        hcount <= hcount_nxt;
        hsync  <= hsync_nxt;
        hblnk  <= hblnk_nxt;
        vcount <= vcount_nxt;
        vsync  <= vsync_nxt;
        vblnk  <= vblnk_nxt;
        Old_brick_tab_out <= Old_brick_tab_in;
        New_brick_tab_out <= New_brick_tab_in;
    end
    
    always @ *
    begin
        if ((hcount_nxt >= HORBLANKSTART) && (hcount_nxt < HORTOTAL))     hblnk_nxt = 1;
        else hblnk_nxt = 0;
    end
    
    always @ *
    begin
        if ((hcount_nxt >= HORSYNCSTART) && (hcount_nxt < HORSYNCSTOP))      hsync_nxt = 1;
        else hsync_nxt = 0;
    end
    
    always @ * 
    begin
        if (hcount == (HORTOTAL-1))
        begin
            hcount_nxt = 0;
            if (vcount >= (VERTOTAL-1)) vcount_nxt = 0;
            else vcount_nxt =  vcount +1;
        end 
        else 
        begin
            hcount_nxt = hcount + 1;
            vcount_nxt = vcount;
        end
    end
       
    always @ *
    begin
        if ((vcount_nxt >= VERBLANKSTART) && (vcount_nxt < VERTOTAL)) vblnk_nxt = 1;
        else vblnk_nxt = 0;
    end  
    
    always @ *
    begin
        if ((vcount_nxt >= VERSYNCSTART) && (vcount_nxt < VERSYNCSTOP)) vsync_nxt = 1;
        else vsync_nxt = 0;
    end

endmodule
