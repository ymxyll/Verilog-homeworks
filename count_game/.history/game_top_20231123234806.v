module game_top(
    input clk, start, rst, sure,//ʱ�� sw7 btn7 btn0
    input [6:0] sw,//���뿪��
    output [15:0]led,//led
    output [7:0] seg,//����
    output [7:0] dig,//λ��
    output [7:0] row, colg, colr,
    //������ʾ
    output beep//���������
);

reg cst, dzst, bst, dst, rand_st;//st sign
reg [2:0] dz_num;
reg [1:0] disp_num;
wire [6:0] rand_num;
wire beep_over, cnt_over;

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
    .colg(colg)
);

beep_beep bbb(
    .clk(clk),
    .st(st),

);


//btn0��btn7����������

//״̬����
//0:sw7=0,nothing is open
//1:sw7=1,dz_greet
//2:click btn7 game1 begin
//3:game2
//4:game3
//5:vectory show

//need module:
//get_random
//dz_show
//counter
//beep_beep
//disp_show




endmodule