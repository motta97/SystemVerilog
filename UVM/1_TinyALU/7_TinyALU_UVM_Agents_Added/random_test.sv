`ifndef RANDOM_TEST_SV
`define RANDOM_TEST_SV
`include "random_tester.sv"
`include "env.sv"
`include "base_tester.sv";
import uvm_pkg::*;
`include "uvm_macros.svh"
class random_test extends uvm_test;
    `uvm_component_utils(random_test);
    env env_h;
    virtual alu_ifc ifc;
    tinyalu_agent_config agent_config_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        base_tester::type_id::set_type_override(random_tester::get_type());
        if(!uvm_config_db #(virtual alu_ifc)::get(null,"*", "ifc", ifc))
            `uvm_fatal("Random Test", "Failed to get the interface");
        agent_config_h = new(ifc, UVM_ACTIVE);
        env_h = env::type_id::create("env_h", this);

        uvm_config_db #(tinyalu_agent_config)::set(this, "env_h.tinyalu_agent_h", "config", agent_config_h);

    endfunction

endclass
`endif