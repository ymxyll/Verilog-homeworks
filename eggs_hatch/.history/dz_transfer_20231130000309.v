module dz_transfer
(
    input clk, dst, 
    input fail, dz_num,
    output [7:0] row, colg, colr
);

//将dz_num映射为对应的图像输入到dz_show中进行展示
//fail变绿

reg [3:0] num;//传入点阵的控制值
wire [4:0] rand_num;//接收随机数的值

wire [1:0] rand_ans;//决定哪个动物

reg rand_st;//随机数使能

assign rand_ans = rand_num[1:0];//0~3个

//生成随机数，映射到(0,4区间)随机显示动物图像
get_random random
(
    .clk(clk),
    .st(rand_st),
    .rand(rand_num)
);

dz_show dzs
(
    .clk(clk),
    .rst(),
    .fail(fail),
    .st(),
    .num(num),
);

always@(posedge clk or posedge dst)
begin
    if(dst)
    begin
        if(dz_num != 5'd16)
        begin
            num <= dz_num / 2;
            rand_st <= 1'd1;
        end
        else
        begin
            rand_st <= 1'd0;
            num <= 5'd8 + rand_ans;
        end            
    end
    else
        num <= num;
end

endmodule