module counter(
    input clk, rst,
    output wire [7:0] row, colr, colg
);

reg [2:0] cnt;



always @(posedge clk or posedge rst)
begin
    if(rst)

end


endmodule