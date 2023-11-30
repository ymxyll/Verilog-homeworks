module dz_show(
    input clk,
    input rst,//¸ß¸´Î»
    input wire[2:0] num,
    output reg [7:0] row, colr, colg
);

reg [2:0] r_num, dz_num, row_count;

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
    case(dz_num)
        3'd5:
        begin
            case(row_count)
                3'd1:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0111_1110;
                end
                3'd2:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0110_0000;
                end
                3'd3:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0111_1100;
                end
                3'd4, 3'd5:
                begin
                    colr <= 8'b0000_0110;
                    colg <= 8'b0000_0000;
                end
                3'd6:
                begin
                    colr <= 8'b0110_0110;
                    colg <= 8'b0000_0000;
                end
                3'd7:
                begin
                    colr <= 8'b0011_1100;
                    colg <= 8'b0000_0000;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0000_0000;
                end
            endcase
        end
        3'd4:
        begin
            case(row_count)
                3'd1, 3'd6, 3'd7:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0000_1100;
                end
                3'd2:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0001_1100;
                end
                3'd3:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0010_1100;
                end
                3'd4:
                begin
                    colr <= 8'b0100_1100;
                    colg <= 8'b0000_0000;
                end
                3'd5:
                begin
                    colr <= 8'b0111_1110;
                    colg <= 8'b0000_0000;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0000_0000;
                end
            endcase
        end
        3'd3:
        begin
            case(row_count)
                3'd1, 3'd7:
                begin
                    colg <= 8'b0011_1100;
                    colr <= 8'b0011_1100;
                end
                3'd2, 3'd6:
                begin
                    colg <= 8'b0110_0110;
                    colr <= 8'b0110_0110;
                end
                3'd3, 3'd5:
                begin
                    colg <= 8'b0000_0110;
                    colr <= 8'b0000_0110;
                end
                3'd4:
                begin
                    colr <= 8'b0001_1100;
                    colg <= 8'b0001_1100;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0000_0000;
                end
            endcase        
        end
        3'd2:
        begin
            case(row_count)
                3'd1:
                begin
                    colg <= 8'b0011_1100;
                    colr <= 8'b0011_1100;
                end
                3'd2:
                begin
                    colg <= 8'b0110_0110;
                    colr <= 8'b0110_0110;
                end
                3'd3:
                begin
                    colg <= 8'b0000_0110;
                    colr <= 8'b0000_0110;
                end
                3'd4:
                begin
                    colr <= 8'b0000_1100;
                    colg <= 8'b0000_1100;
                end
                3'd5:
                begin
                    colr <= 8'b0011_0000;
                    colg <= 8'b0011_0000;
                end
                3'd6:
                begin
                    colr <= 8'b0110_0000;
                    colg <= 8'b0110_0000;
                end
                3'd7:
                begin
                    colr <= 8'b0111_1110;
                    colg <= 8'b0111_1110;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0000_0000;
                end
            endcase  
        end
        3'd1:
        begin
            case(row_count)
                3'd1, 3'd2, 3'd4, 3'd5, 3'd6:
                begin
                    colg <= 8'b0001_1000;
                    colr <= 8'b0000_0000;
                end
                3'd3:
                begin
                    colg <= 8'b0011_1000;
                    colr <= 8'b0000_0000;
                end
                3'd7:
                begin
                    colr <= 8'b0000_0000;
                    colg <= 8'b0111_1110;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                    colr <= 8'b0000_0000;
                end
            endcase  
        end
        3'd0:
        begin
            case(row_count)
                3'd1, 3'd7:
                begin
                    colg <= 8'b0011_1100;
                end
        end
        default:        
    endcase
end





endmodule