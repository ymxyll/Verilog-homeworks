module beep_beep(
    input clk, st,
    output beep, over
);

//beep 1s
//1khz->1ms, 250 ~
reg[7:0] bcnt;//250 cnt
reg bflag = 1'd0;//250 flag

reg[3:0] cx = 4'd0;//0.25ms * 4次反转

//500hz, 250hz
wire clk_500, clk_250;

half_clk clk500
(
    .clk(clk),
    .half_clk(clk_500)
);

half_clk clk250
(
    .clk(clk_500),
    .clk(clk_250)
);
	
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


always @(posedge clk)
begin
	if(!bst)
		beep <= 1'd0;
	else
	begin
		if(!bflag)
			beep <= clk_500;//不能是clk，会始终是1
		else
			beep <= 0;
	end
end


endmodule