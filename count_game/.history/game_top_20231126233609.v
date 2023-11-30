module game_top(
    input clk, start, rst,//时钟 btn0 btn7
    input [6:0] sw,//输入开关
    output reg [15:0]led,//led
    output [7:0] seg,//段码
    output [7:0] dig,//位码
    output [7:0] row, colg, colr,
    //点阵显示
    output beep//蜂鸣器输出
);

reg cst, dzst, bst, dst, rand_st;//st sign
reg [2:0] dz_num;
reg [1:0] disp_num;
wire [6:0] rand_num;
wire beep_over, cnt_over;

reg [3:0] state;
reg [3:0] next_state;


get_random random(
    .clk(clk),
    .st(rand_st),
    .rand(rand_num)
);

counter ct(
    .clk(clk),
    .rst(rst),
    .cst(cst),
    .dzst(dzst),
    .num(dz_num),
    .row(row),
    .colr(colr),
    .colg(colg),
    .over(cnt_over)
);

beep_beep bbb(
    .clk(clk),
    .st(st),
    .beep(beep),
    .over(over)
);

disp_show ds(
    .clk(clk),
    .rst(rst),
    .st(dst),
    .num(disp_num),
    .seg(seg),
    .dig(dig)
);


//btn0与btn7均不用消抖

//状态定义
//0:sw7=0,nothing is open
//1:sw7=1,dz_greet
//2:click btn7 game1 begin
//3: game1 judge
//4:game2
//5:game2 judge
//6:game3
//7:game3 judge
//8:vectory show

//need module:
//get_random
//dz_show
//counter
//beep_beep
//disp_show

//state begin and move
always@(posedge clk or posedge sw[7])
begin
    if(sw[7])
        state <= 4'd0;
    else
        state <= next_state;
end

//state move
always@(*)
begin
    case(state)
        4'd0://sw7 not open
        begin
            if(sw[7])
                next_state <= 4'd1;
            else
                next_state <= state;
        end
        4'd1://sw7 open
        begin
            if(rst)//btn7
                next_state <= 4'd2;
            else if(!sw[7])
                next_state <= 4'd0;
            else
                next_state <= state;
        end
        4'd2://game1 play
        begin
            if(cnt_over)
                if(start)
                    next_state <= 4'd3;
                else
                    next_state <= state;
            else if(!sw[7])
                next_state <= 4'd0;
            else
                next_state <= state;
        end
        4'd3://game1 judge
        begin
            if(sw[4:0] == rand_num[4:0])
                next_state <= 4'd4;
            else if(!sw[7])
                next_state <= 4'd0;                
            else
                next_state <= 4'd2;
        end
        4'd4:
        begin
            if(cnt_over)
                if(start)
                    next_state <= 4'd5;
                else
                    next_state <= state;
            else if(!sw[7])
                next_state <= 4'd0;
            else if(rst)
                next_state <= 4'd2;                
            else
                next_state <= state;
        end
        4'd5:
        begin
            if(sw[5:0] == rand_num[5:0])
                next_state <= 4'd6;
            else if(!sw[7])
                next_state <= 4'd0;                
            else
                next_state <= 4'd4;
        end
        4'd6:
        begin
            if(cnt_over)
                if(start)
                    next_state <= 4'd7;
                else
                    next_state <= state;
            else if(!sw[7])
                next_state <= 4'd0;
            else if(rst)
                next_state <= 4'd2;                
            else
                next_state <= state;
        end                
        4'd7:
        begin
            if(sw[6:0] == rand_num[6:0])
                next_state <= 4'd8;
            else if(!sw[7])
                next_state <= 4'd0;               
            else
                next_state <= 4'd6;
        end
        4'd8:
        begin
            if(!sw[7])
                next_state <= 4'd0;
            else if(rst)
                next_state <= 4'd2;
            else
                next_state <= state;
        end
        default:;
    endcase
end

//state describe
//0:st all 0
//reg cst, dzst, bst, dst, rand_st;//st sign

//状态定义
//0:sw7=0,nothing is open
//1:sw7=1,dz_greet
//2:click btn7 game1 begin
//3: game1 judge
//4:game2
//5:game2 judge
//6:game3
//7:game3 judge
//8:vectory show
always@(*)
begin
    case(state)
        4'd0:
        begin
            cst <= 1'b0;
            dzst <= 1'b0;
            bst <= 1'b0;
            dst <= 1'b0;
            rand_st <= 1'b0;
        end
        4'd1:
        begin
            dz_num <= 3'd3;//保持cst=1时，倒计时时间为3
            cst <= 1'b0;
            dzst <= 1'b1;
            bst <= 1'b0;
            dst <= 1'b0;
            rand_st <= 1'b1;//generate rand_num
        end
        4'd2:
        begin
            led[4:0] <= rand_num;
            led[15:5] <= 11'd0;
            disp_num <= 2'd1;
            cst <= 1'b1;
            dzst <= 1'b1;
            bst <= 1'b0;
            dst <= 1'b0;//disp
            rand_st <= 1'b0;
        end
        4'd3:
        begin
            led[15:0] <= 16'd0;
            dzst <= 1'b1;
            cst
        end
    endcase
end




endmodule