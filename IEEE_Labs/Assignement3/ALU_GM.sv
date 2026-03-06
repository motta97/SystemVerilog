module alu_gm#(
    parameter WIDTH =1)
(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0]B,
    input [3:0]OP,
    output  reg signed  [WIDTH:0] result,//bug: to accomodate for multiplication
    output reg carry,
    output reg Zero
);
always @(*) begin
    case(OP)
    4'b0000: begin
        {carry, result} = A + B;
    end
    4'b0001: begin
        {carry, result} = A - B;
    end
    4'b0010: begin
        result=A&B;
        carry=0;
    end
    4'b0011: begin
        result=A|B;
        carry=0;
    end
    4'b0100: begin
        result=A^B;
        carry=0;
    end
    4'b0101: begin
        result=A<<1;
        carry=0;
    end
    4'b0110: begin
        result=A>>1;
        carry=0;
    end
    4'b0111: begin
        result=A*B;
        carry=0;
    end
    default: begin 
        result=0;
        carry=0;
    end
    endcase
    if(result==0)Zero=1'b1;
    else Zero=1'b0;
    
end



endmodule