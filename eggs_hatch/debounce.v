module debounce(clk,btn,btn_o);
	input clk,btn;
	output reg btn_o;
	
	reg [6:0] debns_cnt;
	
always @(posedge clk)
begin
    if(!btn)
        debns_cnt <= 7'd0;
    else
    begin
        if(debns_cnt==7'd80)
            debns_cnt <= 7'd80;
        else
            debns_cnt <= debns_cnt + 7'b0000001;
    end
    if(debns_cnt==7'd30)
        btn_o <= 1'b1;
    else
        btn_o <= 1'b0;
end
endmodule