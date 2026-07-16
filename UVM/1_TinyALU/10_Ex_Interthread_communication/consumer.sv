import uvm_pkg::*;
`include "uvm_macros.svh";
class consumer extends uvm_component;
    `uvm_component_utils(consumer);
    int shared;
    uvm_get_port get_port_h;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        get_port_h =new("get_port_h", this);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
        get_port_h.get(shared);
        $display("Recieved: %0d", shared);
        end
    endtask

endclass