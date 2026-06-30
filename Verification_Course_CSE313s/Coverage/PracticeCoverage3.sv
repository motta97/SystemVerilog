module test;
    class transaction;
        rand bit [3:0] c;
        rand bit [5:0] g;
    endclass

    transaction tr;


    covergroup covport;

        c1: coverpoint tr.c;
        c2: coverpoint tr.g{
            bins low ={0};
            bins misc =default;
        }

        cross c1,c2{
            ignore_bins t1 = binsof(c1) intersect {7};
            ignore_bins t2 = binsof(c1) intersect {0} && binsof(c2) intersect {9,10,11};
            ignore_bins t3 = binsof(c2.low);
        }
    endgroup

endmodule