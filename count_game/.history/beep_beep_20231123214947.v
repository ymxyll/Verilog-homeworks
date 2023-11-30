module beep_beep(

);

//蜂鸣器
	reg[9:0] bcnt;//计数500下
	reg bflag = 1'd0;//计数完成500标志
	
	reg[3:0] cx = 4'd0;//0.5ms * 9次反转
	
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
			bflag <= 1'd1;//从响变成不响
			bcnt <= bcnt + 9'd1;
			cx <= cx + 4'd1;
		end
		else if(bcnt == 10'd999)
		begin
			bflag <= 1'd0;//从不响变成响
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