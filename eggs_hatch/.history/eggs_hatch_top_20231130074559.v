//ÿ��ͼ��Ӧһ��״̬�������״̬��Ϣ�Լ��¶���Ϣ(Ҫ����5s��������)����
module eggs_hatch_top
(
    input clk, rst, btn0, sw7, sw0,
    output led0, led2,
    output [7:0] row, colg, colr, seg, dig
);

wire btn0_o;

reg dzst, dst, dz_cst, d_cst, temp_cst;

wire [4:0] disp_num, temp_num, dz_num;//����ʱ��,����ʱ��

reg fail;//1Ϊ����ʧ��(5s)��0�ɹ�

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
);

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
    .rst(rst),
    .st(dst),
    .cnt_num(disp_num),
    .seg(seg),
    .dig(dig)
);

dz_transfer transfer
(
    .clk(clk),
    .rst(rst),
    .cst(cst),
    .dst(dst),
    .fail(fail),
    .dz_num(dz_num),
    .row(row),
    .colg(colg),
    .colr(colr)
);

//ȱһ��dz_transfer

//��Ҫһ��1scounter

//��Ҫ�Լ���ʱ�����ʮλ��λ���벢��ʾ���������

//��Ҫ�Լ���ʱ���Լ��¶Ƚ��з���������״̬ת���Լ�������ɫ

//����λ����һ����

//״̬����
//0:sw7=0, nothing is open
//1:sw7=1, an egg,btn0 ���¿�ʼ��ʱ
//2:���������ʼ״̬
//(����dz_num��dz_show,ÿ2s�仯һ�Σ���temp_cntΪ5����ʧ�ܣ���������ͼdz_num==10ʱ����״̬4)
//3:��������״̬(������ͼ��ʼ�����¶�Ӱ�죬������dz_num������ʾ)
//4:�����ɹ�dz_num=16ʱ�������״̬��չʾ�������Ķ���ͼ��
//5:����ʧ��(sw0=0 5sʧ��)

//һ����������ʱ��sw0���º�һ����������5s��һ���������Ƶ�������

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
        3'd3://�¶���Ӱ��ķ�������
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
//reg dzst, cst, dst, dz_cst, d_cst, temp_cst;
//״̬����
//0:����ʹ�ܾ�Ϊ0��ʲôҲ����ʾ
always@(*)
begin
    case(state)
        3'd0:
        begin
            dzst <= 1'd0;
            dst <= 1'd0;
            dz_cst <= 1'd0;

        end

    endcase
end
endmodule