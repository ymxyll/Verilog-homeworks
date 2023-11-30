module game_top(
    input clk, start, rst, sure,//时钟 sw7 btn7 btn0
    input [6:0] sw,//输入开关
    output [15:0]led,//led
    output [7:0] seg,//段码
    output [7:0] dig,//位码
    output [7:0] row, colg, colr
    //点阵显示
);