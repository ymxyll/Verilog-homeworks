`timescale 1ns/1ns
module beep_beep();
//input
reg clk, st;

//output
reg beep, over;

beep_beep bb(
    .clk(clk),
    .st(st),
    .beep(beep),
    .over(over)
);

always #1 clk <= ~clk; //50MHz

initial
begin
    clk <= 1'b1;
    st <= 1'b0;
    #20
    st <= 1'b1;
    #3000
end



endmodule