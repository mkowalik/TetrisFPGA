// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module TOP(clk, ps2_data, ps2_clk, hs, vs, r, b, g, seg, dp, an, btnU, led);
  input clk;
  inout ps2_data;
  inout ps2_clk;
  output hs;
  output vs;
  output [3:0]r;
  output [3:0]b;
  output [3:0]g;
  output [6:0]seg;
  output dp;
  output [3:0]an;
  input btnU;
  output [1:0]led;
endmodule
