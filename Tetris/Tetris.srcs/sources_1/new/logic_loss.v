`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2017 12:12:30
// Design Name: 
// Module Name: logic_loss
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


module logic_loss(
    input wire            clk_100MHz,
    input wire  [449:0]   Tab_save_tab_in,
    input wire            Tab_save_signal_in,
    input wire  [449:0]   New_brick_tab_in,
    
    output reg [449:0]    Tab_save_tab_out,
    output reg            Tab_save_signal_out,
    output reg [449:0]    New_brick_tab_out,
    output reg            Game_over
    );
    
    reg [4:0] q;
    reg Game_over_nxt;
    

    
    always @* 
        begin
            for (q='d0; q<'d25; q = q+'d1)
                if (Tab_save_tab_in[q] == 1)
                Game_over_nxt = 'd1;
                else
                Game_over_nxt = 'd0;
        end
        
    always @ (posedge clk_100MHz)
        begin
            Tab_save_tab_out    <= Tab_save_tab_in;
            Tab_save_signal_out <= Tab_save_signal_in;
            New_brick_tab_out   <= New_brick_tab_in;
            Game_over           <= Game_over_nxt;
        end
    
endmodule
