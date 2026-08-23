module test;
    class transaction;
    rand bit [3:0] a;
    rand bit [3:0] b;
    endclass
    event ready;
    transaction tr;

    covergroup covport @ready;

    coverpoint tr.a;
    endgroup

    initial begin
        transaction tr;
        covport xyz;
        tr = new();
        xyz =new();
        assert(tr.randomize)->ready;
    end
endmodule