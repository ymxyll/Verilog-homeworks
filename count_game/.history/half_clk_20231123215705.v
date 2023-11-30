//°ë·ÖÆµÆ÷
module half_clk(
    input clk,
    output half_clk
);

always @(posedge clk)
begin
	if(clk)
	begin
		if(half_clk == 1'd1)
			half_clk <= 1'd0;
		else
			half_clk <= 1'd1;
	end
	else
		clk_500 <= clk_500;
end

endmodule