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
    output reg [15:0]    Key_code = 16'h0000
    );
    
    reg clk_50MHz = 1'b0;
    
    wire                key_pressed_signal_inner;
    wire [7:0]          key_code_inner;
    
    PS2_Controller my_PS2_Controller(
        .CLOCK_50(clk_50MHz),
        .reset(1'b0),
        
	    .the_command(8'b0),
        .send_command(1'b0),
        
        .PS2_CLK(Keyboard_clk),
        .PS2_DAT(Keyboard_data),
        
        .command_was_sent(),
        .error_communication_timed_out(),
    
        .received_data(key_code_inner),
        .received_data_en(key_pressed_signal_inner)    
    );
            
    reg         Key_pressed_nxt;
    reg [15:0]  Key_code_nxt;
    
    reg [7:0]   last_byte;
    reg [7:0]   previous_byte;
    
    reg [7:0]   last_byte_nxt;
    reg [7:0]   previous_byte_nxt;
    
    reg         key_readed_flag;
    reg         key_readed_flag_nxt;
    
    always @* begin
    
        last_byte_nxt = last_byte;
        previous_byte_nxt = previous_byte;
        key_readed_flag_nxt = key_readed_flag;
        Key_pressed_nxt = Key_pressed;
        Key_code_nxt = Key_code;
        
        case ({key_pressed_signal_inner, key_readed_flag})
            2'b10: begin
                last_byte_nxt = key_code_inner;
                previous_byte_nxt = last_byte;
                key_readed_flag_nxt = 1'b1;
                
                check_an_set_new_Key_code_nxt();
                
            end
            2'b01: begin
                key_readed_flag_nxt = 1'b0;
            end
        endcase
        
        case (Key_pressed)
        1'b1: begin
                Key_pressed_nxt = 1'b0;
            end
        endcase

    end
    
task check_an_set_new_Key_code_nxt;
begin
    case ({previous_byte_nxt, last_byte_nxt})
        16'hF06B: begin // LEFT ARROW break
            Key_code_nxt =  16'hF06B;
            Key_pressed_nxt = 1'b1;
        end
        16'hF074: begin // RIGHT ARROW break
            Key_code_nxt =  16'hF074;
            Key_pressed_nxt = 1'b1;
        end 
        16'hE074: begin //RIGHT ARROW make
            Key_code_nxt =  16'hE074;
            Key_pressed_nxt = 1'b1;
        end
        16'hF072: begin //DOWN ARROW break
            Key_code_nxt =  16'hF072;
            Key_pressed_nxt = 1'b1;
        end
        default: begin
            case (last_byte_nxt)
                8'h6B: begin //LEFT ARROW make
                    Key_code_nxt =  16'h006B;
                    Key_pressed_nxt = 1'b1;
                end
                8'h72: begin //DOWN ARROW make
                    Key_code_nxt =  16'h0072;
                    Key_pressed_nxt = 1'b1;
                end
            endcase
        end //default
    endcase // {previous_byte_nxt, last_byte_nxt}
end
endtask
    
    always @(posedge clk_100MHz) begin
        clk_50MHz <= ~clk_50MHz;
        last_byte <= last_byte_nxt;
        previous_byte <= previous_byte_nxt;
        key_readed_flag <= key_readed_flag_nxt;
        Key_pressed <= Key_pressed_nxt;
        Key_code <= Key_code_nxt;
    end
    
endmodule