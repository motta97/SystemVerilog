module uni;
        
    union packed{
        reg[31:0] x;
        struct packed {
            bit[7:0]opcode;
            bit[15:0]addr;
            bit[7:0]flag;
        } str;
    }pck_uni;

    initial begin
        pck_uni=32'hFFFF_FFFF;
        $display("The opcode is: %b",pck_uni.str.opcode);
        $display("The address is: %b",pck_uni.str.addr);
        $display("The falg is: %b",pck_uni.str.flag);

        pck_uni.str.opcode=8'h00;
        $display("The register value is: %b",pck_uni.x);
    end
endmodule