module dz_show(
    input clk,
    input rst,//�߸�λ
    input wire[2:0] num,
    output reg [7:0] row, colr, colg
);

reg [2:0] r_num, dz_num;

assign r_num = num;


//����״̬��
always @(posedge clk or posedge rst)
begin
    if(rst)
    
end

endmodule