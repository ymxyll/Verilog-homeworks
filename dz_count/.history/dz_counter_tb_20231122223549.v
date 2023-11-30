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

always #1 clk = ~clk; //1ns时钟翻转一次,仿真频率50MHz

initial
begin
    clk <= 1'b1;
    rst <= 1'b1;
    #12000 // 2000ns计1s    
end


endmodule