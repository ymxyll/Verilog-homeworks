module disp_show(clk,rst,stop,y,cat);
//ʱ��Ƶ��Ϊ1kHz������1ms
	input clk, rst, stop; //ʱ�ӡ���λ�����Ӽ�����ͣ��
	output reg [7:0] y; //8λ����
	output reg [7:0] cat; //8λλ��
	reg stop_o;//���������ͣ
	reg stop_flag;//1Ϊ��ͣ��0Ϊ����
	reg [2:0] stop_cnt;//��ͣ����
	reg [6:0] debns_cnt;//��������
	reg [9:0] q; //1s������
	reg q_out;
	reg [4:0] q_temp; //�������(��λ��ʮ��)
	reg [3:0] shi; //�����ʮλ
	reg [3:0] ge; //����ܸ�λ
	reg [3:0] data_decode; //��������
	reg cnt_cat; //��¼�ߵ����ĸ������(������)
	

//���� 30ms, ʱ��Ƶ��Ϊ1kHz->1ms����80��ʱ����������һ��,��80
always @(posedge clk or negedge stop)
	begin
		if(!stop)
			debns_cnt <= 7'd0;
		else
		begin
			if(debns_cnt==7'd80)
				debns_cnt <= 7'd80;
			else
				debns_cnt <= debns_cnt + 7'b0000001;
		end
		if(debns_cnt==7'd30)
			stop_o <= 1'b1;
		else
			stop_o <= 1'b0;
	end

//��ͣ����������
always@(posedge clk or posedge rst)
begin
	if(rst)
		stop_flag <= 1'b0;
	case(stop_cnt)
	2'd0: stop_flag <= 1'b0;
	2'd1: stop_flag <= 1'b1;
	2'd2: stop_flag <= 1'b0;
	default:;
	endcase
end

//��������
always @(posedge clk or posedge rst)
begin
	if(rst)
		stop_cnt <= 2'd0;
	else if(stop_cnt == 2'd3)
		stop_cnt = 2'd0;
	else
		if(stop_o)
			stop_cnt <= stop_cnt + 5'd1;
		else
			stop_cnt <= stop_cnt;
end




//1s������
always@(posedge clk or posedge rst or posedge stop_o)
begin
	if(rst)
		q <= 10'd0;
	else if(stop)
	begin
		q <= q;
	end
	else
	begin
		if(q == 10'd1000)
		begin
			q <= 10'd0;
			q_out <= 1'b1;
		end
		else
		begin
			q <= q + 1'b1;
			q_out <= 1'b0;
		end
	end
end




//ʮλ��λ��������
always @(posedge clk or posedge rst or posedge stop_flag)
begin
	if(rst)
		q_temp <= 5'd0;
	else if(stop_flag)
		q_temp <= q_temp;
	else
	begin
		if(q_temp == 5'd20)
			q_temp = 5'd0;
		else
		begin
			if(q_out)
				q_temp <= q_temp + 5'd1;
			else
				q_temp <= q_temp;
		end
	end
end

//��λʮλת��
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		shi <= 4'd0;
		ge <= 4'd0;
	end
	else
	begin
		if(q_temp > 5'd10)
			begin
				shi = 4'b0001;
				ge = q_temp - 5'd10;
			end
		else if(q_temp == 5'd10)
			begin
				shi = 4'b0001;
				ge = 4'b0000;
			end
		else
			begin
				shi = 4'b0000;
				ge = q_temp;
			end
	end
end
	

//����y  &&   data_decode
always @(*)
	begin
		case(data_decode)
			4'b0000 : y=8'b11111100; //0
			4'b0001 : y=8'b01100000; //1
			4'b0010 : y=8'b11011010; //2
			4'b0011 : y=8'b11110010; //3
			4'b0100 : y=8'b01100110; //4
			4'b0101 : y=8'b10110110; //5
			4'b0110 : y=8'b10111110; //6
			4'b0111 : y=8'b11100000; //7
			4'b1000 : y=8'b11111110; //8
			4'b1001 : y=8'b11110110; //9
			default : y=8'b00000000;
		endcase
	end


//short time cat[0]->cat[1]	1ms?(ʱ��Ƶ��Ϊ1kHz->1ms) dynamic
always @(posedge clk or posedge rst)
	begin
		if(rst)
			cnt_cat <= 1'd0;
		else
			if(clk)
				if(cnt_cat==1'd1)
					cnt_cat <= 1'd0;
				else
					cnt_cat <= cnt_cat + 1'd1;
			else
				cnt_cat <=cnt_cat;
	end


//��cnt_cat��λ����  1 dark 0 light
always @(posedge clk or posedge rst)
	begin
		if(rst)
			cat <= 8'b11111100;
		else
			case(cnt_cat)
				1'd0 : cat <= 8'b11111110; //first disp0
				1'd1 : cat <= 8'b11111101; //second disp1
				default : cat <= 8'b11111111; //can't enter
			endcase
	end


//shi  ge  &&  data_decode
always @(posedge clk or posedge rst)
	begin
		if(rst)
			data_decode <= 4'b0000;
		else
			case(cnt_cat)
				1'd0 : data_decode <= ge;
				1'd1 : data_decode <= shi;
				default : data_decode = 4'b1111; //�ߵ�default��Ϩ��
			endcase
	end
endmodule