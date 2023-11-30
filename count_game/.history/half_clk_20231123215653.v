//°ë·ÖÆµÆ÷
module half_clk(
    input clk,
    output half_clk
);

always @(posedge clk)
begin
	if(clk)
	begin
		if(clk_500 == 1'd1)
			clk_500 <= 1'd0;
		else
			clk_500 <= 1'd1;
	end
	else
		clk_500 <= clk_500;
end

endmodule