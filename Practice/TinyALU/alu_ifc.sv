interface alu_ifc;
    logic [3:0]A;
    logic [3:0]B;
    logic [1:0]op;
    logic [4:0]res;

modport tb(
    input res,
    output A,B,op
);
task load_ifc(logic [3:0]a,
    logic [3:0]b,
    logic [1:0]opp);
    A=a;
    B=b;
    op=opp;
endtask
    

endinterface //alu_ifc

