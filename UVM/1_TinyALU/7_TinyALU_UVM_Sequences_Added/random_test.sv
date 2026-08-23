`include "random_sequence.sv"
`include "base_test.sv"
`include "env.sv"
class random_test extends base_test;
    `uvm_component_utils(random_test);
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
    	base_test::type_id::set_type_override(random_test::get_type());
    endfunction
    task run_phase(uvm_phase phase);
        random_sequence random;
        random = new ("random");
        phase.raise_objection(this);
        $display("I GOT HERE AT RUN PHASE OF THE RANDOM TEST");
        random.start(sequencer_h);
        phase.drop_objection(this);
    endtask
    
endclass
