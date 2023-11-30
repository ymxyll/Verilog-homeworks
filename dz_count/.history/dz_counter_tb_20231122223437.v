`timescale 1ns/1ns
module dz_counter_tb();
//input
reg clk, rst;
reg [7:0] row, colg, colr;
counter dz_ct
(
    .clk(clk),
    .rst(rst),
    .row(row),
    .colg(colg),
    .colr(colr)
);

always #1 clk = ~clk;

endmodule