`ifndef BASE_TESTER_SV
`define BASE_TESTER_SV
import uvm_pkg::*;
import alu_tb_pkg::*;
`include "uvm_macros.svh";
`include "env.sv"


class base_test extends uvm_component;
    `uvm_component_utils(base_test);
    //[removed in sequencer version]
    // mailbox #(command_transaction) mbx;
    // uvm_put_port #(command_transaction) put_port_h;
    // function void build_phase(uvm_phase phase);
    // // if(!uvm_config_db #(mailbox #(alu_tx))::get(null,"*", "mbx",mbx));
    // //     $fatal();
    // put_port_h = new("put_port_h", this);
    // endfunction


    //[added to sequencer version]
    env env_h;
    sequencer sequencer_h;
    function void build_phase(uvm_phase phase);
        env_h = env::type_id::create("env_h", this);
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
    	`uvm_info("end of elaboration at base_test", "I got here", UVM_HIGH)
        sequencer_h = env_h.sequencer_h;
    endfunction



    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction


endclass



`endif
