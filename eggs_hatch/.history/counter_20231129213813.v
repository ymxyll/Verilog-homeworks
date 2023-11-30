module counter//1s分频器
(
    input clk, rst, st,
    output reg[4:0] cnt_num
);

reg [9:0] q; //1s计数器
reg q_out;

//1s计数器
always@(posedge clk or posedge rst or negedge st)
begin
	if(rst)
		q <= 10'd0;
	else if(!st)
		q <= q;
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

//counter
always @(posedge clk or posedge rst or negedge st)
begin
	if(rst)
		cnt_num <= 5'd0;
	else if(!st)
		cnt_num <= cnt_num;
	else
	begin
		if(q_out)
			cnt_num <= cnt_num + 1'd1;
		else
			cnt_num <= cnt_num;
	end
end


endmodule