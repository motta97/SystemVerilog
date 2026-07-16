`pragma once
import alu_tb::*;
import uvm_pkg::*;
`include "uvm_macros.svh";
`include "base_tester.sv";
class random_tester extends base_tester;
    `uvm_component_utils(random_tester);
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    task run_phase(uvm_phase phase);
        
        phase.raise_objection(this);
        repeat(100)begin
            alu_tx tx=new();
            assert(tx.randomize());
            mbx.put(tx);
            #1;
        end
        phase.drop_objection(this);


    endtask


endclass