`timescale 1ns/1ns
module get_random_tb();
//input
reg clk, st;
//output
wire [6:0]rand_data;

always #1 clk = ~clk; //T=2ns


endmodule