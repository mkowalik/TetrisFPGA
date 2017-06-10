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


module char_rom_16x16(
    input   wire    [7:0]   char_xy,
    output  reg     [6:0]   char_code
    );
    
    reg [6:0]   char_code_nxt;
    
    always @ *
        case(char_xy) 
            0: char_code = 7'd42;
            1: char_code = 7'd42;
            2: char_code = 7'd42;
            3: char_code = 7'd42;
            4: char_code = 7'd42;
            5: char_code = 7'd42;
            6: char_code = 7'd42;
            7: char_code = 7'd42;
            8: char_code = 7'd42;
            9: char_code = 7'd42;
            10: char_code = 7'd42;
            11: char_code = 7'd42;
            12: char_code = 7'd42;
            13: char_code = 7'd42;
            14: char_code = 7'd42;
            15: char_code = 7'd42;
            16: char_code = 7'd42;
            17: char_code = 7'd42;
            18: char_code = 7'd42;
            19: char_code = 7'd42;
            20: char_code = 7'd42;
            21: char_code = 7'd42;
            22: char_code = 7'd42;
            23: char_code = 7'd42;
            24: char_code = 7'd42;
            25: char_code = 7'd42;
            26: char_code = 7'd42;
            27: char_code = 7'd42;
            28: char_code = 7'd42;
            29: char_code = 7'd42;
            30: char_code = 7'd42;
            31: char_code = 7'd42;
            32: char_code = 7'd42;
            33: char_code = 7'd42;
            34: char_code = 7'd42;
            35: char_code = 7'd42;
            36: char_code = 7'd42;
            37: char_code = 7'd42;
            38: char_code = 7'd42;
            39: char_code = 7'd42;
            40: char_code = 7'd42;
            41: char_code = 7'd42;
            42: char_code = 7'd42;
            43: char_code = 7'd42;
            44: char_code = 7'd42;
            45: char_code = 7'd42;
            46: char_code = 7'd42;
            47: char_code = 7'd42;
            48: char_code = 7'd42;
            49: char_code = 7'd42;
            50: char_code = 7'd42;
            51: char_code = 7'd42;
            52: char_code = 7'd42;
            53: char_code = 7'd42;
            54: char_code = 7'd42;
            55: char_code = 7'd42;
            56: char_code = 7'd42;
            57: char_code = 7'd42;
            58: char_code = 7'd42;
            59: char_code = 7'd42;
            60: char_code = 7'd42;
            61: char_code = 7'd42;
            62: char_code = 7'd42;
            63: char_code = 7'd42;
            64: char_code = 7'd42;
            65: char_code = 7'd42;
            66: char_code = 7'd42;
            67: char_code = 7'd42;
            68: char_code = 7'd42;
            69: char_code = 7'd42;
            70: char_code = 7'd42;
            71: char_code = 7'd42;
            72: char_code = 7'd42;
            73: char_code = 7'd42;
            74: char_code = 7'd42;
            75: char_code = 7'd42;
            76: char_code = 7'd42;
            77: char_code = 7'd42;
            78: char_code = 7'd42;
            79: char_code = 7'd42;
            80: char_code = 7'd42;
            81: char_code = 7'd42;
            82: char_code = 7'd42;
            83: char_code = 7'd42;
            84: char_code = 7'd42;
            85: char_code = 7'd42;
            86: char_code = 7'd42;
            87: char_code = 7'd42;
            88: char_code = 7'd42;
            89: char_code = 7'd42;
            90: char_code = 7'd42;
            91: char_code = 7'd42;
            92: char_code = 7'd42;
            93: char_code = 7'd42;
            94: char_code = 7'd42;
            95: char_code = 7'd42;
            96: char_code = 7'd42;
            97: char_code = 7'd42;
            98: char_code = 7'd42;
            99: char_code = 7'd42;
            100: char_code = 7'd42;
            101: char_code = 7'd42;
            102: char_code = 7'd42;
            103: char_code = 7'd42;
            104: char_code = 7'd42;
            105: char_code = 7'd42;
            106: char_code = 7'd42;
            107: char_code = 7'd42;
            108: char_code = 7'd42;
            109: char_code = 7'd42;
            110: char_code = 7'd42;
            111: char_code = 7'd42;
            112: char_code = 7'd42;
            113: char_code = 7'd42;
            114: char_code = 7'd42;
            115: char_code = 7'd42;
            116: char_code = 7'd42;
            117: char_code = 7'd42;
            118: char_code = 7'd42;
            119: char_code = 7'd84;
            120: char_code = 7'd101;
            121: char_code = 7'd107;
            122: char_code = 7'd115;
            123: char_code = 7'd116;
            124: char_code = 7'd32;
            125: char_code = 7'd100;
            126: char_code = 7'd111;
            127: char_code = 7'd32;
            128: char_code = 7'd116;
            129: char_code = 7'd101;
            130: char_code = 7'd115;
            131: char_code = 7'd116;
            132: char_code = 7'd111;
            133: char_code = 7'd119;
            134: char_code = 7'd97;
            135: char_code = 7'd110;
            136: char_code = 7'd105;
            137: char_code = 7'd97;
            138: char_code = 7'd46;
            139: char_code = 7'd32;
            140: char_code = 7'd32;
            141: char_code = 7'd32;
            142: char_code = 7'd32;
            143: char_code = 7'd32;
            144: char_code = 7'd32;
            145: char_code = 7'd32;
            146: char_code = 7'd42;
            147: char_code = 7'd42;
            148: char_code = 7'd42;
            149: char_code = 7'd42;
            150: char_code = 7'd42;
            151: char_code = 7'd42;
            152: char_code = 7'd42;
            153: char_code = 7'd42;
            154: char_code = 7'd42;
            155: char_code = 7'd42;
            156: char_code = 7'd42;
            157: char_code = 7'd42;
            158: char_code = 7'd42;
            159: char_code = 7'd42;
            160: char_code = 7'd42;
            161: char_code = 7'd42;
            162: char_code = 7'd42;
            163: char_code = 7'd42;
            164: char_code = 7'd42;
            165: char_code = 7'd42;
            166: char_code = 7'd42;
            167: char_code = 7'd42;
            168: char_code = 7'd42;
            169: char_code = 7'd42;
            170: char_code = 7'd42;
            171: char_code = 7'd42;
            172: char_code = 7'd42;
            173: char_code = 7'd42;
            174: char_code = 7'd42;
            175: char_code = 7'd42;
            176: char_code = 7'd42;
            177: char_code = 7'd42;
            178: char_code = 7'd42;
            179: char_code = 7'd42;
            180: char_code = 7'd42;
            181: char_code = 7'd42;
            182: char_code = 7'd42;
            183: char_code = 7'd42;
            184: char_code = 7'd42;
            185: char_code = 7'd42;
            186: char_code = 7'd42;
            187: char_code = 7'd42;
            188: char_code = 7'd42;
            189: char_code = 7'd42;
            190: char_code = 7'd42;
            191: char_code = 7'd42;
            192: char_code = 7'd42;
            193: char_code = 7'd42;
            194: char_code = 7'd42;
            195: char_code = 7'd42;
            196: char_code = 7'd42;
            197: char_code = 7'd42;
            198: char_code = 7'd42;
            199: char_code = 7'd42;
            200: char_code = 7'd42;
            201: char_code = 7'd42;
            202: char_code = 7'd42;
            203: char_code = 7'd42;
            204: char_code = 7'd42;
            205: char_code = 7'd42;
            206: char_code = 7'd42;
            207: char_code = 7'd42;
            208: char_code = 7'd42;
            209: char_code = 7'd42;
            210: char_code = 7'd42;
            211: char_code = 7'd42;
            212: char_code = 7'd42;
            213: char_code = 7'd42;
            214: char_code = 7'd42;
            215: char_code = 7'd42;
            216: char_code = 7'd42;
            217: char_code = 7'd42;
            218: char_code = 7'd42;
            219: char_code = 7'd42;
            220: char_code = 7'd42;
            221: char_code = 7'd42;
            222: char_code = 7'd42;
            223: char_code = 7'd42;
            224: char_code = 7'd42;
            225: char_code = 7'd42;
            226: char_code = 7'd42;
            227: char_code = 7'd42;
            228: char_code = 7'd42;
            229: char_code = 7'd42;
            230: char_code = 7'd42;
            231: char_code = 7'd42;
            232: char_code = 7'd42;
            233: char_code = 7'd42;
            234: char_code = 7'd42;
            235: char_code = 7'd42;
            236: char_code = 7'd42;
            237: char_code = 7'd42;
            238: char_code = 7'd42;
            239: char_code = 7'd42;
            240: char_code = 7'd42;
            241: char_code = 7'd42;
            242: char_code = 7'd42;
            243: char_code = 7'd42;
            244: char_code = 7'd42;
            245: char_code = 7'd42;
            246: char_code = 7'd42;
            247: char_code = 7'd42;
            248: char_code = 7'd42;
            249: char_code = 7'd42;
            250: char_code = 7'd42;
            251: char_code = 7'd42;
            252: char_code = 7'd42;
            253: char_code = 7'd42;
            254: char_code = 7'd42;
            255: char_code = 7'd42;

        endcase


        
endmodule
