`timescale 1ns/1ns
module disp_count_tb();
	//input
	reg clk;
	reg rst;
	reg stop;
	//output
	wire [7:0]y;//段码
	wire [7:0]cat;//位码

disp_count
dc
(
	.clk(clk),
	.rst(rst),
	.stop(stop),
	.y(y),
	.cat(cat)
);

always #1 clk = ~clk;//1ns时钟翻转一下，仿真时钟周期为2ns，即频率为50Mhz

initial
begin
	clk <= 1'b1;
	rst <= 1'b1;
	stop <= 1'b0;
	#4
	rst <= 1'b0;
	#60000 //等待程序执行(2000ns计一个数)
	rst <= 1'b1; //模拟复位操作
	#10000
	rst <= 1'b0;
	#30000; //等待程序执行
	stop <= 1'b1;
	#200
	stop <= 1'b0;
	#30000
	stop <= 1'b1;
	#200
	stop <= 1'b0;
	#50000;
	$finish; //仿真完成	
end

endmodule
