module test;
    class xyz;
        rand int a;
        rand bit [4:0] c;
        rand bit [5:0] d;
        constraint c {
            unique{
                a,c,d
            };
        }
    endclass
endmodule