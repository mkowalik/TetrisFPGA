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
    input wire              clk_down,
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
    
    reg [4:0] counter = 'd0;
    reg [4:0] counter_nxt;
    
    reg [4:0] __position;
    reg [2:0] __brick_type;
    reg [15:0] __brick_prototype;
        
    reg [4:0] i, j;
        
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
        for (i='d0; i<'d18; i = i+'d1) begin
            for (j='d0; j<'d25; j = j+'d1) begin
                if (j>=__position && j<__position+'d4 && i<'d4) 
                    new_brick_tab_nxt[i*'d25+j] = __brick_prototype[i*'d4+j-__position];
                else
                    new_brick_tab_nxt[i*'d25+j] = 0;
            end
        end
    end
    
    //Undeneath is part for moving down new brick
        
    reg [449:0] brick_tab_nxt;
        
    reg         new_brick_flag;
    reg         new_brick_flag_nxt;
    reg         new_brick_done;
    reg         new_brick_done_nxt;
    
    reg [8:0] index;
    reg [4:0] p,q;
    
    reg         left_inner_flag;
    reg         left_inner_flag_nxt;
    
    reg         right_inner_flag;
    reg         right_inner_flag_nxt;
    
    reg         go_down_done_flag;
    reg         go_down_done_flag_nxt;
    
    reg         left_right_done_flag;
    reg         left_right_done_flag_nxt;
    
    always @* begin
        brick_tab_nxt = brick_tab;   
        new_brick_done_nxt = new_brick_done;
        go_down_done_flag_nxt = go_down_done_flag;
        left_right_done_flag_nxt = left_right_done_flag;
        
        case ({clk_down, go_down_done_flag})
        
            2'b10: begin
                go_down_done_flag_nxt = 1'b1;
                
                if (new_brick_flag==1'b1) begin;
                    new_brick_done_nxt = 1'b1;
                    brick_tab_nxt = new_brick_tab_nxt;
                end else begin
                    count_indexes_to_go_down_and_left_right();
                    left_right_done_flag_nxt = 1'b1;
                end //if  
            end
            
            2'b01: begin
                go_down_done_flag_nxt = 1'b0;
            end
            
        endcase // {clk_down, go_down_done_flag}
        
        case ({new_brick_signal, new_brick_flag})
            2'b00: new_brick_done_nxt = 1'b0;
        endcase // {new_brick_signal, new_brick_flag}
        
        case ({left, right, left_inner_flag_nxt, right_inner_flag})
            4'b0000: left_right_done_flag_nxt = 1'b0;
        endcase // {left, right, left_inner_flag_nxt, right_inner_flag}
        
    end
    
    task count_indexes_to_go_down_and_left_right;
    begin
        for (p='d0; p<'d18; p = p+'d1) begin
            for (q='d0; q<'d25; q = q+'d1) begin
                if (p=='d0)
                    brick_tab_nxt[p*'d25+q] = 1'b0;
                else begin
                    case ({left_inner_flag, right_inner_flag})
                        2'b10: begin 
                            index = (q+'d1<'d25) ? ((p-'d1)*'d25+q+'d1) : (p-'d1)*'d25+q; 
                            brick_tab_nxt[p*'d25+q] = brick_tab[index];
                            end
                        2'b01: begin
                            index = q>'d0 ? (p-'d1)*'d25+q-'d1 : (p-'d1)*'d25+q;
                            brick_tab_nxt[p*'d25+q] <= brick_tab[index];
                            end
                        default: begin 
                            index = (p-'d1)*'d25+q;
                            brick_tab_nxt[p*'d25+q] <= brick_tab[index];
                        end
                    endcase
                end //else
            end //for
        end //for    
    end
    endtask
        
    always @* begin
        new_brick_flag_nxt = new_brick_flag;
        case ({new_brick_signal, new_brick_done})
            2'b10: new_brick_flag_nxt = 1'b1;
            2'b01: new_brick_flag_nxt = 1'b0;
        endcase 
    end
    
    always @* begin
        left_inner_flag_nxt = left_inner_flag;
        right_inner_flag_nxt = right_inner_flag;
        case ({left, right, left_right_done_flag})
            3'b100: left_inner_flag_nxt = 1'b1;
            3'b010: right_inner_flag_nxt = 1'b1;
            3'b001: begin
                left_inner_flag_nxt = 1'b0;
                right_inner_flag_nxt = 1'b0;
            end
        endcase
    end
    
    always @(posedge clk_100MHz) begin
        new_brick_flag <= new_brick_flag_nxt;
        new_brick_done <= new_brick_done_nxt;
        left_inner_flag <= left_inner_flag_nxt;
        right_inner_flag <= right_inner_flag_nxt;
        brick_tab <= brick_tab_nxt;
        go_down_done_flag <= go_down_done_flag_nxt; 
        left_right_done_flag <= left_right_done_flag_nxt;
    end
    
        
        
    
    
endmodule
