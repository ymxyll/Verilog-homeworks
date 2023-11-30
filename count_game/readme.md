## 时钟频率1KHz
## testbench使用说明
testbench为top_tb.v文件，测试时需要将随机数生成模块屏蔽掉，且将随机数(random_num)设置为定值7'b0101011
可修改顶层模块(game_top.v)如下部分：
wire [6:0] rand_num;  -------->>  wire [6:0] rand_num, rand_num1;
```verilog
get_random random(
    .clk(clk),
    .st(rand_st),
    .rand(rand_num)
);
```
\--------->>
```verilog
get_random random(
    .clk(clk),
    .st(rand_st),
    .rand(rand_num1)
);
```

## 引脚配置说明
pins.csv文件中第一栏为输入输出端口名，第二栏为输入/输出类型，第三栏为对应引脚编号，参照此文件配置引脚即可