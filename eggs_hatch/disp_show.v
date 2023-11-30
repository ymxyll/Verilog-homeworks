module disp_show
(
    input clk, st, cnt_num,
    output reg [8:0] seg, dig
);
//不使能是不显示，不需要复位(计数器会复位为0)
reg cnt_dig;
reg [4:0] shi, ge, data_decode;


//个位十位转化
always @(posedge clk or negedge st)
begin
	if(!st)
	begin
		shi <= 4'd0;
		ge <= 4'd0;
	end
	begin
		if(cnt_num > 5'd10)
			begin
				shi = 4'b0001;
				ge = cnt_num - 5'd10;
			end
		else if(cnt_num == 5'd10)
			begin
				shi = 4'b0001;
				ge = 4'b0000;
			end
		else
			begin
				shi = 4'b0000;
				ge = cnt_num;
			end
	end
end
	

//段码y  &&   data_decode
always @(*)
begin
    case(data_decode)
        4'b0000 : seg=8'b11111100; //0
        4'b0001 : seg=8'b01100000; //1
        4'b0010 : seg=8'b11011010; //2
        4'b0011 : seg=8'b11110010; //3
        4'b0100 : seg=8'b01100110; //4
        4'b0101 : seg=8'b10110110; //5
        4'b0110 : seg=8'b10111110; //6
        4'b0111 : seg=8'b11100000; //7
        4'b1000 : seg=8'b11111110; //8
        4'b1001 : seg=8'b11110110; //9
        default : seg=8'b00000000;
    endcase
end


//short time dig[0]->dig[1]	1ms?(时钟频率为1kHz->1ms) dynamic
always @(posedge clk or negedge st)
begin
    if(!st)
        cnt_dig <= 1'd0;
    else
        if(clk)
            if(cnt_dig==1'd1)
                cnt_dig <= 1'd0;
            else
                cnt_dig <= cnt_dig + 1'd1;
        else
            cnt_dig <=cnt_dig;
end


//将cnt_dig与位码结合  1 dark 0 light
always @(posedge clk or negedge st)
begin
    if(!st)
        dig <= 8'b11111111;
    else
        case(cnt_dig)
            1'd0 : dig <= 8'b10111111; //first disp6
            1'd1 : dig <= 8'b01111111; //second disp7
            default : dig <= 8'b11111111; //can't enter
        endcase
end


//shi  ge  &&  data_decode
always @(posedge clk or negedge st)
begin
    if(!st)
        data_decode <= 4'b1111;//到default，全灭
    else
        case(cnt_dig)
            1'd0 : data_decode <= ge;
            1'd1 : data_decode <= shi;
            default : data_decode = 4'b1111; //走到default后熄灭
        endcase
end
endmodule