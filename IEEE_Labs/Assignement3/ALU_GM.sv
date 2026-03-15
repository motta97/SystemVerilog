module alu_gm#(
    parameter WIDTH =1)
(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0]B,
    input [3:0]OP,
    output  reg signed  [WIDTH-1:0] result,//bug: to accomodate for multiplication
    output reg carry,
    output reg Zero
);
reg [WIDTH:0]tmp;
always @(*) begin
    case(OP)
    4'b0000: begin
        tmp = A + B;
    end
    4'b0001: begin
        tmp = A - B;
    end
    4'b0010: begin
        tmp=A&B;
    end
    4'b0011: begin
        tmp=A|B;
    end
    4'b0100: begin
        tmp=A^B;
    end
    4'b0101: begin
        tmp=A<<1;
    end
    4'b0110: begin
        tmp=A>>1;
    end
    4'b0111: begin
        tmp=A*B;
    end
    default: begin 
        tmp=0;
    end
    endcase
    result=tmp[WIDTH-1:0];
    carry=tmp[WIDTH];
    if(result==0)Zero=1'b1;
    else Zero=1'b0; 
end
endmodule