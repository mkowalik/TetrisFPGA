`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2017 12:34:09
// Design Name: 
// Module Name: move_down
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


module move_down(
    input wire              clk_100MHz,
    input wire              clk_down,
    input wire              left,
    input wire              right,
    input wire              new_brick_signal,
    input wire              first_brick,
    input wire [449:0]      new_brick_prototype_tab,
    input wire [449:0]      old_brick_tab,
    output reg [449:0]      brick_tab
    );

        
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
    
    reg         new_brick_signal_or;
    
    reg         move_left, move_right;
    reg         possible_move_left, possible_move_right;
    
    always @* begin
        new_brick_signal_or = first_brick | new_brick_signal ;
    end
    
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
                    brick_tab_nxt = new_brick_prototype_tab;
                end else begin
                    count_indexes_to_go_down_and_left_right();
                    left_right_done_flag_nxt = 1'b1;
                end //if  
            end
            
            2'b01: begin
                go_down_done_flag_nxt = 1'b0;
            end
            
        endcase // {clk_down, go_down_done_flag}
        
        case ({new_brick_signal_or, new_brick_flag})
            2'b00: new_brick_done_nxt = 1'b0;
        endcase // {new_brick_signal_or, new_brick_flag}
        
        case ({left, right, left_inner_flag_nxt, right_inner_flag})
            4'b0000: left_right_done_flag_nxt = 1'b0;
        endcase // {left, right, left_inner_flag_nxt, right_inner_flag}
        
    end
    
    task count_indexes_to_go_down_and_left_right;
    begin
    
        check_if_can_move_left(possible_move_left);
        check_if_can_move_right(possible_move_right);
        move_left = (left_inner_flag & possible_move_left);
        move_right = (right_inner_flag & possible_move_right);
    
        for (p='d0; p<'d18; p = p+'d1) begin
            for (q='d0; q<'d25; q = q+'d1) begin
                if (p=='d0)
                    brick_tab_nxt[p*'d25+q] = 1'b0;
                else begin
                    case ({move_left, move_right})
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
    
    task check_if_can_move_left;
    output can_move_left;
    begin
    
    can_move_left = 1'b1;
    
    for (p='d1; p<'d18; p = p+'d1) begin
        for (q='d0; q<'d25; q = q+'d1) begin
            index = (p-'d1)*'d25+q;
            if (q=='d0 && brick_tab[index] == 1'b1)
                can_move_left = 1'b0;
        end 
    end
    
    end
    endtask
        
    task check_if_can_move_right;
    output can_move_right;
    begin
    
    can_move_right = 1'b1;
    
    for (p='d1; p<'d18; p = p+'d1) begin
        for (q='d0; q<'d25; q = q+'d1) begin
            index = (p-'d1)*'d25+q;
            if (q=='d24 && brick_tab[index] == 'b1)
                can_move_right = 1'b0;
        end 
    end
    
    end
    endtask
        
    always @* begin
        new_brick_flag_nxt = new_brick_flag;
        case ({new_brick_signal_or, new_brick_done})
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
