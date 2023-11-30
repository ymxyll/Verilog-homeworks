//每个图对应一个状态，向点阵传状态信息以及温度信息(要进行5s计数处理)即可
module eggs_hatch_top
(
    input clk, btn0, sw7, sw0,
    output led0, led2,
    output [7:0] row, colg, colr, seg, dig
);

wire btn0_o;

reg dzst, tst, dst, dz_cst, d_cst, temp_cst, rst;
//点阵使能，转换使能，数码管使能，点阵计数器使能，数码管计数器使能，温度计数器使能


wire [4:0] disp_num, temp_num, dz_num;//孵化时间,低温时间

reg fail;//1为孵化失败(5s)，0成功

reg [2:0] state, next_state;

debounce db
(
    .clk(clk),
    .btn(btn0),
    .btn_o(btn0_o)
);

counter disp_ct
(
    .clk(clk),
    .rst(rst),
    .ct(d_cst),
    .cnt_num(disp_num)
);//不使能是暂停，复位是归0

counter temp_ct
(
    .clk(clk),
    .rst(rst),
    .ct(temp_cst),
    .cnt_num(temp_num)
);

counter dan_ct
(
    .clk(clk),
    .rst(rst),
    .ct(dz_cst),
    .cnt_num(dz_num)    
);

disp_show ds
(
    .clk(clk),
    .st(dst),
    .cnt_num(disp_num),
    .seg(seg),
    .dig(dig)
);

dz_transfer transfer
(
    .clk(clk),
    .rst(rst),
    .cst(tst),
    .dst(dzst),
    .fail(fail),
    .dz_num(dz_num),
    .row(row),
    .colg(colg),
    .colr(colr)
);

//缺一个dz_transfer

//需要一个1scounter

//需要对计数时间进行十位个位解码并显示在数码管上

//需要对计数时间以及温度进行分析来决定状态转移以及点阵颜色

//点阵复位到第一个蛋

//状态定义
//0:sw7=0, nothing is open
//1:sw7=1, an egg,btn0 按下开始计时
//2:进入孵化起始状态
//(传递dz_num给dz_show,每2s变化一次，若temp_cnt为5，则失败，到第六幅图dz_num==10时进入状态4)
//3:孵化结束状态(第六幅图开始不受温度影响，还是由dz_num控制显示)
//4:孵化成功dz_num=16时进入这个状态，展示孵化出的动物图像
//5:孵化失败(sw0=0 5s失败)

//一个计数器计时，sw0按下后一个计数器计5s，一个计数器计蛋增长条

//state begin and move
always@(posedge clk or negedge sw7)
begin
    if(!sw7)
        state <= 3'd0;
    else
        state <= next_state;
end

//state move
always@(*)
begin
    case(state)
        3'd0:
        begin
            if(sw7)
                next_state <= 3'd1;
            else
                next_state <= 3'd0;
        end
        3'd1:
        begin
            if(btn0_o)
                next_state <= 3'd2;
            else if(!sw7)
                next_state <= 3'd0;
            else
                next_state <= 3'd1;
        end
        3'd2:
        begin
            if(!sw7)
                next_state <= 3'd0;
            else if(dz_num == 5'd10)
                next_state <= 3'd3;
            else if(temp_num == 5'd5)
                next_state <= 3'd5;
            else
                next_state <= 3'd2;
        end
        3'd3://温度无影响的孵化过程
        begin
            if(!sw7)
                next_state <= 3'd0;
            else if(dz_num == 5'd16)
                next_state <= 3'd4;
            else
                next_state <= 3'd3;
        end
        3'd4:
        begin
            if(!sw7)
                next_state <= 3'd0;
            else if(btn0_o)
                next_state <= 3'd1;
            else
                next_state <= 3'd4;
        end
        3'd5:
        begin
            if(!sw7)
                next_state <= 3'd0;
            else if(btn0_o)
                next_state <= 3'd1;
            else
                next_state <= 3'd5;
        end
    endcase
end
//reg dzst, tst, dst, dz_cst, d_cst, temp_cst;
//fail
//点阵使能，转换使能，数码管使能，点阵计数器使能，数码管计数器使能，温度计数器使能
//状态定义
//0:所有使能均为0，什么也不显示
//1:显示一个蛋，与复位效果一致
always@(*)
begin
    case(state)
        3'd0:
        begin
            rst <= 1'd0;
            dzst <= 1'd0;
            tst <= 1'd0;
            dst <= 1'd0;
            dz_cst <= 1'd0;
            d_cst <= 1'd0;
            temp_cst <= 1'd0;
            fail <= 1'd0;
        end
        3'd1://未启动，显示一个黄色的蛋(复位)
        begin
            rst <= 1'd1;
            dzst <= 1'd1;
            tst <= 1'd0;
            dst <= 1'd0;
            dz_cst <= 1'd0;
            d_cst <= 1'd0;
            temp_cst <= 1'd0;
            fail <= 1'd0;
        end
        3'd2://启动，孵化开始阶段，各计时器开始计时
        begin
            rst <= 1'd0;
            dzst <= 1'd1;
            tst <= 1'd1;
            dst <= 1'd1;
            d_cst <= 1'd1;
            fail <= 1'd0;
            if(sw0)
            begin
                dz_cst <= 1'd0;
                temp_cst <= 1'd1;
            end
            else
            begin
                dz_cst <= 1'd1;
                temp_cst <= 1'd0;
            end
        end
        3'd3://不受温度影响的孵化状态
        begin
            rst <= 1'd0;
            dzst <= 1'd1;
            tst <= 1'd1;
            dst <= 1'd1;
            d_cst <= 1'd1;
            dz_cst <= 1'd1;
            temp_cst <= 1'd0;
            fail <= 1'd0;
        end
        3'd4://孵化成功状态
        begin
            rst <= 1'd0;
            dzst <= 1'd1;
            tst <= 1'd1;
            dst <= 1'd1;
            d_cst <= 1'd0;
            dz_cst <= 1'd0;
            temp_cst <= 1'd0;
            fail <= 1'd0;
        end
        3'd5://孵化失败状态
        begin
            rst <= 1'd0;
            dzst <= 1'd1;
            tst <= 1'd1;
            dst <= 1'd1;
            d_cst <= 1'd0;
            dz_cst <= 1'd0;
            temp_cst <= 1'd0;
            fail <= 1'd1;         
        end
    endcase
end
endmodule