//每个图对应一个状态，向点阵传状态信息以及温度信息(要进行5s计数处理)即可
module eggs_hatch_top
(
    input clk, rst, btn0, sw7, sw0,
    output led0, led2,
    output [7:0] row, colg, colr, seg, dig
);

wire btn0_o;

debounce db
(
    .clk(clk),
    .btn(btn0),
    .btn_o(btn0_o)
);
//需要一个1scounter，还需要一个2scounter

endmodule