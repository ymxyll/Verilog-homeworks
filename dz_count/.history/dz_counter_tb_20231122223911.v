`timescale 1ns/1ns
module dz_counter_tb();
//input
reg clk, rst;
wire [7:0] row, colg, colr;
counter dz_ct
(
    .clk(clk),
    .rst(rst),
    .row(row),
    .colg(colg),
    .colr(colr)
);

always #1 clk = ~clk; //1nsʱ�ӷ�תһ��,����Ƶ��50MHz

initial
begin
    clk <= 1'b1;
    rst <= 1'b1;
    #2
    rst <= 1'b0;
    #12000 // 2000ns��һ������
    rst <= 1'b1;
    #4
    rst <= 1'b0;
    #10000;
    $finish;//�������    
end


endmodule