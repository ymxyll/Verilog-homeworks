module dz_show(
    input clk,
    input rst,//高复位
    input reg[2:0] num,
    output reg [7:0] row, colr, colg
);

//三段状态机
always @(posedge clk or posedge rst)
begin
    
end

endmodule