//°ë·ÖÆµÆ÷
module half_clk(
    input clk,
    output reg half_clk, half_half_clk
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
		half_clk <= half_clk;
end

endmodule