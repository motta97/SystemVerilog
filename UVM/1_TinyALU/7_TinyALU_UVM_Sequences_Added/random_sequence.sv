`ifndef RANDOM_TESTER_SV
`define RANDOM_TESTER_SV
import alu_tb_pkg::sequence_item;
import uvm_pkg::*;
`include "uvm_macros.svh";
class random_sequence extends uvm_sequence #(sequence_item);
    `uvm_object_utils(random_sequence);
    function new(string name="random_sequence");
        super.new(name);
    endfunction
    //[removed in sequence version]
    // task run_phase(uvm_phase phase);
    //     command_transaction atx;
    //     phase.raise_objection(this);
    //     repeat(100)begin
    //     atx=new();
    //     assert(atx.randomize());
    //     // mbx.put(atx);
    //     put_port_h.put(atx);
    //     #0;
    //     end
    //     phase.drop_objection(this);
    // endtask

    //[added in sequnce version]

    task body();
    sequence_item command;
    command = sequence_item:: type_id:: create("command");
    
    repeat(100) begin
       start_item(command);
       assert(command.randomize());
       
       finish_item(command);
       #0;
    end

    endtask




endclass
`endif
