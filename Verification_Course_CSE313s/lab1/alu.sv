//8 bits alu that support 8 operations
module alu (
input logic [7:0] a,
input logic [7:0] b,
input logic [2:0] op,
output logic [7:0] result,
output logic zero,
output logic carry
);
    logic [8:0] alu_wide;
    always_comb begin
        alu_wide = 9'b0;
        case (op)
            3'b000: alu_wide = {1'b0, a} + {1'b0, b}; // ADD
            3'b001: alu_wide = {1'b0, a} - {1'b0, b}; // SUB
            3'b010: alu_wide = {1'b0, a & b}; // AND. The 0 at the beginning is for making carry=0
            3'b011: alu_wide = {1'b0, a | b}; // OR. Same goes here for the zero at the beginning
            3'b100: alu_wide = {1'b0, a ^ b}; // XOR. Same goes here for the zero at the beginning
            3'b101: alu_wide = {1'b0, ~a}; // NOT. Same goes here for the zero at the beginning
            3'b110: alu_wide = {a, 1'b0}; // SLL
            3'b111: alu_wide = {2'b00, a[7:1]}; // SRL
            default: alu_wide = 9'b0;
        endcase
    end
    assign result = alu_wide[7:0];
    assign carry = alu_wide[8];
    assign zero = (alu_wide[7:0] == 8'b0);
endmodule