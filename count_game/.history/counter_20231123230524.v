module counter(
    input clk, rst, cst, dzst,
	input [2:0] num,
    output wire [7:0] row, colr, colg,
	output reg over//计时结束
);

reg [2:0] cnt, dz_cnt;
reg [9:0] q; //1s计数器
reg q_out;


//1s计数器
always@(posedge clk or posedge rst or negedge cst)
begin
	if(rst || !cst)
		q <= 10'd0;
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
always @(posedge clk or posedge rst or negedge cst)
begin
	if(rst || !cst)
	begin
		dz_cnt <= num;
		over <= 1'b0;
	end
	else
        if(dz_cnt == 3'd0)
		begin
            dz_cnt <= dz_cnt;
			over <= 1'b1;
		end
        else
            if(q_out)
                dz_cnt <= dz_cnt - 3'd1;
            else
                dz_cnt <= dz_cnt;
end

//show
dz_show ds(
    .clk(clk),
    .rst(rst),
	.st(dzst),
    .num(dz_cnt),
    .row(row),
    .colr(colr),
    .colg(colg)
);


endmodule