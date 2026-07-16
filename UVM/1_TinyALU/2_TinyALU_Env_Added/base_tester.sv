`ifndef BASE_TESTER_SV
`define BASE_TESTER_SV
import uvm_pkg::*;
import alu_tb::*;
`include "uvm_macros.svh";
virtual class base_tester extends uvm_test;
    `uvm_component_utils(base_tester);
    mailbox #(alu_tx)mbx;



    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(mailbox #(alu_tx))::get(null,"*","mbx",mbx))
            $fatal("Failed to get the mailbox");

    endfunction:build_phase
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction:new
endclass
`endif