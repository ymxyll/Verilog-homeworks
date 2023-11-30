`timescale 1ns/1ns
module get_random_tb();
//input
reg clk, st;
//output
wire [6:0]rand_data;


get_random gr
(
    .clk(clk),
    .st(st),
    .rand(rand_data)
);


always #1 clk = ~clk; //T=2ns

initial
begin
    clk <= 1'b1;
    st <= 1'b0;
    #8
    st <= 1'b1;
    #2
    st <= 1'b0;
    #80
    st <= 1'b1;
    #200;
    
end

endmodule