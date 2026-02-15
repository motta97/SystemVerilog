module gm(
    input wire A, B, S, CLK, RST,
    output reg R
);

    always_ff @(posedge CLK) begin
        if(RST) R = 0;
        else begin 
            R = S? (A | B) : (A & B);
        end
    end

endmodule