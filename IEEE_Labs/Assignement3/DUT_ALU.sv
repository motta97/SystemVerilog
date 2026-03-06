module alu #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [3:0]       op,
    output reg  [WIDTH-1:0] result,
    output reg              carry,
    output wire             zero
);

    
    localparam ADD  = 4'd0;
    localparam SUB  = 4'd1;
    localparam AND = 4'd2;
    localparam OR  = 4'd3;
    localparam XOR = 4'd4;
    localparam SLL  = 4'd5;
    localparam SRL  = 4'd6;
    localparam MUL  = 4'd7;

    reg [WIDTH-1:0] temp;

    // =====================================
    // Combinational ALU
    // =====================================
    always @(*) begin
        temp = { (WIDTH+1){1'b0} };

        case (op)
            ADD:  temp = A + B;
            SUB:  temp = A - B;
            AND: temp = A & B;
            OR:  temp = A | B;
            XOR: temp = A ^ B;
            SLL:  temp = A >> 1;
            SRL:  temp = A << 1;
            MUL:  temp = A * B;
            default: temp = { (WIDTH+1){1'b0} };
        endcase

        result = temp[WIDTH-1:0];
        carry  = temp[WIDTH-1];
    end

    assign zero = (result == {WIDTH{1'b0}});

endmodule