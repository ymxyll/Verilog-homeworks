module beep_beep(
    input clk, st,
    output reg beep, over
);

//beep 1s
//1khz->1ms, 250 ~ 4hz
reg[7:0] bcnt;//250 cnt
reg bflag = 1'd0;//250 flag

reg[2:0] cx = 3'd0;//0.25ms * 4´Î·´×ª

//500hz, 250hz
wire clk_500, clk_250;

half_clk cut_clk
(
    .clk(clk),
    .half_clk(clk_500),
    .half_half_clk(clk_250)
);
	
always @(posedge clk or negedge st)
begin
	if(!st)
	begin
		bcnt <= 8'd0;
		cx <= 4'd0;
		over <= 1'b0;
        bflag <= 1'b0;
	end
	else
	begin
		if(bcnt == 8'd250)
		begin
			bflag <= ~bflag;
			bcnt <= 8'd0;
			cx <= cx + 4'd1;
		end
		else
		begin
			bcnt <= bcnt + 9'd1;
			bflag <= bflag;
		end
		if(cx == 3'd4)
			over <= 1'b1;
	end
end


always @(posedge clk or negedge st or posedge over)
begin
	if(!st)
		beep <= 1'd0;
	else
	begin
    //deferent  frequency
		if(!bflag)
			beep <= clk_250;
		else
			beep <= clk_500;
	end
end


endmodule