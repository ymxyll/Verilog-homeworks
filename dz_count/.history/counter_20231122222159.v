module counter(
    input clk, rst,
    output wire [7:0] row, colr, colg
);

reg [2:0] cnt, dz_cnt;



always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        cnt <= 3'd0;
        dz_cnt <= 3'd5;
    end
end


endmodule