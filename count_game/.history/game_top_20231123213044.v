module game_top(
    input clk, start, rst, sure,//ʱ�� sw7 btn7 btn0
    input [6:0] sw,//���뿪��
    output [15:0]led,//led
    output [7:0] seg,//����
    output [7:0] dig,//λ��
    output [7:0] row, colg, colr
    //������ʾ
);