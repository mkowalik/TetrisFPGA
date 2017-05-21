`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2017 23:03:19
// Design Name: 
// Module Name: New_Brick
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


module New_Brick(
    input wire              clk_down,
    input wire              Left,
    input wire              Right,
    input wire              New_brick,
    output reg [15*20:0]    New_brick_tab
    );
    
    reg [15*20:0] new_brick_shape_nxt; //indexing [x][y] === y*15+x
    
    localparam BRICK_TYPE_0 = 16'b1000111000000000;
    localparam BRICK_TYPE_1 = 16'b1100100010000000;
    localparam BRICK_TYPE_2 = 16'b1100110000000000;
    localparam BRICK_TYPE_3 = 16'b1000000000000000;
    localparam BRICK_TYPE_4 = 16'b1000100010001000;
    localparam BRICK_TYPE_5 = 16'b1111000000000000;
    
    reg [4:0] __position;
    reg [2:0] __brick_type;
    reg [15:0] __brick_prototype;
    
    always @* begin
        __position = $random % (20-3);
        __brick_type = $random % 6;
        case (__brick_type)
            0: __brick_prototype = BRICK_TYPE_0;
            1: __brick_prototype = BRICK_TYPE_1;
            2: __brick_prototype = BRICK_TYPE_2;
            3: __brick_prototype = BRICK_TYPE_3;
            4: __brick_prototype = BRICK_TYPE_4;
            5: __brick_prototype = BRICK_TYPE_5;
            default: __brick_prototype = BRICK_TYPE_0;
        endcase
        
    end
    
    integer i, j;
    
    always @(posedge New_brick) begin
        for (i=0; i<15; i = i+1) begin
            for (j=0; j<20; j = j+1) begin
                if (j>=__position && j<__position+4 && i<4) 
                    New_brick_tab <= __brick_prototype[i*4+j-__position];
                else
                    New_brick_tab <= 0;
            end
        end
    end
endmodule
