module test;
    class transaction;
    rand bit [3:0] a;
    rand bit [3:0] b;
    endclass



    covergroup covport(ref bit [3:0] port, input int mid );

    coverpoint port{
        bins lo = {[0:mid-1]};
        bins hi = {[mid:$]};
    }
    endgroup

    initial begin
        transaction tr;
        covport cpa,cpb;
        tr = new();
        cpa=new(tr.a,4);
        cpb=new(tr.b,2);
    end
endmodule