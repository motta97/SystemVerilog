class driver extends uvm_driver #(command_sequence_item);
`uvm_component_utils(driver)


virtual counter_ifc counter_ifc_h;
function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);

if(!uvm_config_db #(virtual interface counter_ifc)::get(null, "*", "ifc",counter_ifc_h))
    `uvm_fatal("driver", "failed to get the interface")

endfunction

task run_phase(uvm_phase phase);

command_sequence_item cmd;
forever begin
    seq_item_port.get_next_item(cmd);

    counter_ifc_h.load_ifc(cmd.rst_n, cmd.en, cmd.up_down);

    seq_item_port.item_done();
end


endtask








endclass