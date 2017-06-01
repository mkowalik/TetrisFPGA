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
    input wire              clk_100MHz,
    input wire              left,
    input wire              right,
    input wire              new_brick_signal,
    output reg [449:0]      brick_tab
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
        
    reg [449:0]   new_brick_tab_nxt;
    
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
        for (i=0; i<18; i = i+1) begin
            for (j=0; j<25; j = j+1) begin
                if (j>=__position && j<__position+4 && i<4) 
                    new_brick_tab_nxt[i*25+j] = __brick_prototype[i*4+j-__position];
                else
                    new_brick_tab_nxt[i*25+j] = 0;
            end
        end
    end
    
    //Undeneath is part for moving down new brick
        
    reg [449:0] brick_tab_nxt;
        
    reg         new_brick_flag;
    reg         new_brick_flag_nxt;
    reg         new_brick_done;
    reg         new_brick_done_nxt;
    
    integer index;
    integer p, q;
    
    always @* begin
        if (new_brick_flag==1'b1) begin;
            brick_tab_nxt = new_brick_tab_nxt;
            new_brick_done_nxt = 1'b1;
        end else begin
            new_brick_done_nxt = 1'b0;;
            for (p=0; p<18; p = p+1) begin
                for (q=0; q<25; q = q+1) begin
                    if (p==0)
                        brick_tab_nxt[p*25+q] = 1'b0;
                    else begin
                        case ({left, right})
                            2'b10: begin 
                                index = (q+1<25) ? ((p-1)*25+q+1) : (p-1)*25+q; 
                                brick_tab_nxt[p*25+q] = brick_tab[index];
                                end
                            2'b01: begin
                                index = q>0 ? (p-1)*25+q-1 : (p-1)*25+q;
                                brick_tab_nxt[p*25+q] <= brick_tab[index];
                                end
                            default: begin 
                                index = (p-1)*25+q;
                                brick_tab_nxt[p*25+q] <= brick_tab[index];
                            end
                        endcase
                    end //else
                end //for
            end //for
        end //if
    end
    
    always @(posedge clk_down) begin
        brick_tab <= brick_tab_nxt;  
    end
    
    always @* begin
        case ({new_brick_signal, new_brick_done})
            2'b10: new_brick_flag_nxt = 1'b1;
            2'b01: new_brick_flag_nxt = 1'b0;
            default: new_brick_flag_nxt = new_brick_flag;
        endcase 
    end
    
    always @(posedge clk_100MHz) begin
        new_brick_flag <= new_brick_flag_nxt;
        new_brick_done <= new_brick_done_nxt;
    end
    
    
        
        
    
        
        
        
    
    
endmodule
