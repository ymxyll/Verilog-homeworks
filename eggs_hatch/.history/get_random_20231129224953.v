module get_random(clk, st, rand);
	
	input clk, st;
	output reg [6:0] rand = 7'd0;
	
	reg [31:0] data = 9'd300;

//-------- 生成随机数 --------
always @ (posedge clk, negedge st)
begin
	if(st == 1'd0)
		data <= data;
	else
	begin
		data[0] <= data[31];
		data[1] <= data[0] ^ data[31];
		data[2] <= data[1] ^ data[31];
		data[3] <= data[2] ^ data[31];
		data[4] <= data[3];
		data[5] <= data[4] ^ data[31];
		data[6] <= data[5];
		data[7] <= data[6] ^ data[31];
		data[8] <= data[7];
		data[9] <= data[8];
		data[10] <= data[9];
		data[11] <= data[10];
		data[12] <= data[11];
		data[13] <= data[12];
		data[14] <= data[13];
		data[15] <= data[14];
		data[16] <= data[15];
		data[17] <= data[16];
		data[18] <= data[17];
		data[19] <= data[18];
		data[20] <= data[19];
		data[21] <= data[20];
		data[22] <= data[21];
		data[23] <= data[22];
		data[24] <= data[23];
		data[25] <= data[24];
		data[26] <= data[25];
		data[27] <= data[26];
		data[28] <= data[27];
		data[29] <= data[28];
		data[30] <= data[29];
		data[31] <= data[30];
	end
end

integer i=0;

//-------- 判断及赋值 --------
always @ (posedge clk or posedge st)
begin
    if(st)
        for(i = 0; i < 31; i=i+1)
		begin
			rand = rand + data[i];
		end
    else
        rand <= rand;
end

endmodule