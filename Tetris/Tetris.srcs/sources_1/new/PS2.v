`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:02:57
// Design Name: 
// Module Name: PS2
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



module PS2(
    input wire           clk_100MHz,
    input wire           Keyboard_data,
    input wire           Keyboard_clk,
    output reg           Key_pressed,
    output reg [15:0]    Key_code   //TODO change for [15:0]
    );
    
    reg clk_50MHz = 1'b0;
    
    reg                 Key_pressed_nxt;
    reg [7:0]           Key_code_nxt;
    
    wire                 __Key_pressed;
    wire [7:0]           __Key_code;
    
    always @(posedge clk_100MHz) begin
        clk_50MHz <= ~clk_50MHz;
        Key_pressed <= Key_pressed_nxt;
        Key_code <= Key_code_nxt;
    end
    
    always @* begin
        Key_pressed_nxt = __Key_pressed;
        Key_code_nxt = __Key_code;
    end
    
    PS2_Controller my_PS2_Controller(
        .CLOCK_50(clk_50MHz),
        .reset(1'b0),
        
	    .the_command(8'b0),
        .send_command(1'b0),
        
        .PS2_CLK(Keyboard_clk),
        .PS2_DAT(Keyboard_data),
        
        .command_was_sent(),
        .error_communication_timed_out(),
    
        .received_data(__Key_code),
        .received_data_en(__Key_pressed)    
    );
    
endmodule