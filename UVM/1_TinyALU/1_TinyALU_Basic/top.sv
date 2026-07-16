`include "alu_ifc.sv"
`include "alu.v"
`include "random_test.sv"
import uvm_pkg::*;

module top;
alu_ifc ifc();
alu dut(.A(ifc.A),.B(ifc.B),.res(ifc.res),.op(ifc.op));
initial begin
    uvm_config_db #(virtual interface alu_ifc)::set(null,"*","ifc",ifc);
    run_test();
end


endmodule