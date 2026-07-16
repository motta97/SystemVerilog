`ifndef RANDOM_TESTER_SV
`define RANDOM_TESTER_SV
`include "base_tester.sv";
import alu_tb_pkg::*;
class random_tester extends base_tester;
        alu_tx atx;
    `uvm_component_utils(random_tester);
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        $display("Random Test running...");
        phase.raise_objection(this);
        repeat(100)begin
            atx=new();
            assert(atx.randomize());
            mbx.put(atx);
            #1;
        end
        phase.drop_objection(this);
    endtask







endclass
`endif
