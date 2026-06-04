/// buggy design


module alu (
    ifc_alu.dut io  
);

    always_ff @(posedge io.clk or posedge io.reset) begin
        if (io.reset) begin
            io.C <= 5'sb00000; // Using signed zero literal
        end else begin
            case (io.opcode)
                2'b00: begin
                    // ADD: Both operands are signed; automatically sign-extends to 5 bits
                    io.C <= io.A + io.B;
                end
                
                2'b01: begin
                    // SUB: Automatically handles signed subtraction and borrow
                    io.C <= io.A - io.B;
                end
                
                2'b10: begin
                    // BITWISE INVERT A: ~io.A strips the signed attribute.
                    // We cast it back to signed 4-bit before letting it extend to 5-bit C.
                    io.C <= $signed(~io.A);
                end
                
                2'b11: begin
                    // REDUCTION OR B: Returns a 1-bit unsigned result (0 or 1).
                    // Cast to signed so it extends cleanly into the 5-bit signed C container.
                    io.C <= $signed(|io.B);
                end
                
                default: begin
                    io.C <= 5'sb00000;
                end
            endcase
        end
    end

endmodule
