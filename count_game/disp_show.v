module disp_show(
    input clk, rst, st,
    input [1:0] num,//1,2,3
    output reg [7:0] seg, dig
);

always @(posedge clk or negedge st or posedge rst)
begin
    if(rst || !st)
    begin
        seg <= 8'b00000000;
        dig <= 8'b11111111;
    end
    else
    begin
        case(num)
            2'b00 : seg=8'b11111100; //0
            2'b01 : seg=8'b01100000; //1
            2'b10 : seg=8'b11011010; //2
            2'b11 : seg=8'b11110010; //3
            default : seg=8'b00000000;
        endcase
        dig <= 8'b01111111;
    end
end

endmodule