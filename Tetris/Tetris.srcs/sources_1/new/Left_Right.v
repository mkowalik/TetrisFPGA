`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:02:57
// Design Name: 
// Module Name: Left_Right
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


module Left_Right(
    input wire          Key_pressed,
    input wire [15:0]   Key_code,
    output wire         Left,
    output wire         Right,
    output wire         Down
    );
    
    localparam      KEY_LEFT    = 'h006B,
                    KEY_RIGHT   = 'hE074,
                    KEY_DOWN    = 'h0072;
    
    reg Left_nxt, Right_nxt, Down_nxt;
    
    always @ *
        if(Key_pressed)
            if(Key_code == KEY_LEFT)
                begin
                    Left_nxt    = 'b1;
                    Right_nxt   = 'b0;
                    Down_nxt    = 'b0;
                end
            else if (Key_code == KEY_RIGHT)
                begin
                    Left_nxt    = 'b0;
                    Right_nxt   = 'b1;
                    Down_nxt    = 'b0;
                end
            else if (Key_code == KEY_DOWN)
                begin
                    Left_nxt    = 'b0;
                    Right_nxt   = 'b0;
                    Down_nxt    = 'b1;
                end
            else 
                begin
                    Left_nxt    = 'b0;
                    Right_nxt   = 'b0;
                    Down_nxt    = 'b0;
                end
        else
            begin
                Left_nxt    = 'b0;
                Right_nxt   = 'b0;
                Down_nxt    = 'b0;
            end
            
    assign Left     =   Left_nxt;
    assign Right    =   Right_nxt;
    assign Down     =   Down_nxt;
    
    
endmodule