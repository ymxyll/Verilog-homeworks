`timescale 1ns/1ns
module top_tb();
//input
reg clk, start, rst;
reg [6:0] sw;

//output
reg [15:0] led;
wire[7:0] seg, dig, row, colg, colr;
wire beep;

game_top top()


endmodule