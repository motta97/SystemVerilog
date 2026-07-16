import uvm_pkg::*;
`include "uvm_macros.svh";
`include "consumer.sv";
`include "producer.sv";
class communication_test extends uvm_test;
    `uvm_component_utils(communication_test);
    uvm_tlm_fifo #(int) fifo_h;
    consumer consumer_h;
    producer producer_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        fifo_h = new("fifo_h", this);
        consumer_h = new("consumer_h", this);
        producer_h = new("producer_h", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        producer_h.put_port_h.connect(fifo_h.put_export);
        consumer_h.get_port_h.connect(fifo_h.get_export);
    endfunction


endclass