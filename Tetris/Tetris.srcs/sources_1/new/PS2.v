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
    output wire          Key_pressed,
    output wire [15:0]   Key_code
    );
    
    reg clk_50MHz = 1'b0;
    
    wire                key_pressed_signal;
    wire [7:0]          key_code_inner;
        
    reg                 key_pressed_signal_nxt;
    reg [7:0]           key_code_inner_nxt;
    
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
        .received_data_en(key_pressed_signal)    
    );
    
    reg [7:0]   last_byte;
    reg [7:0]   previous_byte;
    
    reg [7:0]   last_byte_nxt;
    reg [7:0]   previous_byte_nxt;
    
    reg         key_read;
    reg         key_read_nxt;
    
    assign Key_code[15:8] = previous_byte;
    assign Key_code[7:0]  = last_byte;
    
    assign Key_pressed    = key_pressed_signal;
    
    always @* begin
        last_byte_nxt = last_byte;
        previous_byte_nxt = previous_byte;
        key_read_nxt = key_read;
        case ({key_pressed_signal, key_read})
            2'b10: begin
                last_byte_nxt = key_code_inner;
                previous_byte_nxt = last_byte;
                key_read_nxt = 1'b1;
            end
            2'b01: begin
                key_read_nxt = 1'b0;
            end
        endcase
    end
    
    always @(posedge clk_100MHz) begin
        clk_50MHz <= ~clk_50MHz;
        last_byte <= last_byte_nxt;
        previous_byte <= previous_byte_nxt;
        key_read <= key_read_nxt;
    end
    
endmodule