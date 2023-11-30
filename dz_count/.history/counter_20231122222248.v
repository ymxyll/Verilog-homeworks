module counter(
    input clk, rst,
    output wire [7:0] row, colr, colg
);

reg [2:0] cnt, dz_cnt;


//1s������
always@(posedge clk or posedge rst or posedge stop_o)
begin
	if(rst)
		q <= 10'd0;
	else
	begin
		if(q == 10'd1000)
		begin
			q <= 10'd0;
		end
		else
		begin
			q <= q + 1'b1;
			q_out <= 1'b0;
		end
	end
end



always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        dz_cnt <= 3'd5;
    end
end


endmodule