`timescale 1ns/1ns
module beep_beep();
//input
reg clk, st;

//output
reg beep, over;

beep_beep bb(
    .clk(clk),
    .st(st),
    .beep(beep),
    .over(over)
);

always #1 clk <= ~clk; //50Hz



endmodule