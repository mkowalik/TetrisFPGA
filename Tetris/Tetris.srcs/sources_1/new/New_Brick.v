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
    input wire              left,
    input wire              right,
    input wire              new_brick_signal,
    output reg [299:0]      brick_tab
    );
    
    //Underneth is part for prepering new_brick_tab_nxt - new brick after receivin new_brick_signal
    
    localparam BRICK_TYPE_0 = 16'b1000111000000000;
    localparam BRICK_TYPE_1 = 16'b1100100010000000;
    localparam BRICK_TYPE_2 = 16'b1100110000000000;
    localparam BRICK_TYPE_3 = 16'b1000000000000000;
    localparam BRICK_TYPE_4 = 16'b1000100010001000;
    localparam BRICK_TYPE_5 = 16'b1111000000000000;
    
    reg [4:0] counter;
    reg [4:0] counter_nxt;
    
    reg [4:0] __position;
    reg [2:0] __brick_type;
    reg [15:0] __brick_prototype;
        
    integer i, j;
        
    reg [299:0]   new_brick_tab_nxt;
    
    always @* begin
        __position = counter % 5'd17; //TODO RANDOM
        __brick_type = counter % 3'd6; ////TODO RANDOM
        counter_nxt = counter+1;
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
    
    always @(posedge clk_down) begin
        counter <= counter_nxt;
    end
    
    always @* begin
        for (i=0; i<15; i = i+1) begin
            for (j=0; j<20; j = j+1) begin
                if (j>=__position && j<__position+4 && i<4) 
                    new_brick_tab_nxt[i*20+j] = __brick_prototype[i*4+j-__position];
                else
                    new_brick_tab_nxt[i*20+j] = 0;
            end
        end
    end
    
    //Undeneath is part for moving down new brick
    
    /*localparam GO_DOWN_STATE = 2'b00;
    localparam NEW_BRICK_STATE = 2'b01;
    localparam NEW_BRICK_GO_DOWN = 2'b10;   //this state is when new_brick_signal is still high, 
    
    reg [1:0]   state;
    reg [1:0]   state_nxt;*/
    
    reg [299:0] brick_tab_nxt;
    reg         new_brick_flag;
    
    integer index;
    integer p, q;
    
    always @* begin
        if (new_brick_flag==1'b1) begin;
            brick_tab_nxt = new_brick_tab_nxt;
        end else begin
            for (p=0; p<15; p = p+1) begin
                for (q=0; q<20; q = q+1) begin
                    if (p==0)
                        brick_tab_nxt[p*20+q] = 1'b0;
                    else begin
                        case ({left, right})
                            2'b10: begin 
                                index = (q+1<20) ? ((p-1)*20+q+1) : (p-1)*20+q; 
                                brick_tab_nxt[p*20+q] = brick_tab[index];
                                end
                            2'b01: begin
                                index = q>0 ? (p-1)*20+q-1 : (p-1)*20+q;
                                brick_tab_nxt[p*20+q] <= brick_tab[index];
                                end
                            default: begin 
                                index = (p-1)*20+q;
                                brick_tab_nxt[p*20+q] <= brick_tab[index];
                            end
                        endcase
                    end //else
                end //for
            end //for
        end //if
    end
            
    always @(posedge new_brick_signal) begin
        new_brick_flag <= 1'b1;
    end
    
    always @(posedge clk_down) begin
        brick_tab <= brick_tab_nxt;  
        new_brick_flag <= 1'b0;
    end
    
endmodule
