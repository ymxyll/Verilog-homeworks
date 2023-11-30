module disp_show(
    input clk, rst, st,
    input [3:0] num,
    output reg [7:0] seg, dig
);

always @(posedge clk or posedge st or posedge rst)
begin
    case(num)
        4'b0000 : seg=8'b11111100; //0
        4'b0001 : seg=8'b01100000; //1
        4'b0010 : seg=8'b11011010; //2
        4'b0011 : seg=8'b11110010; //3
        4'b0100 : seg=8'b01100110; //4
        4'b0101 : seg=8'b10110110; //5
        4'b0110 : seg=8'b10111110; //6
        4'b0111 : seg=8'b11100000; //7
        4'b1000 : seg=8'b11111110; //8
        4'b1001 : seg=8'b11110110; //9
        default : seg=8'b00000000;
    endcase
end

endmodule