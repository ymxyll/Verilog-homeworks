`timescale 1ns/1ns
module top_tb();
//input
reg clk, start, rst;
reg [6:0] sw;

//output
reg [15:0] led;
wire[7:0] seg, dig, row, colg, colr;
wire beep;

game_top top(clk, start, rst, sw, led, seg, dig, row, colg, colr, beep);

always #1 clk = ~clk; //T=2ns

initial
begin
    clk <= 1'b1;
    rst <= 1'b0;
    #20
    sw[7] <= 1'b1;
    #100
    rst <= 1'b1;
    #20
    rst <= 1'b0;
    sw = 7'b0101011;
    #5000

end


endmodule