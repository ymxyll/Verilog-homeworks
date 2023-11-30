module disp_show(
    input clk, rst, st,
    input [3:0] num,
    output reg [7:0] seg, dig
);

always @(posedge clk or posedge st or posedge rst)
begin
    if(rst || !st)
    begin
        seg <= 8'b00000000;
        dig <= 8'b11111111;
    end
    else
    begin
        case(num)
            4'b0000 : seg=8'b11111100; //0
            4'b0001 : seg=8'b01100000; //1
            4'b0010 : seg=8'b11011010; //2
            4'b0011 : seg=8'b11110010; //3
            default : seg=8'b00000000;
        endcase
        dig <= 8'b01111111;
    end
end

endmodule