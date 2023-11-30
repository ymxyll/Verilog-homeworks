`timescale 1ns/1ns
module dz_counter_tb();
//input
reg clk, rst, cst, dzst;
reg [2:0] num;
wire [7:0] row, colg, colr;
counter dz_ct
(
    .clk(clk),
    .rst(rst),
    .cst(cst),
    .num(num),
    .dzst(dzst),
    .row(row),
    .colg(colg),
    .colr(colr)
);

always #1 clk = ~clk; //1ns时钟翻转一次,仿真频率50MHz

initial
begin
    clk <= 1'b1;
    rst <= 1'b1;
    cst <= 1'b0;
    num <= 3'd5;
    #200
    rst <= 1'b0;
    cst <= 1'b1;
    dzst <= 1'b1;
    #12000 // 2000ns计一个数字
    cst <= 1'b0;
    num <= 3'd6;
    #400
    rst <= 1'b0;
    #10000;
    $finish;//仿真完成    
end


endmodule