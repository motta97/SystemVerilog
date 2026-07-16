module alu(
    input [3:0]A,
    input [3:0]B,
    input [1:0]op,
    output reg [4:0]res//injected error, should be width of 8 bits at least
);
localparam add =2'b00 ;
localparam sub =2'b01 ;
localparam mul =2'b10 ;

always @(*) begin
    case(op)
        add:begin
            res=A+B;
        end
        sub: begin
            res=A-B-1;//injected error, should be A-B
        end
        mul: begin
            res=A*B;
        end
        default: res=res;
    endcase
end

endmodule