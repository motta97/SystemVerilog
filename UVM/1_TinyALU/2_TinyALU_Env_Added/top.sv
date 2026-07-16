`pragma once
`include "alu_ifc.sv"
`include "alu.v"
`include "random_test.sv"
import alu_tb::*;
import uvm_pkg::*;

module top;
mailbox #(alu_tx)mbx;
alu_ifc ifc();
alu dut(.A(ifc.A),.B(ifc.B),.res(ifc.res),.op(ifc.op));
initial begin
    mbx=new();
    uvm_config_db #(virtual interface alu_ifc)::set(null,"*","ifc",ifc);//a global variable
    uvm_config_db #(mailbox #(alu_tx))::set(null,"*","mbx",mbx);
    run_test();
end


endmodule