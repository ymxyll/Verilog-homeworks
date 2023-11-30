module dz_show(
    input clk,
    input rst,//¸ß¸´Î»
    input wire[2:0] num,
    output reg [7:0] row, colr, colg
);

reg [2:0] r_num, dz_num;

assign r_num = num;

always @(posedge clk or posedge rst)
begin
    if(rst)
        dz_num <= 3'd0;
    else
        dz_num <= r_num;
end

//dz show
//color: r->g->y
always @(posedge clk or posedge rst)
begin
    case(dz_num):
        3'd5:
        begin
            
        end
        3'd4:
        begin

        end
        3'd3:
        begin
        
        end
        3'd2:
        begin

        end
        3'd1:
        begin

        end
        3'd0:
        begin

        end
        default:        
    endcase
end





endmodule