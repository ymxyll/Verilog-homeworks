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

reg cst, dzst, bst, dst;//st sign



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