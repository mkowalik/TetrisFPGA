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
    input wire              clk_100MHz,
    output reg [449:0]      new_brick_prototype_tab
    );
    
    //Underneth is part for prepering new_brick_type_prototype - new brick after receivin new_brick_signal
    
    localparam BRICK_TYPE_0 = 16'b1000111000000000;
    localparam BRICK_TYPE_1 = 16'b1100100010000000;
    localparam BRICK_TYPE_2 = 16'b1100110000000000;
    localparam BRICK_TYPE_3 = 16'b1000000000000000;
    localparam BRICK_TYPE_4 = 16'b1000100010001000;
    localparam BRICK_TYPE_5 = 16'b1111000000000000;
    
    reg [4:0] counter = 'd0;
    reg [4:0] counter_nxt;
    
    reg [5:0] __position;
    reg [2:0] __brick_type;
    reg [15:0] __brick_prototype;
        
    reg [4:0] i, j;
    
    always @* begin
        __position = counter % 5'd21; //TODO RANDOM
        __brick_type = counter % 3'd6; ////TODO RANDOM
        counter_nxt = (counter+'d1)%'d31;
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
    
    always @(posedge clk_100MHz) begin
        counter <= counter_nxt;
    end
    
    always @* begin
        for (i='d0; i<'d18; i = i+'d1) begin
            for (j='d0; j<'d25; j = j+'d1) begin
                if (j>=__position && j<__position+'d4 && i<'d4) 
                    new_brick_prototype_tab[i*'d25+j] = __brick_prototype[i*'d4+j-__position];
                else
                    new_brick_prototype_tab[i*'d25+j] = 0;
            end
        end
    end
    
endmodule
