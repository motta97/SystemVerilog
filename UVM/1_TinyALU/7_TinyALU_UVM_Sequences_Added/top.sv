`include "alu_ifc.sv"
`include "alu.v"
`include "random_test.sv"
import alu_tb_pkg::*;
import uvm_pkg::*;
module top;
    alu_ifc ifc();
   // mailbox #(alu_tx) mbx;
    alu dut(ifc.A, ifc.B, ifc.op, ifc.res);
    initial begin
        // mbx=new();
        uvm_config_db #(virtual interface alu_ifc)::set(null,"*","ifc",ifc);
        //uvm_config_db #(mailbox #(alu_tx))::set(null,"*","mbx",mbx);
        run_test();
    end
endmodule