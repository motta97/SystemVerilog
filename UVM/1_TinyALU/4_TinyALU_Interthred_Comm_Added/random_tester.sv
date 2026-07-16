`ifndef RANDOM_TESTER_SV
`define RANDOM_TESTER_SV
`include "base_tester.sv";

class random_tester extends base_tester;
    `uvm_component_utils(random_tester);
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        alu_tx atx;
        phase.raise_objection(this);
        repeat(100)begin
        atx=new();
        assert(atx.randomize());
        // mbx.put(atx);
        put_port_h.put(atx);
        #1;
        end
        phase.drop_objection(this);
    endtask







endclass
`endif
