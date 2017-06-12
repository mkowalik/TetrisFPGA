`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2017 13:29:21
// Design Name: 
// Module Name: char_rom_16x16
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


module char_rom_loose_100x1(
    input   wire    [7:0]   char_xy,
    output  reg     [6:0]   char_code
    );
    
    reg [6:0]   char_code_nxt;
    
    always @ *
        case(char_xy) 
        0: char_code = 7'd32;
        1: char_code = 7'd32;
        2: char_code = 7'd32;
        3: char_code = 7'd32;
        4: char_code = 7'd32;
        5: char_code = 7'd32;
        6: char_code = 7'd32;
        7: char_code = 7'd32;
        8: char_code = 7'd32;
        9: char_code = 7'd32;
        10: char_code = 7'd32;
        11: char_code = 7'd32;
        12: char_code = 7'd32;
        13: char_code = 7'd32;
        14: char_code = 7'd32;
        15: char_code = 7'd32;
        16: char_code = 7'd32;
        17: char_code = 7'd32;
        18: char_code = 7'd32;
        19: char_code = 7'd32;
        20: char_code = 7'd32;
        21: char_code = 7'd32;
        22: char_code = 7'd32;
        23: char_code = 7'd32;
        24: char_code = 7'd32;
        25: char_code = 7'd32;
        26: char_code = 7'd32;
        27: char_code = 7'd32;
        28: char_code = 7'd32;
        29: char_code = 7'd32;
        30: char_code = 7'd32;
        31: char_code = 7'd32;
        32: char_code = 7'd32;
        33: char_code = 7'd32;
        34: char_code = 7'd32;
        35: char_code = 7'd32;
        36: char_code = 7'd32;
        37: char_code = 7'd32;
        38: char_code = 7'd32;
        39: char_code = 7'd32;
        40: char_code = 7'd32;
        41: char_code = 7'd32;
        42: char_code = 7'd32;
        43: char_code = 7'd32;
        44: char_code = 7'd32;
        45: char_code = 7'd32;
        46: char_code = 7'd32;
        47: char_code = 7'd80;
        48: char_code = 7'd114;
        49: char_code = 7'd122;
        50: char_code = 7'd101;
        51: char_code = 7'd103;
        52: char_code = 7'd114;
        53: char_code = 7'd97;
        54: char_code = 7'd108;
        55: char_code = 7'd101;
        56: char_code = 7'd115;
        57: char_code = 7'd32;
        58: char_code = 7'd32;
        59: char_code = 7'd32;
        60: char_code = 7'd32;
        61: char_code = 7'd32;
        62: char_code = 7'd32;
        63: char_code = 7'd32;
        64: char_code = 7'd32;
        65: char_code = 7'd32;
        66: char_code = 7'd32;
        67: char_code = 7'd32;
        68: char_code = 7'd32;
        69: char_code = 7'd32;
        70: char_code = 7'd32;
        71: char_code = 7'd32;
        72: char_code = 7'd32;
        73: char_code = 7'd32;
        74: char_code = 7'd32;
        75: char_code = 7'd32;
        76: char_code = 7'd32;
        77: char_code = 7'd32;
        78: char_code = 7'd32;
        79: char_code = 7'd32;
        80: char_code = 7'd32;
        81: char_code = 7'd32;
        82: char_code = 7'd32;
        83: char_code = 7'd32;
        84: char_code = 7'd32;
        85: char_code = 7'd32;
        86: char_code = 7'd32;
        87: char_code = 7'd32;
        88: char_code = 7'd32;
        89: char_code = 7'd32;
        90: char_code = 7'd32;
        91: char_code = 7'd32;
        92: char_code = 7'd32;
        93: char_code = 7'd32;
        94: char_code = 7'd32;
        95: char_code = 7'd32;
        96: char_code = 7'd32;
        97: char_code = 7'd32;
        98: char_code = 7'd32;
        99: char_code = 7'd32;
        100: char_code = 7'd32;
        default: char_code = 7'd32;
        endcase

endmodule
