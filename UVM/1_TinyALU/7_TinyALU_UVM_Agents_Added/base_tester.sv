`ifndef BASE_TESTER_SV
`define BASE_TESTER_SV
import uvm_pkg::*;
import alu_tb_pkg::*;

`include "uvm_macros.svh";
// `include "tinyalu_agent.sv";
`include "tinyalu_agent_config.sv";


class base_tester extends uvm_component;
    `uvm_component_utils(base_tester);
    //mailbox #(command_transaction) mbx;
    uvm_put_port #(command_transaction) put_port_h;


    function void build_phase(uvm_phase phase);
    // if(!uvm_config_db #(mailbox #(alu_tx))::get(null,"*", "mbx",mbx));
    //     $fatal();
    put_port_h = new("put_port_h", this);
    endfunction

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction


endclass



`endif