module beep_beep(

);

//������
	reg[9:0] bcnt;//����500��
	reg bflag = 1'd0;//�������500��־
	
	reg[3:0] cx = 4'd0;//0.5ms * 9�η�ת
	
always @(posedge clk or negedge bst)
begin
	if(!bst)
	begin
		bcnt <= 10'd0;
		cx <= 4'd0;
		ard <= 4'd0;
	end
	else
	begin
		if(bcnt == 10'd499)
		begin
			bflag <= 1'd1;//�����ɲ���
			bcnt <= bcnt + 9'd1;
			cx <= cx + 4'd1;
		end
		else if(bcnt == 10'd999)
		begin
			bflag <= 1'd0;//�Ӳ�������
			bcnt <= 10'd0;
			cx <= cx + 4'd1;
		end
		else
		begin
			bcnt <= bcnt + 9'd1;
			bflag <= bflag;
		end
		if(cx == 4'd9)
			ard <= 4'd1;
	end
end

endmodule