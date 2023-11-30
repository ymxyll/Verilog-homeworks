module game_top(
    input clk, start, rst, sure,//Ê±ÖÓ sw7 btn7 btn0
    input [6:0] sw;
    output [15:0]led,//led
    output [7:0] seg,//¶ÎÂë
    output [7:0] dig,//Î»Âë
);