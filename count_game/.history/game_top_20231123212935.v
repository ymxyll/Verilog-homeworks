module game_top(
    input clk, start, rst, sure,//ʱ�� sw7 ��λ btn0

    output [15:0]led,//led
    output [7:0] seg,//����
    output [7:0] dig,//λ��
);