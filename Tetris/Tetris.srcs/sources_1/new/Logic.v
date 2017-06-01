`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:03:19
// Design Name: 
// Module Name: Logic
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
//Testowy komentarz

module Logic(
    input wire  [8:0]   New_brick_tab,
    input wire  [8:0]   Old_brick_tab,
    output reg  [8:0]   Tab_save,
    output reg          New_brick
    );
    
    reg [8:0] log_tab;
    
    always @ *
        begin
            log_tab = Old_brick_tab << 25; // ??
            if ( (New_brick_tab | log_tab) == 1)
                begin
                    New_brick = 'b1;
                    Tab_save = (New_brick_tab | Old_brick_tab);
                  //  if ( (New_brick_tab | Old_brick_tab) ==  ) // ??
                end
            else 
                begin
                    New_brick = 'b0;
                    Tab_save = Old_brick_tab;
                end
        end

    
    
    
    
endmodule
