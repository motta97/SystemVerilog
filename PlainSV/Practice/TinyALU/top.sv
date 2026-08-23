`include "alu_ifc.sv"
`include "alu.v"
`include "testbench.sv"
module top;

testbench tb;
alu_ifc ifc();
alu dut(.A(ifc.A),.B(ifc.B),.res(ifc.res),.op(ifc.op));
initial begin
    $display("TOP Starting");
    tb=new(ifc);
    tb.run();
end

endmodule