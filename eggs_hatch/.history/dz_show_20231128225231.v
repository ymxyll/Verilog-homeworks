module dz_show(
    input clk,//1kHz时钟
    input rst,//高复位
    input temp,//温度状态
    input st,//点阵使能
    input wire[3:0] num,
    output reg [7:0] row, colr, colg
);

reg [3:0] dz_num, row_count;

// assign r_num = num;

always @(posedge clk or posedge rst or negedge st)
begin
    if(rst || !st)
        dz_num <= 3'd0;
    else
        dz_num <= num;
end

//dz show colr
always @(posedge clk or posedge rst or negedge st)
begin
    if(rst || !st)
        colg <= 8'b0000_0000;
    case(dz_num)
        4'd0:
        begin
            case(row_count)
                3'd2, 3'd5:
                begin
                    colg <= 8'b0001_1000;
                end
                3'd3, 3'd4:
                begin
                    colg <= 8'b0011_1100;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                end
            endcase
        end
        4'd1:
        begin
            case(row_count)
                3'd2, 3'd5:
                begin
                    colg <= 8'b0011_1000;
                end
                3'd3, 3'd4:
                begin
                    colg <= 8'b0111_1100;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                end
            endcase
        end
        4'd2:
        begin
            case(row_count)
                3'd2, 3'd5:
                begin
                    colg <= 8'b0011_1100;
                end
                3'd3, 3'd4:
                begin
                    colg <= 8'b0111_1110;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                end
            endcase
        end
        4'd3:
        begin
            case(row_count)
                3'd1, 3'd6:
                begin
                    colg <= 8'b0011_1100;
                end
                3'd2, 3'd3, 3'd4, 3'd5:
                begin
                    colg <= 8'b0111_1110;
                end
                default:
                begin
                    colg <= 8'b0000_0000;
                end
            endcase
        end
        4'd4:
        begin
            case(row_count)
            3'd0, 3'd7:
            begin
                colg <= 8'b0011_1100;
            end
        end
        4'd5:
        begin
        end
        4'd6:
        begin
        end
        4'd7:
        begin
        end
        4'd8:
        begin
        end
        4'd9:
        begin
        end
        4'd10:
        begin
        end
        4'd11:
        begin
        end
        default:
        begin
            colg <= 8'b0000_0000;
        end     
    endcase
end

//dz_show colg
always@(posedge clk or posedge temp)
begin
    if(temp)
        colr <= colg;
    else
        colr <= 8'b0000_0000;
end



//dynamic  1kHz

always @(posedge clk or posedge rst)
begin
	if(rst)
		row_count <= 3'd0;
	else
		if(clk)
			if(row_count==3'd7)
				row_count <= 3'd0;
			else
				row_count <= row_count + 3'd1;
		else
			row_count <= row_count;
end

// row_count && row
always @(posedge clk or posedge rst)
begin
    case(row_count)
        3'd0 : row <= 8'b11111110; //first
        3'd1 : row <= 8'b11111101; //second
        3'd2 : row <= 8'b11111011;
        3'd3 : row <= 8'b11110111;
        3'd4 : row <= 8'b11101111;
        3'd5 : row <= 8'b11011111;
        3'd6 : row <= 8'b10111111;
        3'd7 : row <= 8'b01111111;
        default : row <= 8'b11111111; //can't enter
    endcase
end




endmodule