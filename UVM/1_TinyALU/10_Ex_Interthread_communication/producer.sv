import uvm_pkg::*;
`include "uvm_macros.svh";
class producer extends uvm_component;
    `uvm_component_utils(producer);
    int shared;
    uvm_put_port #(int) put_port_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
        put_port_h= new("put_port_h", this);
    endfunction
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        repeat(5)begin
        put_port_h.put(++shared);
        $display("Sent: %0d", shared);
        #0;
        end
        phase.drop_objection(this);

    endtask


endclass
