module driver(
    output reg A, B, S, RST
);
    initial
        for(int i=0; i<16; i++)
            {A, B, S, RST} = i;
endmodule