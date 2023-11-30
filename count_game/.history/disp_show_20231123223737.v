module disp_show(
    input clk, rst, st,
    input [3:0] num,
    output [7:0] seg, dig
);

always @(posedge clk or posedge rst)
begin
    case(num):
        
    endcase
end

endmodule